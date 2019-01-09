BN = joytotheworld.bn never_on_sunday.bn pipeline.bn \
	we_three_kings.bn yourmothershouldknow.bn
MS = $(BN:.bn=.ms)
SRC = decus-8-152.pal decus-8-152a.pal # newplay.pal vrs-152a.pal
BIN = $(SRC:.pal=.bin) $(BN:.bn=.bin)
PAL = ./pal
PDP8 = ./pdp8

.SUFFIX: .bn .bin .pal .ms

all: $(MS) $(BIN)

%.bin: %.pal
	./pal $<

%.ms: %.bn uncode
	./uncode $< >$@

%.bin: %.ms
	cp $< code.txt
	$(PDP8) docode
	mv code.bin $@
	rm code.txt
