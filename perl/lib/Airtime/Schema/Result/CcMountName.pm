use utf8;
package Airtime::Schema::Result::CcMountName;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcMountName

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

=head1 TABLE: C<cc_mount_name>

=cut

__PACKAGE__->table("cc_mount_name");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cc_mount_name_id_seq'

=head2 mount_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cc_mount_name_id_seq",
  },
  "mount_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 cc_listener_counts

Type: has_many

Related object: L<Airtime::Schema::Result::CcListenerCount>

=cut

__PACKAGE__->has_many(
  "cc_listener_counts",
  "Airtime::Schema::Result::CcListenerCount",
  { "foreign.mount_name_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 10:29:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bnLz4IzOHPDolBdHR7jTaw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
