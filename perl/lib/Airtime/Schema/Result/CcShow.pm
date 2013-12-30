use utf8;
package Airtime::Schema::Result::CcShow;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcShow

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

=head1 TABLE: C<cc_show>

=cut

__PACKAGE__->table("cc_show");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cc_show_id_seq'

=head2 name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 url

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 255

=head2 genre

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 255

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 512

=head2 color

  data_type: 'varchar'
  is_nullable: 1
  size: 6

=head2 background_color

  data_type: 'varchar'
  is_nullable: 1
  size: 6

=head2 live_stream_using_airtime_auth

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=head2 live_stream_using_custom_auth

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=head2 live_stream_user

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 live_stream_pass

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 linked

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 is_linkable

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cc_show_id_seq",
  },
  "name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "url",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 255 },
  "genre",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 255 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 512 },
  "color",
  { data_type => "varchar", is_nullable => 1, size => 6 },
  "background_color",
  { data_type => "varchar", is_nullable => 1, size => 6 },
  "live_stream_using_airtime_auth",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
  "live_stream_using_custom_auth",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
  "live_stream_user",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "live_stream_pass",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "linked",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "is_linkable",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 cc_show_days

Type: has_many

Related object: L<Airtime::Schema::Result::CcShowDay>

=cut

__PACKAGE__->has_many(
  "cc_show_days",
  "Airtime::Schema::Result::CcShowDay",
  { "foreign.show_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cc_show_hosts

Type: has_many

Related object: L<Airtime::Schema::Result::CcShowHost>

=cut

__PACKAGE__->has_many(
  "cc_show_hosts",
  "Airtime::Schema::Result::CcShowHost",
  { "foreign.show_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cc_show_instances

Type: has_many

Related object: L<Airtime::Schema::Result::CcShowInstance>

=cut

__PACKAGE__->has_many(
  "cc_show_instances",
  "Airtime::Schema::Result::CcShowInstance",
  { "foreign.show_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cc_show_rebroadcasts

Type: has_many

Related object: L<Airtime::Schema::Result::CcShowRebroadcast>

=cut

__PACKAGE__->has_many(
  "cc_show_rebroadcasts",
  "Airtime::Schema::Result::CcShowRebroadcast",
  { "foreign.show_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 10:29:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9Hz2ZIQLGrlYy6P7LqzXMg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
