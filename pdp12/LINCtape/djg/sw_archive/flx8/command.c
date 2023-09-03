/*++									*/
/* command.c								*/
/*									*/
/* DESCRIPTION:								*/
/*   This module contains a command parser used by the FLX8, EIGHT and	*/
/* other projects.  The command syntax takes the general form:		*/
/*									*/
/*   prompt> VERB [ARG-LIST-1 [ARG-LIST-2]] [/MODIFIER/MODIFIER...]	*/
/*									*/
/*  This is actually a very simplified form of DCL, subject to these	*/
/* restrictions: 1) commands may have only zero, one or two parameters,	*/
/* 2) there are only global modifiers, and 3) modifiers may not take	*/
/* values.  Argument lists (e.g. "A,B,C") are allowed for either para-	*/
/* meter, and boolean modifiers (e.g. "/CONFIRM" vs "/NOCONFIRM") are	*/
/* also allowed.							*/
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
/* dd-mmm-yy    who     description					*/
/* ??-???-??    RLA     New file.					*/
/*--									*/

/* Include files... */
#include <stdio.h>	/* NULL, printf(), scanf(), et al		*/
#include <string.h>	/* strlen(), strcpy(), strcat(), etc...		*/
#include <ctype.h>	/* islower(), toupper(), isalnum(), ec...	*/
#include <stdlib.h>	/* malloc(), exit(), etc...			*/
#include <stdarg.h>	/* va_start(), va_end(), etc...			*/
#ifdef VMS
#include <descrip.h>
#endif
#ifdef MSDOS
#include <dos.h>	/* _dos_findfirst(), _dos_findnext(), etc...	*/
#endif
#include "types.h"	/* universal declarations for this project	*/
#include "command.h"	/* function prototypes for this module		*/


/* Global variables... */
PRIVATE char *pszProgram;/* the name of the current program		*/


/************************************************************************/
/* I/O Primitives */
/************************************************************************/

/* SetProgram */
/*   This procedure will set the name of the current program, which is	*/
/* used in all command prompts and error messages....			*/
PUBLIC void SetProgram (char *pszName)
{
  pszProgram = pszName;
}

/* AskUser								*/
/*   This procedure will read a single line of input from the user.  It	*/
/* allows the prompting string to be explicitly specified.  If there is	*/
/* no more input available (i.e. end of file is found) then it will	*/
/* return FALSE.							*/
PUBLIC BOOLEAN AskUser (char *pszPrompt, char *pszAnswer)
{
  UINT cbAnswer;
  fputs(pszPrompt, stderr);
  if (fgets(pszAnswer, MAXSTRING, stdin) == NULL) return FALSE;
  cbAnswer = strlen(pszAnswer);
  if ((cbAnswer > 0)  &&  (pszAnswer[cbAnswer-1] == '\n'))
    pszAnswer[cbAnswer-1] = EOS;
  return TRUE;
} /*AskUser*/

/* ReadCommand								*/
/*   This procedure will read a command line.  If there are no more	*/
/* available (i.e. EOF) then it will return FALSE.			*/
PUBLIC BOOLEAN ReadCommand (char *pszCommand)
{
  STRING szPrompt;
  strcpy(szPrompt, pszProgram);  strcat(szPrompt, ">");
  return AskUser(szPrompt, pszCommand);
} /*ReadCommand*/

/* Message								 */
/*   This procedure will print a message in the appropriate format.  The */
/* first parameter is the severity of the message, and should be one of	 */
/* E (error), W (warning) or I (informational).  The second parameter is */
/* the actual message text, and the third is an argument to be added to	 */
/* the end of the message (if any).					 */
PUBLIC void Message (char cPrefix, char *pszFormat, ...)
{
  STRING szBuffer;
  va_list args;
  va_start(args, pszFormat);
  vsprintf(szBuffer, pszFormat, args);
  va_end(args);
  fprintf(stderr, "%%%s-%c, %s\n", pszProgram, cPrefix, szBuffer);
}


/************************************************************************/
/* Command Parser Utilities */
/************************************************************************/

/* SpanWhite								*/
/*   This procedure will skip over any blank characters in the command	*/
/* line.  It will stop at the end of the buffer...			*/
PRIVATE void SpanWhite (char **ppszCmd)
{
  while (isspace(**ppszCmd)) ++*ppszCmd;
} /*SpanWhite*/

/* GetKeyword								 */
/*   This procedure will get a keyword from the command line, starting	 */
/* with the current character.  Keywords are alphanumeric and are always */
/* folded to upper case.  If there isn't at least one alphanumeric char- */
/* acter there, it will return FALSE.					 */
PRIVATE BOOLEAN GetKeyword (char **ppszCmd, char *pszKey)
{
  UINT cbKey = 0;
  while (isalnum(**ppszCmd)) {
    pszKey[cbKey] = CAP(**ppszCmd);  ++cbKey;  ++*ppszCmd;
  }
  pszKey[cbKey] = EOS;
  return (cbKey > 0);
} /*GetKeyword*/

/* ParseQualifiers							 */
/*   This procedure will absorb any qualifiers which might be next on	 */
/* the command line.  If it finds any, it will APPEND them to the cur-	 */
/* rent command qualifiers.  If there are none, it will do nothing.  Any */
/* syntax errors will cause a message to be printed and FALSE returned.	 */
PRIVATE BOOLEAN ParseQualifiers (char **ppszCmd, char *pszQuals)
{
  STRING szKey;
  SpanWhite(ppszCmd);
  while (**ppszCmd == SLASH) {
    szKey[0] = SLASH;  ++*ppszCmd;
    if (GetKeyword(ppszCmd, &szKey[1])) {
      strcat(pszQuals, szKey);
    } else {
      Message('E', "no qualifier after SLASH");
      return FALSE;
    }
    SpanWhite(ppszCmd);
  }
  return TRUE;
} /*ParseQualifiers*/

/* ParseParameter							*/
/*   This procedure will parse a single parameter and store it in the	*/
/* argument string.  A parameter is any string of characters except for	*/
/* white space and "/".  A parameter may also contain multiple items,	*/
/* with each item separated by a comma.  In this case white space may	*/
/* follow the comma but not preceed it.  This procedure will return	*/
/* FALSE if no parameter can be found, but it cannot detect any error	*/
/* error conditions (since almost anything is legal in a parameter!).	*/
PRIVATE BOOLEAN ParseParameter (char **ppszCmd, char *pszParam)
{
  UINT cbParam = 0;
  while (!isspace(**ppszCmd)  &&  (**ppszCmd != SLASH)  &&  (**ppszCmd != EOS)) {
    pszParam[cbParam++] = **ppszCmd;
    if (**ppszCmd == COMMA) {
      ++*ppszCmd;  SpanWhite(ppszCmd);
    } else
      ++*ppszCmd;
  }
  pszParam[cbParam] = EOS;
  return (cbParam > 0);
} /*ParseParameter*/

/* ParseCommand								 */
/*   This procedure will parse the current command line.  It can verify	 */
/* correct syntax but not the semantics of the command.  If there is	 */
/* some syntax error, it will print a message and return FALSE.  If all	 */
/* is well it will return TRUE and leave the results of the parse in the */
/* CmdXxx global variables...						 */
PUBLIC BOOLEAN ParseCommand
  (char *pszCommand, char *pszVerb, char *pszQualifiers, char *pszP1, char *pszP2)
{
  pszVerb[0] = pszQualifiers[0] = pszP1[0] = pszP2[0] = EOS;
  SpanWhite(&pszCommand);
  if (!GetKeyword(&pszCommand, pszVerb)) {
    Message('E',"no command on line");
    return FALSE;
  } else if (!ParseQualifiers(&pszCommand, pszQualifiers)) {
    /* error message already printed ! */
    return FALSE;
  } else if (!ParseParameter(&pszCommand, pszP1)) {
    /* no parameters for this command */
    return TRUE;
  } else if (!ParseQualifiers(&pszCommand, pszQualifiers)) {
    /* error message already printed ! */
    return FALSE;
  } else if (!ParseParameter(&pszCommand, pszP2)) {
    /* only one parameter for this command */
    return TRUE;
  } else if (!ParseQualifiers(&pszCommand, pszQualifiers)) {
    /* error message already printed ! */
    return FALSE;
  } else if (*pszCommand != EOS) {
    Message('E',"extra parameters on line - \"%s\"", pszCommand);
    return FALSE;
  } else
    return TRUE;
} /*ParseCommand*/

/* BooleanQualifier							 */
/*   This procedure will test for a specific qualifier.  All qualifiers	 */
/* are boolean and their sense is negated by a '/NO' prefix.  If the	 */
/* argument is the qualifier given (with or without a 'NO') then this	 */
/* procedure will return TRUE.  The boolean argument will be set to TRUE */
/* if the qualifier is present without a 'NO' and false if the 'NO' is	 */
/* given. If the qualifier doesn't match, then the boolean is unchanged. */
PUBLIC BOOLEAN BooleanQualifier
  (char *pszString, char *pszQualifier, UINT nMatch, BOOLEAN *pfResult)
{
  if (   (strlen(pszString) >= nMatch+2)
      && (pszString[0] == 'N') && (pszString[1] == 'O')
      && STRNEQL(pszQualifier, &pszString[2], nMatch)) {
    *pfResult = FALSE;  return TRUE;
  } else if (STRNEQL(pszQualifier, pszString, nMatch)) {
    *pfResult = TRUE;  return TRUE;
  } else
    return FALSE;
} /*BooleanQualifier*/

/* StringItem								 */
/*   This procedure will extract the n'th item from a string where the	 */
/* items are separated by "delimiter".  The first item is numbered zero, */
/* and if the string runs out of items FALSE will be returned. Note that */
/* the delimiter is NOT returned in the result.				 */
PUBLIC BOOLEAN StringItem (char *pszString, char *pszItem, char cDelimiter, UINT nItem)
{
  UINT cbItem = 0;
  if (strlen(pszString) == 0) return FALSE;
  while (nItem > 0) {
    pszString = strchr(pszString, cDelimiter);
    if (pszString == NULL) return FALSE;
    ++pszString;  --nItem;
  }
  while ((pszString[cbItem] != cDelimiter) && (pszString[cbItem] != EOS)) ++cbItem;
  strncpy(pszItem, pszString, cbItem);
  pszItem[cbItem] = EOS;
  return TRUE;
} /*StringItem*/

/* OneItem								*/
/*   Return TRUE if the string has only one item or print a message if	*/
/* not...								*/
PUBLIC BOOLEAN OneItem (char *pszList)
{
  STRING szDummy;
  if (StringItem(pszList, szDummy, COMMA, 1)) {
    Message('E', "list not allowed - %s", pszList);
    return FALSE;
  } else
    return TRUE;
} /*OneItem*/

/* CountItems - count the number of items in a list */
PUBLIC UINT CountItems (char *pszList)
{
  STRING szDummy;
  UINT nCount = 0;
  while (StringItem(pszList, szDummy, COMMA, nCount))  ++nCount;
  return nCount;
} /*CountItems*/

/* UnknownQualifier - print unknown qualifier message. */
PUBLIC void UnknownQualifier (char *pszQualifier)
{
  Message('E', "unknown qualifier %s", pszQualifier);
} /*UnknownQualifier*/

/* CheckParameter - check for the required number of parameters */
PUBLIC BOOLEAN CheckParameter (UINT nCount, char *pszP1, char *pszP2)
{
  if (nCount == 0) {
    if (strlen(pszP1) > 0) {
      Message('E', "extra parameter(s)", pszP1);  return FALSE;
    } else
      return TRUE;

  } else if (nCount == 1) {
    if (strlen(pszP1) == 0) {
      Message('E', "additional parameters required");  return FALSE;
    } else if (strlen(pszP2) > 0) {
      Message('E', "extra parameter(s)", pszP2);  return FALSE;
    } else
      return TRUE;

  } else {
    if ((strlen(pszP1) == 0) || (strlen(pszP2) == 0)) {
      Message('E', "additional parameters required");  return FALSE;
    } else
      return TRUE;
  }
} /*CheckParameter*/

/* NoQualifiers - test for no command qualifiers */
PUBLIC BOOLEAN NoQualifiers (char *pszQualifiers)
{
  if (strlen(pszQualifiers) > 0) {
    Message('E', "no qualifiers allowed - %s", pszQualifiers);
    return FALSE;
  } else
    return TRUE;
} /*NoQualifiers*/

/* YesOrNo								*/
/*   This procedure will ask a YES or NO question of the user and will	*/
/* parse and return (TRUE for YES, FALSE for NO) his answer.  If the	*/
/* response is not 'YES', 'NO', or a null then an error will be printed	*/
/* and the user asked again.						*/
PUBLIC BOOLEAN YesOrNo (char *pszFormat, BOOLEAN fDefault, ...)
{
  STRING szPrompt, szAnswer;  va_list args;
  va_start(args, fDefault);
  vsprintf(szPrompt, pszFormat, args);
  va_end(args);
  while (TRUE) {
    if (!AskUser(szPrompt, szAnswer)) return fDefault;
    if (strlen(szAnswer) == 0)  return fDefault;
    if (STRNEQL(szAnswer, "NO", 1)) return FALSE;
    if (STRNEQL(szAnswer, "YES", 1)) return TRUE;
    Message('W', "please answer YES or NO - %s", szAnswer);
  }
} /*YesOrNo*/


/************************************************************************/
/* Other System Utilities */
/************************************************************************/


/* FindHostFile */
/*   This procedure will find the file in the host file system specified */
/* by the argument.  It will return the full name of the file.  If no	 */
/* such file can be found, it will return FALSE.  As a side effect, it	 */
/* will initialize the context so that FindNextHostFile may be called to */
/* find subsequent matching files.					 */
PUBLIC BOOLEAN FindHostFile (BOOLEAN fFirst, char *pszMask, char *pszResult)
{

#ifdef MSDOS
  static struct _find_t FileInfo;
  STRING szDrive, szPath;
  if (fFirst) {
    if (_dos_findfirst(pszMask, _A_NORMAL, &FileInfo) != 0) return FALSE;
  } else {
    if (_dos_findnext(&FileInfo) != 0) return FALSE;
  }
  _splitpath(pszMask, szDrive, szPath, NULL, NULL);
  strcpy(pszResult, szDrive);  strcat(pszResult, szPath);
  strcat(pszResult, FileInfo.name);
  return TRUE;
#endif

#ifdef VMS
  static long lRMSContext;
  long lStatus;
  struct dsc$descriptor_s dscMask, dscResult;

  dscMask.dsc$b_dtype = dscResult.dsc$b_dtype = DSC$K_DTYPE_T;
  dscMask.dsc$b_class = dscResult.dsc$b_class = DSC$K_CLASS_S;
  dscMask.dsc$w_length = strlen(pszMask);  dscMask.dsc$a_pointer = pszMask;
  dscResult.dsc$w_length = MAXSTRING;  dscResult.dsc$a_pointer = pszResult;

  if (fFirst) lRMSContext = 0;

  lStatus = LIB$FIND_FILE(&dscMask, &dscResult, &lRMSContext, 0, 0, 0, 0);
  if (lStatus & 1) {
    return FALSE;
  } else {
    LIB$FIND_FILE_END(&lRMSContext);
    return FALSE;
  }
#endif

} /*FindHostFile*/

/* ParseHostFileName							 */
/*   This procedure will parse a native file specification and separate	 */
/* it into a path (both device and directory), a file name (but not the	 */
/* extension or type) a file extension, and a version (which may be null */
/* on some systems).							 */
PUBLIC void ParseHostFileName
  (char *pszFileName, char *pszPath, char *pszName, char *pszType)
{
#ifdef WINDOWS
#ifdef MSDOS
  STRING szDrive, szDOSPath;
  _splitpath(pszFileName, szDrive, szDOSPath, pszName, pszType);
  strcpy(pszPath, szDrive);  strcat(pszPath, szDOSPath);
#endif
#else
   {
      char *p;
      strcpy(pszName,basename(pszFileName));
      strcpy(pszPath,dirname(pszFileName));
      strcat(pszPath,"/");
      p = strrchr(pszName, '.');
      if (p != NULL) {
         strcpy(pszType,p);
         *(p+1) = 0;
      } else
         pszType[0] = 0;
   }
#endif
#ifdef UNUSED
  var p1, p2: INTEGER;  ts: STRING;
  pszPath[0] = pszName[0] = pszType[0] = EOS;
  SetLength(path,0); SetLength(name,0); SetLength(ext,0); SetLength(vers,0);
  p1 := StringChar(filespec, ']', 1);
  if (p1 = 0) then p1 := StringChar(filespec, '>', 1);
  if (p1 = 0) then p1 := StringChar(filespec, ':', 1);
  if (p1 > 0) then SubString(filespec, path, 1, p1);
  p1 := succ(p1);
  p2 := StringChar(filespec, '.', p1);
  if (p2 = 0) then
    SubString(filespec, name, p1, Length(filespec)-p1+1)
  else {
    SubString(filespec, name, p1, p2-p1);
    SubString(filespec, ts, p2, Length(filespec)-p2+1);
    p1 := StringChar(ts, ';', 1);
    if (p1 > 0) then {
      Substring(ts, ext, 1, p1-1);  Substring(ts, vers, p1, Length(ts)-p1+1)
    } else
      ext := ts
  };
  UpperCase(path);  UpperCase(name);  UpperCase(ext);
  /*if (name[Length(name)] <> '.') then AppendChar(name, '.');*/
#endif
} /*ParseHostFileName*/;
