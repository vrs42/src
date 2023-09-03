# Microsoft Visual C++ generated build script - Do not modify

PROJ = FLX8
DEBUG = 1
PROGTYPE = 6
CALLER = 
ARGS = 
DLLS = 
D_RCDEFINES = -d_DEBUG
R_RCDEFINES = -dNDEBUG
ORIGIN = MSVC
ORIGIN_VER = 1.00
PROJPATH = D:\PDP8\FLX8\
USEMFC = 0
CC = cl
CPP = cl
CXX = cl
CCREATEPCHFLAG = 
CPPCREATEPCHFLAG = 
CUSEPCHFLAG = 
CPPUSEPCHFLAG = 
FIRSTC = FLX8.C      
FIRSTCPP =             
RC = rc
CFLAGS_D_DEXE = /nologo /G2 /W3 /Zi /AL /Od /D "_DEBUG" /D "_DOS" /FR /Fd"FLX8.PDB"
CFLAGS_R_DEXE = /nologo /Gs /G2 /W3 /AM /Ox /D "NDEBUG" /D "_DOS" /FR 
LFLAGS_D_DEXE = /NOLOGO /NOI /STACK:10240 /ONERROR:NOEXE /CO 
LFLAGS_R_DEXE = /NOLOGO /NOI /STACK:5120 /ONERROR:NOEXE 
LIBS_D_DEXE = oldnames llibce 
LIBS_R_DEXE = oldnames mlibce 
RCFLAGS = /nologo
RESFLAGS = /nologo
RUNFLAGS = 
OBJS_EXT = 
LIBS_EXT = 
!if "$(DEBUG)" == "1"
CFLAGS = $(CFLAGS_D_DEXE)
LFLAGS = $(LFLAGS_D_DEXE)
LIBS = $(LIBS_D_DEXE)
MAPFILE = nul
RCDEFINES = $(D_RCDEFINES)
!else
CFLAGS = $(CFLAGS_R_DEXE)
LFLAGS = $(LFLAGS_R_DEXE)
LIBS = $(LIBS_R_DEXE)
MAPFILE = nul
RCDEFINES = $(R_RCDEFINES)
!endif
!if [if exist MSVC.BND del MSVC.BND]
!endif
SBRS = FLX8.SBR \
		COMMAND.SBR \
		DISKETTE.SBR \
		OS8.SBR


FLX8_DEP = d:\pdp8\flx8\command.h \
	d:\pdp8\flx8\diskette.h \
	d:\pdp8\flx8\os8.h


COMMAND_DEP = d:\pdp8\flx8\command.h


DISKETTE_DEP = d:\pdp8\flx8\diskette.h


OS8_DEP = d:\pdp8\flx8\diskette.h \
	d:\pdp8\flx8\os8.h


all:	$(PROJ).EXE $(PROJ).BSC

FLX8.OBJ:	FLX8.C $(FLX8_DEP)
	$(CC) $(CFLAGS) $(CCREATEPCHFLAG) /c FLX8.C

COMMAND.OBJ:	COMMAND.C $(COMMAND_DEP)
	$(CC) $(CFLAGS) $(CUSEPCHFLAG) /c COMMAND.C

DISKETTE.OBJ:	DISKETTE.C $(DISKETTE_DEP)
	$(CC) $(CFLAGS) $(CUSEPCHFLAG) /c DISKETTE.C

OS8.OBJ:	OS8.C $(OS8_DEP)
	$(CC) $(CFLAGS) $(CUSEPCHFLAG) /c OS8.C

$(PROJ).EXE::	FLX8.OBJ COMMAND.OBJ DISKETTE.OBJ OS8.OBJ $(OBJS_EXT) $(DEFFILE)
	echo >NUL @<<$(PROJ).CRF
FLX8.OBJ +
COMMAND.OBJ +
DISKETTE.OBJ +
OS8.OBJ +
$(OBJS_EXT)
$(PROJ).EXE
$(MAPFILE)
c:\msvc15\lib\+
$(LIBS)
$(DEFFILE);
<<
	link $(LFLAGS) @$(PROJ).CRF

run: $(PROJ).EXE
	$(PROJ) $(RUNFLAGS)


$(PROJ).BSC: $(SBRS)
	bscmake @<<
/o$@ $(SBRS)
<<
