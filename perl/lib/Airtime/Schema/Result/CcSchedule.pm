use utf8;
package Airtime::Schema::Result::CcSchedule;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcSchedule

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

=head1 TABLE: C<cc_schedule>

=cut

__PACKAGE__->table("cc_schedule");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cc_schedule_id_seq'

=head2 starts

  data_type: 'timestamp'
  is_nullable: 0

=head2 ends

  data_type: 'timestamp'
  is_nullable: 0

=head2 file_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 stream_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 clip_length

  data_type: 'interval'
  default_value: '00:00:00'
  is_nullable: 1

=head2 fade_in

  data_type: 'time'
  default_value: '00:00:00'
  is_nullable: 1

=head2 fade_out

  data_type: 'time'
  default_value: '00:00:00'
  is_nullable: 1

=head2 cue_in

  data_type: 'interval'
  is_nullable: 0

=head2 cue_out

  data_type: 'interval'
  is_nullable: 0

=head2 media_item_played

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=head2 instance_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 playout_status

  data_type: 'smallint'
  default_value: 1
  is_nullable: 0

=head2 broadcasted

  data_type: 'smallint'
  default_value: 0
  is_nullable: 0

=head2 position

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cc_schedule_id_seq",
  },
  "starts",
  { data_type => "timestamp", is_nullable => 0 },
  "ends",
  { data_type => "timestamp", is_nullable => 0 },
  "file_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "stream_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "clip_length",
  { data_type => "interval", default_value => "00:00:00", is_nullable => 1 },
  "fade_in",
  { data_type => "time", default_value => "00:00:00", is_nullable => 1 },
  "fade_out",
  { data_type => "time", default_value => "00:00:00", is_nullable => 1 },
  "cue_in",
  { data_type => "interval", is_nullable => 0 },
  "cue_out",
  { data_type => "interval", is_nullable => 0 },
  "media_item_played",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
  "instance_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "playout_status",
  { data_type => "smallint", default_value => 1, is_nullable => 0 },
  "broadcasted",
  { data_type => "smallint", default_value => 0, is_nullable => 0 },
  "position",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 cc_webstream_metadatas

Type: has_many

Related object: L<Airtime::Schema::Result::CcWebstreamMetadata>

=cut

__PACKAGE__->has_many(
  "cc_webstream_metadatas",
  "Airtime::Schema::Result::CcWebstreamMetadata",
  { "foreign.instance_id" => "self.id" },
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
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 stream

Type: belongs_to

Related object: L<Airtime::Schema::Result::CcWebstream>

=cut

__PACKAGE__->belongs_to(
  "stream",
  "Airtime::Schema::Result::CcWebstream",
  { id => "stream_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 10:29:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AcG8PetqOJodTfdA7EexQA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
