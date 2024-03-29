use warnings;
use strict;

use Test::More 0.88;
use lib 't/lib';

use Pod::Coverage::Moose;

{   package NonMoose;
    sub foo { }
}
isa_ok(Pod::Coverage::Moose->new(package => 'NonMoose'), 'Pod::Coverage',
    'non Moose package coverage object');

require IsMoose;
my $pcm = Pod::Coverage::Moose->new(package => 'IsMoose');
isa_ok($pcm, 'Pod::Coverage::Moose',
    'Moose package coverage object');

#use Data::Dump qw( dump );
#print dump([$pcm->covered]), "\n";
is_deeply [sort $pcm->covered], [qw( baz )],
    'covered methods contain method directly in package method';
is_deeply [sort $pcm->uncovered], [qw( bar )],
    'uncovered methods contains method directly in package';

done_testing;
