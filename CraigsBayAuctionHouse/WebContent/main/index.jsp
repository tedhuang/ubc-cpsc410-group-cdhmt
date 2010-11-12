<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		
		<title>Welcome To CS410 Project</title>
		
<!-- ***************************************************************************************-->
						<!--   CSS    -->
<!-- ***************************************************************************************-->
	  
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
		
		<!-- Floading Menu References -->
		<link rel="stylesheet" href="./resources/css/floadStyle.css" type="text/css" media="screen" />
		<script type="text/javascript" href="./resources/scripts/jquery-1.3.2.js"></script>
		
		<!-- Tab Panel References -->
		<link rel="stylesheet" href="./resources/css/tab-view.css" type="text/css" media="screen">
		<script type="text/javascript" src="./resources/scripts/tabPanelAjax.js"></script>
		<script type="text/javascript" src="./resources/scripts/tab-view.js"></script>
		
<!-- ***************************************************************************************-->
						<!--  Javascripts -->
<!-- ***************************************************************************************-->
  		
		<!-- jQuery -->
		<script type="text/javascript" src="./resources/scripts/jquery-1.3.2.min.js"></script>
		
		<!-- jQuery Configuration -->
		<script type="text/javascript" src="./resources/scripts/simpla.jquery.configuration.js"></script>
		
		<!-- Facebox jQuery Plugin -->
		<script type="text/javascript" src="./resources/scripts/facebox.js"></script>
		
		<!-- jQuery WYSIWYG Plugin -->
		<script type="text/javascript" src="./resources/scripts/jquery.wysiwyg.js"></script>
		
		<!-- New Lightbox Login -->
		<link type="text/css" rel="stylesheet" href="./resources/css/lightbox-form.css">
		<script src="./resources/scripts/lightbox-form.js" type="text/javascript"></script>
		
		<!--  Ajax Loader Script -->
		<script type="text/javascript" src="./resources/scripts/dynamicAjaxLoader.js"></script>
		
		
		
		
<!-- ***************************************************************************************-->		
					<!-- Auction Functions -->
<!-- ***************************************************************************************-->
	
	<script type="text/javascript">
	function viewAllAuctions()
	{
		loadobjs('./resources/scripts/auctionListLoader.js'); //load the additional javascript tableLoad.jsp requires
		ajaxpage('tableLoad.jsp', 'Dynapage'); //load tableLoad.jsp in to div Dynapage
		document.getElementById("surferTitle").innerHTML="Loading...";
		
	}
	</script>
	<script type="text/javascript">
	function createAuction(containerID)
	{

		ajaxpage('createAuctionTable.jsp', containerID);
		loadobjs('./resources/scripts/createAuction.js');
		document.getElementById("surferTitle").innerHTML="Create a New Auction";
	}
	
	</script>
	
	<!--TODO Link with profile button -->
	<script type="text/javascript">
	function userControlPage()
	{
		loadobjs('./resources/scripts/userControlPanel.js');
		ajaxpage('userControlPanel.jsp', 'Dynapage')
		document.getElementById("surferTitle").innerHTML="Loading...";
	}
	
	</script>

<!-- ***************************************************************************************-->
							<!-- login Function  -->
<!-- ***************************************************************************************-->	
	<script type="text/javascript">
	function userLoginRequest()
		{
			var userName = document.getElementById("username").value;
			var password = document.getElementById("password").value;
			//alert("im in");
			
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
				    //var responseText= ParseXMLResponse(xmlhttp.responseXML);
				    		    
				    //Gets userCred and prints it to div
					var userCred = (xmlhttp.responseXML.getElementsByTagName("userCred")[0]).childNodes[0].nodeValue;
		
				    if( userCred != "null" ) 
					    { 
					    
							var responseText = "<h2>User Credential is: ";
							responseText += userCred  + "</h2>";		
							
							document.getElementById("myDiv").innerHTML=responseText;
							document.getElementById("submitCred").value = userCred;
							document.getElementById("name").value = userName;
							document.getElementById("close").submit();
							
		
				    	}
				    else
				    	{
					    	//TODO: implement error handling
					    	alert("Login Failed");
					    	document.getElementById("myDiv").innerHTML="<h2>Login Failed!</h2>"; 
				    	}
			    }
			  };
			  
			var Params = "userName=" + userName + "&password=" + password;
		
			//send the parameters to the servlet with POST
			xmlhttp.open("POST","../userLoginServlet" ,true);
			xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlhttp.send(Params);
		
		
		}
		</script>

<!-- ***************************************************************************************-->	
						<!-- Sliding Menu js functions  -->
<!-- ***************************************************************************************-->

		<script type="text/javascript">
		$(document).ready(function(){
			$(".trigger").click(function(){
			$(".panel").toggle("fast");
			$(this).toggleClass("active");
			return false;
		});
		});
	</script>
	
	<script type="text/javascript">
	//Temp for floading menu
	//	<div id="menu" class="fload_panel">
	//		<h2>Menu</h2>
	 //   <p> I'm Here!</p>
		//<div style="clear:both;"></div>

		//</div>
		//
	//---------------------------------------------------------
	//<ul id="bubblemenu">
  //      <li>
  //          LOG IN FROM HERE
  //          <div class="tabIframeWrapper">
//	  			<iframe class="tabContent" 
	//	  			name="tabIframe2" src="del.html" 
//		  			marginheight="8" marginwidth="8" frameborder="0">
//	  			</iframe>
//			</div>
//	</ul>
	</script>
	
	
<!-- ***************************************************************************************-->
							<!--  CREDENTIAL CHECK -->
<!-- ***************************************************************************************-->
		
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
	
	<div id="floadMenu">
			<a class="trigger" href="#">Menu</a>
	</div>
	
	<body><div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->

<!-- ***************************************************************************************
								 Sidebar Starts Here
********************************************************************************************-->

		<div id="sidebar"><div id="sidebar-wrapper"> <!-- Sidebar with logo and menu -->
			
			<h1 id="sidebar-title"><a href="#">Admin Panel</a></h1>
		  
			<!-- Logo (221px wide) -->
		  <img id="logo" src="./resources/images/lighthouse.gif" style="float:center;margin-right:20px;margin-bottom:20px">
<!-- ***************************************************************************************-->
								<!-- Sidebar Profile links -->
<!-- ***************************************************************************************-->
			
		<!-- NEW LIGHTBOX LOGIN -->
		<div id="filter"></div>
			<div id="box">
			  <span id="boxtitle"></span>
			  
			 
			  <form id= "close" name="close" method="post" title="Close" >
					<input id="submitCred" type="hidden" name="cred"/>
					<input id="name" type="hidden" name="name" />
					<input type="image" src="./resources/images/minus.png" name="image" />
			  </form>
			  
			  <div id="login-box-name" style="margin-top:20px;">User:</div>
					<div id="login-box-field">
						<input id="username" name="username" class="form-login" title="Username" value="" size="30" maxlength="2048" />
					</div>
					<div id="login-box-name">Password:</div>
					<div id="login-box-field">
					<input id="password" name="password" type="password" class="form-login" title="Password" value="" size="30" maxlength="2048" /></div>
		    <p> 
			   <input type="image" src="./resources/images/login-btn.png" name="image" onclick="userLoginRequest()"/>
			</p>
						
					<div id="myDiv"><h2>Debug Message for page</h2></div>
			</div>
<!-- ***************************************************************************************-->	
	  					<!-- ~ENDS: NEW LIGHTBOX LOGIN -->	
<!-- ***************************************************************************************-->
			<div id="profile-links">
				Hello, 

				<%= userName %>
				 
				<%  
				if(userName != "Guest")
				{
					
				%>
				, you have <a href="#messages" rel="modal" title="3 Messages">3 Messages</a><br />
				<p><a href="#" title="Edit your profile"> Profile</a> | 
				<a href="../main" title="Sign Out">Sign Out</a> </p>
				
				<%
				}
				else
				{
				%>
				<p>Already A Member? <a href="#" onclick="openbox('User Sign In', 1)">Sign-in From here</a></p>
				<%
				}
				%>
				
				
				
				
			</div>        
			
<!-- ***************************************************************************************-->
							<!-- Quick Tools -->
<!-- ***************************************************************************************-->			
			
			<ul id="main-nav">  <!-- Accordion Menu -->
				
				
				<li>
					<a href="#" class="nav-top-item">
						Auctions
					</a>
					<ul>
						<li OnClick="viewAllAuctions()"><a href=#>View All Auctions</a></li>
						<%  
							if(userName != "Guest")
							{
						%>
						
						<li OnClick="createAuction('Dynapage')"><a href="#">New Auction</a></li>
						<li><a href="#">Manage Auction</a></li>
						<%
							}
						%>
					</ul>
				</li>
				
				<li>
					<a href="#" class="nav-top-item">
						Social Network
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
						<li OnClick="userControlPage()"><a href="#">Your Profile</a></li>
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
			</div>
<!-- ********************************************************************************************
									Siderbar ends here
*************************************************************************************************-->
			
	  
			
<!-- ********************************************************************************************
								Dynamic Page Starts Here 
*************************************************************************************************-->
			
			<div id="main-content">

<!-- ********************************************************************************************
								Sliding Menu Starts here 
*************************************************************************************************-->
			
			<div class="panel">
				<h3>Profile</h3>
				<img class="right" src="./resources/images/happy.jpg" />
							<p><h3><%= userName %></h3></p>
							<p><a href=#>Message</a> | <a href=#>My items</a></p>
						
						<div style="clear:both;"></div>
						
							<div class="columns">
								<div class="colleft">
								<h3>Business</h3>
									<ul>
										<li OnClick="viewAllAuctions()"><a href=#>View All Auctions</a></li>
										<li OnClick="createAuction();
											createNewTab('dhtmlgoodies_tabView1','New Auction','','',true)"><a href="#">New Auction</a></li>
										<li><a href="3" title="portfolio">My Auction</a></li>
										<li><a href="4" title="contact">Won history</a></li>
									</ul>
								</div>
							
								<div class="colright">
									<h3>Social Network</h3>
									<ul>
										<a href="7" title="Twitter">My Profile</a></li>
										<li><a href="7" title="Twitter">My Messages</a></li>
										<li><a href="8" title="DesignBump">My Friends</a></li>
										<li><a href="9" title="Digg">Search People</a></li>
										
									</ul>
								</div>
							</div>
						<div style="clear:both;"></div>
						
						</div>
						
		
				<a class="trigger" href="#">MENUS</a>
				
				

		
<!-- ********************************************************************************************
								End~ of Sliding Menu 
*************************************************************************************************-->

<!-- ********************************************************************************************
							    Tab Panel Starts here
*************************************************************************************************-->
	   <div id="tabHolder">
		<div id="dhtmlgoodies_tabView1">
				<div class="dhtmlgoodies_aTab">
					 
					<h2><div id="surferTitle">Welcome <%= userName %></div></h2><br>
					<div id="Dynapage">
						Dynamic page is here
					</div><br>
					
					<a href="#" onclick="createNewTab('dhtmlgoodies_tabView1','A dynamic tab','','externalfile.html',true);return false">Create new tab dynamically</a><br>
					<a href="#" type=hidden onclick="deleteTab('Menu scripts')">Remove this tab</a><br>
						
				</div>
				<div class="dhtmlgoodies_aTab">
					This is the content of the second tab.	<br>
					<a href="#" onclick="deleteTab('Calendar')">Remove this tab</a><br>
				</div>
			</div>
		  </div>
			<script type="text/javascript">
			initTabs('dhtmlgoodies_tabView1',Array('What\'s New','tips'),0,500,400,Array(false,true,true,true));
			</script>
		
<!-- ********************************************************************************************
							   End~ Tab Panel 
*************************************************************************************************-->
		<div id="surferTitle">Welcome <%= userName %></div>

	
		</div> <!-- End~ main Content -->
		</div> <!-- End~ bodywrapper -->
		</body><!-- Whole body ends here -->

</html>