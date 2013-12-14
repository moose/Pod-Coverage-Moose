package TestOverload;
use Moose::Role;
use MooseX::Role::WithOverloading;

use overload
    q{""} => sub { },
    fallback => 1;

sub foo { };

1;
