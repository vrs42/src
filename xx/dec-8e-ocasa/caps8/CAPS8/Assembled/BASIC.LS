
/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 1

             /PDP-8/E CASSETTE BASIC
             /
             /               DEC-8E-OBASA-A
             /
             /               COPYRIGHT        1973
             /               DIGITAL EQUIPMENT CORPORATION
             /               MAYNARD, MASS. (01754)
             /
             /               BILL CLOGHER

             /               THIS IS A MODIFIED VERSION OF
             /               8K BASIC WHICH IN TURN WAS A MODIFIED
             /               VERSION OF EDUSYSTEM 10 BASIC
       0000          FIELD   0
             /
             /PROGRAM IS VERY SENSITIVE TO PAGE BOUNDARIES--FOREWARNED
             /IS FOREARMED!!!!
             /


/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 2



       6000  BUFST=6000
       6200  BUFEND=BUFST+200

             /00000  +----------+
             /       !  BASIC   !
             /07400  +----------+
             /       !  MONITOR !
             /       ! ROUTINES !
             /10000  +----------+
             /       !  BASIC   !
             /11200  +----------+
             /       ! OPTIONAL !
             /       ! FILE I/O !
             /       ! ELSE     !
             /       ! ARRAY    !
             /       ! SPACE    !
             /11600  +----------!
             /       !  ARRAY   !
             /       !  SPACE   !
             /       !    !     !
             /       !   \!/    !
             /       !    '     !
             /       +----------+
             /       !  FREE    !
             /       +----------+
             /       !    .     !
             /       !   /!\    !
             /       !    !     !
             /       ! CODIFIED !
             /       !  BASIC   !
             /       +----------+
             /       !  SYMBOL  !
             /       !  TABLE   !
             /       +----------+
             /       !  LINEBUF !
             /       +----------+
             /       !  STACK   !
             /       +----------+
             /       !  FORLIST !
             /       +----------+
             /       !  GOLIST  !
             /16000  +----------+
             /       ! CASSETTE !
             /       !  BUFFER  !
             /16200  +----------+
             /       ! CASSETTE !
             /       !  MONITOR !
             /17777  +----------+

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 3



             /FOR CASSETTE HANDLER
       7402  TLSOUT=7402     /TTY OUTPUT ROUTINE
       7400  LLSOUT=7400     /LPT OUTPUT ROUTINE
       7626  KBDINP=7626     /KEYBOARD INPUT ROUTINE
       6200  WAIT=6200
       6600  HNDLR=6600
       6404  ENTER=6404
       7403  INCHN=7403      /REALLY THE SINCH
       7002  LOOKUP=7002
       6400  CLOSE=6400
       7604  CTRLCJ=7604

       7407  CNTLO=7407
       7603  MBREAK=7603
             /
             /8/E INSTRUCTIONS
             /
       7002  BSW=7002
       7421  MQL=7421
       7501  MQA=7501
       7621  CAM=7621
       7521  SWP=7521


/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 4



             /
             /CODES FOR LANGUAGE ELEMENTS
             /
             /4200   +
             /4201   -
             /4302   *
             /4303   /
             /4404   ^
             /4105   =
             /4106   <
             /4107   >
             /4110   <=
             /4110   =<
             /4111   >=
             /4111   =>
             /4112   <>
             /4113   (UMINUS)
             /4014   (DONE)
             /4015   ,
             /4016   ;
             /4017   )
             /4021   TO
             /4022   STEP
             /4023   (
             /4024   FN
             /4025   COS
             /4026   TAN
             /4027   ATN
             /4030   LOG
             /4031   EXP
             /4032   SQR
             /4033   ABS
             /4034   SGN
             /4035   INT
             /4036   RND
             /4037   SIN
             /4040   PUT
             /4041   GET
             /4042   TAB
             /4043   UUF
             /4044   LIST
             /4044   LIS
             /4045   RUN
             /4046   SCR(ATCH)
             /4047   SAVE
             /4047   SAV
             /4050   OLD
             /4051   NEW
             /4052   NAME
             /4052   NAM

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 5



             /6000   (CRLF)
             /6000   \
             /6001   PRINT#
             /6002   PRINT
             /6003   LET
             /6004   GOTO
             /6004   THEN
             /6005   IF
             /6006   FOR
             /6007   NEXT
             /6010   GOSUB
             /6011   INPUT
             /6012   RETURN
             /6013   STOP
             /6014   DIM
             /6015   RESTORE
             /6016   REM
             /6017   DEF
             /6020   READ
             /6021   DATA
             /6022   (EXIT)
             /6023   (EOF)
             /6024   END
             /6025   TTY OUT
             /6026   LPT
             /6027   END#
             /6030   INPUT#
             /6031   NO COMMAS
             /6032   COMMAS
             /6033   OPEN
             /6034   CLOSE
             /6035   OUTPUT
             /6036   CHAIN
             /6037   RUBOUTS
             /6040   NO RUBOUTS



       0000  FEXIT=0000
       0040  FSNE=0040
       0050  FSEQ=0050
       0100  FSGE=0100
       0110  FSLT=0110
       0140  FSGT=0140
       0150  FSLE=0150
       1000  FJMP=1000
       1400  FJMPI=1400
       2000  FST=2000
       2400  FSTI=2400
       3000  FLD=3000
       3400  FLDI=3400
       4000  FAD=4000
       4400  FADI=4400

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 5-1

       5000  FSB=5000
       5400  FSBI=5400
       6000  FMP=6000
       6400  FMPI=6400
       7000  FDV=7000
       7400  FDVI=7400
       0200  FWD=200
       0600  BKWD=600

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 6


       0003  *3
00003  0000  ARRLOC, 0
00004  0000  CODELOC,0

             /COME HERE IF CTRL/C TYPED
00005  6213  CTRLC,  CDF CIF 10      /CLOSE OUTPUT FILE IF ONE OPEN
00006  4543          JMS I   PCLOS
00007  5472          JMP I   KM200   /TO 7600 AND MONITOR
       0010  *10
00010  0000  XRLOC,  0
00011  0000  XRPUT,  0       /XREGS USED IN MOVING LINES AROUND
00012  0260  O260,   260
00013  0000  OV,     0
00014  0000  INDEX1, 0
00015  0000  INDEX2, 0
00016  0000  AC3,    0
00017  0000  AC2,    0
00020  0000  AC1,    0
00021  0000  OP3,    0
00022  0000  OP2,    0
00023  0000  OP1,    0
00024  0000  ACS,    0
00025  0000  ACE,    0
00026  0000  OPS,    0
00027  0177  O177,   177     
00030  0000  OPE,    0
00031  0000  TMP,    0
00032  7200  PGETCH, GETCH
00033  0741  PPUTCH, PUTCH
00034  0000  DIMFLAG,0
       4435  FENTER=JMS I .;FPT
00035  4200
00036  0000  PDL,    0
00037  5551  PLINBUF,LINBUF
00040  2227  MLINBUF,-LINBUF
00041  2076  MENDLIN,-ENDLIN
00042  0000  PRTEMP, 0
00043  0000  DECEXP, 0
00044  5335  PNUMBUF,NUMBUF
00045  0000  LOCCTR, 0
00046  0000  READLOC,0
00047  7247  PARGERR,ARGERR
00050  0000  WORD,   0
00051  0240  O240,   240
00052  0000  PSYMTAB,0
00053  0000  NSYMTAB,0
00054  0000  LINENO, 0
00055  0000  GOTEMP, 0
00056  7740  O7740,  7740
00057  7770  O7770,  7770

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 7



00060  0000  EPTR,   0
00061  0000  FPTR,   0
00062  0000  GPTR,   0
00063  0000  HPTR,   0
00064  0002  O2,     2

00065  0000  FORCT,  0
00066  0000  SNUMFLG,0
00067  0012  O12,    12
00070  0000  OLDOP,  0
00071  0000  ADDRESS,0
00072  7600  KM200,-200
00073  0377  O377,   377
00074  0007  O7,     7
00075  0000  OPERAND,0;0;0
00076  0000
00077  0000
00100  5540  PTEXT,  XXTEXT
00101  4136  PERROR, ERROR
00102  6441  PSXERR, SXERR
00103  1000  PEVAL,  EVAL
00104  1400  PGETADD,GETADDR
00105  0213  PEXECUT,EXECUTE
00106  2362  PPUSH,  PUSH
00107  4166  PPOP,   POP
00110  4744  PFIX,   FIX
00111  1202  PGOTOPR,GOTOPR
00112  0474  PPASSCR,PASSCR
00113  4174  CTRZCK, CKCTRZ  /PATCH FOR ^Z IN RUNTIME INPUT FILES
00114  0333  PSTOVAR,STOVAR
00115  0303  PGETVAR,GETVAR
00116  3702  PPRINTX,PRINTXT
00117  1700  PGETBLK,GETBLK
00120  2675  PSLOOP, SLOOP
00121  5000  POUTNUM,OUTNUM
00122  2412  PEDIT,  EDIT
00123  6430  PSTICKI,STICKIT
00124  3104  PNONBLN,NONBLNK
00125  3745  PPRINUM,PRINUM
00126  2602  PGETLIN,GETLIN
00127  5703  PPDLIST,PDLIST
00130  0000  COLUMN, 0
00131  0000  INDEV,  0
00132  0000  OUTD2,  0
00133  0000  OUTDEV, 0
00134  7147  CNTLOZ, ZCNTLO
00135  0000  RBSWCH, 0       /1-RUBOUTS OK,0-NO RUBOUTS
00136  7072  PRESET, RESET1

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 8



00137  7143  PCOWT,  COWT
       0140          *140    /SEE LOC O140B
00140  0077  O77,    77      /DON'T MOVE
00141  0344  CNCLR,  CKBRAK  /SEE IF HE HIT 'BREAK' TO STOP A RUN
00142  6413  SPLEFT, RMLEFT
00143  0036  PCLOS,  CLOS    /CLOSE ROUTINE IS IN FIELD 1
00144  4600  PANORM, ANORM
00145  4402  PAR1,   AR1
00146  4654  PAL1,   AL1
00147  2014  ONE,    2014
00150  0000  ZERO,   0;0;0
00151  0000
00152  0000
       0150  PTEN=ZERO       /CONSTANT TEN IS AT LOC. 0 IN FIELD 1!!!
00153  0200  O200,   200
00154  0000  FPFLAG, 0
00155  4435  POADD,  OADD
00156  0004  O4,     4
00157  2326  PLINFIX,LINFIX
00160  7745  O7745,  7745
00161  6400  PCHKFIT,CHKFIT
00162  5764  PGOLIST,GOLIST
00163  0000  GSBPTR, 0
       0001  GET=1
       4564  ISIT=JMS I .;XISIT;XGISIT
00164  7124
00165  7115
       4566  MUSTBE=JMS I .;XMUST;XGMUST
00166  7277
00167  7270
00170  5622  PLBEGIN,LBEGIN
00171  2155  MLBEGIN,-LBEGIN-1
00172  2035  MLEND,  -ENDPDL
00173  4100  PISITLI,ISITLIT
00174  0215  O215,   215
00175  0212  O212,   212
00176  7776  CMSWCH, -2              /=-2 IF COMMAS ON RT/OUTPUT;=0 IF NO COMMAS
       0200          PAGE

       0177          *.-1


00177  0000  GETWD,  0
00200  1445          TAD I   LOCCTR
00201  3050          DCA     WORD
00202  2045          ISZ     LOCCTR
00203  5577          JMP I   GETWD
00204  0205  PLETDO, LETDO
00205  4566  LETDO,  MUSTBE          /'='
00206  3673          3673
00207  4503          JMS I   PEVAL
00210  4566          MUSTBE          /(CR) OR '\'
00211  2000          2000

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 8-1

00212  4333          JMS     STOVAR
00213  4177  EXECUTE,JMS     GETWD
00214  1204          TAD     PLETDO
00215  3303          DCA     GETVAR
00216  1450          TAD I   WORD
00217  7510          SPA
00220  5231          JMP     KEYWD
00221  7640          SZA CLA         /IS IT A LINENO
00222  5305          JMP     NOTKWD  /NO
00223  1050          TAD     WORD
00224  3054          DCA     LINENO
00225  4177          JMS     GETWD
00226  1450          TAD I   WORD
00227  7700          SMA CLA
00230  5305          JMP     NOTKWD
00231  7332  KEYWD,  CLA CLL CML RTR
00232  1450          TAD I   WORD
00233  7420          SNL             /IS IT A STATEMENT WORD
00234  5502          JMP I   PSXERR  /NO
00235  1241          TAD     SJUMP
00236  3240          DCA     .+2
00237  4344          JMS     CKBRAK  /SEE IF HE TYPED 'BREAK'
00240  0000          0
00241  5642  SJUMP,  JMP I   .+1
00242  0213          EXECUTE
00243  7322  PRN,    PRINTN  /PRINT# STATEMENT
00244  2172          PRINT
00245  0304          LET
00246  0521          GOTO
00247  0372          IF
00250  0415          FOR
00251  0600          NEXT

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 9


00252  0507          GOSUB
00253  4007          INPUT
00254  0677          RETURN
00255  2401          STOP
00256  6472          DIM
00257  3771          RESTORE
00260  0471          SKIPIT
00261  1575          DEF
00262  1622          READ
00263  0471          SKIPIT
00264  2407          EXIT
00265  2412          EDIT
00266  2400          END
00267  7350          TTYOUT
00270  7347          LPTOUT
00271  6441  PENDN,  SXERR   /END# STMT. VALID ONLY AFTER IF STMT.
00272  7316  INPTN,  INPUTN
00273  6176  PCOMMA, NOCOM
00274  6175          COMMAS
00275  3575          OPEN
00276  1170          CLOSEO
00277  6441          SXERR   /OUTPUT
00300  7031          CHAIN
00301  5573          RUBO
00302  5574          NORUBO



00303  0000  GETVAR, 0
00304  4177  LET,    JMS     GETWD
00305  4566  NOTKWD, MUSTBE          /A VARIABLE
00306  7000          7000
00307  1050          TAD     WORD
00310  3335          DCA     VAR
00311  3336          DCA     SSONE
00312  3337          DCA     SSTWO
00313  4565          GET+ISIT                /'('
00314  3755          3755
00315  5703          JMP I   GETVAR  /NO
00316  4503          JMS I   PEVAL
00317  4510          JMS I   PFIX
00320  3336          DCA     SSONE
00321  4564          ISIT            /','
00322  3763          3763
00323  5327          JMP     NOCOMMA /NO
00324  4503          JMS I   PEVAL
00325  4510          JMS I   PFIX
00326  3337          DCA     SSTWO
00327  4566  NOCOMMA,MUSTBE          /')'
00330  3761          3761
00331  4177          JMS     GETWD
00332  5703          JMP I   GETVAR
00333  0000  STOVAR, 0
00334  4504          JMS I   PGETADDR

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 9-1

00335  0000  VAR,    0
00336  0000  SSONE,  0
00337  0000  SSTWO,  0
00340  4435          FENTER
00341  2471          FSTI    ADDRESS
00342  0000          FEXIT
00343  5733          JMP I   STOVAR
             /
             /CHECK TO SEE IF HE TYPED 'BREAK' TO STOP A RUNNING
             /BASIC PROG.
             /
00344  0000  CKBRAK, 0
00345  6201          CDF     0
00346  1764          TAD I   PMBREAK /DID HE TYPE 'BREAK' TO STOP RUN?
00347  6211          CDF     10
00350  7640          SZA     CLA
00351  5744          JMP I   CKBRAK  /NOPE-JUST RETN.
00352  6201          CDF     0       
00353  2764          ISZ I   PMBREAK /RESET THE FLAG
00354  6213          CDF CIF 10      /DO A CLOSE IF A RT FILE OPEN
00355  4543          JMS I   PCLOS
00356  4537          JMS I   PCOWT   /YUP-WAIT FOR I/O
00357  4536          JMS I   PRESET  /RESET I/O DEVICES
00360  4516          JMS I   PPRINTXT        /PRINT MESSAGE
00361  6522          BREAK
00362  5763          JMP I   PHLP    /GO GET HELP AND SAVE A WORD
00363  4163  PHLP,   HLP

00364  7603  PMBREAK,        MBREAK

00365  7332  PENDNM, ENDNM
       0367          *367
00367  4516  FILALT, JMS I   PPRINTXT /HE TYPED ALTMODE WHILE INPUTTING A FILE NAME
00370  6501          DELETED         /GIVE MESSAGE AND GO TO EDIT MODE
00371  5522          JMP I   PEDIT

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 10



00372  4565  IF,     GET+ISIT        /MUST DO SPECIAL CHECK  FOR 'END#'
00373  1751          1751
00374  7410          SKP             /NOT IT
00375  5765          JMP I   PENDNM  /ITS 'IF END#'--HANDLE IT
00376  7201          CLA     IAC     /MUST DO SPECIAL CALL TO EVAL-HAVE WD
00377  4503          JMS I   PEVAL
00400  4435          FENTER
00401  2075          FST     OPERAND
00402  0000          FEXIT
00403  4566  IF1,    MUSTBE          /'THEN'--COME BACK HERE FROM END# ROUTINE
00404  1774          1774
00405  1075          TAD     OPERAND
00406  7750          SPA SNA CLA
00407  5271          JMP     SKIPIT
00410  4565          GET+ISIT        /A LINE#
00411  0000          0000
00412  5614          JMP I   XEXECU
00413  5322          JMP     GOTO+1
00414  0214  XEXECU, EXECUTE+1
00415  4567  FOR,    GET+MUSTBE      /A VARIABLE
00416  7000          7000
00417  4360          JMS     FINDIT
00420  5237          JMP     NOTHERE
00421  7201          CLA IAC
00422  1014          TAD     INDEX1
00423  3015          DCA     INDEX2
00424  7240          CLA CMA
00425  1014          TAD     INDEX1
00426  3014          DCA     INDEX1
00427  5234          JMP     INLUPF
00430  1415  LUPF,   TAD I   INDEX2
00431  3414          DCA I   INDEX1
00432  1415          TAD I   INDEX2
00433  3414          DCA I   INDEX1
00434  2055  INLUPF, ISZ     GOTEMP
00435  5230          JMP     LUPF
00436  2065          ISZ     FORCT
00437  1065  NOTHERE,TAD     FORCT
00440  1306          TAD     O11
00441  7750          SPA SNA CLA             /CAN'T FIT 9 IN FORLIST
00442  5303          JMP     FORERR
00443  1050          TAD     WORD
00444  7041          CIA
00445  3414          DCA I   INDEX1
00446  1050          TAD     WORD
00447  3254          DCA     FORVAR
00450  4567          GET+MUSTBE      /'='
00451  3673          3673
00452  4503          JMS I   PEVAL
00453  4504          JMS I   PGETADDR
00454  0000  FORVAR, 0
00455  0000          0
00456  0000          0

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 10-1

00457  4435          FENTER
00460  2471          FSTI    ADDRESS
00461  0000          FEXIT
00462  4566          MUSTBE          /'TO'
00463  3757          3757
00464  1045          TAD     LOCCTR
00465  3414          DCA I   INDEX1
00466  7240          CLA CMA
00467  1065          TAD     FORCT
00470  3065          DCA     FORCT

00471  4673  SKIPIT, JMS I   PIGNORE         /LOOK FOR "\" OR C.R.
00472  5505          JMP I   PEXECUTE        /AND EXECUTEPTHE NEXT STATEMENT.

00473  2137  PIGNORE,IGNORE


00474  0000  PASSCR, 0                       /THIS LOOKS FOR A REAL C.R.
00475  4673          JMS I   PIGNORE         /LOOK FOR "\" OR C.R.
00476  2050          ISZ     WORD
00477  4564          ISIT
00500  4100          4100                    /A REAL C.R. ?
00501  5275          JMP     .-4             /NOPE. A SLASH.
00502  5674          JMP I   PASSCR          /AND RETURN TO CALLER.



/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 11




00503  4501  FORERR, JMS I   PERROR
00504  0617          TEXT 'FOR'
00505  2200
00506  0011  O11,    11
00507  4177  GOSUB,  JMS GETWD
00510  4334          JMS     GOBOTH
00511  1163          TAD     GSBPTR
00512  1327          TAD     MGSBEND
00513  7650          SNA CLA
00514  5330          JMP     DEEPERR
00515  1045          TAD     LOCCTR
00516  3563          DCA I   GSBPTR
00517  2163          ISZ     GSBPTR
00520  5323          JMP     GOTO+2
00521  4177  GOTO,   JMS GETWD
00522  4334          JMS     GOBOTH
00523  2055          ISZ     GOTEMP
00524  1455          TAD I   GOTEMP
00525  3045          DCA     LOCCTR
00526  5505          JMP I   PEXECUTE
00527  2001  MGSBEND,-GSBEND
00530  4501  DEEPERR,JMS I   PERROR
00531  0717          TEXT 'GOSUB'
00532  2325
00533  0200
00534  0000  GOBOTH, 0
00535  4566          MUSTBE          /A LINENO
00536  0000          0000
00537  1050          TAD     WORD
00540  3055          DCA     GOTEMP
00541  2050          ISZ     WORD
00542  4564          ISIT            /DEFINED
00543  0000          0000
00544  5351          JMP     ISITDF
00545  4501          JMS I   PERROR
00546  1411          TEXT 'LINE#'
00547  1605
00550  4300
00551  4567  ISITDF, GET+MUSTBE      /(CR) OR '\'
00552  2000          2000
00553  5734          JMP I   GOBOTH
00554  0000  VARTEMP,0;0;0
00555  0000
00556  0000
00557  5743  PXFORLI,FORLIST-1
00560  0000  FINDIT, 0
00561  1065          TAD     FORCT
00562  3055          DCA     GOTEMP
00563  1357          TAD     PXFORLIST
00564  3014          DCA     INDEX1
00565  5373          JMP     INLOOP
00566  1414  FINDLUP,TAD I   INDEX1

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 11-1

00567  1050          TAD     WORD
00570  7650          SNA CLA
00571  5376          JMP     FOUND
00572  2014          ISZ     INDEX1
00573  2055  INLOOP, ISZ     GOTEMP
00574  5366          JMP     FINDLUP
00575  5760          JMP I   FINDIT
00576  2360  FOUND,  ISZ     FINDIT
00577  5760          JMP I   FINDIT

       0600          PAGE

00600  4567  NEXT,   GET+MUSTBE      /A VARIABLE
00601  7000          7000
00602  4672          JMS I   PFINDIT
00603  5273          JMP     NEXTERR
00604  1050          TAD     WORD
00605  3237          DCA     NEXTVAR
00606  4567          GET+MUSTBE      /(CR) OR '\'
00607  2000          2000
00610  1045          TAD     LOCCTR
00611  3271          DCA     LOCTEMP
00612  1414          TAD I   INDEX1
00613  3045          DCA     LOCCTR
00614  4503          JMS I   PEVAL
00615  4435          FENTER
00616  2303          FST+FWD+FORLIM-.
00617  0000          FEXIT
00620  4564          ISIT            /(CR) OR '\'
00621  2000          2000
00622  5226          JMP     TRYSTEP /NO
00623  4435          FENTER
00624  3147          FLD     ONE
00625  1207          FJMP+FWD+GOTSTEP-.
00626  4566  TRYSTEP,MUSTBE          /'STEP'
00627  3756          3756
00630  4503          JMS I   PEVAL
00631  4566          MUSTBE          /(CR) OR '\'
00632  2000          2000
00633  4435          FENTER
00634  2270  GOTSTEP,FST+FWD+FORSTEP-.
00635  0000          FEXIT
00636  4504          JMS I   PGETADDR
00637  0000  NEXTVAR,0
00640  0000          0
00641  0000          0
00642  4435          FENTER
00643  3471          FLDI    ADDRESS
00644  4260          FAD+FWD+FORSTEP-.
00645  2671          FST+BKWD+.-VARTEMP
00646  5253          FSB+FWD+FORLIM-.
00647  0000          FEXIT
00650  1024          TAD     ACS
00651  1324          TAD     FORSTEP
00652  7700          SMA CLA

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 11-2

00653  1020          TAD     AC1
00654  7640          SZA CLA
00655  5263          JMP     FORDONE
00656  4435          FENTER
00657  3703          FLD+BKWD+.-VARTEMP
00660  2471          FSTI    ADDRESS
00661  0000          FEXIT
00662  5505          JMP I   PEXECUTE
00663  1271  FORDONE,TAD     LOCTEMP
00664  3045          DCA     LOCCTR
00665  2065          ISZ     FORCT
00666  2055          ISZ     GOTEMP
00667  5265          JMP     .-2
00670  5505          JMP I   PEXECUTE
00671  0000  LOCTEMP,0
00672  0560  PFINDIT,FINDIT
00673  4501  NEXTERR,JMS I   PERROR
00674  1605          TEXT 'NEXT'
00675  3024
00676  0000
00677  4567  RETURN, GET+MUSTBE      /(CR) OR '\'
00700  2000          2000
00701  1163          TAD     GSBPTR
00702  1320          TAD     MGOLIST
00703  7650          SNA CLA
00704  5313          JMP     RETNERR
00705  7240          CLA CMA
00706  1163          TAD     GSBPTR
00707  3163          DCA     GSBPTR
00710  1563          TAD I   GSBPTR
00711  3045          DCA     LOCCTR
00712  5505          JMP I   PEXECUTE
00713  4501  RETNERR,JMS I   PERROR
00714  2205          TEXT 'RETURN'
00715  2425
00716  2216
00717  0000
00720  2014  MGOLIST,-GOLIST
00721  0000  FORLIM, 0;0;0
00722  0000
00723  0000
00724  0000  FORSTEP,0;0
00725  0000
00726  0000  SGN,    0
00727  4435          FENTER
00730  0100          FSGE
00731  3205          FLD+FWD+MNSONE-.
00732  0150          FSLE
00733  3147          FLD     ONE
00734  0000          FEXIT
00735  5726          JMP I   SGN
00736  6014  MNSONE, 6014;0;0
00737  0000
00740  0000
00741  0000  PUTCH,  0

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 11-3

00742  3326          DCA     SGN
00743  1326          TAD     SGN
00744  0027  PCCUNT, AND     O177
00745  1361          TAD     O7763A
00746  7650          SNA CLA                 /IS IT A C.R.
00747  3130          DCA     COLUMN  /YES
00750  1326          TAD     SGN             /RECALL THE CHARACTER.
00751  0362          AND     O140A
00752  7440          SZA
00753  1354          TAD     O7640A
00754  7640  O7640A, SZA CLA
00755  2130          ISZ     COLUMN
00756  1326          TAD     SGN
00757  4763          JMS I   JPUTCH
00760  5741          JMP I   PUTCH


00761  7763  O7763A, 7763
00762  0140  O140A,  140
00763  7000  JPUTCH, PUTER
             /
             /PART OF GETLIN ROUTINE
             /
00764  1060  BARROW, TAD     EPTR
00765  1171          TAD     MLBEGIN
00766  7650          SNA     CLA
00767  5777          JMP I   (NEWCHAR
00770  7240          CLA     CMA
00771  1060          TAD     EPTR
00772  3060          DCA     EPTR
00773  1376          TAD     O3737B
00774  4341          JMS     PUTCH
00775  5777          JMP I   (NEWCHAR
00776  3737  O3737B, 3737

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 12




00777  2622
       1000          PAGE


01000  0000  EVAL,   0
01001  7650          SNA     CLA     /FOR CALL FROM PRINT AND IF ROUTINES
01002  4177          JMS     GETWD
01003  1200          TAD     EVAL
01004  4506  EVALGO, JMS I   PPUSH
01005  1353          TAD     O4014
01006  4506          JMS I   PPUSH
01007  5213          JMP     GETOPR+1
01010  1354  ISUMIN, TAD     O4213
01011  4506          JMS I   PPUSH
01012  4177  GETOPR, JMS     GETWD
01013  4564          ISIT            /'-'
01014  3577          3577
01015  7410          SKP
01016  5210          JMP     ISUMIN
01017  4564          ISIT            /'+'
01020  3600          3600
01021  7410          SKP
01022  5212          JMP     GETOPR
01023  4564          ISIT            /'('
01024  3755          3755
01025  5232          JMP     NOPAREN /NO
01026  4200          JMS     EVAL
01027  4566          MUSTBE          /')'
01030  3761          3761
01031  5511          JMP I   PGOTOPR
01032  4564  NOPAREN,ISIT            /A VARIABLE
01033  7000          7000
01034  5302          JMP     NOTVAR  /NO
01035  3273          DCA     ONESS
01036  3274          DCA     TWOSS
01037  1050          TAD     WORD
01040  3272          DCA     WDTEMP
01041  4565          GET+ISIT        /'('
01042  3755          3755
01043  5271          JMP     GOTSS   /NO
01044  1272          TAD     WDTEMP
01045  4506          JMS I   PPUSH
01046  4200          JMS     EVAL
01047  4564          ISIT            /','
01050  3763          3763
01051  5261          JMP     ONEDIM
01052  4510          JMS I   PFIX
01053  4506          JMS I   PPUSH
01054  4200          JMS     EVAL
01055  4510          JMS I   PFIX
01056  3274          DCA     TWOSS
01057  4507          JMS I   PPOP

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 12-1

01060  5263          JMP     .+3
01061  3274  ONEDIM, DCA     TWOSS
01062  4510          JMS I   PFIX
01063  3273          DCA     ONESS
01064  4566          MUSTBE          /')'
01065  3761          3761
01066  4507          JMS I   PPOP
01067  3272          DCA     WDTEMP
01070  4177          JMS     GETWD
01071  4504  GOTSS,  JMS I   PGETADDR
01072  0000  WDTEMP, 0
01073  0000  ONESS,  0
01074  0000  TWOSS,  0
01075  4435          FENTER
01076  3471          FLDI    ADDRESS
01077  0000          FEXIT
01100  5701          JMP I   .+1
01101  1203          OPDONE
01102  4573  NOTVAR, JMS I   PISITLIT /ISIT A LITERAL
01103  5305          JMP     ISITFUN /NO
01104  5511          JMP I   PGOTOPR /IT IS IN THE AC NOW
01105  1450  ISITFUN,TAD I   WORD
01106  1352          TAD     O3734           /-4044, WHICH IS BEGINNING OF FUNCTIONS.
01107  7500          SMA
01110  5502          JMP I   PSXERR  /BAD!!
01111  1351          TAD     O20     /IS IT PAST END OF LEGAL FUNCTS??
01112  7510          SPA                     /IS IT A LEGAL FUNCTION?
01113  5502          JMP I   PSXERR          /NO. EXIT WITH MESSAGE.
01114  7450          SNA                     /WAS IT 'FN'
01115  4177          JMS     GETWD           /YES,SKIP OVER LETTER
01116  4506          JMS I   PPUSH
01117  4567          GET+MUSTBE              /'('
01120  3755          3755
01121  4200          JMS     EVAL
01122  4507          JMS I   PPOP
01123  1330          TAD     FJUMP
01124  3325          DCA     .+1
01125  7402          HLT
01126  5727          JMP I   .+1
01127  1200          FNEXIT
01130  4731  FJUMP,  JMS I   FUNTAB
01131  5453  FUNTAB, FN
01132  5616          COS
01133  5600          TAN
01134  6200          ATN
01135  6114          LOG
01136  6000          EXP
01137  5412          SQR
01140  6425          ABS
01141  0726          SGN
01142  6434          INT
01143  5353          RND
01144  5624          SIN
01145  3550          PUTJ                    /POINTER TO PUT CHAR ROUTINE.
01146  1765          GETJ                    /GET A CHAR FROM THE TTY.

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 12-2

01147  5547          TAB                     /TAB FUNCTION IS IMPLEMENTED.
01150  6441          SXERR                   /UNIMPLEMENTED USER FUNCTION.



01151  0020  O20,    20
01152  3734  O3734,  3734
01153  4014  O4014,  4014
01154  4213  O4213,  4213



01155  1037  IMMED,  TAD     PLINBUF
01156  3045          DCA     LOCCTR
01157  1362          TAD     PPXXEOF
01160  3054          DCA     LINENO
01161  5505          JMP I   PEXECUTE

01162  5541  PPXXEOF,        XXEOF

01163  4501  SPACERR,JMS I   PERROR
01164  2417          TEXT 'TOO-BIG'
01165  1755
01166  0211
01167  0700
01170  6213  CLOSEO, CDF CIF 10      /CLOSE HANDLER IS IN FLD.1
01171  4543          JMS I   PCLOS
01172  5505          JMP I   PEXECUTE
01173  4536  TUBIG,  JMS I   PRESET
01174  4516          JMS I   PPRINTXT
01175  5162          TOOLONG
01176  5777          JMP I   PNEWLIN
01177  2606  PNEWLIN,        NEWLIN

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 13



       1200          PAGE

01200  4566  FNEXIT, MUSTBE          /')'
01201  3761          3761
01202  4177  GOTOPR, JMS     GETWD
01203  4507  OPDONE, JMS I   PPOP
01204  3070          DCA     OLDOP
01205  1450          TAD I   WORD
01206  0272          AND     O700
01207  7650          SNA CLA
01210  5220          JMP     ITSOP
01211  1450          TAD I   WORD
01212  0275          AND     O7077
01213  1273          TAD     O3755
01214  7100          CLL
01215  1366          TAD     O23
01216  7620          SNL CLA
01217  5502          JMP I   PSXERR
01220  1070  ITSOP,  TAD     OLDOP
01221  0272          AND     O700
01222  3271          DCA     OTEMP
01223  1450          TAD I   WORD
01224  0272          AND     O700
01225  7041          CIA
01226  1271          TAD     OTEMP
01227  7700          SMA CLA
01230  5247          JMP     DOITNOW
01231  1070          TAD     OLDOP
01232  4506          JMS I   PPUSH
01233  4435          FENTER
01234  2075          FST     OPERAND
01235  0000          FEXIT
01236  1075          TAD     OPERAND
01237  4506          JMS I   PPUSH
01240  1076          TAD     OPERAND+1
01241  4506          JMS I   PPUSH
01242  1077          TAD     OPERAND+2
01243  4506          JMS I   PPUSH
01244  1450          TAD I   WORD
01245  4506          JMS I   PPUSH
01246  5776          JMP I   PGETOPR
01247  1070  DOITNOW,TAD     OLDOP
01250  0140          AND     O77
01251  1274          TAD     O7764A
01252  7450          SNA
01253  5363          JMP     UDOPER
01254  7001          IAC
01255  7650          SNA CLA
01256  5321          JMP     UMOPER
01257  1070          TAD     OLDOP
01260  0140          AND     O77
01261  1276          TAD     OJUMP
01262  3271          DCA     OTEMP

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 13-1

01263  4507          JMS I   PPOP
01264  3077          DCA     OPERAND+2
01265  4507          JMS I   PPOP
01266  3076          DCA     OPERAND+1
01267  4507          JMS I   PPOP
01270  3075          DCA     OPERAND
01271  7402  OTEMP,  HLT
01272  0700  O700,   700
01273  3755  O3755,  3755
01274  7764  O7764A, 7764
01275  7077  O7077,  7077
01276  5677  OJUMP,  JMP I   .+1
01277  1312          PLUS
01300  1316          MINUS
01301  1327          STAR
01302  1332          SLASH
01303  5740          UPARRX  /OR 'UPARROW' IF NO EXTENDED FNS
01304  1342          RELATE
01305  1342          RELATE
01306  1342          RELATE
01307  1342          RELATE
01310  1342          RELATE
01311  1342          RELATE
01312  4435  PLUS,   FENTER
01313  4075          FAD     OPERAND
01314  0000  FADEXT, FEXIT
01315  5203          JMP     OPDONE
01316  4435  MINUS,  FENTER
01317  5075          FSB     OPERAND
01320  0000          FEXIT
01321  1020  UMOPER, TAD     AC1
01322  7640          SZA CLA
01323  7330          CLA CLL CML RAR
01324  1024          TAD     ACS
01325  3024          DCA     ACS     /DIRECT REF TO FLOATING AC
01326  5203          JMP     OPDONE
01327  4435  STAR,   FENTER
01330  6075          FMP     OPERAND
01331  1615          FJMP+BKWD+.-FADEXT
01332  4435  SLASH,  FENTER
01333  2204          FST+FWD+SLSHTMP-.
01334  3075          FLD     OPERAND
01335  7202          FDV+FWD+SLSHTMP-.
01336  1622          FJMP+BKWD+.-FADEXT
01337  0000  SLSHTMP,0;0;0
01340  0000
01341  0000
01342  1070  RELATE, TAD     OLDOP
01343  1367          TAD     CONST
01344  3353          DCA     THESKIP
01345  6201          CDF     0               /''''''''' 8 K INSERT.
01346  1753          TAD I   THESKIP
01347  6211          CDF     10              /''''''''' 8 K INSERT.
01350  3353          DCA     THESKIP
01351  4435          FENTER

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 13-2

01352  5075          FSB     OPERAND
01353  7402  THESKIP,HLT
01354  1204          FJMP+FWD+4
01355  3147          FLD     ONE
01356  0000          FEXIT
01357  5203          JMP     OPDONE
01360  3150          FLD     ZERO
01361  0000          FEXIT
01362  5203          JMP     OPDONE
01363  4507  UDOPER, JMS I   PPOP
01364  3070          DCA     OLDOP
01365  5470          JMP I   OLDOP
01366  0023  O23,    23
01367  5263  CONST,  .-4104
01370  0050          FSEQ            /  =
01371  0140          FSGT            /  <
01372  0110          FSLT            /  >
01373  0100          FSGE            /  <=
01374  0150          FSLE            /  >=
01375  0040          FSNE            /  <>

01376  1012  PGETOPR,        GETOPR
       1400          PAGE


01400  0000  GETADDR,0
01401  6201          CDF     0               /''''''''''' 8 K INSERT.
01402  1600          TAD I   GETADDR
01403  3015          DCA     INDEX2
01404  1200          TAD     GETADDR /USE AN XREG TO SAVE A FEW WDS.
01405  3010          DCA     XRLOC
01406  1410          TAD I   XRLOC
01407  3355          DCA     GSS1
01410  1410          TAD I   XRLOC

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 14


01411  3356          DCA     GSS2
01412  6211          CDF     10              /''''''''''' 8 K INSERT.
01413  1415          TAD I   INDEX2
01414  3071          DCA     ADDRESS
01415  2071          ISZ     ADDRESS
01416  1355          TAD     GSS1
01417  7650          SNA CLA
01420  5410          JMP I   XRLOC   /DONE RETURN
01421  1415          TAD I   INDEX2
01422  7450          SNA
01423  5260          JMP     ALLOC
01424  7140          CLL CMA
01425  1355          TAD     GSS1
01426  7630          SZL CLA
01427  5363          JMP     SSERR
01430  1415          TAD I   INDEX2
01431  3357          DCA     GDIM2
01432  1356          TAD     GSS2
01433  7450          SNA
01434  5252          JMP     NOSS2
01435  7141          CLL CIA
01436  1357          TAD     GDIM2
01437  7620          SNL CLA
01440  5363          JMP     SSERR
01441  1355          TAD     GSS1
01442  7041          CIA
01443  3355          DCA     GSS1
01444  7410          SKP
01445  1357          TAD     GDIM2
01446  2355          ISZ     GSS1
01447  5245          JMP     .-2
01450  1356          TAD     GSS2
01451  3355          DCA     GSS1
01452  1355  NOSS2,  TAD     GSS1
01453  7104          CLL RAL
01454  1355          TAD     GSS1
01455  1071          TAD     ADDRESS
01456  3071          DCA     ADDRESS
01457  5410  NOSS1,  JMP I   XRLOC
01460  2034  ALLOC,  ISZ     DIMFLAG
01461  7410          SKP
01462  5272          JMP     ISDIM
01463  3034          DCA     DIMFLAG
01464  1356          TAD     GSS2
01465  7640          SZA CLA
01466  1362          TAD     O13
01467  3356          DCA     GSS2
01470  1362          TAD     O13
01471  3355          DCA     GSS1
01472  1356  ISDIM,  TAD     GSS2
01473  7450          SNA
01474  7201          CLA IAC
01475  7041          CIA
01476  3357          DCA     GDIM2

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 14-1

01477  7301          CLA CLL IAC
01500  1355          TAD     GSS1
01501  7430          SZL
01502  5760          JMP I   PSPACERR
01503  2357          ISZ     GDIM2
01504  5300          JMP     .-4
01505  3357          DCA     GDIM2
01506  1357          TAD     GDIM2
01507  7124          CLL CML RAL
01510  7420          SNL
01511  1357          TAD     GDIM2
01512  3357          DCA     GDIM2
01513  1357          TAD     GDIM2
01514  7430          SZL
01515  5760          JMP I   PSPACERR
01516  4542          JMS I   SPLEFT
01517  7410          SKP
01520  5760          JMP I   PSPACERR
01521  7344          CLA CLL CMA RAL
01522  1015          TAD     INDEX2
01523  3015          DCA     INDEX2
01524  1003          TAD     ARRLOC
01525  3415          DCA I   INDEX2
01526  1355          TAD     GSS1
01527  3415          DCA I   INDEX2
01530  1356          TAD     GSS2
01531  3415          DCA I   INDEX2
01532  7240          CLA CMA
01533  1071          TAD     ADDRESS
01534  3071          DCA     ADDRESS
01535  1361          TAD     O7774
01536  3356          DCA     GSS2
01537  1471          TAD I   ADDRESS
01540  2071          ISZ     ADDRESS
01541  4523          JMS I   PSTICKIT
01542  2356          ISZ     GSS2
01543  5337          JMP     .-4
01544  1357          TAD     GDIM2
01545  7041          CIA
01546  1156          TAD     O4
01547  3357          DCA     GDIM2
01550  4523          JMS I   PSTICKIT
01551  2357          ISZ     GDIM2
01552  5350          JMP     .-2
01553  4541          JMS I   CNCLR           /CHECK FOR CONTROL C.
01554  5201          JMP     GETADDR+1
01555  0000  GSS1,   0
01556  0000  GSS2,   0
01557  0000  GDIM2,  0
01560  1163  PSPACER,SPACERR
01561  7774  O7774,  7774
01562  0013  O13,    13              /(12) IF 1 ORG INDEXING
01563  4501  SSERR,  JMS I   PERROR
01564  2325          TEXT 'SUBSCRIPT'
01565  0223

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 14-2

01566  0322
01567  1120
01570  2400
01571  4005  QERROR, TEXT ' ERROR'
01572  2222
01573  1722
01574  0000

       1575  *1575
01575  1054  DEF,    TAD     LINENO
01576  3014          DCA     INDEX1
01577  1414          TAD I   INDEX1
01600  3217          DCA     USERFN
01601  4567          GET+MUSTBE      /'FN'
01602  3754          3754
01603  4567          GET+MUSTBE      /A VARIABLE
01604  7000          7000
01605  4567          GET+MUSTBE      /'('
01606  3755          3755
01607  4567          GET+MUSTBE      /A VARIABLE
01610  7000          7000
01611  4567          GET+MUSTBE      /')'
01612  3761          3761
01613  4567          GET+MUSTBE      /'='
01614  3673          3673
01615  5616          JMP I   PSKIPIT
01616  0471  PSKIPIT,SKIPIT
01617  0000  USERFN, 0
01620  4566  MORERD, MUSTBE          /','
01621  3763          3763
01622  4515  READ,   JMS I   PGETVAR
01623  7240          CLA CMA
01624  1045          TAD     LOCCTR
01625  3277          DCA     LOCTMP
01626  1046          TAD     READLOC
01627  3045          DCA     LOCCTR
01630  4565          GET+ISIT        /(CR) OR '\'
01631  2000          2000
01632  7410          SKP
01633  5257          JMP     SEARCH
01634  4564          ISIT            /A LINENO
01635  0000          0000
01636  7410          SKP
01637  5257          JMP     SEARCH
01640  4564          ISIT            /','
01641  3763          3763
01642  5272          JMP     DATAERR
01643  4503  ISSOME, JMS I   PEVAL
01644  7240          CLA CMA
01645  1045          TAD     LOCCTR
01646  3046          DCA     READLOC
01647  1277          TAD     LOCTMP
01650  3045          DCA     LOCCTR
01651  4514          JMS I   PSTOVAR
01652  4565          GET+ISIT        /(CR) OR '\'

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 14-3

01653  2000          2000
01654  5220          JMP     MORERD
01655  5505          JMP I   PEXECUTE
01656  4177  SCHMOR, JMS     GETWD
01657  4564  SEARCH, ISIT            /'TEXT'-MUST IGNORE TEXT IN PRINT OR REM
01660  5000          5000
01661  7410          SKP             /NOPE
01662  4676          JMS I   KIGNORE /YUP-SKIP TO CR. OR \
01663  4564          ISIT            /'DATA'
01664  1757          1757
01665  7410          SKP
01666  5243          JMP     ISSOME
01667  4564          ISIT            /(EOF)
01670  1755          1755
01671  5256          JMP     SCHMOR
01672  4501  DATAERR,JMS I   PERROR
01673  0401          TEXT 'DATA'
01674  2401
01675  0000
01676  2137  KIGNORE,        IGNORE
01677  0000  LOCTMP, 0
01700  0000  GETBLK, 0
01701  4561          JMS I   PCHKFIT
01702  7040          CMA
01703  1004          TAD     CODELOC
01704  3010          DCA     XRLOC
01705  1052          TAD     PSYMTAB /CALCULATE HOW MANY WORDS TO MOVE
01706  7041          CMA     IAC
01707  1004          TAD     CODELOC
01710  3277          DCA     LOCTMP  /STORE AS A COUNTER
01711  1004          TAD     CODELOC
01712  1363          TAD     ABCDEF
01713  3004          DCA     CODELOC
01714  7040          CMA
01715  1004          TAD     CODELOC
01716  3011          DCA     XRPUT   /USE INDEX REGS. FOR MOVE.
01717  1052          TAD     PSYMTAB         /UPDATE SYMBOL TABLE NOW.
01720  1363          TAD     ABCDEF          /BY ADDING IN CORRECTION FACTOR.
01721  3052          DCA     PSYMTAB

01722  1410  GTBKLP, TAD I   XRLOC           /MOVE TEXT NOW.
01723  3411          DCA I   XRPUT
01724  2277          ISZ     LOCTMP          /NOW CHECK FOR END.
01725  5322          JMP     GTBKLP

01726  7240          CLA CMA
01727  1053          TAD     NSYMTAB
01730  3053          DCA     NSYMTAB
01731  1163          TAD     GSBPTR
01732  7040          CMA
01733  1162          TAD     PGOLIST
01734  3277          DCA     LOCTMP
01735  1162          TAD     PGOLIST
01736  3050          DCA     WORD
01737  1363          TAD     ABCDEF

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 14-4

01740  1450          TAD I   WORD
01741  3450          DCA I   WORD
01742  2050          ISZ     WORD
01743  2277          ISZ     LOCTMP
01744  5337          JMP     .-5
01745  1065          TAD     FORCT
01746  3277          DCA     LOCTMP
01747  1364          TAD     PPFORLIS
01750  3050          DCA     WORD
01751  5357          JMP     .+6
01752  1363          TAD     ABCDEF
01753  1450          TAD I   WORD
01754  3450          DCA I   WORD
01755  2050          ISZ     WORD
01756  2050          ISZ     WORD
01757  2277          ISZ     LOCTMP
01760  5352          JMP     .-6
01761  1052          TAD     PSYMTAB
01762  5700          JMP I   GETBLK
01763  7774  ABCDEF, -4
01764  5745  PPFORLI,FORLIST+1


01765  0000  GETJ,   0                       /GETS A CHARACTER FROM THE TTY.
01766  4773          JMS I   PBEGFIX         /CLEAN UP THE FAC
01767  4432          JMS I   PGETCH          /FECTH A CHAR.
01770  3016          DCA     AC3             /SAVE IT, BABY!
01771  4544          JMS I   PANORM          /AND NORMALIZE AC.
01772  5765          JMP I   GETJ            /AND RETURN NOW.

01773  3760  PBEGFIX,BEGFIX

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 15


       1776          *1776


01776  2050  NOTNOW, ISZ     WORD
01777  1450          TAD I   WORD
02000  7450          SNA
02001  5227          JMP     INSERT
02002  3366          DCA     LOWLOC
02003  3450          DCA I   WORD
02004  1366          TAD     LOWLOC
02005  3045          DCA     LOCCTR
02006  4512          JMS I   PPASSCR
02007  1366  MOVE,   TAD     LOWLOC
02010  7041          CIA
02011  1004          TAD     CODELOC
02012  7650          SNA CLA
02013  5225          JMP     INSRT5
02014  7340          CLA CLL CMA
02015  1366          TAD     LOWLOC
02016  3366          DCA     LOWLOC
02017  7340          CLA CLL CMA
02020  1045          TAD     LOCCTR
02021  3045          DCA     LOCCTR
02022  1766          TAD I   LOWLOC
02023  3445          DCA I   LOCCTR
02024  5207          JMP     MOVE
02025  1045  INSRT5, TAD     LOCCTR
02026  3004          DCA     CODELOC
02027  1061  INSERT, TAD     FPTR
02030  1040          TAD     MLINBUF
02031  7040          CMA
02032  3061          DCA     FPTR
02033  7326          CLA CLL CML RTL
02034  1061          TAD     FPTR
02035  7450          SNA
02036  5335          JMP     FIXLIN
02037  7040          CMA
02040  4561          JMS I   PCHKFIT
02041  7240          CLA     CMA
02042  1052          TAD     PSYMTAB /AN R.L OPTIMIZATION FOR CASSETTE INPUT
02043  3045          DCA     LOCCTR  /DON'T LOOK THRU ALL THE LINES
02044  1131          TAD     INDEV   /IF INPUT FROM CASSETTE-KNOW THEY'RE IN ORDER
02045  7110          CLL     RAR
02046  7640          SZA     CLA
02047  5263          JMP     OLDKLG  /DO THE KLUDGE FOR CASSETTE INPUT
02050  1004          TAD     CODELOC
02051  3045          DCA     LOCCTR
02052  1437          TAD I   PLINBUF
02053  7001          IAC
02054  3014          DCA     INDEX1
02055  1414          TAD I   INDEX1
02056  3075          DCA     OPERAND
02057  1414          TAD I   INDEX1
02060  3076          DCA     OPERAND+1

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 15-1

02061  7410          SKP
02062  4512          JMS I   PPASSCR /SKIP DOWN TO NEXT LINE
02063  4565  OLDKLG, GET+ISIT        /A LINENO?
02064  0000          0
02065  5303          JMP     IAMLESS
02066  1050          TAD     WORD
02067  7001          IAC
02070  3014          DCA     INDEX1
02071  1414          TAD I   INDEX1
02072  7141          CLL CMA IAC
02073  1075          TAD     OPERAND
02074  7640          SZA     CLA
02075  5301          JMP     FRSTNE
02076  1414          TAD I   INDEX1
02077  7141          CLL CMA IAC
02100  1076          TAD     OPERAND+1
02101  7630  FRSTNE, SZL     CLA
02102  5262          JMP     OLDKLG-1
02103  7240  IAMLESS,        CLA CMA
02104  1004          TAD     CODELOC
02105  3010          DCA     XRLOC   /STORE IN INDEX REG.
02106  1061          TAD     FPTR
02107  1004          TAD     CODELOC
02110  3004          DCA     CODELOC
02111  7240          CLA     CMA
02112  1004          TAD     CODELOC
02113  3011          DCA     XRPUT
02114  1045          TAD     LOCCTR
02115  7041          CMA     IAC
02116  1010          TAD     XRLOC
02117  7001          IAC             /ADJUST BY 1
02120  3366          DCA     LOWLOC  /STORE IN TEM
02121  5324          JMP     .+3     /SKIP OVER FIRST TIME
02122  1410  MOVLUP, TAD I   XRLOC   /GET A WORD
02123  3411          DCA I   XRPUT   /STORE IN NEW PLACE
02124  2366          ISZ     LOWLOC  /DONE ALL?
02125  5322          JMP     .-3     /NOPE
02126  7240  TRANSF, CLA     CMA
02127  1037          TAD     PLINBUF
02130  3010          DCA     XRLOC
02131  1410  TRALUP, TAD I   XRLOC
02132  3411          DCA I   XRPUT
02133  2061          ISZ     FPTR
02134  5331          JMP     TRALUP
02135  4557  FIXLIN, JMS I   PLINFIX
02136  5522          JMP I   PEDIT

02137  0000  IGNORE, 0                       /THIS ROUTINE LOOKS FOR A "\" OR A C.R.

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 16


02140  4177          JMS     GETWD
02141  1450          TAD I   WORD
02142  1367          TAD     K5000
02143  7440          SZA             /IS IT TEXT?
02144  5353          JMP     NOTBAD  /NOPE
02145  1445          TAD I   LOCCTR  /YUP
02146  2045          ISZ     LOCCTR  /GET NEXT WORD OF IT
02147  0140          AND     O77
02150  7640          SZA CLA                 /END OF TEXT?
02151  5345          JMP     .-4             /NOPE.
02152  5340          JMP     IGNORE+1        /YEP. GET NEXT ITEM.
02153  1367  NOTBAD, TAD     K5000   /IS IT CAR.RETN.?
02154  7450          SNA
02155  5737          JMP I   IGNORE  /YES-RETN.
02156  1370          TAD     KM4004  /NO-LOOK FOR LITERAL
02157  7100          CLL
02160  1156          TAD     O4
02161  7420          SNL
02162  7200          CLA             /NOT A LITERAL
02163  1045          TAD     LOCCTR  /LITERAL-ADD # OF WDS TO LOCCTR
02164  3045          DCA     LOCCTR
02165  5340          JMP     IGNORE+1
02166  0000  LOWLOC, 0
02167  5000  K5000,  5000
02170  3774  KM4004, 3774
02171  0010  O10,    10
       2172  *2172
02172  1133  PRINT,  TAD     OUTDEV  /SAVE OUTPUT DEV.
02173  3132          DCA     OUTD2
02174  7344  PRINT2, CLA CLL CMA RAL /ENTER HERE FOR PRINT# W/OUTDEV=CASSETTE
02175  1133          TAD     OUTDEV
02176  7740          SMA SZA CLA
02177  1371          TAD     O10
02200  1357          TAD     O110    /NOW ADD IN 72. THUS TTY,CASSETTE=72,LPT=80.
02201  3355          DCA     TWIDTH          /AND SAVE FOR FUTURE USE.
02202  4565          GET+ISIT                        /CHECK FOR FIRST COMMA. ONCE ONLY CHECK.
02203  3763          3763
02204  5207          JMP     PRINTC          /NO. CONTINUE CHECKING.
02205  5302          JMP     PRINBLK         /YEP. GIVE BLANK, THEN TAB OVER.
02206  4177  PRINTG, JMS     GETWD           /GET NEXT ELEMENT AFTER A TEXT ELEMENT.
02207  3343  PRINTC, DCA     TABFLG          /RESET TAB INDICATER.
02210  4564          ISIT                    /CHECK TO SEE IF CARRIAGE RETURN.
02211  2000          2000
02212  5220          JMP     NOPCR           /NOT A CARRIAGE RETURN. CONTINUE CHECKING.
02213  4516          JMS I   PPRINTXT
02214  6531          CRLF
02215  1132  PRINEX, TAD     OUTD2
02216  3133          DCA     OUTDEV  /RESTORE OUTPUT DEVICE
02217  5505          JMP I   PEXECUTE

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 17



02220  4564  NOPCR,  ISIT                    /IS IT A COMMA (",")
02221  3763          3763
02222  5315          JMP     PRENT           /NO. FINISH CHECKING BELOW.
02223  5306          JMP     PRINCOM         /IT IS. PROCESS THE COMMA NOW.

02224  4564  PRINTHS,ISIT                    /TEXT
02225  5000          5000
02226  5236          JMP     NOTTXT
02227  4177  PRINQUO,JMS     GETWD
02230  1050          TAD     WORD
02231  7002          BSW
02232  4260          JMS     PRINHAF
02233  1050          TAD     WORD
02234  4260          JMS     PRINHAF
02235  5227          JMP     PRINQUO
02236  7201  NOTTXT, CLA     IAC     /SPECIAL CALL TO EVAL!!
02237  4503          JMS I   PEVAL
02240  1343          TAD     TABFLG          /WAS THERE A TAB PRESENT?
02241  7640          SZA CLA
02242  5760          JMP I   TABTHR          /YEP. EXECUTE TAB CORRECTER.
02243  1356          TAD     O14             /SEE IF ROOM FOR 13 PLACES(1+12).
02244  4344          JMS     CHECKW
02245  1024          TAD     ACS
02246  7700          SMA     CLA
02247  1051          TAD     O240
02250  4521          JMS I   POUTNUM /OUTNUM CALLS PUTCH IF AC NOT=0
02251  1176          TAD     CMSWCH  /CHECK SWITCH FOR PRINTING COMMAS
02252  1133          TAD     OUTDEV  /DURING RUNTIME OUTPUT TO CASSETTE
02253  7650          SNA     CLA
02254  1356          TAD     O14     /DO IT -CHANGE SPACE TO COMMA!!
02255  1051          TAD     O240
02256  4433          JMS I   PPUTCH
02257  5207          JMP     PRINTC          /GO BACK AND GET NEXT.
02260  0000  PRINHAF,0
02261  0140          AND     O77
02262  7450          SNA
02263  5206          JMP     PRINTG          /GO SKIP PAST TEXT ELEMENT AND CHECK NEXT.
02264  1324          TAD     OO7736
02265  7450          SNA
02266  5660          JMP I   PRINHAF
02267  1064          TAD     O2
02270  0140          AND     O77
02271  1051          TAD     O240
02272  3024          DCA     ACS             /SAVE CHARACTER FOR A SECOND.
02273  4344          JMS     CHECKW          /CHECK TO SEE IF IT'LL FIT ON THE LINE.
02274  1024          TAD     ACS             /RESTORE THE CHARACTER.
02275  4433          JMS I   PPUTCH
02276  5660          JMP I   PRINHAF


/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 18


02277  4564  COMCK,  ISIT            /','
02300  3763          3763
02301  5224          JMP     PRINTHS
02302  7200  PRINBLK,CLA                     /MAKE SURE AC IS ZERO.
02303  1051          TAD     O240
02304  4433          JMS I   PPUTCH
02305  4344          JMS     CHECKW          /CHECK TO SEE IF ROOM FOR ONE MORE.
02306  1130  PRINCOM,TAD     COLUMN          /SEE IF COLUMN ON COMMA BOUNDRY.
02307  7450          SNA
02310  5320          JMP     PRINSEM         /YEP.
02311  1325          TAD     O7762           /SUBTRACT A LITTLE AN CHECK AGAIN.
02312  7500          SMA                     /TOO FAR?
02313  5307          JMP     .-4             /NOPE.
02314  5302          JMP     PRINBLK         /YEP. GIVE BLANK AND LOOP AGAIN.

02315  4564  PRENT,  ISIT            /';'
02316  3762          3762
02317  5277          JMP     COMCK
02320  4565  PRINSEM,GET+ISIT        /(CR) OR '\'
02321  2000          2000
02322  5315          JMP PRENT
02323  5215          JMP     PRINEX
02324  7736  OO7736, 7736
02325  7762  O7762,  7762
02326  0000  LINFIX, 0
02327  1004          TAD     CODELOC
02330  3045          DCA     LOCCTR
02331  4177  LFXLUP, JMS     GETWD
02332  1450          TAD I   WORD
02333  7640          SZA CLA         /IS IT A LINENO
02334  5726          JMP I   LINFIX  /NO
02335  2050          ISZ     WORD
02336  7240          CLA CMA
02337  1045          TAD     LOCCTR
02340  3450          DCA I   WORD
02341  4512          JMS I   PPASSCR
02342  5331          JMP     LFXLUP


02343  0000  TABFLG, 0                       /TAB FOUND FLAG.

02344  0000  CHECKW, 0                       /THIS ROUTINE CHECKS FOR LINE TOO LONG.
02345  1130          TAD     COLUMN          /GET WHERE AT NOW.
02346  7040          CMA                     /-WHEREAT-#OF PLACES IN OUT CHAR.
02347  1355          TAD     TWIDTH          /ADD IN WIDTH OF DEVICE.
02350  7700          SMA CLA                 /TOO BIG.
02351  5744          JMP I   CHECKW          /NAH. RETURN TO SENDER.
02352  4516          JMS I   PPRINTXT        /YEP.GIVE C.R.L.F.
02353  6531          CRLF
02354  5744          JMP I   CHECKW          /AND RETURN TO SENDER.

02355  0000  TWIDTH, 0                       /0 IS OK SINCE IT'LL BE SET UP CORRECTLY.
02356  0014  O14,    14                      /MAGIC CONSTANT.
02357  0110  O110,   110                     /WDTH OF TTY PAPER.

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 18-1


02360  6350  TABTHR, TABDO                   /ROUTINE WHICH PROCESS TAB CHARACTER.

02361  2034  MENDPDL,-ENDPDL-1

02362  0000  PUSH,   0
02363  3436          DCA I   PDL
02364  2036          ISZ     PDL
02365  1036          TAD     PDL
02366  1361          TAD     MENDPDL
02367  7640          SZA CLA
02370  5762          JMP I   PUSH
02371  4501          JMS I   PERROR
02372  0530          TEXT 'EXPRESSION'
02373  2022
02374  0523
02375  2311
02376  1716
02377  0000
       2400  PAGE




/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 19


02400  4264  END,    JMS     CLEARV  
02401  6213  STOP,   CDF CIF 10      /GO CLOSE RUNTIME OUTPUT FILE IF ONE OPEN
02402  4543          JMS I   PCLOS   /ROUTINE IS IN FIELD 1
02403  4537          JMS I   PCOWT   /WAIT FOR I/O TO FINISH UP
02404  4536          JMS I   PRESET  /RESET DEVICES
02405  4516          JMS I   PPRINTXT        /GIVE THE STOP MESSAGE
02406  6525          READY
02407  4537  EXIT,   JMS I   PCOWT           /WAIT FOR BUFFER TO EMPTY AND THEN CONTINUE.
02410  1174          TAD     O215
02411  4433          JMS I   PPUTCH
02412  1175  EDIT,   TAD     O212
02413  4433          JMS I   PPUTCH
02414  1132          TAD     OUTD2           /RESET DEVICE
02415  3133          DCA     OUTDEV
02416  4541          JMS I   CNCLR           /CHECK TO SEE IF ^C WAS TYPED.
02417  1367          TAD     PXXTHEN
02420  4526          JMS I   PGETLIN
02421  1437          TAD I   PLINBUF
02422  3050          DCA     WORD
02423  1450          TAD I   WORD
02424  7650          SNA CLA
02425  5773          JMP I   PNOTNOW
02426  1175          TAD     O212
02427  4433          JMS I   PPUTCH
02430  1132          TAD     OUTD2           /RESET I/O DEVICE.
02431  3133          DCA     OUTDEV
02432  4564          ISIT            /'RUN'
02433  3733          3733
02434  7410          SKP
02435  5257          JMP     RUN
02436  4564          ISIT            /'LIS'
02437  3734          3734
02440  7410          SKP
02441  5770          JMP I   PLIST
02442  4564          ISIT            /'SCR'
02443  3732          3732
02444  5261          JMP     SAVE1
02445  1372  SCRATCH,TAD     PPERMSYM
02446  3004          DCA     CODELOC
02447  1371          TAD     PXXEOF
02450  3772          DCA I   PPERMSYM
02451  1372          TAD     PPERMSYM
02452  7001          IAC
02453  3052          DCA     PSYMTAB
02454  7240          CLA CMA
02455  3053          DCA     NSYMTAB
02456  4536  RUNC,   JMS I   PRESET          /RESET DEVICES AFTER SCRATCH.
                                     /PROGRAM CHAINED TO STARTS HERE(RUNC) AFTER
                                     /ALL IS READ AND COMPILED
02457  4264  RUN,    JMS     CLEARV
02460  5505          JMP I   PEXECUTE

02461  6213  SAVE1,  CDF CIF 10      /SAVE ROUTINE IS IN FIELD 1
02462  5663          JMP I   PSAVE

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 19-1

02463  1000  PSAVE,  SAVE

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 20



02464  0000  CLEARV, 0
02465  1052          TAD     PSYMTAB
02466  3060          DCA     EPTR
02467  1053          TAD     NSYMTAB
02470  3061          DCA     FPTR
02471  5310          JMP     RUNIN
02472  1460  RUNLUP, TAD I   EPTR
02473  1365          TAD     O7000A
02474  7640          SZA CLA         /IS IT A VARIABLE
02475  5304          JMP     RUNNOT  /NO
02476  2060          ISZ     EPTR
02477  1460          TAD I   EPTR
02500  3062          DCA     GPTR
02501  1462          TAD I   GPTR
02502  3460          DCA I   EPTR
02503  7410          SKP
02504  2060  RUNNOT, ISZ     EPTR
02505  2060          ISZ     EPTR
02506  2060          ISZ     EPTR
02507  2060          ISZ     EPTR
02510  2061  RUNIN,  ISZ     FPTR
02511  5272          JMP     RUNLUP
02512  1366          TAD     PLIMIT
02513  3003          DCA     ARRLOC
02514  1052          TAD     PSYMTAB
02515  3060          DCA     EPTR
02516  1053          TAD     NSYMTAB
02517  3061          DCA     FPTR
02520  5350          JMP     RUN2IN
02521  1460  RUN2LUP,TAD I   EPTR
02522  1365          TAD     O7000A
02523  7640          SZA CLA         /IS IT A VARIABLE
02524  5344          JMP     RUN2NOT /NO
02525  2060          ISZ     EPTR
02526  1460          TAD I   EPTR
02527  3031          DCA     TMP
02530  1003          TAD     ARRLOC
02531  3460          DCA I   EPTR
02532  1031          TAD     TMP
02533  4523          JMS I   PSTICKIT
02534  4523          JMS I   PSTICKIT
02535  4523          JMS I   PSTICKIT
02536  4523          JMS I   PSTICKIT
02537  2060          ISZ     EPTR
02540  3460          DCA I   EPTR
02541  2060          ISZ     EPTR
02542  3460          DCA I   EPTR
02543  5347          JMP     .+4
02544  2060  RUN2NOT,ISZ     EPTR
02545  2060          ISZ     EPTR
02546  2060          ISZ     EPTR
02547  2060          ISZ     EPTR
02550  2061  RUN2IN, ISZ     FPTR

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 20-1

02551  5321          JMP     RUN2LUP
02552  1004          TAD     CODELOC
02553  3045          DCA     LOCCTR
02554  1127          TAD     PPDLIST
02555  3036          DCA     PDL
02556  1004          TAD     CODELOC
02557  3046          DCA     READLOC
02560  7240          CLA CMA
02561  3065          DCA     FORCT
02562  1162          TAD     PGOLIST
02563  3163          DCA     GSBPTR
02564  5664          JMP I   CLEARV
02565  7000  O7000A, 7000
02566  1600  PLIMIT, LIMIT           /FIRST WORD OF USER AREA
02567  5305  PXXTHEN,XXTHEN
02570  3600  PLIST,  LIST
02571  5541  PXXEOF, XXEOF
02572  5111  PPERMSY,PERMSYM
02573  1776  PNOTNOW,NOTNOW
02574  4501  OCASERR,        JMS I   PERROR
02575  1725          TEXT 'OUT'      /OUTPUT ERROR ON CASSETTE
02576  2400


/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 21


       2577          *2577

02577  4557  GETLRET,JMS I   PLINFIX
02600  4541          JMS I   CNCLR           /CHECK TO SEE IF ^C WAS TYPED WHILE HERE.
02601  5602          JMP I   GETLIN
02602  0000  GETLIN, 0
02603  3066          DCA     SNUMFLG
02604  1133          TAD     OUTDEV          /GET THE OUTPUT DEVICE.
02605  3132          DCA     OUTD2           /SAVE FOR A SECOND.
02606  7344  NEWLIN, CLA CLL CMA RAL         /CHECK THE INPUT DEVICE NOW.
02607  1131          TAD     INDEV           /GET IT, BABY.
02610  7700  O7700,  SMA CLA                 /IS IT THE TTY?
02611  5214          JMP     .+3             /NOPE.
02612  4534          JMS I   CNTLOZ          /IT IS. RESET CONTROL O.
02613  7201          CLA IAC                 /AND TEMPORARILY SET THE OUTPUT TO THE TTY.
02614  3133          DCA     OUTDEV          /(TURN OFF OUT DEV.)
02615  1170          TAD     PLBEGIN
02616  3060          DCA     EPTR
02617  1377          TAD     O40
02620  3460          DCA I   EPTR
02621  2060          ISZ     EPTR
02622  4432  NEWCHAR,JMS I   PGETCH
02623  3460          DCA I   EPTR
02624  1460          TAD I   EPTR
02625  1374          TAD     O7603
02626  7450          SNA             /IS IT ALT-MODE (175)
02627  5261          JMP     ALTMODE /YES
02630  1371          TAD     O36
02631  7450          SNA             /IS IT '_'
02632  5773          JMP I   PBARROW /YES
02633  1372          TAD     O122
02634  7450          SNA             /IS IT (CAR. RET.)
02635  5264          JMP     CARRET  /YES
02636  1375          TAD     O7715
02637  7450          SNA             /IS IT '@'
02640  5222          JMP     NEWCHAR /YES
02641  0345          AND     O140B
02642  7440          SZA
02643  1365          TAD     O7640B
02644  7640          SZA CLA         /IS IT A PRINTABLE CHARACTER
02645  5513          JMP I   CTRZCK  /NO-MAKE SPECIAL ^Z CHECK
02646  1133          TAD     OUTDEV  /DON'T CALL OUTPUT ROUTINE IF INPUT
02647  7650          SNA     CLA     /IS FROM CASSETTE (OUTDEV=0)
02650  5253          JMP     .+3
02651  1460          TAD I   EPTR
02652  4433          JMS I   PPUTCH
02653  1060          TAD     EPTR
02654  1172          TAD     MLEND
02655  7640          SZA CLA
02656  5221          JMP     NEWCHAR-1
02657  5660          JMP I   .+1
02660  1173          TUBIG
02661  4516  ALTMODE,        JMS I   PPRINTXT
02662  6501          DELETED

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 21-1

02663  5206          JMP     NEWLIN
02664  1133  CARRET, TAD     OUTDEV  /DON'T PRINT IF OUTDEV=0
02665  7650          SNA     CLA     /COLUMN POINTER WILL BE SCREWED
02666  5271          JMP     .+3     /UP
02667  1174          TAD     O215
02670  4433          JMS I   PPUTCH
02671  1170          TAD     PLBEGIN /EPTR=BEGINNING OF STRING
02672  3060          DCA     EPTR    /FPTR=WHERE TRANSLATED SYMBOL GOES
02673  1037          TAD     PLINBUF /GPRE=CHAR IN STRING(.GE. EPTR)
02674  3061          DCA     FPTR    /HPTR=POSITION IN TABLE
02675  1376  SLOOP,  TAD     PTABLE
02676  3063          DCA     HPTR
02677  1460  HLOOP,  TAD I   EPTR    /AN RL'ISM TO SPEED UP THE SEARCH
02700  1056          TAD     O7740
02701  7440          SZA
02702  5305          JMP     .+3
02703  2060          ISZ     EPTR
02704  5277          JMP     HLOOP
02705  7102          CLL BSW
02706  0210          AND     O7700
02707  7041          CMA     IAC
02710  3031          DCA     TMP
02711  1060  GLOOP,  TAD     EPTR
02712  3062          DCA     GPTR
02713  1463          TAD I   HPTR
02714  7650          SNA CLA
02715  5377          JMP     O40     /GO FALL THROUGH PAGE TO OTHER!!!!!!!!!
02716  1063          TAD     HPTR
02717  3050          DCA     WORD
02720  2063          ISZ     HPTR
02721  7330          CLA CLL CML RAR
02722  1463          TAD I   HPTR
02723  0210          AND     O7700
02724  7440          SZA
02725  1031          TAD     TMP
02726  7640          SZA     CLA
02727  5362          JMP     SKPSYM
02730  3024          DCA     ACS
02731  1462  HLOP1,  TAD I   GPTR    /IGNORE BLANKS
02732  1056          TAD     O7740
02733  7650          SNA     CLA
02734  5357          JMP     NEXTG
02735  7330  BSKIP,  CLA CLL CML RAR
02736  1024          TAD     ACS
02737  3024          DCA     ACS
02740  1463          TAD I   HPTR
02741  7430          SZL
02742  2063          ISZ     HPTR
02743  7420          SNL
02744  7002          BSW
02745  0140  O140B,  AND     O77
02746  7450          SNA
02747  5770          JMP I   JMATCH
02750  1056          TAD     O7740
02751  7450          SNA

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 21-2

02752  5335          JMP     BSKIP
02753  0140          AND     O77
02754  1377          TAD     O40
02755  7041          CIA
02756  1462          TAD I   GPTR
02757  2062  NEXTG,  ISZ     GPTR
02760  7650          SNA CLA
02761  5331          JMP     HLOP1
02762  1463  SKPSYM, TAD I   HPTR
02763  0140          AND     O77
02764  2063          ISZ     HPTR
02765  7640  O7640B, SZA CLA
02766  5362          JMP     .-4
02767  5311          JMP     GLOOP
02770  6506  JMATCH, AMATCH
02771  0036  O36,    36
02772  0122  O122,   122
02773  0764  PBARROW, BARROW
02774  7603  O7603,  7603
02775  7715  O7715,  7715
02776  5112  PTABLE, XXPLUS
       2777          *2777   /MUST BE LAST LOC OF PAGE-JUMP HERE AND
                             /FALL THROUGH TO OTHER!!!!!!!!
02777  0040  O40,    40




/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 22


             /"OTHER" MUST BE FIRST LOC. OF PAGE---FALL THROUGH PAGE BOUNDARY
             /TO HERE!!!!!!!!!!!!!
       3000  *3000
03000  4304  OTHER,  JMS     NONBLNK /MUST BE FIRST LOC OF PAGE
03001  1276          TAD     O7763B
03002  7440          SZA
03003  5223          JMP     NOTCR
03004  1317          TAD     PXXCRLF
03005  3461          DCA I   FPTR
03006  1061          TAD     FPTR
03007  3014          DCA     INDEX1
03010  1320          TAD     PXXEXIT
03011  3414          DCA I   INDEX1
03012  1014          TAD     INDEX1
03013  1041          TAD     MENDLIN
03014  7450          SNA
03015  5622          JMP I   PGETLRET
03016  7710          SPA CLA
03017  5210          JMP     .-7
03020  5621          JMP I   PTUBIG
03021  1173  PTUBIG, TUBIG
03022  2577  PGETLRE,GETLRET
03023  1316  NOTCR,  TAD     O7737
03024  7450          SNA
03025  5376          JMP     DIGIT
03026  1277          TAD     O7764B
03027  7100          CLL
03030  1067          TAD     O12
03031  7430          SZL
03032  5376          JMP     DIGIT
03033  1275          TAD     O7725A
03034  7100          CLL
03035  1315          TAD     O32
03036  7430          SZL
03037  5700          JMP I   PLETTER
03040  7330          CLA CLL CML RAR
03041  1460          TAD I   EPTR
03042  3460          DCA I   EPTR
03043  1100  REMPACK,TAD     PTEXT
03044  3461          DCA I   FPTR
03045  2061          ISZ     FPTR
03046  7421  TXTPAK, MQL             /FLIP TO MQ
03047  1460          TAD I   EPTR
03050  1276          TAD     O7763B
03051  7450          SNA
03052  5273          JMP     CRINTXT
03053  1301          TAD     O7753
03054  7650          SNA CLA
03055  5362          JMP     DQINTXT
03056  1460          TAD I   EPTR
03057  0140          AND     O77
03060  7521          SWP
03061  7450          SNA
03062  5267          JMP     LHALF

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 22-1

03063  7501          MQA
03064  3461          DCA I   FPTR
03065  2061          ISZ     FPTR
03066  5271          JMP     RHALF
03067  7501  LHALF,  MQA
03070  7102          CLL BSW
03071  2060  RHALF,  ISZ     EPTR
03072  5246          JMP     TXTPAK
03073  7501  CRINTXT,        MQA
03074  5373          JMP     MTXXIT
03075  7725  O7725A, 7725
03076  7763  O7763B, 7763
03077  7764  O7764B, 7764
03100  3445  PLETTER,LETTER
03101  7753  O7753,  7753
03102  4200  O4200,  4200
03103  0042  O42,    42
03104  0000  NONBLNK,0
03105  1460          TAD I   EPTR
03106  1056          TAD     O7740
03107  7640          SZA CLA
03110  5313          JMP     .+3
03111  2060          ISZ     EPTR
03112  5305          JMP     NONBLNK+1
03113  1460          TAD I   EPTR
03114  5704          JMP I   NONBLNK
03115  0032  O32,    32
03116  7737  O7737,  7737
03117  5256  PXXCRLF,XXCRLF
03120  5544  PXXEXIT,XXEXIT
03121  0074  POPERA, OPERAND-1
03122  5545  PXXLIT0,XXLIT0
03123  4435  LITRAL, FENTER
03124  2075          FST     OPERAND
03125  0000          FEXIT
03126  1077          TAD     OPERAND+2
03127  7640          SZA CLA
03130  5340          JMP     ALL3
03131  1076          TAD     OPERAND+1
03132  7640          SZA CLA
03133  5341          JMP     JUST2
03134  1075          TAD     OPERAND
03135  7650          SNA CLA
03136  5342          JMP     JUST0
03137  7344  JUST1,  CLA CLL CMA RAL
03140  7001  ALL3,   IAC
03141  1064  JUST2,  TAD     O2
03142  7040  JUST0,  CMA
03143  3031          DCA     TMP

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 23


03144  1321          TAD     POPERA
03145  3014          DCA     INDEX1
03146  1031          TAD     TMP
03147  7040          CMA
03150  1322          TAD     PXXLIT0
03151  5355          JMP     JUST0P
03152  6201  JUST0F, CDF     0               /'''''''''''' 8 K INSERT.
03153  1414          TAD I   INDEX1
03154  6211          CDF     10              /'''''''''''' 8  K INSERT.
03155  3461  JUST0P, DCA I   FPTR
03156  2061          ISZ     FPTR
03157  2031          ISZ     TMP
03160  5352          JMP     JUST0F
03161  5520          JMP I   PSLOOP


03162  7501  DQINTXT,MQA
03163  2060          ISZ     EPTR
03164  7440          SZA
03165  5370          JMP     .+3
03166  1302          TAD     O4200
03167  5373          JMP     MTXXIT
03170  1303          TAD     O42
03171  3461          DCA I   FPTR
03172  2061          ISZ     FPTR
03173  3461  MTXXIT, DCA I   FPTR
03174  2061          ISZ     FPTR
03175  5520          JMP I   PSLOOP


       3176  *3176

03176  7200  DIGIT,  CLA
03177  1466          TAD I   SNUMFLG
03200  1353          TAD     O1770
03201  7440          SZA             /IS IT 'GOTO' OR 'THEN'
03202  1156          TAD     O4
03203  7440          SZA             /OR 'GOSUB'
03204  1352          TAD     O1740
03205  7650          SNA CLA         /OR 'LIST'
03206  7240          CLA CMA         /YES
03207  3066          DCA     SNUMFLG
03210  4435          FENTER
03211  3150          FLD     ZERO
03212  0000          FEXIT
03213  7240          CLA     CMA
03214  3342          DCA     DPFLAG
03215  3343          DCA     DECFRAC
03216  5222          JMP     DIGIN1
03217  2342  ITSDP,  ISZ     DPFLAG
03220  5321          JMP     ENDNUM
03221  2060  DIGIN,  ISZ     EPTR
03222  4524  DIGIN1, JMS I   PNONBLNK
03223  1306          TAD     O7673

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 23-1

03224  7450          SNA
03225  5253          JMP     ITSE
03226  1345          TAD     O27
03227  7450          SNA
03230  5217          JMP     ITSDP
03231  1351          TAD     O7764C
03232  7100          CLL
03233  1067          TAD     O12
03234  7420          SNL
03235  5321          JMP     ENDNUM
03236  7110          CLL RAR
03237  1350          TAD     O2040A
03240  3335          DCA     FDIGIT
03241  7010          RAR
03242  3336          DCA     FDIGIT+1
03243  4435          FENTER
03244  6550          FMPI    PTEN
03245  4270          FAD+FWD+FDIGIT-.
03246  0000          FEXIT
03247  1342          TAD     DPFLAG
03250  7700          SMA CLA
03251  2343          ISZ     DECFRAC
03252  5221          JMP     DIGIN
03253  3335  ITSE,   DCA     FDIGIT
03254  1066          TAD     SNUMFLG
03255  7640          SZA CLA
03256  5321          JMP     ENDNUM
03257  2060          ISZ     EPTR
03260  4524          JMS I   PNONBLNK
03261  1346          TAD     O7725B
03262  7450          SNA
03263  5270          JMP     ITSP
03264  1347          TAD     O7776
03265  7640          SZA CLA
03266  5271          JMP     NOTSGN
03267  2335          ISZ     FDIGIT
03270  2060  ITSP,   ISZ     EPTR
03271  4744  NOTSGN, JMS I   JISDIG
03272  5321          JMP     ENDNUM
03273  2060          ISZ     EPTR
03274  3336          DCA     FDIGIT+1
03275  4744          JMS I   JISDIG
03276  5312          JMP     ONLY1
03277  7200          CLA
03300  1336          TAD     FDIGIT+1
03301  7106          CLL RTL
03302  1336          TAD     FDIGIT+1
03303  7104          CLL RAL
03304  3336          DCA     FDIGIT+1
03305  4744          JMS I   JISDIG
03306  7673  O7673,  7673
03307  1336          TAD     FDIGIT+1
03310  3336          DCA     FDIGIT+1
03311  2060          ISZ     EPTR
03312  1335  ONLY1,  TAD     FDIGIT

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 23-2

03313  7110          CLL RAR
03314  1336          TAD     FDIGIT+1
03315  7420          SNL
03316  7041          CIA
03317  1343          TAD     DECFRAC
03320  3343          DCA     DECFRAC
03321  7200  ENDNUM, CLA
03322  1343          TAD     DECFRAC
03323  7700          SMA CLA
03324  1341          TAD     DIVXTEN
03325  1340          TAD     MULXTEN
03326  3367          DCA     MULEXP
03327  1343          TAD     DECFRAC
03330  7510          SPA
03331  7041          CIA
03332  7040          CMA
03333  3343          DCA     DECFRAC
03334  5371          JMP     MULX1
03335  0000  FDIGIT, 0;0;0
03336  0000
03337  0000
03340  6550  MULXTEN,FMPI    PTEN
03341  1000  DIVXTEN,FDV-FMP
03342  0000  DPFLAG, 0
03343  0000  DECFRAC,0
03344  6532  JISDIG, ISDIG
03345  0027  O27,    27
03346  7725  O7725B, 7725
03347  7776  O7776,  7776
03350  2040  O2040A, 2040
03351  7764  O7764C, 7764
03352  1740  O1740,  1740
03353  1770  O1770,  1770
03354  3123  PLITRAL,        LITRAL
03355  4501  LERR,   JMS I   PERROR
03356  1417          TEXT 'LOOKUP'
03357  1713
03360  2520
03361  0000
03362  4501  CHNERR, JMS I   PERROR
03363  0310  CHNMS,  TEXT 'CHAIN'
03364  0111
03365  1600


       3366          *3366
03366  4435          FENTER
03367  7402  MULEXP, HLT
03370  0000          FEXIT
03371  2343  MULX1,  ISZ     DECFRAC
03372  5366          JMP     .-4
03373  2066          ISZ     SNUMFLG
03374  5754          JMP I   PLITRAL
03375  4510          JMS I   PFIX
03376  7200          CLA             /FALL THRU TO COMMON!!!!!

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 24


       3377          *3377

03377  1052  COMMON, TAD     PSYMTAB
03400  3062          DCA     GPTR
03401  1053          TAD     NSYMTAB
03402  3063          DCA     HPTR
03403  5230          JMP     IN
03404  1462  LUP,    TAD I   GPTR
03405  2062          ISZ     GPTR
03406  2062          ISZ     GPTR
03407  7640          SZA CLA         /IS IT A LINENO
03410  5226          JMP     NOT     /NO
03411  1462          TAD I   GPTR
03412  2062          ISZ     GPTR
03413  7041          CIA
03414  1017          TAD     AC2
03415  7640          SZA CLA
03416  5227          JMP     NOT+1
03417  1462          TAD I   GPTR
03420  7041          CIA
03421  1016          TAD     AC3
03422  7640          SZA CLA
03423  5227          JMP     NOT+1
03424  7346          CLA CLL CMA RTL
03425  5311          JMP     ISDEF2
03426  2062  NOT,    ISZ     GPTR
03427  2062          ISZ     GPTR
03430  2063  IN,     ISZ     HPTR
03431  5204          JMP     LUP
03432  4517          JMS I   PGETBLK
03433  3066          DCA     SNUMFLG
03434  3466          DCA I   SNUMFLG
03435  1066          TAD     SNUMFLG
03436  3014          DCA     INDEX1
03437  3414          DCA I   INDEX1
03440  1017          TAD     AC2
03441  3414          DCA I   INDEX1
03442  1016          TAD     AC3
03443  3414          DCA I   INDEX1
03444  5313          JMP     ITSDEF
03445  7001  LETTER, IAC
03446  7106          CLL RTL
03447  7006          RTL
03450  7006          RTL
03451  3031          DCA     TMP
03452  2060          ISZ     EPTR
03453  4524          JMS I   PNONBLNK
03454  1272          TAD     O7706C
03455  7100          CLL
03456  1067          TAD     O12
03457  7620          SNL CLA
03460  5265          JMP     SIMPLV
03461  1460          TAD I   EPTR
03462  1031          TAD     TMP

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 24-1

03463  3031          DCA     TMP
03464  2060          ISZ     EPTR
03465  1052  SIMPLV, TAD     PSYMTAB
03466  3062          DCA     GPTR
03467  1053          TAD     NSYMTAB
03470  3063          DCA     HPTR
03471  5323          JMP     VSCHIN
03472  7706  O7706C, 7706
03473  7000  O7000B, 7000
03474  1462  VSCHLUP,TAD I   GPTR
03475  1273          TAD     O7000B
03476  7640          SZA CLA
03477  5317          JMP     VSCHNOT
03500  2062          ISZ     GPTR
03501  1462          TAD I   GPTR
03502  3066          DCA     SNUMFLG
03503  1466          TAD I   SNUMFLG
03504  7041          CIA
03505  1031          TAD     TMP
03506  7640          SZA CLA
03507  5320          JMP     VSCHNOT+1
03510  7240          CLA CMA
03511  1062  ISDEF2, TAD     GPTR
03512  3066          DCA     SNUMFLG
03513  1066  ITSDEF, TAD     SNUMFLG
03514  3461          DCA I   FPTR
03515  2061          ISZ     FPTR
03516  5520          JMP I   PSLOOP
03517  2062  VSCHNOT,ISZ     GPTR
03520  2062          ISZ     GPTR
03521  2062          ISZ     GPTR
03522  2062          ISZ     GPTR
03523  2063  VSCHIN, ISZ     HPTR
03524  5274          JMP     VSCHLUP
03525  4517          JMS I   PGETBLK
03526  3066          DCA     SNUMFLG
03527  7240          CLA CMA
03530  1066          TAD     SNUMFLG
03531  3014          DCA     INDEX1
03532  1347          TAD     O1000
03533  3414          DCA I   INDEX1
03534  1003          TAD     ARRLOC
03535  3414          DCA I   INDEX1
03536  3414          DCA I   INDEX1
03537  3414          DCA I   INDEX1
03540  4561          JMS I   PCHKFIT
03541  1031          TAD     TMP
03542  4523          JMS I   PSTICKIT
03543  4523          JMS I   PSTICKIT
03544  4523          JMS I   PSTICKIT
03545  4523          JMS I   PSTICKIT
03546  5313          JMP     ITSDEF
03547  1000  O1000,  1000
03550  0000  PUTJ,   0
03551  4510          JMS I   PFIX

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 24-2

03552  7200          CLA
03553  1016          TAD     AC3
03554  4433          JMS I   PPUTCH
03555  4544          JMS I   PANORM
03556  5750          JMP I   PUTJ
03557  3737  TWOLF,  TEXT '__'
03560  0000
03561  3724  UGH1,   TEXT '_TOO BIG. LINE IGNORED_'
03562  1717
03563  4002
03564  1107
03565  5640
03566  1411
03567  1605
03570  4011
03571  0716
03572  1722
03573  0504
03574  3700
03575  6213  OPEN,   CDF CIF 10      /OPEN PROCESSOR IS IN FLD 1
03576  5777          JMP I   .+1
03577  1200          OPEN1


/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 25


       3600          PAGE


03600  1744  LIST,   TAD I   PXLINBUF
03601  3050          DCA     WORD
03602  4564          ISIT            /LINENO
03603  0000          0000
03604  5210          JMP     LISTALL
03605  2050          ISZ     WORD
03606  1450          TAD I   WORD
03607  7450          SNA
03610  1004  LISTALL,TAD     CODELOC
03611  3045  LISTSOM,DCA     LOCCTR
03612  4565  LISTLUP, GET+ISIT               /(EOF)
03613  1755          1755
03614  5226          JMP     LNOEND          /NOT DUNE YET
03615  1133          TAD     OUTDEV  /OUTPUT A CHAR. DEPENDING ON DEVICE
03616  1377          TAD     (TAD TABL-1     /TTY:NULL,CASSETTE:CTRL/Z,LPT:FORMFEED
03617  3220          DCA     .+1
03620  0000          0
03621  4433          JMS I   PPUTCH
03622  4537          JMS I   PCOWT           /WAIT FOR I/O TO FINISH AND CLEAN UP.
03623  4302          JMS     PRINTXT
03624  3557          TWOLF
03625  5776          JMP I   PSTOP
03626  4564  LNOEND, ISIT            /A LINENO
03627  0000          0000
03630  5236          JMP     LIST2   /NO
03631  1050          TAD     WORD
03632  4525          JMS I   PPRINUM
03633  1051          TAD     O240
03634  4433          JMS I   PPUTCH
03635  5212          JMP     LISTLUP
03636  4564  LIST2,  ISIT            /A VARIABLE
03637  7000          7000
03640  5255          JMP     LIST3
03641  2050          ISZ     WORD
03642  1450          TAD I   WORD
03643  3050          DCA     WORD
03644  1450          TAD I   WORD
03645  3251          DCA     PRINVAR
03646  4302          JMS     PRINTXT
03647  3651          PRINVAR
03650  5212          JMP     LISTLUP
03651  0000  PRINVAR,0
03652  0000  TABL,   0       /NULL FOR TTY:-(ZERO MUST FOLLOW PRINVAR!!!)
03653  0232          232             /CTRL/Z FOR END OF FILE ON CASSETTE
03654  0214          214             /FORM FEED FOR LPT
03655  4573  LIST3,  JMS I   PISITLIT /ISIT A LITERAL
03656  5261          JMP     LIST4   /NO
03657  4521          JMS I   POUTNUM /PRINT IT
03660  5212          JMP     LISTLUP
03661  4564  LIST4,  ISIT            /(TEXT)
03662  5000          5000

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 25-1

03663  5276          JMP     LIST5
03664  4177  L4LUP,  JMS     GETWD
03665  1050          TAD     WORD
03666  3251          DCA     PRINVAR
03667  4302          JMS     PRINTXT
03670  3651          PRINVAR
03671  1050          TAD     WORD
03672  0140          AND     O77
03673  7640          SZA CLA
03674  5264          JMP     L4LUP
03675  5212          JMP     LISTLUP
03676  1050  LIST5,  TAD     WORD    /ITS A SYSTEM SYMBOL
03677  7001          IAC
03700  4302          JMS     PRINTXT

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 26


03701  5212          JMP     LISTLUP
03702  0000  PRINTXT,0
03703  7440          SZA
03704  5310          JMP     JBPENT+1        /'''''''''''' 8 K INSERT.
03705  6201          CDF     0               /'''''''''''' 8 K INSERT.
03706  1702          TAD I   PRINTXT
03707  2302  JBPENT, ISZ     PRINTXT
03710  3042          DCA     PRTEMP
03711  1442  PRLOOP, TAD I   PRTEMP
03712  7002          BSW
03713  4322          JMS     PRSUBR
03714  1442          TAD I   PRTEMP
03715  4322          JMS     PRSUBR
03716  2042          ISZ     PRTEMP
03717  5311          JMP     PRLOOP
03720  6211  PRTXRET,CDF     10              /'''''''' 8 K INSERT.
03721  5702          JMP I   PRINTXT
03722  0000  PRSUBR, 0
03723  0140          AND     O77
03724  7450          SNA
03725  5320          JMP     PRTXRET
03726  1343          TAD     O7741
03727  7450          SNA
03730  5336          JMP     CRLFPR
03731  1140          TAD     O77
03732  0140          AND     O77
03733  1051          TAD     O240
03734  4433          JMS I   PPUTCH
03735  5722          JMP I   PRSUBR
03736  1174  CRLFPR, TAD     O215
03737  4433          JMS I   PPUTCH
03740  1175          TAD     O212
03741  4433          JMS I   PPUTCH
03742  5722          JMP I   PRSUBR
03743  7741  O7741,  7741
03744  5552  PXLINBU,LINBUF+1
03745  0000  PRINUM, 0
03746  7001          IAC
03747  3014          DCA     INDEX1
03750  4360          JMS     BEGFIX          /SET UP FAC TO RECEIVE INTEGER DATA.
03751  1414          TAD I   INDEX1
03752  3017          DCA     AC2
03753  1414          TAD I   INDEX1
03754  3016          DCA     AC3
03755  4544          JMS I   PANORM
03756  4521          JMS I   POUTNUM
03757  5745          JMP I   PRINUM




03760  0000  BEGFIX, 0                       /SETS UP FOR INTEGER TO AC MODE.
03761  3017          DCA     AC2             /CLEAR THEM ALL, EXCEPT FOR LOW WORD.
03762  3020          DCA     AC1

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 26-1

03763  3013          DCA     OV
03764  3024          DCA     ACS
03765  1370          TAD     O233
03766  3025          DCA     ACE
03767  5760          JMP I   BEGFIX

03770  0233  O233,   233


03771  4567  RESTORE,GET+MUSTBE      /(CR) OR '\'
03772  2000          2000
03773  1004          TAD     CODELOC
03774  3046          DCA     READLOC
03775  5505          JMP I   PEXECUTE



03776  2401  PSTOP,  STOP

03777  1251
       4000  PAGE

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 27




04000  4564  MOREIN, ISIT            /(CR) OR '\'
04001  2000          2000
04002  5234          JMP     INPLUP
04003  1175          TAD     O212
04004  4433          JMS I   PPUTCH
04005  1132          TAD     OUTD2           /GET THE OLD OUTPUT DEVICE.
04006  3133          DCA     OUTDEV          /AND RESET IT.
04007  7240  INPUT,  CLA CMA                 /CHECK THE INPUT DEVICE NOW.
04010  1131          TAD     INDEV           /ARE WE INPUT FROM THE TELETYPE.
04011  7640          SZA CLA
04012  5224          JMP     IPNOPE          /NOPE.
04013  1133          TAD     OUTDEV          /GET THE OUTPUT DEVICE.
04014  4506          JMS I   PPUSH           /SAVE IT FOR A SECOND.
04015  7201          CLA IAC                 /SET OUTPUT DEVICE TO TTY FOR "?"
04016  3133          DCA     OUTDEV
04017  4537          JMS I   PCOWT           /WAIT FOR OUTPUT TO FINISH, THEN CONTINUE.
04020  1140          TAD     O77
04021  4433          JMS I   PPUTCH
04022  4507          JMS I   PPOP            /RESET OUTPUT DEVICE NOW.
04023  3133          DCA     OUTDEV
04024  1045  IPNOPE, TAD     LOCCTR
04025  3563          DCA I   GSBPTR
04026  1100          TAD     PTEXT
04027  4526          JMS I   PGETLIN
04030  1563          TAD I   GSBPTR
04031  3045          DCA     LOCCTR
04032  1037          TAD     PLINBUF
04033  3276          DCA     INPPTR
04034  4515  INPLUP, JMS I   PGETVAR
04035  1050          TAD     WORD
04036  3336          DCA     INWDTMP
04037  1045          TAD     LOCCTR
04040  3277          DCA     INLCTMP
04041  1276          TAD     INPPTR
04042  3045          DCA     LOCCTR
04043  4503          JMS I   PEVAL
04044  7240          CLA     CMA
04045  1131          TAD     INDEV
04046  7650          SNA     CLA
04047  5256          JMP     NOCR
04050  4564          ISIT
04051  3763          3763
04052  5256          JMP     NOCR
04053  4565          GET+ISIT
04054  2000          2000
04055  7240          CLA     CMA
04056  1045  NOCR,   TAD     LOCCTR
04057  3276          DCA     INPPTR
04060  1277          TAD     INLCTMP
04061  3045          DCA     LOCCTR
04062  4514          JMS I   PSTOVAR
04063  7332          CLA CLL CML RTR

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 27-1

04064  1736          TAD I   INWDTMP
04065  7640          SZA CLA
04066  5200          JMP     MOREIN
04067  1175          TAD     O212
04070  4433          JMS I   PPUTCH
04071  1132          TAD     OUTD2           /RESET THE DEV, BABY
04072  3133          DCA     OUTDEV
04073  7201          CLA     IAC     /RESET INPUT TO TTY
04074  3131          DCA     INDEV 
04075  5505          JMP I   PEXECUTE
04076  0000  INPPTR, 0
04077  0000  INLCTMP,0

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 28



04100  0000  ISITLIT,0
04101  1450          TAD I   WORD
04102  7146          CLL CMA RTL
04103  7032          CML RTR
04104  3024          DCA     ACS
04105  1024          TAD     ACS
04106  1156          TAD     O4
04107  7620          SNL CLA
04110  5700          JMP I   ISITLIT
04111  2300          ISZ     ISITLIT
04112  3020          DCA     AC1
04113  3017          DCA     AC2
04114  3016          DCA     AC3
04115  4327          JMS     ISLIT
04116  3016          DCA     AC3
04117  4327          JMS     ISLIT
04120  3017          DCA     AC2
04121  4327          JMS     ISLIT
04122  3020          DCA     AC1
04123  4435  LOADED, FENTER
04124  3016          FLD     AC3
04125  0000          FEXIT
04126  5700          JMP I   ISITLIT
04127  0000  ISLIT,  0
04130  2024          ISZ     ACS
04131  7410          SKP
04132  5323          JMP     LOADED
04133  4177          JMS     GETWD
04134  1050          TAD     WORD
04135  5727          JMP I   ISLIT
04136  0000  ERROR,  0
       4136  INWDTMP=ERROR
04137  6213          CDF CIF 10      /CLOSE RUNTIME OUTPUT FILE IF ONE WAS OPEN
04140  4543          JMS I   PCLOS
04141  4536          JMS I   PRESET          /RESET ALL I/O DEVICES.
04142  4516          JMS I   PPRINTXT
04143  6531          CRLF
04144  1336          TAD     ERROR
04145  3347          DCA     .+2
04146  4516          JMS I   PPRINTXT
04147  7402          HLT
04150  4516          JMS I   PPRINTXT
04151  1571          QERROR
04152  1454          TAD I   LINENO
04153  7710          SPA CLA
04154  5361          JMP     .+5
04155  4516          JMS I   PPRINTXT
04156  6451          ATLINE
04157  1054          TAD     LINENO
04160  4525          JMS I   PPRINUM
04161  4516          JMS I   PPRINTXT
04162  6531          CRLF
04163  1127  HLP,    TAD     PPDLIST

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 28-1

04164  3036          DCA     PDL
04165  5522          JMP I   PEDIT

04166  0000  POP,    0
04167  7240          CLA CMA
04170  1036          TAD     PDL
04171  3036          DCA     PDL
04172  1436          TAD I   PDL
04173  5766          JMP I   POP

04174  1060  CKCTRZ, TAD     EPTR    /SPECIAL ^Z CHECK FOR RUNTIME INPUT
04175  6213          CDF CIF 10      /GO TO FIELD 1
04176  5777          JMP I   .+1
04177  0052          CTRZHP

       4200          PAGE




                     /       JMS     FPT     /ENTER FLOATING POINT PACK
                     /       0000            /FEXIT
                     /       0040            /FSNE
                     /       0050            /FSEQ
                     /       0100            /FSGE
                     /       0110            /FSLT
                     /       0140            /FSGT
                     /       0150            /FSLE
                     /               IF BIT 4 OFF THEN SAME AS PDP-8
                     /               IF BIT 4 ON THEN IF BIT 3 OFF THEN RELATIVE PLUS
                     /                                IF BIT 3 ON THEN RELATIVE MINUS
                     /       1XXX            /FJMP
                     /       2XXX            /FST
                     /       3XXX            /FLD
                     /       4XXX            /FAD
                     /       5XXX            /FSB
                     /       6XXX            /FMP
                     /       7XXX            /FDV
04200  0000  FPT,    0
04201  5204          JMP     .+3
04202  4544  FPLOOP, JMS I   PANORM
04203  2200          ISZ     FPT
04204  6201          CDF     0               /'''''''' 8 K INSERT.
04205  1600          TAD I   FPT
04206  7006          RTL
04207  7006          RTL
04210  0074          AND     O7
04211  7450          SNA
04212  5305          JMP     FPOPER
04213  3273          DCA     FPGOTO
04214  1600          TAD I   FPT
04215  0153          AND     O200
04216  7650          SNA CLA
04217  5227          JMP     FPPGZ
04220  1600          TAD I   FPT

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 28-2

04221  0027          AND     O177
04222  7430          SZL
04223  7041          CIA
04224  1200          TAD     FPT
04225  3304          DCA     FPADDR
04226  5237          JMP     FPDOIT
04227  1600  FPPGZ,  TAD I   FPT
04230  0027          AND     O177
04231  3304          DCA     FPADDR
04232  7420          SNL
04233  5237          JMP     FPDOIT
04234  1704          TAD I   FPADDR
04235  3304          DCA     FPADDR
04236  6211          CDF     10              /'''''''' 8 K INSERT.
04237  7346  FPDOIT, CLA CLL CMA RTL
04240  1273          TAD     FPGOTO
04241  7710          SPA CLA
04242  5270          JMP     FPNOADR
04243  7330          CLA CLL CML RAR
04244  0704          AND I   FPADDR
04245  3026          DCA     OPS
04246  1704          TAD I   FPADDR
04247  7640          SZA CLA
04250  7040          CMA
04251  3154          DCA     FPFLAG
04252  1704          TAD I   FPADDR
04253  7012          RTR
04254  7010          RAR
04255  0073          AND     O377
04256  3030          DCA     OPE
04257  1704          TAD I   FPADDR
04260  0074          AND     O7
04261  3023          DCA     OP1
04262  2304          ISZ     FPADDR
04263  1704          TAD I   FPADDR
04264  3022          DCA     OP2
04265  2304          ISZ     FPADDR
04266  1704          TAD I   FPADDR
04267  3021          DCA     OP3
04270  1273  FPNOADR,TAD     FPGOTO
04271  1274          TAD     FPJUMP
04272  3273          DCA     .+1
04273  7402  FPGOTO, HLT
04274  5674  FPJUMP, JMP I   .
04275  4317          FPJMP
04276  4322          FPSTO
04277  4351          FPLAC
04300  4456          FPADD
04301  4453          FPSUB
04302  4530          FPMUL
04303  4667          FPDIV
04304  0000  FPADDR, 0
04305  1600  FPOPER, TAD I   FPT
04306  6211          CDF     10              /''''''''''' 8 K INSERT.
04307  7450          SNA

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 28-3

04310  5600          JMP I   FPT
04311  1345          TAD     O7600
04312  3314          DCA     FPSKIP
04313  4333          JMS     HIGHWD
04314  7402  FPSKIP, HLT
04315  2200          ISZ     FPT
04316  5203          JMP     FPLOOP+1
04317  1304  FPJMP,  TAD     FPADDR
04320  3200          DCA     FPT
04321  5204          JMP     FPLOOP+2
04322  4333  FPSTO,  JMS     HIGHWD
04323  3704          DCA I   FPADDR
04324  2304          ISZ     FPADDR
04325  1017          TAD     AC2
04326  3704          DCA I   FPADDR
04327  2304          ISZ     FPADDR
04330  1016          TAD     AC3
04331  3704          DCA I   FPADDR
04332  5203          JMP     FPLOOP+1
04333  0000  HIGHWD, 0
04334  1025          TAD     ACE
04335  7104          CLL RAL
04336  7500          SMA

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 29


04337  7106          CLL RTL
04340  7530          SPA SZL
04341  5345          JMP     O7600
04342  1024          TAD     ACS
04343  1020          TAD     AC1
04344  5733          JMP I   HIGHWD
04345  7600  O7600,  7600
04346  1073          TAD     O377
04347  3025          DCA     ACE
04350  5334          JMP     HIGHWD+1
04351  1026  FPLAC,  TAD     OPS
04352  3024          DCA     ACS
04353  1030          TAD     OPE
04354  3025          DCA     ACE
04355  1023          TAD     OP1
04356  3020          DCA     AC1
04357  1022          TAD     OP2
04360  3017          DCA     AC2
04361  1021          TAD     OP3
04362  3016          DCA     AC3
04363  3013          DCA     OV
04364  5202          JMP     FPLOOP
04365  7041  UPARR2, CIA             /(CMA) IF 1 ORG INDEXING
04366  3014          DCA     INDEX1
04367  4435          FENTER
04370  3147          FLD     ONE
04371  0000          FEXIT
04372  5376          JMP     .+4
04373  4435          FENTER
04374  6075          FMP     OPERAND
04375  0000          FEXIT
04376  2014          ISZ     INDEX1
04377  5373          JMP     .-4
04400  5601          JMP I   .+1
04401  1203          OPDONE





04402  0000  AR1,    0
04403  1020          TAD     AC1
04404  7110          CLL RAR
04405  3020          DCA     AC1
04406  1017          TAD     AC2
04407  7010          RAR
04410  3017          DCA     AC2
04411  1016          TAD     AC3
04412  7010          RAR
04413  3016          DCA     AC3
04414  7010          RAR
04415  3013          DCA     OV
04416  5602          JMP I   AR1
04417  0000  ACN,    0

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 29-1

04420  1234          TAD     POP3
04421  3235          DCA     OADD
04422  7346          CLA CLL CMA RTL
04423  3202          DCA     AR1
04424  7024          CML RAL
04425  1635          TAD I   OADD
04426  7041          CIA
04427  3635          DCA I   OADD
04430  2235          ISZ     OADD
04431  2202          ISZ     AR1
04432  5224          JMP     .-6
04433  5617          JMP I   ACN
04434  0021  POP3,   OP3
04435  0000  OADD,   0
04436  7100          CLL
04437  1016          TAD     AC3
04440  1021          TAD     OP3
04441  3016          DCA     AC3
04442  7004          RAL
04443  1017          TAD     AC2
04444  1022          TAD     OP2
04445  3017          DCA     AC2
04446  7004          RAL
04447  1020          TAD     AC1
04450  1023          TAD     OP1
04451  3020          DCA     AC1
04452  5635          JMP I   OADD
04453  7330  FPSUB,  CLA CLL CML RAR
04454  1026          TAD     OPS
04455  3026          DCA     OPS
04456  2154  FPADD,  ISZ     FPFLAG
04457  5326          JMP     EOFAD
04460  1025          TAD     ACE
04461  7141          CLL CIA
04462  1030          TAD     OPE
04463  7430          SZL
04464  5302          JMP     BCKWDS
04465  3235          DCA     OADD
04466  1023  ALGNLP, TAD     OP1
04467  7110          CLL RAR
04470  3023          DCA     OP1
04471  1022          TAD     OP2
04472  7010          RAR
04473  3022          DCA     OP2
04474  1021          TAD     OP3
04475  7010          RAR
04476  3021          DCA     OP3
04477  2235          ISZ     OADD
04500  5266          JMP     ALGNLP
04501  5312          JMP     SETSGN
04502  7040  BCKWDS, CMA
04503  3235          DCA     OADD
04504  1030          TAD     OPE
04505  3025          DCA     ACE
04506  7410          SKP

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 29-2

04507  4202          JMS     AR1
04510  2235          ISZ     OADD
04511  5307          JMP     .-2
04512  1024  SETSGN, TAD     ACS
04513  1026          TAD     OPS
04514  7710          SPA CLA
04515  4217          JMS     ACN
04516  4235          JMS     OADD
04517  1020          TAD     AC1
04520  7700          SMA CLA
04521  5326          JMP     EOFAD
04522  7346          CLA CLL CMA RTL
04523  4217          JMS     ACN
04524  1026          TAD     OPS
04525  3024          DCA     ACS
04526  3013  EOFAD,  DCA     OV
04527  5775          JMP I   PFPLOOP
04530  2154  FPMUL,  ISZ     FPFLAG
04531  5371          JMP     MULCLR
04532  1024          TAD     ACS
04533  1026          TAD     OPS
04534  3024          DCA     ACS
04535  1025          TAD     ACE
04536  1030          TAD     OPE
04537  1377          TAD     O7577
04540  3025          DCA     ACE
04541  1020          TAD     AC1
04542  3026          DCA     OPS
04543  1017          TAD     AC2
04544  3030          DCA     OPE
04545  1016          TAD     AC3
04546  3031          DCA     TMP
04547  3020          DCA     AC1
04550  1160          TAD     O7745
04551  3376          DCA     FPTEMP
04552  4202  MPYLUP, JMS     AR1
04553  1026          TAD     OPS
04554  7010          RAR
04555  3026          DCA     OPS
04556  1030          TAD     OPE
04557  7010          RAR
04560  3030          DCA     OPE
04561  1031          TAD     TMP
04562  7010          RAR
04563  3031          DCA     TMP
04564  7430          SZL
04565  4235          JMS     OADD
04566  2376          ISZ     FPTEMP
04567  5352          JMP     MPYLUP
04570  5775          JMP I   PFPLOOP
04571  7346  MULCLR, CLA CLL CMA RTL
04572  3025          DCA     ACE
04573  3020          DCA     AC1
04574  5775          JMP I   PFPLOOP
04575  4202  PFPLOOP,FPLOOP

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 29-3

04576  0000  FPTEMP, 0
04577  7577  O7577,  7577







       4600          PAGE



04600  0000  ANORM,  0
04601  1020          TAD     AC1
04602  7450          SNA                     /IS HIGH WORD ZERO?
04603  5212          JMP     MAYZERO         /YEP. ENTIRE NUMBER MAY BE ZERO.
04604  1057          TAD     O7770
04605  7710          SPA CLA
04606  5220          JMP     NOTBIG
04607  4545          JMS I   PAR1
04610  2025          ISZ     ACE
04611  5201          JMP     ANORM+1

04612  1017  MAYZERO,TAD     AC2             /IS SECOND WORD ZERO?
04613  7640          SZA CLA
04614  5220          JMP     NOTBIG          /NOPE. NORMAL NORMALIZE.
04615  1016          TAD     AC3             /1 & 2 ARE ZERO. IS THIRD WORD?
04616  7650          SNA CLA
04617  5245          JMP     UNDERF          /YEP. CLEAR AC. ALL ZERO.

04620  1013  NOTBIG, TAD     OV
04621  7650          SNA CLA
04622  5233          JMP     NOBUMP
04623  2016          ISZ     AC3
04624  5233          JMP     NOBUMP
04625  2017          ISZ     AC2
04626  5233          JMP     NOBUMP
04627  2020          ISZ     AC1
04630  3013          DCA     OV
04631  5201          JMP     ANORM+1
04632  7240          CLA CMA
04633  1025  NOBUMP, TAD     ACE
04634  7510          SPA
04635  5245          JMP     UNDERF
04636  3025          DCA     ACE
04637  7346          CLA CLL CMA RTL
04640  1020          TAD     AC1
04641  7740          SMA SZA CLA
04642  5600          JMP I   ANORM
04643  4254          JMS     AL1
04644  5232          JMP     NOBUMP-1
04645  7200  UNDERF, CLA
04646  3024          DCA     ACS
04647  3025          DCA     ACE

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 29-4

04650  3020          DCA     AC1
04651  3017          DCA     AC2
04652  3016          DCA     AC3
04653  5600          JMP I   ANORM
04654  0000  AL1,    0
04655  1016          TAD     AC3
04656  7104          CLL RAL
04657  3016          DCA     AC3
04660  1017          TAD     AC2
04661  7004          RAL
04662  3017          DCA     AC2
04663  1020          TAD     AC1
04664  7004          RAL
04665  3020          DCA     AC1
04666  5654          JMP I   AL1
04667  6201  FPDIV,  CDF     0               /''''''''''''''''''' 8 K INSERT.
04670  2154          ISZ     FPFLAG
04671  5336          JMP     FPZDIV
04672  1024          TAD     ACS
04673  1026          TAD     OPS
04674  3024          DCA     ACS
04675  1030          TAD     OPE
04676  7041          CIA
04677  1025          TAD     ACE
04700  1027          TAD     O177
04701  3025          DCA     ACE
04702  3031          DCA     TMP
04703  1343          TAD     O7743
04704  3200          DCA     ANORM
04705  7330  DIVLP,  CLA CLL CML RAR
04706  0023          AND     OP1
04707  1020          TAD     AC1
04710  7700          SMA CLA
04711  4742          JMS I   PACN
04712  4555          JMS I   POADD
04713  1031          TAD     TMP
04714  7004          RAL
04715  3031          DCA     TMP
04716  1030          TAD     OPE
04717  7004          RAL
04720  3030          DCA     OPE
04721  1026          TAD     OPS
04722  7004          RAL
04723  3026          DCA     OPS
04724  4546          JMS I   PAL1
04725  2200          ISZ     ANORM
04726  5305          JMP     DIVLP
04727  1026          TAD     OPS
04730  3020          DCA     AC1
04731  1030          TAD     OPE
04732  3017          DCA     AC2
04733  1031          TAD     TMP
04734  3016          DCA     AC3
04735  5741          JMP I   PPFLOOP
04736  1073  FPZDIV, TAD     O377

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 29-5

04737  3025          DCA     ACE
04740  5741          JMP I   PPFLOOP
04741  4202  PPFLOOP,FPLOOP
04742  4417  PACN,   ACN
04743  7743  O7743,  7743
04744  0000  FIX,    0
04745  1020          TAD     AC1
04746  7650          SNA CLA
04747  5367          JMP     ZFIXEX
04750  1025  FIXLUP, TAD     ACE
04751  1377          TAD     O7545
04752  7700          SMA CLA
04753  5373          JMP     FIXEXIT
04754  4545          JMS I   PAR1
04755  1024          TAD     ACS
04756  0013          AND     OV
04757  7640          SZA CLA
04760  2016          ISZ     AC3
04761  5365          JMP     .+4
04762  2017          ISZ     AC2
04763  5365          JMP     .+2
04764  2020          ISZ     AC1
04765  2025          ISZ     ACE
04766  5350          JMP     FIXLUP
04767  3025  ZFIXEX, DCA     ACE
04770  3020          DCA     AC1
04771  3017          DCA     AC2
04772  3016          DCA     AC3
04773  3013  FIXEXIT,DCA     OV
04774  1016          TAD     AC3
04775  7001  SSFIX,  IAC             /(NOP) IF 1 ORG INDEXING
04776  5744          JMP I   FIX
04777  7545  O7545,  7545







       5000          PAGE



05000  0000  OUTNUM, 0
05001  7440          SZA             /SPECIAL CALL FOR PRINT HANDLER
05002  4433          JMS I   PPUTCH  /NON-ZERO-OUTPUT IT
05003  6201          CDF     0               /'''''''''' 8 K INSERT.
05004  1024          TAD     ACS
05005  7700          SMA CLA
05006  5211          JMP     .+3
05007  1346          TAD     O255
05010  4433          JMS I   PPUTCH
05011  1020          TAD     AC1
05012  7650          SNA     CLA

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 29-6

05013  5317          JMP     FHER
05014  4743  NONZERO,JMS I   FIXUP
05015  1352          TAD     O7771
05016  3042          DCA     PRTEMP
05017  1044          TAD     PNUMBUF
05020  3025          DCA     ACE
05021  5226          JMP     .+5
05022  1020  CVTLOOP,TAD     AC1
05023  0027          AND     O177
05024  3020          DCA     AC1
05025  4755          JMS I   PMPY
05026  1020          TAD     AC1
05027  7006          RTL
05030  7006          RTL
05031  7006          RTL
05032  0344          AND     O17
05033  1012          TAD     O260
05034  3425          DCA I   ACE
05035  2025          ISZ     ACE
05036  2042          ISZ     PRTEMP
05037  5222          JMP     CVTLOOP
05040  7326          CLA CLL CML RTL
05041  1043          TAD     DECEXP
05042  7450          SNA
05043  5323          JMP     FMT1    /.0NNNNNNN
05044  7510          SPA
05045  5251          JMP     FMT2    /N.NNNNNNE-NN
05046  1057          TAD     O7770
05047  7710          SPA CLA
05050  5326          JMP     FMT3    /OTHER THAN N.NNNNNNE+NN
05051  7200  FMT2,   CLA             /N.NNNNNNE+NN
05052  1044          TAD     PNUMBUF
05053  3025          DCA     ACE
05054  1354          TAD     O7772
05055  3042          DCA     PRTEMP
05056  1425          TAD I   ACE
05057  4433          JMS I   PPUTCH
05060  1353          TAD     O256A
05061  4433          JMS I   PPUTCH
05062  2025          ISZ     ACE
05063  1425          TAD I   ACE
05064  4433          JMS I   PPUTCH
05065  2042          ISZ     PRTEMP
05066  5262          JMP     .-4
05067  1347          TAD     O305
05070  4433          JMS I   PPUTCH
05071  1043          TAD     DECEXP
05072  7710          SPA CLA
05073  7326          CLA CLL CML RTL
05074  1345          TAD     O253
05075  4433          JMS I   PPUTCH
05076  3025          DCA     ACE
05077  1043          TAD     DECEXP
05100  7510          SPA
05101  7041          CIA

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 29-7

05102  3043          DCA     DECEXP
05103  1043          TAD     DECEXP

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 30


05104  1351          TAD     O7766
05105  7510          SPA
05106  5312          JMP     .+4
05107  3043          DCA     DECEXP
05110  2025          ISZ     ACE
05111  5303          JMP     .-6
05112  7200          CLA
05113  1025          TAD     ACE
05114  1012          TAD     O260
05115  4433          JMS I   PPUTCH
05116  1043          TAD     DECEXP
05117  1012  FHER,   TAD     O260
05120  4433          JMS I   PPUTCH
05121  6211  FMTENF, CDF     10              /'''''''''' 8 K INSERT.
05122  5600          JMP I   OUTNUM
05123  4516  FMT1,   JMS I   PPRINTXT
05124  6576          DOTZERO
05125  6201          CDF     0               /'''''''''' 8 K INSERT.
05126  1352  FMT3,   TAD     O7771
05127  3042          DCA     PRTEMP
05130  1356          TAD     PNBF6
05131  3025  TRYAGIN,DCA     ACE
05132  1425          TAD I   ACE
05133  1350          TAD     O7520
05134  7640          SZA CLA
05135  5742          JMP I   ZERDONE
05136  2042          ISZ     PRTEMP
05137  7240          CLA CMA
05140  1025          TAD     ACE
05141  5331          JMP     TRYAGIN
05142  6545  ZERDONE,        PZERDONE                /''''''' 8 K INSERT.
05143  5200  FIXUP,  FIXITUP
05144  0017  O17,    17
05145  0253  O253,   253
05146  0255  O255,   255
05147  0305  O305,   305
05150  7520  O7520,  7520
05151  7766  O7766,  7766
05152  7771  O7771,  7771
05153  0256  O256A,  256
05154  7772  O7772,  7772
05155  5321  PMPY,   MPY
05156  5343  PNBF6,  NUMBUF+6


05157  4501  ICASERR,        JMS I   PERROR  /CASSETTE INPUT ERROR
05160  1116          TEXT 'IN'
05161  0000
05162  3714  TOOLONG,TEXT '_LINE TOO LONG_'
05163  1116
05164  0540
05165  2417
05166  1740
05167  1417

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 30-1

05170  1607
05171  3700
05172  4501  FNERR,  JMS I   PERROR
05173  0625          TEXT 'FUNCTION'
05174  1603
05175  2411
05176  1716
05177  0000







       5200          PAGE


05200  0000  FIXITUP,0
05201  1025          TAD     ACE
05202  1345          TAD     O7610
05203  3025          DCA     ACE
05204  7410          SKP
05205  1043  OCC,    TAD     DECEXP
05206  3043          DCA     DECEXP
05207  1020  NORMIT, TAD     AC1
05210  7006          RTL
05211  7630          SZL CLA
05212  5220          JMP     NORMED
05213  4546          JMS I   PAL1
05214  7240          CLA CMA
05215  1025          TAD     ACE
05216  3025          DCA     ACE
05217  5207          JMP     NORMIT
05220  1025  NORMED, TAD     ACE
05221  7540          SMA SZA
05222  5236          JMP     NOTX10
05223  7200          CLA
05224  4545          JMS I   PAR1
05225  4545          JMS I   PAR1
05226  4545          JMS I   PAR1
05227  4545          JMS I   PAR1
05230  4321          JMS     MPY
05231  1025          TAD     ACE
05232  1156          TAD     O4
05233  3025          DCA     ACE
05234  7240          CLA CMA
05235  5205          JMP     OCC
05236  1346  NOTX10, TAD     O7773
05237  7510          SPA
05240  5265          JMP     EXPOK
05241  7200          CLA
05242  1056  EXPGOOD,TAD     O7740
05243  3321          DCA     MPY
05244  7100          CLL

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 30-2

05245  1020  DVLOOP, TAD     AC1
05246  1347          TAD     O5400
05247  7500          SMA
05250  3020          DCA     AC1
05251  7264          CLA CML CMA RAL
05252  3023          DCA     OP1
05253  4546          JMS I   PAL1
05254  2023          ISZ     OP1
05255  2016          ISZ     AC3
05256  2321          ISZ     MPY
05257  5245          JMP     DVLOOP
05260  1020          TAD     AC1
05261  0073          AND     O377
05262  3020          DCA     AC1
05263  7201          CLA IAC
05264  5205          JMP     OCC
05265  3042  EXPOK,  DCA     PRTEMP
05266  7410          SKP
05267  4545          JMS I   PAR1
05270  2042          ISZ     PRTEMP
05271  5267          JMP     .-2
05272  1020          TAD     AC1
05273  1347          TAD     O5400
05274  7700          SMA CLA
05275  5242          JMP     EXPGOOD
05276  7300          CLA CLL
05277  1016          TAD     AC3
05300  1344          TAD     O2062
05301  3016          DCA     AC3
05302  7430          SZL
05303  2017          ISZ     AC2
05304  7410          SKP
05305  2020          ISZ     AC1
05306  1020          TAD     AC1
05307  1347          TAD     O5400
05310  7640          SZA CLA
05311  5600          JMP I   FIXITUP
05312  1153          TAD     O200
05313  3020          DCA     AC1
05314  3017          DCA     AC2
05315  3016          DCA     AC3
05316  2043          ISZ     DECEXP
05317  7000          NOP
05320  5600          JMP I   FIXITUP
05321  0000  MPY,    0
05322  4546          JMS I   PAL1
05323  1020          TAD     AC1
05324  3023          DCA     OP1
05325  1017          TAD     AC2
05326  3022          DCA     OP2
05327  1016          TAD     AC3
05330  3021          DCA     OP3
05331  4546          JMS I   PAL1
05332  4546          JMS I   PAL1
05333  4555          JMS I   POADD

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 30-3

05334  5721          JMP I   MPY
05335  0000  NUMBUF, 0;0;0;0;0;0;0
05336  0000
05337  0000
05340  0000
05341  0000
05342  0000
05343  0000
05344  2062  O2062,  2062
05345  7610  O7610,  7610
05346  7773  O7773,  7773
05347  5400  O5400,  5400






05350  0000  RNDJMP, FEXIT
05351  4544          JMS I   PANORM
05352  5753          JMP I   RND

05353  0000  RND,    0
05354  4435          FENTER
05355  3227          FLD+FWD+FRNDX-.
05356  0000          FEXIT
05357  1021          TAD     OP3
05360  7006          RTL
05361  7006          RTL
05362  7006          RTL
05363  3020          DCA     AC1
05364  1020          TAD     AC1
05365  7010          RAR
05366  0056          AND     O7740
05367  3017          DCA     AC2
05370  3016          DCA     AC3
05371  4555          JMS I   POADD
05372  4555          JMS I   POADD
05373  4555          JMS I   POADD
05374  1030          TAD     OPE
05375  3025          DCA     ACE
05376  1020          TAD     AC1
05377  0074          AND     O7
05400  3020          DCA     AC1
05401  4435          FENTER
05402  2202          FST+FWD+FRNDX-.
05403  1633          FJMP+BKWD+.-RNDJMP


05404  2004  FRNDX,  2004;4173;1231
05405  4173
05406  1231




/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 30-4


05407  0000  FSQRX,  0;0;0
05410  0000
05411  0000
05412  0000  SQR,    0
05413  4435          FENTER
05414  2075          FST     OPERAND
05415  0040          FSNE
05416  1232          FJMP+FWD+SQEXIT-.
05417  0000          FEXIT
05420  1024          TAD     ACS
05421  7710          SPA CLA
05422  5447          JMP I   PARGERR
05423  1025          TAD     ACE
05424  1252          TAD     OO7600
05425  7100          CLL
05426  7510          SPA
05427  7020          CML
05430  7010          RAR
05431  1153          TAD     O200
05432  3025          DCA     ACE
05433  1057          TAD     O7770
05434  3014          DCA     INDEX1
05435  4435  SQLOOP, FENTER
05436  2627          FST+BKWD+.-FSQRX
05437  3075          FLD     OPERAND
05440  7631          FDV+BKWD+.-FSQRX
05441  4632          FAD+BKWD+.-FSQRX
05442  0000          FEXIT
05443  7240          CLA CMA
05444  1025          TAD     ACE
05445  3025          DCA     ACE
05446  2014          ISZ     INDEX1
05447  5235          JMP     SQLOOP
05450  0000  SQEXIT, FEXIT
05451  5612          JMP I   SQR
05452  7600  OO7600, 7600
05453  0000  FN,     0
05454  1045          TAD     LOCCTR
05455  4506          JMS I   PPUSH
05456  1050          TAD     WORD
05457  4506          JMS I   PPUSH
05460  6201          CDF     0                       /''''''' 8 K INSERT
05461  1745          TAD I   PUSERFN
05462  6211          CDF     10                      /'''''''' 8 K INSERT.
05463  7001          IAC
05464  3045          DCA     LOCCTR
05465  4565          GET+ISIT        /'DEF'
05466  1761          1761
05467  5746          JMP I   PFNERR  /NO
05470  4177          JMS     GETWD   /SKIP 'FN'
05471  4177          JMS     GETWD   /SKIP LETTER
05472  4177          JMS     GETWD   /SKIP '('
05473  4565          GET+ISIT        /A VARIABLE
05474  7000          7000

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 30-5

05475  5746          JMP I   PFNERR  /NO
05476  2050          ISZ     WORD
05477  1450          TAD I   WORD
05500  3014          DCA     INDEX1
05501  1414          TAD I   INDEX1
05502  4506          JMS I   PPUSH
05503  1414          TAD I   INDEX1
05504  4506          JMS I   PPUSH
05505  1414          TAD I   INDEX1
05506  4506          JMS I   PPUSH
05507  1014          TAD     INDEX1
05510  4506          JMS I   PPUSH
05511  7344          CLA CLL CMA RAL
05512  1014          TAD     INDEX1
05513  3014          DCA     INDEX1
05514  4435          FENTER
05515  2414          FSTI    INDEX1
05516  0000          FEXIT
05517  4177          JMS     GETWD   /SKIP ')'
05520  4177          JMS     GETWD   /SKIP '='
05521  4503          JMS I   PEVAL
05522  4507          JMS I   PPOP
05523  3050          DCA     WORD
05524  4507          JMS I   PPOP
05525  3450          DCA I   WORD
05526  7240          CLA CMA
05527  1050          TAD     WORD
05530  3050          DCA     WORD
05531  4507          JMS I   PPOP
05532  3450          DCA I   WORD
05533  7240          CLA CMA
05534  1050          TAD     WORD
05535  3050          DCA     WORD
05536  4507          JMS I   PPOP
05537  3450          DCA I   WORD
05540  4507          JMS I   PPOP
05541  3050          DCA     WORD
05542  4507          JMS I   PPOP
05543  3045          DCA     LOCCTR
05544  5653          JMP I   FN
05545  1617  PUSERFN,USERFN



05546  5172  PFNERR, FNERR








05547  0000  TAB,    0                       /FUNCTION "TAB" IN PRINT STATEMENT.
05550  4510          JMS I   PFIX            /FIX THE FAC NOW.

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 30-6

05551  6201          CDF     0               /SET DATA FIELD TO FIELD ZERO.
05552  7201          CLA IAC                 /SET FLAG TO INDICATE WE'VE DONE THIS FUNCTION.
05553  3771          DCA I   PTABFLG         /AND STORE AWAY.
05554  1024          TAD     ACS             /GET SIGN OF FAC
05555  7650          SNA CLA                 /WAS IT A POSITIVE NUMBER?
05556  1016          TAD     AC3             /YEP. PICK UP DESIRED POSITION.
05557  0073          AND     O377            /MAXIMUM OF 256 COLUMNS.
05560  3770          DCA I   PTABDES         /SAVE AWAY FOR ACTUAL SPACER TO USE.
05561  4772          JMS I   TBEGFIX         /PREPARE TO RETURN PRESENT COLUMN NUMBER.
05562  7201          CLA IAC
05563  1130          TAD     COLUMN          /INCREMENT TO ACCOUNT FOR DIFFERENCES.
05564  3016          DCA     AC3             /AND STORE AWAY.
05565  6211          CDF     10              /RESET DATA FIELD NOW.
05566  4544          JMS I   PANORM          /NORMALIZE AC NOW.
05567  5747          JMP I   TAB             /AND RETURN NOW.


05570  6375  PTABDES,TABDES                  /POINTER TO DESIRED LOCATION OF PRINT HEAD.
05571  2343  PTABFLG,TABFLG                  /POINTER TO TAB IN PRINT FLAG.
05572  3760  TBEGFIX,BEGFIX                  /POINTER TO MINI-FIX-SET-UP ROUTINE.








05573  7201  RUBO,   CLA IAC                 /SET RUBOUT SWITCH.
05574  3135  NORUBO, DCA     RBSWCH
05575  5776          JMP I   .+1             /AND CLEAN IT UP.
05576  7354          DEVCOM                  /CLEAN-UP POINTER.










       5600          PAGE





05600  0000  TAN,    0
05601  4435          FENTER
05602  2275          FST+FWD+FTANT1-.
05603  0000          FEXIT
05604  4216          JMS     COS
05605  4435          FENTER
05606  2274          FST+FWD+FTANT2-.

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 30-7

05607  3270          FLD+FWD+FTANT1-.
05610  0000          FEXIT
05611  4224          JMS     SIN
05612  4435          FENTER

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 31


05613  7267          FDV+FWD+FTANT2-.
05614  0000          FEXIT
05615  5600          JMP I   TAN
05616  0000  COS,    0
05617  4435          FENTER
05620  4312          FAD+FWD+FSINC7-.
05621  0000          FEXIT
05622  4224          JMS     SIN
05623  5616          JMP I   COS
05624  0000  SIN,    0
05625  4435          FENTER
05626  7265          FDV+FWD+FSINC1-.
05627  2256          FST+FWD+FSINZ-.
05630  0000          FEXIT
05631  3024          DCA     ACS
05632  4676          JMS I   PINT
05633  7330          CLA CLL CML RAR
05634  0305          AND     FSINZ
05635  3024          DCA     ACS
05636  4435          FENTER
05637  5246          FSB+FWD+FSINZ-.
05640  6275          FMP+FWD+FSINM4-.
05641  2244  FSIN10, FST+FWD+FSINZ-.
05642  0000          FEXIT
05643  3024          DCA     ACS
05644  4435          FENTER
05645  5147          FSB     ONE
05646  0140          FSGT
05647  1210          FJMP+FWD+FSINOK-.
05650  3235          FLD+FWD+FSINZ-.
05651  0000          FEXIT
05652  4675          JMS I   PSGN
05653  2025          ISZ     ACE
05654  4435          FENTER
05655  5230          FSB+FWD+FSINZ-.
05656  1615          FJMP+BKWD+.-FSIN10
05657  3226  FSINOK, FLD+FWD+FSINZ-.
05660  6225          FMP+FWD+FSINZ-.
05661  2227          FST+FWD+FSINZZ-.
05662  6234          FMP+FWD+FSINC3-.
05663  4236          FAD+FWD+FSINC4-.
05664  6224          FMP+FWD+FSINZZ-.
05665  4237          FAD+FWD+FSINC5-.
05666  6222          FMP+FWD+FSINZZ-.
05667  4240          FAD+FWD+FSINC6-.
05670  6220          FMP+FWD+FSINZZ-.
05671  4241          FAD+FWD+FSINC7-.
05672  6213          FMP+FWD+FSINZ-.
05673  0000          FEXIT
05674  5624          JMP I   SIN
05675  0726  PSGN,   SGN
05676  6434  PINT,   INT
05677  0000  FTANT1, 0;0;0
05700  0000

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 31-1

05701  0000
05702  0000  FTANT2, 0;0;0
05703  0000
05704  0000
05705  0000  FSINZ,  0;0;0
05706  0000
05707  0000
05710  0000  FSINZZ, 0;0;0
05711  0000
05712  0000
05713  2036  FSINC1, 2036;2207;7325
05714  2207
05715  7325
05716  1644  FSINC3, 1644;7553;6722
05717  7553
05720  6722
05721  5714  FSINC4, 5714;6223;1432
05722  6223
05723  1432
05724  1755  FSINC5, 1755;0632;1276
05725  0632
05726  1276
05727  6005  FSINC6, 6005;1256;7406
05730  1256
05731  7406
05732  2016  FSINC7, 2016;2207;7325
05733  2207
05734  7325
05735  6034  FSINM4, 6034;0000;0000
05736  0000
05737  0000
05740  4435  UPARRX, FENTER
05741  2634          FST+BKWD+.-FSINZ
05742  0100          FSGE
05743  1221          FJMP+FWD+EXPLONG-.
05744  0000          FEXIT
05745  4676          JMS I   PINT
05746  4435          FENTER
05747  5642          FSB+BKWD+.-FSINZ
05750  0050          FSEQ
05751  1213          FJMP+FWD+EXPLONG-.
05752  3645          FLD+BKWD+.-FSINZ
05753  5207          FSB+FWD+FUPRC1-.
05754  0150          FSLE
05755  1207          FJMP+FWD+EXPLONG-.
05756  3651          FLD+BKWD+.-FSINZ
05757  0000          FEXIT
05760  5761          JMP I   .+1
05761  6457          UPARROW
05762  2077  FUPRC1, 2077;7700
05763  7700
05764  3075  EXPLONG,FLD     OPERAND
05765  0000          FEXIT
05766  4775          JMS I   PLOG
05767  4435          FENTER

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 31-2

05770  6663          FMP+BKWD+.-FSINZ
05771  0000          FEXIT
05772  4776          JMS I   PEXP
05773  5774          JMP I   .+1
05774  1203          OPDONE
05775  6114  PLOG,   LOG
05776  6000  PEXP,   EXP








       6000          PAGE


06000  0000  EXP,    0
06001  4435          FENTER
06002  7270          FDV+FWD+FEXPC1-.
06003  2261          FST+FWD+FEXPU-.
06004  0000          FEXIT
06005  4660          JMS I   PPINT
06006  7330          CLA CLL CML RAR
06007  1024          TAD     ACS
06010  3024          DCA     ACS
06011  4435          FENTER
06012  2247          FST+FWD+FEXPI-.
06013  4251          FAD+FWD+FEXPU-.
06014  2253          FST+FWD+FEXPF-.
06015  6252          FMP+FWD+FEXPF-.
06016  4257          FAD+FWD+FEXPC2-.
06017  2245          FST+FWD+FEXPU-.
06020  3241          FLD+FWD+FEXPI-.
06021  0000          FEXIT
06022  4510          JMS I   PFIX
06023  7000  FXXPFX, NOP             /(IAC IF 1 ORG INDEXING)
06024  3261          DCA     FEXPI
06025  1024          TAD     ACS
06026  7164          CMA CLL CML RAL
06027  1261          TAD     FEXPI
06030  7420          SNL
06031  7041          CIA
06032  7001          IAC
06033  3261          DCA     FEXPI
06034  4435          FENTER
06035  3243          FLD+FWD+FEXPC3-.
06036  7226          FDV+FWD+FEXPU-.
06037  4244          FAD+FWD+FEXPC4-.
06040  5227          FSB+FWD+FEXPF-.
06041  2223          FST+FWD+FEXPU-.
06042  3225          FLD+FWD+FEXPF-.
06043  6224          FMP+FWD+FEXPF-.
06044  6242          FMP+FWD+FEXPC5-.

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 31-3

06045  4217          FAD+FWD+FEXPU-.
06046  2216          FST+FWD+FEXPU-.
06047  3220          FLD+FWD+FEXPF-.
06050  7214          FDV+FWD+FEXPU-.
06051  4240          FAD+FWD+FEXPC6-.
06052  2215          FST+FWD+FEXPF-.
06053  0000          FEXIT
06054  1025          TAD     ACE
06055  1261          TAD     FEXPI
06056  3025          DCA     ACE
06057  5600          JMP I   EXP
06060  6434  PPINT,  INT
06061  0000  FEXPI,  0;0;0
06062  0000
06063  0000
06064  0000  FEXPU,  0;0;0
06065  0000
06066  0000
06067  0000  FEXPF,  0;0;0
06070  0000
06071  0000
06072  2005  FEXPC1, 2005;4271;0300
06073  4271
06074  0300
06075  2075  FEXPC2, 2075;3552;7022
06076  3552
06077  7022
06100  6124  FEXPC3, 6124;6477;0715
06101  6477
06102  0715
06103  2044  FEXPC4, 2044;7643;0062
06104  7643
06105  0062
06106  1744  FEXPC5, 1744;3372;3400
06107  3372
06110  3400
06111  2004  FEXPC6, 2004;0000;0000
06112  0000
06113  0000
06114  0000  LOG,    0
06115  1024          TAD     ACS
06116  7710          SPA CLA
06117  5447          JMP I   PARGERR
06120  1025          TAD     ACE
06121  3365          DCA     LOGACE
06122  1153          TAD     O200
06123  3025          DCA     ACE
06124  4435          FENTER
06125  2641          FST+BKWD+.-FEXPU
06126  4244          FAD+FWD+FLOGC1-.
06127  2640          FST+BKWD+.-FEXPF
06130  3644          FLD+BKWD+.-FEXPU
06131  5241          FSB+FWD+FLOGC1-.
06132  7643          FDV+BKWD+.-FEXPF
06133  2644          FST+BKWD+.-FEXPF

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 31-4

06134  6645          FMP+BKWD+.-FEXPF
06135  6216          FMP+FWD+FLOGC2-.
06136  4220          FAD+FWD+FLOGC3-.
06137  6650          FMP+BKWD+.-FEXPF
06140  6651          FMP+BKWD+.-FEXPF
06141  4220          FAD+FWD+FLOGC4-.
06142  6653          FMP+BKWD+.-FEXPF
06143  5632          FSB+BKWD+.-FEXPC6
06144  2655          FST+BKWD+.-FEXPF
06145  3217          FLD+FWD+LOGFWD-.
06146  5221          FSB+FWD+LOGOKW-.
06147  4660          FAD+BKWD+.-FEXPF
06150  6656          FMP+BKWD+.-FEXPC1
06151  0000          FEXIT
06152  5714          JMP I   LOG
06153  2004  FLOGC2, 2004;6253;2521
06154  6253
06155  2521
06156  2007  FLOGC3, 2007;5421;3604
06157  5421
06160  3604
06161  2025  FLOGC4, 2025;6125;1007
06162  6125
06163  1007
06164  2174  LOGFWD, 2174
06165  0000  LOGACE, 0
06166  0000          0
06167  2174  LOGOKW, 2174;0200;0
06170  0200
06171  0000
06172  2005  FLOGC1, 2005;5202;3632
06173  5202
06174  3632
06175  7344  COMMAS, CLA CLL CMA RAL /COMMAS ON RT OUTPUT-SET SWITCH
06176  3176  NOCOM,  DCA     CMSWCH  /NO COMMAS-CLEAR SWITCH
06177  5505          JMP I   PEXECUTE        /DONE








       6200          PAGE




06200  0000  ATN,    0
06201  1024          TAD     ACS
06202  3272          DCA     FATNSX
06203  3024          DCA     ACS
06204  4435          FENTER
06205  2271          FST+FWD+FATNT-.

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 31-5

06206  2265          FST+FWD+FATNAX-.
06207  5275          FSB+FWD+FATNC1-.
06210  0140          FSGT
06211  1254          FJMP+FWD+ATNBIG-.
06212  5275          FSB+FWD+FATNC2-.
06213  0140          FSGT
06214  1204          FJMP+FWD+ATNLOW-.
06215  3147          FLD     ONE
06216  7260          FDV+FWD+FATNT-.
06217  2257          FST+FWD+FATNT-.
06220  3150  ATNLOW, FLD     ZERO
06221  2316          FST+FWD+FATNC-.
06222  3254          FLD+FWD+FATNT-.
06223  5267          FSB+FWD+FATNC3-.
06224  0100          FSGE
06225  1212          FJMP+FWD+ATNNOT-.
06226  3250          FLD+FWD+FATNT-.
06227  4266          FAD+FWD+FATNC4-.
06230  2246          FST+FWD+FATNT-.
06231  3314          FLD+FWD+FATNCJ-.
06232  7244          FDV+FWD+FATNT-.
06233  4262          FAD+FWD+FATNC4-.
06234  2242          FST+FWD+FATNT-.
06235  3263          FLD+FWD+FATNC5-.
06236  2301          FST+FWD+FATNC-.
06237  3237  ATNNOT, FLD+FWD+FATNT-.
06240  6236          FMP+FWD+FATNT-.
06241  2240          FST+FWD+FATNTT-.
06242  3261          FLD+FWD+FATNC6-.
06243  6236          FMP+FWD+FATNTT-.
06244  4262          FAD+FWD+FATNC7-.
06245  6234          FMP+FWD+FATNTT-.
06246  4263          FAD+FWD+FATNC8-.
06247  6232          FMP+FWD+FATNTT-.
06250  4264          FAD+FWD+FATNC9-.
06251  6230          FMP+FWD+FATNTT-.
06252  4147          FAD     ONE
06253  6223          FMP+FWD+FATNT-.
06254  4263          FAD+FWD+FATNC-.
06255  2221          FST+FWD+FATNT-.
06256  3215          FLD+FWD+FATNAX-.
06257  5147          FSB     ONE
06260  0140          FSGT
06261  1204          FJMP+FWD+ATNBIG-.
06262  3260          FLD+FWD+FATNCH-.
06263  5213          FSB+FWD+FATNT-.
06264  2212          FST+FWD+FATNT-.
06265  3211  ATNBIG, FLD+FWD+FATNT-.
06266  0000          FEXIT
06267  1272          TAD     FATNSX
06270  3024          DCA     ACS
06271  5600          JMP I   ATN
06272  0000  FATNSX, 0
06273  0000  FATNAX, 0;0;0
06274  0000

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 31-6

06275  0000
06276  0000  FATNT,  0;0;0
06277  0000
06300  0000
06301  0000  FATNTT, 0;0;0
06302  0000
06303  0000
06304  1634  FATNC1, 1634;0000;0000
06305  0000
06306  0000
06307  2007  FATNC2, 2007;7776;0000
06310  7776
06311  0000
06312  1774  FATNC3, 1774;2230;2427
06313  2230
06314  2427
06315  2016  FATNC4, 2016;7331;7272
06316  7331
06317  7272
06320  2004  FATNC5, 2004;1405;2216
06321  1405
06322  2216
06323  1756  FATNC6, 1756;0462;4562
06324  0462
06325  4562
06326  5764  FATNC7, 5764;4221;3403
06327  4221
06330  3403
06331  1766  FATNC8, 1766;3141;6672
06332  3141
06333  6672
06334  5775  FATNC9, 5775;2525;2337
06335  2525
06336  2337
06337  0000  FATNC,  0;0;0
06340  0000
06341  0000
06342  2016  FATNCH, 2016;2207;7325
06343  2207
06344  7325
06345  6034  FATNCJ, 6034;0000;0000
06346  0000
06347  0000




06350  1130  TABDO,  TAD     COLUMN          /GET WHERE WE ARE NOW.
06351  7040          CMA
06352  1375          TAD     TABDES  /COMPARE WITH DESIRED LOC.
06353  7450          SNA             /IF WE ARE 1 AWAY THEN RETN.
06354  5776          JMP I   TPRINT  /GOT IT
06355  7700          SMA     CLA     /IF NEGATIVE MUST DO A C.RETN FIRST
06356  5363          JMP     .+5     /ELSE SPACE OVER TO IT
06357  1174          TAD     O215    /ISSUE C.RETN.

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 31-7

06360  4433          JMS I   PPUTCH
06361  4433          JMS I   PPUTCH  /FOLLOWED BY A NULL
06362  5350          JMP     TABDO   /SEE IF THERE
06363  1051          TAD     O240    /SPACE OVER
06364  5361          JMP     .-3

06365  4501  NFOPEN, JMS I   PERROR  /RUN TIME FILE NOT OPENED ERROR
06366  1617          TEXT 'NO FILE OPEN'
06367  4006
06370  1114
06371  0540
06372  1720
06373  0516
06374  0000
06375  0000  TABDES, 0
06376  2207  TPRINT, PRINTC                  /NORMAL EXIT LOCATION.

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 32


       6400          *6400


06400  0000  CHKFIT, 0
06401  1156          TAD     O4
06402  4542          JMS I   SPLEFT
06403  5600          JMP I   CHKFIT
06404  4557          JMS I   PLINFIX
06405  4536          JMS I   PRESET          /RESET ALL I/O DEVICES.
06406  4516          JMS I   PPRINTXT
06407  3561          UGH1
06410  3066          DCA     SNUMFLG         /RESET THIS FLAG NOW
06411  5612          JMP I   .+1
06412  2606          NEWLIN                  /THIS MAY BE RIGHT.


06413  0000  RMLEFT, 0
06414  7100          CLL
06415  1003          TAD     ARRLOC
06416  7430          SZL
06417  5223          JMP     NORLFT
06420  7041          CIA
06421  1004          TAD     CODELOC
06422  7620          SNL CLA
06423  2213  NORLFT, ISZ     RMLEFT
06424  5613          JMP I   RMLEFT



06425  0000  ABS,    0
06426  3024          DCA     ACS
06427  5625          JMP I   ABS

06430  0000  STICKIT,0
06431  3403          DCA I   ARRLOC
06432  2003          ISZ     ARRLOC
06433  5630          JMP I   STICKIT

06434  0000  INT,    0
06435  4510          JMS I   PFIX
06436  7200          CLA
06437  4544          JMS I   PANORM
06440  5634          JMP I   INT



06441  0000  SXERR,  0                       /INCASE THIS IS JMS'D TO.
06442  7200          CLA
06443  3241          DCA     SXERR           /AND REMAKE INTO AN "AND"
06444  4501          JMS I   PERROR
06445  2331          TEXT 'SYNTAX'
06446  1624
06447  0130
06450  0000

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 32-1

06451  4001  ATLINE, TEXT ' AT LINE '
06452  2440
06453  1411
06454  1605
06455  4000


06456  7570  O7570,  7570
06457  1024  UPARROW,TAD     ACS
06460  7700          SMA CLA
06461  1256          TAD     O7570
06462  1025          TAD     ACE
06463  7700          SMA CLA
06464  5447          JMP I   PARGERR
06465  4510          JMS I   PFIX
06466  5667          JMP I   .+1
06467  4365          UPARR2
06470  4566  MOREDIM,MUSTBE          /','
06471  3763          3763
06472  7240  DIM,    CLA CMA
06473  3034          DCA     DIMFLAG
06474  4503          JMS I   PEVAL
06475  4564          ISIT            /(CR) OR '\'
06476  2000          2000
06477  5270          JMP     MOREDIM
06500  5505          JMP I   PEXECUTE/YES

06501  4004  DELETED,TEXT ' DELETED_'
06502  0514
06503  0524
06504  0504
06505  3700


06506  1050  AMATCH, TAD     WORD
06507  3066          DCA     SNUMFLG
06510  1066          TAD     SNUMFLG
06511  3461          DCA I   FPTR
06512  2061          ISZ     FPTR
06513  1062          TAD     GPTR
06514  3060          DCA     EPTR
06515  4564          ISIT            /'REM'
06516  1762          1762
06517  5520          JMP I   PSLOOP
06520  5721          JMP I   .+1
06521  3043          REMPACK




06522  3723  BREAK,  3723;2417;2056
06523  2417
06524  2056
06525  3722  READY,  TEXT '_READY.__'
06526  0501

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 32-2

06527  0431
06530  5637
06531  3700
       6531  CRLF=.-1





06532  0000  ISDIG,  0
06533  4524          JMS I   PNONBLNK
06534  1344          TAD     O7706A
06535  7100          CLL
06536  1067          TAD     O12
06537  7420          SNL
06540  7200          CLA
06541  7430          SZL
06542  2332          ISZ     ISDIG
06543  5732          JMP I   ISDIG
06544  7706  O7706A, 7706


06545  1042  PZERDON,TAD     PRTEMP
06546  1043          TAD     DECEXP
06547  7710          SPA CLA
06550  5354          JMP     .+4
06551  1043          TAD     DECEXP
06552  7040          CMA
06553  3042          DCA     PRTEMP
06554  1044          TAD     PNUMBUF
06555  3025          DCA     ACE
06556  7344          CLA CLL CMA RAL
06557  7040  DIGLUP, CMA
06560  1043          TAD     DECEXP
06561  7440          SZA
06562  5365          JMP     .+3
06563  1375          TAD     O256B
06564  4433          JMS I   PPUTCH
06565  3043          DCA     DECEXP
06566  1425          TAD I   ACE
06567  4433          JMS I   PPUTCH
06570  2025          ISZ     ACE
06571  2042          ISZ     PRTEMP
06572  5357          JMP     DIGLUP
06573  5774          JMP I   .+1             /'''''''' 8 K INSERT RETURN.
06574  5121          FMTENF

06575  0256  O256B,  256
06576  5660  DOTZERO,        TEXT '.0'
06577  0000



       6600          PAGE

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 33



/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 34



06600  0000  WAITR,  0
06601  7440          SZA             /DID HE SUPPLY NEW ERR. RETN?
06602  3213          DCA     WTEM    /YES-STORE TEMPORARILY
06603  6201          CDF 0
06604  6212          CIF 10
06605  4777          JMS I   (WAIT   /CALL WAIT ROUTINE
06606  5612          JMP I   LASERR  /ERROR ON LAST CALL-HANDLE IT
06607  1213          TAD     WTEM    /OK-RESET ERROR RETURN
06610  3212          DCA     LASERR
06611  5600          JMP I   WAITR   /RETN
06612  6613  LASERR, WTEM    /IF GET ERROR BEFORE DOING ANYTHING-HALT
06613  7402  WTEM,   HLT


             /
             /CASSETTE INPUT
             /
06614  2251  CASIN,  ISZ     CGET    /PAST EOF?
06615  5300          JMP     REOFER  /YES-HE TRIED TO READ PAST EOF-IN RUNTIME FILE I/O
06616  2262          ISZ     ICOUNT  /BUFFER EMPTY?
06617  5226          JMP     NOTEM   /NOPE
06620  2261          ISZ     RIP     /YUP-IS A READ IN PROGRESS?
06621  4264          JMS     READIT  /NO-START ONE
06622  4200          JMS     WAITR   /WAIT FOR IT TO FINISH
06623  1072          TAD     KM200   /DONE-RESET BUFFER COUNTER
06624  3262          DCA     ICOUNT
06625  3261          DCA     RIP     /SET READ NOT IN PROGRESS
06626  1262  NOTEM,  TAD     ICOUNT  /GET NEXT CHAR. FROM BUFFER
06627  1377          TAD     (BUFEND
06630  3363          DCA     RCHR    /CALCULATE ADDRESS
06631  6211          CDF     10
06632  1763          TAD I   RCHR
06633  0027          AND     O177
06634  1376          TAD     (-32    /IS THE CHAR A CTRL/Z--EOF??
06635  7650          SNA     CLA
06636  5252          JMP     CTRLZI  /YES-HANDLE IT
06637  7201          CLA     IAC
06640  1262          TAD     ICOUNT  /ARE WE AT TUNED LOC.?
06641  7650          SNA     CLA
06642  4264          JMS     READIT  /YES-START NEXT READ
06643  7040          CMA
06644  3251          DCA     CGET    /SET FLAG-NOT PAST EOF
06645  6211          CDF 10
06646  1763          TAD I   RCHR    /NO-GET IT BACK
06647  5775          JMP I   (GOTIT  /RETN. W/CHAR. IN AC
06650  0000  EOFRTN, 0       /POINTER TO WHERE TO GO WHEN GET EOF FROM
                                     /CASSETTE FILE(FOR CHAIN OR OLD)
06651  0000  CGET,   0       /=0 IF EOF (CTRL/Z) DETECTED ON CURRENT INPUT FILE
                             /=7777 OTHERWISE

06652  1257  CTRLZI, TAD     DRTI    /DOING RUN-TIME INPUT?
06653  7650          SNA     CLA
06654  5650          JMP I   EOFRTN  /NO-TAKE END OF FILE RETN.

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 34-1

06655  1374          TAD     (232    /RETURN A 232 FOR CTRL/Z
06656  5773          JMP I   (GOTIT1 /SPECIAL ^Z RETN TO GOTIT+1-KLUDGE
06657  0000  DRTI,   0               /=7777 IF DOING RUN TIME INPUT


06660  0000  IUNIT,  0       /INPUT CASSETTE UNIT #
06661  0000  RIP,    0       /=7777 IF A CASSETTE READ IS IN PROGRESS
06662  0000  ICOUNT, 0       /MINUS COUNT OF CHARS. IN CASSETTE BUFFER
06663  0000  IERR,   0       /POINTER TO WHERE TO GO ON INPUT ERRORS-SET UP
                             /BY CALLING ROUTINES


06664  0000  READIT, 0
06665  1263          TAD     IERR    /RESET ERROR MESSAGE AFTER WAIT
06666  4200          JMS     WAITR   /WAIT FOR ALL CASSETTE I/O TO BE DONE
06667  1260          TAD     IUNIT   /DO A READ-GET UNIT #
06670  6212          CIF     10
06671  4772          JMS I   (HNDLR  /CALL HANDLER
06672  0010          0010            /FUNCTION WD.-READ INTO FIELD 1
06673  6000          BUFST
06674  5663          JMP I   IERR    /ERROR-TRAP OUT
06675  7240          CLA     CMA
06676  3261          DCA     RIP
06677  5664          JMP I   READIT



06700  4501  REOFER, JMS I   PERROR
06701  0517          TEXT 'EOF'   /READ PAST EOF AT RUNTIME
06702  0600

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 35


             /
             /CASSETTE OUTPUT
             /
06703  0000  CASOUT, 0
06704  3363          DCA     RCHR    /STORE CHAR. PASSED
06705  2361          ISZ     OCOUNT  /DONE FILLING A BUFFER?
06706  5312          JMP     NOTFUL  /NO-GO ON
06707  4200          JMS     WAITR   /YES-WAIT FOR LAST WRITE TO FINISH
06710  1072          TAD     KM200   /DONE-RESET COUNTER-BUFFER EMPTY
06711  3361          DCA     OCOUNT
06712  1361  NOTFUL, TAD     OCOUNT  /GET ADDR TO STORE THIS CHAR AT
06713  1362          TAD     KBUFEND
06714  3264          DCA     READIT
06715  6211          CDF     10
06716  1363          TAD     RCHR    /GET THE CHAR
06717  3664          DCA I   READIT  /PUT IT IN BUFFER
06720  1363          TAD     RCHR    /WAS THIS CHAR A CTRL/Z?
06721  0027          AND     O177
06722  1376          TAD     (-32
06723  7650          SNA     CLA
06724  5331          JMP     DWRIT   /YES-DO A WRITE
06725  1361  NCTRLZ, TAD     OCOUNT  /ARE WE AT THE 'TUNER' LOC.
06726  7001          IAC
06727  7640          SZA     CLA
06730  5341          JMP     NOTYET  /NOPE
06731  1357  DWRIT,  TAD     OERR    /RESET ERROR RETN AFTER WAIT
06732  4200          JMS     WAITR   /YUP-WAIT FOR ALL I/O TO CASSETTE TO FINISH
06733  1360          TAD     OUNIT   /YUP-START WRITING THIS BUFFER
06734  6212          CIF     10
06735  4772          JMS I   (HNDLR
06736  4010          4010            /WRITE FROM FIELD 1
06737  6000  KBUFST, BUFST           /OR RTBUF IF RUNTIME OUTPUT
06740  5757          JMP I   OERR    /ERROR-HANDLE IT
06741  1363  NOTYET, TAD     RCHR    /GET THE CHAR.
06742  0027          AND     O177
06743  1376          TAD     (-32    /WAS IT CTRL/Z?
06744  7640          SZA     CLA
06745  5703          JMP I   CASOUT  /NO-DONE-RETN.
06746  4200          JMS     WAITR   /GOT CTRL/Z-WAIT FOR LAST WRITE TO BE DONE
06747  1360          TAD     OUNIT   /NOW CLOSE THE FILE
06750  6212          CIF     10
06751  4771          JMS I   (CLOSE
06752  5757          JMP I   OERR    /ERR-HANDLE IT
06753  3770          DCA I   (OIP    /CLEAR OUTPUT IN PROGRESS FLAG
06754  1132          TAD     OUTD2
06755  3133          DCA     OUTDEV  /RESET OUTPUT TO WHAT IT WAS
06756  5703          JMP I   CASOUT  /RETN


06757  0000  OERR,   0       /POINTER TO WHERE TO GO ON OUTPUT ERR-SETUP BY CALLING ROUTINE
06760  0000  OUNIT,  0       /OUTPUT CASSETTE UNIT #
06761  0000  OCOUNT, 0       /MINUS COUNT OF CHARS. IN OUTPUT BUFFER

06762  6200  KBUFEND,        BUFEND  /OR RTBUFN IF RUN-TIME OUTPUT IN USE!

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 35-1


06763  0000  RCHR,   0

06764  4501  IANDO,  JMS I   PERROR  /ATTEMPTED TO DO RUNTIME INPUT AND OUTPUT
06765  1146          TEXT 'I&O'      /TO SAME UNIT
06766  1700

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 36


06770  7357
06771  6400
06772  6600
06773  7210
06774  0232
06775  7207
06776  7746
06777  6200
       7000          PAGE


07000  0000  PUTER,  0
07001  3347          DCA     OPUTC   /STORE CHAR. TEMPORARILY
07002  6214          RDF             /GET CALLING FIELD
07003  1205          TAD     K6201   /SET DATA FIELD TO IT ON EXIT
07004  3214          DCA     PUTCDF
07005  6201  K6201,  CDF     0
07006  1133          TAD     OUTDEV  /MOVE OVER OUTPUT DEV.
07007  1216          TAD     OPOTAB  /SO WE DO OUT
07010  3212          DCA     OTEMP1  /SET UP OUTPUT ROUTINE CALL
07011  1347          TAD     OPUTC   /GET THE CHAR.
07012  0000  OTEMP1, 0               /CALL APPROPRIATE ROUTINE
07013  7200          CLA             /CLR. GARBAGE
07014  0000  PUTCDF, 0
07015  5600          JMP I   PUTER   /RETN. W/DATA FIELD SAME AS IT WAS

07016  4617  OPOTAB, JMS I   .+1
07017  7012          OTEMP1          /NO OUTPUT
07020  7024          TTYO            /TELETYPE
07021  6703          CASOUT          /CASSETTE
07022  7400          LLSOUT          /LINEPRINTER
07023  0000  ECHO,   0       /SET TO 400 WHEN BASIC MUST PRINT SOMETHING ON TTY

07024  0000  TTYO,   0
07025  1223          TAD     ECHO
07026  4777          JMS I   (TLSOUT /OUTPUT PLUS ECHO/NO ECHO SWITCH
07027  3223          DCA     ECHO
07030  5624          JMP I   TTYO    /RETN AFTER ZEROING ECHO SWITCH


07031  4567  CHAIN,  GET+MUSTBE      /NEXT ELEMENT MUST BE TEXT!
07032  5000          5000
07033  6201          CDF     0
07034  6212          CIF     10
07035  4776          JMS I   (CNAMST /SET UP UNIT AND NAME FROM CORE!
07036  5264          JMP     BADCHN  /ERROR!
07037  3775          DCA I   (IUNIT  /SAVE UNIT #
07040  6213          CDF CIF 10      /CLOSE RT OUTPUT FILE IF ONE OPEN
07041  4543          JMS I   PCLOS
07042  4774          JMS I   (WAITR  /DO A WAIT BEFORE RESETTING ERR. RETN.
07043  1373          TAD     (CHNERR /OK-SET UP ERROR RETN.-CASSETTE ERROR
07044  3772          DCA I   (IERR
07045  1371          TAD     (RUNC   /SET UP EOF RETURN TO RUN PROG.
07046  3770          DCA I   (EOFRTN

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 36-1

07047  6212          CIF     10
07050  1775          TAD I   (IUNIT  /GET UNIT #
07051  4767          JMS I   (LOOK   /LOOK UP THE FILE
07052  0227          IONAM
07053  5260          JMP     CNTFND  /NOT FOUND
07054  6213          CDF CIF 10
07055  1366          TAD     (IONAM-NAMLOC   /NAME OF FILE IS IN IONAM
07056  3765          DCA I   (NAMER  /SO SET NAMER IN CASE HE DOES A SAVE
07057  5764          JMP I   (OLD3   /FOUND-JUMP INTO 'OLD' HANDLER

07060  4516  CNTFND, JMS I   PPRINTXT
07061  3363          CHNMS           /PRINT CHAIN ERR MESS.
07062  6213          CDF CIF 10
07063  5763          JMP I   (NTFND+2        /GO PRINT THE REST
07064  4501  BADCHN, JMS I   PERROR
07065  0611          TEXT 'FILE NAME'
07066  1405
07067  4016
07070  0115
07071  0500


07072  0000  RESET1, 0
07073  7201          CLA IAC
07074  3133          DCA     OUTDEV
07075  7201          CLA IAC
07076  3132          DCA     OUTD2
07077  7201          CLA IAC
07100  3131          DCA     INDEV
07101  3135          DCA     RBSWCH  /NO RUBOUTS NOW
07102  6201          CDF     0               /RESET DATA FIELD TO HERE.
07103  3762          DCA I   (OCOUNT
07104  3761          DCA I   (RIP
07105  3760          DCA I   (DRTI   /CLR. RUNTIME INPUT FLAG
07106  7040          CMA
07107  3757          DCA I   (ICOUNT
07110  7344          CLA CLL CMA RAL
07111  3176          DCA     CMSWCH  /RESET COMMAS SWITCH
07112  3756          DCA I   (OIP    /CLR. OUTPUT IN PROGRESS SWITCH
07113  4534          JMS I   CNTLOZ  /CLEAR CNTLO SWITCH
07114  5672          JMP I   RESET1









07115  0000  XGISIT, 0
07116  1445          TAD I   LOCCTR
07117  3050          DCA     WORD
07120  2045          ISZ     LOCCTR
07121  1315          TAD     XGISIT

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 36-2

07122  3324          DCA     XISIT
07123  5325          JMP     XISIT+1
07124  0000  XISIT,  0
07125  1450          TAD I   WORD
07126  6201          CDF     0               /''''''''''''' 8 K INSERT.
07127  1724          TAD I   XISIT
07130  6211          CDF     10              /''''''''''''' 8 K INSERT.
07131  2324          ISZ     XISIT
07132  7650          SNA CLA
07133  2324          ISZ     XISIT
07134  5724          JMP I   XISIT

07135  4501  FIOER,  JMS I   PERROR
07136  1617          TEXT 'NO FILES' /NO RUN TIME FILE I/O NOW
07137  4006
07140  1114
07141  0523
07142  0000


             /
             /ROUTINE TO WAIT FOR CASSETTE I/O TO STOP
             /THEN CLEAR CONTROL/O SWITCH AND FORCE TTY OUTPUT
             /
07143  0000  COWT,   0
07144  4774          JMS I   (WAITR  /WAIT FOR CASSETTE I/O
07145  4534          JMS I   CNTLOZ  /CLR. CONTROL /O STATE
07146  5743          JMP I   COWT    /RETN

07147  0000  ZCNTLO, 0
07150  1355          TAD     (400
07151  3223          DCA     ECHO    /RESET SWITCH SO WE CLR. MONITOR'S CNTLO SWITCH
07152  6211          CDF 10
07153  5747          JMP I   ZCNTLO  /RETN.-TURNS INTRPT BACK ON
       7147  OPUTC=ZCNTLO

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 37








07155  0400
07156  7357
07157  6662
07160  6657
07161  6661
07162  6761
07163  1152
07164  1100
07165  0032
07166  0011
07167  0306
07170  6650
07171  2456
07172  6663
07173  3362
07174  6600
07175  6660
07176  0452
07177  7402
       7200  PAGE
07200  0000  GETCH,  0
07201  7240          CLA     CMA     /WHERE IS INPUT FROM
07202  1131          TAD     INDEV   
07203  7640          SZA     CLA     
07204  5777          JMP I   (CASIN  /CASSETTE-WHEN DONE RETN TO GOTIT       
                                     /(TO GOTIT1 IF GOT ^Z IN RUNTIME INPUT FILE)
07205  6201          CDF     0
07206  4776          JMS I   (KBDINP /KEYBOARD
07207  0027  GOTIT,  AND     O177    /MAKE 7 BIT ASCII
07210  3270  GOTIT1, DCA     GTEMP   /STORE (IF GOT ^Z COME HERE W/232 IN AC-ONLY RUNTIME I/O)
07211  6211          CDF     10
07212  1135          TAD     RBSWCH  /ARE RUBOUTS LEGAL AS DELETE CHAR?
07213  7650          SNA     CLA
07214  5223          JMP     GRB     /NOPE
07215  1270          TAD     GTEMP   /YUP IS THIS ONE
07216  1375          TAD     (7601   
07217  7640          SZA     CLA
07220  5223          JMP     GRB     /NOPE-GO ON
07221  1374  GRDELA, TAD     (137    /YUP-PASS IT AS BACKARROW(ALWAYS LEGAL)
07222  5600          JMP I   GETCH

07223  1270  GRB,    TAD     GTEMP   /GET CHAR.
07224  1373          TAD     (7602   /IS IT ALTMODE(376)?
07225  7450          SNA
07226  5242          JMP     GALT    /YUP
07227  1372          TAD     (143    /NO-IS IT ALTMODE(ESCAPE)-233?
07230  7450          SNA     
07231  5242          JMP     GALT    /YUP

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 37-1

07232  1371          TAD     (7673   /NO-IS IT PRINTING CHAR.?
07233  7510          SPA
07234  5244          JMP     GOUT    /YUP-ITS OK
07235  1370          TAD     (7746
07236  7540          SMA     SZA
07237  5244          JMP     GOUT    /YUP ALSO-ITS OK
07240  1367          TAD     (132    /NOPE-MAKE LOW CASE ASCII=UPPER CASE ASCII
07241  5600          JMP I   GETCH   /RETN IT

07242  1366  GALT,   TAD     (175    /GOT ALTMODE -RETN IT
07243  5600          JMP I   GETCH

07244  7200  GOUT,   CLA
07245  1270          TAD     GTEMP   /LEGAL CHAR-RETN IT
07246  5600          JMP I   GETCH

       7270  GTEMP=XGMUST

07247  4501  ARGERR, JMS I   PERROR
07250  0122          TEXT 'ARGUMENT'
07251  0725
07252  1505
07253  1624
07254  0000
             /
             /CALL A FLIED ZERO ROUTINE FROM FIELD 1
             /
07255  0000  LJMS,   0
07256  3270          DCA     XGMUST  /STORE AC
07257  1655          TAD I   LJMS    /GET ADDR OF SUBR TO CALL
07260  2255          ISZ     LJMS    /BUMP RETN.
07261  3277          DCA     XMUST   /STORE THE ADDR
07262  1270          TAD     XGMUST  /GET STORED AC
07263  4677          JMS I   XMUST   /CALL THE ROUTINE
07264  7410          SKP             /IN CASE OF SKIPPING RETN.
07265  2255          ISZ     LJMS
07266  6213          CDF CIF 10
07267  5655          JMP I   LJMS    /RETN






07270  0000  XGMUST, 0
07271  1445          TAD I   LOCCTR
07272  2045          ISZ     LOCCTR
07273  3050          DCA     WORD
07274  1270          TAD     XGMUST
07275  3277          DCA     XMUST
07276  5300          JMP     XMUST+1
07277  0000  XMUST,  0
07300  1450          TAD I   WORD
07301  6201          CDF     0               /''''''''' 8 K INSERT.
07302  1677          TAD I   XMUST

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 37-2

07303  6211          CDF     10              /''''''''' 8 K INSERT.
07304  2277          ISZ     XMUST
07305  7650          SNA CLA
07306  5677          JMP I   XMUST
07307  5502          JMP I   PSXERR







07310  4501  LOOKER, JMS I   PERROR
07311  0611          TEXT 'FILE OPEN'                /HARD ERROR ON CASSETTE-FILE ALREADY OPEN
07312  1405
07313  4017
07314  2005
07315  1600









07316  4337  INPUTN, JMS     DRTICK  /CHECK IF DOING RUNTIME INPUT
07317  7326          CLA CLL CML RTL /OK-SET INPUT DEV. TO CASSETTE
07320  3131          DCA     INDEV
07321  5765          JMP I   (INPUT  /GO DO IT



07322  1357  PRINTN, TAD     OIP     /IS RUNTIME OUTPUT IN PROGRESS?
07323  7650          SNA     CLA
07324  5764          JMP I   (NFOPEN /NOPE-GIVE ERROR
07325  1133          TAD     OUTDEV  /YES-SAVE CURRENT OUTPUT DEV
07326  3132          DCA     OUTD2
07327  7326          CLA CLL CML RTL /SET OUTPUT TO CASSETTE
07330  3133          DCA     OUTDEV
07331  5763          JMP I   (PRINT2 /GO DO IT

07332  4337  ENDNM,  JMS     DRTICK  /CHECK IF DOING RUNTIME INPUT-CGET IN AC ON RETN.
07333  7001          IAC             /(CGET=0:YES;CGET=-1:NO)
07334  3075          DCA     OPERAND /OPRND=1:YES;0:NO--FOR CHECK AT IF1
07335  4177          JMS     GETWD   /MUST GET NEXT WD OF INTRP.CODE
07336  5762          JMP I   (IF1    /JUMP BACK INTO IF PROCESSOR

             /CHECK IF DOING RUNTIME INPUT-IF NOT GIVE ERROR
             /IF SO RETN W/DATA FLD=1 AND CGET IN AC FOR ENDNM
             /
07337  0000  DRTICK, 0
07340  6201          CDF     0       /DRTI FLAG IS IN FLD. 0
07341  1761          TAD I   (DRTI   /RUNTIME INPUT FILE OPEN??

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 37-3

07342  7650          SNA     CLA     
07343  5764          JMP I   (NFOPEN /NO-GIVE NO FILE OPEN ERROR
07344  1760          TAD I   (CGET   /YES-GET CGET INTO AC--(INPUTN CLRS AC)
07345  6211          CDF 10  /DATA FLD =1
07346  5737          JMP I   DRTICK  /RETN.

07347  7326  LPTOUT, CLA CLL CML RTL                 /LINE PRINTER OUTPUT
07350  7001  TTYOUT, IAC                     /TTY OUT
07351  3133          DCA     OUTDEV          /AND SET IT UP
07352  1133          TAD     OUTDEV          /ALSO MOVE OVER TO SECONDARY DEVICE.
07353  3132          DCA     OUTD2
07354  4567  DEVCOM, GET+MUSTBE      /CR. OR \
07355  2000          2000                    /C.R. OR \
07356  5505          JMP I   PEXECUTE

07357  0000  OIP,    0               /=-1 IF OUTPUT TO CAS. INPROGRESS
                                     /FOR SAVE OR RUNTIME OUTPUT
07360  6651
07361  6657
07362  0403
07363  2174
07364  6365
07365  4007
07366  0175
07367  0132
07370  7746
07371  7673
07372  0143
07373  7602
07374  0137
07375  7601
07376  7626
07377  6614
       7400          PAGE


             /
             /INTERRUPT HANDLER GOES HERE
             /

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 38


       0001          FIELD   1
       0000  *0
             /MUST REMAIN AT LOC. 0!!!SEE LOC. PTEN ON PAGE ZERO,FLD. ZERO
10000  2045  TEN,    2045;0000;0000          /INSERTED IN UPPER CORE BECAUSE OF FEEBILITY.
10001  0000
10002  0000
10003  0000  TEMP,   0
10004  0401  UJMS,   UUJMS
       0005  *5
             /RESERVED FOR XOD--DECUS DEBUGGING PROG.
10005  0000  XXOD1,  0
10006  0000  XXOD2,  0
10007  0000  XXOD3,  0
       0010  *10
10010  0000  X10,    0
10011  0000  XREG2,  0
10012  3725  UNIT,   TEXT '_UNIT#(0-7):'
10013  1611
10014  2443
10015  5060
10016  5567
10017  5172
10020  0000
       0021  *21
       0021  *21
10021  0000  UTEM1,  0
       4422  ISIT1=JMS I .;XISIT1
10022  0520
             /ROUTINE TO CALL FIELD 0 TEXT PRINTER
             /       JMS     MPRINT
             /       (ADDR. OF MESS.-FIELD 1)
             /       (RETN. HERE)
             /
10023  0000  MPRINT, 0
10024  6211          CDF     10
10025  1423          TAD I   MPRINT  /GET ADDR. OF TEXT TO AC
10026  2023          ISZ     MPRINT  /BUMP RETN.
10027  4404          JMS I   UJMS
10030  3702          PRINTXT
10031  5423          JMP I   MPRINT

10032  0000  NAMER,  0       /=0 IF NAME OF PROG. IN CORE IS IN NAMLOC;
                             /=11 IF NAME OF PROG. IN CORE IS IN IONAM (AFTER A CHAIN)

       4433  MSTBE1=JMS I .;XMUST1;XGMST1
10033  0541
10034  0533
10035  7357  POIP,   OIP             /OIP=-1 IF OUTPUT TO CASSETTE IN PROGRESS


/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 39



             /
             /ROUTINE TO CHECK IF A CASSETTE OUTPUT FILE IS OPEN
             /IN CASE USER TYPES BREAK OR CTRL/C BEFORE CLOSING
             /THE FILE-THIS ROUTINE INSURES FILE IS CLOSED
             /
10036  0000  CLOS,   0       
       0036  GTPTR=CLOS
10037  7200          CLA
10040  6201          CDF 0           /OIP IS IN FLD 0
10041  2435          ISZ I   POIP    /RUNTIME OUTPUT IN PROGRESS??
10042  5046          JMP     O6203   /NOPE
10043  1177          TAD     [232    /YUP-CLOSE FILE
10044  4404          JMS I   UJMS
10045  6703          CASOUT
10046  6203  O6203,  CDF CIF 0
10047  6211          CDF 10
10050  5436          JMP I   CLOS

             /
             /CHECK FOR ^Z DURING RUNTIME INPUT--EQUALS  END OF FILE
             /MUST RETURN "0" AND CAR.RETN. FOR THE INPUT ROUTINE
             /
10051  2622  CHARNEW,        NEWCHAR

10052  3023  CTRZHP, DCA     MPRINT  /STORE VALUE OF EPTR PASSED
10053  1423          TAD I   MPRINT  /GET LAST CHAR.
10054  7041          CMA     IAC     /NEGATE
10055  1177          TAD     [232    /WAS IT ^Z?
10056  6202          CIF 0
10057  7640          SZA     CLA
10060  5451          JMP I   CHARNEW /NOPE-RETN. GET NEXT CHHAR
10061  6201          CDF 0
10062  7240          CLA     CMA     /CHECK THAT INPUT IS CASSETTE IF GET ^Z
10063  1576          TAD I   [INDEV
10064  6211          CDF 10
10065  7650          SNA     CLA
10066  5451          JMP I   CHARNEW /NOPE-JUST IGNORE^Z
10067  1175          TAD     [60     /YUP-RETN. 0
10070  3423          DCA I   MPRINT  /BY PUTTING IT IN BUFFER
10071  6201          CDF 0
10072  2477          ISZ I   KEPTR   /NOW BUMP POINTER
10073  1174          TAD     [15     /C.RETN TO END LINE
10074  6211          CDF     10
10075  5476          JMP I   .+1     /NOW  THE LINE IS DONE
10076  2623          NEWCHAR+1
10077  0060  KEPTR,  EPTR
       0100  *100
             NOPUNCH
10100  0000  MONITR, ZBLOCK 30
             ENPUNCH

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 40


       0200  *200
10200  0000  SETINCH,        0               /(GETUNIT STORES CAS. UNIT # IN SETINCH)
10201  1377          TAD     (NAMLOC-1       /EITHER NAMLOC-1 OR IONAM-1
10202  3010          DCA     X10     /STORE
10203  1376          TAD     (INCHN-1        /GET POINTER TO IN CORE HEADER
10204  3011          DCA     XREG2
10205  1375          TAD     (-11
10206  3240          DCA     GETUNIT
10207  1410          TAD I   X10     /GET A CHAR. OF FILE NAME
10210  3411          DCA I   XREG2   /STORE IN HEADER
10211  2240          ISZ     GETUNIT /DONE ALL?
10212  5207          JMP     .-3     /NO-GO ON
10213  7201          CLA IAC
10214  3411          DCA I   XREG2   /TYPE=1=ASCII
10215  5600          JMP I   SETINCH /YES-RETN.

             ////////////NAMLOC AND IONAM BLOCKS MUST BE KEPT IN ORDER
             ////////////THEY ARE INITIALIZED TO "NONAME.BAS"
10216  0316  NAMLOC, "N;"O;"N;"A;"M;"E
10217  0317
10220  0316
10221  0301
10222  0315
10223  0305
10224  0302  EXTLOC, "B;"A;"S
10225  0301
10226  0323

10227  0316  IONAM,  "N;"O;"N;"A;"M;"E
10230  0317
10231  0316
10232  0301
10233  0315
10234  0305
10235  0302  IEXTLC, "B;"A;"S
10236  0301
10237  0323
             ///////////////////////////////////////


10240  0000  GETUNIT,        0
10241  6201          CDF     0
10242  7201          CLA     IAC
10243  3573          DCA I   [OUTDEV
10244  7201          CLA     IAC     /MUST BE TO TTY!
10245  3572          DCA I   [OUTD2
10246  4023          JMS     MPRINT
10247  0012          UNIT            /PRINT MESSAGE ASKING FOR UNIT #
10250  4275          JMS     GETIT   /ACCEPT A 1 DIGIT OCTAL #
10251  1171          TAD     [-70
10252  7100          CLL             /FOLLOWED BY A C.R.
10253  1170          TAD     [10
10254  7420          SNL             /IS IT BETW. 0-7?
10255  5271          JMP     TRYALT  /NO-WAS IT ALTMODE?

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 40-1

10256  1175          TAD     [60
10257  3200          DCA     SETINCH /YES-STORE IT
10260  4275          JMS     GETIT   /HE MUST TYPE CAR. RETN.
10261  1167          TAD     [7763
10262  7440          SZA     
10263  5270          JMP     TRYAL   /NOPE-WAS IT ALTMODE?
10264  4023          JMS     MPRINT
10265  5257          CRLFD           /OK-TYPE CRLF
10266  1200          TAD     SETINCH /RETN. W/UNIT# IN AC
10267  5640          JMP I   GETUNIT

10270  1374  TRYAL,  TAD     (-43
10271  1373  TRYALT, TAD     (-115
10272  7650          SNA     CLA     /DID HE TYPE ALTMODE??
10273  5772          JMP I   (FALT   /YES-GO TO EDIT MODE
10274  5241          JMP     GETUNIT+1       /NO-TRY AGAIN

10275  0000  GETIT,  0
10276  4404          JMS I   UJMS    /GET A CHAR. FR. TTY
10277  7200          GETCH
10300  3003          DCA     TEMP    /STORE TEMPORARILY
10301  1003          TAD     TEMP
10302  4404          JMS I   UJMS    /PRINT IT
10303  0741          PUTCH
10304  1003          TAD     TEMP
10305  5675          JMP I   GETIT   /RETN IT IN AC

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 41



             /LOOKUP FILE ON CASSETTE-UNIT # IN AC ON ENTRY
             /IF LINK=1,FILE NAME IS IN NAMLOC, IF LINK=0
             /FILE NAME IS IN IONAM
             /


10306  0000  LOOK,   0
10307  3332          DCA     LUNIT   /STORE UNIT #
10310  1706          TAD I   LOOK    /GET WHERE NAME IS
10311  3322          DCA     NAM     /STORE IN LOOKUP CALL
10312  2306          ISZ     LOOK    /BUMP RETN PAST IS
10313  1046          TAD     O6203   /DETERMINE CALLING FIELD
10314  6214          RDF
10315  3326          DCA     LUKERR
10316  6211          CDF     10
10317  1332          TAD     LUNIT   /GET UNIT #
10320  4771          JMS I   (LOOKUP /LOOK UP THE FILE
10321  6211          CDF     10      /NAME IS IN FLD 1
10322  0000  NAM,    0
10323  5330          JMP     LKERR   /ERROR-HANDLE IT
10324  7610          SKP     CLA     /NOT FOUND-RETN TO CALL+2
10325  2306          ISZ     LOOK    /OK-RETN TO CALL+3
10326  0000  LUKERR, 0
10327  5706          JMP I   LOOK    /IF NOT FOUND-RETN TO CALL+2
10330  6203  LKERR,  CDF CIF 0
10331  5770          JMP I   (LOOKER /YES-GIVE MESSAGE-FILE OPEN ALREADY

10332  0000  SCRAT1, 0
10333  1367          TAD     (XXEOF  /DO A SCRATCH--ALMOST
10334  6211          CDF 10
10335  3766          DCA I   (PERMSYM
10336  6201          CDF     0
10337  1366          TAD     (PERMSYM
10340  3765          DCA I   (CODELOC
10341  7001          IAC
10342  1366          TAD     (PERMSYM
10343  3764          DCA I   (PSYMTAB
10344  7240          CLA     CMA
10345  3763          DCA I   (NSYMTAB
10346  5732          JMP I   SCRAT1

       0332  LUNIT=SCRAT1

10347  0000  PAD,    0
10350  1166          TAD     [40     /PAD NAME OR EXT. WITH SPACES
10351  3436          DCA I   GTPTR
10352  4762          JMS I   (PAKBUF
10353  2761          ISZ I   (CCNTR
10354  5352          JMP     .-2
10355  7346          CLA CLL CMA RTL /WHEN DONE-RESET CNTR FOR EXT.
10356  3761          DCA I   (CCNTR
10357  5747          JMP I   PAD

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 42



10361  0646
10362  0763
10363  0053
10364  0052
10365  0004
10366  5111
10367  5541
10370  7310
10371  7002
10372  0644
10373  7663
10374  7735
10375  7767
10376  7402
10377  0215
       0400  *400

10400  0000  UUJMP,  0
10401  0000  UUJMS,  0               /JMS TO LOC. IN FIELD 0
10402  3200          DCA     UUJMP
10403  6211          CDF     10
10404  6202          CIF     0
10405  1601          TAD I   UUJMS
10406  3211          DCA     UTEM
10407  1200          TAD     UUJMP
10410  4616          JMS I   UUUJMS
10411  0000  UTEM,   0
10412  7410          SKP             /IN CASE OF SKIPPING RETN.
10413  2201          ISZ     UUJMS
10414  2201          ISZ     UUJMS
10415  5601          JMP I   UUJMS

10416  7255  UUUJMS, LJMS

             /
             /GTJMP1 WILL CONTAIN EITHER A '0'- TO FALL THRU TO
             /KBDIN AND GET A CHAR FROM KEYBOARD OR A 'JMP COREIN'  TO GET
             /A CHAR. FROM A TEXT STMT STORED IN CORE
             /
             /THIS IS SET UP BY CALLING ROUTINE BEFORE FIRST CALL TO CHRGET
             /
10417  0000  CHRGET, 0
10420  0000  GTJMP1, 0       /GET CHR. FROM CORE OR KBD-SET UP BY CALLER
10421  4777  KBDIN,  JMS I   (GETIT  /KBD-READ AND ECHO CHAR.
10422  5617          JMP I   CHRGET  /RETN.
10423  2251  COREIN, ISZ     HALF    /CORE-WHICH HALF OF WD?
10424  5233          JMP     RIGHT   /RIGHT-GET IT
10425  4404          JMS I   UJMS    /LEFT-NEED A NEW WD
10426  0177          GETWD
10427  6201          CDF     0
10430  1565          TAD I   [WORD   /ROTATE IT RIGHT 6 BITS
10431  7102          CLL BSW
10432  5237          JMP     HAF     /GO CHECK FOR SPACE,ETC.

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 42-1

10433  7040  RIGHT,  CMA             /RIGHT HALF-SET FLAG FOR LEFT NEXT
10434  3251          DCA     HALF    
10435  6201          CDF     0
10436  1565          TAD I   [WORD   /GET WORD
10437  0164  HAF,    AND     [77     /MASK RIGHT 6 BITS
10440  1163          TAD     [7740   /IS IT SPACE?
10441  7450          SNA
10442  5223  GTJMP,  JMP     COREIN  /YES-IGNORE IT-GET NEXT CHAR.
10443  7100          CLL
10444  1166          TAD     [40     /NO-RESTORE IT TO SEVEN BIT
10445  7430          SZL
10446  1376          TAD     (100
10447  6211          CDF     10
10450  5617          JMP I   CHRGET  /AND RETN.

10451  0000  HALF,   0

10452  0000  CNAMST, 0
10453  6214          RDF             /DETERMINE CALLING FIELD
10454  1046          TAD     O6203
10455  3305          DCA     CLEV    /STORE FOR RETN.
10456  6211          CDF     10
10457  1242          TAD     GTJMP
10460  3220          DCA     GTJMP1  /INPUT FROM CORE-NOT KBD
10461  4404          JMS I   UJMS    /MOVE PTR TO FIRST WD OF TEXT
10462  0177          GETWD
10463  3251          DCA     HALF    /RIGHT HALF OF WORD FIRST
10464  4217          JMS     CHRGET  /GET A CHAR.
10465  1171          TAD     [7710
10466  7100          CLL             /SHOULD BE UNIT NUMBER
10467  1170          TAD     [10
10470  3320          DCA     XISIT1  /STORE CHAIN UNIT NUMBER
10471  7420          SNL
10472  5301          JMP     CNERR   /NOT NUMERIC-ERROR
10473  4217          JMS     CHRGET  /OK-GET ANOTHER CHAR.
10474  1375          TAD     (-72    /MUST BE COLON
10475  7640          SZA     CLA
10476  5301          JMP     CNERR   /NOPE-ERROR
10477  4562          JMS I   [FILNAM /GET FILE NAME FROM CORE
10500  0227          IONAM           /LEAVE IN IONAM
10501  7410  CNERR,  SKP             /ERROR-RETN TO CALL+1
10502  2252          ISZ     CNAMST  /OK-RETN TO CALL+2
10503  1320          TAD     XISIT1  /GET CHAIN UNIT #
10504  1175          TAD     [60     /GLITCH IN MON..0 MEANS SAME UNIT AS LAST USED
10505  0000  CLEV,   0               /CDF CIF TO CALLING FIELD
10506  5652          JMP I   CNAMST  /RETN
10507  4006  NFMES,  TEXT ' FILE NOT FOUND_'
10510  1114
10511  0540
10512  1617
10513  2440
10514  0617
10515  2516
10516  0437
10517  0000

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 42-2


10520  0000  XISIT1, 0
10521  6201          CDF     0
10522  1565          TAD I   [WORD   /GET LIST POINTER
10523  3305          DCA     CLEV    /STORE FOR A WHILE
10524  6211          CDF     10      /DATA IS IN FIELD 1
10525  1705          TAD I   CLEV    /GET THE WORD
10526  1720          TAD I   XISIT1  /GET THE COMPARAND
10527  2320          ISZ     XISIT1  /BUMP RETN. PAST IT
10530  7650          SNA     CLA     /SAME?
10531  2320          ISZ     XISIT1  /YES-BUMP RETN AGAIN
10532  5720          JMP I   XISIT1  /RETN.

10533  0000  XGMST1, 0
10534  4404          JMS I   UJMS    /GET NEXT WORD OF PSEUDO-CODE
10535  0177          GETWD
10536  1333          TAD     XGMST1  /FUDGE SUBR. LINKS
10537  3341          DCA     XMUST1
10540  7410          SKP
10541  0000  XMUST1, 0
10542  1741          TAD I   XMUST1  /GET WHAT PSEUDO CODE SHOULD BE
10543  2341          ISZ     XMUST1  /BUMP RETN. PAST IT
10544  3346          DCA     .+2     /STORE
10545  4422          ISIT1           /IS THAT WHAT IT IS?
10546  0000          0
10547  5351          JMP     SXER    /NOPE-SYNTAX ERR
10550  5741          JMP I   XMUST1  /YES-RETN.
10551  6203  SXER,   CDF CIF 0
10552  5774          JMP I   (SXERR  /GIVE THE ERR

10553  0000  INPSET, 0
10554  3561          DCA I   [DRTI   /AC=0:NOT RUNTIME INPUT--AC=7777:R/T INPUT
10555  7240          CLA     CMA
10556  3773          DCA I   (ICOUNT /SET BUFFER EMPTY
10557  3772          DCA I   (RIP    /SET NO READS IN PROGRESS
10560  7326          CLA CLL CML RTL /SET INPUT DEV. TO CASSETTE
10561  3576          DCA I   [INDEV
10562  7240          CLA     CMA
10563  3560          DCA I   [CGET   /SET FLAG-NO EOF ON INPUT YET
10564  5753          JMP I   INPSET  /RETN.


/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 43



10572  6661
10573  6662
10574  6441
10575  7706
10576  0100
10577  0275
       0600  *600

10600  0000  FILNAM, 0
10601  1600          TAD I   FILNAM  /PICK UP ADDR. AT WHICH TO STORE NAME
10602  2200          ISZ     FILNAM
10603  3247          DCA     PWHERE
10604  1377          TAD     (-50    /MAX. OF 40 CHARS. ON LINE
10605  3363          DCA     PAKBUF
10606  3246  FIL1,   DCA     CCNTR   /CLEAR CHAR COUNTER
10607  4557  GNEXT,  JMS I   [CHRGET /GET A CHAR.
10610  3003          DCA     TEMP
10611  1003          TAD     TEMP
10612  1156          TAD     [7603   /IS IT ALTMODE?--175
10613  7450          SNA
10614  5244          JMP     FALT    /YES-RETN TO EDIT MODE
10615  1155          TAD     [36     /NO-IS IT BACKARROW?
10616  7440          SZA
10617  5225          JMP     DQUOTE  /NO-SEE IF DOUBLE QUOTE
10620  7040          CMA             /YES-DELETE LAST CHAR.
10621  1246          TAD     CCNTR   /BUT DON'T GO BACK PAST BUFF. STRT.
10622  7510          SPA
10623  7200          CLA             /CCNTR CAN'T BE LESS THAN 0
10624  5206          JMP     FIL1
10625  1154  DQUOTE, TAD     [75     /IS IT DOUBLE QUOTE(242)?
10626  7450          SNA
10627  5251          JMP     NAMCHK  /YES-TREAT AS CAR. RETN.
10630  1376          TAD     (122-75 /NO-IS IS CARRETN?
10631  7450          SNA
10632  5251          JMP     NAMCHK  /YES-CHECK NAME VALIDITY
10633  1153          TAD     [7715
10634  0375          AND     (140
10635  7440          SZA             /PRINTING CHAR?
10636  1322          TAD     P7640
10637  7640          SZA     CLA     
10640  5207          JMP     GNEXT
10641  1003  CHAROK, TAD     TEMP    /NO-CHAR. OK
10642  4347          JMS     STOBUF  /STORE IN BUFFER
10643  5207          JMP     GNEXT   /GET NEXT
10644  6203  FALT,   CDF CIF 0
10645  5774          JMP I   (FILALT

10646  0000  CCNTR,  0
10647  0000  PWHERE, 0
10650  0000  DONSW,  0

10651  1174  NAMCHK, TAD     [15     /FIRST STORE C. RETN. IN BUFFER TO
10652  4347          JMS     STOBUF  /END NAME

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 43-1

10653  7040          CMA             /SET PERIOD SWITCH=-1
10654  3347          DCA     PERSW
10655  1152          TAD     [LINBUF+1       /SET POINTER FOR PICKING UP CHARS.
10656  3036          DCA     GTPTR
10657  1436          TAD I   GTPTR   /GET A CHAR. (FIRST ONE)
10660  1151          TAD     [-133   /CHECK TO INSURE ITS ALPHABETIC
10661  7100          CLL
10662  1150          TAD     [32
10663  7620          SNL     CLA
10664  5346          JMP     FERR    /NOPE-ERROR
10665  4363          JMS     PAKBUF  /ITS OK-PACK IT OFF TO FINAL RESTING PLACE
10666  1147          TAD     [-5     /SET CHAR COUNTER FOR MAX OF 5
10667  3246          DCA     CCNTR   /MORE CHARS. IN NAME  (EXCLUDING EXTENSION)
10670  7040          CMA             /SET SWITCH-WE'RE DECODING NAME
10671  3250          DCA     DONSW   /NOT EXTENSION
10672  2036  GETCHR, ISZ     GTPTR   /GET NEXT CHAR.
10673  1436          TAD I   GTPTR
10674  1167          TAD     [7763   /IS IT CAR. RTN.
10675  7450          SNA
10676  5341          JMP     PADDON  /YES-GO PAD NAME IF NECESSARY-DONE
10677  1146          TAD     [15-133 /NO-IS IT ALPHABETIC
10700  7100          CLL
10701  1150          TAD     [32
10702  7420          SNL
10703  5326          JMP     NUMCHK  /NO-SEE IF NUMERIC
10704  7200  STORCH, CLA             /ALPHABETIC-STORE IT
10705  4363          JMS     PAKBUF
10706  2246          ISZ     CCNTR   /BUMP COUNTER-DONE NAME(OR EXTEN.)?
10707  5272          JMP     GETCHR  /NO-GO ON
10710  2250          ISZ     DONSW   /YES-DONE NAME +EXTENSION?
10711  5345          JMP     DONEN   /YES-DONE ALL
10712  7346  GETCR,  CLA CLL CMA RTL /NO-SET COUNTER FOR 3 LETTER EXT.
10713  3246          DCA     CCNTR
10714  2036          ISZ     GTPTR   /DIDN'T GET PERIOD YET-SO IGNORE
10715  1436          TAD I   GTPTR   /MORE THAN 6 CHAR. NAME
10716  1167          TAD     [7763   /CAR. RETN?
10717  7450          SNA
10720  5341          JMP     PADDON  /YES-GO CLEAN UP
10721  1145          TAD     [15-56  /NO-DID HE TYPE PERIOD?
10722  7640  P7640,  SZA     CLA
10723  5312          JMP     GETCR   /NO-IGNORE IT
10724  3347          DCA     PERSW   /YES-CLR. PERIOD SWITCH-NOW WE'RE
10725  5272          JMP     GETCHR  /ACCEPTING EXTENSION

10726  1144  NUMCHK, TAD     [101-72 /IS CHAR. A NUMBER?
10727  7100          CLL
10730  1143          TAD     [12
10731  7430          SZL
10732  5304          JMP     STORCH  /YES-GO STORE IT
10733  1142          TAD     [2      /NO-IS IT PERIOD?
10734  7650          SNA     CLA
10735  2347          ISZ     PERSW   /YES-IS IT FIRST PERIOD?
10736  5346          JMP     FERR    /NO-EROR-BAD CHAR.
10737  4773          JMS I   (PAD    /FIRST PER.-PAD NAME IF NECESSARY
10740  5271          JMP     GETCHR-1        /GET NEXT CHR.

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 43-2

10741  4773  PADDON, JMS I   (PAD    /DONE NAME-PAD IF NECESSARY
10742  2250          ISZ     DONSW   /DONE EXTENSION?
10743  5345          JMP     DONEN   /YES-DONE ALL
10744  5341          JMP     PADDON  /NO-PAD OUT EXT.
10745  2200  DONEN,  ISZ     FILNAM  /DONE-BUMP RETN TO CALL+3
10746  5600  FERR,   JMP I   FILNAM  /RETN( TO CALL+2 IF ERR.)


10747  0000  STOBUF, 0
10750  3003          DCA     TEMP    /STOR CHAR IN TEMP
10751  2363          ISZ     PAKBUF  /TOO MANY CHARS?
10752  7410          SKP             /NOPE
10753  5346          JMP     FERR    /YUP-GIVE ERROR RETN.
10754  2246          ISZ     CCNTR   /BUMP CHAR COUNTER
10755  1141          TAD     [LINBUF /CALCULATE BUFFER ADDR.
10756  1246          TAD     CCNTR
10757  3021          DCA     UTEM1
10760  1003          TAD     TEMP    /GET CHAR.
10761  3421          DCA I   UTEM1   /AND STORE
10762  5747          JMP I   STOBUF

       0747  PERSW=STOBUF

10763  0000  PAKBUF, 0
10764  1436          TAD I   GTPTR   /GET CHAR. TO STORE
10765  1140          TAD     [200    /MAKE IT 8 BIT ASCII
10766  3647          DCA I   PWHERE  /STORE WHERE IT SHOULD GO
10767  2247          ISZ     PWHERE  /BUMP POINTER
10770  5763          JMP I   PAKBUF  /RETN.


10771  3777  QMK,    TEXT'_?_'
10772  3700

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 44


10773  0347
10774  0367
10775  0140
10776  0025
10777  7730
       1000  *1000
11000  4422  SAVE,   ISIT1
11001  3731          3731            /SAVE?
11002  5247          JMP     NEW     /NO-TRY NEW
11003  1032          TAD     NAMER   /NAME IS IN NAMLOC OR IONAM
11004  4540          JMS I   [SETINCH        /YES-SET UP THE IN CORE HEADER
11005  4777          JMS I   (GETUNIT
11006  4776          JMS I   (ENTER  /ENTER FILE ON CASSETTE
11007  5537          JMP I   [LKERR  /ERROR WHILE ENTERING FILE
11010  1540          TAD I   [SETINCH        /GET UNIT #
11011  6201          CDF     0
11012  3536          DCA I   [OUNIT  /STORE FOR CASSETTE ROUTINE
11013  1375          TAD     (BUFST  /SET UP BUFFER PTR.
11014  3535          DCA I   [KBUFST
11015  1374          TAD     (BUFEND
11016  3534          DCA I   [KBUFEND        /INSURE WE USE RIGHT BUFFER!
11017  7126          CLL CML RTL
11020  3573          DCA I   [OUTDEV /SET OUTPUT TO CASSETTE
11021  7201          CLA     IAC
11022  3572          DCA I   [OUTD2  /OUTPUT TO TTY AFTER SAVE
11023  4226          JMS     OUPSET  /SET UP FOR OUTPUT
11024  6202          CIF     0
11025  5773          JMP I   (LISTALL        /SAVE=LIST TO CASSETTE
11026  0000  OUPSET, 0
11027  7240          CLA     CMA
11030  3772          DCA I   (OCOUNT
11031  1371          TAD     (OCASERR        /SET UP ERROR RETN.
11032  3770          DCA I   (OERR
11033  7240          CLA     CMA
11034  3435          DCA I   POIP    /SET OUTPUT IN PROGRESS
11035  6211          CDF     10
11036  5626          JMP I   OUPSET  /RETN.

11037  4422  NAME,   ISIT1
11040  3726          3726            /NAME?
11041  5355          JMP     IMMEDA  /NO-MUST BE IMMEDIATE MODE
11042  4323          JMS     COMON   /YES-DO IT
11043  4023  NM1,    JMS     MPRINT
11044  5257          CRLFD
11045  6202          CIF 0
11046  5767          JMP I   (EDIT   /BACK TO EDIT PHASE

11047  4422  NEW,    ISIT1
11050  3727          3727            /NEW?
11051  5257          JMP     OLD     /NO-TRY OLD
11052  4323  NEWDO,  JMS     COMON   /YES-DO IT-
11053  4023          JMS     MPRINT
11054  5257          CRLFD
11055  6202          CIF 0

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 44-1

11056  5766          JMP I   (SCRATCH        /DO A SCRATCH

11057  4422  OLD,    ISIT1
11060  3730          3730            /IS IT OLD?
11061  5237          JMP     NAME    /NO-TRY NAME
11062  7325  OLDDO,  CLA CLL CML IAC RAL     /YES-GET OLD PROG. NAME(+3 IN AC)
11063  4323          JMS     COMON
11064  4777          JMS I   (GETUNIT        /GET UNIT NUMBER
11065  6201          CDF     0
11066  3533          DCA I   [IUNIT  /STORE AWAY
11067  1132          TAD     [ICASERR
11070  3765          DCA I   (IERR   /SET UP ERROR RETN.
11071  1364          TAD     (STOP   /TYPE READY WHEN GET E O F
11072  3763          DCA I   (EOFRTN /SET UP END OF FILE RETN.
11073  1533          TAD I   [IUNIT
11074  6211          CDF      10
11075  4531          JMS I   [LOOK   /LOOK UP THE FILE
11076  0216          NAMLOC          /FILE NAME IS IN NAMLOC
11077  5350          JMP     NTFND   /NOT FOUND-ERROR
11100  6201  OLD3,   CDF
11101  4530          JMS I   [INPSET /SET UP FOR INPUT--NOT RUNTIME!!
11102  4762          JMS I   (SCRAT1 /DO A SCRATCH ALMOST
11103  6211          CDF     10
11104  6202          CIF     0
11105  5761          JMP I   (RUN    /AND GO ON

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 45




             /
             /THESE 2 LINES MUST BE IN THIS ORDER-SEE OLDDO
             /
11106  3716  NEWMES, TEXT '_NEW '
11107  0527
11110  4000
11111  3717  OLDMES, TEXT '_OLD '
11112  1404
11113  4000
11114  2022  PROGNA, TEXT 'PROGRAM NAME-'
11115  1707
11116  2201
11117  1540
11120  1601
11121  1505
11122  5500

11123  0000  COMON,  0
11124  7421          MQL             /SAVE AC FOR A FLASH
11125  6201          CDF 0           /MUST BE FLD ZERO DUMMY!
11126  7201          CLA     IAC     /INSURE OUTPUT IS TTY
11127  3573          DCA I   [OUTDEV
11130  7201          CLA     IAC
11131  3572          DCA I   [OUTD2
11132  7501          MQA             /GET AC BACK
11133  4023          JMS     MPRINT  /PRINT MESSAGE
11134  1106          NEWMES
11135  4023  ASKAGN, JMS     MPRINT
11136  1114          PROGNA
11137  3760          DCA I   (GTJMP1 /GET CHARS FROM KBD.
11140  4562          JMS I   [FILNAM /GET FILE NAME-STORE IN NAMLOC
11141  0216          NAMLOC
11142  5345          JMP     TYQUES  /ERROR-ASK AGAIN
11143  3032          DCA     NAMER   /0=NAME OF PROG IS IN NAMLOC
11144  5723          JMP I   COMON   /DONE-RETN.

11145  4023  TYQUES, JMS     MPRINT
11146  0771          QMK
11147  5335          JMP     ASKAGN  /MUST HAVE A PROGRAM NAME!

11150  4023  NTFND,  JMS     MPRINT
11151  1111          OLDMES
11152  4023          JMS     MPRINT
11153  0507          NFMES
11154  5243          JMP     NM1

11155  6202  IMMEDA, CIF 0
11156  5757          JMP I   (IMMED


/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 46


11157  1155
11160  0420
11161  2457
11162  0332
11163  6650
11164  2401
11165  6663
11166  2445
11167  2412
11170  6757
11171  2574
11172  6761
11173  3610
11174  6200
11175  6000
11176  6404
11177  0240
       1200  *1200
       1200  NULIM=OPEN1             /LIMIT OF USER CODE IF NO RUNTIME I/O

11200  4434  OPEN1,  GET+MSTBE1      /NEXT ELEMENT MUST BE TEXT
11201  5000          5000
11202  1032          TAD     NAMER
11203  7650          SNA     CLA     /WAS THIS PROG. SEGMENT CHAINED TO?
11204  5220          JMP     NTCHAN  /NOPE
11205  1377          TAD     (-11    /YES-THEN ITS NAME IS IN IONAM-MOVE
11206  3301          DCA     CNTO    /IT TO NAMLOC IN CASE HE SHOULD DO A
11207  1376          TAD     (NAMLOC-1       / 'SAVE' WITHOUT FIRST DOING
11210  3010          DCA     X10     /A 'NAME'-SAVE IT WITH SAME NAME AS IT HAD
11211  1375          TAD     (IONAM-1
11212  3011          DCA     XREG2
11213  1411          TAD I   XREG2
11214  3410          DCA I   X10
11215  2301          ISZ     CNTO
11216  5213          JMP     .-3
11217  3032          DCA     NAMER   /CLR. NAMER LOC.
11220  4774  NTCHAN, JMS I   (CNAMST /DONE-GET UNIT # AND FILE NAME FROM CORE
11221  5356          JMP     FILNR   /ERROR-BAD UNIT OR NAME
11222  3301          DCA     IOUNIT  /STORE UNIT #
11223  4404          JMS I   UJMS    /GET NEXT ELEMENT OF PSEUDO-CODE
11224  0177          GETWD
11225  6201          CDF 0           /IS IT LAST WORD OF TEXT STMT?
11226  1565          TAD I   [WORD
11227  6211          CDF 10
11230  7640          SZA     CLA
11231  5234          JMP     .+3     /NOPE
11232  4404          JMS I   UJMS    /YUP
11233  0177          GETWD           /SKIP IT
11234  4433          MSTBE1          /MUST BE 'FOR'
11235  1772          1772
11236  4404          JMS I   UJMS
11237  0177          GETWD
11240  4422          ISIT1           /IS IT 'INPUT'
11241  1767          1767

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 46-1

11242  5302          JMP     FROUT   /NO-MUST BE 'FOR OUTPUT'
11243  1132  FRINP,  TAD     [ICASERR        /RESET ERROR AFTER WAIT
11244  4404          JMS I   UJMS    /WAIT FOR ALL POSSIBLE READS
11245  6600          WAITR
11246  6201          CDF     0
11247  1435          TAD I   POIP    /IS A RUNTIME OUTPUT FILE OPEN?
11250  7700          SMA     CLA
11251  5261          JMP     FRINP1  /NOPE
11252  1301          TAD     IOUNIT  /YUP -SAME UNIT AS HE WANTS NOW??
11253  7041          CMA     IAC     
11254  1536          TAD I   [OUNIT  /(UNIT # IS IN FLD 0)
11255  7640          SZA     CLA
11256  5261          JMP     FRINP1  /NOPE-OK
11257  6203  IAO,    CDF CIF 0       /YES-GIVE ERROR-CLOSE OUTPUT FILE
11260  5773          JMP I   (IANDO
11261  1132  FRINP1, TAD     [ICASERR        /SET UP RETN. FOR READ ERR.
11262  3772          DCA I   (IERR
11263  7040          CMA             /FLAG-DOING RUNTIME INPUT
11264  4530          JMS I   [INPSET /GO SET UP FOR INPUT
11265  7201          CLA     IAC     /SET INPUT TO TTY
11266  3576          DCA I   [INDEV
11267  1301          TAD     IOUNIT
11270  3533          DCA I   [IUNIT  /STORE # OF RUN-TIME INPUT UNIT
11271  6211          CDF 10
11272  1301          TAD     IOUNIT  /GET THE UNIT #
11273  4531          JMS I   [LOOK   /LOOK UP THE FILE
11274  0227          IONAM           /NAME IS IN IONAM
11275  5354          JMP     OPNERR  /NOT FOUND-GIVE ERROR
11276  6202          CIF 0
11277  6211          CDF 10
11300  5771          JMP I   (EXECUTE        /FOUND-GO ON

11301  0000  IOUNIT, 0
       1301  CNTO=IOUNIT


/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 47


11302  4433  FROUT,  MSTBE1          /MUST BE 'OUTPUT'
11303  1743          1743
11304  6201          CDF 0
11305  7201          CLA     IAC     /IS A RUNTIME OUTPUT FILE OPEN?
11306  1435          TAD I   POIP
11307  6211          CDF 10
11310  7640          SZA     CLA
11311  5314          JMP     NOPE
11312  6203  LKER,   CDF CIF 0
11313  5770          JMP I   (LOOKER /GIVE ERROR AND CLOSE IT
11314  1367  NOPE,   TAD     (IONAM-NAMLOC
11315  4540          JMS I   [SETINCH        /SET UP INCH FROM IONAM
11316  6201          CDF 0
11317  1533          TAD I   [IUNIT  /IS A RUN-TIME INPUT FILE OPEN-SAME UNIT?
11320  7041          CMA     IAC
11321  1301          TAD     IOUNIT
11322  7640          SZA     CLA
11323  5332          JMP     OUTOK   /NOPE
11324  1561          TAD I   [DRTI   /YES-IS HE REALLY DOING RT INPUT
11325  7650          SNA     CLA
11326  5332          JMP     OUTOK   /NO
11327  1560          TAD I   [CGET   /YES-IS HE AT EOF
11330  7640          SZA     CLA
11331  5257          JMP     IAO     /NO-GIVE AN 'I&O' ERROR
11332  1366  OUTOK,  TAD     (OCASERR        /YES-RESET ERROR RETN AFTER WAIT
11333  4404          JMS I   UJMS
11334  6600          WAITR           /WAIT FOR ALL I/O BEFORE ENTER
11335  6211          CDF  10
11336  1301          TAD     IOUNIT  /ENTER FILE ON CASSETTE
11337  4765          JMS I   (ENTER
11340  5312          JMP     LKER    /ERROR
11341  1301          TAD     IOUNIT  /OK-STORE IOUNIT IN OUTPUT CAS. ROUTINE
11342  6201          CDF     0
11343  3536          DCA I   [OUNIT
11344  4764          JMS I   (OUPSET /SET UP FOR OUTPUT

11345  6203          CDF     CIF 0
11346  1363          TAD     (RTBUF
11347  3535          DCA I   [KBUFST
11350  1362          TAD     (RTBFND
11351  3534          DCA I   [KBUFEND        /CHANGE THE BUFFER TO BE USED
11352  6211          CDF 10
11353  5771          JMP I   (EXECUTE        /GO ON

11354  6203  OPNERR, CDF CIF 0
11355  5761          JMP I   (LERR
11356  6203  FILNR,  CDF CIF 0
11357  5760          JMP I   (BADCHN

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 48



11360  7064
11361  3355
11362  1600
11363  1400
11364  1026
11365  6404
11366  2574
11367  0011
11370  7310
11371  0213
11372  6663
11373  6764
11374  0452
11375  0226
11376  0215
11377  7767
       1400  PAGE
             /RUNTIME I/O BUFFER (OUTPUT) ONLY USED
             /IF HE SAYS HE IS USING RUNTIME FILE I/O
11400  0000  RTBUF,  0
       1600  RTBFND=RTBUF+200
       1600  *RTBFND
11600  0000  LIMIT,  0       /LIMIT OF USER CODE IF RUNTIME I/O IS USED

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 49



/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 50


             //ONCE ONLY CODE FOR START UP
             /
       3000  *3000
13000  1377  STARTB, TAD     (CTRLC  /SET UP WHERE TO GO ON CTRL/C
13001  6201          CDF 0
13002  3776          DCA I   (CTRLCJ
13003  4404          JMS I   UJMS            /RESET SOME STUFF
13004  7072          RESET1
13005  4023  ST,     JMS     MPRINT
13006  3103          RTIOMES
13007  4775          JMS I   (GETIT  /GET AND PRINT HIS REPLY
13010  3302          DCA     TEMPS   /STORE IT
13011  4775          JMS I   (GETIT  /MUST TYPE C.R. NOW
13012  1167          TAD     [7763
13013  7640          SZA     CLA
13014  5205          JMP     ST      /NOPE-ASK AGAIN
13015  4023          JMS     MPRINT  /TYPE CR/LF
13016  5257          CRLFD
13017  1302          TAD     TEMPS
13020  1374          TAD     (-"Y!200
13021  7650          SNA     CLA
13022  5240          JMP     NOCHNG  /YES-NO CHANGES TO BASICK
13023  1373  CHNG,   TAD     (NULIM  /NO-RESET LIMIT OF USER PROG.
13024  6201          CDF     0
13025  3772          DCA I   (PLIMIT
13026  1371          TAD     (FIOER  /SET FILE I/0 COMMANDS TO GIVE ERROR
13027  3770          DCA I   (PRN
13030  1147          TAD     [-5
13031  3003          DCA     TEMP
13032  1367          TAD     (PENDN
13033  3010          DCA     X10
13034  1371          TAD     (FIOER
13035  3410          DCA I   X10
13036  2003          ISZ     TEMP
13037  5234          JMP     .-3
13040  4023  NOCHNG, JMS     MPRINT
13041  3124          NWOLMS          /PRINT 'NEW OR OLD--'
13042  4766  DOSCRT, JMS I   (SCRAT1 /SCRATCH!
13043  4404          JMS I   UJMS
13044  7072          RESET1
13045  4404          JMS I   UJMS    /IN CASE HE TYPES A REAL LINE OF BASIC
13046  2464          CLEARV          /CODE IN  GETLIN ROUTINE
13047  1365          TAD     (XXTHEN
13050  4404          JMS I   UJMS
13051  2602          GETLIN          /GET A LINE OF INPUT
13052  1541          TAD I   [LINBUF
13053  3021          DCA     UTEM1
13054  1021          TAD     UTEM1
13055  6201          CDF     0
13056  3565          DCA I   [WORD
13057  6211          CDF     10
13060  1421          TAD I   UTEM1
13061  7650          SNA     CLA
13062  5240          JMP     NOCHNG  /BAD REPLY-ASK AGAIN

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 50-1

13063  4023          JMS     MPRINT  /PRINT CR/LF
13064  5257          CRLFD
13065  6201          CDF     0
13066  1572          TAD I   [OUTD2
13067  3573          DCA I   [OUTDEV
13070  6211          CDF     10
13071  1421          TAD I   UTEM1
13072  1364          TAD     (3727   /DID HE SAY NEW?
13073  7650          SNA     CLA
13074  5763          JMP I   (NEWDO
13075  1421  TRYOLD, TAD I   UTEM1
13076  1362          TAD     (3730
13077  7640          SZA     CLA     /IS IT OLD?
13100  5240          JMP     NOCHNG  /NO-ASK AGAIN
13101  5761          JMP I   (OLDDO  /YES-DO IT

13102  0000  TEMPS,  0
13103  3725  RTIOMES,        TEXT '_USING RUN-TIME FILE I/O?(Y OR N)'
13104  2311
13105  1607
13106  4022
13107  2516
13110  5524
13111  1115
13112  0540
13113  0611
13114  1405
13115  4011
13116  5717
13117  7750
13120  3140
13121  1722
13122  4016
13123  5100
13124  3716  NWOLMS, TEXT '_NEW OR OLD-'
13125  0527
13126  4017
13127  2240
13130  1714
13131  0455
13132  0000

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 51







13161  1062
13162  3730
13163  1052
13164  3727
13165  5305
13166  0332
13167  0271
13170  0243
13171  7135
13172  2566
13173  1200
13174  7647
13175  0275
13176  7604
13177  0005
       5111          *5111

15111  0000  PERMSYM,0
15112  4200  XXPLUS, 4200;TEXT '+'
15113  5300
15114  4201  XXMINUS,4201;TEXT '-'
15115  5500
15116  4302  XXSTAR, 4302;TEXT '*'
15117  5200
15120  4303  XXSLASH,4303;TEXT '/'
15121  5700
15122  4404  XXUPARR,4404;TEXT '^'
15123  3600
15124  4110  XXLE,   4110;TEXT '<='
15125  7475
15126  0000
15127  4111  XXGE,   4111;TEXT '>='
15130  7675
15131  0000
15132  4112  XXNE,   4112;TEXT '<>'
15133  7476
15134  0000
15135  4111  XXEG,   4111;TEXT '=>'
15136  7576
15137  0000
15140  4110  XXEL,   4110;TEXT '=<'
15141  7574
15142  0000
15143  4105  XXEQ,   4105;TEXT '='
15144  7500
15145  4106  XXLT,   4106;TEXT '<'
15146  7400
15147  4107  XXGT,   4107;TEXT '>'
15150  7600

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 51-1

15151  4015  XXCOMMA,4015;TEXT ','
15152  5400
15153  4016  XXSEMI, 4016;TEXT ';'
15154  7300
15155  4017  XXCLOSE,4017;TEXT ')'
15156  5100
15157  4017  XXRBRAK,4017;TEXT ']'
15160  3500
15161  4023  XXOPEN, 4023;TEXT '('
15162  5000
15163  4023  XXLBRAK,4023;TEXT '['
15164  3300
15165  4021  XXTO,   4021;TEXT ' TO '
15166  4024
15167  1740
15170  0000
15171  4022  XXSTEP, 4022;TEXT ' STEP '
15172  4023
15173  2405
15174  2040
15175  0000
15176  4024  XXFN,   4024;TEXT 'FN'
15177  0616
15200  0000
15201  4025  XXCOS,  4025;TEXT 'COS'
15202  0317
15203  2300
15204  4026  XXTAN,  4026;TEXT 'TAN'
15205  2401
15206  1600
15207  4027  XXATN,  4027;TEXT 'ATN'
15210  0124
15211  1600
15212  4030  XXLOG,  4030;TEXT 'LOG'
15213  1417
15214  0700
15215  4031  XXEXP,  4031;TEXT 'EXP'
15216  0530
15217  2000
15220  4032  XXSQR,  4032;TEXT 'SQR'
15221  2321
15222  2200
15223  4033  XXABS,  4033;TEXT 'ABS'
15224  0102
15225  2300
15226  4034  XXSGN,  4034;TEXT 'SGN'
15227  2307
15230  1600
15231  4035  XXINT,  4035;TEXT 'INT'
15232  1116
15233  2400
15234  4036  XXRND,  4036;TEXT 'RND'
15235  2216
15236  0400
15237  4037  XXSIN,  4037;TEXT 'SIN'

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 51-2

15240  2311
15241  1600
15242  4040  XXPUT,  4040;TEXT 'PUT'
15243  2025
15244  2400
15245  4041  XXGET,  4041;TEXT 'GET'
15246  0705
15247  2400
15250  4042  XXTAB,  4042;TEXT 'TAB'
15251  2401
15252  0200
15253  4043  XXUUF,  4043;TEXT 'UUF'
15254  2525
15255  0600
15256  6000  XXCRLF, 6000;TEXT '_'
15257  3700
15260  6000  XXBSLSH,6000;TEXT '\'
15261  3400
15262  6001  XXPRNTN, 6001; TEXT 'PRINT# '
15263  2022
15264  1116
15265  2443
15266  4000
15267  6002  XXPRINT, 6002; TEXT 'PRINT '
15270  2022
15271  1116
15272  2440
15273  0000
15274  6003  XXLET,  6003; TEXT 'LET '
15275  1405
15276  2440
15277  0000
15300  6004  XXGOTO, 6004;TEXT 'GO TO '
15301  0717
15302  4024
15303  1740
15304  0000
15305  6004  XXTHEN, 6004;TEXT ' THEN '
15306  4024
15307  1005
15310  1640
15311  0000
15312  6005  XXIF,   6005;TEXT 'IF '
15313  1106
15314  4000
15315  6006  XXFOR,  6006; TEXT 'FOR '
15316  0617
15317  2240
15320  0000
15321  6010  XXGOSUB, 6010; TEXT 'GOSUB '
15322  0717
15323  2325
15324  0240
15325  0000
15326  6007  XXNEXT, 6007;TEXT 'NEXT '

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 51-3

15327  1605
15330  3024
15331  4000
15332  6030  XXINPTN, 6030;TEXT 'INPUT# '
15333  1116
15334  2025
15335  2443
15336  4000
15337  6011  XXINPUT, 6011; TEXT 'INPUT '
15340  1116
15341  2025
15342  2440
15343  0000
15344  6012  XXRETRN,6012;TEXT 'RETURN'
15345  2205
15346  2425
15347  2216
15350  0000
15351  6013  XXSTOP, 6013;TEXT 'STOP'
15352  2324
15353  1720
15354  0000
15355  6014  XXDIM,  6014;TEXT 'DIM '
15356  0411
15357  1540
15360  0000
15361  6015  XXRSTOR,6015;TEXT 'RESTORE'
15362  2205
15363  2324
15364  1722
15365  0500
15366  6016  XXREM,  6016;TEXT 'REM '
15367  2205
15370  1540
15371  0000
15372  6017  XXDEF,  6017;TEXT 'DEF '
15373  0405
15374  0640
15375  0000
15376  6020  XXREAD, 6020;TEXT 'READ '
15377  2205
15400  0104
15401  4000
15402  6021  XXDATA, 6021;TEXT 'DATA '
15403  0401
15404  2401
15405  4000

15406  6027  XXENDN, 6027; TEXT 'END#'
15407  0516
15410  0443
15411  0000

             /
       5257  CRLFD=XXCRLF+1

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 51-4

             /
15412  6033  XXOPN,  6033;TEXT 'OPEN '
15413  1720
15414  0516
15415  4000
15416  6034  XXCLSE, 6034;TEXT 'CLOSE'
15417  0314
15420  1723
15421  0500
15422  6035  XXOUTPUT, 6035; TEXT 'OUTPUT'
15423  1725
15424  2420
15425  2524
15426  0000
15427  6036  XXCHAN, 6036; TEXT 'CHAIN '
15430  0310
15431  0111
15432  1640
15433  0000
15434  6024  XXEND, 6024;TEXT 'END'  
15435  0516
15436  0400
15437  6025  XXTTYO, 6025;TEXT 'TTY OUT'
15440  2424
15441  3140
15442  1725
15443  2400
15444  6026  XXLPT,  6026;TEXT 'LPT'
15445  1420
15446  2400
15447  6031  XXNCOM, 6031;TEXT 'NO COMMAS'
15450  1617
15451  4003
15452  1715
15453  1501
15454  2300
15455  6032  XXCOMAS, 6032;TEXT 'COMMAS'
15456  0317
15457  1515
15460  0123
15461  0000
15462  6037  XXRUB,  6037; TEXT 'RUBOUTS'
15463  2225
15464  0217
15465  2524
15466  2300
15467  6040  XXNRUB, 6040; TEXT 'NO RUBOUTS'
15470  1617
15471  4022
15472  2502
15473  1725
15474  2423
15475  0000
15476  4044  XXLIST, 4044;TEXT 'LIST'
15477  1411

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 51-5

15500  2324
15501  0000
15502  4044  XXLIS,  4044;TEXT 'LIS'
15503  1411
15504  2300
15505  4045  XXRUN,  4045;TEXT 'RUN'
15506  2225
15507  1600
15510  4046  XXSCR,  4046;TEXT 'SCR'
15511  2303
15512  2200
15513  4047  XXSAVE, 4047;TEXT 'SAVE'
15514  2301
15515  2605
15516  0000
15517  4047  XXSAV,  4047;TEXT 'SAV'
15520  2301
15521  2600
15522  4050  XXOLD,  4050;TEXT 'OLD'
15523  1714
15524  0400
15525  4051  XXNEW,  4051;TEXT 'NEW'
15526  1605
15527  2700
15530  4052  XXNAME, 4052;TEXT 'NAME'
15531  1601
15532  1505
15533  0000
15534  4052  XXNAM,  4052;TEXT 'NAM'
15535  1601
15536  1500


15537  0000          0


15540  3000  XXTEXT, 3000
15541  6023  XXEOF,  6023
15542  4113  XXUNARY,4113
15543  4014  XXFINI, 4014
15544  6022  XXEXIT, 6022
15545  2000  XXLIT0, 2000;2001;2002;2003
15546  2001
15547  2002
15550  2003
             NOPUNCH
15551  0000  LINBUF, ZBLOCK  51
15622  0000  LBEGIN, ZBLOCK  60
15702  0000  ENDLIN, 0
15703  0000  PDLIST, ZBLOCK  40
15743  0000  ENDPDL, 0
15744  0000  FORLIST,ZBLOCK  20
15764  0000  GOLIST, ZBLOCK  13
15777  0000  GSBEND, 0
                     ENPUNCH

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 52



             /
             /PAGE ZERO LITERALS FOR FIELD 1
             /

10130  0553
10131  0306
10132  5157
10133  6660
10134  6762
10135  6737
10136  6760
10137  0330
10140  0200
10141  5551
10142  0002
10143  0012
10144  0007
10145  7737
10146  7662
10147  7773
10150  0032
10151  7645
10152  5552
10153  7715
10154  0075
10155  0036
10156  7603
10157  0417
10160  6651
10161  6657
10162  0600
10163  7740
10164  0077
10165  0050
10166  0040
10167  7763
10170  0010
10171  7710
10172  0132
10173  0133
10174  0015
10175  0060
10176  0131
10177  0232
       0001  FIELD 1
       3000  *3000   /FOR SELF-STARTING BIN LOAD


             $

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 53

ABCDEF 1763      CLOSEO 1170      DWRIT  6731      FEXPI  6061
ABS    6425      CMSWCH 0176      ECHO   7023      FEXPU  6064
ACE    0025      CNAMST 0452      EDIT   2412      FHER   5117
ACN    4417      CNCLR  0141      END    2400      FILALT 0367
ACS    0024      CNERR  0501      ENDLIN 5702      FILNAM 0600
AC1    0020      CNTFND 7060      ENDNM  7332      FILNR  1356
AC2    0017      CNTLO  7407      ENDNUM 3321      FIL1   0606
AC3    0016      CNTLOZ 0134      ENDPDL 5743      FINDIT 0560
ADDRES 0071      CNTO   1301      ENTER  6404      FINDLU 0566
ALGNLP 4466      CODELO 0004      EOFAD  4526      FIOER  7135
ALLOC  1460      COLUMN 0130      EOFRTN 6650      FIX    4744
ALL3   3140      COMCK  2277      EPTR   0060      FIXEXI 4773
ALTMOD 2661      COMMAS 6175      ERROR  4136      FIXITU 5200
AL1    4654      COMMON 3377      EVAL   1000      FIXLIN 2135
AMATCH 6506      COMON  1123      EVALGO 1004      FIXLUP 4750
ANORM  4600      CONST  1367      EXECUT 0213      FIXUP  5143
ARGERR 7247      COREIN 0423      EXIT   2407      FJMP   1000
ARRLOC 0003      COS    5616      EXP    6000      FJMPI  1400
AR1    4402      COWT   7143      EXPGOO 5242      FJUMP  1130
ASKAGN 1135      CRINTX 3073      EXPLON 5764      FLD    3000
ATLINE 6451      CRLF   6531      EXPOK  5265      FLDI   3400
ATN    6200      CRLFD  5257      EXTLOC 0224      FLOGC1 6172
ATNBIG 6265      CRLFPR 3736      FAD    4000      FLOGC2 6153
ATNLOW 6220      CTRLC  0005      FADEXT 1314      FLOGC3 6156
ATNNOT 6237      CTRLCJ 7604      FADI   4400      FLOGC4 6161
BADCHN 7064      CTRLZI 6652      FALT   0644      FMP    6000
BARROW 0764      CTRZCK 0113      FATNAX 6273      FMPI   6400
BCKWDS 4502      CTRZHP 0052      FATNC  6337      FMTENF 5121
BEGFIX 3760      CVTLOO 5022      FATNCH 6342      FMT1   5123
BKWD   0600      DATAER 1672      FATNCJ 6345      FMT2   5051
BREAK  6522      DECEXP 0043      FATNC1 6304      FMT3   5126
BSKIP  2735      DECFRA 3343      FATNC2 6307      FN     5453
BUFEND 6200      DEEPER 0530      FATNC3 6312      FNERR  5172
BUFST  6000      DEF    1575      FATNC4 6315      FNEXIT 1200
CAM    7621      DELETE 6501      FATNC5 6320      FOR    0415
CARRET 2664      DEVCOM 7354      FATNC6 6323      FORCT  0065
CASIN  6614      DIGIN  3221      FATNC7 6326      FORDON 0663
CASOUT 6703      DIGIN1 3222      FATNC8 6331      FORERR 0503
CCNTR  0646      DIGIT  3176      FATNC9 6334      FORLIM 0721
CGET   6651      DIGLUP 6557      FATNSX 6272      FORLIS 5744
CHAIN  7031      DIM    6472      FATNT  6276      FORSTE 0724
CHARNE 0051      DIMFLA 0034      FATNTT 6301      FORVAR 0454
CHAROK 0641      DIVLP  4705      FDIGIT 3335      FOUND  0576
CHECKW 2344      DIVXTE 3341      FDV    7000      FPADD  4456
CHKFIT 6400      DOITNO 1247      FDVI   7400      FPADDR 4304
CHNERR 3362      DONEN  0745      FENTER 4435      FPDIV  4667
CHNG   3023      DONSW  0650      FERR   0746      FPDOIT 4237
CHNMS  3363      DOSCRT 3042      FEXIT  0000      FPFLAG 0154
CHRGET 0417      DOTZER 6576      FEXPC1 6072      FPGOTO 4273
CKBRAK 0344      DPFLAG 3342      FEXPC2 6075      FPJMP  4317
CKCTRZ 4174      DQINTX 3162      FEXPC3 6100      FPJUMP 4274
CLEARV 2464      DQUOTE 0625      FEXPC4 6103      FPLAC  4351
CLEV   0505      DRTI   6657      FEXPC5 6106      FPLOOP 4202
CLOS   0036      DRTICK 7337      FEXPC6 6111      FPMUL  4530
CLOSE  6400      DVLOOP 5245      FEXPF  6067      FPNOAD 4270

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 53-1

FPOPER 4305      GETUNI 0240      INLUPF 0434      LETDO  0205
FPPGZ  4227      GETVAR 0303      INPLUP 4034      LETTER 3445
FPSKIP 4314      GETWD  0177      INPPTR 4076      LFXLUP 2331
FPSTO  4322      GLOOP  2711      INPSET 0553      LHALF  3067
FPSUB  4453      GNEXT  0607      INPTN  0272      LIMIT  1600
FPT    4200      GOBOTH 0534      INPUT  4007      LINBUF 5551
FPTEMP 4576      GOLIST 5764      INPUTN 7316      LINENO 0054
FPTR   0061      GOSUB  0507      INSERT 2027      LINFIX 2326
FPZDIV 4736      GOTEMP 0055      INSRT5 2025      LIST   3600
FRINP  1243      GOTIT  7207      INT    6434      LISTAL 3610
FRINP1 1261      GOTIT1 7210      INWDTM 4136      LISTLU 3612
FRNDX  5404      GOTO   0521      IONAM  0227      LISTSO 3611
FROUT  1302      GOTOPR 1202      IOUNIT 1301      LIST2  3636
FRSTNE 2101      GOTSS  1071      IPNOPE 4024      LIST3  3655
FSB    5000      GOTSTE 0634      ISDEF2 3511      LIST4  3661
FSBI   5400      GOUT   7244      ISDIG  6532      LIST5  3676
FSEQ   0050      GPTR   0062      ISDIM  1472      LITRAL 3123
FSGE   0100      GRB    7223      ISIT   4564      LJMS   7255
FSGT   0140      GRDELA 7221      ISITDF 0551      LKER   1312
FSINC1 5713      GSBEND 5777      ISITFU 1105      LKERR  0330
FSINC3 5716      GSBPTR 0163      ISITLI 4100      LLSOUT 7400
FSINC4 5721      GSS1   1555      ISIT1  4422      LNOEND 3626
FSINC5 5724      GSS2   1556      ISLIT  4127      LOADED 4123
FSINC6 5727      GTBKLP 1722      ISSOME 1643      LOCCTR 0045
FSINC7 5732      GTEMP  7270      ISUMIN 1010      LOCTEM 0671
FSINM4 5735      GTJMP  0442      ITSDEF 3513      LOCTMP 1677
FSINOK 5657      GTJMP1 0420      ITSDP  3217      LOG    6114
FSINZ  5705      GTPTR  0036      ITSE   3253      LOGACE 6165
FSINZZ 5710      HAF    0437      ITSOP  1220      LOGFWD 6164
FSIN10 5641      HALF   0451      ITSP   3270      LOGOKW 6167
FSLE   0150      HIGHWD 4333      IUNIT  6660      LOOK   0306
FSLT   0110      HLOOP  2677      JBPENT 3707      LOOKER 7310
FSNE   0040      HLOP1  2731      JISDIG 3344      LOOKUP 7002
FSQRX  5407      HLP    4163      JMATCH 2770      LOWLOC 2166
FST    2000      HNDLR  6600      JPUTCH 0763      LPTOUT 7347
FSTI   2400      HPTR   0063      JUST0  3142      LUKERR 0326
FTANT1 5677      IAMLES 2103      JUST0F 3152      LUNIT  0332
FTANT2 5702      IANDO  6764      JUST0P 3155      LUP    3404
FUNTAB 1131      IAO    1257      JUST1  3137      LUPF   0430
FUPRC1 5762      ICASER 5157      JUST2  3141      L4LUP  3664
FWD    0200      ICOUNT 6662      KBDIN  0421      MAYZER 4612
FXXPFX 6023      IERR   6663      KBDINP 7626      MBREAK 7603
GALT   7242      IEXTLC 0235      KBUFEN 6762      MENDLI 0041
GDIM2  1557      IF     0372      KBUFST 6737      MENDPD 2361
GET    0001      IF1    0403      KEPTR  0077      MGOLIS 0720
GETADD 1400      IGNORE 2137      KEYWD  0231      MGSBEN 0527
GETBLK 1700      IMMED  1155      KIGNOR 1676      MINUS  1316
GETCH  7200      IMMEDA 1155      KM200  0072      MLBEGI 0171
GETCHR 0672      IN     3430      KM4004 2170      MLEND  0172
GETCR  0712      INCHN  7403      K5000  2167      MLINBU 0040
GETIT  0275      INDEV  0131      K6201  7005      MNSONE 0736
GETJ   1765      INDEX1 0014      LASERR 6612      MONITR 0100
GETLIN 2602      INDEX2 0015      LBEGIN 5622      MOREDI 6470
GETLRE 2577      INLCTM 4077      LERR   3355      MOREIN 4000
GETOPR 1012      INLOOP 0573      LET    0304      MORERD 1620

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 53-2

MOVE   2007      NOTSGN 3271      O11    0506      O7640A 0754
MOVLUP 2122      NOTTXT 2236      O110   2357      O7640B 2765
MPRINT 0023      NOTVAR 1102      O12    0067      O7673  3306
MPY    5321      NOTX10 5236      O122   2772      O77    0140
MPYLUP 4552      NOTYET 6741      O13    1562      O7700  2610
MSTBE1 4433      NSYMTA 0053      O14    2356      O7706A 6544
MTXXIT 3173      NTCHAN 1220      O140A  0762      O7706C 3472
MULCLR 4571      NTFND  1150      O140B  2745      O7715  2775
MULEXP 3367      NULIM  1200      O17    5144      O7725A 3075
MULXTE 3340      NUMBUF 5335      O1740  3352      O7725B 3346
MULX1  3371      NUMCHK 0726      O177   0027      O7737  3116
MUSTBE 4566      NWOLMS 3124      O1770  3353      O7740  0056
NAM    0322      OADD   4435      O2     0064      O7741  3743
NAMCHK 0651      OCASER 2574      O20    1151      O7743  4743
NAME   1037      OCC    5205      O200   0153      O7745  0160
NAMER  0032      OCOUNT 6761      O2040A 3350      O7753  3101
NAMLOC 0216      OERR   6757      O2062  5344      O7762  2325
NCTRLZ 6725      OIP    7357      O212   0175      O7763A 0761
NEW    1047      OJUMP  1276      O215   0174      O7763B 3076
NEWCHA 2622      OLD    1057      O23    1366      O7764A 1274
NEWDO  1052      OLDDO  1062      O233   3770      O7764B 3077
NEWLIN 2606      OLDKLG 2063      O240   0051      O7764C 3351
NEWMES 1106      OLDMES 1111      O253   5145      O7766  5151
NEXT   0600      OLDOP  0070      O255   5146      O7770  0057
NEXTER 0673      OLD3   1100      O256A  5153      O7771  5152
NEXTG  2757      ONE    0147      O256B  6575      O7772  5154
NEXTVA 0637      ONEDIM 1061      O260   0012      O7773  5346
NFMES  0507      ONESS  1073      O27    3345      O7774  1561
NFOPEN 6365      ONLY1  3312      O305   5147      O7776  3347
NM1    1043      OO7600 5452      O32    3115      PACN   4742
NOBUMP 4633      OO7736 2324      O36    2771      PAD    0347
NOCHNG 3040      OPDONE 1203      O3734  1152      PADDON 0741
NOCOM  6176      OPE    0030      O3737B 0776      PAKBUF 0763
NOCOMM 0327      OPEN   3575      O3755  1273      PAL1   0146
NOCR   4056      OPEN1  1200      O377   0073      PANORM 0144
NONBLN 3104      OPERAN 0075      O4     0156      PARGER 0047
NONZER 5014      OPNERR 1354      O40    2777      PAR1   0145
NOPARE 1032      OPOTAB 7016      O4014  1153      PASSCR 0474
NOPCR  2220      OPS    0026      O42    3103      PBARRO 2773
NOPE   1314      OPUTC  7147      O4200  3102      PBEGFI 1773
NORLFT 6423      OP1    0023      O4213  1154      PCCUNT 0744
NORMED 5220      OP2    0022      O5400  5347      PCHKFI 0161
NORMIT 5207      OP3    0021      O6203  0046      PCLOS  0143
NORUBO 5574      OTEMP  1271      O7     0074      PCOMMA 0273
NOSS1  1457      OTEMP1 7012      O700   1272      PCOWT  0137
NOSS2  1452      OTHER  3000      O7000A 2565      PDL    0036
NOT    3426      OUNIT  6760      O7000B 3473      PDLIST 5703
NOTBAD 2153      OUPSET 1026      O7077  1275      PEDIT  0122
NOTBIG 4620      OUTDEV 0133      O7520  5150      PENDN  0271
NOTCR  3023      OUTD2  0132      O7545  4777      PENDNM 0365
NOTEM  6626      OUTNUM 5000      O7570  6456      PERMSY 5111
NOTFUL 6712      OUTOK  1332      O7577  4577      PERROR 0101
NOTHER 0437      OV     0013      O7600  4345      PERSW  0747
NOTKWD 0305      O10    2171      O7603  2774      PEVAL  0103
NOTNOW 1776      O1000  3547      O7610  5345      PEXECU 0105

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 53-3

PEXP   5776      PRINBL 2302      RBSWCH 0135      SSFIX  4775
PFINDI 0672      PRINCO 2306      RCHR   6763      SSONE  0336
PFIX   0110      PRINEX 2215      READ   1622      SSTWO  0337
PFNERR 5546      PRINHA 2260      READIT 6664      ST     3005
PFPLOO 4575      PRINQU 2227      READLO 0046      STAR   1327
PGETAD 0104      PRINSE 2320      READY  6525      STARTB 3000
PGETBL 0117      PRINT  2172      RELATE 1342      STICKI 6430
PGETCH 0032      PRINTC 2207      REMPAC 3043      STOBUF 0747
PGETLI 0126      PRINTG 2206      REOFER 6700      STOP   2401
PGETLR 3022      PRINTH 2224      RESET1 7072      STORCH 0704
PGETOP 1376      PRINTN 7322      RESTOR 3771      STOVAR 0333
PGETVA 0115      PRINTX 3702      RETNER 0713      SXER   0551
PGOLIS 0162      PRINT2 2174      RETURN 0677      SXERR  6441
PGOTOP 0111      PRINUM 3745      RHALF  3071      TAB    5547
PHLP   0363      PRINVA 3651      RIGHT  0433      TABDES 6375
PIGNOR 0473      PRLOOP 3711      RIP    6661      TABDO  6350
PINT   5676      PRN    0243      RMLEFT 6413      TABFLG 2343
PISITL 0173      PROGNA 1114      RND    5353      TABL   3652
PLBEGI 0170      PRSUBR 3722      RNDJMP 5350      TABTHR 2360
PLETDO 0204      PRTEMP 0042      RTBFND 1600      TAN    5600
PLETTE 3100      PRTXRE 3720      RTBUF  1400      TBEGFI 5572
PLIMIT 2566      PSAVE  2463      RTIOME 3103      TEMP   0003
PLINBU 0037      PSGN   5675      RUBO   5573      TEMPS  3102
PLINFI 0157      PSKIPI 1616      RUN    2457      TEN    0000
PLIST  2570      PSLOOP 0120      RUNC   2456      THESKI 1353
PLITRA 3354      PSPACE 1560      RUNIN  2510      TLSOUT 7402
PLOG   5775      PSTICK 0123      RUNLUP 2472      TMP    0031
PLUS   1312      PSTOP  3776      RUNNOT 2504      TOOLON 5162
PMBREA 0364      PSTOVA 0114      RUN2IN 2550      TPRINT 6376
PMPY   5155      PSXERR 0102      RUN2LU 2521      TRALUP 2131
PNBF6  5156      PSYMTA 0052      RUN2NO 2544      TRANSF 2126
PNEWLI 1177      PTABDE 5570      SAVE   1000      TRYAGI 5131
PNONBL 0124      PTABFL 5571      SAVE1  2461      TRYAL  0270
PNOTNO 2573      PTABLE 2776      SCHMOR 1656      TRYALT 0271
PNUMBU 0044      PTEN   0150      SCRATC 2445      TRYOLD 3075
POADD  0155      PTEXT  0100      SCRAT1 0332      TRYSTE 0626
POIP   0035      PTUBIG 3021      SEARCH 1657      TTYO   7024
POP    4166      PUSERF 5545      SETINC 0200      TTYOUT 7350
POPERA 3121      PUSH   2362      SETSGN 4512      TUBIG  1173
POP3   4434      PUTCDF 7014      SGN    0726      TWIDTH 2355
POUTNU 0121      PUTCH  0741      SIMPLV 3465      TWOLF  3557
PPASSC 0112      PUTER  7000      SIN    5624      TWOSS  1074
PPDLIS 0127      PUTJ   3550      SJUMP  0241      TXTPAK 3046
PPERMS 2572      PWHERE 0647      SKIPIT 0471      TYQUES 1145
PPFLOO 4741      PXFORL 0557      SKPSYM 2762      UDOPER 1363
PPFORL 1764      PXLINB 3744      SLASH  1332      UGH1   3561
PPINT  6060      PXXCRL 3117      SLOOP  2675      UJMS   0004
PPOP   0107      PXXEOF 2571      SLSHTM 1337      UMOPER 1321
PPRINT 0116      PXXEXI 3120      SNUMFL 0066      UNDERF 4645
PPRINU 0125      PXXLIT 3122      SPACER 1163      UNIT   0012
PPUSH  0106      PXXTHE 2567      SPLEFT 0142      UPARRO 6457
PPUTCH 0033      PZERDO 6545      SQEXIT 5450      UPARRX 5740
PPXXEO 1162      P7640  0722      SQLOOP 5435      UPARR2 4365
PRENT  2315      QERROR 1571      SQR    5412      USERFN 1617
PRESET 0136      QMK    0771      SSERR  1563      UTEM   0411

/PDP-8/E CASSETTE BASIC                   PAL8-V10D NO DATE   PAGE 53-4

UTEM1  0021      XXINPT 5332      XXTTYO 5437      
UUJMP  0400      XXINPU 5337      XXUNAR 5542      
UUJMS  0401      XXINT  5231      XXUPAR 5122      
UUUJMS 0416      XXLBRA 5163      XXUUF  5253      
VAR    0335      XXLE   5124      X10    0010      
VARTEM 0554      XXLET  5274      ZCNTLO 7147      
VSCHIN 3523      XXLIS  5502      ZERDON 5142      
VSCHLU 3474      XXLIST 5476      ZERO   0150      
VSCHNO 3517      XXLIT0 5545      ZFIXEX 4767      
WAIT   6200      XXLOG  5212      
WAITR  6600      XXLPT  5444      
WDTEMP 1072      XXLT   5145      
WORD   0050      XXMINU 5114      
WTEM   6613      XXNAM  5534      
XEXECU 0414      XXNAME 5530      
XGISIT 7115      XXNCOM 5447      
XGMST1 0533      XXNE   5132      
XGMUST 7270      XXNEW  5525      
XISIT  7124      XXNEXT 5326      
XISIT1 0520      XXNRUB 5467      
XMUST  7277      XXOD1  0005      
XMUST1 0541      XXOD2  0006      
XREG2  0011      XXOD3  0007      
XRLOC  0010      XXOLD  5522      
XRPUT  0011      XXOPEN 5161      
XXABS  5223      XXOPN  5412      
XXATN  5207      XXOUTP 5422      
XXBSLS 5260      XXPLUS 5112      
XXCHAN 5427      XXPRIN 5267      
XXCLOS 5155      XXPRNT 5262      
XXCLSE 5416      XXPUT  5242      
XXCOMA 5455      XXRBRA 5157      
XXCOMM 5151      XXREAD 5376      
XXCOS  5201      XXREM  5366      
XXCRLF 5256      XXRETR 5344      
XXDATA 5402      XXRND  5234      
XXDEF  5372      XXRSTO 5361      
XXDIM  5355      XXRUB  5462      
XXEG   5135      XXRUN  5505      
XXEL   5140      XXSAV  5517      
XXEND  5434      XXSAVE 5513      
XXENDN 5406      XXSCR  5510      
XXEOF  5541      XXSEMI 5153      
XXEQ   5143      XXSGN  5226      
XXEXIT 5544      XXSIN  5237      
XXEXP  5215      XXSLAS 5120      
XXFINI 5543      XXSQR  5220      
XXFN   5176      XXSTAR 5116      
XXFOR  5315      XXSTEP 5171      
XXGE   5127      XXSTOP 5351      
XXGET  5245      XXTAB  5250      
XXGOSU 5321      XXTAN  5204      
XXGOTO 5300      XXTEXT 5540      
XXGT   5147      XXTHEN 5305      
XXIF   5312      XXTO   5165      



ERRORS DETECTED: 0
LINKS GENERATED: 0



