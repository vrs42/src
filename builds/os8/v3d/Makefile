SUBD	= #system devext extensions fortran # Fort Tape # Driver
PAL	= bitmap.pa boot.pa build.pa ccl.pa cd.pa cref.pa direct.pa edit.pa \
	epic.pa fotp.pa help.pa libset.pa os8.pa pal8.pa pip.pa resorc.pa \
	rklfmt.pa rxcopy.pa sabr.pa set.pa spatch.pa srccom.pa
BIN	= lpsv.bin tc08ns.bin l645.bin dtfrmt.bin vr12.bin asr33.bin \
	rommsy.bin pip10.bin td8ec.bin lqp.bin dtcopy.bin td8esy.bin \
	rk8esy.bin dump.bin tdfrmt.bin tdinit.bin td8ed.bin fort.bin \
	rk08ns.bin cr8e.bin loader.bin camp.bin rk08sy.bin mcpip.bin \
	lincsy.bin kl8e.bin pt8e.bin rk8ens.bin df32ns.bin tc08sy.bin \
	tdcopy.bin df32sy.bin td8eb.bin lincns.bin vt50.bin td8ea.bin \
	rf08ns.bin tm8e.bin rf08sy.bin lspt.bin bat.bin \
	load.bin pass3.bin ralf.bin pass2.bin f4.bin libra.bin \
	boot.bin fotp.bin ccl.bin rxcopy.bin bitmap.bin resorc.bin sabr.bin \
	pip.bin srccom.bin build.bin set.bin libset.bin cref.bin epic.bin \
	direct.bin help.bin rklfmt.bin pal8.bin edit.bin \
	rlc.bin rxsy1.bin rxsy2.bin rl1.bin rl0.bin rx78c.bin \
	basic.bin bcomp.bin bload.bin msbat.bin batch.bin brts.bin teco.bin \
	futil.bin

J421A	= boot.sv build.sv ccl.sv direct.sv edit.sv set.sv f4.sv fpat.bn \
	libra.sv load.sv pass2.sv pass2o.sv pass3.sv ralf.sv frts.sv forlib.rl
J422A	= basic.af basic.sv bcomp.sv bpat.bn ccl.sv futil.sv help.sv set.sv \
	basic.ff basic.uf bload.sv brts.sv direct.sv geniox.sb msbat.sv \
	teco.sv basic.sf batch.sv boot.sv build.sv eabrts.bn help.hl reseq.ba
J423B	= absldr.sv ccl.sv float.rl iopen.rl pal8.sv rlfrmt.sv tdcopy.sv \
	atan.rl cref.sv fort.sv ipowrs.rl pip10.sv rwtape.rl tdfrmt.sv \
	bitmap.sv direct.sv fotp.sv lib8.rl pip.sv rxcopy.sv trig.rl \
	boot.sv dtcopy.sv geniox.rl libset.sv powers.rl sabr.sv utilty.rl \
	build.sv dtfrmt.sv integr.rl loader.sv resorc.sv sqrt.rl \
	camp.sv epic.sv ioh.rl mcpip.sv rklfmt.sv srccom.sv
J424A	= abs.ra cabs.ra cos.ra dim.ra expci.ra idint.ra sign.ra \
	acos.ra carith.ra csin.ra dlog10.ra expdd.ra ifix.ra sind.ra \
	adc.ra cexp.ra csqrt.ra dlog.ra expdi.ra ltr.ra sinh.ra \
	alog10.ra chars.ra dabs.ra dmax1.ra expdr.ra onqib.ra sin.ra \
	alog.ra chkeof.ra datan2.ra dmin1.ra expic.ra pause.ra sngl.ra \
	amax.ra clk8a.ra datan.ra dmod.ra expid2.ra plot.ra sqrt.ra \
	amin.ra clock.ra date.ra dsign.ra expid.ra real.ra tand.ra \
	amod.ra clog.ra dble.ra dsin.ra expii.ra realtm.ra tanh.ra \
	asin.ra cmplx.ra dcos.ra dsqrt.ra expir.ra rfcv.ra tan.ra \
	atan2.ra cosd.ra dexp3.ra exp3.ra exp.ra rfdv.ra xfix.ra \
	atan.ra cosh.ra dexp.ra expcc.ra float.ra rsw.ra
J425A	= cclat.ma cclcor.ma cclmsg.ma cclsb2.ma ccltab.ma kl8e.pa \
	ccl.bi ccldat.ma cclps.ma cclsem.ma ccltbl.ma os78.bi \
	cclcd.ma ccldrv.ma cclrem.ma cclsiz.ma help.hl savecb.pa \
	cclcdx.ma ccl.ma cclrun.ma cclsub.ma help.sv
J426A	= asr33.bn df32sy.bn lspt.bn rl0.bn rxns.bn td8ec.bn vxns.bn \
	bat.bn dump.bn pt8e.bn rl1.bn rxsy1.bn td8ed.bn vxsy.bn \
	cr8e.bn kl8e.bn rf08ns.bn rl2.bn rxsy2.bn td8esy.bn \
	csa.bn l645.bn rf08sy.bn rl3.bn tc08ns.bn tdinit.sv \
	csb.bn lincns.bn rk08ns.bn rlc.bn tc08sy.bn tdrom.sy \
	csc.bn lincsy.bn rk08sy.bn rlsy.bn td12k.sy tm8e.bn \
	csd.bn lpsv.bn rk8ens.bn rommsy.bn td8ea.bn vr12.bn \
	df32ns.bn lqp.bn rk8esy.bn rx78c.bn td8eb.bn vt50.bn
PARTS	= j421a j422a j423b j424a j425a j426a
RLFSRC	= abs.ra asin.ra atan.ra exp.ra ifix.ra sinh.ra amod.ra cosh.ra \
	acos.ra onqib.ra sign.ra tanh.ra expii.ra ltr.ra sin.ra tan.ra \
	alog.ra amin.ra exp3.ra cos.ra chkeof.ra rfdv.ra rfcv.ra pause.ra \
	clk8a.ra amax.ra atan2.ra sqrt.ra xfix.ra alog10.ra dim.ra expir.ra \
	chars.ra date.ra float.ra
RLFBIN	= $(RLFSRC:.ra=.rl)
# Stub for now
RALF	= : ralf
LIBRA	= : libra
SABR	= : sabr

all:	$(BIN) $(PARTS)

j421a:	$(J421A)
j422a:	$(J422A)
j423b:	$(J423B)
j424a:	$(J424A)
j425a:	$(J425A)
j426a:	$(J426A)

clean:
	rm -f $(J421A) $(J422A) $(J423B) $(J424A) $(J425A) $(J426A)

subdir:	$(SUBD)
	for i in $(SUBD); do cd $$i; make; cd ..; done

%.bin:	%.pa
	pal -d -l $< || (rm $@; exit 1)

%.bin:	system/%.pa
	pal -d -l $< || (rm $@; exit 1)
	mv system/$@ $@

%.bin:	fortran/%.pa
	pal -d -l $< || (rm $@; exit 1)
	mv fortran/$@ $@

%.bin:	extensions/%.pa
	pal -c -d -l $< || (rm $@; exit 1)
	mv extensions/$@ $@

%.bin:	os78.v4/%.pa
	pal -c -d -l $< || (rm $@; exit 1)
	mv os78.v4/$@ $@

kl8e.pa: system/kl8e.pa
	cp $< $@

%.hl: system/%.hl
	cp $< $@

%.sv:	%.bin
	bn2sv $@ $<

%.bn:	%.bin
	bin2bn $< >$@

%.bn:	os78.v4/%.bin
	bin2bn $< >$@

%.ra:	fortran/%.ra
	cp $< $@

%.ma:	devext/%.ma
	cp $< $@

%.sb:	extensions/%.sb
	cp $< $@

%.rl:	%.sb
	$(SABR) $<

%.rl:	system/%.sb
	$(SABR) $<
	mv system/$@ $@

%.rl:	os78.v4/%.ra
	$(RALF) $<
	mv os78.v4/$@ $@

forlib.rl: $(RLFBIN)
	$(LIBRA) $@ $(RLFBIN)

