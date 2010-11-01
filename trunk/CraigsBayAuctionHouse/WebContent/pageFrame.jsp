<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>
Page Frame Title
</title>

<script type="text/javascript">

function ParseXMLResponseTitle(responseXML)
{
	
	 var title = (responseXML.getElementsByTagName("title")[0]).childNodes[0].nodeValue;

	 return title;
}

function ParseXMLResponseBody(responseXML)
{
	// var body = (responseXML.getElementsByTagName("body")[0]).childNodes[0].nodeValue;
	// alert( (responseXML.getElementsByTagName("test")[0]).childNodes[0].nodeValue );
	//var body = "<button type=\"button\" > my dyanmaic button </button> ";
	var body = "<iframe width=1000 height = 1000 src = ./ControlPanel/index.html>  </iframe> ";
	 updatePage( body );
}

function requestPage()
{
	//alert("im in");
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
		    //var title= ParseXMLResponseTitle(xmlhttp.responseXML);
		    var body= ParseXMLResponseBody(xmlhttp.responseXML);
		    
	    	//document.getElementById("title").innerHTML=title;
	    	//document.getElementById("body").innerHTML=body;
	    }
	  }

	//send the parameters to the servlet with POST
	var Params = "username=delfino&password=123";
	
	xmlhttp.open("POST","pageFrameTestServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

}



function updatePage( testHTMLcode ) {
	bod 				= document.getElementsByTagName('body')[0];
	overlay 			= document.createElement('div');
	overlay.id		    = 'overlay';

	/*
	overlay.innerHTML   = '<div id=newDiv>' +
							+ testHTMLcode +
							+ '</div>';
	*/
	overlay.innerHTML = testHTMLcode;
	bod.appendChild(overlay); // TODO: maybe we can add another method that uses append for adding new posts to our list in the front page 
	//bod.replaceChild(overlay);
}



</script>

</head>
<body>

<div id="div0">

<button type="button" onclick="requestPage()">Request Page</button>

</div>

</body>
</html>