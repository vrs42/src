BIN = ../bin
PA = kaleid.pa spacex.pa spcwr3.pa noeae.pa # life.pa
BN  = $(PA:.pa=.bn)

image: all
	@cd ..;make

all: $(BN)

%.bn: %.pa
	$(BIN)/pal -d $<
	dd if=$(<:.pa=.bin) of=$@ bs=384 conv=sync

%.bn: %.pal
	$(BIN)/pal -d $<
	dd if=$(<:.pal=.bin) of=$@ bs=384 conv=sync
