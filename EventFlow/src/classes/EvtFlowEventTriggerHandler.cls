public class EvtFlowEventTriggerHandler {
	
    public static void afterUpdate(Map<ID, Event__c> newData, Map<ID, Event__c> oldData){
        Event__c oldEvent, newEvent, evtWithRelData;
        List<Master_charts__c> masterCharts;
        List<Master_Charts__c> mcToUpdate = new List<Master_Charts__c>();
        String txtLine1 = '';
        Integer ticketLimit;
        Boolean blnGrpSales = false, blnEvtName = false, blnTicketLimit = false, blnInvoicer = false, blnVenueName = false;
        
        Try{
            masterCharts = [select id, event__c, TXT_Line_1__c, TXT_Line_2__c, TXT_Line_4__c, EXTCOM_Line_1__c, EXTCOM_Line_5__c 
                            												from Master_charts__c where event__c in:newData.keySet()];
        	
            Map<Id, Event__c> mapWithRelData = New Map<id, event__c>([select id, Venue__r.Name, Invoicer__r.name, Venue__r.Semetra_Venue_Type__c 
                                                              							from event__c where id in: newData.keySet()]);
            
            for(ID curId:newData.keySet()){
                newEvent = newData.get(curId);
                oldEvent = oldData.get(curId);
                evtWithRelData = mapWithRelData.get(curId);
                
                //check if group sales allowed is changed
                if(newEvent.Groups_Allowed__c != oldEvent.Groups_Allowed__c){
                    blnGrpSales = true;
                }
                //check if event name is changed
                if(newEvent.Name != oldEvent.Name){
                    blnEvtName = true;
                }

                //check if ticket limit has changed
                if(newEvent.Ticket_Limit__c != oldEvent.Ticket_Limit__c || newEvent.PCI_Information__c != oldEvent.PCI_Information__c){
					blnTicketLimit = true;
                }

                //check if invoicer has changed
				//invoicer related changes - subba			
                if(newEvent.Invoicer__c != oldEvent.Invoicer__c){
					blnInvoicer = true;
                }
				
                //check if venue has changed
                if(newEvent.Venue__c != oldEvent.Venue__c){
					blnVenueName = true;
                }

                if(blnGrpSales || blnEvtName || blnTicketLimit || blnInvoicer || blnVenueName){

                    for(Master_Charts__c curMasterChart: masterCharts){

                        if(curMasterChart.event__c == curId){

							//if group sales allowed was changed
                            if(blnGrpSales){
                                curMasterChart.EXTCOM_Line_5__c = newEvent.Groups_Allowed__c;
                            }

                            //if event name was changed
                            if(blnEvtName){
                                curMasterChart.TXT_Line_2__c = newEvent.Name.toUpperCase();
                            }

                            //if invoicer was changed
                            // invoicer related changes - subba
                            if(blnInvoicer){
                                if(evtWithRelData.Invoicer__r.name != null){
                                    curMasterChart.TXT_Line_1__c = evtWithRelData.Invoicer__r.name.toUpperCase() + ' PRESENTS';
                                }
                                else{
                                    curMasterChart.TXT_Line_1__c = '';
                                }                               
                            }

                            //if PCI or Ticket Limit or Venue Changed
                            if(blnTicketLimit || blnVenueName){
                                if(evtWithRelData.Venue__r.Semetra_Venue_Type__c != null){
                                    txtLine1 = evtWithRelData.Venue__r.Semetra_Venue_Type__c.toUpperCase();
                                }
                                else{
                                    txtLine1 = '';
                                }                                

                                if(newEvent.PCI_Information__c != null){
                                    if(newEvent.PCI_Information__c.contains('HARD TIX')){
                                        txtLine1 = txtLine1 + '/HARD TICKETS';
                                    } 
                                }

                                if(newEvent.Ticket_Limit__c != null ){
                                    ticketLimit = newEvent.Ticket_Limit__c.intValue();
                                    if(ticketLimit != 0){
                                        txtLine1 = txtLine1 + '/TLIMIT=' + String.valueOf(ticketLimit);
                                    }                        
                                }

                                curMasterChart.EXTCOM_Line_1__c = txtLine1;

                                //if venue was changed then update line 
                                if(blnVenueName){
                                    if(evtWithRelData.Venue__r.Name != null){
                                    	curMasterChart.TXT_Line_4__c = evtWithRelData.Venue__r.Name.toUpperCase();
                                    }
                                }
                            }
                            //add the master chart for saving it later
                        	mcToUpdate.add(curMasterChart);
                        }
                    }
                }
            }
            //update all changed master charts
            Database.update(mcToUpdate, false);
        }
        Catch(Exception ex){
            System.debug('Error - ' + ex.getMessage());
        }
    }
    
    
    //called from after update of EvtFlowPricesTrigger
    public static void pricesAfterUpdate(Map<ID, Price__c> newData, Map<ID, Price__c> oldData){
        Price__c newPrice, oldPrice, priceWithEvtData;
        Event__c curEvent;
        Set<ID> evtIds = new Set<ID>();
        Set<ID> processedEvts = new Set<ID>();
        List<Master_Charts__c> mcToUpdate = new List<Master_Charts__c>();
        List<Price__c> prices;
        
        Try{
            //get all event ids
            Map<Id, Price__c> priceWithEvents = New Map<Id, Price__c>([select id, event__c from Price__c where id in:newData.keySet()]);

            //make a list of all event ids to retrieve all master charts that needs to be checked
            for(Price__c curPrice:priceWithEvents.values()){
                evtIds.add(curPrice.event__c);
            }

            //work through events associated rather than the prices
            //else the prices on which data was not changed will not be processed
            Map<Id, Event__c> eventWithPrices = New Map<Id, Event__C>([select id, (select Sales_Channel__c from Prices__r) from event__c where id in:evtIds]);
            //get all master charts with the event ids
            List<Master_Charts__c> allMasterCharts = [select id, event__c, EXTCOM_Line_2__c from Master_Charts__c where event__c in:evtIds];

            //loop through all changed price data
            for(ID curId:newData.keySet()){
                newPrice = newData.get(curId);
                oldPrice = oldData.get(curId);
                priceWithEvtData = priceWithEvents.get(curId);

                //consider looking further only if sales channel was changed
                if(newPrice.Sales_Channel__c != oldPrice.Sales_Channel__c){
                    for(Master_Charts__c curMC:allMasterCharts){
                        if(curMC.Event__c == priceWithEvtData.Event__c && !processedEvts.contains(priceWithEvtData.Event__c)){
                            processedEvts.add(priceWithEvtData.Event__c);
                            curEvent = eventWithPrices.get(priceWithEvtData.Event__c);
                            prices = curEvent.Prices__r;
                            //get the concantenated sales channel from the utility
                            curMC.EXTCOM_Line_2__c = EvtFlowPerfTrgUtil.getSalesChannels(prices);
                            mcToUpdate.add(curMC);
                        }
                    }
                }
            }
            //update all changed master charts
            Database.update(mcToUpdate, false);            
        }
        Catch(Exception ex){
            System.Debug('Error - ' + ex.getMessage());
        }
    }
    
    
    //called from after insert of EvtFlowPricesTrigger
    public static void pricesAfterInsert(List<Price__c> newData){
        Price__c newPrice, oldPrice;
        Set<ID> evtIds = new Set<ID>();
        Set<ID> processedEvts = new Set<ID>();
        List<Master_Charts__c> mcToUpdate = new List<Master_Charts__c>();
        List<Price__c> prices;
        
        Try{
            //get all event ids
            List<Price__c> priceWithEvents = [select id, event__c from Price__c where id in:newData];

            //make a list of all event ids to retrieve all master charts that needs to be checked
            for(Price__c curPrice:priceWithEvents){
                evtIds.add(curPrice.event__c);
            }
            //work through events associated rather than the prices
            //else the prices on which data was not changed will not be processed
            List<Event__c> eventWithPrices = [select id, (select Sales_Channel__c from Prices__r) from event__c where id in:evtIds];

            //get all master charts with the event ids
            List<Master_Charts__c> allMasterCharts = [select id, event__c, EXTCOM_Line_2__c from Master_Charts__c where event__c in:evtIds];

            //loop through all changed price data
            for(Event__c curEvent:eventWithPrices){
                //consider looking further only if sales channel was changed
                for(Master_Charts__c curMC:allMasterCharts){
                    if(curMC.Event__c == curEvent.id){
                        prices = curEvent.Prices__r;
                        //get the concantenated sales channel from the utility
                        curMC.EXTCOM_Line_2__c = EvtFlowPerfTrgUtil.getSalesChannels(prices);
                        mcToUpdate.add(curMC);
                    }
                }
            }
            //update all changed master charts
            Database.update(mcToUpdate, false);            
        }
        Catch(Exception ex){
            System.Debug('Error - ' + ex.getMessage());
        }
    }

}