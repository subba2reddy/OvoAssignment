public class AllocateToEvents {
	 String DEAL_NAME;
	 ID DEAL_ID;
	 public AllocateToEvents(ApexPages.Standardcontroller stdcontroller) {
	 	DEAL_ID = ApexPages.currentPage().getParameters().get('DealId');
	 	DEAL_NAME  = [Select Name From deal__c where id =:DEAL_ID].Name;
	 }
	 public PageReference goToEvents() {
	 	System.debug('DEAL_ID' + DEAL_ID);
	 	System.debug('DEAL_NAME' + DEAL_NAME);
	 	String URL = 'https://emea.salesforce.com/a0X/e?CF00N20000001wzBE=' + DEAL_NAME + '&CF00N20000001wzBE_lkid' + DEAL_ID + '&retURL=%2F' + DEAL_ID;
	 	System.debug('URL' + URL);
        PageReference pageRef = new PageReference(URL);
        pageRef.setRedirect(true);
        return pageRef;        
    }
}