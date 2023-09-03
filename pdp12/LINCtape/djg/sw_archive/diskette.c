/*++									*/
/* diskette.c								*/
/*									*/
/* DESCRIPTION:								*/
/*   This module implements the low level access routines for physical	*/
/* diskette drives and image files, and the end result of all that work	*/
/* is really just two routines, ReadOS8Block() and WriteOS8Block().	*/
/* Implementing these, especially for access to physical diskettes,	*/
/* requires all kinds of obscure knowledge, like the sector inter-	*/
/* leaving scheme used on the RX50, or the twelve bit words to eight 	*/
/* bit bytes conversion algorithm on the RX01.				*/
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
/*--									*/

/* Include files... */
#include <stdio.h>	/* NULL, printf(), scanf(), et al		*/
#include <string.h>	/* strlen(), strcpy(), strcat(), etc...		*/
#include <stdlib.h>	/* malloc(), exit(), etc...			*/
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
#include <sys/types.h>	/*                            			*/
#include <sys/stat.h>	/* S_IWRITE, S_IREAD, et al...			*/
#include <unistd.h>
#define  O_BINARY    0	/* VMS doesn't have this, so we ignore it	*/
#endif
#endif
#if 0
#include <assert.h>	/* assert() macro (what else??)			*/
#endif
#include "types.h"	/* universal data type declarations		*/
#include "diskette.h"	/* function prototypes for this module		*/

#include "os8.h"
#include "os8_html.h"

#define assert(expr) ((void) ((expr) ? 0 : (OS8AssertFail (__STRING(expr), __FILE__, __LINE__, __PRETTY_FUNCTION__), 0)))



PRIVATE BOOLEAN  fReadOnly;	/* TRUE if the current diskette is R/O	*/
PRIVATE BOOLEAN  fVirtualDisk;	/* TRUE if a virtual diskette is mounted*/
PRIVATE int      hVirtualDisk;	/* Current virtual diskette file handle	*/
PRIVATE STRING   szDiskName;	/* Name of virtual or physical device	*/
PRIVATE DISKTYPE nDiskType	/* Type of the diskette mounted		*/
			  = NODISK;
PRIVATE UINT     nPartition	/* Current partition in use (RK05 only)	*/
			  = 0;

/* CloseDisk								*/
/*   This procedure will close the current diskette file.  It works for	*/
/* both physical and virtual disks.					*/
PUBLIC void CloseDisk (void)
{
  /* Close the device or virtual disk file... */
  if (fVirtualDisk) {
    close(hVirtualDisk);
  } else {
    assert(FALSE);  /*physical disk operations not implemented*/
  }

  /* And reset all the internal variables... */  
  fReadOnly=fVirtualDisk=FALSE;  szDiskName[0]='\0';  nDiskType=NODISK;
} /*CloseDisk*/


/* OpenDisk								 */
/*   This procedure will open either a virtual disk file or a physical	 */
/* diskette device. It gets all its inputs through the global parameters */
/* describing the current diskette.  If it is unable to open the device	 */
/* or file, it will return FALSE.					 */
PUBLIC BOOLEAN OpenDisk
  (BOOLEAN fVirtual, BOOLEAN fRead, DISKTYPE nType, char *pszName, BOOLEAN byteMode)
{
  /* If there's currently a disk open, then close it first... */
  if (nDiskType != NODISK) CloseDisk();
  
  /* Initialize all the disk parameters... */
  strcpy(szDiskName, pszName);  nDiskType = nType;
  fReadOnly = fRead;  fVirtualDisk = fVirtual;  nPartition = 0;
  
  /* And return TRUE if we can actually open the disk... */
  if (fVirtualDisk)  {
    hVirtualDisk = open(szDiskName, O_RDONLY | O_BINARY, 0);
    if (nDiskType == AUTO_OS8 && hVirtualDisk != -1) {
       struct stat statbuf;
       int size;

       fstat(hVirtualDisk, &statbuf);
       size = statbuf.st_size;
       if (size == 256256) {
          if (strstr(szDiskName, "byte") != NULL || byteMode)
             nDiskType = RX01_BYTE;
          else
             nDiskType = RX01;
       } else
       if (size == 512512) {
          nDiskType = RX02;
       } else
       // 1600 block tape
       if (size == 412800) {
          nDiskType = DECTAPE;
       } else
       // 1500 block tape
       if (size == 387000) {
          nDiskType = DECTAPE;
       } else
       if (size == 380292) {
          nDiskType = DECTAPE;
       } else
       if (size == 3325952) {
          nDiskType = RK05;
       } else
       if ((size - LINC_HEADER_SIZE) % 129 == 0) {
          nDiskType = LINC_DECTAPE;
       } else
       if ((size - LINC_HEADER_SIZE) % 128 == 0) {
          nDiskType = LINC_DECTAPE;
       } else {
          html_error(0, "Unable to decode disk size %d\n", size);
          //assert(FALSE);
       }
    }
    return (hVirtualDisk != -1);
  } else {
    assert(FALSE);  /*physical disk operations not implemented*/
    hVirtualDisk = -1;
    return FALSE;
  }
} /*OpenDisk*/


/* DiskMounted - return TRUE if any type of diskette is mounted */
PUBLIC BOOLEAN DiskMounted (void)  {return nDiskType != NODISK;}

/* DiskType - return the type (e.g. RX01, RX50) of the current diskette */
PUBLIC DISKTYPE DiskType (void)  {return nDiskType;}

/* DiskName - return the name, in ASCIZ, of the current drive or image */
PUBLIC char *DiskName (void)  {return szDiskName;}

/* ReadOnly - return TRUE if the current diskette is read only */
PUBLIC BOOLEAN ReadOnly (void)  {return fReadOnly;}


/* SetPartition */
/*   The maximum possible size for an OS/8 mass storage device is 4095	*/
/* blocks, but unfortunately the RK05 holds 6,496 blocks or about 50%	*/
/* more than the limit.  The OS/8 designers handled this by making the	*/
/* RK8E handler split the physical drive into two logical partitions,	*/
/* called RKA0 and RKB0 (or RKA1/RKB1 for unit 1, RKA2/RKB2, etc). When	*/
/* the RL01 came along it had more than twice the OS/8 limit and things	*/
/* got even worse, so it has three partitions - RL0A, RL0B and RL0C are	*/
/* different partitions of physical unit 0.  The RL02 has no less than	*/
/* five partitions - A, B, C, D, and E.					*/
/*									*/
/*   This routine sets the current partition in use.  If the partition	*/
/* is illegal, or the current disk type doesn't support partitions, 	*/
/* then FALSE is returned and nothing changes.				*/
BOOLEAN SetPartition (char chPart)
{
  /* Currently, the RK05 is the only thing we support with partitions. */
  if (DiskType() != RK05) return FALSE;
  
  /* For the RK05, the partition has to be either A or B... */
       if ((chPart=='A') || (chPart=='a'))  {nPartition = 0;  return TRUE;}
  else if ((chPart=='B') || (chPart=='b'))  {nPartition = 1;  return TRUE;}
  else return FALSE;
} /*SetPartition*/


/* GetPartition - return the current partition in use, or zero if none. */
char GetPartition (void)
{
  if (DiskType() != RK05) return (char) 0;
  return (char) (nPartition+'A');
} /*GetPartition*/


/* RX01VBN - compute virtual block number for RX01 */
PRIVATE UINT RX01VBN (UINT nTrack, UINT nSector)
{
  assert((nTrack > 0) && (nTrack <= 76) && (nSector > 0) && (nSector <= 26));
  if (fVirtualDisk)
    return (nTrack/*-1*/)*26 + (nSector-1);
  else
    assert(FALSE);  /*physical disk operations not implemented*/
  return 0; // Get rid of warning
    /*RX01VBN := nTrack*65536 + nSector*/
} /*RX01VBN*/


/* ReadRX01 - read a sector from a RX01 (virtual or physical) */
PRIVATE void ReadRX01 (UINT nTrack, UINT nSector, UINT8 *pbData)
{
  long lOffset;
  if (fVirtualDisk) {
    lOffset = (long) RX01VBN(nTrack, nSector) * (long) RX01_SECTOR_SIZE;
    assert(lseek(hVirtualDisk, lOffset, SEEK_SET) == lOffset);
    assert(read(hVirtualDisk, pbData, RX01_SECTOR_SIZE) == RX01_SECTOR_SIZE);
  } else {
    assert(FALSE);  /*physical disk operations not implemented*/
#ifdef OBSOLETE
    var vbn, status: INTEGER;  iosb: $IOSB;
    status := $QIOW(,DiskChannel,IO$_READPBLK,iosb,,,data,RX01SECTSIZE,vbn,,);
    if (not odd(status)) then $SIGNAL(status);
    if (not odd(iosb.status)) then $SIGNAL(iosb.status);
#endif
  }
} /*ReadRX01*/

/* RX02VBN - compute virtual block number for RX02 */
PRIVATE UINT RX02VBN (UINT nTrack, UINT nSector)
{
  assert((nTrack > 0) && (nTrack <= 76) && (nSector > 0) && (nSector <= 26));
  if (fVirtualDisk)
    return (nTrack/*-1*/)*26 + (nSector-1);
  else
    assert(FALSE);  /*physical disk operations not implemented*/
  return 0; // Get rid of warning
    /*RX02VBN := nTrack*65536 + nSector*/
} /*RX02VBN*/


/* ReadRX02 - read a sector from a RX02 (virtual or physical) */
PRIVATE void ReadRX02 (UINT nTrack, UINT nSector, UINT8 *pbData)
{
  long lOffset;
  if (fVirtualDisk) {
    lOffset = (long) RX02VBN(nTrack, nSector) * (long) RX02_SECTOR_SIZE;
    assert(lseek(hVirtualDisk, lOffset, SEEK_SET) == lOffset);
    assert(read(hVirtualDisk, pbData, RX02_SECTOR_SIZE) == RX02_SECTOR_SIZE);
  } else {
    assert(FALSE);  /*physical disk operations not implemented*/
  }
} /*ReadRX02*/

/* RX50VBN - compute virtual block number for RX50  */
PRIVATE UINT RX50VBN (UINT nTrack, UINT nSector)
{
  /* Are the RX50 VBNs from 0..n-1 or 1..n ??? */
  UINT nVBN, nSkew;
  assert((nTrack > 0) && (nTrack <= 80) && (nSector > 0) && (nSector <= 10));
  nSkew = 5-((nTrack-1) % 5);
  if (nSkew == 5) nSkew = 0;
  nVBN = (nTrack/*-1*/)*10 + (((nSector-1)/2)+nSkew) % 5;
  if ((nSector & 1) == 0) nVBN += 5;
  return nVBN;
} /*RX50VBN*/


/* ReadRX50 - read a sector from a RX50 (virtual or physical) */
PRIVATE void ReadRX50 (UINT nTrack, UINT nSector, UINT8 *pbData)
{
  long lOffset;
  if (fVirtualDisk) {
    lOffset = (long) RX50VBN(nTrack, nSector) * (long) RX50_SECTOR_SIZE;
    assert(lseek(hVirtualDisk, lOffset, SEEK_SET) == lOffset);
    assert(read(hVirtualDisk, pbData, RX50_SECTOR_SIZE) == RX50_SECTOR_SIZE);
  } else {
    assert(FALSE);  /*physical disk operations not implemented*/
#ifdef OBSOLETE
    var vbn, status: INTEGER;  iosb: $IOSB;
    status := $QIOW(,DiskChannel,IO$_READLBLK,iosb,,,data,RX50SECTSIZE,vbn,,);
    if (not odd(status)) then $SIGNAL(status);
    if (not odd(iosb.status)) then $SIGNAL(iosb.status);
#endif
  }
} /*ReadRX50*/

/* ReadVM01 - read a bank (not a sector!) from a virtual VM01 image */
PRIVATE void ReadVM01 (UINT nBank, UINT8 *pbData)
{
  if (fVirtualDisk) {
    long lOffset = (long) nBank * (long) VM01_BANK_SIZE;
    assert(lseek(hVirtualDisk, lOffset, SEEK_SET) == lOffset);
    assert(read(hVirtualDisk, pbData, VM01_BANK_SIZE) == VM01_BANK_SIZE);
  } else {
    assert(FALSE);  /*physical disk operations not implemented*/
  }
} /*ReadVM01*/


/* RK05VBN - compute virtual block number for RK05s */
PRIVATE UINT RK05VBN (UINT nCylinder, UINT nHead, UINT nSector)
{
  return (((nCylinder * 2) + nHead) * 16) + nSector;
}

#define LINK_OS8_SECTOR_SIZE 129*2)
/* ReadLINK_OS8_OS8Block - read one OS/8 block from the current partition */
PRIVATE void ReadLINK_OS8_OS8Block (UINT nBlock, UINT16 *pwData)
{
  if (fVirtualDisk) {
    long lOffset;
    short first, first_rev, blksize;

    assert(lseek(hVirtualDisk, -LINC_HEADER_SIZE, SEEK_END) != -1);
    assert(read(hVirtualDisk, &blksize, 2) == 2);
    assert(read(hVirtualDisk, &first, 2) == 2);
    assert(read(hVirtualDisk, &first_rev, 2) == 2);
//    first = -8;
//printf("first %d blksize %d\n",first,blksize);
    lOffset = (long) (long) -first * blksize * 2 + nBlock * (long) blksize*4;
//printf("Offset %d\n",lOffset);
    assert(lseek(hVirtualDisk, lOffset, SEEK_SET) == lOffset);
    assert(read(hVirtualDisk, pwData, RK05_SECTOR_SIZE/2) == RK05_SECTOR_SIZE/2);
       // Discard extra words at end of block if present
    assert(read(hVirtualDisk, &pwData[RK05_SECTOR_SIZE/4], (blksize % 128)*2) == (blksize % 128)*2);
    assert(read(hVirtualDisk, &pwData[RK05_SECTOR_SIZE/4], RK05_SECTOR_SIZE/2) == RK05_SECTOR_SIZE/2);
  } else {
    assert(FALSE);  /*physical disk operations not implemented*/
  }
} /*ReadLINK_OS8_OS8Block*/


/* ReadRK05 */
/*   This routine reads one logical sector of 256 words from the RK05 	*/
/* image.  By this point the partitioning has already been taken into	*/
/* account and the cylinder represents the actual disk address.  Note	*/
/* that this routine reads twelve bit words directly from the image 	*/
/* file, so there's no need for a RK05BytesToPDP8Words() step...	*/
PRIVATE void ReadRK05 (UINT nCylinder, UINT nHead, UINT nSector, UINT16 *pwData)
{
  if (fVirtualDisk) {
    long lOffset = (long) RK05VBN(nCylinder, nHead, nSector) * (long) RK05_SECTOR_SIZE;
    assert(lseek(hVirtualDisk, lOffset, SEEK_SET) == lOffset);
    assert(read(hVirtualDisk, pwData, RK05_SECTOR_SIZE) == RK05_SECTOR_SIZE);
  } else {
    assert(FALSE);  /*physical disk operations not implemented*/
  }
} /*ReadRK05*/


/* RX01BytesToPDP8Words							 */
/*   This procedure will convert 128 bytes of RX01 data into 64 words of */
/* 12 bit data.  The real hardware does this by re-blocking the serial	 */
/* bit stream from the floppy, so it ends up all the bits are compressed */
/* into the first part of the sector and the last part is unused.	 */
PRIVATE void RX01BytesToPDP8Words (UINT8 *pb, UINT16 *pw)
{
  UINT i;
  for (i = 0;  i < 32;  ++i) {
    pw[2*i]   = (UINT16) ((pb[3*i] << 4) | (pb[3*i+1] >> 4));
    pw[2*i+1] = (UINT16) (((pb[3*i+1] & 0x0f) << 8) | pb[3*i+2]);
  }
} /*RX01BytesToPDP8Words*/


/* RX02PDP8WordsToBytes - this is the reverse of RX02BytesToWords */
/* RX02BytesToPDP8Words							 */
/*   This procedure will convert 256 bytes of RX01 data into 128 words of */
/* 12 bit data.  The real hardware does this by re-blocking the serial	 */
/* bit stream from the floppy, so it ends up all the bits are compressed */
/* into the first part of the sector and the last part is unused.	 */
PRIVATE void RX02BytesToPDP8Words (UINT8 *pb, UINT16 *pw)
{
  UINT i;
  for (i = 0;  i < 64;  ++i) {
    pw[2*i]   = (UINT16) ((pb[3*i] << 4) | (pb[3*i+1] >> 4));
    pw[2*i+1] = (UINT16) (((pb[3*i+1] & 0x0f) << 8) | pb[3*i+2]);
  }
} /*RX02BytesToPDP8Words*/


#if 0 // Currently not used
/* RX01PDP8WordsToBytes - this is the reverse of RX01BytesToWords */
PRIVATE void RX01PDP8WordsToBytes (UINT16 *pw, UINT8 *pb)
{
  UINT i;
  for (i = 0;  i < 32;  ++i) {
    pb[3*i]   = (UINT8) (pw[2*i] >> 4);
    pb[3*i+2] = (UINT8) (pw[2*i+1] & 0xff);
    pb[3*i+1] = (UINT8) (((pw[2*i] & 0x0f) << 4) | (pw[2*i+1] >> 8));
  }
} /*RX01PDP8WordsToBytes*/
#endif

/* RX50BytesToPDP8Words							*/
/*   This procedure will convert 512 bytes of RX50 data into 256 words	*/
/* of 12 bit data.  Unfortunately, the RX50 uses a different algorithm	*/
/* for this than the RX01.  On the RX50, it simply reads/writes 16 bit	*/
/* words and truncates them to 12 bits.					*/
PRIVATE void RX50BytesToPDP8Words (UINT8 *pb, UINT16 *pw)
{
  UINT i;
  for (i = 0;  i < 256;  ++i) {
    pw[i] = (UINT16) (pb[2*i] | ((pb[2*i+1] & 0x0f) << 8));
  }
} /*RX50BytesToPDP8Words*/

#if 0 // Not currently used
/* RX50PDP8WordsToBytes - the reverse of RX50BytesToWords */
PRIVATE void RX50PDP8WordsToBytes (UINT16 *pw, UINT8 *pb)
{
  UINT i;
  for (i = 0;  i < 256;  ++i) {
    pb[2*i]   = (UINT8) (pw[i] & 0xff);
    pb[2*i+1] = (UINT8) (pw[i] >> 8);
  }
} /*RX50PDP8WordsToBytes*/
#endif


/* VM01BytesToPDP8Words */
/*   This procedure will convert 192 bytes into 128 PDP-8 words using	*/
/* the same algorithm as the SBC6120 firmware.  It's just a standard	*/
/* OS/8 "three for two" packing.					*/
PRIVATE void VM01BytesToPDP8Words (UINT8 *pb, UINT16 *pw)
{
  UINT i;
  for (i=0;  i<128;  i+=2, pw+=2) {
    *pw     = *pb++;
    *(pw+1) = *pb++;
    *pw     |= (*pb   & 0x0F) << 8;
    *(pw+1) |= (*pb++ & 0xF0) << 4;
  }
}


#if 0 // Not currently used
/* VM01PDP8WordsToBytes - the reverse of VM01BytesToPDP8Words */
PRIVATE void VM01PDP8WordsToBytes (UINT16 *pw, UINT8 *pb)
{
  UINT i;
  for (i=0;  i<128;  i+=2, pw+=2) {
    *pb++ = (UINT8) (*pw    & 0xFF);
    *pb++ = (UINT8) (*(pw+1) & 0xFF);
    *pb++ = (UINT8) (((*(pw+1) >> 4) & 0xF0) | ((*pw >> 8) & 0x0F));
  }
}
#endif

/* RX01OS8LBNToSector							*/
/*   This procedure will figure out the first RX01 sector corresponding	*/
/* to a given OS/8 logical block number.  It duplicates the skew and	*/
/* interleave used by the OS/8 RX8E handler.  Remember that on an RX01	*/
/* each OS/8 block takes FOUR sectors - this just computes the address	*/
/* of the first.							*/
PRIVATE void RX01OS8LBNToSector (UINT nBlock, UINT *pnTrack, UINT *pnSector)
{
  static UINT anSectorMap[13] =
    {1, 9, 17, 25, 8, 16, 24, 5, 13, 21, 4, 12, 20};
  UINT x;
  assert((nBlock >= 0) && (nBlock <= 493));
  *pnTrack = 2 * (nBlock / 13) + 1;
  x = nBlock % 13;
  if (x >= 7) ++*pnTrack;
  *pnSector = anSectorMap[x];
} /*RX01OS8LBNToSector*/


/* RX02OS8LBNToSector							*/
/*   This procedure will figure out the first RX02 sector corresponding	*/
/* to a given OS/8 logical block number.  It duplicates the skew and	*/
/* interleave used by the OS/8 RX8E handler.  Remember that on an RX02	*/
/* each OS/8 block takes FOUR sectors - this just computes the address	*/
/* of the first.							*/
PRIVATE void RX02OS8LBNToSector (UINT nBlock, UINT *pnTrack, UINT *pnSector)
{
  static UINT anSectorMap[] =
    {1, 4, 7, 10, 13, 16, 19, 22, 25, 
     2, 5, 8, 11, 14, 17, 20, 23, 26, 
     3, 6, 9, 12, 15, 18, 21, 24 };

//    {1, 9, 17, 25, 8, 16, 24, 5, 13, 21, 4, 12, 20};
  UINT x;
  assert((nBlock >= 0) && (nBlock <= 988));
#if 0
  *pnTrack = 2 * (nBlock / 13) + 1;
  x = nBlock % 13;
  if (x >= 7) ++*pnTrack;
#endif
  *pnTrack = (nBlock * 256) / (26 * 128) + 1;
  x = ((nBlock * 256) - (*pnTrack - 1) * (26 * 128)) / 128;
  *pnSector = anSectorMap[x];
} /*RX02OS8LBNToSector*/


/* RX01NextSector							 */
/*   After RX01LBNToSector is called, this procedure should then be used */
/* to compute the addresses of the subsequent 3 sectors in an OS/8 RX01	 */
/* logical block.							 */
PRIVATE void RX01NextSector (UINT *pnTrack, UINT *pnSector)
{
 if (*pnSector == 26) {
    *pnSector = 1;  ++*pnTrack;
    assert(*pnTrack <= 77);
  } else {
    if (*pnSector < 25)
      *pnSector += 2;
    else
      *pnSector = 2;
  }
} /*RX01NextSector*/

/* RX02NextSector							 */
/*   After RX02LBNToSector is called, this procedure should then be used */
/* to compute the addresses of the subsequent 3 sectors in an OS/8 RX02	 */
/* logical block.							 */
PRIVATE void RX02NextSector (UINT *pnTrack, UINT *pnSector)
{
 if (*pnSector == 26) {
    *pnSector = 1;  ++*pnTrack;
    assert(*pnTrack <= 77);
  } else {
    *pnSector = (*pnSector - 1 + 3) % 26 + 1;
  }
} /*RX02NextSector*/


/* RX50OS8LBNToSector							 */
/*   This procedure will convert an OS/8 logical block number to the	 */
/* corresponding RX50 physical track and sector.  It allows for the skew */
/* and interleave used by the DECmate-II RX50 handler.  Note that on the */
/* RX50 there is only one physical sector per OS/8 logical block.	 */
PRIVATE void RX50LBNToSector (UINT nBlock, UINT *pnTrack, UINT *pnSector)
{
  UINT temp;
  assert((nBlock >= 0) && (nBlock <= 769));
  *pnTrack = (nBlock / 10)+1;  temp = nBlock % 10;
  *pnSector = temp*2+1;
  if (*pnSector > 10) *pnSector -= 9;
} /*RX50LBNToSector*/


/* RK05OS8LBNToSector */
/*   This procedure will convert an OS/8 block number into a RK05 phy-	*/
/* sical, cylinder/head/sector, address.  The RK05 has a geometry of 16	*/
/* sectors per track, 2 tracks (or heads) per cylinder, and 203 cyl-	*/
/* inders per drive. The OS/8 handler for the RK8E maps these to blocks	*/
/* in the most straight forward way - LBN 0 is C/H/S 0/0/0, LBN 1 is 	*/
/* 0/0/1, LBN 16 is 0/1/0, LBN 32 is 1/0/0, etc.  No interleaving is	*/
/* used, which suprises me a little.					*/
/*									*/
/*   The tricky part is to take into account the selected partition.	*/
/* The OS/8 handler splits the drive _exactly_ in half, which each 	*/
/* partition getting 101.5 cylinders (yep, the top half, head 0, of	*/
/* cylinder 101 belongs to the first partition and the bottom half,	*/
/* head 1, belongs to the second partition).  So for partition 1, LBN	*/
/* 0 is at 101/1/0, LBN 16 is at 102/0/0, and so on.  It seems like it	*/
/* would have been easier to split the drive using the head select (all	*/
/* of partition 0 is head 0, and all of partition 1 is head 1), but it	*/
/* it wasn't done that way...						*/
PRIVATE void RK05LBNToSector (UINT nBlock, UINT nPartition,
	     UINT *pnCylinder, UINT *pnHead, UINT *pnSector)
{
  UINT nRemainder;
  /*   It's easy for us to duplicate the OS/8 partitioning scheme just	*/
  /* by offsetting all LBNs in the second partition by the OS/8 size of	*/
  /* a partition - 3248 blocks.  But before you think the OS/8 authors	*/
  /* picked their partitioning system for the same reason, remember	*/
  /* that they had to deal with twelve bit arithmetic, and this calc-	*/
  /* ulation wouldn't have worked!					*/
  nBlock += nPartition * 3248;
  *pnCylinder = nBlock / (2*16);  nRemainder = nBlock % (2*16);
  *pnHead = nRemainder / 16;  nRemainder = nBlock % 16;
  /*   It appears that RK05 sectors were numbered starting from zero,	*/
  /* not one as they are with the RX01/RX02/RX50s...			*/
  *pnSector = nRemainder;
}


/* ReadRX01OS8Block							*/
/*   This procedure will read one OS/8 virtual block from a RX01 disk-	*/
/* ette.  It can handle either physical or virtual RX01s, and knows all	*/
/* about the logical/physical address mapping, sector interleave and 8	*/
/* to 12 bit conversions used by OS/8.					*/
PRIVATE void ReadRX01OS8Block (UINT nBlock, UINT16 *pwData)
{
  UINT nTrack, nSector, i;
  UINT8 abRawData[RX01_SECTOR_SIZE];
  RX01OS8LBNToSector(nBlock, &nTrack, &nSector);
  for (i = 0;  i < 4;  ++i) {
    ReadRX01(nTrack, nSector, abRawData);
    RX01BytesToPDP8Words(abRawData, pwData+64*i);
    RX01NextSector(&nTrack, &nSector);
  }
} /*ReadRX01OS8Block*/

#define RX01ByteInterleave(sect) (((((sect) % 26) * 3) % 26) + ((sect) / 26) * 26)

/* ReadRX01ByteOS8Block							*/
/*   This procedure will read one OS/8 virtual block from a RX01 disk-	*/
/* ette in special byte mode format.					*/
PRIVATE void ReadRX01ByteOS8Block (UINT nBlock, UINT16 *pwData)
{
   unsigned char buf1[RX01_SECTOR_SIZE],buf2[RX01_SECTOR_SIZE*2];
   int incntr,outcntr;
   unsigned int high;
   off_t lOffset;
   int secnum;

   /* Skip track 0 */
   secnum = (nBlock * 3) + 26;

   lOffset = RX01ByteInterleave(secnum) * 128L; 
   assert(lseek(hVirtualDisk, lOffset, SEEK_SET) == lOffset);
   assert(read(hVirtualDisk, buf1, RX01_SECTOR_SIZE) == RX01_SECTOR_SIZE);

   lOffset = RX01ByteInterleave(secnum + 1) * 128L; 
   assert(lseek(hVirtualDisk, lOffset, SEEK_SET) == lOffset);
   assert(read(hVirtualDisk, buf2, RX01_SECTOR_SIZE) == RX01_SECTOR_SIZE);

   lOffset = RX01ByteInterleave(secnum + 2) * 128L; 
   assert(lseek(hVirtualDisk, lOffset, SEEK_SET) == lOffset);
   assert(read(hVirtualDisk, &buf2[128], RX01_SECTOR_SIZE) == RX01_SECTOR_SIZE);

   for (incntr = 0,outcntr = 0; incntr < 128; incntr++, outcntr += 2) {
      high = ((buf1[incntr] & 0xf0) >> 2) | (buf2[incntr * 2] >> 6);
      pwData[outcntr] = (buf2[incntr*2] & 0x3f) | (high << 6);
      high = ((buf1[incntr] & 0xf) << 2) | (buf2[incntr * 2 + 1] >> 6);
      pwData[outcntr+1] = (buf2[incntr*2+1] & 0x3f) | (high << 6);
   }
} /*ReadRX01ByteOS8Block*/

/* ReadRX02OS8Block							*/
/*   This procedure will read one OS/8 virtual block from a RX02 disk-	*/
/* ette.  It can handle either physical or virtual RX02s, and knows all	*/
/* about the logical/physical address mapping, sector interleave and 8	*/
/* to 12 bit conversions used by OS/8.					*/
PRIVATE void ReadRX02OS8Block (UINT nBlock, UINT16 *pwData)
{
  UINT nTrack, nSector, i;
  UINT8 abRawData[RX02_SECTOR_SIZE];
  RX02OS8LBNToSector(nBlock, &nTrack, &nSector);
  for (i = 0;  i < 2;  ++i) {
    ReadRX02(nTrack, nSector, abRawData);
    RX02BytesToPDP8Words(abRawData, pwData+128*i);
    RX02NextSector(&nTrack, &nSector);
  }
} /*ReadRX02OS8Block*/


/* ReadRX50OS8Block							*/
/*   This procedure will read one OS/8 virtual block from a RX50 disk-	*/
/* ette.  This case is easier than the RX01 in that one OS8 block is	*/
/* exactly one RX50 sector, but this procedure still has to know about	*/
/* the logical to physical translation used by the OS/8 RX50 driver.	*/
PRIVATE void ReadRX50OS8Block (UINT nBlock, UINT16 *pwData)
{
  UINT nTrack, nSector;
  UINT8 abRawData[RX50_SECTOR_SIZE];
  RX50LBNToSector(nBlock, &nTrack, &nSector);
  ReadRX50(nTrack, nSector, abRawData);
  RX50BytesToPDP8Words(abRawData, pwData);
} /*ReadRX50OS8Block*/


/*   Each VM01 (.VMD) file is a byte-for-byte image of an SBC6120 SRAM 	*/
/* or EPROM.  Because a 512Kb RAM chip requires far more address bits	*/
/* than a PDP-8 can muster, the SBC6120 hardware segments it into 128	*/
/* banks of 4Kb each.  For convenience here we treat banks as if they	*/
/* were sectors, and the VM01 becomes a device with 128 sectors per	*/
/* track, one cylinder and one head.  The SBC6120 firmware stores 21	*/
/* pages of 128 twelve bit words in each bank, packed "two for three"	*/
/* requiring 192 eight bit bytes per page.  Twenty one pages of 192 	*/
/* bytes each takes 4032 bytes - the remaining 64 bytes of each bank 	*/
/* are used by the firmware memory diagnostic and are never used to	*/
/* store data.								*/

/* VM01PageToBank - compute bank and offset for VM01 page number */
PRIVATE void VM01PageToBank (UINT nPage, UINT *pnBank, UINT *pnOffset)
{
  *pnBank = nPage / 21;
  *pnOffset = (nPage % 21) * VM01_SECTOR_SIZE;
}


/* ReadVM01OS8Block							*/
/*   This procedure will read one OS/8 virtual block from a VM01 image.	*/
/* The SBC6120 firmware stores data in the SRAMs in 128 word PDP-8	*/
/* pages, so each OS/8 block requires two consectutively numbered pages	*/
/* to be read.  There's no guarantee that these two pages will be in	*/
/* the same bank, and we have to allow for the possibility that they're	*/
/* split.								*/
PRIVATE void ReadVM01OS8Block (UINT nBlock, UINT16 *pwData)
{
  UINT8 abRawData[VM01_BANK_SIZE];
  UINT nBank1, nBank2, nOffset;

  /* Read the first page (one half) of the block... */
  VM01PageToBank(nBlock*2, &nBank1, &nOffset);
  ReadVM01(nBank1, abRawData);
  VM01BytesToPDP8Words(abRawData+nOffset, pwData);

  /* And read the second half of the block...  */
  VM01PageToBank(nBlock*2+1, &nBank2, &nOffset);
  if (nBank2 != nBank1) ReadVM01(nBank2, abRawData);
  VM01BytesToPDP8Words(abRawData+nOffset, pwData+128);
} /*ReadVM01OS8Block*/


/* ReadRK05OS8Block - read one OS/8 block from the current partition */
PRIVATE void ReadRK05OS8Block (UINT nBlock, UINT16 *pwData)
{
  UINT nCylinder, nHead, nSector;
  RK05LBNToSector(nBlock, nPartition, &nCylinder, &nHead, &nSector);
  ReadRK05(nCylinder, nHead, nSector, pwData);
} /*ReadRK05OS8Block*/

/* ReadDECTAPEOS8Block - read one OS/8 block from the current partition */
PRIVATE void ReadDECTAPEOS8Block (UINT nBlock, UINT16 *pwData)
{
    long lOffset;

    lOffset = (long) nBlock * 129*2*2;
//printf("Offset %d\n",lOffset);
    assert(lseek(hVirtualDisk, lOffset, SEEK_SET) == lOffset);
    assert(read(hVirtualDisk, pwData, RK05_SECTOR_SIZE/2) == RK05_SECTOR_SIZE/2);
       // Discard extra word at end of block
    assert(read(hVirtualDisk, &pwData[RK05_SECTOR_SIZE/4], 2));
    assert(read(hVirtualDisk, &pwData[RK05_SECTOR_SIZE/4], RK05_SECTOR_SIZE/2) == RK05_SECTOR_SIZE/2);
} /*ReadDECTAPEOS8Block*/

/* ReadOS8Block								 */
/*   This procedure will read one OS/8 virtual block from the current	 */
/* disk device.  It knows how to handle diskette addressing and the 8 to */
/* 12 bit conversions for both RX01 and RX50 diskettes.  Note that an	 */
/* OS/8 block is always 256 words long.					 */
PUBLIC void ReadOS8Block (UINT nBlock, UINT16 *pwData)
{
  switch (nDiskType) {
    case RX01:  ReadRX01OS8Block(nBlock, pwData);  break;
    case RX01_BYTE:  ReadRX01ByteOS8Block(nBlock, pwData);  break;
    case RX02:  ReadRX02OS8Block(nBlock, pwData);  break;
    case RX50:  ReadRX50OS8Block(nBlock, pwData);  break;
    case VM01:  ReadVM01OS8Block(nBlock, pwData);  break;
    case RK05:  ReadRK05OS8Block(nBlock, pwData);  break;
    case DECTAPE:  ReadDECTAPEOS8Block(nBlock, pwData);  break;
    case LINC_DECTAPE:  ReadLINK_OS8_OS8Block(nBlock, pwData);  break;
    default:    assert(FALSE);
  }
} /*ReadOS8Block*/

