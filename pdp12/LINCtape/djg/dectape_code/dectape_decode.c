static int data_mode = 12;
static int exp_len_12 = 86;
static int exp_len_18 = 256;
static int exp_block_count_12 = 1474;
static int exp_block_count_18 = 578;

/*
 * dectape_decode.c
 *
 * Copyright 2001 Eric Smith <eric@brouhaha.com>
 *
 * $Id: dectape_decode.c,v 1.7 2001/01/31 03:32:55 eric Exp eric $
 *
 * It is assumed that the DECtape contains a series of blocks consecutively
 * numbered starting from 0, and all having the same size.  The block size
 * and count will be written to stderr.
 *
 * The output file will consist of the contents of all the blocks, with
 * no block separator or indication.  Four data modes are supported: 
 *
 * 12-bit:  each 12-bit word will be written in two bytes of output,
 *          padded with four zero bits.
 * 16-bit:  each 16-bit word will be written in two bytes of output.
 * 18-bit:  each 18-bit word will be written in four bytes of output,
 *          padded at MSB with zero bits.
 * 36-bit:  each 36-bit word will be written in five bytes of output,
 *          padded with four zero bits.
 *
 * References:
 *
 *     U.S. Patent 3,387,293
 *     Bidirectional Retrieval of Magnetically Recorded Data
 *     T. C. Stockebrand, inventor
 *
 *     TC11 DECtape System Manual
 *     DEC-11-HTCB-D
 *     Digital Equipment Corporation
 *
 *     TC11 DECtape System Engineering Drawings
 *     DEC-11-HTCA-D
 *     Digital Equipment Corporation
 *
 * Scans of these documents may be found at
 *     http://www.brouhaha.com/~eric/retrocomputing/dec/dectape/
 */


#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <unistd.h>
#include "dectape_decode.h"
#include "decode_transitions.h"


typedef unsigned char boolean;
#define false 0
#define true 1

typedef unsigned char u8;
typedef unsigned int u32;


FILE *outfile;


#define MAX_TAPE_LINES 1500000

static u8 *tape_lines;
static volatile u32 tape_line_count;
static u32 head;

static boolean streaming = false; // True if processing data as it arrives

static int checksum;
static int bad_checksum_count;
static int bad_format_count;
static int block_count;
static int exp_block_count;

int reverse_tape(int dir, int linctape, int wait_stop);


void fatal (int retval, char *fmt, ...) __attribute__ ((noreturn));
int obverse_complement_data (int d);

void fatal (int retval, char *fmt, ...)
{
  va_list ap;

  if (fmt)
    {
      fprintf (stderr, "%s: ", "dectape_decode");
      va_start (ap, fmt);
      vfprintf (stderr, fmt, ap);
      va_end (ap);
    }
  exit (retval);
}

/*
 * write the data from two frames to the output file
 */
void output_data (int data1, int data2, int last, int block, int reverse)
{
  static char data_buffer[16384];
  char data_buffer2[16384];
  static int data_buffer_index = 0;
  unsigned char c [8];
  int swap_size = 0;
  int i;
  int data3;

  if (data_buffer_index+6 >= sizeof(data_buffer)) {
     fatal(2, "data buffer overflow");
  }
  if (reverse) {

     data3 = obverse_complement_data(data2);
     data2 = obverse_complement_data(data1);
     data1 = data3;
  }
  switch (data_mode)
    {
    case 12:
      c [1] = data1 >> 14;
      c [0] = (data1 >> 6) & 0xff;
      c [3] = (data1 >> 2) & 0x0f;
      c [2] = ((data1 & 0x03) << 6) + (data2 >> 12);
      c [5] = (data2 >> 8) & 0x0f;
      c [4] = data2 & 0xff;
      memcpy(&data_buffer[data_buffer_index], c, 6);
      data_buffer_index += 6;
      swap_size = 6;
      break;
    case 16:
      /* high two bits of each frame ignored */
      c [0] = data1 & 0xff;
      c [1] = (data1 >> 8) & 0xff;
      c [2] = data2 & 0xff;
      c [3] = (data2 >> 8) & 0xff;
      memcpy(&data_buffer[data_buffer_index], c, 4);
      data_buffer_index += 4;
      swap_size = 4;
      break;
    case 18:
      c [0] = data1 & 0xff;
      c [1] = (data1 >> 8) & 0xff;
      c [2] = (data1 >> 16) & 0x03;
      c [3] = 0;
      c [4] = data2 & 0xff;
      c [5] = (data2 >> 8) & 0xff;
      c [6] = (data2 >> 16) & 0x03;
      c [7] = 0;
      memcpy(&data_buffer[data_buffer_index], c, 8);
      data_buffer_index += 8;
      swap_size = 8;
      break;
    case 36:
      c [0] = data2 & 0xff;
      c [1] = (data2 >> 8) & 0xff;
      c [2] = ((data1 & 0x3f) << 2) + ((data2 >> 16) & 3);
      c [3] = (data1 >> 6) & 0xff;
      c [4] = (data1 >> 14) & 0xff;
      memcpy(&data_buffer[data_buffer_index], c, 5);
      data_buffer_index += 5;
      swap_size = 5;
      break;
    }
    if (last) {
      if (fseek(outfile, block * data_buffer_index, SEEK_SET) != 0) {
         fatal(2, "Output file seek failed block %d\n",block);
      }
      if (reverse) {
         for (i = 0; i < data_buffer_index; i += swap_size) {
            memcpy(&data_buffer2[i], 
               &data_buffer[data_buffer_index-i-swap_size], swap_size);
         }   
         fwrite (data_buffer2, 1, data_buffer_index, outfile);
      } else {
         fwrite (data_buffer, 1, data_buffer_index, outfile);
      }
      data_buffer_index = 0;
    }
}

int obverse_complement_mark (int m)
{
  int i;
  int oc = 0;
  for (i = 0; i < 6; i++)
    {
      oc <<= 1;
      oc |= ! (m & 1);
      m >>= 1;
    }
  return (oc);
}


int obverse_complement_data (int d)
{
  int i;
  int oc = 0;
  for (i = 0; i < 6; i++)
    {
      oc <<= 3;
      oc |= ((d & 7) ^ 7);
      d >>= 3;
    }
  return (oc);
}

void update_tape_line_count(int tape_line_count_in, int stream_done) {
   tape_line_count = tape_line_count_in;
   if (stream_done) {
      streaming = false;
   }
}

void waitfor(int location, int exit_code, char *text)
{
  while (location >= tape_line_count) {
     if (streaming) {
        usleep(1000);
     } else {
        printf("location %d count %d\n",location, tape_line_count);
        fatal (exit_code, text);
     }
  }
}

/*
 * get an 18-bit frame of data from the current tape location
 */
int get_data_frame (int check)
{
  int i;
  int data = 0;

  waitfor(head + 5, 2, "flapped the tape getting a data frame\n");

  for (i = 0; i < 6; i++)
    data = (data << 3) + (tape_lines [head + i] & 7);

  if (check)
    {
      checksum ^= ((data >> 12) & 077);
      checksum ^= ((data >> 6) & 077);
      checksum ^= (data & 077);
    }

  return (data);
}


int get_mark (void)
{
  int i;
  int mark = 0;

  waitfor(head + 5, 2, "flapped the tape getting a mark frame\n");

  for (i = 0; i < 6; i++)
    mark = (mark << 1) + ((tape_lines [head + i] >> 3) & 1);

  return (mark);
}


#define SYNC 1
#define MK_BLK_MK 2
#define MK_BLK_SYNC 3
#define MK_BLK_START 4
#define MK_DATA 5
#define MK_BLK_END 6
#define MK_END 7

/*
 * find the next significant mark track code, and leave the head
 * positioned at its start
 */
int mark_track_decode (void)
{
  int i;
  int mark;

  while (1)
    {
     waitfor(head + 8, 2, "flapped the tape searching for a mark frame\n");

      mark = 0;
      for (i = 0; i < 8; i++)
	mark = (mark << 1) + ((tape_lines [head + i] >> 3) & 1);
      //if (head < 1000)
      //printf("mark %o head %d line %o\n",mark, head, tape_lines[head]);
      switch (mark)
	   {
   #if 0
	   case 0125:
	   case 0325:
	     head += 2;
	     return (SYNC);
   #endif
	   case 0126:
	     head += 2;
	     return (MK_BLK_MK);
	   case 0232:
	     head += 2;
	     return (MK_BLK_SYNC);
	   case 0010:
	   case 0210:
	     head += 2;
	     return (MK_BLK_START);
	   case 0070:
	     head += 2;
	     return (MK_DATA);
	   case 0073:
	   case 0373:
	     head += 2;
	     return (MK_BLK_END);
	   case 0351:
	     head += 2;
	     return (MK_BLK_SYNC);
	   case 0222:
	     head += 2;
	     return (MK_END);
      // 155 Leader
	   }
	 head++;
       }
}


/* returns true at end of tape */
int read_block (int *block_number, int *block_length, int reverse, int target_block, int exp_block)
{
  int code;
  int block, rev_block;
  int len;
  int i;
  int data [2];
  int end_count = 0;
  int rc = 0;
  int out_block = exp_block;

  for (;;)
    {
      code = mark_track_decode ();
      // Really make sure we are in end before stopping
      if (code == MK_END && end_count++ > 50)
	return (2);
      if (code == MK_BLK_MK)
	break;
    }

  block = get_data_frame (0);
  // Disk monitor system tape doesn't have upper bits set properly
  block &= 07777;
  //printf("Block %d\n",block);
  *block_number = block;

  *block_length = 0;  /* assume error */

  head += 6;

  /* get reverse guard (032) */
  code = get_mark ();
  if (code != 032)
    {
      fprintf (stderr, "bad block format, reverse guard not found %o\n", code);
      return (1);
    }
  head += 6;

  /* get reverse lock (010) */
  code = get_mark ();
  if (code != 010)
    {
      fprintf (stderr, "bad block format, reverse lock not found %o\n", code);
      return (1);
    }
  head += 6;

  /* get reverse check (010) */
  code = get_mark ();
  if (code != 010)
    {
      fprintf (stderr, "bad block format, reverse check not found %o\n",code);
      return (1);
    }
  checksum = get_data_frame (0) & 077;
  head += 6;

  /* get first two words (010) */
  for (i = 0; i < 2; i++)
    {
      code = get_mark ();
      if (code != 010)
	{
	  fprintf (stderr, "bad block format, first two words not found, code %02o, expected %02o at %d\n", code, 010, head);
	  return (1);
	}
      data [i] = get_data_frame (1);
      head += 6;
    }
  if (block == target_block || target_block == -999) 
     output_data (data [0], data [1], 0, out_block, reverse);
  len = 2;

  /* get pairs of intermediate words (070) */

  for (;;)
    {
      code = get_mark ();
      if (code == 073)
	break;
      if (code != 070)
	{
	  fprintf (stderr, "bad block format, intermediate data words not found, code %02o, expected %02o\n", code, 070);
	  return (1);
	}
      data [0] = get_data_frame (1);
      head += 6;

      code = get_mark ();
      if (code == 073)
	{
	  fprintf (stderr, "bad block format, odd length\n");
	  break;
	}
      if (code != 070)
	{
	  fprintf (stderr, "bad block format, intermediate data words not found, code %02o, expected %02o\n", code, 070);
	  return (1);
	}
      data [1] = get_data_frame (1);
      head += 6;

  if (block == target_block || target_block == -999) 
      output_data (data [0], data [1], 0, out_block, reverse);
      len += 2;
    }

  /* get last two data words (073) */
  for (i = 0; i < 2; i++)
    {
      code = get_mark ();
      if (code != 073)
	{
	  fprintf (stderr, "bad block format, last two words not found, code %02o, expected %02o\n", code, 073);
	  return (1);
	}
      data [i] = get_data_frame (1);
      head += 6;
    }
  len += 2;

  /* get forward check (073) */
  code = get_mark ();
  if (code != 073)
    {
      fprintf (stderr, "bad block format, forward check not found code %02o expected %02o\n", code, 073);
      return (1);
    }
  checksum ^= (get_data_frame (0) >> 12);
  head += 6;

  /* verify checksum here */
  if (checksum != 077)
    {
      bad_checksum_count++;
      fprintf (stderr, "\nbad checksum block %d %o\n", *block_number, checksum);
      rc = 3;
    }

  /* get forward lock (073) */
  code = get_mark ();
  if (code != 073)
    {
      fprintf (stderr, "bad block format, forward lock not found\n");
      return (1);
    }
  head += 6;

  /* get forward guard (051) */
  code = get_mark ();
  if (code != 051)
    {
      fprintf (stderr, "bad block format, forward guard not found\n");
      return (1);
    }
  head += 6;

  /* get reverse block number (045) */
  code = get_mark ();
  if (code != 045)
    {
      fprintf (stderr, "bad block format, reverse block number not found\n");
      return (1);
    }
  rev_block = obverse_complement_data(get_data_frame (0)) & 07777;
  head += 6;
  /* compare reverse block number to forward */
  if (block != rev_block) {
    printf ("block number mismatch: block %06o, rev block %06o\n",
	    block, rev_block);
    if (rev_block == exp_block)
       *block_number = rev_block;
 } else {
    out_block = block;
 }
  if (block == target_block || target_block == -999) 
     output_data (data [0], data [1], 1, out_block, reverse);

// This switches to format a 552 dectape control seemed to be using
#if 1
  /* get extension (025) */
  code = get_mark ();
  if (code != 025)
    {
      fprintf (stderr, "bad block format, extension not found %o\n",code);
      return (1);
    }
  head += 6;
#else
  head -= 2;
#endif

  *block_length = len;

  return (rc);
}


int dectape_decode (FILE *out, unsigned char *tape_lines_in, 
   int tape_line_count_in , int reverse, int streaming_in, int format,
   int retry)
{
  int block_number, block_length;
  int exp_block = 0;
  int exp_len;
  int rc;
  boolean format_error = false;
  
  if (format == 18) {
     exp_len = exp_len_18;
     exp_block_count = exp_block_count_18;
     data_mode = 18;
  } else {
     exp_len = exp_len_12;
     exp_block_count = exp_block_count_12;
     data_mode = 12;
  }

  streaming = streaming_in;

  if (reverse) {
     exp_block = exp_block_count - 1;
  }
  block_count = 0;
  bad_checksum_count = 0;
  bad_format_count = 0;

   tape_lines = tape_lines_in;
   tape_line_count = tape_line_count_in;
   fprintf (stderr, "DECtape raw image decoder, Copyright 2001 Eric Smith <eric@brouhaha.com>\n");

   outfile = out;

  head = 0;

  for (;;)
    {
      format_error = false;
      rc = read_block (& block_number, & block_length, reverse, -999, exp_block);
      //printf("\nread return %d block %d \n",rc, block_number);
      if (rc == 2)
	      break;
      if (rc == 1) {
         fprintf(stderr, "Error at %d %f\n",head, get_tape_time(head));
         format_error = true;
      }
      if (retry && (rc == 1 || rc == 3)) {
         int lcl_rev = reverse;
         int retry_count = 1;
         int done = 0;
         int find_block = exp_block;

         lcl_rev = reverse_tape(lcl_rev, 0, 1);
         head = 0;
         while (!done && (retry_count < 20 || lcl_rev != reverse)) {
            rc = read_block (& block_number, & block_length, lcl_rev, find_block, exp_block);
            if ((lcl_rev && block_number < exp_block) || 
               (!lcl_rev && block_number > exp_block)) {
                  printf("\nMissed block %d %d, dir %d retrying\n", block_number, exp_block, lcl_rev);
                  lcl_rev = reverse_tape(lcl_rev, 0, 1);
                  head = 0;
            }  else if (block_number == exp_block) {
               // This is if we got the good read in the wrong direction
               // Now we found the block in the other direction so can stop
               if (find_block == -998) {
                  done = 1;
               } else if (rc == 0) {
                  printf("\nGood read block %d retries %d rev %d\n", exp_block,
                        retry_count, lcl_rev != reverse);
                  if (lcl_rev == reverse) {
                     done = 1;
                  } else {
                     // Don't write next time we pass
                     find_block = -998;
                     lcl_rev = reverse_tape(lcl_rev, 0, 1);
                     head = 0;
                     printf("reversing tape %d\n",lcl_rev);
                  }
               } else {
                  lcl_rev = reverse_tape(lcl_rev, 0, 1);
                  head = 0;
                  printf("\nRetrying read block %d rev %d %d\n", exp_block,
                        lcl_rev != reverse, retry_count);
               } 
               retry_count++;
            }
         }
      }
      //printf("block # %d\n",block_number);
      if (block_count == 0 && retry && block_number > exp_block && exp_len == block_length) {
         int lcl_rev = reverse;
         printf("\nRewinding to beginning of tape, found block %d\n", block_number);
         lcl_rev = reverse_tape(lcl_rev, 0, 0);
         head = 0;
         while (read_block (& block_number, & block_length, lcl_rev, -998, exp_block) != 2);
         lcl_rev = reverse_tape(lcl_rev, 0, 0);
         head = 0;
      } else {
         if ((exp_block != block_number) || (exp_len != block_length)) {
	     fprintf (stderr, "mismatch block %d(%d) length %d(%d) 18-bit words", 
              block_number, exp_block, block_length, exp_len);
	     if (data_mode != 18)
	       fprintf (stderr, " = %d %d-bit words",
		       (data_mode == 16) ? block_length : (block_length * 18) / data_mode,
		       data_mode);
	    fprintf (stderr, "\n");
       format_error = true;
	   }
         block_count++;
      if (reverse) {
         exp_block = block_number - 1;
      } else {
         exp_block = block_number + 1;
      }
      if (format_error) 
          bad_format_count++;
    }

  }
  //fprintf (stderr, "\n%d blocks\n", block_count);
  //fprintf (stderr, "%d bad checksums\n", bad_checksum_count);

  return 0;
}

void get_stats(int *exp_block_count_ret, int *block_count_ret, 
    int *bad_format_count_ret, int *bad_checksum_count_ret) {
   *exp_block_count_ret = exp_block_count;
   *block_count_ret = block_count;
   *bad_format_count_ret = bad_format_count;
   *bad_checksum_count_ret = bad_checksum_count;
}

