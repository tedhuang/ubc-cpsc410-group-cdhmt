<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		
		<title>Welcome To CS410 Project</title>
		
<!-- **************************INCLUDED CSS*********************************************************-->
	  
		<!-- Reset Stylesheet -->
		<link rel="stylesheet" href="./resources/css/reset.css" type="text/css" media="screen" />
	  
		<!-- Main Stylesheet -->
		<link rel="stylesheet" href="./resources/css/style.css" type="text/css" media="screen" />
		
		<!-- Sliding Menu Style -->
		<link rel="stylesheet" href="./resources/css/slidingMenu.css" type="text/css" media="screen" />
		
		<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
		<link rel="stylesheet" href="./resources/css/invalid.css" type="text/css" media="screen" />	
		
		<!-- login css -->
		<link rel="stylesheet" href="./resources/css/loginBubble.css" media="screen,projection" type="text/css" />
		
		<!-- Tab Panel References -->
		<link rel="stylesheet" href="./resources/css/tab-view.css" type="text/css" media="screen">
		<script type="text/javascript" src="./resources/scripts/tabPanelAjax.js"></script>
		<script type="text/javascript" src="./resources/scripts/tab-view.js"></script>
		
		<!-- New Lightbox Login -->
		<link type="text/css" rel="stylesheet" href="./resources/css/lightbox-form.css">
		<script src="./resources/scripts/lightbox-form.js" type="text/javascript"></script>
		
<!-- *************************INCLUDED Javascripts**************************************************-->
		<!-- jQuery -->
		<script type="text/javascript" src="./resources/scripts/jquery-1.3.2.min.js"></script>
		
		<!-- jQuery Configuration -->
		<script type="text/javascript" src="./resources/scripts/simpla.jquery.configuration.js"></script>
		
		<!-- Facebox jQuery Plugin 
		<script type="text/javascript" src="./resources/scripts/facebox.js"></script>-->
		
		<!-- jQuery WYSIWYG Plugin -->
		<script type="text/javascript" src="./resources/scripts/jquery.wysiwyg.js"></script>
		
		<!--  Ajax Loader Script -->
		<script type="text/javascript" src="./resources/scripts/dynamicAjaxLoader.js"></script>
		
		<!--  Javascript files -->
		<script type="text/javascript" src='./resources/scripts/auctionDetailLoader.js'></script>
		<script type="text/javascript" src='./resources/scripts/auctionListLoader.js'></script>
		<script type="text/javascript" src='./resources/scripts/createAuction.js'></script>
		<script type="text/javascript" src='./resources/scripts/friends.js'></script>
		<script type="text/javascript" src='./resources/scripts/userControlPanel.js'></script>
		<script type="text/javascript" src='./resources/scripts/chatServices.js'></script>
		<script type="text/javascript" src='./resources/scripts/flickrAPI.js'></script>
		<script type="text/javascript" src='./resources/scripts/registerUser.js'></script>
		<script type="text/javascript" src='./resources/scripts/general.js'></script>

		
		
<!-- *********************Functions**********************************************-->

<script type="text/javascript">
	var insideTab;
	function getContain(elementID)
	{
		insideTab=document.getElementById(elementID).innerHTML;
	}
</script>
<!-- ****************************chat Function ********************************************-->	

<script type="text/javascript">
	function chatFriend( friendID ) 
	{
		showChatTab( "Your Friend" , friendID);
	}
</script>

<!-- ***********************jQuery for Sliding Menu Behavior*************************************-->
		<script type="text/javascript">
		$(document).ready(function(){
			$(".trigger").click(function(){
			$(".panel").toggle("fast");
			$(this).toggleClass("active");
			return false;
		});
		});
	</script>

</head> <!-- END OF HEADER -->
	
<!-- ********************************CREDENTIAL CHECK *****************************************-->
	
	<% 
		String cred = request.getParameter("cred");
		String userName = request.getParameter("name");
		String loggedInUserID = request.getParameter("loggedInUserID");
		
		if(userName == null || userName == "")
		{
			userName = "Guest";
		}
		else
		{

		}
	%>
	
	<input id="cred" type="hidden" value=<%= cred %>>
	<input id="userName" type="hidden" value=<%= userName %>>
	<input id="loginUserID" type="hidden" value=<%=loggedInUserID %>>
	

	<% 
	if(userName != "Guest")
	{
	%>
		<div id="floadMenu">
				<a class="trigger" href="#">Menu</a>
		</div>
		
		
		<script language="javascript">

		//setInterval("getMsg("+ document.getElementById("loginUserID").value + ")", 5000)
		</script>
	<%
	}
	%>

	<body><div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->

<!-- ****************************Sidebar Starts Here*****************************************-->
<!-- S LIGHTBOX LOGIN -->
	<div id="filter"></div>
	<div id="loginBox" class="box" onkeypress="{if (event.keyCode==13)userLoginRequest()}">
			  
	  <form id= "close" name="close" method="post" title="Close" >
			<input id="submitCred" type="hidden" name="cred"/>
			<input id="name" type="hidden" name="name" />
			<input id="submitUserID" type="hidden" name="loggedInUserID" />
			<!-- <input type="image" src="./resources/images/minus.png" name="image" />
			 -->
	  </form>
	  
	<input type="image" src="./resources/images/login-cancle.png" 
			class="login-icon" style="margin-right:20px;" 
			type="button" name="cancel" value="Cancel" onclick="closebox('loginBox');document.getElementById('myDiv').innerHTML='<h2>WELCOME</h2>'">  
	<div id="login-box-name" style="margin-top:70px; margin-left:100px;">User:</div>   
	<div id="login-box-field" >
	  	<input id="username" name="username" class="form-login" title="Username" value="" size="10" maxlength="2048" />
	</div>
			
	<div id="login-box-name" style="margin-top:0px; margin-left:130px;">Password:</div>
	<div id="login-box-field">
		<input id="password" name="password" type="password" class="form-login" title="Password" value="" size="30" maxlength="2048" />
	</div>
	<div id="loginLoading" class="login-icon" style="margin-button:100px; margin-left:500px;"></div>
		<!-- LOGIN BUTTON -->
	<input type="image" src="./resources/images/login-go.png" class="login-icon" title="go!" style="margin-left:400px;" onclick="userLoginRequest()" >		
	<div style="margin-top:300px;" id="myDiv"><h2>Welcome!</h2></div>
	</div>
<!-- *********************************Register ***********************************************-->
<div id="filter"></div>
	<div id="regBox">
	<span id="boxtitle"></span> 
	Username: <input id="Username" type="text" name="Password" size="20"><br>
	Password: <input id="Password" type="password" name="Password" size="20"><br>
	Repeat Password: <input id="PasswordCheck" type="password" name="Password" size="20"><br>
	Phone Number: <input id="PhoneNumber" type="text" name="PhoneNumber" size="20"><br>
	Phone Carrier:<select id="PhoneCarrier"  name="PhoneCarrier">
				<option value="Fido">Fido</option>
				<option value="Rogers">Rogers</option>
				<option value="Telus">Telus</option>
				<option value="Bell">Bell</option>
				<option value="Virgin Mobile">Virgin Moblie</option>
				<option value="PC Mobile">PC Moblie</option>
				<option value="Koodo">Koodo</option>
				<option value="SaskTel">SaskTel</option>
				<option value="Manitoba Telecom">Manitoba Telecom</option>
		  	</select><br>
	E-mail Address: <input id="EmailAddress" type="text" name="EmailAddress" size="20"><br>

	<div id="feedBack"><h2>Feedback Area</h2></div>
	<button id='Submit' type="button"  onclick="createUserRequest()">Submit Info</button>
</div>
<!-- **********************************SIGN OUT Lightbox********************************************* -->
<div id="filter"></div>
<div id="sign-outLoading" class="signIOBox"><h4>You Are Signing Out...See you soon!</h4></div>
<!-- **********************************SIGN IN Lightbox********************************************* -->
<div id="sign-inLoading" class="signIOBox" style="text-indent: 2cm;"><h4>Signing in...</h4></div>


<!-- ***************************************************************************************-->	
	  					<!-- ~ENDS: NEW LIGHTBOX LOGIN -->	
<!-- ***************************************************************************************-->

   <div id="sidebar"><div id="sidebar-wrapper"> <!-- Sidebar with logo and menu -->
			
		<h1 id="sidebar-title"><a href="#">Admin Panel</a></h1>
		  
	  <!-- Logo (221px wide) -->
	  <img id="logo" src="./resources/images/logo.png" style="float:center;margin-left:20px;margin-bottom:50px">

<!-- *******************************Sidebar Profile links *********************************-->
		<div id="profile-links">
			Hello, 
	
			<%= userName %>
			 
			<%  
			if(userName != "Guest")
			{
				
			%>
			<br />
			<p><a href="#" id="acc-inbox" title="View your Messages"> My Messages</a> | 
			<a href="#" id="log-out" title="Sign Out" onclick="userLogoutRequest();openbox('sign-outLoading','',1)">Sign Out</a> </p>
			
			<%
			}
			else
			{
			%>
			<p>Already A Member? <a href="#" id="sign-in" onclick="openbox('loginBox','', 1)">Sign-in</a></p>
			<p>Not A Member? <a href=# id="sign-up" title="REGISTER" onclick="openbox('regBox','Register', 1)" >&nbsp;</a></p>
			<!-- "./registerUser.jsp" -->
			<%
			}
			%>
		</div>        
			
<!-- **************************** Quick Tools ********************************************************-->			
			
			<ul id="main-nav">  <!-- Accordion Menu -->
				
				<li>
					<a href="#" class="nav-top-item">
						Auctions
					</a>
					<ul>
						<li OnClick="viewAllAuctions('allItemArea','allItemTitle')"><a href=# id="all-items">View All Auctions</a></li>
						<%  
							if(userName != "Guest")
							{
						%>
						
						<li OnClick="showNewAuctionTab()"><a href="#" id="newItem">New Auction</a></li>
						<li OnClick="viewUserAuctions('myAuctionArea','myAuctionTitle');"><a href="#" id="my-item">Manage My Auctions</a></li>
						<li OnClick="viewBiddedAuctions('wantedItemArea', 'wantedItemTitle');"><a href="#" id="myBid">My Bids</a></li>
						<%
							}
						%>
						<li> <input type="text" id="searchTitle" value="Search" 
									onblur="if (this.value=='') { this.value='Search'; }" 
									onfocus="if (this.value=='Search') { this.value=''; }"
									onkeypress="{if (event.keyCode==13)searchAuctionTable('0')}"
									/></li>
						<li>
							<input type="image" src="./resources/images/advancedSearch.png" title="Advanced Search" onClick="showAdvancedSearchTab()"/>
							<input type="image" src="./resources/images/search-btn.png" title="Search" onClick="searchAuctionTable(0);"/>
						</li>
					</ul>
				</li>
				
				<li>
					<a href="#" class="nav-top-item">
						Social Network
					</a>
					<ul>
						<%  
							if(userName != "Guest")
							{
						%>
						<!-- <li><a href="#" onClick="showChatTab()">Start a Chat</a></li> -->
						<li OnClick="viewFriends('friendTable')"><a href="#" id="friends">Friends</a></li>
						<!-- <li><a href="#">Chat history</a></li> -->
						
						<%						
							}
							else
							{
						%>
						<p>You are a GUEST</p>
						<P>Why not Join Us and Make Some Friends?</p>
						<%
							}
						%>
					</ul>
				</li>
				
				<%
						if(userName!="Guest")
						{
				%>
			<li>
					<a href="#" class="nav-top-item">
						Settings
					</a>
				<ul>
						
					<li OnClick="openProfilePage('profileArea','profileTitle')"><a href="#" id="profile">Your Profile</a></li>
						
	
				</li>    
				<%
						}
				%>  
				
			</ul> <!-- End #main-nav -->
			
			</div><!-- Sidebar Style ends here -->
			</div>
<!-- *******************************Siderbar ends here*******************************************-->
			
	  
			
<!-- **************************Dynamic Page Starts Here*****************************************-->
			
		<div id="main-content">

<!-- **************************Sliding Menu Starts here****************************************-->
			
			<div class="panel">
			  <p><h3><%= userName %></h3></p>
				<img class="right" src="./resources/images/happy.jpg" />
							<p><a href=# id="acc-inbox">Messages</a> | 
							<a href=# id="profile" OnClick="openProfilePage('profileArea','profileTitle')">Profile</a> |
							<a href="#" id="log-out" title="Sign Out" onclick="userLogoutRequest()">Sign Out</a></p>
						
						<div style="clear:both;"></div>
						
							<div class="columns">
								<div class="colleft">
								<h3>Business</h3>
									<ul>
										<li OnClick="viewAllAuctions('allItemTitle','allItemArea')"><a href=# id="all-items">All Auctions</a></li>
										<li OnClick="showNewAuctionTab()"><a href="#" id="newItem">New Auction</a></li>
						<li OnClick="viewUserAuctions('myAuctionArea','myAuctionTitle');"><a href="#" id="my-item">My Auctions</a></li>
						<li OnClick="viewBiddedAuctions('wantedItemArea', 'wantedItemTitle');"><a href="#" id="myBid">My Bids</a></li>
									</ul>
								</div>
							
								<div class="colright">
									<h3>Social Network</h3>
								<ul>
									<li OnClick="viewFriends('friendTable')"><a href="#" id="friends">Friends</a></li>
									<li><a href="9" title="Digg">Search People</a></li>
										
								</ul>
							</div>
						</div>
					<div style="clear:both;"></div>
						
						</div>
						
	<% 
	if(userName != "Guest")
	{
	%>
				  <a class="trigger" href="#">MENUS</a>
				  
	<%
	} 
	%>
				
				

		
<!-- **********************************End~ of Sliding Menu *************************************

***************************************Tab Panel Starts here*************************************-->
	   <div id="tabHolder">
		<div id="tabPanel">
				
				<!-- Main Tab -->
				<div class="dhtmlgoodies_aTab">
					 
					<h2><div id="surferTitle">Welcome <%= userName %></div></h2><br>
					<div id="Dynapage">
						Dynamic page is here
						<a href=# id='Harry' onClick="preloadFriends('tempTable')">Chat tab test</a>
						<a class="shortcut-button manage-comments" href="#messages" 
						rel="modal"><span class="png_bg">Messeages</span></a>
			<div id="messages" style="display: none"> <!-- Messages are shown when a link with these attributes are clicked: href="#messages" rel="modal"  -->
				
				<h3> Messages</h3>
			 
				<p>
					<strong>Dec 4th 2010</strong> by Admin<br />
					Demo this day.
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
					
					</div><br>
				</div>
				
				<!--  tip tab-->
				<div class="dhtmlgoodies_aTab">
					This is the content of the second tab.	<br>
					<a href="#" onclick="deleteTab('tip')">Remove this tab</a><br>
				</div>
				
			</div>
		  </div>
		  
			<script type="text/javascript">
			initTabs('tabPanel',Array('What\'s New','tips'),0,"","",Array(false,true));
			if(document.getElementById("userName").value != "Guest")
			{
				preloadFriends("tempTable"); //preload friend into an array
			}
			</script>
		
<!-- ************************End~ Tab Panel*************************************************-->
							    
<!-- ************************TMEPORAL TABLE*************************************************-->
<div id="tempDiv" style="visibility:hidden"><table id="tempTable"></table></div>

</div> <!-- End~ main Content -->
</div> <!-- End~ bodywrapper -->
</body><!-- Whole body ends here -->

</html>