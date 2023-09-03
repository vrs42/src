#include <stdio.h>
#include <fcntl.h>
#include <termios.h>
#include <time.h>
#include <signal.h>
#include <unistd.h>
#include <memory.h>
#include <sys/ioctl.h>

int init_comm(char *);
char conv(int x)
{
printf(" in %d ",x);
   if (x <= 037) 
      x = x + 'A' - 1;
   else
      x =  x + '!' - 041;
printf(" out %d ",x);
return x;
}

main()
{
   int c,i;
   FILE *out;
   unsigned char buf[3];
   unsigned short temp[2];
   int rmaskfd,wmaskfd,emaskfd;   /* Select masks */
   int count,sect,byte;
   unsigned int chksum = 0;
   char fn[100];
   int block = 0;

   fprintf(stderr,"Enter file name\n");
   fgets(fn,sizeof(fn),stdin);
   fn[strlen(fn)-1] = 0;
   out = fopen(fn,"r");
   if (out < 0) {
      perror("Open failed on rk05");
      exit(1);
   }
   fprintf(stderr,"Enter first block\n");
   scanf("%d",&block);
   fprintf(stderr,"block %d\n",block);
   fseek(out,01000 * block,SEEK_SET);

           /* Clear masks for select */
   rmaskfd = 0;
   wmaskfd = 0;
   emaskfd = 0;
 
   count = 0;
   sect = 0;
   while(1) {
      if (fread(&temp,2,1,out) < 1) {
	 perror("Fread failed");
         exit(1);
      }
/*
      printf("%c%c",conv(temp[0] & 077),conv(temp[0] >> 6));
*/
      printf("%c%c",conv(temp[0] >> 6),conv(temp[0] & 077));
      printf(" %06o %d %d ",temp[0], conv(temp[0] >> 6),conv(temp[0] & 077));
      if (count++ == 31) {
         if (sect++ == 3) {
            printf("\nblk %d\n",++block);
            sect = 0;
         } else
            printf("\n");
         count = 0;
      }

   }
}

int init_comm(char *port)
{
   struct termios tios;              /* Serial port TERMIO structure */
   int port_fd;

   port_fd = open(port,O_RDWR,0);
   if (port_fd < 0) {
      fprintf (stderr,"fixmouse: Open failed on port '%s': ",port);
      perror("");
      exit(1);
   }

      /* Set to 8 bit 9600 baud no parity with no special processing */
   if (tcgetattr(port_fd,&tios) < 0) {
      perror("tcgetattr failed");
      exit(1);
   }
   tios.c_cflag = CS8 | CREAD | HUPCL | B9600 /*| PARENB | PARODD */;
   tios.c_iflag = 0;

      /* Mark parity errors (including break) */
/*
   tios.c_iflag = PARMRK | INPCK;
*/
   tios.c_lflag = 0;
   tios.c_oflag = 0;
   tios.c_cc[VMIN] = 0;
   tios.c_cc[VTIME] = 0;

   if (cfsetispeed(&tios,B9600) != 0)
      printf("fixmouse: set ispeed failed\n");
   if (cfsetospeed(&tios,B9600) != 0)
      printf("fixmouse: set ospeed failed\n");

   if (tcsetattr(port_fd,TCSANOW,&tios) < 0) {
      perror("fixmouse: tcsetattr failed");
      exit(1);
   }
   tcflush(port_fd,TCIOFLUSH);
   return(port_fd);
}
