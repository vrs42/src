/* This program sends an td8e Dectape image out the serial port to the PDP8
   restore program.  It will prompt for the file to send or use first command
   line argument.  It needs a config file dumprest.cfg or $HOME/.dumprest.cfg
   with the format defined in config.c

   This program should be running before the PDP8 end is started.

   On the PC ctrl-break will terminate the program
*/
#ifdef PC
#include "encom.h"
#else
#include <termios.h>
#include <unistd.h>
#include <memory.h>
#endif

#include <stdio.h>
#include <fcntl.h>
#include <time.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>

#define ARRAYSIZE(a) (sizeof(a) / sizeof(a[0]))

int terminate = 0;

#define BLKSIZE 129

#include "config.c"
#include "comm.c"

main(argc,argv)
   int argc;
   char *argv[];
{
   int fd;
   FILE *in;
   char filename[256];
   char serial_dev[256];
   long baud;
   int two_stop;
   unsigned char buf[3];
   unsigned short block_buf[BLKSIZE];
   int count,block;
   unsigned int chksum = 0;
   int readsz;
   int rc;

   setup_config(&baud,&two_stop,serial_dev);

   if (argc > 1) {
      strcpy(filename,argv[1]);
   } else {
      printf("Enter file name to send\n");
      fflush(stdout);
      scanf("%s",filename);
   }

#ifdef PC
   in = fopen(filename,"rb");
#else
   in = fopen(filename,"r");
#endif
   if (in == NULL) {
      fprintf(stderr,"On file %s ",filename);
      perror("open failed");
      exit(1);
   }

#if 0
      /* For testing write to file, only works in unix version */
   fd = open("dat",O_RDWR | O_CREAT | O_TRUNC,0666);
   if (fd < 0) {
      perror("Open failed on dat");
      exit(1);
   }
#else
   fd = init_comm(serial_dev,baud,two_stop);
#endif

   count = BLKSIZE;
   block = 0;
   readsz = 0;
   while(!terminate) {
         /* If start of new block */
      if (count == BLKSIZE) {
         count = 0;
            /* If sent all blocks pdp8 asked for wait for it to ask for more */
         if (--readsz <= 0) {
            while (ser_read(fd,(char *)buf,1) < 1 && !terminate);
            readsz = buf[0];
/*
            printf("Got readsize %d\n",readsz);
*/
         }
	 if ((rc = fread(block_buf,2,BLKSIZE,in)) < BLKSIZE) {
	       /* No more data */
	    if (rc < 0) {
	       perror("\nfile read failed\n");
	       exit(1);
	    }
	      /* Must be at start of block when data done */
	    if (rc != 0) {
	       printf("\nEarly end of file %d, %d\n",count,rc);
	       exit(1);
	    }
	       /* Send end of data flag */
	    buf[0] = 0xfe;
	    ser_write(fd,(char *)buf,1);
	       /* Wait for PDP to ask for checksum */
	    while (ser_read(fd,(char *)buf,1) < 1 && !terminate);
	    chksum = -chksum;
	    buf[0] = chksum;
	    buf[1] = (chksum & 0xfff) >> 8;
	    ser_write(fd,(char *)buf,2);
	    exit(0);
	 }
         buf[0] = 0xff;
         ser_write(fd,(char *)buf,1);
         block++;
         if (block % 5 == 0) {
            printf("Block %d\r",block);
            fflush(stdout);
         }
      }
         /* Send 2 words as 3 bytes */
      chksum += block_buf[count];
      buf[0] = block_buf[count];
      if (count + 1 == BLKSIZE) {
         buf[1] = (block_buf[count] >> 8);
         count++;
         ser_write(fd,(char *)buf,2);
      } else {
         chksum += block_buf[count+1];
         buf[1] = (block_buf[count] >> 8) | (block_buf[count+1] << 4);
         buf[2] = (block_buf[count+1] >> 4);
         count += 2;
         ser_write(fd,(char *)buf,3);
      }
   }
   return 1;
}
