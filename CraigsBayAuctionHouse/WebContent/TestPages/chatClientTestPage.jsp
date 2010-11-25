<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<script type="text/javascript">


function getMsg( ) {
	
	xmlhttp = createNewRequest();

	xmlhttp.onreadystatechange=function( )
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			//alert("getting msg");
			if (xmlhttp.readyState==4 && xmlhttp.status==200) {
				//parse XML response from server
				var responseText= ParseGETXMLResponse(xmlhttp.responseXML);
				//alert("msg: " + responseText);
				
				document.getElementById("auctionChatHistory").innerHTML += responseText;
				document.getElementById("auctionChatHistory").scrollTop = document.getElementById("auctionChatHistory").scrollHeight;
				
			}
	   }
	  }
	
	
	//send the parameters to the servlet with POST
	var userID = document.getElementById("userID").value;
	xmlhttp.open("GET","../chatRelayServlet?userID="+userID ,true);
	
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send();

	setTimeout("getMsg()", 2000);
	//change the text while sending the email
	
}

function ParseGETXMLResponse(responseXML)
{
	var messageList = responseXML.getElementsByTagName('message');
	var printout = "";
	
	for (var iNode = 0; iNode < messageList.length; iNode++) {
	
		var message = messageList[iNode].childNodes[0].nodeValue;
		var sender = messageList[iNode].getAttribute("senderID");
		printout += "User " + sender + " said: \"" + message + "\"\n";
	}
	
	return printout;
}

function sendMsg(){
	
	var msg = document.getElementById("msg").value;
	var userID = document.getElementById("userID").value;
	var sendTo = document.getElementById("sendTo").value;
	
	xmlhttp = createNewRequest();
	  
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		    //parse XML response from server
		    //var responseText= ParseGETXMLResponse(xmlhttp.responseXML);
		    //alert("responseText: " + responseText);   
			
	    	//document.getElementById("myDiv").innerHTML=responseText;
	    }
	  }

	var Params = "message=" + msg+ "&senderID=" + userID + "&sendToID=" + sendTo;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../chatRelayServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

	//change the text while sending the email
	document.getElementById("myDiv").innerHTML="<h2>Please wait... Sending Request</h2>";
}

function ParseXMLResponse(responseXML)
{
	 //var result = (responseXML.getElementsByTagName("result")[0]).childNodes[0].nodeValue;
	 
	 //var responseText = "<h2>AJAX XML response from server: ";
	 //responseText += " " + result + "</h2>";

	 //document.getElementById("myDiv").innerHTML=responseText;
	 //wait 5 sec and poll server again.
	 //setTimeout('addNumberRequest()', 5000);
	 
}

function createNewRequest()
{
	xmlhttp=false;
	
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	  

	  return xmlhttp;
}


function getReadyStateHandler(req, responseXmlHandler) {

	   // Return an anonymous function that listens to the XMLHttpRequest instance
	   return function () {

	     // If the request's status is "complete"
	     if (req.readyState == 4) {
	       
	       // Check that we received a successful response from the server
	       if (req.status == 200) {

	         // Pass the XML payload of the response to the handler function.
	         return responseXmlHandler(req.responseXML);

	       } else {

	         // An HTTP problem has occurred
	         alert("HTTP error "+req.status+": "+req.statusText);
	       }
	     }
	   }
}

function refreshAuctionChatParseXMLResponse(responseXML, userID )
{
	document.getElementById("auctionChatHistory").innerHTML = chatLog;
	document.getElementById("auctionChatHistory").scrollTop = document.getElementById("auctionChatHistory").scrollHeight;

	setTimeout("refreshAuctionChat(" + userID + ")", 5000);
}

function refreshAuctionChat(userID)
{
	var xmlhttp;
	
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	  
	xmlhttp.onreadystatechange=getReadyStateHandler(xmlhttp, refreshAuctionChatParseXMLResponse, auctionID );
	
	var userID = document.getElementById("userID").value;

	//document.getElementById("bidFeedback").innerHTML="<h2><img src=./resources/images/loading.gif></img> <p>Sending Auction Update Request...</h2></p>";
	
	var Params = "userID=" + userID;
	
	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../chatRelayServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);



}

</script>

</head>

<body>

<textarea id="auctionChatHistory" readonly="readonly" rows="10" cols="40">
Auction Chat
</textarea>
<br>
Input: <input id="msg" type="text" name="msg" size="50"><br>
SendTo: <input id="sendTo" type="text" name="sendTo" size="5">
<button type="button" onclick="sendMsg()">Send</button><br>
<br>
UserID: <input id="userID" type="text" name="userID" size="50"><br>
<button type="button" onclick="getMsg()">Get Msg</button>

</body>
</html>