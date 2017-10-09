trigger OpportunityTrigger on Opportunity (before insert, before update, before delete, after insert, after update, after delete) {
    
//    OpportunityTriggerHandler oppHandler = new OpportunityTriggerHandler();
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            
        }else if(Trigger.isUpdate){
            
        }else if(Trigger.isDelete){
            
        }
    }else if(Trigger.isAfter){
        if(Trigger.isInsert){
            
        }else if(Trigger.isUpdate){
            
        }else if(Trigger.isDelete){
            
        }
    }
}