@isTest
private class oppAutoRenewBatchSchedulableTest {

    public static testMethod void testschedule() {

	Test.StartTest();
	
	oppAutoRenewBatchSchedulable sh1 = new oppAutoRenewBatchSchedulable();
	        String sch = '0 0 23 * * ?';
	        system.schedule('Test Schedule', sch, sh1);
	Test.stopTest();
	
	}
}