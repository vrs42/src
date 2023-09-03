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
#include <assert.h>	/* assert() macro (what else??)			*/
#include "types.h"	/* universal data type declarations		*/
#include "diskette.h"	/* RX01 and RX50 diskette emulation routines	*/
#include "os8.h"	/* function prototypes for this module		*/


/************************************************************************/
/* OS/8 File Name Manipulations */
/************************************************************************/


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
  time_t lTime;
  struct tm *ptm;
  time(&lTime);  ptm = localtime(&lTime);
  *puYear   = ptm->tm_year;
  *puMonth  = ptm->tm_mon + 1;
  *puDay    = ptm->tm_mday;
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

/* BufferASCIIChar */
/*   This procedure will handle the interpretation of a single ASCII	*/
/* character.  It will return FALSE if the character is ^Z (EOF), and	*/
/* TRUE otherwise.  It ignores nulls and converts CRLFs into newlines.	*/
/* All other characters are written to the file (after accumulating in	*/
/* the line buffer).							*/
PRIVATE BOOLEAN BufferASCIIChar
  (FILE *f, char ch, char *pszBuffer, UINT nMaxBuffer, BOOLEAN *pfTruncated)
{
  UINT cbBuffer;
  ch &= 0x7f;
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
    } else
      *pfTruncated = TRUE;
  }
  return TRUE;
} /*BufferASCIIChar*/


/* ExtractASCIIFile */
/*   This procedure will extract an OS/8 file, given its starting block	 */
/* and length, and convert it to a standard ASCII text file.  The result */
/* is written to the text file handle given.  It will stop when it uses	 */
/* the specified number of blocks, or when it finds an OS/8 EOF (^Z)	 */
/* character.								 */
PUBLIC void ExtractASCIIFile (UINT nBlock, int nLength, FILE *f)
{
  UINT16 awData[OS8_BLOCK_SIZE];  UINT8 abData[OS8_BYTE_BLOCK_SIZE];
  STRING szLine;  BOOLEAN fEOF, fTruncated;  UINT i;
  fEOF = fTruncated = FALSE;  szLine[0] = '\0';
  while ((nLength > 0) && !fEOF) {
    ReadOS8Block(nBlock, awData);  ++nBlock;  --nLength;
    OS8BlockToBytes(awData, abData);
    for (i = 0;  (i < OS8_BYTE_BLOCK_SIZE) && !fEOF;  ++i)
      fEOF = !BufferASCIIChar(f, abData[i], szLine, sizeof(szLine), &fTruncated);
  }
  if (fTruncated)
    assert(FALSE);  /*one or more lines truncated*/
} /*ExtractASCIIFile*/


/* FlushOS8Buffer */
/*   This procedure will write one buffer full of ASCII characters to	*/
/* the OS/8 output file, and re-initialize the buffer pointers.  If we	*/
/* have run out of room on the file, then it will return FALSE.		*/
PRIVATE BOOLEAN FlushOS8Buffer
  (UINT *pnBlock, int *pnLength, UINT *pnWritten, char *pszBuffer, UINT *pnBuffer)
{
  UINT16 awData[OS8_BLOCK_SIZE];
  if (*pnBuffer > 0) {
    ++*pnWritten;
    if ((int) *pnWritten <= *pnLength) {
      OS8BytesToBlock(pszBuffer, awData);
      WriteOS8Block(*pnBlock, awData);
      ++*pnBlock;  *pnBuffer = 0;
      return TRUE;
    } else
      return FALSE;
  }
} /*FlushOS8Buffer*/


/* BufferOS8Char */
/*   This procedure will add one ASCII character to an OS/8 buffer.  If	*/
/* the buffer is full, it will write it to the current output segment.	*/
/* If there is no more room, it will return FALSE.  All characters are	*/
/* converted to OS/8 8 bit ASCII with the 200(8) bit set.		*/
PRIVATE BOOLEAN BufferOS8Char
  (char ch, UINT *pnBlock, int *pnLength, UINT *pnWritten, char *pszBuffer, UINT *pnBuffer)
{
  if (*pnBuffer >= OS8_BYTE_BLOCK_SIZE) {
    if (FlushOS8Buffer(pnBlock, pnLength, pnWritten, pszBuffer, pnBuffer))
      return BufferOS8Char(ch, pnBlock, pnLength, pnWritten, pszBuffer, pnBuffer);
    else
      return FALSE;
  } else {
    pszBuffer[*pnBuffer] = ch | 0x80;  ++*pnBuffer;
    return TRUE;
  }
} /*BufferOS8Char*/


/* InsertASCIIFile */
/*   This procedure will read an external ASCII file, which must already */
/* be opened, convert the contents to OS/8 format, and write it to the	 */
/* diskette.  If there isn't enough room to write the file then it will	 */
/* return FALSE.							 */
PUBLIC BOOLEAN InsertASCIIFile (UINT nBlock, int *pnLength, FILE *f)
{
  BOOLEAN fDone;  UINT nWritten, nBuffer, i;
  STRING szLine;  char szBuffer[OS8_BYTE_BLOCK_SIZE];
  
  fDone = FALSE;  nWritten = nBuffer = 0;
  while (!fDone) {
    if (fgets(szLine, sizeof(szLine), f) == NULL) {
      fDone = TRUE;
    } else {
      for (i = 0;  (szLine[i] != '\n') && !fDone;  ++i)
	fDone = !BufferOS8Char(szLine[i], &nBlock, pnLength, &nWritten, szBuffer, &nBuffer);
      if (!fDone)
	fDone = !BufferOS8Char('\015', &nBlock, pnLength, &nWritten, szBuffer, &nBuffer);
      if (!fDone)
	fDone = !BufferOS8Char('\012', &nBlock, pnLength, &nWritten, szBuffer, &nBuffer);
    }
  }
  if ((int) nWritten <= *pnLength) {
    fDone = !BufferOS8Char(OS8_EOF, &nBlock, pnLength, &nWritten, szBuffer, &nBuffer);
    if (!fDone)
      fDone = FlushOS8Buffer(&nBlock, pnLength, &nWritten, szBuffer, &nBuffer);
  }
  if ((int) nWritten <= *pnLength) {
    *pnLength = (int) nWritten;  return TRUE;
  } else {
    *pnLength = 0;  return FALSE;
  }
} /*InsertASCIIFile*/


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
PUBLIC void ExtractImageFile (UINT nBlock, int nLength, int out)
{
  UINT16 awData[OS8_BLOCK_SIZE];  UINT8 abData[OS8_BYTE_BLOCK_SIZE];
  while (nLength > 0) {
    ReadOS8Block(nBlock, awData);  ++nBlock;  --nLength;
    OS8BlockToBytes(awData, abData);
    assert(write(out, abData, OS8_BYTE_BLOCK_SIZE) == OS8_BYTE_BLOCK_SIZE);
  }
} /*ExtractImageFile*/


/* InsertImageFile */
/*   This procedure will copy an external file onto an OS/8 diskette	 */
/* using image mode transfers.  It is given the handle of the image mode */
/* file (which must already be opened) and the starting block and max-	 */
/* imum length of the OS/8 free space.  On return it will update the	 */
/* length parameter to reflect the actual number of blocks written.  If	 */
/* the file is too long for the space available, it will return FALSE	 */
/* and a length of zero.						 */
PUBLIC BOOLEAN InsertImageFile (UINT nBlock, int *pnLength, int inp)
{
  UINT16 awData[OS8_BLOCK_SIZE];  UINT8 abData[OS8_BYTE_BLOCK_SIZE];
  UINT nWritten, cbData;  BOOLEAN fDone;
  fDone = FALSE;  nWritten = 0;
  while (!fDone) {
    cbData = read(inp, abData, OS8_BYTE_BLOCK_SIZE);
    if (cbData == 0) {
      fDone = TRUE;
    } else {
      if (cbData < OS8_BYTE_BLOCK_SIZE)
        assert(FALSE); /*partial last block written*/
      ++nWritten;
      if ((int) nWritten > *pnLength) {
	fDone = TRUE;
      } else {
	OS8BytesToBlock(abData, awData);
	WriteOS8Block(nBlock, awData);
	++nBlock;
      }
    }
  }
  if ((int) nWritten <= *pnLength) {
    *pnLength = (int) nWritten;  return TRUE;
  } else {
    *pnLength = 0;  return FALSE;
  }
} /*InsertImageFile*/


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


/* RemoveDirWords */
/*   This procedure will remove the specified number of words from the	 */
/* current directory segment, starting with the offset given.  This does */
/* NOT update any other directory information, nor does it re-write the	 */
/* directory segment to the disk.  Zero words are added to the end of	 */
/* the directory as required.						 */
PRIVATE void RemoveDirWords (OS8_FIND_DATA *pCX, UINT nOffset, int nLength)
{
  while (nOffset < OS8_BLOCK_SIZE) {
    if ((int) nOffset < (OS8_BLOCK_SIZE-nLength))
      pCX->awData[nOffset] = pCX->awData[nOffset+nLength];
    else
      pCX->awData[nOffset] = 0;
    ++nOffset;
  }
} /*RemoveDirWords*/


/* AddDirWords */
/*   This procedure will add a specified number of words to the current	 */
/* directory segment BEFORE the current entry.  It's primary use is to	 */
/* add a new temporary file entry before a deleted file entry.  If there */
/* is not enough room in the segment for the words required, then the	 */
/* segment is left unchanged and FALSE is returned.  Note that this	 */
/* procedure does NOT update the file count in the segment header; this	 */
/* is a necessary operation !						 */
PRIVATE BOOLEAN AddDirWords (OS8_FIND_DATA *pCX, UINT nWords)
{
  UINT nPnt = pCX->nPoint;
  UINT nCnt = pCX->nFiles;
  /* Skip ahead until we find the last entry in this segment */
  while (nCnt > 0) {
    nPnt +=  (pCX->awData[nPnt] == 0)  ?  2  :  5 + pCX->nAIW;
    --nCnt;
  }

  /*   At this point, pnt is the offset of the first free word in this	*/
  /* segment.  If adding the words we need would overflow the segment,	*/
  /* then return FALSE and do nothing else.				*/
  if ((nPnt+nWords) > OS8_BLOCK_SIZE) return FALSE;

  /*   There's enough room, so roll the words down until we get back	*/
  /* to our starting point.						*/
  while (nPnt > pCX->nPoint) {
    --nPnt;
    pCX->awData[nPnt+nWords] = pCX->awData[nPnt];
  }
  return TRUE;
} /*AddDirWords*/


/* NextSegment */
/*   This procedure will read the next OS/8 directory segment and reset	*/
/* the OS8_FIND_DATA context accordingly.  If there are no more seg-	*/
/* ments, it will return FALSE.				 		*/
PRIVATE BOOLEAN NextSegment (OS8_FIND_DATA *pCX)
{
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
  assert(pCX->nAIW >= 0); /* bad directory: AIW */
  /* Word 6: Start of file data */
  pCX->nPoint = 5;  pCX->nLast = 0;
  return TRUE;
} /*NextSegment*/


/* WriteSegment - write the current directory segment back to the disk */
PRIVATE void WriteSegment (OS8_FIND_DATA *pCX)
{
  assert(pCX->nSegmentLBN > 0); /* No current directory segment */
  WriteOS8Block(pCX->nSegmentLBN, pCX->awData);
} /*WriteSegment*/


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


/* FindHole */
/*  This procedure will find the largest empty space on the diskette and */
/* will return its starting address and legnth.  In addition, the OS8_	 */
/* FIND_DATA will be left at the deleted file directory entry which 	 */
/* corresponds to that hole. This is essential for the OS8Close function */
/* to be able to add the new file name to the directory.  If the disk is */
/* completely full (i.e. there are no deleted file entries), then zero	 */
/* is returned for the length. 						 */
PRIVATE void FindHole (OS8_FIND_DATA *pCX, UINT *pnBlock, int *pnLength)
{
  OS8_FIND_DATA HoleData;  STRING szName;  UINT nHoleBlock;  int nHoleLength;
  *pnBlock = *pnLength = 0;
  OS8FindFirst(pCX);
  while (OS8FindNext(pCX, szName, &nHoleBlock, &nHoleLength, NULL)) {
    if (szName[0] != EOS) continue;
    if (nHoleLength > *pnLength) {
      *pnLength = nHoleLength;  *pnBlock = nHoleBlock;  HoleData = *pCX;
    }
  }
  if (*pnLength > 0) *pCX = HoleData;
} /*FindHole*/


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


/* OS8Rename */
/*   This procedure will rename the current directory entry to the new	*/
/* name given.  It does not verify that the new name is unique !  The	*/
/* current entry must not be a deleted file !  The current directory	*/
/* segment will be re-written after this operation.			*/
PUBLIC void OS8Rename (OS8_FIND_DATA *pCX, char *pszNewName)
{
  assert(pCX->awData[pCX->nPoint] != 0); /*a deleted file entry*/
  FileNameToWords(pszNewName, &(pCX->awData[pCX->nPoint]));
  WriteSegment(pCX);
} /*OS8Rename*/


/* OS8Delete */
/*   This procedure will turn the current directory entry into a deleted */
/* file entry.  Since deleted file entries are shorter than normal file	 */
/* entries, we have to "roll up" the remainder of the directory segment. */
/* This procedure will squeeze out multiple empty entries in this dir-	 */
/* ectory segment, but it will not attempt to squeeze other segments as	 */
/* well (that's left for the SQUISH function).  Note that the current	 */
/* directory entry becomes a deleted file when this procedure is done.	 */
PUBLIC void OS8Delete (OS8_FIND_DATA *pCX)
{
  /*   If the last directory entry was also a deleted file, then combine */
  /* the space allocated to this file with that one and then completely	 */
  /* remove the current entry.						 */
  if ((pCX->nLast > 0)  &&  (pCX->awData[pCX->nLast] == 0)) {
    AddNegWord(pCX->awData[pCX->nLast+1], pCX->awData[pCX->nPoint+pCX->nAIW+4]);
    RemoveDirWords(pCX, pCX->nPoint, 5+pCX->nAIW);  pCX->nPoint = pCX->nLast;
    DecNegWord(pCX->awData[0]);
  }
  /* Turn this entry into a deleted file */
  if (pCX->awData[pCX->nPoint] != 0) {
    pCX->awData[pCX->nPoint] = 0;
    pCX->awData[pCX->nPoint+1] = pCX->awData[pCX->nPoint+pCX->nAIW+4];
    RemoveDirWords(pCX, pCX->nPoint+2, pCX->nAIW+3);
  }
  /* If the next entry is also a deleted file, then add it to this one */
  if ((pCX->nFiles > 1)  &&  (pCX->awData[pCX->nPoint+2] == 0)) {
    AddNegWord(pCX->awData[pCX->nPoint+1], pCX->awData[pCX->nPoint+3]);
    RemoveDirWords(pCX, pCX->nPoint+2, 2);
    pCX->nFiles--;  DecNegWord(pCX->awData[0]);
  }
  /* Rewrite this directory segment to the diskette */
  WriteSegment(pCX);
} /*OS8Delete*/


/* OS8Enter								 */
/*   This procedure will perform an OS/8 ENTER function.  It does this	 */
/* by searching out the largest hole in the current directory and adding */
/* a new file entry (for the name and date specified) in FRONT of the	 */
/* empty file entry.  The length of this new file is set to zero and the */
/* starting block and length of the empty segment is returned.  The data */
/* (up to the maximum length given) is written by the caller, and then	 */
/* the OS8Close procedure is called with the actual length.		 */
PUBLIC void OS8Enter (OS8_FIND_DATA *pCX, char *pszName, UINT16 cdt, UINT *pnBlock, int *pnLength)
{
  /* Set the current directory entry to the largest hole */
  FindHole(pCX, pnBlock, pnLength);
  if (*pnLength > 0) {
    /* Add a new file entry to the current segment in FRONT of the empty */
    if (AddDirWords(pCX, pCX->nAIW+5)) {
      IncNegWord(pCX->awData[0]);  pCX->nFiles++;
      FileNameToWords(pszName, &(pCX->awData[pCX->nPoint]));
      if (pCX->nAIW > 0) pCX->awData[pCX->nPoint+4] = cdt;
      pCX->awData[pCX->nPoint+pCX->nAIW+4] = 0;
    } else {
      /* directory segment overflow !! */
      assert (FALSE); /* not yet implemented! */
    }
  }
} /*OS8Enter*/


/*   This procedure will close the currently open output file.  It is	 */
/* given the actual length of the data written, and will store this as	 */
/* the length of the tentative file entry.  The length of the empty	 */
/* space after the file entry is decremented by the actual file length,	 */
/* and removed from the directory segment if it is zero.  This procedure */
/* WILL rewrite the current segment.					 */
PUBLIC void OS8Close (OS8_FIND_DATA *pCX, int nLength)
{
  assert(pCX->awData[pCX->nPoint+pCX->nAIW+4] == 0); /* no tentative file entry */
  if (nLength == 0) {
    RemoveDirWords(pCX, pCX->nPoint, pCX->nAIW+5);
    DecNegWord(pCX->awData[0]);  pCX->nFiles--;
  } else {
    pCX->awData[pCX->nPoint+pCX->nAIW+4] = IntToWord(- nLength);
    assert(pCX->awData[pCX->nPoint+pCX->nAIW+5] == 0); /* no empty file on close */
    nLength += NegWordToInt(pCX->awData[pCX->nPoint+pCX->nAIW+6]);
    assert(nLength <= 0); /* created file too long */
    if (nLength == 0) {
      RemoveDirWords(pCX, pCX->nPoint+pCX->nAIW+5, 2);
      DecNegWord(pCX->awData[0]);  pCX->nFiles--;
    } else 
      pCX->awData[pCX->nPoint+pCX->nAIW+6] = IntToWord(nLength);
  }
  WriteSegment(pCX);
} /*OS8Close*/


/* OS8Initialize */
/*   This procedure will initialize the current diskette according the	*/
/* the associated global variables.  It simply writes a directory with	*/
/* one empty file entry for the remainder of the disk space.  If the	*/
/* current disk is a system disk, then space will be reserved for the	*/
/* OS/8 system head.							*/
PUBLIC void OS8Initialize (BOOLEAN fSystem)
{
  UINT i, nStart, nFree;  UINT16 awData[OS8_BLOCK_SIZE];

  /* Allow for directory and boot block */
  nStart = OS8_DIRECTORY_SIZE + 1;

  /* Allow for system head, if present */
  if (fSystem) nStart += OS8_SYSTEM_SIZE;

  /* Calculate the remaining free space */
  switch (DiskType()) {
    case RX01:  nFree = OS8_RX01_SIZE - nStart + 1;  break;
    case RX50:  nFree = OS8_RX50_SIZE - nStart + 1;  break;
    case VM01:  nFree = OS8_VM01_SIZE - nStart + 1;  break;
    case RK05:  nFree = OS8_RK05_SIZE - nStart + 1;  break;
    default:    assert(FALSE);
  }

  /* Dummy up the first directory segment with an empty file entry */
  awData[0] = IntToWord(-1);		/* number of files	 */
  awData[1] = IntToWord(nStart);	/* offset of first file	 */
  awData[2] = 0;			/* no next segmentt	 */
  awData[3] = 0;			/* no tentative files	 */
  awData[4] = IntToWord(-1);		/* number of AIWs	 */
  awData[5] = 0;			/* first entry - empty	 */
  awData[6] = IntToWord(- (int) nFree);	/* number of free blocks */
  for (i = 7;  i < OS8_BLOCK_SIZE;  ++i) awData[i] = 0;
  WriteOS8Block(OS8_HOME_BLOCK, awData);

  /* Finally, write empty blocks for the remaining segments */
  for (i = 0;  i < OS8_BLOCK_SIZE;  ++i) awData[i] = 0;
  for (i = 1;  i < OS8_DIRECTORY_SIZE; ++i) WriteOS8Block(OS8_HOME_BLOCK+i, awData);
} /*OS8Initialize*/
