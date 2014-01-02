#!/usr/bin/perl

use FindBin qw($Bin);

use lib "$Bin/../lib";

use Airtime;

my $air = Airtime->new();

my $shows = $air->resultset('CcShow');

foreach my $show ( $shows->all() )
{
   print $show->name(), "\n";
}
