/* 
* Update the displayed time and minutes in case task has been adjusted manually 
*/
var timerIsRunning;
var btnStart = "buttonStartTimer";
var btnStop = "timer:timerForm:buttonStopTimer";
var actionButtonViews = new Array( btnStart, btnStop );
var startTime;

function startTimer() {
	
	// Only start timer if a valid parent record has been chosen
	var parentId = document.getElementById( "parentRecordId" ).value;
	if( parentId != null && parentId != "" ) {
	
		// Hide/show buttons
		toggleView( actionButtonViews, btnStop );
		
		// Disable time input field
		document.getElementById( recordedTimeDisplay ).disabled = true;
	
		// Store current millisecond count
		previousMillis = getMilliseconds();
		
		// Reset startTime
		startTime = new Date();
		
		// Begin counting 
		runTimer();
		
	} else {

		// Do nothing - timer stopwatch cannot be initiated without a parent record
	
	}

} 

/* 
 * Run timer 
 */ 
function runTimer() {

	// Enable timerIsRunning 
	timerIsRunning = true; 
	var currentTime = new Date(); 
	
	// Calculate elapsed time since timer was started 
	setMilliseconds( parseInt( currentTime.getTime() - startTime.getTime() ) + parseInt( previousMillis ) ); 
	
	// Update time in timer display 
	updateDisplayTime(); 
	
	// Call startTimer() every millisecond 
	counter = setTimeout( "runTimer()" , 1 );
	
} 

/* 
 * Stop the timer 
 */ 
function stopTimer() {

	// Disable timerIsRunning 
	timerIsRunning = false;	
	
	// Stop timer count, record date/time stopped
	try {
		clearTimeout( counter );
	} catch( err ) {}
	
	// Enable elements
	toggleView( actionButtonViews, btnStart );
	
	// Enable time input field
	document.getElementById( recordedTimeDisplay ).disabled = false;

}

/* 
 * Converts manually-specified time into milliseconds 
 */ 
function convertFromUserTime() {

	// Initialize variables 
	var hours = 0; 
	var minutes = 0; 
	var seconds = 0; 
	var millis = 0; 
	var timeChunks = getTime().split( ":" ); 
	
	// Set time units based on length of timeChunks array 
	switch( timeChunks.length ) {
	 
		case 0: // do nothing 
		break 
		case 1: seconds = timeChunks[0]; 
		break 
		case 2: minutes = timeChunks[0]; seconds = timeChunks[1]; 
		break 
		case 3: hours = timeChunks[0]; minutes = timeChunks[1]; seconds = timeChunks[2]; 
		break 
		default: alert( "Time format must be in the format of HH:MM:SS, MM:SS or SS" ); 
		break 
	
	} 
	
	// Calculate milliseconds and set 
	setMilliseconds( ( hours * ( 1000 * 60 * 60 ) ) + ( minutes * ( 1000 * 60 ) ) + ( seconds * ( 1000 ) ) );

	updateDisplayTime();
	
}

/* 
 * Display the current time 
 */ 
function updateDisplayTime() {
 
	var time = getTimeArray(); 
	
	// Update display 
	setTime( addZeroPad( time[2] ) + ":" + addZeroPad( time[1] ) + ":" + addZeroPad( time[0] ) ); 

} 

/* 
 * Parse current time into array 
 */ 
function getTimeArray() {

	// Initialize variables 
	var timeArray = new Array(); 
	var seconds = Math.floor( getMilliseconds() / 1000 ); 
	var minutes = Math.floor( seconds / 60 ); 
	seconds = seconds % 60; 
	var hours = Math.floor( minutes / 60 ); 
	minutes = minutes % 60; 
	
	// Populate array 
	timeArray[0] = seconds; 
	timeArray[1] = minutes; 
	timeArray[2] = hours; 
	
	return timeArray;
 
}

/* 
 * Add leading zero where necessary 
 */ 
function addZeroPad( stub ) {	
	return stub < 10 ? "0" + stub : stub; 
} 

function getTime() { 
	return document.getElementById( "timer:timerForm:recordedTimeDisplay" ).value 
} 

function setTime( val ) { 
	document.getElementById( "timer:timerForm:recordedTimeDisplay" ).value = val; 
} 

function getMilliseconds() {
	return document.getElementById( "timer:timerForm:timeInMillis" ).value 
}

function setMilliseconds( val ) { 
	document.getElementById( "timer:timerForm:timeInMillis" ).value = val; 
}