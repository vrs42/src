int linctape_decode (FILE *out, unsigned char *tape_lines_in,
   int tape_line_count_in , int reverse, int streaming_in);

int linctape_decode_retry (FILE *out, unsigned char *tape_lines_in,
   int tape_line_count_in , int reverse, int streaming_in);

void linctape_update_tape_line_count(int tape_line_count_in, int stream_done);

void linctape_get_stats(int *exp_block_count_ret, int *block_count_ret,
          int *bad_format_count_ret, int *bad_checksum_count_ret);
