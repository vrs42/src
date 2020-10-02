
/SERIAL-BASED DISK SYSTEM                 PAL8-V13B NO DATE   PAGE 1

             /SERIAL-BASED DISK SYSTEM
             /KYLE OWEN - 1/28/2014

       0003          VERS="C&77

       6400          BASER=6400
       6410          BASET=6410
             /BASER=6030
             /BASET=6040

       6400          SKCF=BASER
       6401          SKSF=BASER+1
       6402          SKCC=BASER+2
       6404          SKRS=BASER+4
       6405          SKIE=BASER+5
       6406          SKRB=BASER+6

       6410          STFL=BASET
       6411          STSF=BASET+1
       6412          STCF=BASET+2
       6414          STPC=BASET+4
       6415          STSK=BASET+5
       6416          STLS=BASET+6

       6260          BLKNUM=6260

             /A OR B - COMMAND SERVER, SIDE 0 OR 1
             /@ - SEND BOOT CODE

       0000                  *0
000000  7775                 -3              /THREE DEVICES
000001  2322                 DEVICE SRV; DEVICE SYS;  4640; ENTRY1&177+2000; 0; BLKNUM
000002  2600
000003  2331
000004  2300
000005  4640
000006  2007
000007  0000
000010  6260
000011  2322                 DEVICE SRV; DEVICE SRV1; 4640; ENTRY1&177+1000; 0; BLKNUM
000012  2600
000013  2322
000014  2661
000015  4640
000016  1007
000017  0000
000020  6260
000021  2322                 DEVICE SRV; DEVICE SRV2; 4640; ENTRY2&177+1000; 0; BLKNUM
000022  2600
000023  2322
000024  2662
000025  4640
000026  1060
000027  0000
000030  6260

/SERIAL-BASED DISK SYSTEM                 PAL8-V13B NO DATE   PAGE 1-1

000031  7732                 BOOT-ENDB

       0000                  RELOC 0

000000* 7200         BOOT,   CLA
000001* 1413                 TAD I BOOTX1    /COPY FROM 00200-00400 TO 07600-00000
000002* 3414                 DCA I BOOTX2
000003* 1415                 TAD I BOOTX3    /COPY FROM 00047-00247 TO 17647-10047
000004* 6211                 CDF 10
000005* 3416                 DCA I BOOTX4
000006* 6201                 CDF 0
000007* 1014                 TAD BOOTX2
000010* 7640                 SZA CLA         /DONE?
000011* 5001                 JMP BOOT+1      /NO, KEEP COPYING
000012* 5444                 JMP I B7605     /JUMP TO OS/8
000013* 0177         BOOTX1, 177
000014* 7577         BOOTX2, 7577
000015* 0046         BOOTX3, 46
000016* 7646         BOOTX4, 7646
000017* 0017         ADDR,   17
                     ZBLOCK 20-.
000020* 7240                 CLA CMA         /AC=7777
000021* 3017                 DCA ADDR        /SET UP ADDRESS
000022* 1045                 TAD BOOTMS      /SEND BOOT MESSAGE TO SERVER
000023* 6416                 STLS
000024* 6411                 STSF
000025* 5024                 JMP .-1
000026* 6402         RDLP,   SKCC            /CLEAR AC AND FLAG
000027* 6401                 SKSF            /SKIP IF FLAG SET
000030* 5027                 JMP .-1
000031* 6406                 SKRB            /READ BUFFER
000032* 7106                 CLL RTL         /ROTATE 6 LEFT
000033* 7006                 RTL
000034* 7510                 SPA             /CHANNEL 8 PUNCHED?
000035* 5000                 JMP BOOT        /YES, CONTINUE BOOTING
000036* 7006                 RTL
000037* 6401                 SKSF            /SKIP IF FLAG SET
000040* 5037                 JMP .-1
000041* 6404                 SKRS            /OR BUFFER WITH AC
000042* 3417                 DCA I ADDR      /STORE CONTENTS
000043* 5026                 JMP RDLP        /KEEP LOOPING
000044* 7605         B7605,  7605            /ADDRESS OF OS/8 ENTRY
000045* 0100         BOOTMS, 100             /"@" COMMAND TO SERVER
       0100          ENDB,   RELOC

       0200                  *200
       7600                  RELOC 7600
007600* 0000                 ZBLOCK 7
007607* 0003         ENTRY1, VERS
007610* 7300                 CLA CLL         /CLEAR LINK FOR FIRST PLATTER
007611* 6400         SETUP,  SKCF            /CLEAR RECEIVE FLAG
007612* 1336                 TAD WKUP        /ADD WAKEUP CHARACTER
007613* 4266                 JMS SENDC       /SEND WAKEUP CHARACTER
007614* 7200                 CLA
007615* 6214                 RDF             /GET CURRENT FIELD

/SERIAL-BASED DISK SYSTEM                 PAL8-V13B NO DATE   PAGE 1-2

007616* 1333                 TAD SCDI        /ADD CDI
007617* 3327                 DCA SFIELD      /DEPOSIT MODIFIED CIF
                     /SKSF           /WAIT FOR RESPONSE
                     /JMP .-1
                     /SKCF           /CLEAR FLAG
007620* 1607                 TAD I ENTRY1    /GET FUNCTION
007621* 4273                 JMS SNDNUM      /TELL SERVER FUNCTION
007622* 2207                 ISZ ENTRY1      /LOOK AT BUFFER ADDRESS
007623* 1607                 TAD I ENTRY1    /GET BUFFER ADDRESS
007624* 4273                 JMS SNDNUM      /TELL SERVER BUFFER ADDRESS
007625* 1607                 TAD I ENTRY1    /GET BUFFER ADDRESS
007626* 3334                 DCA SLOC        /STORE BUFFER ADDRESS
007627* 2207                 ISZ ENTRY1      /LOOK AT STARTING BLOCK NUMBER
007630* 1607                 TAD I ENTRY1    /GET STARTING BLOCK NUMBER
007631* 4273                 JMS SNDNUM      /TELL SERVER STARTING BLOCK NUMBER
007632* 2207                 ISZ ENTRY1      /LOOK AT ERROR RETURN
007633* 4301                 JMS GETNUM      /RECEIVE CDF INSTRUCTION
007634* 3250                 DCA CDFSTO
007635* 4301                 JMS GETNUM      /RECEIVE NEGATIVE WORD COUNT
007636* 3335                 DCA WORDCT
007637* 4301         GETACK, JMS GETNUM      /4000=READ, 4001=WRITE, 0000=DONE, 2000=ERROR
007640* 7450                 SNA             /WAS IT ZERO?
007641* 5326                 JMP EXIT        /YES, EXIT
007642* 7104                 CLL RAL         /NO, IS HIGH BIT SET?
007643* 7420                 SNL
007644* 5331                 JMP ERROR       /NO, ERROR!
007645* 7640                 SZA CLA         /YES, READ OR WRITE?
007646* 5313                 JMP TXPG        /TIME TO WRITE

007647* 4301         RXLP,   JMS GETNUM      /GET WORD
007650* 7402         CDFSTO, HLT             /MODIFIED TO CDF
007651* 3734                 DCA I SLOC      /STORE CONTENTS
007652* 6201                 CDF 0
007653* 2334                 ISZ SLOC        /NEXT LOCATION
007654* 7000                 NOP
007655* 2335                 ISZ WORDCT      /INCREMENT WORD COUNT...DONE?
007656* 5247                 JMP RXLP        /NO, KEEP LOOPING
007657* 5237                 JMP GETACK      /ANY OTHER REQUESTS?

007660* 0003         ENTRY2, VERS            /SECOND ENTRY POINT
007661* 7200                 CLA
007662* 1260                 TAD ENTRY2      /GET ARGUMENT ADDRESS
007663* 3207                 DCA ENTRY1      /STORE IT IN COMMON PLACE
007664* 7301                 CLA CLL IAC     /SET AC = 1 FOR 2ND PLATTER
007665* 5211                 JMP SETUP       /CONTINUE WITH SETUP

007666* 0000         SENDC,  0               /SEND CHARACTER IN AC
007667* 6416                 STLS
007670* 6411                 STSF
007671* 5270                 JMP .-1
007672* 5666                 JMP I SENDC
                     
007673* 0000         SNDNUM, 0               /SEND NUMBER AS TWO CONSECUTIVE CHARACTERS
007674* 4266                 JMS SENDC       /SEND BOTTOM 8 BITS OF WORD
007675* 7002                 BSW             /SEND TOP 6 BITS OF WORD PLUS SOME, LET SERVER HANDLE IT

/SERIAL-BASED DISK SYSTEM                 PAL8-V13B NO DATE   PAGE 1-3

007676* 4266                 JMS SENDC
007677* 7200                 CLA
007700* 5673                 JMP I SNDNUM

007701* 0000         GETNUM, 0
007702* 6402                 SKCC            /CLEAR AC AND FLAG
007703* 6401                 SKSF            /SKIP IF FLAG SET
007704* 5303                 JMP .-1
007705* 6406                 SKRB            /READ BUFFER
007706* 7002                 BSW             /SWAP BYTES
007707* 6401                 SKSF            /SKIP IF FLAG SET
007710* 5307                 JMP .-1
007711* 6404                 SKRS            /OR BUFFER WITH AC
007712* 5701                 JMP I GETNUM

007713* 1250         TXPG,   TAD CDFSTO      /GET DATA FIELD
007714* 3315                 DCA TXCDF       /MODIFY CDF FOR TRANSFER
007715* 7402         TXCDF,  HLT             /MODIFIED TO CDF
007716* 1734                 TAD I SLOC      /GET WORD
007717* 6201                 CDF 0           /BACK TO FIELD 0
007720* 2334                 ISZ SLOC        /NEXT LOCATION
007721* 7000                 NOP
007722* 4273                 JMS SNDNUM      /SEND IT
007723* 2335                 ISZ WORDCT      /INCREMENT WORD COUNT...DONE?
007724* 5315                 JMP TXCDF       /NO, KEEP LOOPING
007725* 5237                 JMP GETACK      /ANY MORE REQUESTS?

007726* 2207         EXIT,   ISZ ENTRY1      /NORMAL EXIT
007727* 7402         SFIELD, HLT             /MODIFIED TO CDI
007730* 5607                 JMP I ENTRY1    /EXIT WITH FATAL ERROR
007731* 7130         ERROR,  CLL CML RAR     /ROTATE ERROR CODE AND SET NEGATIVE BIT
007732* 5327                 JMP SFIELD      /ERROR EXIT
                     
007733* 6203         SCDI,   CIF CDF 0
007734* 0000         SLOC,   0
007735* 0000         WORDCT, 0
007736* 0101         WKUP,   101
007737* 0000                 ZBLOCK 7743-.
       0343                  RELOC
             $

/SERIAL-BASED DISK SYSTEM                 PAL8-V13B NO DATE   PAGE 2

ADDR   0017      
BASER  6400      
BASET  6410      
BLKNUM 6260      
BOOT   0000      
BOOTMS 0045      
BOOTX1 0013      
BOOTX2 0014      
BOOTX3 0015      
BOOTX4 0016      
B7605  0044      
CDFSTO 7650      
ENDB   0046      
ENTRY1 7607      
ENTRY2 7660      
ERROR  7731      
EXIT   7726      
GETACK 7637      
GETNUM 7701      
RDLP   0026      
RXLP   7647      
SCDI   7733      
SENDC  7666      
SETUP  7611      
SFIELD 7727      
SKCC   6402      
SKCF   6400      
SKIE   6405      
SKRB   6406      
SKRS   6404      
SKSF   6401      
SLOC   7734      
SNDNUM 7673      
STCF   6412      
STFL   6410      
STLS   6416      
STPC   6414      
STSF   6411      
STSK   6415      
TXCDF  7715      
TXPG   7713      
VERS   0003      
WKUP   7736      
WORDCT 7735      



ERRORS DETECTED: 0
LINKS GENERATED: 0



