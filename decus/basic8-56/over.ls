
/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 1

             /SOURCE PROGRAM  BASIC.UF
             /OVERLAY FOR 'UF.8E', VERSION 26
             /DEC-8E-ALOSA-A-LA
             /RONALD JONES O.D.,PH.D.
             /THE OHIO STATE UNIVERSITY
             /COLLEGE OF OPTOMETRY
             /COLUMBUS, OHIO 43210
             /
       4000  FPP=4000
       6000  FADD=FPP+2000
       6117  FSUB=FPP+2117
       6130  FFNEG=FPP+2130
       5600  FMPY=FPP+1600
       5722  FDIV=FPP+1722
       6254  FFPUT=FPP+2254
       6237  FFGET=FPP+2237
       6213  FFNOR=FPP+2213
       5412  FFDIVI=5412
       0365  FACCKR=0365
       1615  UNSFIX=1615
       1230  PSWAP=1230
       0307  ARGPRE=0307
       6052  DISD=6052
       6053  DILX=6053
       6054  DILY=6054
       6055  DIXY=6055
       6130  CLZE=6130
       6131  CLSK=6131
       6132  CLOE=6132
       6133  CLAB=6133
       6135  CLSA=6135
       6530  ADCL=6530
       6531  ADLM=6531
       6532  ADST=6532
       6533  ADRB=6533
       6534  ADSK=6534
       6536  ADLE=6536
       6537  ADRS=6537
       0044  EXP=44
       0045  HORD=45
       0046  LORD=46
       0010  MAXPTS=XR0
       0011  REFRFL=XR1
       0012  BUFADR=XR2
       0013  DX=XR3
       6040  SPF=6040
       6007  CAF=6007
       1465  IA=1465

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 1-1

             EJECT
       0006  USECON=0006
       0010  XR0=10
       0011  XR1=11
       0012  XR2=12
       0013  XR3=13
       0014  XR4=14
       0015  XR5=15
       0020  CDFIO=0020
       0022  ARSTRT=0022
       0064  INSAV=0064
       0073  K0010=0073
       0074  K0017=0074
       0077  K0200=0077
       0114  FIXP=0114
       0134  FGETL=0134
       0135  FPUTL=0135
       0136  FNORL=0136
       0137  FCLR=0137
       0140  FNEGL=0140
       0156  PISWAP=0156
       4163  GETARG=4163
       0037  FF=0037
       6506  DBSO=6506
       6505  DBCO=6505
       4072  CSAM=4072
       4074  PSAM=4074
       4073  NSAM=4073
       4144  DONE=4144
       4077  NCTR=4077
       4154  S=4154
       4075  PCTR=4075
       4160  FL4096=4160

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 1-2

             EJECT
             /PATCHES TO 'UF.8E'
             /
       4173  *4173
04173  4245          SRESET
       4174  *4174
04174  4520          DRESET
       4175  *4175
04175  3425          INI
       4177  *4177
04177  4502          ARG123

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 1-3

             EJECT
             /BRTS.SV PATCHES
             /
             /THESE ARE THE STARTING ADDRESSES OF  THE ROUTINES
             /THEY SHOULD BE PATCHED INTO BRTS.SV STARTING AT 1560
             /
             /PLT(N,X,Y)     3600
             /REF(N,X,Y)     4310
             /ADC(N)         3531
             /CLK(R,O,S)     4100
             /CLW(N)         3551
             /DRO(T,M)       3400
             /DRI(N)         4302
             /SAM(C,N,P,T)   4000
             /DAC(M,N)       3453
             /GET(M.L)       4400
             /PUT(M,L)       4431
             /INI(N)         3425
             /PLY(Y)         3510
             /
             /ALSO PATCH BRTS.SV  0001=5402;  0002=4456

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 2

             /DRO(T,M)  FL PT NUMBER TO OUTPUT REG  0<=M<=4095
             /       T=1, LOGICAL 1'S ARE LOW;  T=0, LOGICAL 1'S ARE HI
             /
       3400  *3400
03400  0000  DRO,    0
03401  4514          JMS I FIXP      /GET T AND FIX IT
03402  3253          DCA DAC         /TEMP SAVE
03403  1253          TAD DAC
03404  1224          TAD P6505
03405  3212          DCA DROIOT      /PUT IOT ON LINE
03406  4777'         JMS GETARG
03407  4514          JMS I FIXP      /M
03410  7450          SNA             /IS M=0?
03411  5215          JMP DRO1        /YES, CLEAR REG
03412  0000  DROIOT, 0
03413  7300          CLA CLL
03414  5600          JMP I DRO
03415  7040  DRO1,   CMA             /-1
03416  1253          TAD DAC
03417  7041          CIA
03420  1224          TAD P6505
03421  3212          DCA DROIOT
03422  7040          CMA
03423  5212          JMP DROIOT      /CLEAR REG
03424  6505  P6505,  6505

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 2-1

             EJECT
             /INI    INITIALIZE ROUTINE
             /
03425  0000  INI,    0
03426  1006          TAD USECON      /ENTRY POINT OF BUF
03427  7106          CLL RTL
03430  1022          TAD ARSTRT      /ADR-1
03431  3015          DCA XR5
03432  1020          TAD CDFIO
03433  3234          DCA .+1
03434  0000  BUFBAK, 0
03435  7040          CMA
03436  1415          TAD I XR5
03437  3234          DCA BUFBAK
03440  1415          TAD I XR5
03441  3275          DCA PUTCDF
03442  1275          TAD PUTCDF
03443  3252          DCA CDFBAK
03444  6201          CDF
03445  1234          TAD BUFBAK
03446  3012          DCA BUFADR
03447  1006          TAD USECON      /ENTRY POINT OF BUF
03450  3776'         DCA MEM         /SAVE
03451  5625          JMP I INI
03452  0000  CDFBAK, 0

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 2-2

             EJECT
             /DAC(N,M)   LOAD DAC #N WHERE 0<=N<=5 WITH FLOATING
             /       POINT NUMBER M, WHERE 0<=M<4096
             /
03453  0000  DAC,    0
03454  4514          JMS I FIXP      /FIX N
03455  3200          DCA DRO
03456  1200          TAD DRO
03457  1273          TAD KM6         /CHK FOR LEGAL VALUE
03460  7700          SMA CLA         /5 OR LESS?
03461  5775'         JMP IA          /NO
03462  1200          TAD DRO
03463  1272          TAD ADAC        /MAKE IOT
03464  3267          DCA .+3
03465  4777'         JMS GETARG
03466  4514          JMS I FIXP      /FIX M
03467  0000          0
03470  7300          CLA CLL
03471  5653          JMP I DAC
03472  6551  ADAC,   6551
03473  7772  KM6,    -6

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 2-3

             EJECT
             /BUTBUF ENTER WITH 12 BIT VAL IN AC PUT VAL IN USER BUF;
             /       CHK TO SEE IF FIELD IS CROSSED.
             /
03474  0000  PUTBUF, 0
03475  0000  PUTCDF, 0
03476  3412          DCA I BUFADR
03477  7001          IAC
03500  1012          TAD BUFADR
03501  7640          SZA CLA         /ABOUT TO CROSS FIELDS?
03502  5306          JMP .+4         /NO
03503  1073          TAD K0010       /YES
03504  1275          TAD PUTCDF
03505  3275          DCA PUTCDF
03506  6201          CDF
03507  5674          JMP I PUTBUF

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 2-4

             EJECT
             /PLY(Y) ENTER WITH YVAL IN FAC; CHK 0<=VAL<1.0
             /       PUT LEGAL VAL IN USER BUF.
             /
03510  0000  PLY,    0
03511  4314          JMS JOB
03512  4274          JMS PUTBUF
03513  5710          JMP I PLY
             /
03514  0000  JOB,    0
03515  1045          TAD HORD
03516  7710          SPA CLA         />=0?
03517  5775'         JMP IA          /NO, ERROR
03520  1044          TAD EXP
03521  7740          SMA SZA CLA     /<1.0?
03522  5775'         JMP IA
             /CONVERT NUMBER TO A 10 BIT DISPLAYABLE VAL
             /       FAC=FAC*1776+1001
             /
03523  4774'         JMS FMPY
03524  3762          FL1022
03525  4773'         JMS FADD
03526  4557          FL513
03527  4514          JMS I FIXP
03530  5714          JMP I JOB

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 2-5

             EJECT
             /ADC(N)  SAMPLE ADC #N; RETURN LEGAL VAL TO FAC
             /
03531  0000  ADC,    0
03532  4514          JMS I FIXP      /GET ARG
03533  7041          CIA
03534  1074          TAD K0017
03535  7510          SPA             /N<=17?
03536  5775'         JMP IA          / NO
03537  7041          CIA
03540  1074          TAD K0017
03541  6531          ADLM
03542  6532          ADST
03543  6534          ADSK
03544  5343          JMP .-1
03545  6533          ADRB
03546  3045          DCA HORD
03547  4772'         JMS FFLOT
03550  5731          JMP I ADC

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 2-6

             EJECT
             /CLW(N)  N IS A DUMMY ARG; WAIT TILL CLOCK O.F. OR SCHMITT
             /       TRIGGER (DEPENDING ON CLK) THEN RETURN TO BASIC.
             /
03551  0000  CLW,    0
03552  6131          CLSK            /STATUS SET?
03553  7410          SKP
03554  5367          JMP EARLY       /YES
03555  6131          CLSK
03556  5355          JMP .-1
03557  6135  PVAL,   CLSA            /READ STATUS
03560  7104  CLW1,   CLL RAL         /CHK ON O.F.
03561  7430          SZL             /O.F. BIT SET IN STATUS WD?
03562  7041          CIA             /YES, NEGATE
             /RTN CODES
03563  7010          RAR
03564  3045          DCA HORD
03565  4772'         JMS FFLOT
03566  5751          JMP I CLW
03567  6135  EARLY,  CLSA
03570  1073          TAD K0010
03571  5360          JMP CLW1
03572  4200
03573  6000
03574  5600
03575  1465
03576  3765
03577  4163
       3600  PAGE

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 3

             /PLT(N,X,Y)  ROUTINE TO PLOT X,Y ARGS IF N=0.
             /       IF 0<=N<=1024 THE USER ARRAY IS
             /       CONVERTED TO 10BIT DISPLAYABLE
             /       VALS THEN PLOTTED.
             /
       3600  *3600
03600  0000  PLT,    0
03601  4514          JMS I FIXP      /FIX N
03602  7450          SNA
03603  5344          JMP PLOT        /PLOT ARGS IF N=0
03604  7041          CIA
03605  3241          DCA CNTR
03606  3342          DCA VTRX
03607  3343          DCA VTRY
03610  1365          TAD MEM
03611  7041          CIA
03612  1006          TAD USECON
03613  7650          SNA CLA         /ARRAY CHANGED?
03614  5253          JMP APLT        /NO, NOW 10 BIT!
03615  4777'         JMS INI         /INITIALIZE ARRAY
03616  1020          TAD CDFIO
03617  3220          DCA .+1
03620  0000  ADDR,   0               /USED TO ADVANTAGE
03621  1415          TAD I XR5       /BUMP
03622  7300          CLA CLL
03623  1415          TAD I XR5       /DIMENSION 2
03624  6201          CDF
03625  1241          TAD CNTR        /DIMENSION - N
03626  7710          SPA CLA         /IS DIMENSION>=N?
03627  5776'         JMP IA          /NO, ABORT
03630  1241          TAD CNTR
03631  7104          RAL CLL         /MULT BY 2
03632  3256          DCA CONT        /SAVE COUNTER FOR REP
03633  4322          JMS INIT
             /GET INITIAL ADDR AND CDF OF ARRAY
             /
03634  0000  REP,    0               /INIT RETURNS CDF HERE
03635  7001          IAC
03636  3037          DCA FF
03637  1220          TAD ADDR
03640  4534          JMS I FGETL     /GET DATA IN FAC, SET CDF
03641  0000  CNTR,   0               /NOT USED BY FGET
             /PLY IS USED TO CREATE A 10 BIT ARRAY AND CHK VALUES.
             /
03642  3037          DCA FF          /MODE 1 CALL
03643  4775'         JMS PLY
03644  7325          CLA CLL CML IAC RAL     /3
03645  1220          TAD ADDR
03646  3220          DCA ADDR
03647  7430          SZL             /FIELD CROSSED?
03650  4335          JMS BPLT        /YES
03651  2256          ISZ CONT
03652  5234          JMP REP
             /DISPLAY ROUTINE
             /

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 3-1

03653  6135  APLT,   CLSA
03654  6032          KCC
03655  4322          JMS INIT
03656  0000  CONT,   0
03657  1620          TAD I ADDR
03660  1342          TAD VTRX        /VECTOR DISPLAY 
03661  6053          DILX
03662  7300          CLA CLL
03663  2220          ISZ ADDR
03664  5271          JMP DPLT
03665  4335          JMS BPLT
03666  1256          TAD CONT
03667  3270          DCA .+1
03670  0000          0
03671  1620  DPLT,   TAD I ADDR      /GET Y
03672  1343          TAD VTRY
03673  6201          CDF
03674  6054          DILY
03675  6052          DISD
03676  5275          JMP .-1
03677  6055          DIXY
03700  7300          CLA CLL
03701  2220          ISZ ADDR
03702  7410          SKP
03703  4335          JMS BPLT
03704  2234          ISZ REP
03705  5256          JMP CONT        /ARRAY NOT FINISHED
03706  6031          KSF             /FINISHED
03707  5315          JMP CPLT
03710  1073          TAD K0010
03711  3045          DCA HORD        
03712  4774'         JMS FFLOT       /KEYBOARD INTERUPT RETURNS 8 TO BASIC
03713  6032  RTN,    KCC             /PLOT RETURNS HERE
03714  5600          JMP I PLT       /EXIT
03715  6131  CPLT,   CLSK
03716  5255          JMP APLT+2      /CONTINUE IF NO CLOCK INTERRUPT
03717  1200          TAD PLT         /RETURN LOC
03720  3773'         DCA CLW         /STORE IN CLW FUNCTION
03721  5772'         JMP PVAL        /JUMP TO CLW, RETURN TO BASIC
             /SUBROUTINES
             /
03722  0000  INIT,   0
03723  1241          TAD CNTR
03724  3234          DCA REP         /USED FOR VARIABLE COUNTER
03725  1771'         TAD CDFBAK
03726  3722          DCA I INIT      /PUT ON LINE
03727  1770'         TAD BUFBAK      /ADDR-1
03730  3220          DCA ADDR
03731  2220          ISZ ADDR
03732  7410          SKP
03733  4335          JMS BPLT        /FIELD CROSSED
03734  5722          JMP I INIT
03735  0000  BPLT,   0
03736  1722          TAD I INIT
03737  1073          TAD K0010

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 3-2

03740  3722          DCA I INIT
03741  5735          JMP I BPLT
03742  0000  VTRX,   0
03743  0000  VTRY,   0
             /PLOT ARGS X,Y
             /
03744  4767' PLOT,   JMS GETARG      /GET X
03745  4766'         JMS JOB         /CHK, SCALE, AND FIX  X
03746  6053          DILX
03747  7301          CLA CLL IAC
03750  4767'         JMS GETARG      /GET Y
03751  4766'         JMS JOB
03752  6054          DILY
03753  6052          DISD
03754  5353          JMP .-1
03755  6055          DIXY
03756  5313          JMP RTN         /EXIT
03757  0013  FL1024, 13
03760  2000          2000
03761  0000          0
03762  0012  FL1022, 12
03763  3774          3774
03764  0000          0
03765  7700  MEM,    -100            /DUMMY LOAD
03766  3514
03767  4163
03770  3434
03771  3452
03772  3557
03773  3551
03774  4200
03775  3510
03776  1465
03777  3425
       4000  PAGE

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 4

             /FFLOT  FLOAT ANY INTERGER IN HORD INTO FAC
             /
       4200  *4200
04200  0000  FFLOT,  0
04201  3046          DCA LORD        /CLEAR LOW ORDER MANTISSA
04202  1206          TAD P13         /11 INTO EXPONENT
04203  3044          DCA EXP
04204  4536          JMS I FNORL     /NORMALIZE
04205  5600          JMP I FFLOT
04206  0013  P13,    13

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 4-1

             EJECT
             /ADSAM  A CLOCK INTERRUPT FOR SAMPLING ADC'S
             /
       4337  SCNTR=NEGCHK
04207  6537  ADSAM1, ADRS            /READ STATUS (GET MUX)
04210  7001          IAC
04211  6531          ADLM            /BUMP MUX BY 1
04212  5230          JMP ADSAM2-1
04213  6135  ADSAM,  CLSA            /RD STAT AND CLEAR
04214  7700          CLA SMA         /SCHMITT TRIG?
04215  5230          JMP ADSAM2-1    /YES
04216  1777'         TAD  S
04217  7650          SNA CLA         /S=0?
04220  5231          JMP ADSAM2      /YES, SET UP FOR O.F. SAMPLING
04221  2337          ISZ SCNTR       /CONTINUE UNTIL
04222  5256          JMP TION        /S NUMBER OF O.F.'S
04223  1776' RCLK,   TAD PCTR
04224  1775'         TAD PSAM
04225  3045          DCA HORD
04226  4200          JMS FFLOT       /RETURN NUMBER OF POINTS TO BASIC
04227  5774'         JMP DONE        /DONE IN CLK ROUTINE
04230  6532          ADST
04231  6534  ADSAM2, ADSK            /SCHMITT TRIGS DON'T START CONV!
04232  5231          JMP .-1
04233  6533          ADRB
04234  4773'         JMS PUTBUF
04235  2772'         ISZ NCTR        /ALL SAMPLE?
04236  5207          JMP ADSAM1      /NO
04237  2776'         ISZ PCTR        /YES,  JOB DONE?
04240  7410          SKP
04241  5223          JMP RCLK        /JOB DONE, EXIT
04242  1771'         TAD CNTR
04243  1302          TAD DRI
04244  3771'         DCA CNTR        /UPDATE COUNTER IN PLT
04245  1770' SRESET, TAD NSAM
04246  7041          CIA
04247  3772'         DCA NCTR        /ADC SAMPLE COUNT
04250  1767'         TAD CSAM
04251  6531          ADLM            /LOAD 1ST ADC
04252  1775'         TAD PSAM
04253  1776'         TAD PCTR
04254  7650          SNA CLA         /FIRST TIME THRU LOOP?
04255  5260          JMP .+3         / YES, INIT
04256  6001  TION,   ION             /NO, PLT
04257  5766'         JMP APLT+2
04260  1770'         TAD NSAM
04261  7110          RAR CLL         
04262  7430          SZL             /ODD NUMBER?
04263  5300          JMP IAA         /YES, ABORT
04264  7041          CIA
04265  3302          DCA DRI         /TEMP STORE
04266  4765'         JMS INI
04267  3771'         DCA CNTR
04270  1777'         TAD  S
04271  7450          SNA             /IS S  SET?

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 4-2

04272  5276          JMP ADSAM4      /NO, INIT FOR O.F. SAMPLING
04273  7041          CIA             /YES, DISABLE O.F. ENABLE OF ADC
04274  3337          DCA SCNTR
04275  6536          ADLE
04276  6001  ADSAM4, ION
04277  5231          JMP ADSAM2      /IDLE UNTIL FIRST INTERUPT
04300  6040  IAA,    SPF
04301  5764'         JMP IA

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 4-3

             EJECT
             /DRI(N) N=DUMMY, SAMPLE DIGITAL I/O BOARD 0; AND RETURN RESULT
             /       AS FL PT NUMBER IN FAC
             /
04302  0000  DRI,    0
04303  1307          TAD P6503
04304  4763'         JMS DIGIO       /GET DIGITAL VAL
04305  4337          JMS NEGCHK
04306  5702          JMP I DRI
04307  6503  P6503,  6503

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 4-4

             EJECT
             /REF(N,X,Y) ROUTINE TO REFRESH AND VECTOR 10BIT ARRAY.
             /
04310  0000  REF,    0
04311  1310          TAD REF
04312  3762'         DCA PLT         /SET UP EXIT LINK FROM PLT
04313  4514          JMS I FIXP      /FIX N
04314  7041          CIA
04315  3771'         DCA CNTR        /RESET COUNTER IN PLT
04316  4761'         JMS GETARG
04317  4760'         JMS FADD
04320  3757          FL1024          /ADD 2000(8) TO VAL
04321  4514          JMS I FIXP      /FIX X
04322  3757'         DCA VTRX        /INSERT IN PLT ROUTINE
04323  7001          IAC
04324  4761'         JMS GETARG
04325  4760'         JMS FADD
04326  3757          FL1024
04327  4514          JMS I FIXP      /FIX Y
04330  3756'         DCA VTRY
04331  1755'         TAD MEM
04332  7041          CIA
04333  1006          TAD USECON
04334  7640          SZA CLA         /HAS 'USE' BEEN CALLED?
04335  4765'         JMS INI         /YES, RESET POINTERS
04336  5754'         JMP APLT

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 4-5

             EJECT
             /NEGCHK  THIS ROUTINE CHKS TO SEE IF A VALUE
             /       FROM DRI OR GET IS NEG.  IF IT IS
             /       THE VALUE IS CHANGED TO 4096 +
             /       NEG VALUE.
             /
04337  0000  NEGCHK, 0
04340  3310          DCA REF         /TEMP STORE
04341  1310          TAD REF
04342  3045          DCA HORD
04343  4200          JMS FFLOT
04344  1310          TAD REF
04345  7700          SMA CLA         /VAL WAS NEG
04346  5737          JMP I NEGCHK    /NO
04347  4760'         JMS FADD        /YES
04350  4160          FL4096
04351  5737          JMP I NEGCHK
04354  3653
04355  3765
04356  3743
04357  3742
04360  6000
04361  4163
04362  3600
04363  4546
04364  1465
04365  3425
04366  3655
04367  4072
04370  4073
04371  3641
04372  4077
04373  3474
04374  4144
04375  4074
04376  4075
04377  4154
       4400  PAGE

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 5

             /GET(M,L) M=0 GET VAL FROM USER BUF , NO MASKING
             /       M>0,GET VAL FROM USER BUF AND MASK WHERE
             /       M IS THE MASKING VAL.
             /       L IS THE LOCATION OF USER BUF .
             /       COMMON CALLS INI ROUTINE.
             /
       4502          LHOLD=ARG123
       4546          MASK=DIGIO
       4400  *4400
04400  0000  GET,    0
04401  7001          IAC
04402  3301          DCA MSKCTR
04403  4514          JMS I FIXP      /GET M
04404  7450          SNA             /M=0?
04405  7040          CMA             /YES SET M=7777
04406  7110          CLL RAR
04407  7430          SZL
04410  5213          JMP .+3
04411  2301          ISZ MSKCTR
04412  5206          JMP .-4
04413  7004          RAL
04414  4240          JMS COMMON      /SAME CODE FOR GET AND PUT
04415  1301          TAD MSKCTR
04416  7041          CIA
04417  3301          DCA MSKCTR
04420  1702          TAD I LHOLD
04421  6201          CDF             /RESET DF
04422  7110          CLL RAR
04423  2301          ISZ MSKCTR
04424  5222          JMP .-2
04425  7004          RAL
04426  0346          AND MASK
04427  4777'         JMS NEGCHK
04430  5600          JMP I GET
             /PUT(M,L)       M IS THE FL PT VAL TO BE FIXED AN PUT
             /       IN THE USER BUF; LIS THE LOC OF THE USER BUF
             /       INI IS CALLED BY COMMON.
             /
04431  0000  PUT,    0
04432  4514          JMS I FIXP      /GET AND FIX FL PT VAL
04433  4240          JMS COMMON
04434  1346          TAD MASK
04435  3702          DCA I LHOLD
04436  6201          CDF
04437  5631          JMP I PUT
             /COMMON  THIS ROUTINE IS UED BY GET AND PUT
             /
04440  0000  COMMON, 0
04441  3346          DCA MASK        /TEMP STORAGE
04442  4776'         JMS INI         /INITIALIZE ARRAY, SPECIFIED BY USE
04443  4775'         JMS GETARG      /GET L
04444  4514          JMS I FIXP
04445  7100          CLL
04446  1774'         TAD BUFBAK
04447  3302          DCA LHOLD

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 5-1

04450  7430          SZL             /CROSSED FIELDS
04451  1073          TAD K0010       /YES
04452  1773'         TAD CDFBAK
04453  3254          DCA .+1
04454  0000          0
04455  5640          JMP I COMMON

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 5-2

             EJECT
             / WHEN INTERUPT OCCURS COME HERE
             /
04456  7300  SERVC,  CLA CLL         /ASSIGN TO LOC 0002
04457  6131          CLSK
04460  7410          SKP
04461  5772'         JMP ADSAM       /CLOCK INTERUPT
04462  6031          KSF
04463  7410          SKP
04464  5271          JMP KKBRD       /TTY INTERUPT
04465  6041          TSF             /DUE TO LAST ECHO?
04466  7402          HLT             /SPURIOUS 
04467  6042          TCF
04470  5771'         JMP TION
04471  6036  KKBRD,  KRB
04472  6046          TLS
04473  1300          TAD M203
04474  7640          SZA CLA
04475  5771'         JMP TION        /IGNORE CHAR
04476  4556          JMS I PISWAP    /CNTR/C TYPED
04477  5770'         JMP 7605        /RETURN TO MONITOR
04500  7575  M203,   -203
04501  0000  MSKCTR, 0

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 5-3

             EJECT
             /ARG123  THIS ROUTINE GETS 3 ARGS AND STORES
             /       THEIR FL. PT. VALUES IN ARG1, ARG2, & ARG3
             /       AND THEIR FIXED VALUES AT ADR, ADR+1
             /       AND ADR+2
             /
04502  0000  ARG123, 0
04503  1702          TAD I ARG123    /GET ADR-1 FOR THE ARGS
04504  3011          DCA XR1
04505  2302          ISZ ARG123
04506  4514          JMS I FIXP
04507  3411          DCA I XR1
04510  4775'         JMS GETARG
04511  4514          JMS I FIXP
04512  3411          DCA I XR1
04513  7001          IAC
04514  4775'         JMS GETARG
04515  4514          JMS I FIXP
04516  3411          DCA I XR1
04517  5702          JMP I ARG123

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 5-4

             EJECT
             /DRESET    USED TO RESET STARTING DIGITAL I/O BOARD
             /       AND CTR;  WAIT FOR O.F.; SAMPLE EACH BOARD.
             /
04520  4776' DRESET, JMS INI
04521  1767'         TAD NSAM
04522  7041          CIA
04523  3766'         DCA NCTR
04524  1765'         TAD CSAM        /STARTING BOARD #
04525  7106          CLL RTL
04526  7004          RAL     
04527  1356          TAD P6473
04530  3354          DCA KDBCI
             /WAIT LOOP
04531  6131          CLSK
04532  5331          JMP .-1
04533  6135          CLSA            /READ STATUS
04534  7200          CLA
             /SAMPLE ALL BOARDS
04535  1073  DIGSAM, TAD K0010
04536  1354          TAD KDBCI
04537  4346          JMS DIGIO
04540  4764'         JMS PUTBUF
04541  2766'         ISZ NCTR
04542  5335          JMP DIGSAM
04543  2763'         ISZ PCTR        /JOB DONE?
04544  5321          JMP DRESET+1    /NO
04545  5762'         JMP DONE        /YES, DONE IN CLK ROUTINE
             /DIGIO  ENTER WITH DBCI SETUP FOR CORRECT BOARD; SET UP
             /       IOT, SAMPLES BOARD, EXITS WITH VAL IN AC
             /
04546  0000  DIGIO,  0
04547  3354          DCA KDBCI
04550  1354          TAD KDBCI
04551  7001          IAC
04552  3353          DCA KDBRI
04553  0000  KDBRI,  0
04554  0000  KDBCI,  0
04555  5746          JMP I DIGIO
04556  6473  P6473,  6473
04557  0012  FL513,  12
04560  2002          2002
04561  0000          0
04562  4144
04563  4075
04564  3474
04565  4072
04566  4077
04567  4073
04570  7605
04571  4256
04572  4213
04573  3452
04574  3434
04575  4163

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 5-5

04576  3425
04577  4337
       4600  PAGE
             $$

/SOURCE PROGRAM  BASIC.UF                 PAL8-V9B  07/11/74  PAGE 6

ADAC   3472      FADD   6000      PUT    4431
ADC    3531      FCLR   0137      PUTBUF 3474
ADCL   6530      FDIV   5722      PUTCDF 3475
ADDR   3620      FF     0037      PVAL   3557
ADLE   6536      FFDIVI 5412      P13    4206
ADLM   6531      FFGET  6237      P6473  4556
ADRB   6533      FFLOT  4200      P6503  4307
ADRS   6537      FFNEG  6130      P6505  3424
ADSAM  4213      FFNOR  6213      RCLK   4223
ADSAM1 4207      FFPUT  6254      REF    4310
ADSAM2 4231      FGETL  0134      REFRFL 0011
ADSAM4 4276      FIXP   0114      REP    3634
ADSK   6534      FL1022 3762      RTN    3713
ADST   6532      FL1024 3757      S      4154
APLT   3653      FL4096 4160      SCNTR  4337
ARGPRE 0307      FL513  4557      SERVC  4456
ARG123 4502      FMPY   5600      SPF    6040
ARSTRT 0022      FNEGL  0140      SRESET 4245
BPLT   3735      FNORL  0136      TION   4256
BUFADR 0012      FPP    4000      UNSFIX 1615
BUFBAK 3434      FPUTL  0135      USECON 0006
CDFBAK 3452      FSUB   6117      VTRX   3742
CDFIO  0020      GET    4400      VTRY   3743
CLAB   6133      GETARG 4163      XR0    0010
CLOE   6132      HORD   0045      XR1    0011
CLSA   6135      IA     1465      XR2    0012
CLSK   6131      IAA    4300      XR3    0013
CLW    3551      INI    3425      XR4    0014
CLW1   3560      INIT   3722      XR5    0015
CLZE   6130      INSAV  0064
CNTR   3641      JOB    3514
COMMON 4440      KDBCI  4554
CONT   3656      KDBRI  4553
CPLT   3715      KKBRD  4471
CSAM   4072      KM6    3473
DAC    3453      K0010  0073
DBCO   6505      K0017  0074
DBSO   6506      K0200  0077
DIGIO  4546      LHOLD  4502
DIGSAM 4535      LORD   0046
DILX   6053      MASK   4546
DILY   6054      MAXPTS 0010
DISD   6052      MEM    3765
DIXY   6055      MSKCTR 4501
DONE   4144      M203   4500
DPLT   3671      NCTR   4077
DRESET 4520      NEGCHK 4337
DRI    4302      NSAM   4073
DRO    3400      PCTR   4075
DROIOT 3412      PISWAP 0156
DRO1   3415      PLOT   3744
DX     0013      PLT    3600
EARLY  3567      PLY    3510
EXP    0044      PSAM   4074
FACCKR 0365      PSWAP  1230



ERRORS DETECTED: 0
LINKS GENERATED: 75



