({
	doInit : function(component, event, helper) {
        var strObj = '[{"evtCode" : "abc","time" : "dumbar","date" : "datebar","datetime" : "dumbardatebar"},{"evtCode" : "def","time" : "dumbar1","date" : "datebar1","datetime" : "dumbar1datebar1"},{"evtCode" : "grf","time" : "dumbar2","date" : "datebar2","datetime" : "dumbar2datebar2"}]';
        var arrObj = JSON.parse(strObj);
        
        for(var i=0;i<arrObj.length;i++){
            console.log(arrObj[i].evtCode);
        }
        
        console.log("inside do init");
		var action = component.get("c.findAll");
		action.setParams({
            "pageNumber": 1
    	});
        
        action.setCallback(this, function(a) {
            var result = a.getReturnValue();
            console.log(result);
            component.set("v.contacts", result.contacts);
            component.set("v.blnRendered", true);
        });
        $A.enqueueAction(action);
    },
    
    doneRendering: function(component, event, helper){
        var blnRendered = component.get("v.blnRendered");
        if(blnRendered){
            $('.carousel').slick({
                slidesToShow: 1,
                slidesToScroll: 1
            });            
        }
    } 
})