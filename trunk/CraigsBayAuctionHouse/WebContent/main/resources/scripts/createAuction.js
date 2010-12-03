//Ajax to create auction
var auctionID;

function createAuctionRequest()
{
	
	var Title = document.getElementById("AuctionTitle").value;
	var MinPrice = document.getElementById("MinPrice").value;
	var ExpiryWeek = document.getElementById("ExpiryWeek").value;
	var ExpiryDay = document.getElementById("ExpiryDay").value;
	var ExpiryHour = document.getElementById("ExpiryHour").value;
	var Category= document.getElementById("Category").value;
	var credential = document.getElementById("cred").value;
	
	//Check User Input
	if(Title == null){
		alert("Must Enter Auction Title!");
		return;
	}
	if(MinPrice.match(/\d{1,10}\.?\d{0,2}/) == null){
		alert("Min Price not valid");
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
		    var responseText= auctionParseXMLResponse(xmlhttp.responseXML);
		   	
		    
	    	document.getElementById("createAuctionFeedback").innerHTML=responseText;

	    }
	  };

	var Params = "Credential=" + credential + "&AuctionTitle=" + Title + "&MinPrice=" + MinPrice
					+ "&ExpiryWeek=" + ExpiryWeek + "&ExpiryDay=" + ExpiryDay 
					+ "&ExpiryHour=" + ExpiryHour +"&Category=" + Category;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../userCreateAuctionServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

	//change the text while sending the request
	document.getElementById("createAuctionFeedback").innerHTML="<h2><img src=./resources/images/loading.gif></img> <p>Sending Request</h2></p>";
}

function loginParseXMLResponse(responseXML)
{
	
	 var toCredential = (responseXML.getElementsByTagName("userCred")[0]).childNodes[0].nodeValue;

	 return toCredential;
}

function auctionParseXMLResponse(responseXML){
	
	 auctionID = (responseXML.getElementsByTagName("success")[0]).childNodes[0].nodeValue;
	 var responseText = "";

	 if(auctionID == -1)
	{
		 responseText = "<h2>Error creating auction!</h2>";
	}
	 else 
	{
		 document.getElementById("tags").value = auctionID;
		 getHash(auctionID);
		 
		// postFlickrUpload(auctionID);
		 
	}
	 responseText = "<h2>Auction Created</h2>";
	 
	 return responseText;
}




/*
 * Handling Flickr Upload in Javascript
 */
function postFlickrUpload(auctionID, hash){
	
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
		   //alert(xmlhttp.responseXML);
	    }
	  };
	  
	  var boundaryString = 'AaBbCcX30';
	  var boundary1 = '--'+boundaryString;
	  var boundary2 = '----'+boundaryString;
	  var boundary3 = '----'+boundaryString+'--';

	  var postContent = 'Content-Disposition: form-data; name="api_key"\r\n'+
	  '\r\n'+
	  '301748fd9ccc9801f9ed91772b19d8bd'+'\r\n'+
	  boundary2+'\r\n'

	  +'Content-Disposition: form-data; name="auth_token"\r\n'+
	  '\r\n'+
	  '72157625289914267-ed25c30f0392675d'+'\r\n'+
	  boundary2+'\r\n'

	  +'Content-Disposition: form-data; name="api_sig"\r\n'+
	  '\r\n'+
	  hash+'\r\n'+
	  boundary3+'\r\n';
	  
	  //Content-Disposition: form-data; name="photo"; filename="C:\test.jpg"

	  var postLength = postContent.length;

	  xmlhttp.open("POST", "http://api.flickr.com/services/upload/",true);
	  xmlhttp.setRequestHeader('Content-type','multipart/form-data; boundary='+boundary1);
	  xmlhttp.setRequestHeader('Content-length', postLength);
	  xmlhttp.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
	  xmlhttp.send(postContent); 
	
	  
}


function flickrUploadResponse(){
	//alert("TestIn");
	document.getElementById("flickrResponse").innerHTML = '<h2><font color="black">Photo Uploaded! You may now close this tab</font></h2><br/>';
	
}

	  
	  










