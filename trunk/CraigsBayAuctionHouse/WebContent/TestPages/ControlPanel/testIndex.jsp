<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
 
	<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		
		<title>Welcom to CraigsBay</title>
		
		<!--                       CSS                       -->
	  
		<!-- Reset Stylesheet -->
		<link rel="stylesheet" href="resources/css/reset.css" type="text/css" media="screen" />
	  
		<!-- Main Stylesheet -->
		<link rel="stylesheet" href="resources/css/style.css" type="text/css" media="screen" />
		
		<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
		<link rel="stylesheet" href="resources/css/invalid.css" type="text/css" media="screen" />	
		
		<!-- login css -->
		<link rel="stylesheet" href="./resources/css/lightbox.css" media="screen,projection" type="text/css" />
		
		
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
		
	<!-- Functions -->
	<script type="text/javascript">
	function viewAllAuctions()
	{
		loadobjs('./resources/scripts/auctionListLoader.js'); //load the additional javascript tableLoad.jsp requires
		ajaxpage('tableLoad.jsp', 'Dynapage'); //load tableLoad.jsp in to div Dynapage
		document.getElementById("surferTitle").innerHTML="Loading...";
		
	}
	</script>
	<script type="text/javascript">
	function createAuction()
	{
		ajaxpage('createAuctionTable.jsp', 'Dynapage')
		loadobjs('./resources/scripts/createAuction.js');
	}
	</script>
		
	</head>
  	
  	<% 
		String cred = request.getParameter("cred");
		String userName = request.getParameter("name");
		
		if(userName == null || userName == "")
		{
			userName = "Guest";
		}
	%>
	<input id="cred" type="hidden" value=<%= cred %>>
  	
	<body><div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->
		
		<div id="sidebar"><div id="sidebar-wrapper"> <!-- Sidebar with logo and menu -->
			
			<h1 id="sidebar-title"><a href="#">Tool</a></h1>
		  
			<!-- Logo (221px wide) -->
			<img id="logo" src="resources/images/panel.png" width="150" height="150" />
		  	
		  	<ul>
			<li><a href="../main/Login.jsp" class="lbOn">Login From Here</a></li>
			</ul>
			<div id="profile-links">
				Hello, <a href="#" title="Edit your profile">

				<%= userName %>
				
				</a>, you have <a href="#messages" rel="modal" title="3 Messages">3 Messages</a><br />
				
				<br />
				<a href="#" title="View the Site">View the Site</a> | 
				<%  
				if(userName != "Guest")
				{
					
				%>
				<a href="../main" title="Sign Out">Sign Out</a>
				
				<%
				}
				else
				{
				%>
				<a href="../main/Login.jsp" class="lbOn" title="Sign In">Sign In</a>
				<%
				}
				%>
				
							
			</div>      
			
			<ul id="main-nav">  <!-- Accordion Menu -->
				
				
				<li>
					<a href="#" class="nav-top-item">
						Auctions
					</a>
					<ul>
						<li OnClick="viewAllAuctions()"><a href=#>View All Auctions</a></li>
						<li OnClick="createAuction()"><a href="#">New Auction</a></li>
						<li><a href="#">Manage Auction</a></li>
					</ul>
				</li>
				
				<li>
					<a href="#" class="nav-top-item">
						Social Nectwork
					</a>
					<ul>
						<li><a href="#">Start a Chat</a></li>
						<li><a href="#">Friends</a></li>
						<li><a href="#">Chat history</a></li>
						
					</ul>
				</li>
				
				<li>
					<a href="#" class="nav-top-item">
						Settings
					</a>
					<ul>
						<li><a href="#">General</a></li>
						<li><a href="#">Design</a></li>
						<li><a href="#">Your Profile</a></li>
						<li><a href="#">Users and Permissions</a></li>
					</ul>
				</li>      
				
			</ul> <!-- End #main-nav -->
			
			<div id="messages" style="display: none"> <!-- Messages are shown when a link with these attributes are clicked: href="#messages" rel="modal"  -->
				
				<h3> Messages</h3>
			 
				<p>
					<strong>17th May 2009</strong> by Admin<br />
					This is a messege for the admin
					<small><a href="#" class="remove-link" title="Remove message">Remove</a></small>
				</p>
				
				<form action="" method="post">
				
					<h4>New Message</h4>
					
					<fieldset>
						<textarea class="textarea" name="textfield" cols="79" rows="5"></textarea>
					</fieldset>
					
					<fieldset>
					
						<select name="dropdown" class="small-input">
							<option value="option1">Send to...</option>
							<option value="option2">Everyone</option>
							<option value="option3">Admin</option>
							<option value="option4">Jane Doe</option>
						</select>
						
						<input class="button" type="submit" value="Send" />
						
					</fieldset>
					
				</form>
				
			</div> <!-- End #messages -->
			
		</div></div> <!-- End #sidebar -->
		
		<!-- Dynamic Page Starts Here -->
			<div id="main-content">
			<h2><div id="surferTitle">Welcome <%= userName %></div></h2>
			
			<div id="Dynapage">
			Dynamic page is here
			</div>
			</div>
		
	</div></body>
  
</html>
