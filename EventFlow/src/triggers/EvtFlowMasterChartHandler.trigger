trigger EvtFlowMasterChartHandler on Performance__c (after insert, after update, after delete) {

    if(trigger.isAfter && trigger.isInsert){
        //1. handle event of user creating a new performance
        //Check on the master charts if a new one is needed        
        EvtFlowPerfTrgUtil.afterInsert(trigger.new);
    }
    else if(trigger.isAfter && trigger.isUpdate){
        //2. handle the event of user updating a performance
        //Do we need to update a masterchart        
        EvtFlowPerfTrgUtil.afterUpdate(trigger.newMap, trigger.oldMap);
    }
    else if(trigger.isAfter && trigger.isDelete){
        //3. handle the event of user deleting a performance
        //Do we need to delete a master chart        
        EvtFlowPerfTrgUtil.afterDelete(trigger.old);
    }
}