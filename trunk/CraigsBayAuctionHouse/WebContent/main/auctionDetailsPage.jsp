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
								 <tr>  <th id="status">Status</th></tr>
								 <tr>  <th id="timeLeft">Time Left</th></tr>
								 <tr>  <th id="latestPrice">Latest Price</th></tr>
								 <tr>  <th id="numBids">Number of Bids</th></tr>
								 <tr>  <th id="lastBidder">Last Bidder</th></tr>
								 <tr>  <th id="category">Category</th></tr>
								 <tr>  <th id="auctionOwner">Owner</th></tr>
								 <tr>  <th id="picture"> Picture</th></tr>
													
							</thead>
							
							</tbody>
							
						 	</tbody>
						 	
						 	
							<tfoot>
								<!--  Bidding -->
								<tr> 
									<td> 

										<input type="button" onClick='bidOnAuction(<%= auctionID %>)' id="bidButton" disabled="true" value="Bid"> : $ <input type="text" id="bidAmount"/>  
										<div id="bidFeedback"> </div>
										
										<input type="button" onClick ='changeAuctionStatus(<%=auctionID %>)' id="changeStatusButton" disabled="true" value="Owner Option: Change Auction Status"/> :  										
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
					
									
					
					
						<textarea id="auctionChatHistory" readonly="readonly" rows="10" cols="40">
						Auction Chat
						</textarea>
						

						<textarea id="auctionChatInputText" cols="40" rows="1" disabled="true" align="left" >Post your questions...</textarea>
						<input id="auctionChatSubmit" type="button" value="Submit" disabled="true" onClick='sendAuctionChat(<%= auctionID %>)'/>
						
					
</div>



					<div>
					<h4>Scriptless badge:</h4>
					<a href="http://flickrbadge.theducky.com/tag/link/55164508@N02/tag2_1">
					<img src="http://flickrbadge.theducky.com/tag/photo/55164508@N02/tag2_1_s.jpg" alt="Scriptless Flickr Badge" /></a>
					</div>

       				

<!-- This import is for testing purposes -->
<script type="text/javascript" src='./resources/scripts/auctionDetailLoader.js'></script>
</body>
</html>






<!-- Deprecated Code, delete when necessary
<div id="flickrTest">
	<h4>This text should change to picture</h4>
</div>
<button type="button" id="flickrButton" onClick='displayBadges()'>Display Picture or die!</button>

<div id="hiddenBadge"style="visibility: hidden">
<script type="text/javascript" src="http://www.flickr.com/badge_code_v2.gne?show_name=1&count=1&display=latest&size=t&layout=v&source=user_tag&user=55164508%40N02&tag=tag2"></script>
</div>
 -->




