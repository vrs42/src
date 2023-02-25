#!/usr/bin/perl

$SVNURL="https://svn.so-much-stuff.com/svn/trunk/pdp8/src/maindec";

open(INPUT, "Descriptions") || die "Descriptions: $!";
while (<INPUT>) {
  die "Invalid Descriptions line: $_" unless /^(\S+)\s+(.*)$/;
  $desc{$1} = $2;
}
close(INPUT) || die "Descriptions: $!";

open(STDOUT, ">maindec.php") || die "maindec.php: $!";

$head = <<'EOM';
<?php
  $title = "MAINDEC Software Files";
  include $_SERVER['DOCUMENT_ROOT'].'/pdp8/header.php';
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
    $m = "maindec$d"; $m =~ s:[.]/:-:g;
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
  "-pb", "BIN image",
  "-pb.lbl", "Tape label",
  "-pb.lbl.jpg", "Tape label image",
  "-pb.od", "BIN image in octal",
  "-pb.sym", "Symbol Table",
  "-pb1", "BIN image #1",
  "-pb1.lbl", "Tape label",
  "-pb1.od", "BIN image in octal",
  "-pb2", "BIN image #2",
  "-pb2.lbl", "Tape label",
  "-pb2.od", "BIN image in octal",
  "-pm", "RIM image",
  "-pm.lbl", "Tape label",
  "-pm.od", "RIM image in octal",
  "-d.pdf", "PDF write-up",
  "-d.doc", "Word write-up",
  "-d.txt", "Text write-up",
  "-1.pdf", "PDF ECO write-up",
  "-ma.pdf", "PDF write-up",
  "-pa", "DEC PAL tape",
  ".bin", "BIN format",
  ".bin.od", "BIN format in octal",
  ".lst", "PAL listing",
  ".pal", "PAL source",
  "-sv", "OS/8 save image",
  "-sv.htm", "Saved web page",
  "-dg.htm", "Saved web page",
  "-bn.htm", "Saved web page",
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
        print "<td><a href=$link/$k$e>maindec-$n$e</a><td>($exts{$e})<tr>\n";
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

print STDERR "$files diagnostics in $dirs directories\n";

$tail = <<'EOM';
<?php include $_SERVER['DOCUMENT_ROOT'].'/pdp8/footer.php'; ?>
EOM
print $tail;
