use strict;

use Test::Most;
use FindBin;
use lib "$FindBin::Bin/lib";

throws_ok {
    require TestIndirect;
} qr/indirect/i, 'indirect method calls are fatal';

throws_ok {
    require TestStrictures;
} qr/\$foo/i, 'strictures are on';


use syntax 'strictest';

throws_ok {
    my $foo;
    my $bar = 3;
    my $baz = $foo + $bar;
} qr/uninitialized/i, 'fatal warnings';

done_testing;
