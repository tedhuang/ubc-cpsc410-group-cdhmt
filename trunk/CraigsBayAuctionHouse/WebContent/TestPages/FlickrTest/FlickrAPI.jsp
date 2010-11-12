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
http://api.flickr.com/services/rest/?&method=flickr.people.getPublicPhotos&api_key=301748fd9ccc9801f9ed91772b19d8bd&user_id=55164508@N02&format=json
http://www.flickr.com/photos/55164508@N02/5119444922/

var apiKey = "301748fd9ccc9801f9ed91772b19d8bd";
var secret = "a6d78a61a59fbf33";
var userID = "55164508@N02";
auth_token=72157625364835544-ed3bb7ac6f3981be
api_sig=13ab38217c6bc5e98d72059d24921d2a
-->

<h3>Uploading Test:</h3>


<script type="text/javascript" language="javascript" src="http://api.flickr.com/services/rest/?format=json&method=flickr.photos.search&user_id=55164508@N02&sort=date-taken-desc&api_key=301748fd9ccc9801f9ed91772b19d8bd"></script>


<body onload="javascript:window.getSig()">

<input type="hidden" id="hash" value=""/>

<script type="text/javascript" language="javascript" src="http://api.flickr.com/services/rest/?method=flickr.auth.getFrob&api_key=4b29109dde7b7a3d9f64920b8a574694&api_sig=13ab38217c6bc5e98d72059d24921d2a" ></script>


<form enctype="multipart/form-data" method="post"  action="http://api.flickr.com/services/upload/">
<input type="file" name="photo"/>
<input type="hidden" name="api_key" value="301748fd9ccc9801f9ed91772b19d8bd"/>
<input type="hidden" name="auth_token" value=""/>
<input type="hidden" name="api_sig" value=""/>
<input type="submit" name ="submit" value="Upload"/>
</form>



<div class="container">
	<h2>Flickr Photos Displayed with FlickrAPI</h2>
   	<script type="text/javascript" language="javascript" src="http://api.flickr.com/services/rest/?format=json&method=flickr.photos.search&user_id=55164508@N02&sort=date-taken-desc&api_key=301748fd9ccc9801f9ed91772b19d8bd"></script>
</div>





<h3>Flickr Photos Displayed with Badges (HTML) might need couple days to work:</h3>
<!-- Start of Flickr Badge -->
<style type="text/css">
#flickr_badge_source_txt {padding:0; font: 11px Arial, Helvetica, Sans serif; color:#666666;}
#flickr_badge_icon {display:block !important; margin:0 !important; border: 1px solid rgb(0, 0, 0) !important;}
#flickr_icon_td {padding:0 5px 0 0 !important;}
.flickr_badge_image {text-align:center !important;}
.flickr_badge_image img {border: 1px solid black !important;}
#flickr_badge_uber_wrapper {width:150px;}
#flickr_www {display:block; text-align:center; padding:0 10px 0 10px !important; font: 11px Arial, Helvetica, Sans serif !important; color:#3993ff !important;}
#flickr_badge_uber_wrapper a:hover,
#flickr_badge_uber_wrapper a:link,
#flickr_badge_uber_wrapper a:active,
#flickr_badge_uber_wrapper a:visited {text-decoration:none !important; background:inherit !important;color:#3993ff;}
#flickr_badge_wrapper {background-color:#ffffff;border: solid 1px #000000}
#flickr_badge_source {padding:0 !important; font: 11px Arial, Helvetica, Sans serif !important; color:#666666 !important;}
</style>

<!-- This line is basically what you need. Everything above is just for looks -->
<script type="text/javascript" src="http://www.flickr.com/badge_code_v2.gne?show_name=1&count=1&display=latest&size=t&layout=v&source=user_tag&user=55164508%40N02&tag=tag1"></script>

<tr>
</td>
</tr>
</table>
</td></tr></table>
<!-- End of Flickr Badge -->


<h3>All public photos:</h3>
<script type="text/javascript" src="http://www.flickr.com/badge_code_v2.gne?show_name=1&count=10&display=latest&size=t&layout=v&source=user&user=55164508%40N02"></script>




</body>
</html>

