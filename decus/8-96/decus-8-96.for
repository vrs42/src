C;        THIS PROGRAM COMPUTES THE J BESSEL FUNCTION
C;        FOR A GIVEN ARGUMENT AND ORDER
C;        ERROR CODE KEY:
C;        IER=0.......NO ERROR
C;        IER=1.......ORDER IS NEGATIVE
C;        IER=2.......ARGUMENT IS NEGATIVE OR ZERO
C;        IER=3.......REQ'D ACCURACY NOT OBTAINED
C;        IER=4.......RANGE OF N WRT. X NOT CORRECT
502;      CONTINUE
          TYPE 100
100;      FORMAT (/,"ENTER ORDER OF J BESSEL FUNCTION DESIRED",/)
          ACCEPT 200,N
200;      FORMAT(I)
          TYPE 300
300;      FORMAT("ENTER ARGUMENT OF J BESSEL FUNCTION DESIRED",/)
          ACCEPT 400,X
400;      FORMAT(E)
          TYPE 500
500;      FORMAT("ENTER ACCURACY DESIRED",/)
          ACCEPT 400,D
          BJ=0.
          IF(N)10,20,20
10;       IER=1
          GO TO 77
20;       IF(X)30,30,31
30;       IER=2
          GO TO 77
31;       IF(X-15.)32,32,34
32;       NTEST=20.+10.*X-X**2./3.
          GO TO 36
34;       NTEST=90.+X/2.
36;       IF(N-NTEST)40,38,38
38;       IER=4
          GO TO 77
40;       IER=0
          N1=N+1
          BPREV=.0
          IF(X-5.)50,60,60
50;       MA=X+6.
          GO TO 70
60;       MA=1.4*X+60./X
          IFIX=X
70;       MB=N+IFIX/4+2
          IF(MB-MA)111,112,112
112;      MZERO=MB
          GO TO 113
111;      MZERO=MA
113;      CONTINUE
          MMAX=NTEST
          DO 190 M=MZERO,MMAX,3
          FM1=1.0E-28
          FM=ALPHA=0.
          IF(M-(M/2)*2)120,110,120
110;      JT=-1
          GO TO 130
120;      JT=1
130;      M2=M-2
          DO 160 K=1,M2
          MK=M-K
          FLOAT=MK
          BMK=2.*FLOAT*FM1/X-FM
          FM=FM1
          FM1=BMK
          IF(MK-N-1)150,140,150
140;      BJ=BMK
150;      JT=-JT
          S=1+JT
          ALPHA=ALPHA+BMK*S
160;      CONTINUE
          BMK=2.*FM1/X-FM
          IF(N)180,170,180
170;      BJ=BMK
180;      ALPHA=ALPHA+BMK
          BJ=BJ/ALPHA
          UU=BJ-BPREV
          IF(UU)191,191,192
191;      UU=-UU
192;      VV=D*BJ
          IF(VV)193,193,194
193;      VV=-VV
194;      IF(UU-VV)77,77,195
195;      BPREV=BJ
190;      CONTINUE
          IER=3
77;       TYPE 102,BJ,IER
102;      FORMAT(E," IER=",I,/)
          GO TO 502
          END

