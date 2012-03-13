=head1 NAME

Pod::Coverage::Moose - L<Pod::Coverage> extension for L<Moose>

=cut

package Pod::Coverage::Moose;
use Moose;

use Pod::Coverage;
use Carp            qw( croak );
use Perl6::Junction qw( any );
use Class::MOP;

use namespace::clean -except => 'meta';

our $VERSION = '0.04';

=head1 SYNOPSIS

  use Pod::Coverage::Moose;

  my $pcm = Pod::Coverage::Moose->new(package => 'MoosePackage');
  print 'Coverage: ', $pcm->coverage, "\n";

=head1 DESCRIPTION

When using L<Pod::Coverage> in combination with L<Moose>, it will
report any method imported from a Role. This is especially bad when
used in combination with L<Test::Pod::Coverage>, since it takes away
its ease of use.

To use this module in combination with L<Test::Pod::Coverage>, use
something like this:

  use Test::Pod::Coverage;
  all_pod_coverage_ok({ coverage_class => 'Pod::Coverage::Moose'});

=head1 ATTRIBUTES

=head2 package

This is the package used for inspection.

=cut

has package => (
    is          => 'rw',
    isa         => 'Str',
    required    => 1,
);

=head2 cover_requires

Boolean flag to indicate that C<requires $method> declarations in a Role should be trusted.

=cut

has cover_requires => (
    is          => 'ro',
    isa         => 'Bool',
    default => 0,
);

#
#   original pod_coverage object
#

has _pod_coverage => (
    is          => 'rw',
    isa         => 'Pod::Coverage',
    handles     => [qw( coverage why_unrated naked uncovered covered )],
);

=head1 METHODS

=head2 meta

L<Moose> meta object.

=head2 BUILD

Initialises the internal L<Pod::Coverage> object. It uses the meta object
to find all methods and attribute methods imported via roles.

=cut

sub BUILD {
    my ($self, $args) = @_;

    my $meta    = $self->package->meta;
    my @trustme = @{ $args->{trustme} || [] };

    push @trustme, qr/^meta$/;
    push @trustme,                                          # MooseX-AttributeHelpers hack
        map  { qr/^$_$/ }
        map  { $_->name }
        grep { $_->isa('MooseX::AttributeHelpers::Meta::Method::Provided') }
        $meta->get_all_methods
            unless $meta->isa('Moose::Meta::Role');
    push @trustme, 
        map { qr/^\Q$_\E$/ }                                # turn value into a regex
        map {                                               # iterate over all roles of the class
            my $role = $_;
            $role->get_method_list,
            ($self->cover_requires ? ($role->get_required_method_list) : ()),
            map {                                           # iterate over attributes
                my $attr = $role->get_attribute($_);
                ($attr->{is} && $attr->{is} eq any(qw( rw ro wo )) ? $_ : ()),  # accessors
                grep defined, map { $attr->{ $_ } }                             # other attribute methods
                    qw( clearer predicate reader writer accessor );
            } $role->get_attribute_list,
        } 
        $meta->calculate_all_roles;

    $args->{trustme} = \@trustme;

    $self->_pod_coverage(Pod::Coverage->new(%$args));
}

=head1 DELEGATED METHODS

=head2 Delegated to the traditional L<Pod::Coverage> object are

=over

=item coverage

=item covered

=item naked

=item uncovered

=item why_unrated

=back

=head1 EXTENDED METHODS

=head2 new

The constructor will only return a C<Pod::Coverage::Moose> object if it
is invoked on a class that C<can> a C<meta> method. Otherwise, a 
traditional L<Pod::Coverage> object will be returned. This is done so you
don't get in trouble for mixing L<Moose> with non Moose classes in your
project.

=cut

around new => sub {
    my $next = shift;
    my ($self, @args) = @_;

    my %args  = (@args == 1 && ref $args[0] eq 'HASH' ? %{ $args[0] } : @args);
    my $class = $args{package}
        or croak 'You need to specify a package in the constructor arguments';

    Class::MOP::load_class($class);
    return Pod::Coverage->new(%args) unless $class->can('meta');

    return $self->$next(@args);
};

1;

=head1 SEE ALSO

L<Moose>,
L<Pod::Coverage>,
L<Test::Pod::Coverage>

=head1 AUTHOR

Robert 'phaylon' Sedlacek E<lt>rs@474.atE<gt>

=head1 COPYRIGHT AND LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
