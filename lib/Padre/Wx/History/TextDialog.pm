package Padre::Wx::History::TextDialog;

use 5.008;
use strict;
use warnings;
use Params::Util qw{_INSTANCE};
use Padre::DB    ();
use Padre::Wx    ();

use Class::Adapter::Builder
	ISA      => 'Wx::TextEntryDialog',
	AUTOLOAD => 1;

our $VERSION = '0.32';

sub new {
	my $class  = shift;
	my @params = @_;

	# Instead of using the default value directly search using it
	# as a type value in the database history table.
	my $type   = $params[3];
	$params[3] = Padre::DB::History->previous($type);
	if ( _INSTANCE($params[3], 'Padre::DB::History') ) {
		$params[3] = $params[3]->name;
	}
	unless ( defined $params[3] ) {
		$params[3] = '';
	}

	# Create the object
	my $object = Wx::TextEntryDialog->new( @params );

	# Create the adapter
	my $self = $class->SUPER::new( $object );

	# Remember what we suggested to them
	$self->{type}      = $type;
	$self->{suggested} = $params[3];

	return $self;
}

sub ShowModal {
	my $self = shift;

	# Get the return value as normal
	my $rv = $self->{OBJECT}->ShowModal(@_);
	unless ( $rv == Wx::wxID_OK ) {
		# They hit Cancel
		return $rv;
	}

	# Shortcut return if they didn't enter anything
	my $value = $self->GetValue;
	unless ( defined $value and $value ne '' ) {
		return $rv;
	}

	# If they entered something differen add it to the history.
	unless ( defined $self->{suggested} and $value eq $self->{suggested} ) {
		Padre::DB::History->create(
			type => $self->{type},
			name => $value,
		);
	}

	return $rv;
}

1;

# Copyright 2008-2009 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.
