/* diskette.h */
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
#ifndef _DISKETTE_H_
#define _DISKETTE_H_

#define RX01_SECTOR_SIZE	128	/* Size a RX01 disk sector		*/
#define RX02_SECTOR_SIZE	256	/* Size a RX02 disk sector (in bytes) 	*/
#define RX50_SECTOR_SIZE	512	/*  "   " RX50  "      "		*/
#define VM01_SECTOR_SIZE        192	/*  "   " VM01 memory sector		*/
#define VM01_BANK_SIZE	       4096	/*  "   " VM01 memory bank (21 sectors)	*/
/*   There's a minor hack here - the RK05 actually has 256 12 bit words per	*/
/* sector, but the low level code only deals with 8 bit data.  So we simply lie */
/* to it, and read/write each 256 word sector as 512 bytes. The upper four bits	*/
/* of each pair of bytes is unused...						*/
#define RK05_SECTOR_SIZE	512	/* RK05 sector size,in bytes		*/

typedef enum {				/* Type of the diskette in use		*/
  RX01,					/* 8"    SSSD floppy diskette		*/
  RX01_BYTE,				/* 8"    SSSD floppy diskette byte mode */
  RX02,					/* 8"    SSDD floppy diskette		*/
  RX50,					/* 5.25" SSDD floppy diskette		*/
  VM01,					/* SBC6120 RAM disk 			*/
  RK05,					/* RK05 image files from WinEight	*/
  DECTAPE,				/* OS8 DECtape*/
  LINC_DECTAPE,				/* OS8 LINKtape */
  AUTO_OS8,				/* Auto detect */
  NODISK				/* no device mounted			*/
} DISKTYPE;

#define LINC_HEADER_SIZE 6

void CloseDisk (void);
BOOLEAN OpenDisk (BOOLEAN fVirtual, BOOLEAN fRead, DISKTYPE nType, char *pszName, BOOLEAN byteMode);
BOOLEAN CreateDisk (BOOLEAN fVirtual, BOOLEAN fRead, DISKTYPE nType, char *pszName);
BOOLEAN DiskMounted (void);
DISKTYPE DiskType (void);
char *DiskName (void);
BOOLEAN ReadOnly (void);
void ReadOS8Block (UINT nBlock, UINT16 *pwData);
void WriteOS8Block (UINT nBlock, UINT16 *pwData);
BOOLEAN SetPartition (char chPart);
char GetPartition (void);

#endif
