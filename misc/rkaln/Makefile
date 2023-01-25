PAL	= rkealn.pal rksaln.pal
PA	= align.pa alignx.pa
BIN	= $(PAL:.pal=.bin) $(PA:.pal=.bin)

all:	$(BIN)
	binsvcmp rkealn.bin rkealn.dg
	binsvcmp rksaln.bin rksaln.dg

%.bin:	%.pal
	pal -de $<
