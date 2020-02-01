PAL = spcwr3.pal spcwr3_noeae.pal spacex.pal kaleid.pal
BIN = $(PAL:.pal=.bin)

all: $(BIN)

%.bin: %.pal
	pal -d $<
