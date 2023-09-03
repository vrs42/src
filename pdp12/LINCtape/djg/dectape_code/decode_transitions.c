#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "cmd.h"
#define CLOCK_RATE 200000000
#define TEN_US (CLOCK_RATE / 100000)

#define ARRAYSIZE(x) (sizeof(x) / sizeof(x[0]))

#define MAX_TAPE_LINES 1500000
long long tape_time[MAX_TAPE_LINES];

double get_tape_time(int loc) {
   if (loc < MAX_TAPE_LINES) {
      return tape_time[loc] / (double) CLOCK_RATE;
   } else {
      return 0;
   }
}

void dump_data(int tape_index, long long clock_time, int data, int last_data,
 unsigned char tape_lines[], float avg_clock_rate, long long cur_time) {
   static long long last_clock_time;
   static int last_tape_lines = 0;

#define START (550)
static FILE *clk_file = NULL;
static FILE *data_file = NULL;
if (tape_index > START-70 && tape_index <= START+10) {
if (clk_file == NULL) {
   clk_file = fopen("clk.csv","w");
   data_file = fopen("data.csv","w");
}
if (clock_time != last_clock_time ) {
   fprintf(clk_file, "%.8f, %d\n", clock_time / (double) CLOCK_RATE, 0);
   fprintf(clk_file, "%.8f, %d\n", clock_time / (double) CLOCK_RATE, 1);
   fprintf(clk_file, "%.8f, %d\n", (clock_time + avg_clock_rate * .5) / (double) CLOCK_RATE, 1);
   fprintf(clk_file, "%.8f, %d\n", (clock_time + avg_clock_rate * .5) / (double) CLOCK_RATE, 0);
   last_clock_time = clock_time;
}

fprintf(data_file, "%.8f, %d, %d, %d, %d, %d, %o, %d\n", cur_time / (double) CLOCK_RATE,
   last_data & R31_RTT_MASK, last_data & R31_RMT_MASK, last_data & R31_RD0_MASK,
   last_data & R31_RD1_MASK, last_data & R31_RD2_MASK, last_tape_lines,
   tape_index-1);
fprintf(data_file, "%.8f, %d, %d, %d, %d, %d %o, %d\n", cur_time / (double) CLOCK_RATE,
   data & R31_RTT_MASK, data & R31_RMT_MASK, data & R31_RD0_MASK,
   data & R31_RD1_MASK, data & R31_RD2_MASK, tape_lines[tape_index-1],
   tape_index-1);
   last_tape_lines = tape_lines[tape_index-1];
} else {
   if (clk_file != NULL) {
      fclose(clk_file);
      fclose(data_file);
      clk_file = NULL;
      data_file = NULL;
   }
}
}

int decode_transitions(unsigned int deltas[], int num_deltas,
    unsigned char tape_lines[], int max_tape_lines, int tape_index, 
    int first_time, int linctape)
{
   static float avg_clock_rate = 7100;
   static int last_data;
   static long long last_tt_time;
   static long long cur_time;
   static long long time_wrap;
   int i, j;
   static int data;
   static long long last_edge_time[4];
   int bit_masks[4] = 
     {R31_RD2_MASK, R31_RD1_MASK, R31_RD0_MASK, R31_RMT_MASK};
   static int data_written;

   if (first_time) {
      data = deltas[0] >> 24;
      last_data = ((data ^ (R31_RMT_MASK | R31_RTT_MASK)) & 0xff);
      last_tt_time = 0;
      cur_time = 0;
      time_wrap = 0;
      data_written = 1;
   }
   for (i = 0; i < num_deltas; i++) {
      cur_time = (deltas[i] & 0xffffff) + time_wrap;
      if (cur_time < last_tt_time) {
         time_wrap += 0x1000000;
         cur_time += 0x1000000;
      }

      if (!data_written && cur_time > last_tt_time + .6e-6 * CLOCK_RATE) {
            tape_lines[tape_index] = 0;
            for (j = 0; j < ARRAYSIZE(bit_masks); j++) {
#if 0
               if (cur_time - last_edge_time[j] < .0e-6*CLOCK_RATE) {
                  if (!(data & bit_masks[j])) {
                     tape_lines[tape_index] |= 1 << j;
                  }
               } else {
#endif
                  if (data & bit_masks[j]) {
                     tape_lines[tape_index] |= 1 << j;
                  }
#if 0
               }
#endif
            }
            if (tape_index < max_tape_lines-1) {
               tape_index++;
            } else {
               printf("Tape lines overflow\n");
               exit(1);
            }
            if (tape_index < MAX_TAPE_LINES) {
               tape_time[tape_index] = cur_time;
            }
         data_written = 1;
      }
      data = deltas[i] >> 24;
      data = ((data ^ (R31_RMT_MASK | R31_RTT_MASK)) & 0xff);
      for (j = 0; j < ARRAYSIZE(bit_masks); j++) {
         if ((data & bit_masks[j]) ^ (last_data & bit_masks[j])) {
            last_edge_time[j] = cur_time;
         }
      }
      if ((!linctape && (data & R31_RTT_MASK) && !(last_data & R31_RTT_MASK)) ||
           (linctape && !(data & R31_RTT_MASK) && (last_data & R31_RTT_MASK))) {
         avg_clock_rate = avg_clock_rate * .80 + 
            (cur_time - last_tt_time) * .20;

         if (0 && cur_time - last_tt_time > avg_clock_rate * 1.5 ) {
            printf("Long RTT transition %f us clk %f time %f\n",
              (cur_time - last_tt_time) / (float) CLOCK_RATE * 1e6,
              avg_clock_rate / (float) CLOCK_RATE * 1e6,
              cur_time / (float) CLOCK_RATE);
         }
         if (0 && cur_time - last_tt_time < avg_clock_rate * .5 ) {
            printf("Short RTT transition ignored %f us clk %f time %f\n",
              (cur_time - last_tt_time) / (float) CLOCK_RATE * 1e6,
              avg_clock_rate / (float) CLOCK_RATE * 1e6,
              cur_time / (float) CLOCK_RATE);
         } else {
            last_tt_time = cur_time;
            data_written = 0;
         }
      }
#if 1
      dump_data(tape_index, 0, data, last_data, tape_lines, 
           0, cur_time);
#endif
      last_data = data;
   }
   return tape_index;
}
