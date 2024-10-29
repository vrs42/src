BD	= $(wildcard *.bd)
BIN	= $(BD:.bd=.bin)

all:	$(BIN)

%.bin:	%.bd
	bd2bin $<
