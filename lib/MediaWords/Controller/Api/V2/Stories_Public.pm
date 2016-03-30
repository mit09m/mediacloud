package MediaWords::Controller::Api::V2::Stories_Public;
use Modern::Perl "2015";
use MediaWords::CommonLibs;

use strict;
use warnings;
use base 'Catalyst::Controller';
use JSON;
use List::Util qw(first max maxstr min minstr reduce shuffle sum);
use Moose;
use namespace::autoclean;
use List::Compare;
use Carp;

use MediaWords::DBI::Stories;
use MediaWords::Solr;

BEGIN
{
    extends 'MediaWords::Controller::Api::V2::StoriesBase'    # private
}

__PACKAGE__->config(                                          #
    action => {                                               #
        single_GET => { Does => [ qw( ~PublicApiKeyAuthenticated ~Throttled ~Logged ) ] },    #
        list_GET   => { Does => [ qw( ~PublicApiKeyAuthenticated ~Throttled ~Logged ) ] },    #
        count_GET  => { Does => [ qw( ~PublicApiKeyAuthenticated ~Throttled ~Logged ) ] },    #
      }    #
);         #

sub has_extra_data
{
    return 0;
}

sub permissible_output_fields
{
    return [
        qw/
          stories_id
          title
          language
          media_id
          media_name
          media_url
          processed_stories_id
          url
          guid
          publish_date
          collect_date
          story_tags
          bitly_click_count
          ap_syndicated
          /
    ];
}

=head1 AUTHOR

David Larochelle

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;