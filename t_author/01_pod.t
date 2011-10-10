#!perl
use warnings;
use strict;

use Test::More;
use Test::Pod;

all_pod_files_ok( all_pod_files('lib') );

