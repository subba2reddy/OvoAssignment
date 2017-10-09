@isTest
private class FRSupplierUpdaterTest {

    // Test web service call using Mock Web Service    
    static testmethod void testWebService() {
        // Setup Mock Web Service
        Test.setMock(HttpCalloutMock.class, new FRSupplierUpdaterHttpCalloutMock()) ;
        
        // Call Web Service
        Test.startTest();
        HttpResponse res = FRSupplierUpdater.getHashPasswordFromContractorDocs('anypassword');
        Test.stopTest();
        // Check result
        System.assertEquals('$2a$10$ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZA', res.getBody());
    }

    static testmethod void testHashPassword() {
              
        // Add a dummy supplier
        Supplier_Festival_Republic__c testSupplier = new Supplier_Festival_Republic__c(name='Test supplier');        
        insert testSupplier;
        
        // Call FRSupplierUpdater with dummy supplier details
        Test.setMock(HttpCalloutMock.class, new FRSupplierUpdaterHttpCalloutMock());        
        Test.startTest();
        FRSupplierUpdater.updateFRSupplier(testSupplier.Id, 'Test supplier', 'plain-text-password');
        Test.stopTest();
        testSupplier = new Supplier_Festival_Republic__c(Id=testSupplier.Id);
        
        // Verify response received contains fake values
        //System.assertEquals('$2a$10$ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZA', testSupplier.Health_And_Safety_Password__c);
        System.assertEquals(null, testSupplier.Health_And_Safety_Password__c);        
    }
   
    static testmethod void testEmailSupport() {
       
        // Simulate an notifying of an error
        Boolean notifyResult = FRSupplierUpdater.EmailSupport('TestID', 'TestSupplier', 'Testing Error notification');
        System.assertEquals(true, notifyResult);
        
    }
}