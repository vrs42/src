# These assemble cleanly as single files.
PA	= 8i.pa  init.pa  remove.pa  replac.pa
# These are subroutines, and don't get their own .bin or .lst.
SUBR	= float.pa
# These require more work.
PAL	= 8ke.pal 8ki.pal focal8.pal quad8e.pal quad8i.pal
BIN	= $(PA:.pa=.bin) $(PAL:.pal=.bin)

all:	$(BIN)

# Special rules to build stuff using float.pa.
8ke.pal: 8ke.pa focal8.pa float.pa
	cat $^ >$@ || (rm $@ && exit 1)

8ki.pal: 8ki.pa focal8.pa float.pa
	cat $^ >$@ || (rm $@ && exit 1)

focal8.pal: focal8.pa float.pa
	cat $^ >$@ || (rm $@ && exit 1)

quad8e.pal: quad8e.pa focal8.pa float.pa
	cat $^ >$@ || (rm $@ && exit 1)

quad8i.pal: quad8i.pa focal8.pa float.pa
	cat $^ >$@ || (rm $@ && exit 1)

clean:
	rm -f *.bin *.lst

%.bin:	%.pal
	pal -d -e $< || (rm $@ && exit 1)

%.bin:	%.pa
	pal -d -e $< || (rm $@ && exit 1)
