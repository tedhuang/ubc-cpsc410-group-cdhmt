<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		
		<title>sidebar</title>
		
		<!--                       CSS                       -->
	  
		<!-- Reset Stylesheet -->
		<link rel="stylesheet" href="resources/css/reset.css" type="text/css" media="screen" />
	  
		<!-- Main Stylesheet -->
		<link rel="stylesheet" href="resources/css/style.css" type="text/css" media="screen" />
		
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
		
	</head>
	
	
	<body><div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->
		
		<div id="sidebar"><div id="sidebar-wrapper"> <!-- Sidebar with logo and menu -->
			
			<h1 id="sidebar-title"><a href="#">Admin Panel</a></h1>
		  
			<!-- Logo (221px wide) -->
			<img id="logo" src="resources/images/panel.png" width="150" height="150" alt="Simpla Admin logo" />
		  
			<!-- Sidebar Profile links -->
			<div id="profile-links">
				Hello, <a href="#" title="Edit your profile">Admin</a>, you have <a href="#messages" rel="modal" title="3 Messages">3 Messages</a><br />
				<br />
				<a href="#" title="View the Site">View the Site</a> | <a href="/Home_Craigsbay/Login/index.html" title="Sign Out">Sign Out</a>
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
			
			</body>

</body>
</html>