/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class testFRPONumbers {

    static testMethod void myUnitTest() {
        // Add a dummy festival
        Festival__c testFest = new Festival__c(name='TestFest', Prefix__c='TST 2010',Last_PO_Number__c=0);
        insert testFest;
        
        // Add a dummy supplier
        Supplier_Festival_Republic__c testSupplier= new Supplier_Festival_Republic__c(name='Test supplier');
        insert testSupplier;
        
        
        // Add a PO for the fest 
        
        Purchase_Order_Festival_Republic__c testPO = new Purchase_Order_Festival_Republic__c(
        Festival__c=testFest.Id,
        Location__c='test location',
        Supplier__c=testSupplier.Id,
        Supplier_Contact__c='test contact',
        Supplier_Email__c='test@test.com',
        Festival_Year__c='2010',
        PO_Description__c='test po',
        Terms_Summary__c='terms',
        Terms_and_Conditions_Detail__c='terms detail'
        );
        
        Test.startTest();
        insert testPO;
        test.stopTest();
        
        
        system.debug('Last PO num=' + testFest.Last_PO_Number__c);
        // System.assert(testFest.Last_PO_Number__C > 0);
    }
}