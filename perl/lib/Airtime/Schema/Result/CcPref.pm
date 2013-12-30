use utf8;
package Airtime::Schema::Result::CcPref;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcPref

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

=head1 TABLE: C<cc_pref>

=cut

__PACKAGE__->table("cc_pref");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cc_pref_id_seq'

=head2 subjid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 keystr

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 valstr

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cc_pref_id_seq",
  },
  "subjid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "keystr",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "valstr",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<cc_pref_subj_key_idx>

=over 4

=item * L</subjid>

=item * L</keystr>

=back

=cut

__PACKAGE__->add_unique_constraint("cc_pref_subj_key_idx", ["subjid", "keystr"]);

=head1 RELATIONS

=head2 subjid

Type: belongs_to

Related object: L<Airtime::Schema::Result::CcSubj>

=cut

__PACKAGE__->belongs_to(
  "subjid",
  "Airtime::Schema::Result::CcSubj",
  { id => "subjid" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 10:29:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nLIrmRJb93PJhkEcGYxAhw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
