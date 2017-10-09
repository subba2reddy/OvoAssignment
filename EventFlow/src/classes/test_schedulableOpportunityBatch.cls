@isTest
public class test_schedulableOpportunityBatch {
	public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    @isTest static void createData() {
        
        Account a = new Account(Name = 'Test');
        insert a;
        
        List<Opportunity> opps = new List<Opportunity>();
        
        //Scenario 1: No 
        Opportunity o1 = new Opportunity(Name = 'Scenario 1', CloseDate = Date.Today(), RecordTypeId = '012w0000000AgkB', AccountId = a.Id, StageName = 'Prospecting');
        opps.add(o1);
        
        //Scenario 2: 
        Opportunity o2 = new Opportunity(Name = 'Scenario 2', CloseDate = Date.Today(), RecordTypeId = '012w0000000AgkB', AccountId = a.Id, StageName = 'Prospecting');
        opps.add(o2);
        
        //Scenario 3: 
        Opportunity o3 = new Opportunity(Name = 'Scenario 3', CloseDate = Date.Today(), RecordTypeId = '012w0000000AgkB', AccountId = a.Id, StageName = 'Prospecting');
        opps.add(o3);
        
        insert opps;
        
        List<Event_s_Details__c> LCGrossNetList = new List<Event_s_Details__c>();
        Event_s_Details__c ED1 = new Event_s_Details__c(RecordTypeId='01220000000Pj9M', Date__c='Jan ' + String.valueOf(Date.today().year()), Opportunity__c=o1.Id, Net_LC__c=100, Gross_LC__c=100);
        Event_s_Details__c ED2 = new Event_s_Details__c(RecordTypeId='01220000000Pj9M', Date__c='Feb ' + String.valueOf(Date.today().year()), Opportunity__c=o2.Id, Net_LC__c=100, Gross_LC__c=100);
        //LC_Gross_Net_Details record with date in next year
        Event_s_Details__c ED3 = new Event_s_Details__c(RecordTypeId='01220000000Pj9M', Date__c='Jan ' + String.valueOf(Date.today().year()+1), Opportunity__c=o3.Id, Net_LC__c=100, Gross_LC__c=100);
        LCGrossNetList.add(ED1);
        LCGrossNetList.add(ED2);
        LCGrossNetList.add(ED3);
        insert LCGrossNetList;

    }
    
    @isTest static void runTest() {
        
        createData();
        
        Test.startTest();
        
        // Schedule the test job
        String jobId = System.schedule('OpportunityBatchTest', CRON_EXP, new schedulableOpportunityBatch());

        // Get the information from the CronTrigger API object
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];

        // Verify the expressions are the same
        System.assertEquals(CRON_EXP, ct.CronExpression);

        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered);

        // Verify the next time the job will run
        System.assertEquals('2022-03-15 00:00:00', String.valueOf(ct.NextFireTime));

        Test.stopTest();
        //The scheduled job should run immediately after stopTest()
 
    }
}