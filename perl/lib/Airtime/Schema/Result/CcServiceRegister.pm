use utf8;
package Airtime::Schema::Result::CcServiceRegister;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcServiceRegister

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<cc_service_register>

=cut

__PACKAGE__->table("cc_service_register");

=head1 ACCESSORS

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 ip

  data_type: 'varchar'
  is_nullable: 0
  size: 18

=cut

__PACKAGE__->add_columns(
  "name",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "ip",
  { data_type => "varchar", is_nullable => 0, size => 18 },
);

=head1 PRIMARY KEY

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->set_primary_key("name");


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 10:29:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mU2IAqtlrmIW/1BoUNsHIA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
