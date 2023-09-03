/* command.h */
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
#ifndef _COMMAND_H_
#define _COMMAND_H_

#define SLASH	'/'	/* modifier character (e.g. "DELETE/NOLOG")	*/
#define COMMA	','	/* argument list separator (e.g. "FILE1,FILE2")	*/

/* Global routines... */
void SetProgram (char *pszName);
BOOLEAN AskUser (char *pszPrompt, char *pszAnswer);
BOOLEAN ReadCommand (char *pszCommand);
void Message (char cPrefix, char *pszFormat, ...);
BOOLEAN ParseCommand  (char *pszCommand, char *pszVerb, char *pszQualifiers, char *pszP1, char *pszP2);
BOOLEAN BooleanQualifier
  (char *pszString, char *pszQualifier, UINT nMatch, BOOLEAN *pfResult);
BOOLEAN StringItem (char *pszString, char *pszItem, char cDelimiter, UINT nItem);
BOOLEAN OneItem (char *pszList);
UINT CountItems (char *pszList);
void UnknownQualifier (char *pszQualifier);
BOOLEAN CheckParameter (UINT nCount, char *pszP1, char *pszP2);
BOOLEAN NoQualifiers (char *pszQualifiers);
BOOLEAN YesOrNo (char *pszPrompt, BOOLEAN fDefault, ...);
BOOLEAN ConfirmFile (char *pszFunction, char *pszFile);
BOOLEAN FindHostFile (BOOLEAN fFirst, char *pszMask, char *pszResult);
void ParseHostFileName (char *pszFileName, char *pszPath, char *pszName, char *pszType);

#endif	/* command.h */
