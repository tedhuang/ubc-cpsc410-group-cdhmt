<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Auction</title>

</head>
<body>

<br>

<%
String auctionID = request.getParameter("auctionID");
%>

<input type="hidden" value="-1" id="ownerID">
<input type="hidden" value="-1" id="latestBidPrice">
<input type="hidden" value="" id="ownersName">

 <!--  this will get called when the page is dynamically loaded. -->
<script>
viewAuctionByID(<%=auctionID%>);
refreshAuctionChat(<%=auctionID%>);
</script>

<div class="content-box-content">
			   
	<div class="tab-content default-tab" id="infoTab"> <!-- This is the target div. id must match the href of this div's tab -->
		<table>
			<thead id="tableHeader">
				
				 <tr> <th id="auctionItem">Auction Item </tr>
				 <tr>  <th id="auctionOwner">Owner</th>
				 </tr>
				 <tr> <th id="auctionDescription">Auction Description </tr>
				 <tr>  <th id="status">Status</th></tr>
				 <tr>  <th id="timeLeft">Expiry Date</th></tr>
				 <tr>  <th id="timeLeftHours">Time to Expire</th></tr>
				 <tr>  <th id="latestPrice">Latest Price</th></tr>
				 <tr>  <th id="numBids">Number of Bids</th></tr>
				 <tr>  <th id="lastBidder">Last Bidder</th></tr>
				 <tr>  <th id="category">Category</th></tr>
			     <tr>  <th id="flag" ></th></tr>
				 
			</thead>
			
			</tbody>
			
		 	</tbody>
		 	
		 	
			<tfoot>
				<!--  Bidding flow or auction status change for the auction owner-->
				<tr> 
					<td> 
					
					<input type="button" onClick='bidOnAuction(<%= auctionID %>, "detailTitle", "bidFeedback")' id="bidButton" disabled="true" value="Bid"> : $ <input type="text" id="bidAmount" disabled="true"/>  
					<div id="bidFeedback"> </div>
					
					<input type="button" onClick ='changeAuctionStatus(<%=auctionID %>, "detailTitle", "bidFeedback")' id="changeStatusButton" disabled="true" value="Owner Option: Change Auction Status"/> :  										
					<select name="changeStatusValue" id="changeStatusValue" disabled="true" onchange="handleStatusSelectionChange()">
						<option value="OPEN">Open</option>
						<option value="CLOSED">Closed</option>
						<option value="EXPIRED">Expired</option>
					</select>
						
					<br>	
					Expire In... :
					Weeks:<select id="ExpiryWeekAuctionOwnerChange" name="ExpiryDateAuctionOwnerChange" disabled="true">
					<option value="0"></option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
					<option value="4">Four</option>
					</select>
					Days:<select id="ExpiryDayAuctionOwnerChange"" name="ExpiryDateAuctionOwnerChange" disabled="true">
					<option value="0"></option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
					<option value="4">Four</option>
					<option value="5">Five</option>
					<option value="6">Six</option>
					</select>
					Hours:<select id="ExpiryHourAuctionOwnerChange" name="ExpiryDateAuctionOwnerChange" disabled="true">
					<option value="0"></option>
					<option value="6">Six</option>
					<option value="12">Twelve</option>
					<option value="18">Eighteen</option>
					</select><br>

					</td>
				</tr>
				
				
			</tfoot>
		
			
		</table>
		
		
		
	</div> <!-- End #infoTab -->
	
	<!-- We used a external flickr service to help us display the Flickr Badge without having to use javascript
		 because we could not get Flickr's javascript to run correctly in our dynamically loaded web page 
		 the down side is that this usually takes around 10-15min for the image that we uploaded to be displayed-->				
	<div id=flickrImage> <!-- http://flickrbadge.theducky.com/ -->
	<h5><i><font face="Bookman Old Style, Book Antiqua, Garamond">Picture by Flickr:</font></i></h5>
	
	<a href=<%="http://flickrbadge.theducky.com/tag/link/55164508@N02/" +  auctionID + "_1"%>>
	<img src= <%="http://flickrbadge.theducky.com/tag/photo/55164508@N02/" + auctionID + "_1_m.jpg" %> alt="Picture By Flickr:" /></a>
	</div>
	
		<textarea id="auctionChatHistory" readonly="readonly" rows="10" cols="40">
			Auction Chat
		</textarea>

		<textarea id="auctionChatInputText" cols="40" rows="1" disabled="true" align="left" >Post your questions...</textarea>
		<input id="auctionChatSubmit" type="button" value="Submit" disabled="true" onClick='sendAuctionChat(<%= auctionID %>)'/>
					
</div>

</body>
</html>




