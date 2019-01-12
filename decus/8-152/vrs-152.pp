/DECUS	8-152 MUSIC PLAYING PROGRAM
/
#ifdef UNKNOWN
/VERSION ?.?
#else
/VERSION 1.2
#endif
/
/
/
/
*0200
PLAY,	CLA CLL 
	TAD WORD0	/ Reset music pointer
	DCA WORD
	TAD NOTE0	/ Set up note counter
	CIA
	DCA NOTE
START,	TAD I WORD	/ Get the current note
	CLL RTL 	/ Get DAMP bit
	AND MASKD
	TAD DAMP0	/ Add DAMP offset
	DCA DAMP	/ Set DAMP pointer
#ifdef UNKNOWN
	TAD DAMP	/ Get DAMP pointer
	IAC		/ Point to our table
	IAC
	DCA DAMP2	/ Store table ptr
	TAD I DAMP2	/ Get table entrty
	DCA DAMP2	/ Remember for later
#endif
	TAD I DAMP	/ Get DAMP value
	DCA DAMP	/ ...and remember it
	TAD DFIX	/ Get "TAD DAMP" instruction
	DCA DAMPI	/ Store it
#ifdef UNKNOWN
	TAD DDFIX 	/ Get "TAD DAMP2" instruction
	DCA DAMPI2	/ Store it
#endif
	TAD I WORD	/ Get the current note
	AND MASKF	/ Extract the frequency info
	TAD CONSTF	/ Point into the note table
	DCA N0		/ Store the frequency pointer
	TAD I N0	/ Get the frequency
#ifdef UNKNOWN
	CIA		/ Negate it
#endif
	DCA N0		/ Store the frequency
	TAD I WORD	/ Get the current note
	AND MASKA	/ Extract the amplitude
	CLL RAR 	/ Scale it
	SZA 		/ Is it zero?
	JMP STAMP	/ No, just store it
	TAD CDAM	/ Yes, get a NOP
	DCA DAMPI	/ Store for later
#ifdef UNKNOWN
	TAD DAMPI	/ Get NOP back
	DCA DAMPI2	/ Store for later
#endif
STAMP,	DCA AMP		/ Store the amplitude
#ifdef UNKNOWN
	TAD AMP		/ Get amplitude back
	DCA AMP2	/ Save a copy
#endif
	TAD I WORD	/ Get the current note
	AND MASKL	/ Get the duration
	RTR 
	CLL RTR 
	RAR 
	TAD CONSTL	/ Add table offset
	DCA L0		/ Store duration pointer
	TAD I L0	/ Get duration table entry
	CIA		/ Negate it
	DCA L0		/ Save as loop counter value
	TAD L0		/ Get it back
	DCA L		/ Set up initial loop counter
	TAD CNTR	/ Reset tempo counter
	DCA CNT
#ifdef UNKNOWN
A,	TAD N0		/ Get frequency value
	DCA ONCNT	/ Store it
	TAD ONCNT	/ Get it again
	DCA OFFNT	/ Store it again
#else
	TAD N0		/ Get frequency value
	6554		/ and output it
	CLA CLL
A,	ISZ L		/ Wait for duration
	JMP A
#endif
	TAD AMP		/ Get amplitude
DAMPI,	TAD DAMP	/ Add DAMP (or not)
#ifndef UNKNOWN
	RTR		/ Scale it
#endif
	6551		/ Output it
#ifndef UNKNOWN
	RTL		/ Unscale it
#endif
	DCA AMP		/ Store it
#ifdef UNKNOWN
	TAD AMP2	/ Get amplitude copy
DAMPI2,	TAD DAMP2	/ Add our table entry (or not)
	6552		/ Set output amplitude
	DCA AMP2	/ Save the command
	JMS DELAY	/ Do the note delay 
	ISZ ONCNT	/ ...frequency times
	JMP .-2
	6553		/ Set output off
	JMS DELAY	/ Do the delay again
	ISZ OFFNT	/ ...frequency times
	JMP .-2
	JMP A		/ Go again
FIN,	ISZ WORD	/ Note is finished, point to the next
#else
	ISZ CNT		/ Bump tempo counter
	SKP
	JMP FIN
	TAD L0		/ Set up another duration
	DCA L
	JMP A		/ Sustain for another duration
FIN,	ISZ WORD	/ Note is finished, point to the next
	6552		/ Set output low
#endif
/
/
/
/
/
/

/
/EDITOR PAGE 2
/
/
	ISZ NOTE	/ Last note?
	SKP		/ No, go get next
	HLT		/ Yes, halt
	JMP START
#ifdef UNKNOWN
DELAY,	0000		/ Magic subroutine
	ISZ L		/ Duration expired?
	JMP DELAYX	/ No, return
	ISZ CNT		/ Yes, bump tempo ounter
	SKP
	JMP FIN		/ Tempo expired, go wrap up
	TAD L0		/ Set up another duration
	DCA L
DELAYX,	JMP I DELAY	/ Return to caller
#else
	*0376
#endif
CDAM,	NOP
DFIX,	TAD DAMP
#ifdef UNKNOWN
DDFIX,	TAD DAMP2
DAMP2,	0
AMP2,	0
#endif
/
/
/
#ifdef UNKNOWN
/BEGIN NOTREACHED
/Filler at start of page
*0000
 7010
 7400
 7701
 0077
 1537
 7740
 0100
 0277
 7400
 3244
 0000
 1206
 3235
 7774
 0140
 0177
/END NOTREACHED
#endif
*0020
WORD0,	0000	/ Points to the loaded music
WORD,	0000	/ Points to the current note
NOTE0,	0000	/ Count of notes this music
NOTE,	0000
MASKF,	0037	/ Mask for note frequency
CONSTF,	NOTTBL
N0,	0000
#ifdef UNKNOWN
ONCNT,	0000	/ Count down with note pulse on
OFFNT,	0000	/ Count down with note pulse off
#endif
MASKA,	3000
AMP,	0000
MASKL,	0740	/ Mask for duration bits
CONSTL,	DURTBL
L0,	0000	/ Current note loop counter initial value
L,	0000	/ Current note loop counter

#ifdef UNKNOWN
CNTR,	7700	/TEMPO COUNTER
#else
CNTR,	7740	/TEMPO COUNTER
#endif
CNT,	0000
MASKD,	0001
DAMP0,	DAMPP
DAMP,	0000
#ifdef UNKNOWN
/BEGIN NOTREACHED
/Filler in unused gap
 0600
 0400
 0003
 0260
 0540
 0336
 4000
 0000
 0200
 0274
 0276
 7400
 0000
 7500
 0000
 0000
 0350
 0473
 0333
 0644
 0647
 0012
 7506
 1055
 1144
 7642
 1136
 2114
/END NOTREACHED
#endif
/
/
/
/
*0170
#ifdef UNKNOWN
DAMPP,	7776
	7774
#else
DAMPP,	7777
	7777
#endif
#ifdef UNKNOWN
/This table parallels DAMPP
	6010
	6070

/BEGIN NOTREACHED
/Filler to end of page
 7003
 2444
 7003
 7033
/END NOTREACHED
#endif
/
/
/
/
/
/
/
/
/NOTE FREQUENCIES
/
/
*0100
NOTTBL=.	/ Note table
#ifdef UNKNOWN
/These are generally scaled by a factor of 1.2X.
A1,	456
A1S,	435
A2,	227
A2S,	216
A3,	113
A3S,	106
B1,	417
	417
B2,	206
	206
B3,	103
C1,	376
C1S,	357
C2,	176
C2S,	167
C3,	77
C3S,	73
D1,	342
D1S,	325
D2,	161
D2S,	152
E1,	311
	311
E2,	144
F1,	276
F1S,	263
F2,	136
F2S,	131
G1,	251
G1S,	240
G2,	124
G2S,	117
#else
A1,	373
A1S,	355
A2,	175
A2S,	166
A3,	76
A3S,	72
B1,	337
	337
B2,	157
	157
B3,	67
C1,	323
C1S,	307
C2,	151
C2S,	143
C3,	64
C3S,	61
D1,	274
D1S,	261
D2,	135
D2S,	130
E1,	247
	247
E2,	123
F1,	236
F1S,	225
F2,	116
F2S,	112
G1,	214
G1S,	204
G2,	106
G2S,	102
#endif
#ifdef UNKNOWN
/BEGIN NOTREACHED
/Filler in unused gap
 1171
 7410
 1172
 3125
 3116
 5546
 0233
 1500
/END NOTREACHED
#endif
/
/
/NOTE LENGTHS
/
/
*0150
DURTBL=.	/ Duration table
#ifdef UNKNOWN
SCALEF=20
#else
SCALEF=1
#endif
SIXT,	0010^SCALEF
SIXT1,	0014^SCALEF
EIGHT,	0020^SCALEF
EIGHT1,	0030^SCALEF
QUART,	0040^SCALEF
QUART1,	0060^SCALEF
QUARTS,	0050^SCALEF
HALF,	0100^SCALEF
HALF1,	0140^SCALEF
HALFS,	0110^SCALEF
HALFE,	0120^SCALEF
WHOLE,	0200^SCALEF
WHOLE1,	0300^SCALEF
WHOLEQ,	0240^SCALEF
WHOLHQ,	0340^SCALEF
WHOLW,	0400^SCALEF
/
/
/
/
/
/
$
