#!/usr/bin/perl
use warnings;
use strict;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test::More;
use Test::Kwalitee 
    tests => [
        -use_strict,
        -has_test_pod,
        -has_test_pod_coverage,
    ];

