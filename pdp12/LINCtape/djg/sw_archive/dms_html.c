#include <stdio.h>
#include <fcntl.h>
#include <termios.h>
#include <time.h>
#include <signal.h>
#include <unistd.h>
#include <memory.h>
#include <sys/ioctl.h>
#include <stdarg.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

#include "cgi-lib/cgi-lib.h"
#include "cgi-lib/html-lib.h"
#include "url_encode.h"

#define ARRAYSIZE(x) (sizeof(x) / sizeof(x[0]))

#define IMAGE_ROOT "/images/"

typedef enum {TYPE_USR_SYS_TO_BIN, TYPE_BINARY, TYPE_IMAGE} BIN_TYPE;

// Size in bytes
#define BLK_SIZE 129 
int file_offset_words = 0; // DF32 doesn't use first word of disk
#define BLOCK_TO_FILE(x) ((x*BLK_SIZE + file_offset_words)*2)

#define DIR_FILE_NUM(x) (x & 077)
#define DIR_SYS_PROG(x) (x & 0100)
#define DIR_EXT_MEM_BITS(x) ((x >> 7) & 07)
#define DIR_FILE_TYPE(x) ((x >> 10) & 03)

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

void include_file(char *fn)
{
   FILE *in;
   char str[1024];

   in = fopen(fn,"r");
   if (in == NULL) 
      return;

   while (fgets(str, sizeof(str), in) != NULL) {
      printf("%s",str);
   }
   fclose(in);
}

char conv(int x) {
   return x + 32;
}

int conv2(int x)
{
   static int shift_flag = 0;
   if (shift_flag) {
      shift_flag = 0;
      return x;
   } else if (x == 077) {
      shift_flag = 1;
      return -1;
   } else {
      if (x <= 037) 
         return x + 'A' - 1;
      else
         return x;
      return x + 0100;
   }
}

void dump_binloader(FILE *in, int start, int low_core_addr, int entry_point,
   int field, FILE *out) {
   int cntr;
   unsigned char outbuf[3];
   unsigned short buf[BLK_SIZE];
   int block;

   mime_header("application/octet-stream", -1);
   block = start;
   while (block != 0) {
      if (fseek(in,BLOCK_TO_FILE(block),SEEK_SET) != 0)
         html_error(0, "file seek failed\n");
      if (fread(buf, BLK_SIZE*2, 1, in) != 1)
         html_error(0, "file read failed\n");
      for (cntr = 0; cntr < 128; cntr += 2) {
         outbuf[0] = buf[cntr];
         outbuf[1] = buf[cntr+1]; 
         outbuf[2] = ((buf[cntr+1] & 0xf00) >> 4) | (buf[cntr] >> 8);
         if (fwrite(outbuf, sizeof(outbuf), 1, out) < 1)
            html_error(0, "File write failed\n");
      }
      block = buf[BLK_SIZE-1];
   };
}

void dump_image(FILE *out, int size, unsigned short *inbuf) {

   if (fwrite(inbuf, size, 1, out) < 1)
      html_error(0, "File write failed\n");
}

void dump_dms_usr_sys_to_bin(FILE *in, int start, int low_core_addr, int entry_point,
   int field, FILE *out)
{
   int cntr;
   unsigned char leader[64];
   int chksum = 0;
   unsigned short core_addr[BLK_SIZE];
   unsigned short blk[BLK_SIZE];
   int origin;
   unsigned char buf[2];
   int block_count = 0;

   if (low_core_addr == 07777) { 
      if (fseek(in,BLOCK_TO_FILE(start),SEEK_SET) != 0)
         html_error(0, "file seek failed\n");
      if (fread(core_addr, BLK_SIZE*2, 1, in) != 1)
         html_error(0, "file read failed\n");
      start = core_addr[BLK_SIZE-1];
   }

   mime_header("application/octet-stream", -1);
   memset(leader, 0x80, sizeof(leader));
   fwrite(leader, 1, sizeof(leader), out);
   buf[0] = 0xc0 + (field << 3);
   fwrite(buf, 1, 1, out);

   while (start != 0) {
      if (low_core_addr == 07777) { 
         origin = core_addr[block_count++];
      } else {
         origin = low_core_addr;
         low_core_addr += 128;
      }
      buf[0] = 0x40 + (origin >> 6);   
      chksum += buf[0];
      buf[1] = (origin & 077);
      chksum += buf[1];
      fwrite(buf, 1, 2, out);
      if (fseek(in,BLOCK_TO_FILE(start),SEEK_SET) != 0)
         html_error(0, "file seek failed\n");
      if (fread(blk, BLK_SIZE*2, 1, in) != 1)
         html_error(0, "file read failed\n");

      for (cntr = 0; cntr < 128; cntr++) {
            buf[0] = blk[cntr] >> 6;
            chksum += buf[0];
            buf[1] = blk[cntr] & 077;
            chksum += buf[1];
            fwrite(buf, 1, 2, out);
      }

      start = blk[BLK_SIZE-1];
   };

   buf[0] = (chksum & 07777) >> 6;
   buf[1] = chksum & 077;
   fwrite(buf, 1, 2, out);
   fwrite(leader, 1, sizeof(leader), out);
}

void dump_dms_binary(FILE *in, int block, int low_core_addr, int entry_point,
   int field, BIN_TYPE type, FILE *out) {
   unsigned short buf[BLK_SIZE];

   if (type == TYPE_IMAGE) {
      mime_header("application/octet-stream", -1);
      while (block != 0) {
         if (fseek(in,BLOCK_TO_FILE(block),SEEK_SET) != 0)
            html_error(0, "file seek failed\n");
         if (fread(buf, BLK_SIZE*2, 1, in) != 1)
            html_error(0, "file read failed\n");
         dump_image(out, BLK_SIZE-1, buf);
         block = buf[BLK_SIZE-1];
      };
   } else if (type == TYPE_BINARY) {
      dump_binloader(in, block, low_core_addr, entry_point, field, out);
   } else if (type == TYPE_USR_SYS_TO_BIN) {
      dump_dms_usr_sys_to_bin(in, block, low_core_addr, entry_point, field, out);
   } else {
      html_error(0, "Unknown conversion type %d\n",type);
   }
}

void dump_dms_source(FILE *in, int block, FILE *out) {
   unsigned short temp;
   int cntr, cntr2;
   int ff_count = 0;
   int eof = 0;

//printf("Block %d\n",block);

   conv2(0); // Make sure shift isn't set
   while (block != 0 && !eof) {
      if (fseek(in,BLOCK_TO_FILE(block), SEEK_SET) != 0)
         html_error(0, "File seek failed\n");
      for (cntr = 0; cntr < 128; cntr++) {
         int chr;
         if (fread(&temp,1,2,in) < 2)
	    html_error(0, "File read failed\n");
         for (cntr2 = 0; cntr2 < 2 && !eof; cntr2++) {
            if (cntr2 == 0)
               chr = conv2(temp >> 6);
            else
               chr = conv2(temp & 077);
            if (chr != -1) {
               fprintf(out, "%c",chr);
               if (chr == '\f') {
                  if (++ff_count == 2) {
                     eof = 1;
                  }
               } else {
                  ff_count = 0;
               }
            }
         }
      }
      if (fread(&temp,1,2,in) < 2)
         html_error(0, "File read failed\n");
      block = temp;
   };
}

struct dirent {
   char fn[5];
   int low_core_addr;
   int entry_point;
   int flags;
   int first_block;
   int used;
};

int dms_dir_sort(const void *comp1,const void *comp2)
{
   const struct dirent *a = comp1;
   const struct dirent *b = comp2;
   return(strcmp(a->fn, b->fn));
}

void dms_dir(FILE *in, char *infn, char *enc_fn, int sort,int index_mode) {
   int cntr;
   int dirent;
   unsigned short dir[3][BLK_SIZE];
   unsigned short sam[BLK_SIZE*6 + 2];
#define MAX_DIR 64
   struct dirent idir[MAX_DIR];
   char encoded_fn[512];
   char tmpstr[512];
   char *loc;
   int fb;
   int blk, blk_num;
   int dirnum;
   int sam_size = 0;
   int dir_blk;

   memset(dir, 0, sizeof(dir));
   memset(sam, 0, sizeof(sam));
   blk_num = 0177;
   for (blk = 0; blk < 3 && blk_num != 0; blk++) { 
      if (fseek(in,BLOCK_TO_FILE(blk_num),SEEK_SET) != 0)
         html_error(0, "dir seek failed\n");
      if (fread(&dir[blk], BLK_SIZE*2, 1, in) != 1)
         html_error(0, "dir read failed\n");
      blk_num = dir[blk][BLK_SIZE-1];
   }
   // Get SAM block number
   blk_num = dir[0][2];
   // We discard link word when reading next block
   for (blk = 0; blk < 6 && blk_num != 0; blk++) {
      if (fseek(in,BLOCK_TO_FILE(blk_num),SEEK_SET) != 0)
         html_error(0, "sam seek failed\n");
      if (fread(&sam[blk*128], BLK_SIZE*2, 1, in) != 1)
         html_error(0, "sam read failed\n");
      sam_size += 128;
      blk_num = sam[blk*128+128];
   }

   mime_header("text/html", -1);
#if 0
// Dump block chains on disk
{ 
int found_block[512];
short buf[BLK_SIZE];
   memset(found_block, 0, sizeof(found_block));
   for (blk = 0; blk < 512; blk++) {
      if (found_block[blk]) {
         continue;
      }
      printf("blk %d: ",blk);
      blk_num = blk;
      do {
      if (fseek(in,BLOCK_TO_FILE(blk_num),SEEK_SET) != 0)
         html_error(0, "sam seek failed\n");
      if (fread(buf, BLK_SIZE*2, 1, in) != 1)
         html_error(0, "sam read failed\n");
      blk_num = buf[128];
      printf("%d",blk_num);
      if (blk_num < 512) {
         if (found_block[blk_num] & blk_num != 0)
            printf("*");
         found_block[blk_num] = 1;
      } else
         blk_num = 0;   
      printf(" ");
      } while (blk_num != 0);
      printf("<br>");
   }
}
#endif
   printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>Directory of %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> </head> <body>\n",infn);

   printf("<center>Directory of %s</center><br>\n",infn);
   if (index_mode >= 3)
      printf("<!--htdig_noindex-->\n");

   printf("This directory is in the format the Disk Monitor System operating\n");
   printf("The links below will return the file in\n");
   printf("various formats.\n");
   printf("<p>ASCII converts ASCII files to readable text\n");
   printf("<br>INFO gives information on executables with a choice of download formats.\n");
   printf("<br>BINLDR converts the file back to 8 bit binary loader format\n");
   printf("<br>IMAGE converts the file 12 bit words in two bytes\n");

   printf("<p><a href='/ftp/%s'>Download this image %s</a><br>",
      infn, infn);

   if (sort)
      printf("<p><a href='dms_html?act=dir;fn=%s;sort=none'>Unsorted Directory Listing</a>", infn);
   else
      printf("<p><a href='dms_html?act=dir;fn=%s;sort=name'>Sort Directory Listing</a>", infn);
   printf("<p><pre>\n");
   fb = 0;
   for (cntr = 0; cntr < sam_size; cntr++) {
      if ((sam[cntr] & 077) == 0)
         fb++;   
      if ((sam[cntr] >> 6) == 0)
         fb++;   
   }
   printf("FB=%04o\n\n",fb);
   printf("NAME  TYPE    BLK\n"); 
   printf("\n%c%c\n", conv((dir[0][1] >> 6)), conv(dir[0][1] & 077) );
   if (index_mode >= 3)
      printf("<!--/htdig_noindex-->\n");
   dirnum = 0;
   memset(idir, 0, sizeof(idir));
   for (dir_blk = 0; dir_blk < 3; dir_blk++) {
      for (dirent = 3; dirent < 25*5+3; dirent +=5) {
         for (cntr = 0; cntr < 2; cntr++) {
            idir[dirnum].fn[cntr*2] = conv(dir[dir_blk][dirent+cntr] >> 6);
            idir[dirnum].fn[cntr*2+1] = conv(dir[dir_blk][dirent+cntr] & 077);
         }
         idir[dirnum].fn[cntr*2] = 0;
         // Remove trailing spaces
         for (cntr = sizeof(idir[dirnum].fn)-2; cntr > 0; cntr--) {
            if (idir[dirnum].fn[cntr] == ' ')
               idir[dirnum].fn[cntr] = 0;
            else
               break;
         }
         idir[dirnum].low_core_addr = dir[dir_blk][dirent+2];
         idir[dirnum].entry_point = dir[dir_blk][dirent+3];
         idir[dirnum].flags = dir[dir_blk][dirent+4];
         if (DIR_FILE_NUM(idir[dirnum].flags) != 0) {
            idir[dirnum].used = 1;
            dirnum++;
         }
      }
   }
   if (sort) {
      qsort(idir, MAX_DIR, sizeof(idir[0]), dms_dir_sort);
   }
   for (dirent = 0; dirent < MAX_DIR; dirent++) {
      int blocks;
      int file_type;
      char *file_types[] = {"ASCII","BINARY","FTC BIN"};

      if (!idir[dirent].used)
         continue;
      if (index_mode >= 1)
          printf("<a name='%s'></a>",idir[dirent].fn);

      blocks = 0;
      for (cntr = 0; cntr < 256*6; cntr++) {
         int entnum;
         if (cntr & 128) 
            entnum = sam[(cntr & 0x7f) | ((cntr & 0xff00) >> 1)] >> 6;
         else
            entnum = sam[(cntr & 0x7f) | ((cntr & 0xff00) >> 1)] & 077;
         if (entnum == DIR_FILE_NUM(idir[dirent].flags)) {
            blocks++;   
            if (idir[dirent].first_block == 0) {
               idir[dirent].first_block = cntr;
            }
         }
      }

      file_type = DIR_FILE_TYPE(idir[dirent].flags);
      if (file_type < 3) {
         printf("%-4s.%-7s %04o ", idir[dirent].fn,
            file_types[file_type], blocks);
      } else {
         printf("%-4s.%-4s(%d) %04o ", idir[dirent].fn,
            DIR_SYS_PROG(idir[dirent].flags) ? "SYS":"USER", 
            DIR_EXT_MEM_BITS(idir[dirent].flags), blocks);
      }
      strcpy(encoded_fn, idir[dirent].fn);
      RFC1630Encode(encoded_fn, sizeof(encoded_fn), 1);
      if (file_type == 0) {
         printf("<a href='dms_html/%s?act=file;fn=%s;to=ascii;blk=%d,%d,%d,%d'>ASCII</a>  ", 
             encoded_fn, infn, 
             idir[dirent].first_block, idir[dirent].low_core_addr, 
             idir[dirent].entry_point, DIR_EXT_MEM_BITS(idir[dirent].flags));
      }
      if (file_type == 1) {
         printf("<a href='dms_html/%s?act=file;fn=%s;to=binary;blk=%d,%d,%d,%d'>BINLDR</a> ", 
             encoded_fn, infn, 
             idir[dirent].first_block, idir[dirent].low_core_addr, 
             idir[dirent].entry_point, DIR_EXT_MEM_BITS(idir[dirent].flags));
      }
         if (index_mode >= 3)
            printf("<!--htdig_noindex-->\n");
      if (file_type == 3) {
         printf("<a href='dms_html/%s?act=info;fn=%s;blk=%d,%d,%d,%d'>INFO</a>   ", 
             encoded_fn, infn, 
             idir[dirent].first_block, idir[dirent].low_core_addr, 
             idir[dirent].entry_point, DIR_EXT_MEM_BITS(idir[dirent].flags));
      }
         printf("<a href='dms_html/%s?act=file;fn=%s;to=image;blk=%d,%d,%d,%d'>IMAGE</a>  ", 
             encoded_fn, infn, 
             idir[dirent].first_block, idir[dirent].low_core_addr, 
             idir[dirent].entry_point, DIR_EXT_MEM_BITS(idir[dirent].flags));
      printf("\n");
      if (index_mode >= 3)
         printf("<!--/htdig_noindex-->\n");
   }
   printf("</pre>\n");
   if (index_mode >= 3)
      printf("<!--htdig_noindex-->\n");

   strcpy(tmpstr, IMAGE_ROOT);
   loc = strrchr(enc_fn, '/');
   if (loc != 0 && (strlen(tmpstr) + loc - enc_fn) < sizeof(tmpstr)) {
      strncat(tmpstr, enc_fn, loc - enc_fn);
      strcat(tmpstr, ".shtml");
      printf("<p><a href='%s'>Back to images %s is from</a><br>\n",
          tmpstr,infn);
   }

   include_file("footer.shtml");
   if (index_mode >= 3)
      printf("<!--/htdig_noindex-->\n");
   printf("</body> </html>\n");

}

void dms_info(FILE *in, char *tofn, int start, int low_core_addr, int entry_point, 
      int field, char *infn) {
   unsigned short core_addr[BLK_SIZE];
   unsigned short blk[BLK_SIZE];
   int block_count = 0;
   int block;
   int addr;

   mime_header("text/html", -1);
   printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>Information on file %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> <META NAME=\"robots\" CONTENT=\"noindex, nofollow\"></head> <body>\n",tofn);
   printf("<center>Information on file %s</center><br>\n",tofn);

   printf("Loads into field %d\n",field);
   if (entry_point == 0) 
      printf("<br>Program does not autostart\n");
   else
      printf("<br>Starting address %04o\n",entry_point);
   block = start;
   addr = low_core_addr;
   if (low_core_addr == 07777) { 
      if (fseek(in,BLOCK_TO_FILE(block),SEEK_SET) != 0)
         html_error(0, "file seek failed\n");
      if (fread(core_addr, BLK_SIZE*2, 1, in) != 1)
         html_error(0, "file read failed\n");
      block = core_addr[BLK_SIZE-1];
   }
   printf("<br>Memory blocks used:<br>\n");
   while (block != 0) {
      if (low_core_addr == 07777) { 
         printf("%04o ",core_addr[block_count++]);
      } else {
         printf("%04o ",addr);
         addr += 128;
      }
      if (fseek(in,BLOCK_TO_FILE(block),SEEK_SET) != 0)
         html_error(0, "file seek failed\n");
      if (fread(blk, BLK_SIZE*2, 1, in) != 1)
         html_error(0, "file read failed\n");
      block = blk[BLK_SIZE-1];
   };
   printf("<br>\n");
   printf("<a href='dms_html/%s?act=file;fn=%s;to=usr_sys_to_bin;blk=%d,%d,%d,%d'>Convert to BIN loader format</a> &nbsp;&nbsp;\n",
      tofn, infn, start, low_core_addr, entry_point, field);
   printf("<a href='dms_html/%s?act=file;fn=%s;to=ascii;blk=%d,%d,%d,%d'>Convert to ASCII (useful to see strings in executable).</a><br>\n",
      tofn, infn, start, low_core_addr, entry_point, field);

   include_file("footer.shtml");
   html_end();
}

void dms_file(FILE *in, char *tofn, int start, 
      int low_core_addr, int entry_point, int field,
      char *to, char *infn, int plain, int index_mode) {
   if (strcmp(to, "ascii") == 0) {
      int add_footer = 0;
      //char *host, *referer, *user_agent;
      FILE *outfile;
      
      //host = getenv("HTTP_HOST"); 
      //referer = getenv("HTTP_REFERER"); 
      //user_agent = getenv("HTTP_USER_AGENT");
      if (!plain) {
            // && ((host == NULL || referer == NULL ||
            // strstr(referer,"cgi-bin/htsearch") != NULL ||
            // strstr(referer,host) == NULL) || (user_agent != NULL &&
            // !(strncasecmp(user_agent, "mozilla",7) == 0 ||
            //    strncasecmp(user_agent, "opera",5) == 0)) )) {
	 mime_header("text/html", -1);
	 printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>file %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> </head> <body>\n",tofn);
	 printf("<center>File %s</center><br>\n",tofn);
         if (index_mode >= 3)
            printf("<!--htdig_noindex-->\n");
	 printf("<p><a href='../dms_html?act=dir;fn=%s;sort=name'>Directory of image this file is from</a><br>\n",infn);
         printf("<a href='../dms_html/%s?act=file;fn=%s;to=%s;blk=%d,%d,%d,%d;plain=1'>This file as a plain text file</a><br>\n", tofn,
            infn, to, start, low_core_addr, entry_point, field);
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
         outfile = stdout;
      }
      dump_dms_source(in, start, outfile);
      if (add_footer) {
         if (pclose(outfile) != 0)
            html_error(0, "pclose failed\n");
         printf("</pre>\n");
         if (index_mode >= 3)
            printf("<!--htdig_noindex-->\n");
         include_file("footer.shtml");
         if (index_mode >= 3)
            printf("<!--/htdig_noindex-->\n");
         html_end();
      }
   } else if (strcmp(to, "binary") == 0) {
      dump_dms_binary(in, start, low_core_addr, entry_point, field, 
         TYPE_BINARY, stdout);
   } else if (strcmp(to, "image") == 0) {
      dump_dms_binary(in, start, low_core_addr, entry_point, field, 
         TYPE_IMAGE, stdout);
   } else if (strcmp(to, "usr_sys_to_bin") == 0) {
      dump_dms_binary(in, start, low_core_addr, entry_point, field,
         TYPE_USR_SYS_TO_BIN, stdout);
   } else {
      html_error(0, "Unknown conversion %s\n",to);
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

int main(int argc, char **argv)
{
   FILE *in;
   LIST *head;
   char *action;
   char *infn;

   char fullpath[512];
   char enc_fn[256];
   int start, low_core_addr, entry_point, field;
   struct {
      unsigned short block_size;
      short first_block;
      short first_rev_block;
   } linc_info;
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
   if (argc == 2 && strcmp(argv[1],"lcl") == 0)
      strcpy(fullpath, "/mnt/data3/link/link/good/");
   else
      strcpy(fullpath, "/mnt/pdp/ftproot/");
   strcat(fullpath,infn);
   
   in = fopen(fullpath,"r");
   if (in == NULL) 
      html_error(0,"Open %s failed: %s\n",infn, strerror(errno));
   if (strstr(fullpath, "df32")) 
      file_offset_words = 1;
   if (strstr(fullpath, "linc")) {
      if (fseek(in, -sizeof(linc_info), SEEK_END) != 0)
         html_error(0, "file seek failed\n");
      if (fread(&linc_info,sizeof(linc_info),1,in) < 1)
          html_error(0, "file info read failed\n");
      file_offset_words = -linc_info.first_block * linc_info.block_size;
      if (linc_info.block_size == 256)
         file_offset_words += 2049;
   }

   if (strcmp(action,"dir") == 0) {
      char *sort;
      char *user_agent, *referer;
      int index_mode;

      sort = find_val(head, "sort");

      index_mode = 0;
      referer = getenv("HTTP_REFERER");
      if (referer != NULL && strstr(referer, "htsearch?") != NULL) {
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

      url_enc(infn, enc_fn, sizeof(enc_fn));

      dms_dir(in, infn, enc_fn, (sort != NULL && strcmp(sort,"name") == 0),
         index_mode);
   } else if (strcmp(action,"file") == 0) {
      char *blk, *to, *tofn;
      char *plain, *user_agent;
      int index_mode = 0;

      blk = find_val(head, "blk");
      if (blk == NULL) 
         html_error(0, "ERROR: No block specified on file\n");
      if (sscanf(blk, "%d,%d,%d,%d",&start,&low_core_addr,&entry_point,&field)
              != 4)
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
      dms_file(in, tofn, start, low_core_addr, entry_point, field,  to, infn,
         plain != NULL, index_mode);
   } else if (strcmp(action,"info") == 0) {
      char *blk,*tofn;

      blk = find_val(head, "blk");
      if (blk == NULL) 
         html_error(0, "ERROR: No block specified on file\n");
      if (sscanf(blk, "%d,%d,%d,%d",&start,&low_core_addr,&entry_point,&field)
              != 4)
         html_error(0, "ERROR: Illegal block (%s) specified on file\n", blk);
      tofn = getenv("PATH_INFO");
      if (tofn == NULL || strlen(tofn) < 2) 
         html_error(0, "ERROR: No extract file specified\n");
      tofn++; // Remove leading /
      dms_info(in, tofn, start, low_core_addr, entry_point, field, infn);
   } else {
      html_error(0, "ERROR: illegal action %s\n",action);
   }
   return 0;
}
