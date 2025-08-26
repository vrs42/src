PAL	= c2boot.pa c3boot.pa camp.pa dtcopy.pa dtfrmt.pa mcpip.pa pip10.pa \
	tdcopy.pa tdfrmt.pa tdinit.pa 
BIN	= $(PAL:.pa=.bin)

all:	$(BIN)

clean:
	rm -f $(BIN)

%.bin:	%.pa
	pal -d -l $< || (rm $@; exit 1)
