SRC	= k12clr.pa k12deb.pa k12dec.pa k12enb.pa k12enc.pa k12mit.pa
BIN	= $(SRC:.pa=.bin)
BN	= $(BIN:.bin=.bn)

all:	$(BN)

%.bin:	%.pa
	pal -d -j $<

%.bn:	%.bin
	bin2bn $< >$@ || rm $@
