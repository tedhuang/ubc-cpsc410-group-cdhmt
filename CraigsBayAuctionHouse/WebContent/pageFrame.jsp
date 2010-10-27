<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title id='title'>Insert title here</title>

<script type="text/javascript">

function ParseXMLResponseTitle(responseXML)
{
	
	 var title = (responseXML.getElementsByTagName("title")[0]).childNodes[0].nodeValue;

	 return title;
}

function ParseXMLResponseTitle(responseXML)
{
	 var body = (responseXML.getElementsByTagName("body")[0]).childNodes[0].nodeValue;
	 
	 return body;
}

function requestPage()
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
		    var title= ParseXMLResponseTitle(xmlhttp.responseXML);
		    var body= ParseXMLResponseBody(xmlhttp.responseXML);
		    
	    	document.getElementById("title").innerHTML=title;
	    	document.getElementById("body").innerHTML=body;
	    }
	  }

	//send the parameters to the servlet with POST
	var Params = "test";
	
	xmlhttp.open("POST","pageFrameTest" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

}

</script>

</head>
<body id=body>


<button type="button" onclick="requestPage()">Request Page</button>

</body>
</html>