trigger EvtFlowPricesTrigger on Price__c (after update, after insert) {
    //after update trigger
    if(trigger.IsAfter && trigger.IsUpdate){
        EvtFlowEventTriggerHandler.pricesAfterUpdate(trigger.newMap, trigger.oldMap);
    }
    
    //after insert trigger    
    if(trigger.IsAfter && trigger.IsInsert){
        EvtFlowEventTriggerHandler.pricesAfterInsert(trigger.new);
    }
}