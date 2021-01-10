DIR	= advent.0
DOC	= $(DIR)/advent.dc $(DIR)/compil.bi $(DIR)/load.bi \
	$(DIR)/runad.bi $(DIR)/advent.tx
RA	= a5toa1.ra bitset.ra carry.ra dark.ra decode.ra drop.ra dstroy.ra \
	here.ra juggle.ra liqloc.ra liq.ra move.ra pct.ra pspeak.ra put.ra \
	rkb.ra rspeak.ra seed.ra speak.ra trvloc.ra vocab.ra
RA	= $(wildcard advent.0/*.ra)
FT	= advent.ft bug.ft getin.ft initad.ft io.ft rnd.ft temp.ft yes.ft
FT	= $(wildcard advent.0/*.ft)
LD	= advent.ld
SRC	= $(RA) $(FT) $(DOC)
RL	= $(RA:.ra=.rl) $(FT:.ft=.rl)

# BUGBUG: Write the dobuild script!
build:	advent.new
	pdp8 dobuild

advent.xml+: $(SRC)
	rm -f $(RL)
	os8implode advent

advent.new: advent.xml+
	mkdsk advent.xml+
