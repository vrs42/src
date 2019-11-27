
/  EAE MODE A INTEGER ROUTINES        SEP  5, 1975              PAGE  1

                / 8K FORTRAN INTEGER MATH PACKAGE FOR EAE
                / V1            8/18/71         PHIL SIEMENS
 
                        ENTRY   IREM
                        ENTRY   IABS
                        ENTRY   DIV
                        ENTRY   MPY
                        ENTRY   IRDSW
                        ENTRY   CLEAR
                        ENTRY   SUBSC
 
      6034              OPDEF   KRS     6034
      1400              OPDEF   TADI    1400
      3400              OPDEF   DCAI    3400
      4400              OPDEF   JMSI    4400
      5400              OPDEF   JMPI    5400
      7421              OPDEF   MQL     7421
      7501              OPDEF   MQA     7501
      7407              OPDEF   DVI     7407
      7405              OPDEF   MUY     7405
 
                        LAP
 
/  EAE MODE A INTEGER ROUTINES        SEP  5, 1975              PAGE  2

 
                / MULTIPLY ROUTINE
                /IN THE FOLLOWING PROGRAM, THE EAE MULTIPLY ROUTINE
                /RUNS FASTER THAN THE STANDARD BY A FACTOR OF 2.75.
 
                /       DO 10  I=1,10
                /       DO 10  J=1,200
                / 10    N=I*J
 
                /NUMBER OF CYCLES REQUIRED
                / 40 CYCLES + MULT. TIME + CALL TIME
                / 60 + 7.2 + 121 = 188 USEC FOR PDP-8/I
 
0200  6140      MPY,    6140            /INTEGER MULTIPLY ROUTINE
0201  0002              0002
0202  3217              DCA     MQ      /AC TO MQ
0203  1200              TAD     MPY     /GET CDF TO ARG LIST
0204  3205              DCA     MPY1    /PUT IN LINE
0205  7000      MPY1,   NOP             /BECOMES CDF TO ARGS
0206  1601              TADI    MPY#    /GET FIELD OF MULTIPLIER
0207  2201              INC     MPY#
0210  3214              DCA     MPY2    /PUT IN LINE
0211  1601              TADI    MPY#    /GET ADDRESS OF MULTIPLIER
0212  2201              INC     MPY#
0213  3226              DCA     DIV
0214  7000      MPY2,   NOP             /BECOMES CDF TO MULTIPLIER
0215  1626              TADI    DIV     /GET MULTIPLIER
0216  7425              MQL MUY         /MULTIPLY
0217  0000      MQ,     0
0220  7326              CLA CLL CML RTL
0221  1200              TAD     MPY
0222  3224              DCA MPY3        /CDF CIF FOR FAST RETURN
0223  7501              MQA
0224  7000      MPY3,   NOP
0225  5601              JMPI    MPY#
/  EAE MODE A INTEGER ROUTINES        SEP  5, 1975              PAGE  3

 
                / DIVIDE ROUTINE
                /IN THE FOLLOWING EXAMPLE, THE EAE DIVIDE ROUTINE
                /RUNS FASTER THAN THE STANDARD BY A FACTOR OF 3.2.
 
                /       DO 10  I=1,10
                /       DO 10  J=1,200
                / 10    N=J/I
 
                /NUMBER OF CYCLES REQUIRED
                / 57 + DVI TIME + CALL TIME
                / 85 + 8 + 121 = 214 USEC FOR PDP-8/I
 
0226  6140      DIV,    6140            /INTEGER DIVIDE SUBROUTINE
0227  0002              0002
0230  7100              CLL
0231  7510              SPA             /IS DIVIDEND POSITIVE?
0232  7061              CML CIA         /NO
0233  7421              MQL             /LOAD MQ REGISTER
0234  1226              TAD     DIV     /GET FIELD OF ARGS
0235  3236              DCA     DIV1    /PUT IN LINE
0236  7000      DIV1,   NOP             /BECOMES CDF TO ARGS
0237  1627              TADI    DIV#    /GET FIELD OF DIVISOR
0240  2227              INC     DIV#
0241  3245              DCA     DIV2    /PUT IN LINE
0242  1627              TADI    DIV#    /GET ADDRESS OF DIVISOR
0243  2227              INC     DIV#
0244  3200              DCA     MPY
0245  7000      DIV2,   NOP             /BECOMES CDF TO DIVISOR
0246  1600              TADI    MPY     /GET DIVISOR
0247  7450              SNA             /IS DIVISOR ZERO?
0250  5306              JMP DIVZ        /YES
0251  7510              SPA             /IS DIVISOR POSITIVE
0252  7041              CIA CMA         /NO
0253  3261              DCA     DV
0254  7420              SNL             /WILL QUOTIENT BE NEGATIVE?
0255  7040              CMA             /NO
0256  7100              CLL
0257  3200              DCA     MPY     /SET SIGN INDICATOR
0260  7407              DVI             /DIVIDE
0261  0001      DV,      1
0262  3273              DCA     SAV     /SAVE REMAINDER
0263  7326              CLA CLL CML RTL
0264  1226              TAD     DIV
0265  3271              DCA     DIV3
0266  7501              MQA
0267  2200              ISZ     MPY     /CHECK SIGN
0270  7041              CIA             /MAKE QUOTIENT NEGATIVE
0271  7000      DIV3,   NOP
0272  5627              JMPI    DIV#
/  EAE MODE A INTEGER ROUTINES        SEP  5, 1975              PAGE  4

0273  0000      SAV,    BLOCK 1         /REMAINDER FROM LAST DIVISION
0274  6140      IREM,   6140            /INTEGER REMAINDER FUNCTION
0275  0002              0002
0276  2275              INC     IREM#
0277  2275              INC     IREM#
0300  7326              CLA CLL CML RTL
0301  1274              TAD     IREM
0302  3304              DCA     IREM1
0303  1273              TAD     SAV
0304  7000      IREM1,  NOP
0305  5675              JMPI    IREM#
                / NOTE:  THIS FAST RETURN METHOD SAVES APPROX 90 USEC
 
0306  4033      DIVZ,   CALL 1, ERROR   /ZERO DIVIDE ERROR
0307  0110 06
0310  6201 05           ARG     DVERR
0311  0315 01
0312  7350              CLA CLL CMA RAR
0313  4040              RETRN   DIV
0314  0003 06
0315  4411      DVERR,  4411
0316  2632              2632
 
0317  6140      IABS,   6140            /INTEGER ABS VALUE FUNCTION
0320  0002              0002
0321  1317              TAD     IABS    /GET FIELD OF ARGS
0322  3323              DCA     IAB1
0323  7000      IAB1,   NOP             /BECOMES CDF TO ARGS
0324  1720              TADI    IABS#   /GET FIELD OF ARG
0325  2320              INC     IABS#
0326  3332              DCA     IAB2
0327  1720              TADI    IABS#   /GET ADDRESS OF ARG
0330  2320              INC     IABS#
0331  3345              DCA     IRDSW
0332  7000      IAB2,   NOP
0333  1745              TADI    IRDSW   /GET ARG
0334  7510              SPA
0335  7041              CIA
0336  3345              DCA     IRDSW
0337  7326              CLA CLL CML RTL
0340  1317              TAD     IABS
0341  3343              DCA     IAB3
0342  1345              TAD     IRDSW
0343  7000      IAB3,   NOP
0344  5720              JMPI    IABS#
0345  6140      IRDSW,  6140            /READ SR FUNCTION
0346  0002              0002
0347  2346              INC     IRDSW#
0350  2346              INC     IRDSW#
0351  7326              CLA CLL CML RTL
0352  1345              TAD     IRDSW
0353  3355              DCA     IRD1
0354  7404              OSR
0355  7000      IRD1,   NOP
0356  5746              JMPI    IRDSW#
                PAGE
/  EAE MODE A INTEGER ROUTINES        SEP  5, 1975              PAGE  5

                / THE FLOATING POINT CLEAR SUBROUTINE WAS ADDED TO INTEGR
                / SO THAT PROGRAMS WHICH DO NOT USE FLOATING POINT MATH
                / CAN RUN WITHOUT LOADING THE F.P. MATH PACKAGE.
 
0400  6140      CLEAR,  6140
0401  0002              0002
0402  7421              MQL
0403  6211              DCA     ACH
0404  3777
0405  3776              DCA     ACM
0406  3775              DCA     ACL
0407  7501              MQA
0410  4040              RETRN   CLEAR
0411  0006 06
 
                / THE FOLLOWING CAN BE USED FOR DOUBLY OR SINGLY
                / SUBSCRIPTED ARRAYS.  ON ENTRY THE AC SHOULD BE
                / NEGATIVE FOR FLOATING POINT VARIABLES.  THIS MAY
                / BE ANY NEGATIVE NUMBER FOR SINGLY SUBSCRIPTED
                / VARIABLES, AND MUST BE THE FIRST DIMENSION FOR
                / DOUBLY SUBSCRIPTED VARIABLES.
 
 
0412  0000      S1,     BLOCK 1         /ADDR OF FIRST SUBSC
0413  0000      S2,     BLOCK 1         /ADDR OF SECOND SUBSC
0414  0000      A,      BLOCK 2         /ADDR OF ARRAY
0415  0000
0416  0000      R,      BLOCK 1         /ADDR FOR RESULT
0417  0000      TM,     0
0420  0000      FL,     0               /DOUBLE SUBSC FLAG
0421  0000      N,      0               /DIMENSION -- NEGATIVE IF FLOATING
 
0422  6140      SUBSC,  6140
0423  0002              0002
0424  3221              DCA     N       /SAVE THE DIMENSION
0425  1221              TAD     N
0426  7510              SPA
0427  7040              CMA
0430  3324              DCA     MQ2     /MULTIPLIER
0431  7344              CLA CLL CMA RAL /-2
0432  1223              TAD     SUBSC#
0433  3010              DCA     10      /SET AUTO INDEXING POINTER
0434  1222              TAD     SUBSC   /GET FIELD OF ARGS
0435  3236              DCA     SUB1
0436  7000      SUB1,   NOP             /BECOMES CDF TO ARGS
0437  1410              TADI    10      /GET NUMBER OF ARGS
0440  0374              AND     (100
0441  7650              SNA CLA         /DOUBLE SUBSC?
0442  5250              JMP     SB0
0443  1410              TADI    10      /YES -- GET FIELD OF 2ND SUB
0444  3273              DCA     SB2
0445  1410              TADI    10      /GET ADDR OF 2ND SUB
0446  3213              DCA S2
0447  7040              CMA
0450  3220      SB0,    DCA     FL      /SET DOUBLE SUB FLAG
0451  1410              TADI    10      /GET FIELD OF SUB
0452  3277              DCA     SB1
/  EAE MODE A INTEGER ROUTINES        SEP  5, 1975              PAGE  6

0453  1410              TADI    10      /GET ADDR OF SUB
0454  3212              DCA      S1
0455  1410              TADI    10
0456  3214              DCA     A       /FIELD OF ARRAY
0457  1410              TADI    10
0460  3215              DCA     A#      /ADDR OF ARRAY
0461  1222              TAD     SUBSC
0462  3303              DCA     SUB2
0463  1410              TADI    10      /ADDR OF RESULT
0464  3216              DCA     R
0465  1010              TAD     10
0466  7001              IAC
0467  3223              DCA     SUBSC#
0470  2220              ISZ     FL      /DBL SUBS
0471  5277              JMP     SB1
0472  7240              CLA CMA         /GET 2ND SUBSC
0473  7000      SB2,    NOP             /CDF TO FIELD OF 2ND SUBSC
0474  1613              TADI    S2
0475  7440              SZA             /IS IT A 1?
0476  5323              JMP MQ1
0477  7000      SB1,    NOP             /CDF TO FIELD OF 1ST SUBSC
0500  1612              TADI    S1
0501  1373              TAD     (-1
0502  3217              DCA     TM
0503  7000      SUB2,   NOP
0504  1214              TAD     A
0505  3616              DCAI    R
0506  2216              INC     R
0507  1221              TAD     N
0510  7710              SPA CLA         /FIXED OR FLOATING?
0511  1217              TAD     TM
0512  7104              CLL RAL
0513  1217              TAD     TM
0514  1215              TAD     A#
0515  3616              DCAI    R
0516  7326              STL CLA RTL
0517  1222              TAD     SUBSC
0520  3321              DCA     SUB3
0521  7000      SUB3,   NOP
0522  5623              JMPI    SUBSC#
 
0523  7425      MQ1,    MQL MUY
0524  0000      MQ2,    0
0525  7701              CLA MQA
0526  5277              JMP     SB1
 
0573  7777
0574  0100
0575  0022
0576  0021
0577  0020
                END
/  EAE MODE A INTEGER ROUTINES        SEP  5, 1975              PAGE  7

 
 
A       0414
CLEAR   0400EXT
DCAI    3400OP
DIV     0226EXT
DIVZ    0306
DIV1    0236
DIV2    0245
DIV3    0271
DV      0261
DVERR   0315
DVI     7407OP
ERROR   0000EXT
FL      0420
IABS    0317EXT
IAB1    0323
IAB2    0332
IAB3    0343
IRDSW   0345EXT
IRD1    0355
IREM    0274EXT
IREM1   0304
JMPI    5400OP
JMSI    4400OP
KRS     6034OP
MPY     0200EXT
MPY1    0205
MPY2    0214
MPY3    0224
MQ      0217
MQA     7501OP
MQL     7421OP
MQ1     0523
MQ2     0524
MUY     7405OP
N       0421
R       0416
SAV     0273
SB0     0450
SB1     0477
SB2     0473
SUBSC   0422EXT
SUB1    0436
SUB2    0503
SUB3    0521
S1      0412
S2      0413
TADI    1400OP
TM      0417
 
