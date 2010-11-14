<html>
<head>
<title>Create Auction Table Test Page</title>

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
ExpiryDate: <select id="ExpiryDate" name="ExpiryDate">
			<option value="1">One day</option>
			<option value="2">Two Days</option>
			<option value="3">Three Days</option>
			<option value="7">One Week</option>
			<option value="14">Two Weeks</option>
		  </select><br>
Category: <select id="Category" name="Category">
			<option value="electronics">Electronics</option>
			<option value="books">Books</option>
			<option value="motors">Motors</option>
			<option value="art">Art</option>
			<option value="music">Music</option>
		  </select><br>


        	  
<div id="createAuctionFeedback"><h2>Feedback Area</h2></div>


<button type="button" onclick="createAuctionRequest()">Create Auction</button>
    
</body>
</html>