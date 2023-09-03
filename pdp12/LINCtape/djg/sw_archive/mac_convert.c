#include <stdio.h>
#include <unistd.h>
#include <stdarg.h>
#include <time.h>
#include <sys/stat.h>


#include "cgi-lib/cgi-lib.h"
#include "cgi-lib/html-lib.h"

void html_error(int type, char *str, ...)
{
   va_list ap;
   FILE *errlog;

   mime_header("text/html", -1);
   html_begin("Error",NULL);

   va_start(ap, str);
   vprintf(str, ap);
   va_end(ap);
   errlog = fopen("/tmp/html_error","a");
   if (errlog != NULL) {
      time_t tt = time(NULL);
      char *ts = ctime(&tt);
      ts[strlen(ts)-1] = 0;
      fprintf(errlog, "%s: ", ts);
      vfprintf(errlog, str, ap);
      va_end(ap);
      fclose(errlog);
   }

   html_end();
   exit(1);
}


int main (void)
{
   unsigned        c1, c2, c3, c4;
   LIST *head;
   char *infn;
   FILE *infile;
   struct stat statbuf;
   int insize;
   int bytecnt = 0;

   char fullpath[256];
#define MAX_LCL_PATH 64

   head = cgi_input_parse();
   if (head == NULL)
      html_error(0, "ERROR: No action specified\n");
   infn = find_val(head, "loc");
   if (infn == NULL)
      html_error(0, "ERROR: No file specified\n");
   if (strstr(infn,"/../") != NULL || strlen(infn) > sizeof(fullpath) -
         MAX_LCL_PATH)
      html_error(0, "ERROR: Illegal file name %s\n",infn);
   strcpy(fullpath, "/mnt/pdp/ftproot/");
   strcat(fullpath,infn);


   infile = fopen(fullpath, "r");
   if (infile == NULL) {
      html_error(0, "ERROR: File not found %s\n",infn);
   }
   fstat(fileno(infile), &statbuf);
   if (statbuf.st_size % 129 == 0) {
      insize = 129;
   } else {
      insize = 128;
   }
   mime_header("application/octet-stream", statbuf.st_size * 128 /insize * 3 / 4);

   while (! feof(infile)) {
      c1 = getc(infile);
      c2 = getc(infile);
      c3 = getc(infile);
      c4 = getc(infile);
      if (feof(infile))
         continue;
      bytecnt += 4;
      // Drop 129th word of each block if DECtape
      if (insize == 129 && bytecnt == 256) {
         getc(infile);
         getc(infile);
         bytecnt = 0;
      }
      putchar (((c2 & 0x0f) << 4) | (c1 >> 4));
      putchar (((c1 & 0x0f) << 4) | c4);
      putchar (c3);
   }
   return (0);
}

