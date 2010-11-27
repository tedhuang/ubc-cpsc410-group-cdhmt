function createUserRequest()
{
	var Username = document.getElementById("Username").value;
	var Password = document.getElementById("Password").value;
	var PasswordCheck = document.getElementById("PasswordCheck").value;
	var PhoneNumber = document.getElementById("PhoneNumber").value;
	var PhoneCarrier = document.getElementById("PhoneCarrier").value;
	var EmailAddress= document.getElementById("EmailAddress").value;
	
	//Initial user input validation
	if(Username == "Guest"){
		alert("Username cannot be Guest");
		return;
	}
	if(Username == ""){
		alert("Must Enter Username");
		return;
	}
	if(Password == ""){
		alert("Must Enter Password!");
		return;
	}
	if(Password != PasswordCheck){
		alert("Your Passwords Don't Match");
		return;
	}
	if(PhoneNumber.match(/^\d{10}$/)== null){
		alert("Invalid phone number.");
		return;
	}
	apos=EmailAddress.indexOf("@");
	dotpos=EmailAddress.lastIndexOf(".");
	if (apos<1||dotpos-apos<2){
		alert("Invalid E-mail Address");
		return;
	}

	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	  
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		   //parse XML response from server
		   var responseText= userParseXMLResponse(xmlhttp.responseXML);
		   
	    	document.getElementById("feedBack").innerHTML=responseText;
	    }
	  }

	var Params = "Username=" + Username + "&Password=" + Password + "&PhoneNumber=" + PhoneNumber
					+ "&PhoneCarrier=" + PhoneCarrier + "&EmailAddress=" + EmailAddress;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../registerUserServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

	//change the text while sending the request
	document.getElementById("feedBack").innerHTML="<h2>Please wait... Sending Request</h2>";
}



function userParseXMLResponse(responseXML){
	
	 var success = (responseXML.getElementsByTagName("success")[0]).childNodes[0].nodeValue;
	 
	 var responseText = "";
	 
	 if(success== "true")
	{
		 responseText = "<h2>Error creating user!</h2><h2>Username Must Be Unique!</h2>";
	}
	 else 
	{
		 responseText = "<h2>User Created!</h2>";
		 window.location='./index.jsp'
	}
	

	 return responseText;
}