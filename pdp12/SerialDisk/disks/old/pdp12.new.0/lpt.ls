
RALF V  54  APR 28, 77 PAGE 1

                    SECT8   RADC
                    BASE    0
00000 0006          STARTD
00001 0200          FLDA    0
00002 6400          FSTA    ADCRET
00003 0007  
00004 0005          STARTF
00005 4000          TRAP4   LITER
00006 0014  
00007 1030  ADCRET, JA      .
00010 0007  
00011 0000  ICHAR,  0;0;0
00012 0000  
00013 0000  
00014 0000  LITER,  0
00015 7000          NOP
00016 7300          CLA CLL
00017 1312          TAD     ADDA
00020 7006          RTL
00021 7004          RAL
00022 1326          TAD     KCDF
00023 3224          DCA     .+1
00024 0000          0
00025 7300          CLA CLL
00026 6301          6301            /CLEAR DATA
                                    /SYNC BITS
00027 3316          DCA R1          /INIT WORD CNT
00030 1313          TAD ADDA+1      /GET ADDRESS OF ICHAR ARRAY
00031 3314          DCA PTR         /INIT WORD PNTR
00032 2316  LITE2,  ISZ R1          /INC WORD CNT
00033 1316          TAD R1
00034 1322          TAD M6          /COMPUTE(CNT-6)
00035 7700          SMA CLA         /VAR CHAR?
00036 5241          JMP LITE4       /NO
00037 1320          TAD M4
00040 5254          JMP LITE8       /GO TRANSMIT
00041 1316  LITE4,  TAD R1
00042 1322          TAD M6          /COMPUTE(CNT-6)
00043 7640          SZA CLA         /FIXED DIGITS?
00044 5247          JMP LITE6       /NO
00045 1321          TAD M10         /YES, SET 10 BIT
                                    /WORD
00046 5254          JMP LITE8       /GO TRANSMIT
00047 1316  LITE6,  TAD R1
00050 1323          TAD M7          /COMPUTE(CNT-7)
00051 7640          SZA CLA         /SPECIAL CHARACTERS?
00052 5310          JMP GETBAK      /RETURN
00053 1322          TAD M6          /YES, SET FOR 6
                                    /BIT WORD
00054 3317  LITE8,  DCA R2          /INIT NUMBER OF
                                    /BITS PER WORD
00055 1714          TAD%  PTR       /GET EXP OF NXT WORD
00056 1327          TAD P2
00057 7041          CIA             /ROUTINE TO PACK 3 WORD
                                    /CHAR FROM FPP TO 1 8-MODE WORD
00060 3330          DCA EXP         /STORE SHIFT CTR
RALF V  54  APR 28, 77 PAGE 1-1

00061 2314          ISZ PTR         /POINT TO HIGH MANTISSA
00062 1714          TAD% PTR        /GET HIGH MANTISSA
00063 7100          CLL             /SHIFT
00064 7004          RAL             /MANTISSA
00065 2330          ISZ EXP
00066 5264          JMP .-2
00067 2314          ISZ PTR         /SKIP OVER LOW MANT OF CHAR
00070 2314          ISZ PTR         /POINT TO EXP OF NXT CHAR
                            /END OF PACKING ROUTINE
00071 3315          DCA TEMP        /STORE PACKED WORD IN TEMP
00072 1315  LITE10, TAD TEMP        /GET SHIFTED WORD
00073 7010          RAR             /ROTATE WORD RIGHT ONE
00074 3315          DCA TEMP        /RETURN TO TEMP
00075 7420          SNL             /LINK BIT = 1?
00076 5301          JMP .+3         /NO
00077 1324          TAD P1000       /YES, SET DATA BIT
00100 6301          6301            /TRANSMIT
00101 1325          TAD P2000       /ADD SYNC
00102 6301          6301            /TRANSMIT
00103 7300          CLA CLL
00104 6301          6301            /CLEAR DATA, SYNC OUTPUT
00105 2317          ISZ R2          /ALL BITS SENT?
00106 5272          JMP LITE10      /NO
00107 5232          JMP LITE2       /YES
00110 6203  GETBAK, CDF CIF 
00111 5614          JMP% LITER
00112 0000  ADDA,   ADDR ICHAR      /ADDR -1 OF BEG OF ICHAR
00113 0011  
00114 0000  PTR,    0
00115 0000  TEMP,   0
00116 0000  R1,     0       /CHAR COUNTER
00117 0000  R2,     0       /BIT COUNTER
00120 7774  M4,     -4
00121 7766  M10,    -12
00122 7772  M6,     -6
00123 7771  M7,     -7
00124 1000  P1000,  1000
00125 2000  P2000,  2000
00126 6201  KCDF,   CDF
00127 0002  P2,     2
00130 0000  EXP,    0
            
RALF V  54  APR 28, 77 PAGE 1-2

NO ERRORS 
24 SYMBOLS, NO ABS REFS 

 #      C 00000   #MAIN  S 00000   ADCRET   00007   ADDA     00112  
 EXP      00130   GETBAK   00110   ICHAR    00011   KCDF     00126  
 LITER    00014   LITE10   00072   LITE2    00032   LITE4    00041  
 LITE6    00047   LITE8    00054   M10      00121   M4       00120  
 M6       00122   M7       00123   PTR      00114   P1000    00124  
 P2       00127   P2000    00125   RADC   8 00131   R1       00116  
 R2       00117   TEMP     00115  
