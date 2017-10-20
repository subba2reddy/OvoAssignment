global  class ourFriendsExistingContactUpdateBatch implements Database.Batchable<Sobject>{
    
    global  Database.QueryLocator start (Database.BatchableContext con){
        Contact_Batch_ID__c contactBatch =  Contact_Batch_ID__c.getValues('ContactBatch');
        
        String batchId = contactBatch.Contact_Batch_ID__c;
        String queryName='SELECT loyalty_status__c FROM Contact where Creation_Batch_ID__c != :batchId';
        Delete contactBatch;
        return Database.getQueryLocator(queryName);
        
    }
    
    global  void execute(Database.BatchableContext con, List<Contact> scope){
        for(Contact conObj:scope){
            conObj.loyalty_status__c= 'Standard';
            System.debug('Name - ' + conObj.FirstName);
        }
        update scope;
    }
    
    global  void finish(Database.BatchableContext con){
        
    }
}