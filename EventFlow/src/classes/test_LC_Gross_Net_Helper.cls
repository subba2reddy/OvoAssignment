@isTest
private class test_LC_Gross_Net_Helper {

	private static testMethod void theTests() {
        Account a = new Account(Name='Test', Industry='Beverage');
        insert a;
        LN_Executive__c lne = new LN_Executive__c(RecordTypeId='01220000000Pj9W', Name='TestExec');
        insert lne;
        Project__c p = new Project__c(RecordTypeId='01220000000AGoe', Name='TestProj', LN_Asset__c='Festival');
        insert p;
        Opportunity o = new Opportunity(RecordTypeId='012w0000000AgkB', Name='TestOpp', AccountId=a.Id, LN_Market__c='UK', LN_Executive__c=lne.Id, Project__c=p.Id, CloseDate=Date.today(), StageName='1. First Contact', Currency__c='GBP', Deal_Origin__c='New');
        insert o;
        List<Currencies__c> currencies = new List<Currencies__c>();
        Currencies__c c1 = new Currencies__c(Currency_Month__c='Jan', Currency_Year__c=String.valueOf(Date.today().year()), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        Currencies__c c2 = new Currencies__c(Currency_Month__c='Feb', Currency_Year__c=String.valueOf(Date.today().year()), Currency_Type__c='GBP', CurrencyRate__c=1.5);
        currencies.add(c1);
        currencies.add(c2);
        insert currencies;
        List<Event_s_Details__c> LCGrossNetList = new List<Event_s_Details__c>();
        Event_s_Details__c ED1 = new Event_s_Details__c(RecordTypeId='01220000000Pj9M', Date__c='Jan ' + String.valueOf(Date.today().year()), Opportunity__c=o.Id, Net_LC__c=100, Gross_LC__c=100, Currency__c=c1.Id);
        Event_s_Details__c ED2 = new Event_s_Details__c(RecordTypeId='01220000000Pj9M', Date__c='Feb ' + String.valueOf(Date.today().year()), Opportunity__c=o.Id, Net_LC__c=100, Gross_LC__c=100, Currency__c=c2.Id);
        //LC_Gross_Net_Details record with date in next year
        Event_s_Details__c ED3 = new Event_s_Details__c(RecordTypeId='01220000000Pj9M', Date__c='Jan ' + String.valueOf(Date.today().year()+1), Opportunity__c=o.Id, Net_LC__c=100, Gross_LC__c=100, Currency__c=c2.Id);
        LCGrossNetList.add(ED1);
        LCGrossNetList.add(ED2);
        LCGrossNetList.add(ED3);
        insert LCGrossNetList;
        
        Test.startTest();
        ED1.Net_LC__c = 200;
        Update ED1;
        o = [SELECT Current_Year_LC_Net__c FROM Opportunity LIMIT 1];
        system.assertEquals(300, o.Current_Year_LC_Net__c);
        
        ED2.Gross_LC__c = 200;
        update ED2;
        o = [SELECT Current_Year_LC_Gross__c FROM Opportunity LIMIT 1];
        system.assertEquals(300, o.Current_Year_LC_Gross__c);
        
        ED3.Gross_LC__c = 200;
        update ED3;
        o = [SELECT Next_Year_LC_Gross__c FROM Opportunity LIMIT 1];
        system.assertEquals(200, o.Next_Year_LC_Gross__c);
        Test.stopTest();
	}
}