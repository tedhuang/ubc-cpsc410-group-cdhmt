<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 
	<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		
		<title>Admin Panel</title>
		
		<!--                       CSS                       -->
	  
		
		<!-- Main Stylesheet -->
		<link rel="stylesheet" href="./resources/css/contenBox.css" type="text/css" media="screen" />
		
		<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
		<link rel="stylesheet" href="./resources/css/invalid.css" type="text/css" media="screen" />	
		
		<!-- Colour Schemes
	  
		Default colour scheme is green. Uncomment prefered stylesheet to use it.
		
		<link rel="stylesheet" href="./resources/css/blue.css" type="text/css" media="screen" />
		
		<link rel="stylesheet" href="./resources/css/red.css" type="text/css" media="screen" />  
	 
		-->
		
		<!-- Internet Explorer Fixes Stylesheet -->
		
		<!--[if lte IE 7]>
			<link rel="stylesheet" href="./resources/css/ie.css" type="text/css" media="screen" />
		<![endif]-->
		
		<!--                       Javascripts                       -->
  
		<!-- jQuery -->
		<script type="text/javascript" src="./resources/scripts/jquery-1.3.2.min.js"></script>
		
		<!-- jQuery Configuration -->
		<script type="text/javascript" src="./resources/scripts/simpla.jquery.configuration.js"></script>
		
		<!-- Facebox jQuery Plugin -->
		<script type="text/javascript" src="./resources/scripts/facebox.js"></script>
		
		<!-- jQuery WYSIWYG Plugin -->
		<script type="text/javascript" src="./resources/scripts/jquery.wysiwyg.js"></script>
		
		<script type="text/javascript" src="./resources/scripts/auctionListLoader.js"></script>
		
		<!-- Internet Explorer .png-fix -->
		
		<!--[if IE 6]>
			<script type="text/javascript" src="./resources/scripts/DD_belatedPNG_0.0.7a.js"></script>
			<script type="text/javascript">
				DD_belatedPNG.fix('.png_bg, img, li');
			</script>
		<![endif]-->
		
	
	

	
  <style type="text/css">
	
  	.div-table-row{display:table-row;}
  	.div-table-col{display:table-cell; padding: 5px; border: 1px solid #003399;}
  </style>
	
   </head>
   
  <body>
  
 <!--  this will get called when the page is dynamically loaded. -->
 <script>
 loadAuctionTable();
 </script>
  
  
  <input type="hidden" value="0" id="theValue" />
  
  <!--  
  Item: <input id="auctionItem" type="text" name="auctionItem" size="20"><br>
  Status: <input id="status" type="text" name="status" size="20"><br>
  Time Left: <input id="timeLeft" name="time left" size="20"><br>
  Latest Price: <input id="latestPrice" type="text" name="price" size="20"><br>
  
 <button type="button" onclick="loadAuctionTable()">LOAD</button>
	<a href=# onclick=removeElement();>Remove Selected Entry</a>'
  -->
  
  
	<div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->
		
		
		
		<div id="main-content"> <!-- Main Content Section with everything -->
			
			
			<div class="clear"></div> <!-- End .clear -->
			
      <!--      -----Start Content Box-----              -->
			<div class="content-box">
				
				<div class="content-box-header">
					
					<h3>Content box</h3>
					
					<ul class="content-box-tabs">
						<li><a href="#tab1" class="default-tab">Table</a></li> <!-- href must be unique and match the id of target div -->
						<li><a href="#tab2">Forms</a></li>
					</ul>
					
					<div class="clear"></div>
					
				</div> <!-- End .content-box-header -->
				
				<div class="content-box-content">
			   
					<div class="tab-content default-tab" id="tab1"> <!-- This is the target div. id must match the href of this div's tab -->
					
						
						<table>
							
							<thead id="tableHeader">
								<tr>
								   <th><input class="check-all" type="checkbox" /></th>
								   <th>Auction Item</th>
								   <th>Status</th>
								   <th>Time Left</th>
								   <th>Latest Price</th>
								   <th>Tools</th>
								</tr>
								
							</thead>
						 
							<tfoot>
								<tr>
									<td colspan="6">
										<div class="bulk-actions align-left">
											<select name="dropdown">
												<option value="option1">Choose an action...</option>
												<option value="option2">Edit</option>
												<option value="option3">Delete</option>
											</select>
											<a class="button" onclick=removeElement();>Apply to selected</a>
										</div>
								<!-- Need code to Generate Pages-->		
										<div class="pagination">
											<a href="#" title="First Page">&laquo; First</a><a href="#" title="Previous Page">&laquo; Previous</a>
											<a href="#" class="number current" title="1">1</a>
											<a href="#" class="number" title="2">2</a>
											<a href="#" class="number " title="3">3</a>
											<a href="#" class="number" title="4">4</a>
											<a href="#" title="Next Page">Next &raquo;</a><a href="#" title="Last Page">Last &raquo;</a>
										</div> <!-- End .pagination -->
										<div class="clear"></div>
									</td>
								</tr>
							</tfoot>
						 
						 <!-- Entries start here -->
						
							<tbody id="myTable">	
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
						
					</div> <!-- End #tab1 -->
					
					<div class="tab-content" id="tab2">
					
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
						
					</div> <!-- End #tab2 -->        
					
				</div> <!-- End .content-box-content -->
				
			</div> <!-- End .content-box -->
			
			
			<div class="clear"></div>
			
			
			
			
			<div id="footer">
				<small>
						&#169; CraigsBay Admin Control Panel</a>
				</small>
			</div><!-- End #footer -->
			
		</div> <!-- End #main-content -->
		
	</div></body>
  
</html>
