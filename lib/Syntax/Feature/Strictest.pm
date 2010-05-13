use strict;
use warnings;

# ABSTRACT: Use a stricter Perl

package Syntax::Feature::Strictest;

use Carp        qw( confess );
use indirect    ();

use namespace::clean;

$Carp::Internal{ +__PACKAGE__ }++;

sub install {
    my ($class, %args) = @_;

    return $class->_enable(
        -use_strict     => 1,
        -use_warnings   => 1,
        -no_indirect    => 1,
        %{ $args{options} || {} },
    );
}

sub _enable {
    my ($class, %args) = @_;

    strict->import
        if $args{ -use_strict };

    warnings->import(FATAL => 'all')
        if $args{ -use_warnings };

    indirect->unimport(':fatal')
        if $args{ -no_indirect };

    return 1;
}

1;

__END__

=method install

Called by the L<syntax> dispatcher to install the extension into the requesting
package.

=option -use_strict

Defaults to true and will activate 

    use strict;

in the target package.

=option -use_warnings

Defaults to true and will activate

    use warnings FATAL => 'all';

in the target package.

=option -no_indirect

Defaults to true and will activate

    no indirect ':fatal';

in the target package.

=head1 SYNOPSIS

    use syntax qw( strictest );

=head1 DESCRIPTION

This module provides essentially the same as

    use strict;
    use warnings FATAL => 'all';
    no indirect ':fatal';

You can selectively disable the features by passing an optional hash reference
after specifying C<strictest> in the L<syntax> import:

    use syntax strictest => { -no_indirect => 0 };

See L</OPTIONS> for a list of available options.

=head1 SEE ALSO

L<syntax>,
L<strict>,
L<warnings>,
L<perllexwarn>,
L<indirect>

=cut
