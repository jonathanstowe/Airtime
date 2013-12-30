use utf8;
package Airtime::Schema::Result::CcLoginAttempt;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcLoginAttempt

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

=head1 TABLE: C<cc_login_attempts>

=cut

__PACKAGE__->table("cc_login_attempts");

=head1 ACCESSORS

=head2 ip

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 attempts

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "ip",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "attempts",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</ip>

=back

=cut

__PACKAGE__->set_primary_key("ip");


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 10:29:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pURKBTaOKT/zJ3p0v+qeww


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
