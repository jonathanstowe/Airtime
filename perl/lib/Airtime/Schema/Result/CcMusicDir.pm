use utf8;
package Airtime::Schema::Result::CcMusicDir;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcMusicDir

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

=head1 TABLE: C<cc_music_dirs>

=cut

__PACKAGE__->table("cc_music_dirs");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cc_music_dirs_id_seq'

=head2 directory

  data_type: 'text'
  is_nullable: 1

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 exists

  data_type: 'boolean'
  default_value: true
  is_nullable: 1

=head2 watched

  data_type: 'boolean'
  default_value: true
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cc_music_dirs_id_seq",
  },
  "directory",
  { data_type => "text", is_nullable => 1 },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "exists",
  { data_type => "boolean", default_value => \"true", is_nullable => 1 },
  "watched",
  { data_type => "boolean", default_value => \"true", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<cc_music_dir_unique>

=over 4

=item * L</directory>

=back

=cut

__PACKAGE__->add_unique_constraint("cc_music_dir_unique", ["directory"]);

=head1 RELATIONS

=head2 cc_files

Type: has_many

Related object: L<Airtime::Schema::Result::CcFile>

=cut

__PACKAGE__->has_many(
  "cc_files",
  "Airtime::Schema::Result::CcFile",
  { "foreign.directory" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 17:33:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:IIyBgod+QxRjKDd9JBe/Vg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
