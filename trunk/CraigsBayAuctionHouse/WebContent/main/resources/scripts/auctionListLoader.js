
	// Ajax to add entries to the table



function viewDetails(auctionID)
{
	//loadjscssfile('./resources/scripts/auctionDetailLoader.js', 'js');
	//loadobjs('./resources/scripts/auctionDetailLoader.js'); //load the additional javascript file	
	//ajaxpage('./auctionDetailsPage.jsp?auctionID='+auctionID, 'Dynapage'); //load auctionDetailsPage in to div Dynapage
	showItemDetailTab('Test', auctionID);
	document.getElementById("surferTitle").innerHTML="Loading Auction Details...";
}


function ParseAuctionList( responseXML ) {
	

	var auctionsList = responseXML.getElementsByTagName('auctionsList').item(0);

	/*
	var auctionListLength = responseXML.getElementsByTagName('auctionsList').item(0).length;
	var auctionChildLength = auctionsList.childNodes.length;
	var areponseLength = responseXML.getElementsByTagName('response').length;
	*/
	
	//remove old elements
	  var oBody = document.getElementById('myTable');
	  if(oBody != null)
	  {
		  while(oBody.hasChildNodes())
		  {
			  oBody.removeChild(oBody.firstChild);
		  }
	  }
	  
	var auctions = auctionsList.getElementsByTagName("auction");
	for (var iNode = 0; iNode < auctions.length; iNode++) {
		
        var auction_node = auctions[iNode];

        var auctionID		=	auction_node.getAttribute("auctionID");
        var auctionTitle	=	auction_node.getAttribute("auctionTitle");
        var auctionStatus	=	auction_node.getAttribute("auctionStatus");
        var expiryDate		=	auction_node.getAttribute("expiryDate");
        var creationDate	=	auction_node.getAttribute("creationDate");
        var category		=	auction_node.getAttribute("category");
        var ownerID			=	auction_node.getAttribute("ownerID");
        var lastBidderID	=	auction_node.getAttribute("lastBidderID");
        var minPrice		=	auction_node.getAttribute("minPrice");
        var latestBidPrice	=	auction_node.getAttribute("latestBidPrice");
        var bidCounter		=	auction_node.getAttribute("bidCounter");

        var flickerAlbumID	=	auction_node.getAttribute("flickerAlbumID");
        var numberOfViews	=	auction_node.getAttribute("numberOfViews");
		
   	 	var rowHTML =	"<td><input type=checkbox /></td>" +
						"    <td>" +
   	 					"<a href=index.html>"+ auctionTitle + "</a></td>" +
							"    <td>"+ auctionStatus + "</td>" +
							"    <td>"+ expiryDate +"</td>" +
							"    <td>"+ latestBidPrice +"</td>";
		var rowParams = new Array();
		rowParams[0] = auctionID;
		rowParams[1] = auctionTitle;
		rowParams[2] = auctionStatus;
		rowParams[3] = expiryDate;
		rowParams[4] = creationDate;
		rowParams[5] = category;
		rowParams[6] = ownerID;
		rowParams[7] = lastBidderID;
		rowParams[8] = minPrice;
		rowParams[9] = latestBidPrice;
		rowParams[10] = bidCounter;
		rowParams[11] = flickerAlbumID;
		rowParams[12] = numberOfViews;
		addElement(rowParams);
		//alert(rowParams);
		
		/*
		var rowHTML = 	
						
		'	<td><input type="checkbox" /></td> '+
		'	<td><a href="#" title="title">IPhone 4G</a></td> ' +
		'	<td>Hot Bidding!</td> ' +
		'	<td>12 Hours</td> ' +
		'	<td>150</td> ' +

		' <td> ' + 
				' <a href="#" title="Edit"><img src="resources/images/icons/pencil.png" alt="Edit" /></a> ' +
				' <a href="#" title="Delete"><img src="resources/images/icons/cross.png" alt="Delete" /></a> ' +
				' <a href="#" title="Edit Meta"><img src="resources/images/icons/hammer_screwdriver.png" alt="Edit Meta" /></a> ' +
			' </td> ' ;
		*/
		
		//addElement(rowHTML);
		
	}

	document.getElementById("surferTitle").innerHTML="Auction List";
}

function addElement( rowParams ) {
	
	  var ni = document.getElementById('myTable');
	  
	  var numi = document.getElementById('theValue');
	  var num = (document.getElementById('theValue').value -1)+ 2;
	  numi.value = num;
	  var newdiv = document.createElement('div');
	  var divIdName = 'my'+num+'Div';
	  newdiv.setAttribute('id',divIdName);
	  newdiv.setAttribute('class','div-table-row');
	  
	  
	  //newdiv.innerHTML += "<tr>";
	  //alert("<tr>"+rowHTML+"</tr>");
	  //newdiv.innerHTML = '<tr>'+ rowHTML + '</tr>';
	  //alert(newdiv.innerHTML);
	 // newdiv.innerHTML += "</tr>";
	 
	  //remove old rows..
	  
	  var oBody = document.getElementById('myTable');
	  
	 // Insert rows and cells into bodies.
	    oRow = oBody.insertRow(oBody.rows.length);
	    oRow.setAttribute('id', rowParams[0]);
	    
	  //checkbox
	    oCell = oRow.insertCell(-1);
	    oCell.setAttribute ('id', "checkBox" );
	    oCell.innerHTML = "<input type=checkbox />";
	      

	   //name
	    oCell = oRow.insertCell(-1);
	    
	    oCell.innerHTML = "<a href='#' onClick=viewDetails(" + rowParams[0] + ")>"+ rowParams[1] + "</a>";
	    
	    //status
	    oCell = oRow.insertCell(-1);
	    oCell.innerHTML =  rowParams[2];
	    
	    //time left
	    oCell = oRow.insertCell(-1);
	    oCell.innerHTML =  rowParams[3];
	    
	    //latest price
	    oCell = oRow.insertCell(-1);
	    oCell.innerHTML =  rowParams[9];
	    
	    //category
	    oCell = oRow.insertCell(-1);
	    oCell.innerHTML =  rowParams[5];
	    
	    //num bids
	    oCell = oRow.insertCell(-1);
	    oCell.innerHTML =  rowParams[10];
	    
	  	//tools
	    
	  //ni.appendChild(newdiv);
	  
	}

function loadAuctionTable()
{
	//var ni = document.getElementById('myDiv');
	//var numi = document.getElementById('theValue');
	//var num = (document.getElementById('theValue').value -1)+ 2;
	  
	
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
		    
		    var responseText= ParseAuctionList(xmlhttp.responseXML);
	    	
	    }
	  }

	//send the parameters to the servlet with POST
	var Params = "";
	
	xmlhttp.open("POST","../auctionListAllServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
	//document.getElementById("myDiv").innerHTML="<h2>Please wait...getting entry</h2>";
}

function loadUserOwnedAuctions()
{
	//var ni = document.getElementById('myDiv');
	//var numi = document.getElementById('theValue');
	//var num = (document.getElementById('theValue').value -1)+ 2;
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
		    
		    var responseText= ParseAuctionList(xmlhttp.responseXML);
	    	
	    }
	  }

	//send the parameters to the servlet with POST
	var Params = "Credential=" + credential;
	
	xmlhttp.open("POST","../auctionListUserPostedServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
	//document.getElementById("myDiv").innerHTML="<h2>Please wait...getting entry</h2>";
}

function loadUserBiddedAuctions() {
	
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
		    
		    var responseText= ParseAuctionList(xmlhttp.responseXML);
	    	
	    }
	  }

	//send the parameters to the servlet with POST
	var Params = "Credential=" + credential;
	
	xmlhttp.open("POST","../auctionListUserBiddedServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

}
	
function removeElement() {
	var tableBody=document.getElementById( 'myTable' );
	//var entries = document.getElementById( 'myDiv' ).getElementsByTagName('div');
	var chkBox;
	var temp;

	var checked = new Array();

	var rows = tableBody.getElementsByTagName( 'tr' );
	
	for( var i = rows.length-1 ; i > -1; i-- )
	 {
		chkBox= rows[i].cells[0].getElementsByTagName('input');
		temp = rows[i];
		
		if( chkBox[0].checked )
		{
			checked.push(temp);
		}
	 }

	 for (var j = 0 ; j < checked.length; ++j)
	 {
		tableBody.removeChild( checked[j] );
	 }
		
	}
