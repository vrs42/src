
/ SECONDARY BOOTSTRAP                     PAL8-V10D NO DATE   PAGE 1

             / SECONDARY BOOTSTRAP

             /       DEC-8E-OC2BA-A-LA
             /       COPYRIGHT 1972
             /       DIGITAL EQUIPMENT CORPORATION
             /       MAYNARD, MASS.  01754

             /       S.R.

       7002          BSW=7002
       6701          KSDR=6701
       6701          KSDF=6701
       6703          KSBF=6703
       6704          KLSA=6704
       6706          KGOA=6706
       6707          KRSB=6707
                     NOPUNCH
       3602          *3602
                     ENPUNCH

03602  7240  BIN,    STA
03603  3317          DCA GRKNT
03604  1233  ITSFLD, TAD CDF0
03605  3230          DCA FLD
03606  3305  ITSORG, DCA ORG         /ASSUMES ORIGIN ALWAYS APPEARS
                                     /AFTER FIELD SETTING
03607  7240  BINLDR, STA
03610  3307          DCA ORGSW
03611  4243          JMS GETBYT
03612  7002  FOOL,   BSW
03613  7112          CLL RTR
03614  7430          SZL
03615  5235          JMP SPEC        /BIT 4=1
03616  7510          SPA             /BIT 4=0 (TWO WORD COMMAND)
03617  2307          ISZ ORGSW       /IS ORIGIN
03620  7000  N7000,  NOP
03621  7004          RAL
03622  7104          CLL RAL
03623  3306          DCA TEM
03624  4243          JMS GETBYT
03625  1306          TAD TEM         /COMBINE
03626  2307          ISZ ORGSW
03627  5206          JMP ITSORG      /ORIGIN
03630  7402  FLD,    HLT
03631  3705          DCA I ORG
03632  2305          ISZ ORG
03633  6201  CDF0,   CDF 0
03634  5207          JMP BINLDR
03635  7500  SPEC,   SMA
03636  5302          JMP     MON
03637  7006          RTL
03640  0220          AND N7000
03641  7002          BSW
03642  5204          JMP ITSFLD

/ SECONDARY BOOTSTRAP                     PAL8-V10D NO DATE   PAGE 2


03643  0000  GETBYT, 0
03644  2317          ISZ     GRKNT
03645  5274          JMP     RDBYTE
03646  1311          TAD     X260
03647  6704          KLSA
03650  6706          KGOA
03651  6703          KSBF
03652  5251          JMP     .-1
03653  6707          KRSB
03654  0320          AND     X7774
03655  7640          SZA CLA
03656  7402          HLT
03657  2321          ISZ     FIRST
03660  5265          JMP     NOTFST
03661  4323          JMS RESET
03662  1312          TAD     X270
03663  7120          STL
03664  5716          JMP I   X4002
03665  1322  NOTFST, TAD     X7600
03666  3317          DCA     GRKNT
03667  1310          TAD     X200
03670  6704          KLSA
03671  6706          KGOA
03672  6701          KSDF
03673  5272          JMP     .-1
03674  6706  RDBYTE, KGOA
03675  6701          KSDF
03676  5275          JMP     .-1
03677  5643          JMP I   GETBYT

03700  0000          ZBLOCK 3701-.   /LOCATION 3701 IS SKIPPED BY PRIMARY LOADER


                     NOPUNCH
03701  0000          0
                     ENPUNCH

/ SECONDARY BOOTSTRAP                     PAL8-V10D NO DATE   PAGE 3


03702  6213  MON,    CDF CIF 10
03703  5704          JMP I   .+1
03704  5200          5200

03705  0000  ORG,    0
03706  0000  TEM,    0
03707  0000  ORGSW,  0

03710  0200  X200,   200
03711  0260  X260,   260
03712  0270  X270,   270
03713  7737  X7737,  7737
03714  4035  XKNT,   4035
03715  4036  XPTR,   4036
03716  4002  X4002,  4002
03717  0000  GRKNT,  0
03720  7774  X7774,  7774
03721  7777  FIRST,  -1
03722  7600  X7600,  7600
03723  0000  RESET,  0               /SET UP PRIMARY BOOTSTRAP FOR REUSE
03724  1313          TAD     X7737
03725  3714          DCA I   XKNT
03726  3715          DCA I   XPTR
03727  1332          TAD X3211       /A "DCA ." FOR LOCATION 4011
03730  3733          DCA I X4011
03731  5723          JMP I RESET
03732  3211  X3211,  3211
03733  4011  X4011,  4011
03734  0000          ZBLOCK 4000-.
04000  3602          BIN
04001  5600          JMP I .-1       /MUST END IN OCTAL 00
                     $

/ SECONDARY BOOTSTRAP                     PAL8-V10D NO DATE   PAGE 4

BIN    3602      
BINLDR 3607      
CDF0   3633      
FIRST  3721      
FLD    3630      
FOOL   3612      
GETBYT 3643      
GRKNT  3717      
ITSFLD 3604      
ITSORG 3606      
KGOA   6706      
KLSA   6704      
KRSB   6707      
KSBF   6703      
KSDF   6701      
KSDR   6701      
MON    3702      
NOTFST 3665      
N7000  3620      
ORG    3705      
ORGSW  3707      
RDBYTE 3674      
RESET  3723      
SPEC   3635      
TEM    3706      
XKNT   3714      
XPTR   3715      
X200   3710      
X260   3711      
X270   3712      
X3211  3732      
X4002  3716      
X4011  3733      
X7600  3722      
X7737  3713      
X7774  3720      



ERRORS DETECTED: 0
LINKS GENERATED: 0



