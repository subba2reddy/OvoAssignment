public class testClass {
/*
    static testmethod void testdealUpdates(){
        LNEvents__c LNevent = new LNEvents__c();
        LNevent.Event_Type__c = 'Promotion';
        LNevent.Start_Date__c = System.today();
        LNevent.End_Date__c = System.today();
        insert LNevent;
        
        LNEvents__c LNevent2 = new LNEvents__c();
        LNevent2.Event_Type__c = 'Venues';
        LNevent2.Start_Date__c = System.today();
        LNevent2.End_Date__c = System.today();
        insert LNevent2;
        
        Deal__c d = new Deal__c(Event2Deal__c = LNevent.Id);
        d.Deal_Description__c = 'Test Deal';
        insert d;
        
        Deal_Update__c dealUpdate = new Deal_Update__c(Deal__c = d.Id ,Latest_Forecast_in_Local_Currency__c=123,Deal_Update_Commentary__c='Deal_Update_Commentary__c',Net_Forecast_in_Local_Currency__c=234);
        insert dealUpdate;
        dealUpdate.Latest_Forecast_in_Local_Currency__c=234;
        update dealUpdate;
    }
    static testmethod void calculateCurrencyOnUpdate(){
        LNEvents__c LNevent = new LNEvents__c();
        LNevent.Event_Type__c = 'Promotion';
        LNevent.Start_Date__c = System.today();
        LNevent.End_Date__c = System.today();
        insert LNevent;
        
        Deal__c d = new Deal__c(Event2Deal__c = LNevent.Id);
        d.Deal_Description__c = 'Test Deal';
        insert d;
        Event_Costs__c EC = new Event_Costs__c(Event_to_Deal__c=d.Id,Event__c = LNevent.Id,Business_Stage__c = '2 - FirstMeeting',Month_of_Recognition__c='Jan',Year_of_Recognition__c='2009',End_Month_of_Recognition__c='Dec',End_Year_of_Recognition__c='2009');
        insert EC;
        Event_s_Details__c ED = new Event_s_Details__c(Event_s__c = EC.Id,Gross_LC__c=100,Net_LC__c=100,Date__c='Jan 2009', Deal__c=d.Id);
        insert ED;
        ED.Gross_LC__c = 200;
        update ED;
    }
*/
}