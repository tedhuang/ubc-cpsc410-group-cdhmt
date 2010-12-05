/**
 * 
 */
	
	//TODO make sure to be able to handle unique tab updates
	//TODO add username to chat box

	//make sure to handle a re-request from somebody already in chatSession
	
	//Avoid conflicting instance of polling functions (polling different stuff happening on same tab/window)
	//probably save all required variable inside a field of a tab
	
	function waitForChat( )
	{
		var userCred = document.getElementById("cred").value;
		//alert("waitForChat( "+ userCred +") has triggered");
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
				  
				  //document.getElementById("sendToCode").value = sendToCode;
				  //document.getElementById("pollingCode").value = pollingCode;
				  
				  alert("Session Incoming from User " + sender +
						  "sendToCode=" + sendToCode + " pollingCode=" + pollingCode );
				  
				  //TODO make getMsg() open new tab and store crucial info
				  showChatTab( requestList[iNode] );
				  //getMsg( pollingCode );
				}
			  
			  
			  //getMsg( pollingCode );
			  //alert('triggered');
//			  var callback = "waitForChat("+ document.getElementById("cred").value + ")";
//			  alert(callback);
			  setTimeout("waitForChat()", 4000);
			  
		    }
		  }
		//send the parameters to the servlet with POST
		xmlhttp.open( "GET" , "../chatRegisterServlet?Credential=" + userCred, true);
		xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xmlhttp.send();
		
		
		//setTimeout("waitForChat(" + userCred + ")", 8000);

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

	function requestChat( sendTo )
	{
		
		var userCred = document.getElementById("cred").value;
//		var userName = document.getElementById("userName").value;
		//var sendTo = document.getElementById("sendTo").value;
		
		xmlhttp = createNewRequest();
		  
		xmlhttp.onreadystatechange=function()
		  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    {
			  var sessionInfo	= xmlhttp.responseXML.getElementsByTagName("chatSession").item(0);
			  var sendToCode	= sessionInfo.getAttribute("sendToCode");
			  var pollingCode	= sessionInfo.getAttribute("pollingCode");
			  
//			  document.getElementById("sendToCode").value = sendToCode;
//			  document.getElementById("pollingCode").value = pollingCode;
			  
			  alert("Session Requested: sendToCode=" + sendToCode + " pollingCode=" + pollingCode );
			  
			  showChatTab( sessionInfo );
//			  getMsg( pollingCode );
		    }
		  }

		var Params = "Credential=" + userCred + "&sendToID=" + sendTo;
		
		//send the parameters to the servlet with POST
		xmlhttp.open("POST","../chatRegisterServlet" ,true);
		xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xmlhttp.send(Params);
	}
	
	function sendMsg( sendToCode ){
		
		var msg = document.getElementById("chatInput" + sendToCode).value;
		var senderID = document.getElementById("loginUserID").value;
		var senderName = document.getElementById("userName").value;
		
		xmlhttp = createNewRequest();
		
		xmlhttp.onreadystatechange=function()
		  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    {

		    }
		  }

		var Params = "message=" + msg + "&sendToCode=" + sendToCode
						+ "&senderID=" + senderID + "&senderName=" + senderName  ;

		document.getElementById("chatArea" + sendToCode ).innerHTML += "You: " + msg + "\n";
		document.getElementById("chatArea" + sendToCode ).scrollTop = document.getElementById("chatArea" + sendToCode ).scrollHeight;
		
		//send the parameters to the servlet with POST
		xmlhttp.open("POST","../chatRelayServlet" ,true);
		xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xmlhttp.send(Params);

	}
	
	function getMsg( pollingCode ) {
		
//		alert("entered getMsg(" + pollingCode + ")");
		xmlhttp = createNewRequest();
		
//		document.getElementById('imConversation');
		
		xmlhttp.onreadystatechange=function(){
		  if (xmlhttp.readyState==4 && xmlhttp.status==200){
				//alert("getting msg");
				//parse XML response from server
				ParseMsg(xmlhttp.responseXML);
//				alert("msg: " + responseText);
					
			}
		  
		}
		
		
		//send the parameters to the servlet with POST
		//var userID = document.getElementById("userID").value;
		xmlhttp.open("GET","../chatRelayServlet?pollingCode="+pollingCode ,true);
		
		xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xmlhttp.send();
		
	}

	function ParseMsg(responseXML)
	{
		// check first if there is msessage
		var isThereMsg = responseXML.getElementsByTagName('isMsg')[0].getAttribute("boolean");
		if ( isThereMsg != "true" ) {
			return;
		}
		
		var messageList = responseXML.getElementsByTagName('message');
		var printout = "";
		
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
			

			
//			var sender = messageList[iNode].getAttribute("senderID");
//			printout += "User " + sender + " said: \"" + message + "\"\n";


		}

	}
	