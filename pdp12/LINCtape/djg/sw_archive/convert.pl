#!/usr/bin/perl -w -T

#use CGI;
use CGI::Carp "fatalsToBrowser";
use CGI ":all";
use CGI qw/escape unescape/;
use strict;
use Sys::Hostname;

my $q=new CGI;
$q->default_dtd('-//W3C//DTD HTML 4.01 Transitional//EN');
my $debug=$q->param('debug');
if(!defined $debug) {$debug=0}
my $loc=$q->param('loc');
my $to=$q->param('to');
if(!defined $to) {$to=129}
my $error;
my $buf;
	
my $hostname = $ENV{"SERVER_NAME"};
if(defined $loc) {
   $error = "";
   if ($loc =~ /\.\./) {
      $error = "Illegal path $loc";
   } else {
      open IN,"</mnt/pdp/ftproot/$loc" or $error = "Unable to open $loc";
   }

   my $size = (stat ("/mnt/pdp/ftproot/$loc"))[7];
   my ($first, $first_rev, $blksize, $nblocks);
   my $insize = 129;
   $nblocks = $size / (129*2);
   my $header_size = 6;
   if ((($size - $header_size) % 128) == 0) {
      $insize = 128;
   }
   if ($size % 129 != 0) {
      seek IN, -$header_size, 2 or $error = "Seek failed";
      read IN, $buf, $header_size;
      ($blksize, $first, $first_rev) = unpack "sss", $buf;
      seek IN, $blksize * -$first * 2, 0 or $error = "Seek 2 failed";
      $nblocks = ($size - $header_size) / ($insize * 2) - (-$first * 2) - 1;
   }
   if ($error eq "") {
      print $q->header(-type=>"application/octet-stream");
#      print $q->header(-type=>'text/html; charset="iso-8859-1"'),$q->start_html(-title=>'PDP-8 Convert error', "");
#print "to $to insize $insize nblocks $nblocks";
      while ($nblocks-- > 0 && read(IN, $buf, $insize*2)) {
         if ($to == 128) {
            if ($insize == 129) {
               substr($buf, -2) = "";
            }
         } else {
            if ($insize == 128) {
               $buf = $buf . chr(0) . chr(0);
            }
         }
         print $buf;
      }
   } else {
      print $q->header(-type=>'text/html; charset="iso-8859-1"'),$q->start_html(-title=>'PDP-8 Convert error', "");

      print "<P> $error";
      print '<P> <HR WIDTH="100%">';
      print '<p>Feel free to contact me, David Gesswein <A HREF="mailto:djg@pdp8online.com">djg@pdp8online.com</A> with any questions, comments on the web site, or you want to donate equipment, documentation, software etc. to this project.&nbsp; I am interested in anything PDP-8 related, computers, peripherals used with them, DEC or third party, or documentation.&nbsp; <BR><BR><A HREF="http://www.pdp8online.com/query_docs/query.shtml">PDP-8 Documents home</a><BR><A HREF="../../index.shtml">PDP-8 Home Page</a> <BR><A HREF="../../sitemap.shtml">PDP-8 Site Map</a>';
      print "\n";
   }
}


