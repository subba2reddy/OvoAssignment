({
    doInit : function(component, event, helper) {
        debugger;
        var action = component.get("c.getPriceLevels");
        var recordId = component.get("v.recordId");
        var price, facilityFee, serviceCharge;
        action.setParams({priceTypeId: component.get("v.recordId")});
        action.setCallback(this, function(response){
            var callStatus = response.getState();
            if(callStatus == "SUCCESS"){
                var respObj = JSON.parse(response.getReturnValue());
                var priceLevels = component.get("v.priceLevels");
                priceLevels = JSON.parse(response.getReturnValue());
                component.set("v.priceLevels", priceLevels);
                for(var i=0;i<priceLevels.length;i++){
                    if(priceLevels[i].Price__c != undefined && priceLevels[i].Price__c !="" && isNaN(priceLevels[i].Price__c)){
                        var auraId = 'txtCol' + i;
                        var tstCmp = component.find(auraId);
                        if(tstCmp != undefined){
                        	tstCmp.set("v.format", '#####');
                        }
                    }
                }
/*                price = '<td style="border: 1px solid black;"> PRICE ' +  '</td>';
                facilityFee = '<td style="border: 1px solid black;"> FACILITY FEE'+ '</td>';
                serviceCharge = '<td style="border: 1px solid black;"> SERVICE CHARGE' + '</td>';
                
                var strPrice = 'tr[id$="price' + recordId + '"]';
                var strFac = 'tr[id$="facilityFee' + recordId + '"]';
                var strService = 'tr[id$="serviceCharge' + recordId + '"]';
                
                $(strPrice).append(price);
                $(strFac).append(facilityFee);
                $(strService).append(serviceCharge);
                
                for(var i=0 ; i <respObj.length ; i++)
                {
                    price = '<td style="border: 1px solid black;"> £' + respObj[i].Price__c + '</td>';
                    facilityFee = '<td style="border: 1px solid black;"> £' + respObj[i].Facility_fee__c + '</td>';
                    serviceCharge = '<td style="border: 1px solid black;"> £' + respObj[i].Service_Charge__c + '</td>';
                    
                    $(strPrice).append(price);
                    $(strFac).append(facilityFee);
                    $(strService).append(serviceCharge);
                }              */
            }else{
                alert("There was an error!!");
            }
        });
        $A.enqueueAction(action);        
    },
    
    refreshPriceLevel: function(component, event, helper){
        var params = event.getParam('arguments');
        var action = component.get("c.getPriceLevels");
        action.setParams({priceTypeId: params.eventID});
        action.setCallback(this, function(response){
            var callStatus = response.getState();
            if(callStatus == "SUCCESS"){
                var respObj = JSON.parse(response.getReturnValue());
                var priceLevels = component.get("v.priceLevels");
                priceLevels = JSON.parse(response.getReturnValue());
                component.set("v.priceLevels", priceLevels);
            }else{
                alert("There was an error!!");
            }
        });
        
        $A.enqueueAction(action);          
    },
    
    handleUpdateFacilityFee: function(component, event, helper){
        alert("hello");
        var facilityFee = event.getParam("facilityFee");
        var eventId = event.getParam("eventId");
        alert("facility fee: " + facilityFee);

    }
})