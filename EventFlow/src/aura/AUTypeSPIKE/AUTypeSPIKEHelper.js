({
    setText : function(cmp) {
        var apexCtrl = cmp.get("c.getFileText");

        apexCtrl.setCallback(this, function(response){
            var callStatus = response.getState();
            if(callStatus == "SUCCESS"){
                var respObj = response.getReturnValue();
                cmp.find("auType").set("v.value", respObj)
           
            }else{
                alert("There was an error!!");
            }
        });
        $A.enqueueAction(apexCtrl);             
    },

    updateChanges : function(cmp) {
        var apexCtrl = cmp.get("c.updateTextFile");
        apexCtrl.setParams({strFileContent: cmp.find("auType").get("v.value")});
        apexCtrl.setCallback(this, function(response){
            var callStatus = response.getState();
            if(callStatus == "SUCCESS"){
                var respObj = response.getReturnValue();
                alert(respObj);
            }else{
                alert("There was an error!!");
            }
        });
        $A.enqueueAction(apexCtrl);             
    }
        
})