trigger UpdateLastJobPONumber on LNITPO__c (after insert) {
    
    LNITPO__c myPO = trigger.new[0];

    string JobID = myPO.Job__c;
    
    if (myPO.Job__c != null && myPO.DataLoader__c == null ) {
        Job__c myJob = [select id, Last_PO_Number__c from Job__c where ID = :JobID];
        
        //myPO.Name = string.valueOf(myJob.Next_PO_Number__c);
        //update myPO;
        myJob.Last_PO_Number__c = myJob.Last_PO_Number__c + 1;
        update myJob;
        
        
    } else {
        // do nothing!
    }
}