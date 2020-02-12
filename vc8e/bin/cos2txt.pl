#!/usr/bin/perl

# Unpack COS text files.

@cosch = ("",  " ", "!", '"', "#", '$', '%', "&", "'", "(", ")", "*", "+", ",",  "-", ".",
          "/", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":", ";", "<",  "=", ">",
          "?", '@', "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L",  "M", "N",
          "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "[", "\t", "]", "^");
foreach $f (@ARGV) {
  next unless $f =~ /[.](as|db)/;
  open(INPUT, $f) || die "$f: $!";
  binmode(INPUT);
  $of = "$f.txt";
  open(OUTPUT, ">$of") || die "$of: $!";
  # First, unpack every 3 bytes into two words.
  @buf = ();
  while (read(INPUT, $buf, 3) == 3) {
    ($b1, $b2, $b3) = unpack("CCC", $buf);
#   $b1 &= 0177;
#   $b2 &= 0177;
#   $b3 &= 0177;
    $b1 += ($b3 << 4) & 07400;
    $b2 += ($b3 << 8) & 07400;
    #print pack("SS", $b1, $b2);
    push(@buf, $b1, $b2);
  }
  # Now the file is consecutive words in @buf.
  # Output it according to COS conventions.
  while (($len = shift @buf)) {
    $len -= 4096;
last if $len < -2047;
#warn "len == $len\n";
    if ($f =~ /[.]as$/) {
      $linno = shift @buf;
#warn "linno == $linno\n";
      printf OUTPUT "%-4d ", $linno;
      $len++;
    }
    # Output characters using the COS 6-bit
    # convention.
    while ($len++) {
      $b3 = shift @buf;
      if ($f =~ /[.]as$/) {
        $b1 = $b3 >> 6;
        $b2 = $b3 & 077;
        $b1 = $cosch[$b1];
        $b2 = $cosch[$b2];
        print OUTPUT $b1, $b2;
      } else {
        printf OUTPUT "%04o ", $b3;
      }
    }
    print OUTPUT "\n";
  }
}
