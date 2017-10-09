({
/*    getDaysPicklistOptions: function(component){
        // Get Days Picklist values 
        var action = component.get("c.getDayspickval");
        var opts=[];
        
        action.setCallback(this, function(a) {
            for(var i=0;i< a.getReturnValue().length;i++){
                opts.push({"class": "optionClass", label: a.getReturnValue()[i], value: a.getReturnValue()[i]});
            };
            component.set("v.daysPicklistOptions", opts);
            
        });
        $A.enqueueAction(action); 
    }, 
    
    getPerformancePicklistOptions: function(component){
        // Get Performance Picklist values 
        var action = component.get("c.getPerformancepickval");
        var opts=[];
        
        action.setCallback(this, function(a) {
            for(var i=0;i< a.getReturnValue().length;i++){
                opts.push({"class": "optionClass", label: a.getReturnValue()[i], value: a.getReturnValue()[i]});
            };
            component.set("v.performancePicklistOptions", opts);
        });
        $A.enqueueAction(action); 
    },
        */
    
    addFirstPerformance: function(component, Performance){
        
        var Performances = component.get('v.Performances');
        var events = component.get("v.event");
        var days = ['SUNDAY', 'MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY'];
        
        if(Performances.length < 1){
            var startDate = component.find('startDate').get('v.value');
            var eventCode = String(events[0].Event_Code_Prefix__c) + String(startDate.slice(8,10)) + String(startDate.slice(5,7));
            var performanceDate = new Date(startDate);
            var day = days[performanceDate.getDay()]; 
            
            var newPerformance = {
                "Date__c" : startDate.slice(0,10),
                "Event_Code__c" :  eventCode,
                "Day__c" :  day,
                "Sample__c": true,
                "Performance__c": "EVENING"
            };
            console.log('start date ' + startDate.slice(0,10));
            console.log('day ' + day);
            console.log('event code ' +eventCode);
            
            Performances.push(newPerformance);            
            
            component.set("v.Performances", Performances);
            window.setTimeout(
           		 $A.getCallback(function(){
                    var selectedRow = component.find("scrollableTable").getElement().childNodes[0];
                    $A.util.addClass(selectedRow,"selectedRow");
                 }), 10
            );

        }else{
            alert('The event has performances');
        };	
    }, 
    
    makeSampleWeeksWorth: function(component, Performance){
        var performances = component.get("v.Performances");
        var endDate = new Date(component.find("endDATE").get("v.value").slice(0,10));
        
        var samplePerformances = [];
        
        for(var j=0; j<performances.length; j++){
            if(performances[j].Sample__c){
                samplePerformances.push(performances[j]);
            }
        };
        
        if(performances.length > 0 && samplePerformances.length < 7)
        {
            var events = component.get("v.event");
            var days = ['SUNDAY', 'MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY'];
            
            var startDate = samplePerformances[0].Date__c;
            var eventCode = String(events[0].Event_Code_Prefix__c) + String(startDate.slice(8,10)) + String(startDate.slice(5,7));
            var performanceDate = new Date(startDate);
            var masterChart = samplePerformances[0].Master_Chart__c;
            
            for(var i=1; i<=6 && performanceDate < endDate && samplePerformances.length < 7; i++){
                
                performanceDate.setDate(performanceDate.getDate()+1);
                var eventCode = String(events[0].Event_Code_Prefix__c) + String(performanceDate.toJSON().slice(8,10)) + 
                    			String(performanceDate.toJSON().slice(5,7)) + samplePerformances[0].Event_Code__c.slice(7,8);
                
                var newPerformance = JSON.parse(JSON.stringify(samplePerformances[0]));
                delete newPerformance.Id; 	//delete the performance id if there is one
                newPerformance.Date__c = performanceDate.toJSON().slice(0,10);
                newPerformance.Event_Code__c = eventCode;
                newPerformance.Day__c = days[performanceDate.getDay()];
                newPerformance.Sample__c = true;

/*                var newPerformance = {
                    "Date__c": performanceDate.toJSON().slice(0,10),
                    "Event_Code__c": eventCode,
                    "Day__c": days[performanceDate.getDay()],
                    "Master_Chart__c": masterChart,
                    "Sample__c": true
                }; */
                performances.push(newPerformance);
            }
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
                }), 100
            );
        }else
            if(samplePerformances.length >=7) {
                alert("This event has got a sample week's worth of Performances" );            
            }else{
                alert('You need to add a sample Performance first');
            }    
    },
    
    
    repeatSampleForProduction: function(component, event, helper){
        
        var performances = component.get("v.Performances");					 	 		//original copy of performances, any new performances will be appended to this 
        var forSample = performances.filter(function (el) {
                            return el.Sample__c == true; 
                        });
        //alert(performances.length);
        var numberOfSamplePerformances = forSample.length; 								// number of performances in original sample
        var samplePerformances = JSON.parse(JSON.stringify(forSample)); 				// working sample
        var newPerformanceDate = new Date(samplePerformances[0].Date__c);
        newPerformanceDate.setDate(newPerformanceDate.getDate() + 7); 					// should be date for comparision purposes
        var endDate = new Date(component.find("endDATE").get("v.value").slice(0,10) + "T22:59:59.000Z");	// should be date for comparision purposes	
                
        while(newPerformanceDate < endDate)
        {
            for (var i=0; i < numberOfSamplePerformances && newPerformanceDate < endDate; i++) {
                samplePerformances[i].Date__c = this.incrementDate(samplePerformances[i].Date__c);
                newPerformanceDate = new Date(samplePerformances[i].Date__c); 
                if(newPerformanceDate < endDate ){										// add to list only if new performance date is within range
                    delete samplePerformances[i].Id;									// delete the id if it has once else will cause trouble later
                    samplePerformances[i].Link_Next__c = "";							
                    samplePerformances[i].Link_Prev__c = "";							// initialize the links to blank - it will be filled up when 
                    samplePerformances[i].Link_Prev_Week__c = "";						// user clicks on make links. Else it confuses the users.
                    samplePerformances[i].Event_Code__c = samplePerformances[i].Event_Code__c.slice(0,3) + samplePerformances[i].Date__c.slice(8,10)
                    + samplePerformances[i].Date__c.slice(5,7) + (samplePerformances[i].Suffix__c == undefined ? "" : samplePerformances[i].Suffix__c);  
                    performances.push(JSON.parse(JSON.stringify(samplePerformances[i])));                   
                }
            }
        };
        component.set("v.Performances", performances); 
        window.setTimeout(
            $A.getCallback(function(){
                var allRows = component.find("scrollableTable").getElement().childNodes;
                for(var j=0; j < allRows.length; j++){
                    if(performances[j].Sample__c == false){
                        $A.util.removeClass(allRows[j],"selectedRow");
                    }else{
                        $A.util.addClass(allRows[j],"selectedRow");
                    }
                }
            }), 100
        );
    }, 
    
    
    deleteAllRows: function(component, event, helper){
        
        var performances = component.get("v.Performances");
        var action = component.get("c.deleteAllPerformances");

            
        if(performances.length > 0){
            if(confirm('Are you sure you want to delete all '+ performances.length + ' performances?')){
                action.setParams({
                    "performanceList": JSON.stringify(performances)
                });
                
                action.setCallback(this, function(response){
                    var state = response.getState();
                    if (component.isValid() && state === "SUCCESS") {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "Success!",
                            "message": "The records have been deleted successfully."
                        });
                        performances = [];
                        component.set("v.Performances", performances);
                        toastEvent.fire();
                    }else{
                        alert('delete failed: ' + JSON.stringify(response.getError()));
                    }
                });
                $A.enqueueAction(action);
                
            }
        }else{
            alert('There are no performances to delete');		            
        }
    },
    
    
    markAllAsSamplePerformances: function(component, event, helper){
        var performances = component.get("v.Performances");
        var allRows = component.find("scrollableTable").getElement().childNodes;
        for(var i=0; i < allRows.length; i++){
            $A.util.addClass(allRows[i],"selectedRow");
            performances[i].Sample__c = true;
        }
        // set the changed array back to aura
        component.set("v.Performances", performances);        
    },
    
    markAllAsStandardPerformances: function(component, event, helper){
        var performances = component.get("v.Performances");
        var allRows = component.find("scrollableTable").getElement().childNodes;
        for(var i=0; i < allRows.length; i++){
            $A.util.removeClass(allRows[i],"selectedRow");
            performances[i].Sample__c = false;
        }
        // set the changed array back to aura
        component.set("v.Performances", performances);
    },
    
/* Bug fix EFLOW-153  
 * performanceSearch: function(performanceDate, performanceTime, performances, lastWeekEvtCode){
        
        for(var j=0;j<performances.length;j++){
            if(performances[j].Date__c == performanceDate && performances[j].Time__c == performanceTime){ 			
                return performances[j];
            }else{
                // Add what to do if a similar performance does not exist from the previous week
                if(lastWeekEvtCode != undefined){
                    //if last weeks performance is already linked just check if the link is there
                    if(lastWeekEvtCode == performances[j].Event_Code__c){
                        return performances[j];
                    }
                }
            }
        }
    }, */
    
        performanceSearch: function(performanceDate, performanceDay, performances, lastWeekEvtCode, suffix){
        
        for(var j=0;j<performances.length;j++){
            if(performances[j].Date__c == performanceDate && performances[j].Day__c == performanceDay && performances[j].Suffix__c == suffix){ 			
                return performances[j];
            }else{
                // Add what to do if a similar performance does not exist from the previous week
                if(lastWeekEvtCode != undefined){
                    //if last weeks performance is already linked just check if the link is there
                    if(lastWeekEvtCode == performances[j].Event_Code__c){
                        return performances[j];
                    }
                }
            }
        }
    }, 
    
    getWeekNumber : function(d){
        //    var d = new Date(+this);
        d.setHours(0,0,0,0);
        d.setDate(d.getDate()+4-(d.getDay()||7));
        return Math.ceil((((d-new Date(d.getFullYear(),0,1))/8.64e7)+1)/7);
    },
    
    
    incrementDate : function(date) {
        
        //        var date = new Date(tt);
        var newdate = new Date(date);
        
        newdate.setDate(newdate.getDate() + 7);
        
        var dd = newdate.getDate();
        var mm = newdate.getMonth() + 1;
        var y = newdate.getFullYear();
        
        mm = this.pad(mm, 2);
        dd = this.pad(dd, 2);
        
        var someFormattedDate = y + '-' + mm + '-' + dd;
        return someFormattedDate;
    },
    
    
    pad : function(num, size) {
        var s = num+"";
        while (s.length < size) s = "0" + s;
        return s;
    }    
    
    
})