/* File MSBMKB.C

Author: Robert Weiner, Programming Plus, rweiner@watsun.cc.columbia.edu

Synopsis: Encodes a binary file into printable ASCII "boo" format, preserving
the exact file length, using a 4-for-3 byte encoding.

Modification history:
  28-APR-92	Initial pre-Alpha Release
  29-APR-92	Fixes around fwrite, fclose
			Changed writestr -> writeustr
			Added prototypes
		We're now at Beta Release!
			MSDOS 5, MSC 5.1 tests out ok.
			VAX/VMS VAXC032 is ok.
			SUNOS is ok.
			Both work with old or new msbpct.
  30-APR-92	Fix to output()
			Defaults to no prototypes
			Added char counts logic
			Added -v arg
			writexstr takes chgcase now
  01-MAY-92	Added 3rd arg interior-name
			Added -l -u -q
			Added stdin/out support
			Add path stripping
  02-MAY-92	Add '>' to path stripping (vms)
  05-MAY-92	Release after outside testing
			Added VOID usage() proto
			Thanks to Christian Hemsing for OS-9 testing & defs.
			Thanks to Steve Walton for Amiga testing & defs.
  08-MAY-92	Prepare for general release
			Added uchar defs, Modified _CDECL define,
			Fixed up for MSDOS GNU CC
			(GCC warnings noticed by Christian Hemsing)
			Use gcc -DMSDOS to compile.
			This MSDOS GCC defines "unix" which doesn't
				help us at all!
  17-MAY-92		Add AtariST defs & improved __STDC__ check
  				from Bruce Moore
                        Removed string fns so don't need string.h.
			Next general release now ready... Thanks to those
				listed in the directory below
  12-JUL-92	Near Final release...??
			Added portability items, cmd line overrides
			ifdef UCHAR, VOID, NOANSI
			Shortened lines to 79 max (got them all?)
			Only thing not done is checking #ifdef NOUCHAR
			and adding any anding off bits which signed
			chars may intruduce in boo().

Beta Testing Informaton, Supported Systems Directory:
=====================================================================
( Testor / Operating System / O.S. Version / Compiler )

Rob Weiner, rweiner@watsun.cc.columbia.edu:
	MSDOS		5.0		MSC 5.1
	MSDOS		5.0		GCC (DJGPP DOS 386/G++ 1.05)
	VAX/VMS		5.4-2		VAXC032
	SUNOS		4.1
	UNIXPC		3.51
Christian Hemsing, chris@v750.lfm.rwth-aachen.de:
	OS-9
Stephen Walton, swalton@solaria.csun.edu:
	AMIGA				MANX C (defines MCH_AMIGA)
Bruce J. Moore, moorebj@icd.ab.com:
	AtariST TOS/GEMDOS		MWC 3.7

Fun stuff such as my favorite testing shell command is now possible:
	$ for i in *
	do
		echo $i:
		cat $i | msbmkb -q - - | msbpct -q - - | cmp -l - $i
	done

This version properly implements the Lasner ~0 fixes.

SYNOPSYS: The en-booer writes out printable text from binary text via a 3
input char to 4 output char conversion (called "triple to quad" conversion).
Since the input text can run out before the last triple can be formed, all
en-booers (msbmkb) would add 1 or 2 nulls to the input stream to complete
the triple such that a valid quad can be output.  Thus the problem where
often a de-booer (msbpct) will create an output file from a boo encoded
file, but the output file is larger than the input file by 1 or 2 nulls.
Charles Lasner documented this problem and offered a fix... For each 1 or 2
extra null pad chars added to the input stream, the en-booer should add a
trailing ~0 to the created boo file.  ~X (where X-'0' is a repeat value
which indicates a number of "repeated nulls" does not have a value for the
sequence "~0" which would imply: ``decode into a series of 0 nulls,'' a noop
for "old" debooers.  Hence ~0 can be used as a flag that the input text had
a "padding null" added to it and then the de-booer can know NOT to add these
padding chars to the output stream.  This allows the en-boo/de-boo programs
to finally always guarantee that you get what you started with after passing
through the en-boo then de-boo process.

Some bugs/facts with the MSBPCT/MSBMKB programs which popped up
or were discovered recently (January through March 1992):
 -	CURRENT msbpct will NOT make a correct output file from
	the boo file THIS msbmkb creates.  It loses or adds a char.
		Comes from improper implementation of Lasner changes.
		Note: CURRENT enbooer with CURRENT unbooer make the
		same mistakes encoding/uncoding hense files come out
		more or less ok.
 -	OLD msbpct will create a proper output file from a boo
	file created from THIS en-booer.
 -	Current msbpct also screws up output column checking and can
	override the max (usually ~0~0 at eof) and undercut the
	standard value.
 -	Current msbpct doesn't correctly implement lasner fixes.
 -	Current msbpct tells of "using an old booer" at times
	it can determine that that statement is meaningless.
 -	Addtl improper implementation of Lasner change yields
	(quite often) an additional 2 nulls in the output file which
	are removed by an additional 2 ~0 sequence... to break even.
	ie. where old & this enbooer at eof writes "~A", the
	current (bad) booer writes "~C~0~0".
(other items not listed).

This program was redone from scratch for portability and implementation
functionality reasons, we also get VMS support here as a bonus.  Also, there
are a few unnecessary things eliminated like adding nulls to the end of
buffers which don't seem to serve any purpose.

Character counts for MSDOS ignore the fact that \n is really \r\n, it is
just counting real boo data (in reality the \r can be left out and ignored).
This is done on purpose & is the difference between "data bytes out" and
simply "bytes out".

The old enbooer calculated the efficiency of enbooing, well, in reality you
should be calculating the loss as the file grows bigger.  That calc was the
only bit of floating point in the program... so I left it out intentionally.
This program is 100% integer only math now.  Note that sometimes the boo
file is SMALLER than the original, due to lots of null compressions.

This new msbmkb replaces the old one (msbmkb's dated before March 1992).
Credit should be given to the maintainers of the old msbmkb:

	Original by Bill Catchings, Columbia University, July 1984.
	Modifications by Howie Kaye & Frank da Cruz of Columbia
	University and Christian Hemsing of the Rheinisch-Westphaelish
	Technische Hochschule, Aachen, Germany.
*/

#include <stdio.h>			/* only header we need */

/*
  Version Dependencies... Give each new special case its own defs:
*/


#ifdef VAX11C				/* VAXC032 */
#define SYSTEM		"VAX/VMS"
#define EXIT_GOOD	1
#define EXIT_INFO	3
#define EXIT_BAD	5
#define FOPEN_ROPTS	"rb"
#define FOPEN_WOPTS	"w","rat=cr","rfm=var","mrs=0"
#define CASE_CHANGE	CHANGE_LOWER	/* lowercase boo file name for vms */
#define YES_PROTOS
#endif


#ifdef MSDOS				/* MSC 5.1 */
#define SYSTEM		"MSDOS"
#define EXIT_GOOD	0
#define EXIT_INFO	1
#define EXIT_BAD	2
#define FOPEN_ROPTS	"rb"
#define FOPEN_WOPTS	"w"
#define CASE_CHANGE	CHANGE_LOWER	/* lowercase boo file name for msdos */
#define YES_PROTOS
#endif


#ifdef GEMDOS				/* AtariST - TOS - MWC v3.7 */
#define SYSTEM		"AtariST/TOS"
#define EXIT_GOOD	0
#define EXIT_INFO	1
#define EXIT_BAD	2
#define FOPEN_ROPTS	"rb"
#define FOPEN_WOPTS	"w"
#define CASE_CHANGE	CHANGE_LOWER	/* lowercase boo file name */
#define YES_PROTOS
#endif


#ifdef OSK
#define SYSTEM		"OS-9"
#define EXIT_GOOD	0
#define EXIT_INFO	1
#define EXIT_BAD	1
#define FOPEN_ROPTS	"r"
#define FOPEN_WOPTS	"w"
#define CASE_CHANGE	CHANGE_NONE	/* leave filename case sensitive */
/*
#undef  YES_PROTOS                      * default OS9 to noprotos *
*/
#endif

#ifndef FOPEN_ROPTS			/* No system found, default to unix */
#define SYSTEM		"UNIX/Amiga/Generic"
#define EXIT_GOOD	0
#define EXIT_INFO	1
#define EXIT_BAD	2
#define FOPEN_ROPTS	"r"
#define FOPEN_WOPTS	"w"
#define CASE_CHANGE	CHANGE_NONE	/* leave filename case sensitive */
/*
#undef  YES_PROTOS                      * default UNIX/generic to noprotos *
*/
#endif

#ifndef NOANSI				/* allow cmd line override to STDC */
#ifdef __STDC__				/* Ansi likes prototypes */
#if __STDC__				/* MWC sets this defined but 0 valued */
#define YES_PROTOS
#endif
#endif /* __STDC__ */
#endif /* NOANSI */

#ifndef VOID				/* allow cmd line override to VOID */
#define VOID void			/* assume system likes void */
#endif

#ifndef _CDECL
#define _CDECL
#endif

#ifndef __DATE__
#define __DATE__ "01-MAY-1992"
#endif

#ifndef __TIME__
#define __TIME__ "00:00:00"
#endif

/*
  BOO Encoder Options
*/
#define MAXOUTLEN		72	/* max output chars per line */
#define MAXNULLCOMP		78	/* max null compression via ~ */
#define MINNULLCOMP		2	/* min of 2 nulls to compress */

#define tochar(c)	( (c) + '0' )

#define CHANGE_NONE	1
#define CHANGE_UPPER	2
#define CHANGE_LOWER	3

/*
  Typedefs
*/
#ifndef UCHAR				/* allow cmd line override */
typedef unsigned char uchar;		/* possible portability concern */
#define UCHAR	uchar
#else
#define NOUCHAR		1		/* flag saying cmd line changed uchar */
#endif

/*
  Here are the function prototypes...
  If your 'C' don't like prototypes, don't declare YES_PROTOS.
*/
#ifdef YES_PROTOS
VOID _CDECL convert    (FILE *, FILE *);
int  _CDECL get3       (FILE *, UCHAR *);
VOID _CDECL output     (FILE *, UCHAR *, int);
VOID _CDECL writechars (FILE *, char *, int);
VOID _CDECL writexstr  (FILE *, char *, int);
VOID _CDECL boo        (UCHAR *, UCHAR *);
VOID _CDECL change_case(char *, int);
VOID _CDECL usage      (VOID);
#else
VOID convert    ();
int  get3       ();
VOID output     ();
VOID writechars ();
VOID writexstr  ();
VOID boo        ();
VOID change_case();
VOID usage();
#endif

long count_in=0, count_out=0;		/* character counts */
int quiet=0;

main(argc,argv)
int argc;
char **argv;
{
	FILE *fpin, *fpout;
	char *booptr;
	int force_case=0;
	int leave_path=0;

	while( argc > 1 && *argv[1]=='-' )
		{
		if( argv[1][1] == '\0' )
			break;
		switch( argv[1][1] )
			{
			case 'v':		/* version */
				fprintf(stderr,
				"MSBMKB.C, Date=\"%s, %s\", System=\"%s\"\n",
					__DATE__,__TIME__,SYSTEM);
				fprintf(stderr, "\
Email comments to \"rweiner@kermit.columbia.edu\" \
(Rob Weiner/Programming Plus)\
\n");
				fprintf(stderr,"\n");
				break;
			case 'l':		/* lowercase internal name */
				force_case = CHANGE_LOWER ;
				if( !quiet )
					fprintf(stderr,
					"Forcing Lowercased Internal Name\n");
				break;
			case 'u':		/* uppercase internal name */
				force_case = CHANGE_UPPER ;
				if( !quiet )
					fprintf(stderr,
					"Forcing Uppercased Internal Name\n");
				break;
			case 'p':			/* leave paths */
				leave_path=1;
				break;
			case 'q':			/* quiet */
				quiet=1;
				break;
			default:
				usage();
			}
		argc--;
		argv++;
		}

	if( argc < 3 || argc > 4 )
		usage();

	if( argv[1][0]=='-' && argv[1][1]=='\0' )
		{
		fpin = stdin;
		}
	else if( (fpin = fopen( argv[1] , FOPEN_ROPTS )) == NULL )
		{
		fprintf(stderr,"Error, cannot open input file \"%s\"\n",
			argv[1]);
		exit(EXIT_BAD);
		}

	if( argv[2][0]=='-' && argv[2][1]=='\0' )
		{
		fpout = stdout;
		}
	else if( (fpout = fopen( argv[2] , FOPEN_WOPTS )) == NULL )
		{
		fprintf(stderr,"Error, cannot open output file \"%s\"\n",
			argv[2]);
		exit(EXIT_BAD);
		}

	if( !quiet )
		fprintf(stderr,
		       "Creating BOO File \"%s\" from Binary File \"%s\"...\n",
				argv[2],argv[1]);

	booptr = argv[1] ;	/* input file name */
	if( argc > 3 )		/* command line override internal name */
		{
		booptr = argv[3];
		if( !quiet )
			fprintf(stderr,
	"Command Line Argument \"%s\" Overrides Internal BOO File Name\n",
				booptr);
		}
	else if( !leave_path )
		{	/* strip path regexpr ".*[/\\\]:>]" from booptr */
		char *s, *t;
		for( s = t = booptr ; *s ; s++ )
			{
			if(*s=='/' || *s=='\\' || *s==']' ||
			   *s==':' || *s=='>')
				t = s + 1 ;
			}
		if( *t == '\0' )
			t = "_";
		if( t != booptr )
			{
			if( !quiet )
				fprintf(stderr,
			"Internal BOO File Name Without Path = \"%s\"\n",t);
			}
		booptr = t ;
		}

	if( force_case == 0 )
		force_case = CASE_CHANGE ;

	/* first line in output file is filename */
	writexstr( fpout, booptr, force_case );

	convert(fpin,fpout);

	writechars(fpout,"",0);		/* flush output buffering */

	fclose(fpin);
	fclose(fpout);

	if( !quiet )
		{
		fprintf(stderr,"Data bytes in: %ld,  ",  count_in);
		fprintf(stderr,"Data bytes out: %ld,  ", count_out);
		fprintf(stderr,"Difference: %ld bytes\n",
				count_out - count_in);
		}
	exit(EXIT_GOOD);
}


VOID usage()
{
	fprintf(stderr, "MSBMKB = Encode Binary File into Ascii BOO Format\n");
	fprintf(stderr, "\
Usage: MSBMKB [-v -l -u -p -q] input_file output_boo_file [internal_boo_name]\
\n");
	fprintf(stderr,
"              -v = show version information\n");
	fprintf(stderr,
"              -l = lowercase internal BOO file name\n");
	fprintf(stderr,
"              -u = uppercase internal BOO file name\n");
	fprintf(stderr,
"              -p = leave internal BOO path intact\n");
	fprintf(stderr,
"              -q = quiet mode\n");
	fprintf(stderr,
"              Note: Filenames of '-' are supported for stdin & stdout\n");
	exit(EXIT_INFO);
}

VOID convert(fpin,fpout)		/* convert each 3 chars to 4 */
FILE *fpin, *fpout;
{
	int n;
	int fill_nulls = 0;
	UCHAR inbuf[10], outbuf[10];

	while( (n = get3(fpin,inbuf)) != 0 )
		{
		if( n < 0 )		/* bunch of nulls */
			{
			outbuf[0] = '~' ;
			outbuf[1] = tochar( -n );

			output(fpout,outbuf,2);
			}
		else	{
			while( n < 3 )
				{
				inbuf[n++] = '\0' ;
				fill_nulls++ ;
				}

			boo( inbuf , outbuf );

			output(fpout,outbuf,4);
			}
		}

	if( fill_nulls > 0 )
		{
		if( !quiet )
			fprintf(stderr,"Fill Nulls = %d\n",fill_nulls);

/*		strcpy( outbuf , "~0" );	*/
		outbuf[0] = '~' ;		/* redone w/o strcpy... */
		outbuf[1] = '0' ;
		outbuf[2] = '\0' ;

		while( fill_nulls-- > 0 )
			{
			output(fpout,outbuf,2);
			}
		}
	output(fpout, (UCHAR *)"", -1);	/* make sure last line is \n termed */
}

int get3( fp , buf )	/* return: pos=# read, neg=# nulls found */
FILE *fp;
UCHAR *buf;
{
	int i=0;		/* amt last read */
	int nulls=0;		/* amt nulls found */
	int c;

	do	{
		if( (c = getc(fp)) == EOF )		/* hit eof */
			{
			if( ferror(fp) )		/* quick check */
				{
				fprintf(stderr,
					"get3(): fread error on input file\n");
				exit(EXIT_BAD);
				}
			break;				/* stop */
			}
		count_in++;

		if( (nulls > 0) && (c != '\0') )	/* stop collecting */
			{
			if( nulls < MINNULLCOMP )
				{		/* correct for too few nulls */
				i = nulls + 1 ;		/* nulls + new char */
				while( nulls-- > 0 )	/* restore null data */
					*buf++ = '\0' ;
				*buf++ = c ;		/* store curr char */
				}
			else	{
				ungetc(c,fp);		/* save non-null */
				count_in--;
				break;
				}
			}
		else if( (i == 0) && (c == '\0') )	/* collect */
			{
			nulls++ ;			/* keep collecting */
			}
		else	{
			i++;				/* count till 3 */
			*buf++ = c ;			/* save chars */
			}

		} while( (i <= 2) && (nulls <= MAXNULLCOMP) );

	if( nulls > MAXNULLCOMP )
		{
		ungetc(c,fp);		/* save the 79th null for next time */
		nulls--;
		count_in--;
		}

	if( nulls > 0 )
		return( -nulls );

	return(i);
}


VOID output(fp,buf,n)	/* output chars taking care of line wraps */
FILE *fp;		/* we are keeping output quads on the same line */
UCHAR *buf;
int n;		/* -1 is flag to end last line with \n if its not already */
{
	static outlen=0;

	if( ((n < 0) && (outlen != 0)) || ((outlen+n) > MAXOUTLEN) )
		{
		writechars(fp,"\n",1);
		outlen=0;
		}

	if( n > 0 )
		{
		outlen += n;
		writechars(fp,(char *)buf,n);
		}
}

VOID writechars( fp, s, n )			/* n==0 = flush */
char *s;
int n;
FILE *fp;
{
	static char buf[BUFSIZ];
	static char *p=buf;
	int flush = (n==0) ;
	unsigned count;

	if( (p+n) >= (buf+sizeof(buf)) )
		{
		fprintf(stderr,
			"writechars: error would exceed output buffer\n");
		exit(EXIT_BAD);
		}

	while( n-- > 0 )
		*p++ = *s++ ;

	/* we know there is a \n at the end of the ~73 char lines! */

	if( flush || (p[-1] == '\n') )		/* time to dump buffer */
		{
		if( (count = p-buf) != 0 )
			{
			/* this must be "p-buf,1" ordered here for VMS
			   varying recs to come out right */
			count_out += count ;
#if 0						/* Ignore the nl's for now */
#if MSDOS
			if( !flush )		/* MSDOS does \r\n not \n */
				count_out++ ;
#endif
#endif
			if( fwrite( buf , count , 1 , fp ) != 1 )
				{
				fprintf(stderr,
				"writechars(): fwrite error on output file\n");
				exit(EXIT_BAD);
				}
			p = buf ;
			}
		if( flush )
			fflush(fp);
		}
}

VOID writexstr(fp,s,t)			/* write uppercased string */
FILE *fp;
char *s;
int t;					/* type of case change */
{
	int i;
	char buf[BUFSIZ], *p;

/*
	i=strlen(s);
	if( i > BUFSIZ )		* make sure name is sane length *
		i = BUFSIZ ;
	s[i] = '\0' ;
	strcpy(buf,s);
*/
					/* redone w/o strlen & strcpy... */
	i = BUFSIZ - 1;			/* watch buffer overrun */
	p = buf;
	while( (i-- > 0) && ((*p = *s++) != '\0') )
		p++ ;
	*p = '\0' ;			/* make sure there's a null */
	i = p-buf;			/* strlen */

	change_case(buf,t);		/* change case as appropriate */
	writechars(fp,buf,i);
	writechars(fp,"\n",1);
}


VOID boo( inbuf , outbuf )	/* here is where we boo 3 into 4 chars */
UCHAR *inbuf, *outbuf;
{
	UCHAR x,y,z,a,b,c,d;

	/* get x,y,z the 3 input bytes */

	x = *inbuf++;
	y = *inbuf++;
	z = *inbuf;

	/* generate a,b,c,d the 4 output bytes */

	a = x >> 2 ;
	b = ( (x << 4) | (y >> 4) ) & 077 ;
	c = ( (y << 2) | (z >> 6) ) & 077 ;
	d = z & 077 ;

	*outbuf++ = tochar(a);
	*outbuf++ = tochar(b);
	*outbuf++ = tochar(c);
	*outbuf   = tochar(d);
}


VOID change_case(s,t)
char *s;
int t;
{
	if( t != CHANGE_UPPER && t != CHANGE_LOWER && t != CHANGE_NONE )
		{
		fprintf(stderr,"Error, bad case change type\n");
		exit(EXIT_BAD);
		}

	while( *s )
		{
		if( ((t==CHANGE_UPPER) && ( (*s >= 'a') && (*s <= 'z') )) ||
		    ((t==CHANGE_LOWER) && ( (*s >= 'A') && (*s <= 'Z') )) )
			*s ^= 040;
		s++;
		}
}

/*
  [EOF]
*/

