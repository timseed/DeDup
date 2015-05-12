package DeDup;

use 5.018002;
use strict;
use warnings;
use File::Temp;
require Exporter;
use Data::Dumper;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use DeDup ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = (
    'all' => [
        qw(

          )
    ]
);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(

);

our $VERSION = '0.01';

sub new {
    my $class = shift;

 my $self   = {
    _LINES=> (),    # give $self->{num} the supplied value
    _items => ()  ,  # give $self->{num} the supplied value
    _debug => 0,
    _fn    => ""
    };# give $self->{num} the supplied value

    bless $self, $class;
    #print Dumper($self);
    return $self;
}

sub Debug {
    my ( $self, $newdebug ) = @_;
    $self->{_debug} = $newdebug;
    print("Debugging Level $self->{_debug}\n") if $self->{_debug} > 0;
}

sub LoadFile {
    my ( $self, $file ) = @_;
    if ( !defined $file ) {
        return;
    }
    open( IFP, "$file" ) or die "Can not Open File $file";
    $self->{_LINES} = ();
    while (<IFP>) {
        chomp;
        push @{$self->{_LINES}}, $_;
    }
    close IFP;
    print "Number of Lines is " . $self->{_LINES} . "\n" if ( $self->{_debug} > 0 );
}

sub DeDuplicate {
    my ( $self, $delimiter, $unique_field_position ) = @_;
    my %data=();
    my $i = "";
    foreach $i ( @{$self->{_LINES}} ) {
        my @PARTS = split( "$delimiter", $i );
        print( "Key Value set as " . $PARTS[$unique_field_position] . "\n" )
          if ( $self->{_debug} > 0 );
        #
        #We have 2 ways we can Store uniqe values
        #   We can check is the value exists.... if it does not then store it
        # Or
        #   Store using the value ... this will overwrite previous Key values
        #
        # I will do the 2nd option as it is simpler !!
        #Store in Hash at position {$PARTS[$unique_field_position]} the whole line
        $data{$PARTS[$unique_field_position] } = $i;

 #
 #if you do not understand this .... then do some simple hash examples/exercises
 #
    #print Dumper(\%data);
    %{$self->{_items}} = %data;#Hash.... Take care
    }

#print "We have " . keys($self->items) . " in the hash now \n" if ( $self->debug > 0 );
}

sub Output {
    my ($self) = @_;
    my $v      = "";
    my $file   = tmpnam();
    open( my $OFP, '>', $file ) or die 'Can not open file $file';
    my %data= %{$self->{_items}};
 
   #while( my( $key, $value ) = each %data){
    #     print $OFP  $value ."\n";
    #}

   #Note this is ASCII Sort 
   foreach my $key (sort keys %data) {
        print $OFP $data{$key}. "\n";;
   }
    return $file;
}

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

DeDup - Perl extension for DeDuplicating values in Text files. 


=head2 REQUIREMENTS
This module requires File::Temp 

   perl -MCPAN -eshell install File::Temp


=head1 SYNOPSIS

  use DeDup;
  my $fn="";
  my $dd= new DeDup();
  $dd->LoadFile("BankAccounts.csv");
  $dd->DeDuplicate( ',', 0 ) ;    #Use a , and Set the Main Field as Being Field 0 (C Notation)
  $fn=$dd->Output();
  print("De Duplicated data is in $fn");

=head1 Example
 
	#!/usr/bin/perl
	use strict;
	use warnings;
	use File::Temp;
	use DeDup;
        ######## Test For csv Data 
	#
	#
	########
	my $fn="";
	my $dd= new DeDup();

	$dd->Debug(0);
	print "Starting";
	$dd->LoadFile("BankAccounts.csv");
	$dd->DeDuplicate( ',', 0 ) ;    #Use a , and Set the Main Field as Being Field 0 (C Notation)
	$fn=$dd->Output();
	print("De Duplicated data is in $fn");

	printf("\n\n\n");
	######## Test For * EMail Data 
	#
	#
	########
	print "Starting";
	$dd->LoadFile("contacts.dat");
	$dd->DeDuplicate( '\*', 2 ) ;    #Use a , and Set the Main Field as Being Field 0 (C Notation)
	$fn=$dd->Output();
	print("De Duplicated data is in $fn")


=head1 DESCRIPTION

DeDup assumes that the field you specify as the 
Stub documentation for DeDup, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.


=head1 Initialize

Just call the class like this - there are no needed Parameters

   use DeDup;
   my $dd=new DeDup();

=head1 LoadFile

This method requires a filename. Any Valid File name should work - although I have not tried UTF-8 names.

   LoadFile(FILENAME)
   

Note: If you have Data in Mulitple files... and you want to de-duplicate them you would need to do this

   $dd.LoadFile(FILE1);
   $dd.LoadFile(FILE2);
   $dd.LoadFile(FILE3);

This would add all the files together... I am assuming that their structure is the same .... 


=head1 DeDuplicate


   $dd.DeDuplicate(',',2);     #Use , as delimiter, key is a position 2
   $dd.DeDuplicate('*',1);     #Use * as delimiter, key is a position 1 

This module needs 2 parameters 

=head2 Delimiter
Assumed to be a single character but can be a string. At the moment this will not work as a Reg-Ex.... but it would be quite east to make it work like that.


=head2 Key_Position
Needs to be a interger, specifying which field (using your defintion of a Delimiter) - is to be the index field.

The indexing starts at 0 (C/C++/Python Style)

=head1 Output
Needs no parameters. It will create a temporary output file.... and returns the filename.

   $new_file=$dd.Output();

   ....go do something with new_file

THE ORIGINAL FILE REMAINS UN-TOUCHED

=head2 EXPORT

None by default.


=head1 AUTHOR

tim, E<lt>tim@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014 by tim

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
