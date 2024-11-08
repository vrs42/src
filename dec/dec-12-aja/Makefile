BD	= $(wildcard *.bd)
BIN	= $(BD:.bd=.bin)

all:	$(BIN) check

check:	12-ajaa.bin
	bincmp 12-ajaa.bin focal-12.bin

%.bin:	%.bd
	bd2bin $<

%.bin:	%.pal
	pal -e -d $< || rm $@
