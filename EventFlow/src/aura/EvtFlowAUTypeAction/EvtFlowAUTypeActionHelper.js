({
	checkIfReadyAndGenerate : function(cmp) {
		//prepare return value
        var dateRangeStart = "";
        var dateRangeEnd = "";
        
        //get the apex controller method
        var server = cmp.get("c.generateAUTypeFiles");
        
        //check if there is a date range
        if(cmp.get("v.dateBased")){
           	dateRangeStart = cmp.find("startDate").get("v.value");
           	dateRangeEnd = cmp.find("endDate").get("v.value");
         }
        //set apex method parameter
        server.setParams({evtId: cmp.get("v.recordId"), dateBased: cmp.get("v.dateBased"), strtDate: dateRangeStart, endDate: dateRangeEnd} );
        //get ready for call back
        server.setCallback(this, function(response){
            var callStatus = response.getState();
            //got a response from server - hide the spinner now
            cmp.set("v.processComplete", false);
            var header = cmp.find("header");
            //prepare to show the message
            if(callStatus == "SUCCESS"){
                cmp.set("v.alertHeader", "Success");
                cmp.set("v.alertMessage", response.getReturnValue());
                $A.util.addClass(header, "slds-theme_success");
            }else{
                //error while calling the server - display a message
                cmp.set("v.alertHeader", "Error");
                cmp.set("v.alertMessage", response.getError()[0].message);
                $A.util.addClass(header, "slds-theme_error");
            }
            cmp.set("v.showMessage", true);
            var modal = cmp.find("msgModal");
			$A.util.addClass(modal,"slds-fade-in-open");            
        })
		//make the actual call to server
		$A.enqueueAction(server);
	}
})