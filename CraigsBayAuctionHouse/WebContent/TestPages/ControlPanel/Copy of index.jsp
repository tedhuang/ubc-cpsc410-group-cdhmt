<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		
		<title>Welcome To CS410 Project</title>
		
<!-- Meta Tags -->
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="robots" content="index, follow" />

<!-- CSS -->


<!-- JavaScript -->

		
		<!--                       CSS                       -->
	  
		<!-- Reset Stylesheet -->
		<link rel="stylesheet" href="../resources/css/reset.css" type="text/css" media="screen" />
	  
		<!-- Main Stylesheet -->
		<link rel="stylesheet" href="../resources/css/style.css" type="text/css" media="screen" />
		
		<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
		<link rel="stylesheet" href="../resources/css/invalid.css" type="text/css" media="screen" />	
		
		<!-- login css -->
		<link rel="stylesheet" href="../resources/css/default.css" media="screen,projection" type="text/css" />
		<link rel="stylesheet" href="../resources/css/lightbox.css" media="screen,projection" type="text/css" />
		
		<!--                       Javascripts                       -->
  
		<!-- jQuery -->
		<script type="text/javascript" src="../resources/scripts/jquery-1.3.2.min.js"></script>
		
		<!-- jQuery Configuration -->
		<script type="text/javascript" src="../resources/scripts/simpla.jquery.configuration.js"></script>
		
		<!-- Facebox jQuery Plugin -->
		<script type="text/javascript" src="../resources/scripts/facebox.js"></script>
		
		<!-- jQuery WYSIWYG Plugin -->
		<script type="text/javascript" src="../resources/scripts/jquery.wysiwyg.js"></script>
		
		<!-- Login script -->
		<script type="text/javascript" src="../resources/scripts/prototype.js"></script>
		<script type="text/javascript" src="../resources/scripts/lightbox.js"></script>
		
		<!-- Internet Explorer .png-fix -->
		
		<!--[if IE 6]>
			<script type="text/javascript" src="resources/scripts/DD_belatedPNG_0.0.7a.js"></script>
			<script type="text/javascript">
				DD_belatedPNG.fix('.png_bg, img, li');
			</script>
		<![endif]-->
		
	</head>
	
	
	<body><div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->
		
		<div id="sidebar"><div id="sidebar-wrapper"> <!-- Sidebar with logo and menu -->
			
			<h1 id="sidebar-title"><a href="#">Admin Panel</a></h1>
		  
			<!-- Logo (221px wide) -->
			<img id="logo" src="../resources/images/lighthouse.gif" width="100" height="100" alt="logo" />
		  
			<!-- Sidebar Profile links -->
			<ul>
			<li><a href="Login.jsp" class="lbOn">Login From Here</a></li>
			</ul>
			<div id="profile-links">
				Hello, <a href="#" title="Edit your profile">Admin</a>, you have <a href="#messages" rel="modal" title="3 Messages">3 Messages</a><br />
				<br />
				<a href="#" title="View the Site">View the Site</a> | <a href="/CraigsBayAuctionHouse/Login/index.html" title="Sign Out">Sign Out</a>
			</div>        
			
			<ul id="main-nav">  <!-- Accordion Menu -->
				
				
				<li>
					<a href="#" class="nav-top-item">
						Auctions
					</a>
					<ul>
						<li><a href="#">New Auction</a></li>
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
			
			</div><!-- Sidebar Style ends here -->
			</div><!-- Siderbar ends here -->
			
			<!-- Dynamic Page Starts Here -->
			<div id="main-content">
			<h2><div id="surferTitle">Welcome Guest</div></h2>
			
			<div id="Dynapage">
			Dynamic page is here
			</div>
			</div>
			
			
		</div><!-- Page style ends here -->	
		</body><!-- Whole body ends here -->

</html>