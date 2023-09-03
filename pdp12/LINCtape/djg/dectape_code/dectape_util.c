#include <stdio.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#include "cmd.h"
#include "dectape_decode.h"
#include "linctape_decode.h"
#include "decode_transitions.h"

#define MAX_DELTAS (1<<20)
#define MAX_TAPE_LINES 2500000
unsigned char tape_lines [MAX_TAPE_LINES];

int read_tape(unsigned int deltas[], int max_deltas, char *fn)
{
   static int fd = -1;
   int bytes;

   if (fd == -1) {
      fd = open(fn,O_RDONLY);
      if (fd < 0) {
         perror("input open failed");
         exit(1);
      }
   }
   if (read(fd, &bytes, sizeof(bytes)) > 0) {
      if (bytes/4 >= max_deltas) {
         printf("Too many deltas\n");
         exit(1);
      }
      read(fd, deltas, bytes);
      return bytes/4;
   } else {
      return -1;
   }
}

int main (int argc, char *argv[])
{
   unsigned int deltas[MAX_DELTAS];
   int num_deltas;
   int tape_index;
   int tot_deltas = 0;
   int first_time = 1;
   int reverse = 0;
   int linctape = 0;
   FILE *out;
   int i;
   char *fn = "deltas";
   int exp_block_count, block_count, bad_format_count, bad_checksum_count;
   int data_mode = 12;


   i = 1;
   while (argc > 1) {
      if (strcmp (argv [i], "-12") == 0)
         data_mode = 12;
      else if (strcmp (argv [i], "-16") == 0)
         data_mode = 16;
      else if (strcmp (argv [i], "-18") == 0)
         data_mode = 18;
      else if (strcmp (argv [i], "-36") == 0)
         data_mode = 36;
      else if (strcmp (argv [i], "-r") == 0)
         reverse = 1;
      else if (strcmp(argv[i], "-l") == 0) 
         linctape = 1;
      else
         fn = argv[i];
      argc--;
      i++;
   }
   tape_index = 0;

   while ((num_deltas = read_tape(deltas, MAX_DELTAS, fn)) > 0) {
      tot_deltas += num_deltas;
      tape_index = decode_transitions(deltas, num_deltas, 
         tape_lines, MAX_TAPE_LINES, tape_index, first_time, linctape);
      first_time = 0;
   }
   out = fopen("decoded", "w");
   if (out == NULL) {
      perror("Unable to open output file");
      exit(1);
   }
   if (linctape) {
      linctape_decode(out, tape_lines, tape_index, reverse, 0);

      linctape_get_stats(&exp_block_count, &block_count, &bad_format_count,
                &bad_checksum_count);
      fprintf(stderr, "Expected %d block, got %d. %d format errors, %d checksum errors\n", exp_block_count, block_count, bad_format_count,
            bad_checksum_count);
   } else {
      dectape_decode(out, tape_lines, tape_index, reverse, 0, data_mode, 0);

      get_stats(&exp_block_count, &block_count, &bad_format_count,
                &bad_checksum_count);
      fprintf(stderr, "Expected %d block, got %d. %d format errors, %d checksum errors\n", exp_block_count, block_count, bad_format_count,
            bad_checksum_count);
   }

   return 0;
}

int reverse_tape(int dir)
{
   printf("Eror, reverse_tape called\n");
   exit(1);
}

