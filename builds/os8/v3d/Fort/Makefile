PAL	= fort.pa fpatch.pa loader.pa
BIN	= $(PAL:.pa=.bin)

all:	$(BIN)

clean:
	rm -f $(BIN)

%.bin:	%.pa
	pal -d -l $< || (rm $@; exit 1)
