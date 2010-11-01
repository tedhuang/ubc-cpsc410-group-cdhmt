<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>

<script type="text/javascript">

function ParseXMLResponse(responseXML)
{
	 var result = (responseXML.getElementsByTagName("userCred")[0]).childNodes[0].nodeValue;
	 //var message = (responseXML.getElementsByTagName("message")[0]).childNodes[0].nodeValue;

	 var message = "User Credential responseText";
	 
	 var responseText = "<h2>AJAX XML response from server: ";
	 responseText += result + " " + message + "</h2>";

	 return responseText;
}


function userLoginRequest()
{
	var userName = document.getElementById("username").value;
	var password = document.getElementById("password").value;
	//alert("im in");
	
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
		    alert(responseText);
		   
	    	document.getElementById("myDiv").innerHTML=responseText;
	    }
	  }

	var Params = "userName=" + userName + "&password=" + password;

<<<<<<< .mine
	
//	document.getElementById("myDiv").innerHTML=Params;
	
=======
	
>>>>>>> .r68
	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../userLoginServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
	
    //var responseText= ParseXMLResponse(xmlhttp.responseXML);
    

	document.getElementById("myDiv").innerHTML=Params;


}
</script>

<link href="login-box.css" rel="stylesheet" type="text/css" />

</head>

<body>

<div id="login-box">

<form name="close">
<input type="image" src="images/close.png" name="image" width="50" height="50" style="margin-left:300px";/>
</form>

<H2>Login</H2>
<br />
<br />


<div id="login-box-name" style="margin-top:20px;">User:</div>
<div id="login-box-field" style="margin-top:20px;">
	<input id="username" name="username" class="form-login" title="Username" value="" size="30" maxlength="2048" />
	</div>
<div id="login-box-name">Password:</div><div id="login-box-field">
<input id="password" name="password" type="password" class="form-login" title="Password" value="" size="30" maxlength="2048" /></div>
<br />
<span class="login-box-options"><input type="checkbox" name="1" value="1"> Remember Me 
 <a href="#" style="margin-left:30px;">Forgot password?</a></span>

<br />
<br />

<input type="image" src="images/login-btn.png" name="image" width="103" height="42" style="margin-left:90px"
	onclick="userLoginRequest()" />


<br />
<br />



</div>


<div id="myDiv"><h2>Debug Message for page</h2></div>


</body>
</html>