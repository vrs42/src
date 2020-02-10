BIN = ./bin
XML = diag-games-kermit.xml
NEW = diag-games-kermit.new
ALL = subdir0 subdir1 $(XML) $(NEW)

all: $(ALL)

subdir0: $(XML:.xml=.0)
	@cd $?; make all

subdir1: $(XML:.xml=.1)
	@cd $?; make all

%.xml: %.0 %.1
	$(BIN)/os8implode.pl $(@:.xml=)
	mv $@+ $@

%.new: %.xml
	$(BIN)/mkdsk.pl $?
