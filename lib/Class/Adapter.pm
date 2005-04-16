package Class::Adapter;

=pod

=head1 NAME

Class::Adapter - Perl implementation of the Adapter Design Pattern

=head1 DESCRIPTION

The C<Class::Adapter> class is intended as an abstract base class for
creating any sort of class or object that follows the I<Adapter> pattern,
and some that follow the I<Decorator> pattern. (sort of)

=head2 What is an Adapter?

The term I<Adapter> refers to a I<"Design Pattern"> of the same name,
from the famous "Gang of Four" book. Although their original
implementation is designed for Java and similar single-inheritance
strictly-typed langauge, the situation for which it applies is still
valid.

An I<Adapter> in this Perl sense of the term is used to achieve by
composition (objects containing other object) what can't be achieved
by inheritance (sub-classing).

This is similar to the I<Decorator> pattern, but is intended to be
applied primarily on a class-by-class basis, as opposed to being
flexible when used with a single one-off object.

The C<Class::Adapter> object holds a parent object that it "wraps",
and when a method is called on the C<Class::Adapter>, it manually
calls the same (or different) method with the same (or different)
parameters on the parent object contained within it.

Instead of these custom methods being hooked in on an object-by-object
basis, they are defined at the class level.

Basically, a C<Class::Adapter> class/object is your fall-back position
when Perl's inheritance model fails you, or is no longer good enough,
and you need to do something twisty in order to make several APIs play
nicely with each other.

=head2 What can I do with this specific Class::Adapter class

Well actually... nothing.

The base C<Class::Adapter> class doesn't even implement a way to push
method calls through to the underlying object, since the way in which
THAT happens is the bit that changes from case to case.

To actually DO something, you probably want to go take a look at
L<Class::Adapter::Builder>, which makes the creation of I<Adapter>
classes relatively quick and easy.

=head1 METHODS

The C<Class::Adapter> class itself supplies only the two most common
methods, a default constructor and a private method to access the
underlying object.

=cut

use strict;
use Carp         ();
use Scalar::Util ();

use vars qw{$VERSION};
BEGIN {
	$VERSION = '0.02';
}





#####################################################################
# Constructor

=pod

=head2 new $object

The default C<new> constructor takes a single object as argument and
creates a new object which holds the passed object.

Returns a new C<Class::Adapter> object, or C<undef> if you do not pass
in an object.

=cut

sub new {
	my $class  = ref $_[0] ? ref shift : shift;
	my $object = Scalar::Util::blessed($_[0]) ? shift : return undef;
	bless { OBJECT => $object }, $class;
}





#####################################################################
# Private Methods

=pod

=head2 _OBJECT_

The C<_OBJECT_> method is provided primarily as a convenience, and a tool
for people implementing sub-classes, and allows the C<Class::Adapter>
interface to provide a guarenteed correct way of getting to the underlying
object, should you need to do so.

=cut

sub _OBJECT_ {
	return $_[0]->{OBJECT} if ref $_[0];
	Carp::croak('Class::Adapter::_OBJECT_ called as a static method');
}

1;

=pod

=head1 BUGS

It's still early day yet, so you should expect some change throughout
the entire C<Class::Adapter> namespace.

=head1 SUPPORT

Bugs should be reported via the CPAN bug tracker at

L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Class-Adapter>

For other issues, contact the author.

=head1 TO DO

- Write more comprehensive tests

=head1 AUTHOR

Adam Kennedy (Maintainer), L<http://ali.as/>, cpan@ali.as

=head1 SEE ALSO

L<Class::Adapter::Clear>, L<Class::Adapter::Factory>

=head1 COPYRIGHT

Copyright 2005 Adam Kennedy. All rights reserved.
This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
