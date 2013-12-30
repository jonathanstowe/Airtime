use utf8;
package Airtime::Schema::Result::CcPlayoutHistory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcPlayoutHistory

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

=head1 TABLE: C<cc_playout_history>

=cut

__PACKAGE__->table("cc_playout_history");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cc_playout_history_id_seq'

=head2 file_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 starts

  data_type: 'timestamp'
  is_nullable: 0

=head2 ends

  data_type: 'timestamp'
  is_nullable: 1

=head2 instance_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cc_playout_history_id_seq",
  },
  "file_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "starts",
  { data_type => "timestamp", is_nullable => 0 },
  "ends",
  { data_type => "timestamp", is_nullable => 1 },
  "instance_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 cc_playout_history_metadatas

Type: has_many

Related object: L<Airtime::Schema::Result::CcPlayoutHistoryMetadata>

=cut

__PACKAGE__->has_many(
  "cc_playout_history_metadatas",
  "Airtime::Schema::Result::CcPlayoutHistoryMetadata",
  { "foreign.history_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 file

Type: belongs_to

Related object: L<Airtime::Schema::Result::CcFile>

=cut

__PACKAGE__->belongs_to(
  "file",
  "Airtime::Schema::Result::CcFile",
  { id => "file_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 instance

Type: belongs_to

Related object: L<Airtime::Schema::Result::CcShowInstance>

=cut

__PACKAGE__->belongs_to(
  "instance",
  "Airtime::Schema::Result::CcShowInstance",
  { id => "instance_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 17:33:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uEMqFwaXpZQkp4GR7fPCkQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
