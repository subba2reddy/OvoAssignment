trigger CompleteResolutionTimeMilestone on Case (after update) {
    if (UserInfo.getUserType() == 'Standard'){
        DateTime completionDate = System.now(); 
            List<Id> updateCases = new List<Id>();
            for (Case c : Trigger.new){
                    if ((c.status == 'Resolved')&&(c.First_Assigned_PS__c!= null)&(c.SlaStartDate 
                        <= completionDate)&&(c.SlaExitDate == null))
        updateCases.add(c.Id);
        }
    if (updateCases.isEmpty() == false)
        milestoneUtils.completeMilestone(updateCases, 'Resolution Time', completionDate);
    }
}