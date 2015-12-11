use strict;
use warnings;
use utf8;

use t::Util;

use CrystalBuild::Fetcher::Wget;

create_server;

subtest normal => sub {
    my $self = CrystalBuild::Fetcher::Wget->new;
    ok $self->fetch_able(uri_for('test.txt'));
};

subtest failed => sub {
    my $self = CrystalBuild::Fetcher::Wget->new;
    ok not $self->fetch_able(uri_for('invalid_path.txt'));
};

done_testing;