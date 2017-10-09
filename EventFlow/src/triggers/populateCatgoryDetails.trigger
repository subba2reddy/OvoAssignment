trigger populateCatgoryDetails on Purchase_Order_Festival_Republic__c (before insert,before update,after update) {
	
	/*if((Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate))){
		set <ID> setCategoryIDs = new Set<ID>();
		for(Purchase_Order_Festival_Republic__c POFR: Trigger.new){
			setCategoryIDs.add(POFR.Category__c);
		}
		Category__c[] cats = [Select c.Category_Name__c, c.Category_Codes__c From Category__c c where ID in:setCategoryIDs];
		for(Purchase_Order_Festival_Republic__c POFR: Trigger.new){
			for(Category__c c:cats){
				if(POFR.Category__c == c.Id){
					POFR.Category_Code__c = c.Category_Codes__c;
					POFR.Category_Name__c = c.Category_Name__c;
				}
			}
		}
	}
	if(Trigger.isUpdate && Trigger.isBefore){
		set <ID> setCategoryIDs = new Set<ID>();
		for(Integer i=0; i<Trigger.old.size(); i++)
        {
			Purchase_Order_Festival_Republic__c oldPO = Trigger.old[i];
        	Purchase_Order_Festival_Republic__c newPO = Trigger.new[i];
        	if(oldPO.Invoiced_Amount__c != newPO.Invoiced_Amount__c){
				setCategoryIDs.add(newPO.Category__c);
        	}
        }
        	Category__c[] cats = [Select c.Category_Name__c,c.Invoiced_Amount__c, c.Category_Codes__c From Category__c c where ID in:setCategoryIDs];
        	for(Integer j=0; j<Trigger.old.size(); j++)
        	{
        		Purchase_Order_Festival_Republic__c oldPO = Trigger.old[j];
        		Purchase_Order_Festival_Republic__c newPO = Trigger.new[j];
        		if(oldPO.Invoiced_Amount__c != newPO.Invoiced_Amount__c){
					for(Category__c c:cats){
						if(newPO.Category__c == c.Id){
							if(c.Invoiced_Amount__c!= null){
								c.Invoiced_Amount__c += newPO.Invoiced_Amount__c;
							}else{
								c.Invoiced_Amount__c = newPO.Invoiced_Amount__c;
							}
							
						}
					}
        		}
        	}
        	update cats;
        
	}*/
}