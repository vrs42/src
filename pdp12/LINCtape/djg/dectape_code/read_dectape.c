#define DEBUG 0
/*
 * mytest.c
 */
// Validate sector header and number of sectors

#define TWO_EDGE 0
#define CREATE_DELTAS 1

#define DRIVE_NUM 0
#define SECTOR_SIZE 512

#define MEMCPY 1

#define ARRAYSIZE(x) (sizeof(x) / sizeof(x[0]))

#define MAX_TAPE_LINES 1500000
static unsigned char tape_lines [MAX_TAPE_LINES];
volatile int tape_read = 0;

/******************************************************************************
* Include Files                                                               *
******************************************************************************/

// Standard header files
#include <stdio.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <sys/time.h>
#include <signal.h>
#include <pthread.h>

// Driver header file
#include "prussdrv.h"
#include <pruss_intc_mapping.h>	 

#include "dectape_decode.h"
#include "linctape_decode.h"
#include "decode_transitions.h"
#define INDD 4
#define SMEM_OFFSET OFFSET_SHAREDRAM
#define PRU_CONTROL_REG  (0x22000/4)
#include "cmd.h"
#define BIT_MASK(x) (1 << (x))

/******************************************************************************
* Explicit External Declarations                                              *
******************************************************************************/

/******************************************************************************
* Local Macro Declarations                                                    *
******************************************************************************/

#define PRU_NUM 	 0

#define OFFSET_DATARAM0 0
#define OFFSET_DATARAM1 2048 
#define OFFSET_SHAREDRAM 0x4800

/******************************************************************************
* Local Typedef Declarations                                                  *
******************************************************************************/


/******************************************************************************
* Local Function Declarations                                                 *
******************************************************************************/

static int LOCAL_exampleInit ( );
static unsigned short read_tape_setup (int data_mode, int linctape, int retry,
      char *fn );

/******************************************************************************
* Local Variable Definitions                                                  *
******************************************************************************/

volatile int discard = 0;

/******************************************************************************
* Intertupt Service Routines                                                  *
******************************************************************************/


/******************************************************************************
* Global Variable Definitions                                                 *
******************************************************************************/

//static int mem_fd;
static void *sharedMem;

static volatile unsigned int *ddrMem_int, *sharedMem_int;
static volatile char *ddrMem_char;

static unsigned int ddrMemSize, ddrMemSizeInt;
/******************************************************************************
* Global Function Definitions                                                 *
******************************************************************************/
static int exec_cmd(int cmd, int data);


// Must be power of 2
#define DELTA_BUFFER_SIZE (1 << 20)
static int min_buffer_free;
static volatile int delta_in = 0;
 volatile int delta_out_file = 0;
static volatile int delta_out_decode = 0;
static unsigned int deltas[DELTA_BUFFER_SIZE];
inline int cbuf_occupancy(int in, int out) {
   int fill = in - out;
   if (fill < 0) {
      fill += DELTA_BUFFER_SIZE;
   } 
   return fill;
}
inline int cbuf_free(int in, int out) {
   int fill = in - out;
   if (fill < 0) {
      fill += DELTA_BUFFER_SIZE;
   } 
   return DELTA_BUFFER_SIZE - fill - 1;
}

inline int cbuf_wrap(int loc) {
   return DELTA_BUFFER_SIZE - loc;
}
inline int cbuf_min_free_wrap(int in, int out) {
   if (in < out) {
      return cbuf_wrap(in);
   } else {
      return cbuf_free(in, out);
   }
}
inline int cbuf_min_occupancy_wrap(int in, int out) {
   if (in < out) {
      return cbuf_wrap(out);
   } else {
      return cbuf_occupancy(in, out);
   }
}

inline int cbuf_increment(int index, int value) {
   return (index+value) & (DELTA_BUFFER_SIZE-1);
}

void stop_read(void)
{
   // Restart at address 0x1000;
   sharedMem_int[PRU_CONTROL_REG] = STOP_ADDR;
   sharedMem_int[PRU_CONTROL_REG] = STOP_ADDR | 2;
}


void shutdown(void)
{
   static int called = 0;
   
   tape_read = 1;
   if (called)
      return;
   called = 1;
   stop_read();

   exec_cmd(CMD_EXIT, 0);

   /* Wait until PRU0 has finished execution */
   printf("\tINFO: Waiting for HALT command.\r\n");
   prussdrv_pru_wait_event (PRU_EVTOUT_0);
   printf("\tINFO: PRU completed transfer.\r\n");
   prussdrv_pru_clear_event (PRU_EVTOUT_0, PRU0_ARM_INTERRUPT);

   prussdrv_pru_disable(PRU_NUM); 
   prussdrv_exit ();
}

void shutdown_signal(void)
{
   shutdown();
   exit(1);
}

int main (int argc, char *argv[])
{
    unsigned int ret;
    tpruss_intc_initdata pruss_intc_initdata = PRUSS_INTC_INITDATA;
    int data_mode = 12;
    int linctape = 0;
    int retry = 1;
    char *fn = "decoded";
    int i;
    
    for (i = 1; argc > 1; i++, argc--) {
          if (strcmp (argv [i], "-12") == 0)
            data_mode = 12;
          else if (strcmp (argv [i], "-16") == 0)
            data_mode = 16;
          else if (strcmp (argv [i], "-18") == 0)
            data_mode = 18;
          else if (strcmp (argv [i], "-36") == 0)
            data_mode = 36;
          else if (strcmp (argv [i], "-l") == 0)
            linctape = 1;
          else if (strcmp (argv [i], "-n") == 0)
            retry = 0;
          else {
             fn = argv[i];
             if (access(fn, F_OK) == 0) {
                printf("File exists, overwrite not allowed\n");
                exit(1);
             }
          }
    }
   
    signal(SIGINT,(__sighandler_t) shutdown_signal);
    atexit(shutdown);

    printf("\nINFO: Starting %s example.\r\n", "PRU_memAccess_DDR_PRUsharedRAM");
    /* Initialize the PRU */
    prussdrv_init ();		
    
    /* Open PRU Interrupt */
    ret = prussdrv_open(PRU_EVTOUT_0);
    if (ret)
    {
        printf("prussdrv_open open failed\n");
        return (ret);
    }
    
    /* Get the interrupt initialized */
    prussdrv_pruintc_init(&pruss_intc_initdata);

    /* Initialize example */
    printf("\tINFO: Initializing example.\r\n");
    LOCAL_exampleInit(PRU_NUM);
    
    /* Execute example on PRU */
    printf("\tINFO: Executing example.\r\n");
    prussdrv_exec_program (PRU_NUM, "./prucode0.bin");

    if ( !read_tape_setup(data_mode, linctape, retry, fn) )
    {
        printf("Read executed succesfully.\r\n");
    }
    else
    {
        printf("Read failed.\r\n");
    }

    //munmap(ddrMem, 0x0FFFFFFF);
    //close(mem_fd);

    return(0);
}

/*****************************************************************************
* Local Function Definitions                                                 *
*****************************************************************************/

static int LOCAL_exampleInit (  )
{
    unsigned int ddr_base, ddr_offset;
    FILE *fin;

    fin = fopen("/sys/class/uio/uio0/maps/map1/addr","r");
    if (fin == NULL) {
       perror("Unable to open DDR map address");
       exit(1);
    }
    fscanf(fin, "%x", &ddr_base);
    fclose(fin);

    fin = fopen("/sys/class/uio/uio0/maps/map1/offset","r");
    if (fin == NULL) {
       perror("Unable to open DDR map offset");
       exit(1);
    }
    fscanf(fin, "%x", &ddr_offset);
    fclose(fin);

    fin = fopen("/sys/class/uio/uio0/maps/map1/size","r");
    if (fin == NULL) {
       perror("Unable to open DDR map address");
       exit(1);
    }
    fscanf(fin, "%x", &ddrMemSize);
    ddrMemSizeInt = ddrMemSize/4;
    fclose(fin);
    printf("DDR base %x offset %x size %x\n",ddr_base, ddr_offset, ddrMemSize); 

#if 0
    /* open the device */
    mem_fd = open("/dev/mem", O_RDWR);
    //UIO is uncached
    //mem_fd = open("/dev/uio0", O_RDWR);
    if (mem_fd < 0) {
        printf("Failed to open /dev/mem (%s)\n", strerror(errno));
        return -1;
    }	

    /* map the DDR memory */
    ddrMem = mmap(0, ddrMemSize, PROT_WRITE | PROT_READ, MAP_SHARED, mem_fd, ddr_base);
    //ddrMem = mmap(0, ddrMemSize, PROT_WRITE | PROT_READ, MAP_SHARED, mem_fd, 0x1000);
    if (ddrMem == NULL) {
        printf("Failed to map the device (%s)\n", strerror(errno));
        close(mem_fd);
        return -1;
    }
    ddrMem_int = (int *) (ddrMem + ddr_offset);
    {
    volatile int *addr = prussdrv_get_virt_addr(ddr_base+ddr_offset);
    printf("virt %x %x\n",addr, ddrMem_int);
    printf("a %x %x %x\n",addr[0], addr[1], addr[2]);
    printf("%x %x %x\n", ddrMem_int[0], ddrMem_int[1], ddrMem_int[2]);
    ddrMem_int[0] = 0x12344321;
    printf("a %x %x %x\n",addr[0], addr[1], addr[2]);
    printf("%x %x %x\n", ddrMem_int[0], ddrMem_int[1], ddrMem_int[2]);
    //*addr = 0x12345678;
    printf("a %x %x %x\n",addr[0], addr[1], addr[2]);
    printf("%x %x %x\n", ddrMem_int[0], ddrMem_int[1], ddrMem_int[2]);
    printf("a %x %x %x\n",addr[0], addr[1], addr[2]);
    printf("%x %x %x\n", ddrMem_int[0], ddrMem_int[1], ddrMem_int[2]);
    //ddrMem_int = addr;
    }
#else
    ddrMem_int = prussdrv_get_virt_addr(ddr_base+ddr_offset);
    ddrMem_char = (char *) ddrMem_int;
#endif
    
     /* Allocate PRU memory. */
    prussdrv_map_prumem(PRUSS0_PRU0_DATARAM, &sharedMem);
    sharedMem_int = (unsigned int*) sharedMem;

    sharedMem_int[OFFSET_DATARAM0 + LMEM_DDR_ADDR] = ddr_base;
    sharedMem_int[OFFSET_DATARAM0 + LMEM_DDR_MASK] = ddrMemSize-1;

    return(0);
}

static void print_status(int status) {
   struct {
      char *desc;
      int bit;
   } reg_bits[] = 
   {
      { "Write fault", R31_RMT_BIT}
   };
   int n;

   for (n = 0; n < ARRAYSIZE(reg_bits); n++) {
      if (status & (1 << reg_bits[n].bit)) {
         printf("Not %s \n", reg_bits[n].desc);
      } else {
         printf("%s \n", reg_bits[n].desc);
      }
   }
}

static int exec_cmd(int cmd, int data)
{
   int last_pc = -1;
   int pc;

   sharedMem_int[SMEM_CMD_DATA] = data;
   sharedMem_int[SMEM_CMD] = cmd;
   while (sharedMem_int[SMEM_CMD] == cmd) {
      pc = sharedMem_int[PRU_CONTROL_REG+1];
      if (pc != last_pc) {
         printf("PC %x\n", pc);
         last_pc = pc;
      }
      usleep(100);
   };
   if (sharedMem_int[SMEM_CMD] != CMD_STATUS_OK) {
      printf("Command %d fault %x %x\n",cmd, sharedMem_int[SMEM_CMD], 
           sharedMem_int[SMEM_DRIVE_STATUS]);
      print_status(sharedMem_int[SMEM_DRIVE_STATUS]);
      return sharedMem_int[SMEM_CMD];
   }

   return 0;
}

static void set_drive(int drive)
{
   char *drive_pins[] = {
      "/sys/class/gpio/gpio2/direction",
   };
   static int first_time = 1;
   static int fd[4];
   int i;

   if (first_time) {
      for (i = 0; i < 4; i++) {
         fd[i] = open(drive_pins[i], O_WRONLY);
         if (fd[i] < 0) {
            printf("Unable to open pin %s\n",drive_pins[i]);
            exit(1);
         }
      }
      first_time = 0;
   }
   if (drive) {
      write(fd[0], "high", 4);
   } else {
      write(fd[0], "low", 3);
   }
   usleep(10); // Allow lines to settle
}


int get_deltas(int first) {
   static int last_mem_index = 0;
   int mem_index;
   int max_transfer, tmp;

   if (first) {
      last_mem_index = 0;
   }
#if DEBUG
   printf("Write pointer %d %x\n",sharedMem_int[SMEM_WRITE_PTR],
         sharedMem_int[SMEM_WRITE_PTR]);
#endif
   mem_index = sharedMem_int[SMEM_WRITE_PTR] / 4;

   if (discard) {
      // This is ugly, need to either not reset in asm or do this
      // cleaner
      sharedMem_int[SMEM_WRITE_PTR] = 0;
      last_mem_index = 0;
      return 0;
   }

#if 0
   if (mem_index != 0)
   printf("%x mem_index %x\n",mem_index*4,sharedMem_int[OFFSET_DATARAM0 + LMEM_DDR_MASK]);
   { int pc;
      pc = sharedMem_int[PRU_CONTROL_REG+1];
         printf("PC %x\n", pc);
   }
#endif
   if (mem_index == last_mem_index) {
      return 0;
   }
   max_transfer = cbuf_free(delta_in, delta_out_file);
   tmp = cbuf_free(delta_in, delta_out_decode);
   if (tmp < max_transfer) {
      max_transfer = tmp;
   }
   if (max_transfer < min_buffer_free) {
      min_buffer_free = max_transfer;
   }
   tmp = cbuf_wrap(delta_in);
   if (tmp < max_transfer) {
      max_transfer = tmp;
   }

   if (mem_index < last_mem_index) {
      tmp = (ddrMemSizeInt - last_mem_index);
   } else {
      tmp = (mem_index - last_mem_index);
   }
   if (tmp < max_transfer) {
      max_transfer = tmp;
   }
   //printf("copying to %d from %d len %d\n",delta_in, last_mem_index, max_transfer);
   memcpy(&deltas[delta_in], (char *) &ddrMem_int[last_mem_index], 
       max_transfer*4 );
   delta_in = cbuf_increment(delta_in, max_transfer);
   last_mem_index = last_mem_index + max_transfer;
   if (last_mem_index >= ddrMemSizeInt) {
      last_mem_index = 0;
   }

   return max_transfer;
}

static void read_tape(int read_cmd)
{
   int first;

   set_drive(DRIVE_NUM);

   if (sharedMem_int[SMEM_CMD] == CMD_STATUS_WAIT_READY) {
      printf("Waiting for ready\n");
      while (sharedMem_int[SMEM_CMD] == CMD_STATUS_WAIT_READY) {
         usleep(100);
      };
   }
   if (sharedMem_int[SMEM_CMD] != CMD_STATUS_OK) {
      printf("Drive fault %x %x\n",sharedMem_int[SMEM_CMD], 
           sharedMem_int[SMEM_DRIVE_STATUS]);
      print_status(sharedMem_int[SMEM_DRIVE_STATUS]);
      exit(1);
   }
   if (exec_cmd(read_cmd, 0) != 0) {
      printf("Write pointer %d %x\n",sharedMem_int[SMEM_WRITE_PTR],
      sharedMem_int[SMEM_WRITE_PTR]);
      exit(1);
   }
   first = 1;
   while (!tape_read) {
      if (get_deltas(first) < 50) {
         usleep(1000);
      }
      first = 0;
   }

   return;
}

typedef struct {
   int fd_raw;
   int linctape;
} DO_WRITE_ARG;

void *do_write_deltas(void *arg)
{
   int fd_raw;
   double start = 0;
   double end;
   struct timeval tv_end;
   int max_transfer;
   int deltas_total = 0;
   int min_file_write = 1000;
   int exp_block_count, block_count, bad_format_count, bad_checksum_count;
   int done = 0;
   DO_WRITE_ARG *do_write_arg;

   do_write_arg = (DO_WRITE_ARG *)arg;
   fd_raw = do_write_arg->fd_raw;

   while (!done) {
      max_transfer = cbuf_min_occupancy_wrap(delta_in, delta_out_file);

      gettimeofday(&tv_end, NULL);
      end = tv_end.tv_sec + tv_end.tv_usec / 1e6;
      if (end - start > 1) {
         if (start != 0) {
            if (do_write_arg->linctape) {
               linctape_get_stats(&exp_block_count, &block_count, &bad_format_count,
                &bad_checksum_count);
            } else {
               get_stats(&exp_block_count, &block_count, &bad_format_count,
                &bad_checksum_count);
            }
            printf("got %d blocks, %d format errors, %d chksum errors ", block_count, bad_format_count, 
            bad_checksum_count);
            printf("read %f kwords/sec\r", deltas_total /  (end - start) / 1000);
            fflush(stdout);
         }
         start = end;
         deltas_total = 0;
      }
      if ((!tape_read || max_transfer == 0) && 
            (max_transfer < min_file_write && 
             max_transfer < cbuf_wrap(delta_out_file))) {
         if (tape_read && max_transfer == 0) {
            done = 1;
         } else {
            usleep(1000);
         }
      } else { 
         if (fd_raw >= 0) {
            int bytes = max_transfer * sizeof(deltas[0]);
            write(fd_raw, &bytes, sizeof(bytes));
            write(fd_raw, &deltas[delta_out_file], bytes);
         }
         delta_out_file = cbuf_increment(delta_out_file, max_transfer);
         deltas_total += max_transfer;
      }
   }
   return NULL;
}

typedef struct {
   int linctape;
} DO_DECODE_DELTAS_ARG;

void *do_decode_deltas(void *arg)
{
   int max_transfer;
   int min_decode = 100;
   int tape_index = 0;
   int first_time = 1;
   DO_DECODE_DELTAS_ARG *do_decode_deltas_arg;

   do_decode_deltas_arg = (DO_DECODE_DELTAS_ARG *) arg;
   while (!tape_read) {
      if (discard) {
         tape_index = 0;
         delta_out_decode = delta_in;
         if (do_decode_deltas_arg->linctape) {
            linctape_update_tape_line_count(tape_index, 0);
         } else {
            update_tape_line_count(tape_index, 0);
         }
         usleep(1000);
      } else {
      max_transfer =  cbuf_min_occupancy_wrap(delta_in, delta_out_decode);
      if (max_transfer < min_decode && 
            max_transfer < cbuf_wrap(delta_out_decode)) {
         usleep(1000);
      } else {
         tape_index = decode_transitions(&deltas[delta_out_decode], 
            max_transfer, tape_lines, MAX_TAPE_LINES, tape_index, first_time,
            do_decode_deltas_arg->linctape);
         first_time = 0;
         if (do_decode_deltas_arg->linctape) {
            linctape_update_tape_line_count(tape_index, 0);
         } else {
            update_tape_line_count(tape_index, 0);
         }
         delta_out_decode = cbuf_increment(delta_out_decode, max_transfer);
      }
   }
   }

   return NULL;
}

typedef struct {
   int reverse;
   int linctape;
   int format;
   int retry;
} DO_DECTAPE_DECODE_ARG;

int reverse_tape(int dir, int linctape, int wait_rev)
{
   int read_cmd;

   discard = 1;
   // Make sure we go far enough that we don't pass block getting up to speed
   if (wait_rev)
      usleep(60000);  
   stop_read();
   //printf("Stop\n");
   //getchar();
   usleep(10000); 
   dir ^= 1;
   if ((!linctape && dir == 0) || (linctape && dir != 0)) {
      read_cmd = CMD_READ_TAPE;
   } else {
      read_cmd = CMD_READ_TAPE_REV;
   }
   discard = 0;
   if (exec_cmd(read_cmd, 0) != 0) {
      printf("Write pointer %d %x\n",sharedMem_int[SMEM_WRITE_PTR],
      sharedMem_int[SMEM_WRITE_PTR]);
      exit(1);
   }
   return dir;
}

void *do_dectape_decode(void *arg)
{
   FILE *out;
   DO_DECTAPE_DECODE_ARG *do_dectape_decode_arg;

   do_dectape_decode_arg = (DO_DECTAPE_DECODE_ARG *) arg;

   if (do_dectape_decode_arg->reverse) {
      out = fopen("decoded.rev", "w");
   } else {
      out = fopen("decoded.fwd", "w");
   }
   if (out == NULL) {
      perror("Unable to open output file");
      exit(1);
   }

   if (do_dectape_decode_arg->linctape) {
      if (do_dectape_decode_arg->retry)
         linctape_decode_retry(out, tape_lines, 0, do_dectape_decode_arg->reverse, 1);
      else
         linctape_decode(out, tape_lines, 0, do_dectape_decode_arg->reverse, 1);
   } else {
      dectape_decode(out, tape_lines, 0, do_dectape_decode_arg->reverse, 1, 
            do_dectape_decode_arg->format, do_dectape_decode_arg->retry);
   }

      // Read a little further to ensure when we reverse we don't loose any
   usleep(20000); 

   tape_read = 1;

   fclose(out);
   return NULL;
}

static unsigned short read_tape_setup ( int data_mode, int linctape, int retry,
      char *fn )
{
   pthread_t decode_thread, write_thread, delta_thread;
   int fd_raw = -1;
   int i;
   int read_cmd;
   char *raw_fn[2] = {"/tmp/raw_out.fwd","/tmp/raw_out.rev"};
   int exp_block_count, block_count, bad_format_count, bad_checksum_count;
   DO_WRITE_ARG do_write_arg;
   DO_DECTAPE_DECODE_ARG do_dectape_decode_arg;
   DO_DECODE_DELTAS_ARG do_decode_deltas_arg;

   for (i = 0; i < 2;) {
      min_buffer_free = DELTA_BUFFER_SIZE;
      tape_read = 0;
      delta_in = 0;
      delta_out_file = 0;
      delta_out_decode = 0;

      if ((!linctape && (i == 0)) || (linctape && (i == 1))) {
         read_cmd = CMD_READ_TAPE;
      } else {
         read_cmd = CMD_READ_TAPE_REV;
      }
#if CREATE_DELTAS
      fd_raw = open(raw_fn[i], O_WRONLY | O_CREAT | O_TRUNC, 0664);
      if (fd_raw < -1) {
         perror("Unable to create output file");
         exit(1);
      }
#endif
      do_dectape_decode_arg.reverse = (i == 1);
      do_dectape_decode_arg.linctape = linctape;
      do_dectape_decode_arg.format = data_mode;
      do_dectape_decode_arg.retry = retry;
      pthread_create(&decode_thread, NULL, &do_dectape_decode, &do_dectape_decode_arg);
      do_write_arg.fd_raw = fd_raw;
      do_write_arg.linctape = linctape;
      pthread_create(&write_thread, NULL, &do_write_deltas, &do_write_arg);
      do_decode_deltas_arg.linctape = linctape;
      pthread_create(&delta_thread, NULL, &do_decode_deltas, &do_decode_deltas_arg);

      read_tape(read_cmd);
      stop_read();
      if (linctape) {
         linctape_get_stats(&exp_block_count, &block_count, &bad_format_count,
                &bad_checksum_count);
      } else {
         get_stats(&exp_block_count, &block_count, &bad_format_count,
                &bad_checksum_count);
      }
      printf("\nPass %d expected %d block, got %d. %d format errors, %d checksum errors\n", i, exp_block_count, block_count, bad_format_count, 
            bad_checksum_count);
      printf("Minimum buffer free %d\n",min_buffer_free);
      pthread_join(decode_thread, NULL);
      pthread_join(write_thread, NULL);
      pthread_join(delta_thread, NULL);
      close(fd_raw);
      if (block_count < 20) {
         printf("Insufficient blocks found, retrying read\n");
      } else {
         i++;
      }
   }
   exec_cmd(CMD_EXIT, 0);
   if (system("cmp decoded.fwd decoded.rev") != 0) {
      printf("*** Files don't match ***\n");
   } else {
      rename("decoded.fwd",fn);
      unlink("decoded.rev");
      //unlink("raw_out.rev");
      printf("!!Files matched, saved as %s!!\n",fn);
   }
   return 0;

}
