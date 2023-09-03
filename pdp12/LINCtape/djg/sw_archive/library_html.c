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

#include "cgi-lib/cgi-lib.h"
#include "cgi-lib/html-lib.h"
#include "url_encode.h"

#define ARRAYSIZE(x) (sizeof(x) / sizeof(x[0]))

#define IMAGE_ROOT "/images/"

typedef enum {TYPE_BIN, TYPE_IMAGE} BIN_TYPE;

// Size in words
#define BLK_SIZE 129 
#define BLOCK_TO_FILE(x) (((x)*BLK_SIZE + file_offset_words)*2)
int file_offset_words = 0;


// First block of directory
#define DIR_BLOCK 9

#define MAX_DIR 54
struct dirent {
   char fn[7]; // 6 + zero term
   int orig_entry;
   int first_block;
   int entry_point;
   int used;
   int num_pages;
   struct {
      int first;
      int second;
      int type;
   } pages[32];
};

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
   if (x <= 037) 
      return x + 'A' - 1;
   else
      return x;
}

void dump_image(FILE *in, FILE *out, int block) {
   unsigned short buf[BLK_SIZE];

   if (fseek(in,BLOCK_TO_FILE(block),SEEK_SET) != 0)
      html_error(0, "file seek failed\n");
   if (fread(buf, BLK_SIZE*2, 1, in) != 1)
      html_error(0, "file read failed\n");
   // Only 128 of the words used
   if (fwrite(buf, 128*2, 1, out) < 1)
      html_error(0, "File write failed\n");
}

int dump_bin_block(FILE *in, int page, int block, int chksum, FILE *out) {
   unsigned short blk[BLK_SIZE];
   int origin = page << 7;
   unsigned char buf[2];
   int cntr;

   buf[0] = 0x40 + (origin >> 6);   
   chksum += buf[0];
   buf[1] = (origin & 077);
   chksum += buf[1];
   fwrite(buf, 1, 2, out);
   if (fseek(in,BLOCK_TO_FILE(block),SEEK_SET) != 0)
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
   return chksum;
}
 
void dump_library_bin(FILE *in, struct dirent *dir, FILE *out)
{
   int cntr, cntr2;
   unsigned char leader[64];
   int chksum = 0;
   int block = dir->first_block;
   unsigned char buf[2];

   mime_header("application/octet-stream", -1);
   memset(leader, 0x80, sizeof(leader));
   fwrite(leader, 1, sizeof(leader), out);
   // Library system only supports 4k
   //buf[0] = 0xc0 + (field << 3);
   //fwrite(buf, 1, 1, out);

   for (cntr = 0; cntr < dir->num_pages; cntr++) { 
      if (dir->pages[cntr].type == 0) {
         if (dir->pages[cntr].first != 0) {
            chksum = dump_bin_block(in, dir->pages[cntr].first-1, block, chksum, out);
            block++;
         }
         if (dir->pages[cntr].second != 0) {
            chksum = dump_bin_block(in, dir->pages[cntr].second-1, block, chksum, out);
            block++;
         }
      } else if (dir->pages[cntr].type == 3) {
         for (cntr2 = dir->pages[cntr].first; cntr2 <= dir->pages[cntr].second; cntr2++) {
            chksum = dump_bin_block(in, cntr2 - 1, block, chksum, out);
            block++;
         }
      } else {
         html_error(0, "Unknown page type %d\n", dir->pages[cntr].type);
      }
   }
   buf[0] = (chksum & 07777) >> 6;
   buf[1] = chksum & 077;
   fwrite(buf, 1, 2, out);
   fwrite(leader, 1, sizeof(leader), out);
}

void dump_library_binary(FILE *in, struct dirent *dir, 
      BIN_TYPE type, FILE *out) {
   int block;
   int cntr, cntr2;

   if (type == TYPE_IMAGE) {
      mime_header("application/octet-stream", -1);
         block = dir->first_block;
         for (cntr = 0; cntr < dir->num_pages; cntr++) { 
             if (dir->pages[cntr].type == 0) {
                if (dir->pages[cntr].first != 0) {
                   dump_image(in, out, block);
                   block++;
                };
                if (dir->pages[cntr].second != 0) {
                   dump_image(in, out, block);
                   block++;
                };
             } else if (dir->pages[cntr].type == 3) {
                for (cntr2 = dir->pages[cntr].first; cntr2 <= dir->pages[cntr].second; cntr2++) {
                   dump_image(in, out, block);
                   block++;
                }
             } else {
                html_error(0, "Unknown page type %d\n", dir->pages[cntr].type);
             }
         }
   } else if (type == TYPE_BIN) {
      dump_library_bin(in, dir, out);
   } else {
      html_error(0, "Unknown conversion type %d\n",type);
   }
}

int library_dir_sort(const void *comp1,const void *comp2)
{
   const struct dirent *a = comp1;
   const struct dirent *b = comp2;
   return(strcmp(a->fn, b->fn));
}

struct dirent *read_dir(FILE *in) {
   unsigned short dir[128*3];
   static struct dirent idir[MAX_DIR];
   int dirnum;
   int blk;
   int dirent;
   int cntr;

   // Directory is 3 blocks using 128 words in each block
   for (blk = 0; blk < 3; blk++) { 
      if (fseek(in,BLOCK_TO_FILE(blk+DIR_BLOCK),SEEK_SET) != 0)
         html_error(0, "dir seek failed\n");
      if (fread(&dir[blk*128], 128*2, 1, in) != 1)
         html_error(0, "dir read failed\n");
   }
   dirnum = 0;
   memset(idir, 0, sizeof(idir));
   dirent = 4;
   while (dirent <= 128*3-7) {
      unsigned char temp[7];
      int dest = 0;

      for (cntr = 0; cntr < 3; cntr++) {
         temp[cntr*2] = conv(dir[dirent+cntr] >> 6);
         temp[cntr*2+1] = conv(dir[dirent+cntr] & 077);
      }
      temp[cntr*2] = 0;
      // Remove all @
      for (cntr = 0; cntr < sizeof(temp); cntr++) {
         if (temp[cntr] != '@')
            idir[dirnum].fn[dest++] = temp[cntr];
      }
      idir[dirnum].first_block = dir[dirent+3];
      idir[dirnum].entry_point = dir[dirent+4];
      for (cntr = 0; cntr < ARRAYSIZE(idir[0].pages); cntr++) { 
         // Last entry 0 indicates end of list
         if (dir[dirent+cntr+5] == 0) {
            break;
         }
         idir[dirnum].pages[cntr].first = (dir[dirent+cntr+5] >> 5) & 0x1f;
         idir[dirnum].pages[cntr].second = dir[dirent+cntr+5] & 0x1f;
         idir[dirnum].pages[cntr].type = (dir[dirent+cntr+5] >> 10) & 0x3;
         idir[dirnum].num_pages++;
      }
 
      dirent += 6 + idir[dirnum].num_pages;

      // The bitsavers library tapes had first block non zero but empty
      // filename. Don't display them for now
      if (idir[dirnum].first_block != 0 && idir[dirnum].fn[0]  != 0) {
         idir[dirnum].used = 1;
         idir[dirnum].orig_entry = dirnum;
         dirnum++;
      }
   }
   return idir;
}


void library_dir(FILE *in, char *infn, char *enc_fn, int sort, int index_mode,
      struct dirent idir[]) {
   int dirent;
   char encoded_fn[512];
   char tmpstr[512];
   char *loc;

   mime_header("text/html", -1);
   printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>Directory of %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> </head> <body>\n",infn);

   printf("<center>Directory of %s</center><br>\n",infn);
   if (index_mode >= 3)
      printf("<!--htdig_noindex-->\n");

   printf("This directory lists files in the DECtape Library System tape\n");
   printf("The links below will return the file in\n");
   printf("various formats.\n");
   printf("<p>ASCII converts ASCII files to readable text\n");
   printf("<br>INFO gives information on executables with a choice of download formats.\n");
   printf("<br>BINLDR converts the file back to 8 bit binary loader format\n");
   printf("<br>IMAGE converts the file 12 bit words in two bytes\n");

   printf("<p><a href='/ftp/%s'>Download this image %s</a><br>",
      infn, infn);

   if (sort)
      printf("<p><a href='library_html?act=dir;fn=%s;sort=none'>Unsorted Directory Listing</a>", infn);
   else
      printf("<p><a href='library_html?act=dir;fn=%s;sort=name'>Sort Directory Listing</a>", infn);
   printf("<p><pre>\n");
  // printf("FB=%04o\n\n",fb);
   if (index_mode >= 3)
      printf("<!--/htdig_noindex-->\n");
   if (sort) {
      qsort(idir, MAX_DIR, sizeof(idir[0]), library_dir_sort);
   }
   for (dirent = 0; dirent < MAX_DIR; dirent++) {
      if (!idir[dirent].used)
         continue;
      if (index_mode >= 1)
          printf("<a name='%s'></a>",idir[dirent].fn);

      printf("%-6s   ", idir[dirent].fn);
      strcpy(encoded_fn, idir[dirent].fn);
      RFC1630Encode(encoded_fn, sizeof(encoded_fn), 1);
      printf("<a href='library_html/%s.bn?act=file;fn=%s;to=bin;ent=%d'>BINLDR</a>  ", 
          encoded_fn, infn, idir[dirent].orig_entry);
      if (index_mode >= 3)
         printf("<!--htdig_noindex-->\n");
      printf("<a href='library_html/%s?act=info;fn=%s;ent=%d'>INFO</a>  ", 
          encoded_fn, infn, idir[dirent].orig_entry);
      printf("<a href='library_html/%s?act=file;fn=%s;to=image;ent=%d'>IMAGE</a>  ", 
          encoded_fn, infn, idir[dirent].orig_entry);
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

void library_info(FILE *in, char *tofn, struct dirent *dir, char *infn) {
   int cntr, cntr2;
   int block;

   mime_header("text/html", -1);
   printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>Information on file %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> <META NAME=\"robots\" CONTENT=\"noindex, nofollow\"></head> <body>\n",tofn);
   printf("<center>Information on file %s</center><br>\n",tofn);

   if (dir->first_block == 07777) {
      printf("<br>Part of library system, not stored separatly on tape\n");
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
      printf("<a href='library_html/%s.bn?act=file;fn=%s;to=bin;ent=%d'>Convert to BIN loader format</a> &nbsp;&nbsp;\n",
         tofn, infn, dir->orig_entry);
   }

   include_file("footer.shtml");
   html_end();
}

void library_file(FILE *in, char *tofn, struct dirent *dir, 
      char *to, char *infn, int plain, int index_mode) {
   if (strcmp(to, "image") == 0) {
      dump_library_binary(in, dir, TYPE_IMAGE, stdout);
   } else if (strcmp(to, "bin") == 0) {
      dump_library_binary(in, dir, TYPE_BIN, stdout);
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
   struct {
      unsigned short block_size;
      short first_block;
      short first_rev_block;
   } linc_info;
   struct dirent *dir;
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
   if (strstr(fullpath, "linc")) {
      if (fseek(in, -sizeof(linc_info), SEEK_END) != 0)
         html_error(0, "file seek failed\n");
      if (fread(&linc_info,sizeof(linc_info),1,in) < 1)
          html_error(0, "file info read failed\n");
      file_offset_words = -linc_info.first_block * linc_info.block_size;
      if (linc_info.block_size == 256)
         file_offset_words += 2049;
   }
   dir = read_dir(in);

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

      url_enc(infn, enc_fn, sizeof(enc_fn));

      library_dir(in, infn, enc_fn, (sort != NULL && strcmp(sort,"name") == 0),
         index_mode, dir);
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
      library_file(in, tofn, &dir[entry],  to, infn, plain != NULL, index_mode);
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
      library_info(in, tofn, &dir[entry], infn);
   } else {
      html_error(0, "ERROR: illegal action %s\n",action);
   }
   return 0;
}
