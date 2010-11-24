/************************************************************************************************************
Tab view
Copyright (C) October 2005  DTHMLGoodies.com, Alf Magne Kalleland

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

Dhtmlgoodies.com., hereby disclaims all copyright interest in this script
written by Alf Magne Kalleland.

Alf Magne Kalleland, 2009
Owner of DHTMLgoodies.com

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

/****************************************************************************************************************************
 * 
 * 							Second Tabs Initialization Function --for reusable elements
 * 
 * --> Change the "removeTabs()" to "HideTabs()"
 * 
 * @param mainContainerID
 * @param tabTitles
 * @param activeTab	--> tab being displayed 
 * @param width
 * @param height
 * @param closeButtonArray --> close button
 * @param additionalTab
 * @returns
 ************************************************************************************************************************/
		function init_Tabs(mainContainerID,tabTitles,activeTab,width,height,closeButtonArray,additionalTab)
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
				//set up the tab
				aTab.id = 'tabTitle' + mainContainerID + "_" +  (no + tabFrame_countTabs[mainContainerID]);
				aTab.onmouseover = rolloverTab;  
				aTab.onmouseout = rolloutTab;
				aTab.onclick = tabClick;
				aTab.className='tabInactive';
				tabDiv.appendChild(aTab);
				var span = document.createElement('SPAN');
				span.innerHTML = tabTitles[no]; //set the tab title
				span.style.position = 'relative';
				aTab.appendChild(span);

				if(closeButtonArray[no]){  //add close button
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

					closeButton.onclick = function(){ hideTab(this.parentNode.innerHTML); };
					span.appendChild(closeButton);
				}
				
				//tab style
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
					tabs[no].id = 'tabFrame' + mainContainerID + "_" + divCounter;
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
 * 								Second Create New Tab Function --> For reusable elements
 * 
 * @param parentId --> The Tab Panel ID
 * @param tabTitle --> New Table Title
 * @param tabContent --> Anything if not holding pages 
 * @param tabContentUrl --> The page this tab will hold
 * @param closeButton --> True for disposable tab; False for non-disposable tabs 
 *****************************************************************************************************************************************/
		function createReusableTab(parentId,tabTitle,tabContent,tabContentUrl,closeButton)
		{
			if(tabFrame_countTabs[parentId]>=tabFrame_maxNumberOfTabs)return;	// Maximum number of tabs reached - return
			var div = document.createElement('DIV');    //new tab Frame
			div.className = 'dhtmlgoodies_aTab';
			tabObj[parentId].appendChild(div);

			/*Following Line Differs from first Function*/
			var tabId = init_Tabs(parentId,Array(tabTitle),0,'','',Array(closeButton),true);
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

	var tabId = initTabs(parentId,Array(tabTitle),0,'','',Array(closeButton),true);
	div.innerHTML = "<input type='text' id='advancedSearchTitle' value='search Auctions...'" +
	  				" onclick='SelectAll('advancedSearchTitle');'/>"+
	  				"<FORM name='searchOpt'>"+ 
					"<select name='searchCondition1' class='small-input' onChange='cascadeOpt(searchCondition1);'>"+
						"<option value='searchOption'>Search By</option>"+
						"<option value='searchByCategory'>Category</option>"+
						"<option value='searchByPeople'>Owner</option></select></FORM>"+
  
						"<select id='searchCategory'>" +
						
						"<option value=''> Pick a Category</option><option value='electronics'>Electronics</option>"+
						"<option value='books'>Books</option><option value='motors'>Motors</option>"+
						"<option value='art'>Art</option><option value='music'>Music</option></select>"+
				"<input type='text' id='searchOwner' value='search By Authors...' onclick='SelectAll('searchOwner');'/><br>"+
				"<input type='image' id='advSearchBtn' src='./resources/images/advancedSearch.png' title='Advanced Search' onClick='searchAuctionTable(1)'/>";  
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
	
	var frame = document.createElement('DIV');
	frame.id = 'auctionDetailTab';
	frame.innerHTML="<div id='itemDetailArea'></div>";
	
	var tabId = initTabs(parentId,Array(tabTitle),0,'','',Array(closeButton),true);
//	div.innerHTML = "<div id='itemDetailArea'></div>";
	div.appendChild(frame);
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
	Open Advanced Search Tab
/****************************************************************************************************/
function showDetailViewTab()
{

	var open=getTabIndexByTitle('View Detail');
	if (open<0)// if the tab is not open yet
	{	
		var aTab= createDetailViewTab('tabPanel','View Detail', true);
	}
	else
	{
		//showTab('tabPanel',open.toString());
	}
}
function createAdvSearch()
{
	var contain=document.createElement('DIV');
	contain.id='tabPanel_AdvSearchTab';
	contain.innerHTML="<input type='text' id='advancedSearchTitle' value='search Auctions...'" +
					  " onclick='SelectAll('advancedSearchTitle');'/>";
	
	return contain;
}
/****************************************************************************************************
		Open auction detail in a new Tab
/****************************************************************************************************/
function showItemDetailTab(auctionTitle, auctionID)
{
	ajaxpage('./auctionDetailsPage.jsp?auctionID='+auctionID, 'itemDetailArea');
	var open=getTabIndexByTitle(auctionTitle);
	var contain=document.getElementById('itemDetailArea'); //get the pre-defined tab
	
	
	if (true)	// if the tab is not open yet
	var aTab= createReusableTab('tabPanel', auctionTitle, contain, '', true);
	else
	{
	//showTab('tabPanel',open.toString());
	}
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

/******************************************************************************************************************************
* 
* 					Hide the Tab --> hide the tab elements rather than removing
* 
* @param tabLabel --> tab title
* @param tabIndex --> index of the tab in the array
* @param parentId --> which tab panel it is in
*******************************************************************************************************************************/

	function hideTab(tabLabel,tabIndex,parentId)
	{

		if(tabLabel){
			var index = getTabIndexByTitle(tabLabel);
			if(index!=-1){
				hideTab(false,index[1],index[0]);
			}

		}else if(tabIndex>=0){
			if(document.getElementById('tabTitle' + parentId + '_' + tabIndex))
			{
				var tab_title = document.getElementById('tabTitle' + parentId + '_' + tabIndex); //the Tab
				var id = tab_title.parentNode.parentNode.id;
				tab_title.parentNode.removeChild(tab_title);
				//tab_title.style.display=('none');
				var tab_frame = document.getElementById('tabFrame' + parentId + '_' + tabIndex);//the tab frame
				//tab_frame.parentNode.removeChild(obj2); //if remove the div gone for good until refresh
				tab_frame.style.display=('none');
				resetTabIds(parentId);
				activeTabIndex[parentId]=-1;
				showTab(parentId,'0');
			}
		}
	}
