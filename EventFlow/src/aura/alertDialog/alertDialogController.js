({
	doInit : function(component, event, helper) {
		var header = component.find("header");
        $A.util.addClass(header,component.get("v.strClass"));
        var modal = component.find("msgModal");
        $A.util.addClass(modal,"slds-fade-in-open");
	},
    
    closeAlertModal : function(component, event, helper) {
		var modal = component.find("msgModal");
        $A.util.removeClass(modal,"slds-fade-in-open");
	}
})