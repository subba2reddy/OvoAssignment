@isTest
private class oppAutoRenewBatchTest {

    public static testmethod void testOppAutoRenewBatch(){
    // Create the account & opportunity for the test  
    
        Account testAcc = new Account(
        	name = 'test-Account', 
            Type = 'Client',
            recordtypeid = '01220000000A1qs');
        insert testAcc;
        Opportunity testOpp = new Opportunity(
        	name = 'test-Opportunity',
        	accountid = testAcc.id,
            type = 'New Business', 
            recordtypeid = '01220000000A1r2',
            StageName = '6 - Closed - Won',
            primary_genre__c = 'Arts',
            Retail_Tickets__c = 1,
            Box_Office_Tickets__c = 1,
            Estimated_Share_of_Tickets__c = 100,
            contract_signed__c = 'Yes', 
            contract_type__c = 'Fixed term',
            auto_renewal__c = 'Yes',
            exclusive__c = 'Yes',
            event_only_contract_new__c = 'No',
            contractstartdate__c = system.today()-365,
            contractenddate__c = system.today(),
            platform__c = 'Host',
            closedate = system.today()-365);
        insert testOpp;
        
        // Actually start the test  
    
        Test.startTest();
        Database.executeBatch(new oppAutoRenewBatch());
        Test.stopTest();

        // Verify the test worked  
    
        list<opportunity> opps = [SELECT id, name FROM opportunity WHERE accountid = :testAcc.id];
        system.assert(opps.size() == 2);
    }
    
}