({
	// Load Price Levels from Salesforce
doInit: function(component, event, helper) {

    // initialise dropdown actions for buttonmenu
       var items = [
           { label: "Edit", value: "edit" },
           { label: "Delete", value: "delete" }
       ];
       component.set("v.PLactions", items);    
    
    // Create the action
    var action = component.get("c.getPriceLevels");
	action.setParams({
            "PriceTypeId": component.get("v.recordId")
        });
        
    // Add callback behavior for when response is received
    action.setCallback(this, function(response) {
        var state = response.getState();
        if (component.isValid() && state === "SUCCESS") {
            component.set("v.PriceLevels", response.getReturnValue());
        }
        else {
            console.log("Failed with state: " + state);
        }
    });

    // Send action off to be executed
    $A.enqueueAction(action);
    },
   
   createRecordBtn : function (component, event, helper) 
    {
        helper.createPLRecord(component, event, helper);
	},
    
/*   createItems: function (cmp, event) {
       var items = [
           { label: "Edit", value: "edit" },
           { label: "Delete", value: "delete" }
       ];
       cmp.set("v.actions", items);
    }, */
    
    handleMenuSelect: function(cmp, event, helper) {
    	var selectedMenuItemValue = event.getParam("value");
        switch(selectedMenuItemValue)
        {
            case "edit": 
                helper.editPLRecord(cmp, event, helper);
                break;
            case "delete":
                var deleteEvent = cmp.getEvent("deletePriceLevel");
                var priceLevel = event.getSource().get("v.value");
    			deleteEvent.setParams({ "priceLevel": priceLevel }).fire();
                break;
            default:
                console.log("default");
        }
	},
    
    deleteEvent : function(component, event, helper) {
    // Call the helper function to delete record and update view
    helper.deletePLRecord(component, event.getParam("priceLevel"));
	},

    
})