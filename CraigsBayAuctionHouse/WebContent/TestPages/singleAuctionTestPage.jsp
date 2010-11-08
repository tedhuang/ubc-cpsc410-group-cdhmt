<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Auction</title>
<link rel="stylesheet" href="../main/resources/css/contenBox.css" type="text/css" media="screen" />

<script language="javascript"> 
var credential = null;

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

function loginParseXMLResponse(responseXML)
{
	
	 var toCredential = (responseXML.getElementsByTagName("userCred")[0]).childNodes[0].nodeValue;

	 return toCredential;
}

function Login() {
	var userName = document.getElementById("user").value;
	var password = document.getElementById("pw").value;
	
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
		    credential= loginParseXMLResponse(xmlhttp.responseXML);
	    	//document.getElementById("loginDiv").innerHTML=credential;
	    }
	  }

	var Params = "userName=" + userName + "&password=" + password;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../userLoginServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

}

function viewAuctionByID( ){
	var auctionID = document.getElementById("auctionID").value;
	
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
    var oBody = document.getElementById('myDiv');

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

</script>

</head>
<body>
User <input id="user" type="text" name="" size="20"><br>
PW: <input id="pw" type="text" name="" size="20"><br>
<button type="button" onclick="Login()">Login</button><br>
<br>
Auction: <input id="auctionID" type="text" name="" size="20"><br>
<button type="button" onclick="viewAuctionByID()">Get Auction</button><br>

<div class="content-box-content">
			   
					<div class="tab-content default-tab" id="infoTab"> <!-- This is the target div. id must match the href of this div's tab -->
					
						
						<table>
							
							<thead id="tableHeader">
								
								 <tr>  <th>Auction Item</th></tr>
								 <tr>  <th>Status</th></tr>
								 <tr>  <th>Time Left</th></tr>
								 <tr>  <th>Latest Price</th></tr>
								 <tr>  <th>Number of Bids</th></tr>
								 <tr>  <th>Last Bidder</th></tr>
								 <tr>  <th>Category</th></tr>
								 <tr>  <th>Owner</th></tr>
								 <tr>  <th>Picture</th></tr>
								 
								 
								
								
							</thead>
							
						 
							<tfoot>
								<tr>
									<td colspan="6">
										<div class="bulk-actions align-left">
											<select name="dropdown">
												<option value="option1">Choose an action...</option>
												<option value="edit">Edit</option>
												<option value="delete">Delete</option>
											</select>
											<a class="button" href="#">Apply to selected</a>
										</div>
								<!-- Need code to Generate Pages-->		
										<div class="clear"></div>
									</td>
								</tr>
							</tfoot>
						 
						 <!-- Entries start here -->
						<tbody id="myDiv">	
									<!-- 
								<tr>
								 
								<td> 
								
								 <div id="myDiv" > Entry shows Here 
		
									
									
								</div>
								 -->
								 <!-- 
								 </td>
								 
								</tr>
								-->
								<p>Entries</p>
								
							</tbody>
							
						
							
						</table>
						
					</div> <!-- End #infoTab -->
					<a id="displayText" href="javascript:toggle();">show Editing Table</a> <== click Here
					
					<div style="display: none" class="tab-content"  id="editTab">
					 <h2>Edit Your Auction</h2> 
						<form action="" method="post">
							
							<fieldset> <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
								
								<p>
									<label>Title</label>
										<input class="text-input large-input" type="text" id="title-input" name="title-input" />
										<br /><small>Edit the Title Here</small>
								</p>
								<p>
									<label>Category</label>              
									<select name="dropdown" class="small-input">
										<option value="option1">Option 1</option>
										<option value="option2">Option 2</option>
										<option value="option3">Option 3</option>
										<option value="option4">Option 4</option>
									</select> 
								</p>
								<p>
									<label>Price</label>
									<input class="text-input small-input" type="text" id="category-input" name="category-input" />
									<br /><small>Price Cannot be Changed Once Bidding is Started</small>
								</p>
								
								<p>
									<label>Flickr Picture URL</label>
									<input class="text-input small-input" type="text" id="large-input" name="large-input" />
								</p>
								<p>
									<label>Conditions</label>
									<input type="checkBox" name="checkbox1" /> New </br>
									<input type="checkBox" name="checkbox2" />Used
								</p>
								
								<p>
									<label>Shipping</label>
									<input type="radio" name="freeship" /> Free Shipping </br>
									<input type="radio" name="nFreeship" /> Shipping By Rates</br>
									<input type="radio" name="pickup" /> Local-Pickup Only
								</p>
								
								<p>
									<label>Refund Policy</label>
									<input type="radio" name="radio1" /> Non-Refundable<br />
									<input type="radio" name="radio2" /> Refundable
								</p>
								<p>
									<label>Payment</label>
									<input type="checkBox" name="pmcash" /> Cash </br>
									<input type="checkBox" name="pmchk" /> Checks</br>
									<input type="checkBox" name="pmOther" /> Other 
									<input type="text" id="otherPayment" name="other-Payment" />
								</p>
							
								
								<p>
									<label>Details</label>
									<textarea class="text-input textarea wysiwyg" id="detail-input" name="detailInput" cols="79" rows="15"></textarea>
								</p>
								
								<p>
									<input class="button" type="submit" value="Submit" />
								</p>
								
							</fieldset>
							
							<div class="clear"></div><!-- End .clear -->
							
						</form>
						
					</div> <!-- End #editTab -->  
</div>





</body>
</html>