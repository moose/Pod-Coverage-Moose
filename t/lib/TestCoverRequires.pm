package TestCoverRequires;

use Moose::Role;
use namespace::clean -except => 'meta';

sub foo { }

requires 'bar';

1;
