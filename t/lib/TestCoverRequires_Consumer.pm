package TestCoverRequires_Consumer;

=head1 NAME

TestCoverRequires_Consumer - consume role with some methods, override some and define some more

=cut

use Moose;
use namespace::clean -except => 'meta';

with 'TestCoverRequires';

sub foo { }

sub bar { }

sub baz { }

1;
