//TODO: Test if the various convert to options actually work. Anything more
// useful to do with DB files. What is a DF file, 7222.t12?

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
#include <ctype.h>

#include "cgi-lib/cgi-lib.h"
#include "cgi-lib/html-lib.h"
#include "url_encode.h"

// Not really tied to GCC version but allows picking correct header on my system
#include <features.h>
#if __GNUC_PREREQ(4,8)
#include <db.h>
#else
#include <db4/db.h>
#endif

#include "types.h"
#include "os8.h"
#include "diskette.h"

#define ARRAYSIZE(x) (sizeof(x) / sizeof(x[0]))

typedef enum {TYPE_OS8_SV, TYPE_BIN, TYPE_IMAGE, TYPE_DUMP} BIN_TYPE;

#define IMAGE_ROOT "/images/"
struct {
   char *ext;
   char *desc;
   enum {EXT_SV, EXT_BIN, EXT_TEXT} type;
} ext_name[] =
{ 
   {".AS","Source file",EXT_TEXT},
   {".DB","Binary file",EXT_BIN},
   {".DF","Unknown file",EXT_BIN},
   {".SV","System file",EXT_SV}
};

char *imagepath;

int dir_date_offset = 0;
int dir_date = 99999;

static char err_url[200];

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
      fprintf(errlog, "%s\n%s: ", err_url, ts);
      va_start(ap, str);
      vfprintf(errlog, str, ap);
      va_end(ap);
      fclose(errlog);
   } 

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

void dump_image(FILE *out, int size, unsigned short *inbuf) {
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

int is_focal(UINT16 *awData) {
   if (awData[0] == 0 && awData[6] == 060 && (awData[10] >> 6) == 3) {
      return 1;
   } else
      return 0;
}

// Verify incrementing line numbers for text file
int is_COS_text(UINT16 *awData) {
   int cntr;
   int len;

   int last_line = 0;
   cntr = 0;
   do {
      len = 010001 - awData[cntr];
      if (last_line >= awData[cntr+1]) {
         return 0;
      } 
      last_line = awData[cntr+1];
      cntr = cntr + len;
   } while (cntr < OS8_BLOCK_SIZE);
   return 1;
}

// Can't really tell so just check extension
int is_bin(UINT16 *awData, char *tofn) {
   int len = strlen(tofn);

   if (tofn[len-1] == 'B' || tofn[len-1] == 'F') {
      return 1;
   }
   return 0;

}

int is_sv(UINT16 *awData)
{
//html_error(0, "word %o %o\n",awData[0], awData[1]);
   //64k if (((awData[0] & 03777) >= (03777 - 32)) && (awData[1] & 07707) == 06203)
   if ((awData[0] >= (07777 - 32)) && (awData[1] & 07707) == 06203)
      return 1;
   else
      return 0;
}

void do_bin(int start, int len, int print)
{
   UINT16 awData[OS8_BLOCK_SIZE];  UINT8 abData[OS8_BYTE_BLOCK_SIZE];
	int rubout, word, low, high, origin, csum, field, state, i;
	int new_field = 0, load_field = 0;
   int index = OS8_BYTE_BLOCK_SIZE;
   int open = 0, offset = 0;

	rubout = state = field = origin = csum = 0;
   while (1) { 
      if (++index >= OS8_BYTE_BLOCK_SIZE) {
         if (len-- == 0)
            break;
         ReadOS8Block(start++, awData);
         OS8BlockToBytes(awData, abData);
         index = 0;
      }

	i = abData[index];
//printf("i %o index %d word %o state %d<br>\n",i, index, word, state);
	// Rubout ignores to next rubout
	if (i == 0377) {
		rubout ^= 1;
		continue;
	}
	if (i > 0200) {
		new_field = (i & 070) << 9;
		continue;
	}
	switch (state) {
           case 0:                                   /* leader */
	      if ((i != 0) && (i != 0200)) state = 1;
	         high = i;                             /* save as high */
           break;
           case 1:                                    /* low byte */
              if (field != new_field)
                 load_field = 1;
              low = i;
              state = 2;
           break;
           case 2:                                         /* high with test */
              word = (high << 6) | low;
              if (i == 0200) {                        /* end of tape? */
                 if ((csum - word) & 07777) 
                     printf("<br>Checksum error calculated %o file %o\n",
                        csum, -word & 07777);
                 else {
                     if (open)
                        printf("%05o &nbsp;&nbsp;", (origin - offset) | field);
                     state = 0;
                     continue;
                 }
              }
              csum = csum + low + high;
              if (word >= 020000) {
                 if (open)
                    printf("%05o &nbsp;&nbsp;", (origin - offset) | field);
                 origin = word & 07777;
                 field = new_field;
                 printf("Common frame %05o-", origin | field);
                 open = 1;
                 offset = 0;
              } else
              if (word >= 010000) {
                 if (open)
                    printf("%05o &nbsp;&nbsp;", (origin - offset) | field);
                 origin = word & 07777;
                 field = new_field;
                 printf("%05o-", origin | field);
                 open = 1;
                 offset = 0;
              } else { 
                 if (load_field) {
                    field = new_field;
                 }
                 load_field = 0;
                 if ((field | origin) >= 0100000)
                    printf("<br>Binary file error, loads past end of memory<br>\n");
                 origin = (origin + 1) & 07777;
                 offset = 1;
              }
              high = i;
              state = 1;
           break;  
        }                               /* end switch */
    }                                               /* end while */
}

void dump_os8_sv_to_bin(char *infn, int start, int len)
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

void os8_info(char *tofn, int start, int len, int partition, char *infn,
     char *enc_fn) {
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
      tofn, enc_fn, start, len, partition);
   printf("<a href='%s?act=file;fn=%s;blk=%d,%d,%d;to=encode'>Convert</a> to <a href='/os/os8/kermit/kermit.shtml'>kermit</a> encoded image format.<br>\n",
      tofn, enc_fn, start, len, partition);
   printf("<a href='%s?act=file;fn=%s;blk=%d,%d,%d;to=ascii6'>Display</a> as COS text file.<br>\n",
      tofn, enc_fn, start, len, partition);
   printf("<a href='%s?act=file;fn=%s;blk=%d,%d,%d;to=octal'>Display</a> as 12 bit octal data.<br>\n",
      tofn, enc_fn, start, len, partition);

   if (is_sv(awData)) {
      //64k int num_segs = ((awData[0] | 07700) ^ 07777) + 1;
      int num_segs = (awData[0] ^ 07777) + 1;
      int tot_pages = 0;
      char *loc;
      char newfn[512];

      strcpy(newfn, tofn);
      loc = strstr(newfn,".SV");
      if (loc == NULL)
         loc = strstr(newfn,".DG");
      if (loc != NULL)
         strcpy(loc, ".BN"); 
      //printf("<a href='%s?act=file;fn=%s;blk=%d,%d,%d;to=sv_bin'>Convert</a> to <a href='/bin_image.shtml'>BIN loader format</a><br>\n", 
      printf("<a href='%s?act=file;fn=%s;blk=%d,%d,%d;to=sv_bin'>Convert</a> to BIN loader format<br>\n", 
         newfn, enc_fn, start, len, partition);
      printf("<br>This file is an OS/8 executable save file.<br>\n");
      printf("Start Address %04o in field %o. Job status word %04o <br>\n", 
          awData[2], ((awData[1] >> 3) & 07), awData[3]);
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
   if ((rc = is_bin(awData, tofn)) != 0) {
      if (rc == 2) {
         printf("<br>This file is an OS/8 fortran binary relocatable file.<br>\n");
      } else {
         printf("<br>This file is a COS binary file.<br>\n");
      }
   } else
   if (is_COS_text(awData)) {
      printf("<br>This file is a text file.<br>\n");
   } else {
      printf("<p>The file contents doesn't appear to match the known file formats<br>\n");
   }
   printf("<br>\n");

   include_file(stdout, "footer.shtml");
   html_end();
}

int bit5_char_cntr;
void send_char(char chr) {
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

void send_5bit(long long value, char flag) {
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

void dump_os8_image(char *infn, int start, int len)
{
   UINT16 awData[OS8_BLOCK_SIZE]; 

   mime_header("application/octet-stream", -1);
   while (len-- > 0)  { 
      ReadOS8Block(start++, awData);
      dump_image(stdout, ARRAYSIZE(awData), awData);
   }
}

void dump_os8_encode(char *infn, int start, int len)
{
   UINT16 awData[OS8_BLOCK_SIZE * 2]; 
   UINT16 tmp;
   int index = OS8_BLOCK_SIZE;
   int cntr;
   int num_dup;
   long long value;
   long long checksum = 0, checksum2;

   bit5_char_cntr = 0;

   mime_header("text/plain", -1);
   printf("(REMARK PDP-8/DECmate Encoded for Charles Lasner Kermit DECODE)\n");
   printf("(REMARK Image File Created on http://www.pdp8online.com)\n");
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
      while ((index + num_dup) < OS8_BLOCK_SIZE && tmp == awData[index + num_dup])
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
    COSDateToDMY(wCDT, &d, &m, &y);
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

typedef enum {SORT_NONE, SORT_NAME, SORT_EXT} SORT_TYPE;
/* DirOneFile */
/*   This procedure will print the directory information for a single   */
/* file specification, which may have wild cards.  It can print in      */
/* either full or brief mode, and will return the number of files found */
/* and the total number of blocks.                                      */
PRIVATE BOOLEAN DirOneFile
 (FILE *hOut, char *pszMask, BOOLEAN fBrief, UINT *pnFiles, UINT *pnBlocks,
   UINT *pnTotalFree, SORT_TYPE sort, char *enc_fn, DB *db, int index_mode)
{
  OS8_FIND_DATA FindData;  STRING szName;
  UINT nBlock; int nLength;  UINT16 wCDT;  BOOLEAN fMatch;
#define MAX_DIR 512
   struct dirent idir[MAX_DIR];
   int entry = 0;
   int cntr, cntr2;
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

  fprintf(hOut, "Name  Type  LN     Date\n\n");

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
       fprintf(hOut, "<a href='cos_html/%s?act=file;fn=%s;blk=%d,%d,%d;to=auto'>%s.%c</a>", 
          fullname, enc_fn, idir[cntr].start, idir[cntr].len, partition,
          idir[cntr].name, idir[cntr].ext[1]);
    } else {
       fprintf(hOut, "<a href='cos_html/%s?act=file;fn=%s;blk=%d,%d,%d;to=auto'>%-6s  %c</a>", 
          fullname, enc_fn, idir[cntr].start, idir[cntr].len, partition,
          idir[cntr].name, idir[cntr].ext[1]);
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
      fprintf(hOut, "  <a href='cos_html/%s?act=info;fn=%s;blk=%d,%d,%d'>More</a>", 
       fullname, enc_fn, idir[cntr].start, idir[cntr].len, partition);
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
            if (ext != NULL && 
                  (tmpname[0] == 'D' || tmpname[0] == 'E')
                  && (ext - fullname) == 4) {
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
                fprintf(hOut, "  <a href='/os/os8/os8_cmd.shtml#%s'>%s</a>",
                     (char *) key.data, (char *) data.data);
            else
            if (extra_len >= 1)
               fprintf(hOut, "  <a href='%s'>%s</a>", extra, (char *) data.data);
            else
               fprintf(hOut, "  %s",(char *) data.data);
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
    SORT_TYPE sort, char *infn, char *enc_fn, int index_mode)
{
  UINT nItem=0, nFiles=0, nBlocks=0;
  UINT nTotalFree;

  char chPartition;
  char *loc;
  char tmpstr[512];
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
  fprintf(hOut, "<p><b>This COS decoder was a quick modification of the OS/8 decoder. ");
  fprintf(hOut, "The various convert to format options have not been tested much.</b>");
  fprintf(hOut, "<p><a href='%s/%s'>Download this image %s</a>",
      imagepath, enc_fn, infn);
  {
     char new_str[512];
     char new_str2[512];
     char *loc = strrchr(enc_fn,'/');
     if (loc != NULL && strlen(loc) < sizeof(new_str)) {
        strcpy(new_str, loc+1);
        strcpy(new_str2, loc+1);
     }
     if (strstr(enc_fn,".linc") != NULL || strstr(enc_fn,".tu56") != NULL) {
        if (strlen(new_str) > 5)
           new_str[strlen(new_str) - 5] = 0;
        fprintf(hOut, "&nbsp;&nbsp;&nbsp;<a href='/images/convert_linc.shtml/%s?loc=%s'>Convert to disk image</a>", new_str, enc_fn);
        //}
     }
     fprintf(hOut, "<br>");
     if (strstr(enc_fn,".rk05") != NULL || strstr(enc_fn,".tu56") != NULL) {
        //fprintf(hOut, "&nbsp;&nbsp;&nbsp;<a href='/pdp8cgi/mac_convert/%s?fn=%s'>Download in Apple Mac emulator format</a>", new_str2, enc_fn);
        fprintf(hOut, "&nbsp;&nbsp;&nbsp;<a href='/images/convert_mac.shtml/%s?loc=%s'>Convert to Apple Mac emulator format</a>", new_str2, enc_fn);
     }
  }
  fprintf(hOut, "<br>");

  if (sort != SORT_NONE) { 
     fprintf(hOut, "<br><a href='cos_html?act=dir;fn=%s;sort=none'>Unsorted Directory Listing</a>", enc_fn);
  }
  if (sort != SORT_NAME) {
    fprintf(hOut, "<br><a href='cos_html?act=dir;fn=%s;sort=name'>Sort Directory Listing by file name</a>", enc_fn);
  }
  if (sort != SORT_EXT) {
    fprintf(hOut, "<br><a href='cos_html?act=dir;fn=%s;sort=ext'>Sort Directory Listing by file extension</a>", enc_fn);
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

   if ((rc = db->open(db, NULL, "/mnt/pdp/htdocs/images/filenames.db", NULL, DB_HASH, DB_RDONLY, 0666)) != 0) {
      //db->err(db, rc, "Open failed");
      html_error(0, "Unable to open filename database: %s\n", db_strerror(rc)); 
      exit(1);
   }


  for (part = 0; part < maxPart; part++) {
     nTotalFree = 0;
     nFiles = 0;
     nBlocks = 0;
     fprintf(hOut, "\n");
     SetPartition('A' + part);
     chPartition = GetPartition();
     if (chPartition != '\0')  
        fprintf(hOut, "<p>Disk partition %c\n", chPartition);
     fprintf(hOut, "<pre>\n");

#if 0
  UINT16 awData[OS8_BLOCK_SIZE];  UINT8 abData[OS8_BYTE_BLOCK_SIZE];
  STRING szLine;
  BOOLEAN fTruncated;
  int i,fEOF;
// Don't think this is valid for COS
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
           fEOF = !OS8BufferASCIIChar(hOut, abData[i], szLine, sizeof(szLine),
               &fTruncated);
        }
        OS8FlushASCIIChar(hOut, szLine);
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
#endif

     if (!DirOneFile(hOut, pszList, fBrief, &nFiles, &nBlocks, &nTotalFree,
           sort, enc_fn, db, index_mode)) {
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
  loc = strrchr(enc_fn, '/');
  if (loc != 0 && (strlen(tmpstr) + loc - enc_fn) < sizeof(tmpstr)) {
     strncat(tmpstr, enc_fn, loc - enc_fn);
     strcat(tmpstr, ".shtml");
     fprintf(hOut,"<p><a href='%s'>Back to images %s is from</a><br>\n",
         tmpstr,infn);
  }
  include_file(hOut, "footer.shtml");
  if (index_mode >= 3) 
     fprintf(hOut, "<!--/htdig_noindex-->\n");
  fprintf(hOut, "</body> </html>\n");

} /*DirFileList*/

void os8_file(char *tofn, int start, int len, int partition, char *to, char *infn,
     char *enc_fn, int ignore_early_eof, int plain, int index_mode) {
  UINT16 awData[OS8_BLOCK_SIZE];  UINT8 abData[OS8_BYTE_BLOCK_SIZE];

   if (strncmp(to, "auto", 4) == 0) {
      ReadOS8Block(start, awData);
      OS8BlockToBytes(awData, abData);
      if (is_COS_text(awData) && !is_sv(awData) && !is_bin(awData, tofn)) 
         os8_file(tofn, start, len, partition, "ascii6", infn, enc_fn, 0, plain,
            index_mode);
      else if (is_focal(awData) && !is_sv(awData) && !is_bin(awData, tofn)) 
         os8_file(tofn, start, len, partition, "focal", infn, enc_fn, 0, plain,
            index_mode);
      else 
         os8_info(tofn, start, len, partition, infn, enc_fn);
   } else
   if (strcmp(to, "ascii") == 0 || strcmp(to, "ascii6") == 0 ||
        strcmp(to, "focal") == 0 || strcmp(to, "octal") == 0) {
      int add_footer = 0;
      // char *user_agent, *referer, *host;
      FILE *outfile = stdout;

      //host = getenv("HTTP_HOST"); 
      //referer = getenv("HTTP_REFERER"); 
      //user_agent = getenv("HTTP_USER_AGENT"); 
      if (!plain) {
            //&& (host == NULL || referer == NULL || 
            //strstr(referer,"cgi-bin/htsearch") != NULL)) {
            // Any extra characters such as form feed make browser not display
            // so give up on this for now
            //strstr(referer,host) == NULL) || (user_agent != NULL &&
            //!(strncasecmp(user_agent, "mozilla",7) == 0 ||
            //         strncasecmp(user_agent, "opera",5) == 0)))) {
         char desc2[516];
         char *ext, *desc;
	 mime_header("text/html", -1);
         desc = lookup_ext(tofn, &ext);
         if (desc != NULL) {
            sprintf(desc2, "(%s)", desc);
            desc2[strlen(desc2)-2] = ')';
            desc2[strlen(desc2)-1] = 0;
         } else {
            desc2[0] = 0;
         }
	 printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>File %s %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> </head> <body>\n",tofn, desc2);
	 printf("<center>File %s %s</center><br>\n",tofn, desc2);
         if (index_mode >= 3) 
            printf("<!--htdig_noindex-->\n");
	 printf("<p><a href='../cos_html?act=dir;fn=%s;sort=name'>Directory of image this file is from</a><br>\n",enc_fn);
	 printf("<a href='../cos_html/%s?act=file;fn=%s;to=%s;blk=%d,%d,%d;plain=1'>This file as a plain text file</a><br>\n", tofn,
            enc_fn, to, start, len, partition);
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
      if (strcmp(to, "octal") == 0) 
         OS8ExtractOctalFile(start, len, outfile, ignore_early_eof);
      else if (strcmp(to, "focal") == 0) 
         OS8ExtractFocalFile(start, len, outfile);
      else
         OS8ExtractCOSFile(start, len, outfile);
      if (add_footer) {
         if (pclose(outfile) == -1)
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
            dir_date_offset = ((atoi(tok) - 1900 - COS_BASE_YEAR) / 8) * 8;
            dir_date = atoi(tok) - 1900;
            break;
         }
      }
   }
}

void url_enc(char *infn, char *outfn, int len)
{
   int cntr;
   int outcntr = 0;
   for (cntr = 0; cntr < strlen(infn) && outcntr < len - 4; cntr++) {
      if (isalnum(infn[cntr]) || strchr("_-./", infn[cntr]) != 0) {
         outfn[outcntr++] = infn[cntr];
      } else {
         sprintf(&outfn[outcntr],"%%%02x",infn[cntr]);
         outcntr += 3;
      }
   }
   outfn[outcntr] = 0;
}
#include <sys/resource.h>
int main(int argc, char **argv)
{
   LIST *head;
   char *action;
   char *infn;
   char enc_fn[256];
   int partition;

   char fullpath[512];
   char *query;

#define MAX_LCL_PATH 64
#if 0
   struct rlimit rnew;
   rnew.rlim_cur = 9999999999;
   rnew.rlim_max = 9999999999;
   setrlimit(RLIMIT_CORE, &rnew);
   system("/usr/bin/ulimit -c unlimited > /tmp/ulimitc.txt");
   system("/usr/bin/ulimit -a > /tmp/ulimit.txt");
   system("/usr/bin/ulimit -aH > /tmp/ulimith.txt");
#endif
   
   err_url[0] = 0;
   query = getenv("QUERY_STRING");
   if (query != NULL) {
      strncpy(err_url, query, sizeof(err_url));
      err_url[sizeof(err_url)-1] = 0;
   }
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
   url_enc(infn, enc_fn, sizeof(enc_fn));
   strcpy(fullpath, "/mnt/pdp/ftproot/");
   //imagepath = "http://www.pdp8online.com/ftp";
   imagepath = "/ftp";

   strcat(fullpath,infn);
   
   if (strcmp(action,"dir") == 0) {
      if (OpenDisk(TRUE, TRUE, AUTO_OS8, fullpath, TRUE)) {
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
/* Index mode 1 is normal, 
 * 2 is for search engines (removes spaces from file name
 * 3 is for htdig, removes spaces and directory date */
         referer = getenv("HTTP_REFERER"); 
         if (referer != NULL && strstr(referer, "cgi-bin/htsearch") != NULL) {
            index_mode = 1;
         } else {
            user_agent = getenv("HTTP_USER_AGENT"); 
            if (user_agent != NULL) {
               if (strncasecmp(user_agent, "htdig",5) == 0) {
                  index_mode = 3;
               } else 
               if (!(strncasecmp(user_agent, "mozilla",7) == 0 ||
                     strncasecmp(user_agent, "opera",5) == 0)) {
                  index_mode = 2;
               }
            }
         }
         if (index_mode == 1) {
            struct stat statbuf;
            FILE *outfile;
            int rc;
            char buf[2048];

            outfile = tmpfile();
            DirFileList(outfile, "*.*", FALSE, sort, infn, enc_fn, index_mode);
            fflush(outfile);
            fstat(fileno(outfile), &statbuf);
               /* Send proper content length */
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
            DirFileList(stdout, "*.*", FALSE, sort, infn, enc_fn, index_mode);
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
      if (OpenDisk(TRUE, TRUE, AUTO_OS8, fullpath, TRUE)) {
         SetPartition('A' + partition);
         os8_file(tofn, start, len, partition, to, infn, enc_fn, 1, plain != NULL,
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
      if (OpenDisk(TRUE, TRUE, AUTO_OS8, fullpath, TRUE)) {
         SetPartition('A' + partition);
         os8_info(tofn, start, len, partition, infn, enc_fn);
      } else {
         html_error(0,"OpenDisk %s failed: %s\n",infn, strerror(errno));
      }
   } else {
      html_error(0, "ERROR: illegal action %s\n",action);
   }
   return 0;
}
