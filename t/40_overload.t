use warnings;
use strict;

use FindBin;
use lib "$FindBin::Bin/lib";
use Test::More;

eval { require MooseX::Role::WithOverloading };
Test::More->import(skip_all => 'optional tests, MooseX-Role-WithOverloading not found')
    if $@;
Test::More->import('no_plan');

use_ok  'TestOverload_Consumer',    'consumer test class loaded ok';
use_ok  'Pod::Coverage::Moose',             'pcm loaded ok';

my $pcm = Pod::Coverage::Moose->new(package => 'TestOverload_Consumer');

is_deeply [$pcm->uncovered], [qw( bar )], 'injected helper methods not detected as uncovered, overloaded methods ignored';
