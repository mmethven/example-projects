  This project was completed using WAMP Server. The following information is meant to assist in setting up your MySQL database for use with the "contacts.php" file. The instructions assume you have WAMP installed (or equivalent) and have not made any modifications to the original install.

How To set up your MySQL database:
---------------------------------
1) Make sure WAMPSERVER is up and running (v2.4 used for this project)

2) Open MySQL console

3) Press 'Enter' when requested for password
	- null value is default

(NOTE: If you only allow specific users to access MySQL or have enacted a password, you will need to alter information within the code. On line 37 in "contacts.php", replace "root" with the appropriate user and the empty quotes to the right with your password. This should resolve any access issues you may come across due to personalization of MySQL.)

4) At the mysql> prompt enter:

	CREATE DATABASE addressbook;

5) After creating the database you must select it to add a table, at the mysql> prompt enter:

	USE addressbook;

6) Now that you have selected the correct database you must create a table, at the mysql> prompt enter:

CREATE TABLE IF NOT EXISTS `contactlist` (
`id` int(5) NOT NULL auto_increment,
`firstname` varchar(30) default NULL,
`lastname` varchar(30) default NULL,
`homephone` varchar(20) default NULL,
`cellphone` varchar(20) default NULL,
`email` varchar(30) default NULL,
PRIMARY KEY (`id`)
);

7) Your database should now have a table to store values. You can populate your table by inserting the following at the mysql> prompt:

INSERT INTO `contactlist` (`firstname`, `lastname`, `homephone`, `cellphone`, `email`) VALUES
('Adam', 'West', '978-555-0000', '978-444-1111', 'adamw@major.com'),
('Timmothy', 'Whatsit', '508-555-5038', '508-444-4927', 'timwho@lostnfound.edu'),
('Greg', 'Farney', '708-323-7467', '708-232-7467', 'gfarney@myloc.com'),
('Santa', 'Clause', '888-555-1337', '888-444-7331', 'santa@northpole.org'),
('Bob', 'Baker', '781-555-2345', '781-444-3456', 'boba@tophill.net'),
('John', 'Doe', '617-444-3849', '617-333-3849', 'jd@somewhere.org'),
('Jane', 'Smith', '508-321-0987', '508-123-7890', 'janie@overthere.com'),
('Willy', 'Mammoth', '978-645-3289',  '978-546-9823','willy@elephantsrus.com'),
('Obi', 'Wan', '084-336-7230', '048-633-0327', 'ben@lightside.force');

8) Your database now contains a table called "contactlist" which stores the contacts for testing puposes. Entries may be added, altered or removed as the user sees fit.

9) Now you may access "contacts.php" via WAMPSERVER!!

	***Thanks for checking out PHP+MySQL Contacts v1.0***