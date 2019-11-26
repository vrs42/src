PT  =	$(wildcard *.pt)
TXT =	8-341-LISP8-Source-Origin.pa vrs-defines.pa \
	8-341-LISP8-Source-1-of-12.pa 8-341-LISP8-Source-2-of-12.pa 8-341-LISP8-Source-3-of-12.pa \
	8-341-LISP8-Source-4-of-12.pa 8-341-LISP8-Source-5-of-12.pa 8-341-LISP8-Source-6-of-12.pa \
	8-341-LISP8-Source-7-of-12.pa 8-341-LISP8-Source-8-of-12.pa 8-341-LISP8-Source-9-of-12.pa \
	8-341-LISP8-Source-10-of-12.pa 8-341-LISP8-Source-11-of-12.pa 8-341-LISP8-Source-12-of-12.pa
BIN =	8-341.bin

8-341.bin: 8-341.pal
	pal -d $< || rm $@

8-341.pal: $(TXT)
	cat $(TXT) >$@

#8-341-LISP8-links(user).txt
#8-341-LISP8-Origin.txt
