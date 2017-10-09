trigger UpdatePostcode on Account (before insert, before update) {
	// query for all the postcode records 
	// create a map for a lookup for the postcode region
	Map<string, Postcode__c> PcodeRegionMap = new Map<string, Postcode__c>();
	for (Postcode__c p:[SELECT Name, Region__c FROM Postcode__c]) { 
   		if(p.Region__c != null) PcodeRegionMap.put(p.Name, p);
	} 
			
	// iterate over the list of records being processed in the trigger and
	// set the region before being inserted or updated
	for (Account a : Trigger.new) {
		if ((a.BillingPostalCode != null || a.ShippingPostalCode != null) && (a.RecordTypeId=='01220000000Pini')) {
			// catch NullPointerException exception if postcode doesnt exist
			try {
				a.BillingState = PcodeRegionMap.get(a.BillingPostalCode).Region__c;
			} catch (system.NullPointerException e) {
				System.debug('ERROR: ' + e);
			}
			try {
				a.ShippingState = PcodeRegionMap.get(a.ShippingPostalCode).Region__c;
			} catch (system.NullPointerException e2) {
				System.debug('ERROR: ' + e2);
			}
		}
	}
}