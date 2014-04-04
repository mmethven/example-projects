<!--
######################################################################
# Program:		contacts.php
# Author:		Micha Methven
# Created:		Oct 23, 2013
# Last Edited:	Nov 1, 2013
#*********************************************************************
# Purpose:		This program will operate as a digital address
#				book allowing the user to view all contacts,
#				edit/remove contacts, and add contacts via web
#				browser.
#*********************************************************************
# Invocation:	To use this program make sure you have WAMP
# 				installed and running. Then simply follow the
#				directions in the "ReadMe.txt" file. Afterwards,
#				you may open the "contacts.php" file with WAMPSERVER.
######################################################################
-->
<html>
<head>
<title>PHP+MySQL Contacts v1.0</title>
<style>
<!-- Pre-formats tables to standardize the look of the program -->
body{font-family:Arial, Helvetica, sans-serif;font-size:12px;}
table.tableStyleClass{border-collapse:collapse;border:1px solid #A9E2F3;background-color:#A9D0F5;width:650px;font-family:Arial, Helvetica, sans-serif;font-size:12px;}
table.tableStyleClassTwo{border-collapse:collapse;border:1px solid #A9E2F3;background-color:#A9E2F3;width:500px;font-family:Arial, Helvetica, sans-serif;font-size:12px;}
th{background-color:#0080FF;color:#000000;margin:1px;}
td{border-right:1px solid #A9E2F3;padding:2px;text-align:center;}
.oddClassStyle{background-color:#ffffff;border-bottom:1px solid #A9E2F3;}
.evenClassStyle{background-color:#A9D0F5;border-bottom:1px solid #A9E2F3;}
</style>
</head>
<body>

<?php
//Connects to MySQL database
mysql_connect("localhost", "root", "") or die(mysql_error());
mysql_select_db("addressbook") or die(mysql_error());

//Sets value for $mode, used by switch statement
$mode = '';
if(isset($_GET['mode']))
{
	$mode = $_GET['mode'];
}

//Switch statement allows adding, editing, and removing contacts... default case shows contact list
switch($mode)
{
	//Create a form for adding a contact
	case 'add':
?>
	
		<form name="form1" action="<?=$_SERVER['PHP_SELF'];?>?mode=added" method="post">
		<table class="tableStyleClassTwo">
		<tr>
		<td colspan="4" align="center">Add Contact</td>
		</tr>
		<tr>
		<td width="85">First Name:</td><td><div align="left"><input type="text" name="firstname" /></div></td>
		<td width="85">Last Name:</td><td><div align="left"><input type="text" name="lastname" /></div></td>
		</tr>
		<tr>
		<td width="85">Home Phone:</td><td><div align="left"><input type="text" name="homephone" /></div></td>
		<td width="85">Cell Phone:</td><td><div align="left"><input type="text" name="cellphone" /></div></td>
		</tr>
		<tr>
		<td width="85">Email:</td><td><div align="left"><input type="text" name="email" /></div></td>
		</tr>
		<tr>
		<td colspan="4" align="center"><a href="javascript:history.go(-1);">Back</a> | <input name="Submit" type="submit" id="Submit" value="Add" /></td>
		</tr>
		<input type="hidden" name="mode" value="added">
		</table>
		</form>
	
<?php
		break;

	//Use form entries and add to database
	case 'added':
		//Variable declaration
		$firstname = $_POST['firstname'];
		$lastname = $_POST['lastname'];
		$homephone = $_POST['homephone'];
		$cellphone = $_POST['cellphone'];
		$email = $_POST['email'];
		$sql = "INSERT INTO contactlist (firstname, lastname, homephone, cellphone, email) VALUES ('" . $firstname . "','" . $lastname . "','" . $homephone . "','" . $cellphone . "','" . $email . "')";
		//Send insert command to database with user's entries
		mysql_query($sql);
		//Return to main page
		header('location: ' . $_SERVER['PHP_SELF']);
		break;

	//Create a form for editing a contact
	case 'edit':
?>

		<form name="form1" action="<?=$_SERVER['PHP_SELF'];?>?mode=edited" method="post">
		<table class="tableStyleClassTwo">
		<tr>
		<td colspan="4" align="center">Edit Contact</td>
		</tr>
		<tr>
		<td width="85">First Name:</td><td><div align="left"><input type="text" value="<?=$_GET['firstname'];?>" name="firstname" /></div></td>
		<td width="85">Last Name:</td><td><div align="left"><input type="text" value="<?=$_GET['lastname'];?>" name="lastname" /></div></td>
		</tr>
		<tr>
		<td width="85">Home Phone:</td><td><div align="left"><input type="text" value="<?=$_GET['homephone'];?>" name="homephone" /></div></td>
		<td width="85">Cell Phone:</td><td><div align="left"><input type="text" value="<?=$_GET['cellphone'];?>" name="cellphone" /></div></td>
		</tr>
		<tr>
		<td width="85">Email:</td><td><div align="left"><input type="text" value="<?=$_GET['email'];?>" name="email" /></div></td>
		</tr>
		<tr>
		<td colspan="4" align="center"><a href="javascript:history.go(-1);">Back</a> |<input name="Submit" type="submit" value="Save" /></td>
		</tr>
		<input type="hidden" name="mode" value="edited">
		<input type="hidden" name="id" value="<?=$_GET['id'];?>">
		</table>
		</form>

<?php
	break;

	//Use form entries and modify contact info within the database
	case 'edited':
		//Variable declaration
		$firstname = $_POST['firstname'];
		$lastname = $_POST['lastname'];
		$homephone = $_POST['homephone'];
		$cellphone = $_POST['cellphone'];
		$email = $_POST['email'];
		$id = $_POST['id'];
		$sql = "UPDATE contactlist SET firstname = '" . $firstname ."', lastname = '" . $lastname ."', homephone = '" . $homephone . "', cellphone = '" . $cellphone . "', email = '" . $email . "' WHERE id = '" . $id . "'";
		//Send update command to database with user's entries
		mysql_query($sql);
		//Return to main page
		header('location: ' . $_SERVER['PHP_SELF']);
		break;

	//Remove contact from database
	case 'remove':
		//Variable declaration
		$id = $_GET['id'];
		$sql = "DELETE FROM contactlist WHERE id = '" . $id ."'";
		//Send delete command to database with user's entries
		mysql_query($sql);
		//Return to main page
		header('location: ' . $_SERVER['PHP_SELF']);
		break;

	//Default case shows the list of contacts on the "main page"
	default:
		//Variable declaration
		$sql = "SELECT * FROM contactlist ORDER BY firstname ASC";
		$data = mysql_query($sql);
		$rowColor = 0;
?>

		<table class="tableStyleClass">
		<tr>
		<th align="center" colspan="7">PHP+MySQL Contacts v1.0<div align="center"><a href="<?=$_SERVER['PHP_SELF'];?>?mode=add"?mode=add>Add Contact</a></div></th>
		</tr>
		<tr>
		<th width="75">First Name</th><th width="100">Last Name</th><th width="100">Home Phone</th><th width="100">Cell Phone</th><th width="175">Email</th><th width="100" colspan="2">Modification</th>
		</tr>
	
<?php
		//While loop for displaying contacts in a standardized format
		while($info = mysql_fetch_array( $data ))
		{
			if($rowColor == 0)
			{
?>

				<tr class="oddClassStyle">
		
<?php
				$rowColor = 1;
			}elseif($rowColor == 1)
			{
?>

				<tr class="evenClassStyle">
		
<?php
				$rowColor = 0;
			}
?>

			<td><?=$info['firstname'];?></td>
			<td><?=$info['lastname'];?></td>
			<td><?=$info['homephone'];?></td>
			<td><?=$info['cellphone'];?></td>
			<td><a href=mailto:"<?=$info['email'];?>"><?=$info['email'];?></a></td>
			<td><a href="<?=$_SERVER['PHP_SELF'];?>?id=<?=$info['id'];?>&firstname=<?=$info['firstname'];?>&lastname=<?=$info['lastname'];?>&homephone=<?=$info['homephone'];?>&cellphone=<?=$info['cellphone'];?>&email=<?=$info['email'];?>&mode=edit">Edit</a></td>
			<td><a href="<?=$_SERVER['PHP_SELF'];?>?id=<?=$info['id'];?>&mode=remove">Remove</a></td>
			</tr>
	
<?php
		}//End of while loop displaying contacts
?>

		</table>
	
<?php
		break;
}//End of switch statement
?>

</body>
</html>