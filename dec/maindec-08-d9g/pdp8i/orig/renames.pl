#!/usr/bin/perl

foreach $f (<*>) {
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
080136pb.bin
08cdd1pa.asc
828.bin
85-u-bin.bin
sysbldxx.bin
