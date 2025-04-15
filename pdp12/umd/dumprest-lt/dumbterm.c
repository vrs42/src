/* This program will act as a dumb terminal, sending characters typed to
   the PDP-8 and printing characters received.  Can be used to test the
   serial communications.

   The 8th bit is stripped for printing and set for sending to the PDP-8.

   On the PC ctrl-break will terminate the program
*/
#ifdef PC
#include "encom.h"
#include <io.h>
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

#ifndef STDOUT_FILENO
#define STDOUT_FILENO 0
#endif

main(argc,argv)
   int argc;
   char *argv[];
{
   int fd;
   char serial_dev[256];
   long baud;
   int two_stop;
   unsigned char buf[256];
   int rc;
   int cntr;

   printf("Enter ^c (control-c) or ^break to terminate program\n");
   setup_config(&baud,&two_stop,serial_dev);

   fd = init_comm(serial_dev,baud,two_stop);

   while(!terminate) {
      if ((rc = getchar_nonblock()) > 0) {
         buf[0] = rc | 0x80;
         ser_write(fd,(char *)buf,1);
         if (rc == '\n') {
            buf[0] = '\r' | 0x80;
            ser_write(fd,(char *)buf,1);
         }
      }
      if ((rc = ser_read(fd,(char *) buf,sizeof(buf))) < 0) {
         perror("\nstdin read failed\n");
         exit(1);
      }
      if (rc > 0) {
         for (cntr = 0; cntr < rc; cntr++)
             buf[cntr] &= 0x7f;
         write(STDOUT_FILENO, buf, rc);
      }
   }
   printf("Done\n");
   exit(0);
   return(0);
}
