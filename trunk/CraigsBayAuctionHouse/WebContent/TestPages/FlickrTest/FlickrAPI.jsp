<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
    <title>Flickr API Example</title>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <!-- <link rel="stylesheet" href="./flickr-api.css" type="text/css" media="Screen" />  -->
    <script  type="text/javascript" language="javascript" src="./flickrAPI.js"></script>
    <script  type="text/javascript" language="javascript" src="./MD5HashFunction.js"></script>
  </head>


<!--
USEFUL INFO, DO NOT DELETE
var apiKey = "301748fd9ccc9801f9ed91772b19d8bd";
var secret = "a6d78a61a59fbf33";
var userID = "55164508@N02";
var api_sig = "92a368003b3e7042f76bb99e8b928891";
-->


<body > 

<div id="responseDiv">
<h2>Hash for Upload</h2>
</div>

<script type="text/javascript">
var tags = "TestTag";
getHash(tags);
//alert( "JSP: " + document.getElementsByName("api_sig").value ); 
</script>

<form enctype="multipart/form-data" method="post"  action="http://api.flickr.com/services/upload/"> 
<!--  <form onsubmit="test()"> -->
<input type="file" name="photo"/>  
<input type="hidden" name="tags" value="TestTag"/>  
<input type="hidden" name="api_key" value="301748fd9ccc9801f9ed91772b19d8bd"/>
<input type="hidden" name="auth_token" value="72157625289914267-ed25c30f0392675d"/>
<!-- <input type="hidden" name="api_sig" value="05fc99a75e09453bc14536bf23593a50"/> -->
<input type="hidden" id="api_sig" name="api_sig" value=""/>
<input type="submit" id="submit" name ="submit" value="Upload"/>
</form>



<h3>Flickr Photos Displayed with Badges:</h3>
<!-- Start of Flickr Badge -->
<h4>Photo with tag = TestTag:</h4>
<script type="text/javascript" src="http://www.flickr.com/badge_code_v2.gne?show_name=1&count=1&display=latest&size=t&layout=v&source=user_tag&user=55164508%40N02&tag=TestTag"></script>
<h4>Photo with tag = tag2:</h4>
<script type="text/javascript" src="http://www.flickr.com/badge_code_v2.gne?show_name=1&count=1&display=latest&size=t&layout=v&source=user_tag&user=55164508%40N02&tag=tag2"></script>


<tr>
</td>
</tr>
</table>
</td></tr></table>


</body>
</html>


<!-- Old example stuff:


<div class="container">
	<h2>Flickr Photos Displayed with FlickrAPI</h2>
   	<script type="text/javascript" language="javascript" src="http://api.flickr.com/services/rest/?format=json&method=flickr.photos.search&user_id=55164508@N02&sort=date-taken-desc&api_key=301748fd9ccc9801f9ed91772b19d8bd"></script>
</div>


<!-- 
<script type="text/javascript" language="javascript" src="http://api.flickr.com/services/rest/?method=flickr.auth.getFrob&api_key=301748fd9ccc9801f9ed91772b19d8bd&api_sig=" + > </script> 
 -->

<!-- GetFrob line, This is hard coded, works for now 
<script type="text/javascript" language="javascript" src="http://api.flickr.com/services/rest/?method=flickr.auth.getFrob&api_key=301748fd9ccc9801f9ed91772b19d8bd&api_sig=92a368003b3e7042f76bb99e8b928891&format=json" > </script> 
-->
 
 <!-- api_sig for upload = 
"a6d78a61a59fbf33api_key301748fd9ccc9801f9ed91772b19d8bdauth_token72157625289914267-ed25c30f0392675dsubmitUploadtagsTestTag" 

05fc99a75e09453bc14536bf23593a50
without "TestTag":
0dbd6bf1d0c36853881f282a04a72c39
-->
 
 
 
