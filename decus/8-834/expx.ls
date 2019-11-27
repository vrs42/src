
/  EXP -- EXPONENTIATION              SEP  4, 1975              PAGE  1

                /  FOR 23 BIT F. P. FORMAT
                /  WRITTEN BY
                /       PHILLIP SIEMENS
                /       LAWRENCE LIVERMORE LABS
                /       FEBRUARY 7, 1975
 
                /  USES A 7 TERM CHEBYCHEV POLYNOMIAL APPROX.
 
                        ENTRY   EXP
 
      1400      OPDEF   TADI    1400
      3400      OPDEF   DCAI    3400
      5400      OPDEF   JMPI    5400
 
                        LAP
 
0200  0000      X,      0
0201  0000      X1,     0
                X2,                             /OVERLAP WITH EXP ENTRY
 
0202  6140      EXP,    6140                    /VERSION NUMBER
0203  0003              0003                    /EDIT #
0204  1202              TAD     EXP
0205  3206              DCA     EXP1            /GET CDF
                SIGN,
0206  7402      EXP1,     HLT                   /CHANGE DF TO CALLING FIELD
0207  1603              TADI    EXP#            /GET DF OF ARG
0210  3225              DCA     EXP2
0211  2203              INC     EXP#            /BUMP POINTER
0212  7240              CLA CMA
0213  1603              TADI    EXP#            /GET ADDRESS OF ARG
0214  3010              DCA     10
0215  2203              INC     EXP#            /BUMP POINTER
0216  7326              CLA CLL CML RTL         /GET A 2
0217  1202              TAD     EXP             /SET UP RETURN CIF
0220  3330              DCA     EXIT1
0221  1377              TAD     (17
0222  3011              DCA     11
0223  7346              CLA CMA CLL RTL         /-3
0224  3206              DCA     EXP1
                PWTW,
0225  7402      EXP2,     HLT                   /CHANGE DF TO ARG
0226  1410              TADI    10              /GET ARG
0227  6211              6211                    /CHANGE DF TO FAC
0230  3411              DCAI    11              /PUT IN FAC
0231  2206              ISZ     EXP1            /MOVED ALL 3 WORDS?
0232  5225              JMP     EXP2            /NOT YET
 
                / ARG IS NOW IN FAC
 
                        /NOTE -- SIGN=EXP1=0 ALREADY
0233  1776              TADI    (20
0234  7700              SMA CLA                 /NEGATIVE?
0235  5242              JMP     EXP3            /NO
0236  7240              CLA CMA
0237  3206              DCA     SIGN            /SIGN INDICATES NEGATIVE
0240  4033              CALL 0, CHS             /MAKE POSITIVE
/  EXP -- EXPONENTIATION              SEP  4, 1975              PAGE  2

0241  0002 06
0242  4033      EXP3,   CALL 1, FMP             /X*1./ALOG(2.)
0243  0103 06
0244  6201 05             ARG   LG2E
0245  0366 01
0246  4332              JMS     STOX            /X = FAC
0247  4033              CALL 0, FIX             /GET PART TO LEFT OF DECIMAL
0250  0004 06
0251  3225              DCA     PWTW            /SAVE IT FOR LATER
0252  1225              TAD     PWTW
0253  7041              CIA                     /NEGATE IT
0254  4033              CALL 0, FLOT            /FLOAT IT
0255  0005 06
0256  4033              CALL 1, FAD             /NOW GET THE FRACTION PART
0257  0106 06
0260  6201 05             ARG   X
0261  0200 01
0262  4332              JMS     STOX            /MOVE FAC TO X
0263  3776              DCAI    (20             /CLEAR FAC
                                                /DEPENDS ON FAD ONLY CHECKING
                                                /ACH TO SEE IF ZERO.
 
                / NOW EVALUATE THE SERIES EXPANSION FOR F*ALOG(2.)
 
0264  1357              TAD     MK6
0265  3332              DCA     POL2            /6 TERMS
0266  1343              TAD     ACOF
0267  3273      ARG2,   DCA     ARG1#           /SET UP ADDR TO COEF.
0270  4033              CALL 1, FAD
0271  0106 06
0272  6201 05   ARG1,     ARG   COF
0273  0363 01
0274  4033              CALL 1, FMP
0275  0103 06
0276  6201 05             ARG   X
0277  0200 01
0300  7346              CLA CMA CLL RTL         /-3
0301  1273              TAD     ARG1#
0302  2332              ISZ     POL2            /MORE TERMS?
0303  5267              JMP     ARG2            /YES
0304  4033              CALL 1, FAD             /NOTE THAT ENTRY HERE IS WITH
0305  0106 06
                                                /AC NONZERO.  FAD MUST HANDLE I
0306  6201 05             ARG   ONE
0307  0371 01
0310  6211              TAD     ACL
0311  1775
0312  1225              TAD     PWTW            /MULTIPLY BY 2^(INTEGER PART)
0313  3775              DCA     ACL
0314  2206              ISZ     SIGN            /WAS IT NEGATIVE?
0315  5330              JMP     EXIT1           /NO
0316  4332              JMS     STOX            /YES -- STORE FAC IN X
0317  7332              CLA CLL CML RTR         /LOAD AC WITH 1
0320  3776              DCAI    (20
0321  3774              DCAI    (21
0322  7001              IAC
0323  3775              DCAI    (22
/  EXP -- EXPONENTIATION              SEP  4, 1975              PAGE  3

0324  4033              CALL 1, FDV             /GET RECIPROCAL
0325  0107 06
0326  6201 05             ARG   X
0327  0200 01
0330  7402      EXIT1,  HLT                     /GETS A CIF CDF
0331  5603              JMPI    EXP#            /FAST RETURN
 
                POL2,
0332  0000      STOX,   0                       /STORE FAC TO X SUB
0333  6211              TAD     ACH
0334  1776
0335  3200              DCA     X
0336  1774              TAD     ACM
0337  3201              DCA     X1
0340  1775              TAD     ACL
0341  3202              DCA     X2
0342  5732              JMPI    STOX
 
 
                /  COEFFICIENTS FOR EXP(X)
 
0343  0363 01   ACOF,   COF
0344  2613              2613            /.99999622*(LN 2)^1 = .693144560
0345  4366              4366
0346  0000              0000
0347  3660              3660            /.50005992*(LN 2)^2 = .240255296
0350  1276              1276
0351  7776              7776
0352  3426              3426            /.16631354*(LN 2)^3 = .055386509
0353  7173              7173
0354  7774              7774
0355  2412              2412            /.04264947*(LN 2)^4 = .009844995
0356  3163              3163
0357  7772      MK6,    7772
0360  2216              2216            /.00695345*(LN 2)^5 = .001112571
0361  4730              4730
0362  7767              7767
0363  2062      COF,    2062            /.00231014*(LN 2)^6 = .000256207
0364  4703              4703
0365  7765              7765
 
0366  2705      LG2E,   2705            / 1/ALOG(2)
0367  2435              2435
0370  0001              0001
 
0371  2000      ONE,    2000            /1
0372  0000              0000
0373  0001              0001
 
0374  0021
0375  0022
0376  0020
0377  0017
                END
/  EXP -- EXPONENTIATION              SEP  4, 1975              PAGE  4

 
 
ACOF    0343
ARG1    0272
ARG2    0267
CHS     0000EXT
COF     0363
DCAI    3400OP
EXIT1   0330
EXP     0202EXT
EXP1    0206
EXP2    0225
EXP3    0242
FAD     0000EXT
FDV     0000EXT
FIX     0000EXT
FLOT    0000EXT
FMP     0000EXT
JMPI    5400OP
LG2E    0366
MK6     0357
ONE     0371
POL2    0332
PWTW    0225
SIGN    0206
STOX    0332
TADI    1400OP
X       0200
X1      0201
X2      0202
 
