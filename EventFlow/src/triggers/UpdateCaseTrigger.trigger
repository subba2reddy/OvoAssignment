trigger UpdateCaseTrigger on Case (after insert, after update) {
	//Needed as case transfer does not invoke Entitlement recalculation
    //Workaround uses Apex @future method to perform an update to the case	
    List<Id> idList = new List<Id>();	
	if (!ProcessorControl.inFutureContext) {           
    	
		for (Case c : Trigger.new){
            //Exclude TM Shared Cases
            if (c.recordtypeid!='012w0000000Qz1Y') {
                idList.add(c.id);
            }
            
        }
			//Check to see if list is empty to avoid unnecessary future calls
            if (!idList.isEmpty()) {
                CaseTriggerProcessor.updateCases(idList);
            }
	}
}