
/FUNCTION SUBROUTINE CONVT(A)         SEP  5, 1975              PAGE  1

                /CONVERT FROM 27 BIT TO 23 BIT F. P. FORMAT
 
                ENTRY   CONVT
 
      7413      ABSYM   SHL     7413
      7421      ABSYM   MQL     7421
      7501      ABSYM   MQA     7501
 
 
0200  7240      CON1,   CLA CMA
0201  3315              DCA     SWITC           /SET SWITCH
0202  6211              DCA     ACH             /CLEAR FAC
0203  3777
0204  3776              DCA     ACM
0205  3775              DCA     ACL
0206  4033              CALL 1, IFAD            /LOAD FAC
0207  0102 06
0210  6211      CONVT,  ARG     0       /ALSO ENTRY POINT
0211  0000
0212  2315              ISZ     SWITC           /IS SWITCH SET?
0213  5200              JMP     CON1            /NO
0214  2211              INC     CONVT#
0215  2211              INC     CONVT#
0216  6211              TAD     ACM
0217  1776
0220  7421              MQL
0221  1777              TAD     ACH             /LOAD UP REGISTERS
0222  7450              SNA                     /IS IT ZERO?
0223  5305              JMP     CZRO            /YES
0224  0374              AND     (7
0225  7413              SHL
0226  0007                7                     /SHIFT LEFT
0227  3313              DCA     AC1
0230  7501              MQA
0231  3314              DCA     AC2
0232  1775              TAD     ACL
0233  7421              MQL
0234  7413              SHL
0235  0007                7                     /SHIFT REST LEFT
0236  1314              TAD     AC2
0237  3314              DCA     AC2
0240  1777              TAD     ACH             /GET EXP.
0241  0373              AND     (3770
0242  7112              CLL RTR
0243  7010              RAR
0244  1372              TAD     (7600
0245  3775              DCA     ACL             /STORE EXP.
0246  7501              MQA                     /ROUND IF NEEDED
0247  7710              SPA CLA
0250  2314              ISZ     AC2
0251  5261              JMP     CON2
0252  2313              ISZ     AC1
0253  1313              TAD     AC1
0254  7700              SMA CLA
0255  5261              JMP     CON2
0256  7332              CLA CLL CML RTR
0257  3313              DCA     AC1
/FUNCTION SUBROUTINE CONVT(A)         SEP  5, 1975              PAGE  2

0260  2775              ISZ     ACL
0261  4051      CON2,   TAD     ACH
0262  7410
0263  1777
0264  7700              SMA CLA                 /IS FAC NEGATIVE
0265  5276              JMP     CEX             /NO
0266  1314              TAD     AC2
0267  7141              CLL CIA
0270  3314              DCA     AC2
0271  7020              CML
0272  7004              RAL
0273  1313              TAD     AC1
0274  7041              CIA
0275  3313              DCA     AC1
0276  1313      CEX,    TAD     AC1
0277  6211              DCA     ACH
0300  3777
0301  1314              TAD     AC2
0302  3776              DCA     ACM
0303  4040              RETRN   CONVT
0304  0001 06
 
0305  6211      CZRO,   DCA     ACL
0306  3775
0307  3776              DCA     ACM
0310  3777              DCA     ACH
0311  4040              RETRN   CONVT
0312  0001 06
 
0313  0000      AC1,    0
0314  0000      AC2,    0
0315  0000      SWITC,  0
 
0372  7600
0373  3770
0374  0007
0375  0022
0376  0021
0377  0020
                END
/FUNCTION SUBROUTINE CONVT(A)         SEP  5, 1975              PAGE  3

 
 
AC1     0313
AC2     0314
CEX     0276
CONVT   0210EXT
CON1    0200
CON2    0261
CZRO    0305
IFAD    0000EXT
MQA     7501ABS
MQL     7421ABS
SHL     7413ABS
SWITC   0315
 
