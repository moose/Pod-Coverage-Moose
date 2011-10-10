package MooseRole;
use Moose::Role;
use namespace::clean -except => 'meta';

has attr => (is => 'rw');
has complex_attr => (
    reader      => 'get_complex',
    writer      => 'set_complex',
    clearer     => 'clear_complex',
    predicate   => 'has_complex',
);

sub foo { }

1;
