<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flickr API test</title>
</head>

<script type="text/javascript">


var apiKey = "301748fd9ccc9801f9ed91772b19d8bd&u";
var userID = "55164508@N02&format";

function ParseXMLResponse( responseXML ) {
	
	//This only works for public albums
	var photosList = responseXML.getElementsByTagName("photos").item(0);

	var photos = photosList.getElementsByTagName("photo");

	var photoID = photos[0].getAttribute("id"); //only get the first photo to test

	//TODO: implement selecting the photo based on the user
	
	var responseText = "http://www.flickr.com/photos/" + apiKey + "/" + photoID + "/";

	System.out.println("ResponseText for Flickr:\n" + responseText);
	
	return responseText;
}


function showImage()
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
		    var responseText= ParseXMLResponse(xmlhttp.responseXML);
		    //alert("responseText: " + responseText);
		   
	    	document.getElementById("div").innerHTML=responseText;
	    }
	  };
	  

  	document.getElementById("div").innerHTML="<h2>Button Clicked</h2>";
  	
	var Params; // "api_key=" + apiKey "&user_id=" + userID;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","flickrServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

	//change the text while sending the email
	document.getElementById("div").innerHTML="<h2>Please wait... Sending Request</h2>";
}

//http://api.flickr.com/services/rest/?&method=flickr.people.getPublicPhotos&api_key=301748fd9ccc9801f9ed91772b19d8bd&user_id=55164508@N02&format
//http://www.flickr.com/photos/55164508@N02/5119444922/


</script>

<body>

<button type="button" onclick="showImage()">Create Gallery</button>
<div id="div"><h2>Feedback</h2></div>


<!-- Can't link this way 
<img src="http://www.flickr.com/photos/55164508@N02/5119444922/" alt="Test Photo"/>
-->


</body>
</html>