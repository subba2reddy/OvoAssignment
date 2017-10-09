public class EvtFlowMasterChartCtrl {
	@auraEnabled
    public static string getMasterCharts(String EvtId){
		//get the master charts for the event
        List<Master_Charts__c> masterCharts = [SELECT id, Name, TXT_Line_1__c, EXTCOM_Line_1__c, TXT_Line_2__c, EXTCOM_Line_2__c, TXT_Line_3__c, EXTCOM_Line_3__c, 
                                               	TXT_Line_4__c, EXTCOM_Line_4__c, TXT_Line_5__c, EXTCOM_Line_5__c, EXTCOM_Line_6__c, EXTCOM_Line_7__c, EXTCOM_Line_8__c,
                                              	EXTCOM_Line_9__c FROM Master_Charts__c WHERE Event__r.id=:EvtId];
		//form json and return
        String returnJSON = JSON.serialize(masterCharts);
        System.debug(returnJSON);
        Return returnJSON;
    }
    
	@auraEnabled
    public static string saveMasterCharts(String jsonMC){
        Try{
            //get the master charts for the event
            List<Master_Charts__c> masterCharts = (List<Master_Charts__c>)System.JSON.deserialize(jsonMC, List<Master_Charts__c>.class);
            
            //update the master charts   
            update masterCharts;
            
            return 'Master Charts updated succefully!!';
        }
        catch(exception ex){
            Return ex.getMessage();
        }
    }    
}