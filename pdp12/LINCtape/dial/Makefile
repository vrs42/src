LINC	= $(wildcard *.linc)
DSK	= $(LINC:.linc=.dsk)
SUBD	= $(DSK:.dsk=.0)
DIRS	= $(DSK:.dsk=.lst)
TOOLS	= ~/pdp8/8tools

all:	$(DSK) $(SUBD) $(DIRS)

%.dsk:	%.linc $(TOOLS)/linc2dsk
	$(TOOLS)/linc2dsk $<

%.0:	%.dsk $(TOOLS)/dialxplode
	$(TOOLS)/dialxplode $< && touch $@

%.lst:	%.dsk $(TOOLS)/dialdir
	$(TOOLS)/dialdir $< >$@ || (rm $@; exit 1)
