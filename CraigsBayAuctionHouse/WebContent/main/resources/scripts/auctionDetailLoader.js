 

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

	//put code to change table here
    //    var colHTML ="	 <tr>"+ auctionTitle + "</tr>" +
	//		"    <tr>"+ auctionStatus + "</tr>" +
	//		"    <tr>"+ expiryDate +"</tr>" +
	//		"    <tr>"+ latestBidPrice +"</tr>"+
	//		"    <tr>"+ bidCounter +"</tr>"+
	//		"    <tr>"+ lastBidderID +"</tr>"+
	//		"    <tr>"+ category +"</tr>"+
	//		"    <tr>"+ onwerID +"</tr>" +
	//		"    <tr>"+ flickerAlbumID +"</tr>";
			
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
	// Insert rows and cells into bodies.
    var oBody = document.getElementById('auctionDetails');

    oRow = oBody.insertRow(oBody.rows.length);
    oRow.setAttribute('id',colParams[0]);
    oCell = oRow.insertCell(-1);
    oCell.innerHTML = colParams[1];
    
    oRow = oBody.insertRow(oBody.rows.length);
    oRow.setAttribute('id', colParams[0]);
    oCell = oRow.insertCell(-1);
    oCell.innerHTML = colParams[2];
    
    //status
   // oCell = oRow.insertCell(-1);
   // oCell.innerHTML =  rowParams[2];
    
    
	
}

