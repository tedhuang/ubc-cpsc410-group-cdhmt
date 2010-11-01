<html>
<head>
<title>Create Auction Table Test Page</title>

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

function createAuctionRequest()
{
	
	var Title = document.getElementById("AuctionTitle").value;
	var OwnerID = document.getElementById("OwnerID").value;
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
		    var responseText= ParseXMLResponse(xmlhttp.responseXML);
		    //alert("responseText: " + responseText);
		   
	    	document.getElementById("myDiv").innerHTML=responseText;
	    }
	  }

	var Params = "AuctionTitle=" + Title + "&OwnerID=" + OwnerID + "&MinPrice=" + MinPrice;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../createAuctionServlet" ,true);
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
 

Title: <input id="AuctionTitle" type="text" name="AuctionTitle" size="20"><br>
OwnerID: <input id="OwnerID" type="text" name="OwnerID" size="20"><br>
MinPrice: <input id="MinPrice" type="text" name="MinPrice" size="20"><br>
        	  
<div id="myDiv"><h2>Feedback Area</h2></div>


<button type="button" onclick="createAuctionRequest()">Create Auction</button>
    
</body>
</html>