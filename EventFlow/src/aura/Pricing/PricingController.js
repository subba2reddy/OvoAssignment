({
    
    doInit: function(component, event, helper) 
    {
        var action = component.get("c.getPrices");
        action.setParams({"EventId": component.get("v.recordId")});
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS"){
                var retEvent = response.getReturnValue();
  				//if prices are present then set the prices
                if(retEvent.Prices__r != undefined){
                    component.set("v.PriceRecords", retEvent.Prices__r);
                }
                //if restoration levy has a value then set it
                if(retEvent.Pricing_Restoration_Levy__c != undefined){
                    component.set("v.restorationLevy", retEvent.Pricing_Restoration_Levy__c);
                }
                else{
                    component.set("v.restorationLevy", "");
                }
                //if facility fee has a value then set it 
                if(retEvent.Pricing_Facility_Fee__c != undefined){
                    component.set("v.facilityFee", retEvent.Pricing_Facility_Fee__c);
                }
                else{
                    component.set("v.facilityFee", "");
                }                
            }
            else{
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    
    createRecordBtn : function (component, event, helper) 
    {
        
        $A.createComponent(
            "c:CreateNewPrice",
            {
                "recordId": component.get("v.recordId"),
                "facilityFee": component.get("v.facilityFee")
            },
            function(content){                
                if (component.isValid()) {
                    var targetCmp = component.find('ModalDialogPlaceholder');
                    var body = targetCmp.get("v.body");
                    body.push(content);
                    targetCmp.set("v.body", body); 
                }
            }
        );
        

/*        $A.createComponent("c:CreateNewPrice", 
                           {
                               "recordId": component.get("v.recordId")
            
        					},
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   component.find('overlayLib').showCustomModal({
                                       header: "New Price",
                                       body: content,
                                       showCloseButton: true,
                                   })
                               }
                           }); */
        
        /*        helper.showPopupHelper(component, 'modaldialog', 'slds-fade-in-');
				  helper.showPopupHelper(component,'backdrop','slds-backdrop--'); */
        //                helper.createRecord(component);
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
        helper.deleteRecord(component, price);
    },
    
    editPrice: function(component, event, helper){
        var price = event.getSource().get("v.value");
        // Call the helper function to edit record 
        helper.editRecord(component, price);   
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
    
    onLevy: function(component, event, helper){
        debugger;
        //var levyData = document.getElementsByName("selectProblems");
        //var LevyOption = document.getElementById("select-01");
        var recId = 'Levy-' + component.get("v.recordId");
        
        var LevyOption = document.getElementById(recId);
        
        if(LevyOption.value == "Facility Fee(Outside)"){
            component.set("v.isFacilityFee",true);
            component.set("v.isRestorationLevy",false);
        }else if(LevyOption.value == "Restoration Levy(Inside)"){
            component.set("v.isRestorationLevy",true);
            component.set("v.isFacilityFee",false); 
        }else{
            component.set("v.isFacilityFee",false);
            component.set("v.isRestorationLevy",false);
        } 
    },
    
   
    applyFacilityFee: function(component, event, helper){
        // save the price, call apex controller
        // write a class to update the ff for all the prices in the event
		var facFeeAction = component.get("c.changeFacilityFee");
        facFeeAction.setParams({eventId: component.get("v.recordId"), FacilityFee: component.get("v.facilityFee")});
        facFeeAction.setCallback(this, function(response){
            var state = response.getState();
            var toastEvent = $A.get("e.force:showToast");
            if (state == "SUCCESS"){
                var priceLevel = component.find('childLevels');
                if(priceLevel != undefined){
                    if(priceLevel.length != undefined){
                        for(var i=0;i<priceLevel.length;i++){
                            priceLevel[i].updPriceLevel();
                        }
                    }
                    else{
                         priceLevel.updPriceLevel();
                    }
                }
                toastEvent.setParams({
                    title: 'Success',
                    type: 'info',
                    message: 'Facility Fee Updated!!!'
                });                 
            }
            else{
            	toastEvent.setParams({
                    title: 'Error',
                    type: 'Error',
                    message: 'Error while Updating Facility Fee!!!'
            	});                
                console.log("Failed with state: " + state);
            }
            toastEvent.fire();
        });
        $A.enqueueAction(facFeeAction);
        debugger;

        // Fire event to update the fees on the newPriceLevels component - probably not necessary.
        //var updateEvent = component.getEvent("updateFacilityFee");
        //updateEvent.setParams({ 
        //    "facilityFee": component.get("v.facilityFee"),
        //    "eventId": component.get("v.recordId")                  
        //                      });
        //updateEvent.fire();
        
        // fire message to indicate it has been update 
    },
    
    //handle the event of user clicking on update Levy button
    handleRestorationLevy : function(component, event, helper) {
		var levyAction = component.get("c.updateRestorationLevy");
        levyAction.setParams({eventId: component.get("v.recordId"), levyValue: component.get("v.restorationLevy")});
        levyAction.setCallback(this, function(response){
            var state = response.getState();
            var toastEvent = $A.get("e.force:showToast");
            if (state != "SUCCESS"){
            	toastEvent.setParams({
                    title: 'Error',
                    type: 'Error',
                    message: 'Error while Updating Restoration Levy!!!'
            	});                  
                console.log("Failed with state: " + state);
            }
            else{
            	toastEvent.setParams({
                    title: 'Success',
                    type: 'info',
                    message: 'Restoration Levy Updated!!!'
            	});                   
            }
            toastEvent.fire();
        });
        $A.enqueueAction(levyAction);
    }

})