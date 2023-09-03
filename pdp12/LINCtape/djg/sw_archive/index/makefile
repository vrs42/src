# CGI-LIB Library Sample Makefile
#
# This is a sample makefile that will help you
# include the CGI-LIB library in your cgi script.
# The CGI-LIB library must already be compiled,
# before you you use it.

# CC is the variable that will contain your compiler
CC=gcc
CCFLAGS=-g -o
LIB=-ldb

CGI=dbmake
CGI2=dbfind

all:$(CGI) $(CGI2) filenames.db

clean:
	rm $(CGI) $(CGI2) filenames.db

$(CGI): dbmake.c
	$(CC) $(CCFLAGS) $@ dbmake.c $(LIB)

$(CGI2): dbfind.c
	$(CC) $(CCFLAGS) $@ dbfind.c $(LIB)

filenames.db: dbmake HELP.HL
	./dbmake < HELP.HL
	cp filenames.db /mnt/pdp/htdocs/images
