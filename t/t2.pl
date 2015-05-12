#!/usr/bin/perl
use strict;
use warnings;
use lib '~/Dev/perl/DeDup';
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
