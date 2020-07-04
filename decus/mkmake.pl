#!/usr/bin/perl

#
# Scan the DECUS directories, looking for materials.
# Create a decus.mk file in each directory, indicating 
# which material may be relevant and how to keep them 
# up to date.
#
# Also, generate a "TO DO" list, indicating which files 
# would be required to do a better job.
#

foreach $subd (<*/.>) {
  chop $subd; chop $subd; # remove trailing "/."
# print "$subd\n";
  # Found a sub-directory.  Group the files there by 
  # extension.
  %ext = ();
  foreach $f (<$subd/*>) {
    $b = $f; $b =~ s:.*/::;
    $e = $b; $e =~ s:.*[.]::;
    $e =~ y/A-Z/a-z/;
    next if -d "$subd/$b";
# BUGBUG: These kludges shouldn't be needed!
next if $b eq "bincmp";
next if $b eq "Makefile";
next if $b eq "parity2pal";
next if $b eq "rot";
next if $b eq "fppconst";
next if $b eq "decus-8-102a.tap";
next if $b eq "decus-8-120";
next if $b eq "docode";
next if $b eq "uncode";
next if $b eq "perlpp";
    $ext{$e} .= "$b ";
  }
  # DECUS media codes Run from "A" to "R".  "A" to "G"
  # describe materials you might get, whereas "H" through 
  # "Q" presume you get everything, and describe which
  # media (DECtape, RX01, RK05, etc.)  Code "R" mentions 
  # the special case of "Card Deck", which we ignore here.
  # Here we group things thus:
  # A: decus-*.pdf # Write-up
  # B: decus-*-lst.pdf # Listing
  # B: lst # Listing
  # C: A+B+E # Microfiche
  # D: A+B # Write-up+listing
  # E: *-man.pdf # Manuals
  # F: *.bn # Binary
  # F: *.bin # Binary
  # F: *-pb # Binary
  # G: *.pa # ASCII file
  # G: *.pal # ASCII file
  # G: *.li # ASCII file
  # ...
  # In addition, source files are noted, for the later
  # creation of the makefile.
  $a = $b = $e = $f = $g = $src = "";
  foreach $ext (keys %ext) {
    if ($ext eq "htm") {
      # Nothing to do
    } elsif ($ext eq "bad") {
      # Nothing to do
    } elsif ($ext eq "exe") {
      # Nothing to do
    } elsif ($ext eq "lbl") {
      # Nothing to do
    } elsif ($ext eq "pl") {
      # Nothing to do
    } elsif ($ext eq "pp") {
      # Nothing to do
    } elsif ($ext eq "od") {
      # Nothing to do
    } elsif ($ext eq "err") {
      # Nothing to do
    } elsif ($ext eq "ok") {
      # Nothing to do
    } elsif ($ext eq "dir") {
      # Nothing to do
    } elsif ($ext eq "rx01") {
      # Nothing to do
    } elsif ($ext eq "rk05") {
      # Nothing to do
    } elsif ($ext eq "tu56") {
      # Nothing to do
    } elsif ($ext eq "simh") {
      # Nothing to do
    } elsif ($ext eq "txt") {
      # Nothing to do
    } elsif ($ext eq "bn") {
      $f .= $ext{$ext};
    } elsif ($ext eq "bin") {
      $f .= $ext{$ext};
    } elsif ($ext eq "cbl") {
      $f .= $ext{$ext};
    } elsif ($ext eq "xcb") {
      $f .= $ext{$ext};
    } elsif ($ext eq "sv") {
      $f .= $ext{$ext};
    } elsif ($ext eq "erc") {
      $f .= $ext{$ext};
    } elsif ($ext eq "pt") {
      $f .= $ext{$ext};
    } elsif ($ext eq "rim") {
      $f .= $ext{$ext};
    } elsif ($ext eq "fc") {
      $g .= $ext{$ext};
    } elsif ($ext eq "ft") {
      $g .= $ext{$ext};
    } elsif ($ext eq "for") {
      $g .= $ext{$ext};
    } elsif ($ext eq "ho") {
      $e .= $ext{$ext};
    } elsif ($ext eq "ex") {
      $f .= $ext{$ext};
    } elsif ($ext eq "dat") {
      $f .= $ext{$ext};
    } elsif ($ext eq "hl") {
      $g .= $ext{$ext};
    } elsif ($ext eq "li") {
      $g .= $ext{$ext}; # Lisp source
    } elsif ($ext eq "ms") {
      $g .= $ext{$ext}; # Music
    } elsif ($ext eq "wu") {
      $a .= $ext{$ext};
    } elsif ($ext eq "lst") {
      $b .= $ext{$ext};
    } elsif ($ext eq "03") {
      $g .= $ext{$ext};
    } elsif ($ext eq "pa") {
      $g .= $ext{$ext};
      # Don't consider these source files
    } elsif ($ext eq "pal") {
      $g .= $ext{$ext};
      $src .= $ext{$ext};
    } elsif ($ext eq "pdf") {
      foreach $b (split(/ /, $ext{$ext})) {
        if ($b =~ /^decus-$subd[.]pdf$/) {
          $a .= "$ext{$ext} ";
        } elsif ($b =~ /^decus-.*-lst[.]pdf$/) {
          $b .= "$ext{$ext} ";
        } else {
          $e .= "$ext{$ext} ";
        }
      }
    } else {
      foreach $b (split(/ /, $ext{$ext})) {
        next if $b eq "";
        if ($b =~ /-pb$/) {
          $f .= "$b ";
          next;
        } elsif ($b =~ /-pm$/) {
          $f .= "$b ";
          next;
        } elsif ($b =~ /-ft$/) {
          $g .= "$b ";
          next;
        } elsif ($b =~ /-pa$/) {
          $g .= "$b ";
          next;
        }
        warn "Extension: '$ext': '$subd/$b'\n";
      }
    }
  }
  # At this point, we have lists of files for 
  # distribution in $a, $b, $e, $f, and $g.
  # Things that need a rule are also in $src.
# print "$subd:\n";
# print "A = $a\n";
# print "B = $b\n";
# print "E = $e\n";
# print "F = $f\n";
# print "G = $g\n";
# print "SRC = $src\n";
  if ($f eq "") {
#   warn "No binaries for $subd\n";
  } elsif ($a eq "") {
#   warn "No write-up for $subd\n";
  } elsif ($b eq "") {
    warn "No listing for $subd\n";
# } elsif ($e eq "") {
#   warn "No manual for $subd\n";
# } elsif ($g eq "") {
#   warn "No ascii for $subd\n";
  } elsif ($src eq "") {
    warn "No sources for $subd\n";
  } else {
#   warn "$subd is complete!\n";
  }
#exit 1;
}
