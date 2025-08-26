
#
# Make an OS8 volume that contains the specified files.
# The result is in the .dsk format used by SIMH and PUTR.
# BUGBUG: Names without extensions don't match the OS8 pattern.
# BUGBUG: $DRIVES not used yet.
# BUGBUG: Treatment of $HEADS > 1 in confused wrt SIMH.

#
# This info from the SIMH handler for RK8E.
$DRIVETYPE = "rk";	# Documenttion (and output filename)
$DRIVES = 4;		# Number of drives supported
$CYLS = 203;		# Number of cylinders
$HEADS = 2;		# Number of surfaces
$HEADS = 1;		# BUGBUG: kluge for correct result for "rk"
$SECTORS = 16;		# Sectors per track
$WORDSPS = 256;		# 12-bit words per track
$WORDSPD = $CYLS * $HEADS * $SECTORS * $WORDSPS;

#
# Size an OS8 volume based on $WORDSPS and $WORDSPD above.
# The result is in the .dsk format used by SIMH.
$BLOCKWORDS = 256;	# 256 12-bit words (blocksize in OS/8)
$BLOCKBYTES  = $BLOCKWORDS*2;	# Stored as 16 bits (2 bytes)
$OS8BLOCKS = $WORDSPD / $BLOCKWORDS;
die "Can't use sector size of $WORDSPS" if $BLOCKWORDS % $WORDSPS;

die "$OS8BLOCKS" unless $OS8BLOCKS == 3248;	# Debugging

$DIRBLOCKS = 6;		# Blocks 1-6 are directory segments
$FILESTART = 7;		# 70 for system device, 7 otherwise.
$DATABLOCKS = $OS8BLOCKS - $FILESTART;

#
# Get the list of files
%sizes = ();		# Converted to OS8 blocks
%dates = ();		# *nix style last modify times
$total = 0;
$dirents = 0;
@files = <@ARGV>;	# Do globbing so wildcards work.
foreach $f (@files) {
    # Filter file names for OS/8.
    if (($f !~ /^\w{0,6}\.\w{0,2}$/) && ($f !~ /^\w{0,6}$/)) {
	warn "$f: Bad OS/8 name (skipped)\n";
	next;
    }
    $f =~ y/a-z/A-Z/;
    # Name OK, include it if we can stat it.
    if (@stat = stat($f)) {
	$size = $stat[7];
	$size = int($size*2 + 2) / 3;	# 3 bytes per 2 words.
	$size = int(($size + $BLOCKWORDS - 1) / $BLOCKWORDS);
	$sizes{$f} = $size;		# OS8 blocks
	$dates{$f} = $stat[9];
	$dirents++;
	$total += $size;
    } else {
	warn "$f: $! (skipped)\n";
    }
}
$dirents++;		# For the empty file (free space) at the end.
die "Too much data ($total blocks > $DATABLOCKS blocks)\n"
    if $total > $DATABLOCKS;

$DIRSEGSZ = 5;		# Size of directory segment header
$AIW = 1;		# Just the date word
$DIRENTSZ = 5 + $AIW;	# Size of a (non-empty) directory entry
$EMPTYSZ = 2;		# Size of an empty file (free space) entry
$FILESPERSEG = int(($BLOCKWORDS - DIRSEGSZ) / $DIRENTSZ);
$FILESALLOWED = $FILESPERSEG * $DIRBLOCKS;
die "Too many files ($dirents > $$FILESALLOWED)\n" if $dirents > $FILESALLOWED;

#
# Zero RAM copy of non-file blocks.
for ($i = 0; $i < $BLOCKWORDS*$FILESTART; $i++) {
    $head[$i] = 0;
}

#
# Open the new file and copy out the data.
# Create directory entries in RAM while we are at it.
$ofile = "$DRIVETYPE.dsk";
open(OUTPUT, ">$ofile") || die "$ofile: $!";
binmode(OUTPUT);
$blockno = $FILESTART;
seek(OUTPUT, $blockno*$BLOCKBYTES, 0) || die "seek: $!";
$dirptr = $BLOCKWORDS-1; # Directory starts after one block.
$dirdone = 0;		# No directory entries done yet.
foreach $f (sort keys %sizes) {
    #
    # Start new directory segment if needed.
    if (int(($dirptr+$DIRENTSZ)/$BLOCKWORDS) > int($dirptr/$BLOCKWORDS)) {
	#
	# Begin a new directory segment.
	$dirptr = (int($dirptr/$BLOCKWORDS)+1)*$BLOCKWORDS;
	$i = $dirents - $dirdone;
        if ($i > $FILESPERSEG) {
	    # Not the last directory segment.
	    $i = $FILESPERSEG;
	    $head[$dirptr+2] = int($dirptr/$BLOCKWORDS) + 1;
	}
	$head[$dirptr++] = 010000 - $i;
	$head[$dirptr++] = $blockno;
	$dirptr++;
	$dirptr++;
	$head[$dirptr++] = 010000 - 1; # Just one AIW
    }
    #
    # Create directory entry in RAM.
    printf "$f\n";
    (($name, $ext) = $f =~ /^([^.]*)[.]([^.]*)$/)
	|| ($ext = "", ($name) = $f =~ /^([^.]*)$/);
    @name = unpack("C6", $name);
    grep($_ &= 077, @name);
    $head[$dirptr++] = ($name[0] << 6) + $name[1];
    $head[$dirptr++] = ($name[2] << 6) + $name[3];
    $head[$dirptr++] = ($name[4] << 6) + $name[5];
    @ext = unpack("C2", $ext);
    grep($_ &= 077, @ext);
    $head[$dirptr++] = ($ext[0] << 6) + $ext[1];
    ($_, $_, $_, $dy, $mo, $yr) = localtime($dates{$f});
    $yr = ($yr - 70) & 07;
    $mo++;
    $head[$dirptr++] = ($mo<<8) + ($dy<<3) + $yr;
    $head[$dirptr++] = 010000 - $sizes{$f};
    $dirdone++;
    #
    # Open and copy out the file.
    open(INPUT, $f) || die "$f: $!";
    binmode(INPUT);
    for ($i = 0; $i < $sizes{$f}; $i++) {
	read(INPUT, $buf, $BLOCKWORDS*3/2) || die "$f: $!";
	@buf = unpack("C*", $buf);
	$buf = "";
        for ($j = 0; $j < $BLOCKWORDS*3/2; $j += 3) {
	    $c1 = shift @buf;
	    $c2 = shift @buf;
	    $c3 = shift @buf;
	    $c1 += ($c3 >>  4) << 8;
	    $c2 += ($c3 & 017) << 8;
	    $buf = pack("S2", $c1, $c2);
	    syswrite(OUTPUT, $buf, 2*2) || die "$ofile: $!";
	}
	$blockno++;
    }
    close(INPUT) || die "$f: $!";
}

#
# Add the empty file.  Empty files represent the free blocks in the
# file-system.
if (int(($dirptr+$DIRENTSZ)/$BLOCKWORDS) > int($dirptr/$BLOCKWORDS)) {
    #
    # Begin a new directory segment.
    $dirptr = (int($dirptr/$BLOCKWORDS)+1)*$BLOCKWORDS;
    $i = $dirents - $dirdone;
    if ($i > $FILESPERSEG) {
	# Not the last directory segment.
	$i = $FILESPERSEG;
	$head[$dirptr+2] = int($dirptr/$BLOCKWORDS) + 1;
    }
    $head[$dirptr++] = 010000 - $i;
    $head[$dirptr++] = $blockno;
    $dirptr++;
    $dirptr++;
    $head[$dirptr++] = 010000 - 1; # Just one AIW
}
$head[$dirptr++] = 0;	# Null file name
$head[$dirptr] = 010000 - ($DATABLOCKS - ($blockno-$FILESTART));

#
# Write out the directory blocks we have been building.
$buf = pack("S*", @head);
seek(OUTPUT, 0, 0);
syswrite(OUTPUT, $buf, $FILESTART*$BLOCKBYTES) || die "$ofile: $!";

