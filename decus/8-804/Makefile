BIN = /home/vrs/pdp8/8tools
DTAPE = music.sv music1.sv medley.bi playov.pa playov.bn music.pa \
	1tnsld.mu babyel.mu enter.mu fifth1.mu fifth3.mu fugue.mu \
	gminor.mu inv201.mu inv204.mu inv208.mu inv210.mu inv213.mu \
	inv212.mu inv214.mu inv315.mu jcook1.mu jcook2.mu luvwil.mu \
	maple.mu minuet.mu minute.mu music1.mu music2.mu music3.mu \
	music4.mu music5.mu music6.mu usa.mu yankee.mu
FLOP1 = music.sv music1.sv medley.bi playov.pa playov.bn \
	1tnsld.mu babyel.mu enter.mu fifth1.mu fifth3.mu fugue.mu \
	gminor.mu inv201.mu inv204.mu inv208.mu inv210.mu inv213.mu \
	inv212.mu inv214.mu inv315.mu jcook1.mu jcook2.mu luvwil.mu \
	maple.mu minuet.mu minute.mu music1.mu music2.mu music3.mu \
	music4.mu music5.mu music6.mu usa.mu yankee.mu
FLOP2 = music.pa playov.pa playov.bn 1tnsld.mu enter.mu fifth1.mu \
	fifth3.mu fugue.mu gminor.mu inv210.mu inv213.mu inv201.mu \
	inv212.mu inv214.mu inv315.mu jcook2.mu maple.mu minuet.mu \
	minute.mu music1.mu music2.mu music3.mu music5.mu music6.mu \
	usa.mu yankee.mu 
PTAPE = musc4k.bn enter.mu luvwil.mu usa.mu yankee.mu minuet.mu \
	inv201.mu inv204.mu inv208.mu

all: $(DTAPE) $(FLOP1) $(FLOP2) $(PTAPE)

%.bn: %.bin
	$(BIN)/bin2bn $< >$@

%.bin: %.pal
	$(BIN)/pal -d -e -l $< || (rm -f $@; exit 1)

clean:
	rm -f playov.bin musc4k.bin

dist:	dtape.tar flop1.tar flop2.tar ptape.tar

dtape.tar: $(DTAPE)
	tar cf $@ $^

flop1.tar: $(FLOP1)
	tar cf $@ $^

flop2.tar: $(FLOP2)
	tar cf $@ $^

ptape.tar: $(PTAPE)
	tar cf $@ $^
