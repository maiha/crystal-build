use strict;
use warnings;
use utf8;

use t::Util;

use Crenv::Resolver::GitHub;

subtest basic => sub {
    my $assets = [
        {
            name                 => 'crystal-0.7.5-1-darwin-x86_64.tar.gz',
            browser_download_url => 'http://www.example.com/darwin/x64',
        },
        {
            name                 => 'crystal-0.7.5-1-linux-x86_64.tar.gz',
            browser_download_url => 'http://www.example.com/linux/x64',
        },
    ];

    my $urls = Crenv::Resolver::GitHub->_find_binary_download_urls($assets);
    is $urls->{'darwin-x64'}, 'http://www.example.com/darwin/x64';
    is $urls->{'linux-x64'}, 'http://www.example.com/linux/x64';
};

done_testing;