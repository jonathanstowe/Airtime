use utf8;
package Airtime::Schema::Result::CcPerm;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcPerm

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

=head1 TABLE: C<cc_perms>

=cut

__PACKAGE__->table("cc_perms");

=head1 ACCESSORS

=head2 permid

  data_type: 'integer'
  is_nullable: 0

=head2 subj

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 action

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 obj

  data_type: 'integer'
  is_nullable: 1

=head2 type

  data_type: 'char'
  is_nullable: 1
  size: 1

=cut

__PACKAGE__->add_columns(
  "permid",
  { data_type => "integer", is_nullable => 0 },
  "subj",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "action",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "obj",
  { data_type => "integer", is_nullable => 1 },
  "type",
  { data_type => "char", is_nullable => 1, size => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</permid>

=back

=cut

__PACKAGE__->set_primary_key("permid");

=head1 UNIQUE CONSTRAINTS

=head2 C<cc_perms_all_idx>

=over 4

=item * L</subj>

=item * L</action>

=item * L</obj>

=back

=cut

__PACKAGE__->add_unique_constraint("cc_perms_all_idx", ["subj", "action", "obj"]);

=head1 RELATIONS

=head2 subj

Type: belongs_to

Related object: L<Airtime::Schema::Result::CcSubj>

=cut

__PACKAGE__->belongs_to(
  "subj",
  "Airtime::Schema::Result::CcSubj",
  { id => "subj" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 10:29:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4jZ1s8yI2IIMeJtllHvKsQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
