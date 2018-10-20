#!/usr/bin/perl

$dir = "dec";
$DIR = $dir; $DIR =~ y/a-z/A-Z/;
$SVNURL="http://svn.so-much-stuff.com/svn/trunk/pdp8/src/$dir";

open(INPUT, "Descriptions") || die "Descriptions: $!";
while (<INPUT>) {
  die "Invalid Descriptions line: $_" unless /^(\S+)\s+(.*)$/;
  $desc{$1} = $2;
}
close(INPUT) || die "Descriptions: $!";

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
  "-pa1", "DEC PAL tape",
  "-pa1.lbl", "PAL Tape label",
  "-pa1.txt", "PAL Source as text file",
  "-pa1.od", "PAL image in octal",
  "-pa2", "DEC PAL tape",
  "-pa2.lbl", "PAL Tape label",
  "-pa2.txt", "PAL Source as text file",
  "-pa2.od", "PAL image in octal",
  "-pa3", "DEC PAL tape",
  "-pa3.lbl", "PAL Tape label",
  "-pa3.txt", "PAL Source as text file",
  "-pa3.od", "PAL image in octal",
  "-pb", "BIN image",
  "-pb.lbl", "Tape label",
  "-pb.od", "BIN image in octal",
  "-pb1", "BIN image #1",
  "-pb1.lbl", "Tape label",
  "-pb1.od", "BIN image in octal",
  "-pb2", "BIN image #2",
  "-pb2.lbl", "Tape label",
  "-pb2.od", "BIN image in octal",
  "-pb3", "BIN image #3",
  "-pb3.lbl", "Tape label",
  "-pb3.od", "BIN image in octal",
  "-pb4", "BIN image #4",
  "-pb4.lbl", "Tape label",
  "-pb4.od", "BIN image in octal",
  "-pb5", "BIN image #5",
  "-pb5.lbl", "Tape label",
  "-pb5.od", "BIN image in octal",
  "-pb6", "BIN image #6",
  "-pb6.lbl", "Tape label",
  "-pb6.od", "BIN image in octal",
  "-pb7", "BIN image #7",
  "-pb7.lbl", "Tape label",
  "-pb7.od", "BIN image in octal",
  "-pb8", "BIN image #8",
  "-pb8.lbl", "Tape label",
  "-pb8.od", "BIN image in octal",
  "-pb9", "BIN image #9",
  "-pb9.lbl", "Tape label",
  "-pb9.od", "BIN image in octal",
  "-pb10", "BIN image #10",
  "-pb10.lbl", "Tape label",
  "-pb10.od", "BIN image in octal",
  "-pb11", "BIN image #11",
  "-pb11.lbl", "Tape label",
  "-pb11.od", "BIN image in octal",
  "-pb12", "BIN image #12",
  "-pb12.lbl", "Tape label",
  "-pb12.od", "BIN image in octal",
  "-pb13", "BIN image #13",
  "-pb13.lbl", "Tape label",
  "-pb13.od", "BIN image in octal",
  "-pb14", "BIN image #14",
  "-pb14.lbl", "Tape label",
  "-pb14.od", "BIN image in octal",
  "-pb15", "BIN image #15",
  "-pb15.lbl", "Tape label",
  "-pb15.od", "BIN image in octal",
  "-pb16", "BIN image #16",
  "-pb16.lbl", "Tape label",
  "-pb16.od", "BIN image in octal",
  "-pb17", "BIN image #17",
  "-pb17.lbl", "Tape label",
  "-pb17.od", "BIN image in octal",
  "-pb18", "BIN image #18",
  "-pb18.lbl", "Tape label",
  "-pb18.od", "BIN image in octal",
  "-pb19", "BIN image #19",
  "-pb19.lbl", "Tape label",
  "-pb19.od", "BIN image in octal",
  "-pb20", "BIN image #20",
  "-pb20.lbl", "Tape label",
  "-pb20.od", "BIN image in octal",
  "-pb21", "BIN image #21",
  "-pb21.lbl", "Tape label",
  "-pb21.od", "BIN image in octal",
  "-pb22", "BIN image #22",
  "-pb22.lbl", "Tape label",
  "-pb22.od", "BIN image in octal",
  "-pb23", "BIN image #23",
  "-pb23.lbl", "Tape label",
  "-pb23.od", "BIN image in octal",
  "-pb24", "BIN image #24",
  "-pb24.lbl", "Tape label",
  "-pb24.od", "BIN image in octal",
  "-pm", "RIM image",
  "-pm.lbl", "Tape label",
  "-pm.od", "RIM image in octal",
  "-pr", "Fortram Library image",
  "-pr.lbl", "Fortram Library image label",
  "-pr.od", "Fortral Library image in octal",
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
  "-ps", "OS/8 .SV image (paper tape)",
  "-ps.lbl", "OS/8 .SV image tape label",
  "-ps.od", "OS/8 .SV image octal dump",
);
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
      foreach $e (keys %exts) {
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
      warn "No description for $m (@exts)\n" unless defined $desc{$m};
      print "<td>$desc{$m}\n<td>";
      $link = &link();
      print "<table width=100%><col width=50%><col width=50%>\n";
      foreach $e (@exts) {
        print "<td><a href=$link/$k$e>$dir-$n$e</a><td>($exts{$e})<tr>\n";
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
# Walk the directory tree, looking for files.
$root = `pwd`;
chop $root;
$f = '';
&process('.');

print STDERR "$files files in $dirs directories\n";

$tail = <<'EOM';
<?php include $_SERVER{'DOCUMENT_ROOT'}.'/pdp8/footer.php'; ?>
EOM
print $tail;
