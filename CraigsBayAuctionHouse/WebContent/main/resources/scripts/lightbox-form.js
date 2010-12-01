

function gradient(id, level)
{
	var box = document.getElementById(id);
	box.style.opacity = level;
	box.style.MozOpacity = level;
	box.style.KhtmlOpacity = level;
	box.style.filter = "alpha(opacity=" + level * 100 + ")";
	box.style.display="block";
	return;
}


function fadein(id) 
{
	var level = 0;
	while(level <= 1)
	{
		setTimeout( "gradient('" + id + "'," + level + ")", (level* 1000) + 10);
		level += 0.01;
	}
}


// Open the lightbox


function openbox(div, formtitle, fadin)
{
  var box = document.getElementById(div); 
  document.getElementById('filter').style.display='block';

  if (formtitle!=null) 
  {
	  var btitle = document.getElementById('boxtitle');
  	  btitle.innerHTML = "<h3>"+formtitle+"</h3>" +
			  		"<input type='image' src='./resources/images/login-cancle.png'"+ 
					"class='login-icon' style='margin-right:0px;'"+ 
					"type='button' name='cancel' value='Cancel' onclick=closebox('regBox')>";
	}
  if(fadin)
  {
	 gradient(div, 0);
	 fadein(div);
  }
  else
  { 	
    box.style.display='block';
  }  	
}


// Close the lightbox

function closebox(div)
{
   document.getElementById(div).style.display='none';
   document.getElementById('filter').style.display='none';
}

//pop up info window



