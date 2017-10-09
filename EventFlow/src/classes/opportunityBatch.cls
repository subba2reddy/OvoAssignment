//Updates Marketing Partnerships Opportunity Total fields (Current Year, Next Year, Total USD) in bulk
public class opportunityBatch implements Database.Batchable<sObject> {
    public List<Opportunity> oppsToUpdate;
    public Integer successes;
    public Integer failures;
    public Integer currentYear;
    public opportunityBatch() {
        oppsToUpdate = new List<Opportunity>();
    	successes = 0;
    	failures = 0;
        currentYear = DateTime.now().year();
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id
                                         FROM Opportunity
                                         WHERE RecordTypeId = '012w0000000Agk6' OR RecordTypeId = '012w0000000AgkB']);
    }
    
    public void execute(Database.BatchableContext BC, List<Opportunity> scope) {
        
        Set<Id> oppIds = new Set<Id>();
        
        for(Opportunity o : scope) {
            oppIds.add(o.Id);
        }
        
        List<Opportunity> oppsFullDetails = new List<Opportunity>([SELECT Id, Current_Year_USD_Gross__c, Current_Year_USD_Net__c, Current_Year_LC_Gross__c, Current_Year_LC_Net__c,
                                                                     Next_Year_USD_Gross__c, Next_Year_USD_Net__c, Next_Year_LC_Gross__c, Next_Year_LC_Net__c,
                                                                     Total_USD_Gross__c, Total_USD_Net__c,
                                                                     (SELECT Id, Net_LC__c, Gross_LC__c, Gross_USD_formula__c, Net_USD_formula__c, Date__c FROM LC_Gross_and_Net_Details__r)
                                                                  FROM Opportunity WHERE Id IN :oppIds]);
        
        for(Opportunity o : oppsFullDetails) {
            
            //Initialise variables to store totals
            double CurrentYearGrossLC = 0;
            double CurrentYearGrossUSD = 0;
            double CurrentYearNetLC = 0;
            double CurrentYearNetUSD = 0;
            double NextYearGrossLC = 0;
            double NextYearGrossUSD = 0;
            double NextYearNetLC = 0;
            double NextYearNetUSD = 0;
            double TotalGrossUSD = 0;
            double TotalNetUSD = 0;
            
            //Get the LC Gross Net Details records
            List<Event_s_Details__c> lcRecs = new List<Event_s_Details__c>();
            if(o.LC_Gross_and_Net_Details__r.size() > 0) {
                lcRecs = o.LC_Gross_and_Net_Details__r;
            }
            
            if(lcRecs.size() > 0) {
                //Flag to indicate whether the Opp neeeds to be updated
                Boolean updateOpp = false;
                
                for(Event_s_Details__c ED : lcRecs) {
                    if (ED.Gross_LC__c != null) {
                        TotalGrossUSD += ED.Gross_USD_formula__c;
                        if (Integer.valueOf(ED.Date__c.right(4)) == currentYear) {
                            CurrentYearGrossLC += ED.Gross_LC__c;
                            CurrentYearGrossUSD += ED.Gross_USD_formula__c;
                        }
                        else if (Integer.valueOf(ED.Date__c.right(4)) == currentYear + 1) {
                            NextYearGrossLC += ED.Gross_LC__c;
                            NextYearGrossUSD += ED.Gross_USD_formula__c;
                        }
                    }
                    if (ED.Net_LC__c != null) {
                        TotalNetUSD += ED.Net_USD_formula__c;
                        if (Integer.valueOf(ED.Date__c.right(4)) == currentYear) {                       
                            CurrentYearNetLC += ED.Net_LC__c;
                            CurrentYearNetUSD += ED.Net_USD_formula__c;
                        }
                        else if (Integer.valueOf(ED.Date__c.right(4)) == currentYear + 1) {
                            NextYearNetLC += ED.Net_LC__c;
                            NextYearNetUSD += ED.Net_USD_formula__c;
                        }
                    }
                }
                if(o.Current_Year_USD_Gross__c != CurrentYearGrossUSD) {
                    o.Current_Year_USD_Gross__c = CurrentYearGrossUSD;
                    updateOpp = true;
                }
                if(o.Current_Year_USD_Net__c != CurrentYearNetUSD) {
                    o.Current_Year_USD_Net__c = CurrentYearNetUSD;
                    updateOpp = true;
                }
                if(o.Current_Year_LC_Gross__c != CurrentYearGrossLC) {
                    o.Current_Year_LC_Gross__c = CurrentYearGrossLC;
                    updateOpp = true;
                }
                if(o.Current_Year_LC_Net__c != CurrentYearNetLC) {
                    o.Current_Year_LC_Net__c = CurrentYearNetLC;
                    updateOpp = true;
                }
                if(o.Next_Year_USD_Gross__c != NextYearGrossUSD) {
                    o.Next_Year_USD_Gross__c = NextYearGrossUSD;
                    updateOpp = true;
                }
                if(o.Next_Year_USD_Net__c != NextYearNetUSD) {
                    o.Next_Year_USD_Net__c = NextYearNetUSD;
                    updateOpp = true;
                }
                if(o.Next_Year_LC_Gross__c != NextYearGrossLC) {
                    o.Next_Year_LC_Gross__c = NextYearGrossLC;
                    updateOpp = true;
                }
                if(o.Next_Year_LC_Net__c != NextYearNetLC) {
                    o.Next_Year_LC_Net__c = NextYearNetLC;
                    updateOpp = true;
                }
                if(o.Total_USD_Gross__c != TotalGrossUSD) {
                    o.Total_USD_Gross__c = TotalGrossUSD;
                    updateOpp = true;
                }
                if(o.Total_USD_Net__c != TotalNetUSD) {
                    o.Total_USD_Net__c = TotalNetUSD;
                    updateOpp = true;
                }
                
                //Finally, only add the Opportunity to the list to be updated if a change has been made
                if(updateOpp == true) {
                    oppsToUpdate.add(o);
                }
            }
        }
        
        if(oppsToUpdate.size() > 0){
            List<Database.SaveResult> results = Database.Update(oppsToUpdate, false);
            for(Database.SaveResult r : results) {
                if(r.IsSuccess()) {
                    System.debug('Successfully updated Opportunity ' + r.getId() + ' with opportunityBatch class');
                    successes++;
                }
                else {
                    for(Database.Error err : r.getErrors()) {
                        System.debug('Following error occurred while updating an Oppportunity with opportunityBatch class: ' + err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Opportunity fields that affected this error: ' + err.getFields());
                    }
                    failures++;
                }
            }
        }
        System.debug('Found ' + oppsToUpdate.size() + ' Opportunities to update in this batch.');
        System.debug('Of those, there were ' + successes + ' successes and ' + failures + ' failures.');
    }
    
    public void finish(Database.BatchableContext BC) {
    }
}