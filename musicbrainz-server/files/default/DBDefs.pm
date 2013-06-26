use strict;
use warnings;

package DBDefs;

use parent 'DBDefs::Default';
use MusicBrainz::Server::Replication ':replication_type';
use MusicBrainz::Server::DatabaseConnectionFactory;

MusicBrainz::Server::DatabaseConnectionFactory->register_databases(
    READWRITE => {
        database    => "musicbrainz",
        schema          => "musicbrainz",
        username    => "musicbrainz",
        password        => "musicbrainz",
    },
    TEST => {
        database    => "musicbrainz_test",
        schema          => "musicbrainz",
        username    => "musicbrainz",
        password        => "musicbrainz",
    },
    READONLY => {
        database    => "musicbrainz",
        schema          => "musicbrainz",
        username    => "musicbrainz",
        password        => "musicbrainz",
    },
    SYSTEM    => {
        database    => "template1",
        username    => "postgres",
    },
);

sub DB_SCHEMA_SEQUENCE { 18 }

sub REPLICATION_TYPE { RT_SLAVE }

sub CATALYST_DEBUG { 0 }

1;
