BIN = ../bin
PA = life.pal kalied.pal
PA = kaleid.pa spacex.pa spcwr3.pa life.pa
BN  = $(PA:.pa=.bn) $(PAL:.pal=.bn)

image: all
#	@cd ..;make

all: $(BN)

%.bn: %.bin
	$(BIN)/bin2bn $< >$@

%.bin: %.pa
	$(BIN)/pal -e -d $<

%.bin: %.pal
	$(BIN)/pal -e -l -d $<
