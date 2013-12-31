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

   my $conf = Config::Tiny->new();
   $conf->read($self->config_file());
   return $conf;
}

=back


=cut

1;

