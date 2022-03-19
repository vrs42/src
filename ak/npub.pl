#!/usr/bin/perl

$dir = "ak";
$DIR = $dir; $DIR =~ y/a-z/A-Z/;
$SVNURL="https://svn.so-much-stuff.com/svn/trunk/pdp8/src/$dir";

if (0) {
  open(INPUT, "Descriptions") || die "Descriptions: $!";
  while (<INPUT>) {
    die "Invalid Descriptions line: $_" unless /^(\S+)\s+(.*)$/;
    $desc{$1} = $2;
  }
  close(INPUT) || die "Descriptions: $!";
} else {
  open(INPUT, "PartNumbers") || die "PartNumbers: $!";
  while (<INPUT>) {
    next if /^#/;
    die "Invalid PartNumbers line: $_" unless /^(\S+)\t(.*)\t(.*)$/;
    $alias{$1} = $2;
    $desc{$1} = $3;
  }
  close(INPUT) || die "Descriptions: $!";
}

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
# Return a suitable link to the current object.  As a side effect, 
# create a dependency list for the object if it needs a .zip file.
$files = $dirs = 0;
sub link {
  # $d is the directory.
  $files++;
  return "$SVNURL/$d";
}

#
# Read a DESCRIPTION file, and extract the documentation from it.
sub description {
  $dirs++;
  open(INPUT, 'DESCRIPTION') || return;
  $lineone = '';
  $lineone = <INPUT>;
  if ($f) {
    $tag = $d;
    # Convert $tag into a link
    print "<FIELDSET><LEGEND>\n";
    $m = "$dir$d"; $m =~ s:[.]/:-:g;
    print "  <b>$m</b>: $lineone\n";
    print "</LEGEND>";
  }
  @work = ();
  while (<INPUT>) {
    print $_;
  }
  close(INPUT);
  if (@work) {
    # Emit HTML. <DL><DT><DD></DL>
    print "<DL>\n";
    foreach $tag (@work) {
      print "<DT>$tag</A>\n";
      print "  <DD>$work{$tag}";
    }
    print "</DL>\n";
  }
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
sub process {
  local($d) = @_;
  local(@sub);
  chdir($root) || die "$root: $!";
  chdir($d) || die "$d: $!";
  # Skip directories without a description.
  if (-f 'DESCRIPTION') {
    &description();
    # Get a list of the subdirectories.
    @sub = ();
    opendir(DIR, '.') || die "$d: $!";
    %files = ();
    foreach (sort readdir(DIR)) {
      $f = $_;
      if (-d $f) {
        next if $f eq '.';
        next if $f eq '..';
        next if $f eq '.svn';
        # Mark directories to skip by imbedding a blank in the name.
        next if $f =~ / /;
        push(@sub, "$d/$f");
        next;
      }
      # It's a regular file, determine the part number root,
      # and remember the file.
      next if $f eq "DESCRIPTION";
      next if $f eq "Descriptions";
      next if $f =~ /[.]php$/i;
      next if $f =~ /[.]pl$/i;
      next if $f =~ /[.]url$/i;
      $match = 0;
      foreach $e (sort bylength keys %exts) {
        next unless $f =~ /(.*)$e$/;
        $r = $1;
        if (defined($files{$r})) {
          $files{$r} .= " $e";
        } else {
          $files{$r} = $e;
        }
        $match = 1;
        last;
      }
      # It's an unknown file, ignore it.
      warn "Skipping $d/$f\n" unless $match;
    }
    closedir(DIR);
    # Now process the files and generate a table.
    print "<table width=100% border=1>\n";
    print "<col width=50%>\n<col width=50%>\n";
    foreach $k (sort keys %files) {
      print "</tr><tr>\n";
      @exts = split(/ /, $files{$k});
      # Get a description for the key
      $m = "$d/$k"; $m =~ s:^[.]/*::;
      $n = $m; $n =~ s:/:-:g;
@desc = %desc;
#warn "desc: @desc\n" unless defined $desc{$m};
      warn "No description for $m (@exts)\n" unless defined $desc{$m};
#     $desc{$m} = "No description" unless defined $desc{$m};
      print "<td>$desc{$m}\n<td>";
      $link = &link();
      print "<table width=100%><col width=50%><col width=50%>\n";
      foreach $e (@exts) {
        print "<td><a href=$link/$k$e>$n$e</a><td>($exts{$e})<tr>\n";
      }
      print "</table>\n";
    }
    print "</table>\n";
    chdir($root) || die "$root: $!";
    foreach (@sub) {
      &process($_);
    }
    print "</FIELDSET>\n";
  }
}

#
# Attempt to locate a product number.
# Product numbers are located in the ../dec subdirectory indicated in %alias,
# or in the current directory under the new name.
sub locate {
  local($p) = @_;
  $alias = $alias{$p};
  if ($alias =~ /md-(..)-([^-]*)/) {
    $dir = "../maindec/$1/$2"; 
#warn "got here: $alias $dir\n";
  } elsif ($alias =~ /md-([^-]*)/) {
    $dir = "../maindec/$1"; 
#warn "got here: $alias $dir\n";
  } elsif ($alias =~ /de-(..)-([^-]*)/) {
    $dir = "../dec/$1/$2"; 
#warn "got here: $alias $dir\n";
  } elsif ($alias =~ /d-(.)-([^-]*)/) {
    $dir = "../dec/$1-$2"; 
#warn "got here: $alias $dir\n";
  } else {
    die "bad alias: $alias\n" if $alias;
    $dir = "";
  }
warn "found: $dir" if -d "$dir";
  return "$dir" if -d "$dir";
  return "$p" if -d $p;
  return undef;
}
#
# Walk the directory tree, looking for files.
if (0) {
  $root = `pwd`;
  chop $root;
  $f = '';
  &process('.');
} else {
  foreach $p (sort keys %desc) {
    $d = &locate($p);
# BUGBUG: Currently names are truncated, omitting "dec-08-" or whatever.
# BUGBUG: Currently names are not grouped; no directory ../dec/08/foo exists.
    print "$d\n" if -d $d;
#   warn "can't find $p" unless -d $d;
  }
}

print STDERR "$files files in $dirs directories\n";

$tail = <<'EOM';
<?php include $_SERVER{'DOCUMENT_ROOT'}.'/pdp8/footer.php'; ?>
EOM
print $tail;
