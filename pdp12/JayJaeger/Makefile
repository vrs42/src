BIN	= cmptap.bin xmtape.bin

all:	$(BIN)

#
# We don't enable LINC extensions here, as the code isn't using them.
# We don't enable link literal generation, because the originals used
# an assembler that forced them to page zero.  We require an explicit
# reference to a page zero literal, so that we get the same code!
#
%.bin:	%.pal
	pal -d $<
