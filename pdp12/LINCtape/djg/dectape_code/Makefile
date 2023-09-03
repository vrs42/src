#
# Execute 'make' to create prucode.bin and read_dectape
# Other options:
# make clean
# make all
# make pru
# make projectu
# make prucode
# make clean
#

pru = prucode0.bin prucode1.bin
project1 = read_dectape
#project1 =
project2 = dectape_util

LIB_PATH = ../am335x_pru_package-master/pru_sw/app_loader/lib/
LIBRARIES = pthread prussdrv m
INCLUDES = -I ../am335x_pru_package-master/pru_sw/app_loader/include/

SOURCES =  read_dectape.c dectape_decode.c decode_transitions.c linctape_decode.c
SOURCES2 =  dectape_util.c dectape_decode.c decode_transitions.c linctape_decode.c

EXTRA_DEFINE =
CCCFLAGS = $(EXTRA_DEFINE)
CC = gcc
CFLAGS = $(EXTRA_DEFINE) $(INCLUDES) -O2 -g -Wall
PASM = ../am335x_pru_package-master/pru_sw/utils/pasm

all : $(pru) $(project1) $(project2)
pru : $(pru)

$(project1) : $(SOURCES:.c=.o) 
	$(CC)  $(SOURCES:.c=.o) $(LIB_PATH:%=-L %) $(LIBRARIES:%=-l%) -o $@
$(project2) : $(SOURCES2:.c=.o)
	$(CC)  $(SOURCES2:.c=.o) $(LIB_PATH:%=-L %) -lpthread -lm -o $@

clean :
	rm -rf *.o *.bin $(project) core *~

%.bin: %.p cmd.h
	$(PASM) -b $<

%.o: %.c cmd.h
	$(CC) $(CFLAGS) -c -o $@ $<

.SUFFIXES: .c.d
%.d: %.c
	$(SHELL) -ec "$(CC) -M $(CPPFLAGS) $< | sed 's/$*\\.o[ :]*/$@ &/g' > $@" -include $(SOURCES:.c=.d)

