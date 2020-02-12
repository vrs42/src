#!/usr/bin/perl

# Unpack 3 bytes into 2 words.
# into 3 bytes.  Here, we just unpack the 3 bytes 
# into two words.

foreach $f (@ARGV) {
  open(INPUT, $f) || die "$f: $!";
  binmode(INPUT);
  while (read(INPUT, $buf, 3) == 3) {
    ($b1, $b2, $b3) = unpack("CCC", $buf);
#   $b1 &= 0177;
#   $b2 &= 0177;
#   $b3 &= 0177;
    $b1 += ($b3 << 4) & 07400;
    $b2 += ($b3 << 8) & 07400;
    print pack("SS", $b1, $b2);
  }
}
