<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- New User Registration Flow -->

<script type="text/javascript" src='./resources/scripts/registerUser.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register User</title>
</head>
<body>
Username: <input id="Username" type="text" name="Password" size="20"><br>
Password: <input id="Password" type="text" name="Password" size="20"><br>
Repeat Password: <input id="PasswordCheck" type="text" name="Password" size="20"><br>
Phone Number: <input id="PhoneNumber" type="text" name="PhoneNumber" size="20"><br>
Phone Carrier:<select id="PhoneCarrier"  name="PhoneCarrier">
				<option value="Fido">Fido</option>
				<option value="Rogers">Rogers</option>
				<option value="Telus">Telus</option>
				<option value="Bell">Bell</option>
				<option value="Virgin Mobile">Virgin Moblie</option>
				<option value="PC Mobile">PC Moblie</option>
				<option value="Koodo">Koodo</option>
				<option value="SaskTel">SaskTel</option>
				<option value="Manitoba Telecom">Manitoba Telecom</option>
		  	</select><br>
E-mail Address: <input id="EmailAddress" type="text" name="EmailAddress" size="20"><br>

<div id="feedBack"><h2>Feedback Area</h2></div>
<button id='Submit' type="button"  onclick="createUserRequest()">Submit Info</button>

</body>
</html>