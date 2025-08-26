PAL	= r01e.pa r0ab.pa r0cd.pa r1ab.pa r1cd.pa rl01sy.pa rl02sy.pa rl0.pa \
	rl1.pa rlc.pa rx02sy.pa rx2a.pa rx2b.pa rx50sy.pa rx5a.pa rx5b.pa
BIN	= $(PAL:.pa=.bin)

all:	$(BIN)

clean:
	rm -f $(BIN)

%.bin:	%.pa
	pal -d -l $< || (rm $@; exit 1)
