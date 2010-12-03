
var auctionChatID;

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

function handleStatusSelectionChange()
{
	var auctionStatus = document.getElementById("changeStatusValue").value;
	if(auctionStatus == "OPEN")
	{
		document.getElementById("ExpiryWeekAuctionOwnerChange").disabled=false;
		document.getElementById("ExpiryDayAuctionOwnerChange").disabled=false;
		document.getElementById("ExpiryHourAuctionOwnerChange").disabled=false;
	}
	else
	{
		document.getElementById("ExpiryWeekAuctionOwnerChange").disabled=true;
		document.getElementById("ExpiryDayAuctionOwnerChange").disabled=true;
		document.getElementById("ExpiryHourAuctionOwnerChange").disabled=true;
	}


}

/*
 * Sets the status of the auction associated with the ID to the specified status
 */
function changeAuctionStatus(auctionID, title, feedbackTitle){
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
		   changeAuctionStatusParseResponse(xmlhttp.responseXML, auctionID, title);
	    }
	  };
	
	var expiryWeek = document.getElementById("ExpiryWeekAuctionOwnerChange").value;
	var expiryDay = document.getElementById("ExpiryDayAuctionOwnerChange").value;
	var expiryHour = document.getElementById("ExpiryHourAuctionOwnerChange").value;
	
	var auctionStatus = document.getElementById("changeStatusValue").value;
	var credential = document.getElementById("cred").value;
	
	document.getElementById(feedbackTitle).innerHTML=
		"<h2><img src=./resources/images/loading.gif></img> <p>Sending Auction Update Request...</h2></p>";
	
	var Params = "auctionID=" + auctionID +
				 "&auctionStatus="+ auctionStatus + 
				 "&userCred=" + credential +
				 "&expiryWeek=" + expiryWeek +
				 "&expiryDay=" + expiryDay +
				 "&expiryHour=" + expiryHour;
	
	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../auctionChangeStatusServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
}

function changeAuctionStatusParseResponse(responseXML, auctionID, title)
{
	var success = (responseXML.getElementsByTagName("success")[0]).childNodes[0].nodeValue;
	if(success==1)
	{
		ajaxpage('./auctionDetailsPage.jsp?auctionID='+auctionID , 'itemDetailArea');
		document.getElementById(title).innerHTML="Update Succesful, Refreshing Auction Details...";
	}
	else
	{
		ajaxpage('./auctionDetailsPage.jsp?auctionID='+auctionID , 'itemDetailArea');
		document.getElementById(title).innerHTML="Update Unsuccesful, Please Try Again! - Refreshing Auction Details...";
	}
	
}



function viewAuctionByID(auctionID ){
	
	if(auctionChatID!=null)
	{
		clearTimeout(auctionChatID);
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
		   loadAuctionParseXMLResponse(xmlhttp.responseXML);
	    }
	  };
	
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

    var ownerName = auctionView.getElementsByTagName("ownerName")[0].childNodes[0].nodeValue;
    var lastBidderName = auctionView.getElementsByTagName("lastBidderName")[0].childNodes[0].nodeValue;
    //var chatLog = auctionView.getElementsByTagName("chatLog")[0].childNodes[0].nodeValue;;
			
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
		//colParams[15] = chatLog;
		viewInfo(colParams);
}


function viewInfo(colParams)
{

	document.getElementById("detailTitle").innerHTML="Auction Details : " + colParams[1];
	
	document.getElementById("auctionItem").innerHTML = "Auction Item: " + colParams[1];
	document.getElementById("status").innerHTML = "Status " + colParams[2];
	document.getElementById("timeLeft").innerHTML = "Expiry Date: " + colParams[3];
	document.getElementById("latestPrice").innerHTML = "Latest Price: " + colParams[9];
	document.getElementById("numBids").innerHTML = "Number of Bids: " + colParams[10];
	document.getElementById("lastBidder").innerHTML = "Last Bidder: " + colParams[14];
	document.getElementById("category").innerHTML = "Category: " + colParams[5];
	document.getElementById("auctionOwner").innerHTML = "Auction Owner: " + colParams[13] + "<input type=\"button\" onClick='addFriend()' value = \"Add As Friend\" id=\"addFriendButton\">";
	//document.getElementById("picture").innerHTML = "Picture: " + colParams[11];

	
	document.getElementById("ownerID").value = colParams[6];
	document.getElementById("latestBidPrice").value = colParams[9];
	
	//alert( document.getElementById("loginUserID").value );
	//alert( document.getElementById("ownerID").value );
	if(document.getElementById("ownerID").value == document.getElementById("loginUserID").value)
	{//is owner
		document.getElementById("changeStatusButton").disabled=false;
		document.getElementById("changeStatusValue").disabled=false;
		document.getElementById("bidButton").disabled=true;
		document.getElementById("bidAmount").disabled=true;
		document.getElementById("auctionChatInputText").disabled=false;
		document.getElementById("auctionChatSubmit").disabled=false;
		document.getElementById("uploadDetailsPage").disabled=false;
		//enable expiry date change fields
		handleStatusSelectionChange();
	}
	else if( document.getElementById("userName").value != "Guest")
	{
		document.getElementById("bidButton").disabled=false;
		document.getElementById("bidAmount").disabled=false;
		document.getElementById("auctionChatInputText").disabled=false;
		document.getElementById("auctionChatSubmit").disabled=false;
	}
	
	//status checks
	if(colParams[2] == "EXPIRED" || colParams[2] == "CLOSED")
	{
		document.getElementById("bidButton").disabled=true;
	}
	if(colParams[2] == "CLOSED")
	{
		document.getElementById("changeStatusButton").disabled=true;
		document.getElementById("changeStatusValue").disabled=true;
	}
	
	//document.getElementById("auctionChatHistory").innerHTML += colParams[15];
    
}

function bidOnAuction(auctionID, title, feedbackTitle)
{
	
	//alert(document.getElementById("bidAmount").value);
	//alert(document.getElementById("latestBidPrice").value);
	
	var bidAmount =  parseFloat(document.getElementById("bidAmount").value);
	var latestBidPrice = parseFloat(document.getElementById("latestBidPrice").value);
	
	if(document.getElementById("userName").value == "Guest")
	{
		alert("Please sign in to bid");
		document.getElementById(feedbackTitle).innerHTML = "<h2>Please Sign In To Bid!</h2>"
		return;
	}
	
	if(  bidAmount <= latestBidPrice )
	{
		alert("Insufficient Bid Amount, current price is: $" + document.getElementById("latestBidPrice").value );
		document.getElementById(feedbackTitle).innerHTML = "<h2>Bid too low</h2>";
		return;
	}
	document.getElementById(feedbackTitle).innerHTML="<h2><img src=./resources/images/loading.gif></img> <p>Sending Bid Request...</h2></p>";
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
		  bidAuctionParseXMLResponse(xmlhttp.responseXML, auctionID, title, feedbackTitle);
	    }
	  }
	
	var credential = document.getElementById("cred").value;
	var Params = "auctionID=" + auctionID + "&amount=" + bidAmount + "&userCred=" + credential;
	
	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../userAuctionBidServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
}

function bidAuctionParseXMLResponse(responseXML, auctionID, title, feedbackTitle)
{
	 var success = (responseXML.getElementsByTagName("success")[0]).childNodes[0].nodeValue;
	
	if(success==1)
		{
		document.getElementById(feedbackTitle).innerHTML = "<h2>Bid Succesful</h2>";
		
		ajaxpage('./auctionDetailsPage.jsp?auctionID='+auctionID , 'itemDetailArea'); //load auctionDetailsPage 
		document.getElementById(title).innerHTML="Bid Succesful, Refreshing Auction Details...";
		
		}
	else if(success==-1)
		{
		document.getElementById(feedbackTitle).innerHTML = "<h2>Bid Too Low</h2>";
		
		ajaxpage('./auctionDetailsPage.jsp?auctionID='+auctionID , 'itemDetailArea'); //load auctionDetailsPage 
		document.getElementById(feedbackTitle).innerHTML="Bid too low, Refreshing Auction Details...";
		}
	else if(success==-2)
		{
		document.getElementById(feedbackTitle).innerHTML = "<h2>Auction Has Expired</h2>";
		
		ajaxpage('./auctionDetailsPage.jsp?auctionID='+auctionID , 'itemDetailArea'); //load auctionDetailsPage 
		document.getElementById(title).innerHTML="Auction Has Expired, Refreshing Auction Details...";
		
		}
	document.getElementById("bidButton").disabled=false;
	document.getElementById("bidAmount").disabled=false;
	
}

function sendAuctionChat(auctionID)
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
		   //alert("posted question");
	    }
	  }
	
	var text = document.getElementById("auctionChatInputText").value;
	document.getElementById("auctionChatInputText").value="";
	
	var userName = document.getElementById("userName").value;

	//document.getElementById("bidFeedback").innerHTML="<h2><img src=./resources/images/loading.gif></img> <p>Sending Auction Update Request...</h2></p>";
	
	var Params = "auctionID=" + auctionID +
				 "&userName=" + userName +
				 "&text=" + text;
	
	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../AuctionPostChatServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
	
}

function getReadyStateHandler(req, responseXmlHandler, auctionID) {

	   // Return an anonymous function that listens to the XMLHttpRequest instance
	   return function () {

	     // If the request's status is "complete"
	     if (req.readyState == 4) {
	       
	       // Check that we received a successful response from the server
	       if (req.status == 200) {

	         // Pass the XML payload of the response to the handler function.
	         return responseXmlHandler(req.responseXML, auctionID);

	       } else {

	         // An HTTP problem has occurred
	        // alert("HTTP error "+req.status+": "+req.statusText);
	       }
	     }
	   }
}

function refreshAuctionChatParseXMLResponse(responseXML, auctionID)
{
	var chatLog = (responseXML.getElementsByTagName("chatLog")[0]).childNodes[0].nodeValue;
	document.getElementById("auctionChatHistory").innerHTML = chatLog;
	document.getElementById("auctionChatHistory").scrollTop = document.getElementById("auctionChatHistory").scrollHeight;
	if(auctionChatID!=null)
	{
		clearTimeout(auctionChatID);
	}
	auctionChatID=setTimeout("refreshAuctionChat(" + auctionID + ")", 5000);
}

function refreshAuctionChat(auctionID)
{
	var xmlhttp;
	
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	  
	xmlhttp.onreadystatechange=getReadyStateHandler(xmlhttp, refreshAuctionChatParseXMLResponse, auctionID );
	
	var text = document.getElementById("auctionChatInputText").value;
	var userID = document.getElementById("loginUserID").value;

	//document.getElementById("bidFeedback").innerHTML="<h2><img src=./resources/images/loading.gif></img> <p>Sending Auction Update Request...</h2></p>";
	
	var Params = "auctionID=" + auctionID +
				 "&userID=" + userID;
	
	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../AuctionRefreshChatServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);



}

function addFriend(){
		var credential = document.getElementById("cred").value;
		var friendID = document.getElementById("ownerID").value;
		
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
			    
			    var responseText= ParseFriendAdd(xmlhttp.responseXML);
		    	
		    }
		  };
		
		//send the parameters to the servlet with POST
		var Params = "Credential=" + credential + "&FriendID=" + friendID;
		
		xmlhttp.open("POST","../friendAddServlet" ,true);
		xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xmlhttp.send(Params);
	}

	function ParseFriendAdd(responseXML, container){
		
		 var success = (responseXML.getElementsByTagName("success")[0]).childNodes[0].nodeValue;
		 var responseText = "";
		 
		 if(success=="-1")
		{
			 //responseText = 
			 alert("Error adding friend!");
		}
		 
		if(success=="0")
		{
				 //responseText = 
				 alert("Already a friend!");
		}
		 if(success=="1")
		{
			//responseText = 
			 alert("Friend added!");
		}
		 //TODO Disable page while it reloads; ATM it reloads but the user can interact with it while it does.
		 return responseText;
	}

/* We don't need this anymore since we are using scriptless badge 
 * Kept just in case
 * 
function displayBadges(){
	//var str = '<a href="javascript:alert(\'hello world\')">test</a>';
//<script type="text/javascript" src="http://www.flickr.com/badge_code_v2.gne?show_name=1&count=1&display=latest&size=t&layout=v&source=user_tag&user=55164508%40N02&tag=TestTag"></script>
	
	//var str = '<p><a href="http://www.flickr.com/photos/55164508@N02/">PLEASE WORK</a></p>';
	
	//This currently just redirects to the site to oblivion
	//document.getElementById("flickrTest").innerHTML = str;
		//document.write ("<" + "script language='JavaScript' type='text/javascript' src='http://www.flickr.com/badge_code_v2.gne?show_name=1&count=1&display=latest&size=t&layout=v&source=user_tag&user=55164508%40N02&tag=tag2'");
	
    var container2 = document.getElementById('flickrTest');
    var script = document.createElement("script");
    script.type = 'text/javascript';
    script.innerHTML = "document.write(src='http://www.flickr.com/badge_code_v2.gne?show_name=1&count=1&display=latest&size=t&layout=v&source=user_tag&user=55164508%40N02&tag=TestTag');";
    container.appendChild(script);

	
	 //document.getElementById("flickrTest").innerHTML = document.getElementById("hiddenBadge").innerHTML;
	// var newDiv = document.createElement('DIV');
	 //newDiv.id = 'imageDiv';
	 //newDiv.innerHTML = document.getElementById("hiddenBadge").innerHTML;
	 //document.getElementById("flickrTest").appendChild(newDiv);
	 //document.body.appendChild(newDiv);

	 var headID = document.getElementById("flickrTest");         
	 var newScript = document.createElement('script');
	 newScript.type = 'text/javascript';
	 newScript.src = 'http://www.flickr.com/badge_code_v2.gne?show_name=1&count=1&display=latest&size=t&layout=v&source=user_tag&user=55164508%40N02&tag=tag2';
	 headID.appendChild(newScript);
	 
	// alert(document.getElementById("imageDiv").innerHTML);

}
*/

