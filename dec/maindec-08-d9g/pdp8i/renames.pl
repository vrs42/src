#!/usr/bin/perl

foreach $f (<*>) {
  next unless -f $f;
  next if $f eq 'bintrim';
  next if $f eq 'contents';
  next if $f eq 'readme';
  next if $f eq 'renames.pl';
  next if $f =~ /[.]od$/;
  next if $f =~ /[.]xxx$/;
  next if $f eq 'vv';
  if ($f =~ /^(..)(....)(..).bin$/) {
    $n = "maindec-$1-$2-$3";
  } elsif ($f =~ /^(..)(....)(..).xxx$/) {
    $n = "maindec-$1-$2-$3";
  } elsif ($f =~ /^(..)(....)(..).pa$/) {
    $n = "maindec-$1-$2-pa";
  } elsif ($f =~ /^(..)-(.)-(...).bin$/) {
    $n = "maindec-08-$1-$2-pb";
  } elsif ($f =~ /^(..)-(.)-asc.*$/) {
    $n = "maindec-08-$1-$2-pa";
  } elsif ($f =~ /^(..)-(.)-(...).pa$/) {
    $n = "maindec-08-$1-$2-pa";
  } else {
    $n = $d;
  }
#080136pb.bin
#08cdd1pa.asc
#828.bin
#85-u-bin.bin
#sysbldxx.bin
  $d = $n; $d =~ s/.-p[ab]$//;
  print "bincmp $f ~/pdp8/src/dec/$d/$n\n";
}
