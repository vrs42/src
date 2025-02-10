LINC	= $(wildcard *.linc)
DSK	= $(LINC:.linc=.dsk)
DMS	= $(LINC:.linc=.dms)
SUBD	= $(DSK:.dsk=.0)
DIRS	= $(DSK:.dsk=.lst)
TOOLS	= ~/pdp8/8tools

all:	$(DSK) $(DIRS) # $(SUBD)

%.dsk:	%.linc $(TOOLS)/linc2dsk
	$(TOOLS)/linc2dsk $<

%.0:	%.dsk $(TOOLS)/dialxplode
	$(TOOLS)/dmsxplode $< && touch $@

%.dms:	%.dsk
	dd if=$< of=$@ bs=4096 skip=1

%.lst:	%.dms $(TOOLS)/dialdir
	$(TOOLS)/dmsdir $< >$@ || (rm $@; exit 1)
