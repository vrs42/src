Here are a couple of programs from Jay.  One compares a pair of LINCtape,
and the other sends and receives LINCtape images using XMODEM protocol.

email.txt	The email to the CCTALK mailing list with the source code.
cmptap.l4l	The extracted LAP4 listing of the CMPTAP program.
xmtape.l4l	The extracted LAP4 listing of the XMTAPE program.

cm.*		The CMPTAP program, as extracted from column 3 of the listing.
xm.*		The XMTAPE program, as extracted from column 3 of the listing.
cmptap.*	The CMPTAP program, convverted to PAL by me (VRS).
xmtape.*	The XMTAPE program, convverted to PAL by me (VRS).
Makefile	A Makefile to reassemble the PAL if it changes.

There's a known "issue" with XMTAPE at WDFLASH where the entry point is
missing and the "CLA CLL" is clobbered with the return address.  This
ends up not mattering, as WDFLSH is always called with AC clear already
and doesn't care about LINK being clear.  As it happens, the AC is also
clear on return from WDFLSH, so the "CLA CLL" there also seems redundant.

My reading of the manuals on bitsavers suggests that even LAP6 used a
syntax resembling PAL, so hopefully this is of use.

You can find the cross assembler being used in the pdp8/8tools directory.
Also there are the "bincmp" and "binview" tools I used to reassure myself
that my translation is generating the same binary as would have been output
from the LAP4 assembler.

The cm.* and xm.* files lack the page zero literals, as they are only found
implicitly in the LAP4 listings.  (That is, not in column three.)

	Vince
