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
 
 
Password: <input id="Password" disabled = "true"  type="text" name="Password" size="20"><br>
Phone Number: <input id="PhoneNumber" disabled= "true" type="text" name="PhoneNumber" size="20"><br>
Phone carrier:<select id="PhoneCarrier" disabled= "true" name="PhoneCarrier">
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
E-mail Address: <input id="EmailAddress" disabled= "true" type="text" name="EmailAddress" size="20"><br>

<div id="feedBack"><h2>Feedback Area</h2></div>


<button id='Edit' type="button" OnClick= "editUserInfo()">Edit Info</button>
<button id='Submit' type="button" disabled = "true"  onclick="updateUserRequest()">Submit Info</button>

</body>
</html>