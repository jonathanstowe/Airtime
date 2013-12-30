use utf8;
package Airtime::Schema::Result::CcSmemb;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcSmemb

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

=head1 TABLE: C<cc_smemb>

=cut

__PACKAGE__->table("cc_smemb");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 uid

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 gid

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 level

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 mid

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "uid",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "gid",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "level",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "mid",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 10:29:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GDNu2e/2HPn/2KXDIEAUlA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
