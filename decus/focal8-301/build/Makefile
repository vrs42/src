UWF16K	= 16kcpr.pa 12kfns.pa 8xfio.pa 8xfpp.pa 16klib.pa
NOEAE	= 16kcpr.pa 12kfns.pa 8kfio.pa 8kfpp.pa 16klib.pa
OVLSRC	= 16kxii.pa 16mplt.pa 32kxii.pa bslash.pa fcom45.pa fcom47.pa lpt8i.pa
OVLSRC	= dialog.pa fadc.pa fcom.pa fcx8e.pa fcxae.pa fexp.pa fitr.pa fmq.pa \
	fsr.pa fx.pa fxy.pa lf.pa pdp12.pa pdp8e.pa plot8k.pa plot.pa t4002.pa \
	t4010.pa tdump.pa zvrfix.pa
OVLBIN	= $(OVLSRC:.pa=.bin)

all:	$(OVLBIN) # uwf16k.bin

clean:
	rm -f *.bin

check:

uwf16k.pa: $(UWF16K)
	cat $(UWF16K) >$@

#
# This rule illustrates how dialog.pal is constructed/assembled.
# As a practical matter, dialog.pal has been edited to change
# 'TITLE' to 'TITL' to avoid conflict with the TITLE pseudo-op.
# This preserves the original *.pa, but does mean you don't want
# this rule to actually fire.
dialog.pal: fcdef.pa dialog.pa fcovr.pa fclib.pa
	cat >$@ fcdef.pa dialog.pa fcovr.pa fclib.pa

%.bin:	%.pal
	pal -e -d $< || (rm $@; exit 1)
	bincmp `basename $@ .bin`.bn $@ || (rm $@; exit 1)

%.bin:	%.pa
	pal -e -d $< || (rm $@; exit 1)
	bincmp `basename $@ .bin`.bn $@ || (rm $@; exit 1)
