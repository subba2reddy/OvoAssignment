({
	startFileCreation : function(component, event, helper) {
        //check if file needs to be created and create it
        helper.checkIfReadyAndGenerate(component);
        //below will bring up the spinner
        component.set("v.processComplete", true);
    },
    
    
    closeAlertModal : function(component) {
		var modal = component.find("msgModal");
        $A.util.removeClass(modal,"slds-fade-in-open");
	},
    
    
    chkChange : function(component, event, helper){
        var curValue = component.get("v.dateBased");
        if(curValue){
            component.set("v.dateDisabled", false);
        }else{
            component.set("v.dateDisabled", true);
        }
    }
})