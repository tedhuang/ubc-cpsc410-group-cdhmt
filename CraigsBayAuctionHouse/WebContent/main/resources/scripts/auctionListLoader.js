/**************************************************************
 * Description:
 * Used to load many of the aspects of view all auctions page
 * from tableLoad.jsp
 *
 **************************************************************/

/******************************************************************************************
 *  			AUCTION SEARCH FUNCTION 
 ******************************************************************************************/
function searchAuctionTable(type, searchOwner)
	{	
		//If type = 0 then basic search else advanced
		//NOTE for some reason to pass '%' as a string in javascript it has to be '%25'
		if(type == 0){
			var searchTitle = document.getElementById("searchTitle").value;
			var searchCategory = "%25";
			searchOwner = "";
			showAdvancedSearchTab();
		}

		//Advanced Search
		if(type == 1){
			var searchTitle = document.getElementById("advancedSearchTitle").value;
			var searchCategory = document.getElementById("searchCategory").value;
			searchOwner = document.getElementById("searchOwner").value;

			//Check to see what parameters matter
			if(searchTitle == ""){
				searchTitle = "%25";
			}
			if(searchCategory == ""){
				searchCategory = "%25";
			}
			if(searchOwner == ""){
				searchOwner = "";
			}
		}
		
		//Friend Search
		if(type == 2){
			var searchCategory = "%25";
			var searchTitle = "%25";
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
			    
			    var responseText= ParseSearchedAuctionList(xmlhttp.responseXML,'searchRsltArea');
		    	
		    }
		  }
	
		//send the parameters to the servlet with POST
		var Params = "SearchTitle="+ searchTitle + "&SearchCategory=" + searchCategory + 
						"&SearchOwner=" + searchOwner;
		
		xmlhttp.open("POST","../auctionListAllServlet" ,true);
		xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xmlhttp.send(Params);
		//document.getElementById("myDiv").innerHTML="<h2>Please wait...getting entry</h2>";
	}

	// Ajax to add entries to the table
/****************************************************************************************************************************************
 * 
 * 								LAOD ALL AUCTIONS
 * 
 *  @param title  	--> Display loading and Title
 * @param container --> which element to place the table
 *
 *****************************************************************************************************************************************/

function viewAllAuctions(container, title)
	{
		showAllItemTab();
		ajaxpage('tableLoad.jsp', container); //load tableLoad.jsp in to div Dynapage;
		document.getElementById(title).innerHTML="<img src=./resources/images/loading.gif></img>";
		
	}

/****************************************************************************************************************************************
 * 								LAOD ALL AUCTIONS FROM CURRENT USER
 *****************************************************************************************************************************************/

function viewUserAuctions(container, title)
{
	showMyAuctionTab();
	ajaxpage('userOwnedAuctionsLoad.jsp', container);
	document.getElementById(title).innerHTML="<img src=./resources/images/loading.gif></img>";
	
}

/**************************************************************************************************
 * 
 * 							LOAD  AUCTIONS LIST 		
 * 
 * @param responseXML
 ***************************************************************************************************/
function ParseAuctionList( responseXML, container, title ) {
	

	var auctionsList = responseXML.getElementsByTagName('auctionsList').item(0);

	//remove old elements
	  var oBody = document.getElementById(container);
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
		addElement(rowParams, container);
	}
	document.getElementById(title).innerHTML="<h2>Auction List</h2>";
}

/**************************************************************************************************
 * 							SEARCH AUCTIONS LIST 		
 * @param responseXML
 ***************************************************************************************************/
function ParseSearchedAuctionList( responseXML, container ) {
	

	var auctionsList = responseXML.getElementsByTagName('auctionsList').item(0);

	//remove old elements
	  var oBody = document.getElementById(container);
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
		addElement(rowParams, container);
		
	}
	
	document.getElementById("advSearchTitle").innerHTML="<h2>Search Results</h2>";
}

/**************************************************************************************************
 * 
 * 							ADD Retrieved Elements From AJAX To Table		
 * 
 * @param rowParams -->
 * @param container --> HTML Element ID that holds the table
 ***************************************************************************************************/
var theValue = 0;
function addElement( rowParams, container ) {
	
	  var ni = document.getElementById(container);
	  var num = (theValue-1)+2;
	  var newdiv = document.createElement('div');
	  var divIdName = 'my'+num+'Div';
	  newdiv.setAttribute('id',divIdName);
	  newdiv.setAttribute('class','div-table-row');

	  //remove old rows..
	  var oBody = document.getElementById(container);
	  
	 // Insert rows and cells into bodies.
	    oRow = oBody.insertRow(oBody.rows.length);
	    oRow.setAttribute('id', rowParams[0]);
	    
	  //checkbox
	    oCell = oRow.insertCell(-1);
	    oCell.setAttribute ('id', "checkBox" );
	    oCell.innerHTML = "<input type=checkbox />";

	   //name
	    oCell = oRow.insertCell(-1);
	    oCell.innerHTML = 
	    	"<a href='#' " +
	    	" onClick=viewDetails("+rowParams[0]+")>"+ rowParams[1] + "</a>";
	    
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
	}

/************************************************************************************************
 * 					REMOVE UNWANTED ENTRIES FROM THE PAGE 
 ************************************************************************************************/
function removeElement(container) {
	var tableBody=document.getElementById( container );
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



function loadAuctionTable(container, title)
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
		    
		    var responseText= ParseAuctionList(xmlhttp.responseXML, container, title);
	    	
	    }
	  }

	//send the parameters to the servlet with POST
	var Params = "";
	xmlhttp.open("POST","../auctionListAllServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
}

function loadUserOwnedAuctions(container, title)
{
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
		    
		    var responseText= ParseAuctionList(xmlhttp.responseXML,container, title);
	    	
	    }
	  }

	//send the parameters to the servlet with POST
	var Params = "Credential=" + credential;
	
	xmlhttp.open("POST","../auctionListUserPostedServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
}

function loadUserBiddedAuctions(container, title) {
	
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
		    
		    var responseText= ParseAuctionList(xmlhttp.responseXML,container, title);
	    	
	    }
	  }

	//send the parameters to the servlet with POST
	var Params = "Credential=" + credential;
	
	xmlhttp.open("POST","../auctionListUserBiddedServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

}
	

