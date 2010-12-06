<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<script type="text/javascript">

/*
 * Test Page deployed for testing/creating peer-to-peer chat
 * The code is likely outdated as xml data format are changed
 */

function getMsg( pollingCode ) {
	
	xmlhttp = createNewRequest();

	xmlhttp.onreadystatechange=function(){
	  if (xmlhttp.readyState==4 && xmlhttp.status==200){
			//alert("getting msg");
			//parse XML response from server
			var responseText= ParseMsg(xmlhttp.responseXML);
			//alert("msg: " + responseText);
				
			document.getElementById("auctionChatHistory").innerHTML += responseText;
			document.getElementById("auctionChatHistory").scrollTop = document.getElementById("auctionChatHistory").scrollHeight;
				
		}
	}
	
	
	//send the parameters to the servlet with POST
	//var userID = document.getElementById("userID").value;
	xmlhttp.open("GET","../chatRelayServlet?pollingCode="+pollingCode ,true);
	
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send();

	setTimeout("getMsg("+ pollingCode +")", 3000);
	
}

//Parse the message sent back to user
function ParseMsg(responseXML)
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

function sendMsg(  ){
	
	var msg = document.getElementById("msg").value;
	var userID = document.getElementById("userID").value;
	var sendToCode = document.getElementById("sendToCode").value;
	
	xmlhttp = createNewRequest();
	  
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {

	    }
	  }

	var Params = "message=" + msg+ "&senderID=" + userID + "&sendToCode=" + sendToCode;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../chatRelayServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

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

function requestChat()
{
	var userID = document.getElementById("userID").value;
	var sendTo = document.getElementById("sendTo").value;
	
	xmlhttp = createNewRequest();
	  
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  var sessionInfo	= xmlhttp.responseXML.getElementsByTagName("chatSession").item(0);
		  var sendToCode	= sessionInfo.getAttribute("sendToCode");
		  var pollingCode	= sessionInfo.getAttribute("pollingCode");
		  
		  document.getElementById("sendToCode").value = sendToCode;
		  document.getElementById("pollingCode").value = pollingCode;
		  
		  alert("Session Requested: sendToCode=" + sendToCode + " pollingCode=" + pollingCode );
		  
		  getMsg( pollingCode );
	    }
	  }

	var Params = "userID=" + userID + "&sendToID=" + sendTo;
	
	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../chatRegisterServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
}

function waitForChat()
{
	var userID = document.getElementById("userID").value;
	
	xmlhttp = createNewRequest();
	  
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  var requestList = xmlhttp.responseXML.getElementsByTagName('chatRequest');
		  var sender;
		  var pollingCode;
		  var sendToCode;
		  
		  for (var iNode = 0; iNode < requestList.length; iNode++) {
			  sender 		= requestList[iNode].getAttribute("senderID");
			  pollingCode	= requestList[iNode].getAttribute("pollingCode");
			  sendToCode	= requestList[iNode].getAttribute("sendToCode");
			  
			  document.getElementById("sendToCode").value = sendToCode;
			  document.getElementById("pollingCode").value = pollingCode;
			  
			  alert("Session Request from User " + sender +
					  "sendToCode=" + sendToCode + " pollingCode=" + pollingCode );
			  getMsg( pollingCode );
			}
		  
		  
		  //getMsg( pollingCode );
		  setTimeout("waitForChat()", 8000);
	    }
	  }

	//send the parameters to the servlet with POST
	xmlhttp.open("GET","../chatRegisterServlet?userID="+userID, true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send();
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
<button type="button" onclick="requestChat()">Request Chat</button>

<button type="button" onclick="waitForChat()">Wait for Chat</button>

<input id="sendToCode" type="hidden" name="sendToCode">
<input id="pollingCode" type="hidden" name="pollingCode">

</body>
</html>