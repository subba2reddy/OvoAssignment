@isTest
private class OppCloneRenewalTestClass {

    static testMethod void myUnitTest() {
        //insert opportunity to clone
        Opportunity to = new Opportunity(name='Test Opportunity', CloseDate = system.today(), StageName = '1 - Cold Prospect' );
        insert to;
        //instantiate page
        PageReference pageRef = Page.OppCloneRenewal;
        //method that sets the current PageReference for the controller
        Test.setCurrentPage(pageRef);
        //instantiate a StandardController & custom controller
        ApexPages.StandardController sc = new ApexPages.StandardController(to);
        OppCloneRenewalController scs = new OppCloneRenewalController(sc);
        //method to clone opp
        scs.oppCloneRenewal();
    }
}