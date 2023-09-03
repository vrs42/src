// Should store the page info in dir to remove duplicate code

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
#include <stdint.h>

#include "cgi-lib/cgi-lib.h"
#include "cgi-lib/html-lib.h"
#include "url_encode.h"

#define ARRAYSIZE(x) (sizeof(x) / sizeof(x[0]))

#define IMAGE_ROOT "/images/"

typedef enum {TYPE_BIN, TYPE_IMAGE, TYPE_TSS_ASCII6, TYPE_ASCII6, 
   TYPE_TSS_BASIC6, TYPE_OCTAL, TYPE_TSS_PACKED, TYPE_OS8_PACKED} BIN_TYPE;

// Size in words
#define BLK_SIZE 129 
#define BLOCK_TO_FILE(x) (((x)*BLK_SIZE + file_offset_words)*2)
// Currently unused
int file_offset_words = 0;


// First block of directory
#define DIR_BLOCK 127

#define MAX_DIR 64
struct dirent {
   char fn[7]; // 6 + zero term
   int ext;
   int date;
   int dir_fileno;
   int fileno;
   int flags;
   int orig_entry;
   int used;
   int num_blocks;
   // All blocks used. Not necessarly in order in file
   uint16_t blocks[1470];
};

void tss_info(FILE *in, char *tofn, struct dirent *dir, char *infn);

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

char OS8Conv6bit(int x)
{
   // TSS/8 doesn't convert 047 to tab
   if (x == 037)
      return '\n';
   if (x == 043)
      return '\r';
   if (x <= 037)
      return x + 'A' - 1;
   else
      return x;
}


char conv_tss_6bit(int x)
{
   if (x == 077) {
      return '\n';
   } else {
      return x+32;
   }
}

/* OS8BlockToBytes */
/*   This procedure will convert a block of 128 12 bit words into */
/* 192 8 bit bytes.  This unpacking is done by the standard OS/8 */
/* convention for word to byte translations. */
void OS8BlockToBytes (uint16_t *pw, uint8_t *pb)
{
  int i;
  for (i = 0;  i < 128;  ++i) {
    pb[3*i  ] = (pw[2*i  ] & 0xff);
    pb[3*i+1] = (pw[2*i+1] & 0xff);
    pb[3*i+2] = (((pw[2*i] >> 4) & 0xf0) | ((pw[2*i+1] >> 8) & 0x0f));
  }
} /*OS8BlockToBytes*/

/* TSS8BlockToBytes */
/*   This procedure will convert a block of 128 12 bit words into */
/* 192 8 bit bytes.  This unpacking is done by the standard TSS/8 */
/* convention for word to byte translations. */
void TSS8BlockToBytes (uint16_t *pw, uint8_t *pb)
{
  int i;
  for (i = 0;  i < 128;  ++i) {
    pb[3*i  ] = (pw[2*i  ] >> 4);
    pb[3*i+1] = (((pw[2*i] & 0xf) << 4) | ((pw[2*i+1] >> 8) & 0x0f));
    pb[3*i+2] = (pw[2*i+1] & 0xff);
  }
} /*TSS8BlockToBytes*/


char *get_ext(int flags) {
   static char *ext[] = {
      "",     ".ASC", ".ASC", ".ASC",   ".SAV", ".SAV", ".BIN", ".BIN",
      ".BAS", ".BAS", ".BAC", ".BAC",   ".FCL", ".FCL", ".TMP", ".TMP",
      "",     "",     ".DAT", ".DAT",   ".LST", ".LST", ".PAL", ".PAL",
      "",     "",     "",     "",       "",     "",     "",     "",

      "",     "",     "",     "",       "",     "",     "",     "",
      "",     "",     "",     "",       "",     "",     "",     "",
      "",     "",     "",     "",       "",     "",     "",     "",
      "",     "",     "",     "",       "",     "",     "",     ""};
   return ext[flags & 077];
}

char *conv_date(int d) {
   static char dstr[32];
   char *monthstr[] = 
      {"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
   int year, month, day;

   if (d == 0) {
      dstr[0] = 0;
   } else {
      year = d / 372;
      month = (d - year * 372) / 31;
      day = d % 31;
      snprintf(dstr, sizeof(dstr), "%02d-%s-%02d", day + 1, monthstr[month],
          year + 74);
   }

   return dstr;
}

int search_blocks(int value, struct dirent *dir) {
   int cntr;

   for (cntr = 0; cntr < dir->num_blocks; cntr++) {
      if (dir->blocks[cntr] == value) {
         return cntr;
      }
   }
   return -1;
}

int dump_bin_block(int page, uint16_t blk[], int words, int chksum, FILE *out) {
   int origin = page << 7;
   unsigned char buf[2];
   int cntr;

   buf[0] = 0x40 + (origin >> 6);   
   chksum += buf[0];
   buf[1] = (origin & 077);
   chksum += buf[1];
   fwrite(buf, 1, 2, out);

   for (cntr = 0; cntr < words; cntr++) {
      buf[0] = blk[cntr] >> 6;
      chksum += buf[0];
      buf[1] = blk[cntr] & 077;
      chksum += buf[1];
      fwrite(buf, 1, 2, out);
   }
   return chksum;
}
 
void dump_tss_bin(FILE *in, struct dirent *dir, FILE *out)
{
   int cntr;
   unsigned char leader[64];
   int chksum = 0;
   unsigned char buf[2];
   int read_block = dir->blocks[0];
   uint16_t block[129];

   mime_header("application/octet-stream", -1);
   memset(leader, 0x80, sizeof(leader));
   fwrite(leader, 1, sizeof(leader), out);
   // TSS only supports 4k
   //buf[0] = 0xc0 + (field << 3);
   //fwrite(buf, 1, 1, out);

   for (cntr = 0; cntr < dir->num_blocks; cntr++) { 
      if (fseek(in,BLOCK_TO_FILE(read_block),SEEK_SET) != 0)
         html_error(0, "dir seek failed\n");
      if (fread(block, sizeof(block), 1, in) != 1)
         html_error(0, "dir read failed\n");
      chksum = dump_bin_block(cntr, block, 128, chksum, out);
      read_block = block[128];
   }
   buf[0] = (chksum & 07777) >> 6;
   buf[1] = chksum & 077;
   fwrite(buf, 1, 2, out);
   fwrite(leader, 1, sizeof(leader), out);
}

void dump_tss_binary(FILE *in, struct dirent *dir, BIN_TYPE type, FILE *out) {
   uint16_t block[129];
   int cntr;
   int read_block = dir->blocks[0];

   if (type == TYPE_IMAGE) {
      mime_header("application/octet-stream", -1);
      for (cntr = 0; cntr < dir->num_blocks; cntr++) { 
         if (fseek(in,BLOCK_TO_FILE(read_block),SEEK_SET) != 0)
            html_error(0, "dir seek failed\n");
         if (fread(block, sizeof(block), 1, in) != 1)
            html_error(0, "dir read failed\n");
         if (fwrite(block, sizeof(block), 1, out) < 1)
            html_error(0, "File write failed\n");
         read_block = block[128];
      }
   } else if (type == TYPE_BIN) {
      dump_tss_bin(in, dir, out);
   } else {
      html_error(0, "Unknown conversion type %d\n",type);
   }
}

int decode_packed(FILE *in, struct dirent *dir, BIN_TYPE type, FILE *outfile) {
   int cntr, cntr2;
   int block_err = 0;
   uint16_t block[129];
   uint8_t bytes[128*3/2];
   int read_block = dir->blocks[0];

   for (cntr = 0; cntr < dir->num_blocks; cntr++) { 
      if (fseek(in,BLOCK_TO_FILE(read_block),SEEK_SET) != 0)
         html_error(0, "dir seek failed\n");
      if (fread(block, sizeof(block), 1, in) != 1)
         html_error(0, "dir read failed\n");
      if (type == TYPE_OS8_PACKED) {         
         OS8BlockToBytes(block, bytes);
      } else {
         TSS8BlockToBytes(block, bytes);
      }
      for (cntr2 = 0; cntr2 < sizeof(bytes); cntr2++) {
         fputc(bytes[cntr2] & 0x7f, outfile);
      }
      if (block[128] != 0 && search_blocks(block[128], dir) == -1) {
         block_err = 1;
      }
      read_block = block[128];
   }
   return block_err;
}

int decode_6bit(FILE *in, struct dirent *dir, BIN_TYPE type, FILE *outfile) {
   int cntr, cntr2;
   int block_err = 0;
   uint16_t block[129];
   int read_block = dir->blocks[0];

   for (cntr = 0; cntr < dir->num_blocks; cntr++) { 
      if (fseek(in,BLOCK_TO_FILE(read_block),SEEK_SET) != 0)
         html_error(0, "dir seek failed\n");
      if (fread(block, sizeof(block), 1, in) != 1)
         html_error(0, "dir read failed\n");
      for (cntr2 = 0; cntr2 < 128; cntr2++) {
         if (type == TYPE_ASCII6) {         
            fputc(OS8Conv6bit(block[cntr2] >> 6), outfile);
            fputc(OS8Conv6bit(block[cntr2] & 077), outfile);
         } else if (type == TYPE_TSS_ASCII6) {
            fputc(conv_tss_6bit(block[cntr2] >> 6), outfile);
            fputc(conv_tss_6bit(block[cntr2] & 077), outfile);
         } else if (type == TYPE_OCTAL) {
            fprintf(outfile, "%04o ", block[cntr2]);
            if (cntr2 % 16 == 15) {
               fprintf(outfile, "\n");
            }
         }
      }
      if (block[128] != 0 && search_blocks(block[128], dir) == -1) {
         block_err = 1;
      }
      read_block = block[128];
   }
   return block_err;
}

int is_tss_bin_basic(FILE *in, struct dirent *dir) {
   uint16_t block[129];

   if (fseek(in,BLOCK_TO_FILE(dir->blocks[0]),SEEK_SET) != 0)
      return 0;
   if (fread(block, sizeof(block), 1, in) != 1)
      return 0;

   if (block[0] == 07776 && block[1] == 0 && block[2] == 01141 && block[3] == 0030) {
      return 1;
   } else {
      return 0;
   }
}

int is_tss_basic6(FILE *in, struct dirent *dir) {
   int cntr, cntr2;
   int match = 1;
   uint16_t block[129];
   int new_line = 1;
   int done = 0;
   int last_line = 0;
   int read_block = dir->blocks[0];

   for (cntr = 0; cntr < dir->num_blocks && !done; cntr++) { 
      if (fseek(in,BLOCK_TO_FILE(read_block),SEEK_SET) != 0)
         return 0;
      if (fread(block, sizeof(block), 1, in) != 1)
         return 0;
      for (cntr2 = 0; cntr2 < 128 && !done; cntr2++) {
         if (new_line == 1) {         
            if (block[cntr2] == 2047) { // 2047 end of file
               done = 1;
            } else if (block[cntr2] <= last_line) {
               match = 0;
               done = 1;
            }
            last_line = block[cntr2];
            new_line = 0;
         } else {
            if (block[cntr2] == 0) {
               new_line = 1;
            }
         }
      }
      read_block = block[128];
   }
   return match;
}

int is_tss_packed(FILE *in, struct dirent *dir) {
   int cntr, cntr2;
   uint16_t block[129];
   uint8_t bytes[128*3/2];
   int bad_char = 0;
   int read_block = dir->blocks[0];

   for (cntr = 0; cntr < dir->num_blocks; cntr++) { 
      if (fseek(in,BLOCK_TO_FILE(read_block),SEEK_SET) != 0)
         return 0;
      if (fread(block, sizeof(block), 1, in) != 1)
         return 0;
#if 0
      if (type == TYPE_OS8_PACKED) {         
         OS8BlockToBytes(block, bytes);
      } else {
#endif
         TSS8BlockToBytes(block, bytes);
      //}
      for (cntr2 = 0; cntr2 < sizeof(bytes); cntr2++) {
         if (bytes[cntr2] < 32 && bytes[cntr2] != '\n' && bytes[cntr2] != '\r' &&
               bytes[cntr2] != '\t' && bytes[cntr2] != '\f' && bytes[cntr2] != 0) {
            bad_char++;
            //printf("Bad char %d\n",bytes[cntr2]);
         }
      }
      read_block = block[128];
   }
   return bad_char < 4;
}

int decode_tss_basic6(FILE *in, struct dirent *dir, BIN_TYPE type, FILE *outfile) {
   int cntr, cntr2;
   int block_err = 0;
   uint16_t block[129];
   int new_line = 1;
   int done = 0;
   int read_block = dir->blocks[0];

   for (cntr = 0; cntr < dir->num_blocks && !done; cntr++) { 
      if (fseek(in,BLOCK_TO_FILE(read_block),SEEK_SET) != 0)
         html_error(0, "dir seek failed\n");
      if (fread(block, sizeof(block), 1, in) != 1)
         html_error(0, "dir read failed\n");
      for (cntr2 = 0; cntr2 < 128 && !done; cntr2++) {
         if (new_line == 1) {         
            if (block[cntr2] == 2047) { // 2047 end of file
               done = 1;
            } else {
               fprintf(outfile, "%d", block[cntr2]);
            }
            new_line = 0;
         } else {
            if (block[cntr2] == 0) {
               fprintf(outfile, "\n");
               new_line = 1;
            } else {
               fputc(OS8Conv6bit(block[cntr2] >> 6), outfile);
               fputc(OS8Conv6bit(block[cntr2] & 077), outfile);
            }
         }
      }
      if (block[128] != 0 && search_blocks(block[128], dir) == -1) {
         block_err = 1;
      }
      read_block = block[128];
   }
   return block_err;
}

void dump_ascii_file(FILE *in, struct dirent *dir, BIN_TYPE type,
      char *enc_fn, int index_mode, char *to, int plain) {
   int add_footer = 0;
   char fn[12];
   FILE *outfile;
   int block_err = 0;


      if (!plain) {
         char desc2[516] = {0};
         mime_header("text/html", -1);
#if 0
         char *ext, *desc;
         desc = lookup_ext(tofn, &ext);
         if (desc != NULL) {
            sprintf(desc2, "(%s)", desc);
            desc2[strlen(desc2)-2] = ')';
            desc2[strlen(desc2)-1] = 0;
         } else {
            desc2[0] = 0;
         }
#endif
         snprintf(fn, sizeof(fn), "%s%s", dir->fn, get_ext(dir->flags));
         printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>File %s %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> </head> <body>\n", fn, desc2);
         printf("<center>File %s %s</center><br>\n",fn, desc2);
         printf("<p><a href='../os8_html?act=dir;fn=%s;sort=name'>Directory of image this file is from</a><br>\n",enc_fn);
         printf("<a href='../os8_html/%s?act=file;fn=%s;to=%s;ent=%d;plain=1'>This file as a plain text file</a><br>\n", 
            fn, enc_fn, to, dir->orig_entry);
         if (index_mode >= 3)
            printf("<!--/htdig_noindex-->\n");
         printf("<pre>\n");
         add_footer = 1;
         fflush(stdout);
         outfile = popen("/bin/sed -e 's/&/\\&amp;/g' -e 's/</\\&lt;/g'  -e 's/>/\\&gt;/g' -e 's/^L/<HR WIDTH=\"100%\">/'", "w");
         if (outfile == NULL)
            html_error(0, "Sed popen failed\n");
      } else {
         mime_header("text/plain", -1);
         outfile = stdout;
      }
      if (type == TYPE_ASCII6 || type == TYPE_TSS_ASCII6 || type == TYPE_OCTAL) {
         block_err = decode_6bit(in, dir, type, outfile);
      } else if (type == TYPE_TSS_BASIC6) {
         block_err = decode_tss_basic6(in, dir, type, outfile);
      } else if (type == TYPE_TSS_PACKED) {
         block_err = decode_packed(in, dir, type, outfile);
      } else {
         printf("Unknown type %d\n",type);
      }
      if (block_err) {
         fprintf(outfile, "\n\nError found in file block chain\n\n");
      }
      if (add_footer) {
         if (pclose(outfile) != 0)
            html_error(0, "pclose failed\n");
         printf("</pre>\n");
         if (index_mode >= 3)
            printf("<!--htdig_noindex-->\n");
         include_file("footer.shtml");
         if (index_mode >= 3)
            printf("<!--/htdig_noindex-->\n");
         printf("</body> </html>\n");
      }

}

void tss_file(FILE *in, char *tofn, struct dirent *dir, 
      char *to, char *infn, int plain, int index_mode, char *enc_fn) {
   if (strcmp(to, "image") == 0) {
      dump_tss_binary(in, dir, TYPE_IMAGE, stdout);
   } else if (strcmp(to, "bin") == 0) {
      dump_tss_binary(in, dir, TYPE_BIN, stdout);
   } else if (strcmp(to, "ascii6") == 0) {
      dump_ascii_file(in, dir, TYPE_ASCII6, enc_fn, index_mode, to, plain);
   } else if (strcmp(to, "tss_ascii6") == 0) {
      dump_ascii_file(in, dir, TYPE_TSS_ASCII6, enc_fn, index_mode, to, plain);
   } else if (strcmp(to, "tss_basic6") == 0) {
      dump_ascii_file(in, dir, TYPE_TSS_BASIC6, enc_fn, index_mode, to, plain);
   } else if (strcmp(to, "octal") == 0) {
      dump_ascii_file(in, dir, TYPE_OCTAL, enc_fn, index_mode, to, plain);
   } else if (strcmp(to, "tss_packed") == 0) {
      dump_ascii_file(in, dir, TYPE_TSS_PACKED, enc_fn, index_mode, to, plain);
   } else if (strcmp(to, "auto") == 0) {
      if (is_tss_basic6(in, dir)) {
         dump_ascii_file(in, dir, TYPE_TSS_BASIC6, enc_fn, index_mode, to, plain);
      } else if (is_tss_packed(in, dir)) {
         dump_ascii_file(in, dir, TYPE_TSS_PACKED, enc_fn, index_mode, to, plain);
      } else if (is_tss_bin_basic(in, dir)) {
         tss_info(in, tofn, dir, infn);
      } else {
         tss_info(in, tofn, dir, infn);
      }
   } else {
      html_error(0, "Unknown conversion %s\n",to);
   }
}


int tss_dir_sort(const void *comp1,const void *comp2)
{
   const struct dirent *a = comp1;
   const struct dirent *b = comp2;
   return(strcmp(a->fn, b->fn));
}

struct dirent *read_dir(FILE *in, int *free_blocks) {
#define MAX_DIR_BLOCKS 3
#define MAX_ALLOC_BLOCKS 12
   uint16_t dir[130*MAX_DIR_BLOCKS];
   uint16_t alloc[129*MAX_ALLOC_BLOCKS];
   static struct dirent idir[MAX_DIR];
   int dirnum;
   int blk;
   int dirent;
   int cntr;
   // In words
   int first_dirent_offset = 5;
   int dir_skip = 3;
   int dirent_size = 5;
   int alloc_start = 0;
   int alloc_blocks = 0;

   // Directory is 3 blocks using 129 words in each block
   memset(dir, 0, sizeof(dir));
   memset(alloc, 0, sizeof(alloc));
   blk = DIR_BLOCK;
   cntr = 0;
   do {
      if (fseek(in,BLOCK_TO_FILE(blk)+dir_skip*2,SEEK_SET) != 0)
         html_error(0, "dir seek failed\n");
      // Make entries contiguous
      if (fread(&dir[cntr*125], (129-dir_skip)*2, 1, in) != 1)
         html_error(0, "dir read failed\n");
      blk = dir[cntr*125+128-dir_skip];
   } while (blk != 0 && ++cntr < MAX_DIR_BLOCKS);

   cntr = 0;
   blk = DIR_BLOCK+1;
   do {
      if (fseek(in,BLOCK_TO_FILE(blk),SEEK_SET) != 0)
         html_error(0, "alloc tbl seek failed\n");
      // Discard next block pointer previously read
      if (fread(&alloc[cntr*128], 129*2, 1, in) != 1)
         html_error(0, "alloc tbl read failed\n");
      blk = alloc[cntr*128+128];
      alloc_blocks++;
   } while (blk != 0 && ++cntr < MAX_ALLOC_BLOCKS);
   dirnum = 0;
   memset(idir, 0, sizeof(idir));
   *free_blocks = 0;
   for (dirent = 0; dirent < MAX_DIR; dirent++) {
      int loc = dirent*dirent_size + first_dirent_offset;

      for (cntr = 0; cntr < 3; cntr++) {
         idir[dirnum].fn[cntr*2] = (dir[loc+cntr] >> 6) + 32;
         idir[dirnum].fn[cntr*2+1] = (dir[loc+cntr] & 077) + 32;
      }
      // Remove trailing space
      for (cntr = 5; cntr > 0; cntr--) {
         if (idir[dirnum].fn[cntr] == ' ') {
            idir[dirnum].fn[cntr] = 0;
         } else {
            break;
         }
      }
      idir[dirnum].date = dir[loc+3];
      // File number sometimes 0 in directory.
      idir[dirnum].dir_fileno = dir[loc+4] & 077;
      idir[dirnum].fileno = dirent+2;
      idir[dirnum].flags = dir[loc+4] >> 6;
//printf("Entry %d fn %s fileno %d loc %d\n<br>",dirnum, idir[dirnum].fn, idir[dirnum].fileno, loc );
 
      if (idir[dirnum].fn[0] != 32) {
         idir[dirnum].used = 1;
         idir[dirnum].orig_entry = dirnum;
         for (blk = 0; blk < alloc_blocks; blk++) {
            for (cntr = 0; cntr < 128; cntr++) {
               if (idir[dirnum].fileno == (alloc[alloc_start+cntr+blk*128] & 077)) {
                  idir[dirnum].blocks[idir[dirnum].num_blocks] = cntr + blk * 256; 
                  idir[dirnum].num_blocks++;
               }
            }

            for (cntr = 0; cntr < 128; cntr++) {
               if (idir[dirnum].fileno == (alloc[alloc_start+cntr+blk*128] >> 6)) {
                  idir[dirnum].blocks[idir[dirnum].num_blocks] = cntr + blk * 256 + 128; 
                  idir[dirnum].num_blocks++;
               }
            }
         }
         dirnum++;
      }
   }

   for (cntr = 0; cntr < alloc_blocks*128; cntr++) {
      if ((alloc[alloc_start+cntr] & 077) == 0) {
         (*free_blocks)++;
      }
      if ((alloc[alloc_start+cntr] >> 6) == 0) {
         (*free_blocks)++;
      }
   }
   return idir;
}


void tss_dir(FILE *in, char *infn, char *enc_fn, int sort, int index_mode,
      struct dirent idir[], int free_blocks) {
   int dirent;
   char encoded_fn[512];
   char tmpstr[512];
   char *loc;



   mime_header("text/html", -1);
   printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>Directory of %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> </head> <body>\n",infn);

   printf("<center>Directory of %s</center><br>\n",infn);
   if (index_mode >= 3)
      printf("<!--htdig_noindex-->\n");

   printf("This directory lists files in TSS/8 SAVE format DECtapes\n");
   printf("The links below will return the file in\n");
   printf("various formats.\n");
   printf("<p>File name link convert to ASCII text if format can be determined\n");
   printf("<br>INFO gives information on executables with a choice of download formats.\n");
   printf("<br>Limited documentation on format and less testing that desired so may have issues.\n");
#if 0
   printf("<br>BINLDR converts the file back to 8 bit binary loader format\n");
   printf("<br>IMAGE converts the file 12 bit words in two bytes\n");
#endif

   printf("<p><a href='/ftp/%s'>Download this image %s</a><br>",
      infn, infn);

   if (sort)
      printf("<p><a href='tss_dectape?act=dir;fn=%s;sort=none'>Unsorted Directory Listing</a>", infn);
   else
      printf("<p><a href='tss_dectape?act=dir;fn=%s;sort=name'>Sort Directory Listing</a>", infn);
   printf("<p><pre>\n");
  // printf("FB=%04o\n\n",fb);
   if (index_mode >= 3)
      printf("<!--/htdig_noindex-->\n");
   if (sort) {
      qsort(idir, MAX_DIR, sizeof(idir[0]), tss_dir_sort);
   }
   printf("%d. FREE BLOCKS\n\n", free_blocks);
   for (dirent = 0; dirent < MAX_DIR; dirent++) {
      if (!idir[dirent].used)
         continue;
      if (index_mode >= 1)
          printf("<a name='%s'></a>",idir[dirent].fn);

      strcpy(encoded_fn, idir[dirent].fn);
      strcat(encoded_fn, get_ext(idir[dirent].flags));
      RFC1630Encode(encoded_fn, sizeof(encoded_fn), 1);

      printf("<a href='tss_dectape/%s?act=file;fn=%s;to=auto;ent=%d'>",
          encoded_fn, infn, idir[dirent].orig_entry);
      printf("%-6s", idir[dirent].fn);
      printf("%4s ", get_ext(idir[dirent].flags));
      printf("</a>");
      printf("%3d  ", idir[dirent].num_blocks);
      printf("%-9s ", conv_date(idir[dirent].date));
#if 0
      printf("<a href='tss_dectape/%s.bn?act=file;fn=%s;to=bin;ent=%d'>BINLDR</a>  ", 
          encoded_fn, infn, idir[dirent].orig_entry);
#endif
      if (index_mode >= 3)
         printf("<!--htdig_noindex-->\n");
      printf("<a href='tss_dectape/%s?act=info;fn=%s;ent=%d'>INFO</a>  ", 
          encoded_fn, infn, idir[dirent].orig_entry);
#if 0
      printf("<a href='tss_dectape/%s?act=file;fn=%s;to=image;ent=%d'>IMAGE</a>  ", 
          encoded_fn, infn, idir[dirent].orig_entry);
#endif
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

void tss_info(FILE *in, char *tofn, struct dirent *dir, char *infn) {
   mime_header("text/html", -1);
   printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>Information on file %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> <META NAME=\"robots\" CONTENT=\"noindex, nofollow\"></head> <body>\n",tofn);
   printf("<center>Information on file %s</center><br>\n",tofn);

   if (is_tss_basic6(in, dir)) {
      printf("File is BASIC source");
   } else if (is_tss_bin_basic(in, dir)) {
      printf("File is likely binary BASIC. Currently no decoder. Strings can be viewed as 6 bit text");
   } else if (is_tss_packed(in, dir)) {
      printf("File is TSS packed ASCII test");
   } else {
      printf("Unknown file format");
   } 
   printf("<p>\n");

#if 0
      printf("<a href='tss_dectape/%s?act=file;fn=%s;to=tss_ascii6;ent=%d'>Display as TSS 6 bit text</a> &nbsp;&nbsp;\n",
         tofn, infn, dir->orig_entry);
#endif
      printf("<a href='tss_dectape/%s?act=file;fn=%s;to=ascii6;ent=%d'>Display as 6 bit text</a> &nbsp;&nbsp;\n",
         tofn, infn, dir->orig_entry);
      printf("<a href='tss_dectape/%s?act=file;fn=%s;to=tss_packed;ent=%d'>Display as packed TSS ASCII text</a> &nbsp;&nbsp;\n",
         tofn, infn, dir->orig_entry);
      printf("<a href='tss_dectape/%s?act=file;fn=%s;to=tss_basic6;ent=%d'>View BASIC source</a> &nbsp;&nbsp;\n",
         tofn, infn, dir->orig_entry);
      printf("<a href='tss_dectape/%s?act=file;fn=%s;to=octal;ent=%d'>Octal</a> &nbsp;&nbsp;\n",
         tofn, infn, dir->orig_entry);
      printf("<a href='tss_dectape/%s.bn?act=file;fn=%s;to=bin;ent=%d'>Convert to BIN loader format</a> &nbsp;&nbsp;\n",
         tofn, infn, dir->orig_entry);
      printf("<a href='tss_dectape/%s?act=file;fn=%s;to=image;ent=%d'>IMAGE</a>  ", 
          tofn, infn, dir->orig_entry);
#if 0
   if (dir->first_block == 07777) {
      printf("<br>Part of tss system, not stored separatly on tape\n");
   } else {
      printf("<br>Starting address %04o\n",dir->entry_point);

      printf("<br>Memory blocks used:<br>\n");
      block = 0;
      for (cntr = 0; cntr < dir->num_pages; cntr++) { 
         if (dir->pages[cntr].type == 0) {
            if (dir->pages[cntr].first != 0) {
               printf("%04o ", (dir->pages[cntr].first - 1) << 7);
               block++;
            }
            if (dir->pages[cntr].second != 0) {
               printf("%04o ", (dir->pages[cntr].second - 1) << 7);
               block++;
            }
         } else if (dir->pages[cntr].type == 3) {
            printf("%04o to %04o ", (dir->pages[cntr].first - 1) << 7,
                (dir->pages[cntr].second - 1) << 7);
            for (cntr2 = dir->pages[cntr].first; cntr2 <= dir->pages[cntr].second; cntr2++) {
               block++;
            }
         } else {
            html_error(0, "Unknown page type %d\n", dir->pages[cntr].type);
         }
      }
      printf("<br>\n");
      printf("File first tape block %d length %d blocks\n", dir->first_block,
         block);

      printf("<p>\n");
      printf("<a href='tss_dectape/%s.bn?act=file;fn=%s;to=bin;ent=%d'>Convert to BIN loader format</a> &nbsp;&nbsp;\n",
         tofn, infn, dir->orig_entry);
   }
#endif

   include_file("footer.shtml");
   html_end();
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
   struct {
      unsigned short block_size;
      short first_block;
      short first_rev_block;
   } linc_info;
   struct dirent *dir;
   int free_blocks;
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
   url_enc(infn, enc_fn, sizeof(enc_fn));

   if (strstr(infn,"/../") != NULL || strlen(infn) > sizeof(fullpath) - 
         MAX_LCL_PATH) 
      html_error(0, "ERROR: Illegal file name %s\n",infn);
   if (argc == 2 && strcmp(argv[1],"lcl") == 0)
      strcpy(fullpath, "/mnt/data3/link/link/good/");
   else
      strcpy(fullpath, "/mnt/pdp/ftproot/");
   strcat(fullpath,infn);

#if WRITE
   in = fopen(fullpath,"r+");
#else
   in = fopen(fullpath,"r");
#endif
   if (in == NULL) 
      html_error(0,"Open %s failed: %s\n",infn, strerror(errno));
#if 0
   if (strstr(fullpath, "linc")) {
      if (fseek(in, -sizeof(linc_info), SEEK_END) != 0)
         html_error(0, "file seek failed\n");
      if (fread(&linc_info,sizeof(linc_info),1,in) < 1)
          html_error(0, "file info read failed\n");
      file_offset_words = -linc_info.first_block * linc_info.block_size;
      if (linc_info.block_size == 256)
         file_offset_words += 2049;
   }
#endif
   dir = read_dir(in, &free_blocks);

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
            } else if (!(strncasecmp(user_agent, "mozilla",7) == 0 ||
                strncasecmp(user_agent, "opera",5) == 0)) {
               index_mode = 2;
            }
         }
      }

      tss_dir(in, infn, enc_fn, (sort != NULL && strcmp(sort,"name") == 0),
         index_mode, dir, free_blocks);
   } else if (strcmp(action,"file") == 0) {
      char *str, *to, *tofn;
      char *plain, *user_agent;
      int index_mode = 0;
      int entry;

      str = find_val(head, "ent");
      if (str == NULL) 
         html_error(0, "ERROR: No entry specified on file\n");
      entry = atoi(str);
      if (entry >= MAX_DIR) {
         html_error(0, "ERROR: Illegal directory entry (%s) specified on file\n", str);
      }
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
      tss_file(in, tofn, &dir[entry],  to, infn, plain != NULL, index_mode, 
         enc_fn);
   } else if (strcmp(action,"info") == 0) {
      char *str,*tofn;
      int entry;

      str = find_val(head, "ent");
      if (str == NULL) 
         html_error(0, "ERROR: No entry specified on file\n");
      entry = atoi(str);
      if (entry >= MAX_DIR) {
         html_error(0, "ERROR: Illegal directory entry (%s) specified on file\n", str);
      }
      tofn = getenv("PATH_INFO");
      if (tofn == NULL || strlen(tofn) < 2) 
         html_error(0, "ERROR: No extract file specified\n");
      tofn++; // Remove leading /
      tss_info(in, tofn, &dir[entry], infn);
   } else {
      html_error(0, "ERROR: illegal action %s\n",action);
   }
   return 0;
}
