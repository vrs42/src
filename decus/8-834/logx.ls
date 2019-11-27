
/  ALOG -- NATURAL LOG                SEP  5, 1975              PAGE  1

                /  FOR 23 BIT F. P. FORMAT
                /  WRITTEN BY
                /       PHILLIP SIEMENS
                /       LAWRENCE LIVERMORE LABS
                /       FEBRUARY 5, 1975
                /
                        ENTRY ALOG
 
      1400      OPDEF   TADI    1400
      3400      OPDEF   DCAI    3400
      5400      OPDEF   JMPI    5400
      7411      ABSYM   NMI     7411
      7421      ABSYM   MQL     7421
      7501      ABSYM   MQA     7501
      7441      ABSYM   SCA     7441
 
                LAP
 
0200  0000      X,      BLOCK 1
0201  0000      X1,     BLOCK 1
0202  0000      X2,     BLOCK 1
 
0203  0114      LGER,   0114            /"ALOG" ERROR AT LOC XXXX
0204  1707              1707
 
0205  6101      ALOG,   6101            /VERSION # -- ENTRY
0206  0003              0003            /EDIT #
0207  1205              TAD ALOG
0210  3211              DCA ALOG1       /GET CDF
0211  7402      ALOG1,    HLT           /CHANGE DF TO CALLING FIELD
0212  1606              TADI ALOG#      /GET DF OF ARG
0213  3225              DCA ALOG2
0214  2206              INC ALOG#       /BUMP POINTER
0215  7240              CLA CMA
0216  1606              TADI ALOG#      /GET ADDRESS OF ARG
0217  3010              DCA 10
0220  2206              INC ALOG#       /BUMP POINTER
0221  1377              TAD (17
0222  3011              DCA 11
0223  7346              CLA CMA CLL RTL /-3
0224  3211              DCA ALOG1
                POL2,
0225  7402      ALOG2,    HLT           /CHANGE DF TO ARG
0226  1410              TADI 10         /GET ARG
0227  6211              6211            /CHANGE DF TO FAC
0230  3411              DCAI 11         /PUT IN FAC
0231  2211              ISZ ALOG1       /MOVED ALL 3 WORDS?
0232  5225              JMP ALOG2       /NOT YET
 
                /  ARG IS NOW IN FAC
 
0233  1776              TADI (20
0234  7550              SPA SNA         /IS ARG 0 OR -?
0235  5331              JMP LGERR       /YES -- ERROR
0236  7240              CLA CMA
0237  1775              TADI (22
0240  3327              DCA TEM         /SAVE EXP-1
/  ALOG -- NATURAL LOG                SEP  5, 1975              PAGE  2

0241  1774              TADI (21        /MAKE 2*M-1
0242  7421              MQL
0243  1776              TADI (20
0244  0373              AND (1777       /THIS HAS EFFECT OF SUBRACTING 1
0245  7411              NMI             /NORMALIZE THE RESULT
0246  3200              DCA X
0247  7501              MQA
0250  3201              DCA X1
0251  7441              SCA
0252  7041              CIA
0253  7001              IAC             /THIS MULTIPLIES BY 2
0254  3202              DCA X2
0255  3776              DCAI (20        /CLEAR FAC
 
                / NOW EVALUATE THE SERIES EXPANSION
 
0256  1372              TAD (-10        /8 TERMS
0257  3225              DCA POL2
0260  1335              TAD ACOF
0261  3265      ARG2,   DCA ARG1#       /SET UP ADDR TO COEF.
0262  4033              CALL 1, FAD
0263  0102 06
0264  6201 05   ARG1,   ARG COF
0265  0336 01
0266  4033              CALL 1, FMP
0267  0103 06
0270  6201 05           ARG X
0271  0200 01
0272  1371              TAD (3          /GET A 3
0273  1265              TAD ARG1#
0274  2225              ISZ POL2
0275  5261              JMP ARG2        /MORE TERMS TO DO
0276  7200              CLA
0277  6211              TAD ACH         /PUT ALOG(M) IN X
0300  1776
0301  3200              DCA X
0302  1774              TAD ACM
0303  3201              DCA X1
0304  1775              TAD ACL
0305  3202              DCA X2
0306  3776              DCA ACH         /CLEAR FAC
0307  3774              DCA ACM
0310  3775              DCA ACL
0311  1327              TAD TEM         /GET EXP
0312  4033              CALL 0, FLOT    /FLOAT IT
0313  0004 06
0314  4033              CALL 1, FMP     /EXP * ALOG(2)
0315  0103 06
0316  6201 05           ARG LN2
0317  0366 01
0320  4033              CALL 1, FAD
0321  0102 06
0322  6201 05           ARG X           /EXP * ALOG(2) + ALOG(M) = ALOG(X)
0323  0200 01
0324  7326              CLA CLL CML RTL /2
0325  1205              TAD ALOG
0326  3327              DCA ALOG3
/  ALOG -- NATURAL LOG                SEP  5, 1975              PAGE  3

                TEM,
0327  7402      ALOG3,    HLT
0330  5606              JMPI ALOG#
 
0331  4033      LGERR,  CALL 1, ERROR   /FATAL ERROR
0332  0105 06
0333  6201 05           ARG LGER
0334  0203 01
0335  0336 01   ACOF,   COF
0336  4544      COF,    4544            / -6.4535442E-3
0337  1730              1730
0340  7771              7771
0341  2236              2236            / +3.6088494E-2
0342  4304              4304
0343  7774              7774
0344  4746              4746            / -9.5329390E-2
0345  0771              0771
0346  7775              7775
0347  2535              2535            / +1.6765407E-1
0350  3301              3301
0351  7776              7776
0352  4113              4113            / -2.4073380E-1
0353  7212              7212
0354  7776              7776
0355  2517              2517            / +3.3179902E-1
0356  0310              0310
0357  7777              7777
0360  4000              4000            / -4.9987412E-1
0361  4100              4100
0362  7777              7777
0363  3777              3777            / +9.9999644E-1
0364  7742              7742
0365  0000              0000
 
0366  2613      LN2,    2613            / LN 2.0000
0367  4414              4414
0370  0000              0000
0371  0003
0372  7770
0373  1777
0374  0021
0375  0022
0376  0020
0377  0017
                END
/  ALOG -- NATURAL LOG                SEP  5, 1975              PAGE  4

 
 
ACOF    0335
ALOG    0205EXT
ALOG1   0211
ALOG2   0225
ALOG3   0327
ARG1    0264
ARG2    0261
COF     0336
DCAI    3400OP
ERROR   0000EXT
FAD     0000EXT
FLOT    0000EXT
FMP     0000EXT
JMPI    5400OP
LGER    0203
LGERR   0331
LN2     0366
MQA     7501ABS
MQL     7421ABS
NMI     7411ABS
POL2    0225
SCA     7441ABS
TADI    1400OP
TEM     0327
X       0200
X1      0201
X2      0202
 
