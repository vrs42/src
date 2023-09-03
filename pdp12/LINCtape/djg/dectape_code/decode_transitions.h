double get_tape_time(int loc);

int decode_transitions(unsigned int deltas[], int num_deltas,
      unsigned char tape_lines[], int max_tape_lines, int tape_index,
      int first_time, int linctape);

