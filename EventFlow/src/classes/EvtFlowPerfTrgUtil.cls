public class EvtFlowPerfTrgUtil {

    //handle event of new performance creation
    public static void afterInsert(List<Performance__c> newData){
        Try{
            //get the list of master charts to be inserted
            List<Master_Charts__c> insertList = getToBeInsertedMasterCharts(newData);

            //insert all master charts to be inserted - bulkified
            if(insertList.size() > 0){
                insert insertList;    
            }            
        }
        catch(exception ex){
            System.debug('Error - ' + ex.getMessage());
        }
    }
    
    
    //handle the event of performances being deleted
    public static void afterDelete(List<Performance__c> oldData){
        Try{
            //get the list of master charts to be deleted
            List<Master_Charts__c> deleteList = getToBeDeletedMasterCharts(oldData);
            
            //now delete the master charts - bulkified
            if(deleteList.size() > 0){
                delete deleteList;    
            }            
        }
        catch(exception ex){
            System.debug('Error - ' + ex.getMessage());
        }
    }
    
    
    //handle event of performances being updated
    public static void afterUpdate(Map<ID, Performance__c> newDataMap, Map<ID,Performance__c> oldDataMap){
        try{
            List<ID> changedPerf = new List<ID>();
            Boolean firstObject = true;
            ID eventID;
            
            //collect all performances with changed masterchart
            For(id curId:newDataMap.keyset()){
                Performance__c newObject = newDataMap.get(curId);
                Performance__c oldObject = oldDataMap.get(curId);
                
                //get the event id
                if(firstObject){
                    eventID = oldObject.Event__c;
                    firstObject = false;                
                }
                
                //if the master chart value has changed then update it
                if(newObject.Master_Chart__c != oldObject.Master_Chart__c){
					System.debug('Old MC - ' + oldObject.Master_Chart__c + ', New MC - ' + newObject.Master_Chart__c);
                    changedPerf.add(curId);
                }
            }
            
            //Two conditions - 1. the old master chart value is not there anymore in any performance hence needs deleting
            //2. the new master chart value is not currently present and needs inserting
            //Deal with the performances only if there was a master chart changed
            if(changedPerf.size() > 0){
                //work to get list to be inserted
                List<Performance__c> newData = new List<Performance__c>();
                List<Performance__c> oldData = new List<Performance__c>();
                
                for(Id curPerfId:changedPerf){
                    newData.add(newDataMap.get(curPerfId));
                    oldData.add(oldDataMap.get(curPerfId));
                }
                
                System.debug('Before Calling Insert on update - ' + newData);
                List<Master_Charts__c> insertList = getToBeInsertedMasterCharts(newData);
                System.debug('Before Calling Delete on update - ' + oldData);
                List<Master_Charts__c> deleteList = getToBeDeletedMasterCharts(oldData);
    
                if(insertList.size() > 0){
                    //insert the master charts if there is any
                	System.Debug('Insert List Size - ' + insertList.size());
                    insert insertList;
                }
                
                if(deleteList.size() > 0){
                    //delete the master charts if we need to
                	System.Debug('Delete List Size - ' + deleteList.size());
                    delete deleteList;
                }
            }            
        }
        catch(exception ex){
            System.debug('Error - ' + ex.getCause());
        }
    }
    
    
    //re-usable method to find the list of master charts to be inserted
    private static List<Master_Charts__c> getToBeInsertedMasterCharts(List<Performance__c> newPerf){
        List<Master_Charts__c> toBeInsertedMCs = new List<Master_Charts__c>();
        
        try{
            Set<string> newMasterCharts = new Set<string>();
            List<Price__c> prices = new List<Price__c>();
            Master_Charts__c objMasterChart;
            Boolean firstObject = true;
            String evtName, sponsorName, venueName, grpSalesAllowed, txtLine1, pciInfo, delOption, camUser, slsCh = '';
            Decimal decTktLimit;
            Integer ticketLimit;
            ID eventID;
            
            //get all master charts from new performances
            for(Performance__c curPerf:newPerf){
                //get all event related data
                if(firstObject){
                    //will be executed only once
                    eventID = curPerf.Event__c;
                    Event__c curEvent = [select name, Venue__r.name, Groups_Allowed__c, Venue__r.Semetra_Venue_Type__c,	Invoicer__r.name, 
                                        	PCI_Information__c, Ticket_Limit__c, createdby.name,
                                         			(select Sales_Channel__c from Prices__r) from Event__c where id=:eventID];

                    evtName = (curEvent.name !=null ? curEvent.name.toUpperCase() : '');
                    
	                //   commented out because of invoicer changes
  					if(curEvent.Invoicer__r.name != null){
                        sponsorName = curEvent.Invoicer__r.name.toUpperCase() + ' PRESENTS';
                    }
                    else{
                        sponsorName = '';
                    } 
                    
                    if(curEvent.Venue__r.name != null){
                        venueName = curEvent.Venue__r.name.toUpperCase();
                    }
                    else{
                        venueName = '';
                    }
                    
                    if(curEvent.Venue__r.Semetra_Venue_Type__c != null){
                        txtLine1 = curEvent.Venue__r.Semetra_Venue_Type__c.toUpperCase();
                    }
                    else{
                        txtLine1 = '';
                    }
                    
                    grpSalesAllowed = curEvent.Groups_Allowed__c;
                    pciInfo = curEvent.PCI_Information__c;
                    decTktLimit = curEvent.Ticket_Limit__c;
                    delOption = ''; //needs to changed
                    prices = curEvent.Prices__r;
                    slsCh = getSalesChannels(prices);
                    camUser = 'ACCOUNT MANAGER: ' + curEvent.createdby.name.toUpperCase();
                    
                    if(pciInfo != null){
                        if(pciInfo.contains('HARD TIX')){
                            txtLine1 = txtLine1 + '/HARD TICKETS';
                        } 
                    }
                    
                    if(decTktLimit != null ){
                        ticketLimit = decTktLimit.intValue();
                        if(ticketLimit != 0){
                            txtLine1 = txtLine1 + '/TLIMIT=' + String.valueOf(ticketLimit);
                        }                        
                    }
                    firstObject = false;
                }
                
                if(curPerf.Master_Chart__c != '' || curPerf.Master_Chart__c != null){
                    newMasterCharts.add(curPerf.Master_Chart__c);
                }
            }
            
            //get existing master charts with the name
            List<Master_Charts__c> evtMasterCharts = [select id, name from Master_Charts__c where event__c =:eventID and name in:newMasterCharts];
            
            //loop through and find out which ones are already existing
            for(Master_Charts__c curMasterChart:evtMasterCharts){
                if(newMasterCharts.contains(curMasterChart.Name)){
                    //remove the ones already existing
                    newMasterCharts.remove(curMasterChart.Name);
               }
            }
            
            //loop through which is not already existing and prepare list to be inserted
            for(String tmpMasterChart: newMasterCharts){
                objMasterChart = new Master_Charts__c();
                objMasterChart.Name = tmpMasterChart;
                objMasterChart.Event__c = eventID;
                objMasterChart.TXT_Line_1__c = sponsorName;
                objMasterChart.TXT_Line_2__c = evtName;
                objMasterChart.TXT_Line_3__c = '';
                objMasterChart.TXT_Line_4__c = venueName;
                objMasterChart.TXT_Line_5__c = '';
                objMasterChart.EXTCOM_Line_1__c = txtLine1; //need confirmation on hard ticket logic
                objMasterChart.EXTCOM_Line_2__c = slsCh; //Need confirmation on Outlets abbr
                objMasterChart.EXTCOM_Line_3__c = '';
                objMasterChart.EXTCOM_Line_4__c = delOption; //need confirmation
                objMasterChart.EXTCOM_Line_5__c = grpSalesAllowed;
                objMasterChart.EXTCOM_Line_6__c = '';
                objMasterChart.EXTCOM_Line_7__c = '';
                objMasterChart.EXTCOM_Line_8__c = camUser; // CAM Location Pending
                objMasterChart.EXTCOM_Line_9__c = '';
                toBeInsertedMCs.add(objMasterChart);
                System.debug(objMasterChart);
            }
            return toBeInsertedMCs;            
        }
        catch(exception ex){
            System.debug('Error - ' + ex.getMessage() + ', Line - ' + ex.getLineNumber());
            toBeInsertedMCs.clear();
            return toBeInsertedMCs;
        }
    }
    
    
    //re-usable method to find the list of master charts to be inserted
    private static List<Master_Charts__c> getToBeDeletedMasterCharts(List<Performance__c> oldPerf){
        List<Master_Charts__c> toBeDeletedMCs = new List<Master_Charts__c>();
        try{
            Set<string> oldMasterCharts = new Set<string>();
            Master_Charts__c objMasterChart;
            Boolean firstObject = true;
            ID eventID;
    
            //get all master charts from the old performances
            for(Performance__c curPerf:oldPerf){
                //get all event related data
                if(firstObject){
                    eventID = curPerf.Event__c;
                    firstObject = false;
                }
                if(curPerf.Master_Chart__c != '' || curPerf.Master_Chart__c != null){
                    oldMasterCharts.add(curPerf.Master_Chart__c);
                }
            }
    
            //check if any performances with the same name are existing
            List<Performance__c> evtPerformances = [select id, master_chart__c from Performance__c where event__c =:eventID and master_chart__c in:oldMasterCharts];
                            
            //loop through performances to find out if there are any existing performance with the master chart
            for(Performance__c curPerformance:evtPerformances){
                if(oldMasterCharts.contains(curPerformance.Master_Chart__c)){
                    //remove the ones still existing
                    oldMasterCharts.remove(curPerformance.Master_Chart__c);
               }
            }
            
            //get the list of mastercharts to be deleted
            toBeDeletedMCs = [select id, name from Master_Charts__c where event__c =:eventID and name in:oldMasterCharts];
            return toBeDeletedMCs;            
        }
        catch(exception ex){
            System.debug('Error - ' + ex.getMessage());
            toBeDeletedMCs.clear();
            return toBeDeletedMCs;            
        }
    }
    
    
    //calculates and returns the sales channels
    public static string getSalesChannels(List<Price__c> prices){
        String slsCh = 'ON SALE: ';
        try{
            // calculate sales channel for EXT Comm Line 2 
            for(Price__c curPrice:prices){
                if(curPrice.Sales_Channel__c != null || curPrice.Sales_Channel__c != ''){
                    string strChannels = curPrice.Sales_Channel__c;
                    List<String> curChannels = strChannels.split(';');
                    //loop through the sales channel and get the list
                    for(String strChnnl:curChannels){
                        if(strChnnl == 'IVR' || strChnnl == 'NOTAP'){
                            if(!slsCh.contains(strChnnl)){
                                if(slsCh == 'ON SALE: '){
                                    slsCh = strChnnl.toUpperCase();
                                }
                                else{
                                    slsCh = slsCh + '/' + strChnnl.toUpperCase();
                                }
                            }
                        }
                        else if(strChnnl == 'Online'){
                            if(!slsCh.contains('TMON')){
                                if(slsCh == 'ON SALE: '){
                                    slsCh = 'TMON';
                                }
                                else{
                                    slsCh = slsCh + '/' + 'TMON';
                                }
                            }                                
                        }
                        else if(strChnnl == 'Primary Box Office'){
                            if(!slsCh.contains('PBO')){
                                if(slsCh == 'ON SALE: '){
                                    slsCh = 'PBO';
                                }
                                else{
                                    slsCh = slsCh + '/' + 'PBO';
                                }
                            }                                   
                        }
                        else if(strChnnl == 'Secondary Box Office'){
                            if(!slsCh.contains('SBO')){
                                if(slsCh == 'ON SALE: '){
                                    slsCh = 'SBO';
                                }
                                else{
                                    slsCh = slsCh + '/' + 'SBO';
                                }
                            }                                   
                        }                               
                        else if(strChnnl == 'Phone'){
                            if(!slsCh.contains('PH')){
                                if(slsCh == 'ON SALE: '){
                                    slsCh = 'PH';
                                }
                                else{
                                    slsCh = slsCh + '/' + 'PH';
                                }
                            }                                 
                        }
                    }
                }
            }
			
			return slsCh;
        }
        catch(exception ex){
            System.debug('Error - ' + ex.getMessage());
            return '';
        }
    }
    
}