<html>
<head>
<title>Create Auction Table Test Page</title>

<script type="text/javascript">

var credential;

function createAuctionRequest()
{
	
	var Title = document.getElementById("AuctionTitle").value;
	//var OwnerID = document.getElementById("OwnerID").value;
	var MinPrice = document.getElementById("MinPrice").value;
	
	
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
		    var responseText= auctionParseXMLResponse(xmlhttp.responseXML);
		    //alert("responseText: " + responseText);
		   
	    	document.getElementById("myDiv").innerHTML=responseText;
	    }
	  }

	var Params = "Credential=" + credential + "&AuctionTitle=" + Title + "&MinPrice=" + MinPrice;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../userCreateAuctionServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

	//change the text while sending the email
	document.getElementById("myDiv").innerHTML="<h2>Please wait... Sending Request</h2>";
}

function loginParseXMLResponse(responseXML)
{
	
	 var toCredential = (responseXML.getElementsByTagName("userCred")[0]).childNodes[0].nodeValue;

	 return toCredential;
}


function Login()
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
		    credential= loginParseXMLResponse(xmlhttp.responseXML);
		    //alert("responseText: " + responseText);
		   document.getElementById("AuctionTitle").type="text";
		   document.getElementById("MinPrice").type="text";
	    	document.getElementById("loginDiv").innerHTML=credential;
	    }
	  }

	var Params = "userName=" + userName + "&password=" + password;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../userLoginServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

	//change the text while sending the email
	document.getElementById("loginDiv").innerHTML="<h2>Please wait... Sending Request</h2>";
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
 
 
User: <input id="userName" type="text" name="AuctionTitle" size="20"><br>
Pass: <input id="password" type="text" name="OwnerID" size="20"><br>

<button type="button" onclick="Login()">Login</button>
<div id="loginDiv"><h2>Login Status</h2></div>

<br>
<br>

Title: <input id="AuctionTitle" type="hidden" name="AuctionTitle" size="20"><br>
MinPrice: <input id="MinPrice" type="hidden" name="MinPrice" size="20"><br>
        	  
<div id="myDiv"><h2>Feedback Area</h2></div>


<button type="button" onclick="createAuctionRequest()">Create Auction</button>
    
</body>
</html>