# NAME

Pod::Coverage::Moose - Pod::Coverage extension for Moose

# VERSION

version 0.05

# SYNOPSIS

    use Pod::Coverage::Moose;

    my $pcm = Pod::Coverage::Moose->new(package => 'MoosePackage');
    print 'Coverage: ', $pcm->coverage, "\n";

# DESCRIPTION

When using [Pod::Coverage](https://metacpan.org/pod/Pod::Coverage) in combination with [Moose](https://metacpan.org/pod/Moose), it will
report any method imported from a Role. This is especially bad when
used in combination with [Test::Pod::Coverage](https://metacpan.org/pod/Test::Pod::Coverage), since it takes away
its ease of use.

To use this module in combination with [Test::Pod::Coverage](https://metacpan.org/pod/Test::Pod::Coverage), use
something like this:

    use Test::Pod::Coverage;
    all_pod_coverage_ok({ coverage_class => 'Pod::Coverage::Moose'});

# ATTRIBUTES

## package

This is the package used for inspection.

## cover\_requires

Boolean flag to indicate that `requires $method` declarations in a Role should be trusted.

# METHODS

## meta

[Moose](https://metacpan.org/pod/Moose) meta object.

## BUILD

Initialises the internal [Pod::Coverage](https://metacpan.org/pod/Pod::Coverage) object. It uses the meta object
to find all methods and attribute methods imported via roles.

# DELEGATED METHODS

## Delegated to the traditional [Pod::Coverage](https://metacpan.org/pod/Pod::Coverage) object are

- coverage
- covered
- naked
- uncovered
- why\_unrated

# EXTENDED METHODS

## new

The constructor will only return a `Pod::Coverage::Moose` object if it
is invoked on a class that `can` a `meta` method. Otherwise, a
traditional [Pod::Coverage](https://metacpan.org/pod/Pod::Coverage) object will be returned. This is done so you
don't get in trouble for mixing [Moose](https://metacpan.org/pod/Moose) with non Moose classes in your
project.

# SEE ALSO

[Moose](https://metacpan.org/pod/Moose),
[Pod::Coverage](https://metacpan.org/pod/Pod::Coverage),
[Test::Pod::Coverage](https://metacpan.org/pod/Test::Pod::Coverage)

# AUTHOR

Robert 'phaylon' Sedlacek <rs@474.at>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2007 by Robert 'phaylon' Sedlacek.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

# CONTRIBUTORS

- Dave Rolsky <autarch@urth.org>
- Karen Etheridge <ether@cpan.org>
- Vyacheslav Matyukhin <me@berekuk.ru>
