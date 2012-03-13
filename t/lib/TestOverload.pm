package TestOverload;
use Moose::Role;
use MooseX::Role::WithOverloading;

use overload q{""} => sub { };

sub foo { };

1;
