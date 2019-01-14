#!/usr/bin/perl

#
# Perl version of decus-8-152a.
# Basically a recursive descent parser, less the 
# recursion.


open(INPUT, "code.txt") || die "code.txt: $!";

$word0 = 01000; # Base for compiled output

$word = $word0;
$note0 = 0;
$nloop = 0;
$cnt = 0; # Actually the "rest" flag

sub readOct {
  read(INPUT, $temp, 2) || die "EOF";
  return oct($temp);
}

while (1) { # START
  read(INPUT, $temp, 1) || die "EOF";
  if ($temp eq '*') {
    read(INPUT, $temp, 1) || die "EOF";
    $temp = unpack("C", $temp);
    $amp0 = ($temp << 9) & 03000;
  } elsif ($temp eq '$') {
    # Success!  Output a binary.
# BUGBUG: Currently can handle exactly one segment (number 0)
die unless $nloop == 1;
die unless defined$obr[0];
die unless defined$cbr[0];
    printf "*20\n%04o\n", $word0;
    printf "*22\n%04o\n", $note0;
    printf "*%04o\n", $word0;
$word = $word0 + $obr[0];
    for ($i = 0; $i < $note0; $i++) {
      printf "%04o\n", $core[$word+$i];
    }
    print "\$\n";
    last;
  } elsif ($temp eq '<') {
    $lco = &readOct;
    $obr[$lco] = $note0 + 1;
  } elsif ($temp eq '>') {
    $lcc = &readOct;
    $cbr[$lcc] = $note0 + 1;
    $nloop++;
  } elsif ($temp eq '^') {
    $damp0 = $damp;
  } elsif ($temp =~ /^[ABCDEFGR]$/) {
    @freq = (0, 06, 013, 021, 025, 030, 034);
    $temp = index("ABCDEFGR", $temp);
    if (defined($freq[$temp])) {
      $freq0 = $freq[$temp];
      while (1) { # FINF
        $note0++;
        $word++;
        read(INPUT, $temp, 1) || die "EOF";
        next unless $temp =~ /^[123]$/;
        $freq0 += 2 if $temp eq '2';
        $freq0 += 4 if $temp eq '3'; # BUGBUG: not 3!
        last;
      }
      while (1) { # FINF1
        read(INPUT, $temp, 1) || die "EOF";
        $freq0++ if $temp eq 'S';
        last if $temp eq '/';
      }
      # Fallthough to LEN
    } else {
      $ta = $amp0;
      $amp0 = $freq0 = 0;
      $cnt = -1; # Set flag to restore $amp0 later.
      $note0++;
      $word++;
    }
    while (1) { # LEN
      read(INPUT, $temp, 1) || die "EOF";
      $temp = index("EHQSW", $temp);
      next if $temp < 0;
      @len = (02, 07, 04, 0, 013);
      die "length" unless defined $len[$temp];
      $len0 = $len[$temp];
      last;
    }
    while (1) { # FINL
      read(INPUT, $temp, 1) || die "EOF";
      $len0++ if $temp eq '.';
      last if $temp eq '/';
    }
    # FINL1
    $core[$word] = ($len0<<5) + $amp0 + $freq0 + $damp0;
    $amp0 = $ta if $cnt;
    $cnt = $damp0 = 0;
  }
}
exit 0;
