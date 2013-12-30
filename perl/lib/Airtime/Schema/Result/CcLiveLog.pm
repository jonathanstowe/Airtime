use utf8;
package Airtime::Schema::Result::CcLiveLog;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcLiveLog

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

=head1 TABLE: C<cc_live_log>

=cut

__PACKAGE__->table("cc_live_log");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cc_live_log_id_seq'

=head2 state

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 start_time

  data_type: 'timestamp'
  is_nullable: 0

=head2 end_time

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cc_live_log_id_seq",
  },
  "state",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "start_time",
  { data_type => "timestamp", is_nullable => 0 },
  "end_time",
  { data_type => "timestamp", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 10:29:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8sv6274786ZJz+O6z0NO8Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
