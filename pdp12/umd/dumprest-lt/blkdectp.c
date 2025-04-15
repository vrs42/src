/* This program converts between the old 128 words/block DECtape images
   and the new 129 words/block DECtape image format.
   to run execute blkdectp infile outfile
   It will convert the infile to the opposite format and write to outfile.
*/
#ifdef PC
#include <io.h>
#else
#include <unistd.h>
#define O_BINARY 0
#endif
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>

main(int argc, char *argv[])
{
   int fdin,fdout;
   struct stat statbuf;
   unsigned short buf[129];
   int rc;
   int insize,outsize;

   if (argc != 3) {
      printf("Usage: %s infile outfile\n",argv[0]);
      exit(1);
   }
   fdin = open(argv[1],O_RDONLY | O_BINARY);
   if (fdin < 0) {
      perror("Unable to open input file");
      exit(1);
   }
   fdout = open(argv[2],O_WRONLY | O_CREAT | O_BINARY, 0666);
   if (fdout < 0) {
      perror("Unable to open output file");
      exit(1);
   }
   if (fstat(fdin, &statbuf) < 0) {
      perror("Unable to get size of input file");
      exit(1);
   }
   if (statbuf.st_size % (129*2) == 0) {
      insize = 129;
      outsize = 128;
   } else if (statbuf.st_size % (128*2) == 0) {
      insize = 128;
      outsize = 129;
   } else {
      printf("Input file is not a multiple of 128 or 129 words, can't convert\n");
      exit(1);
   }

   memset(buf, 0, sizeof(buf));
   do {
      rc = read(fdin, buf, insize*2);
      if (rc == insize*2) {
         if (write(fdout, buf, outsize*2) != outsize*2) {
            perror("Error writing to output file");
            exit(1);
         }
      } else if (rc < 0) {
         perror("Error reading input file");
         exit(1);
      } else if (rc != 0) {
         printf("Short read on input file %d\n",rc);
         exit(1);
      }
   } while (rc > 0);
}
