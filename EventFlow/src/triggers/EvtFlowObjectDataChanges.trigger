trigger EvtFlowObjectDataChanges on ObjectToolData__c (after insert){
    
    //when an object tool act is created check if there is 
    //an existing act record - if there is then relate them
    if(trigger.isInsert && trigger.isAfter){
        //execute trigger logic only if migration is not running
        EvtFlowObjectDataTriggerUtil.afterInsert(trigger.new);
    }
    //add future trigger context by calling the util class
}