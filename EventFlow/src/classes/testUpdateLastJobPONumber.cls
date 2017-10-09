@isTest
private class testUpdateLastJobPONumber {

    static testMethod void myUnitTest() {
        // create dummy job
        Job__c testJob = new Job__c(
        	name='testClassJob',
        	Prefix__c='TCLASS',
        	Last_PO_Number__c=0);
        insert testJob;
        // create dummy supplier
        LNITSupplier__c testSup = new LNITSupplier__c(
        	name='testClassSupplier');
        insert testSup;
        // create po
        LNITPO__c testPO = new LNITPO__c(
        	Job__c=testJob.id,
        	Supplier__c=testSup.id,
        	recordtypeid='01220000000AHOd',
        	Status__c='Draft',
        	PO_Description__c='testClassPO');
        insert testPO;
     }
}