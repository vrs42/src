
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE  1

                /  USES EAE AND 23 BIT F.P. FORMAT
                /  MODIFIED BY:
                /       PHILLIP SIEMENS
                /       LAWRENCE LIVERMORE LABS
                /       FEBRUARY 4, 1975
                /
                /
                /
                /
                /
      7425              ABSYM MQLMUY 7425
      7501              ABSYM MQA 7501
      7701              ABSYM CLAMQA 7701
      7421              ABSYM MQL 7421
      7417              ABSYM LSR 7417
      7413              ABSYM SHL 7413
      7427              ABSYM MQLDVI 7427
 
      0023              ABSYM SACH 23
      0024              ABSYM SACM 24
      0025              ABSYM SACL 25
      0175              ABSYM N2 175            /LAST ACCUMULATED NUMBER
      0176              ABSYM ARGUMT 176
 
                        ENTRY   READ
                        ENTRY   WRITE
                        ENTRY   IOH
                /
                /       FOR FAST TIMING
                /
      1400              OPDEF TADI 1400
      3400              OPDEF DCAI 3400
      0400              OPDEF ANDI 0400
      5400              OPDEF JMPI 5400
      4400              OPDEF JMSI 4400
      2400              OPDEF ISZI 2400
      4000              SKPDF JMSKP 4000
                        LAP
 
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE  2

0200  0000      A2,     BLOCK   14
0201  0000
0202  0000
0203  0000
0204  0000
0205  0000
0206  0000
0207  0000
0210  0000
0211  0000
0212  0000
0213  0000
                /       IOH ERROR ROUTINES
0214  0000      ERRNO,  BLOCK   1
0215  6201 05   ERR2,   ISZ     WHI     /SEE IF THIS WAS I FORMAT OR THE EXPONE
0216  2777
0217  2214      ERR3,   ISZ     ERRNO   /IN E FORMAT
0220  2214              ISZ     ERRNO
0221  7410              SKP
0222  2241      ERR1,   ISZ     DV      /ERR1 IS ALWAYS FATAL
0223  7200              CLA
0224  1241              TAD     DV
0225  7650              SNA CLA         /WAS THIS AN INPUT ERROR FROM THE TELET
0226  7330              CLA CLL CML RAR /YES - NON-FATAL
0227  1376              TAD     (615
0230  3261              DCA     IO
0231  1214              TAD     ERRNO   /IOH ERROR NUMBER
0232  1375              TAD     (2461   /MAKE INTO BCD
0233  3262              DCA     SW      /TO ERROR COMMENT
0234  4033              CALL    1,ERROR
0235  0104 06
0236  6201 05           ARG     IO
0237  0261 01
0240  5254              JMP     RETRY   /DO ENTIRE READ STATEMENT OVER
0241  0000      DV,     0               /SAVE DEVICE CODE
0242  0200 01   CS,     A2              /INITIAL PUSH POINTER
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE  3

0243  0000      PARN,   0
0244  7000              NOP             /CDF N
0245  1664              TADI    WRITE#
0246  2264              INC     WRITE#
0247  6201 05           JMP I   PARN
0250  5643
0251  0000      CH,     0
0252  6140      READ,   6140            /ENTRY POINT FOR READ
0253  0002              0002
0254  1252      RETRY,  TAD     READ    /SNEAK IN
0255  3263              DCA     WRITE
0256  1253              TAD     READ#
0257  3264              DCA     WRITE#  /SAVE SECOND RETURN WORD
0260  5266              JMP     ET
 
0261  0000      IO,     0
0262  0000      SW,     0               /LEFT OR RIGHT HALF OF FORMAT
0263  6140      WRITE,  6140            /ENTRY POINT
0264  0002              0002
0265  7201              CLA IAC         /INITIALIZE SWITCH
0266  3261      ET,     DCA     IO      /0 = READ  1 = WRITE
0267  3251              DCA     CH      /CLEAR CHARACTER
0270  3214              DCA     ERRNO   /ZERO ERROR NUMBER IN CASE ERROR RESTAR
0271  1263              TAD     WRITE
0272  3244              DCA     PARN#
0273  4243              JMS     PARN
0274  3277              DCA     DEVNO1
0275  4243              JMS     PARN
0276  3007              DCA     7
0277  7000      DEVNO1, NOP             /CDF N
0300  7240              CLA CMA
0301  1407              TADI    7       /PICK UP DEVICE NUMBER
0302  7112              CLL RTR         /ROTATE IT INTO BITS 0-3
0303  7012              RTR
0304  7010              RAR
0305  3241              DCA     DV
0306  1242              TAD     CS      /INITIALIZE PUSH STACK
0307  6201 05           DCA     PUSH    /-
0310  3774
0311  4243              JMS     PARN
0312  3337              DCA     FPNT01
0313  4243              JMS     PARN
0314  3330              DCA     FPNT
0315  7201              CLA IAC         /SET UP "SW" TO START FORMAT
0316  3262              DCA     SW      /FROM SECOND CHARACTER (FIRST IS LPAREN
0317  3773              DCA     BA      /ZAP END-OF-LINE SWITCH
0320  1327              TAD     PENTER  /FAKE RE-ENTRY TO SET UP FIRST LPAREN
0321  3772              DCA     GLST    /ON PUSHDOWN STACK
0322  7326              CLA CLL CML RTL
0323  1263              TAD     WRITE
0324  3325              DCA     WRZZ
0325  7402      WRZZ,   HLT
0326  5664              JMPI    WRITE#
0327  0517 01   PENTER, FENTER
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE  4

0330  0000      FPNT,   0
0331  0000      GFRM,   0
0332  1262              TAD     SW
0333  2262              INC     SW
0334  7110              CLL RAR
0335  1330              TAD     FPNT    /FORM ADDRESS IN AC AND LEFT/RIGHT
0336  3007              DCA     7       /SWITCH IN LINK
0337  7000      FPNT01, NOP             /CDF N
0340  1407              TADI    7
0341  7430              SZL             /LEFT OR RIGHT?
0342  5346              JMP     HR
0343  7012              RTR
0344  7012              RTR
0345  7012              RTR
0346  0371      HR,     AND     (77
0347  6201 05           JMP I   GFRM
0350  5731
0351  0000              0               /I1000
0352  0000              0               /I100
0353  0000              0               /I10
0354  0000      I1,     0               /I1
0355  4000              4000
0356  0000      SV,     BLOCK 3         /FLOATING POINT TEMPORARY
0357  0000
0360  0000
0361  2400      TN,     2400            /10.0
0362  0000              0
0363  0004              4
0371  0077
0372  1600 01
0373  1262 01
0374  0501 01
0375  2461
0376  0615
0377  2327 01
                PAGE
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE  5

0400  3023      RETN,   DCA     SACH            /SET SACH TO 0
0401  4777      RTUR,   JMS     GFRM            /GET NEXT CHAR IN FORMAT
                        CPAGE 24
0402  4776              JMS     CHTYPE  /CLASSIFY FORMAT CHARACTER
0403  0453 01           DG              /DIGIT EXIT
0404  7721              -57;    SL
0405  0440 01
0406  7722              -56;    PER
0407  0546 01
0410  7724              -54;    CM
0411  0435 01
0412  7727              -51;    RPAR
0413  0502 01
0414  7730              -50;    LP
0415  0455 01
0416  7731              -47;    QT
0417  0443 01
0420  7740              -40;    RTUR
0421  0401 01
0422  0000              0;      SVCHR
0423  0424 01
0424  6201 05   SVCHR,  DCA     CH
0425  3775
0426  4774              JMS     NU              /GET THE ACCUMULATED NUMBER
0427  7040              CMA                     /KRONK IT
0430  3237              DCA     N1              /AND SAVE       COUNT FOR ALL C
0431  1775              TAD     CH
0432  0373              AND     (7757
0433  1372              TAD     (7770           /THIS TESTS IF CH IS AN ,X, OR
0434  7650              SNA CLA
0435  4771      CM,     JMS     PR              /IT WAS , PROCESS IT
0436  5200              JMP     RETN            /NOT X OR H, KILL NUMBER AND TR
0437  0000      N1,     0
 
0440  4771      SL,     JMS     PR              /GO PROCESS THE PREVIOUS ITEM (
0441  4770              JMS     EJ
0442  5200              JMP     RETN
0443  4771      QT,     JMS     PR              /PROCESS PREVIOUS ITEM, IF ANY
0444  4777      QT1,    JMS     GFRM
0445  1367              TAD     (-47
0446  7450              SNA                     /ANOTHER QUOTE?
0447  5200              JMP     RETN
0450  1366              TAD     (47
0451  4765              JMS     PRINT           /PRINT CHAR
0452  5244              JMP     QT1
0453  4764      DG,     JMS     DGT             /ACCUMULATE DIGIT INTO SACH
0454  5201              JMP     RTUR            /TRY ANOTHER CHARACTER
0455  2301      LP,     ISZ     PUSH            /LEFT PAREN
0456  7240              CLA CMA                 /COUNT NESTING DEPTH, NEGATIVE
0457  1353              TAD     NPAR
0460  3353              DCA     NPAR
0461  6201 05           TAD     SW              /PICK UP THE FORMAT POINTER
0462  1763
0463  3701              DCA I   PUSH            /CRAM IT INTO THE LIST
0464  2301              ISZ     PUSH            /KICK AGAIN
0465  4774              JMS     NU              /THERE MAY BE AN ACCUMULATED NU
0466  7041              CIA                     /SAVE NUMBER
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE  6

0467  3701              DCA I   PUSH            /*
0470  7326              CLA CLL CML RTL         /HERE WE SEE IF THIS IS A POSSI
0471  1353              TAD     NPAR            /RESTART POINT
0472  7710              SPA CLA                 /IF FIRST SAVE SW IN S1
0473  5200              JMP     RETN            /NOPE- FORGET IT
0474  1763              TAD     SW              /YES--FIRST CRAM FORMAT---
0475  3351              DCA     S1              /---INTO SAVE1
0476  1701              TAD I   PUSH            /AND THAT STUFF IN THE LIST---
0477  3352              DCA     S2              /---GOES INTO SAVE 2
0500  5200              JMP     RETN            /READY FOR ANYTHING, HERE WE GO
0501  0000      PUSH,   0               /PARENTHESIS PUSHDOWN LIST POINTER
 
0502  4771      RPAR,   JMS     PR              /PROCESS PREVIOUS ITEM, IF ANY
0503  2701              ISZ I   PUSH
0504  5336              JMP     TR
0505  7344              CLA CLL CMA RAL         /-2
0506  1301              TAD     PUSH            /DELETE THIS ITEM FORM THE LIST
0507  3301              DCA     PUSH            /PUSH = PUSH-2
0510  2353              ISZ     NPAR            /NPAR = NPAR +1 ]-1[ SINCE MINU
0511  5200              JMP     RETN
0512  4762              JMS     WH              /THIS PAREN WAS THE BALANCING P
0513  1351              TAD     S1              /GET THE FORMAT POINTER OF THE-
0514  3763              DCA     SW              /RESTART POINT AND CRAM IT
0515  1352              TAD     S2              /GET SWITCH AND THE COUNT
0516  7041              CIA
0517  3023      FENTER, DCA     SACH
0520  7240              CLA CMA
0521  6201 05           TAD     SW              /TEST TO SEE IF SW IS ORIGINAL
0522  1763
0523  7650              SNA CLA
0524  5334              JMP     L2              /YES - FAKE A RESTART
0525  2301              ISZ     PUSH            /NO - PUSH ORIGINAL POINTER
0526  7201              CLA IAC                 /SINCE WE ARE RETURNING TO DEPT
0527  3701              DCA I   PUSH
0530  2301              ISZ     PUSH
0531  7240              CLA CMA                 /SET COUNT = 1, SWITCH = 1
0532  3701              DCA I   PUSH
0533  7040              CMA
0534  3353      L2,     DCA     NPAR            /PARNRN = -1
0535  5255              JMP     LP
 
0536  7240      TR,     CLA CMA                 /GET OUT THE FORMAT POINTER--
0537  1301              TAD     PUSH            /*
0540  3345              DCA     N3
0541  6201 05           TAD I   N3
0542  1745
0543  3763              DCA     SW              /HAA-- IT IS NOW RESTORED
0544  5200              JMP     RETN            /AWAY WE GO
0545  0000      N3,     0                       /W FOR E AND F CONVER
0546  4774      PER,    JMS     NU              /GOT A PERIOD, MUST BE  OR F TY
0547  3345              DCA     N3
0550  5200              JMP     RETN
0551  0000      S1,     0
0552  0000      S2,     0                       /SAVE THE COUNT AND SWITCH
0553  0000      NPAR,   0
0562  1231 01
0563  0262 01
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE  7

0564  2330 01
0565  1217 01
0566  0047
0567  7731
0570  1237 01
0571  2000 01
0572  7770
0573  7757
0574  2035 01
0575  0251 01
0576  1660 01
0577  0331 01
                PAGE
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE  8

 
0600  4777      EX,     JMS     GLST            /THIS IS E FORMAT CONVERSION
0601  4776      EE,     JMS     NR      /CHECK IF INPUT - IF NOT, GET NUMBER IN
0602  1775              TAD     C
0603  3777              DCA     GLST            /STORE C AWAY IN A SAFE PLACE
0604  3775              DCA     C
0605  7240              CLA CMA
0606  3236              DCA     EFLG            /SET "E FORMAT FAKEOUT" FLAG
0607  1374              TAD     (-5
0610  5247              JMP     FFAKE           /FAKE OUT "F" FORMAT TO PRINT D
0611  1373      PRNTE,  TAD     (5              /PUT OUT THE E
0612  4772              JMS     PRINT
 
 
                /       NOW PRINT 'C' DIGITS UNDER I3 FORMAT
0613  1777              TAD     GLST
0614  7710              SPA CLA
0615  7344              CLA CLL CMA RAL
0616  1371              TAD     (55
0617  4772              JMS     PRINT           /PRINT A MINUS OR PLUS
0620  1777              TAD     GLST
0621  7510              SPA
0622  7041              CIA
0623  7427              MQLDVI
0624  0012                12
0625  3235              DCA     ETEM
0626  7501              MQA
0627  1370              TAD     (60
0630  4772              JMS     PRINT           /PRINT
0631  1235              TAD     ETEM
0632  1370              TAD     (60
0633  4772              JMS     PRINT           /PRINT SECOND DIGIT
0634  5200              JMP     EX              /DONE, DO NEXT
0635  0000      ETEM,   0
0636  0000      EFLG,   0
0637  0000      CRX,    0
 
0640  7200      FX,     CLA
0641  4777              JMS     GLST            /THIS IS F      FORMAT CONVERSI
0642  4776      FF,     JMS     NR      /CHECK IF INPUT - IF NOT, GET NUMBER IN
0643  3236              DCA     EFLG
0644  1775              TAD     C               /C CONTAINS NUMBER OF MULTS TO
0645  7500              SMA
0646  7240              CLA CMA                 /0 MULTS NEEDED OR ALREADY THER
0647  6201 05   FFAKE,  TAD     N3              /NUM3 IS THE FIELD WIDTH
0650  1767
0651  7041              CIA                     /MINUS SPACE FOR DADP+DP
0652  1175              TAD     N2
0653  4323              JMS     SA              /PUT OUT REQUIRED BLANKS + SIGN
0654  1775              TAD     C
0655  7500              SMA
0656  5317              JMP     PRZRO   /NO LEADING DIGIT - PRINT A ZERO FOR LO
0657  7041              CIA
0660  4766              JMS     DT
0661  1365      PRDCPT, TAD     (56
0662  4772              JMS     PRINT
0663  1775              TAD     C               /GET MULTIPLY COUNT
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE  9

0664  7550              SPA SNA
0665  5310              JMP     PAS2
0666  7040              CMA                     /THEY WERE MULTIPLIES, 0 TO N O
0667  3237              DCA     CRX
0670  1175              TAD     N2              /DIGITS AFTER DEC POINT, DADP
0671  7040              CMA
0672  3776              DCA     NR
0673  5276              JMP     PASA            /TEST FOR 0 MULTIPLIES
0674  1370      RETR,   TAD     (60             /PUT OUT A ZERO
0675  4772              JMS     PRINT           /ALL MULTIPLIES REPRESENTED
0676  2237      PASA,   ISZ     CRX             /NO, TRY RUN OFF FIELD
0677  7410              SKP
0700  5304              JMP     PASS            /YES
0701  6201 05           ISZ     NR              /ALL WIDTH ACCOUNTED FOR%
0702  2776
0703  5274              JMP     RETR            /NO, TRY NEXT POSITION
 
 
0704  6201 05   PASS,   TAD     C               /YES, GET MULT COUNT
0705  1775
0706  7041              CIA                     /-MULT COUNT
0707  7410              SKP
0710  7200      PAS2,   CLA
0711  1175              TAD     N2              /N2-MULT COUNT
0712  7540              SMA SZA                 /IS MULT COUNT .GE. N2?
0713  4766              JMS     DT              /NO - PRINT REMAINING DIGITS
0714  2236              ISZ     EFLG            /WERE WE FAKED OUT BY "E" FORMA
0715  5240              JMP     FX              /NO
0716  5211              JMP     PRNTE           /YES - GO PRINT EXPONENT
0717  7200      PRZRO,  CLA
0720  1370              TAD     (60
0721  4772              JMS     PRINT
0722  5261              JMP     PRDCPT          /GO BACK TO PRINT THE DECIMAL P
 
0723  0000      SA,     0
0724  6201 05           TAD     SN
0725  1764
0726  7500              SMA                     /THIS IS -(NUM OF BLANKS)
0727  5763              JMP     AS3             /POSITIVE, NUMBER TOO BIG FOR F
0730  3237              DCA     CRX
0731  7610              SKP CLA
0732  4772      RETC,   JMS     PRINT           /HERE WE PUT OUT THAT MANY BLAN
0733  1362              TAD     (40
0734  2237              ISZ     CRX
0735  5332              JMP     RETC            /YES
0736  7200              CLA
0737  1764              TAD     SN
0740  7650              SNA CLA                 /IS SIGN MINUS?
0741  5723              JMP I   SA              /EVIDENTLY NOT
0742  1371              TAD     (55
0743  4772              JMS     PRINT           /PUT OUT A MINUS SIGN
0744  5723              JMP I   SA
 
0762  0040
0763  2145 01
0764  1534 01
0765  0056
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 10

0766  1713 01
0767  0545 01
0770  0060
0771  0055
0772  1217 01
0773  0005
0774  7773
0775  1535 01
0776  1400 01
0777  1600 01
                PAGE
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 11

1000  4045      FN,     TAD     N3      /GET WIDTH, INPUT FOR E OR F FORMAT
1001  7410
1002  1777
1003  7040              CMA             /1'S COMPLEMENT
1004  3312              DCA     CR      /TO COUNTER
1005  3307              DCA     D1      /0 TO D1
1006  6211              DCA     ACH     /CLEAR FAC LOCALLY
1007  3776
1010  3775              DCA     ACM
1011  3774              DCA     ACL
1012  7040              CMA
1013  3310              DCA     D2      /-1 TO DECIMAL POINT SWITCH
1014  7040              CMA             /-0 TO SGN FLAG
1015  6201 05   RRTSGN, DCA     SN
1016  3773
1017  7200      RRT,    CLA
1020  2312              ISZ     CR      /INDEX TO SEE IF WIDTH EXCEEDED
1021  7410              SKP
1022  5271              JMP     FP      /GET AN INPUT CHARACTER AND TEST IT
1023  4772              JMS     GCHR
                        CPAGE 20
1024  4771              JMS     CHTYPE  /CLASSIFY INPUT CHAR
1025  1042 01           FDIGIT          /DIGIT
1026  7722              -56;    PUNT
1027  1064 01
1030  7740              -40;    RRT
1031  1017 01
1032  7725              -53;    RRT
1033  1017 01
1034  7723              -55;    RRTSGN
1035  1015 01
1036  7773              -5;     EPRO
1037  1070 01
1040  0000              0
1041  0217 01   PERR3,  ERR3
1042  3311      FDIGIT, DCA     IS
1043  4033              CALL    1,FMP
1044  0105 06
1045  6201 05           ARG     TN
1046  0361 01
1047  4033              CALL    1,STO   /SAVE FLOATING POINT ACCUMULATOR
1050  0106 06
1051  6201 05           ARG     SV
1052  0356 01
1053  1311              TAD     IS
1054  4033              CALL    0,FLOT  /FLOAT NEW DIGIT
1055  0007 06
1056  4033              CALL    1,FAD
1057  0110 06
1060  6201 05           ARG     SV
1061  0356 01
1062  2307              INC     D1      /COUNT OF DIGITS
1063  5217              JMP     RRT
1064  2310      PUNT,   ISZ     D2      /TST DP SWITCH
1065  5641              JMPI    PERR3   /***** TWO DECIMAL POINTS *****
1066  3307              DCA     D1
1067  5217              JMP     RRT
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 12

1070  7240      EPRO,   CLA CMA         /AN E
1071  3311      FP,     DCA     IS      /-1 TO IS IF E, 0 TO IS IF END OF FIELD
1072  2310              ISZ     D2      /TEST DP SWITCH
1073  5276              JMP     FA      /ONE HAS OCCURRED
1074  1175              TAD     N2      /ONE HAS NOT OCCURRED, GET NDP
1075  7410              SKP
1076  1307      FA,     TAD     D1      /COUNT OF DIGITS AFTER EXPLICIT DP
1077  7040              CMA             /-COUNT
1100  4770              JMS     DH      /DIVIDE FPAC BY TEN COUNT TIMES
1101  2773              ISZ     SN      /TEST SIGN
1102  4033              CALL 0, CHS     /MAKE IT NEGATIVE
1103  0011 06
1104  2311              ISZ     IS      /DID WE GET AN "E"?
1105  5331              JMP     VZA     /NO - STORE RESULT AND GET OUT
1106  5767              JMP     VQ      /YES - FAKE INTEGER ROUTINE TO ACCEPT E
1107  0000      D1,     0
1110  0000      D2,     0
1111  0000      IS,     0
1112  0000      CR,     0
 
1113  7040      PRO2,   CMA             /GOT EXPONENT - MAKE IT NEGATIVE
1114  6201 05           ISZ     SN      /WHAT WAS ITS ORIGINAL SIGN?
1115  2773
1116  5330              JMP     VZB     /NEGATIVE - DIVIDE BY 10^EXP
1117  3307              DCA     D1      /SAVE COUNT
1120  5325              JMP     VZD
1121  4033      VZC,    CALL    1,FMP
1122  0105 06
1123  6201 05           ARG     TN
1124  0361 01
1125  2307      VZD,    ISZ     D1      /INDEX COUNT
1126  5321              JMP     VZC
1127  5331              JMP     VZA
1130  4770      VZB,    JMS     DH
1131  4033      VZA,    CALL    1,ISTO  /STORE IN PLACE
1132  0112 06
1133  6201 05           ARG     ARGUMT
1134  0176
1135  5766              JMP     FX
 
1136  4765      GD11,   JMS     SE
1137  6211              ISZ     ACM     /ROUND A LITTLE BIT
1140  2775
1141  5764              JMP     GD
1142  2776              ISZ     ACH
1143  1776              TAD     ACH
1144  7700              SMA CLA
1145  5764              JMP     GD
1146  7132              CLL CML RTR
1147  3776              DCA     ACH
1150  2774              ISZ     ACL
1151  7000              NOP
1152  5336              JMP     GD11
 
1164  1473 01
1165  1536 01
1166  0640 01
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 13

1167  2205 01
1170  2132 01
1171  1660 01
1172  1270 01
1173  1534 01
1174  0022
1175  0021
1176  0020
1177  0545 01
                PAGE
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 14

1200  4777      XX,     JMS     MR              /TEST FOR MORE
1201  6201 05           TAD     IO              /TEST FOR INPUT-OUTPUT
1202  1776
1203  7650              SNA CLA
1204  5210              JMP     XX1             /INPUT, PSEUDO-JUMP
1205  1375              TAD     (40             /OUTPUT A BLANK
1206  4217              JMS     PRINT
1207  5200              JMP     XX              /CYCLE
1210  4270      XX1,    JMS     GCHR            /IGNORE SPACES ON INPUT
1211  7200              CLA
1212  5200              JMP     XX
 
1213  4777      HH,     JMS     MR      /THE H FIELD PROCESSOR
1214  4774              JMS     GFRM    /SAME AS XXX, BUT PRINT NEXT
1215  4217              JMS     PRINT   /----- FORMAT CHARACTER
1216  5213              JMP     HH      /OUTPUT ONLY
 
1217  0000      PRINT,  0
1220  1373              TAD     (-40
1221  7510              SPA
1222  1372              TAD     (100            /CONVERT 6-BIT TO 8-BIT
1223  1371              TAD     (240
1224  6201 05           TAD     DV              /ADD ON DEVICE NUMBER IN BITS 0
1225  1770
1226  4033              CALL    0,GENIO
1227  0013 06
1230  5617              JMP I   PRINT
 
1231  0000      WH,     0
1232  4237              JMS     EJ      /END THE RECORD
1233  1177              TAD     ARGUMT#
1234  7650              SNA CLA         /TEST PARAMETER FOR 0
1235  4767              JMS     GLST    /RETURN TO MAIN PROGRAM ON 0 PAR
1236  5631              JMP I   WH      /MORE AGRUMENTS RETURN
 
1237  0000      EJ,     0                       /ROUTINE TO END RECORD
1240  6201 05           TAD     IO
1241  1776
1242  7640              SZA CLA                 /INPUT OR OUTPUT?
1243  5255              JMP     E1              /OUTPUT
1244  7200      E2,     CLA
1245  1262              TAD     BA
1246  7640              SZA CLA
1247  5252              JMP     BG              /CARRIAGE RETURN SEEN - GOODBYE
1250  4270              JMS     GCHR            /GET A CHARACTER
1251  5244              JMP     E2              /KEEP LOOKING FOR CR
1252  3262      BG,     DCA     BA
1253  6201 05           JMP I   EJ
1254  5637
1255  1366      E1,     TAD     (7715           /7715 TRANSLATES TO 215
1256  4217              JMS     PRINT
1257  1365              TAD     (7712
1260  4217              JMS     PRINT           /PRINT CR-LF
1261  5637              JMP I   EJ
 
1262  0000      BA,     0               /THIS IS THE END OF LINE SWITCH
1263  2262      BH,     ISZ     BA      /ENTRY TO LOOK FOR AN END OF LINE
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 15

1264  1375      BL,     TAD     (40
1265  0364              AND     (77             /KEEP THIS - BL IS REFERENCED B
1266  6201 05           JMP I   GCHR
1267  5670
 
1270  0000      GCHR,   0               /GET AN INPUT STRING CHARACTER
1271  7200      JD,     CLA
1272  1262              TAD     BA      /GET EOR SWITCH
1273  7640              SZA CLA
1274  5264              JMP     BL      /IS EOR, RETURN BLANK
1275  1363              TAD     (2400           /****** IF # OF DEVICES IS CHAN
1276  6201 05           TAD     DV              /THIS SHOULD BE CHANGED TOO ***
1277  1770
1300  4033              CALL    0,GENIO         /CALL GENIO WITH OFFSET DEVICE
1301  0013 06
1302  0362              AND     (177            /STRIP PARITY
1303  1361              TAD     (7763
1304  7450              SNA                     /CARRIAGE RETURN?
1305  5263              JMP     BH
1306  1360              TAD     (7655
1307  7100              CLL
1310  1372              TAD     (100            /IS CHAR IN RANGE 237<CHAR<340?
1311  7420              SNL
1312  5271              JMP     JD              /NO - IGNORE
1313  5264              JMP     BL              /CONVERT TO SIXBIT AND RETURN
1360  7655
1361  7763
1362  0177
1363  2400
1364  0077
1365  7712
1366  7715
1367  1600 01
1370  0241 01
1371  0240
1372  0100
1373  7740
1374  0331 01
1375  0040
1376  0261 01
1377  2027 01
                        PAGE
                /     GET F.P. NUMBER INTO THE RANGE    .1 .LE. N .L. 1.0
1400  0000      NR,     0
1401  4777              JMSKP   BB      /CHECK DIRECTION OF I/O
1402  5776              JMP     FN      /INPUT
1403  4033              CALL    1,IFAD  /OUTPUT - LOAD NUMBER INTO FLOATING AC
1404  0114 06
1405  6201 05           ARG     ARGUMT
1406  0176
1407  3334              DCA     SN      /CLEAR THESE LOCS
1410  3335              DCA     C
1411  6211              TAD     ACH
1412  1775
1413  7450              SNA
1414  5326              JMP     ZP      /NUMBER IS ZERO
1415  7700              SMA CLA         /IS IT A MINUS F P NUMBER
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 16

1416  5222              JMP     RETM
1417  4033              CALL 0, CHS     /YES -- MAKE IT POSITIVE
1420  0011 06
1421  2334              ISZ     SN      /SET SIGN
1422  7240      RETM,   CLA CMA         /MULTIPLY BY 10 UNTIL NR .GT. (1.0)
1423  6211              TAD     ACL
1424  1774
1425  7700              SMA CLA
1426  5235              JMP     TB      /GOT IT IT IS .GE.1
1427  4033              CALL    1,FMP
1430  0105 06
1431  6201 05           ARG     TN
1432  0361 01
1433  2335              ISZ     C       /AND COUNT
1434  5222              JMP     RETM    /GO TRY TO DO IT AGAIN
1435  4336      TB,     JMS     SE      /NOTE SE ' XR-1
1436  4033              CALL    1,STO
1437  0106 06
1440  6201 05           ARG     SV
1441  0356 01
1442  7332              CLA CLL CML RTR
1443  6211              DCA     ACH     /200000000000=.50000 IN AC
1444  3775
1445  6201 05           TAD     CH      /TEST FORMAT
1446  1773
1447  1372              TAD     (7772
1450  7650              SNA CLA         /IS IT E FORMAT?
1451  1335              TAD     C       /NO - COUNT # OF MULTS NEEDED
1452  7041              CIA
1453  1175              TAD     N2      /< DADP
1454  7500              SMA
1455  7040      TB12,   CMA             /NUMB. OF TIMES TO DIV .T BY 10 TO RND
1456  7421              MQL
1457  7501              MQA
1460  7100              CLL
1461  1371              TAD (10
1462  7620              SNL CLA
1463  5331              JMP TB11
1464  7501              MQA
1465  4770              JMS     DH      /DO THE DIVIDES
1466  4033              CALL    1,FAD
1467  0110 06
1470  6201 05           ARG     SV
1471  0356 01
1472  5767              JMP     GD11    /REDUCE TO NORMAL RANGE AGAIN
 
 
1473  6211      GD,     TAD ACL         /GET EXPONENT
1474  1774
1475  7500              SMA             /LT ZERO?
1476  5326              JMP ZP          /# IS < 1/2
1477  7040              CMA             /YES
1500  3316              DCA GDIO        /UNORMALIZE
1501  1316              TAD GDIO
1502  3306              DCA GDIO2
1503  7421              MQL             /CLEAR MQ
1504  1766              TAD ACM         /GET LEAST SIG FAC IN AC
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 17

1505  7417              LSR             /SAVE LS BITS
1506  0000      GDIO2,    0
1507  7701              CLAMQA
1510  3023              DCA SACH
1511  6211              TAD ACM
1512  1766
1513  7421              MQL
1514  1775              TAD ACH
1515  7417              LSR
1516  0000      GDIO,     0
1517  6211              DCA ACH
1520  3775
1521  7501              MQA
1522  3766              DCA ACM
1523  3774              DCA ACL
1524  6201 05   NREX,   JMP I   NR
1525  5600
1526  7200      ZP,     CLA
1527  3023              DCA SACH
1530  5324              JMP NREX
 
1531  1365      TB11,   TAD (7
1532  5255              JMP TB12
1533  7777      M1,     -1
1534  0000      SN,     0
 
1535  0000      C,      0                       /COUNTER FOR DEC. EXP.
1536  0000      SE,     0                       /DIVIDE BY 10 UNTIL N < 1.0
1537  7240      XR,     CLA CMA
1540  6211              TAD     ACL             /TEST NUMBER FOR .GE. 1
1541  1774
1542  7710              SPA CLA
1543  4045              JMP I   SE              /NUMBER IS IN RANGE, RETURN
1544  7410
1545  5736
1546  7344              CLA CLL CMA RAL
1547  4770              JMS     DH
1550  7240              CLA CMA                 /REDUCE COUNT
1551  1335              TAD     C
1552  3335              DCA     C
1553  5337              JMP     XR
1565  0007
1566  0021
1567  1136 01
1570  2132 01
1571  0010
1572  7772
1573  0251 01
1574  0022
1575  0020
1576  1000 01
1577  2043 01
                PAGE
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 18

1600  0000      GLST,   0               /GET NEXT ARGUMENT ROUTINE
1601  6211              DCA     ACH     /CLEAR FLOATING AC
1602  3777
1603  3776              DCA     ACM
1604  3775              DCA     ACL
1605  2257              ISZ     IOHCNT  /ARE WE IN AN ARRAY I/O LOOP?
1606  5215              JMP     ARMORE  /YES - GET NEXT ELEMENT
1607  2221              INC     IOH#
1610  7326              CLA CLL CML RTL /RETURN TO PROG. FOR MORE
1611  1220              TAD     IOH
1612  3213              DCA     IOH3
1613  7402      IOH3,   HLT
1614  5621              JMPI    IOH#
 
1615  1177      ARMORE, TAD     ARGUMT#
1616  1256              TAD     IOHINC  /BUMP ARGUMENT POINTER BY ELEMENT LENGT
1617  5235              JMP     IOHBAK  /RESUME I/O CONVERSIONS WITH UPDATED AR
 
1620  6140      IOH,    6140
1621  0002              0002
1622  7640              SZA CLA         /IS THIS A SCALAR OR AN ARRAY CALL?
1623  5240              JMP     IOHAR   /AN ARRAY CALL
1624  7240              CLA CMA
1625  3257      IOGTAR, DCA     IOHCNT  /SET UP ARGUMENT COUNT FOR THIS CALL
1626  1220              TAD     IOH
1627  3230              DCA     IOH1
1630  7000      IOH1,   NOP             /SET DATA FIELD TO ARGUMENT LIST
1631  1621              TADI    IOH#
1632  3176              DCA     ARGUMT
1633  2221              INC     IOH#
1634  1621              TADI    IOH#
1635  3177      IOHBAK, DCA     ARGUMT#
1636  6201 05           JMP I   GLST    /RETURN TO I/O CONVERSION
1637  5600
1640  1220      IOHAR,  TAD     IOH
1641  3242              DCA     IOH2
1642  7402      IOH2,   HLT
1643  2221              INC     IOH#
1644  7330              CLA CLL CML RAR
1645  0621              ANDI    IOH#    /GET TYPE OF ARRAY
1646  7106              CLL RTL
1647  7024              CML RAL         /FORM A 1 OR A 3, DEPENDING ON ARRAY TY
1650  3256              DCA     IOHINC
1651  7350              CLA CLL CMA RAR
1652  0621              ANDI    IOH#    /GET THE ELEMENT COUNT
1653  7041              CIA
1654  2221              INC     IOH#
1655  5225              JMP     IOGTAR  /SAVE IT AND GET ARRAY POINTER
1656  0000      IOHINC, 0
1657  0000      IOHCNT, 0
 
1660  0000      CHTYPE, 0               /SUBROUTINE TO CLASSIFY CHARACTERS
1661  3312              DCA     CHCH
1662  1312              TAD     CHCH
1663  1374              TAD     (7706
1664  7100              CLL
1665  1373              TAD     (12
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 19

1666  7430              SZL             /IS THE CHARACTER NUMERIC?
1667  5304              JMP     JMPOUT  /YES - TAKE FIRST EXIT
1670  2260              INC     CHTYPE
1671  7200      CHLOOP, CLA
1672  6201 05           TAD I   CHTYPE
1673  1660
1674  2260              INC     CHTYPE
1675  7450              SNA             /CHARACTER LIST EXHAUSTED?
1676  5305              JMP     JMPOTX  /YES - TAKE LAST EXIT WITH CHAR IN AC
1677  1312              TAD     CHCH
1700  7650              SNA CLA         /MATCH?
1701  5304              JMP     JMPOUT  /YES - TAKE EXIT WITH AC=0
1702  2260              INC     CHTYPE
1703  5271              JMP     CHLOOP  /NO MATCH - GO ON TO NEXT CHAR
1704  3312      JMPOUT, DCA     CHCH
1705  6201 05   JMPOTX, TAD I   CHTYPE
1706  1660
1707  3260              DCA     CHTYPE
1710  1312              TAD     CHCH
1711  5660              JMP I   CHTYPE
1712  0000      CHCH,   0
 
                /*******************
1713  0000      DT,     0
1714  7041              CIA
1715  3312              DCA     CHCH    /STORE COUNT
1716  4772              JMS     DTX     /SET UP
1717  1023      RETT,   TAD SACH        /GET LS BITS
1720  7425              MQLMUY          /MULT BY 10
1721  0012                12
1722  6211              DCA ACL
1723  3775
1724  7501              MQA
1725  3023              DCA SACH        /SAVE LS FOR NEXT TIME
1726  1776              TAD ACM         /GET MIDDLE BITS
1727  7425              MQLMUY          /MULT BY 10
1730  0012                12
1731  3025              DCA SACL
1732  7501              MQA
1733  1775              TAD ACL         /ADD
1734  3776              DCA ACM
1735  7004              RAL             /SAVE CARRY
1736  3260              DCA CHTYPE
1737  1777              TAD ACH         /GET MS BITS
1740  0371              AND (3777       /MASK OFF GARBAGE
1741  7425              MQLMUY
1742  0012                12
1743  3024              DCA SACM
1744  7501              MQA
1745  1260              TAD CHTYPE      /ADD POSSIBLE CARRY
1746  1025              TAD SACL
1747  7421              MQL             /PUT IN MQ
1750  7501              MQA             /NOW GET IT BACK
1751  3777              DCA ACH
1752  7004              RAL             /GET POSSIBLE CARRY
1753  1024              TAD SACM
1754  7413              SHL             /SHIFT BCD DIGIT INTO AC
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 20

1755  0000                0
1756  1370              TAD     (60     /MAKE DIGIT
1757  4767              JMS     PRINT   /DUMP IT AND SEE IF ANY MORE
1760  4766              JMS     DTY     /CHECK FOR 6 DIGITS PRINTED
1761  2312              ISZ     CHCH    /LOOP ON COUNT
1762  5317              JMP     RETT    /*
1763  5713              JMP I   DT
1766  2346 01
1767  1217 01
1770  0060
1771  3777
1772  2342 01
1773  0012
1774  7706
1775  0022
1776  0021
1777  0020
                PAGE
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 21

2000  0000      PR,     0
2001  1023              TAD     SACH    /GET THE LAST NUMBER ACCUMULATED
2002  3175              DCA     N2      /SAVE IT
2003  6201 05   PR2,    TAD     CH
2004  1777
2005  7450              SNA
2006  5600              JMP I   PR      /NOTHING TO DO
                        CPAGE 22
2007  4776              JMS     CHTYPE  /CLASSIFY CH
2010  0222 01           ERR1            /DIGIT IS ILLEGAL
2011  7750              -30;XX
2012  1200 01
2013  7767              -11;II
2014  2251 01
2015  7770              -10;HH
2016  1213 01
2017  7772              -6;FF
2020  0642 01
2021  7773              -5;EE
2022  0601 01
2023  7777              -1;AA
2024  2055 01
2025  0000              0;ERR1
2026  0222 01
 
2027  0000      MR,     0               /MORE?
2030  6201 05           ISZ     N1      /SEE IF IT GOES TO ZERO
2031  2775
2032  5627              JMP I   MR
2033  3777              DCA     CH      /NO MORE FIELDS, FIRST WIPE CHAR
2034  5600              JMP I   PR      /GO BACK TO FORMAT SCANNER
 
2035  0000      NU,     0               /ROUTINE TO FETCH THE ACCUM NUMB
2036  1023              TAD     SACH
2037  7450              SNA             /IF IT IS ZERO, SET IT TO 1
2040  7201              CLA IAC         /IT IS AND WE DO
2041  6201 05           JMP I   NU      /GO HOME
2042  5635
2043  0000      BB,     0
2044  4227              JMS     MR      /MORE?
2045  1177              TAD     ARGUMT#
2046  7650              SNA CLA         /IF ARG=0,
2047  4774              JMS     WH      /END RECORD AND RETURN TO USERS PROGRAM
2050  1773              TAD     IO      /TEST IN OUT SWITCH
2051  7640              SZA CLA         /OUTPUT
2052  2243              INC     BB      /INPUT
2053  5643              JMP I   BB
 
2054  4772      AX,     JMS     GLST
2055  1175      AA,     TAD     N2
2056  7041              CIA
2057  3331              DCA     CX
2060  4243              JMSKP   BB
2061  5276              JMP     AR
2062  4317      AS,     JMS     GADR    /GET CHARACTER ADDRESS
2063  1407              TADI    7
2064  7430              SZL
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 22

2065  5271              JMP     ASNORT
2066  7012              RTR
2067  7012              RTR
2070  7012              RTR
2071  0371      ASNORT, AND     (77     /MASK 6 BITS
2072  4770              JMS     PRINT
2073  2331              ISZ     CX
2074  5262              JMP     AS      /LOOP FOR CHARACTER COUNT
2075  5254              JMP     AX      /GET NEXT ARGUMENT(IF ANY)
 
2076  4767      AR,     JMS     GCHR
2077  3332              DCA     DH      /GET AND SAVE INPUT CHAR
2100  4317              JMS     GADR    /GET CHARACTER POINTER
2101  1332              TAD     DH
2102  7430              SZL             /WHICH HALF?
2103  5311              JMP     ARNORT  /RIGHT HALF
2104  7001              IAC
2105  7006              RTL
2106  7006              RTL
2107  7006              RTL
2110  7410              SKP
2111  1407      ARNORT, TADI    7
2112  1366              TAD     (7740   /CANCEL BLANK CHAR
2113  3407      ARCOMN, DCAI    7
2114  2331              ISZ     CX
2115  5276              JMP     AR
2116  5254              JMP     AX
 
2117  0000      GADR,   0               /SUBR TO COMPUTE CHARACTER ADDR FOR "A"
2120  1176              TAD     ARGUMT
2121  3327              DCA     AS1
2122  1175              TAD     N2
2123  1331              TAD     CX
2124  7110              CLL RAR
2125  1177              TAD     ARGUMT# /AC=WORD POINTER, LINK=LEFT/RIGHT FLAG
2126  3007              DCA     7
2127  7000      AS1,    NOP             /SET UP DATA FIELD OF ARGUMENT
2130  5717              JMPI    GADR
2131  0000      CX,     0
 
2132  0000      DH,     0
2133  3331              DCA     CX      /DIVIDE FPAC BY TEN CX TIMES
2134  5341              JMP     DTA
2135  4033      DTB,    CALL    1,FDV
2136  0115 06
2137  6201 05           ARG     TN
2140  0361 01
2141  2331      DTA,    ISZ     CX
2142  5335              JMP     DTB
2143  6201 05           JMP I   DH
2144  5732
2145  7200      AS3,    CLA             /PRINT ASTERISKS FOR WHOLE FIELD SIZE
2146  6201 05           TAD     N3      /GET FIELD SIZE, E OR F
2147  1765
2150  7040              CMA
2151  3331              DCA     CX      /-COUNT
2152  5355              JMP     QQ
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 23

2153  1364      QQA,    TAD     (52     /PRINT CX ASTERISKS
2154  4770              JMS     PRINT
2155  2331      QQ,     ISZ     CX      /INDEX COUNT
2156  5353              JMP     QQA
2157  4772              JMS     GLST    /TEST FOR MORE
2160  5203              JMP     PR2     /RETURN TO FORMAT PROCESSOR, SAME TYPE
2164  0052
2165  0545 01
2166  7740
2167  1270 01
2170  1217 01
2171  0077
2172  1600 01
2173  0261 01
2174  1231 01
2175  0437 01
2176  1660 01
2177  0251 01
                PAGE
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 24

2200  1175      IN,     TAD     N2      /INTEGER INPUT, GET WIDTH OF FIELD
2201  7040              CMA             /1,S COMP TO COUNTER, CR
2202  6201 05           DCA     CR
2203  3777
2204  7040              CMA
2205  3327      VQ,     DCA     WHI     /-1 TO NUMBER ACCUMULATED
2206  7040              CMA             /-1 TO SIGN
2207  6201 05   RRSIGN, DCA     SN
2210  3776
2211  3023              DCA     SACH
2212  6201 05   RRS,    ISZ     CR      /HAS WHOLE NUMBER BEEN ACCUMULATED
2213  2777
2214  7410              SKP
2215  5233              JMP     PRO
2216  4775              JMS     GCHR
                        CPAGE 14
2217  4774              JMS     CHTYPE  /CLASSIFY CHARACTER
2220  2231 01           DIGIT           /ITS A DIGIT
2221  7740              -40;    RRS
2222  2212 01
2223  7725              -53;    RRS
2224  2212 01
2225  7723              -55;    RRSIGN
2226  2207 01
2227  0000              0;      ERR2
2230  0215 01
2231  4330      DIGIT,  JMS     DGT     /ACCUMULATE DIGIT INTO SACH
2232  5212              JMP     RRS     /GET NEXT DIGIT
2233  1023      PRO,    TAD     SACH    /WE HAVE AN INTEGER ...
2234  2327              ISZ     WHI     /WHAT KIND?
2235  5773              JMP     PRO2
2236  6201 05           ISZ     SN      / 'I' FORMAT
2237  2776
2240  7041              CIA
2241  7421              MQL             /SAVE IT TEMPORARILY
2242  1176              TAD     ARGUMT  /GET CDF
2243  3244              DCA     TARG1
2244  7402      TARG1,  HLT             /CHANGE TO FIELD OF ARG
2245  7501              MQA             /GET AC BACK
2246  3577              DCAI    ARGUMT#
 
2247  7200      IX,     CLA
2250  4772              JMS     GLST    /INTEGER CONVERSION
2251  4771      II,     JMSKP   BB      /TEST MORE AND NON ZERO CURRENT LIST IT
2252  5200              JMP     IN      /INPUT
2253  1326              TAD     AB
2254  3025              DCA     SACL    /OUTPUT
2255  1370              TAD     (-4
2256  3327              DCA     WHI     /-4
2257  3776              DCA     SN      /0
2260  1176              TAD     ARGUMT
2261  3262              DCA     TARG2
2262  7402      TARG2,  HLT             /CHANGE TO ARG FIELD
2263  1577              TADI    ARGUMT#
2264  7500              SMA             /SET SN 0 FOR PLUS, 1 FOR MINUS
2265  5271              JMP     XZ      /PLACE MAGNITUDE IN 20
2266  7041              CIA
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 25

2267  6201 05           ISZ     SN
2270  2776
2271  7427      XZ,     MQLDVI
2272  0012                12
2273  6201 05           DCA I   SACL    /SAVE REMAINDER
2274  3425
2275  7501              MQA
2276  3023              DCA     SACH
2277  7040              CMA
2300  1025              TAD     SACL    /SACL=SACL-1
2301  3025              DCA     SACL
2302  2327              ISZ     WHI     /INDEX COUNT
2303  1023              TAD     SACH    /AND CHECK NUM FOR 0
2304  7440              SZA
2305  5271              JMP     XZ      /CYCLE
2306  1175      IB,     TAD     N2
2307  6201 05           DCA     N3      /IN CASE OF OVERFLOW
2310  3767
2311  1175              TAD     N2
2312  7040              CMA
2313  1327              TAD     WHI
2314  1366              TAD     (4      /COMPUTE NUMBER OF LEADING BLANKS
2315  4765              JMS     SA      /PRINT LEADING BLANKS AND SIGN
2316  2025      ID,     INC     SACL    /POINT TO DIGIT TO PRINT NEXT
2317  6201 05           TAD I   SACL    /GET IT
2320  1425
2321  7510              SPA             /TERMINATOR?
2322  5247              JMP     IX      /YUP
2323  1364              TAD     (60
2324  4763              JMS     PRINT   /NOPE - PRINT THE DIGIT
2325  5316              JMP     ID
 
2326  0354 01   AB,     I1
2327  0000      WHI,    0
 
                DCX,
2330  0000      DGT,    0
2331  3024              DCA     SACM
2332  1023              TAD     SACH
2333  7106              CLL RTL
2334  1023              TAD     SACH
2335  7004              RAL
2336  1024              TAD     SACM
2337  3023              DCA     SACH
2340  6201 05           JMP I DGT
2341  5730
 
2342  0000      DTX,    0
2343  1362              TAD     (-6
2344  3330              DCA     DCX     /ONLY 6 SIGNIFICANT DIGITS
2345  5742              JMPI    DTX
 
2346  0000      DTY,    0
2347  2330              ISZ     DCX     /DONE 6
2350  5746              JMPI    DTY     /NOT YET
2351  6211              DCA     ACH     /CLEAR THINGS
2352  3761
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 26

2353  3760              DCA     ACM     /SO ONLY ZEROS ARE PRINTED
2354  3023              DCA     SACH
2355  5746              JMPI    DTY
 
2360  0021
2361  0020
2362  7772
2363  1217 01
2364  0060
2365  0723 01
2366  0004
2367  0545 01
2370  7774
2371  2043 01
2372  1600 01
2373  1113 01
2374  1660 01
2375  1270 01
2376  1534 01
2377  1112 01
                        END
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 27

 
 
AA      2055
AB      2326
ANDI    0400OP
AR      2076
ARCOMN  2113
ARGUMT  0176ABS
ARMORE  1615
ARNORT  2111
AS      2062
ASNORT  2071
AS1     2127
AS3     2145
AX      2054
A2      0200
BA      1262
BB      2043
BG      1252
BH      1263
BL      1264
C       1535
CH      0251
CHCH    1712
CHLOOP  1671
CHS     0000EXT
CHTYPE  1660
CLAMQA  7701ABS
CM      0435
CR      1112
CRX     0637
CS      0242
CX      2131
DCAI    3400OP
DCX     2330
DEVNO1  0277
DG      0453
DGT     2330
DH      2132
DIGIT   2231
DT      1713
DTA     2141
DTB     2135
DTX     2342
DTY     2346
DV      0241
D1      1107
D2      1110
EE      0601
EFLG    0636
EJ      1237
EPRO    1070
ERRNO   0214
ERROR   0000EXT
ERR1    0222
ERR2    0215
ERR3    0217
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 28

ET      0266
ETEM    0635
EX      0600
E1      1255
E2      1244
FA      1076
FAD     0000EXT
FDIGIT  1042
FDV     0000EXT
FENTER  0517
FF      0642
FFAKE   0647
FLOT    0000EXT
FMP     0000EXT
FN      1000
FP      1071
FPNT    0330
FPNT01  0337
FX      0640
GADR    2117
GCHR    1270
GD      1473
GDIO    1516
GDIO2   1506
GD11    1136
GENIO   0000EXT
GFRM    0331
GLST    1600
HH      1213
HR      0346
IB      2306
ID      2316
IFAD    0000EXT
II      2251
IN      2200
IO      0261
IOGTAR  1625
IOH     1620EXT
IOHAR   1640
IOHBAK  1635
IOHCNT  1657
IOHINC  1656
IOH1    1630
IOH2    1642
IOH3    1613
IS      1111
ISTO    0000EXT
ISZI    2400OP
IX      2247
I1      0354
JD      1271
JMPI    5400OP
JMPOTX  1705
JMPOUT  1704
JMSI    4400OP
JMSKP   4000OP
LP      0455
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 29

LSR     7417ABS
L2      0534
MQA     7501ABS
MQL     7421ABS
MQLDVI  7427ABS
MQLMUY  7425ABS
MR      2027
M1      1533
NPAR    0553
NR      1400
NREX    1524
NU      2035
N1      0437
N2      0175ABS
N3      0545
PARN    0243
PASA    0676
PASS    0704
PAS2    0710
PENTER  0327
PER     0546
PERR3   1041
PR      2000
PRDCPT  0661
PRINT   1217
PRNTE   0611
PRO     2233
PRO2    1113
PRZRO   0717
PR2     2003
PUNT    1064
PUSH    0501
QQ      2155
QQA     2153
QT      0443
QT1     0444
READ    0252EXT
RETC    0732
RETM    1422
RETN    0400
RETR    0674
RETRY   0254
RETT    1717
RPAR    0502
RRS     2212
RRSIGN  2207
RRT     1017
RRTSGN  1015
RTUR    0401
SA      0723
SACH    0023ABS
SACL    0025ABS
SACM    0024ABS
SE      1536
SHL     7413ABS
SL      0440
SN      1534
/  IOH, READ, WRITE                   FEB  6, 1976              PAGE 30

STO     0000EXT
SV      0356
SVCHR   0424
SW      0262
S1      0551
S2      0552
TADI    1400OP
TARG1   2244
TARG2   2262
TB      1435
TB11    1531
TB12    1455
TN      0361
TR      0536
VQ      2205
VZA     1131
VZB     1130
VZC     1121
VZD     1125
WH      1231
WHI     2327
WRITE   0263EXT
WRZZ    0325
XR      1537
XX      1200
XX1     1210
XZ      2271
ZP      1526
 
