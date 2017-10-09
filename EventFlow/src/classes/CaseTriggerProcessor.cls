public class CaseTriggerProcessor{
    
    //Needed as case transfer does not invoke Entitlement recalculation
    //Workaround uses Apex @future method to perform an update to the case
    public static boolean inFutureContext = false;
    
    @future
    public static void updateCases(List<Id> triggerCases){
        
		List<case> casesToUpdate = [SELECT Id FROM Case WHERE ID=:triggerCases];

        for ( Case c : casesToUpdate ){
		c.CaseTriggerProcessorLog__c='CaseTriggerProcessor class last ran ' + System.now();          
		}
		
        ProcessorControl.inFutureContext = true;
        
		update casesToUpdate;

	}

}