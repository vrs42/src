SB	= atan.sb # integr.sb ioh.sb iopen.sb ipowrs.sb powers.sb rwtape.sb \
	sqrt.sb trig.sb utilty.sb
RL	= $(SB:.sb=.rl)
SABR	= ./sabr

all:	$(RL)
	for i in $(RL); do cmp $$i canon/$$i; done

%.rl:	%.sb
	$(SABR) $<
