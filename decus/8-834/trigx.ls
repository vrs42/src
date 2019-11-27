
/  SIN -- COS -- TAN                  AUG 28, 1975              PAGE  1

                /  WRITTEN BY
                /       PHILLIP SIEMENS
                /       LAWRENCE LIVERMORE LAB
                /       AUGUST 28, 1975
                /  FOR 23 BIT F. P. FORMAT
 
                        ENTRY   SIN
                        ENTRY   COS
                        ENTRY   TAN
 
      1400      OPDEF   TADI    1400
      3400      OPDEF   DCAI    3400
      5400      OPDEF   JMPI    5400
                                LAP
 
0200  0000      X,      BLOCK   1               /OVERLAP WITH COS ENTRY
 
0201  6140      COS,    6140                    /VERSION #
0202  0005              0005                    /EDIT #
0203  1201              TAD     COS             /SET UP SIN ENTRY FOR
0204  3237              DCA     SIN             /ARG FETCHING AND
0205  1202              TAD     COS#            /THE RETURN
0206  3240              DCA     SIN#
0207  7001              IAC                     /ENTER SIN WITH OFFSET
0210  5241              JMP     COSE
 
0211  0000      MFAC,   0                       /MOVE ARG TO FAC
0212  1237              TAD     SIN
0213  3214              DCA     SIN1
0214  7402      SIN1,   HLT
0215  1640              TADI    SIN#            /GET DF OF ARG
0216  3230              DCA     SIN2
0217  2240              INC     SIN#            /BUMP POINTER
0220  7240              CLA CMA
0221  1640              TADI    SIN#            /GET ADDRESS OF ARG
0222  3010              DCA     10
0223  2240              INC     SIN#            /BUMP POINTER
0224  7346              CLA CMA CLL RTL         /-3
0225  3255              DCA     CNT
0226  1377              TAD     (17
0227  3011              DCA     11
0230  7402      SIN2,     HLT                   /SET DF TO ARG
0231  1410              TADI    10              /GET ARG
0232  6211              6211                    /SET DF TO FAC
0233  3411              DCAI    11              /STORE IN FAC
0234  2255              ISZ     CNT
0235  5230              JMP     SIN2
0236  5611              JMPI    MFAC
 
0237  6140      SIN,    6140                    /VERSION #
0240  0005              0005                    /EDIT #
0241  3253      COSE,   DCA     QUADRT          /INITIALIZE QUADRANT
0242  7001              IAC
0243  3361              DCA     PIEX            /SET UP PI/2
0244  4266              JMS     NORM            /GET INTO RANGE
0245  1376      POLYEV, TAD     (-6
0246  4775              JMS     POL             /6 TERM POLYNOMIAL
/  SIN -- COS -- TAN                  AUG 28, 1975              PAGE  2

0247  0457 01             COF                   /ADDRESS OF TERMS
0250  7326      EX,     CLA CLL CML RTL         /FAST EXIT
0251  1237              TAD     SIN
0252  3253      EX3,    DCA     EX2
                QUADRT,
0253  7402      EX2,      HLT
0254  5640              JMPI    SIN#
 
                CNT,
0255  0000      STOX,   0                       /STORE FAC INTO X
0256  6211              TAD     ACH
0257  1774
0260  3200              DCA     X
0261  1773              TAD     ACM
0262  3201              DCA     COS
0263  1772              TAD     ACL
0264  3202              DCA     COS#
0265  5655              JMPI    STOX
 
0266  0000      NORM,   0                       /NORMALIZE INTO RANGE
0267  4211              JMS     MFAC            /GET ARG IN FAC
0270  4255              JMS     STOX            /SAVE FAC IN X
0271  4033              CALL 1, FDV             /DIVIDE BY PI/2
0272  0104 06
0273  6201 05           ARG     PIOVR2
0274  0357 01
0275  4033              CALL 0, FIX
0276  0005 06
0277  7450              SNA                     /IF ZERO, SAVE STEPS
0300  5347              JMP     SIN5
0301  3255              DCA     CNT             /SAVE IT
0302  1255              TAD     CNT
0303  4033              CALL 0, FLOT            /FLOAT IT
0304  0006 06
0305  4033              CALL 1, FMP             /MULTIPLY BY
0306  0107 06
0307  6201 05           ARG     PIOVR2          /PI/2
0310  0357 01
0311  4033              CALL 0, CHS
0312  0010 06
0313  4033              CALL 1, FAD             /SUBTRACT FROM X
0314  0111 06
0315  6201 05           ARG     X
0316  0200 01
0317  1253              TAD     QUADRT
0320  1255              TAD     CNT
0321  3253              DCA     QUADRT
0322  1200      SIN3,   TAD     X               /GET SIGN
0323  7700              SMA CLA                 /MINUS?
0324  5334              JMP     SIN4            /NO
0325  7240              CLA CMA
0326  1253              TAD     QUADRT
0327  3253              DCA     QUADRT
0330  4033              CALL 1, FAD
0331  0111 06
0332  6201 05           ARG     PIOVR2
0333  0357 01
/  SIN -- COS -- TAN                  AUG 28, 1975              PAGE  3

0334  1253      SIN4,   TAD     QUADRT          /FIND OUT WHAT QUAD.
0335  7012              RTR
0336  7700              SMA CLA
0337  5666              JMPI    NORM
0340  4033              CALL 0, CHS             /IF QUADRT = 2 OR 4
0341  0010 06
0342  4033              CALL 1, FAD             /MAKE FAC = PI/2 - FAC
0343  0111 06
0344  6201 05             ARG   PIOVR2
0345  0357 01
0346  5666              JMPI    NORM
 
0347  1200      SIN5,   TAD     X               /MOVE X TO FAC
0350  6211              DCA     ACH
0351  3774
0352  1201              TAD     COS
0353  3773              DCA     ACM
0354  1202              TAD     COS#
0355  3772              DCA     ACL
0356  5322              JMP     SIN3
 
0357  3110      PIOVR2, 3110                    /USED AS PI/2 AND PI/4
0360  3755              3755
                PIEX,
0361  6140      TAN,    6140                    /VERSION #
0362  0005              0005                    /EDIT #
0363  1361              TAD     TAN             /MOVE ENTRY
0364  3237              DCA     SIN
0365  1362              TAD     TAN#
0366  3240              DCA     SIN#
0367  3361              DCA     PIEX            /SET UP PI/4
0370  5771              JMP     TEVAL           /EVALUATE THE TAN SERIES
 
0371  0526 01
0372  0022
0373  0021
0374  0020
0375  0400 01
0376  7772
0377  0017
                PAGE
0400  0000      POL,    0                       /EVALUATE POLY.
0401  3220              DCA     CNT2            /# OF TERMS
0402  4777              JMS     STOX            /STORE FAC IN X
0403  4033              CALL 1, FMP             /SQUARE FAC
0404  0107 06
0405  6211                ARG   ACH
0406  0020
0407  6211              TAD     ACH             /PUT FAC IN XSQR
0410  1776
0411  3245              DCA     XSQR            /AND CLEAR FAC
0412  3776              DCA     ACH
0413  1775              TAD     ACM
0414  3246              DCA     XSQR#
0415  1774              TAD     ACL
0416  3247              DCA     XSQR1
0417  4045              JMS     45              /SET DF = CURRENT
/  SIN -- COS -- TAN                  AUG 28, 1975              PAGE  4

0420  0000      CNT2,   0
0421  1600              TADI    POL
0422  2200              ISZ     POL
0423  3227      ARG2,   DCA     ARG1#           /SET POINTER TO COEF.
0424  4033              CALL 1, FAD
0425  0111 06
0426  6201 05   ARG1,     ARG   COF
0427  0457 01
0430  2220              ISZ     CNT2            /MORE TERMS
0431  5250              JMP     POL1            /YES
0432  4033              CALL 1, FMP
0433  0107 06
0434  6201 05             ARG   X
0435  0200 01
0436  1773              TAD     QUADRT          /FIND OUT QUAD.
0437  7012              RTR
0440  7620              SNL     CLA
0441  5600              JMPI    POL
0442  4033              CALL 0, CHS             /NEGATE IF Q3, Q4
0443  0010 06
0444  5600              JMPI    POL
 
0445  0000      XSQR,   0
0446  0000              0
0447  0000      XSQR1,  0
 
0450  4033      POL1,   CALL 1, FMP
0451  0107 06
0452  6201 05             ARG   XSQR
0453  0445 01
0454  1372              TAD     (3
0455  1227              TAD     ARG1#           /UPDATE COEF. POINTER
0456  5223              JMP     ARG2
 
0457  4625      COF,    4625            /-0.0000000239
0460  4654              4654
0461  7747              7747
0462  2705              2705            / 0.0000027526
0463  6250              6250
0464  7756              7756
0465  4577              4577            /-0.000198409
0466  4777              4777
0467  7764              7764
0470  2104              2104            / 0.0083333315
0471  2103              2103
0472  7772              7772
0473  5252              5252            /-0.1666667
0474  5253              5253
0475  7776              7776
0476  2000              2000            / 1.0
0477  0000              0000
0500  0001              0001
 
0501  2337      TOEF,   2337            / 0.0095168091
0502  3062              3062
0503  7772              7772
0504  2760              2760            / 0.0029005250
/  SIN -- COS -- TAN                  AUG 28, 1975              PAGE  5

0505  5536              5536
0506  7770              7770
0507  3111              3111            / 0.024565090
0510  7135              7135
0511  7773              7773
0512  3324              3324            / 0.053374060
0513  7541              7541
0514  7774              7774
0515  2104              2104            / 0.13339240
0516  6002              6002
0517  7776              7776
0520  2525              2525            / 0.33333140
0521  2465              2465
0522  7777              7777
0523  2000              2000            / 1.00000000
0524  0000              0000
0525  0001              0001
 
0526  6201 05   TEVAL,  DCA     QUADRT
0527  3773
0530  4771              JMS     NORM
0531  7100              CLL
0532  6211              TAD     ACL     /GET EXPONENT
0533  1774
0534  7500              SMA             /IF POSITIVE, GO EVALUATE
0535  5341              JMP     TEVAL0  /THE SERIES
0536  1370              TAD     (10     /SKIP SERIES IF
0537  7620              SNL CLA         /EXPONENT IS LESS THAN -7
0540  5345              JMP     TEVAL1
0541  7200      TEVAL0, CLA
0542  1367              TAD     (-7
0543  4200              JMS     POL     /7 TERM SERIES
0544  0501 01             TOEF
0545  7240      TEVAL1, CLA CMA
0546  6201 05           TAD     QUADRT
0547  1773
0550  7012              RTR
0551  7630              SZL CLA
0552  5766              JMP     EX
0553  4777              JMS     STOX            /PUT FAC IN X
0554  7332              CLA CLL CML RTR         /LOAD FAC WITH 1
0555  3776              DCAI    (20
0556  7001              IAC
0557  3774              DCAI    (22
0560  3775              DCAI    (21
0561  4033              CALL 1, FDV
0562  0104 06
0563  6201 05             ARG   X
0564  0200 01
0565  5766              JMP     EX
 
0566  0250 01
0567  7771
0570  0010
0571  0266 01
0572  0003
0573  0253 01
/  SIN -- COS -- TAN                  AUG 28, 1975              PAGE  6

0574  0022
0575  0021
0576  0020
0577  0255 01
                END
/  SIN -- COS -- TAN                  AUG 28, 1975              PAGE  7

 
 
ARG1    0426
ARG2    0423
CHS     0000EXT
CNT     0255
CNT2    0420
COF     0457
COS     0201EXT
COSE    0241
DCAI    3400OP
EX      0250
EX2     0253
EX3     0252
FAD     0000EXT
FDV     0000EXT
FIX     0000EXT
FLOT    0000EXT
FMP     0000EXT
JMPI    5400OP
MFAC    0211
NORM    0266
PIEX    0361
PIOVR2  0357
POL     0400
POLYEV  0245
POL1    0450
QUADRT  0253
SIN     0237EXT
SIN1    0214
SIN2    0230
SIN3    0322
SIN4    0334
SIN5    0347
STOX    0255
TADI    1400OP
TAN     0361EXT
TEVAL   0526
TEVAL0  0541
TEVAL1  0545
TOEF    0501
X       0200
XSQR    0445
XSQR1   0447
 
