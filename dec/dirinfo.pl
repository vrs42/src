#!/usr/bin/perl

$dir = "ak";
$DIR = $dir; $DIR =~ y/a-z/A-Z/;
$SVNURL="https://svn.so-much-stuff.com/svn/trunk/pdp8/src/$dir";

#
# Make lists of the directories and files we expect to create.

#
# Here is a list of media type suffixes found on file names.
# Each of these may be followed by a number, i.e. "-pb11".
%exts = (
# Official list of old media types, from the software price list.
# Updated 12/04/20 from PDP-12 Software Components Catalog.
  "-aa", "DECTAPE LINC FORMAT ASCII",
  "-ab", "DECTAPE LINC FORMAT BINARY",
  "-ac", "DECTAPE LINC FORMAT COMBINED MODE",
  "-ca", "CARD DECK, ALPHA",
  "-cb", "CARD DECK, BINARY",
  "-co", "CARD DECK, OPTICAL",
  "-d",  "DOCUMENT",
  "-dn", "DOCUMENT CHANGE NOTICE",
  "-f",  "FICHE",
  "-fa", "FICHE, LISTING",
  "-ha", "DECPACK, ASCII",
  "-hb", "DECPACK, BINARY",
  "-hc", "DECPACK, COMBINED MODE",
  "-la", "LISTING",
  "-ln", "LISTING, CHANGE NOTICE",
  "-ma", "MAGTAPE, ASCII",
  "-mb", "MAGTAPE, BINARY",
  "-mc", "MAGTAPE, COMBINED MODE",
  "-pa", "PAPER TAPE, ASCII SOURCE",
  "-pb", "PAPER TAPE, BINARY",
  "-pl", "PAPER TAPE, LOAD MODULE",
  "-pm", "PAPER TAPE, RIM",
  "-po", "PAPER TAPE, BOOTSTRAP",
  "-pr", "PAPER TAPE, RELOCATABLE",
  "-ps", "PAPER TAPE, SAVE FORMAT",
  "-pt", "PAPER TAPE, NO FORMAT",
  "-ta", "CASSETTE, ASCII SOURCE",
  "-tb", "CASSETTE, BINARY",
  "-tc", "CASSETTE, COMBINED MODE",
  "-ua", "DECTAPE, ASCII SOURCE",
  "-ub", "DECTAPE, BINARY",
  "-uc", "DECTAPE, COMBINED MODE",
  "-uo", "LINCTAPE",
  "-ya", "FLOPPY, ASCII SOURCE",
  "-yb", "FLOPPY, BINARY",
  "-yc", "FLOPPY, COMBINED MODE",
# Stuff added to deal with actual input.
# These may indicate issues with the source material, or
# may be types added later.
# vrs: -dt confirmed
  "-dt", "DECTAPE, DIAGNOSTIC",
);

#
# A quick table of media class codes, and the associated file format.
# These are basically guesswork, as file format should be more
# specific than the media class.
%mt = (
  "aa", "d",	# Manual/Handbook
  "ab", "d",	# System Listing
  "ac", "d",	# Diagnostic Listing
  "ad", "dn",	# Documentation Update
  "ae", "dn",	# SPD (Software Product Description)
  "af", "dn",	# Change/Patch Orders
  "ah", "la",	# Microfiche (documents)
# "aj", "?c",	# RP04
  "ak", "pb",	# Paper Tape
  "al", "uc",	# DECTape/LINCTape
# "am", "?c",	# RK06
  "an", "hc",	# RK05
  "ap", "mc",	# Magtape
  "ar", "tc",	# Cassette
  "as", "yc",	# Floppy
  "at", "cb",	# Card Deck
# "av", "?c",	# Miscellaneous (documents)
  "ax", "hc",	# RL01
# "aw", "?c",	# RP06
  "ba", "yc",	# RX02
);

#
# First, read the DEC part number list in.
open(INPUT, "PartNumbers") || die "PartNumbers: $!";
$ldesc = "";
while (<INPUT>) {
  next if /^#/;
  die "Invalid PartNumbers line: $_" unless /^(\S+)\t(.*)\t(.*)\t(.*)$/;
  $f = $1;
  $media{$f} = $2;
  # Reject lines for media we don't know how to deal with yet.
# next if $media{$f} eq 'aa'; # Manual, handbook
# next if $media{$f} eq 'ac'; # Diagnostic listing
# next if $media{$f} eq 'ad'; # Documentation update
  next if $media{$f} eq 'ah'; # Fiche
  next if $media{$f} eq 'al'; # DECTape
  next if $media{$f} eq 'an'; # RK05
  next if $media{$f} eq 'ap'; # Magtape
  next if $media{$f} eq 'ar'; # Cassette
  next if $media{$f} eq 'as'; # RX01
  next if $media{$f} eq 'av'; # Miscellaneous
  next if $media{$f} eq 'ax'; # RL01
  next if $media{$f} eq 'ba'; # RX02
  $alias{$f} = $3;
  $desc{$f} = $4;
  # Make up an alias if none was provided.
  if (!$alias{$f}) {
    if ($desc{$f} =~ /^A(....)(.)0 /) {
      #
      # Make up a file name based the diagnostic's name.
      $alias{$f} = "xx-08-d$1-$2";
    } else {
      # If all else fails, call it XX-xxxx based on the new part number,
      # and give it it's own directory (ugh!).
      $alias{$f} = "xx-$f";
      # We match descriptions and collect consecutive parts
      # with the same description.
      if ($desc{$f} ne $ldesc) {
        $dir = $alias{$f};
	$dir =~ s/-*.$//; # Lose version number for $dir
        $ldesc = $desc{$f};
      }
      # Attempt to complete a file name based on the media type.
      $alias{$f} .= "-d" if $media{$f} eq 'aa';
      $alias{$f} .= "-d" if $media{$f} eq 'ac';
      $alias{$f} .= "-dn" if $media{$f} eq 'ad';
      $alias{$f} .= "-pa" if $media{$f} eq 'ah';
      $alias{$f} .= "-pb" if $media{$f} eq 'ak';
      $alias{$f} .= "-uc" if $media{$f} eq 'al';
      $alias{$f} .= "-hc" if $media{$f} eq 'an';
      $alias{$f} .= "-mc" if $media{$f} eq 'ap';
      $alias{$f} .= "-tc" if $media{$f} eq 'ar';
#     $alias{$f} .= ".rx01" if $media{$f} eq 'as';
      $alias{$f} .= "-d" if $media{$f} eq 'av';
#     $alias{$f} .= ".rl01" if $media{$f} eq 'ax';
#     $alias{$f} .= ".rx02" if $media{$f} eq 'ba';
    }
    $alias{$f} =~ y/A-Z/a-z/;
#warn "file from media: $f $media{$f} $alias{$f}\n";
  }
}
close(INPUT) || die "Descriptions: $!";

#
# We want to "explode" the database we just read, making a
# list of directories and their contents.  Ideally, we'll get
# to a point where we just edit those directories and files as
# needed, then later re-assemble the database as a web page for
# publishing.

# Fixed a subtle bug: the order of results from 
# "keys %desc" is random, even from one run to 
# the next.  We need longer matches to be tried 
# first, so enforce that here.
sub bylength {
  return length($b) <=> length($a);
}

#
# For each part number, figure out the directory and the file name.
# If no media type is provided, assume there will exist a PDF write-up,
# a PAL source file, and a binary in BIN format.
%dirs = %files = ();
$ldesc = "";
foreach $f (sort keys %desc) {
  $file = $alias{$f};
  # Because folks are used to it, we lengthen "d-" and "de-" prefixes
  # to "dec-", and the "md-" prefix to "maindec-".
  $file =~ s/^d-/dec-/;
  $file =~ s/^de-/dec-/;
  $file =~ s/^md-/maindec-/;
  # If no alias was provided, something is amiss.
  die "$f: no filename\n" unless $file;
  #
  # Implement proper list handling of $media{$f}.
  #
  # If the file lacks a media type, assume "-d" and "-pb".
  # We force in "-d", and fall through for "-pb".
  if ($file !~ /-[acdhlmptuy][abcfmnorst]\d*$/) {
    if ($file !~ /-d$/) {
      $dir = $file;
      $dir =~ s/-*.$//; # Lose version number for $dir
#warn "$f: iterating over $media{$f}\n";
      foreach $m (split(/,/, $media{$f})) {
        $files{"$file-$mt{$m}"} = $f;
        if (defined $dirs{$dir}) {
          # BUGBUG: May need to check for duplication here.
          $dirs{$dir} .= ";$file-$mt{$m}"
        } else {
          $dirs{$dir} = "$file-$mt{$m}";
        }
      }
next;
      $file .= "-pb";
    }
  }
  # The directory name is essentially the name of the file, with
  # version numbers and media type stripped off.  
  # Since at this point, we know there's a media type, we could
  # probably do this by just looking for either /-d$/ or /-..$/.
  $dir = $file;
  foreach $e (sort bylength keys %exts) {
    $dir =~ s/$e\d*$//; # Remove media type
  }
  # At this point, the last character is the version number,
  # possibly preceded by a hyphen.
  $dir =~ s/-*[a-z]$//;
  #
  # Now we have directory and file names.  Add this file to those
  # expected in the directory.
  die "$dir is suspect for $file\n" if $dir =~ /-.*-.*-/;
#warn "checking $dir: $dirs{$dir}\n";
  $files{$file} = $f;
  if (defined $dirs{$dir}) {
    # BUGBUG: May need to check for duplication here.
    $dirs{$dir} .= ";$file"
  } else {
    $dirs{$dir} = $file;
  }
}

#
# Open and read ~/archive.org, remembering files that look interesting.
%archive = ();
if (opendir(DIR, "$ENV{'HOME'}/archive.org")) {
  foreach $f (readdir(DIR)) {
    next unless $f =~ /.pdf$/;
    $k = $f; # Copy the file name
    $k =~ s/_text//;
    $k =~ y/A-Z/a-z/;
    if ($k =~ /maindec-(..)-([^._\s]*)/i) {
      local($d, $n) = ($1, $2);
      $archive{"dec-$d-$n-d.pdf"} = "$ENV{'HOME'}/archive.org/$f";
      $n =~ s/-d$//;
#warn "got one! $f";
      $archive{"maindec-$d-$n-d"} = "$ENV{'HOME'}/archive.org/$f";
    } elsif ($k =~ /dec-(..)-([^._\s]*)/i) {
      local($d, $n) = ($1, $2);
      $archive{"dec-$d-$n-d.pdf"} = "$ENV{'HOME'}/archive.org/$f";
      $n =~ s/-d$//;
#warn "got one! $f";
      $archive{"dec-$d-$n-d.pdf"} = "$ENV{'HOME'}/archive.org/$f";
    }
  } 
  closedir(DIR);
}
#@archive = sort keys %archive;
#print "@archive\n";

#
# Fancy search function.  Looks around for files which might be
# the right one to copy onto the candidate.
sub lookfor {
  local($f) = @_;
  local($c);
  #
  # Is it a maindec?
  if ($f =~ /^maindec-(..)-(.*)/) {
    $c = "../maindec/$1/$2";
    return $c if -f $c;
  }
  #
  # Is it a dec?
  if ($f =~ /^dec-(..)-(.*)/) {
    $c = "../dec/$1/$2";
    return $c if -f $c;
  }
  #
  # Look harder!
  # Maybe archive.org had it?
  $c = $archive{$f};
#warn "got one! $f $c" if $c;
  return $c if -f $c;
  return undef;
}

#
# At this point, we should know all the expected files and where 
# they will live.  For each, output a suitable record so that the
# PartNumbers database can be rebuilt, bottom-up.
$found = $not = 0;
foreach $dir (sort keys %dirs) {
  # Create the directory.
  mkdir $dir unless -d $dir;
  # Open $dir/Files.txt.
  open(FILES, ">$dir/Files.txt") || die "$dir/Files.txt: $!";
  print "$dir:\n";
  @files = split(/\;/, $dirs{$dir});
  foreach $file (sort @files) {
    # Add an output record.
    $f = $files{$file};
    print FILES "$f\t$media{$f}\t$file\t$desc{$f}\n";
    #
    # Modern systems need an extension based on file format.
    # Add an extension if appropriate, to facilitate using and finding them.
    $file .= ".pdf"  if $file =~ /-d$/; 	# Write-up
    $file .= ".pdf"  if $file =~ /-dn$/;	# Change Notice
    $file .= ".pdf"  if $file =~ /-la$/;	# Listing
    $file .= ".tu56" if $file =~ /-uc$/;	# DECTape/LINCTape
    $file .= ".rk05" if $file =~ /-hc$/;	# RK05
    $file .= ".mt"   if $file =~ /-mc$/;	# Magtape
    $file .= ".ct"   if $file =~ /-tc$/; 	# Cassette
    $file .= ".rx01" if $file =~ /-yc$/;	# Floppy
    $file .= ".card" if $file =~ /-cb$/;	# Card Deck
    $file .= ".rl01" if $file =~ /-hc$/;	# RL01
    $file .= ".rx02" if $file =~ /-yc$/;	# RX02
    print "\t$file";
    #
    # Look for the file in our archives.
    $in = &lookfor($file);
    if ($in) {
      print " found: $in\n";
#     print "cp $in $dir/$file\n";
      $found++;
    } else {
      print " not found\n";
      $not++;
    }
  }
}
print "$found files found\n";
print "$not files missing\n";

exit 0
