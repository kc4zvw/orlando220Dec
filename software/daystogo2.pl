#!/usr/bin/env perl
#
# Author: David Billsbrough <billsbrough@gmail.com>
#
#  $Id: daystogo.pl,v 0.4 2004/05/18 11:06:30 root Exp root $
#

use strict;
use warnings;

use Date::Calc qw(Today_and_Now Add_Delta_YMDHMS Delta_DHMS Date_to_Text);

my $Aline;
my $file = ".calendar";
my $GMT = 0;							# System clock is local time.
my @Today = Date::Calc::Today([$GMT]);
my $OldDir = `pwd`;

sub process_line
{
	my @DateArray;
	my $DayCount;
	my $EventDate;
	my $EventName;

	($EventDate, $EventName) = split("~", $Aline);
	@DateArray = split("/", $EventDate);

	$DayCount = Date::Calc::Delta_Days(@Today, @DateArray);

	if ($DayCount <= -2) {
		print "It was " . abs($DayCount) . " days ago since $EventName.\n";
	} elsif ($DayCount == -1) {
		print "Yesterday was $EventName.\n";
	} elsif ($DayCount == 0) {
		print "Today is $EventName.\n";
	} elsif ($DayCount == 1) {
		print "Tomorrow is $EventName.\n";
	} else {
		print "There are $DayCount days until $EventName.\n";
	}
}


###==================================###
##      Main program begins here      ##
###==================================###

chdir;

print "\n";
print "Today is " . Date::Calc::Date_to_Text_Long(@Today) . ".\n";
print "\n";

open FH, "< $file" or die "Can't open '$file': $!\n";

while (not eof(FH)) {
	$Aline = <FH>;
	chomp $Aline;
	&process_line;
}

close FH;

chdir "$OldDir";

print "\n";
print "End of report.\n";

# End of script
