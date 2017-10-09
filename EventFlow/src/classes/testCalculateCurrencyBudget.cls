public class testCalculateCurrencyBudget {
public static testMethod void testAmountAssignMethod(){
    calculateCurrencyBudget test = new calculateCurrencyBudget(); 
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
        
        Budget_Costs__c EC = new Budget_Costs__c(Opportunity__c=d.Id);
        insert EC;
        ApexPages.StandardController sController1 = new ApexPages.StandardController(EC);                        
        calculateCurrencyBudget amtDisplay1 = new calculateCurrencyBudget(sController1); 
        
        List<Event_s_Details__c> monthlyAmountList = new List<Event_s_Details__c>();
        
        Integer Month1 = amtDisplay1.getMonthInNumber('Jan') ;
        Integer Month2 = amtDisplay1.getMonthInNumber('Feb') ;
        Integer Month3 = amtDisplay1.getMonthInNumber('Mar') ;
        Integer Month4 = amtDisplay1.getMonthInNumber('Apr') ;
        Integer Month5 = amtDisplay1.getMonthInNumber('May') ;
        Integer Month6 = amtDisplay1.getMonthInNumber('Jun') ;
        Integer Month7 = amtDisplay1.getMonthInNumber('Jul') ;
        Integer Month8 = amtDisplay1.getMonthInNumber('Aug') ;
        Integer Month9 = amtDisplay1.getMonthInNumber('Sep') ;
        Integer Month10 = amtDisplay1.getMonthInNumber('Oct') ;
        Integer Month11 = amtDisplay1.getMonthInNumber('Nov') ;
        Integer Month12 = amtDisplay1.getMonthInNumber('Dec') ;
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
        
        //EC.Month_of_Recognition__c = 'Nov';
        //EC.Year_of_Recognition__c='2008';
        //EC.End_Month_of_Recognition__c = 'Dec';
        //EC.End_Year_of_Recognition__c='2009';
        update EC;
        ApexPages.StandardController sController2 = new ApexPages.StandardController(EC);                        
        calculateCurrencyBudget amtDisplay2 = new calculateCurrencyBudget(sController2);
        amtDisplay2.listAll();
        
        /**Event_Costs__c errorCntrct1 = new Event_Costs__c(Event_to_Deal__c=d.Id, End_Month_of_Recognition__c=null, End_Year_of_Recognition__c='2008', Month_of_Recognition__c=null, Year_of_Recognition__c='2008');
        insert errorCntrct1; 
        ApexPages.StandardController sController3 = new ApexPages.StandardController(errorCntrct1);                        
        calculateCurrencBudget amtDisplay3 = new calculateCurrencBudget(sController3);
        amtDisplay3.listAll(); 
        
        errorCntrct1.Month_of_Recognition__c = 'May';       
        errorCntrct1.End_Month_of_Recognition__c = 'Jan';
        update errorCntrct1;
        ApexPages.StandardController sController4 = new ApexPages.StandardController(errorCntrct1);                        
        calculateCurrencBudget amtDisplay4 = new calculateCurrencBudget(sController4);
        amtDisplay4.listAll();
        
        errorCntrct1.Year_of_Recognition__c = null;       
        errorCntrct1.End_Year_of_Recognition__c = null;
        update errorCntrct1;
        ApexPages.StandardController sController5 = new ApexPages.StandardController(errorCntrct1);                        
        calculateCurrencBudget amtDisplay5 = new calculateCurrencBudget(sController5);
        amtDisplay5.listAll();
*/
    }   
}