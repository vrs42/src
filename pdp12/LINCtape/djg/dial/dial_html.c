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
#include <sys/stat.h>


#include "cgi-lib/cgi-lib.h"
#include "cgi-lib/html-lib.h"
#include "url_encode.h"

#define ARRAYSIZE(x) (sizeof(x) / sizeof(x[0]))

#define IMAGE_ROOT "/images/"

int lap6_mode;

typedef enum {TYPE_OS8_SV, TYPE_BIN, TYPE_IMAGE, TYPE_DUMP, TYPE_OCTAL} BIN_TYPE;

struct dial_hdr {
   unsigned short mode;
   unsigned short field;
   unsigned short unknown;
   unsigned short start_addr;
   unsigned short fill[219];
   unsigned short nsegs;
   unsigned short segs[32];
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
      va_start(ap, str);
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

char conv(int x)
{
   // Unsure what EOL 12, del 13, meta 56. Case 23 mapped to esc.
   // Funny 8 65 mapped to $
   // 57 isn't defined, mapped to 0. Also not sure if 70 and 71 should 
   // map to different ". 77 also isn't defined, mapped to 77
   unsigned char lap6_map[] = 
   {'0', '1', '2', '3', '4', '5', '6', '7',    //0x
    '8', '9', '\r', 077, ' ', 'i', 'p', '-',   //1x
    '+', '|', '#', ' ', 'A', 'B', 'C', 'D',    //2x
    'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L',    //3x
    'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',    //4x
    'U', 'V', 'W', 'X', 'Y', 'Z', '\n', 0,      //5x
    027, '=', 'u', ',', '.', '$', '[', '_',    //6x
    '"', '"', '<', '>', ']', '*', ':', 077};   //7x
   if (lap6_mode) {
         return lap6_map[x];
   } else {
      if (x == 037)
         return '\r';
      if (x == 043)
         return '\n';
      if (x == 047)
         return '\t';
      if (x <= 037) 
         return x + 'A' - 1;
      else
         return x + '!' - 041;
   }
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

// Convert DIAL file to OS/8 .SV file
// All the following handle full 32k memory of pdp-8 though dial looks like
// dial can only handle 8k. Dial uses 256 word blocks.
void dump_dial_to_os8_sv(FILE *out, unsigned int mem[], unsigned int start)
{
   struct {
      unsigned short nsegs;
      unsigned short field;
      unsigned short start_addr;
      unsigned short job_status_word;
      struct {
         unsigned short origin;
         unsigned short descr;
      } core[32];
      unsigned short fill[188];
   } hdr;
   int core_ndx = -1;
   int used_blk[16][8];
   int page, block, offset, cntr;
   int mem_addr;
   int active;

   memset(&hdr, 0, sizeof(hdr));
   hdr.field = 06203 | ((start >> 9) & 070);
   hdr.start_addr = start;
   for (page = 7; page >= 0; page--) {
      for (block = 0 ; block < 16; block++) {
         used_blk[block][page] = 0; 
         mem_addr = (page << 12) | (block * 256);
         for (offset = 0; offset < 256; offset++) {
             // Memory not loaded value
             if (mem[mem_addr + offset] != 0xffffffff) {
                used_blk[block][page] = 1;
                break;
             }
         }
      }
      active = 0;
      for (block = 0 ; block < 16; block++) {
         if (used_blk[block][page]) {
            if (active) {
               if ((page == 0 || page == 1) && block == 15) {
                  hdr.core[core_ndx].descr += 0100;
                  //printf("Not loading last field page %d\n",page);
               } else {
                  if ((hdr.core[core_ndx].descr & 03700) >= 03600) 
                     active = 0; 
                  else
                     hdr.core[core_ndx].descr += 0200;
               }
            } 
            if (!active) {
               core_ndx++;
               if (core_ndx > ARRAYSIZE(hdr.core))
                  html_error(0, "Too many core blocks\n");
               hdr.core[core_ndx].origin = block * 256;
               hdr.core[core_ndx].descr = 0200 | (page << 3);
               active = 1;
            }
         } else {
            active = 0;
         }
      }
   }
   hdr.nsegs = -(core_ndx + 1);
   if (!used_blk[0][0] && !used_blk[1][0] && !used_blk[2][0] &&
          !used_blk[3][0])  
      hdr.job_status_word |= 1;
   if (!used_blk[0][1] && !used_blk[1][1] && !used_blk[2][1] &&
          !used_blk[3][1])  
      hdr.job_status_word |= 2;
   dump_image(out, sizeof(hdr)/2,(unsigned short *) &hdr);
   for (page = 7; page >= 0; page--) {
      for (block = 0 ; block < 16; block++) {
         if (used_blk[block][page]) {
            unsigned short buf[256];
            for (cntr = 0; cntr < 256; cntr++)
               buf[cntr] = mem[(page << 12) + block * 256 + cntr];
            dump_image(out, 256, buf);
         }
      }
   }
}

void dump_dial_to_bin(FILE *out, unsigned int mem[], unsigned int start)
{
   unsigned char leader[64];
   unsigned char buf[512];
   int chksum = 0;

   memset(leader, 0x80, sizeof(leader));
   fwrite(leader, 1, sizeof(leader), stdout);
   for (int field = 0; field < 8; field++) {
      int last_offset = -1000;
      for (int offset = 0; offset < 4096; offset++) {
         int loc = field * 4096 + offset;
         // Memory not loaded value
         if (mem[loc] != 0xffffffff) {
            if (offset != last_offset + 1) {
               buf[0] = 0xc0 + (field << 3);
               buf[1] = 0x40 + (offset >> 6);   
               chksum += buf[1];
               buf[2] = (offset & 077);
               chksum += buf[2];
               fwrite(buf, 1, 3, stdout);
            }
            last_offset = offset;
            buf[0] = mem[loc] >> 6;
            chksum += buf[0];
            buf[1] = mem[loc] & 077;
            chksum += buf[1];
            fwrite(buf, 1, 2, stdout);
         }
      }
      buf[0] = (chksum & 07777) >> 6;
      buf[1] = chksum & 077;
      fwrite(buf, 1, 2, stdout);
      fwrite(leader, 1, sizeof(leader), stdout);
   }
}

void dump_dial_binary(FILE *in, int block, int size, BIN_TYPE type, FILE *out,
      int blk_offset) {
   struct dial_hdr hdr;
   unsigned short buf[256];
   int cntr, cntr2;
   unsigned int seg_addrs[ARRAYSIZE(hdr.segs)];
   unsigned int pdp8_mem[32768];
   unsigned int pdp8_start;

   if (fseek(in,01000 * block, SEEK_SET) != 0) 
      html_error(0, "file seek failed\n");
   if (type == TYPE_DUMP) {
      mime_header("application/octet-stream", -1);
      for (cntr = 0; cntr < size; cntr++) {
         if (fread(&buf,sizeof(buf),1,in) < 1)
            html_error(0, "file read failed\n");
         if (fwrite(&buf, sizeof(buf), 1, out) < 1)
            html_error(0, "file write failed\n");
      }
   } else if (type == TYPE_OS8_SV || type == TYPE_BIN) {
      int cntr2 = 0;

      if (fread(&hdr,sizeof(hdr),1,in) < 1) 
         html_error(0, "file read failed\n");
      memset(pdp8_mem, -1, sizeof(pdp8_mem));
      for (cntr = 0; cntr < ARRAYSIZE(hdr.segs); cntr++) {
         if (hdr.segs[cntr] != 0) {
            seg_addrs[cntr2++] = cntr*256; 
         }
      }
      if (cntr2 != hdr.nsegs)
         html_error(0, "Illegal save file header %d %d\n", cntr2, hdr.nsegs);
      if (size != hdr.nsegs + 1)
         html_error(0, "Illegal save file size %d %d\n", size, hdr.nsegs);
      pdp8_start = hdr.start_addr | ((hdr.field & 070) << 9);
      for (cntr = 0; cntr < size - 1; cntr++) {
          unsigned short buf[256];
          if (fread(buf, 2, 256, in) < 256)
             html_error(0, "File read failed\n");
          for (cntr2 = 0; cntr2 < 256; cntr2++) {
             pdp8_mem[seg_addrs[cntr] + cntr2] = buf[cntr2];
          }
      }
      mime_header("application/octet-stream", -1);
      if (type == TYPE_OS8_SV) {
         dump_dial_to_os8_sv(out, pdp8_mem, pdp8_start);
      } else {
         dump_dial_to_bin(out, pdp8_mem, pdp8_start);
      }
   } else if (type == TYPE_IMAGE) {
      mime_header("application/octet-stream", -1);
      for (cntr = 0; cntr < size; cntr++) {
          if (fread(&buf,sizeof(buf),1,in) < 1)
             html_error(0, "File read failed\n");
          dump_image(out, sizeof(buf)/2, buf);
      }
   } else if (type == TYPE_OCTAL) {
      if (fread(&hdr,sizeof(hdr),1,in) < 1) 
         html_error(0, "file read failed\n");

      mime_header("text/html", -1);

      printf("Header:<br>\n");
      printf("Mode %04o Field %04o unknown %04o start %04o nsegs %04o<br>\n",
          hdr.mode, hdr.field, hdr.unknown, hdr.start_addr, hdr.nsegs); 
      for (cntr = 0; cntr < ARRAYSIZE(hdr.segs); cntr++) {
         printf("Segs %2d: %04o<br>\n", cntr, hdr.segs[cntr]);
      }
      printf("Fill:<br>\n");
      for (cntr = 0; cntr < ARRAYSIZE(hdr.fill); cntr++) {
         printf("%04o \n", hdr.fill[cntr]);
         if (cntr % 16 == 15) {
            printf("<br>\n"); 
         }
      }
      printf("<p>\n"); 
      
      for (cntr = 0; cntr < size; cntr++) {
         printf("Block: %d (%04oo)<br>\n",cntr + block + blk_offset, 
                cntr + block + blk_offset);
         if (fread(&buf,sizeof(buf),1,in) < 1)
             html_error(0, "File read failed\n");
         for (cntr2 = 0;  cntr2 < sizeof(buf)/2; ++cntr2) {
            printf("%04o ", buf[cntr2]);
            if (cntr2 % 16 == 15) {
              printf("<br>\n");
            }
         }
      }
   } else {
      html_error(0, "Unknown conversion type %d\n",type);
   }
}

void dump_dial_source(FILE *in, int block, int size, FILE *out) {
   unsigned short temp, temp2[2];
   int cntr;
   unsigned char eof_char[2] = {0, 077};
   int len_words = size * 256;

   if (fseek(in,01000 * block, SEEK_SET) != 0)
      html_error(0, "File seek failed\n");

   if (lap6_mode) {
      if (fread(&temp2,1,4,in) < 4)
	 html_error(0, "File read failed\n");
      if (temp2[0] != 02065 || temp2[1] != 05712) {
         fprintf(out, "Invalid manuscript header %04o %04o\n", temp2[0], temp2[1]);
      }
      len_words -= 4;
   }
   for (cntr = 0; cntr < len_words; cntr++) {
      if (fread(&temp,1,2,in) < 2)
	 html_error(0, "File read failed\n");
      if ((temp >> 6) == eof_char[lap6_mode])
         break;
      fprintf(out, "%c",conv(temp >> 6));
      if ((temp & 077) == eof_char[lap6_mode])
         break;
      fprintf(out, "%c",conv(temp & 077));
   }
   if (cntr == 0)
      fprintf(out, "File is empty\n");
}

struct dirent {
   char fn[32];
   int s_start,s_len;
   int b_start,b_len;
   int used;
};

int dial_dir_sort(const void *comp1,const void *comp2)
{
   const struct dirent *a = comp1;
   const struct dirent *b = comp2;
   return(strcmp(a->fn, b->fn));
}

int get_lap6_mode(FILE *in, int first_block) {
   int lap6_mode = 1;
   unsigned short dir[512];

   if (fseek(in,01000 * (214 - first_block),SEEK_SET) != 0)
      html_error(0, "dir seek failed\n");
   if (fread(dir, sizeof(dir), 1, in) != 1)
      html_error(0, "dir read failed\n");
   if (dir[0] != 05757) {
      if (fseek(in,01000 * (254 - first_block),SEEK_SET) != 0)
         html_error(0, "dir seek failed\n");
      if (fread(dir, sizeof(dir), 1, in) != 1)
         html_error(0, "dir read failed\n");
      if (dir[0] != 05757)  {
         lap6_mode = 0;
      }
   }
   return lap6_mode;
}

void dial_dir(FILE *in, char *infn, char *enc_fn, int sort,int index_mode,
       int first_block) {
   int cntr;
   int dirent;
   unsigned short dir[512];
#define MAX_DIR 64
   struct dirent idir[MAX_DIR];
   char encoded_fn[512];
   char tmpstr[512];
   char *loc;

   if (fseek(in,01000 * (214 - first_block),SEEK_SET) != 0)
      html_error(0, "dir seek failed\n");
   if (fread(dir, sizeof(dir), 1, in) != 1)
      html_error(0, "dir read failed\n");
   if (dir[0] != 05757) {
      if (fseek(in,01000 * (254 - first_block),SEEK_SET) != 0)
         html_error(0, "dir seek failed\n");
      if (fread(dir, sizeof(dir), 1, in) != 1)
         html_error(0, "dir read failed\n");
      if (dir[0] != 05757)  {
         if (fseek(in,01000 * (230 - first_block),SEEK_SET) != 0)
            html_error(0, "dir seek failed\n");
         if (fread(dir, sizeof(dir), 1, in) != 1)
            html_error(0, "dir read failed\n");
      }
   }
   mime_header("text/html", -1);
   printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>Directory of %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> </head> <body>\n",infn);
   printf("<center>Directory of %s</center><br>\n",infn);
   if (index_mode >= 3)
      printf("<!--htdig_noindex-->\n");

   printf("This directory is in the format the DIAL operating\n");
   printf("system uses, where each file name normally has both a source and binary file associated with it.  Each BN column is the number of the first block of the file in octal.  Each BLKS column is the number of 256-word blocks occupied by the file.\n");
   printf("The links below will return the file in\n");
   printf("various formats.\n");
   printf("<p>Clicking the BN link will display source files in ASCII and information on binary files \n");
   printf("with a choice of download formats.\n");
   printf("<br>Clicking the BLKS link will return files in \n");
   printf("<a href='/images/pip_image.shtml'>PIP image</a> format.\n");

   printf("<p><a href='/ftp/%s'>Download this image %s</a><br>",
      infn, infn);

   if (sort)
      printf("<p><a href='dial_html?act=dir;fn=%s;sort=none'>Unsorted Directory Listing</a>", infn);
   else
      printf("<p><a href='dial_html?act=dir;fn=%s;sort=name'>Sort Directory Listing</a>", infn);
   printf("<p><pre>\n");
   if (dir[0] == 05757 && dir[1] == 0) {
      char tapename[9];
      for (cntr = 0; cntr < 4; cntr++) {
         tapename[cntr*2] = conv(dir[cntr+4] >> 6);
         tapename[cntr*2+1] = conv(dir[cntr+4] & 077);
      }
      tapename[8] = 0;
      printf("Index of %s\n\n",tapename);
   }
   if (lap6_mode) {
      printf("         MANUSCRIPT   BINARY  \n"); 
   } else {
      printf("           SOURCE     BINARY  \n"); 
   }
   printf("  Name    BN  BLKS   BN  BLKS\n"); 
   if (index_mode >= 3)
      printf("<!--/htdig_noindex-->\n");
   memset(idir, 0, sizeof(idir));
   for (dirent = 0; dirent < MAX_DIR*8; dirent += 8) {
      int dirnum = dirent / 8;
      if (dir[dirent] == 05757) {
         //printf("Directory entry %d empty\n",dirent/8);
         continue;
      }
      idir[dirnum].used = 1;
      for (cntr = 0; cntr < 4; cntr++) {
         idir[dirnum].fn[cntr*2] = conv(dir[dirent+cntr] >> 6);
         idir[dirnum].fn[cntr*2+1] = conv(dir[dirent+cntr] & 077);
      }
      idir[dirnum].fn[cntr*2] = 0;
      for (cntr = 0; cntr < 8; cntr++) {
         if (idir[dirnum].fn[cntr] == '?')
            idir[dirnum].fn[cntr] = 0;
      }
      idir[dirnum].s_start = dir[dirent+4];
      idir[dirnum].s_len = dir[dirent+5];
      idir[dirnum].b_start = dir[dirent+6];
      idir[dirnum].b_len = dir[dirent+7];
   }
   if (sort) {
      qsort(idir, MAX_DIR, sizeof(idir[0]), dial_dir_sort);
   }
   for (dirent = 0; dirent < MAX_DIR; dirent++) {
      if (!idir[dirent].used)
         continue;
      if (index_mode >= 1)
          printf("<a name='%s'></a>",idir[dirent].fn);

      printf("%-8s ", idir[dirent].fn);
      strcpy(encoded_fn, idir[dirent].fn);
      RFC1630Encode(encoded_fn, sizeof(encoded_fn), 1);
      //CGIEncode(encoded_fn, sizeof(encoded_fn));
      if (idir[dirent].s_start != 05757) {
         printf("<a href='dial_html/%s?act=file;fn=%s;to=ascii;blk=%d,%d'>%4o</a> ", 
             encoded_fn, infn, 
             idir[dirent].s_start,idir[dirent].s_len, idir[dirent].s_start);
         if (index_mode >= 3)
            printf("<!--htdig_noindex-->\n");
         printf("<a href='dial_html/%s?act=file;fn=%s;to=image;blk=%d,%d'>%4o</a>  ", 
             encoded_fn, infn, 
             idir[dirent].s_start,idir[dirent].s_len, idir[dirent].s_len);
      } else
         printf("           ");
      if (idir[dirent].b_start != 05757) {
         printf("<a href='dial_html/%s?act=info;fn=%s;blk=%d,%d'>%4o</a> <a href='dial_html/%s?act=file;fn=%s;to=image;blk=%d,%d'>%4o</a>  ", 
             encoded_fn, infn, 
             idir[dirent].b_start,idir[dirent].b_len, idir[dirent].b_start, 
             encoded_fn, infn, 
             idir[dirent].b_start,idir[dirent].b_len, idir[dirent].b_len);
      } else
         printf("          ");
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

void lap6_info(FILE *in, char *tofn, int start, int blk_offset, int len, 
       char *infn) {

   start -= blk_offset;
   mime_header("text/html", -1);
   printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>Information on file %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> <META NAME=\"robots\" CONTENT=\"noindex, nofollow\"></head> <body>\n",tofn);
   printf("<center>Information on file %s</center><br>\n",tofn);
   printf("File is %d 256 word blocks long<p>\n", len);
   printf("<a href='dial_html/%s?act=file;fn=%s;to=dump;blk=%d,%d'>Convert to 12 bit words in 2 bytes<br>\n",
      tofn, infn, start + blk_offset, len);
   include_file("footer.shtml");
   html_end();
}

void dial_info(FILE *in, char *tofn, int start, int blk_offset, int len, 
       char *infn) {
   struct dial_hdr hdr;
   int cntr;
   int cntr2 = 0;

   start -= blk_offset;
   if (fseek(in,01000 * start,SEEK_SET) != 0) 
      html_error(0, "file seek failed\n");
   if (fread(&hdr,sizeof(hdr),1,in) < 1) 
       html_error(0, "file read failed\n");

   mime_header("text/html", -1);
   printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>Information on file %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> <META NAME=\"robots\" CONTENT=\"noindex, nofollow\"></head> <body>\n",tofn);
   printf("<center>Information on file %s</center><br>\n",tofn);

   if (hdr.mode == 0)
      printf("Program does not autostart.<br>\n");
   else
   if ((hdr.mode & 2))
      printf("Program starts in PDP-8 mode.<br>\n");
   else
      printf("Program starts in LINK mode.<br>\n");
   printf("Start Address %04o, loads in %d 256-word memory blocks.<br>\n", 
         hdr.start_addr, hdr.nsegs);

   printf("Memory blocks used:<br>\n");
   for (cntr = 0; cntr < ARRAYSIZE(hdr.segs); cntr++) {
      if (hdr.segs[cntr] != 0) {
         printf("%05o ",cntr*256);
         cntr2++;
      }
   }
   printf("<br>\n");
   if (cntr2 != hdr.nsegs) 
      printf("Illegal save file segment header %d %d<br>\n", cntr2, hdr.nsegs);
   if (len != hdr.nsegs + 1)
      printf("Illegal save file size %d %d<br>\n", len, hdr.nsegs);
   printf("<a href='dial_html/%s.sv?act=file;fn=%s;to=os8_sv;blk=%d,%d'>Convert to OS/8 SV format</a> in 8 bit <a href='/images/pip_image.shtml'>PIP image</a> format.<br>\n",
      tofn, infn, start + blk_offset, len);
   printf("<a href='dial_html/%s.bn?act=file;to=bin;fn=%s;blk=%d,%d'>Convert to BIN loader format</a><br>\n", 
      tofn, infn, start + blk_offset, len);
   printf("<a href='dial_html/%s?act=file;fn=%s;to=octal;blk=%d,%d'>Octal Dump</a><br>\n",
      tofn, infn, start + blk_offset, len);

   include_file("footer.shtml");
   html_end();
}

void dial_file(FILE *in, char *tofn, int start, int blk_offset, int len, 
      char *to, char *infn, int plain, int index_mode) {
   start -= blk_offset;
   if (strcmp(to, "ascii") == 0) {
      int add_footer = 0;
      //char *host, *referer, *user_agent;
      FILE *outfile;
      
      //host = getenv("HTTP_HOST"); 
      //referer = getenv("HTTP_REFERER"); 
      //user_agent = getenv("HTTP_USER_AGENT");
      if (!plain) {
            // && ((host == NULL || referer == NULL ||
            //strstr(referer,"cgi-bin/htsearch") != NULL ||
            //strstr(referer,host) == NULL) || (user_agent != NULL &&
            //!(strncasecmp(user_agent, "mozilla",7) == 0 ||
            //    strncasecmp(user_agent, "opera",5) == 0)) )) 
	 mime_header("text/html", -1);
	 printf("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"> <html> <head> <title>file %s</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> </head> <body>\n",tofn);
	 printf("<center>File %s</center><br>\n",tofn);
         if (index_mode >= 3)
            printf("<!--htdig_noindex-->\n");
	 printf("<p><a href='../dial_html?act=dir;fn=%s;sort=name'>Directory of image this file is from</a><br>\n",infn);
         printf("<a href='../dial_html/%s?act=file;fn=%s;to=%s;blk=%d,%d;plain=1'>This file as a plain text file</a><br>\n", tofn,
            infn, to, start + blk_offset, len);
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
      dump_dial_source(in, start, len, outfile);
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
   } else if (strcmp(to, "image") == 0) {
      dump_dial_binary(in, start, len, TYPE_IMAGE, stdout, blk_offset);
   } else if (strcmp(to, "os8_sv") == 0) {
      dump_dial_binary(in, start, len, TYPE_OS8_SV, stdout, blk_offset);
   } else if (strcmp(to, "bin") == 0) {
      dump_dial_binary(in, start, len, TYPE_BIN, stdout, blk_offset);
   } else if (strcmp(to, "dump") == 0) {
      dump_dial_binary(in, start, len, TYPE_DUMP, stdout, blk_offset);
   } else if (strcmp(to, "octal") == 0) {
      dump_dial_binary(in, start, len, TYPE_OCTAL, stdout, blk_offset);
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
   struct {
      unsigned short block_size;
      short first_block;
      short first_rev_block;
   } linc_info;

   char fullpath[512];
   char enc_fn[256];
#define MAX_LCL_PATH 64
   struct stat statbuf;

   
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
   fstat(fileno(in), &statbuf);
   if (statbuf.st_size % 512 == 0) {
      linc_info.block_size = 256;
      linc_info.first_block = 0;
      linc_info.first_rev_block = 0;
   } else {
      if (fseek(in, -sizeof(linc_info), SEEK_END) != 0) {
         html_error(0, "file seek failed\n");
      }
      if (fread(&linc_info,sizeof(linc_info),1,in) < 1)  {
          html_error(0, "file info read failed\n");
      }
      //printf("\n\n size %d first %d first rev %d\n",linc_info.block_size,
      //   linc_info.first_block, linc_info.first_rev_block);
   }


   lap6_mode = get_lap6_mode(in, linc_info.first_block);

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

      dial_dir(in, infn, enc_fn, (sort != NULL && strcmp(sort,"name") == 0),
         index_mode, linc_info.first_block);
   } else if (strcmp(action,"file") == 0) {
      int start,len;
      char *blk, *to, *tofn;
      char *plain, *user_agent;
      int index_mode = 0;

      blk = find_val(head, "blk");
      if (blk == NULL) 
         html_error(0, "ERROR: No block specified on file\n");
      if (sscanf(blk, "%d,%d",&start, &len) != 2)
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
      dial_file(in, tofn, start, linc_info.first_block, len, to, infn,
         plain != NULL, index_mode);
   } else if (strcmp(action,"info") == 0) {
      int start,len;
      char *blk,*tofn;

      blk = find_val(head, "blk");
      if (blk == NULL) 
         html_error(0, "ERROR: No block specified on file\n");
      if (sscanf(blk, "%d,%d",&start, &len) != 2)
         html_error(0, "ERROR: Illegal block (%s) specified on file\n", blk);
      tofn = getenv("PATH_INFO");
      if (tofn == NULL || strlen(tofn) < 2) 
         html_error(0, "ERROR: No extract file specified\n");
      tofn++; // Remove leading /
      if (lap6_mode) {
         lap6_info(in, tofn, start, linc_info.first_block, len, infn);
      } else {
         dial_info(in, tofn, start, linc_info.first_block, len, infn);
      }
   } else {
      html_error(0, "ERROR: illegal action %s\n",action);
   }
   return 0;
}
