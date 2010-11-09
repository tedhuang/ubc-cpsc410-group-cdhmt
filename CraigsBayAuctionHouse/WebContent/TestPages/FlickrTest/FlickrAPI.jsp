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

/**
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


function jsonShowImage(rsp)
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
	  

	  if (rsp.stat != "ok"){
		 // If this executes, something broke!
		 return;
		}
		
		//variable "s" is going to contain 
		//all the markup that is generated by the loop below
		var output = "";
		
		//this loop runs through every item and creates HTML 
	for (var i=0; i < rsp.photos.photo.length; i++) {
		photo = rsp.photos.photo[ i ];
	
		//notice that "t.jpg" is where you change the
		//size of the image
		t_url = "http://farm" + photo.farm + 
		".static.flickr.com/" + photo.server + "/" + 
		photo.id + "_" + photo.secret + "_" + "t.jpg";
		  
		p_url = "http://www.flickr.com/photos/" + 
		photo.owner + "/" + photo.id;
		
		output +=  '<a href="' + p_url + '">' + '<img alt="'+ 
		photo.title + '"src="' + t_url + '"/>' + '</a>';
	}

	 document.writeln(output); 

}  
/*
  	document.getElementById("div").innerHTML="<h2>Button Clicked</h2>";
  	
	var Params; // "api_key=" + apiKey "&user_id=" + userID;

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","flickrServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

	//change the text while sending the email
	document.getElementById("div").innerHTML="<h2>Please wait... Sending Request</h2>";
*/

//http://api.flickr.com/services/rest/?&method=flickr.people.getPublicPhotos&api_key=301748fd9ccc9801f9ed91772b19d8bd&user_id=55164508@N02
//http://www.flickr.com/photos/55164508@N02/5119444922/

//http://api.flickr.com/services/rest/?format=json&amp;method=flickr.people.getPublicPhotos&amp;api_key=301748fd9ccc9801f9ed91772b19d8bd&user_id=55164508@N02

</script>



<body>

<button type="button" onclick="jsonShowImage()">Create Gallery</button>
<div id="div"><h2>Feedback</h2></div>

<div class="container">
	<h2>Div Container</h2>
   <script type="text/javascript" language="javascript" src="http://api.flickr.com/services/rest/?format=json&amp;method=flickr.people.getPublicPhotos&amp;api_key=301748fd9ccc9801f9ed91772b19d8bd&user_id=55164508@N02"></script> 
</div>


</body>
</html>