
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

	    	document.getElementById("api_sig").value=hash;
	    				//alert( document.getElementById("flickrUploadForm").innerHTML );
	    	
	    	document.getElementById("submit").disabled=false;
	    
	    	//document.getElementById("flickrResponse").innerHTML = "<h3>If you want, you may add a picture to your auction:</h3>";
	    	var myflickrResponsediv = document.getElementById("flickrResponse");
	    	myflickrResponsediv.style.visibility="";
	    	myflickrResponsediv.style.display="";
	    	
	    	var mydiv = document.getElementById("flickrForm");
	    	mydiv.style.visibility="";
	    	mydiv.style.display="";
	    	
	    	
	    	
	    	
	    	//postFlickrUpload(tags, hash);
	    	//document.getElementById("flickrUploadForm").submit();
	    }
	  };
	  
	document.getElementsByName("submit").disabled=true;
	
	 
	var Params = "tags=" + tags;
	
	xmlhttp.open("POST","/CraigsBayAuctionHouse/flickrServlet" ,true); 
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.send(Params);
	
}








