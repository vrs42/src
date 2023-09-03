#define BLKSIZE 1024
#define TAPE_WORDS 300000
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include "decode_transitions.h"
#define ARRAYSIZE(x) (sizeof(x) / sizeof(x[0]))

volatile int tape_line_count;
static int streaming = 0;       // True if processing data as it arrives

#define MIN(a,b) (a < b ? a : b)

static int bad_checksum_count;
static int bad_format_count;
static int block_count;
static int exp_block_count;
static int exp_block_count_256 = 533;
static int exp_block_count_129 = 1569;

int reverse_tape(int dir, int linctape, int wait_stop);

int complement(int x)
{
    int swapbits[] = { 3, 2, 1, 0, 7, 6, 5, 4, 11, 10, 9, 8 };
    int cntr;
    int new = 0;

    x = ~x;
    for (cntr = 0; cntr < 12; cntr++) {
        new |= ((x & (1 << cntr)) >> cntr) << swapbits[cntr];
    }
    return new;
}

void check_chksum(int chksum, int reverse, int block) {
   // 2525000 is checksum for non data blocks on DIAL tapes, 1257652 is for OS/12
   // non data blocks. 01252400 is a 128 word linctape
   if ( (chksum & 07777) != 0 && chksum != 02525000 &&
         chksum != 01257652 && chksum != 01252400) {
      printf("\n**chksum %o block %d\n", chksum, block);
      bad_checksum_count++;
   }
}

int linctape_decode_block(
    unsigned char tape_lines[], 
    short data_buffer[], int data_buffer_len,
    int reverse, int first, int *block_num, int *rev_block_num, 
    int *blksize_out, int *error, int *found_leader, int ignore_except)
{
    int data_count = 0;
    short dt;
    int mt_sync = 0;
    enum                   { IM,  BM, RBM, GM1, GM2, DM,  FM,  CM } state = IM;
    int mt_code[2][8] =  { {0xf, 0xe, 0x7, 0x2, 0x2, 0x9, 0xb, 0x1},
                           {0x0, 0xe, 0x7, 0x4, 0x4, 0x9, 0xd, 0x8} };
    int next_state[2][8] = {{BM,  GM1, IM,  DM, RBM,  FM,  CM, GM2},
                           { BM,  IM, GM2, RBM,  CM, GM1,  DM,  FM} };
    int mark_count[2][8] = {{ 1,   1,   5,  -1,   1,   1,   3,   1},
                            { 1,   5,   1,   1,   3,   1,  -1,   1} };
    int start_block[2] = {0xfe2, 0xfe4};
    int chksum = 0;
    static int last_fwd_block;
    static int last_rev_block;
    static short blksize;
    static int found_block;
    static int tape_cntr;
    static int mt;
    static int dt1, dt2, dt3;
    int quit = 0;
    int block;
    int in_block, block_search_cntr;
    int rc = 0;
    int count = 0;
    int init_bad_checksum_count;
    int init_bad_format_count;
    int i;

    *found_leader = 0;
#define NOT_SET -999
    if (first == 2) {
       tape_cntr = tape_line_count;
       // Prevent non sequential block error
       last_fwd_block = NOT_SET;
    }
    if (first == 1) {
       tape_cntr = 0;
       last_fwd_block = NOT_SET;
       last_rev_block = NOT_SET;
       blksize = NOT_SET;
       found_block = 0;
       exp_block_count = exp_block_count_256;
       block_count = 0;
       bad_checksum_count = 0;
       bad_format_count = 0;
       in_block = 0;
       mt = 0;
       dt1 = 0;
       dt2 = 0;
       dt3 = 0;
    }
    init_bad_format_count = bad_format_count;
    init_bad_checksum_count = bad_checksum_count;

    block_search_cntr = 0;
    while (!quit) {
        if (tape_cntr >= tape_line_count - 1) {
            if (!streaming) {
                printf("\nRan out of tape data at %d\n", tape_cntr);
                quit = 1;
                rc = 1;
            } else {
                usleep(1000);
                continue;
            }
        }
        if (reverse) {
           mt = (mt << 1) | (((tape_lines[tape_cntr] & 8) >> 3) ^ 1);
        } else {
           mt = (mt << 1) | ((tape_lines[tape_cntr] & 8) >> 3);
        }
        dt1 = (dt1 << 1) | ((tape_lines[tape_cntr] & 1) >> 0);
        dt2 = (dt2 << 1) | ((tape_lines[tape_cntr] & 2) >> 1);
        dt3 = (dt3 << 1) | ((tape_lines[tape_cntr] & 4) >> 2);
        tape_cntr++;
        dt = ((dt1 & 0xf) << 8) | ((dt2 & 0xf) << 4) | (dt3 & 0xf);
        dt = ~dt & 07777;
        if (mt == 0 && !found_block && block_search_cntr > 30) {
           *found_leader = 1;
        }
        if (mt == 0 && found_block) {
           printf("\nEnd of tape, last block\n");
           quit = 1;
           rc = 1;
        }
  //printf("MT %x %d %d %d %x %d\n", mt, count, in_block, tape_cntr, start_block[reverse], data_count);
        if ((mt & 0xfff) == start_block[reverse]) {
           int dtb;
           in_block = 1;
           found_block = 1;
          
           dtb = (((dt1 >> 4) & 0xf) << 8) | (((dt2 >> 4) & 0xf) << 4) | ((dt3 >> 4) & 0xf);
           dtb = ~dtb & 07777;
           block = ~((dtb) << (32 - 12) >> (32 - 12));
//printf("block %d block_search_cntr %d cntr %d mt %x mt_sync %d\n", block, block_search_cntr, cntr, mt, mt_sync);
           if (last_fwd_block != NOT_SET && block != last_fwd_block + (reverse ? -1 : 1)) {
              bad_format_count++;
              printf("\n******* Non sequential block # %d %d\n", last_fwd_block, block);
           }
           last_fwd_block = block;
//printf("BM %d %x\n",block,block & 07777);
           if (reverse) {
              state = CM;
              count = mark_count[reverse][GM2];
           } else {
              state = DM;
              count = blksize - 1;
           }
           mt_sync = 4;
           data_count = 0;
           chksum = 0;
        } else {
           block_search_cntr++;
        }
        if (in_block) {
              if (mt_sync-- == 0) {
                  mt_sync = 3;
//printf("dt %o\n",dt);
                    switch (state) {
                    case DM:
                        if ((mt & 0xff) == 0xcc) {
                            printf("\nResyncing b\n");
                            bad_format_count++;
                            mt_sync = 0;
                        }

                        if (reverse) {
                           chksum += complement(dt);
                        } else {
                           chksum += dt;
                        }
                        if (data_count < data_buffer_len - 1) {
                           data_buffer[data_count++] = dt;
                        } else {
                           printf("\nData buffer overflow\n");
                           exit(1);
                        }
                        if ( (reverse && (mt & 0xf) == mt_code[reverse][GM1]) ||
                             (!reverse && (mt & 0xf) == mt_code[reverse][FM]) ) {
                            if (blksize == NOT_SET) {
                                if (data_count < 50) {
                                   printf("\nIllegal blocksize %d found, ignoring\n",data_count);
                                   // Ignore errors also
                                   bad_format_count = init_bad_format_count;
                                   found_block = 0;
                                   in_block = 0;
                                   data_count = 0;
                                   // Prevent non sequential block error
                                   last_fwd_block = NOT_SET;
                                } else {
                                   blksize = data_count;
                                   if (reverse)
                                      blksize--;
                                   printf("\nBlocksize %d\n", blksize);
                                   if (blksize == 129 || blksize == 128)
                                      exp_block_count = exp_block_count_129;
                                }
                            } else {
                                printf("\nEarly final mark\n");
                                bad_format_count++;
                            }
                            if (reverse) {
                               check_chksum(chksum, reverse, last_fwd_block);
                               count = mark_count[reverse][GM1];
                               state = next_state[reverse][GM1];
                            } else {
                               count = mark_count[reverse][FM];
                               state = next_state[reverse][FM];
                            }
                        } else {
                           if ((mt & 0xf) != mt_code[reverse][state]) {
                              bad_format_count++;
                               printf("\nBad DM %x %d %d %f\n", mt, count,
                                   tape_cntr, get_tape_time(tape_cntr));
                           }
                           if (--count == 0) {
                              count = mark_count[reverse][state];
                              state = next_state[reverse][state];
                           }
                        }
                        break;
                    case FM:
//printf("dt %o\n",dt);
                        if (reverse) {
                           chksum += complement(dt);
                        } else {
                           chksum += dt;
                        }
                        if (data_count < data_buffer_len - 1) {
                           data_buffer[data_count++] = dt;
                        } else {
                           printf("\nData buffer overflow\n");
                           exit(1);
                        }
                        if ((mt & 0xf) != mt_code[reverse][state]) {
                            printf("\nBad FM %x %d\n", mt, count);
                           bad_format_count++;
                        }
                        count = mark_count[reverse][state];
                        if (count == -1)
                           count = blksize-1;
                        state = next_state[reverse][state];
                        break;
                    case CM:
                            if (reverse && count == 1) {
                              chksum += complement(dt);
                               block_count++;
                            } else if (!reverse && count == 3) { 
                               chksum += dt;
                               check_chksum(chksum, reverse, last_fwd_block);
                               block_count++;
                            } 
                        if ((mt & 0xf) != mt_code[reverse][state]) {
                            bad_format_count++;
                            printf("\nBad CM %x %d\n", mt, count);
                        }
                        if (--count == 0) {
                           count = mark_count[reverse][state];
                           state = next_state[reverse][state];
                        }
                        break;
                    case GM1:
                         if (reverse) {
                            check_chksum(chksum, reverse, last_fwd_block);
                         }
                    case GM2:
                        if ((mt & 0xf) != mt_code[reverse][state]) {
                            bad_format_count++;
                            printf("\nBad GM %x %d\n", mt, count);
                        }
                        count = mark_count[reverse][state];
                        state = next_state[reverse][state];
                        break;
                    case RBM:
//printf("RBM %o\n",~dt);
//printf("RBM %d %d\n",~((complement(dt) << (32-12)) >> (32-12)),cntr);
                        // Sign extend so negative blocks match
                        block =
                            ~((complement(dt) << (32 - 12)) >> (32 - 12));
                        last_rev_block = block;
                        if (block != last_fwd_block) {
                           // OS/12 linctapes seems to have the reverse block
                           // off by 3. Found a 128 word tape with same off by 3
                           if (blksize <= 129 && (block - (reverse ? -3 : 3)) == last_fwd_block) {
                           } else {
                              bad_format_count++;
                              printf("\nReverse block mismatch %d %d\n", block,
                                      last_fwd_block);
                          }
                        }
                        if ((mt & 0xf) != mt_code[reverse][state]) {
                            bad_format_count++;
                            printf("\nBad RBM %x %d\n", mt, count);
                        }
                        count = mark_count[reverse][state];
                        state = next_state[reverse][state];
                        in_block = 0;
                        block_search_cntr = 0;
                        quit = 1;
                        break;
                    default:
                        printf("\nIllegal state %d\n",state);
                        exit(1);
                    }
                    if (mt == 0x33333333 || mt == 0x66666666) {
                        mt_sync--;
                        bad_format_count++;
                        printf("\nData resync\n");
                    }
                    if ((mt & 0xf) == 0xb && state != CM) {
                        bad_format_count++;
                        printf("\nResyncing after final mark\n");
                        state = CM;
                        count = 3;
                    }
                }
            } else {
//if (cntr > 0000)
//  printf("MT %x %d %d %d\n", mt, count, in_block, cntr);
            }
    }
    *block_num = last_fwd_block;
    *rev_block_num = last_rev_block;
    *blksize_out = blksize;
    if (rc == 0) {
        if ( bad_format_count != init_bad_format_count ||
             bad_checksum_count != init_bad_checksum_count) 
          *error = 1;
       else
          *error = 0;
       if (reverse) {
          for (i = 0; i < blksize/2; i++) {
             short temp = complement(data_buffer[i]);
             data_buffer[i] = complement(data_buffer[blksize - i - 1]);
             data_buffer[blksize - i - 1] = temp;
          }    
          // If odd fix the middle word
          if (blksize & 1) {
             data_buffer[blksize/2] = complement(data_buffer[blksize/2]);
          }
       }
    }
    // This is ugly
    if (rc == 0 && ignore_except != -999 &&
          ignore_except != MIN(last_fwd_block, last_rev_block)) {
       bad_format_count = init_bad_format_count;
       bad_checksum_count = init_bad_checksum_count;
       if (found_block) {
          block_count--;
      }
    }
    return rc;
}

void write_linctape(int reverse, short tape_buffer[], int tape_buffer_ndx, 
     int blksize, int first_tape_block, int first_rev_tape_block, FILE *out) {
   int i;
   int temp;

    if (reverse) {
      for (i = tape_buffer_ndx - blksize; i >= 0; i -= blksize) {
          if (fwrite(&tape_buffer[i], blksize*2, 1, out) < 0) {
             perror("Write failed");
            exit(1);
          }
      }
      if (i != -blksize) {
         printf("\nData mismatch writing reverse data\n");
      }
      temp = first_tape_block;
      first_tape_block = first_rev_tape_block;
      first_rev_tape_block = temp;
    } else {
       if (fwrite(tape_buffer, tape_buffer_ndx*2, 1, out) < 0) {
          perror("Write failed");
          exit(1);
       }
    }
    if (fwrite(&blksize, 2, 1, out) < 0) {
        perror("Write failed");
        exit(1);
    }
    if (fwrite(&first_tape_block, 2, 1, out) < 0) {
        perror("Write failed");
        exit(1);
    }
    if (fwrite(&first_rev_tape_block, 2, 1, out) < 0) {
        perror("Write failed");
        exit(1);
    }
   printf("First %d first rev %d\n",first_tape_block, first_rev_tape_block);
}

void linctape_decode(FILE * out, unsigned char *tape_lines,
                    int tape_line_count_in, int reverse, int streaming_in)
{
    short data_buffer[BLKSIZE];
    short tape_buffer[TAPE_WORDS];
    int tape_buffer_ndx = 0;
    short first_tape_block = 0;
    short first_rev_tape_block = 0;
    int first = 1;
    int block_num, rev_block_num;
    int blksize;
    int done = 0;
    int error;
    int last_blksize = 1;
    int found_leader;

    streaming = streaming_in;
    tape_line_count = tape_line_count_in;


    while (!done) {
       if (linctape_decode_block(tape_lines, data_buffer, BLKSIZE, 
             reverse, first, &block_num, &rev_block_num, &blksize, &error,
             &found_leader, -999)) {
          done = 1;
       } else {
          if (first || reverse) {
             first_tape_block = block_num;
             first_rev_tape_block = rev_block_num;
          }
          if ((tape_buffer_ndx + blksize)*2 >= sizeof(tape_buffer)) { 
             printf("\nTape buffer overflow\n");
             exit(1);
          }
          memcpy(&tape_buffer[tape_buffer_ndx], data_buffer, blksize*2);
          tape_buffer_ndx += blksize;
          last_blksize = blksize;
       }
       first = 0;
    }
    write_linctape(reverse, tape_buffer, tape_buffer_ndx, 
       last_blksize, first_tape_block, first_rev_tape_block, out);
}

void linctape_decode_retry(FILE * out, unsigned char *tape_lines,
                    int tape_line_count_in, int reverse_in, int streaming_in)
{
    short data_buffer[BLKSIZE];
    short tape_buffer[TAPE_WORDS];
    int tape_buffer_ndx = 0;
    short first_tape_block = NOT_SET;
    short first_rev_tape_block = NOT_SET;
    int first = 1;
    int block_num, rev_block_num;
    int blksize;
    int done = 0;
    int error;
    int last_blksize = 1;
    int retrying = 0;
    int target_block = 0;
    int est_block = -999;
    int reverse;
    int retry_count = 0;
    int found_leader;

    reverse = reverse_in;
    streaming = streaming_in;
    tape_line_count = tape_line_count_in;


    while (!done) {
       // Retry doesn't work too close to end of tape
       if (linctape_decode_block(tape_lines, data_buffer, BLKSIZE, 
             reverse, first, &block_num, &rev_block_num, &blksize, &error,
             &found_leader, est_block)) {
          done = 1;
       } else {
          est_block = MIN(block_num, rev_block_num);
          //printf("Block %d first %d found_leader %d error %d\n",est_block, first, found_leader, error);
          if (first == 1 && !found_leader) {
             printf("\nBacking up to begining of tape, found block %d\n",est_block);
             reverse = reverse_tape(reverse, 1, 0);
             while (!linctape_decode_block(tape_lines, data_buffer, BLKSIZE, 
                reverse, first, &block_num, &rev_block_num, &blksize, &error,
                &found_leader, -998)) {
                //printf("block %d\n",block_num);
                first = 0;
                est_block = -999;
             }
             printf("\nSwitching to forward\n");
             reverse = reverse_tape(reverse, 1, 0);
             first = 1;
          } else if (retrying && ((reverse && est_block < target_block) ||
                  (!reverse && est_block > target_block))) {
             printf("\nMissed block %d %d\n", est_block, target_block);
             
             reverse = reverse_tape(reverse, 1, 1);
             first = 2;
          } else if (retrying && est_block != target_block) {
             //printf("Ignoring block %d\n",est_block);
             first = 0;
             // Stop retrying at limit and when moving in the correct direction
          } else if (error && (!retrying || reverse != reverse_in || 
                retry_count < 10)) {
             int diff;
             if (!retrying) {
                retrying = 1;
                diff = abs(block_num - rev_block_num);
                if (diff != 0 && diff != 3) {
                   printf("\nBLock mismatch, Using forward block %d\n", block_num);
                   est_block = block_num;
                   exit(1);
                }
                target_block = est_block;
             }
             retry_count++;
             printf("\nRetrying error on %d\n",target_block);
             reverse = reverse_tape(reverse, 1, 1);
             first = 2;
             est_block = -999;
          } else { 
             if (first_tape_block == NOT_SET || reverse_in) {
                first_tape_block = block_num;
                first_rev_tape_block = rev_block_num;
             }
             if (retrying) {
                if (error)
                   printf("\n***Unable to get good block %d\n",target_block);
                else
                   printf("\nGot good block %d with %d retries rev %d\n",
                      target_block, retry_count, reverse != reverse_in);
                retry_count = 0;
                if (reverse == reverse_in) {
                   retrying = 0;
                } else {
                   // If retring last block this may not work
                   // Getting block number below can be wrong
                   if (reverse_in)
                      target_block--; 
                   else
                      target_block++;
                   reverse = reverse_tape(reverse, 1, 1);
                   first = 2;
                }
             } else {
                first = 0;
                est_block = -999;
             }
             if ((tape_buffer_ndx + blksize)*2 >= sizeof(tape_buffer)) { 
                printf("\nTape buffer overflow\n");
                exit(1);
             }
             memcpy(&tape_buffer[tape_buffer_ndx], data_buffer, blksize*2);
             tape_buffer_ndx += blksize;
             last_blksize = blksize;
          }
       }
    }
    write_linctape(reverse, tape_buffer, tape_buffer_ndx, 
       last_blksize, first_tape_block, first_rev_tape_block, out);
}
void linctape_update_tape_line_count(int tape_line_count_in, int stream_done) {
   tape_line_count = tape_line_count_in;
   if (stream_done) {
      streaming = 0;
  }
}

void linctape_get_stats(int *exp_block_count_ret, int *block_count_ret,
                        int *bad_format_count_ret,
                        int *bad_checksum_count_ret)
{
    *exp_block_count_ret = exp_block_count;
    *block_count_ret = block_count;
    *bad_format_count_ret = bad_format_count;
    *bad_checksum_count_ret = bad_checksum_count;
}
