#!/usr/bin/perl

$SVNURL="http://svn.so-much-stuff.com/svn/trunk/pdp8/src/decus";

#open(INPUT, "Descriptions") || die "Descriptions: $!";
#while (<INPUT>) {
#  die "Invalid Descriptions line: $_" unless /^(\S+)\s+(.*)$/;
#  $desc{$1} = $2;
#}
#close(INPUT) || die "Descriptions: $!";

$head = <<'EOM';
<?php
  $title = "DECUS Software Files";
  include $_SERVER{'DOCUMENT_ROOT'}.'/pdp8/header.php';
?>
<BODY><FONT size=4>
EOM

$body = <<'EOM';
<P>
Here is my collection of things both DECUS and PDP-8.  The intent here is 
to provide a home for the known surviving bits of the PDP-8 portions of 
DECUS.  However, I haven't yet done anything with the BASIC8, LINC, or 
PDP-12 DECUS stuff.
<P>
Part numbers have been altered slightly.  "5/8-1.1" becomes "5,8-1.1"
because slashes aren't valid in filenames.  In some cases, trailing "a",
"b", etc. have been combined into a single directory, usually because 
there is only a single abstract.  Where the program claims to run on the
PDP-5, I have added the "5," to the front, even if DECUS didn't.  Likewise,
if it clearly runs on the PDP-8, I have added ",8" to the name.
<P>
The usual conventions apply "-pb" are BIN files, "-pm" are RIM format, etc.
In addition, ".pdf" indicates a PDF format scan of the write-up, and ".htm" 
indicates an HTML version of the abstract. 
<P>
As usual, my thanks go out to Al Kossow, Dave Gesswein, and many others who 
have taken the time to scan and archive this software and documentation.
<P>
EOM

$tail = <<'EOM';
<?php include $_SERVER{'DOCUMENT_ROOT'}.'/pdp8/footer.php'; ?>
EOM
#
# Return a suitable link to the current object.  As a side effect, 
# create a dependency list for the object if it needs a .zip file.
$files = $dirs = 0;
sub link {
  # $d is the directory.
  return "$SVNURL/$d";
}

sub bynum {
  die "$a: no number" unless $a =~ /-(\d+)/;
  $aa = $1;
  die "$b: no number" unless $b =~ /-(\d+)/;
  $bb = $1;
  return $aa <=> $bb;
}

#
# Process all subdirectories which match the argument.
sub process {
  local($pattern) = @_;
  local(@sub);

  # Find the subdirectories that match the pattern.
  @sub = ();
  opendir(DIR, '.') || die ".: $!";
  foreach $f (sort readdir(DIR)) {
    if (-d $f) {
      next unless "$f." =~ /^$pattern.*/;
      # Mark directories to skip by imbedding a blank in the name.
      next if $f =~ / /;
      push(@sub, "$f");
      next;
    }
  }
  closedir(DIR);
  # Now process the directories found and generate a table.
  $oname = "decus-$patterns{$pattern}";
# open(STDOUT, ">$oname") || die "$oname: $!";
# print $head;
# print "<table width=100% border=1>\n";
# print "<col width=15%><col width=50%><col width=35%>\n";
  print "<a name=$oname></a>\n";
  undef $/;
  foreach $d (sort bynum @sub) {
    $dirs++;
    if (open(INPUT, "$d/decus-$d.htm")) {
      # Get a description for the part.
      $t = <INPUT>; $t =~ s:</table>.*::is;
      $t =~ /<td>(.*)<td>(.*)/is;
      ($desc, $partno) = ($1, $2);
      $desc =~ s:</td>::is;
      $partno =~ s:</td>::is;
      $partno =~ y/A-Z/a-z/;
      close(INPUT) || die "$d/$d.htm";
    } else {
       $partno = $d;
       $desc = "No abstract found";
    }
    warn "Part number '$d' doesn't match\n"
      unless $partno =~ /^$d\r*\n*/;
    $l = &link($f);
    print "<tr>\n<td><a href=$l target=_blank>$partno</a><td>$desc<td>\n";
    @files = <$d/*>;
    foreach $f (sort @files) {
      $f =~ s/^$d.//;
      next if $f eq "vv";
      $files++;
      print "<div><a href=$l/$f target=_blank>$f</a></div>\n";
    }
  }
# print "</table>\n";
# print $tail;
}

#
# We generate tables for each pattern in %patterns.
%patterns = (
  "[5,8]+-\\d{1,2}[^\\d]", "8-1",
  "[5,8]+-1\\d\\d", "8-100",
  "[5,8]+-2\\d\\d", "8-200",
  "[5,8]+-3\\d\\d", "8-300",
  "[5,8]+-4\\d\\d", "8-400",
  "[5,8]+-5\\d\\d", "8-500",
  "[5,8]+-6\\d\\d", "8-600",
  "[5,8]+-7\\d\\d", "8-700",
  "[5,8]+-8\\d\\d", "8-800",
  "[5,8]+-9\\d\\d", "8-900",
  "focal8-\\d{1,2}[^\\d]", "focal8-1",
  "focal8-1\\d\\d", "focal8-100",
  "focal8-2\\d\\d", "focal8-200",
  "focal8-3\\d\\d", "focal8-300",
);
@patterns = (
  "[5,8]+-\\d{1,2}[^\\d]",
  "[5,8]+-1\\d\\d",
  "[5,8]+-2\\d\\d",
  "[5,8]+-3\\d\\d",
  "[5,8]+-4\\d\\d",
  "[5,8]+-5\\d\\d",
  "[5,8]+-6\\d\\d",
  "[5,8]+-7\\d\\d",
  "[5,8]+-8\\d\\d",
  "[5,8]+-9\\d\\d",
  "focal8-\\d{1,2}[^\\d]",
  "focal8-1\\d\\d",
  "focal8-2\\d\\d",
  "focal8-3\\d\\d",
);

#
# Emit the introductory text.
print $head;
print $body;

#
# Emit quick navigation links
print "<div>Some quick navigation links:</div>\n";
print "<div style=padding-left:23px>\n";
print "<a href=#decus-8-1>8-1</a>\n";
print "<a href=#decus-8-100>8-100</a>\n";
print "<a href=#decus-8-200>8-200</a>\n";
print "<a href=#decus-8-300>8-300</a>\n";
print "<a href=#decus-8-400>8-400</a>\n";
print "<a href=#decus-8-500>8-500</a>\n";
print "<a href=#decus-8-600>8-600</a>\n";
print "<a href=#decus-8-700>8-700</a>\n";
print "<a href=#decus-8-800>8-800</a>\n";
print "<a href=#decus-8-900>8-900</a><br>\n";
print "<a href=#decus-focal8-1>focal8-1</a>\n";
print "<a href=#decus-focal8-100>focal8-100</a>\n";
print "<a href=#decus-focal8-200>focal8-200</a>\n";
print "<a href=#decus-focal8-300>focal8-300</a>\n";
print "</div>\n";
print "<div>You can also scroll around, or you could try searching (i.e., 'disassembler').</div><p>\n";

#
# Walk the directory tree, looking for files.
# Emit the big scrollable table.
print "<div style='overflow-y: auto; height:35%; border:thick green ridge'>\n";
print "<table width=100% border=1>\n";
print "<col width=15%><col width=50%><col width=35%>\n";
$root = `pwd`;
chop $root;
$f = '';
foreach $pattern (@patterns) {
  &process($pattern);
}
print "</table>\n</div>";

# Wrap up.
print $tail;
print STDERR "$files files in $dirs directories\n";
