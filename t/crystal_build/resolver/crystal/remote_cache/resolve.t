use strict;
use warnings;
use utf8;

use Test::MockObject;

use t::Util;
use CrystalBuild::Resolver::Crystal::RemoteCache;

subtest basic => sub {
    my $fetcher = Test::MockObject->new;
    $fetcher->mock(fetch => sub {
       my ($self, $url) = @_;

       is $url, 'http://www.example.com';

       return <<EOF;
[
  {
    "tag_name": "0.7.5",
    "assets": {
      "darwin-x64": "https://crystal.org/darwin-x64-0.7.5.tar.gz"
    }
  }
]
EOF
    });

    my $guard = mock_guard(
        'CrystalBuild::Resolver::Crystal::RemoteCache',
        {
            fetcher   => sub { $fetcher },
            cache_url => sub { 'http://www.example.com' },
        });

    my $resolver = CrystalBuild::Resolver::Crystal::RemoteCache->new;

    is
        $resolver->resolve('0.7.5', 'darwin', 'x64'),
        'https://crystal.org/darwin-x64-0.7.5.tar.gz';

    ok $fetcher->called('fetch');
    is $guard->call_count('CrystalBuild::Resolver::Crystal::RemoteCache', 'fetcher'), 1;
    is $guard->call_count('CrystalBuild::Resolver::Crystal::RemoteCache', 'cache_url'), 1;
};

done_testing;
