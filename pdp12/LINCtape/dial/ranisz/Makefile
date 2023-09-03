SRC	= $(HOME)/pdp8/src/dec
all:	ranisz.bin d0fa.bin d0fb.bin d0fc.bin d07a.bin d07b.bin
	bincmp ranisz-pb ranisz.bin |head -20
	bincmp maindec-8e-d0fa-pb d0fa.bin |head -20
#	bincmp maindec-8e-d0fb-pb d0fb.bin |head -20
	bincmp maindec-8e-d0fc-pb d0fc.bin |head -20
	bincmp maindec-08-d07a-pb d07a.bin |head -20
	bincmp maindec-08-d07b-pb d07b.bin |head -20

%.bin:	%.pal
	pal -d $<

disburse: ranisz.bin d0fa.bin d0fb.bin d0fc.bin d07a.bin d07b.bin
	cp d0f?.* maindec-8e-d0f* $(SRC)/maindec-8e-d0f/.
	cp d07?.* maindec-08-d07* $(SRC)/maindec-08-d07/.
	cp d07?.* $(SRC)/maindec-8s-d07/.
	cp maindec-08-d07a-pb $(SRC)/maindec-8s-d07/maindec-8s-d07a-pb
	cp maindec-08-d07b-pb $(SRC)/maindec-8s-d07/maindec-8s-d07b-pb
