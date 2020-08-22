
            /PROGRAM BIO A-08-01
            /ADDITION OF NEW SUBROUTINES TO 4 WORD F.P. PACKAGE
            /FREAD,FSPA,FSZA,FNOP,FJMP,FNEG,FHLT
            /FCLA MAY BE SIMULATED BY SETTING FCLA=2044
            /
            *5760
5760  5324           FPREAD                   /FREAD=10
5761  5333           FPSPA                    /FSPA=11
5762  5340           FPSZA                    /FSZA=12
5763  5770           EXIT6                    /FNOP=13
5764  5770           EXIT6
5765  5345           FPJMP                    /FJMP=15
5766  6261           6261                     /FNEG=16
5767  5372           FPHLT                    /FHLT=17
            EXIT6=5770
            /
            /
            *5324
5324  0000  FPREAD,  0                        /SUBROUTINE TO READ FIRST
5325  4405           JMS I 5                  /VALID F.P. NUMBER
5326  7300           CLA CLL
5327  1061           TAD 61
5330  7650           SNA CLA
5331  5325           JMP .-4
5332  5724           JMP I FPREAD
            /
            /
5333  0000  FPSPA,   0                        /SUBROUTINE TO SIMULATE SPA N.
5334  1045           TAD 45                   /I.E. JUMP N INSTRUCTIONS
5335  7700           SMA CLA                  /IF F.P. ACC. POSITIVE.
5336  4345           JMS FPJMP                /N DEFINED IN F.P. JUMP
5337  5733           JMP I FPSPA
            /
            /
5340  0000  FPSZA,   0                        /SUBROUTINE TO SIMULATE SZA N.
5341  1045           TAD 45                   /I.E. JUMP N INSTRUCTIONS
5342  7650           SNA CLA                  /IF F.P. ACC.=0.
5343  4345           JMS FPJMP                /N DEFINED IN F.P. JUMP
5344  5740           JMP I FPSZA
            /
            /
5345  0000  FPJMP,   0                        /SUBROUTINE TO SIMULATE JMP N
5346  1771           TAD I INST               /WHERE N=M*20(OCTAL) AND
5347  0367           AND MASK1                /M IS THE NUMBER OF INSTR.
5350  7650           SNA CLA                  /TO BE JUMPED. IF BIT 3=0
5351  7040           CMA                      /JUMP FORWARDS, IF BIT 3=1
5352  3015           DCA 15                   /JUMP BACKWARDS.
5353  1771           TAD I INST               /CONTENTS OF LOC. 15 LOST
5354  7112           CLL RTR
5355  7012           RTR
5356  0366           AND MASK
5357  2015           ISZ 15
5360  7041           CIA
5361  1765           TAD I RETADD
5362  1370           TAD MONE
5363  3765           DCA I RETADD
5364  5745           JMP I FPJMP
5365  5661  RETADD,  5661
5366  0017  MASK,    17
5367  0400  MASK1,   400
5370  7777  MONE,    -1
5371  5657  INST,    5657
            /
            /
5372  0000  FPHLT,   0                        /SUBROUTINE TO SIMULATE A HALT
5373  7040           CMA                      /WITH ADDR. OF HALT DISPLAYED
5374  1765           TAD I RETADD             /IN ACC.
5375  7402           HLT
5376  7300           CLA CLL
5377  5772           JMP I FPHLT

EXIT6   5770
FPHLT   5372
FPJMP   5345
FPREAD  5324
FPSPA   5333
FPSZA   5340
INST    5371
MASK    5366
MASK1   5367
MONE    5370
RETADD  5365


