use strict;
use warnings;
package Math::Shape::Grid;
$Math::Shape::Grid::VERSION = '0.01';
use 5.008;
use List::Util qw/max min/;

# ABSTRACT: a 2d grid for visualizing Math::Shape::Point objects on the terminal


sub print {
    my $points = shift;

    my ($min_x, $max_x, $min_y, $max_y) = qw/0 0 0 0/;

    for my $name (sort { $a cmp $b } keys %{$points}) {
        my $point = $points->{$name};

        printf "%s x:%3s, y:%3s, r:%6s\n", $name, $point->{x}, $point->{y}, $point->{r};

        # get grid range
        $min_x = $point->{x} if $point->{x} < $min_x;
        $max_x = $point->{x} if $point->{x} > $max_x;
        $min_y = $point->{y} if $point->{y} < $min_y;
        $max_y = $point->{y} if $point->{y} > $max_y;
    }

    my $max = max ( $max_x, $max_y ) + 5;
    my $min = min ( $min_x, $min_y ) + -5;

    # print grid
    print "\n   ";
    for ($min..$max) { printf "%3s", $_ }
    printf "%3s", "x\n";
    for my $y (reverse $min..$max) 
    {
        printf "%3s", $y;
        for my $x ($min..$max) 
        {
            my $intercept = sprintf "%3s", '.';

            # loop through points to see if we have a match
            for (keys %{ $points } ) {
                my $p = $points->{$_};
                if ($p->{x} == $x && $p->{y} == $y) {
                    $intercept = sprintf "%3s", $_;
                }
            }
            print $intercept;
        }
        print "\n";
    }
    printf "%3s", "y\n";
    1;
}


1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Math::Shape::Grid - a 2d grid for visualizing Math::Shape::Point objects on the terminal

=head1 VERSION

version 0.01

=head1 SYNOPSIS

    my $p1 = Math::Shape::Point->new(1, 1, 0);
    my $p2 = Math::Shape::Point->new(2, 2, 0);
    my $p3 = Math::Shape::Point->new(3, 3, 0);

    Math::Shape::Grid::print({ p1 => $p1, p2 => $p2, p3 => $p3 });

    # prints:
    p1 x:  1, y:  1, r:     0
    p2 x:  2, y:  2, r:     0
    p3 x:  3, y:  3, r:     0

        -5 -4 -3 -2 -1  0  1  2  3  4  5  6  7  8 x
      8  .  .  .  .  .  .  .  .  .  .  .  .  .  .
      7  .  .  .  .  .  .  .  .  .  .  .  .  .  .
      6  .  .  .  .  .  .  .  .  .  .  .  .  .  .
      5  .  .  .  .  .  .  .  .  .  .  .  .  .  .
      4  .  .  .  .  .  .  .  .  .  .  .  .  .  .
      3  .  .  .  .  .  .  .  . p3  .  .  .  .  .
      2  .  .  .  .  .  .  . p2  .  .  .  .  .  .
      1  .  .  .  .  .  . p1  .  .  .  .  .  .  .
      0  .  .  .  .  .  .  .  .  .  .  .  .  .  .
     -1  .  .  .  .  .  .  .  .  .  .  .  .  .  .
     -2  .  .  .  .  .  .  .  .  .  .  .  .  .  .
     -3  .  .  .  .  .  .  .  .  .  .  .  .  .  .
     -4  .  .  .  .  .  .  .  .  .  .  .  .  .  .
     -5  .  .  .  .  .  .  .  .  .  .  .  .  .  .
     y

=head1 FUNCTIONS

=head2 print

Prints a grid to STDOUT. Requires a hashref of L<Math::Shape::Point> objects.

    Math::Shape::Grid::print($points);

=head1 AUTHOR

David Farrell <sillymoos@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by David Farrell.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
