public with sharing class PerformanceListController {
    
    // Get a list of performances for a given event
    @auraEnabled
    public static List<Performance__c> getPerformances(Id eventId){
        return [Select Id, Event_code__c, Link_Next__c, Link_Prev__c, Link_Prev_Week__c, Performance__c, Day__c, Date_Time__c, Suffix__c,  Master_Chart__c, Sample__c
                from Performance__c where Event__c = :eventId];
        // Add error handling in case there are no events
    }
    
    @auraEnabled
    public static List<Event__c> getEventDetails(Id EventId){
        return [Select Name, Performance_Start_Date__c, Performance_End_Date__c,  Event_Code_Prefix__c from Event__c where id = :EventId LIMIT 1];
    }
    
/*    @AuraEnabled
    public static List<String> getDayspickval() {
        List<String> options = new List<String>();

        Schema.DescribeFieldResult fieldResult = Performance__c.Day__c.getDescribe();

        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();

        for (Schema.PicklistEntry f: ple) {
            options.add(f.getLabel());
        }       
        return options;
    } 
    
    @AuraEnabled
    public static List<String> getPerformancepickval() {
        List<String> options = new List<String>();

        Schema.DescribeFieldResult fieldResult = Performance__c.Performance__c.getDescribe();

        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();

        for (Schema.PicklistEntry f: ple) {
            options.add(f.getLabel());
        }       
        return options;
    } */
    
    @auraEnabled
    public static void savePerformances(String performanceList, String deletedPerfs, String evtDates){
		/*Id eventId = performances[0].Event__c;
        System.debug('Updated performances');
        for(Performance__c p: performances){
            System.debug(p);
        }
		
        List<Performance__c> savedPerformances = [Select Id, Event_code__c, Link_Next__c, Link_Prev__c, Link_Prev_Week__c, Performance__c, Day__c, Date_Time__c, Suffix__c,  Master_Chart__c, Sample__c from Performance__c where Event__c = :eventId];
        System.debug('saved performances');
        for(Performance__c p: savedPerformances){
            System.debug(p);
        }
        
        for(Performance__c p: performances){
            if(p.Id != null){
                
            }else{
                insert p;
            }
        }*/
        try
        {
            List<Performance__c> performances = (List<Performance__c>)System.JSON.deserialize(performanceList, List<Performance__c>.class);
            List<Performance__c> deletedPerformances = (List<Performance__c>)System.JSON.deserialize(deletedPerfs, List<Performance__c>.class);
            if(evtDates != ''){
                System.debug('events: ' + evtDates);
                List<Event__c> objEvtDates = (List<Event__c>)System.JSON.deserialize(evtDates, List<Event__c>.class);
                update objEvtDates; // update the event with the date
            }
            System.debug('performances: ' + performanceList);
            //save and updated performances
            if(performances.size() > 0){
            	upsert performances;    
            }
            
            //deleted performance
            if(deletedPerformances.size() > 0){
                Delete deletedPerformances;
            }
        }
        catch(Exception e)
        {
            System.debug('error message' + e.getMessage());
            If(e.getMessage().contains('REQUIRED_FIELD_MISSING')){
                throw new AuraHandledException('Mandatory field missing');
            }
            else{
                throw new AuraHandledException('Error while trying to save the Performances');
            }
        }
    }
    
    @auraEnabled
    public static void deleteAllPerformances(String performanceList){
        System.debug('performanceList: ' + performanceList);
        List<Performance__c> performances = (List<Performance__c>)System.JSON.deserialize(performanceList, List<Performance__c>.class);
        try{
        	delete performances;    
        }catch(Exception e){
            System.debug('Error: ' + e);
        }
        
    }
	
}