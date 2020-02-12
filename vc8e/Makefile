BIN = ./bin
XML = diag-games-kermit.xml
NEW = diag-games-kermit.new
ALL = subdir0 subdir1 $(XML) $(NEW)
EXE = bin/pal SerialDisk/server/os8disk simh-vc8e/BIN/pdp8

all: $(ALL)
#
# Ensure that the sub-directories are up to date.
#
subdir0: $(XML:.xml=.0)
	@cd $?; make all

subdir1: $(XML:.xml=.1)
	@cd $?; make all
#
# Figure out which files to include in the DSK image.
#
%.xml: %.0 %.1
	$(BIN)/os8implode.pl $(@:.xml=)
	mv $@+ $@
#
# Finally, assemble the DSK image.
#
%.new: %.xml
	$(BIN)/mkdsk.pl $?
#
# These rules force the remake of binary executables, 
# which facilitates changing between ARM and x86. 
# (No solution for Windows has been implemented yet.)
#
x86 arm: $(EXE)
	rm $(EXE)
	make $(EXE)

SerialDisk/server/os8disk: SerialDisk/server/server.c
	cd SerialDisk/server; make

simh-vc8e/BIN/pdp8:
	cd simh-vc8e; make pdp8
