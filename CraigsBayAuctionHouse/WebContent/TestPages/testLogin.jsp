<html>
<head>
<title>Create Auction Table Test Page</title>

<script type="text/javascript">

function ParseXMLResponse(responseXML)
{
	 var message = (responseXML.getElementsByTagName("message")[0]).childNodes[0].nodeValue;

	 var responseText = "<h2>AJAX XML response from server: ";
	 responseText += message;

	 return responseText;
}

function checkLoginRequest(){
	
	var userName = document.getElementById("userName").value;
	var password = document.getElementById("password").value;
	
	
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

	var Params = "userName=" + userName + "&password=" + password;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","userCheckServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

	//change the text while sending the email
	document.getElementById("myDiv").innerHTML="<h2>Please wait... Sending Request</h2>";
}

function createLoginRequest()
{
	
	var userName = document.getElementById("userName").value;
	var password = document.getElementById("password").value;
	
	
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
		   
	    }
	  }

	var Params = "userName=" + userName + "&password=" + password;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","userLoginServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

	checkLoginRequest();
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
 

User Name: <input id="userName" type="text" name="userName" size="20"><br>
Password: <input id="password" type="text" name="password" size="20"><br>
        	  
<div id="myDiv"><h2>Feedback Area</h2></div>


<button type="button" onclick="createLoginRequest()">Login</button>
    
</body>
</html>