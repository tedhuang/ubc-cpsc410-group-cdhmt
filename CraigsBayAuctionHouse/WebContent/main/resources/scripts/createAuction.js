//Ajax to create auction


function createAuctionRequest()
{
	
	var Title = document.getElementById("AuctionTitle").value;
	var MinPrice = document.getElementById("MinPrice").value;
	var ExpiryDate = document.getElementById("ExpiryDate").value;
	var Category= document.getElementById("Category").value;
	var credential = document.getElementById("cred").value;
	
	//Check User Input
	if(Title == null){
		alert("Must Enter Auction Title!");
		return;
	}
	if(MinPrice.match(/\d{1,10}\.?\d{0,2}/) == null){
		alert("did not match");
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
		    var responseText= auctionParseXMLResponse(xmlhttp.responseXML);
		   
	    	document.getElementById("createAuctionFeedback").innerHTML=responseText;
	    }
	  }

	var Params = "Credential=" + credential + "&AuctionTitle=" + Title + "&MinPrice=" + MinPrice
					+ "&ExpiryDate=" + ExpiryDate + "&Category=" + Category;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../userCreateAuctionServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

	//change the text while sending the request
	document.getElementById("createAuctionFeedback").innerHTML="<h2><img src=./resources/images/loading.gif></img> <p>Sending Request</h2></p>";
}

function loginParseXMLResponse(responseXML)
{
	
	 var toCredential = (responseXML.getElementsByTagName("userCred")[0]).childNodes[0].nodeValue;

	 return toCredential;
}

function auctionParseXMLResponse(responseXML){
	
	 var success = (responseXML.getElementsByTagName("success")[0]).childNodes[0].nodeValue;
	 var responseText = "";
	 
	 if(success==0)
	{
		 responseText = "<h2>Error creating auction!</h2>";
	}
	 else 
	{
		 
		 responseText = "<h2>Auction Created!</h2>";
	}
	

	 return responseText;
}