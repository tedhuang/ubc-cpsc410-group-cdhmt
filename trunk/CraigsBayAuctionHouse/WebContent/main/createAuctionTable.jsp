<html>
<head>
<title>Create Auction Table Test Page</title>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
</head>

<body>

<!--  this is non-AJAX.
<form action="GmailSMTPServlet" method="POST">
        To Email Address: <input type="text" name="emailAddress" size="20"><br>
        Subject: <input type="text" name="subject" size="20"><br>
        Body: <textarea name="body" cols="40" rows="5">
        	  </textarea><br>
        <input type="submit" value="Send">
</form>
 -->
 
<br>
<h4>Create New Auction</h4>
Title: <input id="AuctionTitle" type="text" name="AuctionTitle" size="20"><br>
MinPrice: <input id="MinPrice" type="text" name="MinPrice" size="12"><br>
<!-- The value returned by the selection corresponds to the number of days till expiry -->
Expire In... :
			Weeks:<select id="ExpiryWeek" name="ExpiryDate">
			<option value="0"></option>
			<option value="1">One</option>
			<option value="2">Two</option>
			<option value="3">Three</option>
			<option value="4">Four</option>
			</select>
			Days:<select id="ExpiryDay" name="ExpiryDate">
			<option value="0"></option>
			<option value="1">One</option>
			<option value="2">Two</option>
			<option value="3">Three</option>
			<option value="4">Four</option>
			<option value="5">Five</option>
			<option value="6">Six</option>
			</select>
			Hours:<select id="ExpiryHour" name="ExpiryDate">
			<option value="0"></option>
			<option value="6">Six</option>
			<option value="12">Twelve</option>
			<option value="18">Eighteen</option>
			</select><br>
Category: <select id="Category" name="Category">
			<option value="electronics">Electronics</option>
			<option value="books">Books</option>
			<option value="motors">Motors</option>
			<option value="art">Art</option>
			<option value="music">Music</option>
		  </select><br>
 <br>

        	  
<div id="createAuctionFeedback"><h2>Feedback Area</h2></div>

<button type="button" onclick="createAuctionRequest()">Create Auction</button>
  


<input type="hidden" value="" id="tagAuctionID">
<!--
<form id ="flickrUploadForm"></form>

  
Photo (optional): <input type="file" name="photoUpload" id="photoUpload"/> 
-->


<div id="flickrResponse" style="display:none">
<h3><font color="black"> If you want, you may add a picture to your auction:</font></h3>
</div>

<div id="flickrForm" style="display:none">
	<form target="_NEW" id="flickrUploadForm" enctype="multipart/form-data" method="post" action="http://api.flickr.com/services/upload/"> 
	<input type="file" name="photo"/>  
	<input type="hidden" name="tags" id="tags" value=""/>  
	<input type="hidden" name="api_key" value="301748fd9ccc9801f9ed91772b19d8bd"/>
	<input type="hidden" name="auth_token" value="72157625289914267-ed25c30f0392675d"/>
	<input type="hidden" id="api_sig" name="api_sig" value=""/>
	<input type="submit" id="submit" name ="submit" value="Upload"/>
	</form>
</div>

<!-- 
<div id="flickrForm" style="display:none">

	<form id="flickrUploadForm" name="flickrUploadForm" enctype="multipart/form-data" method="post"  action="http://api.flickr.com/services/upload/"> 
	<input type="file" name="photo" id="photo"/> 
	<input type="hidden" name="tags" id="tags" value=""/>  
	<input type="hidden" name="api_key" value="301748fd9ccc9801f9ed91772b19d8bd"/>
	<input type="hidden" name="auth_token" value="72157625289914267-ed25c30f0392675d"/>
	<input type="hidden" id="api_sig" name="api_sig" value=""/>
	 <input type="submit" id="submitFlickrButton" name="submit" value="Upload Picture"/>
	</form> 
</div>
	
 -->
    
</body>
</html>