use utf8;
package Airtime::Schema::Result::CcSubj;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcSubj

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

=head1 TABLE: C<cc_subjs>

=cut

__PACKAGE__->table("cc_subjs");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cc_subjs_id_seq'

=head2 login

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 pass

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 type

  data_type: 'char'
  default_value: 'U'
  is_nullable: 0
  size: 1

=head2 first_name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 last_name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 lastlogin

  data_type: 'timestamp'
  is_nullable: 1

=head2 lastfail

  data_type: 'timestamp'
  is_nullable: 1

=head2 skype_contact

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 jabber_contact

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 cell_phone

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 login_attempts

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cc_subjs_id_seq",
  },
  "login",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "pass",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "type",
  { data_type => "char", default_value => "U", is_nullable => 0, size => 1 },
  "first_name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "last_name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "lastlogin",
  { data_type => "timestamp", is_nullable => 1 },
  "lastfail",
  { data_type => "timestamp", is_nullable => 1 },
  "skype_contact",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "jabber_contact",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "cell_phone",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "login_attempts",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<cc_subjs_login_idx>

=over 4

=item * L</login>

=back

=cut

__PACKAGE__->add_unique_constraint("cc_subjs_login_idx", ["login"]);

=head1 RELATIONS

=head2 cc_blocks

Type: has_many

Related object: L<Airtime::Schema::Result::CcBlock>

=cut

__PACKAGE__->has_many(
  "cc_blocks",
  "Airtime::Schema::Result::CcBlock",
  { "foreign.creator_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cc_files_editedbies

Type: has_many

Related object: L<Airtime::Schema::Result::CcFile>

=cut

__PACKAGE__->has_many(
  "cc_files_editedbies",
  "Airtime::Schema::Result::CcFile",
  { "foreign.editedby" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cc_files_owners

Type: has_many

Related object: L<Airtime::Schema::Result::CcFile>

=cut

__PACKAGE__->has_many(
  "cc_files_owners",
  "Airtime::Schema::Result::CcFile",
  { "foreign.owner_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cc_perms

Type: has_many

Related object: L<Airtime::Schema::Result::CcPerm>

=cut

__PACKAGE__->has_many(
  "cc_perms",
  "Airtime::Schema::Result::CcPerm",
  { "foreign.subj" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cc_playlists

Type: has_many

Related object: L<Airtime::Schema::Result::CcPlaylist>

=cut

__PACKAGE__->has_many(
  "cc_playlists",
  "Airtime::Schema::Result::CcPlaylist",
  { "foreign.creator_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cc_prefs

Type: has_many

Related object: L<Airtime::Schema::Result::CcPref>

=cut

__PACKAGE__->has_many(
  "cc_prefs",
  "Airtime::Schema::Result::CcPref",
  { "foreign.subjid" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cc_sesses

Type: has_many

Related object: L<Airtime::Schema::Result::CcSess>

=cut

__PACKAGE__->has_many(
  "cc_sesses",
  "Airtime::Schema::Result::CcSess",
  { "foreign.userid" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cc_show_hosts

Type: has_many

Related object: L<Airtime::Schema::Result::CcShowHost>

=cut

__PACKAGE__->has_many(
  "cc_show_hosts",
  "Airtime::Schema::Result::CcShowHost",
  { "foreign.subjs_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cc_subjs_tokens

Type: has_many

Related object: L<Airtime::Schema::Result::CcSubjsToken>

=cut

__PACKAGE__->has_many(
  "cc_subjs_tokens",
  "Airtime::Schema::Result::CcSubjsToken",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 17:33:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:DOkh4Cr6tUZZvNGpCV+JVw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
