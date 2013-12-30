use utf8;
package Airtime::Schema::Result::CcLocale;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Airtime::Schema::Result::CcLocale

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

=head1 TABLE: C<cc_locale>

=cut

__PACKAGE__->table("cc_locale");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cc_locale_id_seq'

=head2 locale_code

  data_type: 'varchar'
  is_nullable: 0
  size: 16

=head2 locale_lang

  data_type: 'varchar'
  is_nullable: 0
  size: 128

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cc_locale_id_seq",
  },
  "locale_code",
  { data_type => "varchar", is_nullable => 0, size => 16 },
  "locale_lang",
  { data_type => "varchar", is_nullable => 0, size => 128 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-30 17:33:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mH+Xqq8xJpUnrx3hZpjCxA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
