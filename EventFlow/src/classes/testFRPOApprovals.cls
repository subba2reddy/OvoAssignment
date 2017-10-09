// Test class for FR Approvals APEX class

@isTest
private class testFRPOApprovals
{
    static testMethod void ApprovalUnitTest()
    {
        PageReference pageRef = Page.FRPOApprovals;
        Test.setCurrentPage(pageRef);
        
        massApprovePOCon controller = new massApprovePOCon();
        Test.StartTest();
        controller.toggleSort();
        
        // Add a dummy festival
        Festival__c testFest = new Festival__c(name='TestFest', Prefix__c='TST 2010',Last_PO_Number__c=0);
        insert testFest;
        
        Purchase_Order_Festival_Republic__c PO = new Purchase_Order_Festival_Republic__c();
        
        PO.RecordTypeID = '01220000000PgsL';
        PO.Status__C = 'Submitted';
        PO.Holder__c = 'Ian Donaldson';
        PO.Supplier_Contact__c = 'Rob Cowell';
        PO.Supplier_Email__c = 'rob.cowell@livenation.co.uk';
        PO.Festival__c = testFest.ID;
//        PO.Festival_Year__c = '2011';
        PO.PO_Description__c = 'Test PO for mass approvals code';
        PO.Terms_Summary__c = 'Test terms';
        PO.Terms_and_Conditions_Detail__c = 'Test term detail';
        
        insert PO;
        controller.PurchaseOrderID = PO.ID;
        controller.ApprovePO();
        
        PO = new Purchase_Order_Festival_Republic__c();
        
        PO.RecordTypeID = '01220000000PgsL';
        PO.Status__C = 'Submitted';
        PO.Holder__c = 'Ian Donaldson';
        PO.Supplier_Contact__c = 'Rob Cowell';
        PO.Supplier_Email__c = 'rob.cowell@livenation.co.uk';
        PO.Festival__c = testFest.ID;
//        PO.Festival_Year__c = '2011';
        PO.PO_Description__c = 'Test PO for mass approvals code';
        PO.Terms_Summary__c = 'Test terms';
        PO.Terms_and_Conditions_Detail__c = 'Test term detail';
        
        insert PO;
        controller.PurchaseOrderID = PO.ID;
        controller.RejectPO();
        
        Test.StopTest();
    }
}