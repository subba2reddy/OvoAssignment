trigger EvtFlowEventTrigger on Event__c (after update) {
    //after update trigger
    if(trigger.IsAfter && trigger.IsUpdate){
        EvtFlowEventTriggerHandler.afterUpdate(trigger.newMap, trigger.oldMap);
    }
}