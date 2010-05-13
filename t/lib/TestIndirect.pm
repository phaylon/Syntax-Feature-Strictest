use syntax 'strictest';

do { 
    package TestIndirect;
    sub new { bless { } }
};

my $foo = new Foo;

1;
