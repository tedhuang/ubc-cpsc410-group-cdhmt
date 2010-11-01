<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<script type="text/javascript">


//This code doesn't fetch attributes correctly
function ParseXMLResponse( responseXML ) {

	var auctionsList = responseXML.getElementsByTagName('auctionsList').item(0);
	
	var printout;
	
	for (var iNode = 0; iNode < auctionsList.childNodes.length; iNode++) {
		
        var auction_node = auctionsList.childNodes.item(iNode);

        var auctionID		=	auction_node.getElementsByTagName("auction")[0].getAttribute("auctionID");
        var auctionTitle	=	auction_node.getElementsByTagName("auction")[0].getAttribute("auctionTitle");
        var expiryDate		=	auction_node.getElementsByTagName("auction")[0].getAttribute("expiryDate");
        var creationDate	=	auction_node.getElementsByTagName("auction")[0].getAttribute("creationDate");
        var category		=	auction_node.getElementsByTagName("auction")[0].getAttribute("category");
        var ownerID			=	auction_node.getElementsByTagName("auction")[0].getAttribute("ownerID");
        var lastBidderID	=	auction_node.getElementsByTagName("auction")[0].getAttribute("lastBidderID");
        var minPrice		=	auction_node.getElementsByTagName("auction")[0].getAttribute("minPrice");
        var latestBidPrice	=	auction_node.getElementsByTagName("auction")[0].getAttribute("latestBidPrice");
        var bidCounter		=	auction_node.getElementsByTagName("auction")[0].getAttribute("bidCounter");
        var auctionStatus	=	auction_node.getElementsByTagName("auction")[0].getAttribute("auctionStatus");
        var flickerAlbumID	=	auction_node.getElementsByTagName("auction")[0].getAttribute("flickerAlbumID");
        var numberOfViews	=	auction_node.getElementsByTagName("auction")[0].getAttribute("numberOfViews");
        
        printout += "<h2>auctionID=" + auctionID + " auctionTitle=" + auctionTitle
				+ " ownerID=" + ownerID + "</h2>";
						
	}
   
	return printout;
}

function addrow(tablename, arr) {
	   var tbl = document.getElementById(tablename);
	   var lastRow = tbl.rows.length;
	   var row = tbl.insertRow(lastRow);
	      for (r = 0; r < arr.length; r++) {   
	         var cell = row.insertCell(r);
	         cell.innerHTML = arr[r];
	      }
}

function checkAuctionList(){
	
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
			
	    	//document.getElementById("myDiv").innerHTML="<h2>We got it</h2>";
		    document.getElementById("myDiv").innerHTML = responseText;
	    }
	  }

	//send the parameters to the servlet with POST
	var param = "test";
	
	xmlhttp.open("POST","../listAuctionsServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(param);

	//change the text while sending the email
	document.getElementById("myDiv").innerHTML="<h2>Please wait... Sending Request</h2>";
}

</script>


<button type="button" onclick="checkAuctionList()">Check Auction List</button>
        	  
<div id="myDiv"><h2>Feedback Area</h2></div>

</body>
</html>