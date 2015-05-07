package DeDup;

use 5.018002;
use strict;
use warnings;
use File::Temp;
require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use DeDup ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';
sub new {

my $self = {
        @LINES =();
        %items =();
        $debug =0;
        $fn = "";    
    };
}


sub Debug {
    $debug = @_;
    print("Debugging Level $debug\n") if $debug > 0;
}

sub LoadFile {
    my ($file) = @_;
    if ( !defined $file ) {
        return;
    }
    open( IFP, "$file" ) or die "Can not Open File $file";
    @LINES = ();
    while (<IFP>) {
        chomp;
        push @LINES, $_;
    }
    close IFP;
    print "Number of Lines is " . @LINES . "\n" if ( $debug > 0 );
}

sub DeDuplicate {
    my ( $delimiter, $unique_field_position ) = @_;
    %items = ();    #Hash.... Take care
    foreach my $i (@LINES) {
        my @PARTS = split( "$delimiter", $i );
        print( "Key Value set as " . $PARTS[$unique_field_position] . "\n" )
          if ( $debug > 0 );
        #
        #We have 2 ways we can Store uniqe values
        #   We can check is the value exists.... if it does not then store it
        # Or
        #   Store using the value ... this will overwrite previous Key values
        #
        # I will do the 2nd option as it is simpler !!

	#Store in Hash at position {$PARTS[$unique_field_position]} the whole line
        $items{ $PARTS[$unique_field_position] } = $i ; 

 #
 #if you do not understand this .... then do some simple hash examples/exercises
 #
    }
    print "We have " . keys(%items) . " in the hash now \n" if ( $debug > 0 );
}

sub Output {
    my $v="";
    my $file = tmpnam();
    open(my $OFP, '>', $file)  or die 'Can not open file $file';
    # Output using the hash - but sort on the key value
    foreach $v ( sort keys %items ) {
        print $OFP $items{$v} . "\n";
    }
return $file;
}

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

DeDup - Perl extension for blah blah blah

=head1 SYNOPSIS

  use DeDup;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for DeDup, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

tim, E<lt>tim@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014 by tim

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
