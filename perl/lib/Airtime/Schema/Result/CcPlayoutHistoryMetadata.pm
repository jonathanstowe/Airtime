use utf8;
package Airtime::Schema::Result::CcPlayoutHistoryMetadata;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcPlayoutHistoryMetadata

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<cc_playout_history_metadata>

=cut

__PACKAGE__->table("cc_playout_history_metadata");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cc_playout_history_metadata_id_seq'

=head2 history_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 key

  data_type: 'varchar'
  is_nullable: 0
  size: 128

=head2 value

  data_type: 'varchar'
  is_nullable: 0
  size: 128

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cc_playout_history_metadata_id_seq",
  },
  "history_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "key",
  { data_type => "varchar", is_nullable => 0, size => 128 },
  "value",
  { data_type => "varchar", is_nullable => 0, size => 128 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 history

Type: belongs_to

Related object: L<Airtime::Schema::Result::CcPlayoutHistory>

=cut

__PACKAGE__->belongs_to(
  "history",
  "Airtime::Schema::Result::CcPlayoutHistory",
  { id => "history_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 17:33:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:W8hgbGT0wGIws/kKA4VJ7Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
