trigger CompleteFirstResponseMilestone on Case (after update) {
    if (UserInfo.getUserType() == 'Standard'){
        DateTime completionDate = System.now(); 
            List<Id> updateCases = new List<Id>();
            for (Case c : Trigger.new){
                    if ((c.Date_Time_First_Response__c!= null)&(c.SlaStartDate 
                        <= completionDate)&&(c.SlaExitDate == null))
        updateCases.add(c.Id);
        }
    if (updateCases.isEmpty() == false)
        milestoneUtils.completeMilestone(updateCases, 'First Response', completionDate);
    }
}