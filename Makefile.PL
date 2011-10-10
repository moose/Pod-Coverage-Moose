use inc::Module::Install 0.75;

name     'Pod-Coverage-Moose';
all_from 'lib/Pod/Coverage/Moose.pm';

requires 'Moose',                   0.24;
requires 'Carp',                    0;
requires 'namespace::clean',        0.05;
requires 'Pod::Coverage',           0;
requires 'Perl6::Junction',         0;
requires 'Class::MOP',              0;

build_requires 'Test::More',                0;
build_requires 'FindBin',                   0;
build_requires 'Test::Pod',                 0;
build_requires 'Test::Pod::Coverage',       0;

auto_provides;
auto_install;

if (-e 'MANIFEST.SKIP') {

    print "Creating README file\n";
    system 'pod2text lib/Pod/Coverage/Moose.pm > README';

    print "Adding author tests to 'make test' run\n";
    tests 't/*.t t_author/*.t';
}

WriteAll;
