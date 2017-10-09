({
    doInit : function(component, event, helper) {
        
        // Prepare a new record from template
        component.find("priceRecordCreator").getNewRecord(
            "Price__c", // sObject type (entityApiName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function() {
                debugger;
                var rec = component.get("v.newPrice");
                var error = component.get("v.newPriceError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
                console.log("Record template initialized: " + rec.sobjectType);
            })
        );
        component.set("v.cssStyle", ".forceStyle.desktop .stage {z-index:6}"); 
    },
    
    handleSave: function(component, event, helper) {
        var recordId = component.get("v.recordId");
        var pricedetails = component.get("v.simpleNewPrice");
        var salesChannel = component.find("salesChannel");
        pricedetails.Sales_Channel__c = salesChannel.get("v.value");
        var action = component.get("c.savePrice");
        var priceLevels = component.get("v.priceLevels");
        for(var i=0; i<priceLevels.length; i++){
            priceLevels[i].Price_Type__c =  pricedetails.Id;
            if(priceLevels[i].Service_Charge__c == null && priceLevels[i].Price__c == undefined ){
                priceLevels.splice(i,1);
            }
        }

        debugger;
        action.setParams({
            "price": pricedetails,
            "eventId": component.get("v.recordId"),
            "priceLevels": JSON.stringify(priceLevels)
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
               
                // fire event to update prices 
                var updateEvent = component.getEvent("updatePrices");
                updateEvent.setParams({ "price": component.get("v.simpleNewPrice") });
                updateEvent.fire();
                
                component.destroy(); 
                //$A.get("e.force:refreshView").fire();
            }else{
                alert(JSON.stringify(response.getError()[0]));
            }
        });
        $A.enqueueAction(action);
    },
    
    setFacilityFee: function(component, event, helper){
        console.log(event.getSource().getLocalId());
        var ids = event.getSource().getLocalId().split("-");
        
        var priceLevels = component.get("v.priceLevels");
        priceLevels[ids[1]].Facility_fee__c = component.get("v.facilityFee");
    },
    
    closeMe : function(component, event, helper)  { 
        component.destroy();
    }
})