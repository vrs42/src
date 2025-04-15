/*	dump_linc.c		program to receive a LINCtape image from			*/
/*					a PDP12 console serial port							*/
/*																		*/
/*	uses 'dumprest.cfg' for serial port configuration.					*/
/*	If no command line argument, it will prompt for the filename.		*/
/*																		*/
/*	This program should be running before the PDP12 end is started.		*/
/*																		*/
/*	toolset: gcc   (use CYGWIN for Windows machines)					*/

#include <termios.h>
#include <unistd.h>
#include <memory.h>

#include <stdio.h>
#include <fcntl.h>
#include <time.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>

#define ARRAYSIZE(a) (sizeof(a) / sizeof(a[0]))

#include "config.c"
#include "comm.c"

#define	BUFFER_SIZE	200
unsigned char buffer[ BUFFER_SIZE ];


void main( int argc, char *argv[] )
{
	int				i;
	int				fd;
	int				c;

	char			filename[ 1024 ];
	char			serial_dev[ 256 ];
	char			byte;
	long			baud;
	int				two_stop;

	unsigned int	block_size;
	unsigned int	block;
	unsigned int	count;
	unsigned int	word;
	unsigned int	bad_blocks;
	unsigned int	data_sum;

    enum
	{
		STATE_STATUS	= 0,	/* expecting status FF,FE,FD	*/
		STATE_BLOCK_LO,			/* expecting lo  byte of BLOCK	*/
		STATE_BLOCK_HI,			/* expecting hi  byte of BLOCK	*/
		STATE_LENGTH_LO,		/* expecting lo  byte of LENGTH	*/
		STATE_LENGTH_HI,		/* expecting hi  byte of LENGTH	*/
		STATE_DATA_1,			/* expecting 1st byte of DATA	*/
		STATE_DATA_2,			/* expecting 2nd byte of DATA	*/
		STATE_DATA_3,			/* expecting 3rd byte of DATA	*/
		STATE_SUM_LO,			/* expecting lo  byte of SUM	*/
		STATE_SUM_HI			/* expecting hi  byte of SUM	*/
	} state;
	int				state_count;
	
	FILE		   *outfile;


	setup_config( &baud, &two_stop, serial_dev );

	printf( "dump_linc- dump (save) a PDP12 LINCTape\n" );
	if (argc > 1)
	{
		strcpy( filename, argv[1] );
	} 
	else
	{
		printf( "Enter file name to receive\n"	);
		fflush( stdout	);
		scanf( "%s", filename );
	}
	outfile = fopen(filename,"w");

	if (outfile == (FILE *)NULL)
	{
		fprintf( stderr, "ERROR: could not open file: %s\n", filename );
		exit(1);
	}

	fd = init_comm( serial_dev, baud, two_stop );
	printf( "opened serial port: %s\n", serial_dev );

	block_size	= 0;
	block		= 0;
	data_sum	= 0;
	bad_blocks	= 0;
	count		= 0;
	word		= 0;

	state		= STATE_STATUS;

	for (;;)			/* will break when done	*/
	{
		/* read a buffer	*/
		c = ser_read( fd,(char *)buffer, sizeof( buffer ));
		if (c < 0)
		{
			fprintf( stderr, "ERROR: Serial read failed" );
			exit( 1 );
		}

		/* process the buffer	*/
		for (i = 0; i < c; i++)
		{
			switch (state)
			{
			case STATE_STATUS:		/* expecting status FF,FE,FD	*/
				if      (buffer[i] == 0xFD)	/* bad data		*/	
				{
					printf( "\nblock %4u bad\n", block );
					bad_blocks++;
					state = STATE_BLOCK_LO;
				}
				else if (buffer[i] == 0xFE)	/* check sum	*/
				{
					state = STATE_SUM_LO;
				}
				else if (buffer[i] == 0xFF)	/* good data	*/
				{
					state = STATE_BLOCK_LO;
				}
				else
				{
					printf( "ERROR: expected status flag\n" );
					exit( 1 );
				}

				printf( "Block %d\r", block );
				fflush( stdout );

				break;

			case STATE_BLOCK_LO:	/* expecting lo byte of BLOCK	*/
				word = (unsigned int)buffer[i];
				state = STATE_BLOCK_HI;
				break;

			case STATE_BLOCK_HI:	/* expecting hi byte of BLOCK	*/
				word = word | (((unsigned int)buffer[i])  << 8);
				if (word != block)
				{
					printf( "ERROR: expected next block %4u, got: %4u\n",
							block, word		);
					exit( 1 );
				}
				state = STATE_LENGTH_LO;
				break;

			case STATE_LENGTH_LO:	/* expecting lo byte of LENGTH	*/
				word = (unsigned int)buffer[i];
				state = STATE_LENGTH_HI;
				break;

			case STATE_LENGTH_HI:	/* expecting hi byte of LENGTH	*/
                word = word | (((unsigned int)buffer[i])  << 8);
				if (block_size == 0)
				{
					block_size = word;
					printf( "block size is %u\n", block_size );
				}
				if (word != block_size)
				{
					printf( "ERROR: expected  block size %4u, got: %4u\n",
							block_size, word );
					exit( 1 );
				}
				count = block_size;		/* setup data counter	*/
				state = STATE_DATA_1;
				break;

			case STATE_DATA_1:		/* expecting 1st byte of DATA	*/
				word = (unsigned int)buffer[i];		/* lo bits of first word	*/
				state = STATE_DATA_2;
				break;

			case STATE_DATA_2:		/* expecting 2nd byte of DATA	*/
				word |= ((unsigned int)buffer[i]) << 8;	/* lo nybble is hi bits of first word	*/

				word &= 0x0FFF;
				data_sum += word;
							
				byte = (unsigned char)word;
				fputc( byte, outfile );			/* lo byte	*/
				byte = (unsigned char)(word >> 8);
				fputc( byte, outfile );			/* hi byte	*/

				word = ((unsigned int)buffer[i]) >> 4;	/* hi nybble is lo bits of second word	*/
				word &= 0x00F;							/* keep 4 bits */
				
				count--;
				if (count == 0)
				{
					/* block is done	*/
					if (word != 0)
					{
						printf( "ERROR: expected last ODD word as 2 bytes\n" );
						exit( 1 );
					}
					block++;
					state = STATE_STATUS;
				}
				else
				{
					/* block not done, get 3rd byte to complete 2nd word	*/
					state = STATE_DATA_3;
				}
				break;

			case STATE_DATA_3:		/* expecting 3rd byte of DATA	*/
				word |= ((unsigned int)buffer[i]) << 4;		/* hi bits of second word	*/

				word &= 0x0FFF;
				data_sum += word;
							
				byte = (unsigned char)word;
				fputc( byte, outfile );			/* lo byte	*/
				byte = (unsigned char)(word >> 8);
				fputc( byte, outfile );			/* hi byte	*/

				count--;
				if (count == 0)
				{
					block++;
					state = STATE_STATUS;
				}
				else
				{
					state = STATE_DATA_1;
				}
				break;

			case STATE_SUM_LO:		/* expecting lo byte of SUM		*/
				word = (unsigned int)buffer[i];
				state = STATE_SUM_HI;
				break;

			case STATE_SUM_HI:		/* expecting hi byte of SUM		*/
                word = word | (((unsigned int)buffer[i])  << 8);
                if (((word + data_sum) & 0x0fff) != 0) 
				{
					printf( "\n" );
					printf( "Checksum mismatch got %04x, calculated %04x\n", word,data_sum);
					printf("\nDone, wait for PDP12 program to rewind tape\n");
                    exit( 1 );
				}

				/* write block size	*/
				byte = (unsigned char)block_size;
				fputc( byte, outfile );				/* lo byte	*/

				byte = (unsigned char)((block_size >> 8) & 0x0f);
				fputc( byte, outfile );				/* hi byte	*/
				
				/* write number of leader blocks	*/
				byte = (unsigned)0;
				fputc( byte, outfile );				/* lo byte	*/
				fputc( byte, outfile );				/* hi byte	*/

				/* write number of trailer blocks	*/
				byte = (unsigned)0;
				fputc( byte, outfile );				/* lo byte	*/
				fputc( byte, outfile );				/* hi byte	*/

				fclose( outfile );
				
				printf("\nDone, wait for PDP12 program to rewind tape\n");

                exit(0);
				break;

			default:
				fprintf( stderr, "ERROR: broken software: bad 'state'\n" );
				exit( 1 );
				break;
			}
		}
	}
}
