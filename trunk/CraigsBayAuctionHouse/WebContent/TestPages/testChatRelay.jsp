<html>
<head>
<title>Test Page</title>

<script type="text/javascript">

function ParseXMLResponse(responseXML)
{
	 var result = (responseXML.getElementsByTagName("result")[0]).childNodes[0].nodeValue;
	 
	 var responseText = "<h2>AJAX XML response from server: ";
	 responseText += " " + result + "</h2>";

	 document.getElementById("myDiv").innerHTML=responseText;
	 //wait 5 sec and poll server again.
	 setTimeout('addNumberRequest()', 5000);
	 
}

function createNewRequest()
{
	xmlhttp=false;
	
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	  

	  return xmlhttp;
}

function addNumberRequest() {
	
	var number = document.getElementById("number").value;

	xmlhttp = createNewRequest();
	  
	xmlhttp.onreadystatechange = getReadyStateHandler(xmlhttp, ParseXMLResponse);

	var Params = "addThis=" + number;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../chatRelayServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
	//change the text while sending the email
	document.getElementById("myDiv").innerHTML="<h2>Please wait... Sending Request</h2>";
}

function getReadyStateHandler(req, responseXmlHandler) {

	   // Return an anonymous function that listens to the XMLHttpRequest instance
	   return function () {

	     // If the request's status is "complete"
	     if (req.readyState == 4) {
	       
	       // Check that we received a successful response from the server
	       if (req.status == 200) {

	         // Pass the XML payload of the response to the handler function.
	         return responseXmlHandler(req.responseXML);

	       } else {

	         // An HTTP problem has occurred
	         alert("HTTP error "+req.status+": "+req.statusText);
	       }
	     }
	   }
	 }

</script>

</head>

<body>

 

Number: <input id="number" type="text" name="number" size="20"><br>
        	  
<div id="myDiv"><h2>Feedback Area</h2></div>


<button type="button" onclick="addNumberRequest()">add this</button>
    
</body>
</html>