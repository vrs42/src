/*++									*/
/* os8.c								*/
/*									*/
/* DESCRIPTION:								*/
/*   This module implements an OS/8 file system, complete with file	*/
/* lookups, deletes, renames and wild card searches.  Given the 	*/
/* simplicity of the OS/8 file system (i.e. it doesn't have directories	*/
/* and all files are stored contiguously!) this isn't as impressive as	*/
/* it sounds.  What is impressive is that the real OS/8 managed to do	*/
/* all this, plus a bunch more, in the 1KW USR overlay!			*/
/*									*/
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
/*                                                                      */
/* REVISION HISTORY:							*/
/* dd-mmm-yy	who	description					*/
/*  ?-???-??	RLA	New file.					*/
/*  9-May-00	RLA	Add VM01 and RK05 support.			*/
/*  9-May-00	RLA	A lot of the signed arithmetic didn't work for	*/
/*			drives larger than 2047 blocks (like the RK05!)	*/
/*--									*/

/* Include files... */
#include <stdio.h>	/* NULL, printf(), scanf(), et al		*/
#include <string.h>	/* strlen(), strcpy(), strcat(), etc...		*/
#include <ctype.h>	/* isspace(), isalnum(), etc...			*/
#include <stdlib.h>	/* malloc(), exit(), etc...			*/
#ifdef WINDOWS
#include <io.h>		/* read(), write(), et al...			*/
#endif
#include <time.h>	/* struct tm, localtime(), etc...		*/
#include <unistd.h>
#if 0
#include <assert.h>	/* assert() macro (what else??)			*/
#endif
#include "types.h"	/* universal data type declarations		*/
#include "diskette.h"	/* RX01 and RX50 diskette emulation routines	*/
#include "os8.h"	/* function prototypes for this module		*/
#include "os8_html.h"

#define assert(expr) ((void) ((expr) ? 0 : (OS8AssertFail (__STRING(expr), __FILE__, __LINE__, __PRETTY_FUNCTION__), 0)))


#define ARRAYSIZE(x) (sizeof(x) / sizeof(x[0]))

/************************************************************************/
/* OS/8 File Name Manipulations */
/************************************************************************/


void OS8AssertFail(char *assert, char *file, int line,const char *func)
{
   html_error(0, "Assertion %s failed: %s:%d %s\n", assert, file, line, func);
   exit(1);
}

/* WordsToFileName */
/*   This procedure will convert a 4 PDP8 words into an OS/8 file name.	*/
/* OS/8 packs a 6 character file name and a two character extension in	*/
/* SIXBIT into four words.  This function returns the file name in a	*/
/* "pretty" format - it will remove embedded blanks and will add the	*/
/* missing "." to the extension.					*/
PUBLIC void WordsToFileName (UINT16 *pwWords, char *pszName)
{
  char szChars[8];  UINT i;
  for (i = 0;  i < 4;  i++)
    WordToChars(pwWords[i], szChars[2*i], szChars[2*i+1]);
  for (i = 0;  i < 8;  i++)
    if (szChars[i] == ' ') szChars[i] = '\0';
  strncpy(pszName, szChars, 6);  pszName[6] = '\0';  
  strcat(pszName, ".");
  strncat(pszName, &szChars[6], 2);  pszName[9] = '\0';
} /*WordsToFileName*/


/* FileNameToWords */
/*   This function is the reverse of WordsToFileName, however it's much	*/
/* more complicated since in this case the source string may not be a 	*/
/* syntactically valid OS/8 file name.  Only alphanumeric characters	*/
/* A-Z and 0-9 are allowed, and lower case letters are folded to upper.	*/
/* Only the first six letters of the name and the first two of the ex-	*/
/* tension are used and any extra letters are ignored.  This function	*/
/* returns TRUE if the filename is valid and FALSE if it isn't, but in	*/
/* either case the four PDP-8 words are filled in with the best approx-	*/
/* imation we can manage.  Note that if pwWords is NULL then the file	*/
/* name is validated but not stored.					*/
PUBLIC BOOLEAN FileNameToWords (char *pszName, UINT16 *pwWords)
{
  char szChars[8];  UINT i;  BOOLEAN fValid, fType;
  
  /* Parse the file specification... */
  memset(szChars, ' ', 8);  i = 0;  fValid = TRUE;  fType = FALSE;
  while (*pszName != '\0') {
    if (isalnum(*pszName)) {
      if (i < (UINT) (fType ? 8 : 6))  szChars[i++] = CAP(*pszName);
    } else if (*pszName == '.') {
      if (fType) fValid = FALSE;
      fType = TRUE;  i = 6;
    } else
      fValid = FALSE;
    ++pszName;
  }
  
  /* Convert to PDP-8 words... */
  if (pwWords != NULL) {
    for (i = 0;  i < 4;  i++)
      pwWords[i] = CharsToWord(szChars[2*i], szChars[2*i+1]);
  }
  
  return fValid;
} /*FileNameToWords*/


/* ParseOS8FileName */
/*   This function will parse an OS/8 file name into its file name and	*/
/* type (aka extension) components...					*/
PUBLIC void ParseOS8FileName (char *pszFile, char *pszName, char *pszType)
{
  char *pszDot = strchr(pszFile, '.');
  if (pszDot != NULL) {
    *pszDot = '\0';  strcpy(pszName, pszFile);  *pszDot = '.';
    strcpy(pszType, pszDot);
  } else {
    strcpy(pszName, pszFile);  *pszType = '\0';
  }
}


/* WildMatch */
/*   This procedure will take two OS/8 file names, the first of which	*/
/* may contain wild cards, and return TRUE if they are identical.  The	*/
/* only wild card character this procedure needs to deal with is "?",	*/
/* since StringToFILENAME will convert "*" to these.			*/
PRIVATE BOOLEAN WildMatch (char *pszMask, char *pszName)
{
  BOOLEAN fMatch = TRUE;
  while ((*pszMask != '\0')  &&  (*pszName != '\0')) {
    if (*pszMask == '*') {
      while ((*pszMask != '.') && (*pszMask != '\0')) ++pszMask;
      while ((*pszName != '.') && (*pszName != '\0')) ++pszName;
    } else {
      if ((*pszMask != '?') && (CAP(*pszMask) != CAP(*pszName))) fMatch = FALSE;
      ++pszMask;  ++pszName;
    }
  }
  return fMatch;
} /*WildMatch*/


/************************************************************************/
/* OS/8 Date Functions */
/************************************************************************/


/* GetCurrentDate - Return current year, month and date */
PRIVATE void GetCurrentDate (UINT *puDay, UINT *puMonth, UINT *puYear)
{
#if 0
  time_t lTime;
  struct tm *ptm;
  time(&lTime);  ptm = localtime(&lTime);
  *puYear   = ptm->tm_year;
  *puMonth  = ptm->tm_mon + 1;
  *puDay    = ptm->tm_mday;
#endif
  *puYear   = 77;
  *puMonth  = 1;
  *puDay    = 1;
#ifdef OBSOLETE
  var numbuf: $NUMTIMBUF;  status: INTEGER;
  status := $NUMTIM(numbuf,);
  if (not odd(status)) then $signal(status);
  d := numbuf.day;  m := numbuf.month;  y := numbuf.year-1900;
#endif
} /*GetCurrentDate*/


/* GetOS8CurrentDate - get today as an OS/8 date */
PUBLIC void GetOS8CurrentDate (UINT16 *pwDT)
{
  UINT nDay, nMonth, nYear;
  GetCurrentDate(&nDay, &nMonth, &nYear);
  *pwDT = ((nYear-OS8_BASE_YEAR) & 07) | (nDay << 3) | (nMonth << 8);
} /*GetOS8CurrentDate*/


/* OS8DateToDMY - convert OS/8 date 12 bit date word to day, month and year */
PUBLIC void OS8DateToDMY (UINT16 wDT, UINT *pnDay, UINT *pnMonth, UINT *pnYear)
{
  UINT nCurDay, nCurMonth, nCurYear;
  GetCurrentDate(&nCurDay, &nCurMonth, &nCurYear);
  *pnYear = (wDT & 07) + OS8_BASE_YEAR;
  if (*pnYear > nCurYear) *pnYear -= 8;
  *pnMonth = (wDT >> 8) & 0x0f;
  if ((*pnMonth < 1) || (*pnMonth > 12)) *pnMonth = 12;
  *pnDay   = (wDT >> 3) & 0x1f;
} /*OS8DateToDMY*/

/* COSDateToDMY - convert OS/8 date 12 bit date word to day, month and year */
PUBLIC void COSDateToDMY (UINT16 wDT, UINT *pnDay, UINT *pnMonth, UINT *pnYear)
{
  UINT nCurDay, nCurMonth, nCurYear;
  GetCurrentDate(&nCurDay, &nCurMonth, &nCurYear);
  *pnYear = (wDT & 07) + COS_BASE_YEAR;
  if (*pnYear > nCurYear) *pnYear -= 8;
  *pnMonth = (wDT >> 8) & 0x0f;
  if ((*pnMonth < 1) || (*pnMonth > 12)) *pnMonth = 12;
  *pnDay   = (wDT >> 3) & 0x1f;
} /*COSDateToDMY*/


/************************************************************************/
/* OS/8 Data Conversion Procedures */
/************************************************************************/


/* OS8BlockToBytes */
/*   This procedure will convert an OS/8 block of 256 12 bit words into	*/
/* 384 8 bit bytes.  This unpacking is done by the standard OS/8 conv-	*/
/* ention for word to byte translations.  It is used for both ASCII and	*/
/* image mode reading...						*/
PUBLIC void OS8BlockToBytes (UINT16 *pw, UINT8 *pb)
{
  UINT i;
  for (i = 0;  i < OS8_BLOCK_SIZE/2;  ++i) {
    pb[3*i  ] = (UINT8) (pw[2*i  ] & 0xff);
    pb[3*i+1] = (UINT8) (pw[2*i+1] & 0xff);
    pb[3*i+2] = (UINT8) (((pw[2*i] >> 4) & 0xf0) | ((pw[2*i+1] >> 8) & 0x0f));
  }
} /*OS8BlockToBytes*/


/* OS8BytesToBlock - the reverse of BlockToBytes... */
PUBLIC void OS8BytesToBlock (UINT8 *pb, UINT16 *pw)
{
  UINT i;
  for (i = 0;  i < OS8_BLOCK_SIZE/2;  ++i) {
    pw[2*i]   = (UINT16) (pb[3*i]   | ((pb[3*i+2] & 0xf0) << 4));
    pw[2*i+1] = (UINT16) (pb[3*i+1] | ((pb[3*i+2] & 0x0f) << 8));
  }
} /*OS8BytesToBlock*/


/************************************************************************/
/* OS/8 ASCII File Conversion Procedures */
/************************************************************************/


/*   OS/8 ASCII files consist of 8 bit bytes packed three characters per */
/* two 12 bit words.  The actual unpacking from 12 bits to 8 bits is	 */
/* the same used for image mode transfers.  OS/8 only uses 7 bit ASCII	 */
/* characters, and quite often the MSB of the character will be a one	 */
/* (a holdover from the ASR days).  These procedures always trim the	 */
/* characters to 7 bits.  Null (zero) bytes are always ignored (these	 */
/* will occur in unpacked OS/8 ASCII files) and the ^Z character (032)	 */
/* always indicates the end of file, even if there are still data blocks */
/* remaining.  The combination of carriage return and line feed is 	 */
/* interpreted as a newline.  All other characters, including other	 */
/* control characters, are passed as is.				 */

/* OS8BufferASCIIChar */
/*   This procedure will handle the interpretation of a single ASCII	*/
/* character.  It will return FALSE if the character is ^Z (EOF), and	*/
/* TRUE otherwise.  It ignores nulls and converts CRLFs into newlines.	*/
/* All other characters are written to the file (after accumulating in	*/
/* the line buffer).							*/
#if 1
PUBLIC BOOLEAN OS8BufferASCIIChar
  (FILE *f, char ch, char *pszBuffer, UINT nMaxBuffer, BOOLEAN *pfTruncated)
{
  UINT cbBuffer;
  ch &= 0x7f;
//printf("Ch %d\n",ch);
  if (ch == OS8_EOF) {
    return FALSE;
  } else if ((ch == '\0' /*NUL*/) || (ch == '\015' /*CR*/)) {
    /* just ignore it for now */
  } else if (ch == '\012' /*LF*/) {
    fprintf(f, "%s\n", pszBuffer);  *pszBuffer = '\0';
  } else {
    cbBuffer = strlen (pszBuffer);
    if (cbBuffer < nMaxBuffer-1) {
      pszBuffer[cbBuffer] = ch;  pszBuffer[cbBuffer+1] = '\0';
    } else {
      //int cntr;
      *pfTruncated = TRUE;
      fprintf(f, "%s\n", pszBuffer);  *pszBuffer = '\0';
      //for (cntr = 0; cntr < nMaxBuffer; cntr++)
      //    printf(" %d ",pszBuffer[cntr]); 
    }
  }
  return TRUE;
} /*OS8BufferASCIIChar*/
#else
int buffer_char_count = 0;
BOOLEAN BufferASCIIChar
  (FILE *f, char ch, char *pszBuffer, UINT nMaxBuffer, BOOLEAN *pfTruncated)
{
  UINT cbBuffer;
  ch &= 0x7f;
//printf("Ch %d\n",ch);
  if (ch == OS8_EOF) {
    return FALSE;
  } else if ((ch == '\0' /*NUL*/) || (ch == '\015' /*CR*/)) {
    /* just ignore it for now */
  } else if (ch == '\012' /*LF*/) {
    fprintf(f, "\n");
    buffer_char_count = 0;
  } else {
    if (buffer_char_count < nMaxBuffer-1) {
       fputc(ch, f);
       buffer_char_count++;
    } else {
      //int cntr;
      *pfTruncated = TRUE;
      fprintf(f, "%c\n", ch);
      buffer_char_count = 0;
      //for (cntr = 0; cntr < nMaxBuffer; cntr++)
      //    printf(" %d ",pszBuffer[cntr]); 
    }
  }
  return TRUE;
} /*BufferASCIIChar*/
#endif

PUBLIC void OS8FlushASCIIChar(FILE *f, char *pszBuffer) {
#if 1
   if (*pszBuffer != 0) {
      fprintf(f, "%s\n", pszBuffer);  *pszBuffer = '\0';
   }
#else
   if (buffer_char_count != 0)
      fprintf(f, "\n");
   buffer_char_count = 0;
#endif
}

/* OS8ExtractASCIIFile */
/*   This procedure will extract an OS/8 file, given its starting block	 */
/* and length, and convert it to a standard ASCII text file.  The result */
/* is written to the text file handle given.  It will stop when it uses	 */
/* the specified number of blocks, or when it finds an OS/8 EOF (^Z)	 */
/* character.								 */
PUBLIC void OS8ExtractASCIIFile (UINT nBlock, int nLength, FILE *f, 
   int ignore_early_eof)
{
  UINT16 awData[OS8_BLOCK_SIZE];  UINT8 abData[OS8_BYTE_BLOCK_SIZE];
  STRING szLine;  BOOLEAN fEOF, fTruncated;  UINT i;

  fEOF = fTruncated = FALSE;  szLine[0] = '\0';
  while ((nLength > 0) && (ignore_early_eof || !fEOF)) {
    fEOF = FALSE;
    ReadOS8Block(nBlock, awData);  ++nBlock;  --nLength;
    OS8BlockToBytes(awData, abData);
    //for (i = 0;  (i < OS8_BYTE_BLOCK_SIZE) && !fEOF;  ++i)
    // OS/8 does strange things if EOF isn't in last block.  This doesn't
    // match it.
    for (i = 0;  (i < OS8_BYTE_BLOCK_SIZE) && (ignore_early_eof || !fEOF);  ++i)
      fEOF = !OS8BufferASCIIChar(f, abData[i], szLine, sizeof(szLine), &fTruncated);
  }
  OS8FlushASCIIChar(f, szLine);
  if (fTruncated)
    fprintf(f, "\nNote: Lines longer than %d characters were wrapped\n", MAXSTRING);
    //assert(FALSE);  /*one or more lines truncated*/
} /*OS8ExtractASCIIFile*/

/* OS8ExtractOctalFile */
/*   This procedure will extract an OS/8 file, given its starting block	 */
/* and length, and convert it to octal.  The result */
/* is written to the text file handle given.  It will stop when it uses	 */
/* the specified number of blocks. */
PUBLIC void OS8ExtractOctalFile (UINT nBlock, int nLength, FILE *f, 
   int ignore_early_eof)
{
  UINT16 awData[OS8_BLOCK_SIZE];  UINT8 abData[OS8_BYTE_BLOCK_SIZE];
  UINT i;

  while ((nLength > 0)) {
    ReadOS8Block(nBlock, awData);  ++nBlock;  --nLength;
    OS8BlockToBytes(awData, abData);
    //for (i = 0;  (i < OS8_BYTE_BLOCK_SIZE) && !fEOF;  ++i)
    // OS/8 does strange things if EOF isn't in last block.  This doesn't
    // match it.
    for (i = 0;  (i < OS8_BLOCK_SIZE);  ++i) {
      fprintf(f, "%04o ", awData[i]);
      if (i % 16 == 15) {
         fprintf(f,"\n");
      }
    }
  }
} /*OS8ExtractOctalFile*/

char OS8Conv6bit(int x)
{
   if (x == 037)
      return '\n';
   if (x == 043)
      return '\r';
   if (x == 047)
      return '\t';
   if (x <= 037)
      return x + 'A' - 1;
   else
      return x;
}

char OS8ConvCOS6bit(int x)
{
   if (x == 0)
      return 0;
   else if (x == 61)
      return '\t';
   else
      return x + 31;
}

/* OS8ExtractASCII6File */
/*   This procedure will extract an OS/8 file, given its starting block	 */
/* and length, and convert it to a standard ASCII text file.  The result */
/* is written to the text file handle given.  It will stop when it uses	 */
/* the specified number of blocks, or when it finds an OS/8 EOF (^Z)	 */
/* character.								 */
PUBLIC void OS8ExtractASCII6File (UINT nBlock, int nLength, FILE *f,
    int ignore_early_eof)
{
  UINT16 awData[OS8_BLOCK_SIZE];
  STRING szLine;  BOOLEAN fEOF, fTruncated;  UINT i;
  char c;

  fEOF = fTruncated = FALSE;  szLine[0] = '\0';
  while ((nLength > 0) && (ignore_early_eof || !fEOF)) {
    fEOF = FALSE;
    ReadOS8Block(nBlock, awData);  ++nBlock;  --nLength;
    // OS/8 does strange things if EOF isn't in last block.  This doesn't
    // match it.
    //for (i = 0;  (i < OS8_BLOCK_SIZE) && !fEOF;  ++i) {
    for (i = 0;  (i < OS8_BLOCK_SIZE) && (ignore_early_eof || !fEOF);  ++i) {
      if (awData[i] == 0) // EOF?
         fEOF = TRUE;
      else {
         c = OS8Conv6bit(awData[i] >> 6);
//printf("aw %d ",awData[i]);
//printf("%c %d ",c,c);
         if (c != 64)
            OS8BufferASCIIChar(f, c, szLine, sizeof(szLine), &fTruncated);
         c = OS8Conv6bit(awData[i] & 077);
         if (c != 64) 
            OS8BufferASCIIChar(f, c, szLine, sizeof(szLine), &fTruncated);
      }
    }
  }
  OS8FlushASCIIChar(f, szLine);
  if (fTruncated)
    fprintf(f, "\nNote: Lines longer than %d characters were wrapped\n", MAXSTRING);
    //assert(FALSE);  /*one or more lines truncated*/
} /*OS8ExtractASCII6File*/

/* OS8ExtractCOSFile */
/*   This procedure will extract a COS text file, given its starting block */
/* and length, and convert it to a standard ASCII text file.  The result */
/* is written to the text file handle given.  It will stop when it uses	 */
/* the specified number of blocks, or when it finds an OS/8 EOF (^Z)	 */
/* character.								 */
PUBLIC void OS8ExtractCOSFile (UINT nBlock, int nLength, FILE *f)
{
  UINT16 awData[OS8_BLOCK_SIZE];
  STRING szLine;  BOOLEAN fEOF, fTruncated;  UINT i;
  char c;
  int conv_words = 0; // 0 = no more words to convert to text
  int next_lineno = 0; // 1 = next word is line number

  fEOF = fTruncated = FALSE;  szLine[0] = '\0';
  while ((nLength > 0) && !fEOF) {
    fEOF = FALSE;
    ReadOS8Block(nBlock, awData);  ++nBlock;  --nLength;
    for (i = 0;  (i < OS8_BLOCK_SIZE) && !fEOF;  ++i) {
      if (conv_words == 0) {
         conv_words = 010000 - awData[i];
         next_lineno = 1;
         if (awData[i] == 0) // EOF?
            fEOF = TRUE;
      } else if (next_lineno) {
         char str[20];
         int n;

         next_lineno = 0;
         sprintf(str, "%d ", awData[i]);
         for (n = 0; n < strlen(str); n++) {
            OS8BufferASCIIChar(f, str[n], szLine, sizeof(szLine), &fTruncated);
         }
         conv_words--;
      } else {
         c = OS8ConvCOS6bit(awData[i] >> 6);
         if (c != 0)
            OS8BufferASCIIChar(f, c, szLine, sizeof(szLine), &fTruncated);
         c = OS8ConvCOS6bit(awData[i] & 077);
         if (c != 0) 
            OS8BufferASCIIChar(f, c, szLine, sizeof(szLine), &fTruncated);
         conv_words--;
         if (conv_words == 0) {
            OS8BufferASCIIChar(f, '\n', szLine, sizeof(szLine), &fTruncated);
         }
      }
    }
  }
  OS8FlushASCIIChar(f, szLine);
  if (fTruncated)
    fprintf(f, "\nNote: Lines longer than %d characters were wrapped\n", MAXSTRING);
    //assert(FALSE);  /*one or more lines truncated*/
} /*OS8ExtractASCII6File*/

typedef struct {
    int line_num;
    int offset;
    int last;
    int questionable;
} LINE_LIST;

int line_compare(const void *ain, const void *bin) {
   const LINE_LIST *a = ain;
   const LINE_LIST *b = bin;
/*
int line_compare(LINE_LIST *a, LINE_LIST *b) {
*/
   if (a->line_num > b->line_num)
      return 1; 
   else if (a->line_num < b->line_num)
      return -1; 
   else
      return 0;
}

/* OS8ExtractFocalFile */
/*   This procedure will extract an OS/8 file, given its starting block	 */
/* and length, and convert it to a standard ASCII text file.  The result */
/* is written to the text file handle given.  It will stop when it uses	 */
/* the specified number of blocks, or when it finds an OS/8 EOF (^Z)	 */
/* character.								 */
PUBLIC void OS8ExtractFocalFile (UINT nBlock, int nLength, FILE *f)
{
  UINT16 awData[OS8_BLOCK_SIZE*nLength];  
  STRING szLine;  BOOLEAN fEOF, fTruncated;  UINT i;
  LINE_LIST line_list[4096];
  int num_line = 0;
  int line_cntr;
  char c;
  int next_line;
  int new_line = 1;
  int need_15 = 0;
  int cntr;
  int block;
  int numch = 0;
  int last_rejected = 0;

  fEOF = fTruncated = FALSE;  szLine[0] = '\0';
  block = 0;
  while ((nLength > 0) && !fEOF) {
    fEOF = FALSE;
    ReadOS8Block(nBlock, &awData[block*OS8_BLOCK_SIZE]);  ++nBlock;  --nLength;
    block++;
  }
  if (awData[8] == 0) {
     fprintf(f, "File is corrupt so listing may have errors.  Lines starting with * may not be in program.\n\n");

     for (i = 8; i < ARRAYSIZE(awData);) {
         char ch[2];

         ch[0] = awData[i] >> 6;
         ch[1] = awData[i] & 077;
         for (cntr = 0; cntr <= 1; cntr++) {
            if (ch[cntr] == 077) {
               need_15 = 1;
            } else if (need_15) {
               need_15 = 0;
               if (ch[cntr] == 015) {
                  last_rejected = 0;
                  next_line = awData[i+1] - 0200;
                  line_list[num_line].questionable = 0;
                  if (next_line != -0200 && (next_line < 1 || 
                        next_line >= ARRAYSIZE(awData) ||
                        (awData[next_line-1] != 07715 &&
                        awData[next_line-1] != 01500)) ) {
                     line_list[num_line].questionable = 1;
                  }
                  if (awData[i+2] > 128 && (awData[i+2] % 128) < 100) {

                     line_list[num_line].line_num = awData[i+2];
                     line_list[num_line].offset = i+1;
                     if (num_line > 2 && next_line > 0 &&
                           next_line < ARRAYSIZE(awData) &&
                           awData[i+1] < 0200)
                        line_list[num_line].last = 1;
                     else
                        line_list[num_line].last = 0;
                     num_line++;
                  } else {
                     last_rejected = 1;
                  }
                  i += 2;
                  break;
               }
            }
         }
         i++;
      }
      if (!last_rejected)
         num_line--;
      qsort(line_list, num_line, sizeof(line_list[0]), line_compare);
  }
  i = 8;
  line_cntr = 0;
  while (numch++ < 32768 && !fEOF && i > 0 && i < ARRAYSIZE(awData)) {
      if (new_line) {
         char buf[32];

         new_line = 0;
         next_line = awData[i];
         i++;
         if (awData[i] != 0) {
            sprintf(buf, "%2d.%02d ", awData[i] / 128, 
               awData[i] % 128);
            for (cntr = 0; cntr < 7; cntr++)
                OS8BufferASCIIChar(f, buf[cntr], szLine, sizeof(szLine), 
                   &fTruncated);
         }
         i++;
      } else {
         char ch[2];
         ch[0] = awData[i] >> 6;
         ch[1] = awData[i] & 077;
         for (cntr = 0; cntr <= 1; cntr++) {
            if (ch[cntr] == 077) {
               need_15 = 1;
            } else if (need_15) {
               need_15 = 0;
               OS8BufferASCIIChar(f, '\n', szLine, sizeof(szLine), &fTruncated);
               if (ch[cntr] == 015) {
                  if (num_line > 0) {
                     if (line_list[line_cntr].last || line_cntr >= num_line) {
                        fEOF = TRUE;
                     } else {
                        if (line_list[line_cntr].questionable)
                           OS8BufferASCIIChar(f, '*', szLine, sizeof(szLine), 
                               &fTruncated);
                        else
                           OS8BufferASCIIChar(f, ' ', szLine, sizeof(szLine), 
                               &fTruncated);
                        OS8BufferASCIIChar(f, ' ', szLine, sizeof(szLine), 
                            &fTruncated);
                        i = line_list[line_cntr++].offset - 1;
                     }
                  } else {
                     if (next_line == 0)
                        fEOF = TRUE;
                     i = next_line - 0200 - 1;
                  }
                  new_line = 1;
                  break;
               } else {
                  OS8BufferASCIIChar(f, ch[cntr], szLine, sizeof(szLine), &fTruncated);
               }
            } else {
               c = OS8Conv6bit(ch[cntr]);
//printf("aw %d ",awData[i]);
//printf("%c %d ",c,c);
               if (c != 64)
                  OS8BufferASCIIChar(f, c, szLine, sizeof(szLine), &fTruncated);
            }
         }
         i++;
     }
  }
  OS8FlushASCIIChar(f, szLine);
  if (fTruncated)
    fprintf(f, "\nNote: Lines longer than %d characters were wrapped\n", MAXSTRING);
    //assert(FALSE);  /*one or more lines truncated*/
} /*OS8ExtractFocalFile*/


/************************************************************************/
/* OS/8 Image File Procedures */
/************************************************************************/


/*   Any OS/8 file can be transferred in image mode.  This mode takes	 */
/* each block of 256 12 bit words and unpacks it into a record of 384 8	 */
/* bit bytes.  These byte records are then written to the host file sys- */
/* tem exactly as is.  Writing simply reverses this process.  No inter-	 */
/* pretation of the OS/8 data is done in either case.			 */

/* ExtractImageFile */
/*   This procedure will extract an OS/8 file to an image file.  It is	*/
/* given the handle of the image file (which must have already been	*/
/* opened), the starting block and length of the OS/8 file.		*/
PUBLIC void OS8ExtractImageFile (UINT nBlock, int nLength, int out)
{
  UINT16 awData[OS8_BLOCK_SIZE];  UINT8 abData[OS8_BYTE_BLOCK_SIZE];
  while (nLength > 0) {
    ReadOS8Block(nBlock, awData);  ++nBlock;  --nLength;
    OS8BlockToBytes(awData, abData);
    assert(write(out, abData, OS8_BYTE_BLOCK_SIZE) == OS8_BYTE_BLOCK_SIZE);
  }
} /*OS8ExtractImageFile*/


/************************************************************************/
/* OS/8 Directory Management Procedures */
/************************************************************************/


/* FindFirst - initialize OS8_FIND_DATA context */
PUBLIC void OS8FindFirst (OS8_FIND_DATA *pCX)
{
  /* Intialize everything to zero... */
  memset(pCX, 0, sizeof(OS8_FIND_DATA));
  /* Then make the next segment be the first segment on the disk... */
  pCX->nNextSegment = OS8_HOME_BLOCK;
} /*FindFirst*/


/* the OS8_FIND_DATA context accordingly.  If there are no more seg-	*/
/* ments, it will return FALSE.				 		*/
PRIVATE BOOLEAN NextSegment (OS8_FIND_DATA *pCX)
{
//printf("Block %d\n",pCX->nNextSegment);
  if (pCX->nNextSegment == 0) return FALSE;
  ReadOS8Block(pCX->nNextSegment, pCX->awData);
  pCX->nSegmentLBN = pCX->nNextSegment;
  /* Word 1: Number of files in this directory segment */
  pCX->nFiles = - NegWordToInt(pCX->awData[0]);
  assert(pCX->nFiles >= 0); /* bad directory: number of files */
  /* Word 2: Starting offset for files in this segment */
  pCX->nFileLBN = PosWordToInt(pCX->awData[1]);
  /* Word 3: Link to next directory segment */
  pCX->nNextSegment = PosWordToInt(pCX->awData[2]);
  /* Word 5: Additional information words */
  pCX->nAIW = - NegWordToInt(pCX->awData[4]);
  assert(pCX->nAIW >= 0 && pCX->nAIW <= 6); /* bad directory: AIW */
  /* Word 6: Start of file data */
  pCX->nPoint = 5;  pCX->nLast = 0;
  return TRUE;
} /*NextSegment*/


/* SkipDeleted - skip a deleted file entry in the current segment */
PRIVATE void SkipDeleted (OS8_FIND_DATA *pCX)
{
  int nLength;
  assert(pCX->awData[pCX->nPoint] == 0); /* not a deleted file entry*/
  nLength = - NegWordToInt(pCX->awData[pCX->nPoint+1]);
  assert(nLength >= 0); /* bad directory: length */
  pCX->nFileLBN += nLength;  pCX->nFiles--;
  pCX->nLast = pCX->nPoint;  pCX->nPoint += 2;
} /*SkipDeleted*/


/* SkipFile - skip a normal file entry in the current segment */
PRIVATE void SkipFile (OS8_FIND_DATA *pCX)
{
  int nLength;
  assert(pCX->awData[pCX->nPoint] != 0); /*a deleted file entry*/
  nLength = - NegWordToInt(pCX->awData[pCX->nPoint+pCX->nAIW+4]);
  pCX->nFileLBN += nLength;  pCX->nFiles--;
  pCX->nLast = pCX->nPoint;  pCX->nPoint += 5 + pCX->nAIW;
} /*SkipFile*/


/* FileData - extract information about the current file entry */
PRIVATE void FileData
  (OS8_FIND_DATA *pCX, char *pszName, UINT *pnBlock, int *pnLength, UINT16 *pwCDT)
{
  if (pCX->awData[pCX->nPoint] == 0) {
    /* This is a deleted file entry... */
    if (pszName != NULL) pszName[0] = EOS;
    if (pwCDT != NULL)  *pwCDT = 0;
    if (pnLength != NULL) {
      *pnLength = - NegWordToInt(pCX->awData[pCX->nPoint+1]);
      assert(*pnLength >= 0); /* bad directory: length */
    if (pnBlock != NULL) *pnBlock = pCX->nFileLBN;
    }
  } else {
    /* This is a normal file entry... */
    if (pszName != NULL)
      WordsToFileName(&(pCX->awData[pCX->nPoint]), pszName);
    if (pwCDT != NULL)
      *pwCDT = (pCX->nAIW > 0) ? pCX->awData[pCX->nPoint+4] : 0;
    if (pnLength != NULL) {
      *pnLength = - NegWordToInt(pCX->awData[pCX->nPoint+pCX->nAIW+4]);
      assert(*pnLength >= 0); /* bad directory: length */
    }
    if (pnBlock != NULL) *pnBlock = pCX->nFileLBN;
  }
} /* FileData */


/* OS8FindNext */
/*   This function will advance the OS8_FIND_DATA context to the next	*/
/* file in the directory and return data about that file.  If there are	*/
/* no more files in the current directory segment, it will read the 	*/
/* next one.  If there are no more segments, it will return FALSE.  The	*/
/* simplest way to traverse the OS/8 directory of the current diskette	*/
/* is to first call OS8FindFirst() to initialize the OS8_FIND_DATA, and	*/
/* then call OS8FindNext() repeated until it returns FALSE.		*/
/*									*/
/*  For each file, this function will return its name (in OS/8 format),	*/
/* its starting LBN and size, and its creation date word.  In the true	*/
/* OS/8 tradition, empty gaps (i.e. deleted files) are appear as files	*/
/* with a null name (and no CDT), however deleted files do have a start	*/
/* and a length.							*/
/*									*/
/*  When this function returns, the directory entry indicated by nPoint	*/
/* is always the _current_ one (i.e. the one we just returned). This is	*/
/* critical for functions like OS8Rename() or OS8Delete(), which search	*/
/* the directory for a specific entry and then modify it!		*/
PUBLIC BOOLEAN OS8FindNext (OS8_FIND_DATA *pCX,
  char *pszName, UINT *pnBlock, int *pnLength, UINT16 *pwCDT)
{
  /*   Skip over the current entry, provided that it isn't the last one	*/
  /* in this segment!							*/
  if (pCX->nFiles > 0) {
    /* Skip over the current directory entry... */
    if (pCX->awData[pCX->nPoint] == 0)
      /* This is a deleted file entry... */
      SkipDeleted(pCX);
    else
      /* This is a normal entry... */
      SkipFile(pCX);
  }
  
  /*   If this segment has no more files, then read the next one.  It's	*/
  /* possible (or at least I assume it's possible) that a directory	*/
  /* segment may have no files even though the one after it does, so we	*/
  /* have to skip all empty segments until we either find one with some	*/
  /* files or we run out of segments!					*/
  while (pCX->nFiles < 1) {
    if (!NextSegment(pCX)) return FALSE;
  }

  /* Return the data for the next directory entry... */
  FileData(pCX, pszName, pnBlock, pnLength, pwCDT);
  return TRUE;
}


/* OS8FindFile */
/*   This function is essentially identical to OS8FindNext(), except 	*/
/* that it will return only files which match the specified wild card	*/
/* mask.  Files which do not match, and all deleted files, are ingored.	*/
PUBLIC BOOLEAN OS8FindFile (OS8_FIND_DATA *pCX, char *pszMask,
  char *pszName, UINT *pnBlock, int *pnLength, UINT16 *pwCDT)
{
  assert(pszName != NULL);  /* can't be null, you dufus!*/
  while (TRUE) {
    if (!OS8FindNext(pCX, pszName, pnBlock, pnLength, pwCDT)) return FALSE;
    if (pszName[0] == EOS) continue;
    if (WildMatch(pszMask, pszName)) return TRUE;
  }
}


/* SystemDisk */
/*   This procedure will return TRUE if the currently mounted disk was	*/
/* initialized with space for an OS/8 system head.  Unfortunately there	*/
/* isn't any direct way to tell this, so we just fake it by looking at	*/
/* the starting position of the first file.				*/
PUBLIC BOOLEAN SystemDisk (void)
{
  UINT16 awData[OS8_BLOCK_SIZE];  UINT nOffset;
  /* Read the home block and figure the LBN of the first user file */
  ReadOS8Block(1, awData);  nOffset = PosWordToInt(awData[1]);
  /*   If there's a gap between the directory and the first file, then	*/
  /* that's the system space !						*/
  return nOffset > (OS8_HOME_BLOCK + OS8_DIRECTORY_SIZE);
} /*SystemDisk*/


/* OS8Exists */
/*   This function searches the OS/8 directory for a file matching the	*/
/* name given and returns TRUE if it finds one.  Since it uses its own	*/
/* FindData context for searching, any current OS/8 directory operation	*/
/* in progress (e.g. Rename!) is not disturbed...			*/
PUBLIC BOOLEAN OS8Exists (char *pszMask)
{
  OS8_FIND_DATA FindData;
  OS8FindFirst(&FindData);
  return OS8FindFile(&FindData, pszMask, NULL, NULL, NULL, NULL);
} /*OS8FileExists*/

