#!/usr/bin/python
######################################################################
#
# Program:		contacts.py
# Author:		Micha Methven
# Created:		Oct 4, 2013
# Last Edited:	Oct 21, 2013
# Purpose:		This program will operate as a digital address book
#				allowing the user to display all, search, add, modify
#				or delete contacts.
#		*********************Note:***************************
#		1) Created using Python 2.6.6
#		2) For readability, functions use underscore for the
#		naming convention and variables use camel notation.
#		Functions declaring many variables do so at onset for
#		easier understanding of their use.
#		*****************************************************
# Invocation:	To use this program enter... 
#				contacts.py
#
######################################################################

import os
import pickle

######################################################################
# Name:		Person (class)
# Purpose:	Needed for OOP. Provides a contact's structure and
#			allows for printing or modifying attributes.
######################################################################

class Person:

	#Defines the contact's attributes
	def __init__(self, firstName, lastName, homePhone, cellPhone, street, city, state, zipcode):
		self.firstName = firstName
		self.lastName = lastName
		self.homePhone = homePhone
		self.cellPhone = cellPhone
		self.street = street
		self.city = city
		self.state = state
		self.zipcode = zipcode
        
	#Provides a formatted output for contact attribute information
	def __str__(self):
		return "\nFirst Name:\t{0}\nLast Name:\t{1}\nHome Phone:\t{2}\nCell Phone:\t{3}\nAddress:\t{4}\n\t\t{5}\t{6}\t{7}\n".format(self.firstName, self.lastName, self.homePhone, self.cellPhone, self.street, self.city, self.state, self.zipcode)
        
	#"change_" functions allow for modification of attributes
	def change_firstName(self, firstName):
		self.firstName = firstName
        

	def change_lastName(self, lastName):
		self.lastName = lastName
        

	def change_homePhone(self, homePhone):
		self.homePhone = homePhone
                

	def change_cellPhone(self,cellPhone):
		self.cellPhone = cellPhone


	def change_street(self, street):
		self.street = street


	def change_city(self, city):
		self.city = city


	def change_state(self, state):
		self.state = state


	def change_zipcode(self, zipcode):
		self.zipcode = zipcode


######################################################################
# Name:		add_contact
# Purpose:	Creates a new entry into the address book.
######################################################################

def add_contact():

	addressbook = open("addressbook","r")
	emptyFile = os.path.getsize("addressbook") == 0

	if not emptyFile:
		contactsList = pickle.load(addressbook)
	else:
		contactsList = []
	try:
		contact = info_prompt()
		addressbook = open("addressbook","w")
		contactsList.append(contact)
		contactsList = sorted(contactsList, key=lambda Person: (Person.lastName, Person.firstName))
		pickle.dump(contactsList,addressbook)
		print "\n***Added contact to address book.***"

	except EOFError:
		print "\n***EOF Error occurred***\n"
	except KeyboardInterrupt:
		print "\n***KeyboardInterrupt occurred***\n"

	finally:
		addressbook.close()


######################################################################
# Name:		delete_contact
# Purpose:	Allows the user to delete a specified contact.
######################################################################

def delete_contact():

	addressbook = open("addressbook","r")
	deletedContact = False
	emptyFile = os.path.getsize("addressbook") == 0

	if not emptyFile:
		print "\n********************"
		print "* Contact Deletion *"
		print "********************"
		print "\nHow would you like to select contact for deletion?"
		print "--------------------------------------------------"
		print "First Name\t\t1"
		print "Last Name\t\t2"
		print "Home Phone\t\t3"
		print "Cell Phone\t\t4"
		print "Street\t\t\t5"
		print "City\t\t\t6"
		print "State\t\t\t7"
		print "Zipcode\t\t\t8\n"

		selection = input()

		if (selection == 1):
			delFirstName = raw_input("\nEnter the first name to be searched for and deleted:\n")
			contactsList = pickle.load(addressbook)
			for index in range(0,len(contactsList)):
				contact = contactsList[index]
				if contact.firstName == delFirstName:
					print contact
					print "Proceed with deletion?"
					print "----------------------"
					print "Yes\t\t1"
					print "No\t\t2"
					choice = input()
					if (choice == 1):
						del contactsList[index]
						deletedContact = True
						print "\n***Contact deleted from address book.***"
						addressbook = open("addressbook","w")
						if(len(contactsList) == 0):
							addressbook.write("")
						else:
							pickle.dump(contactsList, addressbook)
							break
					else:
						deletedContact = True
		elif (selection == 2):
			delLastName = raw_input("\nEnter the last name to be searched for and deleted:\n")
			contactsList = pickle.load(addressbook)
			for index in range(0,len(contactsList)):
				contact = contactsList[index]
				if contact.lastName == delLastName:
					print contact
					print "Proceed with deletion?"
					print "----------------------"
					print "Yes\t\t1"
					print "No\t\t2"
					choice = input()
					if (choice == 1):
						del contactsList[index]
						deletedContact = True
						print "\n***Contact deleted from address book.***"
						addressbook = open("addressbook","w")
						if(len(contactsList) == 0):
							addressbook.write("")
						else:
							pickle.dump(contactsList, addressbook)
							break
					else:
						deletedContact = True
		elif (selection == 3):
			delHomePhone = raw_input("\nEnter the home phone number to be searched for and deleted:\n")
			contactsList = pickle.load(addressbook)
			for index in range(0,len(contactsList)):
				contact = contactsList[index]
				if contact.homePhone == delHomePhone:
					print contact
					print "Proceed with deletion?"
					print "----------------------"
					print "Yes\t\t1"
					print "No\t\t2"
					choice = input()
					if (choice == 1):
						del contactsList[index]
						deletedContact = True
						print "\n***Contact deleted from address book.***"
						addressbook = open("addressbook","w")
						if(len(contactsList) == 0):
							addressbook.write("")
						else:
							pickle.dump(contactsList, addressbook)
							break
					else:
						deletedContact = True
		elif (selection == 4):
			delCellPhone = raw_input("\nEnter the cell phone number to be searched for and deleted:\n")
			contactsList = pickle.load(addressbook)
			for index in range(0,len(contactsList)):
				contact = contactsList[index]
				if contact.cellPhone == delCellPhone:
					print contact
					print "Proceed with deletion?"
					print "----------------------"
					print "Yes\t\t1"
					print "No\t\t2"
					choice = input()
					if (choice == 1):
						del contactsList[index]
						deletedContact = True
						print "\n***Contact deleted from address book.***"
						addressbook = open("addressbook","w")
						if(len(contactsList) == 0):
							addressbook.write("")
						else:
							pickle.dump(contactsList, addressbook)
							break
					else:
						deletedContact = True
		elif (selection == 5):
			delStreet = raw_input("\nEnter the street address to be searched for and deleted:\n")
			contactsList = pickle.load(addressbook)
			for index in range(0,len(contactsList)):
				contact = contactsList[index]
				if contact.street == delStreet:
					print contact
					print "Proceed with deletion?"
					print "----------------------"
					print "Yes\t\t1"
					print "No\t\t2"
					choice = input()
					if (choice == 1):
						del contactsList[index]
						deletedContact = True
						print "\n***Contact deleted from address book.***"
						addressbook = open("addressbook","w")
						if(len(contactsList) == 0):
							addressbook.write("")
						else:
							pickle.dump(contactsList, addressbook)
							break
					else:
						deletedContact = True
		elif (selection == 6):
			delCity = raw_input("\nEnter the city to be searched for and deleted:\n")
			contactsList = pickle.load(addressbook)
			for index in range(0,len(contactsList)):
				contact = contactsList[index]
				if contact.city == delCity:
					print contact
					print "Proceed with deletion?"
					print "----------------------"
					print "Yes\t\t1"
					print "No\t\t2"
					choice = input()
					if (choice == 1):
						del contactsList[index]
						deletedContact = True
						print "\n***Contact deleted from address book.***"
						addressbook = open("addressbook","w")
						if(len(contactsList) == 0):
							addressbook.write("")
						else:
							pickle.dump(contactsList, addressbook)
							break
					else:
						deletedContact = True
		elif (selection == 7):
			delState = raw_input("\nEnter the state to be searched for and deleted:\n")
			contactsList = pickle.load(addressbook)
			for index in range(0,len(contactsList)):
				contact = contactsList[index]
				if contact.state == delState:
					print contact
					print "Proceed with deletion?"
					print "----------------------"
					print "Yes\t\t1"
					print "No\t\t2"
					choice = input()
					if (choice == 1):
						del contactsList[index]
						deletedContact = True
						print "\n***Contact deleted from address book.***"
						addressbook = open("addressbook","w")
						if(len(contactsList) == 0):
							addressbook.write("")
						else:
							pickle.dump(contactsList, addressbook)
							break
					else:
						deletedContact = True
		elif (selection == 8):
			delZipcode = raw_input("\nEnter the zipcode to be searched for and deleted:\n")
			contactsList = pickle.load(addressbook)
			for index in range(0,len(contactsList)):
				contact = contactsList[index]
				if contact.zipcode == delZipcode:
					print contact
					print "Proceed with deletion?"
					print "----------------------"
					print "Yes\t\t1"
					print "No\t\t2"
					choice = input()
					if (choice == 1):
						del contactsList[index]
						deletedContact = True
						print "\n***Contact deleted from address book.***"
						addressbook = open("addressbook","w")
						if(len(contactsList) == 0):
							addressbook.write("")
						else:
							pickle.dump(contactsList, addressbook)
							break
					else:
						deletedContact = True
		else:
			print "\n***Invalid Selection***"

		if not deletedContact:
			print "\n***No match(es) found for deletion.***"

	else:
		print "\n***Your address book is empty. Nothing to delete.***"

	addressbook.close()


######################################################################
# Name:		display_contacts
# Purpose:	Displays contacts in the address book.
######################################################################

def display_contacts():

	addressbook = open("addressbook","r")
	emptyFile = os.path.getsize("addressbook") == 0

	if not emptyFile:
		contactsList = pickle.load(addressbook)
		contactsList = sorted(contactsList, key=lambda Person: (Person.lastName, Person.firstName))
		for contact in contactsList:
			print contact
	else:
		print "\n***Your address book is empty.***"
		return

	addressbook.close()


######################################################################
# Name:		do_modification
# Purpose:	Provides the actual modification for modify_contact.
######################################################################

def do_modification(contact):

	try:
		while True:
			print "\nWhat would you like to modify?"
			print "-------------------------------"
			print "First Name\t\t1"
			print "Last Name\t\t2"
			print "Home Phone\t\t3"
			print "Cell Phone\t\t4"
			print "Street\t\t\t5"
			print "City\t\t\t6"
			print "State\t\t\t7"
			print "Zipcode\t\t\t8\n"

			selection = input()

			if (selection == 1):
				newFirstName = raw_input("\nEnter new first name:\n")
				contact.change_firstName(newFirstName)
				break
			elif (selection == 2):
				newLastName = raw_input("\nEnter new last name:\n")
				contact.change_lastName(newLastName)
				break
			elif (selection == 3):
				newHomePhone = raw_input("\nEnter new home phone number:\n")
				contact.change_homePhone(newHomePhone)
				break
			elif (selection == 4):
				newCellPhone = raw_input("\nEnter new cell phone number:\n")
				contact.change_cellPhone(newCellPhone)
				break
			elif (selection == 5):
				newStreet = raw_input("\nEnter new street address:\n")
				contact.change_street(newStreet)
				break
			elif (selection == 6):
				newCity = raw_input("\nEnter new city name:\n")
				contact.change_city(newCity)
				break
			elif (selection == 7):
				newState = raw_input("\nEnter new state:\n")
				contact.change_state(newState)
				break
			elif (selection == 8):
				newZipcode = raw_input("\nEnter new zipcode:\n")
				contact.change_zipcode(newZipcode)
				break
			else:
				print "\n***Invalid Selection***"

	except EOFError:
		print "\n***EOF Error occurred***\n"
	except KeyboardInterrupt:
		print "\n***KeyboardInterrupt occurred***\n"


######################################################################
# Name:		info_prompt
# Purpose:	Collects info for add_contact.
######################################################################

def info_prompt():

	try:
		contactFirstName = raw_input("Enter contact's first name:\n")
		contactLastName = raw_input("Enter contact's last name:\n")
		contactHomePhone = raw_input("Enter contact's home phone number:\n")
		contactCellPhone = raw_input("Enter contact's cell phone number:\n")
		contactStreet = raw_input("Enter contact's street address:\n")
		contactCity = raw_input("Enter contact's city:\n")
		contactState = raw_input("Enter contact's state:\n")
		contactZipcode = raw_input("Enter contact's zipcode:\n")

		contact = Person(contactFirstName, contactLastName, contactHomePhone, contactCellPhone, contactStreet, contactCity, contactState, contactZipcode)

		return contact

	except EOFError:
		print "\n***EOF Error occurred***\n"
	except KeyboardInterrupt:
		print "\n***KeyboardInterrupt occurred***\n"


######################################################################
# Name:		modify_contact
# Purpose:	Allows the user to modify a specified contact.
######################################################################

def modify_contact():

	addressbook = open("addressbook","r")
	emptyFile = os.path.getsize("addressbook") == 0
	modifiedContact = False

	if not emptyFile:
		print "\n********************"
		print "*  Modify Contact  *"
		print "********************"
		print "\nHow would you like to select contact for modification?"
		print "------------------------------------------------------"
		print "First Name\t\t1"
		print "Last Name\t\t2"
		print "Home Phone\t\t3"
		print "Cell Phone\t\t4"
		print "Street\t\t\t5"
		print "City\t\t\t6"
		print "State\t\t\t7"
		print "Zipcode\t\t\t8\n"

		selection = input()

		if (selection == 1):
			modFirstName = raw_input("\nEnter the first name of the contact to be modified:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				if contact.firstName == modFirstName:
					do_modification(contact)
					addressbook = open("addressbook","w")
					pickle.dump(contactsList,addressbook)
					modifiedContact = True
					print "\n***Contact in address book was modified.***"
		elif (selection == 2):
			modLastName = raw_input("\nEnter the last name of the contact to be modified:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				if contact.lastName == modLastName:
					do_modification(contact)
					addressbook = open("addressbook","w")
					pickle.dump(contactsList,addressbook)
					modifiedContact = True
					print "\n***Contact in address book was modified.***"
		elif (selection == 3):
			modHomePhone = raw_input("\nEnter the home phone number of the contact to be modified:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				if contact.homePhone == modHomePhone:
					do_modification(contact)
					addressbook = open("addressbook","w")
					pickle.dump(contactsList,addressbook)
					modifiedContact = True
					print "\n***Contact in address book was modified.***"
		elif (selection == 4):
			modCellPhone = raw_input("\nEnter the cell phone number of the contact to be modified:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				if contact.cellPhone == modCellPhone:
					do_modification(contact)
					addressbook = open("addressbook","w")
					pickle.dump(contactsList,addressbook)
					modifiedContact = True
					print "\n***Contact in address book was modified.***"
		elif (selection == 5):
			modStreet = raw_input("\nEnter the street address of the contact to be modified:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				if contact.street == modStreet:
					do_modification(contact)
					addressbook = open("addressbook","w")
					pickle.dump(contactsList,addressbook)
					modifiedContact = True
					print "\n***Contact in address book was modified.***"
		elif (selection == 6):
			modCity = raw_input("\nEnter the city name of the contact to be modified:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				if contact.city == modCity:
					do_modification(contact)
					addressbook = open("addressbook","w")
					pickle.dump(contactsList,addressbook)
					modifiedContact = True
					print "\n***Contact in address book was modified.***"
		elif (selection == 7):
			modState = raw_input("\nEnter the state of the contact to be modified:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				if contact.state == modState:
					do_modification(contact)
					addressbook = open("addressbook","w")
					pickle.dump(contactsList,addressbook)
					modifiedContact = True
					print "\n***Contact in address book was modified.***"
		elif (selection == 8):
			modZipcode = raw_input("\nEnter the zipcode of the contact to be modified:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				if contact.zipcode == modZipcode:
					do_modification(contact)
					addressbook = open("addressbook","w")
					pickle.dump(contactsList,addressbook)
					modifiedContact = True
					print "\n***Contact in address book was modified.***"
		else:
			print "\n***Invalid Selection***"

		if not modifiedContact:
			print "\n***No match(es) found for modification.***"

	else:
		print "\n***Your address book is empty. Nothing to modify.***"

	addressbook.close()


######################################################################
# Name:		search_contact
# Purpose:	Allows the user to search for a specified contact.
######################################################################

def search_contact():
	
	foundContact = False
	addressbook = open("addressbook","r")
	emptyFile = os.path.getsize("addressbook") == 0

	if emptyFile:
		print "\n***Your address book is empty.***"
	else:
		print "\n********************"
		print "*  Contact Search  *"
		print "********************"
		print "\nHow would you like to search for contact?"
		print "-----------------------------------------"
		print "First Name\t\t1"
		print "Last Name\t\t2"
		print "Home Phone\t\t3"
		print "Cell Phone\t\t4"
		print "Street\t\t\t5"
		print "City\t\t\t6"
		print "State\t\t\t7"
		print "Zipcode\t\t\t8\n"

		selection = input()

		if (selection == 1):
			searchFirstName = raw_input("\nEnter first name to search by:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				contactFirstName = contact.firstName
				searchFirstName = searchFirstName.lower()
				contactFirstName = contactFirstName.lower()
				if(contactFirstName == searchFirstName):
					print contact
					foundContact = True
		elif (selection == 2):
			searchLastName = raw_input("\nEnter last name to search by:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				contactLastName = contact.lastName
				searchLastName = searchLastName.lower()
				contactLastName = contactLastName.lower()
				if(contactLastName == searchLastName):
					print contact
					foundContact = True
		elif (selection == 3):
			searchHomePhone = raw_input("\nEnter home phone number to search by:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				contactHomePhone = contact.homePhone
				if(contactHomePhone == searchHomePhone):
					print contact
					foundContact = True
		elif (selection == 4):
			searchCellPhone = raw_input("\nEnter cell phone number to search by:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				contactCellPhone = contact.cellPhone
				if(contactCellPhone == searchCellPhone):
					print contact
					foundContact = True
		elif (selection == 5):
			searchStreet = raw_input("\nEnter street address to search by:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				contactStreet = contact.street
				if(contactStreet == searchStreet):
					print contact
					foundContact = True
		elif (selection == 6):
			searchCity = raw_input("\nEnter city to search by:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				contactCity = contact.city
				searchCity = searchCity.lower()
				contactCity = contactCity.lower()
				if(contactCity == searchCity):
					print contact
					foundContact = True
		elif (selection == 7):
			searchState = raw_input("\nEnter state to search by:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				contactState = contact.state
				if(contactState == searchState):
					print contact
					foundContact = True
		elif (selection == 8):
			searchZipcode = raw_input("\nEnter zipcode to search by:\n")
			contactsList = pickle.load(addressbook)
			for contact in contactsList:
				contactZipcode = contact.zipcode
				if(contactZipcode == searchZipcode):
					print contact
					foundContact = True
		else:
			print "\n***Invalid Selection***"
	
	if not foundContact:
		print "\n***No Match(es) Found***"

	addressbook.close()


######################################################################
#		**MAIN**
######################################################################

# Welcome banner and main menu
while True:
	print "\n*****************************************"
	print "* CONTACTS v1.0 - a Python address book *"
	print "*****************************************"
	print "\nWhat action would you like to perform?"
	print "--------------------------------------"
	print "Display All Contacts\t1"
	print "Search For A Contact\t2"
	print "Add A Contact\t\t3"
	print "Modify A Contact\t4"
	print "Delete A Contact\t5"
	print "Exit Program\t\t6\n"

	selection = input()

	if selection == 1:
		display_contacts()
	elif (selection == 2):
		search_contact()
	elif (selection == 3):
		add_contact()
	elif (selection == 4):
		modify_contact()
	elif (selection == 5):
		delete_contact()
	elif (selection == 6):
		break
	else:
		print "***Invalid Selection***"
