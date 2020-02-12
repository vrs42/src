#!/usr/bin/perl

#
# Convert .bin to .bn.
# In practice, this means to copy input to 
# output, then pad to a multiple of the 
# blocksize (384 bytes/256 words) with 0200.
#

open(INPUT, $ARGV[0]) || die "$ARGV[0]: $!";
binmode(INPUT);
binmode(STDOUT);
while (read(INPUT, $buf, 384)) {
    while (length($buf) < 384) {
        $buf .= chr(0200);
    }
    print $buf;
}
exit 0;
