/* types.h */
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
#ifndef _TYPES_H_
#define _TYPES_H_

/* Standard data types... */
typedef unsigned       UINT;	/* generic unsigned data type		*/
typedef unsigned char  UINT8;	/* unsigned byte (8 bites)		*/
typedef unsigned short UINT16;	/* unsigned word (16 bits)		*/


/* BOOLEAN data type defintions ... */
typedef unsigned char  BOOLEAN;
#define FALSE	((BOOLEAN) 0)
#define TRUE	((BOOLEAN) ~FALSE)


/* STRING data type definitions ... */
#define MAXSTRING	256	/* length of a STRING data type		*/
#define EOS		'\0'	/* end of string			*/
typedef char STRING[MAXSTRING];	/* character string type		*/


/*  These macros are used mostly for documentation purposes to indicate	*/
/* that a variable of a function is to be visible within the current	*/
/* module only (PRIVATE) or to other modules as well (PUBLIC)...	*/
#define PRIVATE	static
#define PUBLIC


/* Shorthand for some simple string functions... */
#define STREQL(s1,s2)	  (strcmp(s1,s2) == 0)
#define STRIEQL(s1,s2)	  (stricmp(s1,s2) == 0)
#define STRNEQL(s1,s2,n)  (strncmp(s1,s2,n) == 0)
#define STRNIEQL(s1,s2,n) (strnicmp(s1,s2,n) == 0)
#define CAP(x)		  (islower(x) ? toupper(x) : x)

/* VMS hacks... */
#ifdef VMS
//#define _open open
//#define _close close
//#define _read read
//#define _write write
//#define _lseek lseek
#endif

#endif /* _TYPES_H_ */
