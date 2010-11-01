<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<script type="text/javascript">
function checkAuctionList(){
	
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
		    //var responseText= ParseXMLResponse(xmlhttp.responseXML);
		    //alert("responseText: " + responseText);   
			
	    	document.getElementById("myDiv").innerHTML="<h2>We got it</h2>";
	    }
	  }

	//send the parameters to the servlet with POST
	xmlhttp.open("POST","../listAuctionServlet" ,true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send();

	//change the text while sending the email
	document.getElementById("myDiv").innerHTML="<h2>Please wait... Sending Request</h2>";
}

</script>

        	  
<div id="myDiv"><h2>Feedback Area</h2></div>



<button type="button" onclick="checkAuctionList()">Check Auction List</button>
</body>
</html>