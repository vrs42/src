# CGI-LIB Library Sample Makefile
#
# This is a sample makefile that will help you
# include the CGI-LIB library in your cgi script.
# The CGI-LIB library must already be compiled,
# before you you use it.

# CC is the variable that will contain your compiler
CC=gcc
#CCFLAGS=-g -O2 -Wall -o
CCFLAGS=-g -Wall -std=gnu99 -o 

# CGI is the variable that contains the cgi file name
CGI=dial_html
CGI2=os8_html
CGI3=dms_html
CGI4=library_html
CGI5=cos_html
CGI6=tss_dectape

# CGI-LIB-ARCHIVE contains the path and name of CGI-LIB
CGI-LIB-ARCHIVE=cgi-lib/cgi-lib.a

all:$(CGI)

$(CGI): dial_html.c
	$(CC) $(CCFLAGS) $@ dial_html.c url_encode.c $(CGI-LIB-ARCHIVE)
	cp dial_html /mnt/pdp/cgi-bin/
	#cp footer.shtml /mnt/pdp/cgi-bin/

$(CGI6): tss_dectape.c
	$(CC) $(CCFLAGS) $@ tss_dectape.c url_encode.c $(CGI-LIB-ARCHIVE)
	cp tss_dectape /mnt/pdp/cgi-bin/
	cp footer.shtml /mnt/pdp/cgi-bin/


$(CGI5): cos_html.c diskette.c os8.c types.h diskette.h os8.h
	$(CC) $(CCFLAGS) $@ cos_html.c diskette.c os8.c url_encode.c $(CGI-LIB-ARCHIVE) -ldb
	cp cos_html /mnt/pdp/cgi-bin/
	cp footer.shtml /mnt/pdp/cgi-bin/

$(CGI4): library_html.c
	$(CC) $(CCFLAGS) $@ library_html.c url_encode.c $(CGI-LIB-ARCHIVE)
	cp library_html /mnt/pdp/cgi-bin/
	cp footer.shtml /mnt/pdp/cgi-bin/

$(CGI3): dms_html.c
	$(CC) $(CCFLAGS) $@ dms_html.c url_encode.c $(CGI-LIB-ARCHIVE)
	cp dms_html /mnt/pdp/cgi-bin/
	cp footer.shtml /mnt/pdp/cgi-bin/

$(CGI2): os8_html.c diskette.c os8.c types.h diskette.h os8.h
	$(CC) $(CCFLAGS) $@ os8_html.c diskette.c os8.c url_encode.c $(CGI-LIB-ARCHIVE) -ldb
	cp os8_html /mnt/pdp/cgi-bin/
	cp footer.shtml /mnt/pdp/cgi-bin/

mac_convert: mac_convert.c
	$(CC) $(CCFLAGS) $@ mac_convert.c $(CGI-LIB-ARCHIVE)
	cp mac_convert /mnt/pdp/cgi-bin/

clean:
	rm $(CGI) $(CGI2) $(CGI3) $(CGI4) $(CGI5) $(CGI6) mac_convert

