ALL	= icbm.bin icbm.cjl.bin icbm.orig.bin icbm.vrs.bin

all:	$(ALL)

icbm.cjl.bin: icbm.cjl.pa
	pal -d $< || (rm $@; exit 1)
	binsvcmp $@ icbm.sv

%.bn:	%.bin
	bin2bn $< >$@

%.bin:	%.pa
	pal -d $< || (rm $@; exit 1)

%.bin:	%.pal
	pal -d $< || (rm $@; exit 1)
