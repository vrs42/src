#!/usr/bin/perl

# "Triple-packed" packed floppies just pack 2 words 
# into 3 bytes.  Here, we just unpack the 3 bytes 
# into two words.

foreach $f (@ARGV) {
  open(INPUT, $f) || die "$f: $!";
  binmode(INPUT);
  $of = $f; $of =~ s/[.]rx01//; $of =~ s/[.]3p//; $of .= ".dsk";
  open(OUTPUT, ">$of") || die "$of: $!";
  binmode(OUTPUT);
  while (read(INPUT, $buf, 3*128) == 3*128) {
    @buf = unpack("C*", $buf);
    while (@buf) {
      $b1 = shift @buf;
      $b2 = shift @buf;
      $b3 = shift @buf;
      # The bit ordering is fugly:
      # abcdefgh ijklmnop qrstuvwx 
      # -> abcdijklmnop efghqrstuvwx
      $word1 = ($b2 << 16) + ($b1 << 8) + $b3;
      $word2 = $word1 & 07777;
      $word1 = $word1 >> 12;
      $word1 = (($word1&017)<<8) + ($word1 >> 4);
      print OUTPUT pack("SS", $word1, $word2);
    }
  }
}
