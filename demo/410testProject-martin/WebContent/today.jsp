Today is: <%= new java.util.Date().toString() %>
<!-- Table of products from store's catalog, one row per item -->
<html>
<head>
<script type="text/javascript">
var var1;
var var2;

function firstvar(firstVar) {
	var1 = firstVar;
}

function secondvar(secondVar) {
	var2 = secondVar;
}

function sendReq() {
	  // Obtain an XMLHttpRequest instance
	  var req = newXMLHttpRequest();

	  // Set the handler function to receive callback notifications
	  // from the request object
	  var handlerFunction = getReadyStateHandler(req, updateSum);
	  req.onreadystatechange = handlerFunction;
	  
	  // Open an HTTP POST connection to the shopping cart servlet.
	  // Third parameter specifies request is asynchronous.
	  req.open("POST", "Calculator.add", true);

	  // Specify that the body of the request contains form data
	  req.setRequestHeader("Content-Type", 
	                       "application/x-www-form-urlencoded");

	  // Send form encoded data stating that I want to add the 
	  // specified item to the cart.
	  req.send("action=add&firstVar="+firstVar+"&secondVar="+secondVar);
}

	function getReadyStateHandler(req, responseXmlHandler) {

	  // Return an anonymous function that listens to the 
	  // XMLHttpRequest instance
	  return function () {

	    // If the request's status is "complete"
	    if (req.readyState == 4) {
	      
	      // Check that a successful server response was received
	      if (req.status == 200) {

	        // Pass the XML payload of the response to the 
	        // handler function
	        responseXmlHandler(req.responseXML);

	      } else {

	        // An HTTP problem has occurred
	        alert("HTTP error: "+req.status);
	      }
	    }
	  }
	}
	
	function updateSum(sumXML) {

		 // Get the root "cart" element from the document
		 var sum = sumXML.getElementsByTagName("sum")[0];

		 // Update the total using the value from the sum document
		 /*
		 document.getElementById("total").innerHTML = 
		                                          sum.getAttribute("sum");
		 */
		}
</script>
</head>

<body>
<form>
<input type="button" value="1" onclick="firstvar('1')" />
<input type="button" value="2" onclick="firstvar('2')" />
<input type="button" value="3" onclick="firstvar('3')" />
<input type="button" value="4" onclick="firstvar('4')" />
<input type="button" value="5" onclick="firstvar('5')" />

<input type="button" value="+1" onclick="secondvar(1)" />
<input type="button" value="+2" onclick="secondvar(2)" />
<input type="button" value="+3" onclick="secondvar(3)" />
<input type="button" value="+4" onclick="secondvar(4)" />
<input type="button" value="+5" onclick="secondvar(5)" />

<input type="button" value=" = " onclick="sendReq()" />

<

</form>

<p>Adding numbers together</p>

</body>
</html>
