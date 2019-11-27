
/  LBYT  --  SBYT                     SEP  5, 1975              PAGE  1

 
                /LBYT FUNCTION SUBROUTINE PROGRAMMED BY MIKE ALLEN
                /TO LOAD A BYTE OF LENGTH 'ARG3' FROM WORD 'ARG1' AND
                /STORE IN THE FIXED ACCUMULATOR, WHERE 'ARG2' IS POSITION
                /OF RIGHTMOST (LEAST SIGNIFICANT) BIT OF BYTE.
                /(NOTE: LEFTMOST BIT POSITION OF WORD IS ZERO.)
                /CALLING SEQUENCE:
                /       CALL 3,LBYT     /CALL SUBROUTINE
                /       ARG1            /INTEGER FROM WHICH BYTE IS TAKEN
                /       ARG2            /LEAST SIG. BIT POSITION OF BYTE
                /       ARG3            /BYTE LENGTH
 
                / MODIFIED BY PHILLIP SIEMENS
                /       LAWRENCE LIVERMORE LABORATORY
                /       SEPTEMBER 8, 1975
 
                /TO DEFINE NEW SYMBOLS FOR EAE
      7404      OPDEF   DVI 7404
      7411      OPDEF   NMI 7411
      7413      OPDEF   SHL 7413
      7415      OPDEF   ASR 7415
      7417      OPDEF   LSR 7417
      7421      OPDEF   MQL 7421
      7405      OPDEF   MUY 7405
      7501      OPDEF   MQA 7501
      7621      OPDEF   CAM 7621
      7441      OPDEF   SCA 7441
      5400      OPDEF   JMPI 5400
      1400      OPDEF   TADI 1400
      3400      OPDEF   DCAI 3400
 
                        ENTRY LBYT
                        ENTRY SBYT
/  LBYT  --  SBYT                     SEP  5, 1975              PAGE  2

0200  6140      LBYT,   6140
0201  0002              0002
0202  4241              JMS GETARG      /GET WORD CONTAINING BYTE
0203  7450              SNA             /IS IT ZERO?
0204  5234              JMP QUXIT       /YES. MAKE A QUICK EXIT
0205  3240              DCA KWORD       /NO. SAVE IT
0206  4241              JMS GETARG      /GET BIT POSITION OF LSB
0207  3212              DCA LFTADJ      /INITIALIZE SHIFT LEFT COMMAND
0210  1240              TAD KWORD       /GET WORD
0211  7433              MQL SHL         /PUT RIGHTMOST BIT IN AC11
0212  0000      LFTADJ, 0
0213  3240              DCA KWORD       /SAVE RIGHT-ADJUSTED BYTE
0214  4241              JMS GETARG      /GET BYTE LENGTH AND SUBTRACT ONE
0215  1377              TAD (-1
0216  7510              SPA             /LOGICAL OR LEGAL BYTE LENGTH?
0217  7240              CLA CMA
0220  3223              DCA MSKMOV      /PROBABLY OK
0221  7240              STA
0222  7433              MQL SHL         /POSITION MASK IN AC
0223  0000      MSKMOV, 0
0224  0240              AND KWORD       /MASK OFF UNWANTED BITS
0225  7421      XIT,    MQL             /SAVE AC
0226  7326              CLA CLL CML RTL /GET A 2
0227  1200              TAD LBYT
0230  3232              DCA XIT2
0231  7501              MQA             /GET AC BACK
0232  7402      XIT2,   HLT             /DO FAST EXIT
0233  5601              JMPI LBYT#
 
0234  1376      QUXIT,  TAD (4
0235  1201              TAD LBYT#
0236  3201              DCA LBYT#       /INCREMENT EXIT POINTER BY 4
0237  5225              JMP XIT
0240  0000      KWORD,  0               /HOLDS BYTE AFTER SHIFTING
 
0241  0000      GETARG, 0               /GET AN ARGUMENT
0242  1200              TAD LBYT
0243  3244              DCA GET1        /SET UP CDF TO FROM FIELD
0244  7402      GET1,   HLT             /CHANGE DF TO FROM FIELD
0245  1601              TADI LBYT#
0246  3253              DCA GET2        /SET UP CDF TO ARG FIELD
0247  2201              INC LBYT#       /BUMP POINTER
0250  1601              TADI LBYT#
0251  3232              DCA XIT2        /POINTER TO ARG
0252  2201              INC LBYT#       /BUMP POINTER
0253  7402      GET2,   HLT             /CHANGE DF TO ARG FIELD
0254  1632              TADI XIT2       /GET ARG
0255  5641              JMPI GETARG
/  LBYT  --  SBYT                     SEP  5, 1975              PAGE  3

                /SBYT SUBROUTINE
                /THIS SUBROUTINE WILL LOAD A BYTE FROM 'ARG4',
                /LEFT ADJUST BY 'ARG2' PLACES AND STORE IN 'ARG1',
                /WHERE 'ARG3' IS THE BYTE LENGTH
                /(NOTE: LEFTMOST BIT POSITION OF WORD IS ZERO).
                /CALLING SEQUENCE:
                /       CALL 4,SBYT     /CALL SUBROUTINE
                /       ARG1            /INTGER IN WHICH BYTE IS INSERTED
                /       ARG2            /BIT POSITIONS TO LEFT-ADJUST BYTE
                /       ARG3            /BYTE LENGTH
                /       ARG4            /RIGHT-ADJUSTED BYTE INTEGER
 
 
 
0256  0000      TEMARG, BLOCK 2
0257  0000
0260  6140      SBYT,   6140
0261  0002              0002
0262  1260              TAD SBYT        /MOVE POINTERS
0263  3200              DCA LBYT        /SO GETARG
0264  1261              TAD SBYT#       /CAN USE THEM
0265  3201              DCA LBYT#
0266  4241              JMS GETARG      /GET STORAGE WORD
0267  3256              DCA TEMARG      /SAVE IT
0270  3223              DCA MSKMOV      /CLEAR ZERO SHIFT FLAG
0271  1253              TAD GET2        /SAVE ARG FIELD
0272  3345              DCA SB2
0273  1232              TAD XIT2        /SAVE ARG POINTER
0274  3261              DCA SBYT#
0275  4241              JMS GETARG      /GET # OF RIGHT SHIFTS
0276  1377              TAD (-1
0277  7510              SPA             /SHIFT REQUIRED?
0300  5350              JMP NOSHFT      /NO. DON'T SHIFT THIS BYTE
0301  3304              DCA RSHIFT      /YES. INITIALIZE SHIFTING INSTR.
0302  1256              TAD TEMARG      /GET ORGINAL WORD
0303  7417              LSR             /RIGHT ADJUST BYTE POSITION
0304  0000      RSHIFT, 0
0305  3256              DCA TEMARG      /SAVE UPPER BITS
0306  7501              MQA             /GET LOW BITS
0307  3257              DCA TEMARG#     /SAVE THEM ALSO
0310  1304              TAD RSHIFT      /GET NUMBER OF SHIFTS DONE
0311  3344              DCA LSHIFT      /INIT SHIFT INSTR TO RESTORE WORD
0312  4241      THDARG, JMS GETARG      /GET # OF BITS IN BYTE
0313  1377              TAD (-1
0314  7510              SPA             /BYTE OF ZERO WIDTH?
0315  5353              JMP QXIT        /YES. EXIT QUICKLY
0316  3323              DCA MSKGEN      /NO. INITIALIZE MASK GENERATOR
0317  4241              JMS GETARG      /GET BYTE
0320  3260              DCA SBYT        /AND SAVE IT FOR LATER
0321  7240              STA             /SET AC=-1
0322  7433              MQL SHL         /GENERATE THE MASK
0323  0000      MSKGEN, 0
0324  3240              DCA KWORD       /SAVE IT
0325  1240              TAD KWORD       /GET IT AGAIN
0326  7040              CMA             /COMPLEMENT IT
0327  0256              AND TEMARG      /MASK OFF UNDESIRED BITS
0330  3256              DCA TEMARG      /SAVE IT AGAIN
/  LBYT  --  SBYT                     SEP  5, 1975              PAGE  4

0331  1223              TAD MSKMOV      /GET SHIFTING FLAG
0332  7104              CLL RAL         /INITIALIZE LINK
0333  7200              CLA
0334  1257              TAD TEMARG#     /GET LOW BITS OF ORIGINAL WORD
0335  7421              MQL             /RETURN THEM TO THE MQ
0336  1240              TAD KWORD       /GET MASK AGAIN
0337  0260              AND SBYT        /EXTRACT DESIRED BYTE
0340  1256              TAD TEMARG      /INSERT BYTE INTO ORGINAL WORD
0341  7430              SZL             /SHIFT THIS WORD TO RESTORE IT?
0342  5345              JMP LSHIFT#     /NO
0343  7413              SHL             /YES. REPOSITION WORD IN AC
0344  0000      LSHIFT, 0
0345  7402      SB2,    HLT             /SET TO ARG FIELD
0346  3661              DCAI SBYT#      /PUT ANSWER THERE
0347  5225              JMP XIT         /EXIT QUICK
 
0350  7240      NOSHFT, STA
0351  3223              DCA MSKMOV      /INITIALIZE ZERO SHIFT FLAG
0352  5312              JMP THDARG
0353  7200      QXIT,   CLA
0354  2201              INC LBYT#       /ADD 2 TO EXIT POINTER
0355  2201              INC LBYT#       /TO SKIP NEXT ARGUMENT
0356  5225              JMP XIT
0376  0004
0377  7777
                        END
/  LBYT  --  SBYT                     SEP  5, 1975              PAGE  5

 
 
ASR     7415OP
CAM     7621OP
DCAI    3400OP
DVI     7404OP
GETARG  0241
GET1    0244
GET2    0253
JMPI    5400OP
KWORD   0240
LBYT    0200EXT
LFTADJ  0212
LSHIFT  0344
LSR     7417OP
MQA     7501OP
MQL     7421OP
MSKGEN  0323
MSKMOV  0223
MUY     7405OP
NMI     7411OP
NOSHFT  0350
QUXIT   0234
QXIT    0353
RSHIFT  0304
SBYT    0260EXT
SB2     0345
SCA     7441OP
SHL     7413OP
TADI    1400OP
TEMARG  0256
THDARG  0312
XIT     0225
XIT2    0232
 
