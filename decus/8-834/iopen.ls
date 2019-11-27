
/ IOPEN, OOPEN, OCLOSE, CHAIN         SEP  5, 1975              PAGE  1

                /8K FORTRAN LIBRARY
 
                /
                /       SUBROUTINES TO MANIPULATE PS/8 FILES
                /
 
                        ENTRY   IOPEN   /OPEN AN INPUT FILE
                        ENTRY   OOPEN   /OPEN AN OUTPUT FILE
                        ENTRY   OCLOS   /CLOSE AN OUTPUT FILE
                        ENTRY   CHAIN   /CHAIN TO A PROGRAM
 
      1400              OPDEF   TADI    1400
      2400              OPDEF   ISZI    2400
      3400              OPDEF   DCAI    3400
      5400              OPDEF   JMPI    5400
 
                        LAP             /LEAVE AUTOMATIC PAGING
 
0200  1117      IOER,   1117;0522       /"IOER" ERROR MESSAGE
0201  0522
0202  6140      IOPEN,  6140
0203  0002              0002
0204  1333              TAD     ASDVM1
0205  4273              JMS     SETUP   /PUT 2 WORDS OF FIRST ARGUMENT INTO "AS
0206  1730              TADI    INHNDL  /DATA FIELD IS 0 HERE - GET INPUT HANDL
0207  7450              SNA
0210  5220              JMP     IOERR   /NO /I GIVEN - ERROR
0211  3410              DCAI    10      /STORE IN "ASPAGE"
0212  4320              JMS     GFILNM  /MOVE FILE NAME INTO LOCS 00000-00003
0213  1334              TAD     FLUKUP  /LOAD POINTER TO "FLUKUP" IN RUN-TIME R
0214  6202      CALASN, 6202            /CIF 0
0215  6201 05           JMS I   FASIGN  /SET DF=CURRENT AND GO LOOKUP FILE
0216  4732
0217  5224              JMP     IOP1
0220  4033      IOERR,  CALL    1,ERROR /I-O ERROR  - GIVE MESSAGE AND QUIT
0221  0105 06
0222  6201 05           ARG     IOER
0223  0200 01
 
0224  7326      IOP1,   CLA CLL CML RTL /FAST EXIT
0225  1202              TAD     IOPEN
0226  3227              DCA     IOP2
0227  7402      IOP2,   HLT
0230  5603              JMPI    IOPEN#
 
0231  6140      OOPEN,  6140
0232  0002              0002
0233  4236              JMS     OOCOMN
0234  1335              TAD     FENTER
0235  5214              JMP     CALASN  /SEE "IOPEN" FOR COMMENTS
 
0236  0000      OOCOMN, 0               /COMMON SUBR BETWEEN "OOPEN" AND "OCLOS
0237  1231              TAD     OOPEN
0240  3202              DCA     IOPEN
0241  1232              TAD     OOPEN#
0242  3203              DCA     IOPEN#  /MOVE CALLING ADDRESS TO IOPEN
0243  1333              TAD     ASDVM1
/ IOPEN, OOPEN, OCLOSE, CHAIN         SEP  5, 1975              PAGE  2

0244  4273              JMS     SETUP   /SET UP DEVICE NAME IN FIELD 0
0245  1731              TADI    OUHNDL
0246  7450              SNA
0247  5220              JMP     IOERR   /NO /O GIVEN - ERROR
0250  3410              DCAI    10      /STORE IN "ASPAGE"
0251  4320              JMS     GFILNM  /PUT FILE NAME INTO 00000-3
0252  5636              JMPI    OOCOMN
 
0253  6140      OCLOS,  6140
0254  0002              0002
0255  4236              JMS     OOCOMN  /SET UP DEVICE AND FILE NAME
0256  1253              TAD     OCLOS
0257  3202              DCA     IOPEN
0260  1254              TAD     OCLOS#
0261  3203              DCA     IOPEN#  /SET UP IOPEN FOR RETURN
0262  1372              TAD     CHX1    /=7177
0263  3236              DCA     OOCOMN
0264  1373      OCLOOP, TAD     CHX2    /=1632 =^Z ON DEVICE 4 OUTPUT
0265  4033              CALL    0,GENIO
0266  0006 06
0267  2236              ISZ     OOCOMN
0270  5264              JMP     OCLOOP  /FORCE OUT THE LAST BUFFER
0271  1336              TAD     FCLOSE
0272  5214              JMP     CALASN  /DO WORK AND LEAVE
 
0273  0000      SETUP,  0
0274  3010              DCA     10
0275  1202              TAD     IOPEN
0276  3277              DCA     SETDF
0277  0000      SETDF,  0               /SET CALLING DATA FIELD
0300  1603              TADI    IOPEN#
0301  3312              DCA     GETWD#  /SAVE FIELD OF ARGUMENT
0302  2203              INC     IOPEN#
0303  1603              TADI    IOPEN#
0304  3277              DCA     SETDF   /SAVE ADDRESS OF ARGUMENT
0305  2203              INC     IOPEN#
0306  4311              JMS     GETWD   /TRANSFER TWO WORDS FROM THE
0307  4311              JMS     GETWD   /ARGUMENT LIST TO WHERE XR 10 POINTS
0310  5673              JMPI    SETUP   /RETURN WITH DATA FIELD =0
 
0311  0000      GETWD,  0
0312  7000              NOP             /SET ARGUMENT FIELD
0313  1677              TADI    SETDF
0314  2277              INC     SETDF
0315  6201              6201            /CDF 00
0316  3410              DCAI    10
0317  5711              JMPI    GETWD   /DO NOT RESTORE DATA FIELD
 
0320  0000      GFILNM, 0
0321  7240              CLA CMA
0322  4273              JMS     SETUP   /MOVE TWO WORDS TO 00000 AND 00001
0323  4311              JMS     GETWD   /MOVE THE THIRD WORD
0324  1327              TAD     DA
0325  3410              DCAI    10      /SUPPLY AN EXTENSION
0326  5720              JMPI    GFILNM
 
0327  0401      DA,     0401            /.DA EXTENSION
/ IOPEN, OOPEN, OCLOSE, CHAIN         SEP  5, 1975              PAGE  3

0330  0074      INHNDL, 74
0331  0075      OUHNDL, 75
0332  0541      FASIGN, 541             /*****************
0333  0552      ASDVM1, 552             /               CAUTION!
0334  0567      FLUKUP, 567             /ALL THESE LOCATIONS ARE VERY VOLATILE!
0335  0741      FENTER, 741             /WATCH OUT IF YOU REASSEMBLE THE LOADER
0336  0757      FCLOSE, 757             /*****************
 
0337  6140      CHAIN,  6140
0340  0002              0002
0341  1337              TAD     CHAIN
0342  3202              DCA     IOPEN
0343  1340              TAD     CHAIN#
0344  3203              DCA     IOPEN#
0345  4320              JMS     GFILNM  /GET FILE NAME INTO 00000-00003
0346  2730              ISZI    INHNDL  /FORCE INHNDL NONZERO SO IOPEN WONT FAI
0347  1367              TAD     SV      /CHANGE ASSUMED EXTENSION
0350  3327              DCA     DA      /FROM .DA TO .SV
0351  1377              TAD     (0310
0352  3200              DCA     IOER    /IF IOPEN FAILS GIVE "CHER" MESSAGE
0353  4033      CALOPN, CALL    1,IOPEN
0354  0101 06
0355  6201 05           ARG     SYS     /CHAIN WORKS FROM THE SYSTEMS DEVICE ON
0356  0366 01
0357  6201              6201
0360  0000              0               /"ARG 0" POINTING TO 00000!
0361  1376              TAD     (6
0362  6201              6201            /SET DF TO 0
0363  3770              DCAI    K2      /MODIFY "LOOKUP" INTO "CHAIN"
0364  3771              DCAI    ZRONAM  /ALSO KILL LOC WHICH ZEROS FILE NAME PT
0365  5353              JMP     CALOPN  /GO BACK - THIS TIME IOPEN WILL CHAIN.
 
0366  2303      SYS,    2303            /***** 2303+2326 =4631 = "SYS"! WATCH I
0367  2326      SV,     2326
0370  0571      K2,     571             /**** SUPER VOLATILE LOCATION ****
0371  0557      ZRONAM, 557             /****     DITTO               ****
0372  7177      CHX1,   7177
0373  1632      CHX2,   1632
 
0376  0006
0377  0310
                        END
/ IOPEN, OOPEN, OCLOSE, CHAIN         SEP  5, 1975              PAGE  4

 
 
ASDVM1  0333
CALASN  0214
CALOPN  0353
CHAIN   0337EXT
CHX1    0372
CHX2    0373
DA      0327
DCAI    3400OP
ERROR   0000EXT
FASIGN  0332
FCLOSE  0336
FENTER  0335
FLUKUP  0334
GENIO   0000EXT
GETWD   0311
GFILNM  0320
INHNDL  0330
IOER    0200
IOERR   0220
IOPEN   0202EXT
IOP1    0224
IOP2    0227
ISZI    2400OP
JMPI    5400OP
K2      0370
OCLOOP  0264
OCLOS   0253EXT
OOCOMN  0236
OOPEN   0231EXT
OUHNDL  0331
SETDF   0277
SETUP   0273
SV      0367
SYS     0366
TADI    1400OP
ZRONAM  0371
 
