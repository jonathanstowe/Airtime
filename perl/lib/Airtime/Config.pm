package Airtime::Config;

use strict;
use warnings;

use Moose;

use Config::Tiny;

=head1 NAME

Airtime::Config - Encapsulate the configuration

=head1 DESCRIPTION

This provides methods for obtaining the Airtime configuration.

=head2 METHODS

=over 4

=item config_file

This is the default configuration file for airtime.

/usr/local/etc/airtime/airtime.conf

Typically it shouldn't need to be changed but can be set if your
installation is unusual.

=cut

has config_file   => (
                        is => 'rw',
                        isa   => 'Str',
                        default  => '/usr/local/etc/airtime/airtime.conf',
                     );

=item config_object

This returns the initialised Config::Tiny created from the C<config_file>

=cut

has config_object => (
                        is => 'ro',
                        isa   => 'Config::Tiny',
                        lazy  => 1,
                        builder  => '_get_config_object',
                     );

sub _get_config_object
{
   my ( $self ) = @_;

   my $conf = Config::Tiny->read($self->config_file());
   return $conf;
}

=item database

This returns the database section of the config.

=cut

has database   => (
                     is => 'ro',
                     isa   => 'HashRef',
                     lazy  => 1,
                     builder  => '_get_database',
                  );

sub _get_database
{
   my ( $self ) = @_;

   return $self->config_object()->{database};
}


=for reference

[database]
host = localhost
dbname = airtime
dbuser = airtime
dbpass = airtime


=cut

=item dbhost

Returns the host from the database (host key)

=cut

has dbhost  => (
                  is => 'ro',
                  isa   => 'Str',
                  lazy  => 1,
                  builder  => '_get_db_host',
               );

sub _get_db_host
{
   my ( $self ) = @_;

   return $self->database()->{host};
}

=item dbname

returns the database name.

=cut

has dbname  => (
                  is => 'ro',
                  isa   => 'Str',
                  lazy  => 1,
                  builder  => '_get_db_name',
               );

sub _get_db_name
{
   my ( $self ) = @_;

   return $self->database()->{dbname};
}

=item dbuser

returns the db user.

=cut

has dbuser  => (
                  is => 'ro',
                  isa   => 'Str',
                  lazy  => 1,
                  builder  => '_get_db_user',
               );

sub _get_db_user
{
   my ( $self ) = @_;

   return $self->database()->{dbuser};
}

=item dbpass

returns the db passsword

=cut

has dbpass  => (
                  is => 'ro',
                  isa   => 'Str',
                  lazy  => 1,
                  builder  => '_get_db_pass',
               );

sub _get_db_pass
{
   my ( $self ) = @_;

   return $self->database()->{dbpass};
}

=item db_dsn

This returns the DSN suitable to connect to the database as defined in the
configuration.

=cut

has db_dsn  => (
                  is => 'ro',
                  isa   => 'Str',
                  lazy  => 1,
                  builder  => '_get_dsn',
               );

sub _get_dsn
{
   my ( $self ) = @_;

   my $dsn = sprintf 'dbi:Pg:dbname=%s', $self->dbname();
   
   if ( $self->dbhost() ne 'localhost' )
   {
      $dsn .= sprintf ':host=s', $self->dbhost();
   }

   return $dsn;
}

=back


=cut

1;

