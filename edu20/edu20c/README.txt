EduSystem 20 Version C
======================


Background
----------

The EduSystem Handbook (January, 1973) has a detailed description of all versions of EduSystem BASIC. Edu20C handles up to 8 simultaneous users in a paper-tape environment: both ASR-33 Teletype (or equivalent) and optional high-speed PTR:/PTP:. The EduSystem Handbook can be found on line at:

http://bitsavers.trailing-edge.com/pdf/dec/pdp8/tss8/EduSystemHandbookJan73.pdf

The EduSystem Handbook predates Edu20C BASIC by several months so it is not a fully accurate description. Edu20C includes string manipulation functions LEN(A$), CAT(A$,B$), MID(A$,S,L) not found in Chapter 5. These functions are described in the Edu25 chapter (Chapter 6, specifically on pages 6-12 and 6-13). Edu20C Basic also supports the command LINPUT (see page 6-10).



Files
-----

edu20c.pa.txt is the reconstructed PAL source code

edu20c.ls.txt is the PAL-8 assembler output listing (with cross-reference generated on a PDP-10)

edu20c.bn.pt is the BIN Loader format output from assembling edu20c.pa

edu20c.rm.pt is the full Edu20C paper tape image with the self-starting binary loader grafted on to the front end (see the SSBIN folder)



Assembling Edu20C BASIC's Source Code in OS/8
---------------------------------------------

Once you've got EDU20C.PA on DSK:, you can assemble it with:

.R PAL8
*EDU20C<EDU20C  (or, *EDU20C,EDU20C<EDU20C if you want to make your own *.LS listing file)


.



Running Edu20C BASIC from OS/8
------------------------------

After assembling, you can turn EDU20C.BN into an OS/8 *.SV file on SYS: with:

.LOAD EDU20C=12000

.SAVE SYS:EDU20C

Or, if you prefer, you can do an immediate load-and-go with:

.LOAD EDU20C/G=12000

Note that Edu20C overwrites OS/8 resident run-time memory. When you are done running Edu20C you need to do a full, cold reboot to get back to OS/8.



Loading and running Edu20c natively
-----------------------------------

Edu20C Basic is intended to be run stand-alone. The file "edu20c.rm.pt" is mostly a BIN format tape but it has a RIM format self-starting BIN loader on the front end. You don't need BIN loader to load this tape. All you need is RIM. Loading Edu20C will use the exact same process you would use to load BIN loader:

*) Set up the Edu20c tape in your reader
*) Make sure the right RIM loader (lo- or hi- speed) is toggled in
*) Load address 7756
*) Clear, Continue


RIM loader will start by reading in the self-starting BIN loader and then automatically jump to the BIN loader when it is loaded. Then BIN loader will read in the BIN image of Edu20C. Assuming no checksum error while reading Edu20C, BIN loader will automatically start Edu20C. You should then see the opening dialog:


EDUSYSTEM 20  BASIC

NUMBER OF USERS (1 TO 8)?1                 <-- you can answer more if you have
ANY UNUSED TERMINALS (Y OR N)?N            <-- y or n as appropriate
DO YOU HAVE A HIGH SPEED PUNCH (Y OR N)?Y  <-- y or n as appropriate
DO YOU HAVE A HIGH SPEED READER (Y OR N)?Y <-- y or n as appropriate
IS THE ABOVE CORRECT (Y OR N)?Y            <-- if you say n, it asks all again

END OF DIALOGUE

READY          <-- you are now live, running Edu20C Basic


Unfortunately, the self-starting BIN loader overwrites RIM loader memory address 07774 with 5200. You don't have to completely reload RIM loader, but you do need to deposit 3376 back into 07774 for RIM loader to work properly again.



Configuring a PiDP-8/I boot script
----------------------------------

The file 6.script is a PiDP-8/i boot script that allows booting into Edu20C as one of the 7 available switch register boot configurations. For example, I never use the as-supplied ETOS system (boot configuration 6) so I use that for Edu20C. A couple of steps are necessary to set this up.

1) in the RPi OS directory /opt/pidp8i/share/boot, you may want to rename the original file named 6.script to something else to keep it as a back-up in case you want to go back to it later.

2) copy this 6.script file into the RPi OS directory /opt/pidp8i/share/boot

3) copy the file edu20c.rm.pt into the RPi OS directory /opt/pidp8i/share/media/os8

From now on, booting the PiDP-8/I with 6 in the Inst Field switches will bring up Edu20C.


