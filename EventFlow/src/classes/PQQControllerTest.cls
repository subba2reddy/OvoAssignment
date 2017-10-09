@isTest
private class PQQControllerTest {

    static testMethod void myUnitTest() {
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        
        Profile profile1 = [Select Id from Profile where name = 'System Administrator'];
        User portalAccountOwner1 = new User(
        UserRoleId = portalRole.Id,
        ProfileId = profile1.Id,
        Username = System.now().millisecond() + 'test2@test.com',
        Alias = 'batman',
        Email='bruce.wayne@wayneenterprises.com',
        EmailEncodingKey='UTF-8',
        Firstname='Bruce',
        Lastname='Wayne',
        LanguageLocaleKey='en_US',
        LocaleSidKey='en_US',
        TimeZoneSidKey='Europe/London'
        );
        Database.insert(portalAccountOwner1);
        
        //User u1 = [Select ID From User Where Id =: portalAccountOwner1.Id];
        
        System.runAs ( portalAccountOwner1 ) {
        //Create account
        Account portalAccount1 = new Account(
        Name = 'TestAccount',
        OwnerId = portalAccountOwner1.Id
        );
        Database.insert(portalAccount1);
            
		//Create PQQ
		PQQ__c pqq1 = new PQQ__c(
        Account__c = portalAccount1.Id
        );
		Database.insert(pqq1);
        
        //Create contact
        Contact contact1 = new Contact(
        FirstName = 'Test',
        Lastname = 'McTesty',
        AccountId = portalAccount1.Id,
        Email = System.now().millisecond() + 'test@test.com'
        );
        Database.insert(contact1);
        
        //Create user
        Profile portalProfile = [SELECT Id FROM Profile WHERE Name = 'FR Community User'];
        User user1 = new User(
        Username = System.now().millisecond() + 'test12345@test.com',
        ContactId = contact1.Id,
        ProfileId = portalProfile.Id,
        Alias = 'test123',
        Email = 'test12345@test.com',
        EmailEncodingKey = 'UTF-8',
        LastName = 'McTesty',
        CommunityNickname = 'test12345',
        TimeZoneSidKey = 'America/Los_Angeles',
        LocaleSidKey = 'en_US',
        LanguageLocaleKey = 'en_US'
        );
        Database.insert(user1);
        }
        
        User portaluser = [SELECT Id FROM User Where Email = 'test12345@test.com'];
        System.runAs (portaluser) {
        
        PageReference pageRef = Page.PQQ;
        Test.setCurrentPage(pageRef);
        
        PQQController controller = new PQQController();
            
        controller.getPQQ();

        //Test save
        controller.save();
		controller.pqq.Public_Product_Liability_Insurance_5M__c=true;
		controller.save();
        
        //Test submit
		controller.pqq.Declaration__c=false;
        controller.submit();
		controller.pqq.Declaration__c=true;
		controller.pqq.Public_Product_Liability_Insurance_5M__c=false;
        controller.submit();
		controller.pqq.Declaration__c=true;
		controller.pqq.Public_Product_Liability_Insurance_5M__c=true;
        controller.submit();
        
        }      
    }
}