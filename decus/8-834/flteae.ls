
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE  1

                / PHIL SIEMENS       JANUARY 27, 1975
                /  LAWRENCE LIVERMORE LABORATORY
                /  LIVERMORE, CA
 
                /       VERSION 5
                /       FIXED BUG IN FLOAT  1/14/76   P.S.
                /       FIXED BUG IN FIX    1/27/76  P.S.
 
                / THE FLOATING POINT FORMAT USED IS:
                /       ACH = MS MANTISSA -- 2'S COMPLEMENT
                /       ACM = LS MANTISSA -- 2'S COMPLEMENT
                /       ACL = EXPONENT    -- 2'S COMPLEMENT
 
                / THE VERSION # AND EDIT # OF EACH ROUTINE
                / ARE CONTAINED IN THE ROUTINE ENTRY POINT
 
                /----------------------------------------------/
                / THERE IS NO CHECK FOR OVERFLOW               /
                /----------------------------------------------/
 
                / ENTRIES
                        ENTRY FAD
                        ENTRY FSB
                        ENTRY FMP
                        ENTRY FDV
                        ENTRY STO
                        ENTRY FLOT
                        ENTRY FLOAT
                        ENTRY FIX
                        ENTRY IFIX
                        ENTRY IFAD
                        ENTRY ISTO
                        ENTRY ABS
                        ENTRY CHS
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE  2

                / DEFINITIONS FOR FAST TIMING
                / USE WITH CAUTION
                / CAN ONLY REFERENCE CURRENT PAGE AND ZERO PAGE SYMBOLS
 
      1400      OPDEF TADI 1400
      3400      OPDEF DCAI 3400
      4400      OPDEF JMSI 4400
      5400      OPDEF JMPI 5400
      2400      OPDEF ISZI 2400
 
                / PAGE ZERO SYMBOLS
 
      0025      ABSYM OPH 25
      0026      ABSYM OPL 26
      0027      ABSYM OPX 27
      0023      ABSYM AC1 23
      0024      ABSYM AC2 24
      0010      ABSYM PNT2 10
 
                / SPECIAL DEFINITIONS
 
      7344      ABSYM AC7776 7344
      7326      ABSYM AC0002 7326
      6214      ABSYM RDF 6214
      7346      ABSYM AC7775 7346
 
                / EAE DEFINITIONS
 
      7421      ABSYM MQL 7421
      7411      ABSYM NMI 7411
      7441      ABSYM SCA 7441
      7501      ABSYM MQA 7501
      7413      ABSYM SHL 7413
      7433      ABSYM MQLSHL 7433
      7415      ABSYM ASR 7415
      7425      ABSYM MQLMUY 7425
      7407      ABSYM DVI 7407
      7701      ABSYM CLAMQA 7701
      7417      ABSYM LSR 7417
 
                        LAP
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE  3

                / FLOATING POINT ADDITION
 
0200  6440      FAD,    6440            /ENTRY
0201  0005              0005
0202  4232              JMS GETADD      /GET ADDRESS OF ARG
0203  4257      FADX,   JMS GETARG      /GET THE ARG
0204  5605              JMPI FFADDI
0205  0401 01   FFADDI, FFADD
 
                / FLOATING POINT SUBTRACTION
 
0206  6440      FSB,    6440            /ENTRY
0207  0005              0005
0210  4232              JMS GETADD      /GET ADDRESS OF ARG
0211  4257              JMS GETARG      /GET THE ARG
0212  5613              JMPI FFSUBI
0213  0400 01   FFSUBI, FFSUB
 
                / FLOATING POINT MULTIPLY
 
0214  6440      FMP,    6440            /ENTRY
0215  0005              0005
0216  4232              JMS GETADD      /GET ADDRES OF ARG
0217  4257              JMS GETARG      /GET THE ARG
0220  5621              JMPI FFMPYI
0221  1000 01   FFMPYI, FFMPY
 
                / FLOATING POINT DIVIDE
0222  4411      DIVZ,   4411
0223  2632              2632
 
0224  6440      FDV,    6440            /ENTRY
0225  0005              0005
0226  4232              JMS GETADD      /GET ADDRESS OF ARG
0227  4257              JMS GETARG      /GET THE ARG
0230  5631              JMPI FFDIVI
0231  1200 01   FFDIVI, FFDIV
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE  4

                /GET ADDRESS OF ARG
                /ASSUMES THE 2 WORDS JUST PREVIOUS TO THE
                /JMS ARE IN SABR ENTRY POINT FORMAT
                /
                /       CDF N
                /       ADDR
                /       JMS GETADD
 
0232  0000      GETADD, 0               /ENTERS WITH DF POINTING TO FROM BANK
0233  7346              AC7775          /GET A -3 IN AC
0234  1232              TAD GETADD      /BACK UP THE POINTER TO ADDR
0235  3330              DCA PNT         /POINT TO LOCATION BEFORE JMS
0236  1730              TADI PNT        /GET CDF TO FROM FIELD
0237  3243              DCA GETAF1      /STORE CDF FOR A FETCH
0240  2330              ISZ PNT         /BUMP POINTER
0241  1730              TADI PNT        /GET ADDR
0242  3330              DCA PNT         /NOW POINT TO ARG ADDRESS
0243  7402      GETAF1,   HLT           /CHANGED TO CDF TO ARG ADDRESS FIELD
0244  1730              TADI PNT        /GET FIELD OF ARG
0245  3260              DCA GETAF2      /STORE IT
0246  2330              ISZ PNT         /BUMP POINTER
0247  7240              CLA CMA
0250  1730              TADI PNT        /GET ADDRESS OF ARG
0251  3010              DCA PNT2
0252  7326              AC0002
0253  1243              TAD GETAF1      /MAKE A CIF CDF TO FROM FIELD
0254  3320              DCA FRETF
0255  2330              ISZ PNT         /RETURN ADDRESS
0256  5632              JMPI GETADD     /EXIT
 
                /GET ARGUMENT  (FETCH)
 
0257  0000      GETARG, 0
0260  7402      GETAF2,   HLT           /CHANGED TO CDF
0261  1410              TADI PNT2
0262  3025              DCA OPH
0263  1410              TADI PNT2
0264  3026              DCA OPL
0265  1410              TADI PNT2
0266  3027              DCA OPX
0267  3024              DCA AC2         /CLEAR OP LS BITS
0270  5657              JMPI GETARG
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE  5

                / FLOATING POINT STORE ROUTINE
 
0271  6440      STO,    6440            /ENTRY
0272  0006              0006
0273  4232              JMS GETADD      /GET ADDRESS
                STOX,
0274  6211              TAD ACH         /MOVE FAC TO THIS
0275  1777
0276  3025              DCA OPH         /FIELD TEMPORARILY
0277  1776              TAD ACM
0300  3026              DCA OPL
0301  1775              TAD ACL
0302  7421              MQL
0303  1260              TAD GETAF2      /MOVE THE CDF INSTRUCTION
0304  3305              DCA STOAF2
0305  7402      STOAF2,   HLT           /GETS A CDF
0306  1025              TAD OPH         /NOW STORE WITH AUTO INDEX
0307  3410              DCAI PNT2
0310  1026              TAD OPL
0311  3410              DCAI PNT2
0312  7501              MQA
0313  3410              DCAI PNT2
0314  6211      STOX1,  DCA ACH         /CLEAR THE FAC
0315  3777
0316  3776              DCA ACM
0317  3775              DCA ACL
                /FLOATING POINT SUBROUTINE RETURN
 
0320  7402      FRETF,    HLT           /CHANGED TO CIF CDF
0321  5730              JMPI PNT
 
 
                / FLOATING POINT ABSOLUTE VALUE
 
0322  6440      ABS,    6440            /ENTRY
0323  0005              0005
0324  4232              JMS GETADD      /GET ADDRESS OF ARG
0325  4257              JMS GETARG      /GET ARG
0326  5727              JMPI FABSI
0327  0552 01   FABSI,  FABS
 
0330  0000      PNT,    0
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE  6

                / INDIRECT FLOATING POINT STORE
 
0331  6440      ISTO,   6440            /ENTRY
0332  0005              0005
0333  4232              JMS GETADD      /GET FIRST ADDRESS
0334  4257              JMS GETARG      /GET SECOND ADDRESS
0335  1025              TAD OPH         /MOVE SECOND ADDRESS
0336  3260              DCA GETAF2      /TO SET UP GETARG
0337  7240              CLA CMA
0340  1026              TAD OPL
0341  3010              DCA PNT2
0342  5274              JMP STOX
 
                / INDIRECT FLOATING ADD
 
0343  6440      IFAD,   6440            /ENTRY
0344  0005              0005
0345  4232              JMS GETADD      /GET FIRST ADDRESS
0346  4257              JMS GETARG      /GET SECOND ADDRESS
0347  1025              TAD OPH         /MOVE SECOND ADDRESS
0350  3260              DCA GETAF2      /TO SET UP GETARG
0351  7240              CLA CMA
0352  1026              TAD OPL
0353  3010              DCA PNT2
0354  5203              JMP FADX
 
                / FLOAT AN INTEGER ARG
 
0355  6440      FLOAT,  6440            /ENTRY
0356  0005              0005
0357  4232              JMS GETADD      /GET ADDRESS
0360  4257              JMS GETARG      /GET ARG
0361  1025              TAD OPH         /GET INTEGER
0362  5763              JMPI FLOTXI     /GO FLOAT IT
0363  0744 01   FLOTXI, FLOTX
 
                /FIX FAC TO AN INTEGER
 
0364  6440      IFIX,   6440            /ENTRY
0365  0005              0005
0366  4232              JMS GETADD      /GET ADDRESS
0367  4257              JMS GETARG      /GET ARG
0370  4774              JMS MOPFAC      /MOVE OP TO FAC
0371  5772              JMPI FIXXI
0372  0677 01   FIXXI,  FIXL
 
0374  0557 01
0375  0022
0376  0021
0377  0020
                PAGE
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE  7

                /FLOATING ADD AND SUBTRACT
 
0400  4232      FFSUB,  JMS OPNEG       /NEGATE OPERAND
0401  1025      FFADD,  TAD OPH
0402  7650              SNA CLA         /IS OPERAND = 0?
0403  5777              JMP FRETF       /YES  DONE
0404  6211              TAD ACH         /IS FAC = 0?
0405  1776
0406  7650              SNA CLA
0407  5355              JMP REPLC       /YES  JUST PUT OP IN FAC
0410  1775              TAD ACL         /NO -- DO EXPONENT CALC.
0411  7141              CLL CMA IAC
0412  1027              TAD OPX
0413  7540              SMA SZA         /WHICH EXP. IS GREATER?
0414  5225              JMP FACR        /OPERAND -- SHIFT FAC
0415  7041              CMA IAC         /FAC -- SHIFT OPERAND = DIF+1
0416  4243              JMS OPSR
0417  4630              JMSI ACSRI      /SHIFT FAC 1 PLACE RIGHT
0420  1027      DOADD,  TAD OPX         /SET EXPONENT OF RESULT
0421  3775              DCAI (22
0422  4631              JMSI OADDI      /DO THE ADDITION
0423  4307              JMS FFNOR       /NORMALIZE THE RESULT
0424  5777              JMP FRETF       /RETURN
 
0425  4630      FACR,   JMSI ACSRI      /SHIFT FAC = DIF+1
0426  4243              JMS OPSR        /SHIFT OPERAND 1 PLACE RIGHT
0427  5220              JMP DOADD       /DO ADDITION
0430  0617 01   ACSRI,  ACSR
0431  0600 01   OADDI,  OADD
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE  8

                /NEGATE OPERAND
 
0432  0000      OPNEG,  0
0433  1026              TAD OPL         /GET LOW ORDER
0434  7141              CLL CMA IAC     /NEGATE
0435  3026              DCA OPL         /STORE BACK
0436  7024              CML RAL         /PROPAGATE CARRY
0437  1025              TAD OPH
0440  7141              CLL CMA IAC     /NEGATE AND STORE
0441  3025              DCA OPH
0442  5632              JMPI OPNEG
 
                / OPERAND SHIFT RIGHT
                / ENTER WITH POSITIVE COUNT-1 IN AC
 
0443  0000      OPSR,   0
0444  7450              SNA             /ONE SHIFT?
0445  5300              JMP OPSRA       /YES
0446  7421              MQL             /SAVE COUNT-1
0447  7501              MQA             /RETRIEVE IT
0450  1027              TAD OPX
0451  3027              DCA OPX         /EXPONENT STILL NEEDS 1
0452  7501              MQA             /DECREMENT
0453  0374              AND (7740       /MASK FOR TOO LARGE SHIFT
0454  7640              SZA CLA
0455  1373              TAD (37         /MAKE IT OK
0456  7501              MQA
0457  1351              TAD IFM1
0460  3265              DCA OPSRB       /SHIFT COUNT
0461  1026              TAD OPL         /GET LOW
0462  7421              MQL             /PUT IN MQ
0463  1025              TAD OPH         /GET HIGH
0464  7415              ASR             /SHIFT RIGHT WITH SIGN
0465  0000      OPSRB,    0
0466  7010      OPSRC,  RAR
0467  3025              DCA OPH         /STORE HIGH
0470  7501              MQA
0471  7010              RAR
0472  3026              DCA OPL         /STORE LOW
0473  2027              ISZ OPX         /FIX EXPONENT
0474  7000              NOP
0475  7010              RAR
0476  3024              DCA AC2         /SAVE LS BITS FOR ROUNDING
0477  5643              JMPI OPSR
 
0500  1026      OPSRA,  TAD OPL         /ONLY 1 SHIFT
0501  7421              MQL             /SET UP FOR IT
0502  1025              TAD OPH         /GET HIGH
0503  7100              CLL
0504  7510              SPA             /GET SIGN IN LINK
0505  7020              CML
0506  5266              JMP OPSRC
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE  9

                / NORMALIZE ROUTINE
 
0507  0000      FFNOR,  0
0510  6211              TAD ACH         /GET HI ORDER
0511  1776
0512  7450              SNA             /ZERO?
0513  1772              TAD ACM         /YES -- HOW ABOUT LOW
0514  7450              SNA
0515  1023              TAD AC1         /HOW ABOUT OVERFLOW?
0516  7640              SZA CLA
0517  5323              JMP IFN2
0520  3775              DCA ACL         /ZERO IT FOR SURE
0521  3023      FFNORR, DCA AC1
0522  5707              JMPI FFNOR      /EXIT
 
0523  1772      IFN2,   TADI (21
0524  7421              MQL
0525  1776              TADI (20
0526  7411              NMI             /NORMALIZE
0527  3776              DCAI (20        /STORE HIGH
0530  7441              SCA             /GET SHIFT COUNT
0531  7041              CIA
0532  1775              TADI (22
0533  3775              DCAI (22        /STORE CORRECTED EXPONENT
0534  7441              SCA
0535  7450              SNA             /NO SHIFTS NEEDED?
0536  5321              JMP FFNORR      /RIGHT
0537  1351              TAD IFM1        /DECREMENT
0540  3345              DCA NX1
0541  7501              MQA
0542  3772              DCAI (21
0543  1023              TAD AC1
0544  7433              MQLSHL          /SHIFT OVERFLOW
0545  0000      NX1,      0
0546  1772              TADI (21
0547  3772              DCAI (21
0550  5321              JMP FFNORR
0551  7777      IFM1,   -1
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE 10

                / DO THE ABSOLUTE VALUE
 
0552  1025      FABS,   TAD OPH         /GET SIGN
0553  7710              SPA CLA         /IS IT MINUS?
0554  4232              JMS OPNEG       /YES -- NEGATE
0555  4357      REPLC,  JMS MOPFAC      /MOVE OP TO FAC
0556  5777              JMP FRETF
 
0557  0000      MOPFAC, 0
0560  1025              TAD OPH
0561  6211              DCA ACH
0562  3776
0563  1026              TAD OPL
0564  3772              DCA ACM
0565  1027              TAD OPX
0566  3775              DCA ACL
0567  5757              JMPI MOPFAC
0572  0021
0573  0037
0574  7740
0575  0022
0576  0020
0577  0320 01
                PAGE
                / ADD ROUTINE
 
0600  0000      OADD,   0
0601  7100              CLL             /CLEAR LINK
0602  1024              TAD AC2         /ADD LEAST SIG
0603  1023              TAD AC1
0604  3023              DCA AC1
0605  7004              RAL
0606  1026              TAD OPL         /ADD LOW ORDER
0607  6211              TAD ACM
0610  1777
0611  3777              DCA ACM
0612  7004              RAL
0613  1025              TAD OPH         /ADD HIGH ORDER
0614  1776              TAD ACH
0615  3776              DCA ACH
0616  5600              JMPI OADD
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE 11

                / FAC SHIFT RIGHT WITH COUNT-1 IN AC
 
0617  0000      ACSR,   0
0620  7450              SNA             /ONE SHIFT?
0621  5255              JMP ACSRA       /YES
0622  7421              MQL             /SAVE COUNT-1
0623  7501              MQA             /RETRIEVE IT
0624  6211              TAD ACL         /GET EXP
0625  1775
0626  3775              DCA ACL         /EXPONENT STILL NEEDS 1
0627  7501              MQA
0630  0302              AND K7740
0631  7640              SZA CLA
0632  1374              TAD (37
0633  7501              MQA
0634  1373              TAD (-1         /DECREMENT
0635  3242              DCA BCI         /SHIFT COUNT
0636  1777              TAD ACM         /GET LOW AND
0637  7421              MQL             /PUT IN MQ
0640  1776              TAD ACH         /GET HIGH
0641  7415              ASR             /SHIFT RIGHT WITH SIGN
0642  0000      BCI,      0
0643  7010      ACSRB,  RAR
0644  3776              DCAI (20        /STORE HIGH
0645  7501              MQA
0646  7010              RAR
0647  3777              DCAI (21        /STORE LOW
0650  2775              ISZI (22        /FIX EXPONENT
0651  7000              NOP
0652  7010              RAR
0653  3023              DCA AC1         /SAVE LS BITS FOR ROUNDING
0654  5617              JMPI ACSR
 
0655  6211      ACSRA,  TAD ACM         /ONE SHIFT
0656  1777
0657  7421              MQL
0660  1776              TAD ACH
0661  7100              CLL
0662  7510              SPA             /GET SIGN IN LINK
0663  7020              CML
0664  5243              JMP ACSRB
 
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE 12

                / FIX WITH NO ARG
 
0665  4611      FXER,   4611            /"FIX" ERROR
0666  3040              3040
 
0667  6440      FIX,    6440            /ENTRY
0670  0005              0005
0671  7326              AC0002          /SET UP RETURN
0672  1267              TAD FIX
0673  6201 05           DCA FRETF
0674  3772
0675  1270              TAD FIX#
0676  3771              DCA PNT
0677  3332      FIXL,   DCA SIGN        /CLEAR SIGN INDICATOR
0700  6211              TAD ACH         /GET SIGN BIT
0701  1776
0702  7740      K7740,  SMA SZA CLA     /MINUS?
0703  5306              JMP FIXP        /NO
0704  4770              JMS FFNEG       /YES -- MAKE POSITIVE
0705  2332              INC SIGN        /AND REMEMBER ITS NEGATIVE
0706  1775      FIXP,   TADI (22        /GET EXPONENT
0707  7041              CIA
0710  1367              TAD (13
0711  7510              SPA
0712  5322              JMP FIXERR
0713  1367              TAD (13
0714  4217              JMS ACSR
0715  3776      FIXR,   DCAI    (20     /CLEAR HIGH ORDER FAC
0716  1332              TAD SIGN        /WHAT SIGN WAS IT?
0717  7110              CLL RAR         /PUT IT IN LINK
0720  1777              TADI (21
0721  5766              JMP FIXZR       /GO FIND SOME ROOM TO FINISH
 
0722  4033      FIXERR, CALL 1, ERROR
0723  0116 06
0724  6201 05            ARG FXER
0725  0665 01
0726  7350              CLA CMA CLL RAR /2047
0727  6211              DCA ACM
0730  3777
0731  5315              JMP FIXR
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE 13

                /FLOAT A FIXED INTEGER IN AC
                /LEAVE RESULT IN FAC
 
                SIGN,
0732  6440      FLOT,   6440            /ENTRY
0733  0006              0006
0734  7421              MQL             /SAVE THE AC
0735  7326              AC0002
0736  1332              TAD FLOT        /MAKE CIF CDF TO FROM FIELD
0737  6201 05           DCA FRETF
0740  3772
0741  1333              TAD FLOT#       /SET UP RETURN POINTER
0742  3771              DCA PNT
0743  7501              MQA             /GET INTEGER BACK
0744  7450      FLOTX,  SNA             /IS INTEGER ZERO?
0745  5765              JMP STOX1       /YES -- CLEAR FAC
0746  7104              CLL RAL         /SIGN TO LINK
0747  7421              MQL             /PUT IN MQ
0750  7430              SZL             /IS SIGN ON?
0751  7040              CMA             /YES -- EXTEND IT
0752  7411              NMI
0753  6211              DCA ACH         /SAVE HIGH
0754  3776
0755  7501              MQA
0756  3777              DCA ACM         /SAVE LOW
0757  7441              SCA             /GET STEP COUNT
0760  7041              CIA
0761  1364              TAD (26
0762  3775              DCA ACL         /SAVE EXPONENT
0763  5772              JMP FRETF
 
0764  0026
0765  0314 01
0766  1364 01
0767  0013
0770  1146 01
0771  0330 01
0772  0320 01
0773  7777
0774  0037
0775  0022
0776  0020
0777  0021
                PAGE
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE 14

                / MULTIPLY
 
1000  4247      FFMPY,  JMS MDSET       /SET UP FOR MPY-OPX IN AC
1001  6211              TAD ACL         /DO EXPONENT ADDITION
1002  1777
1003  3777              DCA ACL         /STORE FINAL EXPONENT
1004  3247              DCA MDSET       /ZERO TEM STORAGE
1005  3024              DCA AC2
1006  1776              TAD ACH         /IS FAC = 0?
1007  7650              SNA CLA
1010  5245              JMP MPY1        /YES - ZERO EXPONENT
1011  4303              JMS MP24        /NO - MULT FAC BY LOW OPR
1012  1025              TAD OPH         /NOW MULT FAC BY HI ORDER
1013  3026              DCA OPL
1014  4303              JMS MP24
1015  1024              TAD AC2         /STORE RESULT BACK IN FAC
1016  6211              DCA ACM         /LOW ORDER
1017  3775
1020  1247              TAD MDSET       /HI ORDER
1021  3776              DCA ACH
1022  1776              TAD ACH         /NORMALIZE?
1023  7004              RAL
1024  7700              SMA CLA
1025  4702              JMSI IFNOR      /YES
1026  1023              TAD AC1
1027  7710              SPA CLA         /CHECK OVERFLOW
1030  2775              ISZ ACM         /HIGH BIT ON -- ROUND RESULT
1031  5237              JMP MDONE
1032  2776              ISZ ACH         /LOW ORDER OVERFLOWED
1033  1776              TAD ACH
1034  7510              SPA             /CHECK FOR 4000 0000
1035  5701              JMPI SHR1I
1036  7200              CLA
1037  3023      MDONE,  DCA AC1         /ZERO OVERFLOW
1040  2276              ISZ MSIGN       /SHOULD RESULT BE NEGATIVE
1041  7410              SKP
1042  4700              JMSI FFNEGI     /YES -- NEGATE
1043  1776              TADI (20
1044  7650              SNA CLA         /ZERO HIGH MEANS ZERO EXP
1045  3777      MPY1,   DCAI (22
1046  5774              JMP FRETF
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE 15

                /MDSET -- SETS UP SIGNS FOR MULT & DIVIDE
                /SHIFTS OPERAND 1 BIT LEFT
                /EXIT WITH EXP OF OPERAND IN AC
 
1047  0000      MDSET,  0
1050  7344              CLA CLL CMA RAL /GET -2
1051  3276              DCA MSIGN
1052  1025              TAD OPH         /IS OP NEGATIVE
1053  7700              SMA CLA
1054  5257              JMP MDS1        /NO
1055  4677              JMSI OPNEGI     /YES -- NEGATE
1056  2276              ISZ MSIGN       /BUMP SIGN CHECK
1057  1026      MDS1,   TAD OPL         /SHIFT OP LEFT 1 BIT
1060  7104              CLL RAL
1061  3026              DCA OPL
1062  1025              TAD OPH
1063  7004              RAL
1064  3025              DCA OPH
1065  6211              TAD ACH         /IS FAC NEGATIVE?
1066  1776
1067  7700              SMA CLA
1070  5274              JMP LEV         /NO
1071  4700              JMSI FFNEGI     /YES -- NEGATE
1072  2276              ISZ MSIGN       /BUMP SIGN CHECK
1073  7000              NOP             /SKIP PROTECT
1074  1027      LEV,    TAD OPX
1075  5647              JMPI MDSET
 
1076  0000      MSIGN,  0
1077  0432 01   OPNEGI, OPNEG
1100  1146 01   FFNEGI, FFNEG
1101  1246 01   SHR1I,  SHR1
1102  0507 01   IFNOR,  FFNOR
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE 16

                / MULTIPLIER IS IN OPL
                / MULTIPLICAND IS IN ACH AND ACM
                / RESULT LEFT IN MDSET, AC2, AND AC1
 
1103  0000      MP24,   0
1104  1026              TAD OPL         /GET MULTIPLIER (12 BITS)
1105  7450              SNA             /IS IT ZERO?
1106  5344              JMP MP24OUT     /YES
1107  3313              DCA MP24A
1110  6211              TAD ACM         /LOW 12 BITS OF MULTIPLICAND
1111  1775
1112  7425              MQLMUY
1113  0000      MP24A,    0             / *OPL
1114  3313              DCA MP24A       /GET LO PART IN AC, LINK IS CLEAR
1115  7501              MQA
1116  1024              TAD AC2         /MAKE FULL PRODUCT
1117  3023              DCA AC1         /LINK CONTAINS CARRY
1120  7004              RAL             /GET POSSIBLE CARRY
1121  1313              TAD MP24A       /ADD HI PART
1122  1247              TAD MDSET
1123  3024              DCA AC2         /TEMPORARY
1124  7004              RAL             /GET POSSIBLE CARRY
1125  3313              DCA MP24A       /AND SAVE IT
1126  1026              TAD OPL
1127  3332              DCA MP24B
1130  1776              TADI (20        /HI 12 BITS OF MULTIPLICAND
1131  7425              MQLMUY
1132  0000      MP24B,    0             / *OPL
1133  3247              DCA MDSET       /HI PRODUCT EXCEPT FOR POSS. CARRY
1134  7501              MQA             /MAKE MIDDLE 12 BITS
1135  1024              TAD AC2
1136  3024              DCA AC2
1137  7004              RAL             /GET POSSIBLE CARRY
1140  1313              TAD MP24A
1141  1247              TAD MDSET
1142  3247              DCA MDSET
1143  5703              JMPI MP24
 
1144  3023      MP24OU, DCA AC1         /INSURE PRODUCT IS ALL ZERO
1145  5703              JMPI MP24
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE 17

                / NEGATE FAC
 
1146  0000      FFNEG,  0
1147  6211              TAD ACM
1150  1775
1151  7141              CLL CIA
1152  3775              DCA ACM
1153  7024              CML RAL
1154  1776              TAD ACH
1155  7141              CLL CIA
1156  3776              DCA ACH
1157  5746              JMPI FFNEG
 
                / CHANGE SIGN OF FAC
 
1160  6440      CHS,    6440            /ENTRY
1161  0005              0005
1162  4346              JMS FFNEG       /NEGATE FAC
1163  7326              AC0002
1164  1360              TAD CHS         /MAKE CIF CDF
1165  3366              DCA CHS1
1166  7402      CHS1,     HLT           /FAST EXIT
1167  5761              JMPI CHS#
 
1170  3777      FIXZZ,  DCAI    (22
1171  7501              MQA             /RESTORE AC
1172  5774              JMP FRETF
1174  0320 01
1175  0021
1176  0020
1177  0022
                PAGE
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE 18

                / DIVIDE ROUTINE
 
1200  4763      FFDIV,  JMSI MDSETI     /SET UP FOR DIVIDE  OPX IN AC
1201  7041              CMA IAC         /NEGATE EXP. OF OPERAND
1202  6211              TAD ACL         /ADD EXP. OF FAC
1203  1777
1204  3777              DCA ACL         /STORE AS FINAL EXP.
1205  1025              TAD OPH         /NEGATE HI ORDER OP. FOR USE
1206  7141              CLL CMA IAC     /AS DIVISOR
1207  3025              DCA OPH
1210  4326              JMS DV24        /DIV. -- (ACH+ACM)/OPH
1211  6211              TAD ACM         /SAVE QUOT. FOR LATER
1212  1776
1213  3023              DCA AC1
1214  1026              TAD OPL
1215  7650              SNA CLA
1216  5267              JMP DVL2        /AVOID MULTIPLYING BY 0
1217  1026              TAD OPL
1220  3223              DCA DVXX        /SET UP FOR A MULTIPLY
1221  1776              TAD ACM
1222  7425              MQLMUY          /ACM*OPL
1223  0000      DVXX,     0
1224  3223              DCA DVXX
1225  7501              MQA             /GET LOW IN AC
1226  7041              CIA             /NEGATE LOW
1227  6211              DCA ACM         /STORE
1230  3776
1231  1223              TAD DVXX        /GET HI IN AC
1232  7420              SNL             /CARRY?
1233  7001              IAC             /YES
1234  1024              TAD AC2         /NEGATE HI ORDER PRODUCT
1235  7161              CLL CML CIA
1236  1775              TAD ACH         /COMPARE WITH REMAINDER OF FIRST
1237  7430              SZL             /WELL?
1240  5272              JMP DVOPS       /GREATER THAN REM. -- ADJ. QUOT
1241  3775              DCA ACH         /OK - DO (REM-(Q*OPL))/OPH
1242  4326      DVL3,   JMS DV24        /DIVIDE BY OPH
1243  1023      DVL1,   TAD AC1         /GET QUOT OF FIRST DIV.
1244  7500              SMA             /IF HI ORDER BIT SET, MUST SHIFT 1
1245  5264              JMP FD          /NO, ITS NORMALIZED -- DONE
1246  7100      SHR1,   CLL
1247  6211              ISZ ACM         /ROUND AND SHIFT RIGHT ONE
1250  2776
1251  7410              SKP
1252  7001              IAC             /DOUBLE PREC INCREMENT
1253  7010              RAR
1254  3775              DCA ACH         /STORE IN FAC
1255  1776              TAD ACM         /SHIFT LOW ORDER RIGHT
1256  7010              RAR
1257  3776              DCA ACM         /STORE BACK
1260  2777              ISZ ACL         /BUMP EXPONENT
1261  7000              NOP
1262  1775              TAD ACH
1263  5244              JMP DVL1#
 
1264  6211      FD,     DCA ACH         /STORE HIGH ORDER RESULT
1265  3775
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE 19

1266  5774              JMP MDONE
 
1267  6211      DVL2,   DCA ACM         /COME HERE IF LO QUO=0
1270  3776
1271  5242              JMP DVL3        /SAVE SOME TIME
 
                /ROUTINE TO ADJUST QUOTIENT OF FIRST DIVIDE (MAYBE)
                /WHEN REMAINDER OF THE FIRST DIVIDE IS LESS THAN QUO*OPL
 
1272  7041      DVOPS,  CMA IAC         /NEGATE AND STORE REVISED REM.
1273  6211              DCA ACH
1274  3775
1275  7100              CLL
1276  1025              TAD OPH
1277  1775              TAD ACH         /WATCH FOR OVERFLOW
1300  7420              SNL
1301  5306              JMP DVOP1       /OVERFLOW -- DONT ADJUST QUOT
1302  3775              DCA ACH         /NO OVRFLW, STORE NEW REM.
1303  7040              CMA             /SUBTRACT 1 FROM QUOT OF
1304  1023              TAD AC1         /FIRST DIVIDE
1305  3023              DCA AC1
1306  7300      DVOP1,  CLA CLL
1307  6211              TAD ACH         /GET HI ORD OF REMAINDER
1310  1775
1311  7450              SNA             /IS IT ZERO?
1312  4051      DVOP2,  DCA ACM         /YES, MAKE WHOLE THING ZERO
1313  7410
1314  3776
1315  3775              DCA ACH
1316  4326              JMS DV24        /DIVIDE EXTENDED REM BY HI DIVISOR
1317  6211              TAD ACM         /NEGATE THE RESULT
1320  1776
1321  7141              CLL CMA IAC
1322  3776              DCA ACM
1323  7420              SNL             /IF QUOT. IS NON-ZERO, SUBTRACT
1324  7040              CMA             /ONE FROM HI ORDER QUOT.
1325  5243              JMP DVL1
 
1326  0000      DV24,   0
1327  1025              TAD OPH
1330  7041              CIA
1331  3340              DCA DV24A       /STORE DIVISOR
1332  6211              TAD ACM         /GET LOW
1333  1776
1334  7421              MQL
1335  1775              TAD ACH
1336  7100              CLL             /CLEAR OVRFLO INDICATOR
1337  7407              DVI
1340  0000      DV24A,    0
1341  6211              DCA ACH         /REM
1342  3775
1343  7430              SZL             /OVRFLO
1344  5351              JMP DBAD        /YES
1345  7501              MQA
1346  3776              DCA ACM         /QUOTIENT
1347  3024              DCA AC2         /RETURN WITH AC2=0
1350  5726              JMPI DV24
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE 20

 
1351  4033      DBAD,   CALL 1, ERROR
1352  0116 06
1353  6201 05           ARG DIVZ
1354  0222 01
1355  7350              CLA CLL CMA RAR
1356  6211              DCA ACH
1357  3775
1360  7350              CLA CLL CMA RAR
1361  3777              DCA ACL
1362  5773              JMP FRETF
1363  1047 01   MDSETI, MDSET
 
1364  7430      FIXZR,  SZL
1365  7041              CIA
1366  7421              MQL             /SAVE AC
1367  3776              DCAI (21
1370  5772              JMP FIXZZ
 
                /*******
1372  1170 01
1373  0320 01
1374  1037 01
1375  0020
1376  0021
1377  0022
                END
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE 21

 
 
ABS     0322EXT
ACSR    0617
ACSRA   0655
ACSRB   0643
ACSRI   0430
AC0002  7326ABS
AC1     0023ABS
AC2     0024ABS
AC7775  7346ABS
AC7776  7344ABS
ASR     7415ABS
BCI     0642
CHS     1160EXT
CHS1    1166
CLAMQA  7701ABS
DBAD    1351
DCAI    3400OP
DIVZ    0222
DOADD   0420
DVI     7407ABS
DVL1    1243
DVL2    1267
DVL3    1242
DVOPS   1272
DVOP1   1306
DVOP2   1312
DVXX    1223
DV24    1326
DV24A   1340
ERROR   0000EXT
FABS    0552
FABSI   0327
FACR    0425
FAD     0200EXT
FADX    0203
FD      1264
FDV     0224EXT
FFADD   0401
FFADDI  0205
FFDIV   1200
FFDIVI  0231
FFMPY   1000
FFMPYI  0221
FFNEG   1146
FFNEGI  1100
FFNOR   0507
FFNORR  0521
FFSUB   0400
FFSUBI  0213
FIX     0667EXT
FIXERR  0722
FIXL    0677
FIXP    0706
FIXR    0715
FIXXI   0372
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE 22

FIXZR   1364
FIXZZ   1170
FLOAT   0355EXT
FLOT    0732EXT
FLOTX   0744
FLOTXI  0363
FMP     0214EXT
FRETF   0320
FSB     0206EXT
FXER    0665
GETADD  0232
GETAF1  0243
GETAF2  0260
GETARG  0257
IFAD    0343EXT
IFIX    0364EXT
IFM1    0551
IFNOR   1102
IFN2    0523
ISTO    0331EXT
ISZI    2400OP
JMPI    5400OP
JMSI    4400OP
K7740   0702
LEV     1074
LSR     7417ABS
MDONE   1037
MDSET   1047
MDSETI  1363
MDS1    1057
MOPFAC  0557
MPY1    1045
MP24    1103
MP24A   1113
MP24B   1132
MP24OU  1144
MQA     7501ABS
MQL     7421ABS
MQLMUY  7425ABS
MQLSHL  7433ABS
MSIGN   1076
NMI     7411ABS
NX1     0545
OADD    0600
OADDI   0431
OPH     0025ABS
OPL     0026ABS
OPNEG   0432
OPNEGI  1077
OPSR    0443
OPSRA   0500
OPSRB   0465
OPSRC   0466
OPX     0027ABS
PNT     0330
PNT2    0010ABS
RDF     6214ABS
/ MODE A EAE MATH PACKAGE             JAN 27, 1976              PAGE 23

REPLC   0555
SCA     7441ABS
SHL     7413ABS
SHR1    1246
SHR1I   1101
SIGN    0732
STO     0271EXT
STOAF2  0305
STOX    0274
STOX1   0314
TADI    1400OP
 
