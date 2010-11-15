<html>
<head>
<title>Test Page</title>

<script type="text/javascript">

function ParseXMLResponse(responseXML)
{
	 var result = (responseXML.getElementsByTagName("result")[0]).childNodes[0].nodeValue;
	 
	 var responseText = "<h2>AJAX XML response from server: ";
	 responseText += " " + result + "</h2>";

	 return responseText;
}

function addNumberRequest() {
	
	var number = document.getElementById("number").value;
	
	
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

	var Params = "addThis=" + number;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../chatRelayServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

	//change the text while sending the email
	document.getElementById("myDiv").innerHTML="<h2>Please wait... Sending Request</h2>";
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
 

Number: <input id="number" type="text" name="number" size="20"><br>
        	  
<div id="myDiv"><h2>Feedback Area</h2></div>


<button type="button" onclick="addNumberRequest()">add this</button>
    
</body>
</html>