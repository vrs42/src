
/ LLL UTILITY ROUTINES                FEB  6, 1976              PAGE  1

                / LLL VERSION FOR CENTRONICS 306
                / WRITTEN BY
                /       PHILLIP SIEMENS
                /       LAWRENCE LIVERMORE LABORATORY
                /       SEPTEMBER 9, 1975
 
                / INCLUDES EOF SUBROUTINE
                /       CALL EOF(RETURN LOCATION)
                /
                /       UPON FINDING AN EOF, UTILTX WILL RETURN TO
                /       THE SPECIFIED LOCATION
                /
                / DEVICE 5 IS USED FOR DECODE
                / CALL RESET(ARG) IS USED AS A REWIND AND ARG IS
                / START OF BUFFER WHICH MUST BE 120 WORDS LONG
 
                        ENTRY   EOF
                        ENTRY   OPEN            /INITIALIZING AND FLAG SETTING
                        ENTRY   GENIO
                        ENTRY   EXIT            /EXIT TO DISK MONITOR SYSTEM
                        ENTRY   ERROR
                        ENTRY   RESET
 
      6034              OPDEF   KRS     6034
      6032              OPDEF   KCC     6032
      1400              OPDEF   TADI    1400
      3400              OPDEF   DCAI    3400
      4400              OPDEF   JMSI    4400
      5400              OPDEF   JMPI    5400
 
                /LINE PRINTER IOT'S
      6667              OPDEF   LLB     6667
      6661              OPDEF   LSF     6661
      6662              OPDEF   LCF     6662
 
/ LLL UTILITY ROUTINES                FEB  6, 1976              PAGE  2

                        LAP
 
0200  0017      U17,    17              /*** MUST BE FIRST LOC IN PAGE ***
 
0201  1117      IOER,   1117
0202  0522              0522            /"IOER" ERROR
0203  6140      GENIO,  6140            /GENERAL INPUT/OUTPUT ROUTINE
0204  0002              0002
0205  3007              DCA     7       /SAVE ENTRY AC
0206  1007      GENLP,  TAD     7
0207  7006              RTL
0210  7006              RTL
0211  7004              RAL
0212  0200      U200,   AND     U17     /MUST BE AT LOC. 212!!!!!
0213  1224              TAD     JMPITB
0214  3222              DCA     DSPACH  /INDEX JUMP TABLE BY DEVICE NUMBER
0215  1212              TAD     U200
0216  6034              KRS
0217  1337              TAD     UM203
0220  7650              SNA CLA
0221  6031              KSF             /CHECK FOR ^C ON TELETYPE
0222  7000      DSPACH, NOP             /NO ^C - DISPATCH TO I/O ROUTINE
0223  5777              JMP     EXITX   /EXIT TO MONITOR
 
0224  5625      JMPITB, JMPI    DEVTAB
0225  0630 01   DEVTAB, TTYOUT          /UNIT 1 WRITE = CONSOLE PRINTER
0226  0245 01           HSPOUT          /UNIT 2 WRITE = PAPER TAPE PUNCH
0227  0401 01           LPTOUT          /UNIT 3 WRITE = LINE PRINTER
0230  0343 01           GENOUT          /UNIT 4 WRITE = DEV. INDEPENDENT
0231  0455 01           PUT             /WRITE PART OF DECODE
0232  0254 01           TTYIN           /UNIT 1 READ = CONSOLE KEYBOARD
0233  0260 01           HSRIN           /UNIT 2 READ = PAPER TAPE READER
0234  0362 01           IOERR           /UNIT 3 READ = NOTHING
0235  0320 01           GENIN           /UNIT 4 READ = DEV. INDEPENDENT
0236  0443 01           GET             /READ PART OF DECODE
0237  0601 01           TTYFUJ          /FUDGE - SEE TELETYPE INPUT ROUTINE
0240  0362 01           IOERR
0241  0362 01           IOERR
0242  0362 01           IOERR
0243  0362 01           IOERR
0244  0362 01           IOERR
/ LLL UTILITY ROUTINES                FEB  6, 1976              PAGE  3

0245  6021      HSPOUT, PSF
0246  5206              JMP     GENLP
0247  1007              TAD     7
0250  6026              PLS
0251  7200      GENRTN, CLA
0252  4040      GRTN2,  RETRN   GENIO
0253  0003 06
 
0254  6031      TTYIN,  KSF
0255  5206              JMP     GENLP
0256  1376              TAD     (2400   /****DEPENDS ON NUMBER OF DEVICES ****
0257  5206              JMP     GENLP   /TEST FOR ^C ONE LAST TIME
 
0260  2340      HSRIN,  ISZ     T1
0261  5274              JMP     HSRSF
0262  1330              TAD     U336    /TIME OUT-PRINT '^'
0263  6046              TLS
0264  6031      HLP,    KSF
0265  5264              JMP     HLP
0266  0212              AND     U200    /GET 200 INTO AC
0267  6034              KRS             /READ THE CHAR.
0270  1337              TAD     UM203
0271  7640              SZA     CLA     /IS IT CONTROL C?
0272  6032              KCC             /NO-CLEAR FLAG
0273  6014              RFC             /USER TYPED-TICKLE RDR-FALL THRU RFC
0274  6011      HSRSF,  RSF
0275  5206              JMP     GENLP
0276  3340              DCA     T1
0277  6016              RRB RFC
0300  5252              JMP     GRTN2
 
0301  6140      EOF,    6140
0302  0002              0002
0303  1301              TAD     EOF     /GET FIELD OF ARG
0304  3305              DCA     EOF1
0305  7402      EOF1,   HLT             /AND PUT THE CDF HERE
0306  7126              CLL CML RTL     /GET A 2
0307  1702              TADI    EOF#    /GET THE FIELD TO RETURN TO
0310  3341              DCA     EOFEX
0311  2302              INC     EOF#
0312  1702              TADI    EOF#    /GET ADDRESS TO RETURN TO
0313  3317              DCA     EOFEX1
0314  2302              INC     EOF#
0315  4040              RETRN   EOF
0316  0001 06
 
0317  0362 01   EOFEX1, IOERR
/ LLL UTILITY ROUTINES                FEB  6, 1976              PAGE  4

0320  6201      GENIN,  6201
0321  1756              TADI    IHNDLR
0322  7650              SNA CLA         /OPEN INPUT FILE?
0323  5362              JMP     IOERR   /NO
0324  6202              6202
0325  6201 05           JMS I   FICHAR  /GET A CHAR
0326  4757
0327  5362              JMP     IOERR   /INPUT ERROR
0330  0336      U336,   AND     U377    /MUST BE 336!!!!!
0331  1375              TAD     (-232   /CHECK FOR ^Z
0332  7450              SNA
0333  5341              JMP     EOFEX   /TAKE EOF EXIT
0334  1374              TAD     (232    /RESTORE CHARACTER
0335  5252              JMP     GRTN2
 
0336  0377      U377,   377
0337  7575      UM203,  -203
0340  0000      T1,     0
 
0341  7000      EOFEX,  NOP             /RETURN TO SPECIFIED STATEMENT
0342  5717              JMPI    EOFEX1
 
0343  6201      GENOUT, 6201
0344  1760              TADI    OHNDLR
0345  7650              SNA CLA         /OPEN OUTPUT FILE?
0346  5362              JMP     IOERR   /NO
0347  6202              6202
0350  1007              TAD     7       /GET CHAR TO BE OUTPUT
0351  0336              AND     U377
0352  6201 05           JMS I   FOCHAR  /PUT A CHARACTER
0353  4761
0354  5362              JMP     IOERR   /OUTPUT ERROR
0355  5252              JMP     GRTN2
 
0356  0122      IHNDLR, 122             /***ALL THESE LOCATIONS ARE VERY VOLATI
0357  0606      FICHAR, 606             /*******
0360  0121      OHNDLR, 121             /*******
0361  0651      FOCHAR, 651             /*******
 
0362  4033      IOERR,  CALL 1, ERROR
0363  0105 06
0364  6201 05           ARG     IOER
0365  0201 01
 
0366  6014      OPEN2,  RFC
0367  6201              6201
0370  3756              DCAI    IHNDLR
0371  3760              DCAI    OHNDLR          /ZERO DEVICE-INDEPENDENT IO FLA
0372  4040              RETRN   OPEN
0373  0002 06
0374  0232
0375  7546
0376  2400
0377  0763 01
                PAGE
/ LLL UTILITY ROUTINES                FEB  6, 1976              PAGE  5

 
 
0400  0377      K377,   377             /MUST BE FIRST IN PAGE
 
                / LLL CENTRONICS LINE PRINTER HANDLER
                / FORMAT CONTROL CHARS.
                /       0       DOUBLE SPACE
                /       1       TOP OF FORM
                /       +       FAT CHARACTERS
 
0401  1007      LPTOUT, TAD     7       /GET CHAR
0402  2242              ISZ     PFSTCH  /FIRST CHAR?
0403  5222              JMP     NOFST   /NO
0404  1377              TAD     (-1261
0405  7450              SNA             /IS IT 1 FOR FORM FEED?
0406  5240              JMP     FRMFED  /YES
0407  7001              IAC
0410  7450              SNA             /IS IT 0 FOR DOUBLE SPACE?
0411  5225              JMP     LPR     /YES
0412  1376              TAD     (5
0413  7440              SZA             /IS IT + FOR FAT CHARS?
0414  5221              JMP     NOFST1
0415  1251              TAD     J200    /YES
0416  3220              DCA     FATC
0417  5775              JMP     GRTN2
0420  0000      FATC,   0
 
0421  1374      NOFST1, TAD     (1253
0422  1373      NOFST,  TAD     (-1212
0423  7450              SNA             /IS IT LINE FEED?
0424  5234              JMP     LLF     /YES -- RESET SWITCHES
0425  1372      LPR,    TAD     (12
0426  1220              TAD     FATC
0427  6667              LLB
0430  6661      LPW,    LSF
0431  5230              JMP     LPW
0432  6662              LCF
0433  5775              JMP     GRTN2
 
0434  7240      LLF,    CLA CMA
0435  3242              DCA     PFSTCH
0436  3220              DCA     FATC
0437  5225              JMP     LPR
 
0440  7326      FRMFED, CLA CLL CML RTL
0441  5225              JMP     LPR
 
0442  7777      PFSTCH, -1
/ LLL UTILITY ROUTINES                FEB  6, 1976              PAGE  6

0443  2275      GET,    ISZ     ICNT    /ANY MORE CHARACTERS?
0444  7410              SKP             /YES
0445  5253              JMP     EMPTY   /NO MORE
0446  7402      GETX,   HLT             /CHANGE DF TO BUFFER FIELD
0447  1720              TADI    IPNT
0450  2320              INC     IPNT    /BUMP POINTER
                J200,
0451  0200      GET2,   AND     K377
0452  5775              JMP     GRTN2
 
0453  1371      EMPTY,  TAD     (215
0454  5775              JMP     GRTN2
 
0455  2316      PUT,    ISZ     OCNT    /BUFFER FULL?
0456  7410              SKP
0457  5266              JMP     FULL    /YES
0460  7402      PUTX,   HLT             /CHANGE DF TO BUFFER FIELD
0461  1007              TAD     7       /GET CHAR
0462  0200              AND     K377    /MASK TO 6 BIT
0463  3717              DCAI    OPNT
0464  2317              INC     OPNT
0465  5775              JMP     GRTN2
 
0466  7240      FULL,   CLA CMA
0467  3316              DCA     OCNT
0470  5775              JMP     GRTN2
 
0471  6140      RESET,  6140
0472  0001              0001
0473  1271              TAD     RESET
0474  3275              DCA     RESET1
                ICNT,
0475  7402      RESET1, HLT             /SET DF TO FROM FIELD
0476  1672              TADI    RESET#
0477  3260              DCA     PUTX
0500  1260              TAD     PUTX
0501  3246              DCA     GETX
0502  2272              INC     RESET#
0503  1672              TADI    RESET#
0504  3317              DCA     OPNT
0505  1317              TAD     OPNT
0506  3320              DCA     IPNT
0507  2272              INC     RESET#
0510  1370              TAD     (-171
0511  3316              DCA     OCNT
0512  1370              TAD     (-171
0513  3275              DCA     ICNT
0514  4040              RETRN   RESET
0515  0006 06
 
0516  0000      OCNT,   0
/ LLL UTILITY ROUTINES                FEB  6, 1976              PAGE  7

                / INITIALIZING ROUTINE
                / CLEAR FAC, SET I/O FLAGS
 
                OPNT,
0517  6140      OPEN,   6140
0520  0003      IPNT,   0003
0521  7447              7447                    /SET EAE TO MODE A
0522  1372              TAD     (12
0523  6046              TLS                     /LINE FEED TO TTY
0524  6032              KCC
0525  6026              PLS
0526  6211              DCA     ACH             /CLEAR FAC
0527  3767
0530  3766              DCA     ACL
0531  3765              DCA     ACM
0532  5764              JMP     OPEN2
0564  0366 01
0565  0021
0566  0022
0567  0020
0570  7607
0571  0215
0572  0012
0573  6566
0574  1253
0575  0252 01
0576  0005
0577  6517
                PAGE
/ LLL UTILITY ROUTINES                FEB  6, 1976              PAGE  8

0600  3777      N3777,  3777            /MUST BE FIRST IN PAGE
 
0601  1266      TTYFUJ, TAD     K200
0602  6034              KRS
0603  3007              DCA     7       /SAVE KEYBOARD CHAR
0604  6032              KCC             /CLEAR FLAG
0605  1007              TAD     7
0606  1377              TAD     (-212
0607  7640              SZA CLA
0610  4221              JMS     TYPE
0611  1007              TAD     7
0612  1376              TAD     (-215
0613  7640              SZA CLA
0614  5217              JMP     TYRTN
0615  7346              CLA CLL CMA RTL
0616  4221              JMS     TYPE
0617  1007      TYRTN,  TAD     7
0620  5775              JMP     GRTN2   /RETURN WITH CHAR IN AC
/ LLL UTILITY ROUTINES                FEB  6, 1976              PAGE  9

0621  0000      TYPE,   0
0622  1007              TAD     7
0623  6041      TYPELP, TSF
0624  5223              JMP     TYPELP
0625  6046              TLS
0626  7200              CLA
0627  5621              JMPI    TYPE
 
0630  4221      TTYOUT, JMS     TYPE
0631  5775              JMP     GRTN2
 
0632  0633 01   PMESG,  MESG
0633  7777      MESG,   7777
0634  7777              7777
0635  4005              4005
0636  2222              2222
0637  1722              1722
0640  4001              4001
0641  2440              2440
0642  1417              1417
0643  0340              0340
0644  0007      LIT7,   0007
 
0645  0000      ERROR,  BLOCK 2         /ERROR PROCESSOR
0646  0000
0647  7600      U7600,  7600
0650  1245              TAD     ERROR
0651  3252              DCA     TEM1
0652  7000      TEM1,   NOP             /SET DATA FIELD OF "CALL ERROR"
0653  1646              TADI    ERROR#
0654  3262              DCA     TEM3
0655  2246              INC     ERROR#
0656  7260      E60,    CLA CMA CML     /CML IS WINDOW DRESSING
0657  1646              TADI    ERROR#
0660  3010              DCA     10
0661  2246              INC     ERROR#
0662  7000      TEM3,   NOP             /DATA FIELD OF MESSAGE&ENTRY POINT
0663  1410              TADI    10
0664  3362              DCA     CKIO    /SAVE FATAL BIT
0665  1362              TAD     CKIO
0666  0200      K200,   AND     N3777   /STRIP FATAL BIT FROM 1ST CHAR
0667  3233              DCA     MESG
0670  1410              TADI    10      /SECOND WORD OF MESSAGE
0671  3234              DCA     MESG#
0672  1410              TADI    10
0673  3252              DCA     TEM1
0674  1410              TADI    10
0675  3262              DCA     TEM3    /CALLING ADDRESS
0676  1232              TAD     PMESG
0677  3361              DCA     TEM2
 
0700  6201 05   ERLP,   TAD I   TEM2
0701  1761
0702  7112              CLL RTR
0703  7012              RTR
0704  7012              RTR
0705  4347              JMS     PR6BIT
/ LLL UTILITY ROUTINES                FEB  6, 1976              PAGE 10

0706  1761              TAD I   TEM2
0707  4347              JMS     PR6BIT
0710  2361              INC     TEM2
0711  5300              JMP     ERLP
 
/ LLL UTILITY ROUTINES                FEB  6, 1976              PAGE 11

0712  1252      PRLOC,  TAD     TEM1
0713  7012              RTR
0714  7012              RTR
0715  0244              AND     LIT7    /GET CALLING FIELD
0716  1256              TAD     E60
0717  4347              JMS     PR6BIT  /PRINT IT
0720  1374              TAD     (-4
0721  3361              DCA     TEM2
0722  1262      NUMLP,  TAD     TEM3
0723  7006              RTL
0724  7004              RAL
0725  3262              DCA     TEM3
0726  1262              TAD     TEM3
0727  7004              RAL
0730  0244              AND     LIT7
0731  1256              TAD     E60
0732  4347              JMS     PR6BIT
0733  2361              ISZ     TEM2
0734  5322              JMP     NUMLP
0735  1373              TAD     (215
0736  3007              DCA     7
0737  4221              JMS     TYPE
0740  7346              CLA CLL CMA RTL
0741  4221              JMS     TYPE
0742  1362              TAD     CKIO    /GET THE FATAL ERROR FLAG
0743  7700              SMA CLA         /WHADDOWEDO??
0744  5363              JMP     EXITX
0745  4040              RETRN   ERROR   /HE SAYS ITS NON-FATAL - LET HIM HANDLE
0746  0005 06
 
0747  0000      PR6BIT, 0               /6BIT TO 8BIT CONVERTOR
0750  0372              AND     (77
0751  7450              SNA
0752  5312              JMP     PRLOC   /MESSAGE OVER
0753  1371              TAD     (240
0754  0372              AND     (77
0755  1371              TAD     (240
0756  4033              CALL    0,GENIO /LOOK FOR ^C WHILE TYPING
0757  0003 06
0760  5747              JMPI    PR6BIT
 
/ LLL UTILITY ROUTINES                FEB  6, 1976              PAGE 12

                /EXIT TO DISK MONITOR SYSTEM
                /
                TEM2,
0761  6140      EXIT,   6140
0762  0002      CKIO,   0002
0763  6041      EXITX,  6041
0764  5363              JMP     EXITX
0765  6203              6203
0766  5647              JMPI    U7600   /RETURN TO MONITOR
 
 
0771  0240
0772  0077
0773  0215
0774  7774
0775  0252 01
0776  7563
0777  7566
                        END
/ LLL UTILITY ROUTINES                FEB  6, 1976              PAGE 13

 
 
CKIO    0762
DCAI    3400OP
DEVTAB  0225
DSPACH  0222
EMPTY   0453
EOF     0301EXT
EOFEX   0341
EOFEX1  0317
EOF1    0305
ERLP    0700
ERROR   0645EXT
EXIT    0761EXT
EXITX   0763
E60     0656
FATC    0420
FICHAR  0357
FOCHAR  0361
FRMFED  0440
FULL    0466
GENIN   0320
GENIO   0203EXT
GENLP   0206
GENOUT  0343
GENRTN  0251
GET     0443
GETX    0446
GET2    0451
GRTN2   0252
HLP     0264
HSPOUT  0245
HSRIN   0260
HSRSF   0274
ICNT    0475
IHNDLR  0356
IOER    0201
IOERR   0362
IPNT    0520
JMPI    5400OP
JMPITB  0224
JMSI    4400OP
J200    0451
KCC     6032OP
KRS     6034OP
K200    0666
K377    0400
LCF     6662OP
LIT7    0644
LLB     6667OP
LLF     0434
LPR     0425
LPTOUT  0401
LPW     0430
LSF     6661OP
MESG    0633
NOFST   0422
/ LLL UTILITY ROUTINES                FEB  6, 1976              PAGE 14

NOFST1  0421
NUMLP   0722
N3777   0600
OCNT    0516
OHNDLR  0360
OPEN    0517EXT
OPEN2   0366
OPNT    0517
PFSTCH  0442
PMESG   0632
PRLOC   0712
PR6BIT  0747
PUT     0455
PUTX    0460
RESET   0471EXT
RESET1  0475
TADI    1400OP
TEM1    0652
TEM2    0761
TEM3    0662
TTYFUJ  0601
TTYIN   0254
TTYOUT  0630
TYPE    0621
TYPELP  0623
TYRTN   0617
T1      0340
UM203   0337
U17     0200
U200    0212
U336    0330
U377    0336
U7600   0647
 
