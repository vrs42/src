#!/usr/bin/perl

#
# The original date algorithm was 3 bits, added to 1970.
# Later, two more bits were added, so years go thru 1999.
# Dates in the future are interpreted as dates in the
# previous 8 years.
# First, get the right epoch.
($_, $_, $_, $dy, $mo, $i) = localtime(time);
$i = ($i + 1900) & 037;
$cyear = $i & 07;
$epoch = 70 + ($i&030);
$i += 70;
@month = ("0",  "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL",
	 "AUG", "SEP", "OCT", "NOV", "DEC", "13",  "14",  "15");
print " $dy-$month[$mo+1]-$i\n\n";

open(INPUT, $ARGV[0]) || die "$ARGV[0]: $!";
binmode(INPUT);

#
# Directory starts in block 1.
$link = 1;
#
# Read in the next directory segment (block).
while ($link) {
    seek(INPUT, $link*01000, 0) || die "directory seek: $!";
    read(INPUT, $dir, 01000) || die "directory read: $!";
    @dir = unpack("S512", $dir);
    #
    # @dir starts with a directory segment header.
    $count = shift @dir;
    $start = shift @dir;
    $link = shift @dir;
    $flag = shift @dir;
    $aiw = shift @dir;
    $aiw = $aiw - 010000 unless $aiw == 0;
    $date = "";
    for ($count -= 010000; $count < 0; $count++) {
	$n1 = shift @dir;
	$n2 = shift @dir;
	if ($n1) {
	    $n3 = shift @dir;
	    $e1 = shift @dir;
	    if ($aiw) {
		$a = shift @dir;
		# Blow that off and use year as 3 bits, from 1970.
		$yr = $a & 07;
		$yr -= 8 if $yr > $cyear;
		$yr += $epoch;
		# Day is 5 bits.
		$dy = ($a>>3) & 037;
		# Month is 4 bits.
		$mo = ($a>>8) & 017;
		$date = "$dy-$month[$mo]-$yr";
		for ($i = $aiw+1; $i < 0; $i++) {
		   $a = shift @dir;
		}
	    }
	    $length = shift @dir;
	    $length = 010000 - $length;
	    @name = ($n1>>6, $n1&077, $n2>>6, $n2&077, $n3>>6, $n3&077);
	    @ext = ($e1>>6, $e1&077);
	    grep($_ = ($_ > 040? $_ : $_ + 0100), @name, @ext);
	    $name = pack("CCCCCC", @name);
	    $ext = pack("CC", @ext);
	    $name .= "." . $ext;
	    $name =~ s/@//g;
	} else {
	    $length = 010000 - $n2;
	    $name = "<empty>";
	    $date = "";
	}
	printf "%-9s\t%04o\t%d\t%s\n", $name, $start, $length, $date;
	$start += $length;
    }
}
