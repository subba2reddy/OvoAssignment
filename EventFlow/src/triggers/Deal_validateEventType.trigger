trigger Deal_validateEventType on Deal__c (after insert, after update) {
	/**if(Trigger.isInsert || Trigger.isUpdate){
		// Logic for validating the event type on event object.
		validateEventType();
	}
	public void validateEventType()
	{
		Deal__c[] deals = [Select d.Event2Deal__r.Event_Type__c, d.Event2Deal__c From Deal__c d where Event2Deal__c != null];
		for(Deal__c d: Trigger.new){
			for(Deal__c deal: deals){
				System.debug('d.LN_Asset__c = ' + d.LN_Asset__c);
				System.debug('deal.Event2Deal__r.Event_Type__c =' + deal.Event2Deal__r.Event_Type__c);
				System.debug('d.Id = ' + d.Id);
				System.debug('deal.Id = ' + deal.Id);
				if(d.Event2Deal__c != null){
					if(d.Id == deal.Id && d.LN_Asset__c != deal.Event2Deal__r.Event_Type__c){
						d.addError('The LN Asset does not match with Event Type');
					}
				}
			}
		}
	}*/
}