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
		   alert(xmlhttp.responseXML);
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
	alert("TestIn");
	document.getElementById("flickrResponse").innerHTML = '<h2><font color="black">Photo Uploaded! You may now close this tab</font></h2><br/>';
	
}

	  
	  
 /*************************************
  * None of the below methods worked  *
  * ***********************************
	
	document.getElementById("flickrUploadForm").innerHTML += 
		'<form enctype="multipart/form-data" id="flickrUploadForm" action="http://api.flickr.com/services/upload/" method="post"></form>'+    
		'<input type="file" name="photo" id="photo" value=' + document.getElementById("photoUpload").value + '/>' + 
		'<input type="hidden" name="tags" id="tags" value=' + auctionID + '/>' +
		'<input type="hidden" name="api_key" value="301748fd9ccc9801f9ed91772b19d8bd"/>'+
		'<input type="hidden" name="auth_token" value="72157625289914267-ed25c30f0392675d"/>'+
		'<input type="hidden" id="api_sig" name="api_sig" value=' + hash + '/>'+
		'<input type="submit" id="submitFlickrUpload" name ="submit" value="Upload"/>';
	
	
	====================================================================
	
	var Params = "photo="+ document.getElementById("photo").value + "&tags=" + auctionID + 
				"&api_key=301748fd9ccc9801f9ed91772b19d8bd" + "&auth_token=72157625289914267-ed25c30f0392675d" +
				"&api_sig=" + hash;
	
	xmlhttp.open("POST","http://api.flickr.com/services/upload/" ,true); 
	req.setRequestHeader("Content-Type", "multipart/form-data");
	xmlhttp.send(Params);
	

	var form = document.createElement("form");
	form.setAttribute("enctype", "multipart/form-data");
	form.setAttribute("method", "post");
	form.setAttribute("action", "http://api.flickr.com/services/upload/");

    var photo =  document.createElement("input"); //document.getElementById("photoUpload").value;
    	photo.setAttribute("type", "file");
	    photo.setAttribute("name", "photo");
	    photo.setAttribute("value", document.getElementById("photo").value);
	    form.appendChild(photo);
	    
    var tags =  document.createElement("input");//auctionID;
    	tags.setAttribute("type", "hidden");
    	tags.setAttribute("name", "tags"); 
    	tags.setAttribute("value", "TestTag"); //    	tags.setAttribute("value", auctionID);
    	form.appendChild(tags);

    var api_key =  document.createElement("input"); //"301748fd9ccc9801f9ed91772b19d8bd";
	    api_key.setAttribute("type", "hidden");
	    api_key.setAttribute("name", "api_key");
	    api_key.setAttribute("value","301748fd9ccc9801f9ed91772b19d8bd");
	    form.appendChild(api_key);
	    
    var aut_token =  document.createElement("input");//"72157625289914267-ed25c30f0392675d";
    	aut_token.setAttribute("type", "hidden");
    	aut_token.setAttribute("name", "auth_token");
	    aut_token.setAttribute("value", "72157625289914267-ed25c30f0392675d");
	    form.appendChild(aut_token);
	    
    var api_sig =  document.createElement("input");//hash;
    	api_sig.setAttribute("type", "hidden");
    	api_sig.setAttribute("name", "api_sig");
    	api_sig.setAttribute("value", "05fc99a75e09453bc14536bf23593a50"); //    	api_sig.setAttribute("value", hash);
    	form.appendChild(api_sig);       
    alert(form.innerHTML);
    form.submit();
    */











