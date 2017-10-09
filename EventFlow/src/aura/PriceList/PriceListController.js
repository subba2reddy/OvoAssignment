({

	doInit: function(component, event, helper)  
	{

	// initialise dropdown items
        var items = [
            { label: "Edit", value: "edit" },
            { label: "Delete", value: "delete" }
        ];
        component.set("v.actions", items);
        
        var action = component.get("c.getPrices");
        action.setParams({"EventId": component.get("v.recordId")});
       
        action.setCallback(this, function(response) 
        {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") 
            {
                component.set("v.PriceRecords", response.getReturnValue());

            }
            else	
            {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
	},
    
    createRecordBtn : function (component, event, helper) 
    {
/*        $A.createComponent("c:CreateNewPrice", {},
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   component.find('overlayLib').showCustomModal({
                                       header: "New Price",
                                       body: content,
                                       showCloseButton: true
                                   })
                               }
                           }); */
        /*        helper.showPopupHelper(component, 'modaldialog', 'slds-fade-in-');
				  helper.showPopupHelper(component,'backdrop','slds-backdrop--'); */
                helper.createRecord(component);
    },
    
/*    refresh : function(component, event, helper) {
    console.log("in refresh");
    var action = component.get('c.getPrices');
    action.setCallback(component,
        function(response) {
            var state = response.getState();
            if (state === 'SUCCESS'){
                $A.get('e.force:refreshView').fire();
            } else {
                 //do something
            }
        }
    );
    $A.enqueueAction(action);
	}, 
    
    navigateToMyComponent : function(component, event, helper) {
        console.log("in navigate");
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:PriceList",
            componentAttributes: {
                recordId : component.get("v.recordId")
            }
        });
        evt.fire();
    }, 
    
    createItems: function (cmp, event) {
        var items = [
            { label: "Edit", value: "edit" },
            { label: "Delete", value: "delete" }
        ];
        cmp.set("v.actions", items);
    }, */
    
/*    handleMenuSelect: function(cmp, event, helper) {
    	var selectedMenuItemValue = event.getParam("value");
        switch(selectedMenuItemValue)
        {
            case "edit": 
                helper.editRecord(cmp, event, helper);
                break;
            case "delete":
                var deleteEvent = cmp.getEvent("deletePriceItem");
                var price = event.getSource().get("v.value");
    			deleteEvent.setParams({ "price": price }).fire();
                break;
            default:
                console.log("default");
        }
	}, */
    
    deleteEvent : function(component, event, helper) {

        var price = event.getSource().get("v.value");

        
        // Call the helper function to delete record and update view
        helper.deleteRecord(component, event.getParam("price"));
    },
    
    handleCancel: function(component, event, helper){
        helper.hidePopupHelper(component, 'modaldialog', 'slds-fade-in-');
		helper.hidePopupHelper(component, 'backdrop', 'slds-backdrop--');
    },
    
    handleSavePrice: function(component, event, helper) {
        //       if(helper.validatePriceForm(component)) {
        component.set("v.simpleNewPrice.Event__c", "a2a4E0000000V3vQAE");
        component.find("priceRecordCreator").saveRecord(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                console.log("record saved successfully");
                // record is saved successfully
                /*                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "Saved",
                        "message": "The record was saved."
                    });
                    resultsToast.fire(); */
                } else if (saveResult.state === "INCOMPLETE") {
                    // handle the incomplete state
                    console.log("User is offline, device doesn't support drafts.");
                } else if (saveResult.state === "ERROR") {
                    // handle the error state
                    console.log('Problem saving price, error: ' + JSON.stringify(saveResult.error));
                } else {
                    console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
                }
            });
            //        }
        },
})