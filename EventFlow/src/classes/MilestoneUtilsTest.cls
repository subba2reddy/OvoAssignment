@isTest(SeeAllData=true)
Private class MilestoneUtilsTest {
    
    // this test can be cut down lots?
    
    @isTest static void TestCompleteResolutionTimeMilestone() {
        Entitlement entl = [select id from Entitlement limit 1];
        String entlId;
        if (entl != null)
            entlId = entl.Id;
        
        Account a = new Account(Name='TestAccount');
        insert a;
        
        Contact co = new Contact(LastName='TestContact',AccountId=a.id);
        insert co;
        
        Case c = new Case(EntitlementId = entlId, AccountId=a.Id,ContactId=co.id,First_Assigned_PS__c=System.now(), Type='Incident', Priority='Critical');
        insert c;
        
        c.Status='Resolved';
        update c;
        
        DateTime completionDate = System.now(); 
            List<Id> updateCases = new List<Id>();
        updateCases.add(c.Id);
        
    if (updateCases.isEmpty() == false)
        milestoneUtils.completeMilestone(updateCases, 'First Response', completionDate);
    
}
    
	
    static testMethod void TestCompleteMilestoneCase(){
        
        Account acc = new Account(Name='Test Account');
        insert acc;
        Contact con = new Contact(LastName='Test Contact',AccountId=acc.id, Email='salesforceadmin@livenation.co.uk');
        insert con;
        String contactId;
        String accountId;
        if (con != null && acc != null)
            contactId = con.Id;
        	accountId= acc.Id;
        
        Entitlement entl = [select id from Entitlement limit 1];
        String entlId;
        if (entl != null)
            entlId = entl.Id;
        
        List<Case> cases = new List<Case>{};
        if (entlId != null){
            Case c = new Case(Subject = 'Test Case with Entitlement ', 
                    EntitlementId = entlId, ContactId = contactId, AccountId = accountId);
            cases.add(c);
        }
        if (cases.isEmpty()==false){
            insert cases;
            List<Id> caseIds = new List<Id>();
            for (Case cL : cases){
                caseIds.add(cL.Id);
          }
          milestoneUtils.completeMilestone(caseIds, 'First Response', System.now());
            }
        }
      
    static testMethod void testCompleteMilestoneViaCase(){
            Entitlement entl = [select id from Entitlement limit 1];
            String entlId;
            if (entl != null)
                entlId = entl.Id;
		Account acc = new Account(Name='Test Account');
        insert acc;
        Contact con = new Contact(LastName='Test Contact',AccountId=acc.id, Email='salesforceadmin@livenation.co.uk');
        insert con;
        String contactId;
        String accountId;
        if (con != null && acc != null)
            contactId= con.Id;
        	accountId= acc.Id;
            List<Case> cases = new List<Case>{};
            for(Integer i = 0; i < 1; i++){
                Case c = new Case(Subject = 'Test Case ' + i, ContactId = contactId, AccountId = accountId);
                cases.add(c);
                if (entlId != null){
                    c = new Case(Subject = 'Test Case with Entitlement ' + i, ContactId = contactId, AccountId = accountId,
                    EntitlementId = entlId);
                    cases.add(c);                 
                }
            }
            
            insert cases;
    
            List<CaseComment> ccs = new List<CaseComment>{};
            for(Case c : cases){
                CaseComment cc = new CaseComment(CommentBody='TestPublic', 
                        IsPublished=true, ParentId=c.Id);
                ccs.add(cc);
                cc = new CaseComment(CommentBody='TestPrivate', 
                        IsPublished=false, ParentId=c.Id);
                ccs.add(cc);
            }
            if (ccs.isEmpty()==false)
                insert ccs;
        
            List<EmailMessage> emails = new List<EmailMessage>();
            for(Case c : cases){
                emails.add(new EmailMessage(parentId = c.id));
            }
            if(emails.isEmpty()==false)
                database.insert(emails);
            
            for(Case c : cases){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] toAddr = new String[] {'salesforceadmin@livenation.co.uk'};
                mail.setToAddresses(toAddr);
                mail.setSaveAsActivity(false);
                mail.setTargetObjectId(c.ContactId);
                mail.setWhatId(c.Id);
                mail.setHtmlBody('TestHTMLBody');
                mail.setPlainTextBody('TestTextBody');
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
        
        for(Case c : cases){
            c.Status = 'Closed';
            
        }
        update cases;
            List<Case> insertedCases = [SELECT Subject,
                           Description,
                           (SELECT IsPublished, CommentBody From CaseComments),
                           (SELECT TextBody, Subject, Incoming From EmailMessages)
                           FROM Case
                           WHERE Id IN :cases];
        }
}