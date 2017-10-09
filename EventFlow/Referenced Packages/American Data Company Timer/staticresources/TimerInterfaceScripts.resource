/* Variable declarations */
var viewState;
var viewStateId = "timer:timerForm:updateViewstate";

var resettableFields = new Array( "recordedTimeDisplay", "timeInMillis", "recordSearch", "subject", "description", "billingType", "workType" );
var dynamicContentWrapper = "timer:timerForm:dynamicContentWrapper";
var recordedTimeDisplay = "timer:timerForm:recordedTimeDisplay";
			
var activeTimerEntryContent = "timer:timerForm:activeTimerEntryContent";
var searchResultWrapper = "timer:timerForm:searchResultWrapper";
var recentItemsWrapper = "timer:timerForm:recentItemsWrapper";
var dynamicViews = new Array( activeTimerEntryContent, searchResultWrapper, recentItemsWrapper );

var recordLinkWrapper = "timer:timerForm:recordLinkWrapper";
var recordSearchWrapper = "timer:timerForm:recordSearchWrapper";
var parentRecordViews = new Array( recordLinkWrapper, recordSearchWrapper );

var showRecentItems = "showRecentItems";
var hideSearchItems = "hideSearchItems";
var hideRecentItems = "hideRecentItems";
var bottomLinkViews = new Array( showRecentItems, hideSearchItems, hideRecentItems );

/* Page load initializations */
function init() {

	toggleViewState();
	
	// Setup view for selected record, if available
	var parentLink = document.getElementById( "timer:timerForm:recordLink" ).innerHTML;
	if( parentLink != null && parentLink != "" ) {
	
		toggleView( parentRecordViews, recordLinkWrapper );		// Display parent record link
		toggleView( dynamicViews, activeTimerEntryContent );		// Dynamic content area
		toggleView( actionButtonViews, btnStart );		// Start/Stop button area
		toggleView( bottomLinkViews, showRecentItems );		// Show Recent Items link
	
	} else {

		toggleView( parentRecordViews, recordSearchWrapper );		// Parent record area
		toggleView( dynamicViews, recentItemsWrapper );		// Dynamic content area
		toggleView( actionButtonViews, btnStart );		// Start/Stop button area
		toggleView( bottomLinkViews );		// Hide all bottom links
		
	}
	
	updateButtonAccessibility();

	// Event handler to prevent Enter/Return key from submitting form
	document.onkeypress = disableEnterKey;

	// Display body
	document.getElementsByTagName( "body" )[0].style.display = "block";

	// Dynamically resize window
	growWindow();
	
}

function growWindow() {

	if( !document.all ) {		// IE 8 does not support this sort of window resize
	
		var windowWidth = getWindowWidth();
		var windowHeight = getWindowHeight();
		var widthIncrement = 1;
		var heightIncrement = 1;
	
		// Resize width
		while( windowWidth <= document.body.offsetWidth ) {
			
			window.innerWidth += widthIncrement;
			windowWidth = getWindowWidth();
	
		}
	
		// Resize height
		while( windowHeight <= document.body.offsetHeight ) {
			
			window.innerHeight += heightIncrement;	
			windowHeight = getWindowHeight();
			
		}
		
	}

}

function getWindowWidth() {
	
	var windowWidth;
	
	if( document.all ) {
		
    	windowWidth = window.document.body.clientWidth;

	} else {
	
		windowWidth = window.innerWidth;
		
	}
	
	return windowWidth;
	
}

function getWindowHeight() {
	
	var windowHeight;
	
	if( document.all ) {

		windowHeight = window.document.body.clientHeight;

	} else {

		windowHeight = window.innerHeight;
		
	}
	
	return windowHeight;
	
}

/* Expand/collapse timer window and dynamic content area */
function toggleViewState() {

	var currentState = document.getElementById( viewStateId ).className;

	if( document.getElementById( viewStateId ) != null ) {

		if( currentState == null || currentState == "" || currentState == "viewstateCollapse" ) {

			toggleViewstateFull();

		} else {

			toggleViewstateCollapse();

		}

	}

}

function toggleViewstateFull() {

	document.getElementById( viewStateId ).className = "viewstateFull";
	document.getElementById( dynamicContentWrapper ).style.display = "block";
	
	if( document.all ) {		// Hard-coded IE 8 support

		window.resizeTo( 420, 520 );
	
	} else {		// Standards-compliant browser support		
		
		if( navigator.userAgent.toLowerCase().indexOf( "chrome" ) > -1 ) {
			
			// Resize window for Chrome browsers
			window.resizeTo( 420, 510 );
	
		} else {
		
			// Resize window for all other browsers
			window.resizeTo( getWindowWidth(), getWindowHeight() );
			growWindow();
			
		}
		
	}
			
}

function toggleViewstateCollapse() {

	document.getElementById( viewStateId ).className = "viewstateCollapse";
	document.getElementById( dynamicContentWrapper ).style.display = "none";

	if( document.all ) {		// Hard-coded IE 8 support

		window.resizeTo( 420, 300 );
	
	} else {		// Standards-compliant browser support

		if( navigator.userAgent.toLowerCase().indexOf( "chrome" ) > -1 ) {
		
			window.resizeTo( 420, 292 );
			
		} else {
		
			window.resizeTo( getWindowWidth(), 260 );
		
		}
	
		growWindow();
		
	}
			
}

/* Show/hide dynamic content areas */
function toggleView( views, activeView ) {

	// Hide all elements in view array
	for( i = 0; i < views.length; i++ ) document.getElementById( views[i] ).style.display = "none";
	
	// Show only active element
	if( document.getElementById( activeView ) != null ) document.getElementById( activeView ).style.display = "block";
	
	// Toggle footer link
	if( activeView == activeTimerEntryContent ) {

		toggleView( bottomLinkViews, showRecentItems );

	} else if( activeView == searchResultWrapper ) {

		toggleView( bottomLinkViews, hideSearchItems );
	
	} else if( activeView == recentItemsWrapper ) {

		toggleView( bottomLinkViews, hideRecentItems );
	
	}
	
	growWindow();
	
}

/**/
function updateButtonAccessibility() {

	try {
		
		var parentRecordId = document.getElementById( "parentRecordId" ).value;
	
		if( parentRecordId == null || parentRecordId == "" ) {
		
			document.getElementById( btnStart ).disabled = true;
		
		} else {
		
			document.getElementById( btnStart ).disabled = false;
		
		}
		
	} catch( err ) {}

}

/* Disables Enter/Return key from executing */
function disableEnterKey( evt ) {

	var evt = ( evt ) ? evt : ( ( event ) ? event : null );
	var node = ( evt.target ) ? evt.target : ( ( evt.srcElement ) ? evt.srcElement : null );
	if ( ( evt.keyCode == 13 ) && ( node.type == "text" ) )  { return false; }

}

/* Reset Interface */
function resetInterface() {

	document.getElementById( "timer:timerForm" ).reset();

	window.location.replace( "/apex/Timer" );

}