DECUS-5-12a loads an old obscure format of "packed" binary data.

The format consists of blocks, which are loaded until one fails to
have the correct checksum.

The blocks each have a preamble, which encodes the 12 bit loading
address, then the length in words, then the checksum.  Each of these
is encoded in the style of the BIN loader, with two data bytes per word.

Once the address, length, and checksum are known, loading of the
region described by address and length commences. These words are
encoded into three byte frames:
	ab cde fgh
	mno pi jkl
        qr stu vwx
to form two word pairs:
	abc def ghi jkl
        mno pqr stu vwx
The third byte of the last frame for an odd-length block is not
needed and not read/punched.

As each word is stored, it is also added to the checksum.  The 
checksum is accumulated as the sum of all the high and low six
bit bytes from each word loaded.

	Vince
