/DECUS 8-152A MUSIC CODING
/
#ifdef UNKNOWN
/VERSION ?.?
#else
/VERSION 1.2
#endif
/
/
/
/EDITOR PAGE 1
/
/
*0600
END,	0
	CLA 
	TAD TEMP
	TAD ARR		/ Got '$'?
	SZA
	JMP I END	/ No, return
	HLT		/ Yes, Halt
#ifdef UNKNOWN
	CLA CLL
#else
	JMS LEADER	/ Emit leader
#endif
	TAD ORGW	/ Emit Origin for WORKD0
	JMS ORIGIN
	TAD WORD0	/ Emit WORD0
	JMS PUNC
	TAD WORD0	/ No go there
	JMS ORIGIN
	TAD NLOOP	/ Negate loop counter
	CIA
	DCA NLOOP
	TAD LCO0	/ Reset LCO
	DCA LCO
	TAD LCC0	/ And LCC
	DCA LCC
	DCA NOTE0	/ Zero NOTE0 (total notes)
LOOP0,	TAD I LCC	/ Get word pointer
	CIA
	TAD I LCO	/ Subtract the end pointer
	DCA TEMP	/ ...to form (negative) Word count
	TAD TEMP	/ Add word count to total
	CIA
	TAD NOTE0
	DCA NOTE0
	TAD WORD0
	TAD I LCO
	DCA WORD
LOOP1,	TAD I WORD	/ Get a word
	JMS PUNC	/ ...and punch it
	CLA CLL 
	ISZ WORD	/ Point to next word
	ISZ TEMP	/ Done?
	JMP LOOP1	/ No, go again
	ISZ LCO		/ Point to next block start
	ISZ LCC		/ Point to next block end
	ISZ NLOOP	/ All blocks done?
	JMP LOOP0	/ No, go again
	TAD ORGN	/ Get NOTE0 origin
	JMS ORIGIN	/ ...and punch it
	TAD NOTE0	/ Punch NOTE0 contents
	JMS PUNC
	JMS PUNC	/ Punch 0000
#ifdef UNKNOWN
	HLT
#else
	JMP CKSUM	/ ...and go emit checksum
#endif
PUNCH,	0
#ifndef UNKNOWN
	TLS		/ Punch the byte
	TSF 
#else
	PLS		/ Punch the byte
	PSF 
#endif
	JMP .-1
#ifndef UNKNOWN
	TAD CHKSUM	/ Add it to the checksum
	DCA CHKSUM
#endif
	CLA 
	JMP I PUNCH
FIX,	0		/ Shift right six bits
	RTR 
	RTR 
	RTR 
	AND MASK	/ Mask for 6 bits
	JMP I FIX
ORIGIN,	0
	DCA TA		/ Store the word
	TAD TA
	JMS FIX		/ Punch high byte
	TAD ORG		/ ...with 0100 set
	JMS PUNCH
	TAD TA		/ Punch low byte
	AND MASK
	JMS PUNCH
	JMP I ORIGIN
PUNC,	0
	DCA TA		/ Store the word
	TAD TA
	JMS FIX		/ Punch high byte
	JMS PUNCH
	TAD TA
	AND MASK	/ Punch low byte
	JMS PUNCH
	JMP I PUNC
ARR,	0244		/ '$'
ORGW,	0020
ORGN,	0022
MASK,	0077
ORG,	0100
#ifndef UNKNOWN
/ Leader/trailer and working checksums are a V1.2 thing.
LEADER,	0000
	CLA CLL 
	TAD M30		/ Emit some leader/trailer
	DCA T1
	TAD P200
	JMS PUNCH
	ISZ T1
	JMP .-3
	CLA CLL 
	DCA CHKSUM	/ Set new checksum to 0000
	JMP I LEADER
M30,	-30
T1,	0000
P200,	0200
CKSUM,	TAD CHKSUM	/ Get checksum
	JMS PUNC	/ ...and punch it
	JMS LEADER	/ Emit trailer
	HLT		/ We are done
CHKSUM,	0000
#else
/BEGIN NOTREACHED
/ Filler for the rest of the page, to match the 
/ original tape, which apparently dumped whole pages.
 4450
 4502
 0033
 1354
 4503
 5325
 4502
 0040
 1354
 4503
 5301
 4510
 2176
 5244
 1177
 7640
 5423
 2177
 3175
 3122
 1054
 3131
 5512
 0416
 7041
 7500
 4147
 3125
 1125
 7001
 1172
 7710
 4147
 1160
 5372
 1523
 7440
 3123
 2125
 5370
 1123
 5754
 1102
/END NOTREACHED
#endif
/
/
/
*0020
WORD0,	1000
WORD,	0
NOTE0,	0
CNT,	0	/ Rest flag
RB,	0377	/ RUBOUT
LF0,	0212	/ LF
CR,	0215	/ CR
AST,	0252	/ '*'
SP,	0240	/ ' '
TEMP,	0
LEN0,	0
FREQ0,	0000
TA,	0000
BRA,	0257	/ '/'
SS0,	0044	/ 'S'-'/'
AA0,	0301	/ 'A'
RR0,	0013
AMP0,	0000
LL0,	0261	/ '1'
ASTI,	ASTK
ENDI,	END
LENI,	LEN
MASKL,	0003
CORR,	260	/ '0'
UPARRI,	UPARR
UPA,	336	/ '^'
DAMP,	4000
DAMP0,	0
FREQI,	FREQ
OBR0,	0274	/ '<'
CBR0,	0276	/ '>'
LCO0,	7400	/ Base of the OBR table
LCO,	0
LCC0,	7500	/ Base of the CBR tablr
LCC,	0
NLOOP,	0
OBRI,	OBR
CBRI,	CBR
READI,	READ
#ifdef UNKNOWN
/BEGIN NOTREACHED
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
/EDITOR PAGE 2
/
/
*0100
	CLA CLL
	RFC
	TAD WORD0	/ Set up buffer pointer
	DCA WORD
	DCA NOTE0	/ Zero note count
	DCA NLOOP	/ Zero number of blocks
START,	JMS ACCEPT	/ Get a character
	JMS I ASTI	/ Store and go again unless '*'
	JMS I ENDI	/ Punch the output if '$'
P00111,	JMS I OBRI	/ Handle '<'
	JMS I CBRI	/ Handle '>'
	JMS I UPARRI	/ Handle '^'
	JMS I FREQI
	JMP START
ACCEPT,	0000
	CLA CLL 	/ Get a character
	RSF 
	JMP .-1
#ifdef UNKNOWN
	RRB
	RFC 
#else
	RRB RFC 
#endif
	CIA		/ Negate and save it
	DCA TEMP
	TAD TEMP
	JMP I ACCEPT	/ ... also return it
#ifdef UNKNOWN
/BEGIN NOTREACHED
/ Filler for the rest of the page, to match the 
/ original tape.
 0000
 3200
 1054
 3131
 3172
 3171
 3170
 5423
 1171
 7410
 1172
 3125
 3116
 5546
 0233
 1500
 7600
 1007
 4476
 5452
 1177
 5501
 1211
 7560
 0170
 6026
 7777
 0000
 2200
 4564
 0255
 0004
 0000
 7003
 0015
 0000
 7003
 2444
 7003
 7033
/END NOTREACHED
#endif
/
/
*0200
FREQ,	0000		/ Character should indicate a frequency
	CLA CLL 
	TAD TEMP	/ Get character
	TAD AA0		/ 'A'?
	SNA 
	JMP AA
	IAC		/ 'B'?
	SNA 
	JMP BB
	IAC		/ 'C'?
	SNA 
	JMP CC
	IAC		/ 'D'?
	SNA 
	JMP DD
	IAC		/ 'E'?
	SNA 
	JMP EE
	IAC		/ 'F'?
	SNA 
	JMP FF
	IAC		/ 'G'?
	SNA 
	JMP GG
	TAD RR0		/ 'R'?
	SNA 
	JMP RR
	JMP I FREQ	/ Unknown, return
AA,	CLA CLL 
	DCA FREQ0	/ Set up 'A' (baseline)
	JMP FINF
BB,	TAD B		/ Set up 'B'
	DCA FREQ0
	JMP FINF
CC,	TAD C		/ Set up 'C'
	DCA FREQ0
	JMP FINF
DD,	TAD D		/ Set up 'D'
	DCA FREQ0
	JMP FINF
EE,	TAD E		/ Set up 'E'
	DCA FREQ0
	JMP FINF
FF,	TAD F		/ Set up 'F'
	DCA FREQ0
	JMP FINF
GG,	TAD G		/ Set up 'G'
	DCA FREQ0
	JMP FINF
RR,	TAD AMP0	/ TA = AMP0
	DCA TA
	DCA AMP0	/ AMP0 = 0
	DCA FREQ0	/ Set FREQ0
	CLA CMA 	/ Set REST flag
	DCA CNT
	ISZ NOTE0	/ One more note
	ISZ WORD	/ Bump buffer pointer
	JMP I LENI	/ Go get duration
	/ Common wrap-up for notes.
FINF,	ISZ NOTE0	/ One more note
	ISZ WORD	/ Bump buffer pointer
	JMS ACCEPT	/ Get another character
	TAD LL0		/ '1'?
	SNA 
	JMP FINF1	/ Yes, have FREQ0
	IAC		/ '2'?
	SNA 
	JMP TW		/ Yes, set up 2
	IAC		/ '3'?
	SNA 
	JMP TH		/ Yes, set up 3
	JMP FINF	/ No, try again (bug here?)
TW,	TAD FREQ0	/ Set up frequency + TWO
	TAD TWO
	DCA FREQ0
	JMP FINF1
TH,	TAD FREQ0	/ Set up frequency + THREE
	TAD THREE
	DCA FREQ0
	/ Wrap-up after half/quarter
FINF1,	JMS ACCEPT	/ Get another character
	TAD BRA		/ '/'?
	SNA 
	JMP FINFS	/ Yes, go get duration
	TAD SS0		/ No, 'S'?
	SNA
	JMP SS		/ Yes, go increment
	JMP FINF1	/ No, skip it
SS,	TAD FREQ0	/ Bump FREQ0
	IAC
	DCA FREQ0
	JMP FINF1	/ And look for another '/'
FINFS,	JMP I LENI	/ Have FREQ0, Go get duration
READ,	0000
	CLA 
	JMS ACCEPT	/ Get next character
	TAD CORR	/ Subtract '0'
	CIA		/ Get first digit 
	CLL RTL 	/ (octal)
	RAL 
	DCA TA		/ Save it
	JMS ACCEPT	/ Get next character
	TAD CORR	/ Subtract '0'
	CIA		/ Get second digit
	TAD TA		/ Add it in
	JMP I READ	/ Return octal value
OBR,	0000
	CLA CLL 
	TAD TEMP	/ Get character
	TAD OBR0	/ 274 '<'?
	SZA 
	JMP I OBR	/ Nope, bail
	JMS READ	/ Yes, read octal number
	TAD LCO0	/ Add LCO table base
	DCA LCO		/ Set LCO origin
	TAD NOTE0	/ Store note count + 1
	IAC
	DCA I LCO	/ in the OBR table
	JMP START	/ ... and keep going
B,	6
C,	13
D,	21
E,	25
F,	30
G,	34
TWO,	2
#ifndef UNKNOWN
THREE,	3
#else
THREE,	4	/ BUGBUG
/BEGIN NOTREACHED
/ Filler for the rest of the page, to match the 
/ original tape.
 0644
 1271
 1225
/END NOTREACHED
#endif
/
/
/
/

/EDITOR PAGE 3
/
*0400
LEN,	JMS ACCEPT	/ Get a character
	TAD EI0		/ 'E'?
	SNA 
	JMP EI
	TAD HA0		/ 'H'?
	SNA 
	JMP HA
	TAD QA0		/ 'Q'?
	SNA 
	JMP QA
	TAD SI0		/ 'S'?
	SNA 
	JMP SI
	TAD WH0		/ 'W'?
	SNA 
	JMP WH
	JMP LEN		/ Other, try again
EI,	TAD ET		/ Set 'E' length
	DCA LEN0
	JMP FINL
HA,	TAD H0		/ Set 'H' length
	DCA LEN0
	JMP FINL
QA,	TAD Q		/ Set 'Q' length
	DCA LEN0
	JMP FINL
SI,	CLA CLL 	/ Set 'S' length (baseline)
	DCA LEN0
	JMP FINL
WH,	TAD W		/ Set 'W' length
	DCA LEN0
	JMP FINL
	/ Common length wrap-up
FINL,	JMS ACCEPT	/ Get a character
	TAD DOT0	/ Is it '.'?
	SNA 
	JMP DOT		/ Yes
	IAC		/ Is it '/'?
	SNA 
	JMP FINL1	/ Yes, we are done
	JMP FINL	/ No, try again
DOT,	TAD LEN0	/ Bump LEN0
	IAC
	DCA LEN0
	JMP FINL	/ ... and go again
	/ Got all the dots.
FINL1,	TAD LEN0	/ How many dots?
	CLL RTL 	/ Move to high bits
	RTL 
	RAL 
	TAD AMP0	/ Add in AMP0
/
/VRS: The stuff below is missing from the write-up.
	TAD FREQ0	/ Add in FREQ0
	TAD DAMP0	/ and DAMP0
	DCA I WORD	/ Store the assembled word!
	ISZ CNT		/ Doing a rest?
	JMP .+3		/ No, don't reset AMP0
	TAD TA		/ AMP0 = TA
	DCA AMP0
	DCA CNT		/ No longer doing a REST
	DCA DAMP0	/ Clear DAMP0
	JMP START	/ and keep going

CBR,	0
	CLA CLL
	TAD TEMP	/ Get character
	TAD CBR0	/ 276 '>'?
	SZA
	JMP I CBR	/ No, bail
	JMS I READI	/ Yes, read octal number
	TAD LCC0	/ Add LCC table base
	DCA LCC		/ Reset LCC origin
	TAD NOTE0	/ Store note count + 1
	IAC
	DCA I LCC	/ in the CBR table
	ISZ NLOOP	/ Bump number of segments
	JMP START	/ and keep going

ASTK,	0
	CLA CLL
	TAD TEMP	/ Character == '*'?
	TAD AST
	SZA
	JMP I ASTK	/ No, return
	JMS ACCEPT	/ Yes, get next character
	CIA
	AND MASKL	/ Mask for bottom 2 bits
	CLL RTR		/ Shift to bits 1-2
	RTR
	DCA AMP0	/ Store as AMP0
	JMP START	/ ... and keep going

EI0,	305		/ 'E'
HA0,	3		/ 'H'-'E'
QA0,	11		/ 'Q'-'H'
SI0,	2		/ 'S'-'Q'
WH0,	4		/ 'W'-'S'
ET,	2
H0,	7
Q,	4
W,	13
DOT0,	256		/ '.'

UPARR,	0
	CLA CLL
	TAD TEMP	/ Get character
	TAD UPA		/ 336 '^'?
	SZA
	JMP I UPARR	/ No, bail
	TAD DAMP	/ Yes, set new DAMP0
	DCA DAMP0
	JMP START	/ ... and keep going
#ifdef UNKNOWN
/BEGIN NOTREACHED
/ Filler for the rest of the page, to match the 
/ original tape.
 7012
 5356
 7040
 3120
 1147
 0003
 3272
 1272
 1002
 7650
 5741
 2341
 1272
 1005
 5741
 1423
 7700
 1036
 4476
 5423
 1454
 0425
 0570

*0000
/ Filler for the beginning of the page, to match the 
/ original tape.
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
$
