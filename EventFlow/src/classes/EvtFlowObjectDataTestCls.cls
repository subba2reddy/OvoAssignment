@isTest
private class EvtFlowObjectDataTestCls {

    static testMethod void testObjectToolDataCreation(){
        //test for creation of 10 records at a time
        Integer i;
        Act__c actRecord;
        List<Act__c> actRecords = New List<Act__c>();
        ObjectToolData__c objectData;
        List<ObjectToolData__c> objRecords = New List<ObjectToolData__c>();
        
        
        //start by creating 8 Act Records
        for(i = 0; i<8 ; i++){
            actRecord = new Act__c();
            actRecord.Name = 'John Maynard_' + i;
            actRecords.add(actRecord);
        }
        
        //insert the Act Records
        Database.Insert(actRecords);
        
        //create the Object Tool data now
        for(i = 0; i<8 ; i++){
            objectData = new ObjectToolData__c();
            objectData.Name = 'John Maynard_' + i;
            objectData.Artist_ID__c = '' + i;
            objectData.ActId__c = '' + i;
            objRecords.add(objectData);
        }
        
        //insert the Object Tool Data
        Database.Insert(objRecords); 
        
        //now check for if data is correct
        String likeName = 'John Maynard%';
        for(Act__c actResult: [Select name, Object_Tool_Name__r.name from Act__c where name like:likeName]){
            System.assertEquals(actResult.name, actResult.Object_Tool_Name__r.name);
        }
    }
}