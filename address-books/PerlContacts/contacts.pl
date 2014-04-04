#!/usr/bin/perl
######################################################################
#
# Program:		contacts.pl
# Author:		Micha Methven
# Created:		Sept 19, 2013
# Last Edited:		Sept 24, 2013
# Purpose:	This program will operate as a digital address book
#		allowing the user to display all, search, add, or
#		delete contacts.
#		*********************Note:***************************
#		For readability, subroutines are ordered alphabetical
#		in their respective packages, subroutines use
#		underscore for thier naming convention, and variables
#		use camel notation. Subroutines declaring many
#		variables do so at onset for easier understanding
#		of their use.
#		*****************************************************
######################################################################

use strict;
use warnings;
use diagnostics;

######################################################################
#		**MAIN**
######################################################################

package Main;


Structure::load_file(); # Load contacts

for(;;)
{
	# Welcome banner and main menu
	print ("\n***************************************\n");
	print ("* CONTACTS v1.0 - a Perl address book *\n");
	print ("***************************************\n");
	print ("\nWhat action would you like to perform?\n");
	print ("--------------------------------------\n");
	print ("Display All Contacts\t1\n");
	print ("Search For A Contact\t2\n");
	print ("Add A Contact\t\t3\n");
	print ("Delete A Contact\t4\n");
	print ("Exit Program\t\t5\n");

	my $input = <STDIN>;
	chop ($input);

	if ($input)
	{
		if ($input == 1)
		{
			Structure::contacts_display();
		}
		if ($input == 2)
		{
			Structure::contact_search();
		}
		if ($input == 3)
		{
			Structure::add_contact();
		}
		if ($input == 4)
		{
			Structure::deletion_prompt();
		}
		if ($input == 5)
		{
			last;
		}
	
	}
}


#*********************PACKAGE SEPARATOR*******************************


package Structure; # Contains all subroutines used in main


######################################################################
# Global Variable(s):
######################################################################
our @entries;   # Stores object of type Contact    


######################################################################
# Subroutines:
######################################################################
# Name:		add_contact (subroutine of Structure)
# Purpose:	Creates and validates a new entry into the address
#		book.
######################################################################

sub add_contact
{
	# Declaration of subroutine's local variables
	my $cellNum;		# Contact's cell phone number
	my $city;		# Contact's city
	my $first;		# Contact's first name
	my $homeNum;		# Contact's home phone number
	my $last;		# Contact's last name
	my $state;		# Contact's state
	my $street;		# Contact's street
	my $test;		# Subroutine's test variable
	my $zip;		# Contact's zipcode

	my $entry = new_contact Contact();	# Create new instance of Contact

	# Prompt user to populate attributes for the new contact
	print ("\n------------------------------------------------------------\n");
	print ("Please enter the following attributes for the new contact...");
	print ("\n------------------------------------------------------------\n");

	# Receive value for first name and verify for required format
	print ("First Name:\t(Example: Michael)\n");
	$first = <STDIN>;
	chomp $first;
	$test = is_valid_name($first);
	if ($test ne 0)
	{
		$entry->first_name($test);
	}else
	{
		my $flag = 0;
		while($flag == 0)
		{
			error_message();
			my $newFirst = error_prompt();
			my $test = is_valid_name($$newFirst);

               		if ($test ne 0)
			{
				chomp $test;
				$entry->first_name($test);
				$flag = 1;
			}

			if ($flag == 1)
			{ 
				{last;}
			}
		}
	}

	# Receive value for last name and verify for required format
	print ("Last Name:\t(Example: Jackson)\n");
	$last = <STDIN>;
	chomp $last;
	$test = is_valid_name($last);
	if ($test ne 0)
	{
		$entry->last_name($test);
	}else
	{
		my $flag = 0;
		while ($flag == 0)
		{
			error_message();
			my $newLast = error_prompt();
			my $test = is_valid_name($$newLast);

               		if ($test ne 0)
			{
				chomp $test;
				$entry->last_name($test);
				$flag = 1;
			}

			if ($flag == 1)
			{ 
				{last;}
			}
		}
	}

	# Receive value for home phone number and verify for required format
	print ("Home Phone:\t(Example: 617-555-5555)\n");
	$homeNum = <STDIN>;
	chomp $homeNum;
	$test = is_valid_phonenum($homeNum);
	if ($test ne 0)
	{
		$entry->home_phone($test);
	}else
	{
		my $flag = 0;
		while ($flag == 0)
		{
			error_message();
			my $newHomeNum = error_prompt();
			my $test = is_valid_phonenum($$newHomeNum);

               		if ($test ne 0)
			{
				chomp $test;
				$entry->home_phone($test);
				$flag = 1;
			}

			if ($flag == 1)
			{ 
				{last;}
			}
		}
	}

	# Receive value for cell phone number and verify for required format
	print ("Cell Phone:\t(Example: 617-555-5555)\n");
	$cellNum = <STDIN>;
	chomp $cellNum;
	$test = is_valid_phonenum($cellNum);
	if ($test ne 0)
	{
		$entry->cell_phone($test);
	}else
	{
		my $flag = 0;
		while ($flag == 0)
		{
			error_message();
			my $newcellNum = error_prompt();
			my $test = is_valid_phonenum($$newcellNum);

               		if ($test ne 0)
			{
				chomp $test;
				$entry->cell_phone($test);
				$flag = 1;
			}

			if ($flag == 1)
			{ 
				{last;}
			}
		}
	}

	# Receive value for street number & name then verify for required format
	print ("Street:\t(Example: 123 Washington St)\n");
	$street = <STDIN>;
	chomp $street;
	$test = is_valid_street($street);
	if ($test ne 0)
	{
		$entry->street($test);
	}else
	{
		my $flag = 0;
		while ($flag == 0)
		{
			error_message();
			my $newStreet = error_prompt();
			my $test = is_valid_street($$newStreet);

               		if ($test ne 0)
			{
				chomp $test;
				$entry->street($test);
				$flag = 1;
			}

			if ($flag == 1)
			{ 
				{last;}
			}
		}
	}

	# Receive value for city name and verify for required format
	print ("City:\t(Example: Boston)\n");
	$city = <STDIN>;
	chomp $city;
	$test = is_valid_name($city);
	if ($test ne 0)
	{
		$entry->city($test);
	}else
	{
		my $flag = 0;
		while($flag == 0)
		{
			error_message();
			my $newCity = error_prompt();
			my $test = is_valid_name($$newCity);

			if ($test ne 0)
			{
				chomp $test;
				$entry->city($test);
				$flag = 1;
			}

			if ($flag == 1)
			{ 
				{last;}
			}
		}
	}

	# Receive value for state abbreviation and verify for required format
	print ("State:\t(Example: MA - state abbreviations only)\n");
	$state = <STDIN>;
	chomp $state;
	$test = is_valid_state($state);
	if ($test ne 0)
	{
		$entry->state($test);
	}else
	{
		my $flag = 0;
		while ($flag == 0)
		{
			error_message();
			my $newState = error_prompt();
			my $test = is_valid_state($$newState);

			if ($test ne 0)
			{
				chomp $test;
				$entry->state($test);
				$flag = 1;
			}

			if ($flag == 1)
			{ 
				{last;}
			}
		}
	}

	# Receive value for zipcode and verify for required format
	print ("Zipcode:\t(Example: 01234 or 01234-5678)\n");
	$zip = <STDIN>;
	chomp $zip;
	$test = is_valid_zipcode($zip);
	if ($test ne 0)
	{
		$entry->zipcode($test);
	}else
	{
		my $flag = 0;
		while ($flag == 0)
		{
			error_message();
			my $newzip = error_prompt();
			my $test = is_valid_zipcode($$newzip);

			if ($test ne 0)
			{
				chomp $test;
			
				$entry->zipcode($test);
	 			$flag = 1;
			}

			if ($flag == 1)
			{ 
				{last;}
			}
		}
	}
	push @entries, $entry;
	update_file();
} # End of add_contact subroutine


######################################################################
# Name:		contacts_display (subroutine of Structure)
# Purpose:	This subroutine allows the user to sort contact
#		information based on the attribute of their choice.
######################################################################

sub contacts_display
{
	# Declaration of subroutine's local variables
	my $direction;		# Holds decision - ascending or descending
	my @order;		# Used to display order direction
	my $selection;		# Holds decision - what to order by
	my @sortby;		# Used to display what we are ordering by
	my @sortedContacts;	# Holds list for sorted contacts

	print ("\n********************\n");
	print ("* Display Contacts *\n");
	print ("********************\n");
	print ("\nIn what order should contacts be displayed?\n");
	print ("-------------------------------------------\n");
	print ("First Name\t\t1\n");
	print ("Last Name\t\t2\n");
	print ("Home phone\t\t3\n");
	print ("Cell phone\t\t4\n");
	print ("Street\t\t\t5\n");
	print ("City\t\t\t6\n");
	print ("State\t\t\t7\n");
	print ("Zipcode\t\t\t8\n");
 
	$selection = <STDIN>;

	$sortby[0] = "First Name";
	$sortby[1] = "Last Name";
	$sortby[2] = "Home Phone";
	$sortby[3] = "Cell Phone";
	$sortby[4] = "Street";
	$sortby[5] = "City";
	$sortby[6] = "State";
	$sortby[7] = "Zipcode";

	@order = qw(Ascending Descending);

	print ("\nAscending or descending order:\n");
	print ("------------------------------\n");
	print ("Ascending\t\t1\n");
	print ("Descending\t\t2\n");
	$direction = <STDIN>;

	if ($selection == 1 and $direction == 1)
	{
		@sortedContacts = sort { $a->first_name cmp $b->first_name } @entries;
	}elsif ($selection == 1 and $direction == 2)
	{
		@sortedContacts = sort { $b->first_name cmp $a->first_name } @entries;
	}elsif ($selection == 2 and $direction == 1)
	{
		@sortedContacts = sort { $a->last_name cmp $b->last_name } @entries;
	}elsif ($selection == 2 and $direction == 2)
	{
		@sortedContacts = sort { $b->last_name cmp $a->last_name } @entries;
	}elsif ($selection == 3 and $direction == 1)
	{
		@sortedContacts = sort { $a->home_phone cmp $b->home_phone } @entries;
	}elsif ($selection == 3 and $direction == 2)
	{
		@sortedContacts = sort { $b->home_phone cmp $a->home_phone } @entries;
	}elsif ($selection == 4 and $direction == 1)
	{
		@sortedContacts = sort { $a->cell_phone cmp $b->cell_phone } @entries;
	}elsif ($selection == 4 and $direction == 2)
	{
		@sortedContacts = sort { $b->cell_phone cmp $a->cell_phone } @entries;
	}elsif ($selection == 5 and $direction == 1)
	{
		@sortedContacts = sort { $a->street cmp $b->street } @entries;
	}elsif ($selection == 5 and $direction == 2)
	{
		@sortedContacts = sort { $b->street cmp $a->street } @entries;
	}elsif ($selection == 6 and $direction == 1)
	{
		@sortedContacts = sort { $a->city cmp $b->city } @entries;
	}elsif ($selection == 6 and $direction == 2)
	{
		@sortedContacts = sort { $b->city cmp $a->city } @entries;
	}elsif ($selection == 7 and $direction == 1)
	{
		@sortedContacts = sort { $a->state cmp $b->state } @entries;
	}elsif ($selection == 7 and $direction == 2)
	{
		@sortedContacts = sort { $b->state cmp $a->state } @entries;
	}elsif ($selection == 8 and $direction == 1)
	{
		@sortedContacts = sort { $a->zipcode <=> $b->zipcode } @entries;
	}elsif ($selection == 8 and $direction == 2)
	{
		@sortedContacts = sort { $b->zipcode <=> $a->zipcode } @entries;
	}

	print ("\n----------------------------------------------------------\n");
	print ("Sorting by ", $sortby[$selection-1]," in ",$order[$direction-1]," order\n");
	print ("----------------------------------------------------------\n");

	foreach (@sortedContacts)
	{
		format STDOUT2 = 
----------------------------------------------------------
First Name: @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$_->first_name
Last Name:  @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$_->last_name
Home Phone: @<<<<<<<<<<<<
$_->home_phone
Cell Phone: @<<<<<<<<<<<<
$_->cell_phone
Address:    @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$_->street
	    @<<<<<<<<<<<< @<< @<<<<<<<<<<
$_->city, $_->state, $_->zipcode
----------------------------------------------------------

.
		write;
	}
} # End of contacts_display subroutine


######################################################################
# Name:		contact_finder (subroutine of Structure)
# Purpose:	Called by the contact_search subroutine to verify whether
#		the user's entry and the current contact list have
#		a match. Returns a list of matches.
######################################################################

sub contact_finder
{
	# Declaration of subroutine's local variables
	my @matches;				# Returned as matching result(s)
	my $match = $_[0];			# Holds user's specific choice
	my $selection = $_[1];			# Holds user's choice type

	my $value = new_contact Contact();	# Create new instance of Contact

	chop $match;

	foreach $value (@entries)
	{
		if ($selection == 1)
		{
			if ($value->first_name eq $match)
			{
				push (@matches, $value);
			}
		}elsif ($selection == 2)
		{
			if ($value->last_name eq $match)
			{
				push (@matches,$value);
			}
		}elsif ($selection == 3)
		{
			if ($value->home_phone eq $match)
			{
				push (@matches,$value);
			}
		}elsif ($selection == 4)
		{
			if ($value->cell_phone eq $match)
			{
				push (@matches,$value);
			}
		}elsif ($selection == 5)
		{
			if ($value->street eq $match)
			{
				push (@matches,$value);
			}
		}elsif ($selection == 6)
		{
			if ($value->city eq $match)
			{
				push (@matches,$value);
			}
		}elsif ($selection == 7)
		{
			if ($value->state eq $match)
			{
				push (@matches,$value);
			}
		}elsif ($selection == 8)
		{
			if ($value->zipcode eq $match)
			{
				push (@matches,$value);
			}
		}
	}
	return @matches;
} # End of contact_finder subroutine


######################################################################
# Name:		contact_search (subroutine of Structure)
# Purpose:	Prompts user to enter search criteria which is then
#		processed by the contact_finder subroutine. The results are
#		saved to a local array which is formatted and each
#		result accounted for.
######################################################################

sub contact_search
{
	print ("\n********************\n");
	print ("*  Contact Search  *\n");
	print ("********************\n");
	print ("\nHow would you like to search for contact?\n");
	print ("-----------------------------------------\n");
	print ("First Name\t\t1\n");
	print ("Last Name\t\t2\n");
	print ("Home Phone\t\t3\n");
	print ("Cell Phone\t\t4\n");
	print ("Street\t\t\t5\n");
	print ("City\t\t\t6\n");
	print ("State\t\t\t7\n");
	print ("Zipcode\t\t\t8\n");

	my $selection = <STDIN>;

	print ("\nEnter specifics for this contact:\n");
	print ("---------------------------------\n");
	my $filter = <STDIN>;

	my @found = contact_finder($filter,$selection);

	my $counter = 0;
	foreach (@found)
	{

		format STDOUT = 
----------------------------------------------------------
First Name: @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$_->first_name
Last Name:  @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$_->last_name
Home Phone: @<<<<<<<<<<<<
$_->home_phone
Cell Phone: @<<<<<<<<<<<<
$_->cell_phone
Address:    @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$_->street
	    @<<<<<<<<<<<< @<< @<<<<<<<<<<
$_->city, $_->state, $_->zipcode
----------------------------------------------------------

.
		write;
		$counter++;
	}
	print ("\n** " . $counter . " Match(es) Found **\n\n");
} # End of contact_search subroutine


######################################################################
# Name:		delete_contact (subroutine of Structure)
# Purpose:	Confirms user's selection for deletion and splices
#		the selection from the array of contacts (@entries).
######################################################################

sub delete_contact
{
	# Declaration of subroutine's local variables
	my $match;		# Variable for matching purposes
	my $selection;		# User's selection for deletion
	my $position = 0;	# Positional reference - foreach loop
	my @matches;		# Array holding matches found
	my $answer;		# User's answer to deletion confirmation

	$match = $_[0];
	chop $match;
	$selection = $_[1];
	chop $selection;

	print ("\n");
	foreach (@entries)
	{
		if ($selection == 1)
		{
			if ($_->first_name eq $match)
			{
				$_->show_contact();

				print ("Delete this contact?\n");
				print ("--------------------\n");
				print ("Yes\t\t1\n");
				print ("No\t\t2\n");

				$answer = <STDIN>;

				if ($answer == 1)
				{
					splice (@entries,$position,1);
					print ("\n**Contact Deleted**\n");
				}
		
			}
		}elsif ($selection == 2)
		{
			if ($_->last_name eq $match)
			{
				$_->show_contact();

				print ("Delete this contact?\n");
				print ("--------------------\n");
				print ("Yes\t\t1\n");
				print ("No\t\t2\n");

				$answer = <STDIN>;

				if ($answer == 1)
				{
					splice (@entries,$position,1);
					print ("\n**Contact Deleted**\n");
				}
			}
		}elsif ($selection == 3)
		{
			if ($_->home_phone eq $match)
			{
				$_->show_contact();

				print ("Delete this contact?\n");
				print ("--------------------\n");
				print ("Yes\t\t1\n");
				print ("No\t\t2\n");

				$answer = <STDIN>;

				if ($answer == 1)
				{
					splice (@entries,$position,1);
					print ("\n**Contact Deleted**\n");
				}
			}
		}elsif ($selection == 4)
		{
			if ($_->cell_phone eq $match)
			{
				$_->show_contact();

				print ("Delete this contact?\n");
				print ("--------------------\n");
				print ("Yes\t\t1\n");
				print ("No\t\t 2\n");

				$answer = <STDIN>;

				if ($answer == 1)
				{
					splice (@entries,$position,1);
					print ("\n**Contact Deleted**\n");
				}
			}
		}elsif ($selection == 5)
		{
			if ($_->street eq $match)
			{
				$_->show_contact();

				print ("Delete this contact?\n");
				print ("--------------------\n");
				print ("Yes\t\t1\n");
				print ("No\t\t2\n");

				$answer = <STDIN>;

				if ($answer == 1)
				{
					splice (@entries,$position,1);
					print ("\n**Contact Deleted**\n");
				}
			}
		}elsif ($selection == 6)
		{
			if ($_->city eq $match)
			{
				$_->show_contact();

				print ("Delete this contact?\n");
				print ("--------------------\n");
				print ("Yes\t\t1\n");
				print ("No\t\t2\n");

				$answer = <STDIN>;

				if ($answer == 1)
				{
					splice (@entries,$position,1);
					print ("\n**Contact Deleted**\n");
				}
			}
		}elsif ($selection == 7)
		{
			if ($_->state eq $match)
			{
				$_->show_contact();

				print ("Delete this contact?\n");
				print ("--------------------\n");
				print ("Yes\t\t1\n");
				print ("No\t\t2\n");

				$answer = <STDIN>;

				if ($answer == 1)
				{
					splice (@entries,$position,1);
					print ("\n**Contact Deleted**\n");
				}
			}
		}elsif ($selection == 8)
		{
			if ($_->zipcode eq $match)
			{
				$_->show_contact();

				print ("Delete this contact?\n");
				print ("--------------------\n");
				print ("Yes\t\t1\n");
				print ("No\t\t2\n");

				$answer = <STDIN>;

				if ($answer == 1)
				{
					splice (@entries,$position,1);
					print ("\n**Contact Deleted**\n");
				}
			}
		}
		$position++;
	}
return @matches;
} # End of delete_contact subroutine


######################################################################
# Name:		deletion_prompt (subroutine of Structure)
# Purpose:	Allows the user to delete a contact entry. The user
#		is propmted to enter the attribute to select by and
#		then is requested to enter attribute specifics.
######################################################################

sub deletion_prompt
{
	print ("\n********************\n");
	print ("* Contact Deletion *\n");
	print ("********************\n");
	print ("\nHow would you like to select contact for deletion?\n");
	print ("--------------------------------------------------\n");
	print ("First Name\t\t1\n");
	print ("Last Name\t\t2\n");
	print ("Home Phone\t\t3\n");
	print ("Cell Phone\t\t4\n");
	print ("Street\t\t\t5\n");
	print ("City\t\t\t6\n");
	print ("State\t\t\t7\n");
	print ("Zipcode\t\t\t8\n");
	
	my $selection = <STDIN>;

	print ("\nEnter specifics for this contact:\n");
	print ("---------------------------------\n");
	my $filter = <STDIN>;
	
	delete_contact($filter,$selection);
	update_file();
} # End of deletion_prompt subroutine


######################################################################
# Name:		error_message (subroutine of Structure)
# Purpose:	Prints an error message to screen.
######################################################################

sub error_message
{
	print ("\n\t**Invalid Submission**\n");
} # End of error_message subroutine


######################################################################
# Name:		error_prompt (subroutine of Structure)
# Purpose:	Retreives data from user.
######################################################################

sub error_prompt
{
	print ("**Please Enter Information As Instructed**\n");
	my $input = <STDIN>;
	return \$input;
} # End of error_prompt subroutine


######################################################################
# Name:		load_file (subroutine of Structure)
# Purpose:	Loads a hardcoded file and tokenizes the data using
#		a colon	as the delimiter. It stores all contacts
#		into a data structure for retrieval/modification.
######################################################################

sub load_file
{
	my $loaded = 0;				# Flag for document format check
	open (PWFILE,"addressbook.txt");	# Open filehandler for parsing data

	while (<PWFILE>)
	{
	    	chomp;
		my $loader = new_contact Contact();	# Create new instance of Contact
		my @field = split (":", $_);		# List of parsed data

		# Load all elements of contact taken from file
		$loader->first_name($field[0]);
		$loader->last_name($field[1]);
		$loader->home_phone($field[2]);
		$loader->cell_phone($field[3]);
		$loader->street($field[4]);
		$loader->city($field[5]);
		$loader->state($field[6]);
		$loader->zipcode($field[7]);

		# Check whether fields are properly populated
		if($field[0] and $field[1] and $field[2] and $field[3] and $field[4]and 		$field[5] and $field[6] and $field[7])
		{
			$loaded = 1;
		}else
		{
			$loaded = 0;
		}

		# If properly formatted then push object into array
		if ($loaded == 1)
		{
			push @entries,$loader;
		}
	}
} # End of load_file subroutine


######################################################################
# Name:		update_file (subroutine of Structure)
# Purpose:	This subroutine will sort contact entries by first
#		name and will write the results to file.
######################################################################

sub update_file
{
	my $output = "addressbook.txt";
	open (FH,">$output") || die("Cannot Open File");
	close $output;
	close (FH);

	my @sortedContacts = sort { $a->first_name cmp $b->first_name } @entries;

	foreach (@sortedContacts)
	{
		$_->write_contact();
	}
} # End of update_file subroutine


######################################################################
#	**Validation subroutines of Structure**
#
# Purpose:	Each validation subroutine checks if the given data
#		is in correct format. Flagging follows conventional
#		rules, returns 0 if false.
######################################################################

# Validator for first, last, and city names
sub is_valid_name
{
	my $test = shift;
	if ($test =~ /^[A-Z][a-z]+$/)
	{
		return $&;
	}else
	{
		return 0;
	}
} # End of is_valid_name


# Validator for phone numbers
sub is_valid_phonenum
{
	my $test = shift;
	if ($test =~ /\d{3}-\d{3}-\d{4}/)
	{
		return $&;
	}else
	{
		return 0;
	}
} #End of is_valid_phonenum subroutine


# Validator for state abbreviation
sub is_valid_state
{
	my $test = shift;
	if ($test =~ /(?:A[LKZR]|C[AOT]|D[EC]|F[L]|G[A]|HI|I[DLNA]|K[SY]|LA|M[EDAINSOT]|N[EVHJMYCD]|O[HKR]|PA|RI|S[CD]|T[NX]|UT|V[TA]|W[AVIY])/)
	{
		return $&;
	}else
	{
		return 0;
	}
} # End of is_valid_state


# Validator for street
sub is_valid_street
{
	my $test = shift;
	if ($test =~ /^\d+[\w+\s*]+$/)
	{
		return $&;
	}else
	{
		return 0;
	}
} # End of is_valid_street


# Validator for zipcode
sub is_valid_zipcode
{
	my $test = shift;
	if ($test =~ /(^\d{5}$)|(^\d{5}-\d{4}$)/)
	{
		return $&;
	}else
	{
		return 0;
	}
} #End of is_valid_zipcode subroutine


#*********************PACKAGE SEPARATOR*******************************


package Contact; # Holds all info needed for creating a person


######################################################################
# Subroutines:
######################################################################
# Name:		cell_phone (subroutine of Contact)
# Purpose:	Allows access to contact's cellular phone number.
######################################################################

sub cell_phone
{
	my ($contact, $cellPhone) = @_;
	$contact->{_cell_phone} = $cellPhone if defined($cellPhone);
	return $contact->{_cell_phone};
} #End of cell_phone subroutine


######################################################################
# Name:		city (subroutine of Contact)
# Purpose:	Allows access to contact's city name.
######################################################################

sub city
{
	my ($contact, $city) = @_;
	$contact->{_city} = $city if defined($city);
	return $contact->{_city};
} #End of city subroutine


######################################################################
# Name:		first_name (subroutine of Contact)
# Purpose:	Allows access to contact's first name.
######################################################################

sub first_name
{
	my ($contact, $firstName) = @_;
	$contact->{_first_name} = $firstName if defined($firstName);
	return $contact->{_first_name};
} #End of first_name subroutine


######################################################################
# Name:		home_phone (subroutine of Contact)
# Purpose:	Allows access to contact's home phone number.
######################################################################

sub home_phone
{
	my ($contact, $homePhone) = @_;
	$contact->{_home_phone} = $homePhone if defined($homePhone);
	return $contact->{_home_phone};
} #End of home_phone subroutine


######################################################################
# Name:		last_name (subroutine of Contact)
# Purpose:	Allows access to contact's last name.
######################################################################

sub last_name
{
	my ($contact, $lastName) = @_;
	$contact->{_last_name} = $lastName if defined($lastName);
	return $contact->{_last_name};
} #End of last_name subroutine


######################################################################
# Name:		new_contact (subroutine of Contact)
# Purpose:	Constructor for a new contact.
######################################################################

sub new_contact
{
	my $contact = {
	_first_name => undef,
	_last_name  => undef,
	_home_phone => undef,
	_cell_phone => undef,
	_street     => undef,
	_city       => undef,
	_state      => undef,
	_zipcode    => undef
	};
	bless $contact;
	return $contact;
} #End of new_contact subroutine


######################################################################
# Name:		show_contact (subroutine of Contact)
# Purpose:	During selection for deletion, this allows a
#		formatted print of the chosen contact to verify
#		if the user wants to proceed.
######################################################################

sub show_contact
{
	my ($contact) = @_;

	format CONTACT =
----------------------------------------------------------
First Name: @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$contact->first_name
Last Name:  @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$contact->last_name
Home Phone: @<<<<<<<<<<<<
$contact->home_phone
Cell Phone: @<<<<<<<<<<<<
$contact->cell_phone
Address:    @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$contact->street
	    @<<<<<<<<<<<< @<< @<<<<<<<<<<
$contact->city, $contact->state, $contact->zipcode
----------------------------------------------------------

.
	write;
} #End of show_contact subroutine


######################################################################
# Name:		state (subroutine of Contact)
# Purpose:	Allows access to contact's state abbreviation.
######################################################################

sub state
{
	my ($contact, $state) = @_;
	$contact->{_state} = $state if defined($state);
	return $contact->{_state};
} #End of state subroutine


######################################################################
# Name:		street (subroutine of Contact)
# Purpose:	Allows access to contact's street info.
######################################################################

sub street
{
	my ($contact, $street) = @_;
	$contact->{_street} = $street if defined($street);
	return $contact->{_street};
} #End of street subroutine


######################################################################
# Name:		write_contact (subroutine of Contact)
# Purpose:	Creates a local output stream and writes contact's
#		information to file or dies with error.
######################################################################

sub write_contact
{
	my $output="addressbook.txt";
	open (FH2,">>$output") || die("Cannot Open File");
	my ($contact) = @_;

	#print Person info
	print FH2 ($contact->first_name);
	print FH2 (":");
	print FH2 ($contact->last_name) ;
	print FH2 (":");
	print FH2 ($contact->home_phone);
	print FH2 (":");
	print FH2 ($contact->cell_phone);
	print FH2 (":");
	print FH2 ($contact->street);
	print FH2 (":");
	print FH2 ($contact->city);
	print FH2 (":");
	print FH2 ($contact->state);
	print FH2 (":");
	print FH2 ($contact->zipcode);
	print FH2 ("\n");

	close $output;
	close (FH2);
} #End of write_contact subroutine


######################################################################
# Name:		zipcode (subroutine of Contact)
# Purpose:	Allows access to contact's zipcode.
######################################################################

sub zipcode
{
	my ($contact, $zipcode) = @_;
	$contact->{_zipcode} = $zipcode if defined($zipcode);
	return $contact->{_zipcode};
} #End zipcode subroutine


__END__

=head1 NAME

contacts.pl - a digital address book

=head1 SYNOPSIS

B<contacts.pl>

=head1 DESCRIPTION

B<contacts.pl> interactively allows the user to add, remove, and search contacts
based on the information stored within addressbook.txt. This file makes use of a
delimiter(colon) for easy value extraction.

=head1 AUTHOR

Micha Methven, micha.methven@gmail.com

=cut

