#!/usr/bin/perl -w -T
# -T removed so I can glob
#NOTE: background= in table isn't valid html 4.01.  Should switch to css
use strict;

my $base = "/mnt/pdp/htdocs/images";
my $cgi_base = "/mnt/pdp/cgi-bin";
my $ftp = "ftp://ftp.pdp8online.com";

my @proc_dirs = ( 
                  ["misc_dectapes", "/mnt/pdp/ftproot", "images"],
                  ["Wullenweber", "/mnt/pdp/ftproot", "images"],
                  ["Martins-Collection", "/mnt/pdp/ftproot", "images"],
                  ["ps-8", "/mnt/pdp/ftproot", "images"],
                  ["dectape-library", "/mnt/pdp/ftproot", "images"],
                  ["8a-lab8e", "/mnt/pdp/ftproot", "images"],
                  ["misc_floppy", "/mnt/pdp/ftproot", "images"],
                  ["os8", "/mnt/pdp/ftproot", "images"],
                  ["os8/DECmate_I", "/mnt/pdp/ftproot", "images"],
                  ["jby", "/mnt/pdp/ftproot", "images"],
                  ["dms", "/mnt/pdp/ftproot", "images"],
                  ["Hachti_lab8e_dectapes", "/mnt/pdp/ftproot", "images"],
                  ["dial", "/mnt/pdp/ftproot", "linctape-images"],
                  ["os8l", "/mnt/pdp/ftproot", "linctape-images"],
                  ["dmsl", "/mnt/pdp/ftproot", "linctape-images"],
                  ["reder/dial", "/mnt/pdp/ftproot", ""],
                  ["reder/dms", "/mnt/pdp/ftproot", ""],
                  ["reder/os8", "/mnt/pdp/ftproot", ""],
                  ["reder/os8l", "/mnt/pdp/ftproot", ""],
                  ["linc-8-dial", "/mnt/pdp/ftproot", "linctape-images"],
                  ["cos", "/mnt/pdp/ftproot", "images"],
                  ["bitsavers/os8", "/mnt/pdp/ftproot", "images"],
                  ["bitsavers/dectape-library", "/mnt/pdp/ftproot", "images"],
                  ["bitsavers/cos", "/mnt/pdp/ftproot", "images"],
                  ["bitsavers/tss8", "/mnt/pdp/ftproot", "images"],
);

#my @proc_dirs =  (["tmp", "/mnt/pdp/ftproot", "images"]);
#                  ["MARCH-Canfield", "/mnt/pdp/ftproot", "images"],
#my @proc_dirs =  ("misc_dectapes", "two");

open OUT,"> $base/index.shtml" or die "unable to open output";
open TMP,"> $cgi_base/imagedates.txt" or die "unable to open imagedates.txt";
close TMP;

start_html(\*OUT, "PDP-8 Archive");
print OUT "The PDP-8 Archive is available at ";
print OUT "<a href='ftp://ftp.pdp8online.com'>ftp.pdp8online.com</a>.\n";
print OUT "It contains images of PDP-8 disks and tapes, software to use these images such as <a href='ftp://ftp.pdp8online.com/software/dumprest/'>PDP-8 dump and restore programs</a> and other PDP-8 related material.\n";
print OUT "<p>Most of the PDP-8 images from the ftp site are browsable in the following directories.  The web interface allows the contents of the images to be viewed and downloaded.\n";

print OUT "<p>The following images may also <a href='/htdig/search.shtml'>be searched</a>\n";
print OUT "<p>";
my $ref;
print OUT "<table bgcolor='white' border=0 cellspacing=0 cellpadding=1><tr><th>&nbsp;</th><th>Image Name&nbsp;&nbsp;</th><th>Description</th><th>&nbsp;</th></tr>\n";

my $line_cntr = 0;
for $ref (@proc_dirs) {
#   print "@$ref[0] - @$ref[1] \n";
   proc_dir(\*OUT, @$ref[0], @$ref[1], @$ref[2], $base, $line_cntr++);
}
print OUT "</table>\n";

print OUT "<p>About <a href='/images/greenbar.shtml'>green bar</a> paper<br>\n";
print OUT '<p>These images can be used with the <a href="../run.shtml">online PDP-8</a> or they can be used with PDP-8 emulators such as <br><a href="http://simh.trailing-edge.com">SIMH emulator (Unix & Windows source)</a> <br><a href="http://www.cs.uiowa.edu/~jones/pdp8/index.html">Douglas W. Jones emulator (Unix source)</a> <br><a href="http://www.sparetimegizmos.com/Software/WinEight.htm">WinEight emulator (Windows)</a> <br><a href="http://home.t-online.de/home/bernhard.baehr/pdp8e/pdp8e.html">PDP-8/E emulator (Apple Macintosh)</a>';
footer(\*OUT, 1);
close OUT;
print "Don't forget to uncomment www.pdp8online.com in /etc/hosts then rundig\n";
exit;

sub proc_dir {
   my ($out, $name, $path, $dir, $base, $line_cntr) = @_;
   my (@info, @dir, %dirhash);
   my $tmp;
   my $cgi = "/pdp8cgi";
   my $row_cntr = 0;
   my $row_color;
   my $hole_col;

   open INFO,"< $path/$dir/$name/README" or die "unable to open $path/$dir/$name/README $!\n";
   open OUT2,"> $base/$dir/$name.shtml" or die "unable to open output $base/$dir/$name.shtml: $!\n";
   start_html(\*OUT2, "PDP-8 File list for $name");

   my $format = <INFO>; chomp($format);
   $format = substr($format, 2);
   if ($format =~ m/OS\/8/) {
      if ($format =~ m/LINKtape/) {
         $cgi = $cgi . "/os8_html";
      } else {
         $cgi = $cgi . "/os8_html";
      }
   } elsif ($format =~ m/DIAL/) {
      $cgi = $cgi . "/dial_html";
   } elsif ($format =~ m/DMS/) {
      $cgi = $cgi . "/dms_html";
   } elsif ($format =~ m/DECtape Library/) {
      $cgi = $cgi . "/library_html";
   } elsif ($format =~ m/COS/) {
      $cgi = $cgi . "/cos_html";
   } elsif ($format =~ m/TSS/) {
      $cgi = $cgi . "/tss_dectape";
   } else {
      print "Can't find type in format $format\n";
   }
   print OUT2 "$format<br>\n";
   while ($tmp = <INFO>) {
      chomp($tmp);
      # Blank line ends header
      if ($tmp eq "") {
         last;
      }
      if (length($tmp) < 2) {
         $tmp = "";
      } else {
         $tmp = substr($tmp,2);
      }
      push @info, $tmp;
      print OUT2 "$tmp<br>\n";
   } 
   if ($line_cntr % 6 < 3) { 
      $row_color = "bgcolor='#d0f0d0'";
   } else {
      $row_color = "";
   }
   if ($line_cntr == 0) {
      $hole_col = "<td bgcolor=white class='holes' rowspan=9999 width=28>&nbsp;</td>";
   } else {
      $hole_col = "";
   }
   my $new_path;
   if ($dir eq "") {
      $new_path=$name;
   } else {
      $new_path="$dir/$name";
   }
   print $out "<tr $row_color>$hole_col<td><a href='$new_path.shtml'>$name</a> </td><td>$info[0] </td>$hole_col</tr>\n";

   print OUT2 "<br>\n";
   #@dir = glob("$path/$name/*");
   opendir DIR, "$path/$dir/$name" or die "Unable to open dir $!";
   @dir = readdir DIR;
   closedir DIR;
   my $ref;
   for $ref (@dir) {
      #print "dir $ref\n";
      if ($ref ne "README" && $ref ne "." && $ref ne "..") {
         $dirhash{$ref} = 1;
      }
   }

   print OUT2 "<p>Clicking on the image name will bring up a directory from which you can download or view individual files.<p>\n";
   #print OUT2 "Clicking on download will download the image.  You may need to do a save as in your browser (right click) to download and not view the binary file.  <p>\n";

   print OUT2 "<table bgcolor='white' border=0 cellspacing=0 cellpadding=1><tr><th>&nbsp;</th><th>Image Name&nbsp;&nbsp;</th><th>Description</th><th>&nbsp;</th></tr>\n";
   
   while ($tmp = <INFO>) {
      chomp $tmp;
      if ($tmp ne "") {
         my ($fn, $desc, $date);
         ($fn, $desc, $date) = split /\t+/, $tmp, 3;
         if (!defined($desc)) {
            $desc = "&nbsp";
         }

         if ($date) {
           if ($date > 1960 && $date < 2000) {
              open TMP,">> $cgi_base/imagedates.txt" or die "unable to open imagedates.txt";
              print TMP "$dir/$name/$fn $date\n";
              close TMP;
           } else {
              print "Bad date $date rejected\n";
           }
         }
         $desc = strip($desc);
         #print "fn $fn desc $desc date $date\n";
         if ($row_cntr == 0) {
            $hole_col = "<td bgcolor=white class='holes' rowspan=9999 width=28>&nbsp;</td>";
         } else {
            $hole_col = "";
         }
         if ($row_cntr++ % 6 < 3) { 
            $row_color = "bgcolor='#d0f0d0'";
         } else {
            $row_color = "";
         }
         my $enc_fn = URLEncode($fn);
         print OUT2 "<tr $row_color>$hole_col<td><a href='$cgi?act=dir;fn=$dir/$name/$enc_fn;sort=name'>$fn</a> </td><td> $desc </td>$hole_col</tr>\n";
         if ($dirhash{$fn}) {
            $dirhash{$fn} = 0;
         } else {
            print "File $fn not found in directory listing for $name\n";
         }
      }
   }
   print OUT2 "</table>\n";
   print OUT2 "<p>About <a href='/images/greenbar.shtml'>green bar</a> paper<br>\n";
   my ($key, $value);
   while (($key, $value) = each %dirhash) {
      if ($value != 0) {
         print "File $key not found in README for $name\n";
      }
   }

   my $lvl = ($name =~ tr'/'')+2;
   if ($dir eq "") {
      $lvl = $lvl - 1
   }
   footer(\*OUT2, $lvl);
   close OUT2;
}

sub footer {
   my ($out, $level) = @_;
   if ($level == 0) {
      print $out "<!--#include virtual='../footer_l1.shtml' -->\n";
   } elsif ($level == 1) {
      print $out "<!--#include virtual='../footer_l2.shtml' -->\n";
   } elsif ($level == 2) {
      print $out "<!--#include virtual='../../footer_l3.shtml' -->\n";
   } elsif ($level == 3) {
      print $out "<!--#include virtual='../../../footer_l4.shtml' -->\n";
   } else {
      die "Bad footer level $level\n";
   }
   print $out "</body></html>\n";
}

sub start_html {
   my ($out, $title) = @_;
   print $out "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">
 <html> <head> <title>$title</title> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"> <STYLE type=\"text/css\"> TABLE { background: white; border-collapse: separate ; border: 0; border-spacing: 0} TD.holes { background: url(\"/hole.jpg\") white repeat scroll;} </STYLE></head> <body text=black bgcolor='#d0d0d0'>\n";
   print $out "<center>$title</center><br>\n";
}

#########################
#Remove leading/trailing blanks
sub strip {
        my @parms = @_;
        for (@parms) {
        if ($_) {
                s/\s+$//;
		s/^\s+//; 
        }
        }
        return wantarray ? @parms : $parms[0];
}

sub URLEncode {
    my $theURL = $_[0];
   #$theURL =~ s/([\W\._])/"%" . uc(sprintf("%2.2x",ord($1)))/eg;
   $theURL =~ s/([^\w._])/"%" . uc(sprintf("%2.2x",ord($1)))/eg;
   return $theURL;
}
