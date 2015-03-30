#
# Build and verify Focal-71.
TOOLS = ./tools
#
# Suffixes:
#   .PA   Unmodified PAL source code.
#   .pal  Modified or generated PAL source code.
#   .BN   Unmodified BIN format image.
#   .bin  Generated BIN format image.
#   .lst  Generated listing file.
#   .SV   Unmodified OS/8 image file.
#   .svb  Unmodified OS/8 image file, converted to BIN format.
#   .tmp  A temporary file.
#   .err  A verify target; should not be created.
#   .ok   The "correct" reference BIN image of something. 
#         This was usually a hand-selected and possibly converted
#         image of something known to be buildable and work.
.SUFFIXES: .PA .pal .BN .bin .lst .SV .svb .tmp .err .ok
#
# Versions currently supported:
#   EFOCLB Tek 4010 support
#   PFOCLB Interrupts off
#   EFOCLC Tek 4010 support
#   PFOCLC Interrupts on
#   PFOCLD Timer function
SRC = EFOCLB.pal EFOCLC.pal PFOCLB.pal PFOCLC.pal PFOCLD.pal
#
# In general, our goal is to create .bin files with the correct content.
BIN = inital.bin $(SRC:.pal=.bin)
#
# To verify correctness, we need "OK" versions to compare against.
OK  = $(BIN:.bin=.ok)
#
# These targets don't get created, as that would inhibit error checking.
ERR = $(OK:.ok=.err)
verify: $(ERR)
#
# Just generate, don't check.
all: $(BIN)

clean:
	rm -f $(BIN) $(BIN:.bin=.tmp) $(BIN:.bin=.svb) $(ERR)

# Generally, the main body of the source is built by concatenating
# the correct versions of the component modules.
EFOCLB.pal: EFOC0B.PA EFOC1B.PA EFLOTB.PA EFOCNB.PA
	cat $^ >$@+
	mv $@+ $@

EFOCLC.pal: EFOC0C.PA EFOC1C.PA EFLOTB.PA EFOCNC.PA
	cat $^ >$@+
	mv $@+ $@

PFOCLB.pal: PFOC0B.PA PFOC1B.PA PFLOTB.PA PFOCNB.PA
	cat $^ >$@+
	mv $@+ $@

PFOCLC.pal: PFOC0C.PA PFOC1C.PA PFLOTC.PA PFOCNC.PA
	cat $^ >$@+
	mv $@+ $@

PFOCLD.pal: PFOC0D.PA PFOC1D.PA PFLOTC.PA PFOCNC.PA
	cat $^ >$@+
	mv $@+ $@

# Invoke the assembler as neeeded to create .bin files.
.pal.bin:
	$(TOOLS)/pal.exe -d $< || (rm $@ && exit 1)

# Generally, foo.tmp is foo.bin with inital.bin concatenated.
.bin.tmp: inital.bin
	cat $< inital.bin >$@

# This rule is probably unnecessary.
.SV.svb:
	$(TOOLS)/sv2bn $<

# EFOCLB.ok is EFOCLC.SV converted to BIN format.
EFOCLB.ok: EFOCLB.SV
	$(TOOLS)/sv2bn EFOCLB.SV && mv EFOCLB.svb EFOCLB.ok

# Just be sure we're still getting the same result here.
inital.err: inital.bin inital.ok
	$(TOOLS)/bincmp inital.bin inital.ok

# EFOCLB.ok is EFOCLC.SV converted to BIN format.
EFOCLB.err: EFOCLB.ok EFOCLB.tmp 
	$(TOOLS)/bincmp $^

# EFOCLC.ok is EFOCLC.BN concatenated with INITAL.ok.
# This does differ from both .SV files provided (which 
# also differ from each other), primarily in the number 
# of 0200 padding bytes after a carriage return.
EFOCLC.err: EFOCLC.ok EFOCLC.tmp
	$(TOOLS)/bincmp $^

# PFOCLB.ok is PFOCLB.BN concatenated with INITAL.ok,
# wth minor tweaks to PFOCLB.BN to fix format and checksum
# problems.
PFOCLB.err: PFOCLB.ok PFOCLB.tmp
	$(TOOLS)/bincmp $^

# There are three versions of the PFOCLC binary,
# PFOCLC.03, PFOCLC.30, and PFOCLC.32 differ in 
# the device code, and the source builds PFOCLC.03.
# PFOCLC.ok thus is PFOCLC.BN concatenated with INITAL.ok,
# wth minor tweaks to PFOCLC.BN to fix format and checksum
# problems.
PFOCLC.err: PFOCLC.ok PFOCLC.tmp
	$(TOOLS)/bincmp $^

# PFOCLD.ok is PFOCLD.BN concatenated with INITAL.ok,
# wth minor tweaks to PFOCLD.BN to fix format and checksum
# problems.
PFOCLD.err: PFOCLD.ok PFOCLD.tmp
	$(TOOLS)/bincmp $^

# These are the PAL and ABSLDR strings on which this is based, 
# as found by grep:
# EFOC0B.PA:/*EFOCLB,EFOCLB<EFOC0B,EFOC1B,EFLOTB,EFOCNB,DOLLAR
# EFOC0B.PA:/*EFOCLB,INITAL=10200$
# EFOC0C.PA:/*EFOCLC,EFOCLC<EFOC0C,EFOC1C,EFLOTB,EFOCNC,DOLLAR
# EFOC0C.PA:/*EFOCLC,INITAL=10200$
# PFOC0B.PA:/*PFOCLB,PFOCLB<PFOC0B,PFOC1B,PFLOTB,PFOCNB,DOLLAR
# PFOC0B.PA:/*PFOCLB,INITAL=10200$
# PFOC0C.PA:/*PFOCLC,PFOCLC<PFOC0C,PFOC1C,PFLOTC,PFOCNC,DOLLAR
# PFOC0C.PA:/*PFOCLC,INITAL=10200$
# PFOC0D.PA:/*PFOCLD,PFOCLD<PFOC0D,PFOC1D,PFLOTC,PFOCNC,DOLLAR
# PFOC0D.PA:/*PFOCLD,INITAL=10200$
