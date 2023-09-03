#include <stdio.h>
#include <fcntl.h>
#include <termios.h>
#include <time.h>
#include <signal.h>
#include <unistd.h>
#include <memory.h>
#include <sys/ioctl.h>

#define ARRAYSIZE(x) (sizeof(x) / sizeof(x[0]))

char conv(int x)
{
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

dump_image(FILE *out, int size, unsigned short *inbuf) {
   int cntr;
   unsigned char outbuf[3];

   for (cntr = 0; cntr < size; cntr += 2) {
      outbuf[0] = inbuf[cntr];
      outbuf[1] = inbuf[cntr+1]; 
      outbuf[2] = ((inbuf[cntr] & 0xf00) >> 4) | (inbuf[cntr+1] >> 8);
      if (fwrite(&outbuf, sizeof(outbuf), 1, out) < 1) {
         perror("Fwrite failed");
         exit(1);
      }
   }
}

dump_os8_sv(FILE *out, int mem[], unsigned int start)
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
                  if (hdr.core[core_ndx].descr & 03700 >= 03600) 
                     active = 0; 
                  else
                     hdr.core[core_ndx].descr += 0200;
               }
            } 
            if (!active) {
               core_ndx++;
               if (core_ndx > ARRAYSIZE(hdr.core)) {
                  printf("Too many core blocks\n");
                  exit(1);
               }
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

dump_binary(char *fn, int block, int size, FILE *in, int type) {
   unsigned short buf[256];
   int cntr;
   char newfn[100];
   struct {
      unsigned short mode;
      unsigned short field;
      unsigned short unknown;
      unsigned short start_addr;
      unsigned short fill[219];
      unsigned short nsegs;
      unsigned short segs[32];
   } hdr;
   unsigned int seg_addrs[ARRAYSIZE(hdr.segs)];
   FILE *out;
   unsigned int pdp8_mem[32768];
   unsigned int pdp8_start;

//return;
   strcpy(newfn,fn);
   strcat(newfn,".BIN");
   out = fopen(newfn, "w");
   if (out == NULL) {
      fprintf(stderr,"%s ",fn);
      perror("file create failed");
      exit(1);
   }
   if (fseek(in,01000 * (block+8),SEEK_SET) != 0) {
      perror("file seek failed");
      exit(1);
   }
   if (fread(&hdr,sizeof(hdr),1,in) < 1) {
       perror("Fread failed");
       exit(1);
   }
   if (hdr.mode == 0)
      printf("No autostart      ");
   else
   if (hdr.mode == 2)
      printf("PDP-8 Mode        ");
   else
      printf("Unknown Mode %04o ",hdr.mode);
   printf("start %04o segments %3d", hdr.start_addr, hdr.nsegs);
   if (type == 2) {
      if (fwrite(&hdr, sizeof(hdr), 1, out) < 1) {
         perror("Fwrite failed");
         exit(1);
      }
      for (cntr = 1; cntr < size; cntr++) {
         if (fread(&buf,sizeof(buf),1,in) < 1) {
            perror("Fread failed");
            exit(1);
         }
         if (fwrite(&buf, sizeof(buf), 1, out) < 1) {
            perror("Fwrite failed");
            exit(1);
         }
      }
   } else
   if (type == 1) {
      int cntr2 = 0;
      memset(pdp8_mem, -1, sizeof(pdp8_mem));
      for (cntr = 0; cntr < ARRAYSIZE(hdr.segs); cntr++) {
         if (hdr.segs[cntr] != 0) {
            seg_addrs[cntr2++] = cntr*256; 
         }
      }
      if (cntr2 != hdr.nsegs) {
         printf("Illegal save file header %d %d\n", cntr2, hdr.nsegs);
         exit(1);
      }
      if (size != hdr.nsegs + 1) {
         printf("Illegal save file size %d %d\n", size, hdr.nsegs);
         exit(1);
      }
      pdp8_start = hdr.start_addr | ((hdr.field & 070) << 9);
      for (cntr = 0; cntr < size - 1; cntr++) {
          unsigned short buf[256];
          if (fread(buf, 2, 256, in) < 256) {
             perror("Fread failed");
             exit(1);
          }
          for (cntr2 = 0; cntr2 < 256; cntr2++) {
             pdp8_mem[seg_addrs[cntr] + cntr2] = buf[cntr2];
          }
      }
      dump_os8_sv(out, pdp8_mem, pdp8_start);
   } else {
      dump_image(out, sizeof(hdr)/2,(unsigned short *) &hdr);
      for (cntr = 1; cntr < size; cntr++) {
          if (fread(&buf,sizeof(buf),1,in) < 1) {
             perror("Fread failed");
             exit(1);
          }
         dump_image(out, sizeof(buf)/2, buf);
      }
   }
   fclose(out);
}

dump_source(char *fn, int block, int size, FILE *in) {
   FILE *out;
   unsigned short temp;
   int cntr;
   char newfn[100];

   strcpy(newfn,fn);
   strcat(newfn,".SRC");
   out = fopen(newfn, "w");
   if (out == NULL) {
      fprintf(stderr,"%s ",fn);
      perror("file create failed");
      exit(1);
   }
   if (fseek(in,01000 * (block+8),SEEK_SET) != 0) {
      perror("file seek failed");
      exit(1);
   }

   for (cntr = 0; cntr < size * 256; cntr++) {
      if (fread(&temp,1,2,in) < 2) {
	 perror("Fread failed");
         exit(1);
      }
      if ((temp >> 6) == 0)
         break;
      fprintf(out, "%c",conv(temp >> 6));
      if ((temp & 077) == 0)
         break;
      fprintf(out, "%c",conv(temp & 077));
   }
   fclose(out);
}
unsigned short dir[512];
main()
{
   FILE *in;
   char fn[100];
   int cntr;
   int dirent;

   fprintf(stderr,"Enter file name\n");
   fgets(fn,sizeof(fn),stdin);
   fn[strlen(fn)-1] = 0;
   in = fopen(fn,"r");
   if (in == NULL) {
      perror("Open failed");
      exit(1);
   }
   if (fseek(in,01000 * 238,SEEK_SET) != 0) {
      perror("dir seek failed");
      exit(1);
   }
   if (fread(dir, sizeof(dir), 1, in) != 1) {
      perror("dir read failed");
      exit(1);
   }

   for (dirent = 0; dirent < 512; dirent += 8) {
if (dirent == 54*8) {
   printf("Hi\n");
}
      if (dir[dirent] == 05757) {
         printf("Directory entry %d empty\n",dirent/8);
         continue;
      }
      for (cntr = 0; cntr < 4; cntr++) {
         fn[cntr*2] = conv(dir[dirent+cntr] >> 6);
         fn[cntr*2+1] = conv(dir[dirent+cntr] & 077);
      }
      fn[cntr*2] = 0;
      for (cntr = 0; cntr < 8; cntr++) {
         if (fn[cntr] == '?')
            fn[cntr] = 0;
      }
      printf("%-8s ", fn);
      if (dir[dirent+4] != 05757) {
         printf("%4o %4o ", dir[dirent+4], dir[dirent+5]);
         dump_source(fn, dir[dirent+4], dir[dirent+5], in);
      } else
         printf("          ");
      if (dir[dirent+6] != 05757) {
         printf("%4o %4o ", dir[dirent+6], dir[dirent+7]);
         dump_binary(fn, dir[dirent+6], dir[dirent+7], in, 1);
      } else
         printf("          ");
      printf("\n");
   }
}

