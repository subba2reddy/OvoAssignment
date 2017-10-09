({
    doInit : function(component, event, helper) {
        
/*        var actions = [
            {value: "0", label: "Choose an Action"},
            {value: "1", label: "Add first Performance"},
            {value: "2", label: "Make a sample weeks’ worth of performances"},
            {value: "3", label: "Repeat sample period for production run"},
            {value: "4", label: "Delete all rows"},
            {value: "5", label: "Mark all as sample performances"},
            {value: "6", label: "Mark all as standard performances"}
        ];
        component.set("v.actions", actions); 
        
        helper.getDaysPicklistOptions(component);
        helper.getPerformancePicklistOptions(component); */
        
        
        /* Get Event Details */
        var action = component.get("c.getEventDetails");
        
        action.setParams({
            "EventId": component.get("v.recordId")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.event", response.getReturnValue());
                console.log("event: " + response.getReturnValue());
                
                /* Get Performances */
                var action = component.get("c.getPerformances");
                
                action.setParams({
                    "eventId": component.get("v.recordId") 
                });
                action.setCallback(this, function(response){
                    var state = response.getState();
                    if(component.isValid() && state === "SUCCESS") {
                        console.log(response.getReturnValue());
                        var performances = response.getReturnValue();
                        for(var i=0; i<performances.length; i++){
                            performances[i].Date__c = performances[i].Date_Time__c.slice(0,10);
                            performances[i].Time__c = performances[i].Date_Time__c.slice(11,16);
                        }
                        //sort it before displaying
                        performances.sort(function(a,b){
                            //compare date along with the times
                            return ( new Date(a.Date__c + 'T' + a.Time__c + ':00.000Z') - new Date(b.Date__c + 'T' + b.Time__c + ':00.000Z') ); 
                        });                        
                        
                        component.set("v.Performances", performances);

                        window.setTimeout(
                            $A.getCallback(function(){
                                var allRows = component.find("scrollableTable").getElement().childNodes;
                                for(var i=0; i < allRows.length; i++){
                                    if(performances[i].Sample__c == false){
                                        $A.util.removeClass(allRows[i],"selectedRow");
                                    }else{
                                        $A.util.addClass(allRows[i],"selectedRow");
                                    }
                                }
                            }), 50
                        );                        
                        
                        
                        /* Get Days Picklist values 
                        var action = component.get("c.getDayspickval");
                        var inputsel = component.find("days");
                        console.log("inputsel: " + inputsel);
                        var opts=[];
                        action.setCallback(this, function(response) {
                            var state = response.getState();
                            if(component.isValid() && state === "SUCCESS"){
                                for(var i=0;i< response.getReturnValue().length;i++){
                                    opts.push({"class": "optionClass", label: response.getReturnValue()[i], value: response.getReturnValue()[i]});
                                };
                                for(var j=0; j<component.get("v.Performances").length; j++){
                                    inputsel[j].set("v.options", opts);
                                }
                                
//                                 Get Performance Picklist values 
                                var action = component.get("c.getPerformancepickval");
                                var performanceComponent = component.find("Performance");

                                var performanceOpts=[];
                                action.setCallback(this, function(response) {
                                    var state = response.getState();
                                    if(component.isValid() && state === "SUCCESS"){
                                        for(var k=0;k< response.getReturnValue().length;k++){
                                            performanceOpts.push({"class": "optionClass", label: response.getReturnValue()[k], value: response.getReturnValue()[k]});
                                        };
                                        for(var l=0; l<component.get("v.Performances").length; l++){
                                            performanceComponent[l].set("v.options", performanceOpts);
                                        }
                                    }
                                    else{
                                        console.log("Failed with state: " + state);
                                    }
                                }); 
                                $A.enqueueAction(action);                                 
                                
                                
                            }
                            else{
                                console.log("Failed with state: " + state);
                            } 
                        });
                        $A.enqueueAction(action); */
                    } 
                    else{
                        console.log("Failed with state: " + state);
                    } 
                }); 
                $A.enqueueAction(action);
            }
            else{
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
        
    },
    
    handleActions: function(component, event, helper)
    {
        var itemSelected = component.find("selectItem").get("v.value");
        var newPerformance = component.get("v.Performance");
        switch(itemSelected)
        {
            case "Add first Performance":
                helper.addFirstPerformance(component, newPerformance);
                break;
            case "Make a sample weeks’ worth of performances":
                helper.makeSampleWeeksWorth(component, event, helper);
                break;
            case "Repeat sample period for production run":
                helper.repeatSampleForProduction(component, event, helper);
                break;
            case "Delete all rows":
                helper.deleteAllRows(component, event, helper);
                break;
            case "Mark all as sample performances":
                helper.markAllAsSamplePerformances(component, event, helper);
                break;
            case "Mark all as standard performances":
                helper.markAllAsStandardPerformances(component, event, helper);
                break; 
            default:
                console.log("default");
        }; 
    }, 
    
    onDateChange: function(component, event, helper){
/*      var dtChgdPerf = component.get("v.changedPerfDates");
        var target = event.target;
        var index = target.getAttribute("data-selected-Index");
        
        if(dtChgdPerf.indexOf(index) == -1){
            dtChgdPerf.push(index);
        }
  */   
			
        	var target = event.target;
        	var index = target.getAttribute("data-selected-Index");        
            var days = ['SUNDAY', 'MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY'];
            
            var performances = component.get("v.Performances");
            var performance = performances[index]; 
            
            // update event code
            var dateValue = target.value;
            var eventCode = performance.Event_Code__c;
            performance.Date__c = dateValue;
            performance.Event_Code__c = eventCode.substring(0,3) + dateValue.slice(8,10) + dateValue.slice(5,7) + eventCode.slice(7,8);
            
            // Update Day
            performance.Day__c = days[new Date(dateValue).getDay()];
            //  alert(typeof(performances));
            
            component.set("v.Performances",performances);     
        
    },
    
    
    onDateBlur: function(component, event, helper){
 /*       var dtChgdPerf = component.get("v.changedPerfDates");
        var target = event.target;
        var index = target.getAttribute("data-selected-Index");
        
        if(dtChgdPerf.indexOf(index) != -1){
            var days = ['SUNDAY', 'MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY'];
            
            var performances = component.get("v.Performances");
            var performance = performances[index]; 
            
            // update event code
            var dateValue = target.value;
            var eventCode = performance.Event_Code__c;
            performance.Date__c = dateValue;
            performance.Event_Code__c = eventCode.substring(0,3) + dateValue.slice(8,10) + dateValue.slice(5,7) + eventCode.slice(7,8);
            
            // Update Day
            performance.Day__c = days[new Date(dateValue).getDay()];
            //  alert(typeof(performances));
            
            component.set("v.Performances",performances);     
            
            //remove the changed date from the array
            dtChgdPerf = dtChgdPerf.filter(item => item != index);
            component.set("v.changedPerfDates", dtChgdPerf);
        }

*/
    },
    
    
    addMasterChart: function(component, event, helper){
        var performances = component.get("v.Performances");
        var target = event.target;
        var index = target.getAttribute("data-selected-Index");
        var performance = performances[index];
        
        performance.Master_Chart__c = target.value;
        component.set("v.Performances", performances);
        
    }, 
    
    addPerformanceTime: function(component, event, helper){
        var performances = component.get("v.Performances");
        var target = event.target;
        var index = target.getAttribute("data-selected-Index");
        var performance = performances[index];
        
        performance.Time__c = target.value;
        component.set("v.Performances", performances);
    },
    
    makeLinks: function(component, event, helper){
        
        var performances = component.get("v.Performances");

        performances.sort(function(a,b){
			//compare date along with the times
            return ( new Date(a.Date__c + 'T' + a.Time__c + ':00.000Z') - new Date(b.Date__c + 'T' + b.Time__c + ':00.000Z') ); 
        });
        
        for(var i=0; i<performances.length; i++){
            
            // Populate Link Next
            if(i<performances.length-1){
                performances[i].Link_Next__c = performances[i+1].Event_Code__c;
            }else if(i==performances.length-1){
                performances[i].Link_Next__c = '';              
            };
            
            // Populate Link Prev
            if(i>=1){
                // number the weeks with sunday cutoff and compare the week of the previous performance with the current performance, if
                // they are not equal it means a change of week, then blank out the link prev of current performance.
                var previousPerformanceWeek = helper.getWeekNumber(new Date(performances[i-1].Date__c));
                var currentPerformanceWeek = helper.getWeekNumber(new Date(performances[i].Date__c));
                if(currentPerformanceWeek > previousPerformanceWeek){
                    performances[i].Link_Prev__c = "";
                }else{
                    performances[i].Link_Prev__c = performances[i-1].Event_Code__c;        
                }
            }else if(i==0){
                performances[i].Link_Prev__c = "";	  
            };
            
            //Populate Link Prev Week
            var currentPerformanceDate = new Date(performances[i].Date__c);
            var firstPerformanceDate = new Date(performances[0].Date__c);
            
            if(Math.abs(currentPerformanceDate - firstPerformanceDate)/86400000 >= 7){
                var oneWeekAgo = new Date( currentPerformanceDate.getTime() - (7 * 24 * 60 * 60 * 1000) ).toJSON().slice(0,10); 
                var performance = helper.performanceSearch(oneWeekAgo, performances[i].Day__c, performances, performances[i].Link_Prev_Week__c, performances[i].Suffix__c);
                if(performance != undefined){
                    performances[i].Link_Prev_Week__c = performance.Event_Code__c;    
                }else{
                    performances[i].Link_Prev_Week__c = '';    
                }
            };
            
        }
        component.set("v.Performances", performances);
        
    },
    
    
    onPerformanceChange: function(component, event, helper){
        
        var target = event.target;
        var index = target.getAttribute("data-selected-Index");
        var performances = component.get("v.Performances");
        var performance = performances[index];
        
        console.log("performance: " + JSON.stringify(performance));
        var performanceValue = target.options[target.selectedIndex].value;
        console.log("performanceValue: " + performanceValue);
        performance.Performance__c = performanceValue;
        
        var eventCode = performance.Event_Code__c;
        console.log("EVENT CODE: " + eventCode);
        
        switch(performanceValue){
            case "MATINEE":
                performance.Suffix__c = "M";
                performance.Event_Code__c = eventCode.slice(0,7)+"M";
                break;
            case "EARLY EVENING":
                performance.Suffix__c = "E";
                performance.Event_Code__c = eventCode.slice(0,7)+"E";
                break;
            case "LATE":
                performance.Suffix__c = "L";
                performance.Event_Code__c = eventCode.slice(0,7)+"L";
                break;
            case "AFTERNOON":
                performance.Suffix__c = "A";
                performance.Event_Code__c = eventCode.slice(0,7)+"A";
                break;
            case "MORNING":
                performance.Suffix__c = "F";
                performance.Event_Code__c = eventCode.slice(0,7)+"F";
                break;
            case "STANDING":
                performance.Suffix__c = "S";
                performance.Event_Code__c = eventCode.slice(0,7)+"S";
                break;
            case "NIGHT":
                performance.Suffix__c = "N";
                performance.Event_Code__c = eventCode.slice(0,7)+"N";
                break;
            case "DOORS":
                performance.Suffix__c = "D";
                performance.Event_Code__c = eventCode.slice(0,7)+"D";
                break;
            case "VIP":
                performance.Suffix__c = "V";
                performance.Event_Code__c = eventCode.slice(0,7)+"V";
                break;
            case "GATES":
                performance.Suffix__c = "T";
                performance.Event_Code__c = eventCode.slice(0,7)+"T";
                break;
            case "EVENING":
                performance.Suffix__c = "";
                performance.Event_Code__c = eventCode.slice(0,7);
                break;
            default:
        };
        console.log("performance after update: " + JSON.stringify(performance));
        component.set("v.Performances",performances);
    },
    
    deletePerformance: function(component,event, helper){
        var index = event.getSource().get("v.value");
        var performances = component.get("v.Performances");
        if (index > -1){
            if(performances[index].Id != undefined){
                var delPerformance = component.get('v.deletedPerf');         
                delPerformance.push(performances[index]);
                component.set("v.deletedPerf", delPerformance);
            }
            performances.splice(index,1);
        }
        component.set("v.Performances", performances);
    },
    
    clonePerformance: function(component, event, helper){
        var performance = JSON.parse(JSON.stringify(event.getSource().get("v.value")));
        var performances = component.get("v.Performances");
        delete performance.Id;
        performance.Link_Next__c = "";
        performance.Link_Prev__c = "";
        performance.Link_Prev_Week__c = "";
        performances.push(performance);
        component.set("v.Performances", performances);
        var index = event.getSource().get("v.name") + 1;
        window.setTimeout(
            $A.getCallback(function(){
                var selectedRow = component.find("scrollableTable").getElement().childNodes[index];
                if(performance.Sample__c == true){
	                $A.util.addClass(selectedRow,"selectedRow");
                }
            }), 10
        ); 
    },
    
    onSave: function(component, event, helper){
        var strEvent = '';
        var action = component.get("c.savePerformances");
        var performances = component.get("v.Performances");
        var delPerformance = component.get('v.deletedPerf'); 
        var performance = component.get("v.Performance");
        var apexArray = JSON.parse(JSON.stringify(performances)); //clone array not by reference
        var events = component.get("v.event");
        
        //check if event date is changed if so save the changed dates
        if(component.get("v.evtDateChanged")){
            strEvent = '[{"id":"' + component.get("v.recordId") + '","Performance_Start_Date__c":"' + events[0].Performance_Start_Date__c
            + '", "Performance_End_Date__c":"' + events[0].Performance_End_Date__c + '"}]';
        }
        
        for(var i=0; i<performances.length; i++){
            performances[i].Date_Time__c = performances[i].Date__c + 'T' +performances[i].Time__c +  ':00.000Z';		
            performances[i].Event__c = component.get("v.recordId");
            apexArray[i].Date_Time__c = apexArray[i].Date__c + 'T' +apexArray[i].Time__c +  ':00.000Z';
            apexArray[i].Event__c = component.get("v.recordId");
            delete apexArray[i].Time__c; 	//delete date and time on duplicate array else it will error on second time save
            delete apexArray[i].Date__c;
        }
        
        action.setParams({
            "performanceList": JSON.stringify(apexArray), "deletedPerfs": JSON.stringify(delPerformance), "evtDates": strEvent
        });
        
        action.setCallback(this, function(response){
            component.set("v.evtDateChanged", false);
            var state = response.getState();
            var toastEvent = $A.get("e.force:showToast");            
            if (component.isValid() && state === "SUCCESS") {
                toastEvent.setParams({
                    "title": "Success!",
                    "type": "info",
                    "message": "The records have been saved successfully."
                });
            }else{
                toastEvent.setParams({
                    "title": "Error",
                    "type": "error",
                    "message": response.getError()[0].message
                });                
                console.log(JSON.stringify(response.getError()[0]));
                //alert(response.getError()[0]);
            }
            toastEvent.fire();            
        });
        $A.enqueueAction(action);
        
        //fire event to tell master charts tab that a save was performed
        var perfEvent = $A.get("e.c:savePerformanceEvent");
        if(perfEvent != undefined){
            perfEvent.fire();
        }
    },
    
    markSample: function(component, event, helper) {
        var performances = component.get("v.Performances");
        var index = event.getSource().get("v.value");
        if(index > -1){
	        var selectedRow = component.find("scrollableTable").getElement().childNodes[index];
    	    $A.util.addClass(selectedRow,"selectedRow");
            performances[index].Sample__c = true;
            // set the changed array back to aura
            component.set("v.Performances", performances);            
        }
    },
    
    markStandard: function(component, event, helper){
        var performances = component.get("v.Performances");
        var index = event.getSource().get("v.value");
        if(index > -1)
        {   
            var selectedRow = component.find("scrollableTable").getElement().childNodes[index];
         	$A.util.removeClass(selectedRow,"selectedRow");
            performances[index].Sample__c = false;
            // set the changed array back to aura
            component.set("v.Performances", performances);     
        }
    },
    
    
    onEvtDateChanged : function(component, event, helper){
        component.set("v.evtDateChanged", true);
    },
    
    afterScriptsLoaded: function(){
        /*        
        if(jQuery.ui){
            console.log("jqueryui loaded successfully");
        }else{
            console.log("jqueryui load failed");
        }
        
  */    
    },
})