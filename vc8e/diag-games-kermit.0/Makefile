BIN = ../bin
PA = # kaleid.pa spacex.pa spcwr3.pa noeae.pa # life.pa
BN  = dsksys.bn dsknsy.bn

image: all
	@cd ..;make

all: $(BN)

%.bn: %.bin
	$(BIN)/bin2bn.pl $< >$@

%.bin: %.pa
	$(BIN)/pal -d $<

%.bin: %.pal
	$(BIN)/pal -d $<
