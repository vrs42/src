
/  ATAN -- ARCTANGENT                 SEP  5, 1975              PAGE  1

                /  FOR 23 BIT F. P. FORMAT
                /  WRITTEN BY
                /       PHILLIP SIEMENS
                /       LAWRENCE LIVERMORE LABS
                /       AUGUST 26, 1975
                /
                / THE FOLLOWING IDENTITIES ARE USED:
                /   FOR ABS(X)>1, ATAN(X)=PI/2 - ATAN(1/X)
                /   FOR ABS(X)<.001, ATAN(X)=X
                /
                / A 6 TERM POLYNOMIAL IS USED TO APPROXIMATE THE ATAN
                / THERE ARE APPROXIMATELY 120 OCTAL LOCATIONS AVAILABLE
                / IN THIS SUBROUTINE.
 
                        ENTRY ATAN
 
      1400      OPDEF   TADI    1400
      3400      OPDEF   DCAI    3400
      5400      OPDEF   JMPI    5400
 
 
      0025      ABSYM   OPH     25
      0026      ABSYM   OPL     26
      0027      ABSYM   OPX     27
 
                LAP
 
0200  6140      ATAN,   6140            /VERSION #
0201  0004              0004            /EDIT #
0202  1200              TAD ATAN        /GET CALLING FIELD
0203  3204              DCA ATAN1
0204  7402      ATAN1,   HLT            /SET TO CALLING FIELD
0205  1601              TADI ATAN#      /GET CDF TO ARG
0206  3220              DCA ATAN2
0207  7240              CLA CMA
0210  2201              INC ATAN#
0211  1601              TADI ATAN#      /GET ADDRESS OF ARG
0212  3010              DCA 10          /SET UP POINTER TO ARG
0213  2201              INC ATAN#
0214  1377              TAD (17
0215  3011              DCA 11          /POINTER TO FAC
0216  7346              CLA CLL CMA RTL /GET -3
0217  3204              DCA ATAN1       /COUNTER FOR 3 WORDS
0220  7402      ATAN2,   HLT
0221  1410              TADI 10         /GET ARG WORD
0222  6211              6211
0223  3411              DCAI 11         /PUT IN FAC
0224  2204              ISZ ATAN1
0225  5220              JMP ATAN2
0226  1776              TADI (22        /GET EXPONENT
0227  7550              SPA SNA         /IS IT MINUS OR ZERO
0230  5306              JMP SIZOK       /YES
0231  1375              TAD (-1
0232  7640              SZA CLA         /EXP > 1
0233  5265              JMP BIGGER      /YES
0234  1774              TADI (20        /GET HI PART
0235  0373              AND (1777
/  ATAN -- ARCTANGENT                 SEP  5, 1975              PAGE  2

0236  7640              SZA CLA         / > 1?
0237  5265              JMP BIGGER      /YES
0240  1774              TADI (20        /GET SIGN
0241  7710              SPA CLA
0242  7040              CMA             /MINUS
0243  3204              DCA ATAN1       /REMEMBER THE SIGN
0244  1262              TAD PI2         /PUT PI/4 INTO FAC
0245  3774              DCAI (20
0246  1263              TAD PI2#
0247  3772              DCAI (21
0250  3776              DCAI (22
0251  2204              ISZ ATAN1       /MINUS?
0252  5255              JMP EXITO       /NO
0253  4033              CALL 0, CHS
0254  0002 06
0255  7326      EXITO,  CLA CLL CML RTL /2
0256  1200              TAD ATAN
0257  3260              DCA ATAN3
0260  7402      ATAN3,   HLT
0261  5601              JMPI ATAN#
 
0262  3110      PI2,    3110            /PI/2
0263  3755              3755
0264  0001              0001
 
0265  7240      BIGGER, CLA CMA
0266  3204              DCA ATAN1       /INDICATE X > 1
0267  1774              TADI (20        /MOVE X TO OP
0270  3025              DCA OPH
0271  1772              TADI (21
0272  3026              DCA OPL
0273  1776              TADI (22
0274  3027              DCA OPX
0275  7332              CLA CLL CML RTR /2000
0276  3774              DCAI (20        /SET FAC = 1
0277  3772              DCAI (21
0300  7001              IAC
0301  3776              DCAI (22
0302  4033              CALL 1, FDV     /GET FAC = 1/X
0303  0103 06
0304  6201 05           ARG OPH
0305  0025
 
0306  7300      SIZOK,  CLL CLA
0307  6211              TAD ACL         /GET EXPONENT
0310  1776
0311  7450              SNA             /IS IT ZERO?
0312  5771              JMP SEVAL       /YES
0313  1370              TAD (10
0314  7630              SZL CLA         /IS X SO SMALL, THAT ATAN(X)=X?
0315  5771              JMP SEVAL       /NO
0316  2204      SIZEA,  ISZ ATAN1       /WAS X > 1
0317  5255              JMP EXITO       /NO
0320  4033              CALL 0, CHS
0321  0002 06
0322  4033              CALL 1, FAD
0323  0104 06
/  ATAN -- ARCTANGENT                 SEP  5, 1975              PAGE  3

0324  6201 05           ARG PI2
0325  0262 01
0326  5255              JMP EXITO
 
0370  0010
0371  0400 01
0372  0021
0373  1777
0374  0020
0375  7777
0376  0022
0377  0017
                PAGE
 
0400  1777      SEVAL,  TADI (20        /SAVE X
0401  3304              DCA X
0402  1776              TADI (21
0403  3305              DCA X#
0404  1775              TADI (22
0405  3306              DCA EX
0406  4033              CALL 1, FMP     /MAKE X*X
0407  0105 06
0410  6201 05           ARG X
0411  0504 01
0412  6211              TAD ACH         /SAVE X SQUARED
0413  1777
0414  3307              DCA XX
0415  1776              TAD ACM
0416  3310              DCA XX#
0417  1775              TAD ACL
0420  3311              DCA EXX
0421  3777              DCA ACH
0422  3776              DCA ACM
0423  3775              DCA ACL
 
0424  1374              TAD (-6
0425  3255              DCA ACNT
0426  1256              TAD ACOF
0427  3233      ARG2,   DCA ARG1#
0430  4033              CALL 1, FAD
0431  0104 06
0432  6201 05   ARG1,   ARG COF
0433  0457 01
0434  4033              CALL 1, FMP
0435  0105 06
0436  6201 05           ARG XX
0437  0507 01
0440  1373              TAD (3
0441  1233              TAD ARG1#
0442  2255              ISZ ACNT
0443  5227              JMP ARG2
0444  4033              CALL 1, FAD
0445  0104 06
0446  6201 05           ARG ONE
0447  0501 01
0450  4033              CALL 1, FMP
0451  0105 06
/  ATAN -- ARCTANGENT                 SEP  5, 1975              PAGE  4

0452  6201 05           ARG X
0453  0504 01
0454  5772              JMP SIZEA
 
0455  0000      ACNT,   0
0456  0457 01   ACOF,   COF
 
0457  2001      COF,    2001            / .007825408
0460  5422              5422
0461  7772              7772
0462  5506              5506            /-.036898304
0463  7252              7252
0464  7774              7774
0465  2534              2534            / .083741056
0466  0067              0067
0467  7775              7775
0470  5657              5657            /-.134803712
0471  5412              5412
0472  7776              7776
0473  3134              3134            / .198798624
0474  4357              4357
0475  7776              7776
0476  5252              5252            /-.333263742
0477  7472              7472
0500  7777              7777
0501  3777      ONE,    3777            / .999999
0502  7767              7767
0503  0000              0000
0504  0000      X,      0
0505  0000              0
0506  0000      EX,     0
0507  0000      XX,     0
0510  0000              0
0511  0000      EXX,    0
 
0572  0316 01
0573  0003
0574  7772
0575  0022
0576  0021
0577  0020
                END
/  ATAN -- ARCTANGENT                 SEP  5, 1975              PAGE  5

 
 
ACNT    0455
ACOF    0456
ARG1    0432
ARG2    0427
ATAN    0200EXT
ATAN1   0204
ATAN2   0220
ATAN3   0260
BIGGER  0265
CHS     0000EXT
COF     0457
DCAI    3400OP
EX      0506
EXITO   0255
EXX     0511
FAD     0000EXT
FDV     0000EXT
FMP     0000EXT
JMPI    5400OP
ONE     0501
OPH     0025ABS
OPL     0026ABS
OPX     0027ABS
PI2     0262
SEVAL   0400
SIZEA   0316
SIZOK   0306
TADI    1400OP
X       0504
XX      0507
 
