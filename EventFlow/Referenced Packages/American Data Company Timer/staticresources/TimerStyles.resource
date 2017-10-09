/*
 * © American Data Company
 * Visualforce Timer Stylesheet
 * May 5, 2009
 *
 * NOTE: [id*=tagId] is used to access Salesforce elements by id value 
 */

/* Normalizer */
html, body,
p, span, a, h1, h2, h3,
label, input, textarea, select,
ol, ul, li,
img {
	margin: 0;
	padding: 0;
}

body {
	float: left;
	width: 400px;
	color: #8f8f8f;
	font-family: verdana, arial, sans-serif;
	font-size: 10px;
	padding: 4px;
}

a {
	color: #A8D56E;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

/* Components */
div[id*=pageWrapperOuter], div[id*=pageWrapperInner], div[id*=header], div[id*=timerWrapper], 
div[id*=timerForm], div[id*=recordedTimeContent], div[id*=dynamicContentWrapper], div[id*=dynamicContentInnerWrapper],
div[id*=dynamicContentWrapperBottom], div[id*=messageDisplay], div[id*=activeTimerEntryContent],
div[id*=searchResultWrapper], div[id*=recentItemsWrapper], div[id*=pageWrapperBottom] {
	clear: both;
	float: left;
	width: 100%;
}

div[id*=pageWrapperOuter] {
	width: 372px;
	background: transparent url( "/resource/vftimer__TimerImages/bgWindow.gif" ) no-repeat 0 0;
	padding: 14px 14px 0 14px;
}

div[id*=pageWrapperInner] {
	width: 372px;
}

div[id*=pageWrapperBottom] {
	width: 400px;
	background: transparent url( "/resource/vftimer__TimerImages/bgWindowBottom.gif" ) no-repeat 0 0;
	padding: 21px 0 0 0;
}

/* General form styles */
input {
	border: 0;
}

div[id*=dynamicContentWrapper] input,
div[id*=dynamicContentWrapper] textarea,
div[id*=dynamicContentWrapper] select {
	border: 1px #e5e5e5 solid !important;
}

/* Header */
div[id*=header] {
	padding: 0 0 6px 0;
}

a[id*=btnPoweredBy] {
	float: left;
}

a[id*=btnPoweredBy] img {
	border: 0;
}

a[id*=btnHelp] {
	float: right;
	height: 0;
	width: 0;
	margin: 0 12px 0 0;
	padding: 25px 25px 0 0;
	background: transparent url( "/resource/vftimer__TimerImages/btnHelp.gif" ) no-repeat 0 0;
	overflow: hidden;
}

a[id*=btnHelp]:hover {
	background: transparent url( "/resource/vftimer__TimerImages/btnHelpHover.gif" ) no-repeat 0 0;
}

/* Stopwatch display */
div[id*=recordedTimeContent] {
	clear: both;
	float: left;
	height: 83px;
	background: transparent url( "/resource/vftimer__TimerImages/bgClock.gif" ) no-repeat 0 0;
}

input[id*=recordedTime] {
	float: left;
	width: 220px;
	font-size: 48px;
	margin: 15px 0 0 20px;
	background: transparent;	
}

input[id*=buttonStartTimer], input[id*=buttonStopTimer] {
	float: right;
	height: 0;
	width: 0;
	margin: 25px 40px 0 0;
	padding: 35px 73px 0 0;
	overflow: hidden;
	cursor: pointer;
}

input[id*=buttonStartTimer] {
	background: transparent url( "/resource/vftimer__TimerImages/btnStart.gif" ) no-repeat 0 0;
}

input[id*=buttonStartTimer]:hover {
	background: transparent url( "/resource/vftimer__TimerImages/btnStartHover.gif" ) no-repeat 0 0;
}

input[id*=buttonStartTimer][disabled], input[id*=buttonStartTimer][disabled]:hover {
	cursor: auto;
	background: transparent url( "/resource/vftimer__TimerImages/btnStartDisabled.gif" ) no-repeat 0 0;
}

input[id*=buttonStopTimer] {
	background: transparent url( "/resource/vftimer__TimerImages/btnStop.gif" ) no-repeat 0 0;
}

input[id*=buttonStopTimer]:hover {
	background: transparent url( "/resource/vftimer__TimerImages/btnStopHover.gif" ) no-repeat 0 0;
}

/* New/Save button bar */
div[id*=timerEntryRecordActions] {
	padding: 4px 0 0 0;
}

input[id*=buttonNew], input[id*=buttonSave] {
	float: right;
	width: 0;
	height: 0;
	margin: 0 14px 0 0;
	padding: 19px 69px 0 0;
	overflow: hidden;
	cursor: pointer;
}

input[id*=buttonNew] {
	background: transparent url( "/resource/vftimer__TimerImages/btnNew.gif" ) no-repeat 0 0;
}

input[id*=buttonNew]:hover {
	background: transparent url( "/resource/vftimer__TimerImages/btnNewHover.gif" ) no-repeat 0 0;
}

input[id*=buttonSave] {
	background: transparent url( "/resource/vftimer__TimerImages/btnSave.gif" ) no-repeat 0 0;
}

input[id*=buttonSave]:hover {
	background: transparent url( "/resource/vftimer__TimerImages/btnSaveHover.gif" ) no-repeat 0 0;
}

/* Search/Record Display */
div[id*=recordTitleWrapper] {
	clear: none;
	float: left;
	width: 320px;
	padding: 10px 0 0 0;
}

div[id*=recordSearchWrapper] * {
	float: left;
}

div[id*=recordSearchWrapper] label {
	padding: 2px 10px 0 0;
}

input[id*=recordSearch] {
	width: 230px;
	border: 1px #e5e5e5 solid;
}

input[id*=btnSearch] {
	height: 0;
	width: 0;
	margin: 0 0 0 10px;
	padding: 24px 23px 0 0;
	background: transparent url( "/resource/vftimer__TimerImages/btnSearch.gif" ) no-repeat 0 0;
	overflow: hidden;
	cursor: pointer;
}

input[id*=btnSearch]:hover {
	background: transparent url( "/resource/vftimer__TimerImages/btnSearchHover.gif" ) no-repeat 0 0;
}

/* Dynamic content area */
div[id*=viewstateWrapper] {
	clear: both;
	float: left;
	width: 50px;
}

a[id*=updateViewstate] {
	clear: both;
	float: left;
	width: 0;
	height: 0;
	margin: 10px 0 0 0;
	padding: 16px 25px 0 0;	
	overflow: hidden;
	cursor: pointer;
}

a.viewstateFull {
	background: transparent url( "/resource/vftimer__TimerImages/btnArrowUp.gif" ) no-repeat 0 0;
}

a.viewstateFull:hover {
	background: transparent url( "/resource/vftimer__TimerImages/btnArrowUpHover.gif" ) no-repeat 0 0;
}

a.viewstateCollapse {
	background: transparent url( "/resource/vftimer__TimerImages/btnArrowDown.gif" ) no-repeat 0 0;
}

a.viewstateCollapse:hover {
	background: transparent url( "/resource/vftimer__TimerImages/btnArrowDownHover.gif" ) no-repeat 0 0;
}

div[id*=dynamicContentWrapper] {
	margin: 10px 0 0 0;
}

div[id*=dynamicContentInnerWrapper] {
	height: 190px;
	width: 362px;
	background: transparent url( "/resource/vftimer__TimerImages/bgDynamicArea.gif" ) no-repeat 0 0;
	padding: 10px 10px 0 10px;
	overflow: auto;
}

div[id*=dynamicContentInnerWrapperBottom] {
	width: 362px;
	height: 0;
	background: transparent url( "/resource/vftimer__TimerImages/bgDynamicAreaBottom.gif" ) no-repeat 0 0;
	padding: 12px 10px 0 0;
}

/* Active Timer Entry */
div[id*=subjectWrapper], div[id*=descriptionWrapper], div[id*=billingTypeWrapper], div[id*=workTypeWrapper] {
	float: left;
	margin: 0 0 15px 0;
}

div[id*=workTypeWrapper] {
	margin: 0;
}

div[id*=subjectWrapper], div[id*=descriptionWrapper],
div[id*=billingTypeWrapper], div[id*=workTypeWrapper] {
	clear: both;
}

div[id*=subjectWrapper] label, div[id*=descriptionWrapper] label,
div[id*=billingTypeWrapper] label, div[id*=workTypeWrapper] label {
	float: left;
	width: 82px;
	text-align: right;
	margin: 0 0 -16px 0;
}

div[id*=subjectWrapper] input, div[id*=descriptionWrapper] textarea,
div[id*=billingTypeWrapper] select, div[id*=workTypeWrapper] select {
	float: left;
	width: 250px;
	margin: 0 0 0 90px;
}

div[id*=descriptionWrapper] textarea {
	height: 80px;
}

div[id*=bottomNaviLinks] a {
	clear: both;
	float: left;
}

/* Search Results */
div[id*=searchResultWrapper] p, div[id*=recentItemsWrapper] p {
	color: #444;
	font-size: 12px;
	font-weight: bold;
	margin: 10px 0 0 0;
}

div[id*=searchResultWrapper] ul, div[id*=recentItemsWrapper] ul {
	list-style: none;
}

div[id*=searchResultWrapper] li, div[id*=recentItemsWrapper] li {
	margin: 2px 0 0 0;
	border-bottom: 1px #f5f5f5 solid;
}

div[id*=recentItemsWrapper] a span {
	color: #999;
}

/* Errors */
div.error * {
	color: #c00;
	font-weight: bold;
}

div.error ul {
	list-style: none;
}