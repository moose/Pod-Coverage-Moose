=pod

=head2 IsMoose->baz

The baz method

=cut

package IsMoose;
use Moose;
use namespace::clean -except => 'meta';

with 'MooseRole';

sub bar { }

sub baz { }

1;
