/* This program receives an rx01 image from the serial port from the PDP8 dump
   program.  It will prompt for the file to receive or use first command
   line argument. It needs a config file dumprest.cfg or $HOME/.dumprest.cfg
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

#include "config.c"
#include "comm.c"

main(argc,argv)
   int argc;
   char *argv[];
{
   int fd,c,i;
   FILE *out;
   char filename[256];
   long baud;
   char serial_dev[256];
   int two_stop;
   unsigned char buf[200];
   int count,scnt,byte;
   int chksum = 0;
   unsigned int track;
   int badflag = 0;
   int sect_size;

   setup_config(&baud,&two_stop,serial_dev);

   if (argc > 1) {
      strcpy(filename,argv[1]);
   } else {
      printf("Enter file name to receive\n");
      fflush(stdout);
      scanf("%s",filename);
   }

#ifdef PC
   out = fopen(filename,"wb");
#else
   out = fopen(filename,"w");
#endif
   if (out < 0) {
      fprintf(stderr,"On file %s ",filename);
      perror("open failed");
      exit(1);
   }

#if 0
      /* For testing read from file, only works in unix version */
   fd = open("dat",O_RDONLY,0666);
   if (fd < 0) {
      perror("Open failed on dat");
      exit(1);
   }
#else
   fd = init_comm(serial_dev,baud,two_stop);
#endif

   count = -3;
   scnt = 0;
   byte = 0;
   while(!terminate) {
      c = ser_read(fd,(char *)buf,sizeof(buf));
      if (c < 0) {
         perror("Serial read failed");
         exit(1);
      }
      for (i = 0; i < c; i++) {
         chksum = chksum + buf[i];
         if (count < 0 ) {
               /*  - Checksum at end */
            if (count == -3) {
               switch(buf[i]) {
                  case 022:
                     printf("Single density disk (RX01)\n");
                     sect_size = 128;
                  break;
                  case 044:
                     printf("Double density disk (RX02)\n");
                     sect_size = 256;
                  break;
                  default:
                     printf("Unknow or quad density, not able to dump %o\n",buf[i]);
                     exit(1);
                  break;
               }
               count = -1;
            } else
            if (count == -2) {
               fclose(out);
               if ((chksum & 0xff) != 0) {
                  printf("\nChecksum bad %x\n",chksum & 0xff);
                  exit(1);
               }
               printf("\nDone\n");
               exit(0);
            } else {
                  /* Start of sector flag */
               if (buf[i] == 0xff || buf[i] == 0xfd) {
                  count = 0;
                  byte = 0;
                  if (buf[i] == 0xfd)
                     badflag = 1;
               } else {
                    /* How about checksum flag */
                  if (buf[i] == 0xfe) {
                     count = -2;
                     byte = 0;
                  } else {
                     printf("\nMissing start of block flag\n");
                     exit(1);
                  }
               }
            }
         } else {
              /* get track */
           if (byte == 0) {
              track = buf[i];
              byte++;
           } else
              /* and sector */
           if (byte == 1) {
              if (badflag) {
                 printf("\nTrack %d sector %d bad\n", track,buf[i]);
                 badflag = 0;
              }
              fseek(out, ((long)track*26 + buf[i] - 1) * sect_size, SEEK_SET);
              byte++;
           } else
              /* Sector data */
           if (byte == 2) {
              fwrite(&buf[i],1,1,out);
              count++;
              if (count == sect_size) {
                 count = -1;
                 scnt++;
                 if (scnt % 26 == 0) {
                    printf("Track %d\r",scnt / 26);
                    fflush(stdout);
                 }
              }
           }
        }
      }
   }
   return 1;
}
