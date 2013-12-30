use utf8;
package Airtime::Schema::Result::CcPlaylistcontent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcPlaylistcontent

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

=head1 TABLE: C<cc_playlistcontents>

=cut

__PACKAGE__->table("cc_playlistcontents");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cc_playlistcontents_id_seq'

=head2 playlist_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 file_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 block_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 stream_id

  data_type: 'integer'
  is_nullable: 1

=head2 type

  data_type: 'smallint'
  default_value: 0
  is_nullable: 0

=head2 position

  data_type: 'integer'
  is_nullable: 1

=head2 trackoffset

  data_type: 'double precision'
  default_value: 0
  is_nullable: 0

=head2 cliplength

  data_type: 'interval'
  default_value: '00:00:00'
  is_nullable: 1

=head2 cuein

  data_type: 'interval'
  default_value: '00:00:00'
  is_nullable: 1

=head2 cueout

  data_type: 'interval'
  default_value: '00:00:00'
  is_nullable: 1

=head2 fadein

  data_type: 'time'
  default_value: '00:00:00'
  is_nullable: 1

=head2 fadeout

  data_type: 'time'
  default_value: '00:00:00'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cc_playlistcontents_id_seq",
  },
  "playlist_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "file_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "block_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "stream_id",
  { data_type => "integer", is_nullable => 1 },
  "type",
  { data_type => "smallint", default_value => 0, is_nullable => 0 },
  "position",
  { data_type => "integer", is_nullable => 1 },
  "trackoffset",
  { data_type => "double precision", default_value => 0, is_nullable => 0 },
  "cliplength",
  { data_type => "interval", default_value => "00:00:00", is_nullable => 1 },
  "cuein",
  { data_type => "interval", default_value => "00:00:00", is_nullable => 1 },
  "cueout",
  { data_type => "interval", default_value => "00:00:00", is_nullable => 1 },
  "fadein",
  { data_type => "time", default_value => "00:00:00", is_nullable => 1 },
  "fadeout",
  { data_type => "time", default_value => "00:00:00", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 block

Type: belongs_to

Related object: L<Airtime::Schema::Result::CcBlock>

=cut

__PACKAGE__->belongs_to(
  "block",
  "Airtime::Schema::Result::CcBlock",
  { id => "block_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
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

=head2 playlist

Type: belongs_to

Related object: L<Airtime::Schema::Result::CcPlaylist>

=cut

__PACKAGE__->belongs_to(
  "playlist",
  "Airtime::Schema::Result::CcPlaylist",
  { id => "playlist_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 17:33:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:n6BJVHt6m+7PRBE2TEHvFA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
