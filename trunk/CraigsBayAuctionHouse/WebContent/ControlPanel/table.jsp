<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 
	<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		
		<title>Admin Panel</title>
		
		<!--                       CSS                       -->
	  
		
		<!-- Main Stylesheet -->
		<link rel="stylesheet" href="resources/css/contenBox.css" type="text/css" media="screen" />
		
		<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
		<link rel="stylesheet" href="resources/css/invalid.css" type="text/css" media="screen" />	
		
		<!-- Colour Schemes
	  
		Default colour scheme is green. Uncomment prefered stylesheet to use it.
		
		<link rel="stylesheet" href="resources/css/blue.css" type="text/css" media="screen" />
		
		<link rel="stylesheet" href="resources/css/red.css" type="text/css" media="screen" />  
	 
		-->
		
		<!-- Internet Explorer Fixes Stylesheet -->
		
		<!--[if lte IE 7]>
			<link rel="stylesheet" href="resources/css/ie.css" type="text/css" media="screen" />
		<![endif]-->
		
		<!--                       Javascripts                       -->
  
		<!-- jQuery -->
		<script type="text/javascript" src="resources/scripts/jquery-1.3.2.min.js"></script>
		
		<!-- jQuery Configuration -->
		<script type="text/javascript" src="resources/scripts/simpla.jquery.configuration.js"></script>
		
		<!-- Facebox jQuery Plugin -->
		<script type="text/javascript" src="resources/scripts/facebox.js"></script>
		
		<!-- jQuery WYSIWYG Plugin -->
		<script type="text/javascript" src="resources/scripts/jquery.wysiwyg.js"></script>
		
		<!-- Internet Explorer .png-fix -->
		
		<!--[if IE 6]>
			<script type="text/javascript" src="resources/scripts/DD_belatedPNG_0.0.7a.js"></script>
			<script type="text/javascript">
				DD_belatedPNG.fix('.png_bg, img, li');
			</script>
		<![endif]-->
		
	
	
	
	<!-- Ajax to add entries to the table -->

<script type="text/javascript">

function ParseXMLResponseTitle(responseXML)
{
	
	 var title = (responseXML.getElementsByTagName("title")[0]).childNodes[0].nodeValue;

	 return title;
}

/*
 * 
 function ParseXMLResponseBody(responseXML)
{
	// var body = (responseXML.getElementsByTagName("body")[0]).childNodes[0].nodeValue;
	// alert( (responseXML.getElementsByTagName("test")[0]).childNodes[0].nodeValue );
	//var body = "<button type=\"button\" > my dyanmaic button </button> ";
	var body = "<tr>"+
	    " <td><input type="checkbox" /></td>"+
		"<td><a href="#" title="title">IPhone 4G</td>"+
		"<td>Hot Bidding!</a></td>"+
		"<td>12 Hours</td>"+
		"<td>150</td>";
	
		
	 updatePage( body );
	
}
*/
function ParseXMLResponse(responseXML)
{
	
	 var item = (responseXML.getElementsByTagName("auctionItem")[0]).childNodes[0].nodeValue;
	 var status = (responseXML.getElementsByTagName("status")[0]).childNodes[0].nodeValue;
	 var timeLeft = (responseXML.getElementsByTagName("timeLeft")[0]).childNodes[0].nodeValue;
	 var price =(responseXML.getElementsByTagName("latestPrice")[0]).childNodes[0].nodeValue;

	 var responseText = "<h2>Get a entry: ";
	responseText += "<tr>" +
		"<td><input type=checkbox /></td>" +
		"<td><a href=index.html title=title>" +item + "</td>" +
		"<td>"+ status + "</a></td>" +
		"<td>"+ timeLeft +"</td>" +
		"<td>"+ price +"</td>" +"</tr>"; 
		 //item + status + timeLeft + price+ "</h2>";

	 updatePage(responseText);
}

function addEntry()
{
	var auctionItem=document.getElementById("auctionItem").value;
	var status=document.getElementById("status").value;
	var timeLeft=document.getElementById("timeLeft").value;
	var latestPrice=document.getElementById("latestPrice").value;
	
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
		    //var title= ParseXMLResponseTitle(xmlhttp.responseXML);
		    var responseText= ParseXMLResponse(xmlhttp.responseXML);
		    //alert("responseText: " + responseText);
		   
	    	//document.getElementById("myDiv").innerHTML=responseText;
	    	//document.getElementById("title").innerHTML=title;
	    	//document.getElementById("body").innerHTML=body;
	    }
	  }

	//send the parameters to the servlet with POST
	var Params = "auctionItem="+ auctionItem + "&status=" + status + "&timeLeft=" + timeLeft + "&latestPrice=" + latestPrice;
	
	xmlhttp.open("POST","../entryServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
	document.getElementById("myDiv").innerHTML="<h2>Please wait...getting entry</h2>";
}

function updatePage( testHTMLcode ) {
	bod 				= document.getElementsByTagName('body')[0];
	overlay 			= document.createElement('div');
	overlay.id		    = 'overlay';

	/*
	overlay.innerHTML   = '<div id=newDiv>' +
							+ testHTMLcode +
							+ '</div>';
	*/
	overlay.innerHTML = testHTMLcode;
	bod.appendChild(overlay);
}
	</script>
   </head>
  <body>
  
  Item: <input id="auctionItem" type="text" name="auctionItem" size="20"><br>
  Status: <input id="status" type="text" name="status" size="20"><br>
  Time Left: <input id="timeLeft" name="time left" size="20"><br>
  Latest Price: <input id="latestPrice" type="text" name="price" size="20"><br>
  
 
	<button type="button" onclick="addEntry()">ADD</button>
	<div id="myDiv"> Entry shows Here</div>
  
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
							
							<thead>
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
											<a class="button" href="#">Apply to selected</a>
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
							<tbody>
							
								<!-- Need DB access methods -->
								<tr>
									<td><input type="checkbox" /></td>
									<td><a href="#" title="title">IPhone 4G</td>
									<td>Hot Bidding!</a></td>
									<td>12 Hours</td>
									<td>150</td>
							 <!-- Need to generate automatically with the entry -->
									<td>
										<!-- Icons -->
										 <a href="#" title="Edit"><img src="resources/images/icons/pencil.png" alt="Edit" /></a>
										 <a href="#" title="Delete"><img src="resources/images/icons/cross.png" alt="Delete" /></a> 
										 <a href="#" title="Edit Meta"><img src="resources/images/icons/hammer_screwdriver.png" alt="Edit Meta" /></a>
									</td>
								</tr>
								
								
								<tr>
									<td><input type="checkbox" /></td>
									<td><a href="#" title="title">Adidas Samba</td>
									<td>Nobody's interested</a></td>
									<td>5 Days</td>
									<td>30</td>
									<td>
										<!-- Icons -->
										 <a href="#" title="Edit"><img src="resources/images/icons/pencil.png" alt="Edit" /></a>
										 <a href="#" title="Delete"><img src="resources/images/icons/cross.png" alt="Delete" /></a> 
										 <a href="#" title="Edit Meta"><img src="resources/images/icons/hammer_screwdriver.png" alt="Edit Meta" /></a>
									</td>
								</tr>
							</tbody>
							
						</table>
						
					</div> <!-- End #tab1 -->
					
					<div class="tab-content" id="tab2">
					
						<form action="" method="post">
							
							<fieldset> <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
								
								<p>
									<label>Small form input</label>
										<input class="text-input small-input" type="text" id="small-input" name="small-input" /> <span class="input-notification success png_bg">Successful message</span> <!-- Classes for input-notification: success, error, information, attention -->
										<br /><small>A small description of the field</small>
								</p>
								
								<p>
									<label>Medium form input</label>
									<input class="text-input medium-input" type="text" id="medium-input" name="medium-input" /> <span class="input-notification error png_bg">Error message</span>
								</p>
								
								<p>
									<label>Large form input</label>
									<input class="text-input large-input" type="text" id="large-input" name="large-input" />
								</p>
								
								<p>
									<label>Checkboxes</label>
									<input type="checkbox" name="checkbox1" /> This is a checkbox <input type="checkbox" name="checkbox2" /> And this is another checkbox
								</p>
								
								<p>
									<label>Radio buttons</label>
									<input type="radio" name="radio1" /> This is a radio button<br />
									<input type="radio" name="radio2" /> This is another radio button
								</p>
								
								<p>
									<label>This is a drop down list</label>              
									<select name="dropdown" class="small-input">
										<option value="option1">Option 1</option>
										<option value="option2">Option 2</option>
										<option value="option3">Option 3</option>
										<option value="option4">Option 4</option>
									</select> 
								</p>
								
								<p>
									<label>Textarea with WYSIWYG</label>
									<textarea class="text-input textarea wysiwyg" id="textarea" name="textfield" cols="79" rows="15"></textarea>
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
