function viewFriends(container)
{
		var credential = document.getElementById("cred").value;
		
		if(credential!=null)
		   {
			showFriendTab();
			ajaxpage('friendsPage.jsp', container); //load tableLoad.jsp in to div Dynapage
			document.getElementById("friendTbTitle").innerHTML="<img src=./resources/images/loading.gif></img>";
		   }
		
}

function loadFriends(container)
{	
	var credential = document.getElementById("cred").value;
	
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
			    
			    var responseText= ParseFriendsList(xmlhttp.responseXML, container);
		    	
		    }
		  }
	
		//send the parameters to the servlet with POST
		var Params = "Credential=" + credential;
		
		xmlhttp.open("POST","../friendsListServlet" ,true);
		xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xmlhttp.send(Params);
	  
		//document.getElementById("myDiv").innerHTML="<h2>Please wait...getting entry</h2>";
}

function ParseFriendsList(responseXML, container){
	 var success = (responseXML.getElementsByTagName("success")[0]).childNodes[0].nodeValue;
	 
	if(success=="false")
	{
		 //responseText = 
		 alert("Error finding friends. Please log out and back in again.");
	}
	 
	var friendList = responseXML.getElementsByTagName('friendList').item(0);
	
	//remove old elements
	var oBody = document.getElementById(container);
	while(oBody.hasChildNodes())
	{
		oBody.removeChild(oBody.firstChild);
	}
	
	var friends = friendList.getElementsByTagName("friend");
	for (var iNode = 0; iNode < friends.length; iNode++) {
		
        var friend_node = friends[iNode];

        var friendID		=	friend_node.getAttribute("friendID");
        var friendName		=	friend_node.getAttribute("friendName");
		
   	 	var rowHTML =	"    <td>" +
   	 					"<a href=index.html>"+ friendID + "</a></td>" +
						"    <td>"+ friendName + "</td>"+
						"    <td><a class=\"button\" onclick=deleteFriend("+friendID+");>Delete</a></td>"+
						"    <td><a class=\"button\" onclick=searchAuctionTable(2,"+friendName+");>View Auctions</a></td>"+
						"    <td><a class=\"button\" onclick=chatFriend("+friendID+");>Chat</a></td>";
		var rowParams = new Array();
		rowParams[0] = friendID;
		rowParams[1] = friendName;
		rowParams[2] = "<a class=\"button\" onclick=deleteFriend("+friendID+");>Delete</a>";
		rowParams[3] = "<a class=\"button\" onclick=searchAuctionTable(2,\""+friendName+"\");>View Auctions</a>";
		rowParams[4] = "<a class=\"button\" onclick=chatFriend("+friendID+");>Chat</a>";
		addElement(rowParams, container);
	}
	document.getElementById("friendTbTitle").innerHTML="Friend List";
}

//function addElement2( rowParams, container ) {
//	
//	  var ni = document.getElementById('myTable');
//	  
//	  var numi = document.getElementById('theValue');
//	  var num = (document.getElementById('theValue').value -1)+ 2;
//	  numi.value = num;
//	  var newdiv = document.createElement('div');
//	  var divIdName = 'my'+num+'Div';
//	  newdiv.setAttribute('id',divIdName);
//	  newdiv.setAttribute('class','div-table-row');
//	 
//	  //remove old rows..
//	  
//	  var oBody = document.getElementById('myTable');
//	  
//	 // Insert rows and cells into bodies.
//	    oRow = oBody.insertRow(oBody.rows.length);
//	    oRow.setAttribute('id', rowParams[0]);
//
//	   //Friend ID
//	    oCell = oRow.insertCell(-1);
//	    
//	    oCell.innerHTML =  rowParams[0];
//	    
//	    //Friend Name
//	    oCell = oRow.insertCell(-1);
//	    oCell.innerHTML =  rowParams[1];
//	    
//	    //Delete Button
//	    oCell = oRow.insertCell(-1);
//	    oCell.innerHTML =  rowParams[2];
//	    
//	    //Auction Button
//	    oCell = oRow.insertCell(-1);
//	    oCell.innerHTML =  rowParams[3];
//	    
//	    //Chat Button
//	    oCell = oRow.insertCell(-1);
//	    oCell.innerHTML =  rowParams[4];
//	    
//	  	//tools
//	    
//	  //ni.appendChild(newdiv);
//	}

function deleteFriend(friendID){
	
var credential = document.getElementById("cred").value;
	
	
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
		    
		    var responseText= ParseFriendDelete(xmlhttp.responseXML, container);
		    loadFriends();
	    	
	    }
	  }
	
	//send the parameters to the servlet with POST
	var Params = "Credential=" + credential + "&FriendID=" + friendID;
	
	xmlhttp.open("POST","../friendDeleteServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
	//document.getElementById("myDiv").innerHTML="<h2>Please wait...getting entry</h2>";
}

function ParseFriendDelete(responseXML, container){
	
	 var success = (responseXML.getElementsByTagName("success")[0]).childNodes[0].nodeValue;
	 var responseText = "";
	 
	 if(success=="true")
	{
		 //responseText = 
		 alert("Error deleting friend!");
	}
	 else 
	{
		//responseText = 
		 alert("Friend deleted!");
	}
	 //TODO Disable page while it reloads; ATM it reloads but the user can interact with it while it does.
	 loadFriends(container);
	 return responseText;
}