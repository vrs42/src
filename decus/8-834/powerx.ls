
/  FFPOW -- IFPOW   POWERS            SEP  5, 1975              PAGE  1

                /  FOR 23 BIT F. P. FORMAT
                /  WRITTEN BY
                /       PHILLIP SIEMENS
                /       LAWRENCE LIVERMORE LAB
                /       FEBRUARY 18, 1975
 
                        ENTRY   FFPOW
                        ENTRY   IFPOW
 
      1400      OPDEF   TADI    1400
      3400      OPDEF   DCAI    3400
      5400      OPDEF   JMPI    5400
 
                        LAP
 
                / FLOATING BASE TO FLOATING EXPONENT
                / X**Y   WHERE X IS IN FAC
                /       ALGORITHM    EXP(Y*ALOG(X))
                /  NOTE   0**Y = 0
                /   ALSO  0**0 = 0
                /   (-X)**Y IS ERROR EVEN IF Y IS AN INTEGER
 
0200  4614      FFPER,  4614
0201  2027              2027
 
0202  6140      FFPOW,  6140                    /ENTRY
0203  0002              0002
0204  1202              TAD     FFPOW           /GET CDF TO CALLING FIELD
0205  3206      FFP0,   DCA     FFP1
0206  7402      FFP1,     HLT                   /GETS CDF
0207  1603              TADI    FFPOW#          /GET CDF TO ARG
0210  3231              DCA     LOGX
0211  2203              INC     FFPOW#          /BUMP POINTER
0212  1603              TADI    FFPOW#          /GET ARG ADDRESS
0213  3232              DCA     LOGX#
0214  2203              INC     FFPOW#          /BUMP POINTER
0215  6211              TAD     ACH             /GET X
0216  1777
0217  7510              SPA                     /IS IT POSITIVE?
0220  5244              JMP     MINUSX          /NO -- ERROR
0221  7650              SNA CLA                 /IS IT ZERO?
0222  5237              JMP     FFP3            /YES -- EXIT WITH FAC=0
0223  4033      FFP4,   CALL 1, ALOG            /ALOG(X)
0224  0103 06
0225  6211                ARG   ACH
0226  0020
0227  4033              CALL 1, FMP             /Y*ALOG(X)
0230  0104 06
0231  6211      LOGX,     ARG   0
0232  0000
0233  4033              CALL 1, EXP             /EXP(Y*ALOG(X))
0234  0105 06
0235  6211                ARG   ACH
0236  0020
0237  7326      FFP3,   CLA CLL CML RTL         /FAST EXIT
0240  1206              TAD     FFP1
0241  3242              DCA     FFP2
/  FFPOW -- IFPOW   POWERS            SEP  5, 1975              PAGE  2

0242  7402      FFP2,     HLT
0243  5603              JMPI    FFPOW#
 
0244  4033      MINUSX, CALL 1, ERROR
0245  0106 06
0246  6201 05             ARG   FFPER
0247  0200 01
0250  4033              CALL 0, CHS
0251  0007 06
0252  5223              JMP     FFP4
 
                /  INTEGER TO FLOATING POWER
                /  FLOAT THE BASE
 
0253  6140      IFPOW,  6140                    /ENTRY
0254  0002              0002
0255  4033              CALL 0, FLOT
0256  0010 06
0257  1254              TAD     IFPOW#
0260  3203              DCA     FFPOW#
0261  1253              TAD     IFPOW
0262  5205              JMP     FFP0
 
0377  0020
                END
/  FFPOW -- IFPOW   POWERS            SEP  5, 1975              PAGE  3

 
 
ALOG    0000EXT
CHS     0000EXT
DCAI    3400OP
ERROR   0000EXT
EXP     0000EXT
FFPER   0200
FFPOW   0202EXT
FFP0    0205
FFP1    0206
FFP2    0242
FFP3    0237
FFP4    0223
FLOT    0000EXT
FMP     0000EXT
IFPOW   0253EXT
JMPI    5400OP
LOGX    0231
MINUSX  0244
TADI    1400OP
 
