@isTest
private class UpdatePostcode_TestClass {

    static testMethod void myUnitTest() {
        // create a postcode record
        Postcode__c testPostcode = new Postcode__c(Name = '12345', Region__c = 'A Test Region');
        
        insert testPostcode;
        
        // create germany test accounts
        list<Account> testAccs = new List<Account>{};
	         
	    for(Integer i = 0; i < 500; i++){
	        Account a = new Account(Name = 'Test Account ' + i, 
	        								BillingPostalCode = '12345', 
	        								ShippingPostalCode = '12345', 
	        								RecordTypeId = '01220000000Pini');
	        testAccs.add(a);
	    }
	    insert testAccs;
	         
	    // Query the database for the newly inserted records.
	    list<Account> insertedAccounts = [SELECT Name, BillingState
	                                      FROM Account
	                                      WHERE Id IN :testAccs];
			                                      
		// Assert that the region__c field contains the proper value now.
	    for(Account a : insertedAccounts){
	    	system.assertEquals('A Test Region', a.BillingState);                                  
    	}
	}
}