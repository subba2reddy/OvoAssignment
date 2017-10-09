({
	doInit : function(component, event, helper) {
		//call apex controller method
		var i;
        var apxCtrl = component.get("c.getMasterCharts");
        apxCtrl.setParams({EvtId: component.get("v.recordId")} );
        apxCtrl.setCallback(this, function(response){
            var callStatus = response.getState();			
            if(callStatus == "SUCCESS"){
                //set the master charts once we get response
                var jsonResult = response.getReturnValue();
                var objMasterCharts = JSON.parse(jsonResult);
                //fix annoying behaviour of javscript i.e if attributes are not defined
                //then add an empty value to define the attributes - else it will cause problems
                for(i=0;i<objMasterCharts.length;i++){
                    if(objMasterCharts[i].TXT_Line_1__c == undefined){
                        objMasterCharts[i].TXT_Line_1__c = '';
                    }
                    if(objMasterCharts[i].TXT_Line_2__c == undefined){
                        objMasterCharts[i].TXT_Line_2__c = '';
                    }
                    if(objMasterCharts[i].TXT_Line_3__c == undefined){
                        objMasterCharts[i].TXT_Line_3__c = '';
                    }
                    if(objMasterCharts[i].TXT_Line_4__c == undefined){
                        objMasterCharts[i].TXT_Line_4__c = '';
                    }
                    if(objMasterCharts[i].TXT_Line_5__c == undefined){
                        objMasterCharts[i].TXT_Line_5__c = '';
                    }
                    if(objMasterCharts[i].EXTCOM_Line_1__c == undefined){
                        objMasterCharts[i].EXTCOM_Line_1__c = '';
                    }
                    if(objMasterCharts[i].EXTCOM_Line_2__c == undefined){
                        objMasterCharts[i].EXTCOM_Line_2__c = '';
                    }
                    if(objMasterCharts[i].EXTCOM_Line_3__c == undefined){
                        objMasterCharts[i].EXTCOM_Line_3__c = '';
                    }
                    if(objMasterCharts[i].EXTCOM_Line_4__c == undefined){
                        objMasterCharts[i].EXTCOM_Line_4__c = '';
                    }
                    if(objMasterCharts[i].EXTCOM_Line_5__c == undefined){
                        objMasterCharts[i].EXTCOM_Line_5__c = '';
                    }
                    if(objMasterCharts[i].EXTCOM_Line_6__c == undefined){
                        objMasterCharts[i].EXTCOM_Line_6__c = '';
                    }
                    if(objMasterCharts[i].EXTCOM_Line_7__c == undefined){
                        objMasterCharts[i].EXTCOM_Line_7__c = '';
                    }
                    if(objMasterCharts[i].EXTCOM_Line_8__c == undefined){
                        objMasterCharts[i].EXTCOM_Line_8__c = '';
                    }
                    if(objMasterCharts[i].EXTCOM_Line_9__c == undefined){
                        objMasterCharts[i].EXTCOM_Line_9__c = '';
                    }                            
                }
                component.set("v.MasterCharts", objMasterCharts);
                component.set("v.curMasterChart", objMasterCharts[0]);
            }
        });
		//make the actual call to server
		$A.enqueueAction(apxCtrl);       
	},
    
    saveMC : function(component, event, helper) {
		var objMasterCharts = component.get("v.MasterCharts");
        var jsonData = JSON.stringify(objMasterCharts);
        
		//call apex controller method
        var apxCtrl = component.get("c.saveMasterCharts");
        apxCtrl.setParams({jsonMC: jsonData} );
        apxCtrl.setCallback(this, function(response){
            var callStatus = response.getState();
            var toastEvent = $A.get("e.force:showToast");
            if(callStatus == "SUCCESS"){
                //display a success message
            	toastEvent.setParams({
                    title: 'Success',
                    type: 'info',
                    message: response.getReturnValue()
            	});
            }
            else{
                //display the error message
             	toastEvent.setParams({
                    title: 'Error',
                    type: 'error',
                    message: response.getError()[0]
            	});               
            }
            toastEvent.fire();            
        })
		//make the actual call to server
		$A.enqueueAction(apxCtrl);       
	},
    
    handleSelect : function(component, event, helper) {
		//get current value and the master charts
        var selValue = component.find("selMasterCharts").get("v.value");
        var objMasterCharts = component.get("v.MasterCharts");

        for(var i=0; i<objMasterCharts.length; i++){
           	if(objMasterCharts[i].Name == selValue){
                //set the selected value as the current master chart
                var curMasterChart = objMasterCharts[i];
                component.set("v.curMasterChart", curMasterChart);
                break;
            }
        }
	},

    handleKeyUp : function(component, event, helper) {
		//this method is to change user input to upper case
		var auraId = event.target.id;
		var value = document.getElementById(event.target.id).value;
        //change the input to upper case
        var uppCaseVal = value.toUpperCase();
        
        //get the current master chart object
        var curMasterChart = component.get("v.curMasterChart");
        if(curMasterChart != undefined){
            //case on the if of the element
            switch(auraId){
                case 'txtline1-'+component.get("v.recordId"):
                    curMasterChart.TXT_Line_1__c = uppCaseVal;
                    break;
                case 'txtline2-'+component.get("v.recordId"):
                    curMasterChart.TXT_Line_2__c = uppCaseVal;
                    break;
                case 'txtline3-'+component.get("v.recordId"):
                    curMasterChart.TXT_Line_3__c = uppCaseVal;
                    break;
                case 'txtline4-'+component.get("v.recordId"):
                    curMasterChart.TXT_Line_4__c = uppCaseVal;
                    break;
                case 'txtline5-'+component.get("v.recordId"):
                    curMasterChart.TXT_Line_5__c = uppCaseVal;
                    break;
                case 'extline1-'+component.get("v.recordId"):
                    curMasterChart.EXTCOM_Line_1__c = uppCaseVal;
                    break;
                case 'extline2-'+component.get("v.recordId"):
                    curMasterChart.EXTCOM_Line_2__c = uppCaseVal;
                    break;
                case 'extline3-'+component.get("v.recordId"):
                    curMasterChart.EXTCOM_Line_3__c = uppCaseVal;
                    break;
                case 'extline4-'+component.get("v.recordId"):
                    curMasterChart.EXTCOM_Line_4__c = uppCaseVal;
                    break;
                case 'extline5-'+component.get("v.recordId"):
                    curMasterChart.EXTCOM_Line_5__c = uppCaseVal;
                    break;
                case 'extline6-'+component.get("v.recordId"):
                    curMasterChart.EXTCOM_Line_6__c = uppCaseVal;
                    break;
                case 'extline7-'+component.get("v.recordId"):
                    curMasterChart.EXTCOM_Line_7__c = uppCaseVal;
                    break;
                case 'extline8-'+component.get("v.recordId"):
                    curMasterChart.EXTCOM_Line_8__c = uppCaseVal;
                    break;
                case 'extline9-'+component.get("v.recordId"):
                    curMasterChart.EXTCOM_Line_9__c = uppCaseVal;                
            }
            //set the upper case value back again        
            component.set("v.curMasterChart", curMasterChart);            
        }

		
	}    
 
})