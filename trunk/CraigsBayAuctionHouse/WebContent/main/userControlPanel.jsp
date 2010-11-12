<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Control Panel</title>
</head>
<body>
 <script>
 loadUserInfo();
</script>
 
 
Password: <input id="Password" disabled="disabled" type="text" name="Password" size="20"><br>
Phone Number: <input id="PhoneNumber" disabled="disabled" type="text" name="PhoneNumber" size="20"><br>
Phone carrier:<select id="PhoneCarrier" disabled="disabled" name="PhoneCarrier">
				<option value="1">Fido</option>
				<option value="2">Rogers</option>
				<option value="3">Telus</option>
				<option value="4">Bell</option>
				<option value="5">Virgin Moblie</option>
				<option value="6">PC Moblie</option>
				<option value="7">Koodo</option>
				<option value="8">SaskTel</option>
				<option value="9">Manitoba Telecom</option>
		  	</select><br>
E-mail Address: <input id="EmailAddress" disabled="disabled" type="text" name="EmailAddress" size="20"><br>

<div id="feedBack"><h2>Feedback Area</h2></div>


<button id='Edit' type="button" onclick="editUserInfo()">Edit Info</button>
<button id='Submit' type="hidden"  onclick="updateUserRequest()">Submit Info</button>

</body>
</html>