
/***********************************************
* Dynamic Ajax Content- © Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/

var bustcachevar=1 //bust potential caching of external pages after initial request? (1=yes, 0=no)
var loadedobjects=""
var rootdomain="http://"+window.location.hostname
var bustcacheparameter=""

function ajaxpage(url, containerid){
var page_request = false

if (window.XMLHttpRequest) // if Mozilla, Safari etc
page_request = new XMLHttpRequest()
else if (window.ActiveXObject){ // if IE
try {
page_request = new ActiveXObject("Msxml2.XMLHTTP")
} 
catch (e){
try{
page_request = new ActiveXObject("Microsoft.XMLHTTP")
}
catch (e){}
}
}
else
return false
page_request.onreadystatechange=function(){
loadpage(page_request, containerid)
}
if (bustcachevar) //if bust caching of external page
bustcacheparameter=(url.indexOf("?")!=-1)? "&"+new Date().getTime() : "?"+new Date().getTime()
page_request.open('GET', url+bustcacheparameter, true)
page_request.send(null)
}

function loadpage(page_request, containerid){
if (page_request.readyState == 4 && (page_request.status==200 || window.location.href.indexOf("http")==-1))
{
	document.getElementById(containerid).innerHTML=page_request.responseText;

/*
var source = page_request.responseText;
var scripts = new Array();

while(source.indexOf("<dynamicOnLoad") > -1 || source.indexOf("</dynamicOnLoad") > -1) {
	var s = source.indexOf("<dynamicOnLoad");
	var s_e = source.indexOf(">", s);
	var e = source.indexOf("</dynamicOnLoad", s);
	var e_e = source.indexOf(">", e);
	
	// Add to scripts array
	scripts.push(source.substring(s_e+1, e));
	// Strip from source
	source = source.substring(0, s) + source.substring(e_e+1);
	// Loop through every script collected and eval it
	for(var i=0; i<scripts.length; i++) {
		try {
			alert(scripts[i]);
			eval(scripts[i]);
		}
		catch(ex) {
			// do what you want here when a script fails
		}
	}
	break;
}

*/
	
	//call any dynamic onLoad functions...
	var ob = document.getElementById(containerid).getElementsByTagName("script");
	for(var i=0; i<ob.length-1; i++){
	if(ob[i+1].text!=null && ob[i+1].text!="") 
		{
			//alert(ob[i+1].text);
			eval(ob[i+1].text);
		}
	}
}

}


function loadobjs(){
if (!document.getElementById)
return
for (i=0; i<arguments.length; i++){
var file=arguments[i]
var fileref=""
if (loadedobjects.indexOf(file)==-1){ //Check to see if this object has not already been added to page before proceeding
if (file.indexOf(".js")!=-1){ //If object is a js file
fileref=document.createElement('script')
fileref.setAttribute("type","text/javascript");
fileref.setAttribute("src", file);
}
else if (file.indexOf(".css")!=-1){ //If object is a css file
fileref=document.createElement("link")
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
fileref.setAttribute("href", file);
}
}
if (fileref!=""){
document.getElementsByTagName("head").item(0).appendChild(fileref)
loadedobjects+=file+" " //Remember this object as being already added to page
}
}
}

