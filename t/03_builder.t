#!/usr/bin/perl

# Main testing for Class::Adapter::Builder

use strict;
BEGIN {
	$|  = 1;
	$^W = 1;
}

use Test::More tests => 4;
use Scalar::Util 'refaddr';
use Class::Adapter::Builder ();

sub string_is {
	my @left  = split /\n/, shift;
	my @right = split /\n/, shift;
	is_deeply( \@left, \@right, @_ );
}

# Manually implement the Class::Adapter::Clear class
my $clear1 = Class::Adapter::Builder->new( 'My::Clear' );
isa_ok( $clear1, 'Class::Adapter::Builder' );
ok( $clear1->set_ISA( '_OBJECT_' ), '->set_ISA(_OBJECT_) returns true' );
ok( $clear1->set_AUTOLOAD(1), '->set_AUTOLOAD() returns true' );

# Check the resulting code
string_is( $clear1->make_class, <<'END_CLEAR', '->make_class matches expected code' );
package My::Clear;

# Generated by Class::Abstract::Builder

use strict;
use Carp ();
use Class::Adapter ();

BEGIN {
	@My::Clear::ISA = 'Class::Adapter';
}

sub isa {
	shift->_OBJECT_->isa(@_);
}

sub can {
	shift->_OBJECT_->can(@_);
}

sub AUTOLOAD {
	my $self     = shift;
	my ($method) = $My::Clear::AUTOLOAD =~ m/^.*::(.*)$/s;
	unless ( ref($self) ) {
		Carp::croak(
			  qq{Can't locate object method "$method" via package "$self" }
			. qq{(perhaps you forgot to load "$self")}
		);
	}
	$self->_OBJECT_->$method(@_);
}

sub DESTROY {
	if ( defined $_[0]->{OBJECT} and $_[0]->{OBJECT}->can('DESTROY') ) {
		$_[0]->{OBJECT}->DESTROY;
	}
	delete $_[0]->{OBJECT};
}

1;
END_CLEAR
