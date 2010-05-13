no warnings;
use Test::Most;

{   package TestNoStrict;
    use syntax strictest => { -use_strict => 0 };
    $foo = 23;
    ::is $foo, 23, 'disabled strictures';
}

{   package TestNoWarnings;
    use syntax strictest => { -use_warnings => 0 };
    my $x = 23;
    my $y;
    my $z = $x + $y;
    ::is $z, 23, 'disabled warnings';
}

{   package TestNoFatalIndirection;
    use syntax strictest => { -no_indirect => 0 };
    sub new { bless {} }
    my $foo = new TestNoFatalIndirection;
    ::isa_ok $foo, 'TestNoFatalIndirection', 'indirectly created object';
}

done_testing;
