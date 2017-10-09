({
    showComponent : function (component, event, helper) {
        console.log("in Show");
  		$A.util.removeClass(component.find('xxx'), "slds-hide");
	},
    
	hideComponent : function (component, event, helper) {
        console.log("in Hide");
  		$A.util.addClass(component.find("xxx"), "slds-hide");
	},
})