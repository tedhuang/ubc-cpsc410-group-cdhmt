 

function toggle() {
	var ele = document.getElementById("editTab");
	//var text = document.getElementById("displayText");
	if(ele.style.display == "block") {
    		ele.style.display = "none";
		text.innerHTML = "show";
  	}
	else {
		ele.style.display = "block";
		text.innerHTML = "hide";
	}
} 

function viewAuctionByID(auctionID ){
	
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
		   loadAuctionParseXMLResponse(xmlhttp.responseXML);
	    }
	  }
	
	var credential = document.getElementById("cred").value;
	var Params = "auctionID=" + auctionID + "&userCred=" + credential;
	
	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../userViewAuctionServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
}

function loadAuctionParseXMLResponse(responseXML) {

	var auctionView = responseXML.getElementsByTagName("auctionView").item(0);
	
	var isOwner = auctionView.getAttribute("owner");
	var canBid = auctionView.getAttribute("bid");

	var auction_node = auctionView.getElementsByTagName("auction").item(0);

        var auctionID		=	auction_node.getAttribute("auctionID");
        var auctionTitle	=	auction_node.getAttribute("auctionTitle");
        var expiryDate		=	auction_node.getAttribute("expiryDate");
        var creationDate	=	auction_node.getAttribute("creationDate");
        var category		=	auction_node.getAttribute("category");
        var ownerID			=	auction_node.getAttribute("ownerID");
        var lastBidderID	=	auction_node.getAttribute("lastBidderID");
        var minPrice		=	auction_node.getAttribute("minPrice");
        var latestBidPrice	=	auction_node.getAttribute("latestBidPrice");
        var bidCounter		=	auction_node.getAttribute("bidCounter");
        var auctionStatus	=	auction_node.getAttribute("auctionStatus");
        var flickerAlbumID	=	auction_node.getAttribute("flickerAlbumID");
        var numberOfViews	=	auction_node.getAttribute("numberOfViews");

			
        var colParams = new Array();
        colParams[0] = auctionID;
        colParams[1] = auctionTitle;//1
        colParams[2] = auctionStatus;//2
        colParams[3] = expiryDate;//3
        colParams[4] = creationDate;//4
        colParams[5] = category;//5
        colParams[6] = ownerID;//6
        colParams[7] = lastBidderID;
		colParams[8] = minPrice;
		colParams[9] = latestBidPrice;
		colParams[10] = bidCounter;
		colParams[11] = flickerAlbumID;
		colParams[12] = numberOfViews;
		viewInfo(colParams);
}

function viewInfo(colParams)
{
	document.getElementById("surferTitle").innerHTML="Auction Details : " + colParams[1];
	
	document.getElementById("auctionItem").innerHTML = "Auction Item: " + colParams[1];
	document.getElementById("status").innerHTML = "Status " + colParams[2];
	document.getElementById("timeLeft").innerHTML = "Expiry Date: " + colParams[3];
	document.getElementById("latestPrice").innerHTML = "Latest Price: " + colParams[9];
	document.getElementById("numBids").innerHTML = "Number of Bids: " + colParams[10];
	document.getElementById("lastBidder").innerHTML = "Last Bidder: " + colParams[7];
	document.getElementById("category").innerHTML = "Category: " + colParams[5];
	document.getElementById("auctionOwner").innerHTML = "OwnerID: " + colParams[6];
	document.getElementById("picture").innerHTML = "Picture: " + colParams[11];
	
	document.getElementById("ownerID").value = colParams[6];
	document.getElementById("latestBidPrice").value = colParams[9];
	
	document.getElementById("bidButton").disabled=false;
    
}

function bidOnAuction(auctionID)
{
	
	//alert(document.getElementById("bidAmount").value);
	//alert(document.getElementById("latestBidPrice").value);
	
	var bidAmount =  parseFloat(document.getElementById("bidAmount").value);
	var latestBidPrice = parseFloat(document.getElementById("latestBidPrice").value);
	
	if(document.getElementById("userName").value == "Guest")
	{
		alert("Please sign in to bid");
		document.getElementById("bidFeedback").innerHTML = "<h2>Please Sign In To Bid!</h2>"
		return;
	}
	
	if(  bidAmount <= latestBidPrice )
	{
		alert("Insufficient Bid Amount, current price is: $" + document.getElementById("latestBidPrice").value );
		document.getElementById("bidFeedback").innerHTML = "<h2>Bid input too low</h2>";
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
		  bidAuctionParseXMLResponse(xmlhttp.responseXML);
	    }
	  }
	
	var credential = document.getElementById("cred").value;
	var Params = "auctionID=" + auctionID + "&userCred=" + credential;
	
	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../userAuctionBidServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
}

function bidAuctionParseXMLResponse()
{
	
}

