/************************************************************************************************************
Tab view
Copyright (C) 2010  UBC CPSC 410 CraigsBay Team
Cheng Chen

************************************************************************************************************/

	var textPadding = 3; // Padding at the left of tab text - bigger value gives you wider tabs
	var strictDocType = true;
	var tabFrame_maxNumberOfTabs = 15;	// Maximum number of tabs

	/* Don't change anything below here */
	var tabObj = new Array();
	var activeTabIndex = new Array();
	var MSIE = navigator.userAgent.indexOf('MSIE')>=0?true:false;

	var regExp = new RegExp(".*MSIE ([0-9]\.[0-9]).*","g");
	var navigatorVersion = navigator.userAgent.replace(regExp,'$1');

	var ajaxObjects = new Array();
	var tabFrame_countTabs = new Array(); //Array of all tabs
	var tabFrameHeight = new Array();
	var tabDivCounter = 0;
	var closeImageHeight = 8;	// Pixel height of close buttons
	var closeImageWidth = 8;	// Pixel height of close buttons


	function setPadding(obj,padding){
		var span = obj.getElementsByTagName('SPAN')[0];
		span.style.paddingLeft = padding + 'px';
		span.style.paddingRight = padding + 'px';
	}
/*************************************************************************************
 * 				
 * 					SHOW ACTIVE TABS
 * 
 * @param parentId
 * @param tabIndex
 *************************************************************************************/
	function showTab(parentId,tabIndex)
	{
		var parentId_div = parentId + "_";
		if(!document.getElementById('tabFrame' + parentId_div + tabIndex)){
			return;
		}
		if(activeTabIndex[parentId]>=0){
			if(activeTabIndex[parentId]==tabIndex){
				return;
			}

			var obj = document.getElementById('tabTitle'+parentId_div + activeTabIndex[parentId]);

			obj.className='tabInactive';
			var img = obj.getElementsByTagName('IMG')[0];
			if(img.src.indexOf('tab_')==-1)img = obj.getElementsByTagName('IMG')[1];
			img.src = './resources/images/tab_right_inactive.gif';
			document.getElementById('tabFrame' + parentId_div + activeTabIndex[parentId]).style.display='none';
		}

		var thisObj = document.getElementById('tabTitle'+ parentId_div +tabIndex);

		thisObj.className='tabActive';
		var img = thisObj.getElementsByTagName('IMG')[0];
		if(img.src.indexOf('tab_')==-1)img = thisObj.getElementsByTagName('IMG')[1];
		img.src = './resources/images/tab_right_active.gif';

		document.getElementById('tabFrame' + parentId_div + tabIndex).style.display='block';
		activeTabIndex[parentId] = tabIndex;


		var parentObj = thisObj.parentNode;
		var aTab = parentObj.getElementsByTagName('DIV')[0];
		countObjects = 0;
		var startPos = 2;
		var previousObjectActive = false;
		while(aTab){
			if(aTab.tagName=='DIV'){
				if(previousObjectActive){
					previousObjectActive = false;
					startPos-=2;
				}
				if(aTab==thisObj){
					startPos-=2;
					previousObjectActive=true;
					setPadding(aTab,textPadding+1);
				}else{
					setPadding(aTab,textPadding);
				}

				aTab.style.left = startPos + 'px';
				countObjects++;
				startPos+=2;
			}
			aTab = aTab.nextSibling;
		}

		return;
	}

	function tabClick()
	{
		var idArray = this.id.split('_');
		showTab(this.parentNode.parentNode.id,idArray[idArray.length-1].replace(/[^0-9]/gi,''));

	}

	function rolloverTab()
	{
		if(this.className.indexOf('tabInactive')>=0){
			this.className='inactiveTabOver';
			var img = this.getElementsByTagName('IMG')[0];
			if(img.src.indexOf('tab_')<=0)img = this.getElementsByTagName('IMG')[1];
			img.src = './resources/images/tab_right_over.gif';
		}

	}
	function rolloutTab()
	{
		if(this.className ==  'inactiveTabOver'){
			this.className='tabInactive';
			var img = this.getElementsByTagName('IMG')[0];
			if(img.src.indexOf('tab_')<=0)img = this.getElementsByTagName('IMG')[1];
			img.src = './resources/images/tab_right_inactive.gif';
		}

	}

	function hovertabFrameCloseButton()
	{
		this.src = this.src.replace('close.gif','close_over.gif');
	}

	function stopHovertabFrameCloseButton()
	{
		this.src = this.src.replace('close_over.gif','close.gif');
	}

/******************************************************************************************************
 * 
 * 							Initialize Tabs
 * 
 * @param mainContainerID
 * @param tabTitles
 * @param activeTab
 * @param width
 * @param height
 * @param closeButtonArray
 * @param additionalTab
 * @returns
 **************************************************************************************************/
	function initTabs(mainContainerID,tabTitles,activeTab,width,height,closeButtonArray,additionalTab)
	{
		if(!closeButtonArray)closeButtonArray = new Array();

		if(!additionalTab || additionalTab=='undefined'){
			tabObj[mainContainerID] = document.getElementById(mainContainerID);
			width = width + '';
			if(width.indexOf('%')<0)width= width + 'px';
			tabObj[mainContainerID].style.width = width;

			height = height + '';
			if(height.length>0){
				if(height.indexOf('%')<0)height= height + 'px';
				tabObj[mainContainerID].style.height = height;
			}


			tabFrameHeight[mainContainerID] = height;

			var tabDiv = document.createElement('DIV');
			var firstDiv = tabObj[mainContainerID].getElementsByTagName('DIV')[0];

			tabObj[mainContainerID].insertBefore(tabDiv,firstDiv);
			tabDiv.className = 'dhtmlgoodies_tabPane';
			tabFrame_countTabs[mainContainerID] = 0;

		}else{
			var tabDiv = tabObj[mainContainerID].getElementsByTagName('DIV')[0];
			var firstDiv = tabObj[mainContainerID].getElementsByTagName('DIV')[1];
			height = tabFrameHeight[mainContainerID];
			activeTab = tabFrame_countTabs[mainContainerID];


		}



		for(var no=0;no<tabTitles.length;no++){
			var aTab = document.createElement('DIV');
			aTab.id = 'tabTitle' + mainContainerID + "_" +  (no + tabFrame_countTabs[mainContainerID]);
			aTab.onmouseover = rolloverTab;
			aTab.onmouseout = rolloutTab;
			aTab.onclick = tabClick;
			aTab.className='tabInactive';
			tabDiv.appendChild(aTab);
			var span = document.createElement('SPAN');
			span.innerHTML = tabTitles[no];
			span.style.position = 'relative';
			aTab.appendChild(span);

			if(closeButtonArray[no]){
				var closeButton = document.createElement('IMG');
				closeButton.src = './resources/images/close.gif';
				closeButton.height = closeImageHeight + 'px';
				closeButton.width = closeImageHeight + 'px';
				closeButton.setAttribute('height',closeImageHeight);
				closeButton.setAttribute('width',closeImageHeight);
				closeButton.style.position='absolute';
				closeButton.style.top = '6px';
				closeButton.style.right = '0px';
				closeButton.onmouseover = hovertabFrameCloseButton;
				closeButton.onmouseout = stopHovertabFrameCloseButton;

				span.innerHTML = span.innerHTML + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';

				var deleteTxt = span.innerHTML+'';

				closeButton.onclick = function(){ deleteTab(this.parentNode.innerHTML) };
				span.appendChild(closeButton);
			}

			var img = document.createElement('IMG');
			img.valign = 'bottom';
			img.src = './resources/images/tab_right_inactive.gif';
			// IE5.X FIX
			if((navigatorVersion && navigatorVersion<6) || (MSIE && !strictDocType)){
				img.style.styleFloat = 'none';
				img.style.position = 'relative';
				img.style.top = '4px'
				span.style.paddingTop = '4px';
				aTab.style.cursor = 'hand';
			}	// End IE5.x FIX
			aTab.appendChild(img);
		}

		var tabs = tabObj[mainContainerID].getElementsByTagName('DIV');
		var divCounter = 0;
		for(var no=0;no<tabs.length;no++){
			if(tabs[no].className=='dhtmlgoodies_aTab' && tabs[no].parentNode.id == mainContainerID){
				if(height.length>0)tabs[no].style.height = height;
				tabs[no].style.display='none';
				tabs[no].id = 'tabFrame' + mainContainerID + "_" + divCounter; //tab frame id
				divCounter++;
			}
		}
		tabFrame_countTabs[mainContainerID] = tabFrame_countTabs[mainContainerID] + tabTitles.length;
		showTab(mainContainerID,activeTab);

		return activeTab;
	}

	
	
	function showAjaxTabContent(ajaxIndex,parentId,tabId)
	{
		var obj = document.getElementById('tabFrame'+parentId + '_' + tabId);
		obj.innerHTML = ajaxObjects[ajaxIndex].response;
	}

	function resetTabIds(parentId)
	{
		var tabTitleCounter = 0;
		var tabContentCounter = 0;


		var divs = tabObj[parentId].getElementsByTagName('DIV');


		for(var no=0;no<divs.length;no++){
			if(divs[no].className=='dhtmlgoodies_aTab'){
				divs[no].id = 'tabFrame' + parentId + '_' + tabTitleCounter;
				tabTitleCounter++;
			}
			if(divs[no].id.indexOf('tabTitle')>=0){
				divs[no].id = 'tabTitle' + parentId + '_' + tabContentCounter;
				tabContentCounter++;
			}


		}

		tabFrame_countTabs[parentId] = tabContentCounter;
	}

/****************************************************************************************************************************************
 * 
 * 								Create New Tab Function
 * 
 * @param parentId --> The Tab Panel ID
 * @param tabTitle --> New Table Title
 * @param tabContent --> Anything if not holding pages 
 * @param tabContentUrl --> The page this tab will hold
 * @param closeButton --> True for disposable tab; False for non-disposable tabs 
 *****************************************************************************************************************************************/
	function createNewTab(parentId,tabTitle,tabContent,tabContentUrl,closeButton)
	{
		if(tabFrame_countTabs[parentId]>=tabFrame_maxNumberOfTabs)return;	// Maximum number of tabs reached - return
		var div = document.createElement('DIV');    //new tab Frame
		div.className = 'dhtmlgoodies_aTab';
		tabObj[parentId].appendChild(div);

		var tabId = initTabs(parentId,Array(tabTitle),0,'','',Array(closeButton),true);
		if(tabContent)div.innerHTML = tabContent;  //if tabcontent is not null tab will display this "tabContent" 
		if(tabContentUrl){						  //Only Will hold page if tabContent is not null
			var ajaxIndex = ajaxObjects.length;
			ajaxObjects[ajaxIndex] = new sack();
			ajaxObjects[ajaxIndex].requestFile = tabContentUrl;	// Specifying which file to get

			ajaxObjects[ajaxIndex].onCompletion = function(){ showAjaxTabContent(ajaxIndex,parentId,tabId); };	// Specify function that will be executed after file has been found
			ajaxObjects[ajaxIndex].runAJAX();		// Execute AJAX function

		}

	}
	

/****************************************************************************************************************************************
 * 
 * 								Create ADV SEARCH Tab Function
 * 
 * @param parentId --> The Tab Panel ID
 * @param tabTitle --> New Table Title
 * @param closeButton --> True for disposable tab; False for non-disposable tabs 
 *****************************************************************************************************************************************/
function createAdvSearchTab(parentId,tabTitle,closeButton)
{
	if(tabFrame_countTabs[parentId]>=tabFrame_maxNumberOfTabs)return;	// Maximum number of tabs reached - return
	var div = document.createElement('DIV');    //new tab Frame
	div.className = 'dhtmlgoodies_aTab';
	tabObj[parentId].appendChild(div);
	
	var title = document.createElement('SPAN');
	title.id = 'advSearchTitle';
	var searchResultArea = document.createElement('TABLE');
	searchResultArea.innerHTML = "<tr><th><input class=\"check-all\" type='checkbox' /></th>"+
								"<th>Auction Item</th><th>Status</th><th>Time Left</th>" +
								"<th>Latest Price</th><th>Category</th><th>Number of Bids</th></tr>" +
								"<tBody id='searchRsltArea'></tBody>";
//	searchResultArea.id='searchRsltArea';
	
//	var resultHeader = document.createElement('THEAD');
//	resultHeader.id='tableHeader';
//	resultHeader.
	
//	searchResultArea.appendChild(resultHeader);
	//	searchResultArea.setAttribute("class", 'content-box');
	

	var tabId = initTabs(parentId,Array(tabTitle),0,'','',Array(closeButton),true);
	div.innerHTML = "<input type='text' id='advancedSearchTitle' value='search Auctions...'" +
	  				" onclick=\"SelectAll('advancedSearchTitle')\">"+
	  				"<FORM name='searchOpt'>"+ 
					"<select name='searchCondition1' class='small-input' onChange=\"cascadeOpt(searchCondition1)\">"+ //cascadeOpt Not working
						"<option value='searchOption'>Search By</option>"+
						"<option value='searchByCategory'>Category</option>"+
						"<option value='searchByPeople'>Owner</option></select></FORM>"+
  
						"<select id='searchCategory'>" +
						
						"<option value=''> Pick a Category</option><option value='electronics'>Electronics</option>"+
						"<option value='books'>Books</option><option value='motors'>Motors</option>"+
						"<option value='art'>Art</option><option value='music'>Music</option></select>"+
				"<input type='text' id='searchOwner' value='search By Authors...' onclick=\"SelectAll('searchOwner')\"/><br>"+
				"<input type='image' id='advSearchBtn' src='./resources/images/advancedSearch.png' title='Advanced Search' onClick=\"searchAuctionTable(1,'')\"/>";  
	div.appendChild(title);
	div.appendChild(searchResultArea);
}
function SelectAll(id)
{
    document.getElementById(id).focus();
    document.getElementById(id).select();
}
/****************************************************************************************************************************************
 * 
 * 								Create View All Item Tab Function
 * 
 * @param parentId --> The Tab Panel ID
 * @param tabTitle --> New Table Title
 * @param closeButton --> True for disposable tab; False for non-disposable tabs 
 *****************************************************************************************************************************************/
function createAllItemViewTab(parentId,tabTitle,closeButton)
{
	if(tabFrame_countTabs[parentId]>=tabFrame_maxNumberOfTabs)return;	// Maximum number of tabs reached - return
	var div = document.createElement('DIV');    //new tab Frame
	div.className = 'dhtmlgoodies_aTab';
	tabObj[parentId].appendChild(div);
	
	var title = document.createElement('SPAN');
	title.id='allItemTitle';
	
	var frame = document.createElement('DIV');
	frame.id = 'allItemTab';
	frame.innerHTML="<div id='allItemArea'></div>";
	
	var tabId = initTabs(parentId,Array(tabTitle),0,'','',Array(closeButton),true);
	div.appendChild(title);
	div.appendChild(frame);
}
/****************************************************************************************************************************************
 * 
 * 								Create View DETAIL Tab Function
 * 
 * @param parentId --> The Tab Panel ID
 * @param tabTitle --> New Table Title
 * @param closeButton --> True for disposable tab; False for non-disposable tabs 
 *****************************************************************************************************************************************/
function createDetailViewTab(parentId,tabTitle,closeButton)
{
	if(tabFrame_countTabs[parentId]>=tabFrame_maxNumberOfTabs)return;	// Maximum number of tabs reached - return
	var div = document.createElement('DIV');    //new tab Frame
	div.className = 'dhtmlgoodies_aTab';
	tabObj[parentId].appendChild(div);
	
	var title = document.createElement('SPAN');
	title.id='detailTitle';
	
	var frame = document.createElement('DIV');
	frame.id = 'auctionDetailTab';
	frame.innerHTML="<div id='itemDetailArea'></div>";
	
	var tabId = initTabs(parentId,Array(tabTitle),0,'','',Array(closeButton),true);
//	div.innerHTML = "<div id='itemDetailArea'></div>";
	div.appendChild(title);
	div.appendChild(frame);
}

/****************************************************************************************************************************************
 * 
 * 								Create Friend List Tab Function
 * 
 * @param parentId --> The Tab Panel ID
 * @param tabTitle --> New Table Title
 * @param closeButton --> True for disposable tab; False for non-disposable tabs 
 *****************************************************************************************************************************************/
function createFriendTab(parentId,tabTitle,closeButton)
{
	if(tabFrame_countTabs[parentId]>=tabFrame_maxNumberOfTabs)return;	// Maximum number of tabs reached - return
	var div = document.createElement('DIV');    //new tab Frame
	div.className = 'dhtmlgoodies_aTab';
	tabObj[parentId].appendChild(div);
	
	var title = document.createElement('SPAN');
	title.id = 'friendTbTitle';
	var buddyList = document.createElement('TABLE');
	buddyList.innerHTML = "<tr><th>Friend ID</th><th>Friend Name</th>"+
								   "<th>Delete</th><th>View Auctions</th>"+
								   "<th>Chat</th><tBody id='friendTable'></tBody>";
	

	var tabId = initTabs(parentId,Array(tabTitle),0,'','',Array(closeButton),true);
	div.appendChild(title);
	div.appendChild(buddyList);
}
/****************************************************************************************************************************************
 * 
 * 								Create Chat Tab Function
 * 
 * @param parentId --> The Tab Panel ID
 * @param tabTitle --> New Table Title
 * @param closeButton --> True for disposable tab; False for non-disposable tabs 
 *****************************************************************************************************************************************/
function createChatTab(parentId,tabTitle, xmlstuff ,closeButton)
{
	//TODO make unique tab so that multiple chat can be handled correctly
	var senderID	= xmlstuff.getAttribute("senderID");
	var pollingCode	= xmlstuff.getAttribute("pollingCode");
	var sendToCode	= xmlstuff.getAttribute("sendToCode");
	
	if(tabFrame_countTabs[parentId]>=tabFrame_maxNumberOfTabs)return;	// Maximum number of tabs reached - return
	var div = document.createElement('DIV');    //new tab Frame
	div.className = 'dhtmlgoodies_aTab';
	tabObj[parentId].appendChild(div);
	div.id='imSession'; //TODO: add contact ID and session Number to the div.ID 
	
	var imFrame = document.createElement('DIV');
	imFrame.id = 'imFrame';
	imFrame.clssName='';//TO DO: Make a css class for chatting
//	imFrame.innerHTML = "test";
	
	var imContainer = document.createElement('TABLE');
	imContainer.id='imContainer';
	imContainer.style.width='100%';
	imContainer.style.height='100%';
	imContainer.cellpadding='0';
	imContainer.CELLSPACING='0';
	imContainer.innerHTML=
		"<tbody>" +
			"<tr style='height: 37px'>" +
			  "<td>" +
//			  	"<input type='button' value='Send SMS' onClick=''/>" +
//			  	"<input type='button' value='Send Message' onClick=''/>" +
			  	"<input type='button' value='Block User' onClick=''/>" +
			  "</td>" +
			"</tr>" +
			"<tr>" +
			   "<td>" +
				  "<textarea id='imConversation' cols='50' rows='5' wrap='hard' readonly>" +
					      "" +
				  "</textarea>" +
				"<td>" +
			"</tr>" +
			"<tr>" +
			   "<td>" +
				  "<textarea id='imInput' cols='45' rows='5' wrap='hard' >" +
					      "This is Gonna be the input" +
				  "</textarea>" +
				  "<input type=button value='send' onClick='sendMsg(" + sendToCode + ")'/>" + //onClick method needed
			"</tr>" +
		"</tbody>";
//		"</tbody>" +
//		"<script language=\"javascript\"> getMsg(" + pollingCode + ") </script>";

	 var newScript = document.createElement('script');
	 newScript.type = 'text/javascript';
	 newScript.innerHTML = "getMsg(" + pollingCode + ")";
	 imContainer.appendChild(newScript);
	
	imFrame.appendChild(imContainer);
	

	var tabId = initTabs(parentId,Array(tabTitle),0,'','',Array(closeButton),true);
	div.appendChild(imFrame);

}
/****************************************************************************************************
		 							Open Advanced Search Tab
/****************************************************************************************************/
function showAdvancedSearchTab()
{

	var open=getTabIndexByTitle('Advanced Search');
	if (open<0)// if the tab is not open yet
	{	
		var aTab= createAdvSearchTab('tabPanel','Advanced Search', true);
	}
	else
	{
			//showTab('tabPanel',open.toString());
	}
}
/****************************************************************************************************
										Open Friends List Tab
/****************************************************************************************************/
function showFriendTab()
{

var open=getTabIndexByTitle('My Friends');
if (open<0)// if the tab is not open yet
{	
var aTab= createFriendTab('tabPanel','My Friends', true);
}
else
{
//showTab('tabPanel',open.toString());
}
}
/****************************************************************************************************
						Open Detail View Tab
/****************************************************************************************************/
function showDetailViewTab()
{

	var open=getTabIndexByTitle('View Detail');
	if (open<0)// if the tab is not open yet
	{	
		var aTab= createDetailViewTab('tabPanel','View Detail' , true);
	}
	else
	{
		//showTab('tabPanel',open.toString());
	}
}
/****************************************************************************************************
						Open Chatting Tab
/****************************************************************************************************/
function showChatTab( xmlstuff )
{
	var sender 		= xmlstuff.getAttribute("friendName");
	
var open=getTabIndexByTitle('Chatting with '+ sender);
if (open<0)// if the tab is not open yet
{	
var aTab= createChatTab('tabPanel','Chatting with '+ sender,  xmlstuff , true);
}
else
{
//showTab('tabPanel',open.toString());
}
}
/****************************************************************************************************
						Open All Items Tab
/****************************************************************************************************/
function showAllItemTab()
{

		var open=getTabIndexByTitle('All Auction');
		if (open<0)// if the tab is not open yet
		{	
			var aTab= createAllItemViewTab('tabPanel','All Auction', true);
		}
		else
		{
			//showTab('tabPanel',open.toString());
		}
}
/****************************************************************************************************
							Open Tab for All Auction of this user
/****************************************************************************************************/
function showMyAuctionTab()
{

	var open=getTabIndexByTitle('My Auction');
	if (open<0)// if the tab is not open yet
	{	
		var aTab= createMyAuctionTab('tabPanel','My Auction', true);
	}
	else
	{
		//showTab('tabPanel',open.toString());
	}
}
/****************************************************************************************************************************************
 * 
 * 								Create My Auction Tab Function
 * 
 * @param parentId --> The Tab Panel ID
 * @param tabTitle --> New Table Title
 * @param closeButton --> True for disposable tab; False for non-disposable tabs 
 *****************************************************************************************************************************************/
function createMyAuctionTab(parentId,tabTitle,closeButton)
{
	if(tabFrame_countTabs[parentId]>=tabFrame_maxNumberOfTabs)return;	// Maximum number of tabs reached - return
	var div = document.createElement('DIV');    //new tab Frame
	div.className = 'dhtmlgoodies_aTab';
	tabObj[parentId].appendChild(div);
	
	var title = document.createElement('SPAN');
	title.id = 'myAuctionTitle';
	var frame = document.createElement('DIV');
	frame.id = 'myAuctionTab';
	frame.innerHTML="<div id='myAuctionArea'></div>";
	

	var tabId = initTabs(parentId,Array(tabTitle),0,'','',Array(closeButton),true);
	div.appendChild(title);
	div.appendChild(frame);
}

/*****************************************************************************************
* 
* 						Get tab index by Title
* 
*****************************************************************************************/
	
	function getTabIndexByTitle(tabTitle)
	{
		var regExp = new RegExp("(.*?)&nbsp.*$","gi"); // first part--> ; "gi"--> global and case-insensitive
		tabTitle = tabTitle.replace(regExp,'$1');
		for(var prop in tabObj){
			var divs = tabObj[prop].getElementsByTagName('DIV');
			for(var no=0;no<divs.length;no++){
				if(divs[no].id.indexOf('tabTitle')>=0){
					var span = divs[no].getElementsByTagName('SPAN')[0];
					var regExp2 = new RegExp("(.*?)&nbsp.*$","gi");
					var spanTitle = span.innerHTML.replace(regExp2,'$1');

					if(spanTitle == tabTitle){

						var tmpId = divs[no].id.split('_');
						return Array(prop,tmpId[tmpId.length-1].replace(/[^0-9]/g,'')/1);
					}
				}
			}
		}

		return -1;				

	}

/* *****************************************************************************************************
 * Call this function if you want to display some content from external file in one of the tabs
 * Arguments: Title of tab and relative path to external file 
 * *****************************************************************************************************/

	function addAjaxContentToTab(tabTitle,tabContentUrl)
	{
		var index = getTabIndexByTitle(tabTitle);
		if(index!=-1){
			var ajaxIndex = ajaxObjects.length;

			tabId = index[1];
			parentId = index[0];


			ajaxObjects[ajaxIndex] = new sack();
			ajaxObjects[ajaxIndex].requestFile = tabContentUrl;	// Specifying which file to get

			ajaxObjects[ajaxIndex].onCompletion = function(){ showAjaxTabContent(ajaxIndex,parentId,tabId); };	// Specify function that will be executed after file has been found
			ajaxObjects[ajaxIndex].runAJAX();		// Execute AJAX function

		}
	}

/******************************************************************************************************************************
 * 
 * 						Remove the Tab --> completely remove elements from the document
 * 
 * @param tabLabel --> tab title
 * @param tabIndex --> index of the tab in the array
 * @param parentId --> which tab panel it is in
 *******************************************************************************************************************************/


	function deleteTab(tabLabel,tabIndex,parentId)
	{

		if(tabLabel){
			var index = getTabIndexByTitle(tabLabel);
			if(index!=-1){
				deleteTab(false,index[1],index[0]);
			}

		}else if(tabIndex>=0){
			if(document.getElementById('tabTitle' + parentId + '_' + tabIndex)){
				var obj = document.getElementById('tabTitle' + parentId + '_' + tabIndex); //the Tab
				var id = obj.parentNode.parentNode.id;
				obj.parentNode.removeChild(obj);
				var obj2 = document.getElementById('tabFrame' + parentId + '_' + tabIndex);//the tab frame
				obj2.parentNode.removeChild(obj2); //element goen for good
				resetTabIds(parentId);
				activeTabIndex[parentId]=-1;
				showTab(parentId,'0');
			}
		}
		
	}

