PAL	= rkealn.pal rksaln.pal
BIN	= $(PAL:.pal=.bin)

all:	$(BIN)
	binsvcmp rkealn.bin rkealn.dg
	binsvcmp rksaln.bin rksaln.dg

%.bin:	%.pal
	pal -de $<
