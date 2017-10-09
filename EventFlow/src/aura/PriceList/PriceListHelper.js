({
    createRecord : function(component){
         
/*        component.find("priceRecordCreator").getNewRecord(
            "Contact", // sObject type (entityApiName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newPrice");
                var error = component.get("v.newPriceError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
                console.log("Record template initialized: " + rec.sobjectType);
            })
        ); */

	    var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            "entityApiName": "Price__c",
            "defaultFieldValues": {
                "Event__c": component.get("v.recordId")
            }
        });
    	createRecordEvent.fire(); 
    },
    
    editRecord : function(component, event, helper){
        var editRecordEvent = $A.get("e.force:editRecord");
        price = event.getSource().get("v.value"); 
        editRecordEvent.setParams({
            "recordId": price.Id
        });
        editRecordEvent.fire();
    },
    
    
    deleteRecord : function(component, price, callback) {
    // Call the Apex controller and update the view in the callback
    var action = component.get("c.deletePrice");
    action.setParams({
        "price": price
    });
    action.setCallback(this, function(response) {
        var state = response.getState();
        if (component.isValid() && state === "SUCCESS") 
        {
        //Show Toast
		var toastEvent = $A.get("e.force:showToast");
  		toastEvent.setParams({
        	"title": "Success!",
        	"message": "The record has been deleted successfully."
   		 });
        toastEvent.fire();    
            
        // Remove only the deleted price from view
          var prices = component.get("v.PriceRecords");
            var items = [];
            for (i = 0; i < prices.length; i++) 
            {
                if(prices[i]!==price) 
                {
                    items.push(prices[i]);  
                }
            }
            component.set("v.PriceRecords", items);
        }
        else
        {
            console.log("Error message from server: " + response.getReturnValue());
        }
    });
    $A.enqueueAction(action);
	},
    
    showPopupHelper: function(component, componentId, className){
		debugger;
/*        var newcmp = $A.createComponent("c:CreateNewPrice",
                                        {
                                            "Event__c": component.get("v.recordId")
                                        },
                                        function(component){
                                            if(component.isValid()){
                                                console.log("SUCCESS");
                                            }
                                        });
        var modal = component.find(componentId);
        $A.util.removeClass(modal, className + 'hide');
        $A.util.addClass(modal, className + 'open');
        component.set("v.body", newcmp); */
    },
    
    hidePopupHelper: function(component, componentId, className){
        var modal = component.find(componentId);
        $A.util.addClass(modal, className+'hide');
        $A.util.removeClass(modal, className+'open');
        component.set("v.body", "");
    }
    
})