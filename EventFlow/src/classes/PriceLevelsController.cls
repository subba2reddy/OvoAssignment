public with sharing class PriceLevelsController {
	
/*    @AuraEnabled
    public static List<Price_Levels__c> getPriceLevels(String priceTypeId) {
        System.debug('priceTypeId: ' + priceTypeId);
        return [SELECT Price__c,
                Facility_fee__c,
                Service_Charge__c
                FROM Price_Levels__c 
                WHERE Price_Type__c=:PriceTypeId];
	}
    
*/
    @AuraEnabled
    public static String getPriceLevels(ID priceTypeId) {
        System.debug('priceTypeId: ' + priceTypeId);
        
        List<Price_Levels__c> priceLevels = [SELECT Price__c,
                								Facility_fee__c,
                                                Service_Charge__c
                                                FROM Price_Levels__c 
                                                WHERE Price_Type__c=:PriceTypeId order by name];
        System.debug('Count: ' + priceLevels.size());
        String returnJSON = JSON.serialize(priceLevels);
        System.debug('Return JSON - ' + returnJSON);
        return returnJSON;
	}    
    
    @AuraEnabled
    public static string deletePriceLevels(Price_Levels__c priceLevel)
    {
        try
        {
        	delete PriceLevel;
            return 'PriceLevel record successfully deleted';
        }catch(Exception e)
        {
            return e.getMessage();
        }
        
    }
}