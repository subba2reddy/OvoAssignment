({
    doInit : function(component, event, helper) {
        
        var action = component.get("c.getPrice");
        action.setParams({"priceId": component.get("v.priceId")});
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") 
            {
                var priceRecords = response.getReturnValue();
                if(priceRecords){
                    component.set("v.simpleNewPrice", priceRecords[0]);
                    var salesChannels = document.getElementById("salesChannels");
                    var selectedChannels = priceRecords[0].Sales_Channel__c;
                    for(var i=0;i<salesChannels.options.length;i++){
                        if(selectedChannels != null && selectedChannels.includes(salesChannels.options[i].value)){
                            salesChannels.options[i].selected = 'selected';
                        }
                    }
                }
				
                // get price levels
                var priceLevelaction = component.get("c.getPriceLevels");
                priceLevelaction.setParams({"priceTypeId": component.get("v.priceId")});
                
                priceLevelaction.setCallback(this, function(result) {
                    var state = result.getState();
                    if (component.isValid() && state === "SUCCESS") 
                    {
                        component.set("v.priceLevels", result.getReturnValue());    
                    }
                    else	
                    {
                        console.log("Failed with state: " + state);
                    }
                });
                $A.enqueueAction(priceLevelaction);
            }
            else	
            {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
        component.set("v.cssStyle", ".forceStyle.desktop .stage {z-index:6}");
    },
    
    handleSave: function(component, event, helper) {
        debugger;
        var recordId = component.get("v.recordId");
        var pricedetails = component.get("v.simpleNewPrice");
        var action = component.get("c.savePrice");
        var priceLevels = component.get("v.priceLevels");
        for(var i=0; i<priceLevels.length; i++){
            priceLevels[i].Price_Type__c =  pricedetails.Id;
            if(priceLevels[i].Service_Charge__c == null && priceLevels[i].Price__c == undefined ){
                priceLevels.splice(i,1);
            }
        }
        action.setParams({
            "price": component.get("v.simpleNewPrice"),
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
                
                //Reload the view so components not using force:recordData are updated
                // $A.get("e.force:refreshView").fire();
            }else{
                alert(JSON.stringify(response.getError()[0]));
            }
        });
        $A.enqueueAction(action);
    }, 
    
    closeMe : function(component, event, helper)  { 
        component.destroy();
    }
})