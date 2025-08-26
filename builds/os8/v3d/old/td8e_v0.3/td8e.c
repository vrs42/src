/* File: td8.c
   Author: Gerold Pauler, 10711 Berlin, Germany
   Date: Nov 22, 2003
   Language: C (UNIX)
   Purpose: DEC TD8 TU56 tape interface

   Based on the pdp8 emulator of Douglas Jones
   and on the description in the
   pdp8/e pdp8/f pdp8/m Maintenance Man. Digital Equipment Corporation, 1972.
   Small Computer Handbook Digital Equipment Corporation, 1966/67, 1967 or 1973.
   TD8E DECtape Diagnostic Digital Equipment Corporation, 1971,72.

   This Version supports two differnt modes and two different
   file formats.

   First supported files format is the "OS/8 129 words per block
   format to directly support the tape images found on various web sites.
   Refered to HLS (high level simulation) later.
   
   Second supported file format is a more low level format with one nibble
   per single line (one mark bit and three data bits). This file format
   is recognized by the string "tu56" as the first four characters.
   Refered to LLS (low level simulation) later.

   Additional blocking read/write implemented
*/

#include "realtime.h"
#include "bus.h"
#include <stdio.h>

/*
 * debugging
 */
#ifdef DEBUG
#define PRINTDEB printf
#else
#define PRINTDEB
#endif

/*
 * rename global vars to get a different set per td8e device
 */
#undef TAPE
#ifdef TD8E0
#define TAPE	td8e0
#define TAPE1	"DTA0"
#define TAPE2	"DTA1"
#define TAPES1	"-- TU56 tape drive 1     "
#define TAPES2	"-- TU56 tape drive 2     "
#define wtm_switch	td8e0_wtm
#define TAPE_dev	td8e0_dev
#define TAPE_init	td8e0_init
#define TAPE_power	td8e0_power
#define tape_name	td8e0_name
#define current_line	td8e0_cline
#define TAPE_wrt_lck	td8e0_wlock
#define TAPE_select	td8e0_select
#define command_register	td8e0_cr
#define data_register		td8e0_dr
#endif
#ifdef TD8E1
#define TAPE	td8e1
#define TAPE1	"DTA2"
#define TAPE2	"DTA3"
#define TAPES1	"-- TU56 tape drive 3     "
#define TAPES2	"-- TU56 tape drive 4     "
#define TAPE_dev	td8e1_dev
#define wtm_switch	td8e1_wtm
#define TAPE_init	td8e1_init
#define TAPE_power	td8e1_power
#define tape_name	td8e1_name
#define current_line	td8e1_cline
#define TAPE_wrt_lck	td8e1_wlock
#define TAPE_select	td8e1_select
#define command_register	td8e1_cr
#define data_register		td8e1_dr
#endif
#ifdef TD8E2
#define TAPE	td8e2
#define TAPE1	"DTA4"
#define TAPE2	"DTA5"
#define TAPES1	"-- TU56 tape drive 5     "
#define TAPES2	"-- TU56 tape drive 6     "
#define TAPE_dev	td8e2_dev
#define wtm_switch	td8e2_wtm
#define TAPE_init	td8e2_init
#define TAPE_power	td8e2_power
#define tape_name	td8e2_name
#define current_line	td8e2_cline
#define TAPE_wrt_lck	td8e2_wlock
#define TAPE_select	td8e2_select
#define command_register	td8e2_cr
#define data_register		td8e2_dr
#endif
#ifdef TD8E3
#define TAPE	td8e3
#define TAPE1	"DTA6"
#define TAPE2	"DTA7"
#define TAPES1	"-- TU56 tape drive 7     "
#define TAPES2	"-- TU56 tape drive 8     "
#define TAPE_dev	td8e3_dev
#define wtm_switch	td8e3_wtm
#define TAPE_init	td8e3_init
#define TAPE_power	td8e3_power
#define tape_name	td8e3_name
#define current_line	td8e3_cline
#define TAPE_wrt_lck	td8e3_wlock
#define TAPE_select	td8e3_select
#define command_register	td8e3_cr
#define data_register		td8e3_dr
#endif
#ifndef TAPE
#define TAPE	td8e0
#define TAPE1	"DTA0"
#define TAPE2	"DTA1"
#define TAPES1	"-- TU56 tape drive 1     "
#define TAPES2	"-- TU56 tape drive 2     "
#define TAPE_dev	td8e0_dev
#define wtm_switch	td8e0_wtm
#define TAPE_init	td8e0_init
#define TAPE_power	td8e0_power
#define TAPE_name	td8e0_name
#define current_line	td8e0_cline
#define TAPE_wrt_lck	td8e0_wlock
#define TAPE_select	td8e0_select
#define command_register	td8e0_cr
#define data_register		td8e0_dr
#endif



/*
 *  TU56 physical tape layout
 *
 * LINES_PER_WORD is the only definition needed for HLS
 * Rest of line definitions are used for HLS
 */
#define LINES_PER_WORD     4L
#define LINES_PER_CELL     6L

#define CELLS_PER_BLOCK   96L
#define WORDS_PER_BLOCK  129L
#define BLOCKS_PER_TAPE 1474L

#define CELLS_PER_TAPE (BLOCKS_PER_TAPE * CELLS_PER_BLOCK)
#define LINES_PER_TAPE (CELLS_PER_TAPE * LINES_PER_CELL)

#define MIN_LINE           0L
#define MAX_LINE (LINES_PER_TAPE - 1L)

/*
 * The following defines will be used by HLS and LLS
 */
#define START_LINE 100000

#define REV_END_MARK     055
#define INTER_BLOCK      025
#define BLOCK_MARK       026
#define REV_GUARD_MARK   032
#define BLOCK_START      010
#define DATA_MARK        070
#define BLOCK_END        073
#define GUARD_MARK       051
#define REV_BLOCK_MARK   045
#define END_MARK         022

/*
 * delays
 */

/* TD8E interface to TU56 controller delay, per data chunk */
#define single_line_time ((30 * microsecond) / IOFUDGE ) /* 3-bit Bytes */

/* TU56 seek times */
#define uts_time         ((120 * millisecond) / IOFUDGE )

/*
 * bytes 0 through 3 are "tu56" for LLS only
 * so TAG_LENGTH is only needed for LLS and
 * to distinguish between LLS and HLS
 */

#define TAG_LENGTH 4
static int lls_flag[2];
long current_line[2];
static int cell[CELLS_PER_BLOCK + 1];


/*********************************************************/
/* Interface between device implementation and "console" */
/*********************************************************/

/*
 * wtm and write lock switches are set by TU56 gui
 */
int wtm_switch = 0;
int TAPE_wrt_lck[2] = { 0, 0 };
int TAPE_select;

static int old_wtm_switch = 0;
static int tape_wlck[2] = { 0, 0 };

/* files used to simulate the device */
static FILE *tape[2];
char tape_name[2][NAME_LENGTH];
static char tape_tag[2][TAG_LENGTH];

/* timers used to simulate delays between I/O initiation and completion */
static struct timer td8e_delay;
static struct timer tu56_delay[2];

static tape_close(u)
int u;
{
	if ( NULL != tape[u] ) {
		fclose( tape[u] );
		tape[u] = NULL;
		tape_name[u][0] = '\0';
	}
}

static int tape_open(u, f)
int u;
char * f;
{
	tape_close(u);
	TAPE_wrt_lck[u] = 0;
	tape_wlck[u] = 0;
	set_file_name( tape_name[u], f );
	if ( NULL == (tape[u] = fopen(tape_name[u], "r+")) ) { /* can't open */
		if ( NULL == (tape[u] = fopen(tape_name[u], "r")) ) {
			tape_name[u][0] = '\0';
		}
		else { /* could open WRITE LOCKED */
			TAPE_wrt_lck[u] = 1;
			tape_wlck[u] = 1;
		}
	}
	if ( NULL != tape[u] ) { /* the file exists, is it LLS or HLS ? */
		if ( 1 == fread(tape_tag[u], TAG_LENGTH, 1, tape[u]) ) {
			/* tag readable */
			if (('t' != tape_tag[u][0]) || ('u' != tape_tag[u][1])
			 || ('5' != tape_tag[u][2]) || ('6' != tape_tag[u][3])) {
				/* HLS */
				lls_flag[u] = 0;
			}
			else {
				/* LLS */
				lls_flag[u] = TAG_LENGTH;
			}
		} else { /* could not read tag */
			tape_close(u);
		};
	}
	current_line[u] = START_LINE; /* should be randomized */
	return (tape[u] != NULL);
}

TAPE_power() /* power-on initialize */
{
	int i = 0;
	int j = 0;

	/*
	 * cell array only needed for HLS
	 */
	cell[i++] = INTER_BLOCK;
	cell[i++] = BLOCK_MARK;
	cell[i++] = REV_GUARD_MARK;
	for ( j=1; 4 >= j; j++ ) {
		cell[i++] = BLOCK_START;
	}	
	for ( j=1; 82 >= j; j++ ) {
		cell[i++] = DATA_MARK;
	}
	for ( j=1; 4 >= j; j++ ) {
		cell[i++] = BLOCK_END;
	}	
	cell[i++] = GUARD_MARK;
	cell[i++] = REV_BLOCK_MARK;
	cell[i++] = INTER_BLOCK;
	cell[i] = END_MARK;

	tape[0] = NULL;
	tape[1] = NULL;
	tape_name[0][0] = '\0';
	tape_name[1][0] = '\0';
	init_timer( td8e_delay );
	init_timer( tu56_delay[0] );
	init_timer( tu56_delay[1] );
	register_device( tape_open, tape_close, 1, TAPE2, TAPES2,
			 tape_name[1] );
	register_device( tape_open, tape_close, 0, TAPE1, TAPES1,
			 tape_name[0] );
	wtm_switch = 0;
	old_wtm_switch = 0;
}


/*************************************/
/* "officially visible" device state */
/*************************************/
static int diff_command_register = 0;
int command_register = 0;
static int mark_track = 0;

#define unit       ((command_register >> 11) & 1)
#define direction  ((command_register >> 10) & 1)
#define stop_go    ((command_register >> 9) & 1)
#define read_write ((command_register >> 8) & 1)
#define write_lock ((command_register >> 7) & 1)
#define sel_tm_err ((command_register >> 6) & 1)

#define set_sel_tm_err (command_register = (command_register & 07377) | 0100)
#define set_write_lock (command_register = (command_register & 07377) | 0200)

int data_register = 0;

static int single_line_flag = 0;
static int quad_line_flag = 0;

static int uts = 0;
static int tape_dir[2]     = { 0, 0 };
static int tape_uts_dir[2] = { 0, 0 };
static int tape_qlines[2]  = { 0, 0 };

/*************************/
/* Device implementation */
/*************************/

/*
 * blocking read/write implementation for better performance
 * implemented for little endian only
 */
#define new_idx (pos / 4L / WORDS_PER_BLOCK)
#define	base    (new_idx * 4L * WORDS_PER_BLOCK)
#define	offset  ((pos - base) / 4L)
#define nibble  ((pos - base) % 4L)

static unsigned short buffer[2][129];
static int buffer_idx[2] = { -1, -1 };
static int buffer_mod[2] = { 0, 0 };

static int bget(u, pos)
int u;
long pos;
{
	if ( new_idx != buffer_idx[u] ) {
		if ( 0 != buffer_mod[u] ) { /* save old buffer first */
			fseek( tape[u],
			       (long)(buffer_idx[u] * WORDS_PER_BLOCK * 2L),
			       SEEK_SET );
			if ( WORDS_PER_BLOCK != fwrite(buffer[u], 2,
					WORDS_PER_BLOCK, tape[u]) ) {
				command_register |= 1 << 7;
				set_sel_tm_err;
				return 0;
			}
		}
		fseek( tape[u],
			(long)(new_idx * WORDS_PER_BLOCK * 2L),
			SEEK_SET );
		if ( WORDS_PER_BLOCK != fread(buffer[u], 2,
					WORDS_PER_BLOCK, tape[u]) ) {
			set_sel_tm_err;
			return 0;
		}
		buffer_idx[u] = new_idx;
		buffer_mod[u] = 0;
	}
	return 1;
}

static int bread(u, pos, data, len)
int u;
long pos;
unsigned short *data;
int len;
{
	if ( 0 > pos ) {
		pos = 0;
	}
	if ( 0 == bget(u, pos) ) {
		return 0;
	}
	/*
	 * copy from buffer to data
	 */
	if ( TAG_LENGTH == lls_flag[u] ) { /* LLS */
		switch (nibble) {
#ifdef BIGENDIAN
		case 0:
			*data = ( buffer[u][offset] >> 12) & 017;
			break;	
		case 1:
			*data = ( buffer[u][offset] >> 8) & 017;
			break;	
		case 2:
			*data = ( buffer[u][offset] >> 4) & 017;
			break;	
		case 3:
			*data = ( buffer[u][offset] >> 0) & 017;
			break;	
#else
		case 0:
			*data = ( buffer[u][offset] >> 4) & 017;
			break;	
		case 1:
			*data = ( buffer[u][offset] >> 0) & 017;
			break;	
		case 2:
			*data = ( buffer[u][offset] >> 12) & 017;
			break;	
		case 3:
			*data = ( buffer[u][offset] >> 8) & 017;
			break;	
#endif
		}
	}
	else { /* HLS */
#ifdef BIGENDIAN
		*data = ( ((buffer[u][offset] & 0xff00) >> 8) |
			  ((buffer[u][offset] & 0x00ff) << 8) );
#else
		*data = buffer[u][offset];
#endif
	}
	return len;
}

static int bwrite( u, pos, data, len )
int u;
long pos;
unsigned short *data;
int len;
{ 
	if ( 0 > pos ) {
		pos = 0;
	}
	if ( 0 == bget(u, pos) ) {
		return 0;
	}
	/*
	 * copy from data to buffer
	 */
	buffer_mod[u] = 1;
	if ( TAG_LENGTH == lls_flag[u] ) { /* LLS */
		switch (nibble) {
#ifdef BIGENDIAN
		case 0:
			buffer[u][offset] = (buffer[u][offset] & 0x0fff) |
						((*data & 0xf) << 12);
			break;	
		case 1:
			buffer[u][offset] = (buffer[u][offset] & 0xf0ff) |
						((*data & 0xf) << 8);
			break;	
		case 2:
			buffer[u][offset] = (buffer[u][offset] & 0xff0f) |
						((*data & 0xf) << 4);
			break;	
		case 3:
			buffer[u][offset] = (buffer[u][offset] & 0xfff0) |
						((*data & 0xf) << 0);
			break;	
#else
		case 0:
			buffer[u][offset] = (buffer[u][offset] & 0xff0f) |
						((*data & 0xf) << 4);
			break;	
		case 1:
			buffer[u][offset] = (buffer[u][offset] & 0xfff0) |
						((*data & 0xf) << 0);
			break;	
		case 2:
			buffer[u][offset] = (buffer[u][offset] & 0x0fff) |
						((*data & 0xf) << 12);
			break;	
		case 3:
			buffer[u][offset] = (buffer[u][offset] & 0xf0ff) |
						((*data & 0xf) << 8);
			break;	
#endif
		}
	}
	else { /* HLS */
#ifdef BIGENDIAN
		buffer[u][offset] = ( ((*data & 0xff00) >> 8) |
			  ((*data & 0x00ff) << 8) );
#else
		buffer[u][offset] = *data;
#endif
	}
	return len;
}

/*
 * checksum generation (HLS only)
 */
static int checksum( block, u )
int block, u;
{
	int i = 0;
	int cs = 0;
	long pos = (long)block * WORDS_PER_BLOCK * 4L;
	
	if ( 0 > pos ) {
		pos = 0;
	}
	if ( 0 == bget(u, pos) ) {
		return 0;
	}
	for ( i = 0; WORDS_PER_BLOCK > i; i++ ) {
#ifdef BIGENDIAN
		cs ^= ( (((buffer[u][i] & 0xff00) >> 8) |
			((buffer[u][i] & 0x00ff) << 8))  & 077);
		cs ^= ( ((((buffer[u][i] & 0xff00) >> 8) |
			((buffer[u][i] & 0x00ff) << 8)) >> 6 ) & 077);
#else
		cs ^= (buffer[u][i] & 077);
		cs ^= (buffer[u][i] >> 6) & 077;
#endif
		cs &= 077;
	}
	return( (cs << 6) & 07700 );
}

/*
 * defines for HLS only
 */
#define current_cell  (int)((current_line[u] / LINES_PER_CELL) \
				% CELLS_PER_BLOCK)
#define current_block (int)((current_line[u] / LINES_PER_CELL) \
				/ CELLS_PER_BLOCK)


static void tu56_event(u)
int u;
{ /* called from timer as each 3bit line spins by tape head */
	int markbit = 0;
	unsigned short tmp_data = 0; 
	long int lower_limit = 0L;
	long int upper_limit = MAX_LINE + 4096L;
	long int current_word = 0L;	/* HLS only */	
	long int block_line = 0L;	/* HLS only */	

	TAPE_wrt_lck[0] |= tape_wlck[0];
	TAPE_wrt_lck[1] |= tape_wlck[1];

	if ( unit != u ) {
		/*
		 * unit not selected
		 *    so do not mess up TD8E registers
		 */ 
		/* schedule next line to spin by head */
		schedule( &tu56_delay[u], single_line_time, tu56_event, u );
		return;
	}

	if ( NULL == tape[u] ) {
		set_sel_tm_err;
		/* schedule next line to spin by head */
		schedule( &tu56_delay[u], single_line_time, tu56_event, u );
		return;
	}

	/*
	 * if wtm just switched on
	 *    set current line of both tapes to begin of tape
	 */
	if ( (0 == old_wtm_switch) && (1 == wtm_switch) ){
		current_line[0] = 0L;
		current_line[1] = 0L;
	}
	old_wtm_switch = wtm_switch;

	if ( TAG_LENGTH == lls_flag[u] ) { /* LLS */
		lower_limit = MIN_LINE;
		upper_limit = MAX_LINE * 2L;
	}
	else { /* HLS */
		lower_limit = MIN_LINE - 4096L;
		upper_limit = MAX_LINE + 4096L;
	}

	if ( 1 == stop_go ) {
		if ( 1 == uts ) {
			single_line_flag = 1;
			tape_qlines[u] = ++tape_qlines[u] % LINES_PER_WORD;
			if ( 0 == tape_qlines[u] ) {
				if ( 1 == quad_line_flag ) {
					set_sel_tm_err;
				}
				quad_line_flag = 1;
			}
		}
		else {
			/* generate single line clock pulses when wtm is on */
			single_line_flag = wtm_switch;
			quad_line_flag = 0;
		}

		/* make it spin even on speedup*/
		if ( 0 == tape_dir[u] ) {
			current_line[u]++;
			if (current_line[u] > upper_limit) {
				current_line[u] = upper_limit - 5L;
			}
		}
		else {
			current_line[u]--;
			if (current_line[u] < lower_limit) {
				current_line[u] = lower_limit + 5L;
			}
		}
	}
	else { /* stop_go = 0 */
		/* generate single line clock pulses when wtm is on */
		single_line_flag = wtm_switch;
		quad_line_flag = 0;
		if ( 0 == uts ) {
			/* spin on break till uts timed out*/
			if ( 0 == tape_dir[u] ) {
				current_line[u]++;
				if (current_line[u] > upper_limit) {
					current_line[u] = upper_limit - 5L;
				}
			}
			else {
				current_line[u]--;
				if (current_line[u] < lower_limit) {
					current_line[u] = lower_limit + 5L;
				}
			}
		}
	}

	if ( TAG_LENGTH == lls_flag[u] ) {	/* LLS */
		if ( 1 != bread(u, (long)(current_line[u] + TAG_LENGTH),
				&tmp_data, 1) ) {
			set_sel_tm_err;
		}
		if ( 1 == tape_dir[u] ) {
			tmp_data ^= 017;
		}
		markbit = (tmp_data >> 3) & 01;
		if ( (1 == stop_go) && (1 == uts) ) {
			mark_track = ( (mark_track << 1) & 076 ) | markbit;
			command_register = ( command_register & 07700 ) |
						mark_track;
			if ( 0 == read_write ) { /* read */
				data_register = ((data_register << 3) & 07770) |
						(tmp_data & 07);
			}
			else { /* write */
				if ( 0 == wtm_switch ) { /* write data */
					tmp_data = ( tmp_data & 010 ) |
						((data_register & 07000) >> 9);
				}
				else { /* write mark track */
					tmp_data = ( tmp_data & 07 ) |
						((data_register & 04000) >> 8);
				}
				data_register = (data_register << 3) & 07770;
				if ( 1 == tape_dir[u] ) {
					tmp_data ^= 017;
				}
				if ( 1 != bwrite(u, (long)(current_line[u] +
								TAG_LENGTH),
						&tmp_data, 1) ) {
					set_sel_tm_err;
				}
			}
		}
	}
	else {	/* HLS */
		if ( -100L >= current_line[u] ) {
			markbit = (REV_END_MARK >>
				(5 + (current_line[u] % LINES_PER_CELL))) & 1;
		}
		else if ( 0L >= current_line[u] ) {
			markbit = (INTER_BLOCK >>
				(5 + (current_line[u] % LINES_PER_CELL))) & 1;
		}
		else if ( MAX_LINE > current_line[u] ) {
			markbit = (cell[current_cell] >>
				(5 - (current_line[u] % LINES_PER_CELL))) & 1;
		}
		else if ( (MAX_LINE + 100L) > current_line[u] ) {
			markbit = (INTER_BLOCK >>
				(5 - (current_line[u] % LINES_PER_CELL))) & 1;
		}
		else if ( (MAX_LINE + 100L) <= current_line[u] ) {
			markbit = (END_MARK >>
				(5 - (current_line[u] % LINES_PER_CELL))) & 1;
		}

		markbit ^= tape_dir[u];

		if ( 1 == uts ) {
			mark_track = ( (mark_track << 1) & 076 ) | markbit;
			command_register = ( command_register & 07700 ) |
						mark_track;
		}
		if ( BLOCK_MARK == mark_track ) {
			if ( 0 == read_write ) {
				data_register = ( current_block ) & 07777;
			}
		}
		else if ( REV_BLOCK_MARK == mark_track ) {
			if ( 0 == read_write ) {
				data_register = ( current_block ) & 07777;
			}
		}
		else if ( (BLOCK_START == mark_track) &&
			  ((4 == current_cell) || (91 == current_cell)) ) {
			if ( 0 == read_write ) {
				if ( 4 == current_cell ) {
					data_register = 07777;
				}
				else if ( 91 == current_cell ) {
					data_register =
						checksum( current_block, u );
				}
			}
		}
		else if ( (0 == read_write) && (1 == quad_line_flag) &&
				(4 == current_cell) && (1 == tape_dir[u]) ) {
			data_register = 0;
		}
		else if ( (0 == read_write) && (1 == quad_line_flag) &&
				(91 == current_cell) ) {
			data_register = checksum( current_block, u );
		}
		else if ( (5 <= current_cell) && (90 >= current_cell) &&
			  (1 == quad_line_flag) ) {
			block_line = current_line[u] -
			   (current_block * CELLS_PER_BLOCK * LINES_PER_CELL) -
			   (5 * LINES_PER_CELL);
			current_word = (long)(block_line / LINES_PER_WORD) +
					(long)(current_block * WORDS_PER_BLOCK);
			if ( 0 == read_write ) { /* read */
				if ( 4 != bread(u, (long)(current_word * 4L),
						&tmp_data, 4) ) {
					set_sel_tm_err;
				}
				data_register = tmp_data & 07777;
			}
			else { /* write */
				if ( 0 == wtm_switch ) { /* write data */
					tmp_data = data_register & 07777;
					if ( 4 != bwrite(u,
						(long)(current_word * 4L),
							&tmp_data, 4) ) {
						command_register |= 1 << 7;
						set_sel_tm_err;
					}
				}
			}
		}
	}

	/* schedule next line to spin by head */
	schedule( &tu56_delay[u], single_line_time, tu56_event, u );
}


/* events to which the TD8E controller responds */
#define td8e_uts    1 /* penalty delay */
#define td8e_dly    2 /* turnaround delay*/

static void td8e_event(p)
int p;
{ /* called from timer when an interface delay has completed */
	switch (p) {
	case td8e_uts:
		schedule( &td8e_delay, uts_time, td8e_event, td8e_dly );
		mark_track = 0;
		uts = 0;
		break;
	case td8e_dly:
		tape_dir[unit] = tape_uts_dir[unit];
		uts = 1;
		break;
	}
}


/***********************************************/
/* Initialization used by CAF and reset switch */
/***********************************************/

TAPE_init() /* console reset or programmed reset */
{
	int u;
	for (u = 0; 1 >= u; u++) {
		if ( (MIN_LINE >= current_line[u])
		   ||(MAX_LINE <= current_line[u]) ) {
			current_line[u] = START_LINE;
		}
		tape_qlines[u] = 0;
	}

	diff_command_register = 0;
	command_register = 0;
	data_register = 0;
	
	mark_track = 0;
	uts = 1;
	
	single_line_flag = 0;
	quad_line_flag= 0;

	/*
	 * schedule each unit independently
	 */
	schedule( &tu56_delay[0], single_line_time, tu56_event, 0 );
	schedule( &tu56_delay[1], single_line_time, tu56_event, 1 );
}

/********************/
/* IOT Instructions */
/********************/
#define wrtlck ( TAPE_wrt_lck[unit] | tape_wlck[unit] )

TAPE_dev(op)
int op;
{
	switch (op & 7) {
	case 00: /* NOP */
		break;
	case 01: /* SDSS */
		if ( 1 == single_line_flag ) {
			pc = (pc + 1) & 07777;
		}
		break;
	case 02: /* SDST */
		if ( 1 == sel_tm_err ) {
			pc = (pc + 1) & 07777;
		}
		break;
	case 03: /* SDSQ */
		if (1 == quad_line_flag ) {
			pc = (pc + 1) & 07777;
		}
		break;
	case 04: /* SDLC */
		/*
		 * set command register and clear accu
		 * as a side effect reset select time error
		 */
		diff_command_register = ( ac ^ command_register ) & 07400;
		command_register = ac & 07400;
		ac = 0;

		command_register = command_register & ((wrtlck << 7) | 07577);
		command_register = command_register | (wrtlck << 7);
		
		/*
		 * if write lock set then reset read/write bit
		 */
		if ( (1 == read_write) && (1 == wrtlck) ) {
			set_write_lock;
		}
		
		/*
		 * if HLS and wtm_switch set error flag
		 */
		if ( (TAG_LENGTH != lls_flag[unit]) && (1 == wtm_switch) ) {
			set_sel_tm_err;
			break;
		}
		/*
		 * show selected unit
		 */
		TAPE_select = unit;

		/*
		 * only read/write flag changed?
		 */
		if ( 1 < ((diff_command_register >> 8) & 017) ) {
			int delay;
			switch ( (diff_command_register >> 9) & 07 ) {
			default:	/* 1, 2, 4, 5, 6 */
				delay = single_line_time;
				break;
			case 3:
			case 7:
				/*
				 * stop/go and direction changed at once?
				 * this means break penalty
				 */
				delay = uts_time;
				break;
			}
			tape_uts_dir[unit] = direction;
			mark_track = 0;
			uts = 0;
			single_line_flag = 0;
			quad_line_flag = 0;
			tape_qlines[unit] = 0;
			schedule( &td8e_delay, delay, td8e_event, td8e_uts );
		}
		break;
	case 05: /* SDLD */
		data_register = ac;
		single_line_flag = 0;
		quad_line_flag = 0;
		tape_qlines[unit] = 0;
		break;
	case 06: /* SDRC */
		command_register = command_register & ((wrtlck << 7) | 07577);
		command_register = command_register | (wrtlck << 7);
		ac = command_register;
		single_line_flag = 0;
		quad_line_flag = 0;
		tape_qlines[unit] = 0;
		break;
	case 07: /* SDRD */
		ac = data_register;
		single_line_flag = 0;
		quad_line_flag = 0;
		tape_qlines[unit] = 0;
		break;
	}
}
