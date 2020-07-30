#!/usr/bin/make
ALL = focal.bin extend.bin # 2user.bin
PAL = pal
BINCMP = ~/pdp8/8tools/bincmp

all: $(ALL)

focal.bin: focal.pa float.pa
	(sed -e '/^[$$]/d' focal.pa; cat float.pa) >foo.pa
	$(PAL) -d foo.pa
	mv foo.lst focal.lst
	mv foo.bin focal.bin

extend.bin: extend.pa
	$(PAL) -d extend.pa

2user.bin: 2user.pa
	$(PAL) -d 2user.pa

test: focal.bin extend.bin
	$(BINCMP) focal.bin part1.bin
	$(BINCMP) extend.bin part2.bin
	@# $(BINCMP) 2user.bin part3.bin
