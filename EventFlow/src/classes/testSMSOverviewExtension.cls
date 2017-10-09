// Test class for SMS Overview controller extension APEX class

@isTest
private class testSMSOverviewExtension
{
    static testMethod void SMSOverviewTest()
    {
       
        SMSOverviewControllerExtension controller = new SMSOverviewControllerExtension();
        
        /*
        PageReference pageRef = Page.SMS_Overview;
        Test.setCurrentPage(pageRef);
        Test.StartTest();
        
        Apexpages.currentPage().getParameters().put('market','UK');
        
        controller.industry = 'Automotive';
        controller.populateSectorList();

        controller.industry = 'Beverage';
        controller.populateSectorList();
                       
        controller.industry = 'Energy';
        controller.populateSectorList();
              
        controller.industry='Entertainment & Leisure';
        controller.populateSectorList();
        
        controller.industry='Financial Services';
        controller.populateSectorList();
        
        controller.industry='FMCG';
        controller.populateSectorList();
        
        controller.industry='Health Care';
        controller.populateSectorList();

        controller.industry='Media/Telco';
        controller.populateSectorList();
        
        controller.industry='Public Sector';
        controller.populateSectorList();
        
        controller.industry='Support Services';
        controller.populateSectorList();
        
        controller.industry='Telecommunications';
        controller.populateSectorList();
        
        controller.industry='Ticketing';
        controller.populateSectorList();
        
        controller.industry='Tobacco';
        controller.populateSectorList();
        
        Apexpages.currentPage().getParameters().put('industry','Beverage');
        controller.populateSectorList();
        

        Apexpages.currentPage().getParameters().put('sector','Beer');
        controller.runSearch();
        
        System.assertEquals(controller.market, 'UK');
        System.assertEquals(controller.industry, 'Beverage');
        System.assertEquals(controller.sector, 'Beer');
        
        System.assertNotEquals(controller.companies, null);
        System.debug('COMPANY SIZE IS ' + controller.companies.size());
        
        controller.companyID = 'a0220000004XnjJ';
        
        System.debug('companyid ' + controller.companyID);
        
        controller.ShowDeals();
        
        System.assertNotEquals(controller.clientcompany,null);
        
        controller.debugOn();
        
        string deals = controller.dealGraph;
        System.assertNotEquals(deals, null);
        
        string countrymap = controller.mapGraph;
        System.assertNotEquals(countrymap, null);
        
        string competitors = controller.CompetitorGraph;
        System.assertNotEquals(competitors, null);
        
        Test.StopTest();

		*/
    }
}