<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 
	<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		
		<title></title>
 <!-- ****************************INCLUDED CSS FILES********************************************************-->
		<!-- Main Stylesheet -->
		<link rel="stylesheet" href="./resources/css/contenBox.css" type="text/css" media="screen" />
		
 <!-- ****************************INCLUDED JAVASCRIPT FILES********************************************************-->
		<!-- jQuery -->
		<script type="text/javascript" src="./resources/scripts/jquery-1.3.2.min.js"></script>
		
		<!-- jQuery Configuration -->
		<script type="text/javascript" src="./resources/scripts/simpla.jquery.configuration.js"></script>
		
		<!-- jQuery WYSIWYG Plugin -->
		<script type="text/javascript" src="./resources/scripts/jquery.wysiwyg.js"></script>
		
		<script type="text/javascript" src="./resources/scripts/auctionListLoader.js"></script>

  <style type="text/css">
  	.div-table-row{display:table-row;}
  	.div-table-col{display:table-cell; padding: 5px; border: 1px solid #003399;}
  </style>
	
  </head>
   
  <body>
  
 <!--  this will get called when the page is dynamically loaded. -->
 <script>
 	loadUserBiddedAuctions('wantedItemArea', 'wantedItemTitle');
 </script>
  
 <input type="hidden" value="0" id="theValue" />
  
<!-- ***************************Start Content Box***************************** -->
			<div class="content-box">
				
				<div class="content-box-header">
					
					<h3>All Auction</h3>
					
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
								</tr>
								
							</thead>
						 
							<tfoot>
								<tr>
									<td colspan="6">
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
							
<!-- *************Entries Will be inserted here*******************-->
				<tbody id="myTable"></tbody>
<!--  *************************************************************-->
		</table>
						
	 </div> 
<!-- ***********************END~ Auction List*********************************************************************-->
	</div>         
	</div> <!-- End .content-box -->
<!-- ***********************************End .content-box-content*****************************************************-->
	<div class="clear"></div>
 
</body>
</html>
