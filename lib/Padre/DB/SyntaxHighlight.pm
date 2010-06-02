package Padre::DB::SyntaxHighlight;

# This class will be automatically loaded by Padre::DB,
# Overloading the code already auto-generated by Padre::DB.

use 5.008;
use strict;
use warnings;
use Padre::DB      ();
use Padre::Current ();

our $VERSION = '0.63';

sub set_mime_type {
	my $class     = shift;
	my $mime_type = shift;
	my $module    = shift;

	my $transaction = Padre::Current->main->lock('DB');
	$class->delete(
		'where mime_type = ?', $mime_type,
	);
	$class->create(
		mime_type => $mime_type,
		value     => $module,
	);

	return;
}

1;

__END__

=pod

=head1 NAME

Padre::DB::SyntaxHighlight - Database table to store mime-type to syntax highlighter mapping

=head1 SYNOPSIS

        my @files = Padre::DB::SyntaxHighlight->select(
                'where mime_type = ?', $mime_type,
        );

=head1 DESCRIPTION

This class allows storing in L<Padre>'s database the name of the 
syntax highlighter module.

=head1 PUBLIC METHODS

=head2 Accessors

The following accessors are automatically created by L<ORLite>:

=over 4

=item id()

=item file()

=item position()

=item focus()

=item session()

=back

=head2 Class methods

The following subs are automatically created by L<ORLite>.
Refer to L<ORLite> for more information on them:

=over 4

=item select()

=item count()

=item new()

=item create()

=item insert()

=item delete()

=item truncate()

=back

=head1 COPYRIGHT & LICENSE

Copyright 2008-2010 The Padre development team as listed in Padre.pm.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut

# Copyright 2008-2010 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.
