diagpack2.fixed.new: diagpack2.xml+
	mkdsk $<

foo.sv: ../edu250.bin
	bn2sv edu250.bin=14000

edu250.bin: ../edu250.pal
	@cd ..;make

diagpack2.0/foo.sv: foo.sv
	cp $< $@

diagpack2.xml+: diagpack2.0 diagpack2.0/*
	os8implode diagpack2

diagpack2.0: diagpack2.dsk
	os8xplode $<
