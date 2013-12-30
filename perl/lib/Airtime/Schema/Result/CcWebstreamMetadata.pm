use utf8;
package Airtime::Schema::Result::CcWebstreamMetadata;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcWebstreamMetadata

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

=head1 TABLE: C<cc_webstream_metadata>

=cut

__PACKAGE__->table("cc_webstream_metadata");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cc_webstream_metadata_id_seq'

=head2 instance_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 start_time

  data_type: 'timestamp'
  is_nullable: 0

=head2 liquidsoap_data

  data_type: 'varchar'
  is_nullable: 0
  size: 1024

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cc_webstream_metadata_id_seq",
  },
  "instance_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "start_time",
  { data_type => "timestamp", is_nullable => 0 },
  "liquidsoap_data",
  { data_type => "varchar", is_nullable => 0, size => 1024 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 instance

Type: belongs_to

Related object: L<Airtime::Schema::Result::CcSchedule>

=cut

__PACKAGE__->belongs_to(
  "instance",
  "Airtime::Schema::Result::CcSchedule",
  { id => "instance_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 10:29:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ciaNzVmiOZjrsxo9z1PPDQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
