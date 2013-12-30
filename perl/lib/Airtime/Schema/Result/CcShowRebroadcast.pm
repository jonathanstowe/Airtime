use utf8;
package Airtime::Schema::Result::CcShowRebroadcast;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcShowRebroadcast

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

=head1 TABLE: C<cc_show_rebroadcast>

=cut

__PACKAGE__->table("cc_show_rebroadcast");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cc_show_rebroadcast_id_seq'

=head2 day_offset

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 start_time

  data_type: 'time'
  is_nullable: 0

=head2 show_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cc_show_rebroadcast_id_seq",
  },
  "day_offset",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "start_time",
  { data_type => "time", is_nullable => 0 },
  "show_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 show

Type: belongs_to

Related object: L<Airtime::Schema::Result::CcShow>

=cut

__PACKAGE__->belongs_to(
  "show",
  "Airtime::Schema::Result::CcShow",
  { id => "show_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 10:29:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9fouut4vJratrLq5wSk2nQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
