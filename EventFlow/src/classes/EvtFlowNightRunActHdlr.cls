@RestResource(urlMapping='/NightRunData/PCT_PACT/*')
global with sharing Class EvtFlowNightRunActHdlr {
	Private static XmlStreamWriter xmlWriter;
    
    @HttpGet
    global static string getChangedData(){
         String retString = '';

        Try{
        	Datetime lastSyncTime = Datetime.valueOf(RestContext.request.params.get('lastSyncTime'));
            
            List<Act__c> changedActs = [SELECT Name, Migrated_Night_Run_ID__c, Night_Run_ID__c, CreatedBy.Night_Run_ID__c, ObjectToolActId__c, CreatedDate, LastModifiedDate, LastModifiedBy.Night_Run_ID__c,
                                        	Act_Major_Category__r.Name, Act_Minor_Category__r.Name, Act_Minor_Category__r.Minor_Category_ID__c FROM Act__c WHERE LastModifiedDate >=: lastSyncTime];
            
            System.debug('Last Sync Time - ' + lastSyncTime);
            xmlWriter = new XmlStreamWriter();
			xmlWriter.writeStartDocument(null, '1.0');
            xmlWriter.writeStartElement(null, 'DATA', null);
            for(Act__c curAct: changedActs){
                xmlWriter.writeStartElement(null, 'ACT', null);																															//start of the Act
                
                if(curAct.Migrated_Night_Run_ID__c != null && curAct.Migrated_Night_Run_ID__c != ' ' ){																					//Act ID
                    writeToXML('Id', curAct.Migrated_Night_Run_ID__c);
                    writeToXML('CUFlag', 'U');
                }
                else{
                    writeToXML('Id', EvtFlowNightRunCallHdlr.checkForNullString(curAct.Night_Run_ID__c));
                    writeToXML('CUFlag', curAct.CreatedDate >= lastSyncTime ? 'I' : 'U');
                }
                
				writeToXML('Actno', EvtFlowNightRunCallHdlr.checkForNullString(curAct.ObjectToolActId__c));																				//Act No
                writeToXML('Actname', EvtFlowNightRunCallHdlr.checkForNullString(curAct.Name));																							//Act Name
                writeToXML('Major', curAct.Act_Major_Category__c != null ? EvtFlowNightRunCallHdlr.checkForNullString(curAct.Act_Major_Category__r.Name) : ' ' );						//Major Category
                writeToXML('Minor', curAct.Act_Minor_Category__c != null ? EvtFlowNightRunCallHdlr.checkForNullString(curAct.Act_Minor_Category__r.Name) : ' ' );						//Minor Category
                writeToXML('Minor', curAct.Act_Minor_Category__c != null ? EvtFlowNightRunCallHdlr.checkForNullString(curAct.Act_Minor_Category__r.Minor_Category_ID__c) : ' ' );		//Minor Category ID
                writeToXML('Createdate', curAct.CreatedDate != null ? EvtFlowNightRunCallHdlr.getFormattedDate(curAct.CreatedDate) : '<NULL VALUE>');									//true if print hard copy is set
                writeToXML('Createtime', EvtFlowNightRunCallHdlr.getFormattedTime(curAct.CreatedDate));																					//Created Time
				writeToXML('Createby', EvtFlowNightRunCallHdlr.checkForNullString(curAct.CreatedBy.Night_Run_ID__c));																	//Created By Night Run ID
				writeToXML('Updatedate', curAct.LastModifiedDate != null ? EvtFlowNightRunCallHdlr.getFormattedDate(curAct.LastModifiedDate) : '<NULL VALUE>');							//Updated date
                writeToXML('Updatetime', EvtFlowNightRunCallHdlr.getFormattedTime(curAct.LastModifiedDate));																			//Created Time
                writeToXML('Updateby', EvtFlowNightRunCallHdlr.checkForNullString(curAct.LastModifiedBy.Night_Run_ID__c));																//updated by
                
                xmlWriter.writeEndElement();
            }
          	xmlWriter.writeEndElement();
			xmlWriter.writeEndDocument();
            
            retString = xmlWriter.getXmlString();
            Return retString;
        }
        Catch(Exception ex){
            System.debug('Error - ' + ex.getMessage());
            System.debug('Error at Line - ' + ex.getLineNumber());
            Return retString;
        }       
    }
    
    private static void writeToXML(String strElementName, String strElementValue){
        xmlWriter.writeStartElement(null, strElementName, null);
        If(strElementValue != '<NULL VALUE>'){
            xmlWriter.writeCharacters(strElementValue);
        }
        xmlWriter.writeEndElement();
    }
}