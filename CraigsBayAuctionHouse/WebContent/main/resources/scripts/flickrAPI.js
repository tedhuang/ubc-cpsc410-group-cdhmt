
var hash;

function getHash(tags){ 
		
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
	    	hash = (xmlhttp.responseXML.getElementsByTagName("hash")[0]).childNodes[0].nodeValue;
	    	//alert("js: " + hash);
	    	document.getElementById("api_sig").value=hash;
	    	//alert("document.getElementById(api_sig).value="  + document.getElementById("api_sig").value);
	    	document.getElementById("submit").disabled=false;
	    	
	    	//document.getElementById("hash").value = (xmlhttp.responseXML.getElementsByTagName("hash")[0]).childNodes[0].nodeValue;
	    }
	  };
	  
	document.getElementsByName("submit").disabled=true;
	
	var Params = "tags=" + tags;
	
	xmlhttp.open("POST","/CraigsBayAuctionHouse/flickrServlet" ,true); 
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);

}








