LINC	= $(wildcard *.linc)
DSK	= $(LINC:.linc=.dsk)
SUBD	= $(DSK:.dsk=.0)
DIRS	= $(DSK:.dsk=.lst)

all:	$(DSK) $(SUBD) $(DIRS)

%.dsk:	%.linc
	linc2dsk $<

%.0:	%.dsk
	dialxplode $< && touch $@

%.lst:	%.dsk
	dialdir $< >$@ || (rm $@; exit 1)
