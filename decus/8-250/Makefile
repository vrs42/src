all:	decus-8-250.bin

%.bin:	%.pal
	pal -l -d $< || (rm $@; exit 1)
