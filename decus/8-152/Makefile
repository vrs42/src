BN = joytotheworld.bn never_on_sunday.bn pipeline.bn \
	we_three_kings.bn yourmothershouldknow.bn
MS = $(BN:.bn=.ms)
SRC = decus-8-152.pal decus-8-152a.pal # newplay.pal vrs-152a.pal
BIN = $(SRC:.pal=.bin) $(BN:.bn=.bin) p0X0X.bin p0102.bin c0X0X.bin c0102.bin
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

p0X0X.bin: vrs-152.pp
	./perlpp -DUNKNOWN $< && mv perlpp.out p0X0X.pal
	./pal p0X0X.pal
	./bincmp $@ play.bn || (mv $@ $@-; exit 1)

p0102.bin: vrs-152.pp
	./perlpp $< && mv perlpp.out p0102.pal
	./pal p0102.pal
	./bincmp $@ decus-8-152.bin || (mv $@ $@-; exit 1)


c0X0X.bin: vrs-152a.pp
	./perlpp -DUNKNOWN $< && mv perlpp.out c0X0X.pal
	./pal c0X0X.pal
	./bincmp $@ coding.bn || (mv $@ $@-; exit 1)

c0102.bin: vrs-152a.pp
	./perlpp $< && mv perlpp.out c0102.pal
	./pal c0102.pal
	./bincmp $@ decus-8-152a.bin || (mv $@ $@-; exit 1)

