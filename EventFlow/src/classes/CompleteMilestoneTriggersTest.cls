@isTest(SeeAllData=true)
private class CompleteMilestoneTriggersTest {
    @isTest static void TestCompleteResolutionTimeMilestone() {
        Entitlement entl = [select id from Entitlement limit 1];
        String entlId;
        if (entl != null)
            entlId = entl.Id;
        
        Account a = new Account(Name='TestAccount');
        insert a;
        
        Contact co = new Contact(LastName='TestContact',AccountId=a.id);
        insert co;
        
        Case c = new Case(EntitlementId = entlId,AccountId=a.Id,ContactId=co.id,First_Assigned_PS__c=System.now(),Type='Incident',Priority='Critical');
        insert c;
        
        c.Status='Resolved';
        update c;
    }
    
    @isTest static void TestCompleteFirstResponseMilestone() {
        Entitlement entl = [select id from Entitlement limit 1];
        String entlId;
        if (entl != null)
            entlId = entl.Id;
        
        Account a = new Account(Name='TestAccount');
        insert a;
        
        Contact co = new Contact(LastName='TestContact',AccountId=a.id);
        insert co;
        
        Case c = new Case(EntitlementId = entlId,AccountId=a.Id,ContactId=co.id,First_Assigned_PS__c=System.now(),Type='Incident',Priority='Critical');
        insert c;
        
        c.Date_Time_First_Response__c=System.now();
        update c;
    }

}