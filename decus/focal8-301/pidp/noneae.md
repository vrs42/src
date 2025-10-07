# Re-generating Non-EAE FPP support

Assembly instructions found in 16KCPR.PA, say:

    /    UWF.BN<16KCPR,12KFNS,8KFIO,8KFPP,16KLIB/L/K=100
    /    EAE VERSION:      8XFIO,8XFPP

The non-EAE versions of FIO and FPP have been lost.

The assembly, load, and save lines used are:

    UWF16K.BN<16KCPR.PA,12KFNS.PA,8XFIO.PA,8XFPP.PA,16KLIB.PA/K
    LOAD RKA1:UWF16K.BN
    SAVE RKA1:UWF16K.SV;100

# Plan: Create new support for the Non-EAE Platform.

Someone with deep understanding of PDP-8 floating point implementation
could probably create work-alikes for 8KFIO and 8KFPP.  Perhaps
one day that person will come along.

This project takes a path that requires less deep understanding:

Create a module that substitutes for the EAE instructions used
by 8XFIO and 8XFPP.

After analyzing the use of the EAE in those two modules the
minimum required emulations are:

- A memory location to serve as the MQ register.  We will use
the existing SAVMQ in location 10.
- MQL Which is actually just DCA SAVMQ
- SWP which will swap AC and SAVMQ
- MUY EAE Multiply the contents of SAVMQ by the number following the MUL call, 
storing the high 12 bits of the product in the AC and the low 12 in SAVMQ.
- DVI EAE Divide of a 24 bit quantity with the high 12 bits in the AC
and the low 12 bits in SAVMQ, storing the 12 bit quotient in SAVMQ
and the 12 bit remainder in the AC.
- SWP MUY Combined SWP and MUY.
- MQL DVI Combined MQL and DVI.

The two 8X modules only use Mode A for PDP-12 compatibility.
They don't use any of the other EAE instructions.

There is a block of memory, labeled for use on the 12K UWF build
"for user functions" starting at 13200.  BITMAP shows no use
of memory between 13200 and 14177. It also shows crucial field 1
page zero availability: 10113-10117 and 10164-1-167.
Five of those locations are needed to make the JMS I . links.

Two new source files are created:

- `8NFPP.PA` — Non-EAE Floating-Point Package (arithmetic routines)
- `8NFIO.PA` — Non-EAE Floating-Point I/O Package (input/output formatting)

I chose not to call them 8K... because they're not.  

Because 8XFIO.PA shows up in the UWF16K listing before 8XFPP.PA,
I elected to create the emulation routines in the FIO module,
8NFIO.PA

In the course of development, I discovered I needed an assembly language
test harness. I put that in 8NFIO.PA so that the basic multiply and divide
routines could be tested without having to rebuild UWF every time, and
so that simple single instruction stepping would be easy inside SIMH.

The rest of 8NFIO.PA and 8NFPP.PA are imports of their 8X counterparts
with the EAE instructions changed to the calls to the emulations:

MQL -> DCA SAVMQ
MUY -> EMMUY
SWP MUY -> MQLMUY
DVI -> EMDVI
MQL DVI -> MQLDVI

Care must be taken to emulate correct edge-case behavior (divide by zero, overflow/underflow)

## Current status 2025-09-11

Basic tests work, but UWFOCAL doesn't.  More edge cases need to be checked.

## Phase 5 — Testing
- **Unit tests**:
  - PAL8 harness for each `EAE_*` stub
  - Verify software vs. hardware results match (AC/MQ/Link state)
- **Cross-build tests**:
  - Run identical FOCAL programs in EAE and non-EAE builds under SIMH
  - Compare results bit-for-bit
- **Edge cases**:
  - Division by zero
  - Normalization of zero
  - Negative operands
  - Overflow/underflow conditions
- **I/O-specific tests**:
  - Floating-point input parsing
  - Output formatting (field widths, exponent notation, rounding)

---

## Phase 6 — Optimization
- Rewrite MUY routine to use Booth's algorithm if it can be made to fit.


# Testing

chatgpt provided corner cases for MUY DVI testing:

## Multiply Corner Cases (12 × 12 → 24-bit product)

- Smallest operands
  - 0 × 0 = 0
  - 0 × 7777 = 0
- Ones
  - 1 × 1 = 1
  - 1 × 7777 = 7777
- Maximal operands
  - 7777 × 7777 → product ≈ 77_777_001 (24-bit product — check high-end overflow behavior)
- Powers of two
  - 2 × 2000 → shift into high word
  - 2000 × 2000 → result sets a single bit in high half


## Divide Corner Cases (24 ÷ 12 → 12-bit quotient + 12-bit remainder)
(plain PDP-8 octal; expected quotient and remainder shown)

- 777777 ÷ 1 = 777777  remainder 0
- 5 ÷ 10 = 0  remainder 5
- 1234 ÷ 1234 = 1  remainder 0
- 7776 ÷ 7777 = 0  remainder 7776
- 777777 ÷ 1 = 777777  remainder 0
- 777777 ÷ 7777 = 100  remainder 77
- 400000 ÷ 2000 = 200  remainder 0
- 2000 ÷ 400 = 4  remainder 0
- 12 ÷ 4 = 2  remainder 2
- 12 ÷ 5 = 2  remainder 0
- 1000:0000 ÷ 7777  => (24-bit dividend written as HI:LO — i.e. octal 10000000 ÷ 7777)
  - expected quotient 1000  remainder 1000

Notes:
- All values and results are shown in PDP-8 style octal.
- For the “1000:0000 ÷ 7777” case the dividend is the 24-bit value with HI=1000, LO=0000 (concatenate to octal 10000000).
- The “Maximal operands” multiply case is shown as an approximate 24-bit octal product; use your host arithmetic to verify exact 24-bit result when testing.


chatgpt provided some FOCAL code for testing:

```
01.10 SET A=1234
01.20 SET B=567
01.30 SET X=A*B
01.40 T "1234*567=",X !
01.50 SET Y=X/321
01.60 T "699678/321=",Y !
01.70 SET C=-25
01.80 SET D=17
01.90 SET Z=C*D
02.00 T "-25*17=",Z !
02.10 SET Q=Z/(-5)
02.20 T "-425/-5=",Q !
02.30 SET R=32767*2
02.40 T "32767*2=",R !
02.50 SET S=R/2
02.60 T "65534/2=",S !
```

Expected results: 

```
1234*567= 6.996780002E+05
699678/321= 2.179682243E+03
-25*17=-4.250000000E+02
-425/-5= 8.500000000E+01
32767*2= 6.553400001E+04
65534/2= 3.276700000E+04
```

More ambitious test:

```
01.10 T "=== BASIC MULTIPLY ===" !
01.20 SET A=1234
01.30 SET B=567
01.40 T "1234*567=",A*B !

01.50 SET C=-25
01.60 SET D=17
01.70 T "-25*17=",C*D !

01.80 SET R=32767
01.90 T "32767*2=",R*2 !
02.00 T "(-32768)*2=",(-32768)*2 !

02.10 T "=== DIVISION ===" !
02.20 T "699678/321=",699678/321 !
02.30 T "-425/-5=",(-425)/(-5) !
02.40 T "425/-5=",425/(-5) !
02.50 T "1/2=",1/2 !
02.60 T "1/16=",1/16 !

02.70 T "=== ZERO HANDLING ===" !
02.80 T "0*9999=",0*9999 !
02.90 T "9999*0=",9999*0 !
03.00 T "0/1234=",0/1234 !
03.10 T "1234/1=",1234/1 !

03.20 T "=== MIXED SIGNS ===" !
03.30 T "-5*5=",(-5)*5 !
03.40 T "-5/-5=",(-5)/(-5) !
03.50 T "5/-5=",5/(-5) !

03.60 T "=== POWERS OF TWO ===" !
03.70 T "2^10=",2^10 !
03.80 T "2^15=",2^15 !
03.90 T "2^-1=",2^-1 !
04.00 T "2^-10=",2^-10 !

04.10 T "=== TRANSCENDENTALS ===" !
04.20 T "SIN(0)=",SIN(0) !
04.30 T "COS(0)=",COS(0) !
04.40 T "LOG(1)=",LOG(1) !
04.50 T "EXP(1)=",EXP(1) !
04.60 T "ATN(1)=",ATN(1) !
04.70 T "SQRT(2)=",SQRT(2) !

04.80 T "=== LARGE NUMBERS ===" !
04.90 T "1E+10 * 1E-10=",1E+10*1E-10 !
05.00 T "1E+10 / 1E+5=",1E+10/1E+5 !
05.10 T "1E-10 * 1E+10=",1E-10*1E+10 !
05.20 T "1E-10 / 1E-5=",1E-10/1E-5 !

99.99 T "=== END OF TEST ===" !

```

Results: 

```
=== BASIC MULTIPLY ===
1234*567= 6.996780002E+05
-25*17=-4.250000000E+02
32767*2= 6.553400001E+04
(-32768)*2=-6.553600002E+04

=== DIVISION ===
699678/321= 2.179682243E+03
-425/-5= 8.500000000E+01
425/-5=-8.500000000E+01
1/2= 5.000000000E-01
1/16= 6.250000000E-02

=== ZERO HANDLING ===
0*9999= 0.000000000E+00
9999*0= 0.000000000E+00
0/1234= 0.000000000E+00
1234/1= 1.234000000E+03

=== MIXED SIGNS ===
-5*5=-2.500000000E+01
-5/-5= 1.000000000E+00
5/-5=-1.000000000E+00

=== POWERS OF TWO ===
2^10= 1.024000000E+03
2^15= 3.276800000E+04
2^-1= 5.000000000E-01
2^-10= 9.765625000E-04

=== TRANSCENDENTALS ===
SIN(0)= 0.000000000E+00
COS(0)= 1.000000000E+00
LOG(1)= 0.000000000E+00
EXP(1)= 2.718281828E+00
ATN(1)= 7.853981634E-01
SQRT(2)= 1.414213562E+00

=== LARGE NUMBERS ===
1E+10 * 1E-10= 1.000000000E+00
1E+10 / 1E+5= 1.000000000E+05
1E-10 * 1E+10= 1.000000000E+00
1E-10 / 1E-5= 1.000000000E-05

=== END OF TEST ===

```
