@isTest
private class test_Currencies_Helper {

	private static testMethod void theTests() {
        Account a = new Account(Name='Test', Industry='Beverage');
        insert a;
        LN_Executive__c lne = new LN_Executive__c(RecordTypeId='01220000000Pj9W', Name='TestExec');
        insert lne;
        Project__c p = new Project__c(RecordTypeId='01220000000AGoe', Name='TestProj', LN_Asset__c='Festival');
        insert p;
        Opportunity o = new Opportunity(RecordTypeId='012w0000000AgkB', ContractStartDate__c=Date.today(), ContractEndDate__c=Date.today().addMonths(5), Name='TestOpp', AccountId=a.Id, LN_Market__c='UK', LN_Executive__c=lne.Id, Project__c=p.Id, CloseDate=Date.today(), StageName='1. First Contact', Currency__c='GBP', Deal_Origin__c='New');
        insert o;
        List<Currencies__c> currencies = new List<Currencies__c>();
        Currencies__c c1 = new Currencies__c(Currency_Month__c='Jan', Currency_Year__c=String.valueOf(Date.today().year()-1), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        Currencies__c c2 = new Currencies__c(Currency_Month__c='Feb', Currency_Year__c=String.valueOf(Date.today().year()-1), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        currencies.add(c1);
        currencies.add(c2);
        insert currencies;
        List<Event_s_Details__c> LCGrossNetList = new List<Event_s_Details__c>();
        Event_s_Details__c ED1 = new Event_s_Details__c(RecordTypeId='01220000000Pj9M', Date__c='Jan ' + String.valueOf(Date.today().year()), Opportunity__c=o.Id, Net_LC__c=100, Gross_LC__c=100, Currency__c=c1.Id);
        Event_s_Details__c ED2 = new Event_s_Details__c(RecordTypeId='01220000000Pj9M', Date__c='Feb ' + String.valueOf(Date.today().year()), Opportunity__c=o.Id, Net_LC__c=100, Gross_LC__c=100, Currency__c=c2.Id);
        Event_s_Details__c ED3 = new Event_s_Details__c(RecordTypeId='01220000000Pj9M', Date__c='Mar ' + String.valueOf(Date.today().year() + 1), Opportunity__c=o.Id, Net_LC__c=100, Gross_LC__c=100, Currency__c=c2.Id);
        LCGrossNetList.add(ED1);
        LCGrossNetList.add(ED2);
        LCGrossNetList.add(ED3);
        insert LCGrossNetList;
        
        Test.startTest();
        
        //Pretend to open the LC_Gross_Net_Allocation page, which would trigger the listAll() method to be called on LC_Gross_Net_AllocationController
        //This sets the Opportunity total field values initially
        pageReference pageRef = Page.LC_Gross_Net_Allocation;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', o.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(o);
        LC_Gross_Net_AllocationController c = new LC_Gross_Net_AllocationController(sc);
        c.setmonthlyAmountList(LCGrossNetList);
        c.save();
        
        //Check everything is ok with active currency rate at 1.5
        o = [SELECT Total_LC_Gross__c, Total_USD_Gross__c, Total_LC_Net__c, Total_USD_Net__c FROM Opportunity];
        System.assertEquals(300, o.Total_LC_Gross__c);
        System.assertEquals(300, o.Total_LC_Net__c);
        System.assertEquals(450, o.Total_USD_Gross__c);
        System.assertEquals(450, o.Total_USD_Net__c);
		
        //Update the active rate for both months to 1.0, which should reduce the Opportunity's total fields
		c1.CurrencyRate__c = 1.0;
        c2.CurrencyRate__c = 1.0;
		update currencies;
        o = [SELECT Total_USD_Net__c, Total_USD_Gross__c FROM Opportunity];
        System.assertEquals(300, o.Total_USD_Gross__c);
        System.assertEquals(300, o.Total_USD_Net__c);
        
        Test.stopTest();
    }
}