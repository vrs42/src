#2345678901234567890123456789012345678901234567890123456789012345678901234567890
PA	= 12k.pa abinos.pa albin.pa algrun.pa comos8.pa fpeae8.pa fppeae.pa \
	fpp.pa inteae.pa intrun.pa runeae.pa runos8.pa
PABN	= 12k.bn abinos.bn albin.bn algrun.bn comos8.bn fpeae8.bn \
	fpp.bn fppeae.bn inteae.bn intrun.bn runeae.bn runos8.bn
ALBN	= algcom.bn intcom.bn
BIN	= $(PABN:.bn=.bin) $(AB)
AL	= algcom.al intcom.al
DOC	= cclcf.ls exampl.es
AC	= $(AL:.al=.ac)
AB	= $(AL:.al=.bin)
PT	= bct bsc cot brt rot

# By default we bring the paper tape images up to date.
all:	$(BIN) $(PT)

clean:
	rm -f $(BIN) $(PT)

compare:
	for i in $(BIN); do bincmp `basename $$i .bin`.bn $$i; done

%.bin %.lst: %.pa
	pal -d -e -l $< || (rm -f $@; exit 1)

%.ac:	%.al
	@echo Answer "'2'" "'2'", then ^C at the "'^'" prompt.
	pdp8 $(@:.ac=)

%.bin:	%.ac
	2asc $< >$(@:.bin=.pal)
	pal $(@:.bin=.pal)

bct:	intrun.bin algcom.bin
	cat $? >$@

bsc:	intrun.bin intcom.bin
	cat $? >$@

cot:	fpeae8.bin comos8.bin 12k.bin
	cat $? >$@

brt:	algrun.bin albin.bin
	cat $? >$@

rot:	runeae.bin abinos.bin 12k.bin # 16k.bin
	cat $? >$@

