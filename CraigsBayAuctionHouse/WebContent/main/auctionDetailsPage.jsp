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