<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Auction</title>
<link rel="stylesheet" href="../main/resources/css/contenBox.css" type="text/css" media="screen" />

<script language="javascript"> 
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
</script>

</head>
<body>

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