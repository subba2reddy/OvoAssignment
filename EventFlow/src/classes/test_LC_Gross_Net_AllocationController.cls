@isTest
private class test_LC_Gross_Net_AllocationController {
	//retroTests covers old, decomissioned classes
	private static testMethod void retroTests() {
        BFYMonthlyAllocationController test1 = new BFYMonthlyAllocationController();
        CFYMonthlyAllocationController test2 = new CFYMonthlyAllocationController();
    }
    
    private static testMethod void theTests() {
        Account a = new Account(Name='Test', Industry='Beverage');
        insert a;
        LN_Executive__c lne = new LN_Executive__c(RecordTypeId='01220000000Pj9W', Name='TestExec');
        insert lne;
        Project__c p = new Project__c(RecordTypeId='01220000000AGoe', Name='TestProj', LN_Asset__c='Festival');
        insert p;
        List<Opportunity> opps = new List<Opportunity>();
        Opportunity o = new Opportunity(RecordTypeId='012w0000000AgkB', ContractStartDate__c=Date.today(), ContractEndDate__c=Date.today().addMonths(5), Name='TestOpp', AccountId=a.Id, LN_Market__c='UK', LN_Executive__c=lne.Id, Project__c=p.Id, CloseDate=Date.today(), StageName='1. First Contact', Currency__c='GBP', Deal_Origin__c='New');
        opps.add(o);
        insert opps;
        List<Currencies__c> currencies = new List<Currencies__c>();
        Currencies__c c1 = new Currencies__c(Currency_Month__c='Jan', Currency_Year__c=String.valueOf(Date.today().year()), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        Currencies__c c2 = new Currencies__c(Currency_Month__c='Feb', Currency_Year__c=String.valueOf(Date.today().year()), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        Currencies__c c3 = new Currencies__c(Currency_Month__c='Mar', Currency_Year__c=String.valueOf(Date.today().year()), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        Currencies__c c4 = new Currencies__c(Currency_Month__c='Apr', Currency_Year__c=String.valueOf(Date.today().year()), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        Currencies__c c5 = new Currencies__c(Currency_Month__c='May', Currency_Year__c=String.valueOf(Date.today().year()), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        Currencies__c c6 = new Currencies__c(Currency_Month__c='Jun', Currency_Year__c=String.valueOf(Date.today().year()), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        Currencies__c c7 = new Currencies__c(Currency_Month__c='Jul', Currency_Year__c=String.valueOf(Date.today().year()), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        Currencies__c c8 = new Currencies__c(Currency_Month__c='Aug', Currency_Year__c=String.valueOf(Date.today().year()), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        Currencies__c c9 = new Currencies__c(Currency_Month__c='Sep', Currency_Year__c=String.valueOf(Date.today().year()), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        Currencies__c c10 = new Currencies__c(Currency_Month__c='Oct', Currency_Year__c=String.valueOf(Date.today().year()), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        Currencies__c c11 = new Currencies__c(Currency_Month__c='Nov', Currency_Year__c=String.valueOf(Date.today().year()), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        Currencies__c c12 = new Currencies__c(Currency_Month__c='Dec', Currency_Year__c=String.valueOf(Date.today().year()), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        
        currencies.add(c1);
        currencies.add(c2);
        currencies.add(c3);
        currencies.add(c4);
        currencies.add(c5);
        currencies.add(c6);
        currencies.add(c7);
        currencies.add(c8);
        currencies.add(c9);
        currencies.add(c10);
        currencies.add(c11);
        currencies.add(c12);
        insert currencies;
        
        Test.startTest();
        
        pageReference pageRef = Page.LC_Gross_Net_Allocation;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', o.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(o);
        LC_Gross_Net_AllocationController c = new LC_Gross_Net_AllocationController(sc);
        
        //Test with an Opportunity that has contract start/end dates (6 months)
        c.listAll();
        
        //Now test with an Opportunity that has contract start/end dates 12 months apart
        o.ContractEndDate__c = Date.today().addMonths(11);
        update o;
        sc = new ApexPages.StandardController(o);
        c = new LC_Gross_Net_AllocationController(sc);
        c.listAll();
        
        //Now test with an Opportunity that has contract start/end dates 13 months apart (no currency will be found for month 13)
        o.ContractEndDate__c = Date.today().addMonths(12);
        update o;
        sc = new ApexPages.StandardController(o);
        c = new LC_Gross_Net_AllocationController(sc);
        c.listAll();
        
        //Test save method
        c.save();
        
        //Test cancel method
        c.cancel();
        
        //Test DMLexceptions in save method
        o.Name = 'Fail';
        update o;
        sc = new ApexPages.StandardController(o);
        c = new LC_Gross_Net_AllocationController(sc);
        c.save();
 
        //Test getters and setters
        Event_s_Details__c[] monthlyAmountList = c.getmonthlyAmountList();
        c.setmonthlyAmountList (monthlyAmountList);
        Boolean hasErrors = c.getHasErrors();
        Boolean hasNoErrors = c.getHasNoErrors();
        Boolean showBack = c.getShowBack();
        c.setShowBack(!showBack);
        Boolean showCancel = c.getShowCancel();
        c.setShowCancel(!showCancel);
        
        Test.stopTest();
    }
}