<?php
  $title = "$DIR Software Files";
  include $_SERVER{'DOCUMENT_ROOT'}.'/pdp8/header.php';
?>
<BODY><FONT size=4>
<P>
This is an archive of the DEC software titles.  DECUS software titles
can be found <a href=/pdp8/software/decus.php>here</a>.
<P>
If this is your first visit to this page, you may want to expand some of
these topics:
<details><summary>Part Numbering</summary>
<P>
Since the files are organized by DEC part number, a
word about part numbers is probably in order.  A DEC part number
might look like any of these:
<pre>
        dec-812-pb
        dec-08-d01a-pb
        dec-08-d01a-b-pb
        ac-6527d-ma
</pre>
depending on the vintage of the title in question.
<P>
The earlier part numbers are the ones which folks are generally familiar with.
These try to encode the name of function of the program into the part number,
with an implicit assumption that the part number identifies a single manual or
chunk of sofware with a known function.
<P>
Later on, software began to look different from this model.  OS/8, for
instance, encompasses a lot of bits and pieces of diverse function.  The
practice of listing in a handbook somewhere the bits and pieces you needed
became cumbersome.
<P>
The later part numbering scheme, which almost no-one remembers how to use
properly, is structured in two layers.  The bottom layer has a part number
like "ac-6527d-ma", which identifies an artifact, more or less, by how to
find it in a warehouse.  (The "ac" identifies it as a document, "6527" says
which one, "d" is a revision code, and "ma" specifies the license and CPU.)
<P>
Layered on top of these part numbers, was a code that identified a product
that could be ordered.  Thus "qf008" would get you FORTRAN IV, etc.)  The
lower level part numbers are merely cited again in every software product
that needed them.
<P>
What's been done here, is to organize the DEC software part numbers into
directories based on the program being addressed, using the newer software
product code only if an old-style part number is not available.  For example,
directory "dec-08-cdd" contains files for all part numbers associated with
any version of DDT-8.
<P>
The directory names generally are the names of the dec part number, with
the version letter removed.  These start with "dec-", "maindec-", or "qf".
(Clicking on the link for a directory name will take you to that directory
in the repository.)
<P>
In general, the older format media codes which trail the part number have
also been used (to make the software to maintain this list a little simpler).
So, that "-ma" suffix in "ac-6527d-ma" should *not* be included in your
search.  (A search for part number ""ac-6527d" will find the file for 
maindec-08-dikla-d-d, as it should.)
<P>
The part numbers here have been mostly taken (and corrected where necessary)
from these documents:
<DL>
<DD><a href=../AV-0872E-TA_PDP-8_Software_Components_Catalog_Jul79.pdf>
    PDP-8 Software Components Catalog Jul79</a>
<DD><a href=dec-08-ba1/dec-08-ba1c-d.pdf>
    PDP-8 8S 8I 8L System Program Index</a>
<DD><a href=dec-08-xspla/dec-08-xspla-d-d.pdf>
    PDP-8 Software Price List Nov73</a>
<DD><a href=maindec-08-diqac/maindec-08-diqac-e-d.pdf>
    PDP-08 Maindec Index</a>
<DD><a href=dec-12-bw1/dec-12-bw1j-d.pdf>
    PDP-12 Software Packages and Services Jun72</a>
<DD><a href=dec-12-xspla/dec-12-xspla-c-d.pdf>
    PDP-12 Software Components Catalog Apr76</a>
<DD>0255 index 81-05
<DD>8 deco depo diagchanges
<DD>diag index
</DL>
</details>
<details><summary>File Formats</summary>
<P>
In general, old-school part numbering is used, and an old-school suffix is
often used instead of the (now useless) licensing suffix.  Most of these
suffixes specify a media type, possibly a file format, then possibly a
sequence number if there is more than one such item needed.  For example, 
"-pm1" signifies that it's a paper tape image, in RIM format, and that it
is the first of two or more such tapes (or tape segments).
<P>
For Media types,
<table>
<tr><td>a</td><td>LINCtape</td></tr>
<tr><td>c</td><td>Card Deck</td></tr>
<tr><td>d</td><td>Document</td></tr>
<tr><td>f</td><td>Fiche</td></tr>
<tr><td>h</td><td>DECpack (RK05/RL01)</td></tr>
<tr><td>l</td><td>Listing</td></tr>
<tr><td>m</td><td>Magtape</td></tr>
<tr><td>p</td><td>Paper tape</td></tr>
<tr><td>t</td><td>Cassette tape</td></tr>
<tr><td>u</td><td>DECtape</td></tr>
<tr><td>y</td><td>Floppy</td></tr>
<table>
<P>
For file formats,
<table>
<tr><td>a</td><td>ASCII</td></tr>
<tr><td>b</td><td>Binary (BIN for Papertape)</td></tr>
<tr><td>c</td><td>ASCII and Binary, mixed</td></tr>
<tr><td>l</td><td>Load Module</td></tr>
<tr><td>m</td><td>RIM</td></tr>
<tr><td>n</td><td>Change Notice</td></tr>
<tr><td>o</td><td>LINCtape (Bootstrap for Papertape)</td></tr>
<tr><td>r</td><td>Relocatable</td></tr>
<tr><td>s</td><td>save format (EPIC)</td></tr>
<tr><td>t</td><td>no format (Diagnostic for DECtape)</td></tr>
</table>
<P>
Yes, I know that LINCtapes are sometimes considered oddly formatted DECtape,
and sometimes as a media type of their own.
</details>
<details><summary>Credits</summary>
<P>
In addition to my own collection of media, *many* other collectors have
contributed to what is presented here.  In most cases, I have shamelessly
duplicated their stuff, in an attempt to be as complete a resource as I 
can manage.
<P>
Here is a partial list of resources I have mined, in no particular order:
<DL>
<DD><a href=www.bitsavers.org>www.bitsavers.org</a>
<DD><a href=ftp.dbit.com>ftp.dbit.com</a>
<DD><a href=www.ibiblio.org>www.ibiblio.org</a>
<DD><a href=ftp.update.uu.se>ftp.update.uu.se</a>
<DD><a href=pdp12.org>pdp12.org</a>
<DD><a href=pdp8.hachti.de>pdp8.hachti.de</a>
<DD><a href=pdp8.org>pdp8.org</a>
<DD><a href=www.pdp8.net>www.pdp8.net</a>
<DD><a href=www.pdp8online.net>www.pdp8online.net</a>
<DD><a href=www.vandermark.ch>www.vandermark.ch</a>
</DL>
<P>
My thanks to these folks and others, for making this material available!
</details>
<P>
<P>
If a filename is a link, the file is currently available here by clicking
that link..  Otherwise, the file is still named, but not clickable.
(If it's not named here, it's either not listed in any of the software
catalogs above, or it has a media type I haven't decided how to deal with
yet.  It is also possible that it's something that should be in the list,
but isn't.  There's a little link in the page footer you can use to
send me mail about that.)
<P>
This is a big list, so you'll probably want to use "search in page".  Here 
are some navigation shortcuts as well:
<div style=padding-left:23px>
<a href=#dec-00>dec-00</a>
<a href=#dec-08>dec-08</a>
<a href=#dec-12>dec-12</a>
<a href=#dec-14>dec-14</a>
<a href=#dec-16>dec-16</a>
<a href=#dec-8e>dec-8e</a>
<a href=#dec-8i>dec-8i</a>
<a href=#dec-8l>dec-8l</a>
<a href=#dec-cp>dec-cp</a>
<a href=#dec-cr>dec-cr</a>
<a href=#dec-d8>dec-d8</a>
<a href=#dec-e8>dec-e8</a>
<a href=#dec-fs>dec-fs</a>
<a href=#dec-in>dec-in</a>
<a href=#dec-l8>dec-l8</a>
<a href=#dec-lb>dec-lb</a>
<a href=#dec-p8>dec-p8</a>
<a href=#dec-s8>dec-s8</a>
<a href=#dec-t8>dec-t8</a>
<a href=#maindec-00>maindec-00</a>
<a href=#maindec-08>maindec-08</a>
<a href=#maindec-12>maindec-12</a>
<a href=#maindec-14>maindec-14</a>
<a href=#maindec-89>maindec-89</a>
<a href=#maindec-8e>maindec-8e</a>
<a href=#maindec-8i>maindec-8i</a>
<a href=#maindec-8l>maindec-8l</a>
<a href=#maindec-8s>maindec-8s</a>
<a href=#maindec-t8>maindec-t8</a>
<a href=#maindec-x8>maindec-x8</a>
<a href=#maindec-801>maindec-8xx</a>
<a href=#digital-5>digital</a>
<a href=#qf>qf</a>
</div><br>
<div style='overflow-y: auto; height:75%; border:thick green ridge'>
<table width=100% border=1>
<tr>
<td>8KBAA Memory Exerciser Program<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/a-08-dhmba>a-08-dhmba</a></td>
<td><table>
<a name='a-08'></a>
<tr><td>a-08-dhmba-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>2223 8K11C Memory Exerciser Program<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/a-08-dhmca>a-08-dhmca</a></td>
<td><table>
<tr><td>a-08-dhmca-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>2223 8K8EJ Memory Exerciser Program<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/a-08-dhmga>a-08-dhmga</a></td>
<td><table>
<tr><td>a-08-dhmga-c-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>2223 MS8AA Memory Exerciser Program<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/a-08-dhmsa>a-08-dhmsa</a></td>
<td><table>
<tr><td>a-08-dhmsa-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>2223 Stack Exerciser for H217/H224<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/a-08-dhsec>a-08-dhsec</a></td>
<td><table>
<tr><td>a-08-dhsec-d-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>2223 Stack Exerciser for H221/H222<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/a-08-dhsed>a-08-dhsed</a></td>
<td><table>
<tr><td>a-08-dhsed-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>2223 Stack Exerciser for H219<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/a-08-dhsee>a-08-dhsee</a></td>
<td><table>
<tr><td>a-08-dhsee-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>ICS8 System Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/a-08-qhica>a-08-qhica</a></td>
<td><table>
<tr><td>a-08-qhica-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>ICS8 File Box Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/a-08-qhicb>a-08-qhicb</a></td>
<td><table>
<tr><td>a-08-qhicb-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>LA36 Power Supply Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/a-08-qhlaa>a-08-qhlaa</a></td>
<td><table>
<tr><td>a-08-qhlaa-g-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Classifying and Documenting<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-bzz>dec-00-bzz</a></td>
<td><table>
<a name='dec-00'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-bzz/dec-00-bzzd-d.pdf>dec-00-bzzd-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>VT05 Alphanumeric Display Terminal Reference<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-h4a>dec-00-h4a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-h4a/dec-00-h4ac-d.pdf>dec-00-h4ac-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>VT05 Alphanumeric Display Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-h4b>dec-00-h4b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-h4b/dec-00-h4bd-d.pdf>dec-00-h4bd-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>861-A,B,C Power Controller Maintenance<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-h861a>dec-00-h861a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-h861a/dec-00-h861a-a-d.pdf>dec-00-h861a-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RK8 Disk System Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hrk>dec-00-hrk</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hrk/dec-00-hrkb-d.pdf>dec-00-hrkb-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RK05 Disk Drive Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hrk05>dec-00-hrk05</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hrk05/dec-00-hrk05-c-d.pdf>dec-00-hrk05-c-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RS64 Disk File Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hrs64>dec-00-hrs64</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hrs64/dec-00-hrs64-e-d.pdf>dec-00-hrs64-e-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TU56 DECtape Transport Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hrt>dec-00-hrt</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hrt/dec-00-hrtc-d.pdf>dec-00-hrtc-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RT02-A 30 Character Remote Terminal Maintenance<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hrt2a>dec-00-hrt2a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hrt2a/dec-00-hrt2a-c-d.pdf>dec-00-hrt2a-c-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Technicians Handbook<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hthaa>dec-00-hthaa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hthaa/dec-00-hthaa-a-d.pdf>dec-00-hthaa-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TU60 DECassette Transport Maintenance<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-htu60>dec-00-htu60</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-htu60/dec-00-htu60-c-d.pdf>dec-00-htu60-c-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RK05 Exerciser Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hzrka>dec-00-hzrka</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hzrka/dec-00-hzrka-a-d.pdf>dec-00-hzrka-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TU55 Instruction Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hzt>dec-00-hzt</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-hzt/dec-00-hzta-d.pdf>dec-00-hzta-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TU20 Tape Transport Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-i4a>dec-00-i4a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-i4a/dec-00-i4ab-d.pdf>dec-00-i4ab-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AD08-A A-D Converter Instruction Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-i6a>dec-00-i6a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-i6a/dec-00-i6aa-d.pdf>dec-00-i6aa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PC04/PC05 Paper Tape Reader/Punch Maintenance<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-pc0>dec-00-pc0</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-pc0/dec-00-pc0a-d.pdf>dec-00-pc0a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TU10 DECmagtape Master System Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-tu10>dec-00-tu10</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-00-tu10/dec-00-tu10m-d.pdf>dec-00-tu10m-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Typeset-8 Maintenance Manual (Negative Logic)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-17t>dec-08-17t</a></td>
<td><table>
<a name='dec-08'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-17t/dec-08-17ta-d.pdf>dec-08-17ta-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>8K Fortran Compiler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2b1>dec-08-a2b1</a></td>
<td><table>
<tr><td>dec-08-a2b1-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2b1/dec-08-a2b1-pb>dec-08-a2b1-pb</td><td></a></td></tr>
<tr><td>dec-08-a2b1-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>8 to 32K Linking Loader<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2b3>dec-08-a2b3</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2b3/dec-08-a2b3-pb>dec-08-a2b3-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>8K Fortran Library Subroutines 1/2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2b4>dec-08-a2b4</a></td>
<td><table>
<tr><td>dec-08-a2b4-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2b4/dec-08-a2b4-pr>dec-08-a2b4-pr</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>8K Fortran Library Subroutines 2/2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2b5>dec-08-a2b5</a></td>
<td><table>
<tr><td>dec-08-a2b5-la</td><td></td></tr>
<tr><td>dec-08-a2b5-pa</td><td></td></tr>
<tr><td>dec-08-a2b5-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2b5/dec-08-a2b5-pr>dec-08-a2b5-pr</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>8K Fortran Library Dectape I/O<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2b6>dec-08-a2b6</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2b6/dec-08-a2b6-pr>dec-08-a2b6-pr</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>8K SABR Assembler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2c2>dec-08-a2c2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2c2/dec-08-a2c2-pb>dec-08-a2c2-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>8K-32K Linking Loader (PT Version)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2c3>dec-08-a2c3</a></td>
<td><table>
<tr><td>dec-08-a2c3-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2c3/dec-08-a2c3-pb>dec-08-a2c3-pb</td><td></a></td></tr>
<tr><td>dec-08-a2c3-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>8K-32K Linking Loader (Disk Version)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2c7>dec-08-a2c7</a></td>
<td><table>
<tr><td>dec-08-a2c7-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>8k SABR Assembler (V16)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2d2>dec-08-a2d2</a></td>
<td><table>
<tr><td>dec-08-a2d2-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-a2d2/dec-08-a2d2-pb>dec-08-a2d2-pb</td><td></a></td></tr>
<tr><td>dec-08-a2d2-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>Fortran Symbol Print<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-afa2>dec-08-afa2</a></td>
<td><table>
<tr><td>dec-08-afa2-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-afa2/dec-08-afa2-pb>dec-08-afa2-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Fortran Symbol Print<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-afb4>dec-08-afb4</a></td>
<td><table>
<tr><td>dec-08-afb4-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>4K FORTRAN Programmers Reference Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-afc>dec-08-afc</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-afc/dec-08-afco-d.pdf>dec-08-afco-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Fortran Compiler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-afc1>dec-08-afc1</a></td>
<td><table>
<tr><td>dec-08-afc1-la</td><td></td></tr>
<tr><td>dec-08-afc1-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-afc1/dec-08-afc1-pb>dec-08-afc1-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Fortran Operating System<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-afc3>dec-08-afc3</a></td>
<td><table>
<tr><td>dec-08-afc3-la</td><td></td></tr>
<tr><td>dec-08-afc3-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-afc3/dec-08-afc3-pb>dec-08-afc3-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>4K Fortran Document<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-afd>dec-08-afd</a></td>
<td><table>
<tr><td>dec-08-afdo-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>Utility Overlays for Focal 1969 (4 word, 8K)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-aj1>dec-08-aj1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-aj1/dec-08-aj1e-pb>dec-08-aj1e-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>CLINE Overlay for Focal 1969<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-aj3>dec-08-aj3</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-aj3/dec-08-aj3e-pb>dec-08-aj3e-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DF32 LIBRA Overlay for Focal 1969<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-aj5>dec-08-aj5</a></td>
<td><table>
<tr><td>dec-08-aj5e-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-aj5/dec-08-aj5e-pb>dec-08-aj5e-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RF08 LIBRA Overlay for Focal 1969<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-aj6>dec-08-aj6</a></td>
<td><table>
<tr><td>dec-08-aj6e-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-aj6/dec-08-aj6e-pb>dec-08-aj6e-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Focal 8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-aja>dec-08-aja</a></td>
<td><table>
<tr><td>dec-08-ajae-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-aja/dec-08-ajae-pb>dec-08-ajae-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-aja/dec-08-ajad-d.pdf>dec-08-ajad-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-aja/dec-08-ajab-d.pdf>dec-08-ajab-d</td><td> (1968)</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-aja/dec-08-ajab-pb>dec-08-ajab-pb</td><td> (1968)</a></td></tr>
</table></td></tr>
<tr>
<td>Advanced FOCAL Technical Specifications<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ajb>dec-08-ajb</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ajb/dec-08-ajbb-d.pdf>dec-08-ajbb-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PAL III Symbolic Assembler Programming Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-asa>dec-08-asa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-asa/dec-08-asac-d.pdf>dec-08-asac-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-asa/dec-08-asab-d.pdf>dec-08-asab-d</td><td>PAL D Disk Assembler Programming Manual</a></td></tr>
</table></td></tr>
<tr>
<td>PAL III Assembler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-asb1>dec-08-asb1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-asb1/dec-08-asb1-pb>dec-08-asb1-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8, 8S, 8I, 8L System Programs Index<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ba1>dec-08-ba1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ba1/dec-08-ba1c-d.pdf>dec-08-ba1c-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DDT-8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-cdd>dec-08-cdd</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-cdd/dec-08-cdda-d.pdf>aa-0416a / dec-08-cdda-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-cdd/dec-08-cdda-pb>ak-0417b / dec-08-cdda-pb</td><td></a></td></tr>
<tr><td>ak-0416b / dec-08-cddb-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-cdd/dec-08-cddb-d.pdf>aa-0417b / dec-08-cddb-d</td><td></a></td></tr>
<tr><td>af-0417b / dec-08-cddb-dn</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-cdd/dec-08-cddb-pb>ak-0417b / dec-08-cddb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MACRO-8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-cma>dec-08-cma</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-cma/dec-08-cmab-d.pdf>dec-08-cmab-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-cma/dec-08-cmaa-d.pdf>dec-08-cmaa-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-cma/dec-08-cmaa-pb>dec-08-cmaa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>ODT-8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-coc>dec-08-coc</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-coc/dec-08-coco-d.pdf>dec-08-coco-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>ODT-8 (LOW)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-coc1>dec-08-coc1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-coc1/dec-08-coc1-pa>ak-0418a / dec-08-coc1-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-coc1/dec-08-coc1-d.pdf>aa-0419a / dec-08-coc1-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-coc1/dec-08-coc1-pb>ak-0419a / dec-08-coc1-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>ODT-8 (HIGH)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-coc2>dec-08-coc2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-coc2/dec-08-coc2-pa>ak-0420a / dec-08-coc2-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-coc2/dec-08-coc2-d.pdf>aa-0421a / dec-08-coc2-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-coc2/dec-08-coc2-pb>ak-0421a / dec-08-coc2-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>High Speed Reader/Punch Tests<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-d2g>dec-08-d2g</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-d2g/dec-08-d2ge-pb>dec-08-d2ge-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DF32/DF32D Disc Data Mini Disk, Interface Address, Data Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-d5c>dec-08-d5c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-d5c/dec-08-d5cc-pb>dec-08-d5cc-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DF32 Multi Disc Exerciser for Master and Slave Units<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-d5d>dec-08-d5d</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-d5d/dec-08-d5db-pb>dec-08-d5db-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DP01A Bit Synchronous IOT and Data Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-d8f>dec-08-d8f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-d8f/dec-08-d8fa-pb>dec-08-d8fa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 5 Functions<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-e05fa>dec-08-e05fa</a></td>
<td><table>
<tr><td>dec-08-e05fa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 10 Self Starting<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-e10fa>dec-08-e10fa</a></td>
<td><table>
<tr><td>dec-08-e10fa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 20 Configuration<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-e20cb>dec-08-e20cb</a></td>
<td><table>
<tr><td>dec-08-e20cb-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>EDUSystem 50 Users Guide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-e50ua>dec-08-e50ua</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-e50ua/dec-08-e50ua-a-d.pdf>dec-08-e50ua-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>BASIC Demo Source Floppy<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ecdaa>dec-08-ecdaa</a></td>
<td><table>
<tr><td>as-0439a / dec-08-ecdaa-a-ya</td><td></td></tr>
</table></td></tr>
<tr>
<td>CLASSIC OS/S FORTRAN Comb. Mode Floppy<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ecfsa>dec-08-ecfsa</a></td>
<td><table>
<tr><td>as-0440a / dec-08-ecfsa-a-yc</td><td></td></tr>
</table></td></tr>
<tr>
<td>CLASSIC INSTALLATION & MAINT GUIDE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ecima>dec-08-ecima</a></td>
<td><table>
<tr><td>aa-0442b / dec-08-ecima-b-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>CL8 Maintenance Guide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-eclma>dec-08-eclma</a></td>
<td><table>
<tr><td>dec-08-eclma-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CLASSIC OS/S BASIC Comb. Mode Floppy<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ecosa>dec-08-ecosa</a></td>
<td><table>
<tr><td>as-0444a / dec-08-ecosa-a-yc</td><td></td></tr>
</table></td></tr>
<tr>
<td>CLASSIC PRIMER, A SELF TEACHING GUIDE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ecpga>dec-08-ecpga</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ecpga/dec-08-ecpga-b-d.pdf>aa-0447b / dec-08-ecpga-b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>CLASSIC USERS REFERENCE GUIDE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ecuga>dec-08-ecuga</a></td>
<td><table>
<tr><td>aa-0449b / dec-08-ecuga-b-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 5<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ed05a>dec-08-ed05a</a></td>
<td><table>
<tr><td>dec-08-ed05a-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 10<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ed10>dec-08-ed10</a></td>
<td><table>
<tr><td>dec-08-ed10-a-la</td><td></td></tr>
<tr><td>dec-08-ed10-a-pb</td><td></td></tr>
<tr><td>dec-08-ed10-a-uc</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 15<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ed15a>dec-08-ed15a</a></td>
<td><table>
<tr><td>dec-08-ed15a-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 20<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ed20b>dec-08-ed20b</a></td>
<td><table>
<tr><td>dec-08-ed20b-a-la</td><td></td></tr>
<tr><td>dec-08-ed20b-a-pb</td><td></td></tr>
<tr><td>dec-08-ed20b-a-uc</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 25<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ed25a>dec-08-ed25a</a></td>
<td><table>
<tr><td>dec-08-ed25a-a-la</td><td></td></tr>
<tr><td>dec-08-ed25a-a-uc</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 30<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ed30a>dec-08-ed30a</a></td>
<td><table>
<tr><td>dec-08-ed30a-a-la</td><td></td></tr>
<tr><td>dec-08-ed30a-a-pb</td><td></td></tr>
<tr><td>dec-08-ed30a-a-uc</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 40<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ed40a>dec-08-ed40a</a></td>
<td><table>
<tr><td>dec-08-ed40a-a-la</td><td></td></tr>
<tr><td>dec-08-ed40a-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 40<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ed40b>dec-08-ed40b</a></td>
<td><table>
<tr><td>dec-08-ed40b-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusysten Handbook<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-edhba>dec-08-edhba</a></td>
<td><table>
<tr><td>dec-08-edhba-a-dn1</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 PROGRAMMING MANUAL<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-eprga>dec-08-eprga</a></td>
<td><table>
<tr><td>aa-0586a / dec-08-eprga-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>EDITOR<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-esa>dec-08-esa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-esa/dec-08-esab-d.pdf>aa-0590b / dec-08-esab-d</td><td></a></td></tr>
<tr><td>ab-0588c / dec-08-esac-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-esa/dec-08-esac-pa>ak-0590c / dec-08-esac-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-esa/dec-08-esac-pb>ak-0589c / dec-08-esac-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Symbolic Tape Editor<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-esa2>dec-08-esa2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-esa2/dec-08-esa2-pb>dec-08-esa2-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>EduTest<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-etsta>dec-08-etsta</a></td>
<td><table>
<tr><td>dec-08-etsta-a-pa</td><td></td></tr>
<tr><td>dec-08-etsta-a-pa1</td><td></td></tr>
<tr><td>dec-08-etsta-a-pa2</td><td></td></tr>
<tr><td>dec-08-etsta-a-pa3</td><td></td></tr>
<tr><td>dec-08-etsta-a-pa4</td><td></td></tr>
<tr><td>dec-08-etsta-a-pa5</td><td></td></tr>
<tr><td>dec-08-etsta-a-pa6</td><td></td></tr>
</table></td></tr>
<tr>
<td>TC01-TU55 DECtape Formatter (beware TC01-TT-4)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-euf>dec-08-euf</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-euf/dec-08-eufb-d.pdf>dec-08-eufb-d</td><td></a></td></tr>
<tr><td>dec-08-eufb-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-euf/dec-08-eufb-pb>dec-08-eufb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Program Library Math Routines<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ffa>dec-08-ffa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ffa/dec-08-ffad-d.pdf>dec-08-ffad-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ffa/dec-08-ffaa-d.pdf>dec-08-ffaa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Single Precision Square Root Routine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fma>dec-08-fma</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fma/dec-08-fmaa-pa>dec-08-fmaa-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Single Precision Signed Multiply<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmb>dec-08-fmb</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmb/dec-08-fmba-pa>dec-08-fmba-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Single Precision Signed Divide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmc>dec-08-fmc</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmc/dec-08-fmca-pa>dec-08-fmca-pa</td><td></a></td></tr>
<tr><td>dec-08-fmcb-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Double Precision Signed Multiply<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmd>dec-08-fmd</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmd/dec-08-fmda-pa>dec-08-fmda-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Double Precision Signed Divide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fme>dec-08-fme</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fme/dec-08-fmea-pa>dec-08-fmea-pa</td><td></a></td></tr>
<tr><td>dec-08-fmeb-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Double Precision Sine Routine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmf>dec-08-fmf</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmf/dec-08-fmfb-pa>dec-08-fmfb-pa</td><td></a></td></tr>
<tr><td>dec-08-fmfc-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Double Precision Cosine Routine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmg>dec-08-fmg</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmg/dec-08-fmgb-pa>dec-08-fmgb-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Four-word Floating Point Package<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmh>dec-08-fmh</a></td>
<td><table>
<tr><td>dec-08-fmhc-la</td><td></td></tr>
<tr><td>dec-08-fmhc-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmh/dec-08-fmha-pb>dec-08-fmha-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Logical Subroutines<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmi>dec-08-fmi</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmi/dec-08-fmia-pa>dec-08-fmia-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Arithmetic Shift Subroutines<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmj>dec-08-fmj</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmj/dec-08-fmja-pa>dec-08-fmja-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Logical Shift Subroutines<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmk>dec-08-fmk</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-fmk/dec-08-fmka-pa>dec-08-fmka-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>338 Programmed Display Programming Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-g61>dec-08-g61</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-g61/dec-08-g61d-d.pdf>dec-08-g61d-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-g61/dec-08-g61b-d.pdf>dec-08-g61b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TC08 DECtape Controller Maintenc Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-h3d>dec-08-h3d</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-h3d/dec-08-h3da-d.pdf>dec-08-h3da-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AX08 Laboratory Peripheral Instruction Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-h6b>dec-08-h6b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-h6b/dec-08-h6ba-d.pdf>dec-08-h6ba-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>GLC-8 Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-h8c>dec-08-h8c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-h8c/dec-08-h8ca-d.pdf>dec-08-h8ca-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Typeset-8 Photon 513/560 Display Ad Program<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-h8q>dec-08-h8q</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-h8q/dec-08-h8qa-d.pdf>dec-08-h8qa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RF08 Disk Control and RS08 Disk Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-hie>dec-08-hie</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-hie/dec-08-hiea-d.pdf>dec-08-hiea-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Typeset-8 Systems Maintenance (Positive Logic)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-hmmpa>dec-08-hmmpa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-hmmpa/dec-08-hmmpa-a-d.pdf>dec-08-hmmpa-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RK8 Disk System Maintenance Manual, Volume 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-hrk>dec-08-hrk</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-hrk/dec-08-hrka-d.pdf>dec-08-hrka-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LP08 Line Printer Interface Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-hrl>dec-08-hrl</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-hrl/dec-08-hrla-d.pdf>dec-08-hrla-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TC01 DECtape Control Unit Instruction Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-i2a>dec-08-i2a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-i2a/dec-08-i2ab-d.pdf>dec-08-i2ab-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TC01 DECtape Control Unit Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-i3a>dec-08-i3a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-i3a/dec-08-i3ab-d.pdf>dec-08-i3ab-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RM08 Serial Drum System Instruction Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-i5a>dec-08-i5a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-i5a/dec-08-i5aa-d.pdf>dec-08-i5aa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>34D Oscilloscope Display Control Instruction Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-i6a>dec-08-i6a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-i6a/dec-08-i6aa-d.pdf>dec-08-i6aa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DM01 Data Multiplexer Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-i8a>dec-08-i8a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-i8a/dec-08-i8aa-d.pdf>dec-08-i8aa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DP01A Data Communications Instruction Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-i8b>dec-08-i8b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-i8b/dec-08-i8ba-d.pdf>dec-08-i8ba-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>4K PAL III<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-las4a>dec-08-las4a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-las4a/dec-08-las4a-a-d.pdf>aa-0614a / dec-08-las4a-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PAL 8 ASSEMBLER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-las8a>dec-08-las8a</a></td>
<td><table>
<tr><td>aa-0615a / dec-08-las8a-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>BIN LOADER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lba>dec-08-lba</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lba/dec-08-lbaa-pa>ak-0616a / dec-08-lbaa-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lba/dec-08-lbaa-pm>ak-0617a / dec-08-lbaa-pm</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lba/dec-08-lbaa-d.pdf>aa-0618a / dec-08-lbaa-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lba/dec-08-lbab-d.pdf>aa-0618b / dec-08-lbab-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>8K BASIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lbasa>dec-08-lbasa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lbasa/dec-08-lbasa-a-la.pdf>ab-0619a / dec-08-lbasa-a-la</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lbasa/dec-08-lbasa-a-pb>ak-0620a / dec-08-lbasa-a-pb</td><td></a></td></tr>
<tr><td>al-0621a / dec-08-lbasa-a-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>8K BASIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lbsma>dec-08-lbsma</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lbsma/dec-08-lbsma-a-d.pdf>aa-0622a / dec-08-lbsma-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FOCAL-8 8K OVERLAY<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lf8ka>dec-08-lf8ka</a></td>
<td><table>
<tr><td>ab-0623a / dec-08-lf8ka-a-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lf8ka/dec-08-lf8ka-a-pb>ak-0624a / dec-08-lf8ka-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Focal-8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lfcla>dec-08-lfcla</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lfcla/dec-08-lfcla-a-ua>al-0626a / dec-08-lfcla-a-ua</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FOCAL-8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lfl8a>dec-08-lfl8a</a></td>
<td><table>
<tr><td>aa-0627a / dec-08-lfl8a-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>FOCAL-8 FAMILY OF 8 OVERLAYS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lfoca>dec-08-lfoca</a></td>
<td><table>
<tr><td>ab-0628a / dec-08-lfoca-a-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lfoca/dec-08-lfoca-a-pb>ak-0629a / dec-08-lfoca-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FOCAL-8 REMOVE/REPLACE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lfrra>dec-08-lfrra</a></td>
<td><table>
<tr><td>ab-0630a / dec-08-lfrra-a-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lfrra/dec-08-lfrra-a-la1.pdf>ab-0630a / dec-08-lfrra-a-la1</td><td>FOCAL-8 REPLACE</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lfrra/dec-08-lfrra-a-la2.pdf>ab-0630a / dec-08-lfrra-a-la2</td><td>FOCAL-8 REMOVE</a></td></tr>
<tr><td>ak-0631a / dec-08-lfrra-a-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lfrra/dec-08-lfrra-a-pb1>ak-0631a / dec-08-lfrra-a-pb1</td><td>FOCAL-8 REPLACE</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lfrra/dec-08-lfrra-a-pb2>ak-0631a / dec-08-lfrra-a-pb2</td><td>FOCAL-8 REMOVE</a></td></tr>
</table></td></tr>
<tr>
<td>FORTRAN/SABR<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lftna>dec-08-lftna</a></td>
<td><table>
<tr><td>aa-0632a / dec-08-lftna-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>HELP Loader<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lha>dec-08-lha</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lha/dec-08-lhaa-d.pdf>dec-08-lhaa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Help Bootstrap Loader<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lha1>dec-08-lha1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lha1/dec-08-lha1-pb>dec-08-lha1-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Help Bootstrap Generator<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lha2>dec-08-lha2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lha2/dec-08-lha2-pb>dec-08-lha2-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MACRO-8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lmaca>dec-08-lmaca</a></td>
<td><table>
<tr><td>ab-0637a / dec-08-lmaca-a-la</td><td></td></tr>
<tr><td>ak-0638a / dec-08-lmaca-a-pa1</td><td></td></tr>
<tr><td>ak-0639a / dec-08-lmaca-a-pa2</td><td></td></tr>
<tr><td>ak-0640a / dec-08-lmaca-a-pa3</td><td></td></tr>
<tr><td>dec-08-lmaca-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>4K PAL III<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lpala>dec-08-lpala</a></td>
<td><table>
<tr><td>ab-0642a / dec-08-lpala-a-la</td><td></td></tr>
<tr><td>ak-0643a / dec-08-lpala-a-pa1</td><td></td></tr>
<tr><td>ak-0644a / dec-08-lpala-a-pa2</td><td></td></tr>
<tr><td>ak-0645a / dec-08-lpala-a-pa3</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lpala/dec-08-lpala-a-pb>ak-0646a / dec-08-lpala-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PAL III and Macro-8 Source<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lpmsa>dec-08-lpmsa</a></td>
<td><table>
<tr><td>al-0647a / dec-08-lpmsa-a-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>FOCAL-8 QUAD OVERLAY DC02<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lqdca>dec-08-lqdca</a></td>
<td><table>
<tr><td>ab-0648a / dec-08-lqdca-a-la</td><td></td></tr>
<tr><td>ak-0649a / dec-08-lqdca-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>FOCAL-8 QUAD OVERLAY PT08<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lqpta>dec-08-lqpta</a></td>
<td><table>
<tr><td>ab-0650a / dec-08-lqpta-a-la</td><td></td></tr>
<tr><td>ak-0651a / dec-08-lqpta-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Read-In-Mode (RIM) Loader<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lra>dec-08-lra</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lra/dec-08-lraa-d.pdf>dec-08-lraa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RTPS FORTRAN IV System LINCtape<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lrtla>dec-08-lrtla</a></td>
<td><table>
<tr><td>dec-08-lrtla-a-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>RTPS FORTRAN IV Users Guide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lrtpa>dec-08-lrtpa</a></td>
<td><table>
<tr><td>dec-08-lrtpa-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>RTPS FORTRAN IV Library Reference Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lrtsa>dec-08-lrtsa</a></td>
<td><table>
<tr><td>dec-08-lrtsa-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>TC01 Bootstrap Loader<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lua>dec-08-lua</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-lua/dec-08-luaa-pm>dec-08-luaa-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PS/8 8K Programming System Users Guide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-mef>dec-08-mef</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-mef/dec-08-mefa-d.pdf>dec-08-mefa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/12 Software Support Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-mex>dec-08-mex</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-mex/dec-08-mexb-d.pdf>dec-08-mexb-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Application Notes (801, 802, 804)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-naa>dec-08-naa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-naa/dec-08-naaa-d.pdf>dec-08-naaa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 27 Bit Floating Point Package<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-nfpea>dec-08-nfpea</a></td>
<td><table>
<tr><td>dec-08-nfpea-a-d</td><td></td></tr>
<tr><td>dec-08-nfpea-a-la</td><td></td></tr>
<tr><td>dec-08-nfpea-a-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-nfpea/dec-08-nfpea-a-pb>dec-08-nfpea-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Floating Point Documentation<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-nfpia>dec-08-nfpia</a></td>
<td><table>
<tr><td>dec-08-nfpia-b-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 23 BIT FLOATING POINT PACKAGE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-nfppa>dec-08-nfppa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-nfppa/dec-08-nfppa-a-pb>ak-0685a / dec-08-nfppa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Family Paper Tape System Users Guide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ngc>dec-08-ngc</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ngc/dec-08-ngcc-d.pdf>dec-08-ngcc-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ngc/dec-08-ngcb-d.pdf>dec-08-ngcb-d</td><td>PDP-8 Family System Users Guide</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ngc/dec-08-ngca-d.pdf>dec-08-ngca-d</td><td>PDP-8 Console Manual</a></td></tr>
</table></td></tr>
<tr>
<td>COS 310/2780 Installation Notes<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ocina>dec-08-ocina</a></td>
<td><table>
<tr><td>aa-0687a / dec-08-ocina-a-d</td><td></td></tr>
<tr><td>ad-0687a / dec-08-ocina-a-dn1</td><td> Update</td></tr>
<tr><td>ad-0687a / dec-08-ocina-a-dn2</td><td> Update</td></tr>
</table></td></tr>
<tr>
<td>COS 300 System Reference Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ocosa>dec-08-ocosa</a></td>
<td><table>
<tr><td>dec-08-ocosa-g-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ocosa/dec-08-ocosa-f-d.pdf>dec-08-ocosa-f-d</td><td></a></td></tr>
<tr><td>dec-08-ocosa-e-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>COS 300 System Reference Card<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ocsca>dec-08-ocsca</a></td>
<td><table>
<tr><td>dec-08-ocsca-a-c</td><td></td></tr>
</table></td></tr>
<tr>
<td>COS 300 Introduction to DIBOL<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ocsta>dec-08-ocsta</a></td>
<td><table>
<tr><td>dec-08-ocsta-b-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>COS 300 Operating System<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-oddsa>dec-08-oddsa</a></td>
<td><table>
<tr><td>dec-08-oddsa-a-uc</td><td></td></tr>
</table></td></tr>
<tr>
<td>DDT-8 & ODT-8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-odp>dec-08-odp</a></td>
<td><table>
<tr><td>ab-0719a / dec-08-odpa-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>Disk System Monitor Programming Reference Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-odsma>dec-08-odsma</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-odsma/dec-08-odsma-a-d.pdf>dec-08-odsma-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 Loader<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-oloda>dec-08-oloda</a></td>
<td><table>
<tr><td>dec-08-oloda-a-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 PALD<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-opala>dec-08-opala</a></td>
<td><table>
<tr><td>dec-08-opala-a-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 PIP<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-opipa>dec-08-opipa</a></td>
<td><table>
<tr><td>dec-08-opipa-a-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>RTS/8 USERS MANUAL<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ortma>dec-08-ortma</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ortma/dec-08-ortma-c-d.pdf>aa-0724c / dec-08-ortma-c-d</td><td></a></td></tr>
<tr><td>aa-5158a / aa-5158a-dn</td><td>RTS/8 RELEASE NOTES</td></tr>
</table></td></tr>
<tr>
<td>RIM Punch (Low)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-pmp1>dec-08-pmp1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-pmp1/dec-08-pmp1-pa>dec-08-pmp1-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-pmp1/dec-08-pmp1-pb>dec-08-pmp1-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-pmp1/dec-08-pmp0-d.pdf>dec-08-pmp0-d</td><td>RIM Punch</a></td></tr>
</table></td></tr>
<tr>
<td>RIM Punch (high)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-pmp2>dec-08-pmp2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-pmp2/dec-08-pmp2-pb>ak-0780a / dec-08-pmp2-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-pmp2/dec-08-pmp2-pa>dec-08-pmp2-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-pmp2/dec-08-pmp0-d.pdf>dec-08-pmp0-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Disc System Builder<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-sba>dec-08-sba</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-sba/dec-08-sbab-d.pdf>dec-08-sbab-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PAMILA 50/8K<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-sp50a>dec-08-sp50a</a></td>
<td><table>
<tr><td>ab-0781a / dec-08-sp50a-a-la</td><td></td></tr>
<tr><td>ak-0782a / dec-08-sp50a-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PAMILA 51/16K<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-sp51>dec-08-sp51</a></td>
<td><table>
<tr><td>ak-0784a / dec-08-sp51a-pb</td><td></td></tr>
<tr><td>ab-0783a / dec-08-sp51a-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>PAMILA 55/8K<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-sp55a>dec-08-sp55a</a></td>
<td><table>
<tr><td>ab-0785a / dec-08-sp55a-a-la</td><td></td></tr>
<tr><td>ak-0786a / dec-08-sp55a-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PAMILA 55/16K<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-sp56a>dec-08-sp56a</a></td>
<td><table>
<tr><td>ab-0787a / dec-08-sp56a-a-la</td><td></td></tr>
<tr><td>ak-0788a / dec-08-sp56a-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PAMILA<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-spmma>dec-08-spmma</a></td>
<td><table>
<tr><td>aa-0789a / dec-08-spmma-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>PAMILA Source (DT)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-spmsa>dec-08-spmsa</a></td>
<td><table>
<tr><td>al-0790a / dec-08-spmsa-a-uc</td><td></td></tr>
</table></td></tr>
<tr>
<td>Dectape Subroutines<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-suc>dec-08-suc</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-suc/dec-08-suco-pa>dec-08-suco-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>COMSYST-8 CRSI CARD READER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-szc>dec-08-szc</a></td>
<td><table>
<tr><td>aa-0792a / dec-08-szca-d</td><td></td></tr>
<tr><td>ak-0794a / dec-08-szca-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>COMSYST-8 DC08F<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-szg>dec-08-szg</a></td>
<td><table>
<tr><td>aa-0795a / dec-08-szga-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>COMSYST-8 DP01A<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-szj>dec-08-szj</a></td>
<td><table>
<tr><td>aa-0798a / dec-08-szja-d</td><td></td></tr>
<tr><td>ak-0800a / dec-08-szja-pa1</td><td></td></tr>
<tr><td>ak-0801a / dec-08-szja-pa2</td><td></td></tr>
</table></td></tr>
<tr>
<td>COMSYST-8 LP08<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-szl>dec-08-szl</a></td>
<td><table>
<tr><td>aa-0802a / dec-08-szla-d</td><td></td></tr>
<tr><td>ak-0804a / dec-08-szla-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>COMSYST-8 CONSOLE TTY<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-szn>dec-08-szn</a></td>
<td><table>
<tr><td>aa-0805a / dec-08-szna-d</td><td></td></tr>
<tr><td>ak-0807a / dec-08-szna-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>COMSYST-8 2741 TYPE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-szq>dec-08-szq</a></td>
<td><table>
<tr><td>aa-0808a / dec-08-szqa-d</td><td></td></tr>
<tr><td>ak-0810a / dec-08-szqa-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>COMSYST-8 TELETYPE TAP<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-szu>dec-08-szu</a></td>
<td><table>
<tr><td>aa-0811a / dec-08-szua-d</td><td></td></tr>
<tr><td>ak-0813a / dec-08-szua-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>COMSYST-8 680-I SEQUENTIAL SCAN<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-szv>dec-08-szv</a></td>
<td><table>
<tr><td>aa-0814a / dec-08-szva-d</td><td></td></tr>
<tr><td>ak-0816a / dec-08-szva-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>COMSYST-8 680-I RANDOM SCAN<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-szw>dec-08-szw</a></td>
<td><table>
<tr><td>aa-0817a / dec-08-szwa-d</td><td></td></tr>
<tr><td>ak-0819a / dec-08-szwa-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>COMSYST-8 SYSTEM CONTROL PKG<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-szz>dec-08-szz</a></td>
<td><table>
<tr><td>aa-0820a / dec-08-szza-d</td><td></td></tr>
<tr><td>ak-0822a / dec-08-szza-pa1</td><td></td></tr>
<tr><td>ak-0823a / dec-08-szza-pa2</td><td></td></tr>
</table></td></tr>
<tr>
<td>TC01 DECTAPE FORMATTER (fixed TC01-TT-4)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-udtfa>dec-08-udtfa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-udtfa/dec-08-udtfa-a-d.pdf>aa-0824a / dec-08-udtfa-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-udtfa/dec-08-udtfa-a-pb>ak-0825a / dec-08-udtfa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MPS Microprocessor Series Users Handbook<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-umpha>dec-08-umpha</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-umpha/dec-08-umpha-a-d.pdf>dec-08-umpha-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>160AX Interface for PDP8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-usa0>dec-08-usa0</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-usa0/dec-08-usa0-pb>dec-08-usa0-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Single Parameter Height Analysis, AC Mode 160AX<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-usa1>dec-08-usa1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-usa1/dec-08-usa1-pb>dec-08-usa1-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Dual Parameter Height Analysis, AC Mode 160AX<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-usa2>dec-08-usa2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-usa2/dec-08-usa2-pb>dec-08-usa2-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>INDAC/8 Software Documentation, Support, Training<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-uwd>dec-08-uwd</a></td>
<td><table>
<tr><td>dec-08-uwda-gp</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8/I DIBOL Programming Self Instruction Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-wdr>dec-08-wdr</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-wdr/dec-08-wdra-d.pdf>dec-08-wdra-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Introduction to Programming<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-xinpa>dec-08-xinpa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-xinpa/dec-08-xinpa-a-d.pdf>aa-0839a / dec-08-xinpa-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Digital Software News Cumulative Index<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-xsmad>dec-08-xsmad</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-xsmad/dec-08-xsmad-a-d.pdf>dec-08-xsmad-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Diagnostic Software Components Catalog<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-xspla>dec-08-xspla</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-xspla/dec-08-xspla-h-d.pdf>dec-08-xspla-h-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-xspla/dec-08-xspla-d-d.pdf>dec-08-xspla-d-d</td><td>PDP-8 Software Price List</a></td></tr>
</table></td></tr>
<tr>
<td>Software Performance Summary LAB-8E and PDP-12<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-xspsc>dec-08-xspsc</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-xspsc/dec-08-xspsc-a-d.pdf>dec-08-xspsc-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Digital Software News<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-xspsg>dec-08-xspsg</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-xspsg/dec-08-xspsg-e-d.pdf>dec-08-xspsg-e-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KV8I SINGLE SIZE CHARACTER GEN<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yis>dec-08-yis</a></td>
<td><table>
<tr><td>aa-0882b / dec-08-yisb-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yis/dec-08-yisb-pa>ak-0883b / dec-08-yisb-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OCTAL MEMORY DUMP<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ypp>dec-08-ypp</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ypp/dec-08-yppa-pb>ak-0885a / dec-08-yppa-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ypp/dec-08-yppa-d.pdf>aa-0885a / dec-08-yppa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DECtape Copy Routine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ypt>dec-08-ypt</a></td>
<td><table>
<tr><td>dec-08-ypta-d</td><td></td></tr>
<tr><td>dec-08-ypta-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-ypt/dec-08-ypta-pb>dec-08-ypta-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Floating Point Package 1 (Basic System)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yq1>dec-08-yq1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yq1/dec-08-yq1a-pb>dec-08-yq1a-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yq1/dec-08-yq1b-pb>dec-08-yq1b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Floating Point Package 2 (Interpreter + I/O Controller)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yq2>dec-08-yq2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yq2/dec-08-yq2b-pb>dec-08-yq2b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yq2/dec-08-yq2a-pb>dec-08-yq2a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Floating Point Package 3 (Interpreter + Extended Functions)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yq3>dec-08-yq3</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yq3/dec-08-yq3a-pb>dec-08-yq3a-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yq3/dec-08-yq3b-pb>dec-08-yq3b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Floating Point Package 4 (Interpreter + I/O + Extended)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yq4>dec-08-yq4</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yq4/dec-08-yq4a-pb>dec-08-yq4a-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yq4/dec-08-yq4b-pb>dec-08-yq4b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Floating Point System Programming Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yqy>dec-08-yqy</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yqy/dec-08-yqyb-d.pdf>dec-08-yqyb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yqy/dec-08-yqya-d.pdf>dec-08-yqya-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>BINARY PUNCH ASR 33<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yx1>dec-08-yx1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yx1/dec-08-yx1a-pb>ak-0888a / dec-08-yx1a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Binary Punch (formerly digital-8-5-u)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yxy>dec-08-yxy</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-yxy/dec-08-yxya-d.pdf>dec-08-yxya-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Edgrin Translator (3 parts)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-zj2>dec-08-zj2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-zj2/dec-08-zj2b-pb>dec-08-zj2b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Edgrin Translator 1/3<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-zj2b-1>dec-08-zj2b-1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-zj2b-1/dec-08-zj2b-1-pa>dec-08-zj2b-1-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Edgrin Translator 2/3<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-zj2b-2>dec-08-zj2b-2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-zj2b-2/dec-08-zj2b-2-pa>dec-08-zj2b-2-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Edgrin Translator 3/3<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-zj2b-3>dec-08-zj2b-3</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-zj2b-3/dec-08-zj2b-3-pa>dec-08-zj2b-3-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Edgrin Cursor Mosiac<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-zj4>dec-08-zj4</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-zj4/dec-08-zj4b-pa>dec-08-zj4b-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Disk Editor Translator<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-zj5>dec-08-zj5</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-zj5/dec-08-zj5b-pb>dec-08-zj5b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RF08 Disk Editor Translator<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-zj6>dec-08-zj6</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-08-zj6/dec-08-zj6a-pb>dec-08-zj6a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DIAL-MS Extensions for RK8F<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-adexa>dec-12-adexa</a></td>
<td><table>
<a name='dec-12'></a>
<tr><td>al-3526a / dec-12-adexa-a1-ac</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 LAP 6-DIAL Programmers Reference<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-adrma>dec-12-adrma</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-adrma/dec-12-adrma-a-d.pdf>dec-12-adrma-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LIBMASH Binary LINCtape<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-afaba>dec-12-afaba</a></td>
<td><table>
<tr><td>dec-12-afaba-a-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>FOCAL-12 Programming Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-aja>dec-12-aja</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-aja/dec-12-ajaa-d.pdf>dec-12-ajaa-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-aja/dec-12-ajaa-la.pdf>dec-12-ajaa-la</td><td>FOCAL-12 Program Listing</a></td></tr>
</table></td></tr>
<tr>
<td>Fast Fourier Transform and Display<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-amfta>dec-12-amfta</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-amfta/dec-12-amfta-a-d.pdf>dec-12-amfta-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LIBMASH<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-amlba>dec-12-amlba</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-amlba/dec-12-amlba-a-d.pdf>dec-12-amlba-a-d</td><td></a></td></tr>
<tr><td>dec-12-amlba-a-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>FPP Assembler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-aqz>dec-12-aqz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-aqz/dec-12-aqza-d.pdf>dec-12-aqza-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Software Packages and Services<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-bw1>dec-12-bw1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-bw1/dec-12-bw1g-d.pdf>dec-12-bw1g-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-bw1/dec-12-bw1i-d.pdf>dec-12-bw1i-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-bw1/dec-12-bw1j-d.pdf>dec-12-bw1j-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-bw1/dec-12-bw1n-d.pdf>dec-12-bw1n-d</td><td>PDP-12 Software Price List</a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Basic Diagnostics<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-d7a>dec-12-d7a</a></td>
<td><table>
<tr><td>dec-12-d7ah-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 D8GF<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-d8g>dec-12-d8g</a></td>
<td><table>
<tr><td>dec-12-d8gf-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 TED<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-eos>dec-12-eos</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-eos/dec-12-eosa-d.pdf>dec-12-eosa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 CONVERT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-esy>dec-12-esy</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-esy/dec-12-esyb-d.pdf>dec-12-esyb-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 QANDA<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-fis>dec-12-fis</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-fis/dec-12-fisa-d.pdf>dec-12-fisa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 DISPLAY<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-fls>dec-12-fls</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-fls/dec-12-flsb-d.pdf>dec-12-flsb-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 FFTD<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-fqe>dec-12-fqe</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-fqe/dec-12-fqea-d.pdf>dec-12-fqea-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 CREF12<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-frz>dec-12-frz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-frz/dec-12-frzb-d.pdf>dec-12-frzb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-frz/dec-12-frza-d.pdf>dec-12-frza-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 MILDRED<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-fzd>dec-12-fzd</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-fzd/dec-12-fzda-d.pdf>dec-12-fzda-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 FRED<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-fzf>dec-12-fzf</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-fzf/dec-12-fzfa-d.pdf>dec-12-fzfa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Floating Point Processor Users Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-gqz>dec-12-gqz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-gqz/dec-12-gqza-d.pdf>dec-12-gqza-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FPP USERS MANUAL<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hfppa>dec-12-hfppa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hfppa/dec-12-hfppa-a-d.pdf>aa-3544a / dec-12-hfppa-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LV8/LV12/LV11 Printer Plotter Users Guide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hlvaa>dec-12-hlvaa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hlvaa/dec-12-hlvaa-a-d.pdf>dec-12-hlvaa-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Preventative Maintenance Procedures<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hpmpa>dec-12-hpmpa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hpmpa/dec-12-hpmpa-a-d.pdf>dec-12-hpmpa-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Maintenance Manual, Volume 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hr1>dec-12-hr1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hr1/dec-12-hr1a-d.pdf>dec-12-hr1a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hr1/dec-12-hr1b-d.pdf>dec-12-hr1b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Maintenance Manual, Volume 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hr2>dec-12-hr2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hr2/dec-12-hr2a-d.pdf>dec-12-hr2a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hr2/dec-12-hr2b-d.pdf>dec-12-hr2b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Maintenance Manual, Volume 4<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hr4>dec-12-hr4</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hr4/dec-12-hr4b-d.pdf>dec-12-hr4b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>VR14 CRT Display Users Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hvcrt>dec-12-hvcrt</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hvcrt/dec-12-hvcrt-d-d.pdf>dec-12-hvcrt-d-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>VR14 and VR20 Troubleshooting Procedures<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hvrtp>dec-12-hvrtp</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-hvrtp/dec-12-hvrtp-a-d.pdf>dec-12-hvrtp-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/12 FORTRAN IV ADC Routine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-lliba>dec-12-lliba</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-lliba/dec-12-lliba-b-pa1>dec-12-lliba-b-pa1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-lliba/dec-12-lliba-b-pa2>dec-12-lliba-b-pa2</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-lliba/dec-12-lliba-b-pa3>dec-12-lliba-b-pa3</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/12 FORTRAN IV Plotter Routines<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-lplta>dec-12-lplta</a></td>
<td><table>
<tr><td>al-3560b / dec-12-lplta-b-ac</td><td> (LT)</td></tr>
<tr><td>al-3559b / dec-12-lplta-b-aa</td><td> Source (LT)</td></tr>
</table></td></tr>
<tr>
<td>Clinical LAB-12 Input Programs<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-mclia>dec-12-mclia</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-mclia/dec-12-mclia-a-d.pdf>dec-12-mclia-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MASH Users Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-mmasa>dec-12-mmasa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-mmasa/dec-12-mmasa-a-d.pdf>dec-12-mmasa-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DEMO Monitor Technical Description<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-mrz>dec-12-mrz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-mrz/dec-12-mrza-d.pdf>dec-12-mrza-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AIPOS BUILD/INIT Internal Descriptions<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-oabia>dec-12-oabia</a></td>
<td><table>
<tr><td>dec-12-oabia-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>AIPOS Extensions for RK8E<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-oaipa>dec-12-oaipa</a></td>
<td><table>
<tr><td>dec-12-oaipa-a-aa</td><td></td></tr>
<tr><td>dec-12-oaipa-a-ab</td><td></td></tr>
</table></td></tr>
<tr>
<td>AIPOS Job Control Processor Internals<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-oajca>dec-12-oajca</a></td>
<td><table>
<tr><td>dec-12-oajca-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>AIPOS Monitor Internal Descriptions<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-oamna>dec-12-oamna</a></td>
<td><table>
<tr><td>dec-12-oamna-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>COS 300 Operating System<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-oddsa>dec-12-oddsa</a></td>
<td><table>
<tr><td>dec-12-oddsa-a-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/12 LINCTape System Handler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-odlta>dec-12-odlta</a></td>
<td><table>
<tr><td>dec-12-odlta-b-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/12 System LINCtape #1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-osc4a>dec-12-osc4a</a></td>
<td><table>
<tr><td>dec-12-osc4a-a-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/12 System LINCtape #1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-osysa>dec-12-osysa</a></td>
<td><table>
<tr><td>dec-12-osysa-a-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAP6-DIAL-MS for the RK8F<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-se2>dec-12-se2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-se2/dec-12-se2d-dn1.pdf>dec-12-se2d-dn1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-se2/dec-12-se2d-dn.pdf>dec-12-se2d-dn</td><td>LAP6-DIAL Programmers Reference Supplement</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-se2/dec-12-se2d-d.pdf>dec-12-se2d-d</td><td>LAP6-DIAL Programmers Reference</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-se2/dec-12-se2b-d.pdf>dec-12-se2b-d</td><td>LAP6-DIAL Programmers Reference</a></td></tr>
<tr><td>dec-12-se2e-uo</td><td>LAP6-DIAL User Programs #1</td></tr>
</table></td></tr>
<tr>
<td>LAP6-DIAL User Programs #2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-se3>dec-12-se3</a></td>
<td><table>
<tr><td>dec-12-se3c-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAP6-DIAL User Programs #3<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-se4>dec-12-se4</a></td>
<td><table>
<tr><td>dec-12-se4c-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>AIPOS System Tape<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-se6>dec-12-se6</a></td>
<td><table>
<tr><td>dec-12-se6e-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>FPP Software<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-se7>dec-12-se7</a></td>
<td><table>
<tr><td>dec-12-se7b-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>AIPOS Source LINCtape #1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-sex>dec-12-sex</a></td>
<td><table>
<tr><td>dec-12-sexa-uo1</td><td></td></tr>
<tr><td>dec-12-sexa-uo2</td><td>AIPOS Source LINCtape #2</td></tr>
<tr><td>dec-12-sexb-uo</td><td>AIPOS Source LINCtape #3</td></tr>
</table></td></tr>
<tr>
<td>LAP 6 DIAL 2A Sources<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-sey>dec-12-sey</a></td>
<td><table>
<tr><td>dec-12-seya-uo1</td><td></td></tr>
<tr><td>dec-12-seya-uo2</td><td>LAP 6 DIAL 2B Sources</td></tr>
</table></td></tr>
<tr>
<td>LAP 6 DIAL-MS Sources Part 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-sez>dec-12-sez</a></td>
<td><table>
<tr><td>dec-12-sezb-u1</td><td></td></tr>
<tr><td>dec-12-sezb-u2</td><td>LAP 6 DIAL-MS Sources Part 2</td></tr>
</table></td></tr>
<tr>
<td>PDP-12 L8SIM<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-si1>dec-12-si1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-si1/dec-12-si1b-d.pdf>dec-12-si1b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 AIPOS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-sq1>dec-12-sq1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-sq1/dec-12-sq1a-d.pdf>dec-12-sq1a-d</td><td></a></td></tr>
<tr><td>dec-12-sq1a-dn</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 MASH Documents<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-sq2>dec-12-sq2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-sq2/dec-12-sq2a-d.pdf>dec-12-sq2a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 MIDAS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-sq3>dec-12-sq3</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-sq3/dec-12-sq3a-d.pdf>dec-12-sq3a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MASH Listing<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-sqz>dec-12-sqz</a></td>
<td><table>
<tr><td>dec-12-sqza-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 System Reference Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-srz>dec-12-srz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-srz/dec-12-srzb-d.pdf>dec-12-srzb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-srz/dec-12-srzc-d.pdf>dec-12-srzc-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TSS/12 Library LINCtape<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-sy1>dec-12-sy1</a></td>
<td><table>
<tr><td>dec-12-sy1a-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>TSS/12 DIAL LINCtape<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-sy2>dec-12-sy2</a></td>
<td><table>
<tr><td>dec-12-sy2a-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>DEMO Monitor Listing<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-trz>dec-12-trz</a></td>
<td><table>
<tr><td>dec-12-trza-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>DEMO12 Users Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-udema>dec-12-udema</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-udema/dec-12-udema-a-d.pdf>dec-12-udema-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FPP Assembler Users Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-ufpaa>dec-12-ufpaa</a></td>
<td><table>
<tr><td>dec-12-ufpaa-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>AIPOS Monitor Internal Descriptions<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-ur1>dec-12-ur1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-ur1/dec-12-ur1a-d.pdf>dec-12-ur1a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AIPOS Job Control Processor I/O Internal Descriptions<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-ur2>dec-12-ur2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-ur2/dec-12-ur2a-d.pdf>dec-12-ur2a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AIPOS BUILD/INIT Internal Descriptions<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-ur3>dec-12-ur3</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-ur3/dec-12-ur3a-d.pdf>dec-12-ur3a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AIPOS DORA Internal Descriptions<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-ur4>dec-12-ur4</a></td>
<td><table>
<tr><td>dec-12-ur4a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>AIPOS File Handling and MOVE Internal Descriptions<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-ur5>dec-12-ur5</a></td>
<td><table>
<tr><td>dec-12-ur5a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>CATACAL Box-Car Averager<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uw1>dec-12-uw1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uw1/dec-12-uw1a-d.pdf>dec-12-uw1a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uw1/dec-12-uw1a-d1.pdf>dec-12-uw1a-d1</td><td>Assembling CATACAL</a></td></tr>
</table></td></tr>
<tr>
<td>ADTAPE and ADCON Analog to Tape<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uw2>dec-12-uw2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uw2/dec-12-uw2a-d.pdf>dec-12-uw2a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TISA Time Independent Spectrum Acquisition<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uw3>dec-12-uw3</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uw3/dec-12-uw3a-d.pdf>dec-12-uw3a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>SINPRE Single Precision<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uw4>dec-12-uw4</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uw4/dec-12-uw4a-d.pdf>dec-12-uw4a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>NMRSIM-E Spectral Simulator<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uw5>dec-12-uw5</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uw5/dec-12-uw5a-d.pdf>dec-12-uw5a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LIFE Library File Editor<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uw8>dec-12-uw8</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uw8/dec-12-uw8b-d.pdf>dec-12-uw8b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Demonstration Programs<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uxz>dec-12-uxz</a></td>
<td><table>
<tr><td>dec-12-uxzc-uo</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uxz/dec-12-uxzb-d.pdf>dec-12-uxzb-d</td><td>DEMO12 Users Guide</a></td></tr>
</table></td></tr>
<tr>
<td>Signal Averager Users Guide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uz1>dec-12-uz1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uz1/dec-12-uz1a-d.pdf>dec-12-uz1a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Moving Window for Scanning LINCTape<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uzs>dec-12-uzs</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-uzs/dec-12-uzsa-d.pdf>dec-12-uzsa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Software Components Catalog<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-xspla>dec-12-xspla</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-xspla/dec-12-xspla-c-d.pdf>dec-12-xspla-c-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 HIRES-MS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-xxx>dec-12-xxx</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-xxx/dec-12-xxxx-d.pdf>dec-12-xxxx-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FPP Support Library<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-yex>dec-12-yex</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-yex/dec-12-yexa-d.pdf>dec-12-yexa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 MARK12<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-yit>dec-12-yit</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-yit/dec-12-yitb-d.pdf>dec-12-yitb-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 PRTC12-F<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-yiy>dec-12-yiy</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-yiy/dec-12-yiya-d.pdf>dec-12-yiya-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 PATCH<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-yu2>dec-12-yu2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-yu2/dec-12-yu2a-d.pdf>dec-12-yu2a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DIAL-MS CREF<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr0>dec-12-zr0</a></td>
<td><table>
<tr><td>dec-12-zr0b-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>DIAL-MS ASSEMBLER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr1>dec-12-zr1</a></td>
<td><table>
<tr><td>dec-12-zr1b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr1/dec-12-zr1a-d.pdf>dec-12-zr1a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DIAL-MS PIP<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr2>dec-12-zr2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr2/dec-12-zr2b-d.pdf>dec-12-zr2b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DIAL-MS PXDXSRC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr3>dec-12-zr3</a></td>
<td><table>
<tr><td>dec-12-zr3b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr3/dec-12-zr3a-d.pdf>dec-12-zr3a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DIAL-MS PRINTMS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr4>dec-12-zr4</a></td>
<td><table>
<tr><td>dec-12-zr4b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr4/dec-12-zr4a-d.pdf>dec-12-zr4a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DIAL-MS BUILD<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr5>dec-12-zr5</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr5/dec-12-zr5b-d.pdf>dec-12-zr5b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DIAL-MS LOADER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr6>dec-12-zr6</a></td>
<td><table>
<tr><td>dec-12-zr6b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr6/dec-12-zr6a-d.pdf>dec-12-zr6a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DIAL-MS EDITOR<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr7>dec-12-zr7</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr7/dec-12-zr7b-d.pdf>dec-12-zr7b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DIAL-MS FILE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr8>dec-12-zr8</a></td>
<td><table>
<tr><td>dec-12-zr8b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr8/dec-12-zr8a-d.pdf>dec-12-zr8a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Building LAP 6 DIAL Sources<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr9>dec-12-zr9</a></td>
<td><table>
<tr><td>dec-12-zr9b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zr9/dec-12-zr9a-d.pdf>dec-12-zr9a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LAP 6 DIAL ASSEMBLER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zw1>dec-12-zw1</a></td>
<td><table>
<tr><td>dec-12-zw1a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAP 6 DIAL PIP<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zw2>dec-12-zw2</a></td>
<td><table>
<tr><td>dec-12-zw2a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAP 6 DIAL PXDXSRC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zw3>dec-12-zw3</a></td>
<td><table>
<tr><td>dec-12-zw3a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAP 6 DIAL PRINTMS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zw4>dec-12-zw4</a></td>
<td><table>
<tr><td>dec-12-zw4a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAP 6 DIAL SAVE BINARY<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zw5>dec-12-zw5</a></td>
<td><table>
<tr><td>dec-12-zw5a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAP 6 DIAL LOADER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zw6>dec-12-zw6</a></td>
<td><table>
<tr><td>dec-12-zw6a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAP 6 DIAL EDITOR V2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zw7>dec-12-zw7</a></td>
<td><table>
<tr><td>dec-12-zw7a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAP 6 DIAL ADD PROGRAM<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zw8>dec-12-zw8</a></td>
<td><table>
<tr><td>dec-12-zw8a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAP 6 DIAL FILE COMMANDS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-12-zw9>dec-12-zw9</a></td>
<td><table>
<tr><td>dec-12-zw9a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>PAL-14 (V3)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-asz>dec-14-asz</a></td>
<td><table>
<a name='dec-14'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-asz/dec-14-aszb-pb>dec-14-aszb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>SIM-14<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-edz>dec-14-edz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-edz/dec-14-edzc-pb>dec-14-edzc-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>SET-14<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-eiz>dec-14-eiz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-eiz/dec-14-eiza-pb>dec-14-eiza-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-14 Users Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-ggz>dec-14-ggz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-ggz/dec-14-ggza-d.pdf>dec-14-ggza-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>VT14 Users Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-gvtma>dec-14-gvtma</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-gvtma/dec-14-gvtma-a-d.pdf>dec-14-gvtma-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-14 Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-hgz>dec-14-hgz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-hgz/dec-14-hgzb-d.pdf>dec-14-hgzb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-hgz/dec-14-hgza-d1.pdf>dec-14-hgza-d1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-hgz/dec-14-hgza-d2.pdf>dec-14-hgza-d2</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Industrial 14 Systems Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-hsmaa>dec-14-hsmaa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-hsmaa/dec-14-hsmaa-a-d.pdf>dec-14-hsmaa-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Industrial 14 Software Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-isuma>dec-14-isuma</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-isuma/dec-14-isuma-b-d.pdf>dec-14-isuma-b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>BOOL-14<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-kzz>dec-14-kzz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-kzz/dec-14-kzze-pb>dec-14-kzze-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LOAD-14<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-lzp>dec-14-lzp</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-lzp/dec-14-lzpb-d.pdf>dec-14-lzpb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-lzp/dec-14-lzpb-pb>dec-14-lzpb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RUN-14<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-mwz>dec-14-mwz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-14-mwz/dec-14-mwzb-d.pdf>dec-14-mwzb-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP16-M Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-16-hmmma>dec-16-hmmma</a></td>
<td><table>
<a name='dec-16'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-16-hmmma/dec-16-hmmma-a-d.pdf>dec-16-hmmma-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP16-M Users Guide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-16-imuga>dec-16-imuga</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-16-imuga/dec-16-imuga-a-d.pdf>dec-16-imuga-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Advanced Averager Mass Storage 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa1a>dec-8e-aaa1a</a></td>
<td><table>
<a name='dec-8e'></a>
<tr><td>dec-8e-aaa1a-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa1a/dec-8e-aaa1a-a-pa>dec-8e-aaa1a-a-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa1a/dec-8e-aaa1a-a-pb>dec-8e-aaa1a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Advanced Averager Mass Storage 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa2a>dec-8e-aaa2a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa2a/dec-8e-aaa2a-a-pa>dec-8e-aaa2a-a-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa2a/dec-8e-aaa2a-a-pb>dec-8e-aaa2a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Advanced Averager Mass Storage 3<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa3a>dec-8e-aaa3a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa3a/dec-8e-aaa3a-a-pa>dec-8e-aaa3a-a-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa3a/dec-8e-aaa3a-a-pb>dec-8e-aaa3a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Advanced Averager Mass Storage 4<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa4a>dec-8e-aaa4a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa4a/dec-8e-aaa4a-a-pa>dec-8e-aaa4a-a-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa4a/dec-8e-aaa4a-a-pb>dec-8e-aaa4a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Advanced Averager Mass Storage 5<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa5a>dec-8e-aaa5a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa5a/dec-8e-aaa5a-a-pa>dec-8e-aaa5a-a-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaa5a/dec-8e-aaa5a-a-pb>dec-8e-aaa5a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>ADVANCED AVERAGER SECTION II DSK/DTA<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aaapa>dec-8e-aaapa</a></td>
<td><table>
<tr><td>ak-4203a / dec-8e-aaapa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Auto and Cross Correlation Mass Storage<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aacra>dec-8e-aacra</a></td>
<td><table>
<tr><td>dec-8e-aacra-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aacra/dec-8e-aacra-a-pb>dec-8e-aacra-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>ADVANCED AVERAGER SECTION I-IV<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aap1a>dec-8e-aap1a</a></td>
<td><table>
<tr><td>aa-4205a / dec-8e-aap1a-a-d</td><td></td></tr>
<tr><td>ak-4206a / dec-8e-aap1a-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>ADVANCED AVERAGER CTL SECTION II-IV<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aap2a>dec-8e-aap2a</a></td>
<td><table>
<tr><td>ak-4207a / dec-8e-aap2a-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>ADVANCED AVERAGER FOR DSK/DTA<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aapta>dec-8e-aapta</a></td>
<td><table>
<tr><td>ak-4208a / dec-8e-aapta-a-pb1</td><td></td></tr>
<tr><td>ak-4209a / dec-8e-aapta-a-pb2</td><td></td></tr>
<tr><td>ak-4210a / dec-8e-aapta-a-pb3</td><td></td></tr>
<tr><td>ak-4211a / dec-8e-aapta-a-pb4</td><td></td></tr>
</table></td></tr>
<tr>
<td>Basic Averager<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba0a>dec-8e-aba0a</a></td>
<td><table>
<tr><td>dec-8e-aba0a-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba0a/dec-8e-aba0a-a-pb>dec-8e-aba0a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Basic Averager Control Tape, 1 Channel, 1000 Points<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba1a>dec-8e-aba1a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba1a/dec-8e-aba1a-a-pb>dec-8e-aba1a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Basic Averager Control Tape, 2 Channels, 500 Points<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba2a>dec-8e-aba2a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba2a/dec-8e-aba2a-a-pb>dec-8e-aba2a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Basic Averager Control Tape, 3-4 Channels, 250 Points<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba3a>dec-8e-aba3a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba3a/dec-8e-aba3a-a-pb>dec-8e-aba3a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Basic Averager Control Tape, 1 Channels, Confidence Limits<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba4a>dec-8e-aba4a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba4a/dec-8e-aba4a-a-pb>dec-8e-aba4a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Basic Averager Control Tape, 2 Channels, Confidence Limits<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba5a>dec-8e-aba5a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba5a/dec-8e-aba5a-a-pb>dec-8e-aba5a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Basic Averager Control Tape, 4 Channels, Confidence Limits<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba6a>dec-8e-aba6a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba6a/dec-8e-aba6a-a-pb>dec-8e-aba6a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Basic Averager Control Tape, 1 Channels, Trend, Conf. Limits<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba7a>dec-8e-aba7a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba7a/dec-8e-aba7a-a-pb>dec-8e-aba7a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Basic Averager Control Tape, 2 Channels, Trend, Conf. Limits<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba8a>dec-8e-aba8a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aba8a/dec-8e-aba8a-a-pb>dec-8e-aba8a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LAB-8/E BASIC RUNTIME<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-abasa>dec-8e-abasa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-abasa/dec-8e-abasa-a-la.pdf>ab-4213a / dec-8e-abasa-a-la</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-abasa/dec-8e-abasa-a-pb>ak-4214a / dec-8e-abasa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LAB-8/E BASIC AVERAGER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-acaoa>dec-8e-acaoa</a></td>
<td><table>
<tr><td>aa-4216a / dec-8e-acaoa-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAB-8/E Data Conversion Program<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-acvta>dec-8e-acvta</a></td>
<td><table>
<tr><td>dec-8e-acvta-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-acvta/dec-8e-acvta-a-pb>dec-8e-acvta-a-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-acvta/dec-8e-acvta-a-pa>dec-8e-acvta-a-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-acvta/dec-8e-acvta-a-la.pdf>dec-8e-acvta-a-la</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DAFFT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-adafa>dec-8e-adafa</a></td>
<td><table>
<tr><td>dec-8e-adafa-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-adafa/dec-8e-adafa-a-pa>dec-8e-adafa-a-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-adafa/dec-8e-adafa-a-pb>dec-8e-adafa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DAQUAN<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-adaqa>dec-8e-adaqa</a></td>
<td><table>
<tr><td>dec-8e-adaqa-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-adaqa/dec-8e-adaqa-a-pa>dec-8e-adaqa-a-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-adaqa/dec-8e-adaqa-a-pb>dec-8e-adaqa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DAQUAN Floating Point Package, EAE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-adfea>dec-8e-adfea</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-adfea/dec-8e-adfea-a-pb>dec-8e-adfea-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DAQUAN Floating Point Package, non-EAE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-adfpa>dec-8e-adfpa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-adfpa/dec-8e-adfpa-a-pb>dec-8e-adfpa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DAQUAN<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-adqna>dec-8e-adqna</a></td>
<td><table>
<tr><td>ab-4221a / dec-8e-adqna-a-la</td><td></td></tr>
<tr><td>ak-4222a / dec-8e-adqna-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAB8-E Mass Storage Binaries<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa>dec-8e-almsa</a></td>
<td><table>
<tr><td>al-4246b / dec-8e-almsa-b-ub</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-ub>al-4246a / dec-8e-almsa-a-ub</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb1>ak-4223a / dec-8e-almsa-a-pb1</td><td>ADVANCED AVERAGER AAVG1.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb10>ak-4224a / dec-8e-almsa-a-pb10</td><td>BASIC AVERAGER CONTROL BAC5.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb11>ak-4225a / dec-8e-almsa-a-pb11</td><td>BASIC AVERAGER CONTROL BAC6.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb12>ak-4226a / dec-8e-almsa-a-pb12</td><td>BASIC AVERAGER CONTROL BAC7.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb13>ak-4227a / dec-8e-almsa-a-pb13</td><td>BASIC AVERAGER CONTROL BAC8.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb14>ak-4228a / dec-8e-almsa-a-pb14</td><td>BASIC AVERAGER BAD2.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb15>ak-4229a / dec-8e-almsa-a-pb15</td><td>PST & HISTOGRAM PSTD1.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb16>ak-4230a / dec-8e-almsa-a-pb16</td><td>TIH HISTOGRAM TIHD2.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb17>ak-4231a / dec-8e-almsa-a-pb17</td><td>AUTO CROSS CORRELATION CORD3.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb18>ak-4232a / dec-8e-almsa-a-pb18</td><td>CONVERT PROGRAM COND14.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb19>ak-4233a / dec-8e-almsa-a-pb19</td><td>DAQUAN W/O FPP DAQD5.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb2>ak-4234a / dec-8e-almsa-a-pb2</td><td>ADVANCED AVERAGER AAVG2.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb20>ak-4235a / dec-8e-almsa-a-pb20</td><td>EAE FPP FPPEAE.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb21>ak-4236a / dec-8e-almsa-a-pb21</td><td>NON-EAE FPP FOR DAQUAN FPPNE.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb22>ak-4237a / dec-8e-almsa-a-pb22</td><td>DAFFT OVERLAY TO DAQUAN DAFFT3.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb23>ak-4238a / dec-8e-almsa-a-pb23</td><td>ADVANCED AVERAGER MASS STG PAFFT2.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb3>ak-4239a / dec-8e-almsa-a-pb3</td><td>ADVANCED AVERAGER AAVG3.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb4>ak-4240a / dec-8e-almsa-a-pb4</td><td>ADVANCED AVERAGER AAVG4.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb5>ak-4241a / dec-8e-almsa-a-pb5</td><td>ADVANCED AVERAGER AAVG5.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb6>ak-4242a / dec-8e-almsa-a-pb6</td><td>BASIC AVERAGER CONTROL BAC1.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb7>ak-4243a / dec-8e-almsa-a-pb7</td><td>BASIC AVERAGER CONTROL BAC2.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb8>ak-4244a / dec-8e-almsa-a-pb8</td><td>BASIC AVERAGER CONTROL BAC3.BN</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-almsa/dec-8e-almsa-a-pb9>ak-4245a / dec-8e-almsa-a-pb9</td><td>BASIC AVERAGER CONTROL BAC4.BN</a></td></tr>
<tr><td>as-4247b / dec-8e-almsa-b-yb</td><td>LAB8-E Mass Storage System Floppy</td></tr>
</table></td></tr>
<tr>
<td>LAB-8/E Functions for OS/8 Basic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aloia>dec-8e-aloia</a></td>
<td><table>
<tr><td>dec-8e-aloia-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAB-8/E Functions for OS/8 Basic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-alosa>dec-8e-alosa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-alosa/dec-8e-alosa-a-d.pdf>dec-8e-alosa-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-alosa/dec-8e-alosa-a-pb>dec-8e-alosa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LAB-8/E SOFTWARE SYS USERS MANUAL<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aluma>dec-8e-aluma</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aluma/dec-8e-aluma-b-d.pdf>aa-4248b / dec-8e-aluma-b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LAB-8/E Software System Sources (DT)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-amssa>dec-8e-amssa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-amssa/dec-8e-amssa-b-ua1>al-4251b / dec-8e-amssa-b-ua1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-amssa/dec-8e-amssa-b-ua2>al-4252b / dec-8e-amssa-b-ua2</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-amssa/dec-8e-amssa-b-ua3>al-4253b / dec-8e-amssa-b-ua3</td><td></a></td></tr>
<tr><td>as-4254b / dec-8e-amssa-b-ya1</td><td></td></tr>
<tr><td>as-4255b / dec-8e-amssa-b-ya2</td><td></td></tr>
<tr><td>as-4256b / dec-8e-amssa-b-ya3</td><td></td></tr>
</table></td></tr>
<tr>
<td>PAFFT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-apafa>dec-8e-apafa</a></td>
<td><table>
<tr><td>dec-8e-apafa-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-apafa/dec-8e-apafa-a-pb>dec-8e-apafa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PST & LATENCY HISTOGRAM<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aplha>dec-8e-aplha</a></td>
<td><table>
<tr><td>aa-4258a / dec-8e-aplha-a-d</td><td></td></tr>
<tr><td>ak-4259a / dec-8e-aplha-a-pb</td><td>PST & LATENCY HOSTOGRAM</td></tr>
</table></td></tr>
<tr>
<td>PST and Latency Histogram<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-apsta>dec-8e-apsta</a></td>
<td><table>
<tr><td>dec-8e-apsta-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-apsta/dec-8e-apsta-a-pb>dec-8e-apsta-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LAB-8/E Miscellaneous<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-aspta>dec-8e-aspta</a></td>
<td><table>
<tr><td>al-4261a / dec-8e-aspta-a-ua1</td><td></td></tr>
<tr><td>al-4262a / dec-8e-aspta-a-ua2</td><td></td></tr>
<tr><td>al-4263a / dec-8e-aspta-a-ua3</td><td></td></tr>
<tr><td>al-4264a / dec-8e-aspta-a-ua4</td><td></td></tr>
</table></td></tr>
<tr>
<td>Time Interval Histogram<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-atiha>dec-8e-atiha</a></td>
<td><table>
<tr><td>dec-8e-atiha-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-atiha/dec-8e-atiha-a-pb>dec-8e-atiha-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TIME AND INTERVAL HISTOGRAM<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-atina>dec-8e-atina</a></td>
<td><table>
<tr><td>aa-4266a / dec-8e-atina-a-d</td><td></td></tr>
<tr><td>ak-4267a / dec-8e-atina-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TD8E DT FORMATTER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-euz>dec-8e-euz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-euz/dec-8e-euzc-d.pdf>aa-4269c / dec-8e-euzc-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-euz/dec-8e-euzc-pb>ak-4270c / dec-8e-euzc-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP8/E/F/M Maintenance Manual, Volume 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-hmm1a>dec-8e-hmm1a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-hmm1a/dec-8e-hmm1a-d-d.pdf>dec-8e-hmm1a-d-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP8/E/F/M Maintenance Manual, Volume 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-hmm2a>dec-8e-hmm2a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-hmm2a/dec-8e-hmm2a-d-d.pdf>dec-8e-hmm2a-d-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP8/E/F/M Maintenance Manual, Volume 3<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-hmm3a>dec-8e-hmm3a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-hmm3a/dec-8e-hmm3a-c-d.pdf>dec-8e-hmm3a-c-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP8/E/F/M Maintenance Manual, Volume 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-hr1>dec-8e-hr1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-hr1/dec-8e-hr1c-d.pdf>dec-8e-hr1c-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP8/E/F/M Maintenance Manual, Volume 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-hr2>dec-8e-hr2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-hr2/dec-8e-hr2b-d.pdf>dec-8e-hr2b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-hr2/dec-8e-hr2c-d.pdf>dec-8e-hr2c-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-hr2/dec-8e-hr2d-d.pdf>dec-8e-hr2d-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP8/E/F/M Maintenance Manual, Volume 3<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-hr3>dec-8e-hr3</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-hr3/dec-8e-hr3b-d.pdf>dec-8e-hr3b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FOCAL-8 8K OVERLAY (8E)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-lf8ka>dec-8e-lf8ka</a></td>
<td><table>
<tr><td>ab-4272a / dec-8e-lf8ka-a-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-lf8ka/dec-8e-lf8ka-a-pb>ak-4273a / dec-8e-lf8ka-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FOCAL-8 FAMILY OF 8 OVERLAYS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-lfoca>dec-8e-lfoca</a></td>
<td><table>
<tr><td>ab-4274a / dec-8e-lfoca-a-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-lfoca/dec-8e-lfoca-a-pb>ak-4275a / dec-8e-lfoca-a-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-lfoca/dec-8e-lfoca-a-pb1>ak-4275a / dec-8e-lfoca-a-pb1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-lfoca/dec-8e-lfoca-a-pb2>ak-4275a / dec-8e-lfoca-a-pb2</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FOCAL-8 QUAD OVERLAY (8E W/KL8E)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-lquda>dec-8e-lquda</a></td>
<td><table>
<tr><td>ab-4276a / dec-8e-lquda-a-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-lquda/dec-8e-lquda-a-pb>ak-4277a / dec-8e-lquda-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8/E EAE FLOATING POINT PACKAGE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-neaea>dec-8e-neaea</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-neaea/dec-8e-neaea-a-pb>ak-4282a / dec-8e-neaea-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Cassette Programming System 8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-ocasa>dec-8e-ocasa</a></td>
<td><table>
<tr><td>dec-8e-ocasa-a-cn1</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-ocasa/dec-8e-ocasa-b-d.pdf>dec-8e-ocasa-b-d</td><td></a></td></tr>
<tr><td>dec-8e-ocasa-a-d</td><td></td></tr>
<tr><td>dec-8e-ocasa-a-la</td><td></td></tr>
<tr><td>dec-8e-ocasa-a-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>COS 300 Operating System<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-oddsa>dec-8e-oddsa</a></td>
<td><table>
<tr><td>dec-8e-oddsa-a-hc</td><td></td></tr>
<tr><td>dec-8e-oddsa-a-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>TA8-E STAND ALONE CASSETTE HANDLER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-ucasa>dec-8e-ucasa</a></td>
<td><table>
<tr><td>aa-4292a / dec-8e-ucasa-a-d</td><td></td></tr>
<tr><td>ak-4293a / dec-8e-ucasa-a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>TD8E DT COPY PROGRAM<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-utdea>dec-8e-utdea</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-utdea/dec-8e-utdea-a-d.pdf>aa-4296a / dec-8e-utdea-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-utdea/dec-8e-utdea-a-pb>ak-4298a / dec-8e-utdea-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TD8E DT SUBROUTINE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-uzt>dec-8e-uzt</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-uzt/dec-8e-uzta-pa>ak-4300a / dec-8e-uzta-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-uzt/dec-8e-uzta-pb>ak-4301a / dec-8e-uzta-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Self Starting BIN Loader (8/E/F/M)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-xbina>dec-8e-xbina</a></td>
<td><table>
<tr><td>aa-4302b / dec-8e-xbina-b-d</td><td></td></tr>
<tr><td>ak-4303b / dec-8e-xbina-b-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-xbina/dec-8e-xbina-b-pb>ak-4304b / dec-8e-xbina-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-xbina/dec-8e-xbina-a-d.pdf>aa-4302a / dec-8e-xbina-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8e-xbina/dec-8e-xbina-a-pb>ak-4304a / dec-8e-xbina-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>680/I DC08 8 BIT CHARACTER ROUTINES<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-f8v>dec-8i-f8v</a></td>
<td><table>
<a name='dec-8i'></a>
<tr><td>ak-4306b / dec-8i-f8vb-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>680/I DC08 8 BIT CHARACTER ROUTINES<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-fzv>dec-8i-fzv</a></td>
<td><table>
<tr><td>ak-4308a / dec-8i-fzva-pa</td><td></td></tr>
<tr><td>aa-4307a / dec-8i-fzva-ta</td><td></td></tr>
</table></td></tr>
<tr>
<td>COMSYST-8 USERS GUIDE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-ggv>dec-8i-ggv</a></td>
<td><table>
<tr><td>aa-4309a / dec-8i-ggva-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>CR8/I Card Reader System Users Guide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-h2b>dec-8i-h2b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-h2b/dec-8i-h2bb-d.pdf>dec-8i-h2bb-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PP8/I High Speed Paper Tape Punch Functional Description<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-h2c>dec-8i-h2c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-h2c/dec-8i-h2ca-d.pdf>dec-8i-h2ca-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 KV Graphic Display System Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-h6m>dec-8i-h6m</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-h6m/dec-8i-h6ma-d.pdf>dec-8i-h6ma-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DC08A Serial Line Multiplexer<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-h80>dec-8i-h80</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-h80/dec-8i-h80a-d.pdf>dec-8i-h80a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KT8/I Time-Sharing Option Functional Description<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-h8n>dec-8i-h8n</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-h8n/dec-8i-h8na-d.pdf>dec-8i-h8na-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KE8/I Extended Arithmetic Element<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-hoc>dec-8i-hoc</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-hoc/dec-8i-hoca-d.pdf>dec-8i-hoca-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KB8/I General Input/Output Interface Description<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-hod>dec-8i-hod</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-hod/dec-8i-hoda-d.pdf>dec-8i-hoda-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8/I Maintenance Manual, Volume 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-hr1>dec-8i-hr1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-hr1/dec-8i-hr1a-d.pdf>dec-8i-hr1a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8/I Maintenance Manual, Volume 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-hr2>dec-8i-hr2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-hr2/dec-8i-hr2a-d.pdf>dec-8i-hr2a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 COMMONLY USED UTILITY ROUTINES<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-rzp>dec-8i-rzp</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8i-rzp/dec-8i-rzpa-d.pdf>aa-4338a / dec-8i-rzpa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KP8/L Power Failure Option Functional Description<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8l-d0b>dec-8l-d0b</a></td>
<td><table>
<a name='dec-8l'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8l-d0b/dec-8l-d0ba-d.pdf>dec-8l-d0ba-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DW08A Bus Conversion (Positive CPU) Installation<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8l-d0d>dec-8l-d0d</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8l-d0d/dec-8l-d0da-d.pdf>dec-8l-d0da-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MC8/L Memory Extension Control Functional Description<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8l-d4b>dec-8l-d4b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8l-d4b/dec-8l-d4ba-d.pdf>dec-8l-d4ba-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8/L Maintenance Manual, Volume 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8l-hr1>dec-8l-hr1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8l-hr1/dec-8l-hr1b-d.pdf>dec-8l-hr1b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8/L Maintenance Manual, Volume 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8l-hr2>dec-8l-hr2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8l-hr2/dec-8l-hr2a-d.pdf>dec-8l-hr2a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MC8/LA and MC8/LB Memory Extension Installation<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8l-i1a>dec-8l-i1a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-8l-i1a/dec-8l-i1aa-d.pdf>dec-8l-i1aa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>GLC-8 Gas-Liquid Chromatography System<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-cp-gay>dec-cp-gay</a></td>
<td><table>
<a name='dec-cp'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-cp-gay/dec-cp-gayb-d.pdf>dec-cp-gayb-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Quickpoint Floating Point Package V. D 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-cp-qpa1>dec-cp-qpa1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-cp-qpa1/dec-cp-qpa1-pb>dec-cp-qpa1-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Quickpoint Floating Point Package V. D 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-cp-qpa2>dec-cp-qpa2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-cp-qpa2/dec-cp-qpa2-pb>dec-cp-qpa2-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Quickpoint EIA to ASCII Conversion<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-cp-qpa3>dec-cp-qpa3</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-cp-qpa3/dec-cp-qpa3-pb>dec-cp-qpa3-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Quickpoint Parity Check<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-cp-qpa4>dec-cp-qpa4</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-cp-qpa4/dec-cp-qpa4-pb>dec-cp-qpa4-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>VR12 Point Plot Display Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-cr-h6a>dec-cr-h6a</a></td>
<td><table>
<a name='dec-cr'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-cr-h6a/dec-cr-h6aa-d.pdf>dec-cr-h6aa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Fortran D Compiler Loader (FORT)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-afa1>dec-d8-afa1</a></td>
<td><table>
<a name='dec-d8'></a>
<tr><td>dec-d8-afa1-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-afa1/dec-d8-afa1-pb>dec-d8-afa1-pb</td><td></a></td></tr>
<tr><td>dec-d8-afa1-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>Fortran D Compiler Loader (.FT.)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-afa2>dec-d8-afa2</a></td>
<td><table>
<tr><td>dec-d8-afa2-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-afa2/dec-d8-afa2-pb>dec-d8-afa2-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Fortran D Operating System Loader (FOSL)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-afa3>dec-d8-afa3</a></td>
<td><table>
<tr><td>dec-d8-afa3-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-afa3/dec-d8-afa3-pb>dec-d8-afa3-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Fortran D Operating System (.OS.)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-afa4>dec-d8-afa4</a></td>
<td><table>
<tr><td>dec-d8-afa4-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-afa4/dec-d8-afa4-pb>dec-d8-afa4-pb</td><td></a></td></tr>
<tr><td>dec-d8-afa4-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>Fortran D Symbol Print (STBL)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-afa5>dec-d8-afa5</a></td>
<td><table>
<tr><td>dec-d8-afa5-la</td><td></td></tr>
<tr><td>dec-d8-afa5-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-afa5/dec-d8-afa5-pb>dec-d8-afa5-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Fortran D Daignose (DIAG)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-afa6>dec-d8-afa6</a></td>
<td><table>
<tr><td>dec-d8-afa6-la</td><td></td></tr>
<tr><td>dec-d8-afa6-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-afa6/dec-d8-afa6-pb>dec-d8-afa6-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Disk Assembler (PALD)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-asa>dec-d8-asa</a></td>
<td><table>
<tr><td>dec-d8-asac-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-asa/dec-d8-asac-pb>dec-d8-asac-pb</td><td></a></td></tr>
<tr><td>dec-d8-asac-ua</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-asa/dec-d8-asab-pb>dec-d8-asab-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-asa/dec-d8-asaa-d.pdf>dec-d8-asaa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Disk System DDT Driver (DDT)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-cdd1>dec-d8-cdd1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-cdd1/dec-d8-cdd1-pa>dec-d8-cdd1-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-cdd1/dec-d8-cdd1-pb>dec-d8-cdd1-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Disk System DDT (.DDT)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-cdd2>dec-d8-cdd2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-cdd2/dec-d8-cdd2-pb>dec-d8-cdd2-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Disk System DDT Driver (DDT)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-cde1>dec-d8-cde1</a></td>
<td><table>
<tr><td>dec-d8-cde1-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-cde1/dec-d8-cde1-pa>dec-d8-cde1-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-cde1/dec-d8-cde1-pb>dec-d8-cde1-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Disk System DDT (.DDT)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-cde2>dec-d8-cde2</a></td>
<td><table>
<tr><td>dec-d8-cde2-la</td><td></td></tr>
<tr><td>dec-d8-cde2-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-cde2/dec-d8-cde2-pb>dec-d8-cde2-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>ODT-8 Debugger<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-coc>dec-d8-coc</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-coc/dec-d8-coco-d.pdf>dec-d8-coco-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Disk System Editor (EDIT)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-esa>dec-d8-esa</a></td>
<td><table>
<tr><td>dec-d8-esad-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-esa/dec-d8-esad-pb>dec-d8-esad-pb</td><td></a></td></tr>
<tr><td>dec-d8-esad-ua</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-esa/dec-d8-esac-pb>dec-d8-esac-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-esa/dec-d8-esab-pb>dec-d8-esab-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DF32 Disk File and Control Instruction Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-idf>dec-d8-idf</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-idf/dec-d8-idfa-d.pdf>dec-d8-idfa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DisK System PIP-DF32 (PIP)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-pda>dec-d8-pda</a></td>
<td><table>
<tr><td>dec-d8-pdad-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-pda/dec-d8-pdad-pb>dec-d8-pdad-pb</td><td></a></td></tr>
<tr><td>dec-d8-pdad-ua</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-pda/dec-d8-pdaa-pb>dec-d8-pdaa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Disk System PIP-RF08 (PIP)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-pdz>dec-d8-pdz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-pdz/dec-d8-pdze-pb>dec-d8-pdze-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Disk System Restore<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-rwd>dec-d8-rwd</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-rwd/dec-d8-rwda-pa>dec-d8-rwda-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Disk System Builder<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-sba>dec-d8-sba</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-sba/dec-d8-sbab-d.pdf>dec-d8-sbab-d</td><td></a></td></tr>
<tr><td>dec-d8-sbaf-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-sba/dec-d8-sbaf-pb>dec-d8-sbaf-pb</td><td></a></td></tr>
<tr><td>dec-d8-sbaf-ua</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-sba/dec-d8-sbae-pb>dec-d8-sbae-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Patch D8-SBAE (R022A.PAT)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-sba1>dec-d8-sba1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-sba1/dec-d8-sba1-pb>dec-d8-sba1-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Disk Monitor System (DMS) Programmers Reference<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-sda>dec-d8-sda</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-sda/dec-d8-sdaa-d.pdf>dec-d8-sdaa-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-d8-sda/dec-d8-sdab-d.pdf>dec-d8-sdab-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 PALD<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-asz>dec-e8-asz</a></td>
<td><table>
<a name='dec-e8'></a>
<tr><td>dec-e8-asza-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 CRASH<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-cdd>dec-e8-cdd</a></td>
<td><table>
<tr><td>dec-e8-cdda-la</td><td></td></tr>
<tr><td>dec-e8-cdda-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 XDDT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-jdf>dec-e8-jdf</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-jdf/dec-e8-jdfa-pb>dec-e8-jdfa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 FORT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-kf1>dec-e8-kf1</a></td>
<td><table>
<tr><td>dec-e8-kf1a-la</td><td></td></tr>
<tr><td>dec-e8-kf1a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 FDCOMP<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-kf2>dec-e8-kf2</a></td>
<td><table>
<tr><td>dec-e8-kf2a-la</td><td></td></tr>
<tr><td>dec-e8-kf2a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 BASIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-kjr>dec-e8-kjr</a></td>
<td><table>
<tr><td>dec-e8-kjra-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-kjr/dec-e8-kjra-ps>dec-e8-kjra-ps</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 LOADER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-lwh>dec-e8-lwh</a></td>
<td><table>
<tr><td>dec-e8-lwha-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 PIP<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-ppf>dec-e8-ppf</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-ppf/dec-e8-ppfa-ps>dec-e8-ppfa-ps</td><td></a></td></tr>
<tr><td>dec-e8-ppfa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 BUILD<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-sbh>dec-e8-sbh</a></td>
<td><table>
<tr><td>dec-e8-sbha-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-sbh/dec-e8-sbha-pb>dec-e8-sbha-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 FOSL<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-sf1>dec-e8-sf1</a></td>
<td><table>
<tr><td>dec-e8-sf1a-la</td><td></td></tr>
<tr><td>dec-e8-sf1a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 FOSSIL<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-sf2>dec-e8-sf2</a></td>
<td><table>
<tr><td>dec-e8-sf2a-la</td><td></td></tr>
<tr><td>dec-e8-sf2a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 TEST 0<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t01>dec-e8-t01</a></td>
<td><table>
<tr><td>dec-e8-t01a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 DEMO<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t02>dec-e8-t02</a></td>
<td><table>
<tr><td>dec-e8-t02a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 CATALOG<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t03>dec-e8-t03</a></td>
<td><table>
<tr><td>dec-e8-t03a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 TEST 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t04>dec-e8-t04</a></td>
<td><table>
<tr><td>dec-e8-t04a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 POT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t05>dec-e8-t05</a></td>
<td><table>
<tr><td>dec-e8-t05a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 BANDIT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t06>dec-e8-t06</a></td>
<td><table>
<tr><td>dec-e8-t06a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 BLKJAC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t07>dec-e8-t07</a></td>
<td><table>
<tr><td>dec-e8-t07a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 BUNNY<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t08>dec-e8-t08</a></td>
<td><table>
<tr><td>dec-e8-t08a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 CRAPS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t09>dec-e8-t09</a></td>
<td><table>
<tr><td>dec-e8-t09a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 EVEN<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t10>dec-e8-t10</a></td>
<td><table>
<tr><td>dec-e8-t10a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 FILMS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t11>dec-e8-t11</a></td>
<td><table>
<tr><td>dec-e8-t11a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 FTBALL<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t12>dec-e8-t12</a></td>
<td><table>
<tr><td>dec-e8-t12a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 HOSSR<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t13>dec-e8-t13</a></td>
<td><table>
<tr><td>dec-e8-t13a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 GOLF<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t14>dec-e8-t14</a></td>
<td><table>
<tr><td>dec-e8-t14a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 NELSON<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t15>dec-e8-t15</a></td>
<td><table>
<tr><td>dec-e8-t15a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 NIM<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t16>dec-e8-t16</a></td>
<td><table>
<tr><td>dec-e8-t16a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 ROULET<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t17>dec-e8-t17</a></td>
<td><table>
<tr><td>dec-e8-t17a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 SPORTS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t18>dec-e8-t18</a></td>
<td><table>
<tr><td>dec-e8-t18a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 TICTAC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t19>dec-e8-t19</a></td>
<td><table>
<tr><td>dec-e8-t19a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 CONVER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t20>dec-e8-t20</a></td>
<td><table>
<tr><td>dec-e8-t20a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 TACT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t21>dec-e8-t21</a></td>
<td><table>
<tr><td>dec-e8-t21a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 FACTAL<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t22>dec-e8-t22</a></td>
<td><table>
<tr><td>dec-e8-t22a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 FIBO<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t23>dec-e8-t23</a></td>
<td><table>
<tr><td>dec-e8-t23a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 PAPERTAPE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t24>dec-e8-t24</a></td>
<td><table>
<tr><td>dec-e8-t24a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 MAGIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t25>dec-e8-t25</a></td>
<td><table>
<tr><td>dec-e8-t25a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 PRIME<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t26>dec-e8-t26</a></td>
<td><table>
<tr><td>dec-e8-t26a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 INTER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t27>dec-e8-t27</a></td>
<td><table>
<tr><td>dec-e8-t27a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 PEACE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t28>dec-e8-t28</a></td>
<td><table>
<tr><td>dec-e8-t28a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 PEACE 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t29>dec-e8-t29</a></td>
<td><table>
<tr><td>dec-e8-t29a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 SNOOPY<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t30>dec-e8-t30</a></td>
<td><table>
<tr><td>dec-e8-t30a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 WDGAME<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t31>dec-e8-t31</a></td>
<td><table>
<tr><td>dec-e8-t31a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 DATA<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t32>dec-e8-t32</a></td>
<td><table>
<tr><td>dec-e8-t32a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 MATRIX<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t33>dec-e8-t33</a></td>
<td><table>
<tr><td>dec-e8-t33a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 TYPE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t34>dec-e8-t34</a></td>
<td><table>
<tr><td>dec-e8-t34a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 HAMURS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t35>dec-e8-t35</a></td>
<td><table>
<tr><td>dec-e8-t35a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 HAMURA<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t36>dec-e8-t36</a></td>
<td><table>
<tr><td>dec-e8-t36a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 ROCKES<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t37>dec-e8-t37</a></td>
<td><table>
<tr><td>dec-e8-t37a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 ROCKET<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t38>dec-e8-t38</a></td>
<td><table>
<tr><td>dec-e8-t38a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 CIVIL<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t39>dec-e8-t39</a></td>
<td><table>
<tr><td>dec-e8-t39a-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 TEST 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t41>dec-e8-t41</a></td>
<td><table>
<tr><td>dec-e8-t41a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 TEST 3<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-t42>dec-e8-t42</a></td>
<td><table>
<tr><td>dec-e8-t42a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 10 Demo Programs<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-txi>dec-e8-txi</a></td>
<td><table>
<tr><td>dec-e8-txia-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 10 Demo Programs Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-txp>dec-e8-txp</a></td>
<td><table>
<tr><td>dec-e8-txpa-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 FOCAL<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-ynr>dec-e8-ynr</a></td>
<td><table>
<tr><td>dec-e8-ynra-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 FOCAL Overlays<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-ynt>dec-e8-ynt</a></td>
<td><table>
<tr><td>dec-e8-ynta-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 DUPL<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-ypp>dec-e8-ypp</a></td>
<td><table>
<tr><td>dec-e8-yppa-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 LIBRARY<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-ywt>dec-e8-ywt</a></td>
<td><table>
<tr><td>dec-e8-ywta-uc</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 SYSTAT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-yzz>dec-e8-yzz</a></td>
<td><table>
<tr><td>dec-e8-yzza-la</td><td></td></tr>
<tr><td>dec-e8-yzza-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 Source #1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-zz1>dec-e8-zz1</a></td>
<td><table>
<tr><td>dec-e8-zz1a-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 Source #2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-zz2>dec-e8-zz2</a></td>
<td><table>
<tr><td>dec-e8-zz2a-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 Source #3<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-zz3>dec-e8-zz3</a></td>
<td><table>
<tr><td>dec-e8-zz3a-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 Source #4<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-zz4>dec-e8-zz4</a></td>
<td><table>
<tr><td>dec-e8-zz4a-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 Source #5<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-zz5>dec-e8-zz5</a></td>
<td><table>
<tr><td>dec-e8-zz5a-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 50 Source #6<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-e8-zz6>dec-e8-zz6</a></td>
<td><table>
<tr><td>dec-e8-zz6a-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>RS08/RS09 DECdisk Preventative Maintenance<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-fs-hrspm>dec-fs-hrspm</a></td>
<td><table>
<a name='dec-fs'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-fs-hrspm/dec-fs-hrspm-a-d.pdf>dec-fs-hrspm-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>INDAC8/2 Handbook<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-in-grz>dec-in-grz</a></td>
<td><table>
<a name='dec-in'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-in-grz/dec-in-grza-d.pdf>dec-in-grza-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>SUDSY II Prolog (Test 0)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-l8-d0b>dec-l8-d0b</a></td>
<td><table>
<a name='dec-l8'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-l8-d0b/dec-l8-d0ba-pb>dec-l8-d0ba-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LINC-8 SUDSY II, Volume 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-l8-dss0>dec-l8-dss0</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-l8-dss0/dec-l8-dss0-d.pdf>dec-l8-dss0-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LAB-8/E Advanced Averager Section II<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-aaapa>dec-lb-aaapa</a></td>
<td><table>
<a name='dec-lb'></a>
<tr><td>dec-lb-aaapa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAB-8/E Maintenance Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-h8emm>dec-lb-h8emm</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-h8emm/dec-lb-h8emm-b-d.pdf>dec-lb-h8emm-b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LAB-8/E Users Handbook<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-hrz>dec-lb-hrz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-hrz/dec-lb-hrza-d.pdf>dec-lb-hrza-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>1 CHANNEL AVERAGER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u01>dec-lb-u01</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u01/dec-lb-u01b-pb>ak-4491b / dec-lb-u01b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>2 CHANNEL AVERAGER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u02>dec-lb-u02</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u02/dec-lb-u02b-pb>ak-4492b / dec-lb-u02b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>4 CHANNEL AVERAGER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u03>dec-lb-u03</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u03/dec-lb-u03b-pb>ak-4493b / dec-lb-u03b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>1 CHANNEL AVERAGER & CONFIDENCE LIMITS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u04>dec-lb-u04</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u04/dec-lb-u04b-pb>ak-4494b / dec-lb-u04b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>2 CHANNEL AVERAGER & CONFIDENCE LIMITS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u05>dec-lb-u05</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u05/dec-lb-u05b-pb>ak-4495b / dec-lb-u05b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>4 CHANNEL AVERAGER & CONFIDENCE LIMITS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u06>dec-lb-u06</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u06/dec-lb-u06b-pb>ak-4496b / dec-lb-u06b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>1 CHANNEL AVERAGER & CONF. LIMITS, TREND ANAL.<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u07>dec-lb-u07</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u07/dec-lb-u07b-pb>ak-4497b / dec-lb-u07b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>2 CHANNEL AVERAGER & CONF. LIMITS, TREND ANAL.<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u08>dec-lb-u08</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u08/dec-lb-u08b-pb>ak-4498b / dec-lb-u08b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AUTO & CROSS CORRELATION PACKAGE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u41>dec-lb-u41</a></td>
<td><table>
<tr><td>ak-4500b / dec-lb-u41b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>NMR AVERAGER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u52>dec-lb-u52</a></td>
<td><table>
<tr><td>ab-4501a / dec-lb-u52a-la</td><td></td></tr>
<tr><td>ak-4502a / dec-lb-u52a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>NMR SIMULATOR<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u53>dec-lb-u53</a></td>
<td><table>
<tr><td>ab-4503a / dec-lb-u53a-la</td><td></td></tr>
<tr><td>ak-4504a / dec-lb-u53a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AUTO & CROSS CORRELATION PACKAGE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u67>dec-lb-u67</a></td>
<td><table>
<tr><td>aa-4505a / dec-lb-u67a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>BASIC/RT Users Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u70>dec-lb-u70</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u70/dec-lb-u70b-d.pdf>dec-lb-u70b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u70/dec-lb-u70b-pb>dec-lb-u70b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AX08 LAB8 USERS BULLETIN<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-u90>dec-lb-u90</a></td>
<td><table>
<tr><td>aa-4506b / dec-lb-u90b-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>AX08 HANDLERS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-lb-yi1>dec-lb-yi1</a></td>
<td><table>
<tr><td>aa-4507a / dec-lb-yi1a-d</td><td></td></tr>
<tr><td>ak-4508a / dec-lb-yi1a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PS/8 DEC Config (DECtape)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-p8-mw0>dec-p8-mw0</a></td>
<td><table>
<a name='dec-p8'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-p8-mw0/dec-p8-mw0a-pb>dec-p8-mw0a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PS/8 DEC Config (RK8)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-p8-mw1>dec-p8-mw1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-p8-mw1/dec-p8-mw1a-pb>dec-p8-mw1a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PS/8 DEC Config (RF08)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-p8-mw2>dec-p8-mw2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-p8-mw2/dec-p8-mw2a-pb>dec-p8-mw2a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PS/8 DEC Config (DF32)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-p8-mw3>dec-p8-mw3</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-p8-mw3/dec-p8-mw3a-pb>dec-p8-mw3a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PS/8 Binary Tape<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-p8-mwz>dec-p8-mwz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-p8-mwz/dec-p8-mwza-pb>dec-p8-mwza-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PS/8 Command Decoder<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-p8-swx>dec-p8-swx</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-p8-swx/dec-p8-swxb-pb>dec-p8-swxb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PS/8 CREF<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-p8-yrx>dec-p8-yrx</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-p8-yrx/dec-p8-yrxa-pb>dec-p8-yrxa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Edusystem 25<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ed25a>dec-s8-ed25a</a></td>
<td><table>
<a name='dec-s8'></a>
<tr><td>dec-s8-ed25a-a-la</td><td></td></tr>
<tr><td>dec-s8-ed25a-a-uc1</td><td></td></tr>
<tr><td>dec-s8-ed25a-a-uc2</td><td></td></tr>
</table></td></tr>
<tr>
<td>BASIC-8 (8K)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lbasa>dec-s8-lbasa</a></td>
<td><table>
<tr><td>dec-s8-lbasa-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lbasa/dec-s8-lbasa-a-la.pdf>dec-s8-lbasa-a-la</td><td></a></td></tr>
<tr><td>dec-s8-lbasa-a-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lbasa/dec-s8-lbasa-a-pb1>dec-s8-lbasa-a-pb1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lbasa/dec-s8-lbasa-a-pb2>dec-s8-lbasa-a-pb2</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lbasa/dec-s8-lbasa-a-pb3>dec-s8-lbasa-a-pb3</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lbasa/dec-s8-lbasa-a-pb4>dec-s8-lbasa-a-pb4</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lbasa/dec-s8-lbasa-a-pb5>dec-s8-lbasa-a-pb5</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 FORTRAN IV Compiler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lfiva>dec-s8-lfiva</a></td>
<td><table>
<tr><td>dec-s8-lfiva-a-ps</td><td></td></tr>
<tr><td>dec-s8-lfiva-b-ps</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lfiva/dec-s8-lfiva-b-ps1>dec-s8-lfiva-b-ps1</td><td> (F4.SV)</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lfiva/dec-s8-lfiva-b-ps2>dec-s8-lfiva-b-ps2</td><td> (PASS2.SV)</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lfiva/dec-s8-lfiva-b-ps3>dec-s8-lfiva-b-ps3</td><td> (PASS2O.SV)</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lfiva/dec-s8-lfiva-b-ps4>dec-s8-lfiva-b-ps4</td><td> (PASS3.SV)</a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 FORTRAN II Compiler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lfora>dec-s8-lfora</a></td>
<td><table>
<tr><td>dec-s8-lfora-b-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lfora/dec-s8-lfora-b-pb>dec-s8-lfora-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 F4 SOFTWARE SUPPORT MANUAL<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lfssa>dec-s8-lfssa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lfssa/dec-s8-lfssa-a-d.pdf>aa-4532a / dec-s8-lfssa-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 FORTRAN IV Source<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lftna>dec-s8-lftna</a></td>
<td><table>
<tr><td>dec-s8-lftna-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lftna/dec-s8-lftna-b-uc>dec-s8-lftna-b-uc</td><td></a></td></tr>
<tr><td>dec-s8-lftna-a-uc</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lftna/dec-s8-lftna-a-ua1>dec-s8-lftna-a-ua1</td><td></a></td></tr>
<tr><td>dec-s8-lftna-a-ua2</td><td></td></tr>
<tr><td>dec-s8-lftna-a-ua3</td><td></td></tr>
<tr><td>dec-s8-lftna-a-ua4</td><td></td></tr>
<tr><td>dec-s8-lftna-a-la1</td><td></td></tr>
<tr><td>dec-s8-lftna-a-la2</td><td></td></tr>
<tr><td>dec-s8-lftna-a-la3</td><td></td></tr>
<tr><td>dec-s8-lftna-a-la4</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 FORTRAN IV Librarian (LIBRA)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-llbra>dec-s8-llbra</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-llbra/dec-s8-llbra-b-ps>dec-s8-llbra-b-ps</td><td></a></td></tr>
<tr><td>dec-s8-llbra-a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 FORTRAN IV Library (FORLIB)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lliba>dec-s8-lliba</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lliba/dec-s8-lliba-b-ps1>dec-s8-lliba-b-ps1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lliba/dec-s8-lliba-b-ps2>dec-s8-lliba-b-ps2</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lliba/dec-s8-lliba-b-ps3>dec-s8-lliba-b-ps3</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lliba/dec-s8-lliba-b-ps4>dec-s8-lliba-b-ps4</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lliba/dec-s8-lliba-b-ps5>dec-s8-lliba-b-ps5</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lliba/dec-s8-lliba-b-ps6>dec-s8-lliba-b-ps6</td><td></a></td></tr>
<tr><td>dec-s8-lliba-a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 FORTRAN IV Loader<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lloda>dec-s8-lloda</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lloda/dec-s8-lloda-b-ps>dec-s8-lloda-b-ps</td><td></a></td></tr>
<tr><td>dec-s8-lloda-a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 FORTRAN IV PLOTTER ROUTINES<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lplma>dec-s8-lplma</a></td>
<td><table>
<tr><td>aa-4576a / dec-s8-lplma-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 FORTRAN IV PLOTTER ROUTINES (DT)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lplta>dec-s8-lplta</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lplta/dec-s8-lplta-b-uc>al-4587b / dec-s8-lplta-b-uc</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lplta/dec-s8-lplta-a-uc>al-4587a / dec-s8-lplta-a-uc</td><td></a></td></tr>
<tr><td>dec-s8-lplta-b-la</td><td>OS/8 FORTRAN IV PLOTTER ROUTINES</td></tr>
<tr><td>ak-4580b / dec-s8-lplta-b-pr1</td><td>OS/8 FORTRAN IV PLOTTER ROUTINES .RL #1</td></tr>
<tr><td>ak-4581b / dec-s8-lplta-b-pr2</td><td>OS/8 FORTRAN IV PLOTTER ROUTINES .RL #2</td></tr>
<tr><td>ak-4582b / dec-s8-lplta-b-pr3</td><td>OS/8 FORTRAN IV PLOTTER ROUTINES .RL #3</td></tr>
<tr><td>ak-4583b / dec-s8-lplta-b-pr4</td><td>OS/8 FORTRAN IV PLOTTER ROUTINES .RL #4</td></tr>
<tr><td>ak-4584b / dec-s8-lplta-b-pr5</td><td>OS/8 FORTRAN IV PLOTTER ROUTINES .RL #5</td></tr>
<tr><td>al-4586b / dec-s8-lplta-b-ua</td><td>OS/8 FORTRAN IV PLOTTER ROUTINES Source (DT)</td></tr>
<tr><td>ar-4585b / dec-s8-lplta-b-tc</td><td>OS/8 FORTRAN IV PLOTTER ROUTINES (Cassette)</td></tr>
<tr><td>ar-4585c / dec-s8-lplta-c-tc</td><td>OS/8 FORTRAN IV PLOTTER ROUTINES (Cassette)</td></tr>
<tr><td>an-4579b / dec-s8-lplta-b-ha</td><td>OS/8 FORTRAN IV PLOTTER ROUTINES Source (RK05)</td></tr>
<tr><td>as-4588b / dec-s8-lplta-b-ya</td><td>OS/8 FORTRAN IV PLOTTER ROUTINES Source Floppy</td></tr>
<tr><td>as-4589b / dec-s8-lplta-b-yc</td><td>OS/8 FORTRAN IV PLOTTER ROUTINES Comb. Mode Floppy</td></tr>
</table></td></tr>
<tr>
<td>OS/8 FORTRAN IV RALF<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lrafa>dec-s8-lrafa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lrafa/dec-s8-lrafa-b-ps>dec-s8-lrafa-b-ps</td><td></a></td></tr>
<tr><td>dec-s8-lrafa-a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 FORTRAN IV V02 FRTS.SV<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lrtsa>dec-s8-lrtsa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-lrtsa/dec-s8-lrtsa-b-ps>dec-s8-lrtsa-b-ps</td><td></a></td></tr>
<tr><td>dec-s8-lrtsa-a-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Auxiliary Device Drivers<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-obada>dec-s8-obada</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-obada/dec-s8-obada-b-pb>dec-s8-obada-b-pb</td><td></a></td></tr>
<tr><td>dec-s8-obada-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Batch<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-obata>dec-s8-obata</a></td>
<td><table>
<tr><td>dec-s8-obata-a-d</td><td></td></tr>
<tr><td>dec-s8-obata-a-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-obata/dec-s8-obata-a-pb>dec-s8-obata-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Builder (BUILD)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oblda>dec-s8-oblda</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oblda/dec-s8-oblda-b-pb>dec-s8-oblda-b-pb</td><td></a></td></tr>
<tr><td>dec-s8-oblda-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 MARK SENSE BATCH USERS MANUAL<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-obuga>dec-s8-obuga</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-obuga/dec-s8-obuga-a-d.pdf>aa-4593a / dec-s8-obuga-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Cassette Programming System 8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ocasa>dec-s8-ocasa</a></td>
<td><table>
<tr><td>dec-s8-ocasa-a-d</td><td></td></tr>
<tr><td>dec-s8-ocasa-a-la</td><td></td></tr>
<tr><td>dec-s8-ocasa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Configuration (CONFIG)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ocfga>dec-s8-ocfga</a></td>
<td><table>
<tr><td>dec-s8-ocfga-b-la</td><td></td></tr>
<tr><td>dec-s8-ocfga-b-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ocfga/dec-s8-ocfga-b-pa1>dec-s8-ocfga-b-pa1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ocfga/dec-s8-ocfga-b-pa2>dec-s8-ocfga-b-pa2</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ocfga/dec-s8-ocfga-b-pa3>dec-s8-ocfga-b-pa3</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Command Decoder/ODT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ocmda>dec-s8-ocmda</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ocmda/dec-s8-ocmda-b-pb>dec-s8-ocmda-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ocmda/dec-s8-ocmda-a-pb>dec-s8-ocmda-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Cross Reference Program (CREF)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ocrfa>dec-s8-ocrfa</a></td>
<td><table>
<tr><td>dec-s8-ocrfa-b-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ocrfa/dec-s8-ocrfa-b-pb>dec-s8-ocrfa-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 DF32 Configure<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oddfa>dec-s8-oddfa</a></td>
<td><table>
<tr><td>dec-s8-oddfa-b-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oddfa/dec-s8-oddfa-b-pb>dec-s8-oddfa-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oddfa/dec-s8-oddfa-a-pb>dec-s8-oddfa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 TC08 System Handler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oddta>dec-s8-oddta</a></td>
<td><table>
<tr><td>dec-s8-oddta-b-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/12 LINCTape System Handler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-odlta>dec-s8-odlta</a></td>
<td><table>
<tr><td>dec-s8-odlta-b-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 RF08 Configure<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-odrfa>dec-s8-odrfa</a></td>
<td><table>
<tr><td>dec-s8-odrfa-b-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-odrfa/dec-s8-odrfa-b-pb>dec-s8-odrfa-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-odrfa/dec-s8-odrfa-a-pb>dec-s8-odrfa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 RK8 Configure<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-odrka>dec-s8-odrka</a></td>
<td><table>
<tr><td>dec-s8-odrka-b-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-odrka/dec-s8-odrka-b-pb>dec-s8-odrka-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-odrka/dec-s8-odrka-a-pb>dec-s8-odrka-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 TD8E System Handler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-odtda>dec-s8-odtda</a></td>
<td><table>
<tr><td>dec-s8-odtda-b-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Editor (EDIT)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oedta>dec-s8-oedta</a></td>
<td><table>
<tr><td>dec-s8-oedta-b-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oedta/dec-s8-oedta-b-pb>dec-s8-oedta-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 FORTRAN Library (LIB 8)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oliba>dec-s8-oliba</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oliba/dec-s8-oliba-b-pr>dec-s8-oliba-b-pr</td><td></a></td></tr>
<tr><td>dec-s8-oliba-a-pr</td><td></td></tr>
<tr><td>dec-s8-oliba-b-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Linking Loader<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ollda>dec-s8-ollda</a></td>
<td><table>
<tr><td>dec-s8-ollda-b-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ollda/dec-s8-ollda-b-pb>dec-s8-ollda-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Library Setup (LIBSET)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-olsta>dec-s8-olsta</a></td>
<td><table>
<tr><td>dec-s8-olsta-b-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-olsta/dec-s8-olsta-b-pb>dec-s8-olsta-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Monitor and Absolute Loader<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oos8a>dec-s8-oos8a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oos8a/dec-s8-oos8a-b-pb>dec-s8-oos8a-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oos8a/dec-s8-oos8a-a-pb>dec-s8-oos8a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 PAL 8 Assembler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-opala>dec-s8-opala</a></td>
<td><table>
<tr><td>dec-s8-opala-b-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-opala/dec-s8-opala-b-pb>dec-s8-opala-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 PIP<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-opipa>dec-s8-opipa</a></td>
<td><table>
<tr><td>dec-s8-opipa-b-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-opipa/dec-s8-opipa-b-pb>dec-s8-opipa-b-pb</td><td></a></td></tr>
<tr><td>dec-s8-opipa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 PIP-C<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-opipb>dec-s8-opipb</a></td>
<td><table>
<tr><td>dec-s8-opipb-a-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-opipb/dec-s8-opipb-a-d.pdf>dec-s8-opipb-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-opipb/dec-s8-opipb-a-pb>dec-s8-opipb-a-pb</td><td></a></td></tr>
<tr><td>dec-s8-opipb-a-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 TD8-E ROM System Handler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ortda>dec-s8-ortda</a></td>
<td><table>
<tr><td>dec-s8-ortda-b-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>RTS/8 Comb. Mode DECtape #1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ortsa>dec-s8-ortsa</a></td>
<td><table>
<tr><td>al-4624c / dec0s8-ortsa-c-uc1</td><td></td></tr>
<tr><td>al-c759c / dec0s8-ortsa-c-uc2</td><td>RTS/8 Comb. Mode DECtape #2</td></tr>
<tr><td>as-4625c / dec0s8-ortsa-c-yc1</td><td>RTS/8 Comb. Mode Floppy #1</td></tr>
<tr><td>as-4626c / dec0s8-ortsa-c-yc2</td><td>RTS/8 Comb. Mode Floppy #2</td></tr>
</table></td></tr>
<tr>
<td>OS/78 Users Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-os78a>dec-s8-os78a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-os78a/dec-s8-os78a-a-d.pdf>aa-5748a / dec-s8-os78a-a-d</td><td></a></td></tr>
<tr><td>ad-5748a / dec-s8-os78a-a-dn1</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 SABR Assembler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osaba>dec-s8-osaba</a></td>
<td><table>
<tr><td>dec-s8-osaba-b-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osaba/dec-s8-osaba-b-pb>dec-s8-osaba-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osaba/dec-s8-osaba-b-pb1>dec-s8-osaba-b-pb1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osaba/dec-s8-osaba-b-pb2>dec-s8-osaba-b-pb2</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Source #1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osc1a>dec-s8-osc1a</a></td>
<td><table>
<tr><td>dec-s8-osc1a-b-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Source #2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osc2a>dec-s8-osc2a</a></td>
<td><table>
<tr><td>dec-s8-osc2a-b-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Source #3<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osc3a>dec-s8-osc3a</a></td>
<td><table>
<tr><td>dec-s8-osc3a-b-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Source #4<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osc4a>dec-s8-osc4a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osc4a/dec-s8-osc4a-b-uc>dec-s8-osc4a-b-uc</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Source #7<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osc7a>dec-s8-osc7a</a></td>
<td><table>
<tr><td>dec-s8-osc7a-a-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Source #8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osc8a>dec-s8-osc8a</a></td>
<td><table>
<tr><td>dec-s8-osc8a-a-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Source #9<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osc9a>dec-s8-osc9a</a></td>
<td><table>
<tr><td>dec-s8-osc9a-a-ua</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Getting on the Air<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osgab>dec-s8-osgab</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osgab/dec-s8-osgab-a-d.pdf>dec-s8-osgab-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Handbook<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oshba>dec-s8-oshba</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oshba/dec-s8-oshba-a-d.pdf>aa-4637a / dec-s8-oshba-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-oshba/dec-s8-oshba-a-dn4.pdf>ad-4647a / dec-s8-oshba-a-dn4</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Industrial BASIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osiba>dec-s8-osiba</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osiba/dec-s8-osiba-a-d.pdf>dec-s8-osiba-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 System Reference Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osrma>dec-s8-osrma</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osrma/dec-s8-osrma-a-d.pdf>dec-s8-osrma-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 V3D RELEASE NOTES<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osrna>dec-s8-osrna</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osrna/dec-s8-osrna-b-d.pdf>aa-4645b / dec-s8-osrna-b-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Software Support Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ossma>dec-s8-ossma</a></td>
<td><table>
<tr><td>dec-s8-ossma-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 V3C Software Support Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ossmb>dec-s8-ossmb</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ossmb/dec-s8-ossmb-b-d.pdf>aa-4646b / dec-s8-ossmb-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ossmb/dec-s8-ossmb-a-d.pdf>aa-4646a / dec-s8-ossmb-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 System Users Guide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osuma>dec-s8-osuma</a></td>
<td><table>
<tr><td>dec-s8-osuma-a-d</td><td></td></tr>
<tr><td>dec-s8-osuma-a-dn1</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 System DECTape<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysa>dec-s8-osysa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysa/dec-s8-osysa-b-uc>dec-s8-osysa-b-uc</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 VIII Base System<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb>dec-s8-osysb</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pa>dec-s8-osysb-a-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pa1>dec-s8-osysb-a-pa1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pa2>dec-s8-osysb-a-pa2</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pa3>dec-s8-osysb-a-pa3</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pa4>dec-s8-osysb-a-pa4</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pa5>dec-s8-osysb-a-pa5</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pa6>dec-s8-osysb-a-pa6</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pa7>dec-s8-osysb-a-pa7</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pa8>dec-s8-osysb-a-pa8</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pa9>dec-s8-osysb-a-pa9</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb1>dec-s8-osysb-a-pb1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb10>dec-s8-osysb-a-pb10</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb11>dec-s8-osysb-a-pb11</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb12>dec-s8-osysb-a-pb12</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb13>dec-s8-osysb-a-pb13</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb14>dec-s8-osysb-a-pb14</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb15>dec-s8-osysb-a-pb15</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb16>dec-s8-osysb-a-pb16</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb17>dec-s8-osysb-a-pb17</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb18>dec-s8-osysb-a-pb18</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb19>dec-s8-osysb-a-pb19</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb2>dec-s8-osysb-a-pb2</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb20>dec-s8-osysb-a-pb20</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb21>dec-s8-osysb-a-pb21</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb22>dec-s8-osysb-a-pb22</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb23>dec-s8-osysb-a-pb23</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb24>dec-s8-osysb-a-pb24</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb3>dec-s8-osysb-a-pb3</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb4>dec-s8-osysb-a-pb4</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb5>dec-s8-osysb-a-pb5</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb6>dec-s8-osysb-a-pb6</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb7>dec-s8-osysb-a-pb7</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb8>dec-s8-osysb-a-pb8</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pb9>dec-s8-osysb-a-pb9</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-osysb/dec-s8-osysb-a-pr>dec-s8-osysb-a-pr</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>12K TD8-E Bootstrap<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-otbsa>dec-s8-otbsa</a></td>
<td><table>
<tr><td>dec-s8-otbsa-b-pm</td><td></td></tr>
<tr><td>dec-s8-otbsa-a-pm</td><td>TD8-E Bootstrap (RIM) Tape</td></tr>
</table></td></tr>
<tr>
<td>TD8-E Initializer<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-otdia>dec-s8-otdia</a></td>
<td><table>
<tr><td>dec-s8-otdia-a-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>TD8-E Initializer (RIM) Tape<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-otina>dec-s8-otina</a></td>
<td><table>
<tr><td>dec-s8-otina-a-pm</td><td></td></tr>
</table></td></tr>
<tr>
<td>COGO-8 Double Precision<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-scdpa>dec-s8-scdpa</a></td>
<td><table>
<tr><td>dec-s8-scdpa-a-ua</td><td></td></tr>
<tr><td>dec-s8-scdpa-a-ub</td><td></td></tr>
</table></td></tr>
<tr>
<td>COGO-8 Source<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-scgla>dec-s8-scgla</a></td>
<td><table>
<tr><td>dec-s8-scgla-a-la</td><td></td></tr>
</table></td></tr>
<tr>
<td>COGO-8 Reference Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-scgma>dec-s8-scgma</a></td>
<td><table>
<tr><td>dec-s8-scgma-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>COGO-8 Single Precision<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-scspa>dec-s8-scspa</a></td>
<td><table>
<tr><td>dec-s8-scspa-a-ua</td><td></td></tr>
<tr><td>dec-s8-scspa-a-ub</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Bitmap<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ubita>dec-s8-ubita</a></td>
<td><table>
<tr><td>dec-s8-ubita-a-d</td><td></td></tr>
<tr><td>dec-s8-ubita-a-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ubita/dec-s8-ubita-a-pb>dec-s8-ubita-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Cassette Handler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ucasa>dec-s8-ucasa</a></td>
<td><table>
<tr><td>dec-s8-ucasa-a-d</td><td></td></tr>
<tr><td>dec-s8-ucasa-a-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ucasa/dec-s8-ucasa-a-pb1>dec-s8-ucasa-a-pb1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ucasa/dec-s8-ucasa-a-pb2>dec-s8-ucasa-a-pb2</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 VIII Extensions<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uexta>dec-s8-uexta</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uexta/dec-s8-uexta-a-uc>dec-s8-uexta-a-uc</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 VIII Extensions<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uextb>dec-s8-uextb</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uextb/dec-s8-uextb-a-pb1>dec-s8-uextb-a-pb1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uextb/dec-s8-uextb-a-pb2>dec-s8-uextb-a-pb2</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uextb/dec-s8-uextb-a-pb3>dec-s8-uextb-a-pb3</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uextb/dec-s8-uextb-a-pb4>dec-s8-uextb-a-pb4</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uextb/dec-s8-uextb-a-pb5>dec-s8-uextb-a-pb5</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uextb/dec-s8-uextb-a-pb6>dec-s8-uextb-a-pb6</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uextb/dec-s8-uextb-a-pb7>dec-s8-uextb-a-pb7</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uextb/dec-s8-uextb-a-pb8>dec-s8-uextb-a-pb8</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uextb/dec-s8-uextb-a-pb9>dec-s8-uextb-a-pb9</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uextb/dec-s8-uextb-a-pr>dec-s8-uextb-a-pr</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 FLAP & FPP FLAP Support Library<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ufpda>dec-s8-ufpda</a></td>
<td><table>
<tr><td>al-4766a / dec-s8-ufpda-a-uc</td><td></td></tr>
</table></td></tr>
<tr>
<td>FLAP (FPP ASSEMBLER)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-ufppa>dec-s8-ufppa</a></td>
<td><table>
<tr><td>aa-4767a / dec-s8-ufppa-a-d</td><td></td></tr>
<tr><td>ak-4768a / dec-s8-ufppa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>FPP-FLAP SUPPORT LIBRARY<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-umtha>dec-s8-umtha</a></td>
<td><table>
<tr><td>aa-4769a / dec-s8-umtha-a-d</td><td></td></tr>
<tr><td>ak-4770a / dec-s8-umtha-a-pa1</td><td></td></tr>
<tr><td>ak-4771a / dec-s8-umtha-a-pa2</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 EPIC (Edit, Patch, & Compare)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uptha>dec-s8-uptha</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uptha/dec-s8-uptha-b-d.pdf>dec-s8-uptha-b-d</td><td></a></td></tr>
<tr><td>dec-s8-uptha-a-d</td><td></td></tr>
<tr><td>dec-s8-uptha-a-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uptha/dec-s8-uptha-a-pb>dec-s8-uptha-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 RK8E System Handler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-urk8a>dec-s8-urk8a</a></td>
<td><table>
<tr><td>dec-s8-urk8a-a-la</td><td></td></tr>
<tr><td>dec-s8-urk8a-a-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-urk8a/dec-s8-urk8a-a-pb>dec-s8-urk8a-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 RK8E Non-System Handler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-urk8b>dec-s8-urk8b</a></td>
<td><table>
<tr><td>dec-s8-urk8b-a-la</td><td></td></tr>
<tr><td>dec-s8-urk8b-a-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-urk8b/dec-s8-urk8b-a-pb>dec-s8-urk8b-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 Source Compare (SRCCOM)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-usrca>dec-s8-usrca</a></td>
<td><table>
<tr><td>dec-s8-usrca-b-d</td><td></td></tr>
<tr><td>dec-s8-usrca-b-la</td><td></td></tr>
<tr><td>dec-s8-usrca-b-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-usrca/dec-s8-usrca-a-pb>dec-s8-usrca-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 TECO<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uteca>dec-s8-uteca</a></td>
<td><table>
<tr><td>dec-s8-uteca-a-d</td><td></td></tr>
<tr><td>dec-s8-uteca-a-la</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-uteca/dec-s8-uteca-a-pb>dec-s8-uteca-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 RK8E Handler Document<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-s8-xos8a>dec-s8-xos8a</a></td>
<td><table>
<tr><td>dec-s8-xos8a-b-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>TSS/8 Extended BASIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-ajz>dec-t8-ajz</a></td>
<td><table>
<a name='dec-t8'></a>
<tr><td>dec-t8-ajza-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>EDUSystem 50 ODTHI<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-coz>dec-t8-coz</a></td>
<td><table>
<tr><td>dec-t8-cozb-la</td><td></td></tr>
<tr><td>dec-t8-cozb-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>EDUSystem 50 EDIT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-eup>dec-t8-eup</a></td>
<td><table>
<tr><td>dec-t8-eupb-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>TSS/8 Monitor for the PDP-8, PDP-8/I<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-frf>dec-t8-frf</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-frf/dec-t8-frfa-d.pdf>dec-t8-frfa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>BASIC-8 for TSS/8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-kjz>dec-t8-kjz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-kjz/dec-t8-kjza-d.pdf>dec-t8-kjza-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>EDUSystem 50 Users Guide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-mbz>dec-t8-mbz</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-mbz/dec-t8-mbzb-d.pdf>dec-t8-mbzb-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TSS/8 Users Guide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-mrf>dec-t8-mrf</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-mrf/dec-t8-mrfb-d.pdf>dec-t8-mrfb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-mrf/dec-t8-mrfa-d.pdf>dec-t8-mrfa-d</td><td></a></td></tr>
<tr><td>dec-t8-mrfc-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>EDUSystem 50 COPY<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-pzf>dec-t8-pzf</a></td>
<td><table>
<tr><td>dec-t8-pzfb-ps</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-pzf/dec-t8-pzfb-pb>dec-t8-pzfb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>EDUSystem 50 CAT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-yrz>dec-t8-yrz</a></td>
<td><table>
<tr><td>dec-t8-yrzb-la</td><td></td></tr>
<tr><td>dec-t8-yrzb-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>EDUSystem 50 LOGID<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-ywf>dec-t8-ywf</a></td>
<td><table>
<tr><td>dec-t8-ywfb-la</td><td></td></tr>
<tr><td>dec-t8-ywfb-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>EDUSystem 50 LOGOUT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/dec-t8-ywz>dec-t8-ywz</a></td>
<td><table>
<tr><td>dec-t8-ywzb-la</td><td></td></tr>
<tr><td>dec-t8-ywzb-ps</td><td></td></tr>
</table></td></tr>
<tr>
<td>Single Precision Multiply Routine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-5-2b-a>digital-5-2b-a</a></td>
<td><table>
<a name='digital-5'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-5-2b-a/digital-5-2b-a-pa>digital-5-2b-a-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Double Precision Integer Multiply<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-5-33b-a>digital-5-33b-a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-5-33b-a/digital-5-33b-a-pa>digital-5-33b-a-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Double Precision Integer Divide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-5-34-a>digital-5-34-a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-5-34-a/digital-5-34-a-pa>digital-5-34-a-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>BCD to Binary Conversion<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-5-4-a>digital-5-4-a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-5-4-a/digital-5-4-a-pa>digital-5-4-a-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Symbolic Editor Programming Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-1-s>digital-8-1-s</a></td>
<td><table>
<a name='digital-8'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-1-s/digital-8-1-s-d.pdf>digital-8-1-s-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Read-In-Mode Loader (dec-08-lraa)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-1-u>digital-8-1-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-1-u/digital-8-1-u-d.pdf>digital-8-1-u-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Calculator<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-10-s>digital-8-10-s</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-10-s/digital-8-10-s-d.pdf>digital-8-10-s-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>BCD Binary Conversion Routines<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-10-u>digital-8-10-u</a></td>
<td><table>
<tr><td>digital-8-10-u-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-10-u/digital-8-10-u-d.pdf>digital-8-10-u-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Single Precision Multiply Routine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-11-f>digital-8-11-f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-11-f/digital-8-11-f-pa>digital-8-11-f-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DATAK Programming Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-11-s>digital-8-11-s</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-11-s/digital-8-11-s-d.pdf>digital-8-11-s-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Double Precision BCD to Binary Conversion Routine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-11-u>digital-8-11-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-11-u/digital-8-11-u-d.pdf>digital-8-11-u-d</td><td></a></td></tr>
<tr><td>digital-8-11-u-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Signed Single Precision Divide Routine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-12-f>digital-8-12-f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-12-f/digital-8-12-f-pa>digital-8-12-f-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>ODT-II Revised<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-12-s>digital-8-12-s</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-12-s/digital-8-12-s-d.pdf>digital-8-12-s-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-12-s/digital-8-12-s-pb>digital-8-12-s-pb</td><td> (low)</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-12-s/digital-8-12-s-h-pb>digital-8-12-s-h-pb</td><td> (high)</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-12-s/digital-8-12-s-l-pb>digital-8-12-s-l-pb</td><td> (low)</a></td></tr>
</table></td></tr>
<tr>
<td>Incremental Plotter Subroutines<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-12-u>digital-8-12-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-12-u/digital-8-12-u-d.pdf>aa-4968a / digital-8-12-u-d</td><td></a></td></tr>
<tr><td>ak-4970a / digital-8-12-u-pb</td><td></td></tr>
<tr><td>digital-8-12-u-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Signed Double Precision Multiply Routine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-13-f>digital-8-13-f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-13-f/digital-8-13-f-pa>digital-8-13-f-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>One Dimensional Display and Analysis<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-13-s>digital-8-13-s</a></td>
<td><table>
<tr><td>digital-8-13-s-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>Double Precision Divide Subroutine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-14-f>digital-8-14-f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-14-f/digital-8-14-f-pa>digital-8-14-f-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Multianalyser Programs<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-14-s>digital-8-14-s</a></td>
<td><table>
<tr><td>digital-8-14-s-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Binary to BCD Conversion Routine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-14-u>digital-8-14-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-14-u/digital-8-14-u-pa>digital-8-14-u-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-14-u/digital-8-14-u-d.pdf>digital-8-14-u-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Single Precision Sine Routine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-15-f>digital-8-15-f</a></td>
<td><table>
<tr><td>digital-8-15-f</td><td></td></tr>
</table></td></tr>
<tr>
<td>Oceanographic Analysis<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-15-s>digital-8-15-s</a></td>
<td><table>
<tr><td>digital-8-15-s-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Binary to BCD Conversion Routine (4 Digit)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-15-u>digital-8-15-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-15-u/digital-8-15-u-pa>digital-8-15-u-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Double Precision Sine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-16-f>digital-8-16-f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-16-f/digital-8-16-f-pa>digital-8-16-f-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Master Tape Duplicator<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-16-s>digital-8-16-s</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-16-s/digital-8-16-s-d.pdf>digital-8-16-s-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-16-s/digital-8-16-s-pb>digital-8-16-s-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Binary to BCD Conversion (IBM Magtape format)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-16-u>digital-8-16-u</a></td>
<td><table>
<tr><td>digital-8-16-u-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>EAE Instruction Set Simulator<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-17-u>digital-8-17-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-17-u/digital-8-17-u-pa>digital-8-17-u-pa</td><td></a></td></tr>
<tr><td>digital-8-17-u-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>Double Precision Cosine Subroutine<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-18-f>digital-8-18-f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-18-f/digital-8-18-f-pa>digital-8-18-f-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Alphanumeric Message Typeout<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-18-u>digital-8-18-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-18-u/digital-8-18-u-pa>digital-8-18-u-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-18-u/digital-8-18-u-d.pdf>digital-8-18-u-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Teletype Output Subroutines<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-19-u>digital-8-19-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-19-u/digital-8-19-u-pa>digital-8-19-u-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-19-u/digital-8-19-u-d.pdf>digital-8-19-u-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FORTRAN<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-2-s>digital-8-2-s</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-2-s/digital-8-2-s-fc-pb>digital-8-2-s-fc-pb</td><td> Compiler</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-2-s/digital-8-2-s-pb>digital-8-2-s-pb</td><td> Runtime</a></td></tr>
</table></td></tr>
<tr>
<td>BINARY LOADER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-2-u>digital-8-2-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-2-u/digital-8-2-u-pm>digital-8-2-u-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Four-Word Floating-Point Package<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-20-f>digital-8-20-f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-20-f/digital-8-20-f-d.pdf>digital-8-20-f-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-20-f/digital-8-20-f-pb>digital-8-20-f-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Character String Type-out<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-20-u>digital-8-20-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-20-u/digital-8-20-u-pa>digital-8-20-u-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-20-u/digital-8-20-u-d.pdf>digital-8-20-u-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Signed Single Precision Multiply<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-21-f>digital-8-21-f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-21-f/digital-8-21-f-pa>digital-8-21-f-pa</td><td></a></td></tr>
<tr><td>digital-8-21-f-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>Symbolic Tape Format Generator<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-21-u>digital-8-21-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-21-u/digital-8-21-u-d.pdf>digital-8-21-u-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-21-u/digital-8-21-u-pb>digital-8-21-u-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Signed Single Precision Divide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-22-f>digital-8-22-f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-22-f/digital-8-22-f-pa>digital-8-22-f-pa</td><td></a></td></tr>
<tr><td>digital-8-22-f-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>Unsigned Decimal Print<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-22-u>digital-8-22-u</a></td>
<td><table>
<tr><td>digital-8-22-u-pa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-22-u/digital-8-22-u-d.pdf>digital-8-22-u-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Double Precision Multiply (EAE Version)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-23-f>digital-8-23-f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-23-f/digital-8-23-f-pa>digital-8-23-f-pa</td><td></a></td></tr>
<tr><td>digital-8-23-f-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>Signed Decimal Print, Single Precision<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-23-u>digital-8-23-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-23-u/digital-8-23-u-d.pdf>digital-8-23-u-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Unsigned Decimal Print, Double Precision<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-24-u>digital-8-24-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-24-u/digital-8-24-u-pa>digital-8-24-u-pa</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-24-u/digital-8-24-u-d.pdf>digital-8-24-u-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>EAE Floating Point Package<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-25-f>digital-8-25-f</a></td>
<td><table>
<tr><td>digital-8-25-f-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-25-f/digital-8-25-f-pb>digital-8-25-f-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-25-f/digital-8-25-f-pb1>digital-8-25-f-pb1</td><td>, Basic System</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-25-f/digital-8-25-f-pb2>digital-8-25-f-pb2</td><td>, Interpreter, I/O</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-25-f/digital-8-25-f-pb3>digital-8-25-f-pb3</td><td>, Int., I/O, Functions</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-25-f/digital-8-25-f-pb4>digital-8-25-f-pb4</td><td>, Int., I/O, Functions</a></td></tr>
</table></td></tr>
<tr>
<td>Signed Decimal Print, Double Precision<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-25-u>digital-8-25-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-25-u/digital-8-25-u-d.pdf>digital-8-25-u-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-25-u/digital-8-25-u-pa>digital-8-25-u-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DECTOG<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-26-u>digital-8-26-u</a></td>
<td><table>
<tr><td>digital-8-26-u-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DECtape Subroutines<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-27-u>digital-8-27-u</a></td>
<td><table>
<tr><td>digital-8-27-u-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Single Decimal to Binary Conversion and ASR-33 Input<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-28-u>digital-8-28-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-28-u/digital-8-28-u-d.pdf>digital-8-28-u-d</td><td></a></td></tr>
<tr><td>digital-8-28-u-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Double Decimal to Binary Conversion and ASR-33 Input<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-29-u>digital-8-29-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-29-u/digital-8-29-u-d.pdf>digital-8-29-u-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-29-u/digital-8-29-u-pa>digital-8-29-u-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PAL III (dec-08-asaa)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-3-s>digital-8-3-s</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-3-s/digital-8-3-s-pb>digital-8-3-s-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DECtape System Loader<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-3-u>digital-8-3-u</a></td>
<td><table>
<tr><td>digital-8-3-u-pa</td><td></td></tr>
</table></td></tr>
<tr>
<td>Binary Punch (6 Channel)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-32-u>digital-8-32-u</a></td>
<td><table>
<tr><td>digital-8-32-u</td><td></td></tr>
</table></td></tr>
<tr>
<td>DECtape Formatter<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-33-u>digital-8-33-u</a></td>
<td><table>
<tr><td>digital-8-33-u-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DECtape Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-34-u>digital-8-34-u</a></td>
<td><table>
<tr><td>digital-8-34-u-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>680 Character Assembly Routines<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-35-s>digital-8-35-s</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-35-s/digital-8-35-s-d1.pdf>digital-8-35-s-d1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-35-s/digital-8-35-s-d2.pdf>digital-8-35-s-d2</td><td>8 Bit 680 Character Assembly Routines</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-35-s/digital-8-35-s-pa1>digital-8-35-s-pa1</td><td>5 Bit 680 Character Assembly Routines</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-35-s/digital-8-35-s-pa2>digital-8-35-s-pa2</td><td>8 Bit 680 Character Assembly Routines</a></td></tr>
</table></td></tr>
<tr>
<td>DDT (Dynamic Debugger)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-4-s>digital-8-4-s</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-4-s/digital-8-4-s-pb>digital-8-4-s-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Read-In-Mode (RIM) Punch<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-4-u>digital-8-4-u</a></td>
<td><table>
<tr><td>digital-8-4-u-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Floating Point Package<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-5-s>digital-8-5-s</a></td>
<td><table>
<tr><td>digital-8-5-s-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-5-s/digital-8-5-s-pb1>digital-8-5-s-pb1</td><td> #1, BASIC SYSTEM</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-5-s/digital-8-5-s-pb2>digital-8-5-s-pb2</td><td> #2, INTERPRETER;I/O;I/O CONTROLLER</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-5-s/digital-8-5-s-pb3>digital-8-5-s-pb3</td><td> #3, INTERPRETER;I/O; FUNCTIONS</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-5-s/digital-8-5-s-pb4>digital-8-5-s-pb4</td><td> #4, INTERPRETER;I/O;I/O CONTROLLER;</a></td></tr>
</table></td></tr>
<tr>
<td>Binary Punch<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-5-u>digital-8-5-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-5-u/digital-8-5-u-d.pdf>digital-8-5-u-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-5-u/digital-8-5-u-pb>digital-8-5-u-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Fortran Symbol Print<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-6-s>digital-8-6-s</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-6-s/digital-8-6-s-pb>digital-8-6-s-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Octal Memory Dump<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-6-u>digital-8-6-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-6-u/digital-8-6-u-d.pdf>digital-8-6-u-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DECtape Programming Manual<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-7-s>digital-8-7-s</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-7-s/digital-8-7-s-d.pdf>digital-8-7-s-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Logical Subroutines<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-7-u>digital-8-7-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-7-u/digital-8-7-u-pa>digital-8-7-u-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MACRO-8 Assembler<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-8-s>digital-8-8-s</a></td>
<td><table>
<tr><td>digital-8-8-s-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Arithmetic Shift Subroutines, Single and Double Precision<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-8-u>digital-8-8-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-8-u/digital-8-8-u-pa>digital-8-8-u-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Square Root<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-9-f>digital-8-9-f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-9-f/digital-8-9-f-pa>digital-8-9-f-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DECtape FORTRAN<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-9-s>digital-8-9-s</a></td>
<td><table>
<tr><td>digital-8-9-s-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Logical Shift Right Subroutines<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-9-u>digital-8-9-u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/digital-8-9-u/digital-8-9-u-pa>digital-8-9-u-pa</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LABB-8 Paper Tape System Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-08-labpa>libkit-08-labpa</a></td>
<td><table>
<a name='libkit-08'></a>
<tr><td>libkit-08-labpa-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>RTPS Fortran IV Binary Paper Tape Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-08-lfoda>libkit-08-lfoda</a></td>
<td><table>
<tr><td>libkit-08-lfoda-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>RTPS Fortran IV Binary LINCTape Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-08-lfola>libkit-08-lfola</a></td>
<td><table>
<tr><td>libkit-08-lfola-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>RTPS Fortran IV Binary DECTape Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-08-lfota>libkit-08-lfota</a></td>
<td><table>
<tr><td>libkit-08-lfota-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>Mass Storage DECTape Tape Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-08-lmsda>libkit-08-lmsda</a></td>
<td><table>
<tr><td>libkit-08-lmsda-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>Mass Storage Source Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-08-lmsds>libkit-08-lmsds</a></td>
<td><table>
<tr><td>libkit-08-lmsds-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>Mass Storage Paper Tape Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-08-lmspa>libkit-08-lmspa</a></td>
<td><table>
<tr><td>libkit-08-lmspa-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>LAB-8/E Listing Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-08-lptlt>libkit-08-lptlt</a></td>
<td><table>
<tr><td>libkit-08-lptlt-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>TM8E Diagnostic Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-08-tm8ea>libkit-08-tm8ea</a></td>
<td><table>
<tr><td>libkit-08-tm8ea-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>VT8E Diagnostic Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-08-vt8ea>libkit-08-vt8ea</a></td>
<td><table>
<tr><td>libkit-08-vt8ea-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>FPP Software Package<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-12-uflt>libkit-12-uflt</a></td>
<td><table>
<a name='libkit-12'></a>
<tr><td>libkit-12-uflta-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8/E/F/M Diagnostic Software Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-8e-bas>libkit-8e-bas</a></td>
<td><table>
<a name='libkit-8e'></a>
<tr><td>libkit-8e-base-a</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8/E/F/M System Software Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-8e-xba>libkit-8e-xba</a></td>
<td><table>
<tr><td>libkit-8e-xbas-a</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 VII Extension Binary DECTape Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-s8-extda>libkit-s8-extda</a></td>
<td><table>
<a name='libkit-s8'></a>
<tr><td>libkit-s8-extda-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 VII Extension Binary LINCTape Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-s8-extla>libkit-s8-extla</a></td>
<td><table>
<tr><td>libkit-s8-extla-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 VII Extension Binary Paper Tape Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-s8-extpa>libkit-s8-extpa</a></td>
<td><table>
<tr><td>libkit-s8-extpa-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 VII Binary Paper Tape Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-s8-gs8pa>libkit-s8-gs8pa</a></td>
<td><table>
<tr><td>libkit-s8-gs8pa-b-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 VII Binary DECTape Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-s8-os8da>libkit-s8-os8da</a></td>
<td><table>
<tr><td>libkit-s8-os8da-b-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 VII Binary LINCTape Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-s8-os8la>libkit-s8-os8la</a></td>
<td><table>
<tr><td>libkit-s8-os8la-b-k</td><td></td></tr>
<tr><td>libkit-s8-os8la-a-k</td><td>OS/12 LINCtape Kit</td></tr>
</table></td></tr>
<tr>
<td>System Exerciser Paper Tape Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-x8-diqaa>libkit-x8-diqaa</a></td>
<td><table>
<a name='libkit-x8'></a>
<tr><td>libkit-x8-diqaa-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>System Exerciser DECTape Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-x8-diqba>libkit-x8-diqba</a></td>
<td><table>
<tr><td>libkit-x8-diqba-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>System Exerciser LINCTape Kit<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/libkit-x8-diqca>libkit-x8-diqca</a></td>
<td><table>
<tr><td>libkit-x8-diqca-a-k</td><td></td></tr>
</table></td></tr>
<tr>
<td>ALL ZEROS TEST TAPE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-00-d2g1>maindec-00-d2g1</a></td>
<td><table>
<a name='maindec-00'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-00-d2g1/maindec-00-d2g1-pt>ak-5800a / maindec-00-d2g1-pt</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>ONES AND ZEROS TEST TAPE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-00-d2g2>maindec-00-d2g2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-00-d2g2/maindec-00-d2g2-pt>ak-5801a / maindec-00-d2g2-pt</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>BINARY COUNT PATTERN TEST TAPE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-00-d2g3>maindec-00-d2g3</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-00-d2g3/maindec-00-d2g3-pt>ak-5802a / maindec-00-d2g3-pt</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>SPECIAL BINARY COUNT PATTERN TEST TAPE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-00-d2g4>maindec-00-d2g4</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-00-d2g4/maindec-00-d2g4-pt>ak-5803a / maindec-00-d2g4-pt</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MARK SENSE ALPHA CARD DECK SRC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-00-dzcma>maindec-00-dzcma</a></td>
<td><table>
<tr><td>at-5804a / maindec-00-dzcma-a-ca</td><td></td></tr>
<tr><td>at-5805a / maindec-00-dzcma-a-cb</td><td>MARK SENSE ALPHA CARD DECK BIN</td></tr>
<tr><td>at-5806a / maindec-00-dzcma-a-co</td><td>MARK SENSE ALPHA CARD DECK OPTICAL</td></tr>
</table></td></tr>
<tr>
<td>CM8F Optical Mark Sense Card Deck<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-00-dzcmb>maindec-00-dzcmb</a></td>
<td><table>
<tr><td>maindec-00-dzcmb-a-co</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Instruction Test 1 (same as 8I-D01C)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d01>maindec-08-d01</a></td>
<td><table>
<a name='maindec-08'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d01/maindec-08-d01c-d.pdf>maindec-08-d01c-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d01/maindec-08-d01c-pb>maindec-08-d01c-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d01/maindec-08-d01b-d.pdf>maindec-08-d01b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d01/maindec-08-d01b-pb>maindec-08-d01b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d01/maindec-08-d01a-d.pdf>maindec-08-d01a-d</td><td>PDP-8 Instruction Test 1 (replaces maindec-801-2a)</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d01/maindec-08-d01a-pb>maindec-08-d01a-pb</td><td>PDP-8 Instruction Test 1 (replaces maindec-801-2a)</a></td></tr>
</table></td></tr>
<tr>
<td>INSTRUCTION TEST PART 2B<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d02>maindec-08-d02</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d02/maindec-08-d02b-d.pdf>ac-5810b / maindec-08-d02b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d02/maindec-08-d02b-pb>ak-5812b / maindec-08-d02b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Basic JMP-JMS Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d03>maindec-08-d03</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d03/maindec-08-d03a-d.pdf>ac-c007a / maindec-08-d03a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d03/maindec-08-d03a-pb>ak-c009a / maindec-08-d03a-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d03/maindec-08-d03a-pb1>maindec-08-d03a-pb1</td><td> (Store HLTs)</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d03/maindec-08-d03a-pb2>maindec-08-d03a-pb2</td><td> (Test Program)</a></td></tr>
</table></td></tr>
<tr>
<td>RANDOM JMP TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d04>maindec-08-d04</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d04/maindec-08-d04b-d.pdf>ac-5813b / maindec-08-d04b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d04/maindec-08-d04b-pb>ak-5815b / maindec-08-d04b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RANDOM JMP-JMS TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d05>maindec-08-d05</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d05/maindec-08-d05b-d.pdf>ac-5816b / maindec-08-d05b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d05/maindec-08-d05b-pb>ak-5818b / maindec-08-d05b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RANDOM ISZ TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d07>maindec-08-d07</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d07/maindec-08-d07b-d.pdf>ac-5819b / maindec-08-d07b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d07/maindec-08-d07b-pb>ak-5821b / maindec-08-d07b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Instruction Test, part 3A (EAE)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d0a>maindec-08-d0a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d0a/maindec-08-d0aa-pb>maindec-08-d0aa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Instruction Test (EAE) Part 3B<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d0b>maindec-08-d0b</a></td>
<td><table>
<tr><td>maindec-08-d0ba-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Memory Address Test (renamed to 08-D1B0)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d11>maindec-08-d11</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d11/maindec-08-d11a-d.pdf>maindec-08-d11a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d11/maindec-08-d11a-pb1>maindec-08-d11a-pb1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d11/maindec-08-d11a-pb2>maindec-08-d11a-pb2</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Memory Power On/Off Test (replaces maindec-829)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1a>maindec-08-d1a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1a/maindec-08-d1ac-d.pdf>ac-5822c / maindec-08-d1ac-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1a/maindec-08-d1ac-pb>ak-5824c / maindec-08-d1ac-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Memory Address Test (replaces 08-D11A)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1b0>maindec-08-d1b0</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1b0/maindec-08-d1b0-d.pdf>maindec-08-d1b0-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Memory Address Test (Low)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1b1>maindec-08-d1b1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1b1/maindec-08-d1b1-pb>maindec-08-d1b1-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1b1/maindec-08-d1b1-pm>maindec-08-d1b1-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Memory Address Test (High)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1b2>maindec-08-d1b2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1b2/maindec-08-d1b2-pm>maindec-08-d1b2-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>EXTENDED MEMORY CHECKERBOARD<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1e>maindec-08-d1e</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1e/maindec-08-d1ec-d.pdf>ac-5825c / maindec-08-d1ec-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1e/maindec-08-d1ec-pb>ak-5828c / maindec-08-d1ec-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1e/maindec-08-d1eb-d.pdf>maindec-08-d1eb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1e/maindec-08-d1eb-pb>maindec-08-d1eb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8, 8/I, 8/S Extended Memory Control Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1g>maindec-08-d1g</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1g/maindec-08-d1gb-d.pdf>maindec-08-d1gb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1g/maindec-08-d1gb-pb>maindec-08-d1gb-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1g/maindec-08-d1gd-d.pdf>maindec-08-d1gd-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1g/maindec-08-d1gd-pb>maindec-08-d1gd-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>EXTENDED MEMORY ADDRESS TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1h>maindec-08-d1h</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1h/maindec-08-d1ha-d.pdf>ac-5829a / maindec-08-d1ha-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1h/maindec-08-d1ha-pb>ak-5831a / maindec-08-d1ha-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KP8I POWER FAIL TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1k>maindec-08-d1k</a></td>
<td><table>
<tr><td>ac-5832b / maindec-08-d1kb-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1k/maindec-08-d1kb-pb>ak-5835b / maindec-08-d1kb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8, 8/I BASIC CHECKERBOARD<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1l0>maindec-08-d1l0</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1l0/maindec-08-d1l0-d.pdf>ac-5836a / maindec-08-d1l0-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8, 8/I BASIC CHECKERBOARD (LOW)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1l1>maindec-08-d1l1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1l1/maindec-08-d1l1-pm>ak-5838a / maindec-08-d1l1-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8, 8/I BASIC CHECKERBOARD (HIGH)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1l2>maindec-08-d1l2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1l2/maindec-08-d1l2-pb>ak-5839a / maindec-08-d1l2-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1l2/maindec-08-d1l2-pm>ak-5839a / maindec-08-d1l2-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MEMORY ADDRESS TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1m>maindec-08-d1m</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1m/maindec-08-d1ma-d.pdf>ac-5840a / maindec-08-d1ma-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1m/maindec-08-d1ma-pm1>ak-5846a / maindec-08-d1ma-pm1</td><td> (LOW)</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1m/maindec-08-d1ma-pm2>ak-5847a / maindec-08-d1ma-pm2</td><td> (HIGH)</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1m/maindec-08-d1ma-pb1>maindec-08-d1ma-pb1</td><td> (LOW)</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d1m/maindec-08-d1ma-pb2>maindec-08-d1ma-pb2</td><td> (HIGH)</a></td></tr>
</table></td></tr>
<tr>
<td>FAMILY OF 8 TELETYPE TESTS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d2a>maindec-08-d2a</a></td>
<td><table>
<tr><td>ac-5848a / maindec-08-d2aa-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d2a/maindec-08-d2aa-pb>ak-5855a / maindec-08-d2aa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FAMILY OF 8 HSR/HSP TESTS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d2g>maindec-08-d2g</a></td>
<td><table>
<tr><td>ac-5860f / maindec-08-d2gf-d</td><td></td></tr>
<tr><td>ak-5863f / maindec-08-d2gf-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>645A Line Printer Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d2l>maindec-08-d2l</a></td>
<td><table>
<tr><td>maindec-08-d2la-d</td><td></td></tr>
<tr><td>maindec-08-d2la-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CR01C CARD READER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d2n>maindec-08-d2n</a></td>
<td><table>
<tr><td>ac-5872b / maindec-08-d2nb-d</td><td></td></tr>
<tr><td>ak-5875b / maindec-08-d2nb-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CR03 Card Reader Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d2o>maindec-08-d2o</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d2o/maindec-08-d2oh-pb>maindec-08-d2oh-pb</td><td></a></td></tr>
<tr><td>maindec-08-d2oa-d</td><td></td></tr>
<tr><td>maindec-08-d2oa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>FAMILY OF 8 ASR 33/35 TTY TEST 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d2p>maindec-08-d2p</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d2p/maindec-08-d2pe-d.pdf>ac-5880e / maindec-08-d2pe-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d2p/maindec-08-d2pe-pb>ak-5885e / maindec-08-d2pe-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FAMILY OF 8 ASR 33/35 TTY TEST 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d2q>maindec-08-d2q</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d2q/maindec-08-d2qd-d.pdf>ac-5886d / maindec-08-d2qd-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d2q/maindec-08-d2qd-pb>ak-5891d / maindec-08-d2qd-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PA60C, PA63 DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d2u>maindec-08-d2u</a></td>
<td><table>
<tr><td>ac-5892a / maindec-08-d2ua-d</td><td></td></tr>
<tr><td>ak-5895a / maindec-08-d2ua-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TC01 Basic Exerciser (Maindec 850)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d3b>maindec-08-d3b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d3b/maindec-08-d3bb-d.pdf>maindec-08-d3bb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d3b/maindec-08-d3bc-pb>maindec-08-d3bc-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TC01 EXTENDED MEMORY EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d3e>maindec-08-d3e</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d3e/maindec-08-d3eb-d.pdf>ac-5902b / maindec-08-d3eb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d3e/maindec-08-d3eb-pb>ak-5905b / maindec-08-d3eb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>INCREMENTAL TAPE DELAY TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d3f>maindec-08-d3f</a></td>
<td><table>
<tr><td>ac-5906c / maindec-08-d3fc-d</td><td></td></tr>
<tr><td>ak-5909c / maindec-08-d3fc-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TC01 RANDOM EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d3r>maindec-08-d3r</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d3r/maindec-08-d3ra-d.pdf>ac-5910a / maindec-08-d3ra-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d3r/maindec-08-d3ra-pb>ak-5915a / maindec-08-d3ra-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MEMORY PARITY CHECKERBOARD<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d4a0>maindec-08-d4a0</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d4a0/maindec-08-d4a0-d.pdf>ac-5920o / maindec-08-d4a0-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Memory Parity Checkerboard<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d4a1>maindec-08-d4a1</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d4a1/maindec-08-d4a1-pm>ak-5917a / maindec-08-d4a1-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MEMORY PARITY CHECKERBOARD<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d4a2>maindec-08-d4a2</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d4a2/maindec-08-d4a2-pm>ak-5920o / maindec-08-d4a2-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Extended Memory Parity Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d4b>maindec-08-d4b</a></td>
<td><table>
<tr><td>maindec-08-d4ba-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>8I 8L INCREMENTAL TAPE COMPATIBILITY TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d4c>maindec-08-d4c</a></td>
<td><table>
<tr><td>ac-5925b / maindec-08-d4cb-d</td><td></td></tr>
<tr><td>ak-5928b / maindec-08-d4cb-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>INCREMENTAL TAPE RELIABILITY TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d4d>maindec-08-d4d</a></td>
<td><table>
<tr><td>ac-5929a / maindec-08-d4da-d</td><td></td></tr>
<tr><td>ak-5934a / maindec-08-d4da-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>INCREMENTAL TAPE INSTRUCTION TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d4e>maindec-08-d4e</a></td>
<td><table>
<tr><td>ac-5935b / maindec-08-d4eb-d</td><td></td></tr>
<tr><td>ak-5941b / maindec-08-d4eb-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>INCREMENTAL TAPE RANDOM EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d4f>maindec-08-d4f</a></td>
<td><table>
<tr><td>ac-5942b / maindec-08-d4fb-d</td><td></td></tr>
<tr><td>ak-5946b / maindec-08-d4fb-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MAGNETIC RM08A DRUM TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5a>maindec-08-d5a</a></td>
<td><table>
<tr><td>ac-5947a / maindec-08-d5aa-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5a/maindec-08-d5aa-pb>ak-5950a / maindec-08-d5aa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DF32/DF32D Discless Logic Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5b>maindec-08-d5b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5b/maindec-08-d5bb-d.pdf>maindec-08-d5bb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5b/maindec-08-d5bb-pb>maindec-08-d5bb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DF32/DF32D Disc Data Mini Disk, Interface Address, Data Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5c>maindec-08-d5c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5c/maindec-08-d5cc-pb>maindec-08-d5cc-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5c/maindec-08-d5cd-pb>maindec-08-d5cd-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5c/maindec-08-d5ce-d.pdf>maindec-08-d5ce-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5c/maindec-08-d5ce-pb>maindec-08-d5ce-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5c/maindec-08-d5cg-pb>maindec-08-d5cg-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MULTI USER DISK EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5d>maindec-08-d5d</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5d/maindec-08-d5db-d.pdf>ac-5951b / maindec-08-d5db-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5d/maindec-08-d5db-pb>ak-5953b / maindec-08-d5db-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5d/maindec-08-d5da-pb>ak-5953a / maindec-08-d5da-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RF08 Disk Data (256K)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5e>maindec-08-d5e</a></td>
<td><table>
<tr><td>maindec-08-d5eb-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5e/maindec-08-d5eb-pb>maindec-08-d5eb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RF08 MULTI DISK TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5f>maindec-08-d5f</a></td>
<td><table>
<tr><td>ac-5954a / maindec-08-d5fa-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5f/maindec-08-d5fa-pb>ak-5956a / maindec-08-d5fa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RK8 DISK DATA RELIABILITY (RK01)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5h>maindec-08-d5h</a></td>
<td><table>
<tr><td>ac-5957c / maindec-08-d5hc-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5h/maindec-08-d5hc-pb>ak-5965c / maindec-08-d5hc-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RK8 Disk and Control Instruction Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5j>maindec-08-d5j</a></td>
<td><table>
<tr><td>maindec-08-d5jb-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5j/maindec-08-d5jb-pb>maindec-08-d5jb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RK8 DISK FORMATTER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5k>maindec-08-d5k</a></td>
<td><table>
<tr><td>ac-5974c / maindec-08-d5kb-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d5k/maindec-08-d5kb-pb>ak-5978b / maindec-08-d5kb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>CALCOMP PLOTTER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6c>maindec-08-d6c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6c/maindec-08-d6cc-d.pdf>ac-5980c / maindec-08-d6cc-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6c/maindec-08-d6cc-pb>ak-5982c / maindec-08-d6cc-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>A/D Calibration Check<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6g>maindec-08-d6g</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6g/maindec-08-d6gc-d.pdf>ac-5989c / maindec-08-d6gc-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6g/maindec-08-d6gc-pb>ak-5991c / maindec-08-d6gc-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AF04 DIAGNOSTIC & DEMO<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6h>maindec-08-d6h</a></td>
<td><table>
<tr><td>ac-5992a / maindec-08-d6ha-d</td><td></td></tr>
<tr><td>ak-5994a / maindec-08-d6ha-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AD08 DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6j>maindec-08-d6j</a></td>
<td><table>
<tr><td>ac-5998d / maindec-08-d6jd-d</td><td></td></tr>
<tr><td>ak-6000d / maindec-08-d6jd-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>VC8I, 34D DISPLAY TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6k>maindec-08-d6k</a></td>
<td><table>
<tr><td>ac-6001c / maindec-08-d6kc-d</td><td></td></tr>
<tr><td>ac-6001b / maindec-08-d6kb-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6k/maindec-08-d6kb-pb>ak-6067b / maindec-08-d6kb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>VS38 Display Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6m>maindec-08-d6m</a></td>
<td><table>
<tr><td>maindec-08-d6ma-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AM03/AM08 DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6q>maindec-08-d6q</a></td>
<td><table>
<tr><td>ac-6013a / maindec-08-d6qa-d</td><td></td></tr>
<tr><td>ak-6015a / maindec-08-d6qa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AA05/AA07 DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6t>maindec-08-d6t</a></td>
<td><table>
<tr><td>ac-6018a / maindec-08-d6ta-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6t/maindec-08-d6ta-pb>ak-6020a / maindec-08-d6ta-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AD01-A DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6u>maindec-08-d6u</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6u/maindec-08-d6ub-d.pdf>ac-6022b / maindec-08-d6ub-d</td><td></a></td></tr>
<tr><td>ak-6025b / maindec-08-d6ub-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AA-50 D/A CONVERTER DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6w>maindec-08-d6w</a></td>
<td><table>
<tr><td>ac-6026b / maindec-08-d6wb-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d6w/maindec-08-d6wb-pb>ak-6029b / maindec-08-d6wb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>680 DCS Expanded Static Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d71>maindec-08-d71</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d71/maindec-08-d71a-d.pdf>maindec-08-d71a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>680 DCS Data and Control Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d72>maindec-08-d72</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d72/maindec-08-d72a-d.pdf>maindec-08-d72a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d72/maindec-08-d72a-pb>maindec-08-d72a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Typeset and System Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d7c>maindec-08-d7c</a></td>
<td><table>
<tr><td>maindec-08-d7ca-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DK8E Clocks Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8a>maindec-08-d8a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8a/maindec-08-d8ac-pb>maindec-08-d8ac-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Online IBMS360 to DX08/9 Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8b>maindec-08-d8b</a></td>
<td><table>
<tr><td>maindec-08-d8ba-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Data Test for 636-B Communication Interface<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8c>maindec-08-d8c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8c/maindec-08-d8ca-pb>maindec-08-d8ca-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DP01A IOT+Data Tests (device code 3x)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8e>maindec-08-d8e</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8e/maindec-08-d8eb-pb>maindec-08-d8eb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DB88 TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8g>maindec-08-d8g</a></td>
<td><table>
<tr><td>ac-6059a / maindec-08-d8ga-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>DP01A Bit Synchronous IOT+Data Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8h>maindec-08-d8h</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8h/maindec-08-d8hb-pb>maindec-08-d8hb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DB08A TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8i>maindec-08-d8i</a></td>
<td><table>
<tr><td>ac-6062b / maindec-08-d8ib-d</td><td></td></tr>
<tr><td>ak-6064b / maindec-08-d8ib-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>VA38 Character Generator Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8m>maindec-08-d8m</a></td>
<td><table>
<tr><td>maindec-08-d8mb-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PT08 DATA PHONE TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8p>maindec-08-d8p</a></td>
<td><table>
<tr><td>ac-6069a / maindec-08-d8pa-d</td><td></td></tr>
<tr><td>ak-6071a / maindec-08-d8pa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DM01 EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8s>maindec-08-d8s</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8s/maindec-08-d8sc-d.pdf>ac-6078c / maindec-08-d8sc-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8s/maindec-08-d8sc-pb>ak-6083c / maindec-08-d8sc-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8s/maindec-08-d8sb-pb>ak-6083b / maindec-08-d8sb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>SIM 360/IBMS360 CHANNEL SIMULATOR<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8t>maindec-08-d8t</a></td>
<td><table>
<tr><td>ac-6084a / maindec-08-d8ta-d</td><td></td></tr>
<tr><td>ak-6090a / maindec-08-d8ta-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DX08 TO S360 EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8u>maindec-08-d8u</a></td>
<td><table>
<tr><td>ac-6091b / maindec-08-d8ub-d</td><td></td></tr>
<tr><td>ak-6094b / maindec-08-d8ub-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>KW08S Clock Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8v>maindec-08-d8v</a></td>
<td><table>
<tr><td>ac-6095b / maindec-08-d8vb-d</td><td></td></tr>
<tr><td>ak-6097b / maindec-08-d8vb-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DC02 DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8w>maindec-08-d8w</a></td>
<td><table>
<tr><td>ac-6098a / maindec-08-d8wa-d</td><td></td></tr>
<tr><td>ak-6100a / maindec-08-d8wa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>XOR Buffer Option Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d8x>maindec-08-d8x</a></td>
<td><table>
<tr><td>maindec-08-d8xa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TC58, TU20 DATA RELIABILITY (7 TRACK)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d9a>maindec-08-d9a</a></td>
<td><table>
<tr><td>ac-6104d / maindec-08-d9ad-d</td><td></td></tr>
<tr><td>ak-6115d / maindec-08-d9ad-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TC58, TU20 INSTRUCTION TEST 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d9e>maindec-08-d9e</a></td>
<td><table>
<tr><td>ac-6116c / maindec-08-d9ec-d</td><td></td></tr>
<tr><td>ak-6118c / maindec-08-d9ec-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TC58, TU20 DATA RELIABILITY (9 TRACK)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d9f>maindec-08-d9f</a></td>
<td><table>
<tr><td>ac-6119c / maindec-08-d9fc-d</td><td></td></tr>
<tr><td>ak-6128c / maindec-08-d9fc-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TC58, TU20 DATA RELIABILITY (9 TRACK)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d9g>maindec-08-d9g</a></td>
<td><table>
<tr><td>ac-6129a / maindec-08-d9ga-d</td><td></td></tr>
<tr><td>ak-6131a / maindec-08-d9ga-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DC04-C WIRE STORAGE INTERFACE DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d9i>maindec-08-d9i</a></td>
<td><table>
<tr><td>ac-6132a / maindec-08-d9ib-d</td><td></td></tr>
<tr><td>ak-6135b / maindec-08-d9ib-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Family of 8 Multi Break Device Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d9k>maindec-08-d9k</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d9k/maindec-08-d9ka-pb>maindec-08-d9ka-pb</td><td></a></td></tr>
<tr><td>maindec-08-d9ka-d</td><td>Multi Break Device Exerciser</td></tr>
</table></td></tr>
<tr>
<td>DP01 SYSTEM IOT AND DATA TEST 6301<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d9m>maindec-08-d9m</a></td>
<td><table>
<tr><td>ac-6140a / maindec-08-d9ma-d</td><td></td></tr>
<tr><td>ak-6143a / maindec-08-d9ma-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DP01 SYSTEM IOT AND DATA TEST 6501<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d9n>maindec-08-d9n</a></td>
<td><table>
<tr><td>ac-6144a / maindec-08-d9na-d</td><td></td></tr>
<tr><td>ak-6147a / maindec-08-d9na-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DP01 SYSTEM IOT AND DATA TEST 6601<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d9p>maindec-08-d9p</a></td>
<td><table>
<tr><td>ac-6148a / maindec-08-d9pa-d</td><td></td></tr>
<tr><td>ak-6153a / maindec-08-d9pa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DP01 SYSTEM IOT AND DATA TEST 6701<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-d9q>maindec-08-d9q</a></td>
<td><table>
<tr><td>ac-6154a / maindec-08-d9qa-d</td><td></td></tr>
<tr><td>ak-6157a / maindec-08-d9qa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>BM812-I TEST FOR PDP-8/I and PDP-12<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-ddbma>maindec-08-ddbma</a></td>
<td><table>
<tr><td>ac-6161a / maindec-08-ddbma-a-d</td><td></td></tr>
<tr><td>ak-6163a / maindec-08-ddbma-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>BM8/L Extended Memory Control Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-debma>maindec-08-debma</a></td>
<td><table>
<tr><td>ac-6165a / maindec-08-debma-a-d</td><td></td></tr>
<tr><td>ak-6167a / maindec-08-debma-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DR8-EA DIAGNOSTIC FOR TRADITIONAL PDP-8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dgdra>maindec-08-dgdra</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dgdra/maindec-08-dgdra-a-d.pdf>ac-6169a / maindec-08-dgdra-a-d</td><td></a></td></tr>
<tr><td>ak-6171a / maindec-08-dgdra-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>EXTENDED MEMORY CONTROL TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dgmca>maindec-08-dgmca</a></td>
<td><table>
<tr><td>ac-6173b / maindec-08-dgmca-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dgmca/maindec-08-dgmca-b-pb>ak-6175b / maindec-08-dgmca-b-pb</td><td></a></td></tr>
<tr><td>maindec-08-dgmca-a-pb</td><td>Extended Memory Control Test</td></tr>
</table></td></tr>
<tr>
<td>VT05 TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dgv5a>maindec-08-dgv5a</a></td>
<td><table>
<tr><td>ac-6177b / maindec-08-dgv5a-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dgv5a/maindec-08-dgv5a-b-pb>ak-6182b / maindec-08-dgv5a-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>COS 300 Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dh05b>maindec-08-dh05b</a></td>
<td><table>
<tr><td>maindec-08-dh05b-n-pb</td><td></td></tr>
<tr><td>an-6138u / maindec-08-dh05b-u-hb</td><td> (RK05)</td></tr>
</table></td></tr>
<tr>
<td>AD8E, AM8E A-D TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhada>maindec-08-dhada</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhada/maindec-08-dhada-a-d.pdf>ac-6184a / maindec-08-dhada-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhada/maindec-08-dhada-a-pb>ak-6186a / maindec-08-dhada-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>CDP8/GLC-8E DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhafa>maindec-08-dhafa</a></td>
<td><table>
<tr><td>ac-6188a / maindec-08-dhafa-a-d</td><td></td></tr>
<tr><td>ak-6190a / maindec-08-dhafa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AFC8 DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhafb>maindec-08-dhafb</a></td>
<td><table>
<tr><td>ac-6192a / maindec-08-dhafb-a-d</td><td></td></tr>
<tr><td>ac-6192a / maindec-08-dhafb-a-d</td><td></td></tr>
<tr><td>ak-6194a / maindec-08-dhafb-a-pb</td><td></td></tr>
<tr><td>ak-6194a / maindec-08-dhafb-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-9/E CASSETTE LOADER/BUILDER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhcaa>maindec-08-dhcaa</a></td>
<td><table>
<tr><td>ac-6196a / maindec-08-dhcaa-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhcaa/maindec-08-dhcaa-a-pb>ak-6198a / maindec-08-dhcaa-a-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhcaa/maindec-08-dhcaa-a-pb>ak-6198a / maindec-08-dhcaa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>CM8F (80 COLUMN) CARD READER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhcma>maindec-08-dhcma</a></td>
<td><table>
<tr><td>ac-6200a / maindec-08-dhcma-a-d</td><td></td></tr>
<tr><td>ak-6202a / maindec-08-dhcma-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CR8E/CR8F CARD READER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhcra>maindec-08-dhcra</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhcra/maindec-08-dhcra-a-d.pdf>ac-6204a / maindec-08-dhcra-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhcra/maindec-08-dhcra-a-pb>ak-6206a / maindec-08-dhcra-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DH8E HOST PROGRAM<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhdha>maindec-08-dhdha</a></td>
<td><table>
<tr><td>ac-6208a / maindec-08-dhdha-a-d</td><td></td></tr>
<tr><td>ak-6210a / maindec-08-dhdha-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DH8E BINARY LOADER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhdhb>maindec-08-dhdhb</a></td>
<td><table>
<tr><td>ac-6212a / maindec-08-dhdhb-a-d</td><td></td></tr>
<tr><td>ak-6214a / maindec-08-dhdhb-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DH8E REMOTE LOADER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhdhc>maindec-08-dhdhc</a></td>
<td><table>
<tr><td>ac-6216a / maindec-08-dhdhc-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhdhc/maindec-08-dhdhc-a-pb>ak-6218a / maindec-08-dhdhc-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AHDKAB0 DK8E Clocks Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhdka>maindec-08-dhdka</a></td>
<td><table>
<tr><td>ac-6220b / maindec-08-dhdka-b-d</td><td></td></tr>
<tr><td>ak-6222b / maindec-08-dhdka-b-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhdka/maindec-08-dhdka-a-d.pdf>ac-6220a / maindec-08-dhdka-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhdka/maindec-08-dhdka-a-pb>ak-6222a / maindec-08-dhdka-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DP8E Synchronous Modem Interface<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhdpa>maindec-08-dhdpa</a></td>
<td><table>
<tr><td>ac-6224d / maindec-08-dhdpa-d-d</td><td></td></tr>
<tr><td>ak-6227d / maindec-08-dhdpa-d-pb</td><td></td></tr>
<tr><td>ac-6224b / maindec-08-dhdpa-b-d</td><td></td></tr>
<tr><td>ak-6227b / maindec-08-dhdpa-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AHDRAC0 DR8-EA 12 Channel Interface<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhdra>maindec-08-dhdra</a></td>
<td><table>
<tr><td>ac-6229c / maindec-08-dhdra-c-d</td><td></td></tr>
<tr><td>ak-6231c / maindec-08-dhdra-c-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhdra/maindec-08-dhdra-a-d.pdf>ac-6229a / maindec-08-dhdra-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhdra/maindec-08-dhdra-a-pb>ak-6231a / maindec-08-dhdra-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DR8-ED EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhdrh>maindec-08-dhdrh</a></td>
<td><table>
<tr><td>ac-6233a / maindec-08-dhdrh-a-d</td><td></td></tr>
<tr><td>ak-6235a / maindec-08-dhdrh-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>ICS-8 FIELD TEST PROGRAM<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhica>maindec-08-dhica</a></td>
<td><table>
<tr><td>ac-6237a / maindec-08-dhica-a-d</td><td></td></tr>
<tr><td>ak-6239a / maindec-08-dhica-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>8E ADDER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkaa>maindec-08-dhkaa</a></td>
<td><table>
<tr><td>ac-6241b / maindec-08-dhkaa-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkaa/maindec-08-dhkaa-b-pb>ak-6243b / maindec-08-dhkaa-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkaa/maindec-08-dhkaa-a-d.pdf>maindec-08-dhkaa-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Random AND Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkab>maindec-08-dhkab</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkab/maindec-08-dhkab-a-d.pdf>maindec-08-dhkab-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkab/maindec-08-dhkab-a-pb>maindec-08-dhkab-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MM8E 4K MEMORY CHECKERBOARD<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkac>maindec-08-dhkac</a></td>
<td><table>
<tr><td>ac-6249a / maindec-08-dhkac-b-d</td><td></td></tr>
<tr><td>ak-6251a / maindec-08-dhkac-b-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkac/maindec-08-dhkac-a-pb>maindec-08-dhkac-a-pb</td><td>MM8E Memory Checkerboard</a></td></tr>
</table></td></tr>
<tr>
<td>MEMORY ADDRESS TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkad>maindec-08-dhkad</a></td>
<td><table>
<tr><td>ac-6253a / maindec-08-dhkad-b-d</td><td></td></tr>
<tr><td>ak-6255a / maindec-08-dhkad-b-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkad/maindec-08-dhkad-a-pb>maindec-08-dhkad-a-pb</td><td>Memory Address Test</a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8E Instruction Test Part 1 (replaces 8e-d0ab)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkaf>maindec-08-dhkaf</a></td>
<td><table>
<tr><td>ac-6257a / maindec-08-dhkaf-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkaf/maindec-08-dhkaf-a-pb>ak-6259a / maindec-08-dhkaf-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8E Instruction Test Part 2 (obsoletes 8e-d08b)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkag>maindec-08-dhkag</a></td>
<td><table>
<tr><td>ac-6261a / maindec-08-dhkag-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkag/maindec-08-dhkag-a-pb>ak-6263a / maindec-08-dhkag-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>EAE Memory Exerciser (replaces maindec-8e-dora)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkea>maindec-08-dhkea</a></td>
<td><table>
<tr><td>ac-6265b / maindec-08-dhkea-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkea/maindec-08-dhkea-b-pb>ak-6267b / maindec-08-dhkea-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkea/maindec-08-dhkea-a-d.pdf>ac-6265a / maindec-08-dhkea-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkea/maindec-08-dhkea-a-pb>ak-6267a / maindec-08-dhkea-a-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkea/maindec-08-dhkea-e-pb>ak-6267e / maindec-08-dhkea-e-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KE8-E EAE Instruction Test 1 (replaces 8e-d0lb)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkeb>maindec-08-dhkeb</a></td>
<td><table>
<tr><td>ac-6269b / maindec-08-dhkeb-b-d</td><td></td></tr>
<tr><td>ak-6271b / maindec-08-dhkeb-b-pb</td><td></td></tr>
<tr><td>maindec-08-dhkeb-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AHKECB0 KE8-E EAE Instruction Test 2 (replaces 8e-d0mb)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkec>maindec-08-dhkec</a></td>
<td><table>
<tr><td>ac-6273b / maindec-08-dhkec-b-d</td><td></td></tr>
<tr><td>ak-6275b / maindec-08-dhkec-b-pb</td><td></td></tr>
<tr><td>ac-6273a / maindec-08-dhkec-a-d</td><td></td></tr>
<tr><td>ak-6275a / maindec-08-dhkec-a-pb</td><td></td></tr>
<tr><td>al-6276a / maindec-08-dhkec-a-ub</td><td></td></tr>
</table></td></tr>
<tr>
<td>KG8-EA DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkga>maindec-08-dhkga</a></td>
<td><table>
<tr><td>ac-6277b / maindec-08-dhkga-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkga/maindec-08-dhkga-b-pb>ak-6279b / maindec-08-dhkga-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Double Buffered Async Interface Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkic>maindec-08-dhkic</a></td>
<td><table>
<tr><td>maindec-08-dhkic-c-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AHKLAB0 KL8M Modem Control<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkla>maindec-08-dhkla</a></td>
<td><table>
<tr><td>ac-6281b / maindec-08-dhkla-b-d</td><td></td></tr>
<tr><td>ak-6284b / maindec-08-dhkla-b-pb</td><td></td></tr>
<tr><td>ac-6281a / maindec-08-dhkla-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkla/maindec-08-dhkla-a-pb>ak-6284a / maindec-08-dhkla-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AHKLBC0 KL8M KL8E/F DC08 OnLine Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhklb>maindec-08-dhklb</a></td>
<td><table>
<tr><td>ac-6285c / maindec-08-dhklb-c-d</td><td></td></tr>
<tr><td>ak-6287c / maindec-08-dhklb-c-pb</td><td></td></tr>
<tr><td>ac-6285b / maindec-08-dhklb-b-d</td><td></td></tr>
<tr><td>ak-6287b / maindec-08-dhklb-b-pb</td><td></td></tr>
<tr><td>ac-6285a / maindec-08-dhklb-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhklb/maindec-08-dhklb-a-pb>ak-6287a / maindec-08-dhklb-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AHKLCE0 KL8F Async Interface<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhklc>maindec-08-dhklc</a></td>
<td><table>
<tr><td>ac-6289e / maindec-08-dhklc-e-d</td><td></td></tr>
<tr><td>ak-6292e / maindec-08-dhklc-e-pb</td><td></td></tr>
<tr><td>ac-6289d / maindec-08-dhklc-d-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhklc/maindec-08-dhklc-d-pb>ak-6292d / maindec-08-dhklc-d-pb</td><td></a></td></tr>
<tr><td>ac-6289c / maindec-08-dhklc-c-d</td><td></td></tr>
<tr><td>ak-6292c / maindec-08-dhklc-c-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhklc/maindec-08-dhklc-b-d.pdf>ac-6289b / maindec-08-dhklc-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhklc/maindec-08-dhklc-b-pb>ak-6292b / maindec-08-dhklc-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>8E Teletype & KL8 Asynch Control Test (formerly 8e-d2ac)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkld>maindec-08-dhkld</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkld/maindec-08-dhkld-a-d.pdf>ac-6294a / maindec-08-dhkld-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkld/maindec-08-dhkld-a-pb>ak-6296a / maindec-08-dhkld-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP8E EXTENDED MEMORY DATA & CHECKERBOARD<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkma>maindec-08-dhkma</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkma/maindec-08-dhkma-d-d.pdf>ac-6298d / maindec-08-dhkma-d-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkma/maindec-08-dhkma-c-d.pdf>ac-6298c / maindec-08-dhkma-c-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkma/maindec-08-dhkma-a-d.pdf>ac-6298c / maindec-08-dhkma-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkma/maindec-08-dhkma-d-pb>ak-6300d / maindec-08-dhkma-d-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkma/maindec-08-dhkma-c-pb>ak-6300c / maindec-08-dhkma-c-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkma/maindec-08-dhkma-b-pb>ak-6300b / maindec-08-dhkma-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkma/maindec-08-dhkma-a-pb>ak-6300a / maindec-08-dhkma-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP8E EXTENDED MEMORY ADDRESS TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkmc>maindec-08-dhkmc</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkmc/maindec-08-dhkmc-b-d.pdf>ac-6302b / maindec-08-dhkmc-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkmc/maindec-08-dhkmc-b-pb>ak-6304b / maindec-08-dhkmc-b-pb</td><td></a></td></tr>
<tr><td>ac-6302c / maindec-08-dhkmc-c-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkmc/maindec-08-dhkmc-c-pb>ak-6304c / maindec-08-dhkmc-c-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KP8E POWER FAIL/AUTO RESTART TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkpa>maindec-08-dhkpa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkpa/maindec-08-dhkpa-b-d.pdf>ac-6306b / maindec-08-dhkpa-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkpa/maindec-08-dhkpa-b-pb>ak-6308b / maindec-08-dhkpa-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RK8E/8L Data Reliability<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkrc>maindec-08-dhkrc</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhkrc/maindec-08-dhkrc-h-pb>maindec-08-dhkrc-h-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LC8E (LA30) CONTROL/EXERCISER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhlaa>maindec-08-dhlaa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhlaa/maindec-08-dhlaa-b-d.pdf>ac-6310b / maindec-08-dhlaa-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhlaa/maindec-08-dhlaa-b-pb>ak-6314b / maindec-08-dhlaa-b-pb</td><td></a></td></tr>
<tr><td>maindec-08-dhlaa-a-pb</td><td>DECwriter Control Exerciser</td></tr>
</table></td></tr>
<tr>
<td>LQP-8 PRINTER DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhlqa>maindec-08-dhlqa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhlqa/maindec-08-dhlqa-b-d.pdf>ac-6315b / maindec-08-dhlqa-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhlqa/maindec-08-dhlqa-b-pb>ak-6318b / maindec-08-dhlqa-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LQP-8 MULTIPLE PRINTER DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhlqb>maindec-08-dhlqb</a></td>
<td><table>
<tr><td>ac-6320b / maindec-08-dhlqb-b-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>LS8 Line Printer Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhlsa>maindec-08-dhlsa</a></td>
<td><table>
<tr><td>ac-6324c / maindec-08-dhlsa-b-d</td><td></td></tr>
<tr><td>ak-6326c / maindec-08-dhlsa-b-pb</td><td></td></tr>
<tr><td>maindec-08-dhlsa-c-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhlsa/maindec-08-dhlsa-a-d.pdf>maindec-08-dhlsa-a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>8E MEMORY EXTENSION & TIME SHARE TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhmca>maindec-08-dhmca</a></td>
<td><table>
<tr><td>ac-6328b / maindec-08-dhmca-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhmca/maindec-08-dhmca-b-pb>ak-6330b / maindec-08-dhmca-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhmca/maindec-08-dhmca-a-d.pdf>ac-6328a / maindec-08-dhmca-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhmca/maindec-08-dhmca-a-pb>ak-6330a / maindec-08-dhmca-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 DIAGNOSTIC MEDIUM<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhmea>maindec-08-dhmea</a></td>
<td><table>
<tr><td>ac-6332b / maindec-08-dhmea-b-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>8E EXTENDED MEMORY PARITY TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhmpa>maindec-08-dhmpa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhmpa/maindec-08-dhmpa-a-d.pdf>ac-6335a / maindec-08-dhmpa-a-d</td><td></a></td></tr>
<tr><td>ak-6338a / maindec-08-dhmpa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MR8-EC ROM CONTENTS TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhmra>maindec-08-dhmra</a></td>
<td><table>
<tr><td>ac-6339a / maindec-08-dhmra-a-d</td><td></td></tr>
<tr><td>ak-6342a / maindec-08-dhmra-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MR8-EA READ ONLY MEMORY TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhmrb>maindec-08-dhmrb</a></td>
<td><table>
<tr><td>ac-6343b / maindec-08-dhmrb-b-d</td><td></td></tr>
<tr><td>ak-6345b / maindec-08-dhmrb-b-pb1</td><td></td></tr>
<tr><td>ak-6346b / maindec-08-dhmrb-b-pb2</td><td></td></tr>
</table></td></tr>
<tr>
<td>MR8-FB PROM DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhmrc>maindec-08-dhmrc</a></td>
<td><table>
<tr><td>ac-6348a / maindec-08-dhmrc-a-d</td><td></td></tr>
<tr><td>ak-6350a / maindec-08-dhmrc-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MR8-FB PROM LOADER PROGRAM<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhmrd>maindec-08-dhmrd</a></td>
<td><table>
<tr><td>ac-6352a / maindec-08-dhmrd-a-d</td><td></td></tr>
<tr><td>ak-6354a / maindec-08-dhmrd-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MR8-FB 1K PROM INTERNAL TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhmre>maindec-08-dhmre</a></td>
<td><table>
<tr><td>ac-6356a / maindec-08-dhmre-a-d</td><td></td></tr>
<tr><td>ak-6358a / maindec-08-dhmre-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MR8-FB 2K PROM INTERNAL TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhmrf>maindec-08-dhmrf</a></td>
<td><table>
<tr><td>ac-6360a / maindec-08-dhmrf-a-d</td><td></td></tr>
<tr><td>ak-6362a / maindec-08-dhmrf-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PROM Blaster Program<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhpba>maindec-08-dhpba</a></td>
<td><table>
<tr><td>maindec-08-dhpba-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>High Speed Reader/PUnch Test (replaces 8e-d2ca)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhpca>maindec-08-dhpca</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhpca/maindec-08-dhpca-a-d.pdf>ac-6368a / maindec-08-dhpca-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhpca/maindec-08-dhpca-a-pb>ak-6371a / maindec-08-dhpca-a-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhpca/maindec-08-dhpca-b-pb>ak-6371b / maindec-08-dhpca-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PTW/8E DECWIRE UTILITY TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhpta>maindec-08-dhpta</a></td>
<td><table>
<tr><td>ac-6373a / maindec-08-dhpta-a-d</td><td></td></tr>
<tr><td>ak-6376a / maindec-08-dhpta-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>RK8E/PDP-12 Diskless Control Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrka>maindec-08-dhrka</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrka/maindec-08-dhrka-e-d.pdf>ac-6377e / maindec-08-dhrka-e-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrka/maindec-08-dhrka-e-pb>ak-6380e / maindec-08-dhrka-e-pb</td><td></a></td></tr>
<tr><td>af-6377e / maindec-08-dhrka-e-dn</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrka/maindec-08-dhrka-b-d.pdf>ac-6377b / maindec-08-dhrka-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrka/maindec-08-dhrka-b-pb>ak-6380b / maindec-08-dhrka-b-pb</td><td></a></td></tr>
<tr><td>ac-6377c / maindec-08-dhrka-c-d</td><td></td></tr>
<tr><td>ak-6380c / maindec-08-dhrka-c-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrka/maindec-08-dhrka-a-pb>ak-6380a / maindec-08-dhrka-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RK8E Drive Control Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkb>maindec-08-dhrkb</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkb/maindec-08-dhrkb-g-d.pdf>ac-6382g / maindec-08-dhrkb-g-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkb/maindec-08-dhrkb-g-pb>ak-6384g / maindec-08-dhrkb-g-pb</td><td></a></td></tr>
<tr><td>af-6382g / maindec-08-dhrkb-g-dn</td><td></td></tr>
<tr><td>ac-6382f / maindec-08-dhrkb-f-d</td><td></td></tr>
<tr><td>ak-6384f / maindec-08-dhrkb-f-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkb/maindec-08-dhrkb-e-d.pdf>ac-6382e / maindec-08-dhrkb-e-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkb/maindec-08-dhrkb-e-pb>ak-6384e / maindec-08-dhrkb-e-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkb/maindec-08-dhrkb-d-d.pdf>maindec-08-dhrkb-d-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkb/maindec-08-dhrkb-c-pb>maindec-08-dhrkb-c-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkb/maindec-08-dhrkb-b-pb>maindec-08-dhrkb-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RK8E Data Reliability Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkc>maindec-08-dhrkc</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkc/maindec-08-dhrkc-h-d.pdf>ac-6386h / maindec-08-dhrkc-h-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkc/maindec-08-dhrkc-h-pb>ak-6389h / maindec-08-dhrkc-h-pb</td><td></a></td></tr>
<tr><td>maindec-08-dhrkc-f-d</td><td></td></tr>
<tr><td>maindec-08-dhrkc-f-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkc/maindec-08-dhrkc-e-d.pdf>maindec-08-dhrkc-e-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkc/maindec-08-dhrkc-c-d.pdf>maindec-08-dhrkc-c-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkc/maindec-08-dhrkc-c-pb>maindec-08-dhrkc-c-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkc/maindec-08-dhrkc-a-pb>maindec-08-dhrkc-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RK8E Disk Formatter<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkd>maindec-08-dhrkd</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkd/maindec-08-dhrkd-d-d.pdf>ac-6391d / maindec-08-dhrkd-d-d</td><td></a></td></tr>
<tr><td>ak-6393d / maindec-08-dhrkd-d-fa</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkd/maindec-08-dhrkd-d-pb>ak-6394d / maindec-08-dhrkd-d-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkd/maindec-08-dhrkd-c-pb>maindec-08-dhrkd-c-pb</td><td></a></td></tr>
<tr><td>maindec-08-dhrkd-b-d</td><td></td></tr>
<tr><td>maindec-08-dhrkd-b-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkd/maindec-08-dhrkd-a-d.pdf>maindec-08-dhrkd-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrkd/maindec-08-dhrkd-a-pb>maindec-08-dhrkd-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RK8L INSTRUCTION TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhrke>maindec-08-dhrke</a></td>
<td><table>
<tr><td>ac-c623a / maindec-08-dhrke-a-d</td><td></td></tr>
<tr><td>ak-c625a / maindec-08-dhrke-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TD8E DECTape Diagnostic Overlay (replaces 8E-D3AB)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhta>maindec-08-dhta</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhta/maindec-08-dhta-a-pb>maindec-08-dhta-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TA8-E CASSETTE TAPE DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtaa>maindec-08-dhtaa</a></td>
<td><table>
<tr><td>ac-6396c / maindec-08-dhtaa-c-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtaa/maindec-08-dhtaa-c-pb>ak-6398c / maindec-08-dhtaa-c-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtaa/maindec-08-dhtaa-b-pb>ak-6398b / maindec-08-dhtaa-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TA8-E CASSETTE RELIABILITY TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtab>maindec-08-dhtab</a></td>
<td><table>
<tr><td>ac-6400c / maindec-08-dhtab-c-d</td><td></td></tr>
<tr><td>ak-6403c / maindec-08-dhtab-c-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtab/maindec-08-dhtab-b-pb>ak-6403b / maindec-08-dhtab-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TD8E DECtape Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtda>maindec-08-dhtda</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtda/maindec-08-dhtda-d-pb>ak-6408d / maindec-08-dhtda-d-pb</td><td></a></td></tr>
<tr><td>ac-6405b / maindec-08-dhtda-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtda/maindec-08-dhtda-b-pb>ak-6408b / maindec-08-dhtda-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtda/maindec-08-dhtda-a-d.pdf>ac-6405a / maindec-08-dhtda-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtda/maindec-08-dhtda-a-pb>ak-6408a / maindec-08-dhtda-a-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtda/maindec-08-dhtda-a-pb1>maindec-08-dhtda-a-pb1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtda/maindec-08-dhtda-a-pb2>maindec-08-dhtda-a-pb2</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TM8-E Control Test Part 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtma>maindec-08-dhtma</a></td>
<td><table>
<tr><td>ac-6410b / maindec-08-dhtma-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtma/maindec-08-dhtma-b-pb>ak-6412b / maindec-08-dhtma-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtma/maindec-08-dhtma-a-d.pdf>ac-6410a / maindec-08-dhtma-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtma/maindec-08-dhtma-a-pb>ak-6412a / maindec-08-dhtma-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TM8-E Control Test Part 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtmb>maindec-08-dhtmb</a></td>
<td><table>
<tr><td>ac-6414b / maindec-08-dhtmb-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtmb/maindec-08-dhtmb-b-pb>ak-6416b / maindec-08-dhtmb-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtmb/maindec-08-dhtmb-a-d.pdf>ac-6414a / maindec-08-dhtmb-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtmb/maindec-08-dhtmb-a-pb>ak-6416a / maindec-08-dhtmb-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TM8-E Drive Function Timer<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtmc>maindec-08-dhtmc</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtmc/maindec-08-dhtmc-a-d.pdf>ac-6418a / maindec-08-dhtmc-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtmc/maindec-08-dhtmc-a-pb>ak-6420a / maindec-08-dhtmc-a-pb</td><td></a></td></tr>
<tr><td>ac-6418b / maindec-08-dhtmc-b-d</td><td></td></tr>
<tr><td>ak-6420b / maindec-08-dhtmc-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TM8-E Reliability (9 TRACK)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtmd>maindec-08-dhtmd</a></td>
<td><table>
<tr><td>ac-6422b / maindec-08-dhtmd-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtmd/maindec-08-dhtmd-b-pb>ak-6424b / maindec-08-dhtmd-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtmd/maindec-08-dhtmd-a-d.pdf>ac-6422a / maindec-08-dhtmd-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtmd/maindec-08-dhtmd-a-pb>ak-6424a / maindec-08-dhtmd-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TM8-E RELIABILITY (7 TRACK)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtme>maindec-08-dhtme</a></td>
<td><table>
<tr><td>ac-6426b / maindec-08-dhtme-b-d</td><td></td></tr>
<tr><td>ak-6428b / maindec-08-dhtme-b-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtme/maindec-08-dhtme-a-pb>ak-6428a / maindec-08-dhtme-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TM8-E Random Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtmf>maindec-08-dhtmf</a></td>
<td><table>
<tr><td>ac-6430c / maindec-08-dhtmf-c-d</td><td></td></tr>
<tr><td>ak-6432c / maindec-08-dhtmf-c-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtmf/maindec-08-dhtmf-b-pb>ak-6432b / maindec-08-dhtmf-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TM8-E/TS03 CONTROL TEST PART 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtsa>maindec-08-dhtsa</a></td>
<td><table>
<tr><td>ak-6436b / maindec-08-dhtsa-b-pb</td><td></td></tr>
<tr><td>ac-6434b / maindec-08-dhtsa-c-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>TM8-E/TS03 CONTROL TEST PART 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtsb>maindec-08-dhtsb</a></td>
<td><table>
<tr><td>ac-6438b / maindec-08-dhtsb-b-d</td><td></td></tr>
<tr><td>ak-6440b / maindec-08-dhtsb-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TM8E/TS03 9 Track Data Reliability Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtsc>maindec-08-dhtsc</a></td>
<td><table>
<tr><td>ac-6442b / maindec-08-dhtsc-b-d</td><td></td></tr>
<tr><td>ak-6444b / maindec-08-dhtsc-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TM8-E/TS03 MULTIDRIVE EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtsd>maindec-08-dhtsd</a></td>
<td><table>
<tr><td>ac-6446b / maindec-08-dhtsd-b-d</td><td></td></tr>
<tr><td>ak-6448b / maindec-08-dhtsd-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TM8-E/TS03 DRIVE FUNCTION TIMER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtse>maindec-08-dhtse</a></td>
<td><table>
<tr><td>ac-6450a / maindec-08-dhtse-a-d</td><td></td></tr>
<tr><td>ak-6452a / maindec-08-dhtse-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TM8-E/TS03 UTILITY DRIVER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhtsf>maindec-08-dhtsf</a></td>
<td><table>
<tr><td>ac-6454a / maindec-08-dhtsf-a-d</td><td></td></tr>
<tr><td>ak-6456a / maindec-08-dhtsf-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>VC-8E Display Diagnostic (replaces 8e-d6cb)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhvca>maindec-08-dhvca</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhvca/maindec-08-dhvca-a-d.pdf>ac-6458a / maindec-08-dhvca-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhvca/maindec-08-dhvca-a-pb>ak-6460a / maindec-08-dhvca-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>VT8-E DISPLAY TEST 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhvta>maindec-08-dhvta</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhvta/maindec-08-dhvta-b-d.pdf>ac-6462b / maindec-08-dhvta-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhvta/maindec-08-dhvta-b-pb>ak-6464b / maindec-08-dhvta-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>VT8-E DISPLAY TEST 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhvtb>maindec-08-dhvtb</a></td>
<td><table>
<tr><td>ac-6466a / maindec-08-dhvtb-a-d</td><td></td></tr>
<tr><td>ak-6468a / maindec-08-dhvtb-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>VT50 TERMINAL ACCEPTANCE TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhvtc>maindec-08-dhvtc</a></td>
<td><table>
<tr><td>ac-6470d / maindec-08-dhvtc-d-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhvtc/maindec-08-dhvtc-d-pb>ak-6472d / maindec-08-dhvtc-d-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>VT61 TERMINAL ACCEPTANCE TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhvtd>maindec-08-dhvtd</a></td>
<td><table>
<tr><td>ac-6474a / maindec-08-dhvtd-a-d</td><td></td></tr>
<tr><td>ak-6476a / maindec-08-dhvtd-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TA8EA PDP-8/E Diagnostics (Cassette)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dhzda>maindec-08-dhzda</a></td>
<td><table>
<tr><td>ar-6478a / maindec-08-dhzda-a-tb1</td><td></td></tr>
<tr><td>ar-6479a / maindec-08-dhzda-a-tb2</td><td></td></tr>
</table></td></tr>
<tr>
<td>AD0X ANALOG INPUT TESTS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-diadc>maindec-08-diadc</a></td>
<td><table>
<tr><td>ac-6483a / maindec-08-diadc-a-d</td><td></td></tr>
<tr><td>ak-6485a / maindec-08-diadc-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>UDC-8 ANALOG INPUT EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-diadf>maindec-08-diadf</a></td>
<td><table>
<tr><td>ac-6492a / maindec-08-diadf-a-d</td><td></td></tr>
<tr><td>ak-6494a / maindec-08-diadf-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AFC8 Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-diafb>maindec-08-diafb</a></td>
<td><table>
<tr><td>maindec-08-diafb-a-d</td><td></td></tr>
<tr><td>maindec-08-diafb-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DB8-E INTERPROCESSOR BUFFER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-didba>maindec-08-didba</a></td>
<td><table>
<tr><td>ac-6502a / maindec-08-didba-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-didba/maindec-08-didba-a-pb>ak-6505a / maindec-08-didba-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DF32-D DISKLESS LOGIC TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-didfa>maindec-08-didfa</a></td>
<td><table>
<tr><td>ac-6507c / maindec-08-didfa-c-d</td><td></td></tr>
<tr><td>ak-6509c / maindec-08-didfa-c-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8, 8/I, 8/S DF32 DISKLESS LOGIC TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-didfb>maindec-08-didfb</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-didfb/maindec-08-didfb-a-d.pdf>ac-6511a / maindec-08-didfb-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-didfb/maindec-08-didfb-a-pb>ak-6513a / maindec-08-didfb-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DF32-D DATA, ADDRESS TESTS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-didfc>maindec-08-didfc</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-didfc/maindec-08-didfc-a-d.pdf>ac-6515a / maindec-08-didfc-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-didfc/maindec-08-didfc-a-pb>ak-6517a / maindec-08-didfc-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Random TAD Test (replaces 08-d0e)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dikaa>maindec-08-dikaa</a></td>
<td><table>
<tr><td>maindec-08-dikaa-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>INSTRUCTION TEST PART 2A<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dikia>maindec-08-dikia</a></td>
<td><table>
<tr><td>ac-6523a / maindec-08-dikia-a-d</td><td></td></tr>
<tr><td>ak-6526a / maindec-08-dikia-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8/A CPU Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dikka>maindec-08-dikka</a></td>
<td><table>
<tr><td>maindec-08-dikka-c-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8/A CPU Test with Console Package<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dikkb>maindec-08-dikkb</a></td>
<td><table>
<tr><td>maindec-08-dikkb-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AIKLAD0 KL8-J/K Loopback Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dikla>maindec-08-dikla</a></td>
<td><table>
<tr><td>ac-6527d / maindec-08-dikla-d-d</td><td></td></tr>
<tr><td>ak-6529d / maindec-08-dikla-d-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dikla/maindec-08-dikla-c-d.pdf>ac-6527c / maindec-08-dikla-c-d</td><td></a></td></tr>
<tr><td>ak-6529c / maindec-08-dikla-d-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dikla/maindec-08-dikla-b-d.pdf>ac-6527b / maindec-08-dikla-b-d</td><td></a></td></tr>
<tr><td>ak-6529b / maindec-08-dikla-d-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>KL8-JA TELETYPE TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-diklb>maindec-08-diklb</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-diklb/maindec-08-diklb-a-d.pdf>ac-6531a / maindec-08-diklb-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-diklb/maindec-08-diklb-a-pb>ak-6533a / maindec-08-diklb-a-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-diklb/maindec-08-diklb-a-pb>ak-6533a / maindec-08-diklb-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AILABE0 LA36 Printer Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dilab>maindec-08-dilab</a></td>
<td><table>
<tr><td>ac-6535e / maindec-08-dilab-e-d</td><td></td></tr>
<tr><td>ak-6537e / maindec-08-dilab-e-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dilab/maindec-08-dilab-d-d.pdf>ac-6535d / maindec-08-dilab-d-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dilab/maindec-08-dilab-d-pb>ak-6537d / maindec-08-dilab-d-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LA180 PRINTER DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dilac>maindec-08-dilac</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dilac/maindec-08-dilac-b-d.pdf>ac-6539b / maindec-08-dilac-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dilac/maindec-08-dilac-b-pb>ak-6541b / maindec-08-dilac-b-pb</td><td></a></td></tr>
<tr><td>ac-6539a / maindec-08-dilac-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dilac/maindec-08-dilac-a-pb>ak-6541a / maindec-08-dilac-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LE8/LP08 PRINTER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dilpa>maindec-08-dilpa</a></td>
<td><table>
<tr><td>ac-6543c / maindec-08-dilpa-c-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dilpa/maindec-08-dilpa-c-ps>ak-6545c / maindec-08-dilpa-c-ps</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dilpa/maindec-08-dilpa-n-pb>ak-6545n / maindec-08-dilpa-n-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LP08/F DIAGNOSTIC TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dilpd>maindec-08-dilpd</a></td>
<td><table>
<tr><td>ac-6547a / maindec-08-dilpd-a-d</td><td></td></tr>
<tr><td>ak-6549a / maindec-08-dilpd-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>LP08/LP05/LP14 PRINTER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dilpe>maindec-08-dilpe</a></td>
<td><table>
<tr><td>ac-6551c / maindec-08-dilpe-c-d</td><td></td></tr>
<tr><td>ak-6553c / maindec-08-dilpe-c-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>LPC8 PHOTOCOMP INTERFACE DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-diltc>maindec-08-diltc</a></td>
<td><table>
<tr><td>ac-6555a / maindec-08-diltc-a-d</td><td></td></tr>
<tr><td>ak-6557a / maindec-08-diltc-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>LS8E LINE PRINTER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-diltd>maindec-08-diltd</a></td>
<td><table>
<tr><td>ac-6559a / maindec-08-diltd-a-d</td><td></td></tr>
<tr><td>ak-6561a / maindec-08-diltd-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>LV12/LV8 PRINTER/PLOTTER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dilva>maindec-08-dilva</a></td>
<td><table>
<tr><td>ac-6563a / maindec-08-dilva-a-d</td><td></td></tr>
<tr><td>ak-6565a / maindec-08-dilva-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PA60A/PA63/PA67A.PA68F TYPESETTING CONFIG TESTS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dipaa>maindec-08-dipaa</a></td>
<td><table>
<tr><td>ac-6567b / maindec-08-dipaa-b-d</td><td></td></tr>
<tr><td>ak-6569b / maindec-08-dipaa-b-pb</td><td>PA60A/PA63/PA67A.PA68F TYPESETTING TESTS</td></tr>
</table></td></tr>
<tr>
<td>PRS01 Toggle in Program for KL8J<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dipra>maindec-08-dipra</a></td>
<td><table>
<tr><td>ac-c621a / maindec-08-dipra-a-d</td><td></td></tr>
<tr><td>ak-c621a / maindec-08-dipra-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AIQACL0 PDP-8 MAINDEC Index<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-diqac>maindec-08-diqac</a></td>
<td><table>
<tr><td>ac-6571l / maindec-08-diqac-l-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-diqac/maindec-08-diqac-e-d.pdf>ac-6571e / maindec-08-diqac-e-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>RF08 DISK DATA TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dirfa>maindec-08-dirfa</a></td>
<td><table>
<tr><td>ac-6573a / maindec-08-dirfa-a-d</td><td></td></tr>
<tr><td>ak-6575a / maindec-08-dirfa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>RK8 DISK & CONTROL INSTRUCTION TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dirka>maindec-08-dirka</a></td>
<td><table>
<tr><td>ac-b196a / maindec-08-dirka-a-d</td><td></td></tr>
<tr><td>ak-b198a / maindec-08-dirka-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>RT01/RT02 TERMINAL DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dirta>maindec-08-dirta</a></td>
<td><table>
<tr><td>ac-6577b / maindec-08-dirta-b-d</td><td></td></tr>
<tr><td>ak-6579b / maindec-08-dirta-b-pb</td><td></td></tr>
<tr><td>maindec-08-dirta-a-pb</td><td>RT01/02 Terminal Diagnostic</td></tr>
</table></td></tr>
<tr>
<td>AIRXAE0 RX8/RX01 Diagnostic Program<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dirxa>maindec-08-dirxa</a></td>
<td><table>
<tr><td>ac-6581e / maindec-08-dirxa-e-d</td><td></td></tr>
<tr><td>ak-6583e / maindec-08-dirxa-e-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dirxa/maindec-08-dirxa-d-d.pdf>ac-6581d / maindec-08-dirxa-d-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dirxa/maindec-08-dirxa-d-pb>ak-6583d / maindec-08-dirxa-d-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dirxa/maindec-08-dirxa-c-d.pdf>ac-6581c / maindec-08-dirxa-c-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dirxa/maindec-08-dirxa-c-pb>ak-6583c / maindec-08-dirxa-c-pb</td><td></a></td></tr>
<tr><td>ac-6581b / maindec-08-dirxa-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dirxa/maindec-08-dirxa-b-pb>ak-6583b / maindec-08-dirxa-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AIRXBF0 RX01/02 Reliability Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dirxb>maindec-08-dirxb</a></td>
<td><table>
<tr><td>ac-6585f / maindec-08-dirxb-f-d</td><td></td></tr>
<tr><td>ak-6587f / maindec-08-dirxb-f-pb</td><td></td></tr>
<tr><td>af-6585f / maindec-08-dirxb-f-dn</td><td></td></tr>
<tr><td>ac-6585e / maindec-08-dirxb-e-d</td><td></td></tr>
<tr><td>ak-6587e / maindec-08-dirxb-e-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dirxb/maindec-08-dirxb-d-d.pdf>ac-6585d / maindec-08-dirxb-d-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dirxb/maindec-08-dirxb-d-pb>ak-6587d / maindec-08-dirxb-d-pb</td><td></a></td></tr>
<tr><td>ac-6585c / maindec-08-dirxb-c-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dirxb/maindec-08-dirxb-c-pb>ak-6587c / maindec-08-dirxb-c-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TC01 BASIC EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-ditca>maindec-08-ditca</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-ditca/maindec-08-ditca-a-d.pdf>ac-6589a / maindec-08-ditca-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-ditca/maindec-08-ditca-a-pb>ak-6591a / maindec-08-ditca-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TC58/TU10 DRIVE FUNCTION TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-ditcb>maindec-08-ditcb</a></td>
<td><table>
<tr><td>ac-6593a / maindec-08-ditcb-a-d</td><td></td></tr>
<tr><td>ak-6595a / maindec-08-ditcb-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>TC58/TU10 RANDOM EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-ditcc>maindec-08-ditcc</a></td>
<td><table>
<tr><td>ac-6597a / maindec-08-ditcc-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-ditcc/maindec-08-ditcc-a-pb>ak-6599a / maindec-08-ditcc-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TC58/TU10 INSTRUCTION TEST PART 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-ditcd>maindec-08-ditcd</a></td>
<td><table>
<tr><td>ac-6601a / maindec-08-ditcd-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-ditcd/maindec-08-ditcd-a-pb>ak-6603a / maindec-08-ditcd-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>UDC8 SYSTEM FUNCTION EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-diuda>maindec-08-diuda</a></td>
<td><table>
<tr><td>ac-6605c / maindec-08-diuda-c-d</td><td></td></tr>
<tr><td>ak-6607c / maindec-08-diuda-c-pb</td><td></td></tr>
<tr><td>maindec-08-diuda-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>VT20 HOST COMPUTER PROGRAM<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-divtb>maindec-08-divtb</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-divtb/maindec-08-divtb-a-d.pdf>ac-6609a / maindec-08-divtb-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-divtb/maindec-08-divtb-a-pb>ak-6611a / maindec-08-divtb-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>VT55 VIDEO TERMINAL ACCEPTANCE TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-divtc>maindec-08-divtc</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-divtc/maindec-08-divtc-a-d.pdf>ac-6613a / maindec-08-divtc-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-divtc/maindec-08-divtc-a-pb>ak-6615a / maindec-08-divtc-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>A/D CONVERTER MULTIPLEXER DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djada>maindec-08-djada</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djada/maindec-08-djada-c-d.pdf>ac-6617c / maindec-08-djada-c-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djada/maindec-08-djada-c-pb>ak-6619c / maindec-08-djada-c-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>CL8 OPTION TEST 1 & 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djcla>maindec-08-djcla</a></td>
<td><table>
<tr><td>ac-6621a / maindec-08-djcla-a-d</td><td></td></tr>
<tr><td>ak-6623a / maindec-08-djcla-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CL8 PRESYSTEM TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djclb>maindec-08-djclb</a></td>
<td><table>
<tr><td>ac-6625a / maindec-08-djclb-a-d</td><td></td></tr>
<tr><td>ak-6627a / maindec-08-djclb-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DKC8-AA Option Test 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djdka>maindec-08-djdka</a></td>
<td><table>
<tr><td>ac-6629a / maindec-08-djdka-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djdka/maindec-08-djdka-b-d.pdf>ac-6629b / maindec-08-djdka-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djdka/maindec-08-djdka-b-pb>ak-6631b / maindec-08-djdka-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djdka/maindec-08-djdka-c-pb>ak-6631c / maindec-08-djdka-c-pb</td><td></a></td></tr>
<tr><td>ac-6629d / maindec-08-djdka-d-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djdka/maindec-08-djdka-d-pb>ak-6631d / maindec-08-djdka-d-pb</td><td></a></td></tr>
<tr><td>ak-6636d / maindec-08-djdka-d-pm1</td><td></td></tr>
<tr><td>ak-6637d / maindec-08-djdka-d-pm2</td><td></td></tr>
<tr><td>ak-6638d / maindec-08-djdka-d-pm3</td><td></td></tr>
<tr><td>ak-6639d / maindec-08-djdka-d-pm4</td><td></td></tr>
</table></td></tr>
<tr>
<td>RANDOM MRI INSTRUCTION EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djexa>maindec-08-djexa</a></td>
<td><table>
<tr><td>ac-6641a / maindec-08-djexa-a-d</td><td></td></tr>
<tr><td>ak-6646a / maindec-08-djexa-a-pm</td><td></td></tr>
</table></td></tr>
<tr>
<td>2K TO 32K PDP-8A PROCESSOR EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djexb>maindec-08-djexb</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djexb/maindec-08-djexb-a-d.pdf>ac-6648a / maindec-08-djexb-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djexb/maindec-08-djexb-a-pb>ak-6650a / maindec-08-djexb-a-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djexb/maindec-08-djexb-a-pm>ak-6651a / maindec-08-djexb-a-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AJEXCC0 4K TO 32K PROCESSOR EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djexc>maindec-08-djexc</a></td>
<td><table>
<tr><td>ac-6653c / maindec-08-djexc-c-d</td><td></td></tr>
<tr><td>ak-6655c / maindec-08-djexc-c-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djexc/maindec-08-djexc-b-d.pdf>ac-6653b / maindec-08-djexc-b-d</td><td></a></td></tr>
<tr><td>ak-6655b / maindec-08-djexc-b-pb</td><td></td></tr>
<tr><td>ac-6653a / maindec-08-djexc-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djexc/maindec-08-djexc-a-pb>ak-6655a / maindec-08-djexc-a-pb</td><td></a></td></tr>
<tr><td>al-6656a / maindec-08-djexc-a-uc</td><td></td></tr>
</table></td></tr>
<tr>
<td>FPP8-A Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djfpa>maindec-08-djfpa</a></td>
<td><table>
<tr><td>maindec-08-djfpa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>FPP8-A Instruction Test and Data Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djfpb>maindec-08-djfpb</a></td>
<td><table>
<tr><td>maindec-08-djfpb-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>FPP-8A DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djfppa>maindec-08-djfppa</a></td>
<td><table>
<tr><td>ac-6657b / maindec-08-djfppa-b-d</td><td></td></tr>
<tr><td>ak-6659b / maindec-08-djfppa-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>FPP-8A INSTRUCTION TEST & DATA EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djfppb>maindec-08-djfppb</a></td>
<td><table>
<tr><td>ac-6662c / maindec-08-djfppb-c-d</td><td></td></tr>
<tr><td>ak-6665c / maindec-08-djfppb-c-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8A CPU TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkka>maindec-08-djkka</a></td>
<td><table>
<tr><td>ac-6667c / maindec-08-djkka-c-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkka/maindec-08-djkka-c-pb>ak-6670c / maindec-08-djkka-c-pb</td><td></a></td></tr>
<tr><td>ak-6670c / maindec-08-djkka-c-pb1</td><td></td></tr>
<tr><td>ak-6675c / maindec-08-djkka-c-pm1</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkka/maindec-08-djkka-b-d.pdf>ac-6667b / maindec-08-djkka-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkka/maindec-08-djkka-b-pb>ak-6670b / maindec-08-djkka-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>CL8 PDP-8A CPU TEST WITH CONSOLE PACKAGE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkkb>maindec-08-djkkb</a></td>
<td><table>
<tr><td>ac-6678a / maindec-08-djkkb-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkkb/maindec-08-djkkb-a-pb>ak-6680a / maindec-08-djkkb-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KL8-A Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkla>maindec-08-djkla</a></td>
<td><table>
<tr><td>ac-6682d / maindec-08-djkla-d-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkla/maindec-08-djkla-d-pb>ak-6684d / maindec-08-djkla-d-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkla/maindec-08-djkla-c-pb>ak-6684c / maindec-08-djkla-c-pb</td><td>KL8-A Multiple SLU Diagnostic</a></td></tr>
</table></td></tr>
<tr>
<td>KM8-A OPTION TEST 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkma>maindec-08-djkma</a></td>
<td><table>
<tr><td>ac-6686c / maindec-08-djkma-c-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkma/maindec-08-djkma-c-pb>ak-6688c / maindec-08-djkma-c-pb</td><td></a></td></tr>
<tr><td>ak-6693c / maindec-08-djkma-c-pm1</td><td></td></tr>
<tr><td>ak-6694c / maindec-08-djkma-c-pm2</td><td></td></tr>
<tr><td>ak-6696c / maindec-08-djkma-c-pm4</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkma/maindec-08-djkma-b-d.pdf>ac-6686b / maindec-08-djkma-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkma/maindec-08-djkma-a-d.pdf>ac-6686a / maindec-08-djkma-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkma/maindec-08-djkma-a-pb>ak-6688a / maindec-08-djkma-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AJKTAB0 KT8-A Memory Management Option<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djkta>maindec-08-djkta</a></td>
<td><table>
<tr><td>ac-e505b / maindec-08-djkta-b-d</td><td></td></tr>
<tr><td>ak-e506b / maindec-08-djkta-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MR8-A ROM COMPARE TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djmra>maindec-08-djmra</a></td>
<td><table>
<tr><td>ac-6698a / maindec-08-djmra-a-d</td><td></td></tr>
<tr><td>ak-6700a / maindec-08-djmra-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MR8-SA ROM LOADER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djmrb>maindec-08-djmrb</a></td>
<td><table>
<tr><td>ac-c615a / maindec-08-djmrb-a-d</td><td></td></tr>
<tr><td>ak-c617a / maindec-08-djmrb-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MR8-SA ROM DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djmrc>maindec-08-djmrc</a></td>
<td><table>
<tr><td>ac-c627a / maindec-08-djmrc-a-d</td><td></td></tr>
<tr><td>ak-c629a / maindec-08-djmrc-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MR8-A ROM CONVERSION<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djmrd>maindec-08-djmrd</a></td>
<td><table>
<tr><td>ac-6702a / maindec-08-djmrd-a-d</td><td></td></tr>
<tr><td>ak-6704a / maindec-08-djmrd-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MS8-A 1-4K MOS MEMORY TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djmsa>maindec-08-djmsa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djmsa/maindec-08-djmsa-a-d.pdf>ac-6706a / maindec-08-djmsa-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djmsa/maindec-08-djmsa-a-pb>ak-6709a / maindec-08-djmsa-a-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djmsa/maindec-08-djmsa-a-pm>ak-6711a / maindec-08-djmsa-a-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AJRLAB0 RL8-A Diskless Controller Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrla>maindec-08-djrla</a></td>
<td><table>
<tr><td>ac-c656b / maindec-08-djrla-b-d</td><td></td></tr>
<tr><td>ak-c658b / maindec-08-djrla-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AJRLBB0 RL8-A/RL01 Test Drive Part 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrlb>maindec-08-djrlb</a></td>
<td><table>
<tr><td>ac-c660b / maindec-08-djrlb-b-d</td><td></td></tr>
<tr><td>ak-c662b / maindec-08-djrlb-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AJRLCA0 RL8-A/RL01 Drive Test Part 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrlc>maindec-08-djrlc</a></td>
<td><table>
<tr><td>ac-c664a / maindec-08-djrlc-a-d</td><td></td></tr>
<tr><td>ak-c666a / maindec-08-djrlc-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AJRLDA0 RL8-A/RL01 Drive CPT Verifier<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrld>maindec-08-djrld</a></td>
<td><table>
<tr><td>ac-c668a / maindec-08-djrld-a-d</td><td></td></tr>
<tr><td>ak-c670a / maindec-08-djrld-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AJRLEA0 RL8-A/RL01 Performance Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrle>maindec-08-djrle</a></td>
<td><table>
<tr><td>ac-c672a / maindec-08-djrle-a-d</td><td></td></tr>
<tr><td>ak-c674a / maindec-08-djrle-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AJRLGA0 RL8-A/RL01 Pack Verifier<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrlg>maindec-08-djrlg</a></td>
<td><table>
<tr><td>ac-c682a / maindec-08-djrlg-a-d</td><td></td></tr>
<tr><td>ak-c684a / maindec-08-djrlg-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AJRLZD0 RL01 Diagnostic Disk (RL01)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrlz>maindec-08-djrlz</a></td>
<td><table>
<tr><td>ax-e806d / ax-e806d-hc</td><td></td></tr>
</table></td></tr>
<tr>
<td>CL/8 Floppy Media #1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrxa>maindec-08-djrxa</a></td>
<td><table>
<tr><td>as-6713l / maindec-08-djrxa-l-pb</td><td></td></tr>
<tr><td>as-6713p / maindec-08-djrxa-p-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8A Floppy Media<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrxb>maindec-08-djrxb</a></td>
<td><table>
<tr><td>as-6714d / maindec-08-djrxb-d-pb</td><td></td></tr>
<tr><td>as-6714j / maindec-08-djrxb-j-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>RX01 Option Media #1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrxc>maindec-08-djrxc</a></td>
<td><table>
<tr><td>as-6715g / maindec-08-djrxc-g-pb</td><td></td></tr>
<tr><td>as-6715j / maindec-08-djrxc-j-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>RX01 Option Media #2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrxd>maindec-08-djrxd</a></td>
<td><table>
<tr><td>as-6716c / maindec-08-djrxd-c-pb</td><td></td></tr>
<tr><td>as-6716e / maindec-08-djrxd-e-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CL/8 Floppy Media #2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrxe>maindec-08-djrxe</a></td>
<td><table>
<tr><td>as-6717b / maindec-08-djrxe-b-pb</td><td></td></tr>
<tr><td>as-6717c / maindec-08-djrxe-c-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>RX01 Option Media #3<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrxf>maindec-08-djrxf</a></td>
<td><table>
<tr><td>as-6718a / maindec-08-djrxf-a-pb</td><td></td></tr>
<tr><td>as-6718c / maindec-08-djrxf-c-pb</td><td></td></tr>
<tr><td>as-6718f / maindec-08-djrxf-f-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>RX01 Option Media #4<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrxg>maindec-08-djrxg</a></td>
<td><table>
<tr><td>as-a873a / maindec-08-djrxg-a-pb</td><td></td></tr>
<tr><td>as-a873c / maindec-08-djrxg-c-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AJRXHF0 WS202 Floppy Tests<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrxh>maindec-08-djrxh</a></td>
<td><table>
<tr><td>as-e113f / maindec-08-djrxh-f-yb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AJRXIB0 DEC 88 Diagnostic Binary #1 (RX02)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djrxi>maindec-08-djrxi</a></td>
<td><table>
<tr><td>ba-f246b / ba-f246b-yb</td><td></td></tr>
<tr><td>ba-f286b / ba-f286b-yb</td><td>AJRXIB0 DEC 88 Diagnostic Binary #2 (RX02)</td></tr>
<tr><td>ba-f246a / ba-f246a-yb</td><td></td></tr>
<tr><td>ba-f286a / ba-f286a-yb</td><td>AJRXIB0 DEC 88 Diagnostic Binary #2 (RX02)</td></tr>
</table></td></tr>
<tr>
<td>VK8 TESTS<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djvka>maindec-08-djvka</a></td>
<td><table>
<tr><td>ac-6719b / maindec-08-djvka-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-djvka/maindec-08-djvka-b-pb>ak-6721b / maindec-08-djvka-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>VT78 Floppy Media<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dkrxa>maindec-08-dkrxa</a></td>
<td><table>
<tr><td>as-b200a / maindec-08-dkrxa-a-pb</td><td></td></tr>
<tr><td>as-b200d / maindec-08-dkrxa-d-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>VT78 MOS Memory Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dkvta>maindec-08-dkvta</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dkvta/maindec-08-dkvta-a-d.pdf>maindec-08-dkvta-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dkvta/maindec-08-dkvta-a-pb>maindec-08-dkvta-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AKVTBB0 VT78 CPU Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dkvtb>maindec-08-dkvtb</a></td>
<td><table>
<tr><td>ac-a825b / maindec-08-dkvtb-b-d</td><td></td></tr>
<tr><td>ak-a826b / maindec-08-dkvtb-b-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-dkvtb/maindec-08-dkvtb-a-d.pdf>ac-a825a / maindec-08-dkvtb-a-d</td><td></a></td></tr>
<tr><td>ak-a826a / maindec-08-dkvtb-a-pb</td><td></td></tr>
<tr><td>al-a828a / maindec-08-dkvtb-a-uc</td><td></td></tr>
</table></td></tr>
<tr>
<td>BINary Loader<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-lba>maindec-08-lba</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-08-lba/maindec-08-lbaa-pm>maindec-08-lbaa-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 CP Test 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0a>maindec-12-d0a</a></td>
<td><table>
<a name='maindec-12'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0a/maindec-12-d0ab-pb>maindec-12-d0ab-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0a/maindec-12-d0ab-d.pdf>maindec-12-d0ab-d</td><td>PDP-12 Instruction Test, Part 2</a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Instruction Test part 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0b>maindec-12-d0b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0b/maindec-12-d0ba-pb>maindec-12-d0ba-pb</td><td></a></td></tr>
<tr><td>maindec-12-d0ba-d</td><td>PDP-12 Instruction Test, Part 1</td></tr>
</table></td></tr>
<tr>
<td>PDP-12 CP Test 3<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0c>maindec-12-d0c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0c/maindec-12-d0ca-pb>maindec-12-d0ca-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0c/maindec-12-d0cb-d.pdf>maindec-12-d0cb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0c/maindec-12-d0cb-pb>maindec-12-d0cb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Tape Quickie<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0g>maindec-12-d0g</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0g/maindec-12-d0ga-pb>maindec-12-d0ga-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0g/maindec-12-d0ga-pm>maindec-12-d0ga-pm</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0g/maindec-12-d0ga-d.pdf>maindec-12-d0ga-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DR12 Relay Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0h>maindec-12-d0h</a></td>
<td><table>
<tr><td>maindec-12-d0ha-d</td><td></td></tr>
<tr><td>maindec-12-d0ha-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CM12 Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0j>maindec-12-d0j</a></td>
<td><table>
<tr><td>maindec-12-d0ja-d</td><td></td></tr>
<tr><td>maindec-12-d0ja-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Coulter S Interface Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0k>maindec-12-d0k</a></td>
<td><table>
<tr><td>maindec-12-d0ka-d</td><td></td></tr>
<tr><td>maindec-12-d0ka-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>FPP-12 TRACE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0l>maindec-12-d0l</a></td>
<td><table>
<tr><td>ac-9739c / maindec-12-d0lc-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0l/maindec-12-d0lc-pb>ak-9741c / maindec-12-d0lc-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FPP-12 Instruction Test 2A<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0m>maindec-12-d0m</a></td>
<td><table>
<tr><td>ac-9743c / maindec-12-d0mc-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0m/maindec-12-d0mc-pb>ak-9745c / maindec-12-d0mc-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FPP-12 Instruction Test 2B<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0n>maindec-12-d0n</a></td>
<td><table>
<tr><td>ac-9747b / maindec-12-d0nb-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0n/maindec-12-d0nb-pb>ak-9749b / maindec-12-d0nb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FPP-12 Instruction Test 2C<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0o>maindec-12-d0o</a></td>
<td><table>
<tr><td>maindec-12-d0ob-d</td><td></td></tr>
<tr><td>maindec-12-d0ob-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>FPP-12 Address Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0p>maindec-12-d0p</a></td>
<td><table>
<tr><td>maindec-12-d0pc-d</td><td></td></tr>
<tr><td>maindec-12-d0pc-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>FPP-12 Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0q>maindec-12-d0q</a></td>
<td><table>
<tr><td>maindec-12-d0qa-d</td><td></td></tr>
<tr><td>maindec-12-d0qa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>KF12B Auto Priority Interrupt<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0s>maindec-12-d0s</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0s/maindec-12-d0sa-d.pdf>maindec-12-d0sa-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0s/maindec-12-d0sa-pb>maindec-12-d0sa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FPP-12 Trace EPM 2B<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0t>maindec-12-d0t</a></td>
<td><table>
<tr><td>ac-9757a / maindec-12-d0ta-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0t/maindec-12-d0ta-pb>ak-9755a / maindec-12-d0ta-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FPP-12 Instruction Test 3 (FPP13) EPM Version<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0u>maindec-12-d0u</a></td>
<td><table>
<tr><td>ac-9759a / maindec-12-d0ua-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d0u/maindec-12-d0ua-pb>ak-9761a / maindec-12-d0ua-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Extended Memory Control<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1a>maindec-12-d1a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1a/maindec-12-d1ac-d.pdf>maindec-12-d1ac-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1a/maindec-12-d1ac-pb>maindec-12-d1ac-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1a/maindec-12-d1ab-pb>maindec-12-d1ab-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>JMP SELF<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1b>maindec-12-d1b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1b/maindec-12-d1ba-d.pdf>ac-9763a / maindec-12-d1ba-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1b/maindec-12-d1ba-pb>ak-9765a / maindec-12-d1ba-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Address Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1c>maindec-12-d1c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1c/maindec-12-d1ca-pb>maindec-12-d1ca-pb</td><td></a></td></tr>
<tr><td>maindec-12-d1ca-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Checkerboard<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1d>maindec-12-d1d</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1d/maindec-12-d1da-d.pdf>maindec-12-d1da-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1d/maindec-12-d1da-pb>maindec-12-d1da-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Float 1s and 0s Through Memory<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1e>maindec-12-d1e</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1e/maindec-12-d1ea-d.pdf>ac-9774a / maindec-12-d1ea-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1e/maindec-12-d1ea-pb>ak-9777a / maindec-12-d1ea-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Basic Memory Control Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1f>maindec-12-d1f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1f/maindec-12-d1fa-d.pdf>maindec-12-d1fa-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1f/maindec-12-d1fa-pb>maindec-12-d1fa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KP12 Power Fail Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d1k>maindec-12-d1k</a></td>
<td><table>
<tr><td>maindec-12-d1ka-d</td><td></td></tr>
<tr><td>maindec-12-d1ka-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CM12B/C Alpha Card Deck<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d21>maindec-12-d21</a></td>
<td><table>
<tr><td>maindec-12-d21a-c</td><td></td></tr>
</table></td></tr>
<tr>
<td>CM12B/C Binary Card Deck<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d22>maindec-12-d22</a></td>
<td><table>
<tr><td>maindec-12-d22a-c</td><td></td></tr>
</table></td></tr>
<tr>
<td>CM12B/C Mark Sense Card Deck<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d23>maindec-12-d23</a></td>
<td><table>
<tr><td>maindec-12-d23a-c</td><td></td></tr>
</table></td></tr>
<tr>
<td>VT06 (Datapoint 330)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d2a>maindec-12-d2a</a></td>
<td><table>
<tr><td>maindec-12-d2aa-d</td><td></td></tr>
<tr><td>maindec-12-d2aa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CD12 Data Break Card Reader<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d2b>maindec-12-d2b</a></td>
<td><table>
<tr><td>maindec-12-d2ba-d</td><td></td></tr>
<tr><td>maindec-12-d2ba-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>645A Line Printer Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d2l>maindec-12-d2l</a></td>
<td><table>
<tr><td>maindec-12-d2la-d</td><td></td></tr>
<tr><td>maindec-12-d2la-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Tape Control Test part 1 of 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3a>maindec-12-d3a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3a/maindec-12-d3ae-d.pdf>maindec-12-d3ae-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3a/maindec-12-d3ae-pb>maindec-12-d3ae-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3a/maindec-12-d3ac-pb>maindec-12-d3ac-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 MAGtape Data Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3d>maindec-12-d3d</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3d/maindec-12-d3db-d.pdf>maindec-12-d3db-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3d/maindec-12-d3db-pb>maindec-12-d3db-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TC12-F Option Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3e>maindec-12-d3e</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3e/maindec-12-d3eb-pb>maindec-12-d3eb-pb</td><td></a></td></tr>
<tr><td>maindec-12-d3eb-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Tape Data Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3f>maindec-12-d3f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3f/maindec-12-d3fb-pb>maindec-12-d3fb-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3f/maindec-12-d3fb-d.pdf>maindec-12-d3fb-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Tape Control Test part 2 of 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3g>maindec-12-d3g</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3g/maindec-12-d3ga-pb>maindec-12-d3ga-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d3g/maindec-12-d3ga-d.pdf>maindec-12-d3ga-d</td><td>PDP-12 Tape Control Test</a></td></tr>
</table></td></tr>
<tr>
<td>DF32 Disk List Logic Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d5b>maindec-12-d5b</a></td>
<td><table>
<tr><td>maindec-12-d5ba-d</td><td></td></tr>
<tr><td>maindec-12-d5ba-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DV08-N Data Verifier Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d5c>maindec-12-d5c</a></td>
<td><table>
<tr><td>maindec-12-d5ca-d</td><td></td></tr>
<tr><td>maindec-12-d5ca-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>VR14/VR20 Display Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d6b>maindec-12-d6b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d6b/maindec-12-d6ba-pb>maindec-12-d6ba-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d6b/maindec-12-d6ba-d.pdf>maindec-12-d6ba-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d6b/maindec-12-d6bb-d.pdf>maindec-12-d6bb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d6b/maindec-12-d6bc-d.pdf>maindec-12-d6bc-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d6b/maindec-12-d6bc-pb>maindec-12-d6bc-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>A to D Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d6c>maindec-12-d6c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d6c/maindec-12-d6cc-d.pdf>maindec-12-d6cc-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d6c/maindec-12-d6cc-pb>maindec-12-d6cc-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d6c/maindec-12-d6cb-pb>maindec-12-d6cb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>A to D Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d6d>maindec-12-d6d</a></td>
<td><table>
<tr><td>maindec-12-d6da-d</td><td></td></tr>
<tr><td>maindec-12-d6da-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Maintenance Programs #1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d7a>maindec-12-d7a</a></td>
<td><table>
<tr><td>maindec-12-d7ah-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 System Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d7c>maindec-12-d7c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d7c/maindec-12-d7cd-d.pdf>maindec-12-d7cd-d</td><td></a></td></tr>
<tr><td>maindec-12-d7cd-pb</td><td>System Exerciser</td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d7c/maindec-12-d7cb-pb>maindec-12-d7cb-pb</td><td>System Exerciser</a></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Maintenance Programs #2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d7g>maindec-12-d7g</a></td>
<td><table>
<tr><td>maindec-12-d7gf-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>DR12 Relay Register Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8a>maindec-12-d8a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8a/maindec-12-d8ab-d.pdf>maindec-12-d8ab-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8a/maindec-12-d8ab-pb>maindec-12-d8ab-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KW12A Clock Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8c>maindec-12-d8c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8c/maindec-12-d8cd-d.pdf>maindec-12-d8cd-d</td><td></a></td></tr>
<tr><td>maindec-12-d8cd-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8c/maindec-12-d8cc-d.pdf>maindec-12-d8cc-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8c/maindec-12-d8cc-pb>maindec-12-d8cc-pb</td><td>KW12 Clock Test for Units w/o ECO #55</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8c/maindec-12-d8ca-d.pdf>maindec-12-d8ca-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8c/maindec-12-d8ca-pb>maindec-12-d8ca-pb</td><td>KW12 Clock Test for Units w/o ECO #55</a></td></tr>
</table></td></tr>
<tr>
<td>DC04 Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8d>maindec-12-d8d</a></td>
<td><table>
<tr><td>maindec-12-d8da-d</td><td></td></tr>
<tr><td>maindec-12-d8da-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>KW12 B-C Simple Clock<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8e>maindec-12-d8e</a></td>
<td><table>
<tr><td>maindec-12-d8eb-d</td><td></td></tr>
<tr><td>maindec-12-d8eb-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DC02-F Option Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8f>maindec-12-d8f</a></td>
<td><table>
<tr><td>maindec-12-d8fb-d</td><td></td></tr>
<tr><td>maindec-12-d8fb-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DP02 Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8h>maindec-12-d8h</a></td>
<td><table>
<tr><td>maindec-12-d8ha-d</td><td></td></tr>
<tr><td>maindec-12-d8ha-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CC02 Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8j>maindec-12-d8j</a></td>
<td><table>
<tr><td>maindec-12-d8ja-d</td><td></td></tr>
<tr><td>maindec-12-d8ja-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>VW01 Control Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8k>maindec-12-d8k</a></td>
<td><table>
<tr><td>maindec-12-d8ka-d</td><td></td></tr>
<tr><td>maindec-12-d8ka-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>A.I.P. Instruction Test I<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8l>maindec-12-d8l</a></td>
<td><table>
<tr><td>maindec-12-d8la-d</td><td></td></tr>
<tr><td>maindec-12-d8la-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>A.I.P. Instruction Test II<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d8m>maindec-12-d8m</a></td>
<td><table>
<tr><td>maindec-12-d8ma-d</td><td></td></tr>
<tr><td>maindec-12-d8ma-pb</td><td></td></tr>
<tr><td>maindec-12-d8mb-d</td><td></td></tr>
<tr><td>maindec-12-d8mb-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DB12 Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d9b>maindec-12-d9b</a></td>
<td><table>
<tr><td>maindec-12-d9ba-d</td><td></td></tr>
<tr><td>maindec-12-d9ba-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 Operating Procedures<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d9c>maindec-12-d9c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-d9c/maindec-12-d9ca-d.pdf>maindec-12-d9ca-d</td><td></a></td></tr>
<tr><td>maindec-12-d9ca-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Data Break Card Reader<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dacda>maindec-12-dacda</a></td>
<td><table>
<tr><td>maindec-12-dacda-a-d</td><td></td></tr>
<tr><td>maindec-12-dacda-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CM12F Card Reader Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dacma>maindec-12-dacma</a></td>
<td><table>
<tr><td>maindec-12-dacma-a-d</td><td></td></tr>
<tr><td>maindec-12-dacma-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DC02F OPTION TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dadca>maindec-12-dadca</a></td>
<td><table>
<tr><td>ac-9900a / maindec-12-dadca-a-d</td><td></td></tr>
<tr><td>ak-9902a / maindec-12-dadca-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DV08-N Data Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dadva>maindec-12-dadva</a></td>
<td><table>
<tr><td>maindec-12-dadva-a-d</td><td></td></tr>
<tr><td>maindec-12-dadva-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-12 System Exerciser (replaces 12-D7CD)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-daexa>maindec-12-daexa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-daexa/maindec-12-daexa-a-pb>maindec-12-daexa-a-pb</td><td></a></td></tr>
<tr><td>maindec-12-daexa-a-d</td><td></td></tr>
</table></td></tr>
<tr>
<td>FPP-12 EXERCISER (replaces 12-d0qa)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dafpa>maindec-12-dafpa</a></td>
<td><table>
<tr><td>ac-9910b / maindec-12-dafpa-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dafpa/maindec-12-dafpa-b-pb>ak-9912b / maindec-12-dafpa-b-pb</td><td></a></td></tr>
<tr><td>ac-9910a / maindec-12-dafpa-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dafpa/maindec-12-dafpa-a-pb>ak-9912a / maindec-12-dafpa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FPP-12 INSTRUCTION TEST 2C (replaces 12-d0ob)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dafpb>maindec-12-dafpb</a></td>
<td><table>
<tr><td>ac-9914a / maindec-12-dafpb-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dafpb/maindec-12-dafpb-a-pb>ak-9916a / maindec-12-dafpb-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>FPP-12 ADDRESS TEST (replaces 12-d0pc)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dafpc>maindec-12-dafpc</a></td>
<td><table>
<tr><td>ac-9918a / maindec-12-dafpc-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dafpc/maindec-12-dafpc-a-pb>ak-9920a / maindec-12-dafpc-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Optional Diagnostic LINCtape #1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dakaa>maindec-12-dakaa</a></td>
<td><table>
<tr><td>maindec-12-dakaa-a-ab</td><td></td></tr>
</table></td></tr>
<tr>
<td>Optional Diagnostic LINCtape #2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dakab>maindec-12-dakab</a></td>
<td><table>
<tr><td>maindec-12-dakab-a-ab</td><td></td></tr>
</table></td></tr>
<tr>
<td>Basic System Diagnostic Linktape<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dakac>maindec-12-dakac</a></td>
<td><table>
<tr><td>maindec-12-dakac-a-ab</td><td></td></tr>
</table></td></tr>
<tr>
<td>Optional Diagnostic LINCtape #3<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dakad>maindec-12-dakad</a></td>
<td><table>
<tr><td>maindec-12-dakad-a-ab</td><td></td></tr>
</table></td></tr>
<tr>
<td>Timesharing Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dakta>maindec-12-dakta</a></td>
<td><table>
<tr><td>maindec-12-dakta-a-d</td><td></td></tr>
<tr><td>maindec-12-dakta-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>BM812-I Memory Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-damca>maindec-12-damca</a></td>
<td><table>
<tr><td>maindec-12-damca-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-damca/maindec-12-damca-a-pb>maindec-12-damca-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>VT78 MOS MEMORY DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-12-dkvta>maindec-12-dkvta</a></td>
<td><table>
<tr><td>ac-a821a / maindec-12-dkvta-a-d</td><td></td></tr>
<tr><td>ak-a822a / maindec-12-dkvta-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>VER-14<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-14-d1a>maindec-14-d1a</a></td>
<td><table>
<a name='maindec-14'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-14-d1a/maindec-14-d1ab-d.pdf>maindec-14-d1ab-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-14-d1a/maindec-14-d1ab-pb>maindec-14-d1ab-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TEST-14<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-14-d7a>maindec-14-d7a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-14-d7a/maindec-14-d7ab-d.pdf>maindec-14-d7ab-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-14-d7a/maindec-14-d7ab-pb>maindec-14-d7ab-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TEST-14L<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-14-d7l>maindec-14-d7l</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-14-d7l/maindec-14-d7la-d.pdf>maindec-14-d7la-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-14-d7l/maindec-14-d7la-pb>maindec-14-d7la-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>ABE-14<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-14-d8a>maindec-14-d8a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-14-d8a/maindec-14-d8ab-d.pdf>maindec-14-d8ab-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Instruction Test Part 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-801-1>maindec-801-1</a></td>
<td><table>
<a name='maindec-801'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-801-1/maindec-801-1-d.pdf>ac-b187a / maindec-801-1-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-801-1/maindec-801-1-pm>ak-b189a / maindec-801-1-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Instruction Test, Part 2A<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-801-2a>maindec-801-2a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-801-2a/maindec-801-2a-d.pdf>maindec-801-2a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-801-2a/maindec-801-2a-pb>maindec-801-2a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Instruction Test - Part 2B<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-801-2b>maindec-801-2b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-801-2b/maindec-801-2b-pb>maindec-801-2b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>JMS and JMP Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-801-2c>maindec-801-2c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-801-2c/maindec-801-2c-pb>maindec-801-2c-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Instruction Test (EAE) Part 3A<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-801-3a>maindec-801-3a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-801-3a/maindec-801-3a-d.pdf>maindec-801-3a-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Instruction Test (EAE) Part 3B<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-801-3b>maindec-801-3b</a></td>
<td><table>
<tr><td>maindec-801-3b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Memory Checkerboard<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-802>maindec-802</a></td>
<td><table>
<a name='maindec-802'></a>
<tr><td>maindec-802-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-802/maindec-802-pm1>maindec-802-pm1</td><td> (High)</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-802/maindec-802-pm2>maindec-802-pm2</td><td> (Low)</a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Memory Address Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-803>maindec-803</a></td>
<td><table>
<a name='maindec-803'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-803/maindec-803-pm>maindec-803-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Teletype Reader Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-810>maindec-810</a></td>
<td><table>
<a name='maindec-810'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-810/maindec-810-pm>maindec-810-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 High Speed Reader Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-811>maindec-811</a></td>
<td><table>
<a name='maindec-811'></a>
<tr><td>maindec-811-pm</td><td></td></tr>
</table></td></tr>
<tr>
<td>TTY Punch Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-812>maindec-812</a></td>
<td><table>
<a name='maindec-812'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-812/maindec-812-pm>maindec-812-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 Teleprinter Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-814>maindec-814</a></td>
<td><table>
<a name='maindec-814'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-814/maindec-814-pm>maindec-814-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8 High Speed Punch Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-817>maindec-817</a></td>
<td><table>
<a name='maindec-817'></a>
<tr><td>maindec-817-pm</td><td></td></tr>
</table></td></tr>
<tr>
<td>Extended Memory Control Test, Part 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-820-1>maindec-820-1</a></td>
<td><table>
<a name='maindec-820'></a>
<tr><td>maindec-820-1-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Extended Memory Checkerboard Part 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-820-2>maindec-820-2</a></td>
<td><table>
<tr><td>maindec-820-2-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>680 Static Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-825>maindec-825</a></td>
<td><table>
<a name='maindec-825'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-825/maindec-825-d.pdf>maindec-825-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-825/maindec-825-pb>maindec-825-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>680 8-Bit Character Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-826a>maindec-826a</a></td>
<td><table>
<a name='maindec-826a'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-826a/maindec-826a-d.pdf>maindec-826a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-826a/maindec-826a-pb>maindec-826a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>680 5-Bit Character Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-826b>maindec-826b</a></td>
<td><table>
<a name='maindec-826b'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-826b/maindec-826b-d.pdf>maindec-826b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-826b/maindec-826b-pb>maindec-826b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>580 System Compiler and Utility Routines<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-827>maindec-827</a></td>
<td><table>
<a name='maindec-827'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-827/maindec-827-pb>maindec-827-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LT08 TELEPRINTER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-828>maindec-828</a></td>
<td><table>
<a name='maindec-828'></a>
<tr><td>ac-b787a / maindec-828-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-828/maindec-828-pb>ak-b789a / maindec-828-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Memory Power On/Off Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-829>maindec-829</a></td>
<td><table>
<a name='maindec-829'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-829/maindec-829-d.pdf>maindec-829-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-829/maindec-829-pb>maindec-829-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Type 30G Symbol Generator Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-830>maindec-830</a></td>
<td><table>
<a name='maindec-830'></a>
<tr><td>maindec-830-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DECtape Maintenance Package<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-831>maindec-831</a></td>
<td><table>
<a name='maindec-831'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-831/maindec-831-pb>maindec-831-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Real-Time Clock Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-832>maindec-832</a></td>
<td><table>
<a name='maindec-832'></a>
<tr><td>maindec-832-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Lots of Little Pictures on the Eight<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-833>maindec-833</a></td>
<td><table>
<a name='maindec-833'></a>
<tr><td>maindec-833-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Type 338 Display PJMP Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-834>maindec-834</a></td>
<td><table>
<a name='maindec-834'></a>
<tr><td>maindec-834-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Type 338 POP Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-835>maindec-835</a></td>
<td><table>
<a name='maindec-835'></a>
<tr><td>maindec-835-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Parity Option Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-839>maindec-839</a></td>
<td><table>
<a name='maindec-839'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-839/maindec-839-d.pdf>maindec-839-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-839/maindec-839-pb>maindec-839-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Type 30 N, G Display Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-843>maindec-843</a></td>
<td><table>
<a name='maindec-843'></a>
<tr><td>maindec-843-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MONROE PRINTER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-844>maindec-844</a></td>
<td><table>
<a name='maindec-844'></a>
<tr><td>ac-b790a / maindec-844-d</td><td></td></tr>
<tr><td>ak-b792a / maindec-844-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PPD-8 A/D Converter<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-845>maindec-845</a></td>
<td><table>
<a name='maindec-845'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-845/maindec-845-d.pdf>maindec-845-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>CR ALPHA CARD DECK #1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-89-d1b1>maindec-89-d1b1</a></td>
<td><table>
<a name='maindec-89'></a>
<tr><td>at-b134a / maindec-89-d1b1-c-cb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CR ALPHA CARD DECK #2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-89-d1b2>maindec-89-d1b2</a></td>
<td><table>
<tr><td>at-b135a / maindec-89-d1b2-c-cb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CM BINARY CARD DECK #1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-89-d2b2>maindec-89-d2b2</a></td>
<td><table>
<tr><td>at-b136a / maindec-89-d2b2-c-cb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CM BINARY CARD DECK #2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-89-d2b3>maindec-89-d2b3</a></td>
<td><table>
<tr><td>at-b137a / maindec-89-d2b3-c-cb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CM ALPHA CARD DECK<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-89-d2c1>maindec-89-d2c1</a></td>
<td><table>
<tr><td>at-b138a / maindec-89-d2c1-c-cb</td><td></td></tr>
</table></td></tr>
<tr>
<td>ONLINE IBM S360 TO DX08/9 EXERCISER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-89-d8b>maindec-89-d8b</a></td>
<td><table>
<tr><td>ac-b793a / maindec-89-d8ba-d</td><td></td></tr>
<tr><td>ak-b795a / maindec-89-d8ba-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8/E Instruction Test 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0a>maindec-8e-d0a</a></td>
<td><table>
<a name='maindec-8e'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0a/maindec-8e-d0ab-d.pdf>maindec-8e-d0ab-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0a/maindec-8e-d0ab-pb>maindec-8e-d0ab-pb</td><td></a></td></tr>
<tr><td>maindec-8e-d0aa-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0a/maindec-8e-d0aa-pb>maindec-8e-d0aa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8/E Instruction Test 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0b>maindec-8e-d0b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0b/maindec-8e-d0bb-d.pdf>maindec-8e-d0bb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0b/maindec-8e-d0bb-pb>maindec-8e-d0bb-pb</td><td></a></td></tr>
<tr><td>maindec-8e-d0ba-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0b/maindec-8e-d0ba-pb>maindec-8e-d0ba-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>8E Adder Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0c>maindec-8e-d0c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0c/maindec-8e-d0cc-d.pdf>maindec-8e-d0cc-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0c/maindec-8e-d0cc-pb>maindec-8e-d0cc-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0c/maindec-8e-d0ca-d.pdf>maindec-8e-d0ca-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0c/maindec-8e-d0ca-pb>maindec-8e-d0ca-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Random AND Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0d>maindec-8e-d0d</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0d/maindec-8e-d0db-d.pdf>maindec-8e-d0db-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0d/maindec-8e-d0db-pb>maindec-8e-d0db-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0d/maindec-8e-d0da-d.pdf>maindec-8e-d0da-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0d/maindec-8e-d0da-pb>maindec-8e-d0da-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Random TAD Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0e>maindec-8e-d0e</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0e/maindec-8e-d0eb-d.pdf>maindec-8e-d0eb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0e/maindec-8e-d0eb-pb>maindec-8e-d0eb-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0e/maindec-8e-d0ea-d.pdf>maindec-8e-d0ea-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0e/maindec-8e-d0ea-pb>maindec-8e-d0ea-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Random ISZ Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0f>maindec-8e-d0f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0f/maindec-8e-d0fc-d.pdf>maindec-8e-d0fc-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0f/maindec-8e-d0fc-pb>maindec-8e-d0fc-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0f/maindec-8e-d0fb-d.pdf>maindec-8e-d0fb-d</td><td></a></td></tr>
<tr><td>maindec-8e-d0fb-pb</td><td></td></tr>
<tr><td>maindec-8e-d0fa-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0f/maindec-8e-d0fa-pb>maindec-8e-d0fa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Random DCA Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0g>maindec-8e-d0g</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0g/maindec-8e-d0gc-d.pdf>maindec-8e-d0gc-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0g/maindec-8e-d0gc-pb>maindec-8e-d0gc-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0g/maindec-8e-d0gb-d.pdf>maindec-8e-d0gb-d</td><td></a></td></tr>
<tr><td>maindec-8e-d0gb-pb</td><td></td></tr>
<tr><td>maindec-8e-d0ga-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0g/maindec-8e-d0ga-pb>maindec-8e-d0ga-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Random JMP Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0h>maindec-8e-d0h</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0h/maindec-8e-d0hc-d.pdf>maindec-8e-d0hc-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0h/maindec-8e-d0hc-pb>maindec-8e-d0hc-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0h/maindec-8e-d0hb-d.pdf>maindec-8e-d0hb-d</td><td></a></td></tr>
<tr><td>maindec-8e-d0hb-pb</td><td></td></tr>
<tr><td>maindec-8e-d0ha-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0h/maindec-8e-d0ha-pb>maindec-8e-d0ha-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Basic JMP-JMS Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0i>maindec-8e-d0i</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0i/maindec-8e-d0ib-d.pdf>maindec-8e-d0ib-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0i/maindec-8e-d0ib-pb>maindec-8e-d0ib-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0i/maindec-8e-d0ia-d.pdf>maindec-8e-d0ia-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0i/maindec-8e-d0ia-pb>maindec-8e-d0ia-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Random JMP-JMS Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0j>maindec-8e-d0j</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0j/maindec-8e-d0jc-d.pdf>maindec-8e-d0jc-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0j/maindec-8e-d0jc-pb>maindec-8e-d0jc-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0j/maindec-8e-d0jb-d.pdf>maindec-8e-d0jb-d</td><td></a></td></tr>
<tr><td>maindec-8e-d0jb-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0j/maindec-8e-d0ja-d.pdf>maindec-8e-d0ja-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0j/maindec-8e-d0ja-pb>maindec-8e-d0ja-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KP8E Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0k>maindec-8e-d0k</a></td>
<td><table>
<tr><td>maindec-8e-d0kc-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>KE8-E (EAE) Instruction Test 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0l>maindec-8e-d0l</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0l/maindec-8e-d0lb-d.pdf>maindec-8e-d0lb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0l/maindec-8e-d0lb-pb>maindec-8e-d0lb-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0l/maindec-8e-d0la-d.pdf>maindec-8e-d0la-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0l/maindec-8e-d0la-pb>maindec-8e-d0la-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KE8-E (EAE) Instruction Test 2 Multiply and Divide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0m>maindec-8e-d0m</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0m/maindec-8e-d0mb-d.pdf>maindec-8e-d0mb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0m/maindec-8e-d0mb-pb>maindec-8e-d0mb-pb</td><td></a></td></tr>
<tr><td>maindec-8e-d0ma-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0m/maindec-8e-d0ma-pb>maindec-8e-d0ma-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8E JMP Self Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0n>maindec-8e-d0n</a></td>
<td><table>
<tr><td>maindec-8e-d0nb-pb</td><td></td></tr>
<tr><td>maindec-8e-d0na-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DP8E Interprocessor Buffer<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0p>maindec-8e-d0p</a></td>
<td><table>
<tr><td>maindec-8e-d0pc-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DR8-EA 12 Channel Digital Interface Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0q>maindec-8e-d0q</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0q/maindec-8e-d0qa-d.pdf>maindec-8e-d0qa-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KE8-E (EAE) Extended Memory Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0r>maindec-8e-d0r</a></td>
<td><table>
<tr><td>maindec-8e-d0ra-d</td><td></td></tr>
<tr><td>maindec-8e-d0ra-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DB8-E Interprocessor Buffer Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d0s>maindec-8e-d0s</a></td>
<td><table>
<tr><td>maindec-8e-d0sa-d</td><td></td></tr>
<tr><td>maindec-8e-d0sa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MM8E 4K Memory Checkerboard<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1a>maindec-8e-d1a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1a/maindec-8e-d1ab-d.pdf>maindec-8e-d1ab-d</td><td></a></td></tr>
<tr><td>maindec-8e-d1ab-pb</td><td></td></tr>
<tr><td>maindec-8e-d1aa-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1a/maindec-8e-d1aa-pb>maindec-8e-d1aa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KM8E 4K Extended Memory Checkerboard<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1b>maindec-8e-d1b</a></td>
<td><table>
<tr><td>maindec-8e-d1bc-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1b/maindec-8e-d1bc-pb>maindec-8e-d1bc-pb</td><td></a></td></tr>
<tr><td>maindec-8e-d1bb-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1b/maindec-8e-d1bb-pb>maindec-8e-d1bb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>Memory Address Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1e>maindec-8e-d1e</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1e/maindec-8e-d1ec-d.pdf>maindec-8e-d1ec-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1e/maindec-8e-d1ec-pb>maindec-8e-d1ec-pb</td><td></a></td></tr>
<tr><td>maindec-8e-d1ea-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1e/maindec-8e-d1ea-pm>maindec-8e-d1ea-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP8E Extended Memory Address Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1f>maindec-8e-d1f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1f/maindec-8e-d1fb-d.pdf>maindec-8e-d1fb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1f/maindec-8e-d1fb-pb>maindec-8e-d1fb-pb</td><td></a></td></tr>
<tr><td>maindec-8e-d1fa-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1f/maindec-8e-d1fa-pb>maindec-8e-d1fa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MEMORY ON/OFF TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1g>maindec-8e-d1g</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1g/maindec-8e-d1gb-d.pdf>ac-b824b / maindec-8e-d1gb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1g/maindec-8e-d1gb-pb>ak-b827b / maindec-8e-d1gb-pb</td><td></a></td></tr>
<tr><td>ac-b824a / maindec-8e-d1ga-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1g/maindec-8e-d1ga-pb>ak-b827a / maindec-8e-d1ga-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP8E Memory Extension and Time Share Control Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1h>maindec-8e-d1h</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1h/maindec-8e-d1ha-d.pdf>maindec-8e-d1ha-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1h/maindec-8e-d1ha-pb>maindec-8e-d1ha-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1h/maindec-8e-d1hb-d.pdf>maindec-8e-d1hb-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MI8-E BOOTSTRAP DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1i>maindec-8e-d1i</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1i/maindec-8e-d1ib-d.pdf>ac-b829b / maindec-8e-d1ib-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1i/maindec-8e-d1ib-pb1>ak-b833b / maindec-8e-d1ib-pb1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1i/maindec-8e-d1ib-pb2>ak-b834b / maindec-8e-d1ib-pb2</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>MR8-E Read Only Memory Test (Low, High)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1j>maindec-8e-d1j</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1j/maindec-8e-d1jb-pb1>maindec-8e-d1jb-pb1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d1j/maindec-8e-d1jb-pb2>maindec-8e-d1jb-pb2</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8/E Teletype and KL8 Asynchronous Data Control Tests<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d2a>maindec-8e-d2a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d2a/maindec-8e-d2ab-d.pdf>maindec-8e-d2ab-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d2a/maindec-8e-d2ab-pb>maindec-8e-d2ab-pb</td><td></a></td></tr>
<tr><td>maindec-8e-d2aa-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d2a/maindec-8e-d2aa-pb>maindec-8e-d2aa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LE8-E Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d2b>maindec-8e-d2b</a></td>
<td><table>
<tr><td>maindec-8e-d2bb-pb</td><td></td></tr>
<tr><td>maindec-8e-d2ba-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>High Speed Reader/Punch Tests<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d2c>maindec-8e-d2c</a></td>
<td><table>
<tr><td>maindec-8e-d2ca-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d2c/maindec-8e-d2ca-pb>maindec-8e-d2ca-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OPTICAL MARK CARD READER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d2d>maindec-8e-d2d</a></td>
<td><table>
<tr><td>ac-b835b / maindec-8e-d2db-d</td><td></td></tr>
<tr><td>ak-b837b / maindec-8e-d2db-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DecWriter (LA30) Control/Exerciser Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d2f>maindec-8e-d2f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d2f/maindec-8e-d2fb-pb>maindec-8e-d2fb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>TD8-E DECTape Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d3a>maindec-8e-d3a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d3a/maindec-8e-d3aa-pb1>maindec-8e-d3aa-pb1</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d3a/maindec-8e-d3aa-pb2>maindec-8e-d3aa-pb2</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8E-XY8E PLOTTER CONTROL & DISPLAY<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d6a>maindec-8e-d6a</a></td>
<td><table>
<tr><td>ac-b839b / maindec-8e-d6ab-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d6a/maindec-8e-d6ab-pb>ak-b841b / maindec-8e-d6ab-pb</td><td></a></td></tr>
<tr><td>af-b839b / maindec-8e-d6ab-dn</td><td></td></tr>
</table></td></tr>
<tr>
<td>AD8E/AM8E A-D Converter and Multiplexer Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d6b>maindec-8e-d6b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d6b/maindec-8e-d6bb-d.pdf>maindec-8e-d6bb-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>VC8-E Display Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d6c>maindec-8e-d6c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d6c/maindec-8e-d6cb-d.pdf>maindec-8e-d6cb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d6c/maindec-8e-d6ca-d.pdf>maindec-8e-d6ca-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DK8E Clocks Diagnostic (renamed to 08-DHDKA-A)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d8a>maindec-8e-d8a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d8a/maindec-8e-d8ac-d.pdf>maindec-8e-d8ac-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d8a/maindec-8e-d8ac-pb>maindec-8e-d8ac-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d8a/maindec-8e-d8ab-d.pdf>maindec-8e-d8ab-d</td><td></a></td></tr>
<tr><td>maindec-8e-d8ab-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Instruction Test 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9a>maindec-8e-d9a</a></td>
<td><table>
<tr><td>ac-b851a / maindec-8e-d9aa-d</td><td></td></tr>
<tr><td>ak-b851a / maindec-8e-d9aa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Instruction Test Part 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9b>maindec-8e-d9b</a></td>
<td><table>
<tr><td>maindec-8e-d9ba-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>8E Adder Tests<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9c>maindec-8e-d9c</a></td>
<td><table>
<tr><td>ac-b859a / maindec-8e-d9ca-d</td><td></td></tr>
<tr><td>ak-b859a / maindec-8e-d9ca-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>RANDOM AND TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9d>maindec-8e-d9d</a></td>
<td><table>
<tr><td>ac-b863a / maindec-8e-d9da-d</td><td></td></tr>
<tr><td>ak-b863a / maindec-8e-d9da-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>RANDOM TAD TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9e>maindec-8e-d9e</a></td>
<td><table>
<tr><td>ac-b867a / maindec-8e-d9ea-d</td><td></td></tr>
<tr><td>ak-b867a / maindec-8e-d9ea-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>RANDOM ISZ TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9f>maindec-8e-d9f</a></td>
<td><table>
<tr><td>ac-b871a / maindec-8e-d9fa-d</td><td></td></tr>
<tr><td>ak-b871a / maindec-8e-d9fa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>RANDOM DCA TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9g>maindec-8e-d9g</a></td>
<td><table>
<tr><td>ac-b875a / maindec-8e-d9ga-d</td><td></td></tr>
<tr><td>ak-b875a / maindec-8e-d9ga-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>RANDOM JMP TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9h>maindec-8e-d9h</a></td>
<td><table>
<tr><td>ac-b879a / maindec-8e-d9ha-d</td><td></td></tr>
<tr><td>ak-b879a / maindec-8e-d9ha-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>BASIC JMP-JMS TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9i>maindec-8e-d9i</a></td>
<td><table>
<tr><td>ac-b883a / maindec-8e-d9ia-d</td><td></td></tr>
<tr><td>ak-b883a / maindec-8e-d9ia-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>RANDOM JMP-JMS TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9j>maindec-8e-d9j</a></td>
<td><table>
<tr><td>ac-b887a / maindec-8e-d9ja-d</td><td></td></tr>
<tr><td>ak-b887a / maindec-8e-d9ja-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MEMORY ADDRESS TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9k>maindec-8e-d9k</a></td>
<td><table>
<tr><td>ac-b891a / maindec-8e-d9ka-d</td><td></td></tr>
<tr><td>ak-b897a / maindec-8e-d9ka-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MM8-E 4K MEMORY CHECKERBOARD<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9l>maindec-8e-d9l</a></td>
<td><table>
<tr><td>ac-b895a / maindec-8e-d9la-d</td><td></td></tr>
<tr><td>ak-b895a / maindec-8e-d9la-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>KP8E POWER FAIL TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9m>maindec-8e-d9m</a></td>
<td><table>
<tr><td>ac-b899a / maindec-8e-d9ma-d</td><td></td></tr>
<tr><td>ak-b899a / maindec-8e-d9ma-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MEMORY POWER ON/OFF TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9n>maindec-8e-d9n</a></td>
<td><table>
<tr><td>ac-b903a / maindec-8e-d9na-d</td><td></td></tr>
<tr><td>ak-b903a / maindec-8e-d9na-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>JMP SELF TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-d9p>maindec-8e-d9p</a></td>
<td><table>
<tr><td>ac-b907a / maindec-8e-d9pa-d</td><td></td></tr>
<tr><td>ak-b907a / maindec-8e-d9pa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8/E Adder Tests<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-dhkaa>maindec-8e-dhkaa</a></td>
<td><table>
<tr><td>maindec-8e-dhkaa-a-d</td><td></td></tr>
<tr><td>maindec-8e-dhkaa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8E Extended Memory Parity Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-dhmp>maindec-8e-dhmp</a></td>
<td><table>
<tr><td>maindec-8e-dhmpa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Self Start Binary Loader<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8e-xbina>maindec-8e-xbina</a></td>
<td><table>
<tr><td>maindec-8e-xbina-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Instruction Test 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d01>maindec-8i-d01</a></td>
<td><table>
<a name='maindec-8i'></a>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d01/maindec-8i-d01c-d.pdf>ac-b911c / maindec-8i-d01c-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d01/maindec-8i-d01c-pb>ak-b913c / maindec-8i-d01c-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d01/maindec-8i-d01b-d.pdf>ac-b911b / maindec-8i-d01b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d01/maindec-8i-d01b-pb>ak-b913c / maindec-8i-d01b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>INSTRUCTION TEST 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d02>maindec-8i-d02</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d02/maindec-8i-d02b-d.pdf>ac-b914b / maindec-8i-d02b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d02/maindec-8i-d02b-pb>ak-b916b / maindec-8i-d02b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>INSTRUCTION TEST 3A<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d0a>maindec-8i-d0a</a></td>
<td><table>
<tr><td>ac-b917a / maindec-8i-d0aa-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d0a/maindec-8i-d0aa-pb>ak-b919a / maindec-8i-d0aa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8I EAE TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d0b>maindec-8i-d0b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d0b/maindec-8i-d0ba-d.pdf>ac-b920a / maindec-8i-d0ba-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d0b/maindec-8i-d0ba-pb>ak-b922a / maindec-8i-d0ba-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>LE8/LP08 Line Printer Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d2a>maindec-8i-d2a</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d2a/maindec-8i-d2ac-pb>maindec-8i-d2ac-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>OPTICAL MARK CARD READER TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d2b>maindec-8i-d2b</a></td>
<td><table>
<tr><td>ac-b923a / maindec-8i-d2ba-d</td><td></td></tr>
<tr><td>ak-b926a / maindec-8i-d2ba-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>680/I TTY RELIABILITY TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d2c>maindec-8i-d2c</a></td>
<td><table>
<tr><td>ac-b927a / maindec-8i-d2ca-d</td><td></td></tr>
<tr><td>ak-b930a / maindec-8i-d2ca-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>MEMORY PARITY IOT TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d4c>maindec-8i-d4c</a></td>
<td><table>
<tr><td>ac-b931a / maindec-8i-d4ca-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d4c/maindec-8i-d4ca-pm>ak-b933a / maindec-8i-d4ca-pm</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DF32 Discless Logic Test, MiniDisc<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d5b>maindec-8i-d5b</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d5b/maindec-8i-d5bb-d.pdf>maindec-8i-d5bb-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d5b/maindec-8i-d5bb-pb>maindec-8i-d5bb-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DF32D Discless Logic Test, MiniDisc<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d5f>maindec-8i-d5f</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d5f/maindec-8i-d5fa-pb>maindec-8i-d5fa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AX08 Diagnostic<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d6a>maindec-8i-d6a</a></td>
<td><table>
<tr><td>ac-b938c / maindec-8i-d6ac-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d6a/maindec-8i-d6ac-pb>ak-b940c / maindec-8i-d6ac-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d6a/maindec-8i-d6ab-d.pdf>ac-b938b / maindec-8i-d6ab-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DV8I DISPLAY DIAGNOSTIC<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d6c>maindec-8i-d6c</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d6c/maindec-8i-d6ce-d.pdf>ac-b941e / maindec-8i-d6ce-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d6c/maindec-8i-d6ce-pb>ak-b944e / maindec-8i-d6ce-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>KW8I Real Time Clock Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d8a>maindec-8i-d8a</a></td>
<td><table>
<tr><td>ac-b953e / maindec-8i-d8ae-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d8a/maindec-8i-d8ae-pb>ak-b956e / maindec-8i-d8ae-pb</td><td></a></td></tr>
<tr><td>ac-b953d / maindec-8i-d8ad-d</td><td></td></tr>
<tr><td>ak-b956d / maindec-8i-d8ad-pb</td><td></td></tr>
<tr><td>ac-b949c / maindec-8i-d8ac-d</td><td>DC08T2/DC08 ON LINE TEST</td></tr>
<tr><td>ak-b952c / maindec-8i-d8ac-pb</td><td>DC08T2/DC08 ON LINE TEST</td></tr>
</table></td></tr>
<tr>
<td>DC08 8 BIT CHARACTER ASSEMBLY ROUTINES<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d8b>maindec-8i-d8b</a></td>
<td><table>
<tr><td>ac-b957b / maindec-8i-d8bb-d</td><td></td></tr>
<tr><td>ak-b960b / maindec-8i-d8bb-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>680-AG Control and Data Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d8c>maindec-8i-d8c</a></td>
<td><table>
<tr><td>maindec-8i-d8ca-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>680-AG On-Line Diagnostic Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d8d>maindec-8i-d8d</a></td>
<td><table>
<tr><td>maindec-8i-d8da-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DC08F AND DC08H OFF LINE TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d8e>maindec-8i-d8e</a></td>
<td><table>
<tr><td>ac-b967a / maindec-8i-d8ea-d</td><td></td></tr>
<tr><td>ak-b973a / maindec-8i-d8ea-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DC08F AND DC08H ON LINE TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8i-d8f>maindec-8i-d8f</a></td>
<td><table>
<tr><td>ac-b974a / maindec-8i-d8fa-d</td><td></td></tr>
<tr><td>ak-b979a / maindec-8i-d8fa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8L Memory Protect Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8l-d0a>maindec-8l-d0a</a></td>
<td><table>
<a name='maindec-8l'></a>
<tr><td>ac-b986b / maindec-8l-d0ab-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8l-d0a/maindec-8l-d0ab-pb>ak-b989b / maindec-8l-d0ab-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8l-d0a/maindec-8l-d0aa-d.pdf>ac-b986a / maindec-8l-d0aa-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8l-d0a/maindec-8l-d0aa-pb>ak-b989a / maindec-8l-d0aa-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8L EXTENDED MEMORY CONTROL TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8l-d1g>maindec-8l-d1g</a></td>
<td><table>
<tr><td>ac-b990c / maindec-8l-d1gc-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8l-d1g/maindec-8l-d1gc-pb>ak-b993c / maindec-8l-d1gc-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>PDP-8L EXTENDED MEMORY CONTROL TEST (12K)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8l-d1h>maindec-8l-d1h</a></td>
<td><table>
<tr><td>ac-b994a / maindec-8l-d1ha-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8l-d1h/maindec-8l-d1ha-pb>ak-b999a / maindec-8l-d1ha-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>BM8-L Extended Memory Control Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8l-d1j>maindec-8l-d1j</a></td>
<td><table>
<tr><td>maindec-8l-d1ja-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8L Memory Parity IOT Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8l-d5a>maindec-8l-d5a</a></td>
<td><table>
<tr><td>maindec-8l-d5aa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>BM8/L Extended Memory Control Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8l-debma>maindec-8l-debma</a></td>
<td><table>
<tr><td>maindec-8l-debma-a-d</td><td></td></tr>
<tr><td>maindec-8l-debma-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8S Instruction Test 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d01>maindec-8s-d01</a></td>
<td><table>
<a name='maindec-8s'></a>
<tr><td>ac-c004b / maindec-8s-d01b-d</td><td></td></tr>
<tr><td>ak-c006b / maindec-8s-d01b-pb</td><td></td></tr>
<tr><td>ac-c004a / maindec-8s-d01a-d</td><td></td></tr>
<tr><td>ak-c006a / maindec-8s-d01a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8S Instruction Test 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d02>maindec-8s-d02</a></td>
<td><table>
<tr><td>maindec-8s-d02b-d</td><td></td></tr>
<tr><td>maindec-8s-d02b-pb</td><td></td></tr>
<tr><td>maindec-8s-d02a-d</td><td></td></tr>
<tr><td>maindec-8s-d02a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8S BASIC JMP-JMS TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d03>maindec-8s-d03</a></td>
<td><table>
<tr><td>ac-c007a / maindec-8s-d03a-d</td><td></td></tr>
<tr><td>ak-c009a / maindec-8s-d03a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8S RANDOM JMP TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d04>maindec-8s-d04</a></td>
<td><table>
<tr><td>ac-c010a / maindec-8s-d04a-d</td><td></td></tr>
<tr><td>ak-c012a / maindec-8s-d04a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8S Random JMP-JMS Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d05>maindec-8s-d05</a></td>
<td><table>
<tr><td>ac-c013b / maindec-8s-d05b-d</td><td></td></tr>
<tr><td>ak-c015b / maindec-8s-d05b-pb</td><td></td></tr>
<tr><td>ac-c013a / maindec-8s-d05a-d</td><td></td></tr>
<tr><td>ak-c015a / maindec-8s-d05a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8S RANDOM DCA TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d06>maindec-8s-d06</a></td>
<td><table>
<tr><td>ac-c014a / maindec-8s-d06a-d</td><td></td></tr>
<tr><td>ak-c018a / maindec-8s-d06a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8S RANDOM ISZ TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d07>maindec-8s-d07</a></td>
<td><table>
<tr><td>ac-c019a / maindec-8s-d07a-d</td><td></td></tr>
<tr><td>ak-c021a / maindec-8s-d07a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8S MEMORY ADDRESS TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d11>maindec-8s-d11</a></td>
<td><table>
<tr><td>ac-c022a / maindec-8s-d11a-d</td><td></td></tr>
<tr><td>ak-c024a / maindec-8s-d11a-pb</td><td></td></tr>
<tr><td>ak-c025a / maindec-8s-d11a-pm</td><td></td></tr>
<tr><td>ak-c026j / maindec-8s-d11j-pb</td><td></td></tr>
<tr><td>ak-c027j / maindec-8s-d11j-pm</td><td></td></tr>
</table></td></tr>
<tr>
<td>PDP-8S 4K Sense Amplifier Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d15>maindec-8s-d15</a></td>
<td><table>
<tr><td>ac-c028a / maindec-8s-d15a-d</td><td></td></tr>
<tr><td>ak-c030a / maindec-8s-d15a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>High Speed Reader Test <br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d23>maindec-8s-d23</a></td>
<td><table>
<tr><td>maindec-8s-d23b-d</td><td></td></tr>
<tr><td>maindec-8s-d23b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DF32 Diskless Logic Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d5b>maindec-8s-d5b</a></td>
<td><table>
<tr><td>maindec-8s-d5bb-d</td><td></td></tr>
<tr><td>maindec-8s-d5bb-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>CALCOMP Plotter Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d6a>maindec-8s-d6a</a></td>
<td><table>
<tr><td>maindec-8s-d6aa-d</td><td></td></tr>
<tr><td>maindec-8s-d6aa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>KW08 Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d8a>maindec-8s-d8a</a></td>
<td><table>
<tr><td>maindec-8s-d8aa-d</td><td></td></tr>
<tr><td>maindec-8s-d8aa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DB8S DATA BREAK TEST 1<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d8b>maindec-8s-d8b</a></td>
<td><table>
<tr><td>ac-c037a / maindec-8s-d8ba-d</td><td></td></tr>
<tr><td>ak-c039a / maindec-8s-d8ba-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DB8S DATA BREAK TEST 2<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-8s-d8c>maindec-8s-d8c</a></td>
<td><table>
<tr><td>ac-c040a / maindec-8s-d8ca-d</td><td></td></tr>
<tr><td>ak-c042a / maindec-8s-d8ca-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>Simple DR8E test program<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-dr8e>maindec-dr8e</a></td>
<td><table>
<a name='maindec-dr8e'></a>
<tr><td>maindec-dr8ea-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>KT8I TIME SHARING OPTION TEST<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-t8-d8a>maindec-t8-d8a</a></td>
<td><table>
<a name='maindec-t8'></a>
<tr><td>ac-c169a / maindec-t8-d8aa-d</td><td></td></tr>
<tr><td>ak-c171a / maindec-t8-d8aa-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DEC/X8 LINCTAPE (TC12/TC01+TU55/TU56)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-ddqaa>maindec-x8-ddqaa</a></td>
<td><table>
<a name='maindec-x8'></a>
<tr><td>maindec-x8-ddqaa-l-pb</td><td></td></tr>
<tr><td>maindec-x8-ddqaa-a-uo</td><td></td></tr>
</table></td></tr>
<tr>
<td>DEC/X8 Module "TC12LT" TC12 LINCTape Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-ddtca>maindec-x8-ddtca</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-ddtca/maindec-x8-ddtca-a-pb>maindec-x8-ddtca-a-pb</td><td></a></td></tr>
<tr><td>maindec-x8-ddtca-a-d</td><td>DEC/X8 TC12LT LINCtape Exerciser</td></tr>
</table></td></tr>
<tr>
<td>AXTCCB0 MOD TC12LT (replaces x8-ddtca)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-ddtcc>maindec-x8-ddtcc</a></td>
<td><table>
<tr><td>ac-c173b / maindec-x8-ddtcc-b-d</td><td></td></tr>
<tr><td>ak-c175b / maindec-x8-ddtcc-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXADAB0 MOD ADRSTT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhada>maindec-x8-dhada</a></td>
<td><table>
<tr><td>ac-c176b / maindec-x8-dhada-b-d</td><td></td></tr>
<tr><td>ak-c178b / maindec-x8-dhada-b-pb</td><td></td></tr>
<tr><td>ac-c176a / maindec-x8-dhada-b-d</td><td></td></tr>
<tr><td>ak-c178a / maindec-x8-dhada-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXCRAB0 MOD CARD8E (CR8E/CR8F/CM8E)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhcra>maindec-x8-dhcra</a></td>
<td><table>
<tr><td>ac-c180b / maindec-x8-dhcra-b-d</td><td></td></tr>
<tr><td>ak-c182b / maindec-x8-dhcra-b-pb</td><td></td></tr>
<tr><td>ac-c180a / maindec-x8-dhcra-a-d</td><td></td></tr>
<tr><td>ak-c182a / maindec-x8-dhcra-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXDPAB0 DEC/X8 MOD DP8E Modem Test Module<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhdpa>maindec-x8-dhdpa</a></td>
<td><table>
<tr><td>ac-c184c / maindec-x8-dhdpa-b-d</td><td></td></tr>
<tr><td>ak-c183c / maindec-x8-dhdpa-b-pb</td><td></td></tr>
<tr><td>ac-c184a / maindec-x8-dhdpa-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhdpa/maindec-x8-dhdpa-a-pb>ak-c183a / maindec-x8-dhdpa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXICAB0 DEC/X8 MOD ICSX8 (ICS-8)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhica>maindec-x8-dhica</a></td>
<td><table>
<tr><td>ac-c186b / maindec-x8-dhica-b-d</td><td></td></tr>
<tr><td>ak-c188b / maindec-x8-dhica-b-pb</td><td></td></tr>
<tr><td>ac-c186a / maindec-x8-dhica-a-d</td><td></td></tr>
<tr><td>ak-c188a / maindec-x8-dhica-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DEC/X8 EAE EDP Module<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhkea>maindec-x8-dhkea</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhkea/maindec-x8-dhkea-a-pb>maindec-x8-dhkea-a-pb</td><td></a></td></tr>
<tr><td>maindec-x8-dhkea-a-d</td><td>DEC/X8 EAEDP EAE Double Precision Exerciser</td></tr>
</table></td></tr>
<tr>
<td>AXKEDB0 MOD EAEDP (replaces x8-dhkea)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhked>maindec-x8-dhked</a></td>
<td><table>
<tr><td>ac-c189b / maindec-x8-dhked-b-d</td><td></td></tr>
<tr><td>ak-c191b / maindec-x8-dhked-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DEC/X8 RK8EDS (RK8E/RK8F+RK05)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhkra>maindec-x8-dhkra</a></td>
<td><table>
<tr><td>maindec-x8-dhkra-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXLQAC0 MOD LQP-8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhlqa>maindec-x8-dhlqa</a></td>
<td><table>
<tr><td>ac-c192c / maindec-x8-dhlqa-c-d</td><td></td></tr>
<tr><td>ak-c195c / maindec-x8-dhlqa-c-pb</td><td></td></tr>
<tr><td>ac-c192a / maindec-x8-dhlqa-a-d</td><td></td></tr>
<tr><td>ak-c195a / maindec-x8-dhlqa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DEC/X8 RK8 EDS Module<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhrka>maindec-x8-dhrka</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhrka/maindec-x8-dhrka-a-pb>maindec-x8-dhrka-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXRKBC0 MOD RK8EDS (replaces x8-dhrka)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhrkb>maindec-x8-dhrkb</a></td>
<td><table>
<tr><td>ac-c196c / maindec-x8-dhrkb-c-d</td><td></td></tr>
<tr><td>ak-c198c / maindec-x8-dhrkb-c-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DEC/X8 FLOPPY (RX8E+RX01)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhrxa>maindec-x8-dhrxa</a></td>
<td><table>
<tr><td>as-c311b / maindec-x8-dhrxa-b-pb</td><td></td></tr>
<tr><td>as-c311j / maindec-x8-dhrxa-j-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXRXBC0 MOD FLOPPY (replaces x8-dhrxa)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhrxb>maindec-x8-dhrxb</a></td>
<td><table>
<tr><td>ac-c199c / maindec-x8-dhrxb-c-d</td><td></td></tr>
<tr><td>ak-c201c / maindec-x8-dhrxb-c-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXTAAC0 MOD TA8ECS TA8-E Cassette System<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhtaa>maindec-x8-dhtaa</a></td>
<td><table>
<tr><td>ac-c202c / maindec-x8-dhtaa-c-d</td><td></td></tr>
<tr><td>ak-c204c / maindec-x8-dhtaa-c-pb</td><td></td></tr>
<tr><td>ac-c202b / maindec-x8-dhtaa-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhtaa/maindec-x8-dhtaa-b-pb>ak-c204b / maindec-x8-dhtaa-b-pb</td><td></a></td></tr>
<tr><td>ac-c202a / maindec-x8-dhtaa-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhtaa/maindec-x8-dhtaa-a-pb>ak-c204a / maindec-x8-dhtaa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXTDAC0 MOD TD8EDT DECtape System<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhtda>maindec-x8-dhtda</a></td>
<td><table>
<tr><td>ac-c205c / maindec-x8-dhtda-c-d</td><td></td></tr>
<tr><td>ak-c207c / maindec-x8-dhtda-c-pb</td><td></td></tr>
<tr><td>ac-c205b / maindec-x8-dhtda-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhtda/maindec-x8-dhtda-b-pb>ak-c207b / maindec-x8-dhtda-b-pb</td><td></a></td></tr>
<tr><td>ac-c205a / maindec-x8-dhtda-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhtda/maindec-x8-dhtda-a-pb>ak-c207a / maindec-x8-dhtda-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXTMAC0 MOD TM8EMT TM8-E Magtape<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhtma>maindec-x8-dhtma</a></td>
<td><table>
<tr><td>ac-c208c / maindec-x8-dhtma-c-d</td><td></td></tr>
<tr><td>ak-c210c / maindec-x8-dhtma-c-pb</td><td></td></tr>
<tr><td>ac-c208b / maindec-x8-dhtma-b-d</td><td></td></tr>
<tr><td>ak-c210b / maindec-x8-dhtma-b-pb</td><td></td></tr>
<tr><td>ac-c208a / maindec-x8-dhtma-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhtma/maindec-x8-dhtma-a-pb>ak-c210a / maindec-x8-dhtma-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXVCAB0 MOD VCAD8E VT8-E Display<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhvca>maindec-x8-dhvca</a></td>
<td><table>
<tr><td>ac-c211b / maindec-x8-dhvca-b-d</td><td></td></tr>
<tr><td>ak-c213b / maindec-x8-dhvca-b-pb</td><td></td></tr>
<tr><td>ac-c211a / maindec-x8-dhvca-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhvca/maindec-x8-dhvca-a-pb>ak-c213a / maindec-x8-dhvca-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXVTAB0 MOD VT8E Display Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhvta>maindec-x8-dhvta</a></td>
<td><table>
<tr><td>ac-c214b / maindec-x8-dhvta-b-d</td><td></td></tr>
<tr><td>ak-c216b / maindec-x8-dhvta-b-pb</td><td></td></tr>
<tr><td>ac-c214a / maindec-x8-dhvta-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dhvta/maindec-x8-dhvta-a-pb>ak-c216a / maindec-x8-dhvta-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXCDAB0 DEC/X8 MOD CDP8<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dicda>maindec-x8-dicda</a></td>
<td><table>
<tr><td>ac-c217b / maindec-x8-dicda-b-d</td><td></td></tr>
<tr><td>ak-c219b / maindec-x8-dicda-b-pb</td><td></td></tr>
<tr><td>ac-c217a / maindec-x8-dicda-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dicda/maindec-x8-dicda-a-pb>ak-c219a / maindec-x8-dicda-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXDCAB0 MOD DC02<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-didca>maindec-x8-didca</a></td>
<td><table>
<tr><td>ac-c220b / maindec-x8-didca-b-d</td><td></td></tr>
<tr><td>ak-c222b / maindec-x8-didca-b-pb</td><td></td></tr>
<tr><td>ac-c220a / maindec-x8-didca-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-didca/maindec-x8-didca-a-pb>ak-c222a / maindec-x8-didca-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXDCBB0 MOD DC08A<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-didcb>maindec-x8-didcb</a></td>
<td><table>
<tr><td>ac-c223b / maindec-x8-didcb-b-d</td><td></td></tr>
<tr><td>ak-c225b / maindec-x8-didcb-b-pb</td><td></td></tr>
<tr><td>ac-c223a / maindec-x8-didcb-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-didcb/maindec-x8-didcb-a-pb>ak-c225a / maindec-x8-didcb-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXDFAC0 MOD DF32DS DF32 Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-didfa>maindec-x8-didfa</a></td>
<td><table>
<tr><td>ac-c226c / maindec-x8-didfa-c-d</td><td></td></tr>
<tr><td>ak-c228c / maindec-x8-didfa-c-pb</td><td></td></tr>
<tr><td>ac-c226b / maindec-x8-didfa-b-d</td><td></td></tr>
<tr><td>ak-c228b / maindec-x8-didfa-b-pb</td><td></td></tr>
<tr><td>ac-c226a / maindec-x8-didfa-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-didfa/maindec-x8-didfa-a-pb>ak-c228a / maindec-x8-didfa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXDKAE0 MOD TIMERA Real Time Clock Tests<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-didka>maindec-x8-didka</a></td>
<td><table>
<tr><td>ac-c229e / maindec-x8-didka-e-d</td><td></td></tr>
<tr><td>ak-c231e / maindec-x8-didka-e-pb</td><td></td></tr>
<tr><td>ac-c229d / maindec-x8-didka-d-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-didka/maindec-x8-didka-d-pb>ak-c231d / maindec-x8-didka-d-pb</td><td></a></td></tr>
<tr><td>ac-c229c / maindec-x8-didka-c-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-didka/maindec-x8-didka-c-pb>ak-c231c / maindec-x8-didka-c-pb</td><td></a></td></tr>
<tr><td>ac-c229a / maindec-x8-didka-a-d</td><td></td></tr>
<tr><td>ak-c231a / maindec-x8-didka-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DEC/X8 Module "FPP12"<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-difpa>maindec-x8-difpa</a></td>
<td><table>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-difpa/maindec-x8-difpa-a-pb>maindec-x8-difpa-a-pb</td><td></a></td></tr>
<tr><td>maindec-x8-difpa-a-d</td><td>DEC/X8 FPP12 Tests</td></tr>
</table></td></tr>
<tr>
<td>AXFPBB0 MOD FPP12<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-difpb>maindec-x8-difpb</a></td>
<td><table>
<tr><td>ac-c232b / maindec-x8-difpb-b-d</td><td></td></tr>
<tr><td>ak-c234b / maindec-x8-difpb-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXKAAB0 MOD MRI08A Memory Reference Instruction Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikaa>maindec-x8-dikaa</a></td>
<td><table>
<tr><td>ac-c235b / maindec-x8-dikaa-b-d</td><td></td></tr>
<tr><td>ak-c237b / maindec-x8-dikaa-b-pb</td><td></td></tr>
<tr><td>ac-c235a / maindec-x8-dikaa-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikaa/maindec-x8-dikaa-a-pb>ak-c237a / maindec-x8-dikaa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXKABB0 MOD RANMRI Random MRI Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikab>maindec-x8-dikab</a></td>
<td><table>
<tr><td>ac-c238b / maindec-x8-dikab-b-d</td><td></td></tr>
<tr><td>ak-c240b / maindec-x8-dikab-b-pb</td><td></td></tr>
<tr><td>ac-c238a / maindec-x8-dikab-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikab/maindec-x8-dikab-a-pb>ak-c240a / maindec-x8-dikab-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXKACC0 MOD OPRATE Operate Instruction Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikac>maindec-x8-dikac</a></td>
<td><table>
<tr><td>ac-c241c / maindec-x8-dikac-c-d</td><td></td></tr>
<tr><td>ak-c243c / maindec-x8-dikac-c-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikac/maindec-x8-dikac-b-d.pdf>ac-c241b / maindec-x8-dikac-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikac/maindec-x8-dikac-b-pb>ak-c243b / maindec-x8-dikac-b-pb</td><td></a></td></tr>
<tr><td>ac-c241a / maindec-x8-dikac-a-d</td><td></td></tr>
<tr><td>ak-c243a / maindec-x8-dikac-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXKADC0 MOD NOTFUN Non-functional IOT Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikad>maindec-x8-dikad</a></td>
<td><table>
<tr><td>ac-c244c / maindec-x8-dikad-c-d</td><td></td></tr>
<tr><td>ak-c246c / maindec-x8-dikad-c-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikad/maindec-x8-dikad-b-d.pdf>ac-c244b / maindec-x8-dikad-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikad/maindec-x8-dikad-b-pb>ak-c246b / maindec-x8-dikad-b-pb</td><td></a></td></tr>
<tr><td>ac-c244a / maindec-x8-dikad-a-d</td><td></td></tr>
<tr><td>ak-c246a / maindec-x8-dikad-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DEC/X8 EAEALL EAE Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikae>maindec-x8-dikae</a></td>
<td><table>
<tr><td>maindec-x8-dikae-a-d</td><td></td></tr>
<tr><td>maindec-x8-dikae-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXKEAC0 MOD EAEALL EAE Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikea>maindec-x8-dikea</a></td>
<td><table>
<tr><td>ac-c247c / maindec-x8-dikea-c-d</td><td></td></tr>
<tr><td>ak-c249c / maindec-x8-dikea-c-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikea/maindec-x8-dikea-b-d.pdf>ac-c247b / maindec-x8-dikea-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikea/maindec-x8-dikea-b-pb>ak-c249b / maindec-x8-dikea-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXKLAB0 DEC/X8 MOD MULTTY TTY Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikla>maindec-x8-dikla</a></td>
<td><table>
<tr><td>ac-c250b / maindec-x8-dikla-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikla/maindec-x8-dikla-b-pb>ak-c252b / maindec-x8-dikla-b-pb</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikla/maindec-x8-dikla-a-d.pdf>ac-c250a / maindec-x8-dikla-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikla/maindec-x8-dikla-a-pb>ak-c252a / maindec-x8-dikla-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXKLBC0 MOD TTYLUP KL8E/F/J Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diklb>maindec-x8-diklb</a></td>
<td><table>
<tr><td>ac-c253c / maindec-x8-diklb-c-d</td><td></td></tr>
<tr><td>ak-c255c / maindec-x8-diklb-c-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diklb/maindec-x8-diklb-b-d.pdf>ac-c253b / maindec-x8-diklb-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diklb/maindec-x8-diklb-b-pb>ak-c255b / maindec-x8-diklb-b-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXKLCB0 DEC/X8 MOD MULSLU KL8A Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diklc>maindec-x8-diklc</a></td>
<td><table>
<tr><td>ac-c256b / maindec-x8-diklc-b-d</td><td></td></tr>
<tr><td>ak-c258b / maindec-x8-diklc-b-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diklc/maindec-x8-diklc-a-d.pdf>ac-c256a / maindec-x8-diklc-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diklc/maindec-x8-diklc-a-pb>ak-c258a / maindec-x8-diklc-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXKLDB0 DEC/X8 MOD MSLULP (KL8A)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dikld>maindec-x8-dikld</a></td>
<td><table>
<tr><td>ac-c260b / maindec-x8-dikld-b-d</td><td></td></tr>
<tr><td>ak-c262b / maindec-x8-dikld-b-pb</td><td></td></tr>
<tr><td>ac-c260a / maindec-x8-dikld-a-d</td><td></td></tr>
<tr><td>ak-c262a / maindec-x8-dikld-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXLAAB0 MOD LA180 Printer Tests<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dilaa>maindec-x8-dilaa</a></td>
<td><table>
<tr><td>ac-c692b / maindec-x8-dilaa-b-d</td><td></td></tr>
<tr><td>ak-c694b / maindec-x8-dilaa-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXLDAB0 MOD LPD8 Control Interface Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dilda>maindec-x8-dilda</a></td>
<td><table>
<tr><td>ac-c263b / maindec-x8-dilda-b-d</td><td></td></tr>
<tr><td>ak-c265b / maindec-x8-dilda-b-pb</td><td></td></tr>
<tr><td>ac-c263a / maindec-x8-dilda-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dilda/maindec-x8-dilda-a-pb>ak-c265a / maindec-x8-dilda-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXLPAC0 MOD PRNTR Printer Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dilpa>maindec-x8-dilpa</a></td>
<td><table>
<tr><td>ac-c267c / maindec-x8-dilpa-c-d</td><td></td></tr>
<tr><td>ak-c269c / maindec-x8-dilpa-c-pb</td><td></td></tr>
<tr><td>ac-c267b / maindec-x8-dilpa-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dilpa/maindec-x8-dilpa-b-pb>ak-c269b / maindec-x8-dilpa-b-pb</td><td></a></td></tr>
<tr><td>ac-c267a / maindec-x8-dilpa-a-d</td><td></td></tr>
<tr><td>ak-c269a / maindec-x8-dilpa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXPAAB0 MOD TYPSET Typesetting Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dipaa>maindec-x8-dipaa</a></td>
<td><table>
<tr><td>ac-c270b / maindec-x8-dipaa-b-d</td><td></td></tr>
<tr><td>ak-c272b / maindec-x8-dipaa-b-pb</td><td></td></tr>
<tr><td>ac-c270a / maindec-x8-dipaa-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dipaa/maindec-x8-dipaa-a-pb>ak-c272a / maindec-x8-dipaa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXPCAB0 MOD HSRHSP HS Reader/Punch Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dipca>maindec-x8-dipca</a></td>
<td><table>
<tr><td>ac-c273b / maindec-x8-dipca-b-d</td><td></td></tr>
<tr><td>ak-c275b / maindec-x8-dipca-b-pb</td><td></td></tr>
<tr><td>ac-c273a / maindec-x8-dipca-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dipca/maindec-x8-dipca-a-pb>ak-c275a / maindec-x8-dipca-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>DEC/X8 FILE<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diqaa>maindec-x8-diqaa</a></td>
<td><table>
<tr><td>ak-c172c / maindec-x8-diqaa-c-pb</td><td></td></tr>
<tr><td>al-c172p / maindec-x8-diqaa-p-uo</td><td> (LT)</td></tr>
<tr><td>al-c289p / maindec-x8-diqaa-p-uc</td><td> (DT)</td></tr>
<tr><td>ap-c284o / maindec-x8-diqaa-p-mc</td><td> (MT)</td></tr>
</table></td></tr>
<tr>
<td>AXQABE0 Monitor/Builder Users Guide<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diqab>maindec-x8-diqab</a></td>
<td><table>
<tr><td>ac-c276e / maindec-x8-diqab-e-d</td><td></td></tr>
<tr><td>ak-c278e / maindec-x8-diqab-e-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diqab/maindec-x8-diqab-d-d.pdf>ac-c276d / maindec-x8-diqab-d-d</td><td></a></td></tr>
<tr><td>ak-c278d / maindec-x8-diqab-d-pb</td><td></td></tr>
<tr><td>ac-c276c / maindec-x8-diqab-c-d</td><td></td></tr>
<tr><td>ak-c278c / maindec-x8-diqab-c-pb</td><td></td></tr>
<tr><td>ac-c276b / maindec-x8-diqab-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diqab/maindec-x8-diqab-b-pb>ak-c278b / maindec-x8-diqab-b-pb</td><td></a></td></tr>
<tr><td>ac-c276a / maindec-x8-diqab-a-d</td><td></td></tr>
<tr><td>ak-c278a / maindec-x8-diqab-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DEC/X8 Software Module Interface Specification<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diqac>maindec-x8-diqac</a></td>
<td><table>
<tr><td>maindec-x8-diqac-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXQADE0 DEC/X8 Detailed Description<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diqad>maindec-x8-diqad</a></td>
<td><table>
<tr><td>ac-c282e / maindec-x8-diqad-e-d</td><td></td></tr>
<tr><td>ak-c283e / maindec-x8-diqad-e-pb</td><td></td></tr>
<tr><td>ac-c282c / maindec-x8-diqad-c-d</td><td></td></tr>
<tr><td>ak-c283c / maindec-x8-diqad-c-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DEC/X8 DECTAPE (TC08/TC01+TU55/TU56)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diqae>maindec-x8-diqae</a></td>
<td><table>
<tr><td>maindec-x8-diqae-l-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diqae/maindec-x8-diqae-h-ub>maindec-x8-diqae-h-ub</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXQAFN0 DEC/X8 Software Module Index<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diqaf>maindec-x8-diqaf</a></td>
<td><table>
<tr><td>ac-c290n / maindec-x8-diqaf-n-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-diqaf/maindec-x8-diqaf-j-d.pdf>ac-c290j / maindec-x8-diqaf-j-d</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXRFAB0 MOD RF08DS RF08 Disk System Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dirfa>maindec-x8-dirfa</a></td>
<td><table>
<tr><td>ac-c293b / maindec-x8-dirfa-b-d</td><td></td></tr>
<tr><td>ak-c295b / maindec-x8-dirfa-b-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dirfa/maindec-x8-dirfa-a-d.pdf>ac-c293a / maindec-x8-dirfa-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dirfa/maindec-x8-dirfa-a-pb>ak-c295a / maindec-x8-dirfa-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXRKAB0 MOD RK8DS RK8 Disk System Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dirka>maindec-x8-dirka</a></td>
<td><table>
<tr><td>ac-c296b / maindec-x8-dirka-b-d</td><td></td></tr>
<tr><td>ak-c298b / maindec-x8-dirka-b-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dirka/maindec-x8-dirka-a-d.pdf>ac-c296a / maindec-x8-dirka-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dirka/maindec-x8-dirka-a-pb>ak-c298a / maindec-x8-dirka-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXRXCA0 MOD RX02<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dirxc>maindec-x8-dirxc</a></td>
<td><table>
<tr><td>ac-e589a / maindec-x8-dirxc-a-d</td><td></td></tr>
<tr><td>ak-e591a / maindec-x8-dirxc-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXTCAC0 TC01DT TC01/TC08 DECtape Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-ditca>maindec-x8-ditca</a></td>
<td><table>
<tr><td>ac-c299c / maindec-x8-ditca-c-d</td><td></td></tr>
<tr><td>ak-c301c / maindec-x8-ditca-c-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-ditca/maindec-x8-ditca-b-d.pdf>ac-c299b / maindec-x8-ditca-b-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-ditca/maindec-x8-ditca-b-pb>ak-c301b / maindec-x8-ditca-b-pb</td><td></a></td></tr>
<tr><td>ac-c299a / maindec-x8-ditca-a-d</td><td></td></tr>
<tr><td>ak-c301a / maindec-x8-ditca-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXTCBD0 MOD TC58MT DECMagtape Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-ditcb>maindec-x8-ditcb</a></td>
<td><table>
<tr><td>ak-c304d / maindec-x8-ditcb-d-d</td><td></td></tr>
<tr><td>ak-c304d / maindec-x8-ditcb-d-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-ditcb/maindec-x8-ditcb-c-d.pdf>ak-c304c / maindec-x8-ditcb-c-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-ditcb/maindec-x8-ditcb-c-pb>ak-c304c / maindec-x8-ditcb-c-pb</td><td></a></td></tr>
<tr><td>ak-c304b / maindec-x8-ditcb-b-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-ditcb/maindec-x8-ditcb-b-pb>ak-c304b / maindec-x8-ditcb-b-pb</td><td></a></td></tr>
<tr><td>ak-c304a / maindec-x8-ditcb-a-d</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-ditcb/maindec-x8-ditcb-a-pb>ak-c304a / maindec-x8-ditcb-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXXYAB0 MOD PLOTTER Incremental Plotter Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dixya>maindec-x8-dixya</a></td>
<td><table>
<tr><td>ac-c305b / maindec-x8-dixya-b-d</td><td></td></tr>
<tr><td>ak-c307b / maindec-x8-dixya-b-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dixya/maindec-x8-dixya-a-d.pdf>ac-c305a / maindec-x8-dixya-a-d</td><td></a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dixya/maindec-x8-dixya-a-pb>ak-c307a / maindec-x8-dixya-a-pb</td><td></a></td></tr>
</table></td></tr>
<tr>
<td>AXFPAB0 MOD FPP8A FPP8-A Exerciser<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-djfpa>maindec-x8-djfpa</a></td>
<td><table>
<tr><td>ac-c308b / maindec-x8-djfpa-b-d</td><td></td></tr>
<tr><td>ak-c310b / maindec-x8-djfpa-b-pb</td><td></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-djfpa/maindec-x8-djfpa-a-d.pdf>ac-c308a / maindec-x8-djfpa-a-d</td><td></a></td></tr>
<tr><td>ak-c310a / maindec-x8-djfpa-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXRLAB0 MOD RL8A<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-djrla>maindec-x8-djrla</a></td>
<td><table>
<tr><td>ac-c676b / maindec-x8-djrla-b-d</td><td></td></tr>
<tr><td>ak-c678b / maindec-x8-djrla-b-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>DEC/X8 FLOPPY (RX8E+RX01)<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-djrxa>maindec-x8-djrxa</a></td>
<td><table>
<tr><td>as-c311f / maindec-x8-djrxa-f-pb</td><td></td></tr>
<tr><td>as-c311j / maindec-x8-djrxa-j-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXDPAA0 MOD DP78 Data and Register Test<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-dkdpa>maindec-x8-dkdpa</a></td>
<td><table>
<tr><td>ac-e629a / maindec-x8-dkdpa-a-d</td><td></td></tr>
<tr><td>ak-e630a / maindec-x8-dkdpa-a-pb</td><td></td></tr>
<tr><td>al-e632a / maindec-x8-dkdpa-a-uc</td><td></td></tr>
</table></td></tr>
<tr>
<td>AXQQAB0 APT-8 System<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/maindec-x8-qiqab>maindec-x8-qiqab</a></td>
<td><table>
<tr><td>ac-c612b / maindec-x8-qiqab-b-d</td><td></td></tr>
<tr><td>ak-c613b / maindec-x8-qiqab-b-pb</td><td></td></tr>
<tr><td>ac-c612a / maindec-x8-qiqab-a-d</td><td></td></tr>
<tr><td>ak-c613a / maindec-x8-qiqab-a-pb</td><td></td></tr>
</table></td></tr>
<tr>
<td>OS/8 V3D EXT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006>qf006</a></td>
<td><table>
<a name='qf'></a>
<tr><td>al-3609c / al-3609c-uo</td><td> Binary (LT)</td></tr>
<tr><td>al-4761c / al-4761c-uc</td><td> Binary (DT)</td></tr>
<tr><td>al-3607c / al-3607c-uo</td><td> Source #1 (LT)</td></tr>
<tr><td>al-3608c / al-3608c-uo</td><td> Source #2 (LT)</td></tr>
<tr><td>al-5584c / al-5584c-uo</td><td> Source #3 (LT)</td></tr>
<tr><td>al-4759c / al-4759c-uc</td><td> Source #1 (DT)</td></tr>
<tr><td>al-4760c / al-4760c-uc</td><td> Source #2 (DT)</td></tr>
<tr><td>al-5586c / al-5586c-uc</td><td> Source #3 (DT)</td></tr>
<tr><td>an-4746c / an-4746c-ha</td><td> Source (RK05)</td></tr>
<tr><td>as-4762c / as-4762c-ya</td><td> Source #1 (RX01)</td></tr>
<tr><td>as-4763c / as-4763c-ya</td><td> Source #2 (RX01)</td></tr>
<tr><td>as-4764c / as-4764c-ya</td><td> Source #3 (RX01)</td></tr>
<tr><td>as-5585c / as-5585c-ya</td><td> Source #4 (RX01)</td></tr>
<tr><td>as-4765c / as-4765c-ta</td><td> Binary #1 (RX01)</td></tr>
<tr><td>ar-4758c / ar-4758c-ta</td><td> Binary #1 (Cassette)</td></tr>
<tr><td>ar-5593c / ar-5593c-ta</td><td> Binary #2 (Cassette)</td></tr>
<tr><td>av-d530a / ar-d530a-d</td><td>TECO Pocket Guide</td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006/ak-4747c-ps>ak-4747c / ak-4747c-ps</td><td> BIN RESEQ</a></td></tr>
<tr><td>ak-4748c / ak-4748c-ps</td><td> BIN BASIC EDITOR</td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006/ak-4749c-ps>ak-4749c / ak-4749c-ps</td><td> BIN BASIC COMPILER</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006/ak-4750c-ps>ak-4750c / ak-4750c-ps</td><td> BIN BASIC LOADER</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006/ak-4751c-ps>ak-4751c / ak-4751c-ps</td><td> BIN BRTS</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006/ak-4752c-ps>ak-4752c / ak-4752c-ps</td><td> BIN EABRTS</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006/ak-4753c-ps>ak-4753c / ak-4753c-ps</td><td> BIN BASIC.UF</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006/ak-4754c-ps>ak-4754c / ak-4754c-ps</td><td> BIN BATCH</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006/ak-4755c-ps>ak-4755c / ak-4755c-ps</td><td> BIN TECO</a></td></tr>
<tr><td>ak-4756c / ak-4756c-ps</td><td> BIN MARK SENSE BATCH</td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006/ak-4757c-ps>ak-4757c / ak-4757c-ps</td><td> BIN GENIOX.RL</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006/ak-5588c-pa>ak-5588c / ak-5588c-pa</td><td> BIN GENIOX.SB</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006/ak-5589c-ps>ak-5589c / ak-5589c-ps</td><td> BIN FUTIL</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006/ak-5590c-ps>ak-5590c / ak-5590c-ps</td><td> BIN BASIC.AF</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006/ak-5591c-ps>ak-5591c / ak-5591c-ps</td><td> BIN BASIC.FF</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf006/ak-5592c-ps>ak-5592c / ak-5592c-ps</td><td> BIN BASIC.SF</a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 F4 V3D<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf008>qf008</a></td>
<td><table>
<tr><td>al-3550d / al-3550d-uo</td><td> Source LINCtape #1</td></tr>
<tr><td>al-3551d / al-3551d-uo</td><td> Source LINCtape #2</td></tr>
<tr><td>al-3552d / al-3552d-uo</td><td> Source LINCtape #3</td></tr>
<tr><td>al-3554d / al-3554d-uo</td><td> Binary LT #1</td></tr>
<tr><td>al-5595d / al-5595d-uo</td><td> Binary LT #2</td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf008/ak-4528d-ps>ak-4528d / ak-4528d-ps</td><td>OS/8 F4 F4.SV</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf008/ak-4529d-ps>ak-4529d / ak-4529d-ps</td><td>OS/8 F4 PASS2.SV</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf008/ak-4530d-ps>ak-4530d / ak-4530d-ps</td><td>OS/8 F4 PASS2O.SV</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf008/ak-4531d-ps>ak-4531d / ak-4531d-ps</td><td>OS/8 F4 PASS3.SV</a></td></tr>
<tr><td>an-4542d / an-4542d-ha</td><td> Source (RK05)</td></tr>
<tr><td>ar-4543d / ar-4543d-ta</td><td> Binary #1 (Cassette)</td></tr>
<tr><td>ar-4544d / ar-4544d-ta</td><td> Binary #2 (Cassette)</td></tr>
<tr><td>al-4545d / al-4545d-uc</td><td>05/8 F4 V3D Source #1 (DT)</td></tr>
<tr><td>al-4546d / al-4546d-uc</td><td>05/8 F4 V3D Source #2 (DT)</td></tr>
<tr><td>al-4547d / al-4547d-uc</td><td>05/8 F4 V3D Source #3 (DT)</td></tr>
<tr><td>al-4549d / al-4549d-uc</td><td>OS/8 F4 Binary #1 (DT)</td></tr>
<tr><td>al-5596d / al-5596d-uc</td><td>OS/8 F4 Binary #2 (DT)</td></tr>
<tr><td>as-4550d / as-4550d-ya</td><td> Source #1 (RX01)</td></tr>
<tr><td>as-4551d / as-4551d-ya</td><td> Source #2 (RX01)</td></tr>
<tr><td>as-4552d / as-4552d-ya</td><td> Source #3 (RX01)</td></tr>
<tr><td>as-4553d / as-4553d-ya</td><td> Source #4 (RX01)</td></tr>
<tr><td>as-4554d / an-4554d-ta</td><td> Binary #1 (RX01)</td></tr>
<tr><td>as-5597d / an-5597d-ta</td><td> Binary #2 (RX01)</td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf008/ak-4555d-ps>ak-4555d / ak-4555d-ps</td><td>OS/8 F4 LIBRA.SV</a></td></tr>
<tr><td>ak-4556d / ak-4556d-ps</td><td>OS/8 F4 FORLIB BIN PT 1</td></tr>
<tr><td>ak-4558d / ak-4558d-ps</td><td>OS/8 F4 FORLIB BIN PT 2</td></tr>
<tr><td>ak-4559d / ak-4559d-ps</td><td>OS/8 F4 FORLIB BIN PT 3</td></tr>
<tr><td>ak-4560d / ak-4560d-ps</td><td>OS/8 F4 FORLIB BIN PT 4</td></tr>
<tr><td>ak-4561d / ak-4561d-ps</td><td>OS/8 F4 FORLIB BIN PT 5</td></tr>
<tr><td>ak-4562d / ak-4562d-ps</td><td>OS/8 F4 FORLIB BIN PT 6</td></tr>
<tr><td>ak-4563d / ak-4563d-ps</td><td>OS/8 F4 FORLIB BIN PT 7</td></tr>
<tr><td>ak-4564d / ak-4564d-ps</td><td>OS/8 F4 FORLIB BIN PS 8</td></tr>
<tr><td>ak-4565d / ak-4565d-ps</td><td>OS/8 F4 FORLIB BIN PS 9</td></tr>
<tr><td>ak-4557d / ak-4557d-ps</td><td>OS/8 F4 FORLIB BIN PT 10</td></tr>
<tr><td>ak-5594d / ak-5594d-ps</td><td>OS/8 F4 FORLIB BIN PT 11</td></tr>
<tr><td>ak-4566d / ak-4566d-ps</td><td>OS/8 F4 FORLIB.RL PT 1</td></tr>
<tr><td>ak-4567d / ak-4567d-ps</td><td>OS/8 F4 FORLIB.RL PT 2</td></tr>
<tr><td>ak-4568d / ak-4568d-ps</td><td>OS/8 F4 FORLIB.RL PT 3</td></tr>
<tr><td>ak-4569d / ak-4569d-ps</td><td>OS/8 F4 FORLIB.RL PT 4</td></tr>
<tr><td>ak-4570d / ak-4570d-ps</td><td>OS/8 F4 FORLIB.RL PT 5</td></tr>
<tr><td>ak-4571d / ak-4571d-ps</td><td>OS/8 F4 FORLIB.RL PT 6</td></tr>
<tr><td>ar-4572d / ar-4572d-ta</td><td> Binary #3 (Cassette)</td></tr>
<tr><td>ar-4573d / ar-4573d-ta</td><td> Binary #4 (Cassette)</td></tr>
<tr><td>ar-4574d / ar-4574d-ta</td><td> Binary #5 (Cassette)</td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf008/ak-4575d-ps>ak-4575d / ak-4575d-ps</td><td>OS/8 F4 LOAD.SV</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf008/ak-4590d-ps>ak-4590d / ak-4590d-ps</td><td>OS/8 F4 RALPH.SV</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf008/ak-4591d-ps>ak-4591d / ak-4591d-ps</td><td>OS/8 F4 FRTS.SV</a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 V3D<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015>qf015</a></td>
<td><table>
<tr><td>al-3580c / al-3580c-uo</td><td> Binary #1 (LT)</td></tr>
<tr><td>al-3581c / al-3581c-uo</td><td> Binary #2 (LT)</td></tr>
<tr><td>al-4711c / al-4711c-uc</td><td> Binary #1 (DT)</td></tr>
<tr><td>al-4712c / al-4712c-uc</td><td> Binary #2 (DT)</td></tr>
<tr><td>al-3572c / al-3572c-uo</td><td> Source #1 (LT)</td></tr>
<tr><td>al-3573c / al-3573c-uo</td><td> Source #2 (LT)</td></tr>
<tr><td>al-3574c / al-3574c-uo</td><td> Source #3 (LT)</td></tr>
<tr><td>al-3575c / al-3575c-uo</td><td> Source #4 (LT)</td></tr>
<tr><td>al-3576c / al-3576c-uo</td><td> Source #5 (LT)</td></tr>
<tr><td>al-3577c / al-3577c-uo</td><td> Source #6 (LT)</td></tr>
<tr><td>al-3578c / al-3578c-uo</td><td> Source #7 (LT)</td></tr>
<tr><td>an-4650c / an-4650c-ha</td><td> Source (RK05)</td></tr>
<tr><td>as-4699c / as-4699c-ya</td><td> Source #1 (RX01)</td></tr>
<tr><td>as-4700c / as-4700c-ya</td><td> Source #2 (RX01)</td></tr>
<tr><td>as-4701c / as-4701c-ya</td><td> Source #3 (RX01)</td></tr>
<tr><td>as-4702c / as-4702c-ya</td><td> Source #4 (RX01)</td></tr>
<tr><td>as-4703c / as-4703c-ya</td><td> Source #5 (RX01)</td></tr>
<tr><td>as-4704c / as-4704c-ya</td><td> Source #6 (RX01)</td></tr>
<tr><td>as-4705c / as-4705c-ya</td><td> Source #7 (RX01)</td></tr>
<tr><td>as-4706c / as-4706c-ya</td><td> Source #8 (RX01)</td></tr>
<tr><td>as-4707c / as-4707c-ya</td><td> Source #9 (RX01)</td></tr>
<tr><td>as-5587c / as-5587c-ya</td><td> Source #10 (RX01)</td></tr>
<tr><td>as-4708c / as-4708c-ya</td><td> Binary #1 (RX01)</td></tr>
<tr><td>as-4709c / as-4709c-ya</td><td> Binary #2 (RX01)</td></tr>
<tr><td>ar-4685c / ar-4685c-tb</td><td> Binary #1 (Cassette)</td></tr>
<tr><td>ar-4686c / ar-4686c-tb</td><td> Binary #2 (Cassette)</td></tr>
<tr><td>ar-4687c / ar-4687c-tb</td><td> Binary #3 (Cassette)</td></tr>
<tr><td>ar-4688c / ar-4688c-tb</td><td> Binary #4 (Cassette)</td></tr>
<tr><td>ar-4689c / ar-4689c-tb</td><td> Binary #5 (Cassette)</td></tr>
<tr><td>ar-4690c / ar-4690c-tb</td><td> Binary #6 (Cassette)</td></tr>
<tr><td>ak-4651c / ak-4651c-ps</td><td> BIN HELP FILE PT 1</td></tr>
<tr><td>ak-4652c / ak-4652c-ps</td><td> BIN CCL PT 1</td></tr>
<tr><td>ak-4653c / ak-4653c-ps</td><td> BIN CCL PT 2</td></tr>
<tr><td>ak-4654c / ak-4654c-ps</td><td> BIN CCL PT 3</td></tr>
<tr><td>ak-4655c / ak-4655c-ps</td><td> BIN CCL PT 4</td></tr>
<tr><td>ak-4656c / ak-4656c-ps</td><td> BIN CCL PT 5</td></tr>
<tr><td>ak-4658c / ak-4658c-pb</td><td> BIN KL8E PT 1</td></tr>
<tr><td>ak-4659c / ak-4659c-pb</td><td> BIN KL8E PT 2</td></tr>
<tr><td>ak-4660c / ak-4660c-pb</td><td> BIN FILE STRUCTURED HANDLERS</td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4661c-ps>ak-4661c / ak-4661c-ps</td><td> BIN CREF</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4662c-ps>ak-4662c / ak-4662c-ps</td><td> BIN EDIT</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4663c-ps>ak-4663c / ak-4663c-ps</td><td> BIN PAL8</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4664c-ps>ak-4664c / ak-4664c-ps</td><td> BIN PIP</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4665c-ps>ak-4665c / ak-4665c-ps</td><td> BIN MCPIP</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4666c-ps>ak-4666c / ak-4666c-ps</td><td> BIN BITMAP</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4667c-ps>ak-4667c / ak-4667c-ps</td><td> BIN EPIC</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4668c-ps>ak-4668c / ak-4668c-ps</td><td> BIN SRCCOM</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4669c-ps>ak-4669c / ak-4669c-ps</td><td> BIN CCL</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4670c-ps>ak-4670c / ak-4670c-ps</td><td> BIN FOTP</a></td></tr>
<tr><td>ak-4671c / ak-4671c-pb</td><td> BIN NON-FILE STRUCTURED HANDLERS</td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4672c-ps>ak-4672c / ak-4672c-ps</td><td> BIN RESORC</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4673c-ps>ak-4673c / ak-4673c-ps</td><td> BIN DIRECT</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4674c-ps>ak-4674c / ak-4674c-ps</td><td> BIN PIP10</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4675c-ps>ak-4675c / ak-4675c-ps</td><td> BIN CAMP</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4676c-ps>ak-4676c / ak-4676c-ps</td><td> BIN BOOT</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4677c-ps>ak-4677c / ak-4677c-ps</td><td> BIN RXCOPY</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4678c-ps>ak-4678c / ak-4678c-ps</td><td> BIN BUILD</a></td></tr>
<tr><td>ak-4679c / ak-4679c-ps</td><td> BIN MONITOR</td></tr>
<tr><td>ak-4680c / ak-4680c-ps</td><td> BIN COMMAND DECODER</td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4681c-ps>ak-4681c / ak-4681c-ps</td><td> BIN FORT</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4682c-ps>ak-4682c / ak-4682c-ps</td><td> BIN SABR</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4683c-ps>ak-4683c / ak-4683c-ps</td><td> BIN LOADER</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-4684c-ps>ak-4684c / ak-4684c-ps</td><td> BIN LIBSET</a></td></tr>
<tr><td>ak-4710c / ak-4710c-ps</td><td> BIN LIB8</td></tr>
<tr><td>ak-5598c / ak-5598c-ps</td><td> BIN HELP FILE PT 1</td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-5599c-ps>ak-5599c / ak-5599c-ps</td><td> BIN ABSLDR</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-5601c-ps>ak-5601c / ak-5601c-ps</td><td> BIN SET</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-5602c-ps>ak-5602c / ak-5602c-ps</td><td> BIN DTCOPY</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-5603c-ps>ak-5603c / ak-5603c-ps</td><td> BIN TDCOPY</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-5604c-ps>ak-5604c / ak-5604c-ps</td><td> BIN DTFRMT</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-5605c-ps>ak-5605c / ak-5605c-ps</td><td> BIN TDFRMT</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-5606c-ps>ak-5606c / ak-5606c-ps</td><td> BIN HELP</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/ak-5607c-ps>ak-5607c / ak-5607c-ps</td><td> BIN RKLFMT</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/al-4691c-sa>al-4691c / al-4691c-sa</td><td> Source (DT) #1</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/al-4692c-sa>al-4692c / al-4692c-sa</td><td> Source (DT) #2</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/al-4693d-sa>al-4693c / al-4693d-sa</td><td> Source (DT) #3</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/al-4694c-sa>al-4694c / al-4694c-sa</td><td> Source (DT) #4</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/al-4695c-sa>al-4695c / al-4695c-sa</td><td> Source (DT) #5</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/al-4696c-sa>al-4696c / al-4696c-sa</td><td> Source (DT) #6</a></td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf015/al-4697c-sa>al-4697c / al-4697c-sa</td><td> Source (DT) #7</a></td></tr>
</table></td></tr>
<tr>
<td>OS/8 MACREL/LINKER<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf019>qf019</a></td>
<td><table>
<tr><td>al-5642b / al-5642b-uc</td><td> Binary (DT)</td></tr>
<tr><td>al-5643b / al-5643b-ua</td><td> Source #1 (DT)</td></tr>
<tr><td>al-5644b / al-5644b-ua</td><td> Source #2 (DT)</td></tr>
<tr><td>al-h602b / al-h602b-ua</td><td> Source #3 (DT)</td></tr>
<tr><td>al-h603b / al-h603b-ua</td><td> Source #4 (DT)</td></tr>
<tr><td>as-5641b / as-5642b-yc</td><td> Binary (RX01)</td></tr>
<tr><td>as-5645b / as-5645b-ya</td><td> Source #1 (RX01)</td></tr>
<tr><td>as-5646b / as-5646b-ya</td><td> Source #2 (RX01)</td></tr>
<tr><td>as-5647b / as-5647b-ya</td><td> Source #3 (RX01)</td></tr>
<tr><td>as-h604b / as-h604b-ya</td><td> Source #4 (RX01)</td></tr>
<tr><td>aa-5663b / aa-5663b-d</td><td> RELEASE NOTES</td></tr>
<tr><td>aa-5664b / aa-5664b-d</td><td> USERS GUIDE</td></tr>
</table></td></tr>
<tr>
<td>OS/78<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf022>qf022</a></td>
<td><table>
<tr><td>as-5353b / as-5353b-yc</td><td> Binary #1 (RX01)</td></tr>
<tr><td>as-5354b / as-5354b-yc</td><td> Binary #2 (RX01)</td></tr>
<tr><td>as-d912a / as-d912a-ya</td><td> Source #1 (RX01)</td></tr>
<tr><td>as-d913a / as-d913a-ya</td><td> Source #2 (RX01)</td></tr>
<tr><td>as-d914a / as-d914a-ya</td><td> Source #3 (RX01)</td></tr>
<tr><td>as-d915a / as-d915a-ya</td><td> Source #4 (RX01)</td></tr>
<tr><td>as-d916a / as-d916a-ya</td><td> Source #5 (RX01)</td></tr>
<tr><td>as-d917a / as-d917a-ya</td><td> Source #6 (RX01)</td></tr>
<tr><td>as-d918a / as-d918a-ya</td><td> Source #7 (RX01)</td></tr>
<tr><td>as-d919a / as-d919a-ya</td><td> Source #8 (RX01)</td></tr>
<tr><td>as-d920a / as-d920a-ya</td><td> Source #9 (RX01)</td></tr>
<tr><td>as-d921a / as-d921a-ya</td><td> Source #10 (RX01)</td></tr>
<tr><td>as-d922a / as-d922a-ya</td><td> Source #11 (RX01)</td></tr>
<tr><td>as-d923a / as-d923a-ya</td><td> Source #12 (RX01)</td></tr>
<tr><td>av-5582a / av-5582a-d</td><td> Command Summary</td></tr>
<tr><td>aa-d927a / aa-d927a-ta</td><td> Release Notes</td></tr>
</table></td></tr>
<tr>
<td>OS/8 DEV EXT<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf026>qf026</a></td>
<td><table>
<tr><td>al-h525a / al-h525a-uc</td><td> Binary (DT)</td></tr>
<tr><td>an-h526a / an-h526a-hb</td><td> Binary (RK05)</td></tr>
<tr><td>ax-h527a / ax-h527a-hb</td><td> Binary (RL01)</td></tr>
<tr><td>ba-h528a / ba-h528a-yb</td><td> Binary (RX02)</td></tr>
<tr><td>an-h529a / an-h529a-ha</td><td> Source (RK05)</td></tr>
<tr><td>ax-h530a / ax-h530a-hb</td><td> Source (RL01)</td></tr>
<tr><td>as-h587a / as-h587a-yb</td><td> Binary #1 (RX01)</td></tr>
<tr><td>as-h588a / as-h588a-yb</td><td> Binary #2 (RX01)</td></tr>
<tr><td>aa-d319a / aa-d319a-ta</td><td> Users Guide</td></tr>
<tr><td>aa-h565a / aa-h565a-ta</td><td> Release Notes</td></tr>
</table></td></tr>
<tr>
<td>COS-310<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf310>qf310</a></td>
<td><table>
<tr><td>an-0708e / an-0708e-hc</td><td> Operating System (RK05)</td></tr>
<tr><td>as-0714e / as-0714e-yc</td><td> Operating System (RX01)</td></tr>
<tr><td>av-d757a / av-d757a-d</td><td> System Reference Card</td></tr>
<tr><td>ax-h806e / ax-h806e-hc</td><td> Operating System (RL01)</td></tr>
<tr><td>ba-h239e / ba-h239e-yc</td><td> Operating System (RX02)</td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf310/aa-d647a-ta.pdf>aa-d647a / aa-d647a-ta</td><td>COS 310 SYSTEM REFERENCE MANUAL</a></td></tr>
<tr><td>ad-d647a / ad-d647a-dn</td><td>COS 310 SYSTEM REFERENCE MANUAL</td></tr>
<tr><td><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf310/aa-d758a-ta.pdf>aa-d758a / aa-d758a-ta</td><td>COS 310 NEW USERS GUIDE</a></td></tr>
<tr><td>aa-d759b / aa-d759b-d</td><td>COS 310 RELEASE NOTES & INSTALLATION GUIDE</td></tr>
</table></td></tr>
<tr>
<td>COS-310/2780<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf311>qf311</a></td>
<td><table>
<tr><td>aa-0690c / aa-0690c-d</td><td></td></tr>
<tr><td>an-0704d / an-0704d-ha</td><td> (RK05)</td></tr>
<tr><td>an-0705d / an-0705d-ya</td><td> (Floppy)</td></tr>
</table></td></tr>
<tr>
<td>WPS List Processing<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qf7xx>qf7xx</a></td>
<td><table>
<tr><td>aa-5269b / aa-5269b-d</td><td> Users Manual</td></tr>
<tr><td>aa-5264c / aa-5264c-d</td><td>WPS Communications Option Users Manual</td></tr>
<tr><td>aa-5267c / aa-5267c-d</td><td>WPS-8 System Reference Manual</td></tr>
<tr><td>av-5688c / av-5688c-d</td><td>WPS-8 Preface</td></tr>
<tr><td>as-0414c / as-0414c-yb</td><td>WPS-8 Documentation Binary Floppy</td></tr>
<tr><td>as-0415e / as-0415e-yb</td><td>WPS-8 System Binary Floppy</td></tr>
<tr><td>as-d909b / as-d909b-yb</td><td>WPS-8 Release Notes Binary Floppy</td></tr>
<tr><td>as-5265f / as-5265f-yb</td><td>WPS-8/MTS Binary Floppy</td></tr>
<tr><td>as-c875d / as-c875d-yb</td><td>WPS-8/78 Binary Floppy</td></tr>
<tr><td>as-d577b / as-d577b-yb</td><td>WPS-8/FTS Binary Floppy</td></tr>
<tr><td>as-h546a / as-h546a-yb</td><td>WPS-8/81 Binary Floppy</td></tr>
<tr><td>as-h547a / as-h547a-yb</td><td>WPS-8/82 Binary Floppy</td></tr>
</table></td></tr>
<tr>
<td>DIBS on COS-310<br><a href=http://svn.so-much-stuff.com/svn/trunk/pdp8/src/xx/qfaxx>qfaxx</a></td>
<td><table>
<tr><td>aa-h446a / aa-h446a-ta</td><td> A/P Manual</td></tr>
<tr><td>as-h447a / as-h447a-ya</td><td> A/P Source (RX01)</td></tr>
<tr><td>ba-h448a / ba-h448a-ya</td><td> A/P Source (RX02)</td></tr>
<tr><td>aa-h450a / aa-h450-ta</td><td> A/R V1 Manual</td></tr>
<tr><td>as-h451a / as-h451a-ya</td><td> A/R V1 Source (RX01)</td></tr>
<tr><td>ba-h452a / ba-h452a-ya</td><td> A/R V1 Source (RX02)</td></tr>
<tr><td>aa-h454a / aa-h454a-ta</td><td> P/R V1 Manual</td></tr>
<tr><td>as-h455a / as-h455a-ya</td><td> P/R V1 Source (RX01)</td></tr>
<tr><td>ba-h456a / ba-h456a-ya</td><td> P/R V1 Source (RX02)</td></tr>
<tr><td>aa-h458a / aa-h458a-ta</td><td> G/L V1 Manual</td></tr>
<tr><td>as-h459a / as-h459a-ya</td><td> G/L V1 Source (RX01)</td></tr>
<tr><td>ba-h460a / ba-h460a-ya</td><td> G/L V1 Source (RX02)</td></tr>
<tr><td>aa-h462a / aa-h462a-ta</td><td> INV V1 Manual</td></tr>
<tr><td>as-h463a / as-h463a-ya</td><td> INV V1 Source (RX01)</td></tr>
<tr><td>ba-h464a / ba-h464a-ya</td><td> INV V1 Source (RX02)</td></tr>
<tr><td>aa-h549a / aa-h549a-ta</td><td> A/P Build/Install Manual</td></tr>
<tr><td>aa-h550a / aa-h550a-ta</td><td> A/R Build/Install Manual</td></tr>
<tr><td>aa-h551a / aa-h551a-ta</td><td> P/R Build/Install Manual</td></tr>
<tr><td>aa-h552a / aa-h552a-ta</td><td> G/L Build/Install Manual</td></tr>
<tr><td>aa-h553a / aa-h553a-ta</td><td> INV Build/Install Manual</td></tr>
<tr><td>as-h638a / aa-h638a-ta</td><td> A/P Documentation #1 (RX01)</td></tr>
<tr><td>as-h639a / aa-h639a-ta</td><td> A/P Documentation #2 (RX01)</td></tr>
<tr><td>as-h640a / aa-h640a-ta</td><td> A/R Documentation #1 (RX01)</td></tr>
<tr><td>as-h641a / aa-h641a-ta</td><td> A/R Documentation #2 (RX01)</td></tr>
<tr><td>as-h642a / aa-h642a-ta</td><td> A/R Documentation #3 (RX01)</td></tr>
<tr><td>as-h643a / aa-h643a-ta</td><td> P/R Documentation #1 (RX01)</td></tr>
<tr><td>as-h644a / aa-h644a-ta</td><td> P/R Documentation #2 (RX01)</td></tr>
<tr><td>as-h645a / aa-h645a-ta</td><td> P/R Documentation #3 (RX01)</td></tr>
<tr><td>as-h646a / aa-h646a-ta</td><td> INV Documentation #1 (RX01)</td></tr>
<tr><td>as-h647a / aa-h647a-ta</td><td> INV Documentation #2 (RX01)</td></tr>
<tr><td>as-h648a / aa-h648a-ta</td><td> INV Documentation #3 (RX01)</td></tr>
<tr><td>as-h649a / aa-h649a-ta</td><td> G/L Documentation #1 (RX01)</td></tr>
<tr><td>as-h650a / aa-h650a-ta</td><td> G/L Documentation #2 (RX01)</td></tr>
</table></td></tr>
</table>
</div>
</div>
<?php include $_SERVER{'DOCUMENT_ROOT'}.'/pdp8/footer.php'; ?>
