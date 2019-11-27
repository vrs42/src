
/ SQRT -- SQUARE ROOT                 SEP  5, 1975              PAGE  1

                /  FOR 23 BIT F. P. FORMAT
                /  WRITTEN BY
                /       PHILLIP SIEMENS
                /       LAWRENCE LIVERMORE LABORATORY
                /       SEPTEMBER 9, 1975
 
                /  USE THE APPROXIMATION
                /       Y = X0 + (Y/X0)/2
 
                /  INITIAL X0 IS CHOSEN BY
                /       MANTISSA = (MANTISSA + 2**23) / 2 IF EXP IS EVEN
                /       MANTISSA = (MANTISSA + 2**22) / 2 IF EXP IS ODD
                /       EXPONENT = EXP/2  IF EXP IS EVEN
                /       EXPONENT = EXP/2 + 1 IF EXP IS ODD
 
                        LAP
 
                / DEFINITIONS TO MAKE THINGS RUN FAST
 
      1400      OPDEF   TADI    1400
      5400      OPDEF   JMPI    5400
      3400      OPDEF   DCAI    3400
      2400      OPDEF   ISZI    2400
 
                        ENTRY   SQRT
 
                / TEMPORARY STORAGE
 
0200  0000      X0,     0
0201  0000      X1,     0
0202  0000      X2,     0
 
0203  0000      Y,      0
0204  0000      Y1,     0
0205  0000      Y2,     0
 
0206  0000      CNT,    0
/ SQRT -- SQUARE ROOT                 SEP  5, 1975              PAGE  2

0207  6321      SQER,   6321                    /"SQRT" ERROR FROM LOC XXXXX
0210  2224              2224
 
0211  6140      SQRT,   6140                    /VERSION # IN ENTRY POINT
0212  0005              0005                    /EDIT #
0213  1211              TAD     SQRT            /GET CDF TO FROM FIELD
0214  3215              DCA     SQRT1           /PUT IT HER
0215  7402      SQRT1,  HLT                     /CHANGE DF TO FROM
0216  1612              TADI    SQRT#           /GET FIELD OF ARG
0217  3225              DCA     SQRT2
0220  2212              ISZ     SQRT#           /BUMP POINTER
0221  7240              CLA CMA
0222  1612              TADI    SQRT#           /GET ADDRESS OF ARG
0223  3010              DCA     10              /INIT AUTO INDEX
0224  2212              ISZ     SQRT#           /BUMP POINTER
0225  7402      SQRT2,  HLT                     /CHANGE DF TO ARG FIELD
0226  1410              TADI    10              /GET MS OF ARG
0227  3203              DCA     Y               /STORE IN Y
0230  1410              TADI    10
0231  3204              DCA     Y1
0232  1410              TADI    10
0233  3205              DCA     Y2
0234  1203              TAD     Y               /GET SIGN OF ARG
0235  7500              SMA                     /NEGATIVE?
0236  5253              JMP     POS             /NO
0237  4033              CALL 1, ERROR           /ERROR
0240  0102 06
0241  6201 05           ARG     SQER
0242  0207 01
0243  1204              TAD     Y1              /CHANGE SIGN OF Y TO POSITIVE
0244  7141              CLL CIA
0245  3204              DCA     Y1
0246  7024              CML RAL
0247  1203              TAD     Y
0250  7141              CLL CIA
0251  3203              DCA     Y
0252  5255              JMP     NONZ
/ SQRT -- SQUARE ROOT                 SEP  5, 1975              PAGE  3

0253  7650      POS,    SNA CLA                 /IS ARG ZERO?
0254  5342              JMP     SQZERO          /YES -- ROOT = 0
0255  7100      NONZ,   CLL                     /FORM INITIAL X0
0256  1205              TAD     Y2              /GET EXPONENT
0257  7510              SPA                     /NEGATIVE?
0260  7020              CML                     /YES -- GET A 1 IN LINK
0261  7010              RAR                     /DIVIDE EXPONENT BY 2
0262  6211              DCA     ACL             /SET EXPONENT IN FAC
0263  3777
0264  7430              SZL                     /WAS EXP EVEN?
0265  2777              ISZ     ACL             /NO -- ADD 1 TO EXP
0266  7000              NOP
0267  7020              CML                     /NOW FIX THE MANTISSA
0270  7420              SNL
0271  7030              CML RAR
0272  7010              RAR
0273  1203              TAD     Y               /DIVIDE BY 2
0274  7010              RAR
0275  3776              DCA     ACH
0276  1204              TAD     Y1
0277  7010              RAR
0300  3775              DCA     ACM
0301  7346              CLA CMA CLL RTL
0302  3206              DCA     CNT             /DO 3 ITERATIONS
 
0303  1776      INIT,   TADI    (20             /SAVE FAC IN X0
0304  3200              DCA     X0
0305  1775              TADI    (21
0306  3201              DCA     X1
0307  1777              TADI    (22
0310  3202              DCA     X2
0311  1203              TAD     Y               /PUT Y INTO FAC
0312  3776              DCAI    (20
0313  1204              TAD     Y1
0314  3775              DCAI    (21
0315  1205              TAD     Y2
0316  3777              DCAI    (22
0317  4033              CALL 1, FDV             / Y/X0
0320  0103 06
0321  6201 05           ARG     X0
0322  0200 01
0323  4033              CALL 1, FAD             / ( Y/X0 ) + X0
0324  0104 06
0325  6201 05           ARG     X0
0326  0200 01
0327  7240              CLA CMA
0330  6211              TAD     ACL             / (( Y/X0 ) + X0 ) / 2
0331  1777
0332  3777              DCA     ACL
0333  2206              ISZ     CNT
0334  5303              JMP     INIT
0335  7326      SQRN,   CLA CLL CML RTL         /FAST RETURN
0336  1211              TAD     SQRT
0337  3340              DCA     SQRTR
0340  7402      SQRTR,  HLT
0341  5612              JMPI    SQRT#
 
/ SQRT -- SQUARE ROOT                 SEP  5, 1975              PAGE  4

0342  6211      SQZERO, DCA     ACH             /ZERO FAC
0343  3776
0344  3775              DCA     ACM
0345  3777              DCA     ACL
0346  5335              JMP     SQRN
 
0375  0021
0376  0020
0377  0022
                END
/ SQRT -- SQUARE ROOT                 SEP  5, 1975              PAGE  5

 
 
CNT     0206
DCAI    3400OP
ERROR   0000EXT
FAD     0000EXT
FDV     0000EXT
INIT    0303
ISZI    2400OP
JMPI    5400OP
NONZ    0255
POS     0253
SQER    0207
SQRN    0335
SQRT    0211EXT
SQRTR   0340
SQRT1   0215
SQRT2   0225
SQZERO  0342
TADI    1400OP
X0      0200
X1      0201
X2      0202
Y       0203
Y1      0204
Y2      0205
 
