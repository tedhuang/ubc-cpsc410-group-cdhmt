<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flickr API test</title>
</head>

<script type="text/javascript">

function createGallery()
{
	
	//var responseXML = "http://api.flickr.com/services/rest/?&method=flickr.people.getPublicPhotos&api_key=301748fd9ccc9801f9ed91772b19d8bd&user_id=55164508@N02";
		
	
	 //var message = (responseXML.getElementsByTagName("owner")[0]).childNodes[0].nodeValue;

	 //var responseText = "<h2>Return is: ";
	 //responseText += message;

	 document.getElementById("myDiv").innterHTML="<h2>SOMETHING HAPPENED</h2>";
}

//http://api.flickr.com/services/rest/?&method=flickr.people.getPublicPhotos&api_key=301748fd9ccc9801f9ed91772b19d8bd&user_id=55164508@N02&format=json



</script>

<body>

<div id="myDiv"><h2>Feedback Area</h2></div>

<button type="button" onclick="createGallery()">Create Gallery</button>

</body>
</html>