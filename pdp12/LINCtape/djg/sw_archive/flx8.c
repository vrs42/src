/*++									*/
/* flx8.c 								*/
/*									*/
/* DESCRIPTION:								*/
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
/* REVISION HISTORY:							*/
/*                                                                      */
/* dd-mmm-yy	who	description					*/
/*  ?-???-??	RLA	New file.					*/
/*  9-May-00	RLA	Add VM01 and RK05 support.			*/
/*  9-May-00	RLA	When initializing an RK05, always initialize	*/
/*			all partitions - otherwise there's no way to	*/
/*			create a valid B partition!			*/
/*--									*/

/* Include files... */
#include <stdio.h>	/* printf(), fprintf(), etc...			*/
#include <stdlib.h>	/* malloc(), exit(), splitpath(), etc..		*/
#include <string.h>	/* strlen(), strcat(), strcpy(), etc...		*/
#ifdef VMS
#include <unixio.h>	/* VMS versions of _read(), _write(), etc...	*/
#include <file.h>	/* VMS versions of O_RDWR, O_CREAT, etc...	*/
#include <stat.h>	/* VMS versions of S_IWRITE, etc...		*/
#define  O_BINARY    0	/* VMS doesn't have this, so we ignore it	*/
#else
#include <fcntl.h>	/* O_RDWR, O_CREAT, O_BINARY, etc...		*/
#ifdef WINDOWS
#include <io.h>		/* open(), read(), write(), etc...		*/
#include <sys\stat.h>	/* S_IWRITE, S_IREAD, et al...			*/
#else
#include <sys/stat.h>	/* S_IWRITE, S_IREAD, et al...			*/
#define  O_BINARY    0	/* Unix doesn't have this, so we ignore it	*/
#endif
#endif                  
#include <ctype.h>	/* isspace(), isalnum(), etc...			*/
#include <assert.h>	/* assert() macro (what else??)			*/
#include "types.h"	/* standard data types				*/
#include "command.h"	/* command parser functions			*/
#include "diskette.h"	/* physical/virtual disekette access		*/
#include "os8.h"	/* OS/8 directory functions			*/

/* Miscellaneous global variables */  
PRIVATE BOOLEAN fFinished	/* TRUE when FLX should exit		*/
			  = FALSE;


/************************************************************************/
/****************     D I S M O U N T   C O M M A N D    ****************/
/************************************************************************/


/* ReadableDisk - return TRUE if diskette is mounted and readable */
PRIVATE BOOLEAN ReadableDisk (void)
{
  if (DiskMounted()) return TRUE;
  Message('E',"no diskette mounted");
  return FALSE;
} /*ReadableDisk*/


/* WritableDisk - return TRUE if diskette is mounted and writable */
PRIVATE BOOLEAN WritableDisk (void)
{
  if (!ReadableDisk()) return FALSE;
  if (!ReadOnly()) return TRUE;
  Message('E',"diskette is read only");
  return FALSE;
} /*WritableDisk*/


/* DismountDisk */
/*   This procedure will do the actual work of dismounting the current	*/
/* diskette.  It is called both by the dismount command and by the EXIT	*/
/* command.								*/
PRIVATE void DismountDisk (void)
{
  if (ReadableDisk()) {
   Message('I', "dismounting diskette %s", DiskName());
   CloseDisk();
  }
} /*DismountDisk*/


/* DoDismount - dismount the currently mounted diskette */
PRIVATE void DoDismount (char *pszQualifiers, char *pszP1, char *pszP2)
{
  if (NoQualifiers(pszQualifiers) && CheckParameter(0, pszP1, pszP2))
    DismountDisk();
} /*DoDismount*/


/************************************************************************/
/****************        M O U N T   C O M M A N D       ****************/
/************************************************************************/


/* ParseMount								 */
/*   This procedure will parse the argument and qualifiers for the MOUNT */
/* command.  If there is any problem with the command, a message will be */
/* printed and FALSE is returned.					 */
PRIVATE BOOLEAN ParseMount
  (char *pszQualifiers, char *pszP1, char *pszP2, char *pszName, DISKTYPE *pnType,
   BOOLEAN *pfInitialize, BOOLEAN *pfVirtual, BOOLEAN *pfSystem, BOOLEAN *pfRead, BOOLEAN *pfConfirm)
{
  STRING szItem;  UINT nItem = 1;
  
  /* Set the defaults */
  *pfVirtual = *pfConfirm = TRUE;  *pnType = RX50;
  *pfRead = *pfInitialize = *pfSystem = FALSE;  pszName[0] = EOS;

  /* Parse the qualifiers */
  while (StringItem(pszQualifiers, szItem, SLASH, nItem)) {
         if (STRNEQL(szItem, "RX01",      4))   *pnType = RX01;
    else if (STRNEQL(szItem, "RX50",      4))   *pnType = RX50;
    else if (STRNEQL(szItem, "VM01",      4))   *pnType = VM01;
    else if (STRNEQL(szItem, "RK05",      4))   *pnType = RK05;
    else if (STRNEQL(szItem, "LINKOS8",      7))   *pnType = LINK_OS8;
    else if (STRNEQL(szItem, "PHYSICAL",  3))   *pfVirtual = FALSE;
    else if (STRNEQL(szItem, "VIRTUAL",   3))   *pfVirtual = TRUE;
    else if (STRNEQL(szItem, "READ_ONLY", 4))   *pfRead = TRUE;
    else if (BooleanQualifier(szItem, "SYSTEM",     3, pfSystem))     /* */;
    else if (BooleanQualifier(szItem, "INITIALIZE", 3, pfInitialize)) /* */;
    else if (BooleanQualifier(szItem, "CONFIRM",    4, pfConfirm))    /* */;
    else {UnknownQualifier(szItem);   return FALSE;}
    ++nItem;
  }

  /* /PHYSICAL is allowed only with RX01s and RX50s... */
  if (!*pfVirtual && !((*pnType == RX01) || (*pnType == RX50))) {
    Message('E', "/PHYSICAL can be used only with diskettes");  return FALSE;
  }

  /* The only parameter is the name of the file/device to mount */
  if (!CheckParameter(1, pszP1, pszP2)) return FALSE;
  if (!OneItem(pszP1)) return FALSE;
  strcpy(pszName, pszP1);

  return TRUE;
} /*ParseMount*/


/* DefaultVirtualDiskName - apply defaults to virtual disk name */
PRIVATE void DefaultVirtualDiskName (char *pszDiskName)
{
  STRING szPath, szName, szType;
  ParseHostFileName(pszDiskName, szPath, szName, szType);
  if (strlen(szType) == 0) strcpy(szType, ".DSK");
  strcpy(pszDiskName, szPath);
  strcat(pszDiskName, szName);
  strcat(pszDiskName, szType);
} /*DefaultVirtualDiskName*/


/* DoMount								*/
/*   This procedure will parse and execute the mount command.		*/
PRIVATE void DoMount (char *pszQualifiers, char *pszP1, char *pszP2)
{
  BOOLEAN fSuccess = FALSE;  STRING szName;  DISKTYPE nType;
  BOOLEAN fInitialize, fSystem, fVirtual, fRead, fConfirm;
  
  /*   If a diskette is already mounted, then force it to be dismounted	*/
  /* (before changing anything !!).  Then initialize all diskette para-	*/
  /* meters to the appropriate defaults.				*/
  if (DiskMounted()) DismountDisk();

  /* Now parse the command switches */
  if (!ParseMount(pszQualifiers, pszP1, pszP2, szName, &nType,
         &fInitialize, &fVirtual, &fSystem, &fRead, &fConfirm)) return;

  if (fVirtual) {

    /* Mount a virtual diskette on a normal file... */
    DefaultVirtualDiskName(szName);
    /* First try to open an existing disk file */
    if (OpenDisk(fVirtual, fRead, nType, szName)) {
      /* The file exists - initialize it only if the user confirms! */
        DoInitialize(fSystem);
    } else
      /* Can't read or create the virtual image file ... */
      Message('E', "unable to access virtual disk file %s", szName);

  } else {
      Message('E', "unable to access physical disk drive", szName);
  }
} /*DoMount*/


/************************************************************************/
/***************     P A R T I T I O N   C O M M A N D    ***************/
/************************************************************************/

/*   The PARTITION command is used to select the active disk partition	*/
/* on RK05 images (and RL01/RL02s, if we ever support those).  It has	*/
/* no qualifiers and the only argument is a single letter which selects	*/
/* the partition to use (e.g. "A", "B", etc).				*/
PRIVATE void DoPartition (char *pszQualifiers, char *pszP1, char *pszP2)
{
  if (   NoQualifiers(pszQualifiers)
      && CheckParameter(1, pszP1, pszP2)
      && OneItem(pszP1)) {
    if ((strlen(pszP1) != 1)  ||  !SetPartition(pszP1[0]))
      Message('E',"invalid partition name %s", pszP1);
  }
} /*DoPartition*/


/************************************************************************/
/****************   D I R E C T O R Y    C O M M A N D   ****************/
/************************************************************************/
		      

/* WriteDate - Write OS/8 date to a file */
PRIVATE void WriteDate (FILE *f, UINT16 wCDT)
{
  static char *apszMonths[12] = {
    "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
    "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
  UINT d,m,y;
  if (wCDT == 0) {
    fprintf(f, " (none)  ");
  } else {
    OS8DateToDMY(wCDT, &d, &m, &y);
    fprintf(f, "%2d-%s-%2d", d, apszMonths[m-1], y);
  }
} /*WriteDate*/


/* DirOneFile */
/*   This procedure will print the directory information for a single	*/
/* file specification, which may have wild cards.  It can print in	*/
/* either full or brief mode, and will return the number of files found	*/
/* and the total number of blocks.					*/
PRIVATE BOOLEAN DirOneFile
 (FILE *hOut, char *pszMask, BOOLEAN fBrief, UINT *pnFiles, UINT *pnBlocks)
{
  OS8_FIND_DATA FindData;  STRING szName;
  UINT nBlock; int nLength;  UINT16 wCDT;  BOOLEAN fMatch;
  OS8FindFirst(&FindData);  fMatch = FALSE;

  while (OS8FindFile(&FindData, pszMask, szName, &nBlock, &nLength, &wCDT)) {
    fprintf(hOut, "%-9s", szName);
    if (fBrief) {
      fprintf(hOut, (*pnFiles % 5) == 0 ? "\n" : "    ");
    } else {
      fprintf(hOut, "%5d   ", nLength);
      WriteDate(hOut, wCDT);
      fprintf(hOut, "  (%04o)\n", nBlock);
    }
    ++*pnFiles;  *pnBlocks += nLength;  fMatch = TRUE;
  }

  if (fBrief && ((*pnFiles % 5) != 0)) fprintf(hOut, "\n");
  return fMatch;
} /*DirOneFile*/


/* DirFileList */
/*   This procedure will handle the directory of a list of files.  It	 */
/* splits the list up into individual files (which are handled by DirOne */
/* Spec) and maintains the total blocks and files found.		 */
PRIVATE void DirFileList (FILE *hOut, char *pszList, BOOLEAN fBrief)
{
  UINT nItem=0, nFiles=0, nBlocks=0;  STRING szItem;
  char chPartition = GetPartition();
  if (!ReadableDisk()) return;
  fprintf(hOut, "\nDirectory of %s", DiskName());
  if (chPartition != '\0')  fprintf(hOut, ", partition %c", chPartition);
  fprintf(hOut, "\n");
  while (StringItem(pszList, szItem, COMMA, nItem)) {
    if (!DirOneFile(hOut, szItem, fBrief, &nFiles, &nBlocks))
      Message('W', "no files found to match %s", szItem);
    ++nItem;
  }
  fprintf(hOut, "\nTotal of ");
  if (!fBrief) fprintf(hOut, "%d blocks in ", nBlocks);
  fprintf(hOut,"%d files.\n", nFiles);
} /*DirFileList*/


/* DoDirectory */
/*   This procedure will handle the directory command.  Mostly it just	*/
/* figures out the parameters and calls the appropriate routines to do	*/
/* the work.								*/
PRIVATE void DoDirectory (char *pszQualifiers, char *pszP1, char *pszP2)
{
  BOOLEAN fBrief;  UINT nItem = 1;  STRING szItem;  FILE *hOut;

  /* Parse the qualifiers for DIRECTORY */
  fBrief = FALSE;
  while (StringItem(pszQualifiers, szItem, SLASH, nItem++)) {
         if (STRNEQL(szItem, "BRIEF", 3))  fBrief = TRUE;
    else if (STRNEQL(szItem, "FULL",  3))  fBrief = FALSE;
    else {UnknownQualifier(szItem);  return;}
  }

  /*  If there's a P2, then it is the name of a host file to receive the */
  /* output.  If there's no P2 then send the listing to standard output. */
  /* If there's no P1, then use *.* as the default.			 */
  if ((strlen(pszP2) > 0)  &&  OneItem(pszP2)) {
    hOut = fopen(pszP2, "wt");
    if (hOut != NULL) {
      DirFileList(hOut, pszP1, fBrief);  fclose(hOut);
    } else
      Message('E', "unable to write file %s", pszP2);
  } else {
    if (strlen(pszP1) == 0)
      DirFileList(stderr, "*.*", fBrief);
    else
      DirFileList(stderr, pszP1, fBrief);
  }
} /*DoDirectory*/


/************************************************************************/
/****************        D U M P    C O M M A N D        ****************/
/************************************************************************/

			 
/* StrToInt */
/*   This procedure will convert a string to an integer.  If the first	 */
/* character is a '0', then the value is assumed to be in the octal	 */
/* radix.  If the first digit is non-zero then decimal is assumed.  If	 */
/* the string is not a valid number, then an error message is printed	 */
/* and FALSE returned.  Note that this procedure assumes that the string */
/* is not null!								 */
PRIVATE BOOLEAN StrToInt (char *pszString, UINT *pnValue)
{
 *pnValue = (UINT) strtoul(pszString, &pszString, 0);
 if (*pszString != EOS) {
   Message('E', "not a valid number - \"%s\"", pszString);
   return FALSE;
 } else
   return TRUE;
} /*StrToInt*/


/* DumpBlock - dump a single OS/8 logical block in octal, SIXBIT and ASCII */
PRIVATE void DumpBlock (FILE *fOut, UINT nLBN)
{
  UINT16 awData[OS8_BLOCK_SIZE];  UINT8 abData[OS8_BYTE_BLOCK_SIZE];
  UINT nOffset, i;  char c1, c2;
  char chPartition = GetPartition();
  
  ReadOS8Block(nLBN, awData);  OS8BlockToBytes(awData, abData);
  fprintf(fOut, "\nDump of OS/8 LBN %d (%04o)", nLBN, nLBN);
  if (chPartition != '\0')  fprintf(fOut, ", partition %c", chPartition);
  fprintf(fOut, "\n");

  for (nOffset = 0;  nOffset < OS8_BLOCK_SIZE;  nOffset += 8) {
    /* First dump the offset and 8 words in octal */
    fprintf(fOut, "%04o/", nOffset);
    for (i = 0;  i < 8;  ++i) fprintf(fOut, " %04o", awData[nOffset+i]);

    /* Now write the same 8 words as 16 SIXBIT characters */
    fprintf(fOut, "  ");
    for (i = 0;  i < 8;  ++i) {
      WordToChars(awData[nOffset+i], c1, c2);  fprintf(fOut, "%c%c", c1, c2);
    }

    /* And now the same 8 words as 12 ASCII characters */
    fprintf(fOut, "  ");
    for (i = 0;  i < 12;  ++i) {
      c1 = abData[3*(nOffset/2)+i] & 0x7f;
      fputc(((c1 >= ' ') && (c1 < 127)) ? c1 : '.', fOut);
    }

    /* On to the next 8 words */
    fprintf(fOut, "\n");
  };

  fprintf(fOut, "\n");
} /*DumpBlock*/


/* ValidDumpRange							 */
/*   This procedure will test the dump range to ensure that the starting */
/* LBN is less than the ending, and that both are within the size of the */
/* disk.								 */
PRIVATE BOOLEAN ValidDumpRange (UINT nStart, UINT nFinish)
{
  if (nStart > nFinish) {
    Message('E', "ending block must be greater than starting");
    return FALSE;
  }
  if (((DiskType() == RX01) && (nFinish > OS8_RX01_SIZE-1))
   || ((DiskType() == RX50) && (nFinish > OS8_RX50_SIZE-1))
   || ((DiskType() == VM01) && (nFinish > OS8_VM01_SIZE-1))
   || ((DiskType() == RK05) && (nFinish > OS8_RK05_SIZE-1))) {
    Message('E', "block number is too large for diskette");
    return FALSE;
  }
  return TRUE;
} /*ValidDumpRange*/


/* DoDump								 */
/*   This procedure will process the DUMP command.  This command has no	 */
/* modifiers, and will accept one or two arguments.  The first argument	 */
/* is the starting (or only) block to dump, and the second is the ending */
/* block.  If the second argument is omitted, only one block will be	 */
/* dumped.								 */
PRIVATE void DoDump (char *pszQualifiers, char *pszP1, char *pszP2)
{
  UINT nStart, nFinish;
  if (!NoQualifiers(pszQualifiers)) {
    /* error message already printed */
  } else if (strlen(pszP1) == 0) {
    Message('E', "specify block number to dump");
  } else if (!ReadableDisk()) {
    /* error message already printed */
  } else if (!StrToInt(pszP1, &nStart)) {
    /* error message already printed */
  } else if (strlen(pszP2) == 0) {
    if (ValidDumpRange(nStart, nStart)) DumpBlock(stderr, nStart);
  } else if (StrToInt(pszP2, &nFinish)) {
    if (ValidDumpRange(nStart, nFinish))
      for (; nStart <= nFinish;  ++nStart) DumpBlock(stderr, nStart);
  }
} /*DoDump*/


/************************************************************************/
/****************        T Y P E    C O M M A N D        ****************/
/************************************************************************/


/* TypeOneFile */
/*   This procedure will all files matched by a single OS/8 filespec.	*/
/* This is implicitly an ASCII type READ operation with the output to	*/
/* the terminal.							*/
PRIVATE BOOLEAN TypeOneFile (char *pszMask, BOOLEAN fConfirm)
{
  OS8_FIND_DATA FindData;  UINT nFiles;
  STRING pszName;  UINT nBlock; int nLength;  UINT16 wCDT;
  OS8FindFirst(&FindData);  nFiles = 0;
  while (OS8FindFile(&FindData, pszMask, pszName, &nBlock, &nLength, &wCDT)) {
    if (!fConfirm || YesOrNo("Type file %s", TRUE, pszName)) {
      fprintf(stderr, "\n[%s]\n\n", pszName);
      ExtractASCIIFile(nBlock, nLength, stderr);
      fprintf(stderr,"\n");
    }
    ++nFiles;
  }
  return nFiles > 0;
} /*TypeOneFile*/


/* DoType */
/*   This procedure will execute the TYPE command.  This command will	*/
/* type one or more OS/8 files on the terminal.  It has only one qual-	*/
/* ifier, and implicitly assumes an ASCII data transfer...		*/
PRIVATE void DoType (char *pszQualifiers, char *pszP1, char *pszP2)
{
  UINT nItem;  STRING szItem;  BOOLEAN fConfirm;

  /* Parse the qualifiers... */
  fConfirm = FALSE;  nItem = 1;
  while (StringItem(pszQualifiers, szItem, SLASH, nItem)) {
    if (BooleanQualifier (szItem, "CONFIRM", 4, &fConfirm)) /* */;
    else {UnknownQualifier(szItem);  return;}
    ++nItem;
  }

  /* The only parameter is a list of files to type */
  if (!CheckParameter(1, pszP1, pszP2)) return;
  if (!ReadableDisk()) return;

  /* Extract each file specification from the list and type it out */
  nItem = 0;
  while (StringItem(pszP1, szItem, COMMA, nItem)) {
    if (!TypeOneFile(szItem, fConfirm))
      Message('W', "no files found to match %s", szItem);
    ++nItem;
  }
} /*DoType*/


/************************************************************************/
/****************      D E L E T E    C O M M A N D      ****************/
/************************************************************************/


/* DeleteOneFile */
/*   This procedure will delete all files matched by a single (possibly	*/
/* wildcarded) OS/8 filespec.						*/
PRIVATE BOOLEAN DeleteOneFile (char *pszMask, BOOLEAN fConfirm)
{
  OS8_FIND_DATA FindData;
  UINT nBlock; int nLength;  UINT16 wCDT;  BOOLEAN fFound;  STRING szName;
  OS8FindFirst(&FindData);  fFound = FALSE;
  while (OS8FindFile(&FindData, pszMask, szName, &nBlock, &nLength, &wCDT)) {
    if (!fConfirm || YesOrNo("Delete file %s", FALSE, szName)) {
      OS8Delete(&FindData);
      Message('I', "deleted file %s", szName);
    }
    fFound = TRUE;
  }
  return fFound;
} /*DeleteOneFile*/


/* DoDelete								 */
/*  This procedure will execute the DELETE command. This command accepts */
/* a single argument containg one or more OS/8 file names.  Each file	 */
/* name may contain wild card characters.  The files named are deleted	 */
/* if they exist.							 */
PRIVATE void DoDelete (char *pszQualifiers, char *pszP1, char *pszP2)
{
  UINT nItem;  STRING szItem;  BOOLEAN fConfirm;

  /* Parse the qualifiers... */
  fConfirm = FALSE;  nItem = 1;
  while (StringItem(pszQualifiers, szItem, SLASH, nItem)) {
    if (BooleanQualifier (szItem, "CONFIRM", 4, &fConfirm)) /* */;
    else {UnknownQualifier(szItem);  return;}
    ++nItem;
  }

  /* The only parameter is a list of files to delete */
  if (!CheckParameter(1, pszP1, pszP2)) return;
  if (!WritableDisk()) return;

  /* Extract each file specification from the list and delete it */
  nItem = 0;
  while (StringItem(pszP1, szItem, COMMA, nItem)) {
    if (!DeleteOneFile(szItem, fConfirm))
      Message('W', "no files found to delete %s", szItem);
    ++nItem;
  }
} /*DoDelete*/


/************************************************************************/
/****************      R E N A M E    C O M M A N D      ****************/
/************************************************************************/


/* RenameNewFile */
/*   This procedure will compute the new name for a file being renamed,	*/
/* given the current name (which must not contain wild cards) and the	*/
/* new name specification as given by the user (which may contain wild	*/
/* cards).  All parameters are OS/8 file names.				*/
PRIVATE void RenameNewFile (char *pszOld, char *pszMask, char *pszNew)
{
  while (*pszMask != EOS) {
    if (*pszMask == '?') {
      if ((*pszOld != '.') && (*pszOld != EOS))  *pszNew++ = *pszOld++;
      ++pszMask;
    } else if (*pszMask == '*') {
      while ((*pszOld != '.') && (*pszOld != EOS)) *pszNew++ = *pszOld++;
      while ((*pszMask != '.') && (*pszMask != EOS)) ++pszMask;
    } else if (*pszMask == '.') {
      while ((*pszOld != '.') && (*pszOld != EOS)) ++pszOld;
      ++pszMask;  ++pszOld;
    } else {
      *pszNew++ = *pszMask++;
      if ((*pszOld != '.') && (*pszOld != EOS))  ++pszOld;
    }      
  }      
} /*RenameNewFile*/


/* RenameOneFile */
/*   This procedure will handle renaming one or more files, when given a */
/* single old filespec and a new filespec.  Either or both file file	 */
/* specifications may be wildcarded.  It will return FALSE if no files	 */
/* are found that match the old filespec.				 */
PRIVATE BOOLEAN RenameOneFile (char *pszOldMask, char *pszNewMask, BOOLEAN fConfirm)
{
  OS8_FIND_DATA FindData;  STRING szOldName, szNewName;
  UINT nBlock; int nLength;  UINT16 wCDT;  BOOLEAN fFound;
  OS8FindFirst(&FindData);  fFound = FALSE;
  while (OS8FindFile(&FindData, pszOldMask, szOldName, &nBlock, &nLength, &wCDT)) {
    RenameNewFile(szOldName, pszNewMask, szNewName);
    if (!fConfirm || YesOrNo("Rename %s to %s", TRUE, szOldName, szNewName)) {
      /*   Do another directory search to ensure that the new	*/
      /* name is unique ! 					*/
      if (OS8Exists(szNewName)) {
	Message('W', "new name already exists %s", szNewName);
      } else {
	OS8Rename(&FindData, szNewName);
	Message('I', "Renamed %s to %s", szOldName, szNewName);
      }
    }
    fFound = TRUE;
  }
  return fFound;
} /*RenameOneFile*/


/* DoRename */
/*    This procedure will handle all the work for the RENAME command.	*/
/* There is only one qualifier, /[NO]CONFIRM, and two parameters are	*/
/* always required.  If the first parameter is a list, then the second	*/
/* must have exactly the same number of items.				*/
PRIVATE void DoRename (char *pszQualifiers, char *pszP1, char *pszP2)
{
  UINT nItem;  STRING szOldName, szNewName, szItem;  BOOLEAN fConfirm;

  /* Parse the qualifiers for RENAME */  
  fConfirm = FALSE;  nItem = 1;
  while (StringItem(pszQualifiers, szItem, SLASH, nItem)) {
        if (BooleanQualifier (szItem, "CONFIRM", 4, &fConfirm)) /* */ ;
    else {UnknownQualifier(szItem);  return;}
    ++nItem;
  }
 
  /*   Rename requires two parameters (old name and new name), and if */
  /* a list of values is used then they must match one for one.	      */
  if (!CheckParameter(2, pszP1, pszP2)) return;
  if (CountItems(pszP1) != CountItems(pszP2)) {
    Message('E',"both parameters must have the same number of items");
    return;
  }
  if (!WritableDisk()) return;

  /* Rename each old file to the new name given... */
  while (StringItem(pszP1, szOldName, COMMA, nItem)) {
    StringItem(pszP2, szNewName, COMMA, nItem);
    if (!RenameOneFile(szOldName, szNewName, fConfirm))
      Message('W', "no files found to rename %s", szOldName);
    ++nItem;
  }
} /*DoRename*/


/************************************************************************/
/****************        R E A D    C O M M A N D        ****************/
/************************************************************************/


/* ParseReadWrite */
/*   This procedure will parse the qualifiers and paramters for the READ */
/* and WRITE commands.  There are currently three local qualifiers,	 */
/* /ASCII, /IMAGE and /SYSTEM and one global qualifier /CONFIRM.  If	 */
/* there are any problems with the qualifiers, it will return FALSE.	 */
/* Either one or two parameters may be present, and P2 (if given) must	 */
/* conform to certain rules.						 */
PRIVATE BOOLEAN ParseReadWrite (char *pszQualifiers, char *pszP1, char *pszP2,
  BOOLEAN *pfASCII, BOOLEAN *pfImage, BOOLEAN *pfSystem, BOOLEAN *pfConfirm)
{
  STRING szItem;  UINT nItem=1, nP1, nP2;

  /* Establish the default values */
  *pfASCII = *pfImage = *pfSystem = *pfConfirm = FALSE;

  /* Parse the qualifiers and set the flags accordingly */
  while (StringItem(pszQualifiers, szItem, SLASH, nItem)) {
         if (BooleanQualifier (szItem, "CONFIRM", 4, pfConfirm)) /* */;
    else if (STRNEQL(szItem, "SYSTEM", 3))  *pfSystem = TRUE;
    else if (STRNEQL(szItem, "IMAGE",  2))  *pfImage  = TRUE;
    else if (STRNEQL(szItem, "ASCII",  2))  *pfASCII  = TRUE;
    else {UnknownQualifier(szItem);  return FALSE;}
    ++nItem;
  }

  /*   Don't allow /IMAGE and /ASCII together, and disallow /SYSTEM and	*/
  /* /ASCII (but allow /SYSTEM/IMAGE).  If neither /ASCII nor /IMAGE was	*/
  /* given, then use /IMAGE if /SYSTEM was present and /ASCII otherwise.	*/
  if (*pfSystem) {
    if (*pfASCII) {
      Message('W', "image mode required with /SYSTEM");  return FALSE;
    } else
      *pfImage = TRUE;
  } else {
    if (*pfASCII && *pfImage) {
      Message('E', "/ASCII incompatible with /IMAGE");  return FALSE;
    } else if (!*pfImage) {
      *pfASCII = TRUE;
    }
  }

  /*   Now check the parameters.  At least a P1 is always required, and	 */
  /* it may or may not be a list. P2 is not required, but if it is given */
  /* then it must conform to one off two possibilities.  If it is not a	 */
  /* list, then that's fine.  If it is a list, then P1 must also be a	 */
  /* list and both lists must have the same number of items.  Any dif-	 */
  /* ference in the number of items causes an error message.  Finally,	 */
  /* if /SYSTEM is used only P1 may be present, and it cannot be a list. */
  if (strlen(pszP1) == 0) {
      Message('E', "at least one file name is required");  return FALSE;
  }
  if (*pfSystem){
    if (!CheckParameter(1, pszP1, pszP2)) return FALSE;
    if (!OneItem(pszP1)) return FALSE;
  } else {
      nP1 = CountItems(pszP1);  nP2 = CountItems(pszP2);
      if ((nP2 > 1) && (nP1 != nP2)) {
	Message('E', "both lists must have the same number of items");
	return FALSE;
      }
  }

  return TRUE;
} /*ParseReadWrite*/


/* NativeOutputFileName */
/*   This procedure will compute the appropriate output file name when	 */
/* given the OS/8 input file name and the output name string given by 	 */
/* the user.  If the user's string is null, then the OS/8 name is used	 */
/* just as is.  If the user's string is not null, then it is parsed into */
/* a path, a file name, an extension and a version.  The path is used as */
/* is, but if either the name or extension is null or "*" it will be	 */
/* replaced by the corresponding part of the OS/8 name.  The result is	 */
/* returned in the result string.  Note that the OS/8 name should not	 */
/* contain any wild cards by this time.					 */
PRIVATE void HostOutputFileName (char *pszInFile, char *pszOutFile, char *pszResult)
{
  STRING szHostPath, szHostName, szHostType, szOS8Name, szOS8Type;
  if (strlen(pszOutFile) == 0) {
    strcpy(pszResult, pszInFile);
  } else {
    ParseHostFileName(pszOutFile, szHostPath, szHostName, szHostType);
    ParseOS8FileName(pszInFile, szOS8Name, szOS8Type);
    if ((strlen(szHostName) == 0) || STREQL(szHostName, "*"))
      strcpy(szHostName, szOS8Name);
    if ((strlen(szHostType) == 0) || STREQL(szHostType, ".*"))
      strcpy(szHostType, szOS8Type);
    strcpy(pszResult, szHostPath);
    strcat(pszResult, szHostName);  strcat(pszResult, szHostType);
  }    
} /*HostOutputFileName*/


/* ReadASCII - read a single ASCII file to the external file given */
PRIVATE BOOLEAN ReadASCII (UINT nBlock, int nLength, char *pszFile)
{
  FILE *hOutput;
  if ((hOutput = fopen(pszFile, "wt")) == NULL) {
    Message('E', "unable to write ASCII file %s", pszFile);
    return FALSE;
  }
  ExtractASCIIFile(nBlock, nLength, hOutput);
  fclose(hOutput);
  return TRUE;
} /*ReadASCII*/


/* ReadImage - just like ReadASCII, but for image files */
PRIVATE BOOLEAN ReadImage (UINT nBlock, int nLength, char *pszFile)
{
  int hOutput;
  hOutput = open(pszFile,
    O_RDWR | O_BINARY | O_CREAT | O_EXCL, S_IREAD | S_IWRITE);
  if (hOutput == -1) {
    Message('E', "unable to write image file %s", pszFile);
    return FALSE;
  }
  ExtractImageFile(nBlock, nLength, hOutput);
  close(hOutput);
  return TRUE;
} /*ReadImage*/


/* ReadFile */
/*   This procedure will handle the reading of a single, but possibly	 */
/* wildcarded, file specification.  It is also given the output name and */
/* the transfer mode (ASCII or not ASCII (i.e. IMAGE)).			 */
PRIVATE BOOLEAN ReadFile
  (char *pszOS8Mask, char *pszHostMask, BOOLEAN fASCII, BOOLEAN fConfirm)
{
  OS8_FIND_DATA FindData;  BOOLEAN fMatch = FALSE;
  STRING szHostName, szOS8Name;  UINT nBlock; int nLength;  UINT16 wCDT;

  OS8FindFirst(&FindData);
  while (OS8FindFile(&FindData, pszOS8Mask, szOS8Name, &nBlock, &nLength, &wCDT)) {
    HostOutputFileName(szOS8Name, pszHostMask, szHostName);
    if (!fConfirm || YesOrNo("Read %s into %s", TRUE, szOS8Name, szHostName)) {
      if (fASCII) {
	if (ReadASCII(nBlock, nLength, szHostName))
	  Message('I', "read %s into ASCII file %s", szOS8Name, szHostName);
      } else {
	if (ReadImage(nBlock, nLength, szHostName))
	  Message('I', "read %s into image file %s", szOS8Name, szHostName);
      }
    }
    fMatch = TRUE;
  }

  return fMatch;
} /*ReadFile*/


/* ReadSystem - read the system head into the external file named */
PRIVATE void ReadSystem (char *pszHostName)
{
  if (SystemDisk()) {
    if (ReadImage(OS8_HOME_BLOCK+OS8_DIRECTORY_SIZE, OS8_SYSTEM_SIZE, pszHostName))
      Message('I', "OS/8 system head copied to %s", pszHostName);
  } else
    Message('E', "not a system disk");
} /*ReadSystem*/


/*   This procedure is the top level for handling the READ command.  The */
/* argument handling for P2 (the output or host file name) is somewhat	 */
/* complicated.  If there is no P2 then we will pass a null string to	 */
/* ReadFile for the output specification.  If there is a P2 and it has	 */
/* only one item, then this is used as the output specification for ALL	 */
/* input files.  If P2 is a list of files, then they are paired one for	 */
/* one with the input files.  In this case an error occurs if there	 */
/* aren't enough to go around.						 */
PRIVATE void DoRead (char *pszQualifiers, char *pszP1, char *pszP2)
{
  BOOLEAN fASCII, fImage, fSystem, fConfirm;
  STRING szHostName, szOS8Name;  UINT nItem=0;

  if (!ParseReadWrite(pszQualifiers, pszP1, pszP2,
         &fASCII, &fImage, &fSystem, &fConfirm)) return;
  if (!ReadableDisk()) return;

  if (fSystem) {
    ReadSystem(pszP1);
  } else {
    while (StringItem(pszP1, szOS8Name, COMMA, nItem)) {
      if (!StringItem(pszP2, szHostName, COMMA, nItem)) strcpy(szHostName, pszP2);
      if (!ReadFile(szOS8Name, szHostName, fASCII, fConfirm))
        Message('W', "no files found to match %s", szOS8Name);
      ++nItem;
    }
  }
} /*DoRead*/


/************************************************************************/
/****************       W R I T E    C O M M A N D       ****************/
/************************************************************************/


/* WriteASCII - Write a single ASCII file from the external file given */
PRIVATE BOOLEAN WriteASCII (char *pszOS8Name, UINT nBlock, int *pnLength, char *pszHostName)
{
  FILE *fInput;  BOOLEAN fSuccess;
  if ((fInput = fopen(pszHostName, "rt")) == NULL) {
    Message('E', "unable to read ASCII file %s", pszHostName);
    return FALSE;
  }
  if (!(fSuccess = InsertASCIIFile(nBlock, pnLength, fInput)))
    Message('W', "not enough room for %s", pszOS8Name);
  fclose(fInput);
  return fSuccess;
} /*WriteASCII*/


/* WriteImage - just like WriteASCII, but for image files */
PRIVATE BOOLEAN WriteImage (char *pszOS8Name, UINT nBlock, int *pnLength, char *pszHostName)
{
  int hInput;  BOOLEAN fSuccess;
  hInput = open(pszHostName, O_RDONLY | O_BINARY, 0);
  if (hInput == -1) {
    Message('E', "unable to read image file %s", pszHostName);
    return FALSE;
  }
  if (!(fSuccess = InsertImageFile(nBlock, pnLength, hInput)))
    Message('W', "not enough room for %s", pszOS8Name);
  close(hInput);
  return fSuccess;
} /*WriteImage*/


/* OS8OutputFileName */
/*   This procedure will compute the appropriate output (OS/8) file name */
/* to use for a given host input file.  If the output file name given by */
/* the user doesn't contain wild cards, then there is no problem. If the */
/* name has wildcards, then this procedure will try to replace them by	 */
/* the corresponding parts of the input file name. Any illegal (i.e. non */
/* alphanumeric) characters are replaced by an X.			 */
PRIVATE void OS8OutputFileName (char *pszInFile, char *pszOutFile, char *pszResult)
{
  STRING szHostPath, szHostName, szHostType, szOS8Name, szOS8Type;

  /* Separate the two names into their component parts */
  ParseHostFileName(pszInFile, szHostPath, szHostName, szHostType);
  ParseOS8FileName(pszOutFile, szOS8Name, szOS8Type);
  
  /* Default the name and type of the output using the input */
  if ((strlen(szOS8Name) == 0) || STREQL(szOS8Name, "*"))
    strncpy(szOS8Name, szHostName, 6);
  if ((strlen(szOS8Type) == 0) || STREQL(szOS8Type, ".*"))
    strncpy(szOS8Type, szHostType, 3);
  
  /* Limit the result to six letters + two letters (including the dot) */
  szOS8Name[6] = szOS8Type[3] = EOS;
  strcpy(pszResult, szOS8Name);  strcat(pszResult, szOS8Type);

  /* Remove any illegal characters */
  for (;  *pszResult != EOS;  ++pszResult) {
         if (*pszResult == '.')    /* leave it alone! */;
    else if (!isalnum(*pszResult)) *pszResult = 'X';
    else                           *pszResult = CAP(*pszResult);
  }
} /*OS8OutputFileName*/


/* PurgeExistingFile */
/*   This procedure is called by the write command to see if a file by	 */
/* the same name already exists, and to determine what to do with it. If */
/* the /CONFIRM option is selected, then the user is asked if he wants	 */
/* to delete the old version.  If /NOCONFIRM is used, then it is simply	 */
/* deleted.  THis procedure will return FALSE if the user decides not to */
/* have the old file written.						 */
PRIVATE BOOLEAN PurgeExistingFile (char *pszMask, BOOLEAN fConfirm)
{
  OS8_FIND_DATA FindData;
  UINT nBlock; int nLength;  UINT16 wCDT;  STRING szName;
  OS8FindFirst(&FindData);
  if (!OS8FindFile(&FindData, pszMask, szName, &nBlock, &nLength, &wCDT)) return TRUE;
  if (fConfirm) {
    if (!YesOrNo("Purge existing file %s", FALSE, szName)) return FALSE;
  } else
    Message('I', "purging existing version of %s", szName);
  OS8Delete(&FindData);
  return TRUE;
} /*PurgeExistingFile*/


/* WriteFile */
/*   This procedure will handle the writing of a single, but possibly	 */
/* wildcarded, file specification.  It is also given the output name and */
/* the transfer mode (ASCII or not ASCII (i.e. IMAGE)).			 */
PRIVATE BOOLEAN WriteFile
  (char *pszOS8Mask, char *pszHostMask, BOOLEAN fASCII, BOOLEAN fConfirm)
{
  STRING szHostName, szOS8Name;  UINT nBlock; int nLength;  UINT16 wCDT;
  OS8_FIND_DATA FindData;  BOOLEAN fSuccess, fFirst=TRUE;

  while (FindHostFile(fFirst, pszHostMask, szHostName)) {

    /*   Compute the corresponding OS/8 name, and confirm if necessary.  If */
    /* this file already exists on the diskette, confirm deleting it.       */
    OS8OutputFileName(szHostName, pszOS8Mask, szOS8Name);
    if (fConfirm && !YesOrNo("Write %s to %w", TRUE, szHostName, szOS8Name)) continue;
    if (!PurgeExistingFile(szOS8Name, fConfirm)) continue;

    /* Enter this file into the directory.  If the disk is full, give up. */    
    GetOS8CurrentDate(&wCDT);
    OS8Enter(&FindData, szOS8Name, wCDT, &nBlock, &nLength);
    if (nLength == 0) {
      Message('W',"no room (diskette full) for %s", szOS8Name);  continue;
    }

    /* Finally, we're ready to write the file to the diskette */
    if (fASCII)
      fSuccess = WriteASCII (szOS8Name, nBlock, &nLength, szHostName);
    else
      fSuccess = WriteImage (szOS8Name, nBlock, &nLength, szHostName);
    if (fSuccess) {
      OS8Close(&FindData, nLength);
      Message('I', "wrote %s to %s", szHostName, szOS8Name);
    } else
      OS8Close(&FindData, 0);

    fFirst = FALSE;
  }

  return !fFirst;
} /*WriteFile*/


/* WriteSystem - write the system head from the external file named */
PRIVATE void WriteSystem (char *pszHostName)
{
  int nLength = OS8_SYSTEM_SIZE;
  if (!SystemDisk())  {Message('E', "not a system disk");  return;}
  if (WriteImage("SYSTEM", OS8_HOME_BLOCK+OS8_DIRECTORY_SIZE, &nLength, pszHostName)) {
    if (nLength != OS8_SYSTEM_SIZE)
      Message('E', "OS/8 system head length wrong %s", pszHostName);
    else
      Message('I', "OS/8 system head written from %s", pszHostName);
  }
} /*WriteSystem*/


/* DoWrite - top level procedure for the Write command */
PRIVATE void DoWrite (char *pszQualifiers, char *pszP1, char *pszP2)
{
  BOOLEAN fASCII, fImage, fSystem, fConfirm;
  STRING szHostName, szOS8Name;  UINT nItem=0;

  if (!ParseReadWrite(pszQualifiers, pszP1, pszP2, 
         &fASCII, &fImage, &fSystem, &fConfirm)) return;
  if (!WritableDisk()) return;

  if (fSystem) {
    WriteSystem(pszP1);
  } else {
    while (StringItem(pszP1, szHostName, COMMA, nItem)) {
      if (!StringItem(pszP2, szOS8Name, COMMA, nItem)) strcpy(szOS8Name, "*.*");
      if (!WriteFile(szOS8Name, szHostName, fASCII, fConfirm))
        Message('W', "no files found to match %s", szHostName);
      ++nItem;
    }
  }
} /*DoWrite*/


/************************************************************************/
/****************        M A I N    P R O G R A M        ****************/
/************************************************************************/


/* DoExit - execute the EXIT command */
PRIVATE void DoExit (char *pszQualifiers, char *pszP1, char *pszP2)
{
  if (NoQualifiers(pszQualifiers)  &&  CheckParameter(0, pszP1, pszP2))
   fFinished = TRUE;
} /*DoExit*/


/* DoCommand								 */
/*   This procedure will parse and (if it's legal) execute the command	 */
/* in the command buffer.  If there is some problem with the command	 */
/* then an appropriate message will be printed and nothing else happens. */
PRIVATE void DoCommand (char *pszCommand)
{
  STRING szVerb, szQualifiers, szP1, szP2;
  if (strlen(pszCommand) > 0) {
    if (ParseCommand(pszCommand, szVerb, szQualifiers, szP1, szP2)) {
      if (STRNEQL(szVerb, "EXIT", 2))
        DoExit(szQualifiers, szP1, szP2);
      else if (STRNEQL(szVerb, "MOUNT", 3))
        DoMount(szQualifiers, szP1, szP2);
      else if (STRNEQL(szVerb, "DISMOUNT", 4))
        DoDismount(szQualifiers, szP1, szP2);
      else if (STRNEQL(szVerb, "PARTITION", 4))
        DoPartition(szQualifiers, szP1, szP2);
      else if (STRNEQL(szVerb, "DUMP", 2))
        DoDump(szQualifiers, szP1, szP2);
      else if (STRNEQL(szVerb, "DIRECTORY", 3))
        DoDirectory(szQualifiers, szP1, szP2);
      else if (STRNEQL(szVerb, "TYPE", 2))
        DoType(szQualifiers, szP1, szP2);
      else if (STRNEQL(szVerb, "READ", 3))
        DoRead(szQualifiers, szP1, szP2);
      else if (STRNEQL(szVerb, "RENAME", 3))
        DoRename(szQualifiers, szP1, szP2);
      else if (STRNEQL(szVerb, "DELETE", 3))
        DoDelete(szQualifiers, szP1, szP2);
      else if (STRNEQL(szVerb, "WRITE", 3))
        DoWrite(szQualifiers, szP1, szP2);
      else
        Message('E', "unknown command %s", szVerb);
    }
  }
} /*DoCommand*/


/* Main - the actual main program */
PUBLIC main (int argc, char *argv[])
{
  STRING szCommand;
  SetProgram("FLX8");
  while (!fFinished)
    if (ReadCommand(szCommand))
      DoCommand(szCommand);
    else
     fFinished = TRUE;
  if (DiskMounted()) DismountDisk();
  return EXIT_SUCCESS;
}
