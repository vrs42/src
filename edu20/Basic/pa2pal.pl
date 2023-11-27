#! /usr/bin/perl
@rem = '
@echo off
c:\perl5\bin\perl %0 %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
@rem ' if @rem;

open(STDOUT, ">foo.pal") || die "foo.pal: $!";
binmode(STDOUT);
#
# Open the input file in binary mode and read it in.
open(INPUT, $ARGV[0]) || die "$ARGV[0]: $!";
binmode(INPUT);
@core = (); $loc = $store = undef;
while (read(INPUT, $top, 4)) {
  # Read 2 twelve bit words
  ($d1, $d2) = unpack("SS", $top);
  warn "word1: $d1" if $d1 > 07777;
  warn "word2: $d2" if $d2 > 07777;
  # Assemble 8-bit bytes
  $d3 = (($d1 & 07400) >> 4) + (($d2 & 07400) >>8);
  $d1 &= 0177;
  $d2 &= 0177;
  $d3 &= 0177;
  # Output them unless EOF
  last if ($d1 & 0177) == 032;
  $top = pack("C", $d1);
  printf "%s", $top;
  last if ($d2 & 0177) == 032;
  $top = pack("C", $d2);
  printf "%s", $top;
  last if ($d3 & 0177) == 032;
  $top = pack("C", $d3);
  printf "%s", $top;
}
close(INPUT);

__END__
:endofperl
