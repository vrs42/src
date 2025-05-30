
/PARAMETERS FOR RTS-8 TASKS     (VERSION  PAL8-V9H  04/29/77  PAGE 1

   1                /PARAMETERS FOR RTS-8 TASKS     (VERSION 2)

/PARAMETERS FOR RTS-8 TASKS     (VERSION  PAL8-V9H  04/29/77  PAGE 5

   2                /TASK TABLE SETUP - "TASK", "CUR","INIWT", AND "START"
   3                /MUST BE DEFINED BY TASK:
   4   
   5          1206          *TASK^2+MSGTBL
   6   01206  0000          ZBLOCK  2       /MESSAGE BUFFER INITIALLY CLEAR
   7          1242          *TASK^4+TSTABL
   8   01242  0011          CUR%10+CUR      /INITIAL FLAGS
   9   01243  6011          START
  10   01244  0000          0               /INITIAL AC 0
  11          1305          *TASK+TFTABL
  12   01305  0000          INIWT
  13          1224          *TASK2^2+MSGTBL
  14   01224  0000          ZBLOCK  2       /MESSAGE BUFFER INITIALLY CLEAR
  15          1276          *TASK2^4+TSTABL
  16   01276  0011          CUR2%10+CUR2    /INITIAL FLAGS2
  17   01277  6051          START2
  18   01300  0000          0               /INITIAL AC 0
  19          1314          *TASK2+TFTABL
  20   01314  0000          INIWT2

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 6

  21                /MCR FOR RTS8 V2                        8/30/74
  22                /
  23                /
  24                /
  25                /
  26                /
  27                /
  28                /
  29                /
  30                /
  31                /COPYRIGHT  (C)  1974,1975 BY DIGITAL EQUIPMENT CORPORATION
  32                /
  33                /
  34                /
  35                /
  36                /
  37                /
  38                /
  39                /
  40                /
  41                /
  42                /THE INFORMATION IN THIS DOCUMENT IS SUBJECT TO CHANGE WITHOUT NOTICE
  43                /AND SHOULD NOT BE CONSTRUED AS A COMMITMENT BY DIGITAL EQUIPMENT
  44                /CORPORATION.  DIGITAL EQUIPMENT CORPORATION ASSUMES NO RESPONSIBILITY
  45                /FOR ANY ERRORS THAT MAY APPEAR IN THIS DOCUMENT.
  46                /
  47                /THE SOFTWARE DESCRIBED IN THIS DOCUMENT IS FURNISHED TO THE PURCHASER
  48                /UNDER A LICENSE FOR USE ON A SINGLE COMPUTER SYSTEM AND CAN BE COPIED
  49                /(WITH INCLUSION OF DIGITAL'S COPYRIGHT NOTICE) ONLY FOR USE IN SUCH
  50                /SYSTEM, EXCEPT AS MAY OTHERWISE BE PROVIDED IN WRITING BY DIGITAL.
  51                /
  52                /DIGITAL EQUIPMENT CORPORATION ASSUMES NO RESPONSIBILITY FOR THE USE
  53                /OR RELIABILITY OF ITS SOFTWARE ON EQUIPMENT THAT IS NOT SUPPLIED BY
  54                /DIGITAL.
  55                /
  56                /
  57                /
  58                /
  59                /
  60                /
  61                /
  62                /
  63                /
  64                /

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 7

  65                / M. HURLEY / R. LARY
  66   
  67                /THE MONITOR CONSOLE ROUTINE ALLOWS THE OPERATOR/PROGRAMMER OF AN
  68                /RTS-8 SYSTEM TO CONTROL AND OBSERVE THE STATE OF THE SYSTEM
  69                /THROUGH THE CONSOLE TELETYPE.
  70   
  71          0004  TASK=   MCR
  72          0010  CUR=    10
  73          0000  INIWT=  0
  74   
  75   
  76                /PARAMETERS FOR SOMEWHAT FANCIER NULL TASK WHICH COMES WITH MCR
  77   
  78          0013  TASK2= NTASKS+1 /LOWEST PRIORITY TASK IN SYSTEM - UNADDRESSABLE
  79          0010  CUR2=   CUR     /SAME FIELD AS MCR
  80          0000  INIWT2= 0       /COMES UP RUNNING
  81   
  82          0052  INLENG= 52      /LENGTH OF INPUT BUFFER
  83          0034  NMFIT=  34      /NUMBER OF NAMES WHICH CAN SHARE A PAGE WITH CODE
  84   
  85          0001          FIELD CUR%10
  86   
  87          0100          *100
  88   10100  6112  ERRDLM, DLMER
  89   10101  6120  ERRNUM, NUMER
  90   10102  6104  ERRNAM, NAMER
  91   10103  5400  GET,    GETA
  92   10104  0000  NUMB,   0       /GETN RESULT
  93   10105  6000  ENDSTF, ENDS
  94   10106  5460  BCKUP,  BACKUP
  95   10107  5436  LEGLIM, LEGAL
  96   10110  5465  EOL,    EOLA
  97   10111  0000  ACL,    0       /2 WORD AC
  98   10112  0000  ACH,    0
  99   10113  0000  Q,      0       /ALL USAGE TEMPS
 100   10114  0000  V,      0
 101   10115  0000  P,      0
 102          4516  PUTW=   JMS I   .
 103   10116  5432          PUTWX

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 8

 104          5200          *MCRSYS^7600+5400
 105          5400          IFNZRO  NTASKS-NMFIT&4000       <*.+200>        /SAVE NAME PG
 106   
 107                /GET NEXT CHARACTER ROUTINE
 108                /ADVANCE POINTER FOR NEXT GET
 109   
 110   15400  0000  GETA,   0
 111   15401  1604          TAD I   IP
 112   15402  2204          ISZ     IP
 113   15403  5600          JMP I   GETA
 114   15404  0000  IP,     0
 115   
 116                /DETERMINES IF NEXT CHARACTER IS ALPHABETIC OR NUMERIC
 117                /EXIT IF NOT; EXIT+1 IF ALPHA OR NUM
 118   
 119   15405  0000  ALPNUM, 0               
 120   15406  4503          JMS I   GET
 121   15407  3113          DCA     Q
 122   15410  1113          TAD     Q
 123   15411  1377          TAD     (-333
 124   15412  7100          CLL
 125   15413  1376          TAD     (32
 126   15414  7630          SZL CLA         /TEST FOR ALPHA
 127   15415  2205          ISZ     ALPNUM  /BUMP RETURN IF ALPHA
 128   15416  1113          TAD     Q       /NOW TEST FOR NUMERIC
 129   15417  4222          JMS     ISITNM
 130   15420  2205          ISZ     ALPNUM
 131   15421  5605          JMP I   ALPNUM
 132   
 133                /SEE IF CHARACTER IN AC IS NUMERAL
 134                /EXIT IF IS; EXIT+1 IF NOT
 135   
 136   15422  0000  ISITNM, 0       
 137   15423  1375          TAD     (-"9-1
 138   15424  7100          CLL
 139   15425  1374          TAD     (12     /CHECK FOR RANGE 260-271
 140   15426  7420          SNL
 141   15427  2222          ISZ     ISITNM  /BUMP RETURN ADDRESS IF NOT IN RANGE
 142   15430  1373          TAD     (260    /RESTORE CHAR
 143   15431  5622          JMP I   ISITNM
 144   
 145   15432  0000  PUTWX,  0               /ROUTINE TO STORE A WORD IN THE OUTPUT BUFFER
 146   15433  3704          DCA I   W
 147   15434  2304          ISZ     W
 148   15435  5632          JMP I   PUTWX

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 9

 149                /CHECK NEXT CHAR FOR TYPE OF DELIMITER
 150                /EXIT=  NOT CR,ALTMODE,SPACE, OR COMMA
 151                /EXIT+1=CR OR ALTMODE
 152                /EXIT+2=SPACE OR COMMA
 153   
 154   15436  0000  LEGAL,  0
 155   15437  4503          JMS I   GET     
 156   15440  3113          DCA     Q
 157   15441  1113          TAD     Q
 158   15442  7141          CIA CLL
 159   15443  7510          SPA             /CR OR ALTMODE?
 160   15444  5250          JMP     NOCRAL  /NO
 161   15445  7264          STA CML RAL     /GENERATE -2 IF CR, -1 IF ALTMODE
 162   15446  3272          DCA     CRALT
 163   15447  5256          JMP     ITSEOL
 164   15450  1372  NOCRAL, TAD     (240    /BLANK?
 165   15451  7440          SZA
 166   15452  1371          TAD     (",-240 /COMMA?
 167   15453  7640          SZA CLA
 168   15454  5257          JMP     NOGOOD  /NEITHER
 169   15455  2236          ISZ     LEGAL   /SPACE OR COMMA
 170   15456  2236  ITSEOL, ISZ     LEGAL   /CR,ALT
 171   15457  5636  NOGOOD, JMP I   LEGAL
 172   
 173   15460  0000  BACKUP, 0               /BACK UP INBUF POINTER BY 1 CHAR
 174   15461  7240          CLA CMA
 175   15462  1204          TAD     IP
 176   15463  3204          DCA     IP
 177   15464  5660          JMP I   BACKUP
 178   
 179   15465  0000  EOLA,   0               /SEARCH FOR C.R. OR ALTMODE
 180   15466  4507          JMS I   LEGLIM
 181   15467  5500          JMP I   ERRDLM  /CRAP AT END OF LINE
 182   15470  5665          JMP I   EOLA
 183   15471  5266          JMP     EOLA+1
 184   
 185   15472  0000  CRALT,  0

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 10

 186   15473  0000  TTOUT,  0
 187   15474  4516          PUTW            /TERMINATE LINE
 188   15475  4020          CAL
 189   15476  0011          SENDW
 190   15477  0005          TTY             /SEND MESSAGE TO TTY AND WAIT
 191   15500  5505          EXMSG
 192   15501  1370          TAD     (E1MSG  /INITIALIZE POINTER FOR NEXT LINE
 193   15502  3304          DCA     W
 194   15503  5673          JMP I   TTOUT
 195   
 196   15504  5512  W,      E1MSG
 197   
 198   15505  0000  EXMSG,  ZBLOCK  3       /OUTPUT BUFFER SHARES SPACE WITH INPUT BUFFER
 199   15510  0000          0
 200   15511  0000          0
 201                E1MSG,
 202   15512  0000  INBUF,  ZBLOCK  INLENG  /INPUT BUFFER
 203   15570  5512
 204   15571  0014
 205   15572  0240
 206   15573  0260
 207   15574  0012
 208   15575  7506
 209   15576  0032
 210   15577  7445
 211          5600          PAGE

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 11

 212                /ROUTINE TO PARSE OFF A TASK NAME OR NUMBER
 213   
 214   15600  5601  NAMEA,  XNAME
 215   15601  0000  XNAME,  0       /USED FOR TEMP STORAGE OF ACCUMULATED NAME
 216   15602  0000  XNAME1, 0
 217   
 218   15603  0000  GETTSK, 0               /THIS SUBR RETURNS TASK NUMBER IN "TSKWD"
 219   15604  4232          JMS     NAMGET
 220   15605  5223          JMP     NUMTSK
 221   15606  4300          JMS     NAMCOM  /OK SO FAR.
 222                                        /NOW CHECK FOR NAME DUPLICATION
 223   15607  5502          JMP I   ERRNAM
 224   15610  1114          TAD     V
 225   15611  1377          TAD     (NTASKS+1       /GET NUMBER ASSOC. WITH THIS NAME
 226   15612  3277  GOTASK, DCA     TSKWD   /AND THAT'S THE TASK NUMBER
 227   15613  1277          TAD     TSKWD
 228   15614  7041          CIA
 229   15615  7100          CLL
 230   15616  1376          TAD     (NTASKS /MUST BE BETWEEN 1 + NTASKS
 231   15617  7620          SNL CLA
 232   15620  5501          JMP I   ERRNUM
 233   15621  1277          TAD     TSKWD
 234   15622  5603          JMP I   GETTSK  /RETURN WITH TASK NUMBER IN AC
 235   15623  4506  NUMTSK, JMS I   BCKUP   /IT'S A NUMBER - MUST BACK UP PTR
 236   15624  4775          JMS I   (OCTNUM /SO GO ACCUMULATE IT
 237   15625  4506          JMS I   BCKUP
 238   15626  4503          JMS I   GET     /GET DELIMITING CHAR
 239   15627  7200          CLA
 240   15630  1104          TAD     NUMB
 241   15631  5212          JMP     GOTASK

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 12

 242   15632  0000  NAMGET, 0
 243   15633  1200          TAD     NAMEA
 244   15634  3276          DCA     G7
 245   15635  7344          AC7776
 246   15636  3275          DCA     G3
 247   15637  1374          TAD     (4040
 248   15640  3202          DCA     XNAME1
 249   15641  4773          JMS I   (ALPNUM /ONLY ALPHAS + NUMBERS LEGAL
 250   15642  5772          JMP I   (CHRER
 251   15643  1371          TAD     (-300
 252   15644  7710          SPA CLA         /NAME OR NUMBER?
 253   15645  5632          JMP I   NAMGET  /BY NUMBER
 254   15646  2232          ISZ     NAMGET
 255   15647  1113          TAD     Q
 256   15650  0370  NXT,    AND     (77
 257   15651  7126          STL RTL         /40 IN LOW 6 BITS
 258   15652  7006          RTL
 259   15653  7006          RTL
 260   15654  3676          DCA I   G7
 261   15655  4773          JMS I   (ALPNUM
 262   15656  5270          JMP     ENDX    /2ND CHAR IS NOT ALPHANUMERIC
 263   15657  0370          AND     (77
 264   15660  1367          TAD     (-40    /REMOVE LOW 40
 265   15661  1676          TAD I   G7
 266   15662  3676          DCA I   G7      /SAVE 1ST 2 CHARS
 267   15663  2276          ISZ     G7
 268   15664  2275          ISZ     G3      /4 CHARS YET?
 269   15665  4773          JMS I   (ALPNUM
 270   15666  5270          JMP     ENDX    /3RD CHAR NON-ALPHANUMERIC
 271   15667  5250          JMP     NXT     /GO DO 3RD+4TH CHARS
 272   15670  4506  ENDX,   JMS I   BCKUP
 273   15671  4507  END,    JMS I   LEGLIM
 274   15672  5271          JMP     END
 275   15673  7000          NOP
 276   15674  5632          JMP I   NAMGET
 277   
 278   15675  0000  G3,     0
 279   15676  0000  G7,     0
 280   15677  0000  TSKWD,  0

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 13

 281                /COMPARE NAME IN XNAME WITH NMTBL, LOOKING FOR MATCHES.
 282   
 283   15700  0000  NAMCOM, 0
 284   15701  1366          TAD     (NMTBL-1
 285   15702  3115          DCA     P
 286   15703  1365          TAD     (-NTASKS-1
 287   15704  3114          DCA     V
 288   15705  2115  CHKMOR, ISZ     P       /UPDATE PAST UNNEED INFO
 289   15706  2114          ISZ     V       /DONE?
 290   15707  7410          SKP
 291   15710  5700          JMP I   NAMCOM  /YES
 292   15711  1515          TAD I   P       /GET 2 CHARACTERS FROM NMTBL
 293   15712  2115          ISZ     P
 294   15713  7041          CIA
 295   15714  1201          TAD     XNAME   /COMPARE TO NAME UNDER INVESTIGATION
 296   15715  7640          SZA CLA
 297   15716  5305          JMP     CHKMOR  /N.G. CONTINUE THRU NMTBL
 298   15717  1202          TAD     XNAME1  /TRY 2ND 2 CHARS FOR MATCH
 299   15720  7041          CIA
 300   15721  1515          TAD I   P
 301   15722  7640          SZA CLA
 302   15723  5305          JMP     CHKMOR  /NOT CLOSE ENOUGH
 303   15724  2300          ISZ     NAMCOM  /FOUND IT
 304   15725  5700          JMP I   NAMCOM

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 14

 305                /RUN THE REQUESTED TASK. TO SCHED FIRST
 306   
 307   15726  1277  REQUST, IFDEF   CLOCK   <TAD    TSKWD>
 308   15727  4020          CAL
 309   15730  0003          RUN
 310   15731  5335          JMP     BKELEN
 311   
 312                /STOP THE REQUESTED TASK
 313   
 314   15732  4203  STOP,   JMS     GETTSK
 315   15733  4020          CAL
 316   15734  0004          SUSPND
 317   15735  4506  BKELEN, JMS I   BCKUP
 318   15736  4510          JMS I   EOL
 319   15737  5505          JMP I   ENDSTF
 320   
 321                /ENABLE A TASKS EXECUTION
 322   
 323   15740  4203  ENABLE, JMS     GETTSK
 324   15741  4020          CAL
 325   15742  0012          UNBARG          /UNBLOCK THE TASK ON
 326   15743  0040          ENABWT          /ENABLE WAIT
 327   15744  5335          JMP     BKELEN  /CLEAN UP
 328   
 329                /DISABLE A TASKS EXECUTION
 330   
 331   15745  4203  DISABL, JMS     GETTSK
 332   15746  4020          CAL
 333   15747  0010          BLKARG          /BLOCK THE TASK ON
 334   15750  0040          ENABWT          /ENABLE WAIT
 335   15751  5335          JMP     BKELEN  /CLEAN UP
 336   15765  7765
 337   15766  6177
 338   15767  7740
 339   15770  0077
 340   15771  7500
 341   15772  6076
 342   15773  5405
 343   15774  4040
 344   15775  6633
 345   15776  0012
 346   15777  0013
 347          6000          PAGE

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 15

 348                /COMMAND CLEANUP AND NEW COMMAND FETCH
 349   
 350   16000  2777  ENDS,   ISZ I   (CRALT  /ALT-MODE EXIT?
 351   16001  5211          JMP     START   /NO-CR EXIT
 352   16002  6002          IOF             /"WAITM" REQUIRES IOF ON ENTRY
 353   16003  6203          CDF CIF 0
 354   16004  1376          TAD     (4000+TASK
 355   16005  3775          DCA I   (MCREF
 356   16006  6211          CDF CUR         /SUSPEND MCR ON ^C EVENT FLAG
 357   16007  4425          WAITM           /WITHOUT LETTING INTERRUPTS GO BACK ON!
 358   16010  2000          EFWT
 359   16011  4020  START,  CAL
 360   16012  0011          SENDW
 361   16013  0005          TTY
 362   16014  6043          MCRMES
 363   16015  1247          TAD     PINBUF
 364   16016  3774          DCA I   (IP
 365   16017  3777          DCA I   (CRALT
 366   16020  4507          JMS I   LEGLIM  /LOOK AT FIRST CHAR
 367   16021  5224          JMP     .+3     /SOMETHING USEFUL
 368   16022  5505          JMP I   ENDSTF  /CR OR ALT - NULL LINE
 369   16023  5220          JMP     .-3     /SPACE OR COMMA - KEEP LOOKING FOR MEAT
 370   16024  4506          JMS I   BCKUP   /FOUND MEAT - BACK UP OVER IT
 371   16025  4773          JMS I   (NAMGET /GET COMMAND NAME
 372   16026  5502          JMP I   ERRNAM
 373   16027  1372          TAD     (CMDLST-1
 374   16030  3115          DCA     P
 375   16031  2115  CMDLP,  ISZ     P
 376   16032  1515          TAD I   P       /GET 1ST 2 CHARS OF A COMMAND
 377   16033  2115          ISZ     P
 378   16034  7440          SZA             /0 TERMINATES COMMAND LIST
 379   16035  1771          TAD I   (XNAME
 380   16036  7640          SZA     CLA     /A MATCH?
 381   16037  5231          JMP     CMDLP   /NO-TRY AGAIN
 382   16040  1515          TAD I   P       /YES - GET COMMAND DISPATCH ADDRESS
 383   16041  3115          DCA     P
 384   16042  5515          JMP I   P       /WE'RE ON OUR WAY
 385   
 386   16043  0000  MCRMES, ZBLOCK 3
 387   16046  2052          2000+INLENG
 388   16047  5512  PINBUF, INBUF
 389   16050  7600  L7600,  TEXT    />/
 390   
 391   16051  1250  START2, TAD     L7600   /RSX-11D STYLE NULL TASK
 392   16052  2262  BKGLP,  ISZ     BKGCT
 393   16053  2262          ISZ     BKGCT
 394   16054  2262          ISZ     BKGCT
 395   16055  2262          ISZ     BKGCT
 396   16056  2262          ISZ     BKGCT
 397   16057  5252          JMP     BKGLP
 398   16060  7010          RAR
 399   16061  5252          JMP     BKGLP
 400   16062  0000  BKGCT,  0

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 16

 401   16063  0000  ERMSG,  ZBLOCK  3       /STANDARD MESSAGE HEADER
 402   16066  1000          1000            /SIXBIT MESSAGE, END WITH CRLF, INDIRECT
 403   16067  0000          0               /NO INPUT
 404   16070  0000  ERRA,   0               /JMS PUTS POINTER TO ERROR MESSAGE HERE
 405   16071  4020          CAL             /AC RANDOM BUT IRRELEVANT
 406   16072  0011          SENDW
 407   16073  0005          TTY
 408   16074  6063          ERMSG
 409   16075  5211          JMP     START
 410   
 411   16076  4270  CHRER,  JMS     ERRA
 412   16077  0201          TEXT    /BAD CHAR/
 413   16100  0440
 414   16101  0310
 415   16102  0122
 416   16103  0000
 417   16104  4270  NAMER,  JMS     ERRA
 418   16105  0201          TEXT    /BAD NAME/
 419   16106  0440
 420   16107  1601
 421   16110  1505
 422   16111  0000
 423   16112  4270  DLMER,  JMS     ERRA
 424   16113  0201          TEXT    /BAD DELIM/
 425   16114  0440
 426   16115  0405
 427   16116  1411
 428   16117  1500
 429   16120  4270  NUMER,  JMS     ERRA
 430   16121  0201          TEXT    /BAD NUMBER/
 431   16122  0440
 432   16123  1625
 433   16124  1502
 434   16125  0522
 435   16126  0000

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 17

 436                /COMMAND LIST - FORMAT OF LIST IS:
 437                /       NAME
 438                /       OVERLAY NO.
 439                /       ST. ADDR. IN OVERLAY
 440   
 441   16127  5454  CMDLST, -2324;  STOP    /STOP
 442   16130  5732
 443   16131  7262          -0516;  ENABLE  /ENABLE
 444   16132  5740
 445   16133  7367          -0411;  DISABL  /DISABLE
 446   16134  5745
 447   16135  6177          -1601;  NAME    /NAME
 448   16136  6224
 449                        IFDEF   CLOCK   <
 450   16137  7377          -0401;  DATEX   /DATE
 451   16140  7200
 452   16141  5367          -2411;  TIME    /TIME
 453   16142  7000
 454   16143  7477          -0301;  CANCEL  /CANCEL
 455   16144  7450
 456                        >
 457   16145  5573          -2205;  SCHED   /REQUEST
 458   16146  7400
 459   16147  6060          -1720;  EXAM    /OPEN
 460   16150  6726
 461   16151  7373          -0405;  DEPSIT  /DEPOSIT
 462   16152  6670
 463   16153  5761          -2017;  POSTEF  /POST
 464   16154  6714
 465                        IFNZRO  MCRSYS  <
 466   16155  5447          -2331;  SYSTAT  /SYSTAT
 467   16156  6400
 468                        >
 469   16157  7250          -0530;  EXIT    /EXIT
 470   16160  6251
 471   16161  0000          0;      NAMER   /END OF LIST
 472   16162  6104
 473   16171  5601
 474   16172  6126
 475   16173  5632
 476   16174  5404
 477   16175  0041
 478   16176  4004
 479   16177  5472
 480          6200          PAGE

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 18

 481                /FORMAT OF NMTBL IS 2 WORDS OF 4 6-BIT CHARS
 482                /ORDERED BY NUMBER OF TASK AFFILIATED WITH THAT NAME
 483                /NAMES MUST BE PADDED WITH BLANKS!
 484   
 485   16200  0000  NMTBL,  ZBLOCK  NTASKS^2
 486          6176  NAMES=  NMTBL-2
 487   
 488          6206          *MCR^2+NAMES
 489   16206  1503          1503;   2240    /MCR
 490   16207  2240
 491                        IFDEF   TTY     <
 492          6210          *TTY^2+NAMES
 493   16210  2424          2424;   3140    /TTY
 494   16211  3140
 495                        >
 496                        IFDEF   CLOCK   <
 497          6200          *CLOCK^2+NAMES
 498   16200  0314          DEVICE  CLCK
 499   16201  0313
 500                        >
 501                        IFDEF   RK8     <
 502          6202          *RK8^2+NAMES
 503   16202  2213          2213;   7040    /RK8
 504   16203  7040
 505                        >

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 19

 506                /NAME TABLE CONTINUED
 507   
 508                        IFDEF   OS8F    <
 509          6212          *OS8F^2+NAMES
 510   16212  1723          DEVICE  OS8F
 511   16213  7006
 512                        >
 513                        IFDEF   OS8     <
 514          6222          *OS8^2+NAMES
 515   16222  1723          1723;   7040    /OS8
 516   16223  7040
 517                        >
 518                        IFDEF LTA       <
 519          6204          *LTA^2+NAMES
 520   16204  1424          1424;0140               /LTA
 521   16205  0140
 522                        >
 523   
 524   
 525   
 526   
 527   
 528          6224          *NTASKS^2+NMTBL /ORIGIN TO END OF TABLE

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 20

 529                /ASSOCIATE A NAME WITH A TASK NUMBER
 530   
 531   16224  4777  NAME,   JMS I   (GETTSK /GET TASK NUMBER TO GIVE THIS NAME TO
 532   16225  7104          RAL CLL         /INDEX INTO NMTBL
 533   16226  1376          TAD     (NAMES
 534   16227  3112          DCA     ACH     
 535   16230  4506          JMS I   BCKUP
 536   16231  4507          JMS I   LEGLIM
 537   16232  5500          JMP I   ERRDLM
 538   16233  5500          JMP I   ERRDLM  /NO CR BEFORE NUMBER
 539   16234  4775          JMS I   (NAMGET
 540   16235  5502          JMP I   ERRNAM
 541   16236  4774          JMS I   (NAMCOM /CHECK FOR DUPLICATION OF NAMES
 542   16237  7410          SKP
 543   16240  5502          JMP I   ERRNAM  /BAD NAME - ALREADY EXISTS
 544   16241  4506          JMS I   BCKUP
 545   16242  4510          JMS I   EOL
 546   16243  1773          TAD I   (XNAME
 547   16244  3512          DCA I   ACH     /1 WORD
 548   16245  2112          ISZ     ACH
 549   16246  1772          TAD I   (XNAME1
 550   16247  3512          DCA I   ACH     /THEN THE OTHER
 551   16250  5505          JMP I   ENDSTF
 552   
 553   16251  1772  EXIT,   TAD I   (XNAME1
 554   16252  1371          TAD     (-1124  /VERIFY THAT "EXIT" WAS TYPED
 555   16253  7640          SZA CLA
 556   16254  5770          JMP I   (EXAM   /OTHERWISE ASSUME USER MEANT "EXAMINE"
 557   16255  6201          CDF     0
 558   16256  3767          DCA I   (TSWFLG /INHIBIT TASK SWITCHING
 559   16257  2114          ISZ     V
 560   16260  5257          JMP     .-1     /ALLOW (MOST) I/O TO COMPLETE
 561   16261  2266          ISZ     EXDLAY
 562   16262  5257          JMP     .-3
 563   16263  6002          IOF
 564   16264  6203          CDF CIF 0
 565   16265  5766          JMP I   (7600
 566   
 567   16266  7720  EXDLAY, -60

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 21

 568   16267  0000  PR12BT, 0               /PRINT 2 3-BIT NUMBERS
 569   16270  3113          DCA     Q
 570   16271  1113          TAD     Q
 571   16272  7112          CLL RTR
 572   16273  7012          RTR
 573   16274  7012          RTR
 574   16275  4301          JMS     PRNTNM  /PASS 2 DIGIT NO.
 575   16276  1113          TAD     Q
 576   16277  4301          JMS     PRNTNM  /PASS LAST 2 DIGITS
 577   16300  5667          JMP I   PR12BT
 578   
 579   16301  0000  PRNTNM, 0
 580   16302  0365          AND     (77
 581   16303  3114          DCA     V
 582   16304  1114          TAD     V
 583   16305  7106          CLL RTL
 584   16306  7004          RAL
 585   16307  0364          AND     (707    /GET LEFT DIGIT
 586   16310  1114          TAD     V
 587   16311  0364          AND     (707    /RIGHT DIGIT
 588   16312  1363          TAD     (6060
 589   16313  4516          PUTW
 590   16314  5701          JMP I   PRNTNM
 591   16363  6060
 592   16364  0707
 593   16365  0077
 594   16366  7600
 595   16367  0035
 596   16370  6726
 597   16371  6654
 598   16372  5602
 599   16373  5601
 600   16374  5700
 601   16375  5632
 602   16376  6176
 603   16377  5603
 604          6400          PAGE

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 22

 605                        IFNZRO  MCRSYS  <
 606                /PRINT A STATUS TABLE
 607                /FORMAT IS: NO. OF TASK
 608                /       AFFILIATED NAME IF ANY
 609                /       STATE OF FLAGS:
 610                /       E=      EVENT           M=      MESSAGE
 611                /       S=      SWAP            R=      RUN
 612                /       U=      USER            D=      DISABLED
 613                /       O=      EVENT OR MESSAGE
 614   
 615   16400  3114  SYSTAT, DCA     V
 616   16401  4506          JMS I   BCKUP
 617   16402  4507          JMS I   LEGLIM
 618   16403  5500          JMP I   ERRDLM
 619   16404  5211          JMP     FULSYS  /NO ARGS - DO FOA ALL TASKS, NO STATE
 620   16405  4777          JMS I   (GETTSK /DELIMITER - GET TASK ID
 621   16406  3114          DCA     V
 622   16407  3115          DCA     P       /SET FOR ONE TASK, WITH STATE
 623   16410  5214          JMP     ONETSK
 624   16411  1376  FULSYS, TAD     (-NTASKS
 625   16412  3115          DCA     P       /-MAX. NO. ENTRIES
 626   16413  2114  UPCHCK, ISZ     V
 627   16414  1375  ONETSK, TAD     (TFTABL
 628   16415  1114          TAD     V
 629   16416  3334          DCA     ST2     /INDEX INTO FLAG TABLE
 630   16417  6201          CDF 0
 631   16420  1734          TAD I   ST2     /GET JFTABL WORD
 632   16421  6211          CDF CUR
 633   16422  3334          DCA     ST2
 634   16423  1334          TAD     ST2     /LO BIT=1 MEANS NOT ACTIVE
 635   16424  7110          RAR CLL
 636   16425  7630          SZL CLA
 637   16426  5321          JMP     NXTTSK  /MOVE ON TO NEXT TASK
 638   16427  1114          TAD     V       /PRINT TASK NO.
 639   16430  4774          JMS I   (PRNTNM
 640   16431  4326          JMS     SYSOUT
 641   16432  1114          TAD     V
 642   16433  7104          CLL RAL
 643   16434  1373          TAD     (NAMES  /INDEX INTO NAME TABLE
 644   16435  3333          DCA     ST1
 645   16436  1733          TAD I   ST1
 646   16437  4326          JMS     SYSOUT  /ADD NAME TO WRITE BUFFER
 647   16440  2333          ISZ     ST1
 648   16441  1733          TAD I   ST1
 649   16442  4326          JMS     SYSOUT

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 23

 650                /INSERT TASK WAIT CODES INTO LINE
 651   
 652   16443  1372          TAD     (FLGTBL-1
 653   16444  3333          DCA     ST1     /DECODE WAIT CODE
 654   16445  2333  FLGLP,  ISZ     ST1
 655   16446  1733          TAD I   ST1     /GET NEXT TABLE ENTRY
 656   16447  2333          ISZ     ST1
 657   16450  7450          SNA
 658   16451  5260          JMP     NOMOFG  /ZERO ENDS TABLE
 659   16452  0334          AND     ST2     /IF WE ARE WAITING ON THIS CODE,
 660   16453  7650          SNA CLA         /WE WILL PUT THE CORRESPONDING CODE LETTER OUT
 661   16454  5245          JMP     FLGLP
 662   16455  1733          TAD I   ST1
 663   16456  4516          PUTW
 664   16457  5245          JMP     FLGLP
 665   16460  1114  NOMOFG, TAD     V
 666   16461  7104          CLL RAL
 667   16462  1371          TAD     (MSGTBL
 668   16463  3113          DCA     Q
 669   16464  6201          CDF     0
 670   16465  1513          TAD I   Q
 671   16466  6211          CDF     CUR
 672   16467  7650          SNA CLA
 673   16470  5273          JMP     .+3
 674   16471  1370          TAD     (4052
 675   16472  4516          PUTW
 676   16473  1115          TAD     P
 677   16474  7640          SZA CLA
 678   16475  5320          JMP     NODTL
 679   16476  1367          TAD     (-4
 680   16477  3334          DCA     ST2
 681   16500  1114          TAD     V       /PRINT 4 WORDS FROM TASK STATE TABLE ENTRY
 682   16501  7106          CLL RTL         /FOR THIS TASK
 683   16502  1366          TAD     (TSTABL
 684   16503  3333          DCA     ST1
 685   16504  4326          JMS     SYSOUT
 686   16505  1333          TAD     ST1
 687   16506  4765          JMS I   (PR12BT /PRINT LOCATION OF JOB STATE TABLE ENTRY
 688   16507  1364          TAD     (7240   /FOLLOWED BY COLON, SPACE
 689   16510  4326  PRDTLP, JMS     SYSOUT
 690   16511  6201          CDF 0
 691   16512  1733          TAD I   ST1
 692   16513  6211          CDF CUR
 693   16514  4765          JMS I   (PR12BT
 694   16515  2333          ISZ     ST1
 695   16516  2334          ISZ     ST2
 696   16517  5310          JMP     PRDTLP

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 24

 697   16520  4763  NODTL,  JMS I   (TTOUT  /SEND MESSAGE TO TTY
 698   16521  2115  NXTTSK, ISZ     P       /END OF TABLE?
 699   16522  1115          TAD     P
 700   16523  7710          SPA CLA
 701   16524  5213          JMP     UPCHCK  /NO
 702   16525  5505          JMP I   ENDSTF  /YES - GO AWAY
 703   
 704   16526  0000  SYSOUT, 0
 705   16527  7450          SNA             /PRINT CONTENTS OF AC
 706   16530  1362          TAD     (4040   /OR BLANKS.
 707   16531  4516          PUTW
 708   16532  5726          JMP I   SYSOUT
 709   
 710   16533  0000  ST1,    0
 711   16534  0000  ST2,    0
 712   
 713   16535  0020  FLGTBL, MSGWT;  4015    /M
 714   16536  4015
 715   16537  2000          EFWT;   4005    /E
 716   16540  4005
 717   16541  1000          RUNWT;  4022    /R
 718   16542  4022
 719   16543  0400          SWPWT;  4023    /S
 720   16544  4023
 721   16545  0100          USERWT; 4025    /U
 722   16546  4025
 723   16547  0040          ENABWT; 4004    /D
 724   16550  4004
 725   16551  0200          EORMWT; 4017    /O
 726   16552  4017
 727   16553  4000          NONRWT; 4016    /N
 728   16554  4016
 729   16555  0000          0
 730   16562  4040
 731   16563  5473
 732   16564  7240
 733   16565  6267
 734   16566  1222
 735   16567  7774
 736   16570  4052
 737   16571  1176
 738   16572  6534
 739   16573  6176
 740   16574  6301
 741   16575  1301
 742   16576  7766
 743   16577  5603
 744          6600          PAGE
 745                        >

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 25

 746                /GET 2 OCTAL NUMBERS
 747   
 748   16600  0000  GET2OC, 0
 749   16601  4233          JMS     OCTNUM  /GO GET A NUMBER
 750   16602  5216          JMP     ISITDN  /LESS THAN 4 DIGITS
 751   16603  1104          TAD     NUMB    /5TH IS FIELD
 752   16604  7112          CLL RTR
 753   16605  7012          RTR
 754   16606  7012          RTR
 755   16607  0377          AND     (70
 756   16610  3267          DCA     G2A     /SAVE FIELD POINTER IN CASE 5TH DIGIT SHOWS
 757   16611  4247          JMS     D07     /TRY FOR 5 DIGITS
 758   16612  5216          JMP     ISITDN  /BE CONTENT WITH 4
 759   16613  4503          JMS I   GET
 760   16614  7200          CLA             /WASTE A CHAR - THE DELIM
 761   16615  1267          TAD     G2A     /USE THE FIELD WE SAVED
 762   16616  1376  ISITDN, TAD     (CDF 0  /AC MAY NOT BE 0 HERE!
 763   16617  3362          DCA     GFLD    /SAVE CDF TO FIELD
 764   16620  1104          TAD     NUMB
 765   16621  3267          DCA     G2A     /THIS IS 4 DIGIT NUMBER
 766   16622  4506          JMS I   BCKUP
 767   16623  4507          JMS I   LEGLIM
 768   16624  5500          JMP I   ERRDLM
 769   16625  5600          JMP I   GET2OC  /LEGAL EOL-ONLY 1 NUMBER
 770   16626  4233          JMS     OCTNUM  /TRY FOR A 2ND
 771   16627  4506          JMS I   BCKUP
 772   16630  1104          TAD     NUMB
 773   16631  2200          ISZ     GET2OC
 774   16632  5600          JMP I   GET2OC  /UPDATE RETURN + PASS 2ND NUMBER IN AC

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 26

 775   16633  0000  OCTNUM, 0
 776   16634  7346          AC7775
 777   16635  3114          DCA     V
 778   16636  3104          DCA     NUMB    /INITIALIZE NUMBER
 779   16637  4247          JMS     D07     /GET A DIGIT
 780   16640  5501          JMP I   ERRNUM
 781   16641  4247  TWOMOR, JMS     D07     /CAN HAVE UP TO 4 DIGITS
 782   16642  5633          JMP I   OCTNUM  /L.T. 4
 783   16643  2114          ISZ     V
 784   16644  5241          JMP     TWOMOR
 785   16645  2233          ISZ     OCTNUM  /4 DIGITS
 786   16646  5633          JMP I   OCTNUM
 787   
 788                /DIGIT MUST BE OCTAL-USE ONLY 3 BITS
 789   
 790   16647  0000  D07,    0
 791   16650  4503          JMS I   GET
 792   16651  1375          TAD     (-270
 793   16652  7100          CLL
 794   16653  1374          TAD     (10
 795   16654  3305          DCA     BUMP    /SAVE DIGIT VALUE
 796   16655  7420          SNL
 797   16656  5647          JMP I   D07     /NOT DIGIT AFTER ALL - NON-SKIP RETURN
 798   16657  1104          TAD     NUMB
 799   16660  7104          CLL RAL
 800   16661  7104          CLL RAL
 801   16662  7104          CLL RAL         /NUMB*8
 802   16663  1305          TAD     BUMP
 803   16664  3104          DCA     NUMB
 804   16665  2247          ISZ     D07     /TAKE SKIP RETURN
 805   16666  5647          JMP I   D07
 806   16667  0000  G2A,    0

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 27

 807                /DEPOSIT IN LOCATION SPECIFIED CONTENTS
 808   
 809   16670  4200  DEPSIT, JMS     GET2OC
 810   16671  5501          JMP I   ERRNUM  /MUST HAVE 2 NUMBERS
 811   16672  4361  DEPSLP, JMS     XFLD    /SET FIELD
 812   16673  3667          DCA I   G2A     /ADD IN NEW CONTENTS
 813   16674  6211          CDF     CUR
 814   16675  4507          JMS I   LEGLIM
 815   16676  5500          JMP I   ERRDLM
 816   16677  5505          JMP I   ENDSTF
 817   16700  4233          JMS     OCTNUM  /MAY BE MORE CONTENTS
 818   16701  4506          JMS I   BCKUP
 819   16702  4305          JMS     BUMP    /BUMP LOCATION POINTER
 820   16703  1104          TAD     NUMB
 821   16704  5272          JMP     DEPSLP
 822   
 823   16705  0000  BUMP,   0               /ROUTINE TO BUMP G2A
 824   16706  2267          ISZ     G2A
 825   16707  5705          JMP I   BUMP    /AH, NICE AND SIMPLE
 826   16710  1374          TAD     (10
 827   16711  1362          TAD     GFLD    /ACROSS FIELD BOUNDARY
 828   16712  3362          DCA     GFLD
 829   16713  5705          JMP I   BUMP
 830   
 831                /POST EVENT FLAG GIVEN ADDRESS
 832   
 833   16714  4200  POSTEF, JMS     GET2OC  /GET 5-DIGIT ADDRESS
 834   16715  7410          SKP             /SHOULD BE ONLY 1 NUMBER
 835   16716  5501          JMP I   ERRNUM  /MORE IS ERROR
 836   16717  1362          TAD     GFLD
 837   16720  3324          DCA     POSTDF
 838   16721  1267          TAD     G2A
 839   16722  4020          CAL
 840   16723  0005          POST            /PRAY WHAT WE ARE POSTING IS REALLY
 841   16724  7402  POSTDF, HLT             /AN EVENT FLAG
 842   16725  5505          JMP I   ENDSTF

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 28

 843                /EXAMINE LOCATION OR RANGE OF LOCATIONS
 844   
 845   16726  4200  EXAM,   JMS     GET2OC  /GET OCTAL VALUES
 846   16727  4506          JMS I   BCKUP   /NO SECOND NUMBER - EXAMINE ONLY 1 LOC
 847   16730  7450          SNA             /IF 2D NUM IS ZERO,
 848   16731  7001          IAC             /EXAMINE ONLY 1 LOC
 849   16732  7041          CIA
 850   16733  3360          DCA     LSTCNT  /- NO. OF LOCATIONS TO EXAM
 851   16734  4510          JMS I   EOL
 852   16735  1362  PRNCON, TAD     GFLD    /GFLD SET BY GET2OC
 853   16736  0377          AND     (70
 854   16737  7112          CLL RTR
 855   16740  7010          RAR
 856   16741  1373          TAD     (4060   /SPACE , NUMBER
 857   16742  4516          PUTW
 858   16743  1267          TAD     G2A
 859   16744  4772          JMS I   (PR12BT /PRINT THE LOCATION NEXT
 860   16745  1371          TAD     (5740   /PRINT A SLASH BEFORE CONTENTS
 861   16746  4516          PUTW
 862   16747  4361          JMS     XFLD    /SET FIELD
 863   16750  1667          TAD I   G2A     /GET CONTENTS
 864   16751  6211          CDF     CUR
 865   16752  4772          JMS I   (PR12BT /PRINT IT
 866   16753  4305          JMS     BUMP
 867   16754  4770          JMS I   (TTOUT  /OUTPUT A LINE
 868   16755  2360          ISZ     LSTCNT  /DONE?
 869   16756  5335          JMP     PRNCON  /NO - DO SOME MORE
 870   16757  5505          JMP I   ENDSTF
 871   16760  0000  LSTCNT, 0
 872   
 873   16761  0000  XFLD,   0
 874   16762  7402  GFLD,   HLT
 875   16763  5761          JMP I   XFLD
 876   16770  5473
 877   16771  5740
 878   16772  6267
 879   16773  4060
 880   16774  0010
 881   16775  7510
 882   16776  6201
 883   16777  0070
 884          7000          PAGE

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 29

 885                        IFDEF   CLOCK   <
 886   
 887   17000  1777  TIME,   TAD I   (CRALT  
 888   17001  7640          SZA     CLA
 889   17002  5216          JMP     PRNTM   /PRINT TIME
 890   17003  4776  DOTIME, JMS I   (HRMIN  /DECODE HOURS + MINS
 891   17004  1777          TAD I   (CRALT
 892   17005  7650          SNA CLA
 893   17006  4510          JMS I   EOL
 894   17007  1111          TAD     ACL
 895   17010  6203          CDF CIF 0       /INHIBIT INTERRUPTS BETWEEN HALVES
 896   17011  3775          DCA I   (TODL
 897   17012  1112          TAD     ACH
 898   17013  3774          DCA I   (TODH
 899   17014  6213          CDF CIF CUR
 900   17015  5505          JMP I   ENDSTF
 901   17016  3773  PRNTM,  DCA I   (P1
 902   17017  3261          DCA     HRS
 903   17020  3262          DCA     MINS    /CONVERT TOD TO HOURS:MINUTES
 904   17021  6002          IOF             /INHIBIT INTERRUPTS BETWEEN HALVES
 905   17022  6201          CDF 0
 906   17023  1775          TAD I   (TODL
 907   17024  3111          DCA     ACL
 908   17025  1774          TAD I   (TODH   /GET TIME OF DAY FROM PAGE 0 OF FIELD 0
 909   17026  3112          DCA     ACH
 910   17027  6001          ION             /RE-ENABLE INTERRUPTS
 911   17030  6211          CDF CUR
 912   17031  1372          TAD     (FUDGEL
 913   17032  4277          JMS     DBLSUB  /TAKE OFF THE MIDNIGHT FUDGE
 914   17033  1371  HRLOP,  TAD     (HRCON  /SUBTRACT HRS TIL OVERFLO
 915   17034  4277          JMS     DBLSUB
 916   17035  2261          ISZ     HRS
 917   17036  1112          TAD     ACH
 918   17037  7700          SMA CLA         /AC GOES NEGATIVE ON OVERFLOW
 919   17040  5233          JMP     HRLOP
 920   17041  1370  MINLOP, TAD     (MINCON
 921   17042  4263          JMS     DBLADD
 922   17043  2262          ISZ     MINS
 923   17044  1112          TAD     ACH
 924   17045  7710          SPA CLA         /THIS TIME AC GOES POSITIVE ON OVERFLOW
 925   17046  5241          JMP     MINLOP
 926   17047  7240          STA
 927   17050  1261          TAD     HRS
 928   17051  4767          JMS I   (PR4BIT
 929   17052  2773          ISZ I   (P1     /MINS SPLIT BET WORDS
 930   17053  1262          TAD     MINS
 931   17054  7041          CIA
 932   17055  1366          TAD     (74
 933   17056  4767          JMS I   (PR4BIT
 934   17057  4765          JMS I   (TTOUT
 935   17060  5505          JMP I   ENDSTF
 936   17061  0000  HRS,    0
 937   17062  0000  MINS,   0

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 30

 938   17063  0000  DBLADD, 0               /DOUBLE PRECISION ADD ROUTINE
 939   17064  3113          DCA     Q
 940   17065  7100          CLL
 941   17066  1513          TAD I   Q
 942   17067  1111          TAD     ACL
 943   17070  3111          DCA     ACL
 944   17071  2113          ISZ     Q       /PREPARE FOR HI WORD
 945   17072  7004          RAL             /UPDATE HI WORD
 946   17073  1112          TAD     ACH
 947   17074  1513          TAD I   Q
 948   17075  3112          DCA     ACH
 949   17076  5663          JMP I   DBLADD
 950   
 951   17077  0000  DBLSUB, 0               /** CAN BE CALLED WITH DF=CUR OR DF=0 **
 952   17100  3113          DCA     Q
 953   17101  6212          CIF CUR         /INHIBIT INTERRUPTS BETWEEN HALVES
 954   17102  1513          TAD I   Q       /GET LO VALUE
 955   17103  7141          CIA CLL
 956   17104  1111          TAD     ACL
 957   17105  3111          DCA     ACL
 958   17106  2113          ISZ     Q       /UPDATE FOR HI VALUE
 959   17107  7024          CML RAL
 960   17110  1513          TAD I   Q
 961   17111  7041          CIA
 962   17112  1112          TAD     ACH
 963   17113  3112          DCA     ACH
 964   17114  5677          JMP I   DBLSUB
 965   
 966   17115  0000  GETN,   0               /GET A NUMBER ROUTINE
 967   17116  3104          DCA     NUMB    /INITIALIZE NUMBER TO 0
 968   17117  4503  PSTSPC, JMS I   GET
 969   17120  4764          JMS I   (ISITNM /DIGIT?
 970   17121  5332          JMP     YSITIS  /YES - GO BUILD NUMBER
 971   17122  1363          TAD     (-240
 972   17123  7650          SNA CLA
 973   17124  5317          JMP     PSTSPC  /PERMIT LEADING SPACES
 974   17125  5501          JMP I   ERRNUM
 975   17126  4503  GETNXL, JMS I   GET
 976   17127  4764          JMS I   (ISITNM
 977   17130  7410          SKP
 978   17131  5715          JMP I   GETN    /RETURN WITH DELIMITER IN AC
 979   17132  1362  YSITIS, TAD     (-260
 980   17133  3343          DCA     DIG
 981   17134  1104          TAD     NUMB
 982   17135  7106          CLL RTL
 983   17136  1104          TAD     NUMB
 984   17137  7004          RAL             /NUMBER SO FAR *10
 985   17140  1343          TAD     DIG     /+ NEW NUMBER
 986   17141  3104          DCA     NUMB
 987   17142  5326          JMP     GETNXL
 988   17143  0000  DIG,    0

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 31

 989                /THIS TABLE CONTAINS THE CONVERSION FACTORS FOR HOURS,
 990                /MINUTES & SECONDS TO TICKS. EACH IS A 2 WORD VALUE
 991                /BECAUSE ALL THIS IS DONE BY DOUBLE WORD ARITHMETIC.
 992                /THE HOUR TO TICKS VALUE = 60*60*SHERTZ = 7020(OCT)*SHERTZ
 993                /THE LOW WORD VALUE IS DETERMINED FOR THIS MULTIPLICATION
 994                /BY THE ASSEMBLER.
 995                /THE HIGH WORD IS (7020*SHERTZ)/10000.
 996                /THIS MUST BE REDUCED FOR THE ASSEMBLER
 997                /IT IS = 341*SHERTZ/400 = 340*SHERTZ/400+SHERTZ/400 =
 998                / 7*SHERTZ/10+SHERTZ/400 = (7*SHERTZ+SHERTZ/40)/10
 999   
1000   17144  0310  INTTBL, "H
1001   17145  6240  HRCON,  7020^SHERTZ
1002          0000  HRCTEM= SHERTZ%40
1003   17146  0010  HRCON1, 7^SHERTZ+HRCTEM%10
1004   
1005   17147  0315          "M
1006   17150  1130  MINCON, 74^SHERTZ
1007   17151  0000  MINCN1, 17^SHERTZ%2000
1008   
1009   17152  0323          "S
1010   17153  0012  SECCON, SHERTZ
1011   17154  0000          0
1012   
1013   17155  0324          "T
1014   17156  0001  TICCON, 1
1015   17157  0000          0
1016   
1017   17160  0000          0       /EOT
1018   17162  7520
1019   17163  7540
1020   17164  5422
1021   17165  5473
1022   17166  0074
1023   17167  7302
1024   17170  7150
1025   17171  7145
1026   17172  7525
1027   17173  7275
1028   17174  0037
1029   17175  0036
1030   17176  7527
1031   17177  5472
1032          7200          PAGE

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 32

1033   17200  1777  DATEX,  TAD I   (CRALT  
1034   17201  7640          SZA CLA         /PRINT OR GET?
1035   17202  5244          JMP     PRNTDT  /PRINT DATE
1036   17203  3243          DCA     DATEWD  /WHERE WILL THIS BE??
1037   17204  4234          JMS     GETNXT  /GET MONTH
1038   17205  0376          AND     (17
1039   17206  7112          CLL RTR
1040   17207  7012          RTR
1041   17210  7010          RAR
1042   17211  3243          DCA     DATEWD  /IN STANDARD OS/8 FORMAT
1043   17212  4234          JMS     GETNXT  /HERE COMES DAY
1044   17213  0375          AND     (37
1045   17214  7106          CLL RTL
1046   17215  7004          RAL
1047   17216  1243          TAD     DATEWD
1048   17217  3243          DCA     DATEWD
1049   17220  4774          JMS I   (GETN   /FOLLOWED BY YEAR
1050   17221  7200          CLA
1051   17222  1773          TAD I   (DIG    /OF WHICH WE TAKE ONLY LAST DIGIT
1052   17223  1243          TAD     DATEWD
1053   17224  6201          CDF     0
1054   17225  3772          DCA I   (DATE
1055   17226  6211          CDF     CUR
1056   17227  4506          JMS I   BCKUP
1057   17230  4507          JMS I   LEGLIM
1058   17231  5500          JMP I   ERRDLM
1059   17232  5505          JMP I   ENDSTF
1060   17233  5771          JMP I   (DOTIME /MAY BE FOLLOWED BY TIME

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 33

1061   17234  0000  GETNXT, 0
1062   17235  4774          JMS I   (GETN
1063   17236  1370          TAD     (-257
1064   17237  7640          SZA     CLA     /USE / AS DELIM FOR DATE
1065   17240  5500          JMP I   ERRDLM
1066   17241  1104          TAD     NUMB
1067   17242  5634          JMP I   GETNXT
1068   17243  0000  DATEWD, 0
1069   
1070   17244  3275  PRNTDT, DCA     P1
1071   17245  6201          CDF     0
1072   17246  1772          TAD I   (DATE   
1073   17247  6211          CDF     CUR
1074   17250  3243          DCA     DATEWD  /SAVE CURRENT DATE
1075   17251  1243          TAD     DATEWD
1076   17252  0367          AND     (7400   /GET MONTH
1077   17253  7106          CLL RTL
1078   17254  7006          RTL
1079   17255  7004          RAL
1080   17256  4302          JMS     PR4BIT
1081   17257  7240          CLA CMA
1082   17260  3275          DCA     P1      /DAY WILL BE SPLIT BET 2 BUFFER WORDS
1083   17261  1243          TAD     DATEWD
1084   17262  0366          AND     (370    /GET MONTH
1085   17263  7112          CLL RTR
1086   17264  7010          RAR
1087   17265  4302          JMS     PR4BIT
1088   17266  1243          TAD     DATEWD  /AND YEAR
1089   17267  0365          AND     (7
1090   17270  1364          TAD     (70     /GOOD TIL 77
1091   17271  4763          JMS I   (PRNTNM
1092   17272  4762          JMS I   (TTOUT  /PUT OUT LINE
1093   17273  5505          JMP I   ENDSTF
1094   
1095   17274  0000  TENCNT, 0
1096   17275  0000  P1,     0
1097   17276  5700  SPEC,   5700    /SLASH FOR DATE
1098   17277  0057          57
1099   17300  7200          7200    /: FOR TIME
1100   17301  0040          40

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 34

1101                /PRINT ROUTINE FOR 4 BIT NUMBERS
1102   
1103   17302  0000  PR4BIT, 0       
1104   17303  3113          DCA     Q
1105   17304  1361          TAD     (57
1106   17305  3274          DCA     TENCNT  /TENS INITAILLY=0
1107   17306  1113          TAD     Q       /GET THE DIGITS
1108   17307  2274  DECMOR, ISZ     TENCNT
1109   17310  1360          TAD     (-12
1110   17311  7500          SMA
1111   17312  5307          JMP     DECMOR  /COUNT TENS
1112   17313  1357          TAD     (72     /60+12
1113   17314  3113          DCA     Q
1114   17315  1275          TAD     P1      /SPLIT ACROSS WORDS?
1115   17316  7450          SNA
1116   17317  5335          JMP     REG     /NO
1117   17320  1356          TAD     (SPEC+1 /P1 IS +1 OR -1
1118   17321  3275          DCA     P1      /POINT TO CORRECT FILLERS
1119   17322  1675          TAD I   P1      /YES-GET LEADING CHAR
1120   17323  1274          TAD     TENCNT
1121   17324  4516          PUTW            /1ST DIGIT TO RIGHT
1122   17325  2275          ISZ     P1
1123   17326  1113          TAD     Q       /2ND DIGIT TO LEFT
1124   17327  7106          CLL RTL
1125   17330  7006          RTL
1126   17331  7006          RTL
1127   17332  1675          TAD I   P1      /AND 2ND DELIM
1128   17333  4516  SAVIT,  PUTW
1129   17334  5702          JMP I   PR4BIT
1130   17335  1274  REG,    TAD     TENCNT
1131   17336  7106          CLL RTL
1132   17337  7006          RTL
1133   17340  7006          RTL
1134   17341  1113          TAD     Q
1135   17342  5333          JMP     SAVIT
1136   17356  7277
1137   17357  0072
1138   17360  7766
1139   17361  0057
1140   17362  5473
1141   17363  6301
1142   17364  0070
1143   17365  0007
1144   17366  0370
1145   17367  7400
1146   17370  7521
1147   17371  7003
1148   17372  0040
1149   17373  7143
1150   17374  7115
1151   17375  0037
1152   17376  0017
1153   17377  5472
1154          7400          PAGE

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 35

1155                /REQUEST A TASK:
1156   
1157                /A)     IMMEDIATELY
1158                /B)     AFTER AN INTERVAL
1159                /C)     AT A TIME OF DAY
1160                /D)     AFTER AN INTERVAL AND PERIODICALLY
1161                /E)     AT A TIME OF DAY AND PERIODICALLY
1162   
1163   17400  4777  SCHED,  JMS I   (GETTSK /GET TASK
1164   17401  4506          JMS I   BCKUP
1165   17402  4507          JMS I   LEGLIM
1166   17403  5500          JMP I   ERRDLM  /MUST BE DELIM
1167   17404  5776          JMP I   (REQUST /JUST A REQUEST
1168   17405  3112          DCA     ACH
1169   17406  3111          DCA     ACL     /INITIALIZE INTERVAL
1170   17407  4503          JMS I   GET
1171   17410  1375          TAD     (-",    /CHECK FOR NULL INTERVAL
1172   17411  7450          SNA
1173   17412  5223          JMP     SAVTIM  /YES - GET PERIOD
1174   17413  1374          TAD     (",-"@  /CHECK FOR @ TIME-OD-DAY
1175   17414  7640          SZA CLA
1176   17415  5310          JMP     INTSCH
1177   17416  4773          JMS I   (HRMIN  /DECODE TIME SPECIFICATION
1178   17417  1372          TAD     (TODL
1179   17420  6201          CDF 0
1180   17421  4771          JMS I   (DBLSUB /SUBTRACT CURRENT T.O.D. TO GET INTERVAL
1181   17422  6211          CDF CUR
1182   17423  1112  SAVTIM, TAD     ACH
1183   17424  3321          DCA     SCHDHI
1184   17425  1111          TAD     ACL
1185   17426  3322          DCA     SCHDLO
1186   17427  1770          TAD I   (CRALT
1187   17430  7640          SZA CLA         /END OF LINE SEEN?
1188   17431  5240          JMP     ZROINT  /YES - NO INTERVAL
1189   17432  4253          JMS     GETINT
1190   17433  1112          TAD     ACH
1191   17434  3323          DCA     RSCHHI  /SAVE RESCHEDULE UNITS IN CLOCK MESSAGE
1192   17435  1111          TAD     ACL
1193   17436  3324          DCA     RSCHLO
1194   17437  7332          AC2000
1195   17440  1367  ZROINT, TAD     (1000
1196   17441  1766  SNDCLK, TAD I   (TSKWD
1197   17442  3320          DCA     SCHDWD
1198   17443  4020          CAL
1199   17444  0000          SEND
1200   17445  0001          CLOCK
1201   17446  7515          SCHMES
1202   17447  5765          JMP I   (BKELEN
1203   
1204                /CANCEL ALL CLOCK QUEUE ENTRIES FOR A TASK
1205   
1206   17450  4777  CANCEL, JMS I   (GETTSK /GET TASK - RETURNS NUMBER IN AC AND "TSKWD"
1207   17451  7330          AC4000          /"CANCEL" OPCODE FOR CLOCK HANDLER IS 4000
1208   17452  5240          JMP     ZROINT  /SEND THE CLOCK THE CANCEL MESSAGE

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 36

1209                /ROUTINE TO GET AN INTERVAL -
1210                /INTERVALS ARE A NUMBER FOLLOWED BY H,M,S OR T
1211                /THIS ROUTINE IS JUMPED INTO BY "HRMIN"
1212   
1213   17453  0000  GETINT, 0
1214   17454  4764          JMS I   (GETN
1215   17455  3313          DCA     S2      /THIS IS THE ALPHA FOR UNIT
1216   17456  1363          TAD     (INTTBL
1217   17457  3314          DCA     S1
1218   17460  3112          DCA     ACH
1219   17461  3111          DCA     ACL     /CLEAR AC PRIOR TO ADDS
1220   17462  1714  NXTINT, TAD I   S1      /NOW CHECK FOR MATCHING UNITS
1221   17463  2314          ISZ     S1
1222   17464  7450          SNA
1223   17465  5762          JMP I   (CHRER  
1224   17466  7041          CIA
1225   17467  1313          TAD     S2
1226   17470  7650          SNA CLA
1227   17471  5275          JMP     FNDINT  /FOUND THEM
1228   17472  2314          ISZ     S1
1229   17473  2314          ISZ     S1
1230   17474  5262          JMP     NXTINT  /TRY AGAIN
1231   17475  1104  FNDINT, TAD     NUMB    /PREPARE COUNT ** HRMIN ENTERS HERE **
1232   17476  7041          CIA
1233   17477  3313          DCA     S2
1234   17500  1314  MORUNT, TAD     S1      /PASS UNITS FOR ADD
1235   17501  4761          JMS I   (DBLADD
1236   17502  2313          ISZ     S2
1237   17503  5300          JMP     MORUNT
1238   17504  4507          JMS I   LEGLIM
1239   17505  5500          JMP I   ERRDLM  /ILLEGAL TERMINATING DELIMITER
1240   17506  7000  SC7000, 7000            /EITHER SPACE, COMMA, OR EOL IS OK
1241   17507  5653          JMP I   GETINT
1242   
1243   17510  4506  INTSCH, JMS I   BCKUP
1244   17511  4253          JMS     GETINT  /GET INTERVAL
1245   17512  5223          JMP     SAVTIM
1246   17513  0000  S2,     0
1247   17514  0000  S1,     0
1248   17515  0000  SCHMES, ZBLOCK 3
1249   17520  0000  SCHDWD, 0               /2000+TASK NUM
1250   17521  0000  SCHDHI, 0
1251   17522  0000  SCHDLO, 0
1252   17523  0000  RSCHHI, 0
1253   17524  0000  RSCHLO, 0       /RESCHEDULE INTERVAL (IF APPLICABLE)

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 37

1254                /COMPUTE THE NUMBER OF TICKS IN A DAY FOR THE TIME-OF-DAY FUDGE
1255   
1256          0000          TEMPH=3^SHERTZ%40
1257   17525  0400  FUDGEL, -600^SHERTZ
1258   17526  7455  FUDGEH, -25^SHERTZ-TEMPH-1
1259   
1260   17527  0000  HRMIN,  0               /IF SPEC HRS,MUST HAVE MINS
1261   17530  4764          JMS I   (GETN
1262   17531  1360          TAD     (-":    /ONLY : BET HRS + MINS
1263   17532  7640          SZA CLA
1264   17533  5501          JMP I   ERRNUM  /NO : - ERROR
1265   17534  1327          TAD     HRMIN
1266   17535  3253          DCA     GETINT  /FAKE OUT "GETINT" TO DO SOME WORK FOR US LATER
1267   17536  1104          TAD     NUMB    /MULTIPLY HRS BY 60 TO GET MINS
1268   17537  7166          STL CMA RTL
1269   17540  7006          RTL
1270   17541  1104          TAD     NUMB
1271   17542  7146          CLL CMA RTL
1272   17543  3327          DCA     HRMIN
1273   17544  4764          JMS I   (GETN   /GET MINS
1274   17545  4506          JMS I   BCKUP
1275   17546  1357          TAD     (MINCON
1276   17547  3314          DCA     S1      /SET UNITS TO MINUTES
1277   17550  1326          TAD     FUDGEH
1278   17551  3112          DCA     ACH     /INITIALIZE AC TO MIDNIGHT FUDGE
1279   17552  1325          TAD     FUDGEL  /BEFORE WE ADD IN TICKS
1280   17553  3111          DCA     ACL
1281   17554  1327          TAD     HRMIN
1282   17555  5275          JMP     FNDINT  /CONVERT MINUTES TO TICKS AND RETURN
1283   17557  7150
1284   17560  7506
1285   17561  7063
1286   17562  6076
1287   17563  7144
1288   17564  7115
1289   17565  5735
1290   17566  5677
1291   17567  1000
1292   17570  5472
1293   17571  7077
1294   17572  0036
1295   17573  7527
1296   17574  7754
1297   17575  7524
1298   17576  5726
1299   17577  5603
1300          7600          PAGE
1301                        >
1302                        $$$

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 38

ACH    0112      ERMSG  6063      MCREF  0041      PR4BIT 7302
ACL    0111      ERRA   6070      MCRMES 6043      PSTSPC 7117
AC0002 7326      ERRDLM 0100      MCRSYS 0001      PUTW   4516
AC2000 7332      ERRNAM 0102      MINCN1 7151      PUTWX  5432
AC3777 7350      ERRNUM 0101      MINCON 7150      PWRFAL 0000
AC4000 7330      EXAM   6726      MINLOP 7041      P1     7275
AC7775 7346      EXDLAY 6266      MINS   7062      Q      0113
AC7776 7344      EXIT   6251      MORUNT 7500      QDEV2  0024
ALPNUM 5405      EXMSG  5505      MSGTBL 1176      QTASK  0011
BACKUP 5460      E1MSG  5512      MSGWT  0020      QUNIT2 0004
BCKUP  0106      FLGLP  6445      NAMCOM 5700      RECEIV 0001
BKELEN 5735      FLGTBL 6535      NAME   6224      REG    7335
BKGCT  6062      FNDINT 7475      NAMEA  5600      REQUST 5726
BKGLP  6052      FREE   4000      NAMER  6104      RK8    0002
BLKARG 0010      FUDGEH 7526      NAMES  6176      RSCHHI 7523
BUMP   6705      FUDGEL 7525      NAMGET 5632      RSCHLO 7524
CAL    4020      FULSYS 6411      NETWT  0010      RUN    0003
CANCEL 7450      GET    0103      NMFIT  0034      RUNWT  1000
CHECKP 0000      GETA   5400      NMTBL  6200      SAVIT  7333
CHKMOR 5705      GETINT 7453      NOCRAL 5450      SAVTIM 7423
CHRER  6076      GETN   7115      NODTL  6520      SCHDHI 7521
CLKQLN 0022      GETNXL 7126      NOGOOD 5457      SCHDLO 7522
CLKTYP 0001      GETNXT 7234      NOMOFG 6460      SCHDWD 7520
CLOCK  0001      GETTSK 5603      NONRWT 4000      SCHED  7400
CMDLP  6031      GET2OC 6600      NTASKS 0012      SCHMES 7515
CMDLST 6127      GFLD   6762      NUMB   0104      SC7000 7506
CRALT  5472      GOTASK 5612      NUMER  6120      SECCON 7153
CUR    0010      G2A    6667      NUMTSK 5623      SEND   0000
CUR2   0010      G3     5675      NXT    5650      SENDW  0011
DATE   0040      G7     5676      NXTINT 7462      SHERTZ 0012
DATEWD 7243      HERTZ  0012      NXTTSK 6521      SKPINS 0006
DATEX  7200      HGHFLD 0070      OCTNUM 6633      SNDCLK 7441
DBLADD 7063      HRCON  7145      ONETSK 6414      SPEC   7276
DBLSUB 7077      HRCON1 7146      OSFILL 0000      START  6011
DECMOR 7307      HRCTEM 0000      OSFLDS 0003      START2 6051
DEPSIT 6670      HRLOP  7033      OSKBDV 0003      STOP   5732
DEPSLP 6672      HRMIN  7527      OSSYSD 0002      ST1    6533
DERAIL 0007      HRS    7061      OSTTDV 0004      ST2    6534
DIG    7143      INBUF  5512      OS8    0012      SUSPND 0004
DISABL 5745      INIWT  0000      OS8F   0006      SWPWT  0400
DLMER  6112      INIWT2 0000      P      0115      SYSOUT 6526
DNEWT  0001      INLENG 0052      PARTNS 0000      SYSTAT 6400
DOTIME 7003      INTSCH 7510      PDP12  0001      S1     7514
D07    6647      INTTBL 7144      PDP8E  0000      S2     7513
EAE    0000      IP     5404      PINBUF 6047      TASK   0004
EFWT   2000      ISITDN 6616      POST   0005      TASK2  0013
ENABLE 5740      ISITNM 5422      POSTDF 6724      TEMPH  0000
ENABWT 0040      ITSEOL 5456      POSTDS 5424      TENCNT 7274
END    5671      KBDEV  0040      POSTEF 6714      TFTABL 1301
ENDS   6000      LEGAL  5436      PRDTLP 6510      TICCON 7156
ENDSTF 0105      LEGLIM 0107      PRNCON 6735      TIME   7000
ENDX   5670      LSTCNT 6760      PRNTDT 7244      TODH   0037
EOL    0110      LTA    0003      PRNTM  7016      TODL   0036
EOLA   5465      L7600  6050      PRNTNM 6301      TSKWD  5677
EORMWT 0200      MCR    0004      PR12BT 6267      TSTABL 1222

/MCR FOR RTS8 V2                          PAL8-V9H  04/29/77  PAGE 38-1

TSWFLG 0035
TTDEV  0041
TTOUT  5473
TTY    0005
TWOMOR 6641
UNBARG 0012
UPCHCK 6413
USERWT 0100
USER1  0007
USER2  0010
V      0114
W      5504
WAITE  0002
WAITM  4425
XFLD   6761
XNAME  5601
XNAME1 5602
YSITIS 7132
ZROINT 7440



ERRORS DETECTED: 0
LINKS GENERATED: 0




ACH         98#  534   547   548   550   897   909   917   923   946  
           948   962   963  1168  1182  1190  1218  1278  
ACL         97#  894   907   942   943   956   957  1169  1184  1192  
          1219  1280  
AC2000    1194  
AC4000    1207  
AC7775     776  
AC7776     245  
ALPNUM     119#  127   130   131   249   261   269  
BACKUP      94   173#  177  
BCKUP       94#  235   237   272   317   370   535   544   616   766  
           771   818   846  1056  1164  1243  1274  
BKELEN     310   317#  327   335  1202  
BKGCT      392   393   394   395   396   400# 
BKGLP      392#  397   399  
BLKARG     333  
BUMP       795   802   819   823#  825   829   866  
CAL        188   308   315   324   332   359   405   839  1198  
CANCEL     455  1206# 
CHKMOR     288#  297   302  
CHRER      250   411# 1223  
CLCK       498  
CLOCK      307   449   496   497   885  1200  
CMDLP      375#  381  
CMDLST     373   441# 
CRALT      162   185#  350   365   887   891  1033  1186  
CUR          8     8    72#   79    85   356   632   671   692   813  
           864   899   911   953  1055  1073  1181  
CUR2        16    16    79# 
DATE      1054  1072  
DATEWD    1036  1042  1047  1048  1052  1068# 1074  1075  1083  1088  
DATEX      451  1033# 
DBLADD     921   938#  949  1235  
DBLSUB     913   915   951#  964  1180  
DECMOR    1108# 1111  
DEPSIT     462   809# 
DEPSLP     811#  821  
DIG        980   985   988# 1051  
DISABL     331#  446  
DLMER       88   423# 
DOTIME     890# 1060  
D07        757   779   781   790#  797   804   805  
EFWT       358   715  
ENABLE     323#  444  
ENABWT     326   334   723  
END        273#  274  
ENDS        93   350# 
ENDSTF      93#  319   368   551   702   816   842   870   900   935  
          1059  1093  
ENDX       262   270   272# 
EOL         96#  318   545   851   893  
EOLA        96   179#  182   183  
EORMWT     725  
ERMSG      401#  408  
ERRA       404#  411   417   423   429  
ERRDLM      88#  181   537   538   618   768   815  1058  1065  1166  
          1239  
ERRNAM      90#  223   372   540   543  
ERRNUM      89#  232   780   810   835   974  1264  

EXAM       460   556   845# 
EXDLAY     561   567# 
EXIT       470   553# 
EXMSG      191   198# 
E1MSG      192   196   201# 
FLGLP      654#  661   664  
FLGTBL     652   713# 
FNDINT    1227  1231# 1282  
FUDGEH    1258# 1277  
FUDGEL     912  1257# 1279  
FULSYS     619   624# 
GET         91#  120   155   238   759   791   968   975  1170  
GETA        91   110#  113  
GETINT    1189  1213# 1241  1244  1266  
GETN       966#  978  1049  1062  1214  1261  1273  
GETNXL     975#  987  
GETNXT    1037  1043  1061# 1067  
GETTSK     218#  234   314   323   331   531   620  1163  1206  
GET2OC     748#  769   773   774   809   833   845  
GFLD       763   827   828   836   852   874# 
GOTASK     226#  241  
G2A        756   761   765   806#  812   824   838   858   863  
G3         246   268   278# 
G7         244   260   265   266   267   279# 
HRCON      914  1001# 
HRCON1    1003# 
HRCTEM    1002# 1003  
HRLOP      914#  919  
HRMIN      890  1177  1260# 1265  1272  1281  
HRS        902   916   927   936# 
INBUF      202#  388  
INIWT       12    73# 
INIWT2      20    80# 
INLENG      82#  202   387  
INTSCH    1176  1243# 
INTTBL    1000# 1216  
IP         111   112   114#  175   176   364  
ISITDN     750   758   762# 
ISITNM     129   136#  141   143   969   976  
ITSEOL     163   170# 
LEGAL       95   154#  169   170   171  
LEGLIM      95#  180   273   366   536   617   767   814  1057  1165  
          1238  
LSTCNT     850   868   871# 
LTA        518   519  
L7600      389#  391  
MCR         71   488  
MCREF      355  
MCRMES     362   386# 
MCRSYS     104   465   605  
MINCN1    1007# 
MINCON     920  1006# 1275  
MINLOP     920#  925  
MINS       903   922   930   937# 
MORUNT    1234# 1237  
MSGTBL       5    13   667  
MSGWT      713  
NAMCOM     221   283#  291   303   304   541  
NAME       448   531# 
NAMEA      214#  243  

NAMER       90   417#  472  
NAMES      486#  488   492   497   502   509   514   519   533   643  
NAMGET     219   242#  253   254   276   371   539  
NMFIT       83#  105  
NMTBL      284   485#  486   528  
NOCRAL     160   164# 
NODTL      678   697# 
NOGOOD     168   171# 
NOMOFG     658   665# 
NONRWT     727  
NTASKS      78   105   225   230   286   485   528   624  
NUMB        92#  240   751   764   772   778   798   803   820   967  
           981   983   986  1066  1231  1267  1270  
NUMER       89   429# 
NUMTSK     220   235# 
NXT        256#  271  
NXTINT    1220# 1230  
NXTTSK     637   698# 
OCTNUM     236   749   770   775#  782   785   786   817  
ONETSK     623   627# 
OS8        513   514  
OS8F       508   509   510  
P          101#  285   288   292   293   300   374   375   376   377  
           382   383   384   622   625   676   698   699  
PINBUF     363   388# 
POST       840  
POSTDF     837   841# 
POSTEF     464   833# 
PRDTLP     689#  696  
PRNCON     852#  869  
PRNTDT    1035  1070# 
PRNTM      889   901# 
PRNTNM     574   576   579#  590   639  1091  
PR12BT     568#  577   687   693   859   865  
PR4BIT     928   933  1080  1087  1103# 1129  
PSTSPC     968#  973  
PUTW       102#  187   589   663   675   707   857   861  1121  1128  
PUTWX      103   145#  148  
P1         901   929  1070  1082  1096# 1114  1118  1119  1122  1127  
Q           99#  121   122   128   156   157   255   569   570   575  
           668   670   939   941   944   947   952   954   958   960  
          1104  1107  1113  1123  1134  
REG       1116  1130# 
REQUST     307# 1167  
RK8        501   502  
RSCHHI    1191  1252# 
RSCHLO    1193  1253# 
RUN        309  
RUNWT      717  
SAVIT     1128# 1135  
SAVTIM    1173  1182# 1245  
SCHDHI    1183  1250# 
SCHDLO    1185  1251# 
SCHDWD    1197  1249# 
SCHED      458  1163# 
SCHMES    1201  1248# 
SC7000    1240# 
SECCON    1010# 
SEND      1199  
SENDW      189   360   406  

SHERTZ    1001  1002  1003  1006  1007  1010  1256  1257  1258  
SNDCLK    1196# 
SPEC      1097# 1117  
START        9   351   359#  409  
START2      17   391# 
STOP       314#  442  
ST1        644   645   647   648   653   654   655   656   662   684  
           686   691   694   710# 
ST2        629   631   633   634   659   680   695   711# 
SUSPND     316  
SWPWT      719  
SYSOUT     640   646   649   685   689   704#  708  
SYSTAT     467   615# 
S1        1217  1220  1221  1228  1229  1234  1247# 1276  
S2        1215  1225  1233  1236  1246# 
TASK         5     7    11    71#  354  
TASK2       13    15    19    78# 
TEMPH     1256# 1258  
TENCNT    1095# 1106  1108  1120  1130  
TFTABL      11    19   627  
TICCON    1014# 
TIME       453   887# 
TODH       898   908  
TODL       896   906  1178  
TSKWD      226   227   233   280#  307  1196  
TSTABL       7    15   683  
TSWFLG     558  
TTOUT      186#  194   697   867   934  1092  
TTY        190   361   407   491   492  
TWOMOR     781#  784  
UNBARG     325  
UPCHCK     626#  701  
USERWT     721  
V          100#  224   287   289   559   581   582   586   615   621  
           626   628   638   641   665   681   777   783  
W          146   147   193   196# 
WAITM      357  
XFLD       811   862   873#  875  
XNAME      214   215#  295   379   546  
XNAME1     216#  248   298   549   553  
YSITIS     970   979# 
ZROINT    1188  1195# 1208  
_15570     192  
_15571     166  
_15572     164  
_15573     142  
_15574     139  
_15575     137  
_15576     125  
_15577     123  
_15765     286  
_15766     284  
_15767     264  
_15770     256   263  
_15771     251  
_15772     250  
_15773     249   261   269  
_15774     247  
_15775     236  
_15776     230  

_15777     225  
_16171     379  
_16172     373  
_16173     371  
_16174     364  
_16175     355  
_16176     354  
_16177     350   365  
_16363     588  
_16364     585   587  
_16365     580  
_16366     565  
_16367     558  
_16370     556  
_16371     554  
_16372     549   553  
_16373     546  
_16374     541  
_16375     539  
_16376     533  
_16377     531  
_16562     706  
_16563     697  
_16564     688  
_16565     687   693  
_16566     683  
_16567     679  
_16570     674  
_16571     667  
_16572     652  
_16573     643  
_16574     639  
_16575     627  
_16576     624  
_16577     620  
_16770     867  
_16771     860  
_16772     859   865  
_16773     856  
_16774     794   826  
_16775     792  
_16776     762  
_16777     755   853  
_17162     979  
_17163     971  
_17164     969   976  
_17165     934  
_17166     932  
_17167     928   933  
_17170     920  
_17171     914  
_17172     912  
_17173     901   929  
_17174     898   908  
_17175     896   906  
_17176     890  
_17177     887   891  
_17356    1117  
_17357    1112  
_17360    1109  

_17361    1105  
_17362    1092  
_17363    1091  
_17364    1090  
_17365    1089  
_17366    1084  
_17367    1076  
_17370    1063  
_17371    1060  
_17372    1054  1072  
_17373    1051  
_17374    1049  1062  
_17375    1044  
_17376    1038  
_17377    1033  
_17557    1275  
_17560    1262  
_17561    1235  
_17562    1223  
_17563    1216  
_17564    1214  1261  1273  
_17565    1202  
_17566    1196  
_17567    1195  
_17570    1186  
_17571    1180  
_17572    1178  
_17573    1177  
_17574    1174  
_17575    1171  
_17576    1167  
_17577    1163  1206  

V3 
