trigger LC_Gross_Net_Trigger on Event_s_Details__c (after update) {
    if(trigger.isAfter && trigger.isUpdate) {
        LC_Gross_Net_Helper.calculateTotals(trigger.new);
    }
}