({
	createAccount: function(component, Account) {
    var action = component.get("c.saveAccount");
    action.setParams({
        "accountObj": Account
    });
    action.setCallback(this, function(response){
        var state = response.getState();
        if (component.isValid() && state === "SUCCESS") {
            var newAccount = component.get("v.newAccount");
            component.set("v.newAccount", newAccount);
        }
    });
    $A.enqueueAction(action);
}
})