({
    
    doInit: function(component, event, helper) {
        
        var action = component.get("c.getContacts");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var contacts = response.getReturnValue();
                for(var i=0; i<contacts.length; i++){
                    if(contacts[i].loyalty_status__c == 'Friendly'){
                        contacts[i].friendly = true;
                    }else{
                        contacts[i].friendly = false;
                    }
                }
                component.set("v.Contacts", contacts);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        
        $A.enqueueAction(action);
    },
    
    updateLoyaltyStatus: function(component, event, helper){
        var contacts = component.get("v.Contacts");
        
        for(var i=0;i<contacts.length; i++){
            if(contacts[i].friendly == true){
                contacts[i].loyalty_status__c = 'Friendly';    
            }else{
                contacts[i].loyalty_status__c = 'Unfriendly';
            }
        }
        
        var action = component.get("c.updateLoyalty");
        
        action.setParams({
            "contactList": JSON.stringify(contacts)
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                alert('Loyalty Status updated successfully');
                /*
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Loyalty status has been updated successfully."
                });
                toastEvent.fire(); */
            }
            else {
                alert('There was an error, please contact the administrator');
                console.log("Failed with state: " + state);
            }
        });
        
        $A.enqueueAction(action);
    },
})