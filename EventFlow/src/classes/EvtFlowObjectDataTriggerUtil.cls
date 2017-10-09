public class EvtFlowObjectDataTriggerUtil {
    
    // handler after insert trigger
    public static void afterInsert(List<ObjectToolData__c> newObjActData){
        Map<string, id> actNames = new Map<string, id>();
        Map<string, id> majorCategories = new Map<string, id>();
        Map<string, id> minorCategories = new Map<string, id>();
        List<Act__c> actRecords;
        Try{
            //get flag to check if data migration is running
            Boolean chkMigration = [select Active__c from EventFlow_Customizing__mdt where MasterLabel = 'Migration' LIMIT 1].Active__c;
            
            //bulkify - get names of all created
            for(ObjectToolData__c curActData: newObjActData){
                System.Debug('New Object Tool Data - ' + curActData.name + ', Act Id - ' + curActData.ActId__c + ', ID - ' + curActData.id);
                if(chkMigration){
                    //if migration then map based on act id
                    actNames.put(curActData.ActId__c, curActData.id);
                    majorCategories.put(curActData.ActId__c, curActData.Act_Major_Category__c);
                    minorCategories.put(curActData.ActId__c, curActData.Act_Minor_Category__c);                          
                }
                else{
                    //else map based on the name of act
                    actNames.put(curActData.name, curActData.id);
                    majorCategories.put(curActData.name, curActData.Act_Major_Category__c);
                    minorCategories.put(curActData.name, curActData.Act_Minor_Category__c);                    
                }
            }
            
            //Bulkify - get all act records with the name
            if(chkMigration){
                actRecords = [select id, MigrationActId__c, name, Object_Tool_Name__c from Act__c where MigrationActId__c in:actNames.keyset()];
            }
            else{
            	actRecords = [select id, MigrationActId__c, name, Object_Tool_Name__c from Act__c where name in:actNames.keyset()];    
            }
            
    
            //update the relationship      
            for(Act__c curActRec: actRecords){
                if(chkMigration){
                    //else records to be matched based on the name
                    System.Debug('Act Id found - ' + curActRec.MigrationActId__c);
                    curActRec.Object_Tool_Name__c = actNames.get(curActRec.MigrationActId__c);
                    curActRec.Act_Major_Category__c = majorCategories.get(curActRec.MigrationActId__c);
                    curActRec.Act_Minor_Category__c = minorCategories.get(curActRec.MigrationActId__c);                             
                }
                else{
                    //else records to be matched based on the name
                    System.Debug('Act Found - ' + curActRec.name);
                    curActRec.Object_Tool_Name__c = actNames.get(curActRec.name);
                    curActRec.Act_Major_Category__c = majorCategories.get(curActRec.name);
                    curActRec.Act_Minor_Category__c = minorCategories.get(curActRec.name);                    
                }
            }
            
            //update all records now
            Database.update(actRecords, false);           
        }
        catch (exception ex){
            System.debug('Exception in Object Data Trigger - ' + ex.getMessage());
        }
    }
}