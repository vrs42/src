/* os8.h */
/* Copyright (C) 1994 by Robert Armstrong                               */
/*                                                                      */
/* This program is free software; you can redistribute it and/or modify */
/* it under the terms of the GNU General Public License as published by */
/* the Free Software Foundation; either version 2 of the License, or    */
/* (at your option) any later version.                                  */
/*                                                                      */
/* This program is distributed in the hope that it will be useful, but  */
/* WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANT- */
/* ABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General    */
/* Public License for more details.                                     */
/*                                                                      */
/* You should have received a copy of the GNU General Public License    */
/* along with this program; if not, visit the website of the Free       */
/* Software Foundation, Inc., www.gnu.org.                              */
#ifndef _OS8_H_
#define _OS8_H_


/* Constants... */
#define OS8_RX01_SIZE	    494	/* Blocks usuable by OS/8 on a RX01	*/
#define OS8_RX50_SIZE	    766	/*   "       "    "    "   " " RX50	*/
#define OS8_VM01_SIZE	   1344	/*   "       "    "    "     " VM01	*/
#define OS8_RK05_SIZE	   3248	/* OS/8 blocks on each RK05 partition	*/
#define OS8_BASE_YEAR	     86	/* Base year for OS/8 dates		*/
#define OS8_BLOCK_SIZE      256	/* Size of an OS/8 disk block		*/
#define OS8_BYTE_BLOCK_SIZE 384	/* Size of an OS/8 block in byte mode	*/
#define OS8_SYSTEM_SIZE	     49	/* Blocks allocated to OS/8 system head	*/
#define OS8_DIRECTORY_SIZE    6	/*   "        "     "   "   directory	*/
#define OS8_HOME_BLOCK	      1	/* First directory segment LBN		*/
#define OS8_EOF		     26	/* OS/8 end of file (^Z) character	*/


/* OS/8 directory search context for OS8FindFile(), et al... */
struct _OS8_FIND_DATA {
  UINT   nPoint;	/* Index of the current entry in this segment	*/
  UINT   nLast;		/*   "    "  "  last      "   "   "     "	*/
  UINT   nFiles;	/* Total number of files in this segment	*/
  UINT   nAIW;		/* Count of additional information words	*/
  UINT   nSegmentLBN;	/* LBN of this directory segment		*/
  UINT   nNextSegment;	/*  "   " the next directory segment		*/
  UINT   nFileLBN;	/* Starting LBN for files in this segment	*/
  UINT16 awData[OS8_BLOCK_SIZE]; /* Actual contents of this segment	*/
};
typedef struct _OS8_FIND_DATA OS8_FIND_DATA;


/* Simple PDP-8 and OS/8 data conversions... */
#define SixToChar(x)		/* convert SIXBIT character to a char	*/ \
	((char) ( ((x) == 0) ? ' ' : ((x) >= 32) ? (x) : ((x) | 0100) ))
#define CharToSix(x)		/* convert one char to SIXBIT		*/ \
	((UINT) ( ((x) == ' ') ? 0 : ((x) & 077) ))
#define WordToChars(w,c1,c2)	/* convert a SIXBIT word to two chars	*/ \
	c1 = SixToChar((w) >> 6),  c2 = SixToChar((w) & 077)
#define CharsToWord(c1,c2)	/* convert two chars to a SIXBIT word	*/ \
	( (CharToSix(c1) << 6) | CharToSix(c2) )

/*   Unfortunately, things get a little messy when converting signed -8	*/
/* words to integers.  The macro SgnWordToInt does the "correct" thing	*/
/* - it sign extends a twelve bit value in the range -2048..2047.  But,	*/
/* there are a lot of cases the OS/8 directory contains words which are	*/
/* the negative of the number of free blocks, or the absolute block	*/
/* number of the first block in a file, and in cases where the device	*/
/* has more than 2048 blocks (like the RK05, RL01 or RL02!) this won't	*/
/* give the expected result!  For those situations where the sign of 	*/
/* value is known (or assumed), there are the PosWordToInt() and	*/
/* NegWordToInt() macros, which return results in the range 0..4095 or	*/
/* 0..-4095.								*/
#define SgnWordToInt(x)		/* convert a PDP-8 word to a signed int	*/ \
	((int) ( ((x) < 2048) ? (x) : ((x)-4096) ))
#define NegWordToInt(x)		/* convert a negative PDP-8 word to int	*/ \
	((int) ( ((x) == 0)   ? 0   : ((x)-4096) ))
#define PosWordToInt(x)		/* convert a positive PDP-8 word to int	*/ \
	((int) (x))

/*   Converting the other way, from signed integer to PDP-8 word, is 	*/
/* never an issue because we just do what a real PDP-8 would - truncate	*/
/* and throw away the extra bits!  This works as long as all computers	*/
/* involved are using two's complement (a fairly safe assumption!).	*/
#define IntToWord(x)		/* convert a signed int to a PDP-8 word	*/ \
	((UINT16) ((x) & 07777))

/* Other, useful, twelve bit arithmetic operations... */
#define AddNegWord(x,y)		/* add two negative PDP-8 words		*/ \
	x = IntToWord( NegWordToInt(x) + NegWordToInt(y) )
#define IncNegWord(x)		/* increment a negative PDP-8 word	*/ \
	x = IntToWord( NegWordToInt(x) - 1 )
#define DecNegWord(x)		/* decrement a negative PDP-8 word	*/ \
	x = IntToWord( NegWordToInt(x) + 1 )


/* Function prototypes... */
void WordsToFileName (UINT16 *pwWords, char *pszName);
BOOLEAN FileNameToWords (char *pszName, UINT16 *pwWords);
void ParseOS8FileName (char *pszFile, char *pszName, char *pszType);
void OS8BlockToBytes (UINT16 *pw, UINT8 *pb);
void OS8BytesToBlock (UINT8 *pb, UINT16 *pw);
void GetOS8CurrentDate (UINT16 *pwDT);
void OS8DateToDMY (UINT16 wDT, UINT *pnDay, UINT *pnMonth, UINT *pnYear);
void ExtractASCIIFile (UINT nBlock, int nLength, FILE *f);
BOOLEAN InsertASCIIFile (UINT nBlock, int *pnLength, FILE *f);
void ExtractImageFile (UINT nBlock, int nLength, int out);
BOOLEAN InsertImageFile (UINT nBlock, int *pnLength, int inp);
BOOLEAN OS8FindFile (OS8_FIND_DATA *pCX, char *pszMask, char *pszName, UINT *pnBlock, int *pnLength, UINT16 *pwCDT);
BOOLEAN OS8FindNext (OS8_FIND_DATA *pCX, char *pszName, UINT *pnBlock, int *pnLength, UINT16 *pwCDT);
void OS8FindFirst (OS8_FIND_DATA *pCX);
BOOLEAN SystemDisk (void);
BOOLEAN OS8Exists (char *pszMask);
void OS8Rename (OS8_FIND_DATA *pCX, char *pszNewName);
void OS8Delete (OS8_FIND_DATA *pCX);
void OS8Enter (OS8_FIND_DATA *pCX, char *pszName, UINT16 cdt, UINT *pnBlock, int *pnLength);
void OS8Close (OS8_FIND_DATA *pCX, int nLength);
void OS8Initialize (BOOLEAN fSystem);

#endif /* _OS8_H_ */
