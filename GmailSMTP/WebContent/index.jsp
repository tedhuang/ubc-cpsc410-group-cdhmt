<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Craigsbay Email Tester</title>

<script type="text/javascript">

function ParseXMLResponse(responseXML)
{
	
	 var toAddress = (responseXML.getElementsByTagName("toAddress")[0]).childNodes[0].nodeValue;
	 var subject = (responseXML.getElementsByTagName("subject")[0]).childNodes[0].nodeValue;
	 var body = (responseXML.getElementsByTagName("body")[0]).childNodes[0].nodeValue;

	 var responseText = "<h2>AJAX XML response from server: ";
	 responseText += "\r\nEmail Sent to: " + toAddress + " Subject: " + subject + " Body: " + body + "</h2>";

	 return responseText;
}

function SendEmail()
{
	var emailAddress = document.getElementById("email").value;
	var subject = document.getElementById("subject").value;
	var body = document.getElementById("body").value;
	
	
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
		    var responseText= ParseXMLResponse(xmlhttp.responseXML);
		    //alert("responseText: " + responseText);
		   
	    	document.getElementById("myDiv").innerHTML=responseText;
	    }
	  }

	var Params = "emailAddress=" + emailAddress + "&subject=" + subject + "&body=" + body;
	
	xmlhttp.open("POST","GmailSMTPServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
	
	document.getElementById("myDiv").innerHTML="<h2>Please wait...sending email</h2>";
}
</script>

</head>

<body>

<!--  this is non-AJAX.
<form action="GmailSMTPServlet" method="POST">
        To Email Address: <input type="text" name="emailAddress" size="20"><br>
        Subject: <input type="text" name="subject" size="20"><br>
        Body: <textarea name="body" cols="40" rows="5">
        	  </textarea><br>
        <input type="submit" value="Send">
</form>
 -->
 

To Email Address: <input id="email" type="text" name="emailAddress" size="20"><br>
Subject: <input id="subject" type="text" name="subject" size="20"><br>
Body: <textarea id="body" name="body" cols="40" rows="5"> </textarea><br>
        	  
<div id="myDiv"><h2>Let AJAX change this text dynamically</h2></div>


<button type="button" onclick="SendEmail()">Send Email</button>
    
</body>
</html>