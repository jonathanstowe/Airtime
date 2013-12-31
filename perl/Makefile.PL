use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
   NAME               => 'Airtime',
   AUTHOR             => q{Jonathan Stowe <jns@gellyfish.co.uk>},
   VERSION_FROM       => 'lib/Airtime.pm',
   ABSTRACT_FROM      => 'lib/Airtime.pm',
   LICENSE            => 'Artistic_2_0',
   PL_FILES           => {},
   MIN_PERL_VERSION   => 5.006,
   CONFIGURE_REQUIRES => {
      'ExtUtils::MakeMaker' => 0,
   },
   BUILD_REQUIRES => {
      'Test::More' => 0,
   },
   PREREQ_PM => {
      Moose                 => 0,
      DateTime              => 0,
      DBIx::Class           => 0,
      DBD::Pg               => 0,
      Config::Tiny          => 0,
      MooseX::MarkAsMethods => 0,
      MooseX::NonMoose      => 0,
      Net::Google::Calendar   => 0,
   },
   dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
   clean => { FILES    => 'Airtime-*' },
);
