trigger FRUpdateLastPONumber on Purchase_Order_Festival_Republic__c (after insert) {

Purchase_Order_Festival_Republic__c myPO = trigger.new[0];
System.assert(myPO != null);

string FestivalID = myPO.Festival__c;

Festival__c myFestival = [select id, Last_PO_Number__c from Festival__c where ID = :FestivalID];
system.assert(myFestival != null);

myFestival.Last_PO_Number__c = myFestival.Last_PO_Number__c + 1;

update myFestival;

}