ORIG = vc8ea.bn vc8eb.bn vc8ec.bn vc8ed.bn
BIN = $(ORIG:.bn=.bin)

all: $(BIN)

%.bin: %.pal
	pal -d $<
	bincmp $@ $(<:.pal=.ok) || (rm $@; exit 1)
