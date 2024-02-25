all:	morse.bin
	bincmp morse.bin morse.ok

%.bin:	%.pal
	pal -j -d $<
