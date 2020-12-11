
/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 1

             /CAPS SYMBOLIC EDITOR           VERSION EDIT.01
             /DEC-8E-OEDTA-A-LA

             /3 DEC 1973                     HJ

             /COPYRIGHT 1972 DIGITAL EQUIPMENT CORPORATION
             /       MAYNARD, MASSACHUSSETTS 01754

             /THE SYMBOLIC EDITOR IS A LINE-ORIENTED
             /TEXT EDITOR WITH CHARACTER AND STRING
             /SEARCH CAPABILITIES.  IT IS DESIGNED
             /TO BE COMPATIBLE WITH THE CAPS SYSTEM.

             /THE DESIGN OF THE EDITOR IS SIMILAR
             /TO THAT OF THE OS/8 SYMBOLIC EDITOR.


/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 2





             /THE STARTING ADDRESS IS 00200.


             /OPTIONS:
             /B      CONVERT 2 OR MORE SPACES TO TAB ON INPUT

             /ERROR CODES:
             /  0    FAILURE IN INPUT DEVICE HANDLER
             /  1    FAILURE IN OUTPUT DEVICE HANDER
             /  2    COULD NOT CLOSE FILE


/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 3



             /COMMANDS:

             /A      APPEND TEXT TO BUFFER
             /I      INSERT TEXT INTO BUFFER
             /C      CHANGE TEXT IN BUFFER
             /L      LIST TEXT IN BUFFER
             /D      DELETE TEXT IN BUFFER
             /K      KILL BUFFER
             /M      MOVE TEXT WITHIN BUFFER
             /G      GET AND LIST TAGGED LINE IN BUFFER
             /B      LIST # OF CORE LOCATIONS LEFT IN BUFFER
             /S      CHARACTER SEARCH
             /J      INTER-BUFFER STRING SEARCH
             /F      AFTER J, SEARCH FOR NEXT OCCURRANCE
             /       OF SAME STRING
             /$      INTRA-BUFFER STRING SEARCH
             /R      READ TEXT INTO BUFFER FROM INPUT DEVICE
             /N      WRITE BUFFER, KILL, AND READ NEXT PAGE
             /Y      INPUT TEXT PAGE, NO OUTPUT
             /P      WRITE TEXT BUFFER TO OUTPUT DEVICE
             /E      OUTPUT BUFFER, TRANSFER REST OF
             /       INPUT FILE TO OUTPUT FILE
             /       CLOSE OUTPUT FILE
             /Q      IMMEDIATE END OF FILE


             /ABBREVIATIONS

             /.LT.   LESS THAN
             /.LE.   LESS THAN OR EQUAL TO
             /.GT.   GREATER THAN
             /.GE.   GREATER THAN OR EQUAL TO
             / R     RIGHT
             / L     LEFT

             /SPECIAL COMMENTS

             /SINCE THE EDITOR IS CODED ACROSS PAGE BOUNDARIES, IT IS
             /NECESSARY TO BE AWARE OF THE EFFECTS OF THE INSERTION
             /OR DELETION OF CODE.  FOR THIS REASON, THE LIMITS
             /OF PERMISSABLE PAGE BOUNDARY WANDERING
             /ARE INDICATED WITH THE FOLLOWING CONSTRUCTION:

             /----------------------------------------------------------
             /SOMEWHERE BETWEEN LINES, THE PAGE BOUNDARY MUST OCCUR
             /----------------------------------------------------------

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 4



       4400                  FIXMRI CALL=4400

       0000                  VT05=0          /0 MEANS NOT ON VT05

       7402                  TTOCHR=7402
       7403                  INCHAD=7403     /ADDRESS IF SINCH
       7411                  INCHEX=INCHAD+6
       7602                  KBDIN=7602
       7626                  KBDCHR=7626
       6400                  CLOSE=6400
       7002                  LOOKUP=7002
       6404                  ENTER=6404
       6600                  HANDLER=6600
       3000                  LBUFR=3000
       7624                  INVNUM=7600+24  /VERSION NUMBER OF INPUT FILE
       7400                  OPT1=7400
       7401                  OPT2=OPT1+1
       7200                  UTIL=7200
       7400                  LPOCHR=7400
       5200                  FLIPI=6400+6600 /ADDRESS'S OF 2 INPUT BUFFERS
       3663                  BUFRD=INCHAR    /CALLED AS BUFRD
       6200                  FLIPO=7000+7200 /ADDRESS'S OF 2 OUTPUT BUFFERS
       4111                  BUFWT=OCHAR     /CALLED AS BUFWT
       6200                  WAIT=6200
       7604                  CTRLCJ=7604     /MONITOR EXIT ROUTINE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 5



             /MISCELLANEOUS POINTER AND CONSTANTS

       0007                  *7

000007  7701         M77,    -77
000010  0077         C77,    77
000011  0100         C100,   100
000012  0677         C677,   677             /QUESTION MARK

             /AUTO-INDEX REGISTERS

000013  0000         AXOUT,  0               /OUTPUT INDEX
000014  0000         AXCOMB, 0               /COMBINE POINTER
000015  0000         AXTEM,  0               /TEMPORARY INDEX
000016  0000         AXIN,   0               /STORAGE INDEX

       0020                  *20

             /CONSTANTS

000020  7774         M4,     -4              /LETTER COUNT
000021  0177         P177,   177
000022  7563         MCR,    -215
000023  7540         M240,   -240
000024  0040         P40,    40
000025  0200         C200,   200             /(START & RESTART)

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 6




             /LISTS

             /TAG SEARCH LIST-
       0026          LIST7=.

000026  0240         C240,   240             /SPACE
000027  0257                 257             /COMMENT DELIMITER (/)

             /OUTPUT LIST
       0030          LIST4=.

000030  0211         CTAB,   211             /TAB
000031  0215         C215,   215             /CARRIAGE RETURN
000032  0212                 212             /LINE FEED
000033  0214                 214             /FORM FEED
000034  0377                 377             /RUBOUT
000035  7751         M27,    -27             /LIST DELIMITER

             /SPECIAL CHARACTER LIST FOR
             /INPUT IN TEXT MODE
       0036          LIST5=.                 /USED AT AONE
000036  0240                 240             /SPACE
       0037          LIST6=.                 /USED AT SFOUND
000037  0225                 225             / ^U
000040  0214         C214,   214             /FORM FEED
000041  0207         BELL,   207             / ^G (BELL)
000042  0212         C212,   212             /LINE FEED
000043  0377                 377             /RUBOUT

       0044          LIST3=.
000044  0215                 215             /LIST BRANCHER
000045  0000                 000             /(SEARCH CHARACTER)
000046  6757         MCHIN1, -CHIN-1         /LIST DELIMITER

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 7




             /CONSTANTS AND POINTERS

       0031          CCR=C215                /CARRIAGE RETURN
       0042          CLF=C212                /LINE FEED
000047  7770         MTABS,  -10             /TAB COUNTER
000050  0640         DELT,   DELP
000051  1020         CHI1,   CHIN
000052  1021         IGNORE, CHIN+1
000053  0200         END,    200
000054  1212         KEYBD,  I33
000055  5414         CCON,   JMP I AXCOMB
000056  1273                 COM1-1
000057  0523         UTR1,   UTRA
000060  1032         FIN1,   FIND
000061  0702         LIS1,   LIST
000062  0707         LIS,    LISTER
000063  0012         NINE,   12
000064  7506         NUMB,   -272
000065  1124         OUT1,   OUT
       0066          OUTL1=.
000066  1207         LOW,    OUTL
000067  7300         CZ,     CLA CLL         /CONTENTS OF START
000070  0222         ONUM,   GTOP
000071  0325         SORTJ,  SORTB
000072  0455         PACK1,  PACBUF

000073  1103         SXS1,   TAD CHAR        /CONTENTS OF L3
000074  5372         SXS2,   SLOOK&177+5200  /JMP SLOOK
000075  0752         L3I,    L3              /PATCH POINTER
000076  0750         L2I,    L2              /CONTINUE SEARCH - LETTERS
000077  1663         ENDLNI, ENDLN
000100  0453         SPCNO,  MOR+4           /PACK
000101  0450         SPCGO,  MOR+1           /SORT
000102  0334         SPLAT,  334             /\ - ACKNOWLEDGE RUBOUT

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 8




             /CHAR IS ALWAYS SET BY OUT, SOMETIMES BY SORTB;
             /IT IS ALWAYS USED BY PACK AND SORTB.
000103  0000         CHAR,   0
       0104          MOV1=.
000104  0000         COUNTP, 0               /NUMBER OF PAGES
       0105          CNT=.                   /PRINT COUNTER
000105  0000         XCT,    0               /UNPACK SWITCH
000106  0000         XCTIN,  0               /PACK SWITCH
000107  0001         ECHOSW, 1               /NON-ZERO TO PRINT
000110  0000         SAVE,   0
000111  0000         TABIND, 0               /TABS OR SPACES SWITCH
000112  0000         TEMP,   0
000113  0000         THIS,   0               /LINE POINTER.
000114  1207         OUTDEV, OUTL            /POINTER TO OUTPUT SUBROUTINE
000115  2600         GRBAGE, GARBAG          /GARBAGE COLLECTOR
000116  0000         MARK,   0               /OBJECT LINE IN G.C.
000117  0000         XSAV,   0               /HOLD INPUT POINTER.
000120  0200         BUFR,   200
000121  0020         CFRS,   20              /LOCATION 20 OF FIELD 1 CONTAINS LINE POINTER
000122  2325         KILL1,  KILL+3
000123  1642         CHKARG, CHKARX
000124  4135         ERSW,   ERROR           /ERROR ROUTINE
000125  0726         L1I,    L1

000126  0000         EKILLL, 0               /E CMD SWITCH  1 IF E NOT ALLOWED
000127  5600         BUFEND, 5600            /WARNING FOR END OF BUFFER

             /I-O RELATED POINTERS AND WORDS

000130  3663         BUFRDI, BUFRD           /OR CHIN...IN DEVICE POINTER
000131  4111         BUFWTI, BUFWT           /WRITE OUTPUT TO DEVICE
000132  2003         CLFLI,  FLCLOS          /SET TO CLOSE FILE
000133  0620         PSETUP, SETUP
000134  5236         JMPCH,  PUNCH&177+5200  /DESTROYED BY YANK

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 9



             /ERROR ROUTINE POINTERS


       0135          GTEM=.          /NEXT 6-BITS OF UNPACK
       0135          DTEM=.          /NEXT POINTER IN DELETE CHAIN


             /ERROR ROUTINE
             /REJECTS ILLEGAL COMMAND
             /AND TYPES ?

       4135          ERROR=JMS .
000135  0000                 0
000136  7600         ELIM,   7600            /GRP2-CLA
000137  1012                 TAD C677
000140  4466                 JMS I OUTL1     /PRINT "?"
000141  1067         CZONE,  TAD CZ          /RESET PATCHES
000142  3547                 DCA I TE1
000143  5547         JMPTE1, JMP I TE1       /*RETURN TO COMMAND MODE*


000144  2237         UPAROI, UPAROW          /GENERATE ^ CHARACTER
000145  0000         STRIND, 0
000146  2400         STRFIN, SFIND1
000147  0201         TE1,    START

             /VARIABLES
000150  0000         THSN,   0               /CURRENT LINE NUMBER
000151  0000         LSTN,   0               /LAST LINE NUMBER
000152  0000         TCNT,   0               /TAB COUNT
000153  0000         ADD,    0
000154  0000         ARG0,   0
000155  0240         ARG1,   0240
000156  7777         ARG2,   -1

000157  1302         COMM5,  COM5
000160  0000         TEMPO,  0
000161  7575         X203,   -203

       0160          MOV2=TEMPO
000162  0000         LSTCHK, 0               /DIGIT ACCEPTED FLAG
000163  0000         PTR,    0               /USED FOR I/O ROUTINES
000164  0000         HDPTR,  0               /" " " "
000165  0000         KNT,    0               /" " " "
000166  4200         EDSTRT, IOSET           /LETS START AT 200
000167  0000         INFLG,  0
000170  0000         INPTR,  0
000171  7777         INUNIT, -1
000172  0000         OUWDCT, 0
000173  0000         OUTINH, 0

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 10






       0200          *200
000200  5566                 JMP I EDSTRT    /START AT IOSET OR START
             /HANDLER FOR ^U (IF IN COMMAND MODE)
000201  7300         START,  CLA CLL         /NON-I/O STARTING POINT
000202  1066                 TAD LOW         /ENTER COMMAND MODE
000203  3114                 DCA OUTDEV      /INITIALIZE KEYBOARD
000204  3111                 DCA TABIND      /CLEAR TAB INDICATOR
000205  2107                 ISZ ECHOSW      /SET UP FOR ECHO
000206  3045                 DCA LIST3+1
000207  1073                 TAD SXS1
000210  3475                 DCA I L3I
000211  1124                 TAD ERSW        /RESET ERROR SWITCH AT L1
000212  3525                 DCA I L1I
000213  1141                 TAD CZONE
000214  3557                 DCA I COMM5
000215  3162                 DCA LSTCHK      /CLEAR DIGIT ACCEPTED
000216  1031                 TAD CCR         /OUTPUT CARRIAGE RETURN
000217  4465                 JMS I OUT1
             /HANDLER FOR CARRIAGE RETURN (COMMAND MODE)
000220  1324                 TAD SIGN        /OUTPUT #
000221  4465                 JMS I OUT1
000222  3154         GTOP,   DCA ARG0        /CLEAR ARGUMENTS
000223  3156                 DCA ARG2
             /HANDLER FOR SPACE OR +
000224  1323         GEXP,   TAD NONE
             /HANDLER FOR -
000225  1336         GMIN,   TAD CMPT
000226  3240                 DCA G2          /SET SIGN TO + OR -
000227  3112         DBCV2,  DCA TEMP
000230  4451                 JMS I CHI1      /INPUT ONE CHARACTER
000231  1064                 TAD NUMB
000232  7100                 CLL
000233  1063                 TAD NINE
000234  7430                 SZL             /WAS IT A DIGIT?
000235  5353                 JMP COUNT       /YES - CONTINUE ACCEPTING NUMBERS

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 11




000236  7200         GLOM,   CLA             /NO
000237  1112                 TAD TEMP        /GET ACCUMULATED NUMBER
000240  7402         G2,     HLT             /(NOP) OR (CIA) TO HANDLE SIGN
000241  1156                 TAD ARG2
000242  3156                 DCA ARG2        /STORE NEW ARGUMENT
000243  4325                 JMS SORTB       /WAS LAST CHARACTER SPECIAL?
000244  1305                 LIST1-1         /YES - COMPARE TO LIST
000245  0242                 OPS1-LIST1      /AND BRANCH TO HANDLER
000246  1103                 TAD CHAR        /NO - SAVE COMMAND CHARACTER
000247  3110                 DCA SAVE
000250  4451                 JMS I CHI1      /INPUT ONE CHARACTER
000251  4325                 JMS SORTB       /IS IT CARRIAGE RETURN, ^C, OR ^U?
000252  1327                 LIST1A-1        /YES - EXIT TO HANDLER
000253  0245                 OPS1A-LIST1A
000254  4135                 ERROR           /NO - TRY AGAIN

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 12



             /CHECK LEGALITY OF ARGUMENTS
             /ARG0 CONTAINS FIRST ARGUMENT
             /ARG2 CONTAINS SECOND ARGUMENT

000255  1154         RETRN,  TAD ARG0        
000256  7450                 SNA             /IS ARG0=0?
000257  1156                 TAD ARG2        /YES - ARG0=ARG2
000260  3154                 DCA ARG0        /NO
000261  1156                 TAD ARG2
000262  7040                 CMA
000263  1154                 TAD ARG0
000264  7500                 SMA             /IS ARG0 .LE. ARG2?
000265  4135                 ERROR           /NO
000266  3155                 DCA ARG1        /YES - ARG1=ARG0-ARG2-1
000267  1154                 TAD ARG0
000270  7710                 SPA CLA         /IS ARG0 .GE. 0?
000271  4135                 ERROR           /NO
000272  1110                 TAD SAVE        /YES - GET COMMAND CHARACTER
000273  4325                 JMS SORTB       /IS IT A LEGAL COMMAND?
000274  0276                 LIST2-1         /YES - MATCH TO LIST
000275  0064                 OPS2-LIST2      /AND BRANCH TO ITS HANDLER
000276  4135                 ERROR           /NO - TRY AGAIN


             /COMMAND IDENTIFICATION LIST
       0277          LIST2=.         /COMMAND LETTERS
000277  0305                 305             /E
000300  0301                 301             /A
000301  0311                 311             /I
000302  0303                 303             /C
000303  0313                 313             /K
000304  0304                 304             /D
000305  0314                 314             /L
000306  0316                 316             /N
000307  0320                 320             /P
000310  0322                 322             /R
000311  0312                 312             /J
000312  0306                 306             /F
000313  0324                 324             /T
000314  0315                 315             /M
000315  0307                 307             /G
000316  0323                 323             /S
000317  0331                 331             /Y
000320  0321                 321             /Q
000321  0302                 302             /B
000322  0326                 326             /V
000323  7737         NONE,   -41             /"NOP-CIA"


000324  0643         SIGN,   "#+400

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 13



             /SORT AND BRANCH ROUTINE
             /LOOKS FOR MATCH BETWEEN CHAR
             /AND ELEMENTS OF TABLE 1 SPECIFIED
             /CALLING SEQUENCE:
             /       JMS I (SORTB
             /       TABLE1-1
             /       TABLE2-TABLE1
             /       RETURN IF NO MATCH
             /DISPATCHES TO CORRESPONDING ADDRESS IN TABLE 2

000325  0000         SORTB,  0
000326  7440                 SZA             /IS CHARACTER STORED YET?
000327  3103                 DCA CHAR        /NO - STORE IT
000330  1725                 TAD I SORTB     /YES
000331  2325                 ISZ SORTB
000332  3015                 DCA AXTEM       /STORE TABLE 1 ADDRESS
000333  1415                 TAD I AXTEM     /GET TABLE ENTRY
000334  7510                 SPA             /DONE YET?
000335  5350                 JMP SEX         /YES - EXIT
000336  7041         CMPT,   CIA             /NO
000337  1103                 TAD CHAR        /GET CHARACTER
000340  7640                 SZA CLA         /DO THEY MATCH?
000341  5333                 JMP .-6         /NO - KEEP TRYING
000342  1015                 TAD AXTEM       /YES - THEY MATCH
000343  1725                 TAD I SORTB     /GET DISPATCH TABLE ADDRESS
000344  3325                 DCA SORTB
000345  1725                 TAD I SORTB
000346  3325                 DCA SORTB       /SET RETURN ADDRESS
000347  5725                 JMP I SORTB     /--RETURN--VIA DISPATCH TABLE
000350  2325         SEX,    ISZ SORTB       /MATCH NOT FOUND
000351  7200                 CLA
000352  5725                 JMP I SORTB     /--


             /DECIMAL ADDITION ROUTINE
             /FOR NUMERIC ARGUMENTS OF COMMANDS
             /ENTER WITH INPUT DIGIT IN SORTB
             /EXIT WITH ACCUMULATED NUMBER IN AC
000353  3325         COUNT,  DCA SORTB
000354  2162                 ISZ LSTCHK      /GOT A DIGIT NOW
000355  1112                 TAD TEMP
000356  7106                 RTL CLL
000357  1112                 TAD TEMP
000360  7004                 RAL
000361  1325                 TAD SORTB
000362  5227                 JMP DBCV2       /RETURN TO MAIN SEQUENCE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 14



             /----------------------------------------------------------

             /DISPATCH LIST FOR COMMAND HANDLERS
000363  1614         OPS2,   ENDFIL          /E
000364  1217                 APP             /A
000365  1221                 XNS             /I
000366  1223                 CNGE            /C
000367  2322                 KILL            /K
000370  2720                 DELE            /D
000371  0702                 LIST            /L
000372  1254                 COMBO           /N
000373  1236                 PUNCH           /P
000374  1245                 TELE            /R
000375  2257                 JERK            /J
000376  2303                 BARROW          /F
000377  0136                 ELIM            /T - REMOVED FOR CAS-8
000400  1400                 MOVEM           /M
000401  1333                 GETTAG          /G
000402  1165                 XCRET           /S
000403  1251                 YANK            /Y
000404  2000                 Q               /Q
000405  2312                 CORSPC          /B
000406  2704                 VIEW            /V


/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 15


             /END OF INPUT TEXT LINE ROUTINE

000407  4477         EOL,    JMS I ENDLNI    /RESET LINK CELLS
000410  2151                 ISZ LSTN        /INCREMENT LINE POINTERS
000411  2150                 ISZ THSN
000412  1127                 TAD BUFEND
000413  7141                 CLL CIA
000414  1016                 TAD AXIN
000415  7620                 SNL CLA         /IS THE BUFFER FULL?
             /----------------------------------------------------------
000416  5247                 JMP MOR         /NO - KEEP FILLING
000417  1041                 TAD BELL        /YES - RING WARNING BELL
000420  4466                 JMS I OUTL1
000421  5547                 JMP I TE1       /*RETURN TO COMMAND MODE*


             /CONTINUATION OF HANDLERS FOR A, C, AND I COMMANDS
000422  1151         APP1,   TAD LSTN        /APPEND
000423  3154                 DCA ARG0        /RESET ARG0 TO END OF TEXT
000424  5230                 JMP INS
000425  4450         CNGE1,  JMS I DELT      /CHANGE - DELETE LINES AND
000426  1154         XNS1,   TAD ARG0        /INSERT
000427  7650                 SNA CLA         /ANY ARGUMENTS?
000430  2154         INS,    ISZ ARG0        /NO - INSERT AT BEGINNING OF TEXT
000431  1154                 TAD ARG0
000432  4460                 JMS I FIN1      /FIND THE POINTER
000433  3113                 DCA THIS
000434  2111                 ISZ TABIND      /SET TAB INDICATOR
000435  6211                 CDF 10
000436  1513                 TAD I THIS      /GET LINK TO BUFFER
000437  6201                 CDF 0
000440  3117                 DCA XSAV
000441  7040                 CMA
000442  1154                 TAD ARG0
000443  3150                 DCA THSN        /SET LINE POINTER
000444  1120         AONE,   TAD BUFR        /BEGIN LINE
000445  3016                 DCA AXIN
000446  3106                 DCA XCTIN
000447  4530         MOR,    JMS I BUFRDI    /GET A CHARACTER
000450  4471                 JMS I   SORTJ   /IS IT SPECIAL? (SEE LIST)
000451  0035                 LIST5-1
000452  0542                 INLIST-LIST5    /YES - GO TO ITS HANDLER
000453  4255                 JMS PACBUF      /NO - PACK IT
000454  5247                 JMP MOR         /FETCH ANOTHER

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 16



             /CHARACTER PACKING ROUTINE
             /CONVERTS CHARACTER IN CHAR TO INTERNAL CODE
             /AND CALLS PCK1 TO PACK IT INTO BUFFER
             /ENTER AND EXIT WITH AC CLEAR

000455  0000         PACBUF, 0
000456  4777'                JMS TBUF        /CHECK WHERE BUFFER IS UP TO
000457  1103                 TAD CHAR        /O.K. TO INSERT
000460  1023                 TAD M240
000461  7510                 SPA             /IS IT 200-237?
000462  5275                 JMP ESCA        /YES - ATTACH 77
000463  1007                 TAD M77
000464  7540                 SMA SZA         /IS IT 337 OR LESS?
000465  5275                 JMP ESCA        /NO - ATTACH 77
000466  1024                 TAD P40         /YES - IS IT 277?
000467  7650                 SNA CLA
000470  5275                 JMP ESCA        /YES - ATTACH 77
000471  1103         TR1,    TAD CHAR        /240-337 EXCEPT 277
000472  0010                 AND C77         /MASK OUT LEFT 6 BITS
000473  4301                 JMS PCK1        /PACK IT
000474  5655                 JMP I PACBUF    /--RETURN--
000475  7200         ESCA,   CLA             /200-237, 277,340-377
000476  1010                 TAD C77         /PACK A 77
000477  4301                 JMS PCK1
000500  5271                 JMP TR1         /PACK THE CHARACTER

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 17



             /PACK CHARACTERS INTO TEXT BUFFER
             /ENTER WITH 6-BIT CODE IN AC

000501  0000         PCK1,   0
000502  2106                 ISZ XCTIN       /LEFT HALF OR RIGHT HALF?
000503  5314                 JMP ROT         /LEFT HALF
000504  3323                 DCA UTRA        /RIGHT HALF - STORE CHARACTER
000505  1323                 TAD UTRA        /GET CHARACTER
000506  1153                 TAD ADD         /GET PREVIOUS CHARACTER
000507  6211                 CDF 10
000510  3416                 DCA I AXIN      /STORE IN FIELD 1 BUFFER
000511  6201                 CDF 0
000512  3153                 DCA ADD
000513  5701                 JMP I PCK1      /--RETURN--
000514  7106         ROT,    CLL RTL         /LEFT HALF
000515  7006                 RTL
000516  7006                 RTL             /ROTATE 6 LEFT
000517  3153                 DCA ADD         /RETAIN UNTIL NEXT CHARACTER
000520  7040                 CMA             /IS READY
000521  3106                 DCA XCTIN       /RESET L OR R SWITCH
000522  5701                 JMP I PCK1      /--RETURN--

       0455                  UTEST=PACBUF    /TEMPORARY

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 18



             /CHARACTER UNPACKING ROUTINE
             /CONVERTS ONE CHARACTER FROM
             /BUFFER FORMAT TO 8-BIT ASCII
             /EXIT WITH CHARACTER IN AC

000523  0000         UTRA,   0
000524  7240                 CLA CMA         /INITIALIZE TO -1
000525  3255                 DCA UTEST
000526  2105         EXTR,   ISZ XCT         /LEFT HALF OR RIGHT HALF?
000527  5341                 JMP GET3        /RIGHT HALF
000530  6211                 CDF 10          /LEFT HALF
000531  1413                 TAD I AXOUT     /GET BUFFER WORD
000532  6201                 CDF 0
000533  3135                 DCA GTEM
000534  1135                 TAD GTEM
000535  7012                 RTR             /ROTATE 6 RIGHT
000536  7012                 RTR
000537  7012                 RTR
000540  5344                 JMP GET4        /SKIP TO GETA
000541  7240         GET3,   CLA CMA         /RESET L - R SWITCH
000542  3105                 DCA XCT
000543  1135                 TAD GTEM
000544  0010         GET4,   AND C77         /MASK OUT LEFT 6 BITS
000545  1007                 TAD M77
000546  7100                 CLL
000547  7450                 SNA             /WAS IT 77?
000550  2255                 ISZ UTEST       /YES - WAS IT LEFT HALF?
000551  5353                 JMP GET5        /NO - CONTINUE
000552  5326                 JMP EXTR        /YES - GET OTHER HALF
000553  1371         GET5,   TAD P37
000554  2255                 ISZ UTEST       /RESTORE THE CHARACTER
000555  7020                 CML
000556  7420                 SNL
000557  1011                 TAD C100
000560  1026                 TAD C240
000561  1161                 TAD X203        /IS IT A ^C?
000562  7450                 SNA
000563  5324                 JMP UTRA+1      /YES - IGNORE IT
000564  1035                 TAD M27         /NO - IS IT A ^Z?
000565  7450                 SNA
000566  5324                 JMP UTRA+1      /YES - IGNORE IT
000567  1372                 TAD P232        /NO - RESTORE CHARACTER
000570  5723                 JMP I UTRA      /--RETURN--

000571  0037         P37,    37
000572  0232         P232,   232
000577  1600
       0600                  PAGE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 19



             /INPUT LIST FOR SPECIAL CHARACTERS IN TEXT MODE
       0600          INLIST=.
000600  1514                 SPACES          /SPCS
000601  1631                 CTRLU           /^U
000602  0607                 FULL            /FORM
000603  0607                 FULL            /BELL
000604  1503                 RUB4+1          /LINE FEED
000605  1446                 RUB1            /RUBOUT
000606  0407                 EOL             /CARRIAGE RETURN

             /HANDLER FOR FORM FEED OR ^G
000607  1052         FULL,   TAD IGNORE      /
000610  1046                 TAD MCHIN1      /
000611  7650                 SNA CLA         /IN APPEND MODE?
000612  5547                 JMP I TE1       /YES*RETURN TO COMMAND MODE*
000613  1151                 TAD LSTN        /NO - IS BUFFER EMPTY?
000614  7650                 SNA CLA         /
000615  5617                 JMP I MORI      /YES - IGNORE FORM FEED
000616  5547                 JMP I TE1       /NO*RETURN TO COMMAND MODE*

000617  0447         MORI,   MOR


             /SET UP TO READ FROM INPUT DEVICE
             /USED BY C AND R COMMANDS
             /CALLED WITH SEQUENCE
             /       JMS I PSETUP
             /       INPUT ROUTINE
             /       CONTINUATION OF HANDLER
             /EXITS TO CONTINUATION OF HANDLER

000620  0000         SETUP,  0
000621  1620                 TAD I SETUP     /GET READ AREA FROM ARGS
000622  3130                 DCA BUFRDI
000623  1620                 TAD I SETUP     /LOCATION FOR IGNORED CHARACTERS
000624  7001                 IAC
000625  3052                 DCA IGNORE
000626  2220                 ISZ SETUP       /SETUP PROPER RETURN POINT
000627  1620                 TAD I SETUP
000630  3220                 DCA SETUP
000631  7100                 CLL     
000632  1120                 TAD BUFR
000633  1237                 TAD L1720
000634  7630                 SZL CLA         /IS BUFFER FULL?
000635  4135                 ERROR           /YES - DON'T READ
000636  5620                 JMP I SETUP     /--RETURN--

000637  1720         L1720,  1720

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 20



             /SUPERVISOR FOR DELETION OF TEXT LINES

000640  0000         DELP,   0
000641  4523                 JMS I CHKARG    /CHECK ARGUMENT VALIDITY
000642  1154                 TAD ARG0
000643  3150                 DCA THSN        /SET CURRENT LINE #
000644  1155                 TAD ARG1        /SAVE # DELETED
000645  3307                 DCA LISTER
000646  1154                 TAD ARG0        /GET POINTER TO LINE
000647  4460                 JMS I FIN1      /TO BE DELETED
000650  3113                 DCA THIS        /STORE IT
000651  6211         DELP1,  CDF 10
000652  1513                 TAD I THIS
000653  3116                 DCA MARK        /CORE ADDRESS OF OBJECT LINE
000654  1516                 TAD I MARK
000655  3513                 DCA I THIS      /CHAIN NEW POINTERS TO DELETE LINE
000656  1116                 TAD MARK
000657  6201                 CDF 0
000660  4515                 JMS I GRBAGE    /PHYSICALLY DELETE THE LINE
000661  2155                 ISZ ARG1        /ALL SPECIFIED LINES DELETED?
000662  5251                 JMP DELP1       /NO - CONTINUE
000663  1151                 TAD LSTN        /IF 1,/D..MAKE CURRENT=0
000664  7650                 SNA CLA
000665  3150                 DCA THSN
000666  1307                 TAD LISTER      /BUMP TOTAL DOWN
000667  1151                 TAD LSTN
000670  3151                 DCA LSTN
000671  5640                 JMP I DELP      /YES--RETURN--


             /HANDLER FOR <
000672  7344         EXLAS,  CLA CLL CMA RAL /PRINT LAST LINE - AC=7776=-2
             /HANDLER FOR > OR LINE FEED
000673  1150         EXNEX,  TAD THSN        /PRINT NEXT LINE
000674  7001                 IAC
000675  7450                 SNA             /IS IT AN EXISTING LINE?
000676  4135                 ERROR           /NO
000677  3154                 DCA ARG0        /YES SAVE EFFECTIVE ARGUMENTS
000700  7040                 CMA
000701  3155                 DCA ARG1
             /HANDLER FOR L COMMAND
000702  1066         LIST,   TAD LOW         /SET KEYBOARD AS OUTPUT
000703  3114                 DCA OUTDEV
000704  2111                 ISZ TABIND      /SET TAB INDICATOR
000705  4307                 JMS LISTER      /OUTPUT LINE(S)
000706  5547                 JMP I TE1       /*RETURN TO COMMAND MODE*

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 21



             /LISTING OUTPUT ROUTINE
             /OUTPUTS LINES INDICATED BY ARG0,ARG1

000707  0000         LISTER, 0
000710  1154                 TAD ARG0
000711  7640                 SZA CLA         /ANY ARGUMENTS?
000712  5322                 JMP L0          /YES - SET THEM UP
000713  1162                 TAD LSTCHK      /ALLOW 0L?
000714  7640                 SZA CLA
000715  4135                 ERROR           /NOPE
000716  1151                 TAD LSTN        /NO - SET TO LIST BUFFER
000717  7041                 CIA
000720  3155                 DCA ARG1
000721  2154                 ISZ ARG0        /SET TO LINE 1
000722  1154         L0,     TAD ARG0
000723  7041                 CIA
000724  1151                 TAD LSTN
000725  7710                 SPA CLA         /ARGUMENTS IN RIGHT RANGE?
000726  4135         L1,     ERROR           /NO -( OR JMP I TE1)
000727  1154                 TAD ARG0
000730  4460                 JMS I FIN1      /GET POINTERS
000731  3113                 DCA THIS        /SAVE POINTER
000732  7040                 CMA
000733  6211                 CDF 10
000734  1513                 TAD I THIS      /GET START
000735  3013                 DCA AXOUT
000736  1413                 TAD I AXOUT     /SAVE POINTER FOR SEARCH
000737  3117                 DCA XSAV
000740  1013                 TAD AXOUT       /SAVE OBJECT LINE FOR GRBG CLLCT        
000741  3116                 DCA MARK
000742  6201                 CDF 0
000743  7040                 CMA
000744  3105                 DCA XCT
000745  1154                 TAD ARG0        /SET POINTER
000746  3150                 DCA THSN
000747  2154                 ISZ ARG0        /SET FOR NEXT LINE
             /(HANDLER FOR FORM FEED DURING CHARACTER SEARCH)
000750  4457         L2,     JMS I UTR1      /UNPACK A  CHARACTER
000751  4465                 JMS I OUT1      /PRINT A CHARACTER
000752  1103         L3,     TAD CHAR        /OR (JMP SLOOK)
000753  1022                 TAD MCR
000754  7640                 SZA CLA         /WAS IT END OF LINE?
000755  5350                 JMP L2          /NO - KEEP UNPACKING
000756  2155                 ISZ ARG1        /YES - DONE YET?
000757  5322                 JMP L0          /NO - GET NEXT LINE
000760  5707                 JMP I LISTER    /YES --RETURN--


/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 22



             /----------------------------------------------------------
             /SEARCH ROUTINES


             /HANDLER FOR CARRIAGE RETURN
000761  4477         SRETN,  JMS I ENDLNI    /TERMINATE THIS LINE
000762  1116                 TAD MARK        /AND NOW GARBAGE COLLECT
000763  4515                 JMS I GRBAGE
000764  2155                 ISZ ARG1        /DONE YET?
000765  5461                 JMP I LIS1      /NO - GET NEXT LINE
000766  5547                 JMP I TE1       /YES*RETURN TO COMMAND MODE*

             /HANDLER FOR ^G DURING CHARACTER SEARCH
             /CHANGE SEARCH CHARACTER
000767  4454         SCONT,  JMS I KEYBD     /FETCH NEW SEARCH CHARACTER
000770  3045                 DCA LIST3+1     /STORE IT IN LIST
000771  5476                 JMP I L2I       /CONTINUE SEARCH

000772  4471         SLOOK,  JMS I SORTJ     /SEARCH DONE?
000773  0043                 LIST3-1         /(CARIRAGE RTRN OR SEARCH CHAR)
000774  1400                 LISTGO-LIST3    /YES - GO TO ITS HANDLER
000775  4472                 JMS I PACK1     /NO-PACK SEARCHED CHARACTERS
000776  5476                 JMP I L2I       /CONTINUE SEARCH

             /HANDLER FOR LINE FEED DURING SEARCH
000777  1031         SLINE,  TAD CCR
001000  3103                 DCA CHAR
001001  4477                 JMS I ENDLNI
001002  2154                 ISZ ARG0        /MOVE POINT
001003  2150                 ISZ THSN        /BUMP CURRENT LINE COUNT
001004  2151                 ISZ LSTN        /ADD A LINE.
             /HANDLER FOR _ DURING SEARCH
001005  1031         SBAR,   TAD CCR         /CTRL-U
001006  4465                 JMS I OUT1      /OUTPUT CARRIAGE RETURN
001007  1120                 TAD BUFR        /RESTART PACK BUFFER
001010  3016                 DCA AXIN
001011  3106                 DCA XCTIN
             /----------------------------------------------------------
001012  4451         SFOUND, JMS I CHI1      /GET A CHARACTER
001013  4471                 JMS I SORTJ     /SPECIAL SEARCH COMMAND?
001014  0036                 LIST6-1
001015  1400                 SRNLST-LIST6    /YES - GO TO HANDLER
             /HANDLER FOR SEARCH CHARACTER FOUND
001016  4472         SGOT,   JMS I PACK1     /NO-PACK INSERTS
001017  5212                 JMP SFOUND      /CONTINUE INPUT



/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 23



             /TELETYPE CHARACTER FETCH ROUTINE
             /ENTER WITH AC CLEAR
             /EXIT WITH CHARACTER IN CHAR AND AC
             /FORCE CHANNEL 8
             /BLANK TAPE & LEADER TRAILER IGNORED

001020  0000         CHIN,   0
001021  3103                 DCA CHAR        /CLEAR CHARACTER
001022  4454                 JMS I KEYBD
001023  0021                 AND P177        /MASK PARITY
001024  7450                 SNA             /IGNORE BLANK AND L/T
001025  5221                 JMP CHIN+1
001026  1025                 TAD C200        /RESTORE CHARACTER
001027  4465                 JMS I OUT1      /ECHO INPUT
001030  1103                 TAD CHAR
001031  5620                 JMP I CHIN      /--RETURN--


             /SEARCH TEXT BUFFER FOR LINE
             /WHOSE NUMBER IS ONE LESS THAN
             /THE CONTENTS OF THE AC
             /EXIT WITH ADDRESS OF LINK CELL IN AC

001032  0000         FIND,   0               /LOCATE LINE BUFFER
001033  7041                 CIA
001034  7500                 SMA             /IS LINE NUMBER TOO SMALL?
001035  4135                 ERROR           /YES
001036  3112                 DCA TEMP        /NO - STORE NEGATIVE OF LINE #
001037  1112                 TAD TEMP
001040  7001                 IAC
001041  1151                 TAD LSTN
001042  7710                 SPA CLA         /IS LINE NUMBER TOO LARGE?
001043  4135                 ERROR           /YES
001044  1121                 TAD CFRS        /NO
001045  5252                 JMP FIND1
001046  6211         FIND2,  CDF 10
001047  1510                 TAD I SAVE      /CHAIN THROUGH LIST
001050  6201                 CDF 0
001051  7440                 SZA             /FAILSAFE
001052  3110         FIND1,  DCA SAVE
001053  2112                 ISZ TEMP        /DONE YET?
001054  5246                 JMP FIND2       /NO - KEEP CHAINING
001055  1110                 TAD SAVE        /YES - GET LINE NUMBER
001056  5632                 JMP I FIND      /--RETURN--


001057  6030         CON,    6030    /CONVERSION CONSTANTS
001060  7634                 7634
001061  7766                 7766
001062  7777                 7777

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 24



       0104          BOX=COUNTP
       0154          VAL=ARG0

             /HANDLER FOR : OR =
             /PRINTS REQUESTED LINE NUMBER
             /WHICH IS FOUND IN ARG2 ON ENTRY

001063  1156         PRNT,   TAD ARG2
001064  3154                 DCA VAL         /SET NUMBER TO BE PRINTED
001065  1020                 TAD M4
001066  3105                 DCA CNT         /SET CHARACTER COUNT
001067  1321                 TAD ADDR
001070  3305                 DCA XYZ+2
001071  3104         FLOOZ,  DCA BOX
001072  7100                 CLL
001073  1154                 TAD VAL         /IF VAL IS TOO LARGE, IT LOOKS
001074  7700                 SMA CLA         /LIKE A NEG NO. THE LINK
001075  1322                 TAD K50         /DETERMINES THE END POINT THEN
001076  1323                 TAD K7430       /7430=SZL; 7500=SMA
001077  3306                 DCA XYZ+3
001100  5304                 JMP .+4
001101  2104                 ISZ BOX
001102  7100                 CLL
001103  3154         XYZ,    DCA VAL
001104  1154                 TAD VAL
001105  7000                 NOP             /TAD CON +() SOME DISPLACEMENT
001106  7500                 SMA             /OR, IF VAL TOO BIG,SZL
001107  5301                 JMP XYZ-2       /KEEP ADDING THE SAME CONSTANT
001110  7200                 CLA
001111  1104                 TAD BOX         /BOX HAS THE NUMBER COUNT
001112  1320                 TAD C260        /MAKE ASCII DIGIT
001113  4466                 JMS I OUTL1     /OUTPUT THE DIGIT
001114  2305                 ISZ XYZ+2       /ADD IN NEXT CONVERSION CONS LATER
001115  2105                 ISZ CNT         /DONE ALL FOUR?
001116  5271                 JMP FLOOZ       /NO - KEEP CONVERTING
001117  5547                 JMP I TE1       /YES*RETURN TO COMMAND MODE*

001120  0260         C260,   260
001121  1257         ADDR,   TAD CON
001122  0050         K50,    50
001123  7430         K7430,  7430

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 25



             /CHARACTER OUTPUT ROUTINE

001124  0000         OUT,    0
001125  3103                 DCA CHAR
001126  1107                 TAD ECHOSW
001127  7650                 SNA CLA         /ECHO SUPPRESSED?
001130  5724                 JMP I OUT       /YES--RETURN--
001131  4471                 JMS I SORTJ     /NO - IS IT A FORMAT CHARACTER?
001132  0027                 LIST4-1         /YES - EXIT TO ITS HANDLER
001133  1201                 OUTLIS-LIST4
001134  2152                 ISZ TCNT        /NO - COUNT ONE LETTER
001135  1103                 TAD CHAR
001136  4514         OUTX,   JMS I OUTDEV    /OUTPUT THE CHARACTER
001137  5724                 JMP I OUT       /--RETURN--


             /CARRIAGE RETURN HANDLER

001140  1031         OUTCRL, TAD CCR
001141  4514                 JMS I OUTDEV    /OUTPUT CARRIAGE RETURN
001142  3152                 DCA TCNT        /CLEAR TAB COUNTER
001143  1042                 TAD CLF         /OUTPUT LINE FEED
001144  5336                 JMP OUTX


             /TAB HANDLER - TAB/RUBOUT

001145  1030         OUTRT,  TAD CTAB
001146  4514                 JMS I OUTDEV    /OUTPUT TAB
001147  5724                 JMP I OUT       /YES--RETURN--


             /TAB HANDLER - SPACES

001150  1111         OUTTAB, TAD TABIND
001151  7650                 SNA CLA         /OUTPUT TAB/RUBOUT INSTEAD?
001152  5345                 JMP OUTRT       /YES - GO TO OTHER TAB HANDLER
001153  1152                 TAD TCNT        /NO -
001154  1047                 TAD MTABS       /REDUCE SPACE COUNT TO 8 OR LESS
001155  7500                 SMA
001156  5354                 JMP .-2
001157  3152                 DCA TCNT
001160  1026                 TAD C240        /OUTPUT SPACES
001161  4514                 JMS I OUTDEV
001162  2152                 ISZ TCNT        /DONE YET?
001163  5360                 JMP .-3         /NO - CONTINUE
001164  5724                 JMP I OUT       /YES--RETURN--


/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 26



             /----------------------------------------------------------
             /I-O SUBROUTINES


             /HANDLER FOR S COMMAND

001165  4454         XCRET,  JMS I KEYBD     /GET THE SEARCH CHARACTER
001166  3045                 DCA LIST3+1     /SAVE IT IN LIST
001167  1074                 TAD SXS2
001170  3475                 DCA I L3I       /MAKE LISTER JUMP TO SLOOK
001171  1120                 TAD BUFR
001172  3016                 DCA AXIN        /BUILD NEW TEXT IMAGE HERE
001173  3106                 DCA XCTIN
001174  1051                 TAD CHI1        /READ POINT IS CHIN
001175  7001                 IAC
001176  3052                 DCA IGNORE
001177  5461                 JMP I LIS1

             /LIST OF SPECIAL CHARACTERS FOR G COMMAND
       1200          TAGLIST=.
001200  1341                 GTAG2   /SPACE
001201  1341                 GTAG2   //
001202  1341                 GTAG2   /TAB
001203  1341                 GTAG2   /CARRIAGE RETURN

             /----------------------------------------------------------
001204  0422         APPL,   APP1
001205  0426         XNSL,   XNS1
001206  0425         CNGEL,  CNGE1


             /LOW SPEED OUTPUT ROUTINE
             /ENTER WITH CHARACTER IN AC

001207  0000         OUTL,   0
001210  4777'                JMS TOUT
001211  5607                 JMP I OUTL      /--RETURN--

             /LOW SPEED INPUT ROUTINE
             /^C TAKES AN ASYNCRONOUS EXIT
             /EXIT WITH CHARACTER IN AC

001212  0000         I33,    0
001213  4776'                JMS KIN         /GET A CHARACTER FROM MONITOR
001214  0375                 AND (177        /CONVERT TO INDEPENDENT 8 BIT
001215  1374                 TAD (200
001216  5612                 JMP I I33       /NO--RETURN--

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 27



             /SET UP APPEND, CHANGE, INSERT TO WORK
             /EACH READS KEYBOARD, NOT DEVICE

             /HANDLER FOR A COMMAND
001217  1204         APP,    TAD APPL
001220  5224                 JMP SET

             /HANDLER FOR I COMMAND
001221  1205         XNS,    TAD XNSL
001222  5224                 JMP SET

             /HANDLER FOR C COMMAND
001223  1206         CNGE,   TAD CNGEL
001224  3230         SET,    DCA DEST        /RETURN POINT
001225  2107                 ISZ ECHOSW
001226  4533                 JMS I PSETUP
001227  1020                 CHIN            /KEYBOARD INPUT
001230  0422         DEST,   APP1


             /SPECIAL OUTPUT LIST
       1231          OUTLIS=.
001231  1150                 OUTTAB  /211 - TAB
001232  1140                 OUTCRL  /215 - CARRIAGE RETURN
001233  1137                 OUTX+1  /212 - LINE FEED
001234  1137                 OUTX+1  /214 - FORM FEED
001235  1137                 OUTX+1  /377 - RUBOUT


/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 28




             /HANDLER FOR P COMMAND

001236  2107         PUNCH,  ISZ ECHOSW
001237  1131                 TAD BUFWTI      /SETUP TO WRITE INTO OUTPUT BUFFER
001240  3114                 DCA OUTDEV
001241  4462         PUNC,   JMS I LIS       /WRITE THE EDITOR BUFFER
001242  1040                 TAD C214        /OUTPUT FORM FEED
001243  4514                 JMS I OUTDEV
             /HANDLER FOR T COMMAND - REMOVED FOR CAS-8
001244  5547                 JMP I TE1       /*RETURN TO COMMAND MODE*

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 29


             /HANDLER FOR R COMMAND

       1245          TELE=.
001245  3107         TELEN,  DCA ECHOSW      /INHIBIT ECHO
001246  4533                 JMS I PSETUP    /SETUP TO READ FROM
001247  3663                 BUFRD           /INPUT DEVICE
001250  0422                 APP1            /APPEND TEXT TO BUFFER

             /HANDLER FOR Y COMMAND

001251  1274         YANK,   TAD COM1        /YANK KILLS 'P' PART OF N
001252  3456                 DCA I CCON+1
001253  5256                 JMP COMBOA

             /HANDLER FOR N COMMAND

001254  1134         COMBO,  TAD JMPCH       /YANK WIPES COM1-1
001255  3456                 DCA I CCON+1
001256  1154         COMBOA, TAD ARG0
001257  7450                 SNA             /ANY ARGUMENTS
001260  7001                 IAC             /NO - ASSUME 1
001261  7041                 CIA
001262  3104                 DCA COUNTP      /SET NUMBER OF PAGES TO YANK
001263  1055                 TAD CCON        /(JMP I AXCOMB)
001264  3547                 DCA I TE1       /SET TE1 TO ALLOW LOOPING
001265  1056         COMB,   TAD CCON+1      /THROUGH PUNCH, KILL, READ
001266  3014                 DCA AXCOMB      /CYCLE
001267  3154                 DCA ARG0        /CLEAR ARGUMENTS
001270  3156                 DCA ARG2
001271  3162                 DCA LSTCHK      /DON'T INHIBIT LISTER!
001272  3111                 DCA TABIND      /CLEAR IN CASE OF MULTIPLE N
001273  5241                 JMP PUNC        /OUTPUT BUFFER
001274  5522         COM1,   JMP I KILL1     /KILL BUFFER
001275  5245                 JMP TELEN       /READ NEW BUFFER FULL
001276  2104                 ISZ COUNTP      /DONE YET?
001277  5265                 JMP COMB        /NO - CONTINUE
001300  7324                 CLA CLL CML RAL /YES-AC=1 - RESET CURRENT LINE #
001301  3150                 DCA THSN        /.=1 ON RETURN
001302  1067         COM5,   TAD CZ          /RESTORE TE1
001303  3547                 DCA I TE1
001304  5547                 JMP I TE1       /*RETURN TO COMMAND MODE*
             /IT IS VITAL TO KEEP DUMB1 AND COM5 ON THE SAME PAGE
001305  2260         DUMB1,  JERK1

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 30




       1306          LIST1=.
001306  0212                 212             /LINE FEED
001307  0240                 240             /SPACE
001310  0253                 253             /PLUS (+)
001311  0254                 254             /COMMA (,)
001312  0255                 255             /MINUS (-)
001313  0256                 256             /PERIOD (.)
001314  0257                 257             /SLASH (/)
001315  0274                 274             /<
001316  0275                 275             /=
001317  0276                 276             />
001320  0000                 000             /(DUMMY ENTRY)
001321  0375                 375             /ALTMODE ASR-33
001322  0376                 376             /ALTMODE ASR-35
001323  0233                 233             /ESCAPE KEY
001324  0242                 242             /DOUBLE QUOTE (")
001325  0244                 244             /DOLLAR SIGN ($)
001326  0377                 377             /RUBOUT
001327  0272                 272             /COLON (:)
001330  0215         LIST1A, 215             /CARRIAGE RETURN
001331  0225                 225             /^U
001332  0203                 203             /^C


             /HANDLER FOR G COMMAND

001333  2150         GETTAG, ISZ THSN
001334  1154                 TAD ARG0
001335  7450                 SNA             /ANY ARGUMENTS
001336  1150                 TAD THSN        /NO - BEGIN WITH NEXT LINE (.+1)
001337  3154                 DCA ARG0        /YES - SET ARGUMENTS
001340  7410                 SKP
001341  2154         GTAG2,  ISZ ARG0
001342  7001                 IAC
001343  1154                 TAD ARG0
001344  4460                 JMS I FIN1      /GET NEXT LINE
001345  3013                 DCA AXOUT
001346  7040                 CMA
001347  3105                 DCA XCT
001350  4457                 JMS I UTR1      /UNPACK FIRST CHARACTER
001351  4471                 JMS I SORTJ     /DOES IT BEGIN A TAG?
001352  0025                 LIST7-1         /NO - TAGLIST EXITS
001353  1152                 TAGLIST-LIST7   /TO GTAG2
001354  5461                 JMP I LIS1      /YES - PRINT LINE

001374  0200
001375  0177
001376  4240
001377  4235
       1400                  PAGE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 31




       0155          MP1=ARG1
       0154          MP2=ARG0
       0156          MP3=ARG2

             /HANDLER FOR M COMMAND
             /ENTER WITH FIRST LINE TO MOVE IN MOV1
             /LAST LINE TO MOVE IN MOV2
             /MOV2 .GT. MOV1
             /DESTINATION LINE IN ARG2


001400  1104         MOVEM,  TAD MOV1
001401  7041                 CIA             /ARG2 MAY NOT BE BETWEEN
001402  1156                 TAD ARG2        /MOV1 AND MOV2
001403  7710                 SPA CLA         /IS MOV1 .GT. ARG2?
001404  5212                 JMP .+6         /YES - O.K.
001405  1160                 TAD MOV2
001406  7040                 CMA
001407  1156                 TAD ARG2
001410  7750                 SPA SNA CLA     /IS MOV2 .LT. ARG2?
001411  4135                 ERROR           /NO-FAULTY LOGIC IN COMMAND
001412  1104                 TAD MOV1        /YES
001413  4460                 JMS I FIN1
001414  3155                 DCA MP1         /STORE FIRST LINE POINTER
001415  7001                 IAC
001416  1160                 TAD MOV2
001417  4460                 JMS I FIN1
001420  3154                 DCA MP2         /STORE LAST LINE POINTER
001421  1156                 TAD ARG2
001422  4460                 JMS I FIN1
001423  3156                 DCA MP3         /STORE DESTINATION LINE POINTER
001424  6211                 CDF 10          /ALL FOUND
001425  1555                 TAD I MP1       /SWAP POINTERS-
001426  3112                 DCA TEMP        /RESET THE LINK COORDS
001427  1554                 TAD I MP2
001430  3555                 DCA I MP1
001431  1556                 TAD I MP3
001432  3554                 DCA I MP2
001433  1112                 TAD TEMP
001434  3556                 DCA I MP3
001435  6201                 CDF 0
001436  5547                 JMP I TE1       /*RETURN TO COMMAND MODE*

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 32



       1437          SRNLST=.
001437  1005                 SBAR            /BACK ARROW (_)
001440  0750                 L2              /FORM FEED
001441  0767                 SCONT           /BELL
001442  0777                 SLINE           /LINE FEED
001443  1446                 RUB1            /RUB OUT

       1444          LISTGO=.
001444  0761                 SRETN           /CARRIAGE RETURN
001445  1016                 SGOT            /SEARCH CHARACTER FOUND

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 33



             /HANDLER FOR RUBOUT IN TEXT OR SEARCH
001446  1016         RUB1,   TAD AXIN
001447  7041                 CIA
001450  1120                 TAD BUFR
001451  1106                 TAD XCTIN
001452  7640                 SZA CLA         /IS THERE ANYTHING ON THIS LINE?
001453  1107                 TAD ECHOSW      /OR ECHO INHIBITED?
001454  7650                 SNA CLA
001455  5452                 JMP I IGNORE    /YES-IGNORE RUBOUT
001456  1102                 TAD SPLAT       /NO-
001457  4465                 JMS I OUT1      /OUTPUT BACKSLASH
001460  1016                 TAD AXIN        /GET LAST WORD OF INPUT
001461  3104                 DCA MOV1
001462  6211                 CDF 10
001463  3520                 DCA I BUFR      /PREVENTS INFINITE RUBOUTS
001464  1504                 TAD I MOV1
001465  2106                 ISZ XCTIN       /WHICH HALF OF WORD?
001466  5305                 JMP RUB2
001467  0010                 AND C77
001470  1007                 TAD M77
001471  7640                 SZA CLA         /TEST EXTENSION
001472  5302                 JMP RUB4
001473  7040         RUB3,   CMA
001474  3106                 DCA XCTIN
001475  7040                 CMA
001476  1016                 TAD AXIN
001477  3016                 DCA AXIN
001500  1504                 TAD I MOV1
001501  0313                 AND P7700
001502  3153         RUB4,   DCA ADD
001503  6201                 CDF 0
001504  5452                 JMP I IGNORE    /CHIN+1
001505  0313         RUB2,   AND P7700
001506  1011                 TAD C100
001507  7640                 SZA CLA
001510  5273                 JMP RUB3
001511  3504                 DCA I MOV1
001512  5274                 JMP RUB3+1

001513  7700         P7700,  7700

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 34



             /HANDLER FOR SPACE IN TEXT MODE
001514  1107         SPACES, TAD ECHOSW
001515  7200                 CLA             /OR SZA CLA IF B OPTION
001516  5500                 JMP I SPCNO     /PACK IT - (MOR+4)
001517  7040                 CMA             /SET COUNTER
001520  3105         SP2,    DCA CNT
001521  4530                 JMS I BUFRDI    /GET LAST CHARACTER
001522  1023                 TAD M240
001523  7650                 SNA CLA         /WAS IT SPACE?
001524  5320                 JMP SP2         /YES-IGNORE EXTRA SPACES
             /----------------------------------------------------------
001525  1103                 TAD CHAR        /NO
001526  3110                 DCA SAVE        /SAVE NON-SPACE
001527  2105                 ISZ CNT         /WAS THERE MORE THAN 1 SPACE?
001530  1035                 TAD M27         /YES- STORE TAB
001531  1026                 TAD C240        /NO-STORE SPACES
001532  3103                 DCA CHAR
001533  4472                 JMS I PACK1
001534  1110                 TAD SAVE
001535  5501                 JMP I SPCGO     /SORT - (MOR+1)

             /HANDLER FOR $ (PART OF M COMMAND)

001536  1154         MOVE,   TAD ARG0        /ARG2 .GE. ARG0
001537  7041                 CIA
001540  1156                 TAD ARG2
001541  7710                 SPA CLA         /ARE LINES TO BE MOVED LEGITIMATE
001542  4135                 ERROR           /NO
001543  1154                 TAD ARG0        /YES-
001544  3104                 DCA MOV1        /SET POINTER TO FIRST LINE
001545  1156                 TAD ARG2
001546  3160                 DCA MOV2        /SET POINTER TO LAST LINE
001547  5470                 JMP I ONUM      /CONTINUE COMMAND INPUT

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 35



001550  0673         OPS1,   EXNEX           /LINE FEED
001551  0224                 GEXP            /SPACE
001552  0224                 GEXP            /PLUS
001553  2715                 FIRS            /COMMA
001554  0225                 GMIN            /MINUS
001555  1653                 PERI            /POINT(.)
001556  1655                 SLAS            /SLASH
001557  0672                 EXLAS           /BACKUP(<)
001560  1063                 PRNT            /=
001561  0673                 EXNEX           /ALT(>)
001562  0227                 DBCV2           /DUMMY
001563  2251                 AMODE           /ALTMODE ASR-33
001564  2251                 AMODE           /ALTMODE ASR-35
001565  2251                 AMODE           /ESCAPE KEY
001566  2307                 DBLQUO          /"
001567  1536                 MOVE            /DOLLAR SIGN
001570  0136                 ELIM            /COMMAND RUBOUT
001571  1063                 PRNT            /:
001572  0220                 GTOP-2          /CARRIAGE RETURN
001573  0201                 START           /^U
001574  4135                 ERROR           /^C CAN'T HAPPEN IN CAS-8
001575  0255         OPS1A,  RETRN           /RETURN
             /----------------------------------------------------------
001576  0201                 START           /^U
001577  4135                 ERROR           /^C CAN'T HAPPEN IN CAS-8
       1600                  PAGE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 36


             / END OF WORK BUFFER CHECK ROUTINE

001600  0000         TBUF,   0
001601  7100                 CLL
001602  1016                 TAD AXIN        /GET CURRENT POINTER
001603  1377                 TAD (3610       /KEYBOARD MON SHOT?
001604  7620                 SNL CLA
001605  5600                 JMP I TBUF      /NO
001606  3776'                DCA INCORE      /LONG BOOT STRAP
001607  1016                 TAD AXIN
001610  1375                 TAD (1610       /END OF BUFFER?
001611  7630                 SZL CLA
001612  5600                 JMP I TBUF      /NO
001613  4135                 ERROR


             /HANDLER FOR E COMMAND

001614  1126         ENDFIL, TAD EKILLL      /IS E COMMAND ALLOWED?
001615  7640                 SZA CLA
001616  4135                 ERROR           /NO-NO INPUT SPECIFIED
001617  7240                 CLA CMA         /YES-RESET ARGUMENTS
001620  3154                 DCA ARG0
001621  1143                 TAD JMPTE1      /SKIP LISTER IF EMPTY BUFFER
001622  3525                 DCA I L1I
001623  1227                 TAD FLCLSI      /CLOSE FILE SETUP
001624  3136                 DCA ELIM        /CLOSES FILE ON READ FAILURE
001625  5626                 JMP I COMBOP

001626  1254         COMBOP, COMBO
001627  5532         FLCLSI, JMP I CLFLI
001630  0444         AONEI,  AONE

             /HANDLER FOR ^U IN TEXT MODE
001631  4233         CTRLU,  JMS CTRLU1      /GENERATE A ^U
001632  5630                 JMP I AONEI     /AND CONTINUE

             /PRINT ^U
001633  0000         CTRLU1, 0
001634  1241                 TAD C325
001635  4544                 JMS I UPAROI    /PRINT ^U
001636  1031                 TAD CCR         /AND A CR/LF
001637  4465                 JMS I OUT1
001640  5633                 JMP I CTRLU1    /--RETURN--
001641  0325         C325,   325

             /CHECK VALIDITY OF ARGUMENTS
             /FOR D COMMAND
001642  0000         CHKARX, 0
001643  1154                 TAD ARG0
001644  7041                 CIA
001645  7001                 IAC
001646  1155                 TAD ARG1
001647  1151                 TAD LSTN

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 36-1

001650  7710                 SPA CLA         /DO LINES EXIST?
001651  4135                 ERROR           /NO
001652  5642                 JMP I CHKARX    /YES--RETURN--

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 37



             /HANDLER FOR .
001653  1150         PERI,   TAD THSN
001654  7410                 SKP
             /HANDLER FOR /
001655  1151         SLAS,   TAD LSTN
001656  3112                 DCA TEMP        /SAVE LINE NUMBER
001657  3103                 DCA CHAR
001660  2162                 ISZ LSTCHK      /GOT EITHE . OR / IN ARGS
001661  5662                 JMP I .+1       /FETCH REST OF ARGUMENT
001662  0236                 GLOM

             /END OF A NEW TEXT LINE
             /PACK CARRIAGE RETURN INTO BUFFER
             /SET LINK CELLS AROUND NEW LINE
             /ENTER WITH:
             /       CHAR CONTAINS CARRIAGE RETURN
             /       THIS CONTAINS ADDRESS OF LINK
             /       CELL OF PRECEDING TEXT LINE
             /       XSAV CONTAINS ADDRESS OF LINK
             /       CELL OF FOLLOWING TEXT LINE
             /       BUFR CONTAINS ADDRESS OF LINK
             /       CELL OF NEW TEXT LINE

001663  0000         ENDLN,  0
001664  4472                 JMS I PACK1     /PACK CARRIAGE RETURN
001665  6211                 CDF 10
001666  1153                 TAD ADD
001667  7440                 SZA
001670  3416                 DCA I AXIN
001671  1120                 TAD BUFR        /RESET LINK CELL
001672  3513                 DCA I THIS      /OF PREVIOUS LINE
001673  1117                 TAD XSAV
001674  3520                 DCA I BUFR      /RESET LINK CELL OF NEW LINE
001675  1120                 TAD BUFR
001676  3113                 DCA THIS        /RESET POINTER TO LINK CELL
001677  2016                 ISZ AXIN
001700  1016                 TAD AXIN
001701  3120                 DCA BUFR        /RESET FOR NEXT LINE
001702  3106                 DCA XCTIN       /CR CHARACTER SWITCH
001703  6201                 CDF 0
001704  5663                 JMP I ENDLN     /--RETURN--

001775  1610
001776  2046
001777  3610
       2000                  PAGE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 38




             /HANDLER FOR Q COMMAND

002000  1173         Q,      TAD OUTINH      /OPENED OUTPUT FILE?
002001  7650                 SNA CLA         /WAS AN OUTPUT DEVICE SPECIFIED?
002002  4135                 ERROR           /NO-
002003  1151         FLCLOS, TAD LSTN
002004  7650                 SNA CLA         /IS BUFFER EMPTY?
002005  5212                 JMP FLCLS1      /YES-CLOSE FILE
002006  1245                 TAD FLCLI       /NO-
002007  3147                 DCA TE1         /SET UP RETURN FROM P COMMAND
002010  5611                 JMP I .+1
002011  1236                 PUNCH           /WRITE CURRENT BUFFER

             /CLOSE FILE ON E OR Q COMMAND
             / THE OUTPUT CLOSE ROUTINE
002012  1377         FLCLS1, TAD (232&177    /GET AN (^Z)
002013  4776'                JMS OCHAR       /WRITE IT INTO THE BUFFER
002014  1375                 TAD (200
002015  1172                 TAD OUWDCT      /SEE IF IT FORCED A WRITE
002016  7640                 SZA CLA         /
002017  4774'                JMS OUWRT       /NO.. SO WE FORCE IT
002020  4773'                JMS INTWT       /FINISH LAST OPERATION
002021  1772'                TAD OUNIT       /GET THE OUTPUT UNIT
002022  6212                 CIF 10
002023  4771                 CALL (CLOSE     /CLOSE THE FILE
002024  5770'                JMP CLERR       /FILE O.K., BUT LET USER KNOW
002025  6212                 CIF 10
002026  1171                 TAD INUNIT      /REWIND UNITS
002027  4767                 CALL (UTIL
002030  0010                 10
002031  7000                 NOP             /IGNORE ERRORS
002032  1246         ETOMON, TAD INCORE
002033  6212                 CIF 10
002034  7640                 SZA CLA
002035  5766'                JMP 5200
002036  6202                 CIF 0
002037  3765'                DCA CTRLCJ      /CLEAR MONITOR RETURN LOCATION
002040  4764'                JMS WRTMSG
002041  3554                 UPC
002042  4763'                JMS KIN
002043  7600                 7600
002044  5643                 JMP I .-1


002045  2012         FLCLI,  FLCLS1
002046  0001         INCORE, 01              /MONITOR INCORE SWITCH

002163  4240
002164  3317
002165  7604
002166  5200
002167  7200

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 38-1

002170  4325
002171  6400
002172  4105
002173  4243
002174  4123
002175  0200
002176  4111
002177  0032
       2200                  PAGE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 39



002200  0000         SRCBUF, ZBLOCK 24       /SEARCH BUFFER


             /SPECIAL CHARACTER LIST FOR STRING SEARCH
       2224          SLST=.
002224  0247                 247             /"
002225  0242                 242             /'
002226  0377                 377             /RUBOUT
002227  0203                 203             /^C
002230  0225                 225             /^U
002231  5705         NEXBUF, DUMB1&177+5600  /JMP I DUMB1    

             /DISPATCH LIST FOR STRING SEARCH

002232  2431         OSLST,  QUO1            /"
002233  2430                 QUO2            /'
002234  2573                 FORGET          /RUBOUT
002235  4135                 ERROR           /^C CAN'T HAPPEN IN CAS-8
002236  2247                 RLEAS           /^U IN STRING SEARCH

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 40




             /GENERATE ^ FOLLOWED BY THE CHARACTER
             /WHICH IS IN AC ON ENTRY

002237  0000         UPAROW, 0
002240  3160                 DCA TEMPO       /SAVE CHARACTER
002241  1246                 TAD C336
002242  4466                 JMS I OUTL1     /PRINT ^
002243  1160                 TAD TEMPO
002244  4466                 JMS I OUTL1     /PRINT CHARACTER
002245  5637                 JMP I UPAROW    /--RETURN--
002246  0336         C336,   336


             /HANDLER FOR ^U DURING STRING SEARCH
002247  4777         RLEAS,  JMS I (CTRLU1
002250  5776                 JMP I (START    /^U GETS US BACK TO #

             /HANDLER FOR ALTMODE

002251  3145         AMODE,  DCA STRIND      /NEED SETUP
002252  4546                 JMS I STRFIN    /SEARCH FOR STRING
002253  4135                 ERROR
002254  1150                 TAD THSN        /RESULT IS LINE NUMBER
002255  5656                 JMP I .+1       /LINK TO COMMAND STRUCTURE
002256  0223                 GTOP+1


             /HANDLER FOR J COMMAND

002257  3145         JERK,   DCA STRIND      /SETUP FOR SEARCH
002260  4546         JERK1,  JMS I STRFIN    /SEARCH FOR STRING
002261  5265                 JMP GMOR        /GET NEXT BUFFER
002262  1067                 TAD CZ          /RESTORE MONITOR EXIT
002263  3547                 DCA I TE1
002264  5547                 JMP I TE1       /*POSSIBLE RETURN TO COMMAND MODE*

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 41



             /GET NEXT BUFFER FOR S SEARCH

002265  1706         GMOR,   TAD I CNTRI
002266  7650                 SNA CLA         /IS BUFFER EMPTY?
002267  4135                 ERROR           /NO
002270  2145                 ISZ STRIND      /YES-BYPASS SETUP
002271  1231                 TAD NEXBUF
002272  3557                 DCA I COMM5     /SET UP READ OF ONE BUFFER
002273  7001                 IAC
002274  3154                 DCA ARG0
002275  1126                 TAD EKILLL
002276  7640                 SZA CLA         /IS THERE AN OUTPUT DEVICE?
002277  5701                 JMP I .+2       /NO
002300  5702                 JMP I .+2       /YES
002301  1251                 YANK            /NO OUTPUT
002302  1254                 COMBO           /THERE IS OUTPUT


             /HANDLER FOR F COMMAND

002303  2145         BARROW, ISZ STRIND      /CONTINUES LOOK FOR EXISTING STRING
002304  2150                 ISZ THSN        /INCREMENT FOR NEXT LINE
002305  5260                 JMP JERK1
002306  2564         CNTRI,  CNTR

             /HANDLER FOR "

002307  2150         DBLQUO, ISZ THSN        /USES STRING NOW IN BUFFER
002310  2145                 ISZ STRIND      /NO SETUP REQUIRED
002311  5252                 JMP AMODE+1

             /HANDLER FOR B COMMAND

002312  1120         CORSPC, TAD BUFR        /YES-SET UP NUMBER OF LOCATIONS
002313  7041                 CIA             /IN ARG2
002314  1127                 TAD BUFEND
002315  1321                 TAD K400
002316  3156                 DCA ARG2
002317  5720                 JMP I .+1
002320  1063                 PRNT
002321  0400         K400,   400

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 42



             /HANDLER FOR K COMMAND

002322  1154         KILL,   TAD ARG0        /IN CASE HE TYPED N,MK
002323  7640                 SZA CLA         /INSTEAD OF N,ML. SAVE HIM!!
002324  4135                 ERROR
002325  1053                 TAD END         /RESET BUFFER POINTERS
002326  3120                 DCA BUFR        /TO REFLECT EMPTY BUFFER
002327  3151                 DCA LSTN
002330  3150                 DCA THSN
002331  6211                 CDF 10          /ZERO FIELD 1 POINTER
002332  3521                 DCA I CFRS
002333  6201                 CDF 0
002334  5547                 JMP I TE1       /*RETURN TO COMMAND MODE*

             / READ A RECORD FROM INPUT FILE
002335  0000         READ,   0
002336  4775'                JMS INTWT       /WAIT FOR LAST OPERATION
002337  1353                 TAD INEOF       /CHECK TO SEE IF LAST READ EOF'D
002340  7640                 SZA CLA
002341  5735                 JMP I READ      /IGNORE THIS READ
002342  1374                 TAD (INERRX     /SET NEW ERROR POINT
002343  3773'                DCA ERET
002344  6212                 CIF 10
002345  1171                 TAD INUNIT
002346  4772                 CALL (HANDLER
002347  0000                 0               /READ INTO FIELD 0
002350  6400         INBUFP, 6400            /INPUT BUFFER ADDRESS
002351  5771'                JMP RDERR       /READ FAILED
002352  5735                 JMP I READ

002353  0000         INEOF,  0       /INITIAL VALUE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 43


002371  4327
002372  6600
002373  4250
002374  4334
002375  4243
002376  0201
002377  1633
       2400          *2400
             /----------------------------------------------------------
             /----------------------------------------------------------
             /STRING SEARCH ROUTINE
             /CALLED BY $(ALTMODE) AND J COMMAND HANDLERS

002400  0000         SFIND1, 0
002401  2107                 ISZ ECHOSW
002402  1145                 TAD STRIND      /IS SETUP NECESSARY
002403  7640                 SZA CLA
002404  5240                 JMP SFIND2      /NO.
002405  1372                 TAD MSCNT
002406  3366                 DCA BUFCNT      /SET COUNTER
002407  1371                 TAD SBUF
002410  3016                 DCA AXIN        /BEGIN SEARCH BUFFER
002411  1361                 TAD ATSIGN
002412  4466                 JMS I OUTL1     /OUTPUT $
002413  2111                 ISZ TABIND
002414  4451         RLOOP,  JMS I CHI1      /FETCH CHARACTER FROM TTY
002415  4471                 JMS I SORTJ     /IS IT SPECIAL FOR SEARCH STRING?
002416  2223                 SLST-1          /YES-HANDLE IT
002417  0006                 OSLST-SLST
002420  2366                 ISZ BUFCNT      /NO-SEARCH BUFFER FULL?
002421  5225                 JMP STORE       /NO-STORE THIS CHARACTER
002422  7240                 CLA CMA
002423  3366                 DCA BUFCNT      /YES-DON'T ALLOW ANY MORE
002424  5213                 JMP RLOOP-1     /BUT KEEP ECHOING HIS
002425  1103         STORE,  TAD CHAR        /STORE CHARACTER IN SEARCH BUFFER
002426  3416                 DCA I AXIN
002427  5214                 JMP RLOOP

             /HANDLER FOR "
002430  1150         QUO2,   TAD THSN        /START AT .+1
             /HANDLER FOR '
002431  7001         QUO1,   IAC             /START AT .=1
002432  3150                 DCA THSN
002433  1016                 TAD AXIN
002434  7041                 CIA             /MAKE UP COUNT OF NO. CHARS NOW IN
002435  1371                 TAD SBUF        /SEARCH BUFFER
002436  3364                 DCA CNTR
002437  3416                 DCA I AXIN      /END STRING WITH A 0
002440  1364         SFIND2, TAD CNTR
002441  7650                 SNA CLA         /IS BUFFER EMPTY?
002442  5335                 JMP ER1         /YES-PREPARE TO EXIT
002443  4350                 JMS NUCHAR      /NO GET FIRST STRING CHARACTER
002444  1150                 TAD THSN
002445  4460                 JMS I FIN1      /GET APPROPRIATE POINTER

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 43-1

002446  3113                 DCA THIS        /THE TRICK IS TO GET THE NEXT
002447  3370                 DCA CHFND
002450  6211                 CDF 10          /POINTER SO THAT WE NEVER HAVE TO GO
002451  1513                 TAD I THIS      /BACK TO THE FIND ROUTINE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 44



002452  3363         COMBAK, DCA TMP2
002453  1763                 TAD I TMP2
002454  3367                 DCA NEXTPT
002455  6201                 CDF 0
002456  1150                 TAD THSN
002457  7041                 CIA
002460  1151                 TAD LSTN
002461  7710                 SPA CLA         /LAST LINE?
002462  5335                 JMP ER1         /YES-FINISHED WITH BUFFER
002463  1363                 TAD TMP2        /NO
002464  3013                 DCA AXOUT       /SET TO UNPACK CHARACTERS
002465  7040                 CMA
002466  3105                 DCA XCT
002467  4457         UPK1,   JMS I UTR1      /UNPACK A CHARACTER
002470  3363                 DCA TMP2
002471  1363                 TAD TMP2
002472  1022                 TAD MCR
002473  7640                 SZA CLA         /END OF LINE?
002474  5303                 JMP NOCR        /NO
002475  2150                 ISZ THSN        /YES-INCREMENT LINE COUNTER
002476  4350                 JMS NUCHAR      /FORGET PREVIOUS MATCHES ON NEW LINE
002477  3370                 DCA CHFND
002500  6211                 CDF 10
002501  1367                 TAD NEXTPT      /AND GET NEXT LINE
002502  5252                 JMP COMBAK

002503  1363         NOCR,   TAD TMP2        /CHARACTER OTHER THAN CARRIAGE RTRN
002504  1362                 TAD TMP1        /GET A CHARACTER FROM SEARCH BUFFER
002505  7640                 SZA CLA         /DO THEY MATCH
002506  5314                 JMP UPK         /NO
002507  2370                 ISZ CHFND       /YES-BUMP A RANDOM POINTER
002510  7240                 CLA CMA
002511  3365                 DCA FMATCH      /SIGNIFY FIRST MATCH
002512  4344                 JMS NUCHA       /GET NEXT SEARCH CHARACTERR
002513  5267                 JMP UPK1        /AND ANOTHER BUFFER CHARACTER

002514  2365         UPK,    ISZ FMATCH      /WAS THIS FIRST MATCH?
002515  5326                 JMP NOTSO       /NO-NO PROBLEM
002516  1105                 TAD XCT         /YES-DON'T LET THE POINTERS BE
002517  7710                 SPA CLA         /BE CHANGED
002520  5325                 JMP WREK
002521  7040                 CMA
002522  1013                 TAD AXOUT
002523  3013                 DCA AXOUT
002524  7040                 CMA
002525  3105         WREK,   DCA XCT
002526  4350         NOTSO,  JMS NUCHAR      /GET 1ST CHARACTER OF SEARCH STRING
002527  3370                 DCA CHFND
002530  5267                 JMP UPK1        /TRY AGAIN

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 45



002531  1370         STFIN,  TAD CHFND       /END OF STRING-DO COUNTS MATCH?
002532  1364                 TAD CNTR
002533  7650                 SNA CLA
002534  5342                 JMP GOOD        /YES-SEARCH SUCCESSFUL
002535  1151         ER1,    TAD LSTN        /IF BUFFER EMPTY, SET .=0
002536  7640                 SZA CLA
002537  7001                 IAC
002540  3150                 DCA THSN
002541  7410                 SKP             /CAUSE ERROR RETURN (?)
002542  2200         GOOD,   ISZ SFIND1      /INCREMENT RETURN
002543  5600                 JMP I SFIND1    /--RETURN--

             /GET NEXT SEARCH CHARACTER
002544  0000         NUCHA,  0
002545  1344                 TAD .-1         /SET TO RETURN FROM NUCHAR
002546  3350                 DCA NUCHAR
002547  5353                 JMP NEXX

             /GET FIRST CHARACTER OF SEARCH STRING
002550  0000         NUCHAR, 0
002551  1371                 TAD SBUF
002552  3016                 DCA AXIN
002553  1416         NEXX,   TAD I AXIN
002554  7450                 SNA             /END OF STRING?
002555  5331                 JMP STFIN       /YES
002556  7041                 CIA             /NO - NEGATE SEARCH CHARACTER
002557  3362                 DCA TMP1        /AND STORE IT
002560  5750                 JMP I NUCHAR    /--RETURN--

       2177          ENDA=SRCBUF-1
002561  0244         ATSIGN, 244
002562  0000         TMP1,   0
002563  0000         TMP2,   0
002564  0000         CNTR,   0
002565  0000         FMATCH, 0
002566  0000         BUFCNT, 0
002567  0000         NEXTPT, 0
002570  0001         CHFND,  1               /MUST BE NONZERO INITIALLY
002571  2177         SBUF,   ENDA
002572  7754         MSCNT,  -24

             /HANDLER FOR RUBOUT IN SEARCH STRING

002573  1031         FORGET, TAD CCR
002574  4465                 JMS I OUT1      /OUTPUT CARRIAGE RETURN
002575  5201                 JMP SFIND1+1


/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 46



       2600                  *2600
             /----------------------------------------------------------
             /----------------------------------------------------------
       0104                  THISX=COUNTP
       0135                  THISX2=DTEM


             /GARBAGE COLLECTION ROUTINE
             /ENTER WITH NUMBER OF LINE TO BE DELETED
             /IN AC

002600  0000         GARBAG, 0
002601  3270                 DCA LINPTR      /SAVE OBJECT LINE ADDRESS
002602  1270                 TAD LINPTR
002603  3014                 DCA AXCOMB      /SCAN LINE LOOKING FOR 7715 OR 1500 (CR)
002604  7001                 IAC             /CNT HOLDS
002605  3105                 DCA CNT         /TOTAL # LOCS IN THIS LINE
002606  6211                 CDF 10
002607  2105         COLECT, ISZ CNT
002610  1414                 TAD I AXCOMB    /GET A WORD
002611  1271                 TAD K63
002612  7450                 SNA             /IS IT 7715?
002613  5217                 JMP FINONE      /YES-END OF LINE
002614  1317                 TAD K6215       
002615  7640                 SZA CLA         /NO-IS IT 1500?
002616  5207                 JMP COLECT      /NO-TRY NEXT WORD
002617  1105         FINONE, TAD CNT         /YES MINUS CNT GIVES AMOUNT
002620  7041                 CIA             /TO REDUCE CERTAIN POINTERS
002621  3236                 DCA RELCNT
002622  6201                 CDF 0
002623  7001                 IAC             /GO THROUGH LIST OF POINTERS
002624  4460                 JMS I FIN1      /& OFFSET PNTRS WHICH WILL BE MOVED
002625  6211                 CDF 10          /MOVED ALONG WITH TEXT
002626  3104         GBG2,   DCA THISX       /SAVE POINTER
002627  1504                 TAD I THISX     /GET ADDRESS OF THIS LINE
002630  7450                 SNA             /DONE WITH STRING?
002631  5237                 JMP GBGEND      /YES
002632  4272                 JMS CGEPTR      /DECREASE POINTER IF NECESSARY
002633  3504                 DCA I THISX     /STORE NEW POINTER
002634  1135                 TAD THISX2
002635  5226                 JMP GBG2        /DO NEXT LINE

002636  0000         RELCNT, 0

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 47



002637  6201         GBGEND, CDF 0           /ALL POINTERS ARE REDUCED. NOW,
002640  7120                 CLL CML
002641  1120                 TAD BUFR        /PHYSICALLY MOVE CORE TO
002642  7041                 CIA             /CORRESPOND WITH POINTERS
002643  1014                 TAD AXCOMB      /AXCOMB POINTS TO FIRST LOC. TO GO
002644  7520                 SMA SNL         /POINTERS O.K.?
002645  4135                 ERROR           /NO
002646  3105                 DCA XCT         /YES-SET UP OTHER POINTERS
002647  6211                 CDF 10
002650  7040                 CMA
002651  1270                 TAD LINPTR
002652  3013                 DCA AXOUT
002653  1414                 TAD I AXCOMB    /MOVE TEXT
002654  3413                 DCA I AXOUT
002655  2105                 ISZ XCT         /ALL TEXT MOVED?
002656  5253                 JMP .-3         /NO-CONTINUE MOVING
002657  6201                 CDF 0           /YES
002660  1013                 TAD AXOUT
002661  3120                 DCA BUFR        /RESET TOP OF BUFFER
002662  1120                 TAD BUFR        /REDUCE AXIN FOR CHARACTER SEARCH
002663  3016                 DCA AXIN
002664  1113                 TAD THIS        /NOW DECREASE THIS IF NECESSARY
002665  4272                 JMS CGEPTR
002666  3113                 DCA THIS
002667  5600                 JMP I GARBAG    /--RETURN--

002670  0000         LINPTR, 0
002671  0063         K63,    63

002672  0000         CGEPTR, 0               /THIS ROUTINE DETERMINES IF THE
002673  3135                 DCA THISX2      /OF THE AC MUST BE DECREASED BY RELCNT.
002674  7100                 CLL             /IF THISX2 IS GREATER THAN LINPTR
002675  1135                 TAD THISX2      /DECREASE THISX2 BY RELCNT.
002676  7041                 CIA
002677  1270                 TAD LINPTR      /THIS EFFECTIVELY DECREASE ALL POINTERS
002700  7620                 SNL CLA         /WHICH HAVE TO BE RELOCATED
002701  1236                 TAD RELCNT
002702  1135                 TAD THISX2
002703  5672                 JMP I CGEPTR

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 48



             /LINE PRINTER OUTPUT ROUTINE
             /ENTER WITH CHARACTER IN AC
             /EXIT WITH AC CLEAR

             /HANDLER FOR V COMMAND

002704  1377         VIEW,   TAD (LPOCHR     /SET UP LISTER TO EXIT TO LPT
002705  3114                 DCA OUTDEV
002706  2111                 ISZ TABIND
002707  1040                 TAD C214        /PAGE EJECT HIM
002710  4514                 JMS I OUTDEV
002711  4462                 JMS I LIS       /LIST BUFFER
002712  1040                 TAD C214        /AND OUTPUT A FORM FEED
002713  4514                 JMS I OUTDEV
002714  5547                 JMP I TE1       /*RETURN TO COMMAND MODE*

             /HANDLER FOR ,

002715  1156         FIRS,   TAD ARG2
002716  5470                 JMP I ONUM

002717  6215         K6215,  6215



002720  4450         DELE,   JMS I DELT      /DELETE THE LINES
002721  5547                 JMP I TE1

002722  0000         OUTEM,  0               /OUTPUT NONBLANK CHARS FROM INCH
002723  4776'                JMS GINCH
002724  1375                 TAD (-240!200
002725  7650                 SNA CLA
002726  5331                 JMP .+3
002727  4776'                JMS GINCH
002730  4774'                JMS TOUT
002731  2164                 ISZ HDPTR
002732  2165                 ISZ KNT
002733  5323                 JMP OUTEM+1
002734  5722                 JMP I OUTEM     /RETURN

002774  4235
002775  7740
002776  4230
002777  7400
       3000                  PAGE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 49


                     /EDITOR I/O

       3200                  *3200
             / SCAN AN INPUT LINE ROUTINE
003200  0000         SCNLIN, 0               /R1-NULL LINE
003201  1377                 TAD (LBUFR      /R2-X:(CR) NOTATION
003202  3163                 DCA PTR         /R3-EXPLICIT NAME
003203  1563                 TAD I PTR       /R4-SYNTAX ERROR
003204  1376                 TAD (-215!200   /(CR)?
003205  7650                 SNA CLA
003206  5600                 JMP I SCNLIN    /R1  1ST CHAR (CR)
003207  2200                 ISZ SCNLIN
003210  1563                 TAD I PTR
003211  3272                 DCA UNIT        /1ST CHAR WILL ALWAYS BE UNIT
003212  2163                 ISZ PTR
003213  1563                 TAD I PTR
003214  1375                 TAD (-":!200    /COLON MUST FOLLOW UNIT
003215  7640                 SZA CLA
003216  5265                 JMP SYNERR
003217  2163                 ISZ PTR
003220  1563                 TAD I PTR
003221  1376                 TAD (-215!200   /IS THIS X:(CR) NOTATION?
003222  7650                 SNA CLA
003223  5600                 JMP I SCNLIN    /YES

             / INITIALIZE THE FILENAME AND EXTENSION TO BLANKS
003224  1374                 TAD (INCHAD     /
003225  3164                 DCA HDPTR       /
003226  1373                 TAD (-10        /
003227  3165                 DCA KNT         /
003230  2164                 ISZ HDPTR       /DONT HAVE TO BLANK CHAR 1
003231  1372                 TAD (240&177    /
003232  4771'                JMS PINCH       /
003233  2165                 ISZ KNT         /
003234  5230                 JMP .-4         /

003235  1374                 TAD (INCHAD
003236  3164                 DCA HDPTR
003237  4273                 JMS LET
003240  5265                 JMP SYNERR      /1ST CHAR HAS TO BE LETTER
003241  4771'                JMS PINCH
003242  2163                 ISZ PTR
003243  2164                 ISZ HDPTR
003244  1370                 TAD (-5
003245  3165                 DCA KNT
003246  4334                 JMS GETNAM      /KNT IS NUMBER TO GET
003247  1563                 TAD I PTR
003250  1367                 TAD (-".!200    /DID WE GET EXTENSION?
003251  7640                 SZA CLA
003252  5261                 JMP CRCK        /NO.. BETTER BE A (CR)
003253  2163                 ISZ PTR
003254  1366                 TAD (INCHEX
003255  3164                 DCA HDPTR
003256  7346                 CLA CLL CMA RTL /-3

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 49-1

003257  3165                 DCA KNT
003260  4334                 JMS GETNAM
003261  1563         CRCK,   TAD I PTR
003262  1376                 TAD (-215!200
003263  7650                 SNA CLA         /LINE MUST END WITH A (CR)
003264  5270                 JMP NORMRT      /IT DID
003265  2200         SYNERR, ISZ SCNLIN
003266  4317                 JMS WRTMSG
003267  3515                 ERR
003270  2200         NORMRT, ISZ SCNLIN
003271  5600                 JMP I SCNLIN


003272  0000         UNIT,   0

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 50


             / CHECK FOR A LETTER ROUTINE
003273  0000         LET,    0               /R1-NOT A LETTER
003274  1563                 TAD I PTR       /R2-THE LETTER IN 8 BIT
003275  1365                 TAD (-"Z!200-1
003276  7100                 CLL
003277  1364                 TAD (32
003300  7620                 SNL CLA
003301  5673                 JMP I LET
003302  1563                 TAD I PTR
003303  2273                 ISZ LET
003304  5673                 JMP I LET


             / CHECK FOR A DIGIT ROUTINE
003305  0000         DIG,    0               /R1-NOT A DIGIT
003306  1563                 TAD I PTR       /R2-IS A DIGIT 0-9
003307  1363                 TAD (-"0!200
003310  7100                 CLL
003311  1362                 TAD (-12
003312  7630                 SZL CLA
003313  5705                 JMP I DIG
003314  1563                 TAD I PTR
003315  2305                 ISZ DIG
003316  5705                 JMP I DIG


             / WRITE OUT THE GIVEN MESSAGE
003317  0000         WRTMSG, 0               /R-TYPES THE GIVEN MSG
003320  1717                 TAD I WRTMSG    /THE ADDRESS OF THE MSG
003321  3333                 DCA WPTR
003322  2317                 ISZ WRTMSG
003323  1733         TNXT,   TAD I WPTR
003324  0361                 AND (777
003325  4760'                JMS TOUT
003326  1733                 TAD I WPTR
003327  7710                 SPA CLA         /NEG CHAR INDICATES END
003330  5717                 JMP I WRTMSG
003331  2333                 ISZ WPTR
003332  5323                 JMP TNXT
003333  0000         WPTR,   0

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 51


             / GETS LETTERS OR DIGITS AND PUTS THEM IN THE INCH AT HDPTR
003334  0000         GETNAM, 0
003335  4273                 JMS LET
003336  7410                 SKP             /CHECK FOR A DIGIT
003337  5342                 JMP STCHAR
003340  4305                 JMS DIG
003341  5734                 JMP I GETNAM
003342  4771'        STCHAR, JMS PINCH
003343  2164                 ISZ HDPTR
003344  2163                 ISZ PTR
003345  2165                 ISZ KNT
003346  5335                 JMP GETNAM+1
003347  5734                 JMP I GETNAM
003360  4235
003361  0777
003362  7766
003363  7720
003364  0032
003365  7645
003366  7411
003367  7722
003370  7773
003371  4223
003372  0040
003373  7770
003374  7403
003375  7706
003376  7763
003377  3000
       3400                  PAGE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 52


             / GETS AN INPUT LINE FROM THE TTY
003400  0000         GETLIN, 0               /R-GETS A LINE OF TEXT ENDED
003401  1377                 TAD (LBUFR      /-WITH A (CR)
003402  3163                 DCA PTR
003403  4776'        GLINE,  JMS KIN
003404  3563                 DCA I PTR
003405  1563                 TAD I PTR
003406  1375                 TAD (-377!200   /A (RO)?
003407  7450                 SNA             /NO..
003410  5242                 JMP ROR
003411  1374                 TAD (377-215    /A (CR)?
003412  7450                 SNA             /NO..
003413  5600                 JMP I GETLIN    /YES.. RETURN
003414  1373                 TAD (215-225    /A (^U)?
003415  7650                 SNA CLA         /NO..
003416  5237                 JMP ZOTLIN
003417  1163                 TAD PTR
003420  7041                 CIA
003421  1377                 TAD (LBUFR
003422  7650                 SNA CLA
003423  5255                 JMP ZCOL
003424  1563         CHRIN,  TAD I PTR
003425  4772'                JMS TOUT
003426  2163                 ISZ PTR
003427  1163                 TAD PTR
003430  7041                 CIA
003431  1377                 TAD (LBUFR
003432  1371                 TAD (240&177
003433  7700                 SMA CLA
003434  5203                 JMP GLINE
003435  1315                 TAD ERR
003436  4772'                JMS TOUT
003437  4770'        ZOTLIN, JMS WRTMSG
003440  3516                 CRLFA
003441  5201                 JMP GETLIN+1


             / THE RUBOUT HANDLER
003442  7240         ROR,    CMA CLA
003443  1163                 TAD PTR
003444  3163                 DCA PTR
003445  1377                 TAD (LBUFR
003446  7041                 CIA
003447  1163                 TAD PTR
003450  7710                 SPA CLA
003451  5237                 JMP ZOTLIN
003452  1563                 TAD I PTR
003453  4772'                JMS TOUT
003454  5203                 JMP GLINE


             / THE 0: FUDGE
003455  4767'        ZCOL,   JMS DIG
003456  7410                 SKP

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 52-1

003457  5225                 JMP CHRIN+1
003460  1366                 TAD ("0&177
003461  3563                 DCA I PTR
003462  2163                 ISZ PTR
003463  1366                 TAD ("0&177
003464  4772'                JMS TOUT
003465  1365                 TAD (":&177
003466  3563                 DCA I PTR
003467  2163                 ISZ PTR
003470  1365                 TAD (":&177
003471  4772'                JMS TOUT
003472  1764                 TAD I (KBDIN
003473  3563                 DCA I PTR
003474  5224                 JMP CHRIN

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 53


             / THE MESSAGES
003475  0452         INMSG,  "*&177+400
003476  0511                 "I&177+400
003477  4116                 "N&177+4000
003500  0452         OUTMSG, "*&177+400
003501  0517                 "O&177+400
003502  0125                 "U&177
003503  0124                 "T&177
003504  0120         PUTMSG, "P&177
003505  0125                 "U&177
003506  0124                 "T&177
003507  0040                 240&177
003510  0106                 "F&177
003511  0111                 "I&177
003512  0114                 "L&177
003513  0105                 "E&177
003514  4055                 "-&177+4000
003515  0477         ERR,    "?&177+400
003516  0415         CRLFA,  215&177+400
003517  0412                 212&177+400
                     IFNZRO VT05 <0;0;0              /DELAY FOR VT05>
003520  4052                 "*&177+4000
003521  0415         CRLF,   215&177+400
003522  4412                 IFZERO VT05 <212&177+400+4000>
                     IFNZRO VT05 <
                     212&177+400
                     0;0;4000        /DELAY FOR VT05>
003523  0525         BADUNT, "U&177+400
003524  0116                 "N&177
003525  0111                 "I&177
003526  0124                 "T&177
003527  0040                 240&177
003530  0110                 "H&177
003531  0101                 "A&177
003532  0123                 "S&177
003533  0040                 240&177
003534  0117                 "O&177
003535  0120                 "P&177
003536  0105                 "E&177
003537  0116                 "N&177
003540  0105                 "E&177
003541  0104                 "D&177
003542  0040                 240&177
003543  0106                 "F&177
003544  0111                 "I&177
003545  0114                 "L&177
003546  4105                 "E&177+4000
003547  0415         TERMSG, 215&177+400
003550  0412                 212&177+400
003551  0412                 212&177+400
003552  0477                 "?&177+400
003553  0000                 0               /ERROR NUMBER
003554  0536         UPC,    "^&177+400
003555  4503                 "C&177+400+4000

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 53-1

003564  7602
003565  0072
003566  0060
003567  3305
003570  3317
003571  0040
003572  4235
003573  7770
003574  0162
003575  7601
003576  4240
003577  3000
       3600                  PAGE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 54


             / OPEN AN INPUT FILE AND POSITION IT
003600  0000         INFILE, 0               /R1-NO INPUT FILE
003601  4777'                JMS WRTMSG      /R2-FILE OPENED AND POSITIONED
003602  3521                 CRLF
003603  4777'                JMS WRTMSG
003604  3475                 INMSG
003605  4777'                JMS WRTMSG
003606  3504                 PUTMSG
003607  4776'        GFNAME, JMS GETLIN      /GET A LINE
003610  4775'                JMS SCNLIN      /PARSE IT
003611  5260                 JMP CL          /NULL FILE
003612  5774'                JMP SYNERR      /PERSON TRIED X:(CR)
003613  7410                 SKP             /GOOD FILE NAME
003614  5207                 JMP GFNAME      /SYNTAX ERROR
003615  4777'                JMS WRTMSG
003616  3521                 CRLF
003617  1773'                TAD OUNIT       /NEW INPUT UNIT CAN'T BE
003620  7041                 CIA             /
003621  1772'                TAD UNIT        /-ON OUTPUT FILES UNIT
003622  7650                 SNA CLA
003623  5253                 JMP BADIN
003624  4771'                JMS INTWT       /MAKE SURE ALL I-O DONE
003625  1772'                TAD UNIT
003626  6212                 CIF 10
003627  4770                 CALL (LOOKUP
003630  6211                 CDF 10
003631  7403                 INCHAD
003632  5767'                JMP RDERR
003633  5250                 JMP INERR       /ERROR RETURN
003634  2200                 ISZ INFILE
003635  1772'                TAD UNIT
003636  3171                 DCA INUNIT
003637  2766'                ISZ FILFLG      /SIGNAL EXISTANCE OF INPUT FILE
003640  2167                 ISZ INFLG       /" " " " "
003641  3765'                DCA INEOF       /TURN OFF END OF FILE FLAG
003642  1364                 TAD (6400
003643  3763'                DCA INBUFP
003644  4762'                JMS READ
003645  7240                 CLA CMA         /FORCE READ
003646  3341                 DCA INCHCT      /
003647  5600                 JMP I INFILE    /RETURN
003650  4777'        INERR,  JMS WRTMSG
003651  3515                 ERR
003652  5207                 JMP GFNAME
003653  4777'        BADIN,  JMS WRTMSG
003654  3523                 BADUNT
003655  4777'                JMS WRTMSG
003656  3516                 CRLFA
003657  5207                 JMP GFNAME
003660  4777'        CL,     JMS WRTMSG
003661  3521                 CRLF
003662  5600                 JMP I INFILE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 55


             / GET A CHARACTER ROUTINE
             / WILL REQUEST ANOTHER INPUT FILE IF /M OPTION IS USED
003663  0000         INCHAR, 0               /R1-NO MORE INPUT
                                     /R2-CHARACTER IN AC
003664  1167                 TAD INFLG       /OPEN INPUT FILE?
003665  7650                 SNA CLA 
003666  4135                 ERROR           /NO...
003667  2341                 ISZ INCHCT      /HAVE WE REACHED END OF BUFFER?
003670  5305                 JMP GETCHR
003671  1765'        GETBUF, TAD INEOF       /CHECK TO SEE IF FILE EMPTY
003672  7640                 SZA CLA
003673  5323                 JMP GETFIL      /IT WAS... START ANOTHER
003674  1763'                TAD INBUFP      /GET FILLED BUFFER ADDRESS
003675  3170                 DCA INPTR
003676  1763'                TAD INBUFP
003677  7041                 CIA
003700  1361                 TAD (FLIPI      /SWITCH TO OTHER BUFFER
003701  3763'                DCA INBUFP
003702  4762'                JMS READ
003703  1360                 TAD (-200
003704  3341                 DCA INCHCT
003705  1570         GETCHR, TAD I INPTR
003706  3103                 DCA CHAR
003707  1103                 TAD CHAR
003710  0357                 AND (177        /JUST IN CASE OF 8-BIT
003711  1356                 TAD (-232!200   /A (^Z)?
003712  7650                 SNA CLA
003713  5323                 JMP GETFIL      /EOF
003714  2170                 ISZ INPTR
003715  1103                 TAD CHAR
003716  0357                 AND (177
003717  7450                 SNA
003720  5264                 JMP INCHAR+1
003721  1355                 TAD (200
003722  5663                 JMP I INCHAR

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 56


003723  1754'        GETFIL, TAD MULTIN      /MULTIPLE INPUT FILES ALLOWED?
003724  7650                 SNA CLA
003725  7410                 SKP             /NO..
003726  4200                 JMS INFILE      /YES.. GET NEW INPUT FILE
003727  7610                 SKP CLA
003730  5271                 JMP GETBUF      /LOAD A BUFFER
003731  3167                 DCA INFLG       /DISABLE READS
003732  1557                 TAD I COMM5     /THE FOLLOWING CODE HANDLES
003733  7700                 SMA CLA         /THE CASE OF NO FINAL FORM
003734  4135                 ERROR           /IN THE INPUT BUFFER
003735  7201                 CLA IAC         /
003736  3150                 DCA THSN        /
003737  5740                 JMP I .+1       /FINISHING PROCESSING THE
003740  2440                 SFIND2          /-INPUT BUFFER

003741  0000         INCHCT, 0

003754  4251
003755  0200
003756  7746
003757  0177
003760  7600
003761  5200
003762  2335
003763  2350
003764  6400
003765  2353
003766  4252
003767  4327
003770  7002
003771  4243
003772  3272
003773  4105
003774  3265
003775  3200
003776  3400
003777  3317
       4000                  PAGE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 57


             / OPEN AN OUTPUT FILE AND POSITION IT
004000  0000         OUTFIL, 0               /R1-NO OUTPUT FILE
004001  4777'                JMS WRTMSG      /R2-FILE OPENED AND POSITIONED
004002  3500                 OUTMSG
004003  4776'        GOFNM,  JMS GETLIN
             /ZERO THE VERSION NUMBER
004004  6211                 CDF 10
004005  3775                 DCA I (INCHAD+24
004006  6201                 CDF 0
004007  4774'                JMS SCNLIN
004010  5600                 JMP I OUTFIL    /NULL OUTPUT FILE
004011  4247                 JMS TACKIT      /X:(CR) NOTATION USED
004012  7410                 SKP             /EXPLICIT FILE NAME GIVEN
004013  5203                 JMP GOFNM       /SYNTAX ERROR
004014  4777'                JMS WRTMSG
004015  3521                 CRLF
004016  1773'                TAD UNIT
004017  7041                 CIA
004020  1171                 TAD INUNIT
004021  7650                 SNA CLA
004022  5300                 JMP BADOU
004023  4772'                JMS INTWT       /MAKE SURE ALL I-O DONE
004024  6212                 CIF 10
004025  1773'                TAD UNIT
004026  4771                 CALL (ENTER     /OPEN THE OUTPUT FILE
004027  5306                 JMP OUERR
004030  1370                 TAD (FLCLS1     /MAKE ^C CLOSE FILE
004031  3767'                DCA CTRLCJ      /MONITOR ^C BRANCH LOCATION
004032  2200                 ISZ OUTFIL
004033  2173                 ISZ OUTINH      /SIGNAL OPEN OUTPUT FILE
004034  2305                 ISZ OUNIT       /FIRST TIME?
004035  5244                 JMP PANICO      /NO.. MUST BE PANIC MODE
004036  1366                 TAD (-200       /WORD COUNT
004037  3172                 DCA OUWDCT      /
004040  1365                 TAD (7000       /OUTPUT BUFFER
004041  3346                 DCA OUPTR       /
004042  1365                 TAD (7000
004043  3333                 DCA OUBPTR
004044  1773'        PANICO, TAD UNIT
004045  3305                 DCA OUNIT
004046  5600                 JMP I OUTFIL    /RETURN
004047  0000         TACKIT, 0               /R-TYPES OUT THE DEFAULT FILENAME
004050  1764'                TAD FILFLG      /-WILL GIVE SYNTAX ERROR IF NOT
004051  7750                 SPA SNA CLA     /-IN RESPONSE TO INITIAL OUTPUT
004052  5763'                JMP SYNERR      /-FILE WITH GIVEN INPUT FILE
004053  7330                 CLA CLL CML RAR /4000
004054  3764'                DCA FILFLG

             / THE FOLLOWING GETS THE NAME FROM THE INCH AND PRINTS IT
004055  1362                 TAD (INCHAD     /
004056  3164                 DCA HDPTR       /
004057  4761'                JMS GINCH       /
004060  4760'                JMS TOUT        /
004061  1357                 TAD (-5         /

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 57-1

004062  3165                 DCA KNT         /
004063  2164                 ISZ HDPTR       /
004064  4756'                JMS OUTEM       /
004065  1355                 TAD (".&177     /
004066  4760'                JMS TOUT        /
004067  7346                 CLA CLL CMA RTL /-3
004070  3165                 DCA KNT         /
004071  4756'                JMS OUTEM       /
             /BUMP THE INPUTS VERSION NUMBER FOR OUTPUT
004072  6211                 CDF 10
004073  1754                 TAD I (INVNUM
004074  7001                 IAC
004075  3775                 DCA I (INCHAD+24
004076  6201                 CDF 0
004077  5647                 JMP I TACKIT    /

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 58


004100  4777'        BADOU,  JMS WRTMSG
004101  3523                 BADUNT
004102  4777'                JMS WRTMSG
004103  3516                 CRLFA
004104  5203                 JMP GOFNM

004105  7777         OUNIT,  -1

004106  4777'        OUERR,  JMS WRTMSG
004107  3515                 ERR
004110  5203                 JMP GOFNM
             / OUTPUT A CHARACTER ROUTINE
004111  0000         OCHAR,  0               /R-CHARACTER OUTPUT
004112  3746                 DCA I OUPTR     
004113  1173                 TAD OUTINH      /IS OUTPUT INHIBITED?
004114  7650                 SNA CLA         
004115  4135                 ERROR           /YES..
004116  2346                 ISZ OUPTR
004117  2172                 ISZ OUWDCT
004120  5711                 JMP I OCHAR
004121  4323                 JMS OUWRT
004122  5711                 JMP I OCHAR

             / WRITE A BUFFER ROUTINE
004123  0000         OUWRT,  0               /R-BUFFER WRITTEN
004124  4772'                JMS INTWT       /WAIT FOR PREVIOUS OPERATION
004125  1353                 TAD (EOTHND     /ERROR RETURN
004126  3752'                DCA ERET
004127  1305                 TAD OUNIT       
004130  6212                 CIF 10
004131  4751                 CALL (HANDLER   /WRITE THE BUFFER
004132  4000                 4000            /A WRITE FROM FIELD 0
004133  7000         OUBPTR, 7000            /ADDRESS OF BUFFER
004134  5750'                JMP WRTERR      /WRITE ERROR.
004135  1366                 TAD (-200
004136  3172                 DCA OUWDCT
004137  1333                 TAD OUBPTR
004140  7041                 CIA
004141  1347                 TAD (FLIPO      /SWITCH TO OTHER OUTPUT BUFFER
004142  3346                 DCA OUPTR
004143  1346                 TAD OUPTR
004144  3333                 DCA OUBPTR
004145  5723                 JMP I OUWRT     /RETURN

004146  0000         OUPTR,  0

004147  6200
004150  4326
004151  6600
004152  4250
004153  4255
004154  7624
004155  0056
004156  2722

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 58-1

004157  7773
004160  4235
004161  4230
004162  7403
004163  3265
004164  4252
004165  7000
004166  7600
004167  7604
004170  2012
004171  6404
004172  4243
004173  3272
004174  3200
004175  7427
004176  3400
004177  3317
       4200                  PAGE

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 59


004200  7300         IOSET,  CLA CLL
004201  6211                 CDF 10
004202  1777                 TAD I (OPT2
004203  7710                 SPA CLA
004204  2251                 ISZ MULTIN
004205  1776                 TAD I (OPT1
004206  6201                 CDF 0
004207  7006                 RTL
004210  7620                 SNL CLA
004211  5214                 JMP NOCONV
004212  1254                 TAD SZCL        /SET UP TO CONVERT SPACES TO TABS
004213  3653                 DCA I SPCP1
004214  4775'        NOCONV, JMS INFILE
004215  7000                 NOP
004216  4774'                JMS OUTFILE
004217  2126                 ISZ EKILLL      /DISALLOW E COMMAND
004220  1373                 TAD (START
004221  3166                 DCA EDSTRT
004222  5773'                JMP START

004223  0000         PINCH,  0               /STORE CHAR IN INCH
004224  6211                 CDF 10
004225  3564                 DCA I HDPTR
004226  6201                 CDF 0
004227  5623                 JMP I PINCH

004230  0000         GINCH,  0               /GET A CHAR FROM THE INCH
004231  6211                 CDF 10
004232  1564                 TAD I HDPTR
004233  6201                 CDF 0
004234  5630                 JMP I GINCH

004235  0000         TOUT,   0               /OUTPUT A CHAR TO THE TTY
004236  4772                 JMS I (TTOCHR
004237  5635                 JMP I TOUT

004240  0000         KIN,    0               /GET A CHAR FROM THE TTY
004241  4771                 JMS I (KBDCHR
004242  5640                 JMP I KIN

004243  0000         INTWT,  0               /I/O WAIT ROUTINE
004244  6212                 CIF 10
004245  4770                 CALL (WAIT
004246  5650                 JMP I ERET      /ERROR ON PREVIOUS OPERATION
004247  5643                 JMP I INTWT     /NO ERROR.. CONTINUE

004250  4246         ERET,   .-2             /LOOP IF FIRST OPERATION

004251  0000         MULTIN, 0
004252  0000         FILFLG, 0
004253  1515         SPCP1,  SPACES+1
004254  7640         SZCL,   SZA CLA         

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 60



             /THE END OF TAPE HANDLER
004255  0367         EOTHND, AND (40
004256  7650                 SNA CLA
004257  5326                 JMP WRTERR      /REAL ERROR - NOT EOT
004260  4316                 JMS BBG
004261  4316                 JMS BBG
004262  6212                 CIF 10          /-ARE CONSIDERED FATAL........
004263  4766                 CALL (HANDLER   /READ BACK LAST GOOD RECORD
004264  0000                 0
004265  6200                 6200            /PANIC INPUT AREA
004266  5326                 JMP WRTERR
004267  4316                 JMS BBG
004270  6212                 CIF 10
004271  4765                 CALL (CLOSE     /CLOSE THE FILE
004272  5326                 JMP WRTERR
004273  4774'        TRYAGN, JMS OUTFIL      /ALL WILL BE O.K. IF USER GIVES
004274  5273                 JMP .-1         /-GOOD OUTPUT FILE TO FINISH WITH
004275  6212                 CIF 10
004276  4766                 CALL (HANDLER
004277  4000                 4000
004300  6200                 6200
004301  5273                 JMP TRYAGN      /WRITE OUT THE LAST GOOD RECORD
004302  1764'                TAD OUBPTR
004303  7041                 CIA
004304  1370                 TAD (FLIPO      /REWRITE BUFFER WE FAILED ON
004305  3311                 DCA OSPOT
004306  6212                 CIF 10
004307  4766                 CALL (HANDLER
004310  4000                 4000
004311  0000         OSPOT,  0
004312  5273                 JMP TRYAGN      /DIDN'T WORK - GIVE USER ANOTHER CRACK
004313  1363                 TAD (TRYAGN     /WITHOUT CLOSING THIS FILE
004314  3250                 DCA ERET
004315  5244                 JMP INTWT+1     /CONTINUE OPERATION WHICH
                                     /IN PROGRESS

004316  0000         BBG,    0
004317  1762'                TAD OUNIT
004320  6212                 CIF 10
004321  4761                 CALL (UTIL
004322  0050                 50
004323  5326                 JMP WRTERR
004324  5716                 JMP I BBG

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 61



004325  7201         CLERR,  CLA IAC
004326  7001         WRTERR, IAC
004327  1360         RDERR,  TAD (460        /MUST PRINT CODE
004330  3757'                DCA TERMSG+4    /ERROR NUMBER
004331  4756'                JMS WRTMSG
004332  3547                 TERMSG
004333  5755'                JMP ETOMON      /GO TO THE MONITOR THROUGH EXITOR

004334  0354         INERRX, AND (20         /EOF?
004335  7650                 SNA CLA
004336  5327                 JMP RDERR       /NO.. HARD ERROR
004337  2753'                ISZ INEOF       /SIGNAL END OF FILE TO ALL FUTURE READS
004340  5643                 JMP I INTWT     /CONTINUE OPERATION

004353  2353
004354  0020
004355  2032
004356  3317
004357  3553
004360  0460
004361  7200
004362  4105
004363  4273
004364  4133
004365  6400
004366  6600
004367  0040
004370  6200
004371  7626
004372  7402
004373  0201
004374  4000
004375  3600
004376  7400
004377  7401
       0001                  FIELD 1         /TO INITIALIZE TEXT BUFFER POINTER
       0020                  *20             /WHICH IS AT ABSOLUTE LOCATION 20
010020  0000                 0               /IN FIELD 1.


       0000                  FIELD   0
       0200                  *200            /SELF STARTING ADDRESS
                     $

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 62

ADD    0153      COMB   1265      ERR    3515      INBUFP 2350
ADDR   1121      COMBAK 2452      ERROR  4135      INCHAD 7403
AMODE  2251      COMBO  1254      ERSW   0124      INCHAR 3663
AONE   0444      COMBOA 1256      ER1    2535      INCHCT 3741
AONEI  1630      COMBOP 1626      ESCA   0475      INCHEX 7411
APP    1217      COMM5  0157      ETOMON 2032      INCORE 2046
APPL   1204      COM1   1274      EXLAS  0672      INEOF  2353
APP1   0422      COM5   1302      EXNEX  0673      INERR  3650
ARG0   0154      CON    1057      EXTR   0526      INERRX 4334
ARG1   0155      CORSPC 2312      FILFLG 4252      INFILE 3600
ARG2   0156      COUNT  0353      FIND   1032      INFLG  0167
ATSIGN 2561      COUNTP 0104      FIND1  1052      INLIST 0600
AXCOMB 0014      CRCK   3261      FIND2  1046      INMSG  3475
AXIN   0016      CRLF   3521      FINONE 2617      INPTR  0170
AXOUT  0013      CRLFA  3516      FIN1   0060      INS    0430
AXTEM  0015      CTAB   0030      FIRS   2715      INTWT  4243
BADIN  3653      CTRLCJ 7604      FLCLI  2045      INUNIT 0171
BADOU  4100      CTRLU  1631      FLCLOS 2003      INVNUM 7624
BADUNT 3523      CTRLU1 1633      FLCLSI 1627      IOSET  4200
BARROW 2303      CZ     0067      FLCLS1 2012      I33    1212
BBG    4316      CZONE  0141      FLIPI  5200      JERK   2257
BELL   0041      C100   0011      FLIPO  6200      JERK1  2260
BOX    0104      C200   0025      FLOOZ  1071      JMPCH  0134
BUFCNT 2566      C212   0042      FMATCH 2565      JMPTE1 0143
BUFEND 0127      C214   0040      FORGET 2573      KBDCHR 7626
BUFR   0120      C215   0031      FULL   0607      KBDIN  7602
BUFRD  3663      C240   0026      GARBAG 2600      KEYBD  0054
BUFRDI 0130      C260   1120      GBGEND 2637      KILL   2322
BUFWT  4111      C325   1641      GBG2   2626      KILL1  0122
BUFWTI 0131      C336   2246      GETBUF 3671      KIN    4240
CALL   4400      C677   0012      GETCHR 3705      KNT    0165
CCON   0055      C77    0010      GETFIL 3723      K400   2321
CCR    0031      DBCV2  0227      GETLIN 3400      K50    1122
CFRS   0121      DBLQUO 2307      GETNAM 3334      K6215  2717
CGEPTR 2672      DELE   2720      GETTAG 1333      K63    2671
CHAR   0103      DELP   0640      GET3   0541      K7430  1123
CHFND  2570      DELP1  0651      GET4   0544      LBUFR  3000
CHIN   1020      DELT   0050      GET5   0553      LET    3273
CHI1   0051      DEST   1230      GEXP   0224      LINPTR 2670
CHKARG 0123      DIG    3305      GFNAME 3607      LIS    0062
CHKARX 1642      DTEM   0135      GINCH  4230      LIST   0702
CHRIN  3424      DUMB1  1305      GLINE  3403      LISTER 0707
CL     3660      ECHOSW 0107      GLOM   0236      LISTGO 1444
CLERR  4325      EDSTRT 0166      GMIN   0225      LIST1  1306
CLF    0042      EKILLL 0126      GMOR   2265      LIST1A 1330
CLFLI  0132      ELIM   0136      GOFNM  4003      LIST2  0277
CLOSE  6400      END    0053      GOOD   2542      LIST3  0044
CMPT   0336      ENDA   2177      GRBAGE 0115      LIST4  0030
CNGE   1223      ENDFIL 1614      GTAG2  1341      LIST5  0036
CNGEL  1206      ENDLN  1663      GTEM   0135      LIST6  0037
CNGE1  0425      ENDLNI 0077      GTOP   0222      LIST7  0026
CNT    0105      ENTER  6404      G2     0240      LIS1   0061
CNTR   2564      EOL    0407      HANDLE 6600      LOOKUP 7002
CNTRI  2306      EOTHND 4255      HDPTR  0164      LOW    0066
COLECT 2607      ERET   4250      IGNORE 0052      LPOCHR 7400

/CAPS SYMBOLIC EDITOR           VERSION   PAL8-V13B NO DATE   PAGE 62-1

LSTCHK 0162      OUTCRL 1140      SFIND1 2400      UPC    3554
LSTN   0151      OUTDEV 0114      SFIND2 2440      UPK    2514
L0     0722      OUTEM  2722      SFOUND 1012      UPK1   2467
L1     0726      OUTFIL 4000      SGOT   1016      UTEST  0455
L1I    0125      OUTINH 0173      SIGN   0324      UTIL   7200
L1720  0637      OUTL   1207      SLAS   1655      UTRA   0523
L2     0750      OUTLIS 1231      SLINE  0777      UTR1   0057
L2I    0076      OUTL1  0066      SLOOK  0772      VAL    0154
L3     0752      OUTMSG 3500      SLST   2224      VIEW   2704
L3I    0075      OUTRT  1145      SORTB  0325      VT05   0000
MARK   0116      OUTTAB 1150      SORTJ  0071      WAIT   6200
MCHIN1 0046      OUTX   1136      SPACES 1514      WPTR   3333
MCR    0022      OUT1   0065      SPCGO  0101      WREK   2525
MOR    0447      OUWDCT 0172      SPCNO  0100      WRTERR 4326
MORI   0617      OUWRT  4123      SPCP1  4253      WRTMSG 3317
MOVE   1536      PACBUF 0455      SPLAT  0102      XCRET  1165
MOVEM  1400      PACK1  0072      SP2    1520      XCT    0105
MOV1   0104      PANICO 4044      SRCBUF 2200      XCTIN  0106
MOV2   0160      PCK1   0501      SRETN  0761      XNS    1221
MP1    0155      PERI   1653      SRNLST 1437      XNSL   1205
MP2    0154      PINCH  4223      START  0201      XNS1   0426
MP3    0156      PRNT   1063      STCHAR 3342      XSAV   0117
MSCNT  2572      PSETUP 0133      STFIN  2531      XYZ    1103
MTABS  0047      PTR    0163      STORE  2425      X203   0161
MULTIN 4251      PUNC   1241      STRFIN 0146      YANK   1251
M240   0023      PUNCH  1236      STRIND 0145      ZCOL   3455
M27    0035      PUTMSG 3504      SXS1   0073      ZOTLIN 3437
M4     0020      P177   0021      SXS2   0074      
M77    0007      P232   0572      SYNERR 3265      
NEXBUF 2231      P37    0571      SZCL   4254      
NEXTPT 2567      P40    0024      TABIND 0111      
NEXX   2553      P7700  1513      TACKIT 4047      
NINE   0063      Q      2000      TAGLIS 1200      
NOCONV 4214      QUO1   2431      TBUF   1600      
NOCR   2503      QUO2   2430      TCNT   0152      
NONE   0323      RDERR  4327      TELE   1245      
NORMRT 3270      READ   2335      TELEN  1245      
NOTSO  2526      RELCNT 2636      TEMP   0112      
NUCHA  2544      RETRN  0255      TEMPO  0160      
NUCHAR 2550      RLEAS  2247      TERMSG 3547      
NUMB   0064      RLOOP  2414      TE1    0147      
OCHAR  4111      ROR    3442      THIS   0113      
ONUM   0070      ROT    0514      THISX  0104      
OPS1   1550      RUB1   1446      THISX2 0135      
OPS1A  1575      RUB2   1505      THSN   0150      
OPS2   0363      RUB3   1473      TMP1   2562      
OPT1   7400      RUB4   1502      TMP2   2563      
OPT2   7401      SAVE   0110      TNXT   3323      
OSLST  2232      SBAR   1005      TOUT   4235      
OSPOT  4311      SBUF   2571      TRYAGN 4273      
OUBPTR 4133      SCNLIN 3200      TR1    0471      
OUERR  4106      SCONT  0767      TTOCHR 7402      
OUNIT  4105      SET    1224      UNIT   3272      
OUPTR  4146      SETUP  0620      UPAROI 0144      
OUT    1124      SEX    0350      UPAROW 2237      



ERRORS DETECTED: 0
LINKS GENERATED: 91

