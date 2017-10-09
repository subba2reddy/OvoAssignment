@isTest
private class updateContactsOnAddressChangeTest{

    static testMethod void myTest() {
        // Create a test account
	   	Account a = new Account(Name = 'Acme Test Account', RecordTypeId = '01220000000AFqo');
    	insert a;
        
        // Create a test contact
        Contact c = new Contact(LastName = 'Coyote', FirstName = 'Wile E', AccountID = a.ID, RecordTypeId = '01220000000AFqt');
        insert c;
        
        // Update account address
        a.BillingCity = 'San Francisco';
        update a;
        
        // Check contact address has been updated after trigger
        Contact u = [SELECT Id, MailingCity FROM Contact WHERE AccountID = :a.ID];
        system.assertEquals(a.BillingCity, u.MailingCity);

    }
	
}