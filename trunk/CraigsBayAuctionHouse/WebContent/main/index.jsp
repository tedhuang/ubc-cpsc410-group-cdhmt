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
		
		<!-- Tab Panel References -->
		<link rel="stylesheet" href="./resources/css/tab-view.css" type="text/css" media="screen">
		<script type="text/javascript" src="./resources/scripts/tabPanelAjax.js"></script>
		<script type="text/javascript" src="./resources/scripts/tab-view.js"></script>
		
		<!-- New Lightbox Login -->
		<link type="text/css" rel="stylesheet" href="./resources/css/lightbox-form.css">
		<script src="./resources/scripts/lightbox-form.js" type="text/javascript"></script>
		
<!-- ***************************************************************************************-->
						<!--  Javascripts -->
<!-- ***************************************************************************************-->
  		
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
		
		
<!-- ***************************************************************************************-->		
					<!-- Auction Functions -->
<!-- ***************************************************************************************-->
	
	<script type="text/javascript">
	function viewAllAuctions()
	{
		//loadjscssfile('./resources/scripts/auctionListLoader.js', 'js');
		//loadobjs('./resources/scripts/auctionListLoader.js'); //load the additional javascript tableLoad.jsp requires
		ajaxpage('tableLoad.jsp', 'Dynapage'); //load tableLoad.jsp in to div Dynapage
		//createNewTab('tabPanel','All Auctions','','tableLoad.jsp',true);
		document.getElementById("surferTitle").innerHTML="<img src=./resources/images/loading.gif></img>";
		
	}
	</script>
	<script type="text/javascript">
	function createAuction(containerID)
	{

		//ajaxpage('createAuctionTable.jsp', containerID);
		//loadjscssfile('./resources/scripts/createAuction.js', 'js');
		//loadobjs('./resources/scripts/createAuction.js');
		createNewTab('tabPanel','New Auction','','createAuctionTable.jsp',true);
		//document.getElementById("surferTitle").innerHTML="Create a New Auction";
	}
	</script>
	<script type="text/javascript">
	function viewUserAuctions()
	{
		//loadjscssfile('./resources/scripts/auctionListLoader.js', 'js');
		//loadobjs('./resources/scripts/auctionListLoader.js'); //load the additional javascript tableLoad.jsp requires
		ajaxpage('userOwnedAuctionsLoad.jsp', 'Dynapage'); //load tableLoad.jsp in to div Dynapage
		//createNewTab('tabPanel','All Auctions','','tableLoad.jsp',true);
		document.getElementById("surferTitle").innerHTML="<img src=./resources/images/loading.gif></img>";
		
	}
	</script>
	<script type="text/javascript">
	function viewBiddedAuctions()
	{
		//loadjscssfile('./resources/scripts/auctionListLoader.js', 'js');
		//loadobjs('./resources/scripts/auctionListLoader.js'); //load the additional javascript tableLoad.jsp requires
		ajaxpage('userBiddedAuctionsLoad.jsp', 'Dynapage'); //load tableLoad.jsp in to div Dynapage
		//createNewTab('tabPanel','All Auctions','','tableLoad.jsp',true);
		document.getElementById("surferTitle").innerHTML="<img src=./resources/images/loading.gif></img>";
		
	}
	</script>
	
	<!--TODO Link with profile button -->
	<script type="text/javascript">
	function userControlPage()
	{
		//loadjscssfile('./resources/scripts/userControlPanel.js', 'js');
		//loadobjs('./resources/scripts/userControlPanel.js');
		ajaxpage('userControlPanel.jsp', 'Dynapage');
		document.getElementById("surferTitle").innerHTML="<img src=./resources/images/loading.gif></img>";
	}
	
	</script>
	
	<script type="text/javascript">
		var insideTab;
		function getContain(elementID)
		{
			insideTab=document.getElementById(elementID).innerHTML;
		}
	</script>
	
	<script type="text/javascript">
		function SelectAll(id)
		{
		    document.getElementById(id).focus();
		    document.getElementById(id).select();
		}
	</script>
	
	<script type="text/javascript">	
	//Code to search DB for auctions
	function searchAuctionTable(type, searchOwner)
	{	
		//If type = 0 then basic search else advanced
		//NOTE for some reason to pass '%' as a string in javascript it has to be '%25'
		if(type == 0){
			var searchTitle = document.getElementById("searchTitle").value;
			var searchCategory = "%25";
			searchOwner = "";
		}

		//Advanced Search
		if(type == 1){
			var searchTitle = document.getElementById("advancedSearchTitle").value;
			var searchCategory = document.getElementById("searchCategory").value;
			searchOwner = document.getElementById("searchOwner").value;

			//Check to see what parameters matter
			if(searchTitle == ""){
				searchTitle = "%25";
			}
			if(searchCategory == ""){
				searchCategory = "%25";
			}
			if(searchOwner == ""){
				searchOwner = "";
			}
		}
		
		//Friend Search
		if(type == 2){
			var searchCategory = "%25";
			var searchTitle = "%25";
		}
		
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
			    
			    var responseText= ParseAuctionList(xmlhttp.responseXML);
		    	
		    }
		  }
	
		//send the parameters to the servlet with POST
		var Params = "SearchTitle="+ searchTitle + "&SearchCategory=" + searchCategory + 
						"&SearchOwner=" + searchOwner;
		
		xmlhttp.open("POST","../auctionListAllServlet" ,true);
		xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xmlhttp.send(Params);
		//document.getElementById("myDiv").innerHTML="<h2>Please wait...getting entry</h2>";
	}
	</script>
	<script type="text/javascript">
	function viewFriends()
	{
		ajaxpage('friendsPage.jsp', 'Dynapage'); //load tableLoad.jsp in to div Dynapage
		document.getElementById("surferTitle").innerHTML="<img src=./resources/images/loading.gif></img>";
		
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
					var userID = (xmlhttp.responseXML.getElementsByTagName("userID")[0]).childNodes[0].nodeValue;
					
				    if( userCred != "null" ) 
					    { 
					    
							var responseText = "<h2>User Credential is: ";
							responseText += userCred  + "</h2>";		
							
							document.getElementById("myDiv").innerHTML=responseText;
							document.getElementById("submitCred").value = userCred;
							document.getElementById("name").value = userName;
							document.getElementById("submitUserID").value = userID;
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
							<!-- logout Function  -->
<!-- ***************************************************************************************-->	
	<script type="text/javascript">
	function userLogoutRequest()
		{
			var userCred = document.getElementById("cred").value;
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
					window.location="../main";   //if logout successfully, redirect to the main page 
			    }
			  else //logout failed display error messege
				 {
				  
				 }
			  };
			  
			var Params = "Credential=" + userCred;
		
			//send the parameters to the servlet with POST
			xmlhttp.open("POST","../userLogoutServlet" ,true);
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
	


	</script>
	
	<script type="text/javascript">
	
	
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
//<script language="javascript">
			
//			function cascadeOpt(dropdown){
//			var myForm = document.getElementById("searchOpt");
//			var opt1=document.getElementById("searchCategory");
//			var opt2=document.getElementById("searchByPplBox");
			
	//		var opt= dropdown.selectedIndex;
	//		var temp=opt1.style.display;
		//	switch(opt)
			//{
//			case 0:
	//			break;
	//		case 1:
		//		if(temp=="block")
			//	{
				//	opt1.style.display="none";
			//	}
		//		else
			//	{
				//	opt1.style.display="block";
				//}
//			break;
			
	//	  }
		//}
	//	</script>
	</script>
	
	
<!-- ***************************************************************************************-->
							<!--  CREDENTIAL CHECK -->
<!-- ***************************************************************************************-->
		
	</head>
	
            
	
	<% 
		String cred = request.getParameter("cred");
		String userName = request.getParameter("name");
		String loggedInUserID = request.getParameter("loggedInUserID");
		
		if(userName == null || userName == "")
		{
			userName = "Guest";
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
	<%
	}
	%>

	<body><div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->

<!-- ***************************************************************************************
								 Sidebar Starts Here
********************************************************************************************-->
<!-- NEW LIGHTBOX LOGIN -->
		<div id="filter"></div>
			<div id="box">
			  
			  <form id= "close" name="close" method="post" title="Close" >
					<input id="submitCred" type="hidden" name="cred"/>
					<input id="name" type="hidden" name="name" />
					<input id="submitUserID" type="hidden" name="loggedInUserID" />
					<!-- <input type="image" src="./resources/images/minus.png" name="image" />
					 -->
			  </form>
			  
			<input type="image" src="./resources/images/login-cancle.png" class="login-icon" style="margin-right:20px;" type="button" name="cancel" value="Cancel" onclick="closebox()">  
			<div id="login-box-name" style="margin-top:70px; margin-left:100px;">User:</div>   
			<div id="login-box-field" >
			  	<input id="username" name="username" class="form-login" title="Username" value="" size="10" maxlength="2048" />
			</div>
					
			<div id="login-box-name" style="margin-top:0px; margin-left:130px;">Password:</div>
			<div id="login-box-field">
				<input id="password" name="password" type="password" class="form-login" title="Password" value="" size="30" maxlength="2048" />
			</div>
				
				<!-- LOGIN BUTTON -->
			<input type="image" src="./resources/images/login-go.png" class="login-icon" title="go!" style="margin-left:400px;" onclick="userLoginRequest()" >		
			<div style="margin-top:300px;" id="myDiv"><h2>Debug Message for page</h2></div>
			</div>
<!-- ***************************************************************************************-->	
	  					<!-- ~ENDS: NEW LIGHTBOX LOGIN -->	
<!-- ***************************************************************************************-->

   <div id="sidebar"><div id="sidebar-wrapper"> <!-- Sidebar with logo and menu -->
			
		<h1 id="sidebar-title"><a href="#">Admin Panel</a></h1>
		  
	  <!-- Logo (221px wide) -->
	  <img id="logo" src="./resources/images/logo.png" style="float:center;margin-left:50px;margin-bottom:50px">
<!-- ***************************************************************************************-->
								<!-- Sidebar Profile links -->
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
				<a href="#" title="Sign Out" onclick="userLogoutRequest()">Sign Out</a> </p>
				
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
						
						<li OnClick="createAuction('Dynapage');"><a href="#">New Auction</a></li>
						<li OnClick="viewUserAuctions();"><a href="#">Manage Auction</a></li>
						<li OnClick="viewBiddedAuctions();"><a href="#">My Bids</a></li>
						<%
							}
						%>
						<li> <input type="text" id="searchTitle" value="search Auctions..." onclick="SelectAll('searchTitle');"/></li>
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
						<li><a href="#">Start a Chat</a></li>
						<li OnClick="viewFriends()"><a href="#">Friends</a></li>
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
							<p><a href=#>Messages</a> | <a href=#>My items</a></p>
						
						<div style="clear:both;"></div>
						
							<div class="columns">
								<div class="colleft">
								<h3>Business</h3>
									<ul>
										<li OnClick="viewAllAuctions()"><a href=#>View All Auctions</a></li>
										<li OnClick="createAuction()"><a href="#">New Auction</a></li>
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
						
	<% 
	if(userName != "Guest")
	{
	%>
				  <a class="trigger" href="#">MENUS</a>
				  
	<%
	} 
	%>
				
				

		
<!-- ********************************************************************************************
								End~ of Sliding Menu 
*************************************************************************************************-->

<!-- ********************************************************************************************
							    Tab Panel Starts here
*************************************************************************************************-->
	   <div id="tabHolder">
		<div id="tabPanel">
				
				<!-- Main Tab -->
				<div class="dhtmlgoodies_aTab">
					 
					<h2><div id="surferTitle">Welcome <%= userName %></div></h2><br>
					<div id="Dynapage">
						Dynamic page is here
					</div><br>
				</div>
				
				<!--  tip tab-->
				<div class="dhtmlgoodies_aTab">
					This is the content of the second tab.	<br>
					<a href="#" onclick="deleteTab('tip')">Remove this tab</a><br>
				</div>
				
				<!-- Pre-Defined Advanced Search Tab -->
				<div class="dhtmlgoodies_aTab" id="advancedSearchTab">
					<div id="searchTool1">
						<input type="text" id="advancedSearchTitle" value="search Auctions..." onclick="SelectAll('advancedSearchTitle');"/>
						
					<FORM name="searchOpt"> 
						<select name="searchCondition1" class="small-input" onChange="cascadeOpt(searchCondition1);">
							<option value="searchOption">Search By</option>
							<option value="searchByCategory">Category</option>
							<option value="searchByPeople">Owner</option>
						</select>
					</FORM>
					</div>
				  
					<select id="searchCategory" >
							
							<option value=""> Pick a Category</option>
							<option value="electronics">Electronics</option>
							<option value="books">Books</option>
							<option value="motors">Motors</option>
							<option value="art">Art</option>
							<option value="music">Music</option>
					</select>
					<input type="text" id="searchOwner" value="search By Authors..." onclick="SelectAll('searchOwner');"/>
					<br><input type="image" id="advSearchBtn" 
						   src="./resources/images/advancedSearch.png"
						   title="Advanced Search" onClick="searchAuctionTable(1)"/>
				</div>
				
				<!-- Auction Details Tab -->
				<div class="dhtmlgoodies_aTab" id="auctionDetailTab">
					<div id="itemDetailArea">
					</div><br>
				</div>
				
			</div>
		  </div>
		  
		  
			<script type="text/javascript">
			initTabs('tabPanel',Array('What\'s New','tips'),0,500,400,Array(false,true));
			</script>
		
<!-- ********************************************************************************************
							   End~ Tab Panel 
*************************************************************************************************-->
	
		</div> <!-- End~ main Content -->
		</div> <!-- End~ bodywrapper -->
		</body><!-- Whole body ends here -->

</html>