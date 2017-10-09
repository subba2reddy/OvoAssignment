public with sharing class PriceListController {
    
    @AuraEnabled
    public static Event__c getPrices(Id EventId) {
        
        //Event__c curEvent = [SELECT Pricing_Restoration_Levy__c, Pricing_Facility_Fee__c, 
        //                     	(SELECT Price_Type__c, Description__c, Sales_Channel__c, Display_Priority__c, 
        //                         	Offer_Type_Number__c, Password_Server_ID__c, DID__C, Qualifier_Qualifiers__c, 
		//								Mask__c, Mask_Level__c, Cosell__c, Secondary_Settle_code__c, Offer_Info__c FROM Prices__r) 
		//									FROM  Event__c where Id=:EventId];
        //
		//return the data
		//Return JSON.serialize(curEvent);
		//
//        Return [SELECT Price_Type__c, Description__c, Sales_Channel__c, Display_Priority__c, 
//                                 	Offer_Type_Number__c, Password_Server_ID__c, DID__C, Qualifier_Qualifiers__c, 
//										Mask__c, Mask_Level__c, Cosell__c, Secondary_Settle_code__c, Offer_Info__c FROM Price__c where Event__c=:EventId];
//										
		Event__c curEvent = [SELECT Pricing_Restoration_Levy__c, Pricing_Facility_Fee__c, 
                             	(SELECT Price_Type__c, Description__c, Sales_Channel__c, Display_Priority__c, 
                                 	Offer_Type_Number__c, Password_Server_ID__c, DID__C, Qualifier_Qualifiers__c, 
										Mask__c, Mask_Level__c, Cosell__c, Secondary_Settle_code__c, Offer_Info__c FROM Prices__r) 
											FROM  Event__c where Id=:EventId];
        Return curEvent;
     }
    
    @AuraEnabled
    public static String delPrice(Price__c priceToDel)
    {
        try{
            System.debug('Prices Deletion');
            delete priceToDel;
            return 'success';
        }
        catch(Exception e) 
        {
            return e.getMessage();
        }
        
    }
    
    @AuraEnabled
    public static void savePrice(Price__c price, ID eventId, String priceLevels)
    {
        System.debug('price details: ' +  price);
        
        if(price.Id == null){
            price.Event__c = eventId;
        }
        List<Price_Levels__c> priceLevelsList = (List<Price_Levels__c>)System.JSON.deserialize(priceLevels, List<Price_Levels__c>.class);
        System.debug('price levels: ' +  priceLevels);
        try{
            upsert price;
            System.debug('price Id: ' + price.Id);
            try{

                for(integer i=0; i < priceLevelsList.size(); i++){
                    System.debug('Price_Type__c: ' + priceLevelsList[i].Price_Type__c);
                    if(priceLevelsList[i].Price_Type__c == null){
                    	priceLevelsList[i].Price_Type__c = price.Id;    
                    }
                }

                upsert priceLevelsList;
            }catch(Exception err){
                System.debug('Price Level error: ' + err.getMessage());
            }
        }catch(Exception e){
            System.debug('Price error: ' + e.getMessage());
        }
    }
    
    @AuraEnabled
    public static List<Price__c> getPrice(Id priceId) {
        
        return [SELECT 
                Price_Type__c,
                Description__c,
                Sales_Channel__c,
                Display_Priority__c,
                Offer_Type_Number__c,
                Password_Server_ID__c,
                DID__C,
                Qualifier_Qualifiers__c,
                Mask__c,
                Mask_Level__c,
                Cosell__c,
                Secondary_Settle_code__c,
                Offer_Info__c
                FROM Price__c 
                WHERE Id=:priceId];
    }
    
    @AuraEnabled
    public static List<Price_Levels__c> getPriceLevels(ID priceTypeId) {
        System.debug('priceTypeId: ' + priceTypeId);
/*        List<Price_Levels__c> priceLevels = [SELECT Price__c,
                Facility_fee__c,
                Service_Charge__c,
                Price_Type__c
                FROM Price_Levels__c 
                WHERE Price_Type__c=:PriceTypeId];
        
//        priceLevels.sort();
        System.debug('price levels: ' + priceLevels);
        string retStr = JSON.serialize(priceLevels);
        //return priceLevels;
        System.debug('price retstr: ' + retStr);
        return retStr; */
        
        
        
        return [SELECT Price__c,
                Facility_fee__c,
                Service_Charge__c,
                Price_Type__c
                FROM Price_Levels__c 
                WHERE Price_Type__c=:PriceTypeId order by Name]; 
        
        
    }
    
    @AuraEnabled
    public static void updateFacilityFee(List<Price__c> prices){
        upsert prices;
    }
    
    @AuraEnabled
    public static void updateRestorationLevy(ID eventId, Decimal levyValue){
        Try{
            Event__c curEvent = [SELECT Pricing_Restoration_Levy__c FROM Event__c where id=:eventId LIMIT 1];
            curEvent.Pricing_Restoration_Levy__c = levyValue;
            
            Update curEvent;            
        }
        Catch(Exception ex){
			System.debug('Error - ' + ex.getMessage());
            throw new AuraHandledException('Error while saving Restoration Levy.');
        }
    }

	@AuraEnabled
    public static void changeFacilityFee(ID eventId, Decimal FacilityFee){
        List<Price_Levels__c> priceLevels = new List<Price_Levels__c>();
        
        Try{
            Event__c curEvent = [SELECT Pricing_Facility_Fee__c FROM Event__c where id=:eventId LIMIT 1];
            curEvent.Pricing_Facility_Fee__c = FacilityFee;
            //update event with the facility fees
            Update curEvent; 
            
            //now check and update price levels with facility fees if there are any
/* price */            List<Price__c> curPrices = [SELECT id, (SELECT id,  Facility_fee__c FROM Price_Levels__r) FROM Price__c where Event__c=:eventId];
            
            for(Price__c curPrice:curPrices){
                for(Price_Levels__c curPriceLevel : curPrice.Price_Levels__r){
                    curPriceLevel.Facility_fee__c = FacilityFee;
                    priceLevels.add(curPriceLevel);
                }
            }
            
            if(priceLevels.size() > 0){
                System.debug('Halo - ' + curPrices.size());
                update priceLevels; 
            }
        }
        Catch(Exception ex){
			System.debug('Error - ' + ex.getMessage());
            throw new AuraHandledException('Error while saving Facility Fee.');            
        }
    }    
}