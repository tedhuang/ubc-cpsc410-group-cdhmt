//Ajax to create auction


function createAuctionRequest()
{
	
	var Title = document.getElementById("AuctionTitle").value;
	var MinPrice = document.getElementById("MinPrice").value;
	var ExpiryDate = document.getElementById("ExpiryDate").value;
	var Category= document.getElementById("Category").value;
	var credential = document.getElementById("cred").value;
	
	
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

	var Params = "Credential=" + credential + "&AuctionTitle=" + Title + "&MinPrice=" + MinPrice
					+ "&ExpiryDate=" + ExpiryDate + "&Category=" + Category;

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

function auctionParseXMLResponse(responseXML){
	
}