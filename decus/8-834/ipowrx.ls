
/  IIPOW -- FIPOW     INTEGER POWER   SEP  5, 1975              PAGE  1

                /  FOR 23 BIT F. P. FORMAT
                /  WRITTEN BY
                /       PHILLIP SIEMENS
                /       LAWRENCE LIVERMORE LABORATORY
                /       SEPTEMBER 5, 1975
 
      1400      OPDEF   TADI    1400
      5400      OPDEF   JMPI    5400
      3400      OPDEF   DCAI    3400
 
      7425      ABSYM   MQLMUY  7425
      7701      ABSYM   CLAMQA  7701
      7421      ABSYM   MQL     7421
      7501      ABSYM   MQA     7501
 
                ENTRY   IIPOW
                ENTRY   FIPOW
 
                        LAP
 
                /  AC = AC**ARG
                /  THIS ROUTINE DOES NOT CALL ANY OTHER LIBRARY SUBROUTINES
 
0200  6140      IIPOW,  6140                    /VERSION #  -- ENTRY
0201  0004              0004                    /EDIT #
0202  3233              DCA     NB              /SAVE BASE
0203  4244              JMS     GETARG          /GET THE ARG
0204  7510              SPA                     /POSITIVE?
0205  5237              JMP     IZRO            /NO -- I**(-) = 0
0206  3247              DCA     NARG            /SAVE ARG
0207  1233              TAD     NB              /GET BASE
0210  7650              SNA CLA                 /ZERO?
0211  5242              JMP     IP4             /YES -- 0**ARG = 0
0212  7001              IAC
0213  3223              DCA     MR              /INITIALIZE
 
0214  1247      IP3,    TAD     NARG
0215  7110              CLL RAR
0216  3247              DCA     NARG
0217  7420              SNL                     /BIT ON?
0220  5226              JMP     NOMPY           /NO
0221  1233              TAD     NB              /MULTIPLY
0222  7425              MQLMUY
0223  0000      MR,     0
0224  7701              CLAMQA
0225  3223              DCA     MR
0226  1247      NOMPY,  TAD     NARG
0227  7650              SNA CLA                 /MORE TO DO?
0230  5241              JMP     IPDNE           /NOPE
0231  1233              TAD     NB
0232  7425              MQLMUY
0233  0000      NB,     0
0234  7701              CLAMQA
0235  3233              DCA     NB
0236  5214              JMP     IP3
 
0237  7200      IZRO,   CLA
/  IIPOW -- FIPOW     INTEGER POWER   SEP  5, 1975              PAGE  2

0240  3223              DCA     MR              /CLEAR RESULT
0241  1223      IPDNE,  TAD     MR              /GET RESULT IN AC
0242  7402      IP4,    HLT
0243  5601              JMPI    IIPOW#
 
0244  0000      GETARG, 0
0245  1200              TAD     IIPOW           /GET CDF TO FROM FIELD
0246  3247              DCA     IP1
                NARG,
0247  7402      IP1,    HLT                     /CHANGE DF TO FROM FIELD
0250  1601              TADI    IIPOW#          /GET CDF TO ARG FIELD
0251  3261              DCA     IP2
0252  2201              INC     IIPOW#
0253  1601              TADI    IIPOW#          /GET POINTER TO ARG
0254  3247              DCA     IP1
0255  2201              INC     IIPOW#
0256  7326              CLA CLL CML RTL         /GET A 2
0257  1200              TAD     IIPOW
0260  3242              DCA     IP4             /SET UP FAST EXIT
0261  7402      IP2,    HLT                     /CHANGE DF TO ARG FIELD
0262  1647              TADI    IP1             /GET ARG
0263  5644              JMPI    GETARG
 
                / FAC = FAC**ARG
 
0264  0000      X,      0                       /OVERLAP WITH SUB. ENTRY
0265  6140      FIPOW,  6140                    /VERSION #  -- ENTRY
0266  0003              0003
0267  1265              TAD     FIPOW           /MOVE POINTERS
0270  3200              DCA     IIPOW
0271  1266              TAD     FIPOW#
0272  3201              DCA     IIPOW#
0273  4244              JMS     GETARG          /GET THE POWER
0274  7100              CLL                     /CLEAR LINK -- SIGN INDICATOR
0275  7510              SPA                     /POSITIVE POWER?
0276  7061              CIA CML                 /NO -- ABS VALUE AND SET LINK
0277  3247              DCA     NARG            /SAVE THE POWER
0300  4342              JMS     SWAP            /PUT FAC IN X, FAC GETS GARBAGE
0301  1377      FACONE, TAD     (2000           / LITERAL SO LINK IS PRESERVED
0302  3776              DCAI    (20             /SET FAC = 1
0303  3775              DCAI    (21
0304  7001              IAC
0305  3774              DCAI    (22
0306  7420              SNL                     /WAS POWER NEGATIVE?
0307  5317              JMP     FI2             /NO
0310  4033              CALL 1, FDV             /YES -- MAKE 1/X
0311  0103 06
0312  6201 05           ARG     X
0313  0264 01
0314  4342              JMS     SWAP            /X = 1/X    FAC = OLD X
0315  7100              CLL
0316  5301              JMP     FACONE
 
0317  1247      FI2,    TAD     NARG
0320  7110              CLL RAR
0321  3247              DCA     NARG
0322  7420              SNL                     /BIT SET?
/  IIPOW -- FIPOW     INTEGER POWER   SEP  5, 1975              PAGE  3

0323  5330              JMP     FI3             /NO
0324  4033              CALL 1, FMP
0325  0104 06
0326  6201 05           ARG     X
0327  0264 01
0330  1247      FI3,    TAD     NARG
0331  7650              SNA CLA                 /DONE?
0332  5242              JMP     IP4             /YES -- GET OUT QUICK
0333  4342              JMS     SWAP            /SAVE RESULT IN X
                                                /GET BASE IN FAC
0334  4033              CALL 1, FMP             /SQUARE BASE
0335  0104 06
0336  6211              ARG     ACH
0337  0020
0340  4342              JMS     SWAP            /GET RESULT BACK IN FAC
                                                /SAVE SQUARED BASE IN X
0341  5317              JMP     FI2
 
0342  0000      SWAP,   0                       /SWAP FAC AND X
0343  6211              TAD     ACH
0344  1776
0345  7421              MQL
0346  1264              TAD     X
0347  3776              DCA     ACH
0350  7501              MQA
0351  3264              DCA     X
0352  1775              TAD     ACM
0353  7421              MQL
0354  1265              TAD     FIPOW
0355  3775              DCA     ACM
0356  7501              MQA
0357  3265              DCA     FIPOW
0360  1774              TAD     ACL
0361  7421              MQL
0362  1266              TAD     FIPOW#
0363  3774              DCA     ACL
0364  7501              MQA
0365  3266              DCA     FIPOW#
0366  5742              JMPI    SWAP
 
0374  0022
0375  0021
0376  0020
0377  2000
                END
/  IIPOW -- FIPOW     INTEGER POWER   SEP  5, 1975              PAGE  4

 
 
CLAMQA  7701ABS
DCAI    3400OP
FACONE  0301
FDV     0000EXT
FIPOW   0265EXT
FI2     0317
FI3     0330
FMP     0000EXT
GETARG  0244
IIPOW   0200EXT
IPDNE   0241
IP1     0247
IP2     0261
IP3     0214
IP4     0242
IZRO    0237
JMPI    5400OP
MQA     7501ABS
MQL     7421ABS
MQLMUY  7425ABS
MR      0223
NARG    0247
NB      0233
NOMPY   0226
SWAP    0342
TADI    1400OP
X       0264
 
