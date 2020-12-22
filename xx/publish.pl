#!/usr/bin/perl

# BUGBUG: digital-8-\d+-[fsu] part numbers don't include a version number!
# (They should be handled differently when computing directory names.)

$dir = "xx";
$DIR = $dir; $DIR =~ y/a-z/A-Z/;
$SVNURL="http://svn.so-much-stuff.com/svn/trunk/pdp8/src/$dir";

#
# First, read the File list in.
open(INPUT, "PartNumbers") || die "PartNumbers: $!";
$ldesc = "";
while (<INPUT>) {
  next if /^#/;
  die "Invalid Files.txt line: $_" unless /^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\r*$/;
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
        $d = $alias{$f};
	$d =~ s/-*.$//; # Lose version number for $d
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
close(INPUT) || die "Files: $!";

#
# Create the output file.
open(STDOUT, ">$dir.php") || die "$dir.php: $!";

$head = <<'EOM';
<?php
  $title = "$DIR Software Files";
  include $_SERVER{'DOCUMENT_ROOT'}.'/pdp8/header.php';
?>
<BODY><FONT size=4>
EOM
print $head;
#
# Return a suitable link to the current object.
$files = $dirs = $links = 0;
sub link {
  # $f is the file we want a link to.
  $links++;
  return "$SVNURL/$f";
}

#
# Process a directory.
%exts = (
  "-pa", "DEC PAL tape",
  "-pa.lbl", "PAL Tape label",
  "-pa.txt", "PAL Source as text file",
  "-pa.od", "PAL image in octal",
  "-pb", "BIN image",
  "-pb.lbl", "Tape label",
  "-pb.lbl.jpg", "Tape label",
  "-pb.od", "BIN image in octal",
  "-pb1", "BIN image #1",
  "-pb1.lbl", "Tape label",
  "-pb1.od", "BIN image in octal",
  "-pb2", "BIN image #2",
  "-pb2.lbl", "Tape label",
  "-pb2.od", "BIN image in octal",
  "-pm", "RIM image",
  "-pm.lbl", "Tape label",
  "-pm.od", "RIM image in octal",
  "-pr", "Fortran Library image",
  "-pr.lbl", "Fortran Library image label",
  "-pr.od", "Fortran Library image in octal",
  "-d.pdf", "PDF write-up",
  "-d.doc", "Word write-up",
  "-d.txt", "Text write-up",
  "-ma.pdf", "PDF write-up",
  ".bin", "BIN format",
  ".bin.od", "BIN format in octal",
  "-lst", "PAL listing",
  "-lst.lbl", "PAL listing tape label",
  "-lst.od", "PAL listing as octal image",
  "-lst.txt", "PAL listing as a text file",
  ".lst", "PAL listing",
  ".pal", "PAL source",
  "-sv", "OS/8 save image",
  "-sv.htm", "Saved web page",
  "-dg.htm", "Saved web page",
  "-bn.htm", "Saved web page",
  "-sym", "DEC PAL tape",
  "-sym.od", "DEC PAL tape, octal image",
  ".lbl.jpg", "Tape label image",
  "-software-bom.pdf", "Bill of Materials",
  ".pdf", "PDF write-up",
);
# Fixed a subtle bug: the order of results from 
# "keys %desc" is random, even from one run to 
# the next.  We need longer matches to be tried 
# first, so enforce that here.
sub bylength {
  return length($b) <=> length($a);
}

#
# Given a directory, read Files.txt and compose table entries.
sub process {
  local($d) = @_;
  local($first) = 1;

  open(INPUT, "$d/Files.txt") || die "$d/Files.txt: $!";
  # BeginNow process the files and generate a table.
  while (<INPUT>) {
    next if /^#/;
    die "$d: Invalid Files.txt line: $_" unless /^([^\t]*)\t([^\t]*)\t([^\t]*)\t(.*)$/;
    $part = $1;
    $media = $2;
    $alias = $3;
    $desc = $4;
    if ($first) {
      print "<tr>\n";
      $f = $d; $l = &link; $links--;
      print "<td><a href=$l>$d</a></td>\n";
#     print "<td>$media</td>\n";
      print "<td>$desc</td>\n";
      print "<td>\n";
      $first = 0;
    }
    # BUGBUG: Convert $alias to file name, if needed.
    $f = "$d/$alias";
    $f .= ".pdf" if $f =~ /-d\d*$/;
    $f .= ".pdf" if $f =~ /-dn\d*$/;
    $f .= ".pdf" if $f =~ /-la\d*$/;
    $f .= ".pdf" if $f =~ /-ta\d*$/;
    # Output a link if the file exists, otherwise just a name.
    $part = "$media-$part / " if $part;
    if (-f $f) {
      $l = &link;
      print "<a href=$l>$part$alias</a><br>\n";
    } else {
      print "$part$alias<br>\n";
    }
    $files++;
  }
  print "</td></tr>\n";
  $dirs++;
}

#
# Attempt to locate a product number.
# Product numbers are located in the subdirectory implied by %alias.
sub locate {
  local($p) = @_;
  local($d) = $alias{$p};
  # The file name in $alias has a media type and a version number.
  # Remove them to get a directory name.
  $d =~ s/-[a-y][a-y]\d*$//;
  $d =~ s/-*[a-z]$//;
  return "$d/$alias{$p}";
}

#
# Output a description of what's going on.
open(INPUT, 'DESCRIPTION') || return;
while (<INPUT>) {
  print $_;
}
close(INPUT);

#
# Begin creating a table of directories and files.
print "<table width=100% border=1>\n";
#print "<col width=50%>\n<col width=50%>\n";
#
# Process all subdirectories of ".".
opendir(DOT, ".") || die ".: $!";
@dirs = sort (readdir(DOT));
foreach $d (@dirs) {
  next if $d =~ /^[.]/;
  next unless -d $d;
  &process($d);
}
print "</table>\n";
print "</FIELDSET>\n";
print STDERR "$files files in $dirs directories ($links linked)\n";

$tail = <<'EOM';
<?php include $_SERVER{'DOCUMENT_ROOT'}.'/pdp8/footer.php'; ?>
EOM
print $tail;
