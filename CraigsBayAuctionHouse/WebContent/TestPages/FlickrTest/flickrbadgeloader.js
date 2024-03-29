/* 
 * This helper script is taken from online tutorial. 
 * (Script is released under Creative Commons Attribution 3.0 License)
 * 
 * Credits goes to:
 * Flickrbadge v2.1 by Christian Heilmann http://wait-till-i.com  
 * */

function YAHOO_config_run(o){if(o===undefined){var feedUrl='http://yui.yahooapis.com/2.3.0/build/yahoo-dom-event/yahoo-dom-event.js';var s=document.createElement('script');s.src=feedUrl;s.type='text/javascript';document.getElementsByTagName('head')[0].appendChild(s);};if(o&&o.name==='yahoo-dom-event'){YAHOO.example.flickrbadge=function(){var YD=YAHOO.util.Dom,YE=YAHOO.util.Event,d=document,head=d.getElementsByTagName('head')[0];

// Variables to change 
var containerClass='flickrbadge';
var openClass='flickrbadgeopen';
var originClass='flickrlink';
var listClass='flickritems';
var bigImgageClass='flickrimage';
var CSSURL='flickrbadge.css';
var prevHTML='<img src="la.gif" alt="prev">';
var nextHTML='<img src="ra.gif" alt="next">';
var seeAllLabel='see all photos';
var navClass='flickrnav';
var currentClass='current';

//alert("In Loader");

// Evil, dark magic, don't touch! 
var bs=[];
var c=d.createElement('link');c.rel='stylesheet';c.type='text/css';c.href=CSSURL;head.appendChild(c);

function seed(o){var reg=/\/|:|@|\./g;

var chunks=o.link.split('/');chunks[4]=o.items[0].author_id;

var id=chunks.join('/').replace(reg,'');var ori=d.getElementById(id);var oldori=d.getElementById(o.link.replace(reg,''));

if(!ori){if(oldori){ori=oldori;}else{return;}}var out='';

var list=d.createElement('ul');YE.on(list,'click',show);YD.addClass(list,listClass);

for(var i=0;o.items[i];i++){if(i%5===0){
	if(i>0){
		out+='</ul></li>';
		};
		out+='<li><ul>';};
		out+='<li><a href="'+o.items[i].link+'"><img src="'+o.items[i].media.m.replace('_m','_s')+'" alt="'+o.items[i].title+'"></a></li>';};
		list.innerHTML=out;ori.appendChild(list);
		var outlist=d.createElement('ul');YD.addClass(outlist,navClass);
		var li=d.createElement('li');var back=d.createElement('a');back.href='#';
		YE.on(back,'click',go,{dir:-1,id:id});back.innerHTML=prevHTML;li.appendChild(back);outlist.appendChild(li);
		var li=d.createElement('li');
		var span=document.createElement('span');span.innerHTML='1 / 4';
		bs[id]={};
		bs[id].count=span;
		li.appendChild(span);
		outlist.appendChild(li);
		var li=d.createElement('li');
		var fwd=d.createElement('a');fwd.href='#';
		YE.on(fwd,'click',go,{dir:1,id:id});
		fwd.innerHTML=nextHTML;li.appendChild(fwd);outlist.appendChild(li);
		ori.appendChild(outlist);bs[id].sets=list.getElementsByTagName('ul');
		var p=d.createElement('p');
		var a=d.createElement('a');
		a.href=o.link;
		a.innerHTML=seeAllLabel;
		p.appendChild(a);
		ori.appendChild(p);bs[id].current=0;YD.addClass(bs[id].sets[0],currentClass);
		};
		
		function show(e,o){
			var t=YE.getTarget(e);
			if(t.nodeName.toLowerCase()==='img'){
				var id=this.parentNode.id;if(bs[id].img){bs[id].img.parentNode.removeChild(bs[id].img);};var img=document.createElement('img');img.src=t.src.replace('_s','_m');YE.on(img,'click',function(){bs[this.parentNode.id].img=null;YD.removeClass(this.parentNode,openClass);this.parentNode.removeChild(this);});YD.addClass(img,bigImgageClass);this.parentNode.appendChild(img);YD.addClass(this.parentNode,openClass);bs[this.parentNode.id].img=img;};YE.preventDefault(e);};function go(e,o){var b=bs[o.id];YD.removeClass(b.sets[b.current],currentClass);b.current=b.current+o.dir;if(b.current===4){b.current=0;}if(b.current===-1){b.current=3;}b.count.innerHTML=(b.current+1)+' / 4';YD.addClass(b.sets[b.current],currentClass);YE.preventDefault(e);};function init(o){var src=o.getElementsByTagName('a')[0];YD.addClass(src,originClass);var data=sanitizeUrl(src.href.replace('%40','@'));o.id=data[1];var s=d.createElement('script');s.src=data[0];s.type='text/javascript';head.appendChild(s);};function sanitizeUrl(url){var url=url.replace(/\/$/,'');var realname=(url.indexOf('#')!==-1)?url.split('#')[1]:null;url=url.split('#')[0];var chunks=url.split('/');var all=chunks.length;var apiurl='http://api.flickr.com/services/feeds/photos_public.gne?id=';if(url.indexOf('tags')!==-1){var feedURL=apiurl+chunks[all-3]+'&tags='+chunks[all-1]+'&format=json';chunks[all-3]=realname||chunks[all-3];}else{var feedURL=apiurl+chunks[all-1]+'&format=json';chunks[all-1]=realname||chunks[all-1];}var id=chunks.join('/').replace(/\/|:|@|\.|#.*/g,'');return[feedURL,id];};var bs=YD.getElementsByClassName(containerClass,'div');YD.batch(bs,init);return{seed:seed,go:go};}();};};function jsonFlickrFeed(o){YAHOO.example.flickrbadge.seed(o);};YAHOO_config={listener:YAHOO_config_run};YAHOO_config_run();

		
		
		
		