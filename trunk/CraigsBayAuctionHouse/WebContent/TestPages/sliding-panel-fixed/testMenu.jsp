<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="testStyle.css" type="text/css" media="screen" />
<script type="text/javascript" src="http://jqueryjs.googlecode.com/files/jquery-1.3.2.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$(".trigger").click(function(){
		$(".panel").toggle("fast");
		$(this).toggleClass("active");
		return false;
	});
});
</script>

</head>
<body>
<div class="panel">
		<h3>Profile</h3>
		<img class="right" src="images/jon_image.jpg" alt="Jon Phillips" />
	<p>Admin</p>
	<p>Message</p>
	<p>My items</p>

<div style="clear:both;"></div>

	<div class="columns">
		<div class="colleft">
		<h3>Business</h3>
			<ul>
				<li><a href="1" title="home">Home</a></li>
				<li><a href="2" title="about">New Auction</a></li>
				<li><a href="3" title="portfolio">My Auction</a></li>
				<li><a href="4" title="contact">Won history</a></li>
			</ul>
		</div>
	
		<div class="colright">
			<h3>Social Network</h3>
			<ul>
				<li><a href="7" title="Twitter">My Profile</a></li>
				<li><a href="7" title="Twitter">My Messages</a></li>
				<li><a href="8" title="DesignBump">My Friends</a></li>
				<li><a href="9" title="Digg">Search People</a></li>
				
			</ul>
		</div>
	</div>
<div style="clear:both;"></div>

</div>
<a class="trigger" href="#">MENUS</a>

</body>
</html>