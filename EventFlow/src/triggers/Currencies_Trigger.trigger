trigger Currencies_Trigger on Currencies__c (after update) {
	if(trigger.isAfter && trigger.isUpdate) {
        Currencies_Helper.calculateTotals(trigger.new);
    }
}