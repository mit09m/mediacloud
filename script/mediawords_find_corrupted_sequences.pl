#!/usr/bin/env perl

use strict;
use warnings;

use Modern::Perl "2015";
use MediaWords::CommonLibs;

use MediaWords::DB;
use Data::Dumper;

sub main
{
    my $db = MediaWords::DB::connect_to_db;

    my $corrupted_sequences = $db->query( 'SELECT find_corrupted_sequences()' )->hashes;

    if ( scalar( @{ $corrupted_sequences } ) > 0 )
    {
        foreach my $sequence ( @{ $corrupted_sequences } )
        {
            INFO 'Corrupted sequence: ' . Dumper( $sequence );
        }
        exit 1;
    }
}

main();
