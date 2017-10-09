global class oppAutoRenewBatch implements 
             Database.Batchable<SObject>, Database.Stateful{
	
	Double failedInserts{get; set;}

    global oppAutoRenewBatch(){
        failedInserts = 0;
    }
    
    global Database.queryLocator 
                    start(Database.BatchableContext ctx){
        return Database.getQueryLocator([SELECT id, Type, StageName, Retail_Tickets__c, RecordTypeId, Primary_Genre__c, Platform__c, OwnerId, Name, Exclusive__c, Event_Only_Contract_NEW__c, Estimated_Share_of_Tickets__c, Contract_Type__c, Contract_Signed__c, ContractStartDate__c, ContractEndDate__c, CloseDate, Client_Type__c, Box_Office_Tickets__c, Auto_renewal__c, Avg_Annual_Tickets_Retail__c, Avg_Annual_Tickets_Box_Office__c, AccountId 
        									FROM Opportunity 
        									WHERE (RecordTypeId = '01220000000A1r2' OR RecordTypeId = '01220000000PjFU') AND contractenddate__c = TODAY AND  Auto_renewal__c = 'Yes' AND Contract_Type__c <> 'Fixed term one-time contract' AND Client_Type__c <> 'One-time Client']);
    }
    
    global void execute(Database.BatchableContext ctx, List<Sobject>
                        scope){
        List<Opportunity> opps = (List<Opportunity>)scope;
        
        for(Integer i = 0; i < opps.size(); i++){
            opps[i].CloseDate = system.today();
            opps[i].Preceding_Opportunity__c = opps[i].id;
            opps[i].Existing_Contract_Expiration_Date__c = opps[i].ContractEndDate__c;
            opps[i].Type = 'Renewal of Existing Business';
            opps[i].Name = opps[i].Name + ' - Auto Renewal';
            opps[i].ContractStartDate__c = opps[i].ContractEndDate__c + 1;
            opps[i].ContractEndDate__c = opps[i].ContractEndDate__c + 365;
            opps[i].Created_by_Auto_renewal__c = true;
            opps[i].Retail_Tickets__c = opps[i].Avg_Annual_Tickets_Retail__c;
            opps[i].Box_Office_Tickets__c = opps[i].Avg_Annual_Tickets_Box_Office__c;
        }
        List<Opportunity> oppsClone = (List<Opportunity>)opps.deepclone();  // because if we deepclone scope we lose opp id!
        
        List<Database.SaveResult> dsrs = Database.insert(oppsClone, false);
        for(Database.SaveResult dsr : dsrs){
            if(!dsr.isSuccess()){
                failedInserts++;
            }
            
        } 
    }
    
    global void finish(Database.BatchableContext ctx){
    
        AsyncApexJob a = [SELECT id, ApexClassId, 
                       JobItemsProcessed, TotalJobItems, 
                       NumberOfErrors, CreatedBy.Email 
                       FROM AsyncApexJob 
                       WHERE id = :ctx.getJobId()];
        
        String emailMessage = 'Your batch job '
             + 'oppAutoRenewBatch '
             + 'has finished.  It executed ' 
             + a.totalJobItems 
             + ' batches.  Of which, ' + a.jobitemsprocessed 
             + ' processed without any exceptions thrown and ' 
             + a.numberOfErrors +
             ' batches threw unhandled exceptions.'
             + '  Of the batches that executed without error, ' 
             + failedInserts 
             + ' records were not inserted successfully.';
        
        Messaging.SingleEmailMessage mail = 
              new Messaging.SingleEmailMessage();
        //String[] toAddresses = new String[] {a.createdBy.email};
        String[] toAddresses = new String[] {'james.patterson@livenation.co.uk'};
        mail.setToAddresses(toAddresses);
        mail.setReplyTo('noreply@salesforce.com');
        mail.setSenderDisplayName('Batch Job Summary');
        mail.setSubject('Batch job completed');
        mail.setPlainTextBody(emailMessage);
        mail.setHtmlBody(emailMessage);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] 
                           { mail });
    }

}