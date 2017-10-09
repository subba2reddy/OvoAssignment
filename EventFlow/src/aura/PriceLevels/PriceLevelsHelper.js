({
    createPLRecord : function(component, event, helper){
    var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            "entityApiName": "Price_Levels__c",
            "defaultFieldValues": {
                "Price_Type__c": component.get("v.recordId")
            }
        });
    createRecordEvent.fire();
    },
    
    editPLRecord : function(component, event, helper){
        var editRecordEvent = $A.get("e.force:editRecord");
        priceLevel = event.getSource().get("v.value"); 
        editRecordEvent.setParams({
            "recordId": priceLevel.Id
        });
        editRecordEvent.fire();
    },
    
    deletePLRecord : function(component, priceLevel, callback) {
    // Call the Apex controller and update the view in the callback
    var action = component.get("c.deletePriceLevels");
    action.setParams({
        "priceLevel": priceLevel
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
            
        // Remove only the deleted priceLevel from view
          var priceLevels = component.get("v.PriceLevels");
            var items = [];
            for (i = 0; i < priceLevels.length; i++) 
            {
                if(priceLevels[i]!==priceLevel) 
                {
                    items.push(priceLevels[i]);
                    console.log(Object.values(priceLevels[i]));
                }
            }
            component.set("v.PriceLevels", items);
        }
        else
        {
            console.log("Error message from server: " + response.getReturnValue());
        }
    });
    $A.enqueueAction(action);
	}
    
})