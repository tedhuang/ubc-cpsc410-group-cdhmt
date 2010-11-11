function loadAuctionTable()
{	
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
		    
		    var responseText= ParseUserInfo(xmlhttp.responseXML);
	    	
	    }
	  }

	//send the parameters to the servlet with POST
	var Params = "";
	
	xmlhttp.open("POST","../listAuctionsServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
	//document.getElementById("myDiv").innerHTML="<h2>Please wait...getting entry</h2>";
}


function ParseUserInfo( responseXML ) {
	

	var auctionsList = responseXML.getElementsByTagName('auctionsList').item(0);
	var auctions = auctionsList.getElementsByTagName("auction");
	for (var iNode = 0; iNode < auctions.length; iNode++) {
		
        var auction_node = auctions[iNode];

        document.getElementById("Password").value =	auction_node.getAttribute("auctionID");
        document.getElementById("Telephone").value = auction_node.getAttribute("auctionTitle");
        document.getElementById("PhoneCarrier").value	=	auction_node.getAttribute("auctionStatus");
        document.getElementById("EmailAddress").value =	auction_node.getAttribute("expiryDate");
	}

	document.getElementById("surferTitle").innerHTML="Auction List";
}




function getUserInfo()
{

}

function editUserInfo()
{
	//Unlocks textboxes etc. to be edited
	document.getElementById("Password").disabled = "";
	document.getElementById("Telephone").disabled = "";
	document.getElementById("PhoneCarrier").disabled = "";
	document.getElementById("EmailAddress").disabled = "";	
	document.getElementById("Submit").style = 'display:all;';
}


function updateUserRequest()
{
	
	var Password = document.getElementById("Password").value;
	var Telephone = document.getElementById("Telephone").value;
	var PhoneCarrier = document.getElementById("PhoneCarrier").value;
	var EmailAddress= document.getElementById("EmailAddress").value;
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
		   
	    	document.getElementById("feedBack").innerHTML=responseText;
	    }
	  }

	var Params = "Credential=" + credential + "&Password=" + Password + "&Telephone=" + Telephone
					+ "&PhoneCarrier=" + Phonecarrier + "&EmailAddress=" + EmailAddress;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../userEditInfo" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

	//change the text while sending the request
	document.getElementById("feedBack").innerHTML="<h2>Please wait... Sending Request</h2>";
}