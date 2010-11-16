 

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

/*
 * Might not need
 */
function handleDropdownMenu(){
	
	//if(selection)
	var selection = document.getElementById("dropdown").value;

	if(selection.equals("edit")){
		//Todo:implement
	}
	
	if(selection.equals("close")){
		closeAuction();
	}
		
	
}

/*
 * Sets the status of the auction associated with the ID to the specified status
 */
function changeAuctionStatus(auctionID){
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
		   changeAuctionStatusParseResponse(xmlhttp.responseXML);
	    }
	  }
	
	var auctionStatus = document.getElementById("changeStatusValue").value;
	var credential = document.getElementById("cred").value;
	var Params = "auctionID=" + auctionID +
				 "&auctionStatus="+ auctionStatus + 
				 "&userCred=" + credential;
	
	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../auctionChangeStatusServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
}

function changeAuctionStatusParseResponse(responseXML)
{
	
	
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

    var ownerName = auctionView.getElementsByTagName("ownerName")[0].childNodes[0].nodeValue;;
    var lastBidderName = auctionView.getElementsByTagName("lastBidderName")[0].childNodes[0].nodeValue;;
			
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
		colParams[13] = ownerName;
		colParams[14] = lastBidderName;
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
	document.getElementById("lastBidder").innerHTML = "Last Bidder: " + colParams[14];
	document.getElementById("category").innerHTML = "Category: " + colParams[5];
	document.getElementById("auctionOwner").innerHTML = "Auction Owner: " + colParams[13];
	document.getElementById("picture").innerHTML = "Picture: " + colParams[11];
	
	document.getElementById("ownerID").value = colParams[6];
	document.getElementById("latestBidPrice").value = colParams[9];
	
	document.getElementById("bidButton").disabled=false;
	
	//alert( document.getElementById("loginUserID").value );
	//alert( document.getElementById("ownerID").value );
	if(document.getElementById("ownerID").value == document.getElementById("loginUserID").value)
	{//is owner
		document.getElementById("changeStatusButton").disabled=false;
		document.getElementById("changeStatusValue").disabled=false;
	}
    
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
		document.getElementById("bidFeedback").innerHTML = "<h2>Bid too low</h2>";
		return;
	}
	
	document.getElementById("bidButton").disabled=true;
	
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
		  bidAuctionParseXMLResponse(xmlhttp.responseXML, auctionID);
	    }
	  }
	
	var credential = document.getElementById("cred").value;
	var Params = "auctionID=" + auctionID + "&amount=" + bidAmount + "&userCred=" + credential;
	
	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../userAuctionBidServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
}

function bidAuctionParseXMLResponse(responseXML, auctionID)
{
	 var success = (responseXML.getElementsByTagName("success")[0]).childNodes[0].nodeValue;
	
	if(success==1)
		{
		document.getElementById("bidFeedback").innerHTML = "<h2>Bid Succesful</h2>";
		
		ajaxpage('./auctionDetailsPage.jsp?auctionID='+auctionID , 'Dynapage'); //load auctionDetailsPage in to div Dynapage
		document.getElementById("surferTitle").innerHTML="Bid Succesful, Refreshing Auction Details...";
		
		}
	else
		{
		document.getElementById("bidFeedback").innerHTML = "<h2>Bid Too Low</h2>";
		
		ajaxpage('./auctionDetailsPage.jsp?auctionID='+auctionID , 'Dynapage'); //load auctionDetailsPage in to div Dynapage
		document.getElementById("surferTitle").innerHTML="Bid too low, Refreshing Auction Details...";
		}
	document.getElementById("bidButton").disabled=false;
	
}

