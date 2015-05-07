#!/usr/bin/perl
use strict;
use warnings;
use File::Temp;


my @LINES = ();    #Array..  Simple but dumb
my %items = ();    #Hash.... Take care
my $debug = 0;
my $fn="";

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

######## Test For csv Data 
#
#
########
Debug(1);
print "Starting";
LoadFile("BankAccounts.csv");
DeDuplicate( ',', 0 ) ;    #Use a , and Set the Main Field as Being Field 0 (C Notation)
$fn=Output();
print("De Duplicated data is in $fn");

printf("\n\n\n");
######## Test For * EMail Data 
#
#
########
Debug(1);
print "Starting";
LoadFile("contacts.dat");
DeDuplicate( '\*', 2 ) ;    #Use a , and Set the Main Field as Being Field 0 (C Notation)
$fn=Output();
print("De Duplicated data is in $fn")
