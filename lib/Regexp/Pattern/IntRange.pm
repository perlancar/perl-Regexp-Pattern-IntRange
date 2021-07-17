package Regexp::Pattern::IntRange;

# AUTHORITY
# DATE
# DIST
# VERSION

#use 5.010001;
use strict;
use warnings;
#use utf8;

our %RE;

$RE{simple_int_range} = {
    summary => 'Simple integer range, e.g. 1-10 / -2-7',
    description => <<'_',

Currently does not check that start value must not be greater than end value.

_
    pat => qr/(-?[0-9]+)\s*-\s*(-?[0-9]+)/,
    tags => ['capturing'],
    examples => [
        {str=>'', matches=>0, summary=>'Empty string'},
        {str=>'1', anchor=>1, mtaches=>0, summary=>'Not a range but single positive integer'},
        {str=>'-2', anchor=>1, matches=>0, summary=>'Not a range but single negative integer'},

        {str=>'1-1', anchor=>1, matches=>1},
        {str=>'1-2', anchor=>1, matches=>1},
        {str=>'1 - 2', anchor=>1, matches=>1},
        {str=>'0-100', anchor=>1, matches=>1},
        {str=>'-1-2', anchor=>1, matches=>1},
        {str=>'-10--1', anchor=>1, matches=>1},

        {str=>'1-', anchor=>1, matches=>0, summary=>'Missing end value'},
        {str=>'1-1.5', anchor=>1, matches=>0, sumary=>'Float'},
        #{str=>'9-2', anchor=>1, matches=>0, summary=>'start value cannot be larger than end value'},
        {str=>'1-2-3', anchor=>1, matches=>0, summary=>'Invalid syntax'},
        {str=>' 1-2 ', anchor=>1, matches=>0, summary=>'Leading and trailing whitespace is currently not allowed'},
    ],
};

$RE{simple_uint_range} = {
    summary => 'Simple unsigned integer range, e.g. 1-10 / 2-7',
    description => <<'_',

Currently does not check that start value must not be greater than end value.

_
    pat => qr/([0-9]+)\s*-\s*([0-9]+)/,
    tags => ['capturing'],
    examples => [
        {str=>'', matches=>0, summary=>'Empty string'},
        {str=>'1', anchor=>1, mtaches=>0, summary=>'Not a range but single positive integer'},
        {str=>'-2', anchor=>1, matches=>0, summary=>'Not a range but single negative integer'},

        {str=>'1-1', anchor=>1, matches=>1},
        {str=>'1-2', anchor=>1, matches=>1},
        {str=>'1 - 2', anchor=>1, matches=>1},
        {str=>'0-100', anchor=>1, matches=>1},
        {str=>'-1-2', anchor=>1, matches=>0,
         summary=>'Negative'},
        {str=>'-10--1', anchor=>1, matches=>0,
         summary=>'Negative'},

        {str=>'1-', anchor=>1, matches=>0, summary=>'Missing end value'},
        {str=>'1-1.5', anchor=>1, matches=>0, sumary=>'Float'},
        #{str=>'9-2', anchor=>1, matches=>0, summary=>'start value cannot be larger than end value'},
        {str=>'1-2-3', anchor=>1, matches=>0, summary=>'Invalid syntax'},
        {str=>' 1-2 ', anchor=>1, matches=>0, summary=>'Leading and trailing whitespace is currently not allowed'},
    ],
};

$RE{simple_int_seq} = {
    summary => 'Simple integer sequence, e.g. 1,-3,12',
    description => <<'_',

_
    pat => qr/(?:-?[0-9]+)(?:\s*,\s*(?:-?[0-9]+))*/,
    examples => [
        {str=>'', anchor=>1, matches=>0, summary=>'Empty string'},
        {str=>'1-2', anchor=>1, matches=>0, summary=>'A range m-n is not valid in simple integer sequence'},
        {str=>'1,', anchor=>1, matches=>0, summary=>'Dangling comma is currently not allowed'},
        {str=>'1,,2', anchor=>1, matches=>0, summary=>'Multiple commas are currently not allowed'},
        {str=>'1.2', anchor=>1, matches=>0, summary=>'Float'},

        {str=>'1', anchor=>1, matches=>1},
        {str=>'1,2', anchor=>1, matches=>1},
        {str=>'1 , 2', anchor=>1, matches=>1},
        {str=>'1,2,-3,4', anchor=>1, matches=>1},
    ],
};

$RE{simple_uint_seq} = {
    summary => 'Simple unsigned integer sequence, e.g. 1,3,12',
    description => <<'_',

_
    pat => qr/(?:[0-9]+)(?:\s*,\s*(?:[0-9]+))*/,
    examples => [
        {str=>'', anchor=>1, matches=>0, summary=>'Empty string'},
        {str=>'1-2', anchor=>1, matches=>0, summary=>'A range m-n is not valid in simple integer sequence'},
        {str=>'1,', anchor=>1, matches=>0, summary=>'Dangling comma is currently not allowed'},
        {str=>'1,,2', anchor=>1, matches=>0, summary=>'Multiple commas are currently not allowed'},
        {str=>'1.2', anchor=>1, matches=>0, summary=>'Float'},

        {str=>'1', anchor=>1, matches=>1},
        {str=>'1,2', anchor=>1, matches=>1},
        {str=>'1 , 2', anchor=>1, matches=>1},
        {str=>'1,2,-3,4', anchor=>1, matches=>0,
         summary=>'Negative'},
    ],
};

$RE{int_range} = {
    summary => 'Integer range (sequence of ints/simple ranges), e.g. 1 / -5-7 / 1,10 / 1,5-7,10',
    description => <<'_',

Currently does not check that start value in a simple range must not be greater
than end value.

_
    pat => qr/
                 (?:(?:-?[0-9]+)(?:\s*-\s*(?:-?[0-9]+))?)
                 (
                     \s*,\s*
                     (?:(?:-?[0-9]+)(?:\s*-\s*(?:-?[0-9]+))?)
                 )*
             /x,
    examples => [
        {str=>'', anchor=>1, matches=>0, summary=>'Empty string'},

        # single int

        {str=>'1', anchor=>1, matches=>1},
        {str=>'-2', anchor=>1, matches=>1},

        {str=>'1.5', anchor=>1, matches=>0, summary=>'Float'},

        # simple int range

        {str=>'1-1', anchor=>1, matches=>1},
        {str=>'1-2', anchor=>1, matches=>1},
        {str=>'1 - 2', anchor=>1, matches=>1},
        {str=>'0-100', anchor=>1, matches=>1},
        {str=>'-1-2', anchor=>1, matches=>1},
        {str=>'-10--1', anchor=>1, matches=>1},

        {str=>'1-', anchor=>1, matches=>0, summary=>'Missing end value'},
        {str=>'1-1.5', anchor=>1, matches=>0, sumary=>'Float'},
        #{str=>'9-2', anchor=>1, matches=>0, summary=>'start value cannot be larger than end value'},
        {str=>'1-2-3', anchor=>1, matches=>0, summary=>'Invalid simple int range syntax'},
        {str=>' 1-2 ', anchor=>1, matches=>0, summary=>'Leading and trailing whitespace is currently not allowed'},

        # simple int seq

        {str=>'1,2', anchor=>1, matches=>1},
        {str=>'1 , 2', anchor=>1, matches=>1},
        {str=>'1,2,-3,4', anchor=>1, matches=>1},

        {str=>'1,2,-3,4.5', anchor=>1, matches=>0, summary=>'Float'},
        {str=>'1,', anchor=>1, matches=>0, summary=>'Dangling comma is currently not allowed'},
        {str=>'1,,2', anchor=>1, matches=>0, summary=>'Multiple commas are currently not allowed'},

        # seq of ints/simple int ranges

        {str=>'1,2-5', anchor=>1, matches=>1},
        {str=>'-1,-2-5,7,9-9', anchor=>1, matches=>1},

        #{str=>'1,9-2', anchor=>1, matches=>0, summary=>'start value cannot be larger than end value'},

    ],
};

$RE{uint_range} = {
    summary => 'Unsigned integer range (sequence of uints/simple ranges), e.g. 1 / 5-7 / 1,10 / 1,5-7,10',
    description => <<'_',

Currently does not check that start value in a simple range must not be greater
than end value.

_
    pat => qr/
                 (?:(?:[0-9]+)(?:\s*-\s*(?:[0-9]+))?)
                 (
                     \s*,\s*
                     (?:(?:[0-9]+)(?:\s*-\s*(?:[0-9]+))?)
                 )*
             /x,
    examples => [
        {str=>'', anchor=>1, matches=>0, summary=>'Empty string'},

        # single int

        {str=>'1', anchor=>1, matches=>1},
        {str=>'-2', anchor=>1, matches=>0,
         summary=>'Negative'},

        {str=>'1.5', anchor=>1, matches=>0, summary=>'Float'},

        # simple int range

        {str=>'1-1', anchor=>1, matches=>1},
        {str=>'1-2', anchor=>1, matches=>1},
        {str=>'1 - 2', anchor=>1, matches=>1},
        {str=>'0-100', anchor=>1, matches=>1},
        {str=>'-1-2', anchor=>1, matches=>0,
         summary=>'Negative'},
        {str=>'-10--1', anchor=>1, matches=>0,
         summary=>'Negative'},

        {str=>'1-', anchor=>1, matches=>0, summary=>'Missing end value'},
        {str=>'1-1.5', anchor=>1, matches=>0, sumary=>'Float'},
        #{str=>'9-2', anchor=>1, matches=>0, summary=>'start value cannot be larger than end value'},
        {str=>'1-2-3', anchor=>1, matches=>0, summary=>'Invalid simple int range syntax'},
        {str=>' 1-2 ', anchor=>1, matches=>0, summary=>'Leading and trailing whitespace is currently not allowed'},

        # simple int seq

        {str=>'1,2', anchor=>1, matches=>1},
        {str=>'1 , 2', anchor=>1, matches=>1},
        {str=>'1,2,-3,4', anchor=>1, matches=>0,
         summary=>'Negative'},

        {str=>'1,2,-3,4.5', anchor=>1, matches=>0, summary=>'Float'},
        {str=>'1,', anchor=>1, matches=>0, summary=>'Dangling comma is currently not allowed'},
        {str=>'1,,2', anchor=>1, matches=>0, summary=>'Multiple commas are currently not allowed'},

        # seq of ints/simple int ranges

        {str=>'1,2-5', anchor=>1, matches=>1},
        {str=>'-1,-2-5,7,9-9', anchor=>1, matches=>0,
         summary=>'Negative'},

        #{str=>'1,9-2', anchor=>1, matches=>0, summary=>'start value cannot be larger than end value'},

    ],
};

1;
# ABSTRACT: Regexp patterns related to integer ranges

=head1 prepend:SEE ALSO

L<Sah::Schemas::IntRange>

L<Regexp::Pattern::Int>
