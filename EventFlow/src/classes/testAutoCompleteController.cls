@isTest

private class testAutoCompleteController
{
    static testMethod void AutoCompleteTest()
    {
        PageReference pageRef = Page.SMS_Overview;
        pageRef.getParameters().put('objectname', 'ClientCompany__c');
        pageRef.getParameters().put('aname', 'companytag');
        Test.setCurrentPage(pageRef);
        
        SMSOverviewControllerExtension controller = new SMSOverviewControllerExtension();
        AutoComplete_Controller acController = new AutoComplete_Controller();
        
        ClientCompany__c company = new ClientCompany__c();
        insert company;
        
        ApexPages.StandardController sController1 = new ApexPages.StandardController(company);
        AutoComplete_Controller acController2 = new AutoComplete_Controller(sController1);
        Test.StartTest();
        
        acController.clearValues();
        acController.getHasparams();
        acController.getHasnoresults();
        acController.avoidRefresh();
        
        List<String> acResults = acController.getResultsname();     
        
        PageReference acRef = acController.searchSuggestions();           
        Test.StopTest();
    }
}