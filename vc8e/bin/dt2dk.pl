#!/usr/bin/perl

# Convert SIMH dectape images to disk images.

# This essentially just removes the extra 129th 
# word of each DECtape block.

foreach $f (@ARGV) {
  open(INPUT, $f) || die "$f: $!";
  binmode(INPUT);
  $tap = $f; $f =~ s/[.]tu56$//;
  $f .= ".dsk";

  die "$f: exists" if -f $f;
  open(OUTPUT, ">$f") || die "$f: $!";
  binmode(OUTPUT);

  while (1) {
    $count = read(INPUT, $buf, 129*2);
    die "read($tap): $!" if $count < 0;
    last unless $count;
    die" $f: not an integral number of blocks!" unless $count == 129*2;
    syswrite(OUTPUT, $buf, 128*2) || die "writed($f): $!";
  }
}
exit 0;
