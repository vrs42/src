BD	= $(wildcard *.bd)
OK	= $(BD:.bd=.ok)
BIN	= $(BD:.bd=.bin)

all:	$(OK) $(BIN) $(BIN:.bin=.chk) check

check:	12-ajaa.bin
	bincmp 12-ajaa.bin focal-12.bin

%.chk:	%.ok %.bin
	bincmp $(@:.chk=.ok) $(@:.chk=.bin)

%.ok:	%.bd
	bd2bin $< || rm -f $@
	mv $(@:.ok=.bin) $@

%.bin:	%.pal
	pal -e -d $< || rm $@
