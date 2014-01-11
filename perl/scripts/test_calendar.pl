#!/usr/bin/perl

use strict;
use warnings;

use FindBin qw($Bin);

use lib "$Bin/../lib";

my $DO_DB = 1;

use Airtime;

use Net::Google::Calendar;
use Data::ICal::DateTime;
use Data::ICal;
use Data::Dumper;

use DateTime::Format::Duration;
use DateTime::Span;

use LWP::Simple;

#my $uri = 'http://www.google.com/calendar/feeds/sv9sb2112vgrbe5kt6gvfsrvk8%40group.calendar.google.com/private-3a4e198b5319c59fba46b4293fd32575/basic';
my $uri =
'http://www.google.com/calendar/ical/sv9sb2112vgrbe5kt6gvfsrvk8%40group.calendar.google.com/private-3a4e198b5319c59fba46b4293fd32575/basic.ics';

my $cal_data = get($uri);

my $f = DateTime::Format::Duration->new( normalise => 1, pattern => '%r' );
my $cal = Data::ICal->new( data => $cal_data );


my $date1 = DateTime->new( year => 2013, month => 1, day => 1 );
my $date2 = DateTime->new( year => 2015, month => 12, day => 31 );


my $span = DateTime::Span->from_datetimes( start => $date1, end => $date2 );

my $airtime = Airtime->new();

my $show_rs = $airtime->resultset('CcShow');

my $tz = 'Europe/London';

my %show_days;

foreach my $ev ( $cal->events($span) )
{
   if ( $ev->ical_entry_type() eq 'VEVENT' )
   {
      my $show_name = $ev->summary();

      if (!$show_name )
      {
         $show_name = $ev->description();
      }
      if ( $show_name && (lc($show_name) ne 'tbc'))
      {
         $show_name =~ s%shows/%%;
         print "Name: $show_name\n";
         print $ev->start(), " - ", $ev->end(), "\n";
         my $duration = $f->format_duration( $ev->end() - $ev->start() );
         print "Duration : $duration\n";
         my $dow = $ev->start()->day_of_week();
         $dow = 0 if $dow == 7;
         print "DOW : $dow\n";

         my $show;

         if (my $rrule = $ev->property('rrule') )
         {
            if ( $rrule = $rrule->[0] )
            {
               print "REC: ",$rrule->value(),"\n";
            }
         }

         my $rep = -1;
         if ( $ev->original() )
         {
            print "Original " . $ev->original()->start(), "\n";
            if ( my $rrule = $ev->original()->property('rrule') )
            {
               if ( $rrule = $rrule->[0] )
               {
                  $rep = rec_to_repeat($rrule->value());
                  print "REC: ", $rep, "\n";
               }
            }
         }
         if ( $ev->period() )
         {
            print "Last : ", $ev->period()->end(), "\n";
         }
         if ( $DO_DB )
         {
            $show = $show_rs->update_or_create({name => $show_name});

            if ( !exists $show_days{ $show->id() } )
            {
               $show_days{$show->id()} = $show->update_or_create_related(
                  cc_show_days => {
                     first_show  => $ev->start(),
                     start_time  => $ev->start()->hms(':'),
                     timezone    => $tz,
                     duration    => $duration,
                     day         => $dow,
                     repeat_type => $rep,
                  }
               );
            }
            else
            {
               my $sd = $show_days{$show->id()};
               $sd->next_pop_date($ev->start());
               $sd->repeat_type($rep);
               $sd->insert_or_update();
            }
         
            $show->update_or_create_related(cc_show_instances => {
               starts   => $ev->start(),
               ends     => $ev->end(),
               created  => DateTime->now(),
            });
         }
         if ( $ev->recurrence() )
         {
            print "Recurrence ", $ev->recurrence(),"\n";
            foreach my $rev ( $ev->explode($ev->recurrence()) )
            {
               print "\t",$rev->start(), " - ", $rev->end(), "\n";
               if ( $DO_DB )
               {
                  $show->update_or_create_related(cc_show_instances => {
                     starts   => $rev->start(),
                     ends     => $rev->end(),
                     created  => DateTime->now(),
                  });
               }
            }
         }
      }
      else
      {
         print "skipped\n";
      }
   }
}

sub rec_to_repeat
{
   my ( $rec ) = @_;

   my $rep = -1;

   if ( $rec )
   {
      my %foo = map { split '=', $_ } 
                split ';', $rec;

      if ( exists $foo{FREQ} && $foo{FREQ} eq 'WEEKLY' )
      {
         $rep = 0;

         if ( exists $foo{INTERVAL} )
         {
            if ( $foo{INTERVAL} == 2 )
            {
               $rep = 1;
            }
            elsif ( $foo{INTERVAL} == 4 )
            {
               $rep = 3;
            }

         }
      }
   }

   return $rep;
}
