#include <stdio.h>
#include <fcntl.h>
#include <termios.h>
#include <time.h>
#include <signal.h>
#include <unistd.h>
#include <memory.h>
#include <sys/ioctl.h>

char conv(int x)
{
   if (x <= 037) 
      return x + 'A' - 1;
   else
      return x + '!' - 041;
}

main()
{
   int fd,c,i;
   int cntr;
   FILE *out;
   unsigned char buf[3];
   unsigned short temp[2];
   int rmaskfd,wmaskfd,emaskfd;   /* Select masks */
   int count,sect,byte;
   unsigned int chksum = 0;

   out = fopen("/tmp/t","r");
   if (out < 0) {
      perror("Open failed on rk05");
      exit(1);
   }
   fseek(out,01000 * 0,SEEK_SET);

           /* Clear masks for select */
   rmaskfd = 0;
   wmaskfd = 0;
   emaskfd = 0;
 
   count = 0;
   sect = 0;
   while(1) {
      if (fread(&temp,2,2,out) < 1) {
	 perror("Fread failed");
         exit(1);
      }
/*
      printf("%c%c",conv(temp[0] & 077),conv(temp[0] >> 6));
      printf("%c%c",conv(temp[0] >> 6),conv(temp[0] & 077));
         printf("%c%c%c",buf[0],buf[1],buf[2],3);
      buf[0] = temp[0];
      buf[1] = (temp[0] >> 8) | (temp[1] << 4);
      buf[2] = (temp[1] >> 4);
*/
      buf[0] = temp[0];
      buf[2] = (temp[1] >> 8) | ((temp[0] & 0xff00) >> 4);
      buf[1] = (temp[1]);
      for (cntr = 0; cntr < 3; cntr++) {
      buf[cntr] = buf[cntr] & 0x7f;
      if (buf[cntr] > 31 && buf[cntr] < 128) {
         printf("%c",buf[cntr] );
      if (count++ == 30) {
         printf("\n");
         count = 0;
     }
      }
      }


   }
}

