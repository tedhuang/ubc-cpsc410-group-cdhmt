<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">

<title>Add LI</title>

<script type="text/javascript">

function addListItem( listID, fieldID )
{
 var theList = document.getElementById( listID ),
     theField = document.getElementById( fieldID ),
     newItem;
 
 if( theList && theField && /\S/.test( theField.value ) )
 {
  newItem = theList.appendChild( document.createElement( 'li' ) );    
  newItem.appendChild( document.createTextNode( theField.value ) ); 
 }
 
 delete newItem; 
}

</script>
</head>
<body>
<ul id='myUl'>
  <li> I'm a list item
</ul>
<form action=''> 
<p>
 <input type='text' id='liText'><label for='liText'>Enter text for new list item</label><br>
 <input type='button' id='addBtn' value="Add LI" onclick="addListItem( 'myUl', 'liText' )" >
</form>
</body>
</html>