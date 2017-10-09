public class testCalculateCurrency {

     public static testMethod void testAmountAssignMethod(){ 
        
        calculateCurrency test = new calculateCurrency();
        /*
        //Account acct = new Account( Name='TestAccount', AccountNumber='100987');
        //insert acct;
        //Deal__c d = new Deal__c();
        //d.Deal_Description__c = 'Test deal';
        //insert d;
        
        Opportunity d = new Opportunity();
        d.Name = 'Test deal';
        d.StageName = 'Test stage';
        d.CloseDate = date.parse('01/01/1900');
        insert d;
        
        Event_Costs__c EC = new Event_Costs__c(Opportunity__c=d.Id, End_Month_of_Recognition__c='December', End_Year_of_Recognition__c='2008', Month_of_Recognition__c='January', Year_of_Recognition__c='2008');
        insert EC;
        ApexPages.StandardController sController1 = new ApexPages.StandardController(EC);                        
        calculateCurrency amtDisplay1 = new calculateCurrency(sController1); 
        List<Event_s_Details__c> monthlyAmountList = new List<Event_s_Details__c>();
         
        amtDisplay1.getHasErrors(); 
        amtDisplay1.getHasNoErrors(); 
        amtDisplay1.getShowBack(); 
        amtDisplay1.setShowBack(true);
        amtDisplay1.getShowCancel();
        amtDisplay1.setShowCancel(false); 
        monthlyAmountList = amtDisplay1.getmonthlyAmountList();
        amtDisplay1.setmonthlyAmountList(monthlyAmountList);
        amtDisplay1.listAll();    
        PageReference pgref = amtDisplay1.save();        
        pgref = amtDisplay1.cancel();
        
        EC.Month_of_Recognition__c = 'Nov';
        EC.Year_of_Recognition__c='2008';
        EC.End_Month_of_Recognition__c = 'Dec';
        EC.End_Year_of_Recognition__c='2009';
        update EC;
        ApexPages.StandardController sController2 = new ApexPages.StandardController(EC);                        
        calculateCurrency amtDisplay2 = new calculateCurrency(sController2);
        amtDisplay2.listAll();
        
        Event_Costs__c errorCntrct1 = new Event_Costs__c(Opportunity__c=d.Id, End_Month_of_Recognition__c=null, End_Year_of_Recognition__c='2008', Month_of_Recognition__c=null, Year_of_Recognition__c='2008');
        insert errorCntrct1; 
        ApexPages.StandardController sController3 = new ApexPages.StandardController(errorCntrct1);                        
        calculateCurrency amtDisplay3 = new calculateCurrency(sController3);
        amtDisplay3.listAll(); 
        
        errorCntrct1.Month_of_Recognition__c = 'May';       
        errorCntrct1.End_Month_of_Recognition__c = 'Jan';
        update errorCntrct1;
        ApexPages.StandardController sController4 = new ApexPages.StandardController(errorCntrct1);                        
        calculateCurrency amtDisplay4 = new calculateCurrency(sController4);
        amtDisplay4.listAll();
        
        errorCntrct1.Year_of_Recognition__c = null;       
        errorCntrct1.End_Year_of_Recognition__c = null;
        update errorCntrct1;
        ApexPages.StandardController sController5 = new ApexPages.StandardController(errorCntrct1);                        
        calculateCurrency amtDisplay5 = new calculateCurrency(sController5);
        amtDisplay5.listAll();
		*/
    }
}