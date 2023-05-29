UWF16K	= 16kcpr.pa 12kfns.pa 8xfio.pa 8xfpp.pa 16klib.pa
NOEAE	= 16kcpr.pa 12kfns.pa 8kfio.pa 8kfpp.pa 16klib.pa
OVLSRC	= 16kxii.pa 16mplt.pa 32kxii.pa bslash.pa fcom45.pa fcom47.pa lpt8i.pa
OVLBIN	= $(OVLSRC:.pa=.bin)

all:	uwf16k.bin $(OVLBIN)

clean:
	rm -f *.bin

check:

uwf16k.pa: $(UWF16K)
	cat $(UWF16K) >$@

%.bin:	%.pa
	pal -e -d $< || (rm $@; exit 1)
	bincmp `basename $@ .bin`.bn $@
