/**
 * methods that handles peer-to-peer chat
 * includes polling for message, sending message
 */
	/*
	 * Code for creating new http request, used by other methods
	 */
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
	
	/*
	 * Sends a p2p chat message by creating a new http request
	 */
	function sendMsg( sendToCode ){
		
		var msg = document.getElementById("chatInput" + sendToCode).value;
		var senderID = document.getElementById("loginUserID").value;
		var senderName = document.getElementById("userName").value;
		
		xmlhttp = createNewRequest();
		
		// does nothing on return
		xmlhttp.onreadystatechange=function()
		  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    {

		    }
		  }

		//parameters of the request
		var Params = "message=" + msg + "&sendToCode=" + sendToCode
						+ "&senderID=" + senderID + "&senderName=" + senderName  ;

		document.getElementById("chatArea" + sendToCode ).innerHTML += "You: " + msg + "\n";
		document.getElementById("chatArea" + sendToCode ).scrollTop = document.getElementById("chatArea" + sendToCode ).scrollHeight;
		
		//send the parameters to the servlet with POST
		xmlhttp.open("POST","../chatRelayServlet" ,true);
		xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xmlhttp.send(Params);

	}
	
	
	/*
	 * Handles polling of p2p message from server
	 */
	function getMsg( pollingCode ) {
		
		xmlhttp = createNewRequest();
		
		xmlhttp.onreadystatechange=function(){
		  if (xmlhttp.readyState==4 && xmlhttp.status==200){
				ParseMsg(xmlhttp.responseXML);
					
			}
		  
		}
		
		// sends the request
		xmlhttp.open("GET","../chatRelayServlet?pollingCode="+pollingCode ,true);
		
		xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xmlhttp.send();
		
	}

	/*
	 * parses the received messge from server
	 * called by getMsg()
	 */
	function ParseMsg(responseXML)
	{
		// check first if there is msessage
		var isThereMsg = responseXML.getElementsByTagName('isMsg')[0].getAttribute("boolean");
		if ( isThereMsg != "true" ) {
			return;
		}
		
		var messageList = responseXML.getElementsByTagName('message');
		var printout = "";
		
		// there may be more than 1 message, this loop send the right message to the right window
		for (var iNode = 0; iNode < messageList.length; iNode++) {
			
			var message = messageList[iNode].childNodes[0].nodeValue;
			var senderName = messageList[iNode].getAttribute("senderName");
			var senderID = messageList[iNode].getAttribute("senderID");
			
			if ( message!="" || message != null ) {
				
				var printout = senderName + " said: \"" + message + "\"\n";
				
				if( document.getElementById("chatContainer" + senderID ) == null ) {
					showChatTab( senderName, senderID  );
				}
				
				document.getElementById("chatArea" + senderID ).innerHTML += printout;
				document.getElementById("chatArea" + senderID ).scrollTop = document.getElementById("chatArea" + senderID ).scrollHeight;
			}
			
		}

	}
	