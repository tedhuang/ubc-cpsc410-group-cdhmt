<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Tabs Demo</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<link href="default.css" rel="stylesheet" type="text/css" />
<link href="tabbed.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="tabbed.js"></script>
<style type="text/css">

/******************************************************************************
* Styles for the tabbed displays.                                             *
******************************************************************************/

/*-----------------------------------------------------------------------------
  Note: The border-radius property is a proposed feature for CSS3 which creates
        rounded corners. Mozilla/Netscape browsers currently support this
        feature via the proprietary -moz-border-radius property. Both are
        defined here. Browsers that support neither should simply ignore them.
-----------------------------------------------------------------------------*/

div.tabBox {}

div.tabArea {
  font-size: 80%;
  font-weight: bold;
  padding: 0px 0px 3px 0px;
}

a.tab {/*Gerenal tab style*/
  background-color: #FFFFFF;
  border: 1px solid #000000;
  border-bottom-width: 0px;
  border-color: #849B9E #849B9E #849B9E #849B9E;
  -moz-border-radius: .75em .75em 0em 0em;
  border-radius-topleft: .75em;
  border-radius-topright: .75em;
  padding: 2px 1em 2px 1em;
  position: relative;
  text-decoration: none;
  top: 3px;
  z-index: 100;
}

a.tab, a.tab:visited {
  color: #2177DA;
}

a.tab:hover {
  background-color: #a080d0;
  border-color: #c0a0f0 #8060b0 #8060b0 #c0a0f0;
  color: #ffe0ff;
}

a.tab.activeTab, a.tab.activeTab:hover, a.tab.activeTab:visited {
  background-color: #2177DA;
  border-color: #2F74D0 #2F74D0 #2F74D0 #2F74D0;
  color: #ffe0ff;
}

a.tab.activeTab {
  padding-bottom: 4px;
  top: 1px;
  z-index: 102;
}


div.tabMain { /*Main tab styles*/
  background-color: #2177DA;
  border: 2px solid #000000;
  border-color: #2177DA #FFFFFF #2177DA #FFFFFF;
  -moz-border-radius: 0em .5em .5em 0em;
  border-radius-topright: .5em;
  border-radius-bottomright: .5em;
  padding: .5em;
  position: relative;
  z-index: 101;
}

div.tabIframeWrapper {
  width: 100%;
}

iframe.tabContent {
  background-color: #DAEBF0;
  border: 1px solid #000000;
  border-color: #049BFF #049BFF #049BFF #049BFF;
  width: 100%;
  height: 100ex;
}

/******************************************************************************
* Additional styles.      
Bar inside the tab                                                    *
******************************************************************************/

h4#title {
  background-color: #2177DA;
  border: 1px solid #000000;
  border-color: #2177DA #2177DA #2177DA #2177DA;
  color: #8ED6EA;
  font-weight: bold;
  margin-top: 0em;
  margin-bottom: .5em;
  padding: 2px .5em 2px .5em;
}

</style>
<script type="text/javascript">//<![CDATA[

//*****************************************************************************
// Do not remove this notice.
//*****************************************************************************

function synchTab(frameName) {

  var elList, i;

  // Exit if no frame name was given.

  if (frameName == null)
    return;

  // Check all links.

  elList = document.getElementsByTagName("A");
  for (i = 0; i < elList.length; i++)

    // Check if the link's target matches the frame being loaded.

    if (elList[i].target == frameName) {

      // If the link's URL matches the page being loaded, activate it.
      // Otherwise, make sure the tab is deactivated.

      if (elList[i].href == window.frames[frameName].location.href) {
        elList[i].className += " activeTab";
        elList[i].blur();
      }
      else
        removeName(elList[i], "activeTab");
    }
}

function removeName(el, name) {

  var i, curList, newList;

  if (el.className == null)
    return;

  // Remove the given class name from the element's className property.

  newList = new Array();
  curList = el.className.split(" ");
  for (i = 0; i < curList.length; i++)
    if (curList[i] != name)
      newList.push(curList[i]);
  el.className = newList.join(" ");
}

//]]></script>
</head>
<body>

<div class="tabBox" style="float:right;width:24em;">
  <div class="tabArea">
    <a class="tab" href="news.html" target="tabIframe1">News</a>
    <a class="tab" href="reviews.html" target="tabIframe1">Reviews</a>
    <a class="tab" href="links.html" target="tabIframe1">Links</a>
  </div>
  <div class="tabMain">
    <div class="tabIframeWrapper"><iframe class="tabContent" name="tabIframe1" src="news.html" marginheight="8" marginwidth="8" frameborder="0" style="height:18ex;"></iframe></div>
  </div>
</div>

<div id="demoBox">

<h3>Tabs Demo</h3>

<p>Tabbed pageFrame Test</p>

</div>

<p></p>

<div class="tabBox" style="clear:both;">
  <div class="tabArea">
  	<a class="tab" href="tableLoad.jsp" target="tabIframe2">Auctions</a>
    <a class="tab" href="pageFrame.jsp" target="tabIframe2">Control Panel</a>
    <a class="tab" href="#" target="tabIframe2">Messages</a>
    <a class="tab" href="#" target="tabIframe2">History</a>
    <a class="tab" href="#" target="tabIframe2">...</a>
  </div>
  <div class="tabMain">
    <h4 id="title">Top Picks</h4>
    <div class="tabIframeWrapper"><iframe class="tabContent" name="tabIframe2" src="action.html" marginheight="8" marginwidth="8" frameborder="0"></iframe></div>
  </div>
</div>

</body>
</html>