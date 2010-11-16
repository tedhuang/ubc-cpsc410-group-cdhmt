function loadUserInfo()
{	
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
		    //var responseText= 
		    ParseUserInfo(xmlhttp.responseXML);
	    	
	    }
	  }
	
	var credential = document.getElementById("cred").value;

	//send the parameters to the servlet with POST
	var Params = "Credential=" + credential;
	
	xmlhttp.open("GET","../userEditInfo?Credential="+ credential ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send();
	//document.getElementById("myDiv").innerHTML="<h2>Please wait...getting entry</h2>";
}


function ParseUserInfo( responseXML ) {
	if((responseXML.getElementsByTagName("success")[0]).childNodes[0].nodeValue == "false"){
		alert("You must login");
		return;
	}
	var user = responseXML.getElementsByTagName("user").item(0);		
    
	document.getElementById("Password").value =	user.getAttribute("password");
    document.getElementById("PhoneNumber").value = user.getAttribute("phoneNumber");
    var i = 0;
    for(i = 0; i < (document.getElementById("PhoneCarrier").options.length); i++){
    	if(document.getElementById("PhoneCarrier").options[i].value == user.getAttribute("phoneCarrier")){
    		document.getElementById("PhoneCarrier").options[i].selected = true;
    	}
    	
    }
    document.getElementById("EmailAddress").value =	user.getAttribute("emailAddress");
	document.getElementById("surferTitle").innerHTML="User Info";
}


function editUserInfo()
{
	//Unlocks textboxes etc. to be edited
	document.getElementById("Password").disabled = false;
	document.getElementById("PhoneNumber").disabled = false;
	document.getElementById("PhoneCarrier").disabled = false;
	document.getElementById("EmailAddress").disabled = false;	
	document.getElementById("Submit").disabled = false;
}


function updateUserRequest()
{
	
	var Password = document.getElementById("Password").value;
	var PhoneNumber = document.getElementById("PhoneNumber").value;
	var PhoneCarrier = document.getElementById("PhoneCarrier").value;
	var EmailAddress= document.getElementById("EmailAddress").value;
	var credential = document.getElementById("cred").value;
	
	//Check user input
	if(Password == ""){
		alert("Must Enter Password!");
		return;
	}
	if(PhoneNumber.match(/\d{10}/)== null){
		alert("Invalid phone number.");
		return;
	}
	apos=EmailAddress.indexOf("@");
	dotpos=EmailAddress.lastIndexOf(".");
	if (apos<1||dotpos-apos<2){
		alert("Invalid E-mail Address");
		return;
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
		   var responseText= userParseXMLResponse(xmlhttp.responseXML);
		   
	    	document.getElementById("feedBack").innerHTML=responseText;
	    }
	  }

	var Params = "Credential=" + credential + "&Password=" + Password + "&PhoneNumber=" + PhoneNumber
					+ "&PhoneCarrier=" + PhoneCarrier + "&EmailAddress=" + EmailAddress;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../userEditInfo" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

	//change the text while sending the request
	document.getElementById("feedBack").innerHTML="<h2>Please wait... Sending Request</h2>";
}

function userParseXMLResponse(responseXML){
	
	 var success = (responseXML.getElementsByTagName("success")[0]).childNodes[0].nodeValue;
	 var responseText = "";
	 
	 if(success==true)
	{
		 responseText = "<h2>Error updating user!</h2>";
	}
	 else 
	{
		 
		 responseText = "<h2>User Updated!</h2>";
	}
	

	 return responseText;
}