//Directory of image this file is from doesn't know correct date
#include <stdio.h>
#include <fcntl.h>
#include <termios.h>
#include <time.h>
#include <signal.h>
#include <unistd.h>
#include <memory.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <stdarg.h>
#include <errno.h>
#include <string.h>
#include <values.h>

#include "cgi-lib/cgi-lib.h"
#include "cgi-lib/html-lib.h"

#include <db3/db.h>

#include "types.h"
#include "os8.h"
#include "diskette.h"

#define ARRAYSIZE(x) (sizeof(x) / sizeof(x[0]))

typedef enum {TYPE_OS8_SV, TYPE_BIN, TYPE_IMAGE, TYPE_DUMP} BIN_TYPE;

#define IMAGE_ROOT "/images/"
struct {
   char *ext;
   char *desc;
   enum {EXT_SV, EXT_BIN, EXT_TEXT, EXT_TEXT6} type;
} ext_name[] =
{ 
   {".FT","Fortran source files",EXT_TEXT},
   {".FC","focal source files",EXT_TEXT},
   {".BA","BASIC source files",EXT_TEXT},
   {".30","OMSI 30 basic source files",EXT_TEXT6},
   {".TX","text files",EXT_TEXT},
   {".LS","listing files",EXT_TEXT},
   {".HL","help files",EXT_TEXT},
   {".BI","batch files",EXT_TEXT},
   {".MU","music files",EXT_TEXT},
   {".DC","file descriptions",EXT_TEXT},
   {".MP","load map files",EXT_TEXT},
   {".PA","PAL assembler source files",EXT_TEXT},
   {".MA","MACREL macro assembler source files",EXT_TEXT},
   {".SB","8k SABR macro assembler source files",EXT_TEXT},
   {".TE","<a href='/editors/teco/teco.shtml'>TECO</a> editor macro files",EXT_TEXT},
   {".DG","diagnostic Executables",EXT_SV},
   {".SV","save files (Executable program)",EXT_SV},
   {".HN","device handlers, install with set handler",EXT_BIN},
   {".BX","<a href='/os/os8/decx8.shtml'>DECX8</a> builder modules",EXT_BIN},
   {".X8","customized DECX8 system exercisers/diagnostics",EXT_SV},
   {".SY","system heads for building new disks",EXT_BIN},
   {".BN","binary files",EXT_BIN},
   {".RL","Fortran library or relocatable files",EXT_BIN}
};
   //char text_ext[] = {"PA", "LS", "MA", "DI", "DC", "HL", "FT", "BA", "BI", "MU", "TX"};

char *imagepath;

int dir_date_offset = 0;
int dir_date = 99999;

void html_error(int type, char *str, ...)
{
   va_list ap;
   FILE *errlog;

   mime_header("text/html", -1);
   html_begin("Error",NULL);

   va_start(ap, str);
   vprintf(str, ap);
   errlog = fopen("/tmp/html_error","a");
   if (errlog != NULL) {
      time_t tt = time(NULL);
      char *ts = ctime(&tt);
      ts[strlen(ts)-1] = 0;
      fprintf(errlog, "%s: ", ts);
      vfprintf(errlog, str, ap);
      fclose(errlog);
   } 
   va_end(ap);

   html_end();
   exit(1);
}

void include_file(FILE *out, char *fn)
{
   FILE *in;
   char str[1024];

   in = fopen(fn,"r");
   if (in == NULL) 
      return;

   while (fgets(str, sizeof(str), in) != NULL) {
      fprintf(out, "%s",str);
   }
   fclose(in);
}

dump_image(FILE *out, int size, unsigned short *inbuf) {
   int cntr;
   unsigned char outbuf[3];

   for (cntr = 0; cntr < size; cntr += 2) {
      outbuf[0] = inbuf[cntr];
      outbuf[1] = inbuf[cntr+1]; 
      outbuf[2] = ((inbuf[cntr] & 0xf00) >> 4) | (inbuf[cntr+1] >> 8);
      if (fwrite(&outbuf, sizeof(outbuf), 1, out) < 1)
         html_error(0, "File write failed\n");
   }
}

do_fort_lib(UINT16 *awData, int start, int len, int print)
{
   int cntr, cntr2, cntr3;
   int num_print = 0;
   int num_tot = 0;
   UINT16 awData2[OS8_BLOCK_SIZE];
   int found_space = 0;
   int not_lib = 0;
   char c[2];

   cntr = 0;
   while (len > 0) {
//printf("<br>cntr %d awData %d %d %d %d\n", cntr, awData[cntr*4], awData[cntr*4+1], awData[cntr*4+2], awData[cntr*4+3]);
      if (awData[cntr*4] == 0 && awData[cntr*4+3] == 0)
         break;
      found_space = 0;
      for (cntr2 = 0; cntr2 < 3; cntr2++) {
         WordToChars(awData[cntr*4 + cntr2],c[0],c[1]);
 //           printf("%c%c",c[0],c[1]);
         if (print) {
            printf("%c%c",c[0],c[1]);
            if (cntr2 == 2)
               printf("<br>\n");
         } else {
            for (cntr3 = 0; cntr3 < 2; cntr3++) {
//printf("c %d %c\n",c[cntr3],c[cntr3]);
               if (c[cntr3] == ' ' && cntr != 0) { // First entry has a space
                  found_space = 1;
               } else 
                  if (isalnum(c[cntr3]) || c[cntr3] == '#')
                     if (found_space) {
//printf("Not\n");
                        not_lib = 1;
                     } else
                        num_print++;
            }
//printf("Not %c:%c %d:%d\n",c1,c2, c1,c2);
            num_tot++;
         }
      }
      cntr++;
      if (cntr*4 >= OS8_BLOCK_SIZE) {
         awData = awData2; // Don't destroy input data
         if (--len > 0)
            ReadOS8Block(++start, awData);
         cntr = 0;
      }
   }
//printf("not %d num_print %d num_tot %d\n",not_lib,num_print,num_tot);
   if (!not_lib && ((float) num_print / num_tot) > .95 && num_tot > 15)
      return 1;
   else
      return 0;
}
int is_focal(UINT16 *awData) {
   if (awData[0] == 0 && awData[6] == 060 && (awData[10] >> 6) == 3) {
      return 1;
   } else
      return 0;
}

int is_6bit(UINT16 *awData) {
   int num_unprint = 0;
   int total = 0;
   int cntr,cntr2;
   int tmp;
   char c[2];

//mime_header("text/plain", -1);
   for (cntr = 0; cntr < OS8_BLOCK_SIZE; cntr++) {
      if ((awData[cntr] & 077) == 0 || (awData[cntr] >> 6) == 0)
         break;
//      WordToChars(awData[cntr],c[0],c[1]);
      c[0] = conv_6bit(awData[cntr] >> 6);
      c[1] = conv_6bit(awData[cntr] & 077);
      for (cntr2 = 0; cntr2 < 2; cntr2++) {
         tmp = c[cntr2];
         total++;
//printf("ch %d\n",tmp);
         if (!isalnum(tmp) && tmp != ' ' && tmp != '\n' && tmp != '\r' && tmp != '\t' && tmp != 95 && strchr("$()\";',=+-/*",tmp) == NULL) {
//printf("char %c %d\n",tmp,tmp);
            num_unprint++; 
         }
      }
   }
//printf("num %d tot %d\n",num_unprint, total);
   if ((float) num_unprint / total < .05 && total > 30)
      return 1;
   else
      return 0;
}

int is_ascii(UINT8 *abData, int size) {
   int num_unprint = 0;
   int cntr;
   int num_null = 0;
   int found_eof = 0;
   int num_unprint_before_eof = 0;
   int null_before_eof = 0;
   int char_before_eof = 0;

//	mime_header("text/plain", -1);
   for (cntr = 0; cntr < OS8_BYTE_BLOCK_SIZE; cntr++) {
      int tmp = abData[cntr] & 0x7f;
//if ((abData[cntr] & 0x7f) > 26)
//printf("char %d %c %d\n",(abData[cntr] & 0x7f), (abData[cntr] & 0x7f),cntr);
      if (!isprint(tmp) && tmp != '\n' && tmp != '\r' && tmp != '\t') {
//printf("***char %c %d\n", (abData[cntr] & 0x7f), (abData[cntr] & 0x7f));
         if (tmp == 26) {
            found_eof = 1;
            num_unprint_before_eof = num_unprint;
            null_before_eof = num_null;
            char_before_eof = cntr;
         } else
         if (tmp == 0)
            num_null++;
         else
            num_unprint++; 
      }
   }
   if (char_before_eof == 0) {
      num_unprint_before_eof = num_unprint;
      char_before_eof = cntr;
      null_before_eof = num_null;
   }
//printf("num unprint %d null before %d char_before  %d size %d\n", num_unprint_before_eof, null_before_eof, char_before_eof, size);
   if (num_unprint_before_eof > 15 || 
          (((float) null_before_eof / char_before_eof) > .4) || 
          char_before_eof <= (size > 1 ? 75 : 10))
      return 0;
   else
      return 1;
}

is_bin(UINT8 *abData) {
   int cntr;
   for (cntr = 0; cntr < 256; cntr++) {
      if (abData[cntr] != 0x80) {
           // Field
         if (cntr >= 64 && abData[cntr] >= 0300 && abData[cntr] <= 0370) 
            return 1;
           // Origin
         else if (cntr >= 64 && abData[cntr] >= 0100 && abData[cntr] <= 0177) 
            return 1;
           // Fortran common
         else if (cntr >= 64 && abData[cntr] >= 0240 && abData[cntr] <= 0257) 
            return 2;
         else
            return 0;
      }
   }
   return 0;
}

is_sv(UINT16 *awData)
{
//html_error(0, "word %o %o\n",awData[0], awData[1]);
   //64k if (((awData[0] & 03777) >= (03777 - 32)) && (awData[1] & 07707) == 06203)
   if ((awData[0] >= (07777 - 32)) && (awData[1] & 07707) == 06203)
      return 1;
   else
      return 0;
}

do_bin(int start, int len, int print)
{
   UINT16 awData[OS8_BLOCK_SIZE];  UINT8 abData[OS8_BYTE_BLOCK_SIZE];
	int rubout, word, low, high, origin, csum, field, state, i;
	int last_field = 99;
   int index = OS8_BYTE_BLOCK_SIZE;
   int open = 0;

	rubout = state = field = origin = csum = 0;
   while (1) { 
      if (index++ >= OS8_BYTE_BLOCK_SIZE) {
         if (len-- == 0)
            break;
         ReadOS8Block(start++, awData);
         OS8BlockToBytes(awData, abData);
         index = 0;
      }

		i = abData[index];
//printf("i %o\n",i);
		// Rubout ignores to next rubout
		if (i == 0377) {
			rubout ^= 1;
			continue;
		}
		if (i > 0200) {
			field = (i & 070) >> 3;
			continue;
		}
		switch (state) {
			case 0:                                         /* leader */
			  if ((i != 0) && (i != 0200)) state = 1;
				  high = i;                               /* save as high */
			break;
			case 1:                                         /* low byte */
				if (field != last_field) {
					last_field = field;
				}
				low = i;
				state = 2;
			break;
			case 2:                                         /* high with test */
				word = (high << 6) | low;
				if (i == 0200) {                        /* end of tape? */
					if ((csum - word) & 07777) 
                  printf("<br>Checksum error calculated %o file %o\n",
                      csum, -word & 07777);
				}
				csum = csum + low + high;
				if (word >= 020000) {
               if (open)
                  printf("%05o &nbsp;&nbsp;", origin | field);
					origin = word & 07777;
               printf("Common frame %05o-", origin | field);
               open = 1;
				} else
            if (word >= 010000) {
               if (open)
                  printf("%05o &nbsp;&nbsp;", origin | field);
					origin = word & 07777;
               printf("%05o-", origin | field);
               open = 1;
				} else { 
		 			if ((field | origin) >= 0100000)
                  printf("<br>Binary file error, loads past end of memory<br>\n");
					origin = (origin + 1) & 07777;
				}
				high = i;
				state = 1;
			break;  
		}                               /* end switch */
	}                                               /* end while */
}

dump_os8_sv_to_bin(char *infn, int start, int len)
{
   UINT16 awData[OS8_BLOCK_SIZE]; 
   UINT16 awData2[OS8_BLOCK_SIZE]; 
   int num_segs;
   int cntr,cntr2;
   unsigned char leader[64];
   unsigned char buf[512];
   int chksum = 0;

   memset(leader, 0x80, sizeof(leader));
   ReadOS8Block(start++, awData);
   num_segs = (awData[0] ^ 07777) + 1;
   mime_header("application/octet-stream", -1);
   fwrite(leader, 1, sizeof(leader), stdout);
   for (cntr = 0; cntr < num_segs; cntr++) {
      int pages = (awData[5+cntr*2] >> 6) & 0x1f;
      int origin = awData[4+cntr*2];
      int field = ((awData[5+cntr*2] >> 3) & 07);
      buf[0] = 0xc0 + (field << 3);
      buf[1] = 0x40 + (origin >> 6);   
      chksum += buf[1];
      buf[2] = (origin & 077);
      chksum += buf[2];
      fwrite(buf, 1, 3, stdout);
      while (pages > 0) {
         int len;

         ReadOS8Block(start++, awData2);
         if (pages == 1)
            len = 128;
         else
            len = 256;
         for (cntr2 = 0; cntr2 < len; cntr2++) {
            buf[0] = awData2[cntr2] >> 6;
            chksum += buf[0];
            buf[1] = awData2[cntr2] & 077;
            chksum += buf[1];
            fwrite(buf, 1, 2, stdout);
         }
         pages -= 2;
      }
   }
   buf[0] = (chksum & 07777) >> 6;
   buf[1] = chksum & 077;
   fwrite(buf, 1, 2, stdout);
   fwrite(leader, 1, sizeof(leader), stdout);
}


char *lookup_ext(char *tofn, char **outext)
{
   int cntr;
   char *ext = strrchr(tofn, '.');
   char *desc = NULL;

   if (ext != NULL) {
      for (cntr = 0; cntr < ARRAYSIZE(ext_name); cntr++) {
	 if (strcmp(ext, ext_name[cntr].ext) == 0) {
	    desc = ext_name[cntr].desc;
	    break; 
	 }
      }
   }
   *outext = ext;
   return desc;
}

os8_info(char *tofn, int start, int len, int partition, char *infn) {
  UINT16 awData[OS8_BLOCK_SIZE];  UINT8 abData[OS8_BYTE_BLOCK_SIZE];
  int cntr;
  int rc;
  char *ext;
  char *desc;

   mime_header("text/html", -1);
   printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>Information on file %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> <META NAME=\"robots\" CONTENT=\"noindex, nofollow\"></head> <body>\n",tofn);
   printf("<center>Information on file %s</center><br>\n",tofn);

   ReadOS8Block(start, awData);
   OS8BlockToBytes(awData, abData);

   desc = lookup_ext(tofn, &ext);
   if (desc) 
      printf("<br>The file extension %s is normally used for %s.<p>\n", 
            ext, desc);

   printf("<a href='%s?act=file;fn=%s;blk=%d,%d,%d;to=image'>Convert</a> to 8 bit <a href='/images/pip_image.shtml'>PIP image</a> format.<br>\n",
      tofn, infn, start, len, partition);
   printf("<a href='%s?act=file;fn=%s;blk=%d,%d,%d;to=encode'>Convert</a> to <a href='/os/os8/kermit/kermit.shtml'>kermit</a> encoded image format.<br>\n",
      tofn, infn, start, len, partition);
   printf("<a href='%s?act=file;fn=%s;blk=%d,%d,%d;to=ascii'>Display</a> PDP-8 8 bit packed characters as text.<br>\n",
      tofn, infn, start, len, partition);
   printf("<a href='%s?act=file;fn=%s;blk=%d,%d,%d;to=ascii6'>Display</a> PDP-8 6 bit characters as text.<br>\n",
      tofn, infn, start, len, partition);

   if (is_sv(awData)) {
      //64k int num_segs = ((awData[0] | 07700) ^ 07777) + 1;
      int num_segs = (awData[0] ^ 07777) + 1;
      int tot_pages = 0;
      char *loc;
      char newfn[32];

      strcpy(newfn, tofn);
      loc = strstr(newfn,".SV");
      if (loc == NULL)
         loc = strstr(newfn,".DG");
      if (loc != NULL)
         strcpy(loc, ".BN"); 
      //printf("<a href='%s?act=file;fn=%s;blk=%d,%d,%d;to=sv_bin'>Convert</a> to <a href='/bin_image.shtml'>BIN loader format</a><br>\n", 
      printf("<a href='%s?act=file;fn=%s;blk=%d,%d,%d;to=sv_bin'>Convert</a> to BIN loader format<br>\n", 
         newfn, infn, start, len, partition);
      printf("<br>This file is an OS/8 executable save file.<br>\n");
      printf("Start Address %04o in field %o.<br>\n", awData[2], 
          ((awData[1] >> 3) & 07));
      printf("Memory blocks used:<br>\n");
    
      for (cntr = 0; cntr < num_segs; cntr++) {
         int pages = (awData[5+cntr*2] >> 6) & 0x1f;
         int start = awData[4+cntr*2] + ((awData[5+cntr*2] << 9) & 070000);
         tot_pages += pages;
         if (pages & 1)
            tot_pages++;
         printf("%05o-%05o &nbsp;&nbsp;",start, start + pages * 128);
      }
      printf("<br>\n");
      tot_pages += 2; // Add header
      if (tot_pages != len * 2) {
         printf("File size does not match header, file %d 128 word pages, header %d<br>\n",len * 2, tot_pages);
      }
   } else 
   if ((rc = is_bin(abData)) != 0) {
      if (rc == 2) {
         printf("<br>This file is an OS/8 fortran binary relocatable file.<br>\n");
      } else {
         printf("<br>This file is an OS/8 binary loader file.<br>\n");
         printf("Loads into memory:<br>\n");
         do_bin(start, len, 1);
      }
   } else
   if (do_fort_lib(awData, start, len, 0)) {
      printf("This file is an OS/8 fortran library file.<br>\n");
      printf("Library contents:<br>\n");
      do_fort_lib(awData, start, len, 1);
   } else
   if (is_ascii(abData, len)) {
      printf("<br>This file is a text file.<br>\n");
   } else
   if (is_6bit(awData)) {
      printf("<br>This file is a 6 bit character text file.<br>\n");
   } else {
      printf("<p>The file contents don't appear to match the known file formats<br>\n");
   }
   printf("<br>\n");

   include_file(stdout, "footer.shtml");
   html_end();
}

int bit5_char_cntr;
send_char(char chr) {
   if (bit5_char_cntr == 0) {
      printf("<%c",chr);
      bit5_char_cntr++;
   }
   else if (bit5_char_cntr == 68) {
      printf("%c>\n",chr);
      bit5_char_cntr = 0;
   } else {
      printf("%c",chr);
      bit5_char_cntr++;
   }
}

send_5bit(long long value, char flag) {
   int count;
   char chr;

   if (flag == 'X') {
      send_char('X');
      value = value << 40;
      count = 4;
   } else 
      count = 12;
   while (count-- > 0) {
      chr = (value >> 55) & 0x1f;
      if (chr > 9)
         chr = chr + 'A' - 10; 
      else
         chr = chr + '0';
      send_char(chr);
      value <<= 5;
   }
}

dump_os8_image(char *infn, int start, int len)
{
   UINT16 awData[OS8_BLOCK_SIZE]; 

   mime_header("application/octet-stream", -1);
   while (len-- > 0)  { 
      ReadOS8Block(start++, awData);
      dump_image(stdout, ARRAYSIZE(awData), awData);
   }
}

dump_os8_encode(char *infn, int start, int len)
{
   UINT16 awData[OS8_BLOCK_SIZE * 2]; 
   UINT16 tmp;
   int index = OS8_BLOCK_SIZE;
   int cntr;
   int num_dup;
   long long value;
   int value_cntr = 0;
   long long checksum = 0, checksum2;

   bit5_char_cntr = 0;

   mime_header("text/plain", -1);
   printf("(REMARK PDP-8/DECmate Encoded for Charles Lasner Kermit DECODE)\n");
   printf("(REMARK Image File Created on http://www.pdp8.net)\n");
   printf("(FILE %s)\n", infn);
   while (1) { 
      if (index >= OS8_BLOCK_SIZE) {
         if (len-- == 0)
            break;
         ReadOS8Block(start++, awData);
         if (len > 0)
            ReadOS8Block(start, &awData[OS8_BLOCK_SIZE]);
         else 
            memset(&awData[OS8_BLOCK_SIZE], 0, OS8_BLOCK_SIZE * 2);
         index -= OS8_BLOCK_SIZE;
      }
      tmp = awData[index];
      num_dup = 0;
      while (index < OS8_BLOCK_SIZE && tmp == awData[index + num_dup])
         num_dup++;
      if (num_dup >= 3) {
         if (num_dup > 256)
            num_dup = 256;
         value = (tmp << 8) | (num_dup & 0xff);
         send_5bit(value, 'X');
         index += num_dup;
         checksum += tmp + num_dup * 16;
      } else {
         value = 0; 
         for (cntr = 0; cntr < 5; cntr++) {
            checksum += awData[index + cntr];
            value = (value << 12) | awData[index + cntr];
         }
         index += 5;
         send_5bit(value, 0);
      }
   }
   send_char('Z');
   checksum = -checksum;
   checksum2 = 0;
   for (cntr = 0; cntr < 5; cntr++)  {
      checksum2 = (checksum2 << 12) | (checksum & 07777);
      checksum = checksum >> 12;
   }
   send_5bit(checksum2, 0);
   if (bit5_char_cntr != 0)
      printf(">\n");
   printf("(END %s)\n(REMARK End of File)\n", infn);
}

/************************************************************************/
/****************   D I R E C T O R Y    C O M M A N D   ****************/
/************************************************************************/


/* WriteDate - Write OS/8 date to a file */
PRIVATE void WriteDate (FILE *f, UINT16 wCDT)
{
  static char *apszMonths[12] = {
    "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
    "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
  UINT d,m,y;
  if (wCDT == 0) {
    fprintf(f, " (none)  ");
  } else {
    OS8DateToDMY(wCDT, &d, &m, &y);
    y += dir_date_offset; 
    if (y > dir_date)
       y -= 8;
    fprintf(f, "%2d-%s-%2d", d, apszMonths[m-1], y);
  }
} /*WriteDate*/

struct dirent {
   char name[7];
   char ext[4];
   int start,len;
   int used;
   UINT16 wCDT;
};

int sort_name = 0;
int dir_sort(const void *comp1,const void *comp2)
{
   const struct dirent *a = comp1;
   const struct dirent *b = comp2;
   if (sort_name)
      return(strcmp(a->name, b->name));
   else
      return(strcmp(a->ext, b->ext));
}

char *lcase(char *in)
{
   char ret[256];
   int cntr = 0;

   for (cntr = 0; cntr < sizeof(ret) - 1 && in[cntr] != 0; cntr++) {
      ret[cntr] = tolower(in[cntr]);
   }
   ret[cntr] = 0;
}

typedef enum {SORT_NONE, SORT_NAME, SORT_EXT} SORT_TYPE;
/* DirOneFile */
/*   This procedure will print the directory information for a single   */
/* file specification, which may have wild cards.  It can print in      */
/* either full or brief mode, and will return the number of files found */
/* and the total number of blocks.                                      */
PRIVATE BOOLEAN DirOneFile
 (FILE *hOut, char *pszMask, BOOLEAN fBrief, UINT *pnFiles, UINT *pnBlocks,
   UINT *pnTotalFree, SORT_TYPE sort, char *infn, DB *db, int index_mode)
{
  OS8_FIND_DATA FindData;  STRING szName;
  UINT nBlock; int nLength;  UINT16 wCDT;  BOOLEAN fMatch;
#define MAX_DIR 512
   struct dirent idir[MAX_DIR];
   int entry = 0;
   int cntr, cntr2;
   int total_blocks;
   int partition;
   DBT key, data;
   int rc;
  char db_data[256];

  OS8FindFirst(&FindData);  fMatch = FALSE;

  memset(idir, 0, sizeof(idir));

  while (OS8FindNext(&FindData, szName, &nBlock, &nLength, &wCDT)) {
    char *ext;
    if (szName[0] == EOS) {
       *pnTotalFree += nLength;
       continue;
    }
    if (nLength == 0) {  // Ignore tentative files
       continue;
    }
    ext = strrchr(szName,'.');
    if (ext != NULL && (ext - szName) < sizeof(idir[entry].name)) {
       strncpy(idir[entry].name, szName, ext - szName);
       idir[entry].name[ext - szName] = 0;
    } 
    if (entry < MAX_DIR) {
       strcpy(idir[entry].ext, ext+1);
       idir[entry].start = nBlock;
       idir[entry].len = nLength;
       idir[entry].wCDT = wCDT;
       idir[entry].used = 1;
       entry++;
    } else {
       html_error(0, "Too many directry entries\n");
    }
  }
  //fprintf(hOut, "<br>\n");
  if (sort != SORT_NONE) { 
     sort_name = (sort == SORT_NAME);
     qsort(idir, MAX_DIR, sizeof(idir[0]), dir_sort);
  }

  fprintf(hOut, "Name  Ext Length   Date\n");

  partition = GetPartition();
  if (partition != 0)
     partition = (partition - 'A');

  memset(&key, 0, sizeof(key));
  memset(&data, 0, sizeof(data));
  data.data = db_data;
  data.ulen = sizeof(db_data);
  data.flags = DB_DBT_USERMEM;

  for (cntr = 0; cntr < MAX_DIR; cntr++) { 
    char fullname[32];
    if (!idir[cntr].used)
       continue;
    snprintf(fullname, sizeof(fullname), "%s.%s", idir[cntr].name, 
       idir[cntr].ext);
    RFC1630Encode(fullname, sizeof(fullname), 1);
    if (index_mode >= 1) 
       fprintf(hOut, "<a name='%s'></a>",fullname);
    if (index_mode > 1) {
       fprintf(hOut, "<a href='os8_html/%s?act=file;fn=%s;blk=%d,%d,%d;to=auto'>%s.%s</a>", 
          fullname, infn, idir[cntr].start, idir[cntr].len, partition,
          idir[cntr].name, idir[cntr].ext);
    } else {
       fprintf(hOut, "<a href='os8_html/%s?act=file;fn=%s;blk=%d,%d,%d;to=auto'>%-6s.%-3s</a>", 
          fullname, infn, idir[cntr].start, idir[cntr].len, partition,
          idir[cntr].name, idir[cntr].ext);
    }
    //fprintf(hOut, "%-6s%-3s", idir[cntr].name, idir[cntr].ext);
    if (fBrief) {
      fprintf(hOut, (*pnFiles % 5) == 0 ? "\n" : "    ");
    } else {
      if (index_mode >= 3) 
          fprintf(hOut, "<!--htdig_noindex-->\n");
      fprintf(hOut, "%5d   ", idir[cntr].len);
      WriteDate(hOut, idir[cntr].wCDT);
      //fprintf(hOut, "  (%04o)\n", nBlock);
      fprintf(hOut, "  <a href='os8_html/%s?act=info;fn=%s;blk=%d,%d,%d'>More</a>", 
       fullname, infn, idir[cntr].start, idir[cntr].len, partition);
      if (index_mode >= 3) 
          fprintf(hOut, "<!--/htdig_noindex-->\n");
      key.data = fullname;
      key.size = strlen(key.data);
      if ((rc = db->get(db, NULL, &key, &data, 0)) != 0) {
	 char tmpname[9];
	 if (strlen(fullname) == 9) {
	    strncpy(tmpname, fullname, 5);
	    strcpy(&tmpname[5], &fullname[6]);
	    key.data = tmpname;
	    key.size = strlen(key.data);
	    rc = db->get(db, NULL, &key, &data, 0);
         }
         if (rc != 0) {
            char *ext;
	    strcpy(tmpname, fullname);
            ext = strchr(tmpname, '.'); 
            if (ext != NULL) {
               *ext = 0;
	       key.data = tmpname;
	       key.size = strlen(key.data);
	       rc = db->get(db, NULL, &key, &data, 0);
            }
         }
         if (rc != 0) {
            char *add_pre[] = {"8E", "8I", "8"};
            char *ext;
            ext = strchr(fullname, '.'); 
            // If looks like old style diag try to find
            if (ext != NULL && tmpname[0] == 'D' && (ext - fullname) == 4) {
               for (cntr2 = 0; cntr2 < ARRAYSIZE(add_pre) && rc != 0; cntr2++) {
                  strcpy(tmpname, add_pre[cntr2]);
	          strcat(tmpname, fullname);
	          key.data = tmpname;
	          key.size = strlen(key.data);
	          rc = db->get(db, NULL, &key, &data, 0);
               }
            }
         }
      }
      if (rc == 0) {
         char *extra;
         char *ext;
         int extra_len;

         if (data.size < sizeof(db_data))
            ((char *)data.data)[data.size] = 0;
         else
            html_error(0, "Returned string too long\n");
         extra = strrchr(data.data, '^'); 
         if (extra != NULL) {
            *extra++ = 0;
            extra_len = strlen(extra);
            ext = strrchr(key.data, '.'); 
            if (ext != NULL)
               *ext++ = 0;
            if (extra_len >= 1 && extra[0] == '#') 
                fprintf(hOut, "  <a href='/os/os8/os8_cmd.shtml#%s'>%s</a>",key.data,
                     data.data);
            else
            if (extra_len >= 1)
               fprintf(hOut, "  <a href='%s'>%s</a>", extra, data.data);
            else
               fprintf(hOut, "  %s",data.data);
         }
         //db->err(db, rc, "get failed key %s", key.data);
         //exit(1);
      }
      fprintf(hOut, "\n");
    }
    ++*pnFiles;  *pnBlocks += idir[cntr].len;  fMatch = TRUE;
  }

  if (fBrief && ((*pnFiles % 5) != 0)) fprintf(hOut, "\n");

  return fMatch;
} /*DirOneFile*/


/* DirFileList */
/*   This procedure will handle the directory of a list of files.  It    */
/* splits the list up into individual files (which are handled by DirOne */
/* Spec) and maintains the total blocks and files found.                 */
PRIVATE void DirFileList (FILE *hOut, char *pszList, BOOLEAN fBrief, 
    SORT_TYPE sort, char *infn, int index_mode)
{
  UINT nItem=0, nFiles=0, nBlocks=0;  STRING szItem;
  UINT nTotalFree;

  char chPartition;
  char *loc;
  char tmpstr[128];
  int part,maxPart;
  DB *db;
  int rc;


  fprintf(hOut, "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>Directory of %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> </head> <body>\n",infn);
  fprintf(hOut, "<center>Directory of %s</center><br>\n",infn);
  if (index_mode >= 3) 
     fprintf(hOut, "<!--htdig_noindex-->\n");
  fprintf(hOut, "This directory is in the format the OS/8 operating\n");
  fprintf(hOut, "system uses.  OS/8 can only store dates for an 8 year period\n");
  fprintf(hOut, "so dates will be shown as 1970-1977 unless the media had\n");
  fprintf(hOut, "a printed directory or other information find the correct date range.\n");
  fprintf(hOut, "The length column is the number of 256-word blocks occupied by the file.\n");
  fprintf(hOut, "The descriptions of the file contents are not part of the image contents but are generated by the web display software.  They may not always be an accurate description of the file.\n");
  fprintf(hOut, "The links below will return the file in\n");
  fprintf(hOut, "various formats.\n");
  fprintf(hOut, "<p>Clicking the file name link will return source files in ASCII and\n");
  fprintf(hOut, "will give a choice of formats with more information on the file for binary files.\n");
  fprintf(hOut, "<br>Clicking the More link will give more information and \n");
  fprintf(hOut, "a choice of formats to return file in.\n");
  fprintf(hOut, "<p><a href='%s/%s'>Download this image %s</a>",
      imagepath, infn, infn);
  if (strstr(infn,".linc") != NULL || strstr(infn,".tu56") != NULL) {
     char new_str[100];
     char *loc = strrchr(infn,'/');
     if (loc != NULL && strlen(loc) < sizeof(new_str)) {
        strcpy(new_str, loc+1);
        new_str[strlen(new_str) - 5] = 0;
        //strcpy(new_str + strlen(new_str) - 4, "rktu");
        fprintf(hOut, "&nbsp;&nbsp;&nbsp;<a href='/images/convert_linc.shtml/%s?loc=%s'>Convert</a>", new_str, infn);
     }
  }
  fprintf(hOut, "<br>");

  if (sort != SORT_NONE) { 
     fprintf(hOut, "<br><a href='os8_html?act=dir;fn=%s;sort=none'>Unsorted Directory Listing</a>", infn);
  }
  if (sort != SORT_NAME) {
    fprintf(hOut, "<br><a href='os8_html?act=dir;fn=%s;sort=name'>Sort Directory Listing by file name</a>", infn);
  }
  if (sort != SORT_EXT) {
    fprintf(hOut, "<br><a href='os8_html?act=dir;fn=%s;sort=ext'>Sort Directory Listing by file extension</a>", infn);
  }
  if (index_mode >= 3) 
     fprintf(hOut, "<!--/htdig_noindex-->\n");

  if (SetPartition('A')) 
     maxPart = 2;
  else
     maxPart = 1;
   
   if ((rc = db_create(&db, NULL, 0)) != 0) {
      perror("db_create failed");
      exit(1);
   }

   if ((rc = db->open(db, "/mnt/pdp/htdocs/images/filenames.db", NULL, DB_HASH, DB_RDONLY, 0666)) != 0) {
      //db->err(db, rc, "Open failed");
      html_error(0, "Unable to open filename database: %s\n", db_strerror(rc)); 
      exit(1);
   }


  for (part = 0; part < maxPart; part++) {
  UINT16 awData[OS8_BLOCK_SIZE];  UINT8 abData[OS8_BYTE_BLOCK_SIZE];
  int i,fEOF,fTruncated;
  STRING szLine;
     nTotalFree = 0;
     nFiles = 0;
     nBlocks = 0;
     fprintf(hOut, "\n");
     SetPartition('A' + part);
     chPartition = GetPartition();
     if (chPartition != '\0')  
        fprintf(hOut, "<p>Disk partition %c\n", chPartition);
     fprintf(hOut, "<pre>\n");
#define IDBLOCK 6
#define IDSTART 192
#define IDLEN 128
     ReadOS8Block(IDBLOCK, awData);
#if 0
for (i = 0; i < 256; i++) {
   if ((i % 8) == 0)
      printf("<br> %d ",i);
   printf ("%04o ",awData[i]);
}
#endif
     if ((awData[0] == 00427 && awData[1] == 01203 && awData[2] == 07777) ||
         (awData[0] == 00011 && awData[1] == 00022 && awData[2] == 00033 &&
          awData[3] == 06437) ) {
        char *header_id[] = {
           "UNASSIGNED",
           "PS/8",
           "OS/8",
           "OS/12",
           "DECSYSTEM-8/78",
           "OS/78",
           "ETOS/8",
           "MULTI/8",
           "MULTOS/8"};
        int type;
        OS8BlockToBytes(awData, abData);
        if (awData[0] == 00427) {
	   for (i = 96;  i < 96+2;  i++) 
              if (isprint(abData[i] & 0x7f))
	         fprintf(hOut, "%c", abData[i] & 0x7f);
	   for (i = 99;  i < 99+2;  i++) 
              if (isprint(abData[i] & 0x7f))
	         fprintf(hOut, "%c", abData[i] & 0x7f);
	   fprintf(hOut, " VOLUME-- %d\n",awData[68]);
        }
        fEOF = 0;
        szLine[0] = 0;
        for (i = IDSTART;  (i < IDSTART+IDLEN) && !fEOF;  ++i) {
           fEOF = !BufferASCIIChar(hOut, abData[i], szLine, sizeof(szLine),
               &fTruncated);
        }
        FlushASCIIChar(hOut, szLine);
        if (awData[0] == 00427) {
	   type = 010000 - awData[69];
	   if (type >= ARRAYSIZE(header_id)) 
	      type = 0;
	   if (awData[70] != 0) {
	      fprintf(hOut, "%s SYSTEM VERSION %d%c\n\n", header_id[type],
                awData[70], awData[71] + 'A' - 1);
           }
        }
     }

     if (!DirOneFile(hOut, pszList, fBrief, &nFiles, &nBlocks, &nTotalFree,
           sort, infn, db, index_mode)) {
     //  html_error(0, "no files found to match %s", pszList);
       ++nItem;
     }
     fprintf(hOut,"\n %d Files in %d Blocks - %d Free blocks\n", 
        nFiles, nBlocks, nTotalFree);
     fprintf(hOut, "</pre>\n");
  }
  if (index_mode >= 3) 
     fprintf(hOut, "<!--htdig_noindex-->\n");

  db->close(db, 0);

  strcpy(tmpstr, IMAGE_ROOT);
  loc = strrchr(infn, '/');
  if (loc != 0 && (strlen(tmpstr) + loc - infn) < sizeof(tmpstr)) {
     strncat(tmpstr, infn, loc - infn);
     strcat(tmpstr, ".shtml");
     fprintf(hOut,"<p><a href='%s'>Images this file %s is from</a><br>\n",
         tmpstr,infn);
  }
  include_file(hOut, "footer.shtml");
  if (index_mode >= 3) 
     fprintf(hOut, "<!--/htdig_noindex-->\n");
  fprintf(hOut, "</body> </html>\n");

} /*DirFileList*/

os8_file(char *tofn, int start, int len, int partition, char *to, char *infn,
     int ignore_early_eof, int plain, int index_mode) {
  UINT16 awData[OS8_BLOCK_SIZE];  UINT8 abData[OS8_BYTE_BLOCK_SIZE];
  int cntr;

   if (strcmp(to, "auto") == 0) {
      ReadOS8Block(start, awData);
      OS8BlockToBytes(awData, abData);
      if (is_ascii(abData, len)) 
         os8_file(tofn, start, len, partition, "ascii", infn, 0, plain, 
            index_mode);
      else 
      if (is_6bit(awData) && !is_sv(awData) && !is_bin(abData)) 
         os8_file(tofn, start, len, partition, "ascii6", infn, 0, plain,
            index_mode);
      else if (is_focal(awData) && !is_sv(awData) && !is_bin(abData)) 
         os8_file(tofn, start, len, partition, "focal", infn, 0, plain,
            index_mode);
      else 
         os8_info(tofn, start, len, partition, infn);
   } else
   if (strcmp(to, "ascii") == 0 || strcmp(to, "ascii6") == 0 ||
        strcmp(to, "focal") == 0) {
      int add_footer = 0;
      char *host, *referer, *user_agent;
      int inpipe[2];
      FILE *outfile = stdout;
      int pid;

      host = getenv("HTTP_HOST"); 
      referer = getenv("HTTP_REFERER"); 
      user_agent = getenv("HTTP_USER_AGENT"); 
#if 0
      if (!plain && (host != NULL && referer != NULL && 
            strstr(referer,"cgi-bin/htsearch") == NULL &&
            strstr(referer,host) != NULL) && (user_agent != NULL &&
            (strncasecmp(user_agent, "mozilla",7) == 0 ||
            strncasecmp(user_agent, "opera",5) == 0)) ) {
#endif
      if (!plain && (referer == NULL ||
            strstr(referer,"cgi-bin/htsearch") == NULL) ) {
	 mime_header("text/html", -1);
	 printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>file %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> </head> <body>\n",tofn);
	 printf("<center>File %s</center><br>\n",tofn);
         if (index_mode >= 3) 
            printf("<!--htdig_noindex-->\n");
	 printf("<p><a href='../os8_html?act=dir;fn=%s;sort=name'>Directory of image this file is from</a><br>\n",infn);
	 printf("<a href='../os8_html/%s?act=file;fn=%s;to=%s;blk=%d,%d,%d;plain=1'>This file as a plain text file</a><br>\n", tofn,
            infn, to, start, len, partition);
         if (index_mode >= 3) 
            printf("<!--/htdig_noindex-->\n");
         printf("<pre>\n");
         add_footer = 1;
         fflush(stdout);
         outfile = popen("/bin/sed -e 's/&/\\&amp;/g' -e 's/</\\&lt;/g'  -e 's/>/\\&gt;/g' -e 's//<HR WIDTH=\"100%\">/'", "w");
         if (outfile == NULL)
            html_error(0, "Sed popen failed\n");
      } else {
	 mime_header("text/plain", -1);
      }
      if (strcmp(to, "ascii6") == 0) 
         ExtractASCII6File(start, len, outfile, ignore_early_eof);
      else if (strcmp(to, "focal") == 0) 
         ExtractFocalFile(start, len, outfile);
      else
         ExtractASCIIFile(start, len, outfile, ignore_early_eof);
      if (add_footer) {
         if (pclose(outfile) != 0)
            html_error(0, "pclose failed\n");
         printf("</pre>\n");
         if (index_mode >= 3) 
            printf("<!--htdig_noindex-->\n");
         include_file(stdout, "footer.shtml");
         if (index_mode >= 3) 
            printf("<!--/htdig_noindex-->\n");
         printf("</body> </html>\n");
      }
   } else if (strcmp(to, "image") == 0) {
      dump_os8_image(tofn, start, len);
   } else if (strcmp(to, "encode") == 0) {
      dump_os8_encode(tofn, start, len);
   } else if (strcmp(to, "sv_bin") == 0) {
      dump_os8_sv_to_bin(tofn, start, len);
   } else {
      html_error(0, "Unknown conversion %s\n",to);
   }
}

void find_dir_date(char *image) {
   FILE *in;
   char str[100];
   char *tok;

//mime_header("text/plain", -1);
   in = fopen("imagedates.txt","r");
   if (in != NULL) {
      while (fgets(str, sizeof(str), in) != NULL) {
         tok = strtok(str, " \n");
//printf("tok %s image %s\n",tok,image);
         if (tok != NULL && strcmp(tok, image) == 0) {
            tok = strtok(NULL, " \n");
            dir_date_offset = ((atoi(tok) - 1900 - OS8_BASE_YEAR) / 8) * 8;
            dir_date = atoi(tok) - 1900;
            break;
         }
      }
   }
}

main(int argc, char **argv)
{
   LIST *head;
   char *action;
   char *infn;
   int partition;

   char fullpath[256];
#define MAX_LCL_PATH 64
   
   head = cgi_input_parse();
   if (head == NULL) 
      html_error(0, "ERROR: No action specified\n");
   action = find_val(head, "act");
   if (action == NULL) 
      html_error(0, "ERROR: No action specified\n");
   infn = find_val(head, "fn");
   if (infn == NULL) 
      html_error(0, "ERROR: No file specified\n");
   if (strstr(infn,"/../") != NULL || strlen(infn) > sizeof(fullpath) - 
         MAX_LCL_PATH) 
      html_error(0, "ERROR: Illegal file name %s\n",infn);
   strcpy(fullpath, "/mnt/pdp/ftproot/");
   imagepath = "http://www.pdp8.net/ftp";

   strcat(fullpath,infn);
   
   if (strcmp(action,"dir") == 0) {
      if (OpenDisk(TRUE, TRUE, AUTO_OS8, fullpath)) {
         char *str;
         SORT_TYPE sort;
         char *user_agent, *referer;
         int index_mode;

         str = find_val(head, "sort");
         sort = SORT_NONE;
         if (str != NULL && strcmp(str,"none") != 0) {
            if (strcmp(str,"name") == 0) {
               sort = SORT_NAME;
            } else {
               sort = SORT_EXT;
            }
         }
         find_dir_date(infn);
         index_mode = 0;
         referer = getenv("HTTP_REFERER"); 
         if (referer != NULL && strstr(referer, "cgi-bin/htsearch") != NULL) {
            index_mode = 1;
         } else {
            user_agent = getenv("HTTP_USER_AGENT"); 
            if (user_agent != NULL)
               if (strncasecmp(user_agent, "htdig",5) == 0)
                  index_mode = 3;
               else
               if (strncasecmp(user_agent, "mozilla",7) != 0 &&
                     strncasecmp(user_agent, "opera",5) != 0)
                  index_mode = 2;
         }
         if (index_mode == 1) {
            struct stat statbuf;
            FILE *outfile;
            int rc;
            char buf[2048];

            outfile = tmpfile();
            DirFileList(outfile, "*.*", FALSE, sort, infn, index_mode);
            fflush(outfile);
            fstat(fileno(outfile), &statbuf);
            mime_header("text/html", statbuf.st_size);
            if (fseek(outfile, 0, SEEK_SET) != 0)
               html_error(0, "dir fseek failed\n");
            while (!feof(outfile)) {
               rc = fread(buf, 1, sizeof(buf), outfile);
               if (rc > 0)
                  fwrite(buf, 1, rc, stdout);
            }
            fclose(outfile);
         } else {
            mime_header("text/html", -1);
            DirFileList(stdout, "*.*", FALSE, sort, infn, index_mode);
         }
	 CloseDisk();
      } else {
         html_error(0,"OpenDisk %s failed: %s\n",infn, strerror(errno));
      }
   } else if (strcmp(action,"file") == 0) {
      int start,len;
      char *blk, *to, *tofn;
      char *plain, *user_agent;
      int index_mode = 0;

      blk = find_val(head, "blk");
      if (blk == NULL) 
         html_error(0, "ERROR: No block specified on file\n");
      if (sscanf(blk, "%d,%d,%d",&start, &len, &partition) != 3)
         html_error(0, "ERROR: Illegal block (%s) specified on file\n", blk);
      to = find_val(head, "to");
      if (to == NULL) 
         html_error(0, "ERROR: No conversion specified on file\n");
      tofn = getenv("PATH_INFO");
      if (tofn == NULL || strlen(tofn) < 2) 
         html_error(0, "ERROR: No extract file specified\n");
      tofn++; // Remove leading /
      plain = find_val(head, "plain");
      user_agent = getenv("HTTP_USER_AGENT"); 
      if (user_agent != NULL && strncasecmp(user_agent, "htdig",5) == 0)
         index_mode = 3;
      if (OpenDisk(TRUE, TRUE, AUTO_OS8, fullpath)) {
         SetPartition('A' + partition);
         os8_file(tofn, start, len, partition, to, infn, 1, plain != NULL,
              index_mode);
      } else {
         html_error(0,"OpenDisk %s failed: %s\n",infn, strerror(errno));
      }
   } else if (strcmp(action,"info") == 0) {
      int start,len;
      char *blk,*tofn;

      blk = find_val(head, "blk");
      if (blk == NULL) 
         html_error(0, "ERROR: No block specified on file\n");
      if (sscanf(blk, "%d,%d,%d",&start, &len, &partition) != 3)
         html_error(0, "ERROR: Illegal block (%s) specified on file\n", blk);
      tofn = getenv("PATH_INFO");
      if (tofn == NULL || strlen(tofn) < 2) 
         html_error(0, "ERROR: No extract file specified\n");
      tofn++; // Remove leading /
      if (OpenDisk(TRUE, TRUE, AUTO_OS8, fullpath)) {
         SetPartition('A' + partition);
         os8_info(tofn, start, len, partition, infn);
      } else {
         html_error(0,"OpenDisk %s failed: %s\n",infn, strerror(errno));
      }
   } else {
      html_error(0, "ERROR: illegal action %s\n",action);
   }
}
