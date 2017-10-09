@RestResource(urlMapping='/NightRunData/PCT/*')
global with sharing Class EvtFlowNightRunCallHdlr {
    Private static Map<string, String> host2System;
    Private static XmlStreamWriter xmlWriter;
    
    @HttpGet
    global static string getChangedData(){
        String retString = '';

        Try{
        	Datetime lastSyncTime = Datetime.valueOf(RestContext.request.params.get('lastSyncTime'));
            
            IntializeData();
            
            List<Event__c> newEvents = [SELECT Host__c, Event_Code_Prefix__c, Night_Run_ID__c, Name, Start_Date__c, End_date__c, Embargo__c, ATP_On_Off__c, Ticket_Stock_Category__c, COBO_CHARGE__c,
                                        	Ticket_Stock_Name__c, COBO_No_Charge__c, Dupes_Requested__c, COBO_From_To__c, Groups_Allowed__c, CreatedDate, LastModifiedDate, Ticket_Limit__c, Online_Id__c, 
                                        		Attributes_1__c, Status__c, Promoter_Id__c, Date_Time_Checked__c, Checked_By__r.Night_Run_ID__c, Ticketfast_Delivery__c, PCI_Information__c, ITV_override__c, 
                                        			Alternative_Name_1__c, Alternative_Name_2__c, Alternative_Name_3__c, Alternative_Name_4__c, Comment__c, Settlement_Code__c, ATP_Date__c, Reason_No_ATP__c, 
                                        				Download__c, SSBD_Group__c, Print_Hard_Copy__c, LastModifiedBy.Night_Run_ID__c,  Venue__r.Name, Venue__r.Migrated_Night_Run_ID__c, Venue__r.Semetra_Online_ID__c, 
                                        					Invoicer__r.name, CreatedBy.Night_Run_ID__c, Venue__r.Zone__c, Venue__r.Semetra_Venue_Type__c, Venue__r.Night_Run_ID__c, Act__r.Migrated_Night_Run_ID__c, 
                                        						Act__r.Night_Run_ID__c, Secondary_Act__r.Name, Secondary_Act__r.Migrated_Night_Run_ID__c, Secondary_Act__r.Night_Run_ID__c, Barcode_Modes__c, Invoicer__r.id, 
                                        							Act__r.name, Act__r.ObjectToolActId__c, Act__r.Act_Major_Category__r.Major_Category_ID__c, Ticket_Stock_Name__r.Name, Act__r.Act_Major_Category__r.name, 
                                        								Act__r.Act_Minor_Category__r.name, Act__r.Act_Minor_Category__r.Minor_Category_ID__c,Secondary_Act__r.ObjectToolActId__c, Print_Run_Name__r.Night_Run_ID__c, 
                                        									Owner_Night_Run_ID__c, (select Sales_Channel__c FROM Prices__r)
                                  												FROM Event__c WHERE LastModifiedDate >=: lastSyncTime];
            System.debug('Last Sync Time - ' + lastSyncTime);
            xmlWriter = new XmlStreamWriter();
			xmlWriter.writeStartDocument(null, '1.0');
            xmlWriter.writeStartElement(null, 'DATA', null);
            for(Event__c curEvent: newEvents){
                xmlWriter.writeStartElement(null, 'EVENT', null);																						//start of the event
               
				writeToXML('ID', checkForNullString(curEvent.Night_Run_ID__c));																			//Night Run Id
                writeToXML('SYSTEM', curEvent.Host__c != null ? host2System.get(curEvent.Host__c) : ' ');												//Host Id
                writeToXML('PREFIX', checkForNullString(curEvent.Event_Code_Prefix__c));																//Venue Prefix
                writeToXML('VENUE', curEvent.Venue__c != null ? checkForNullString(curEvent.Venue__r.Name) : ' ');										//Venue Name
                writeToXML('EVENTNAME', checkForNullString(curEvent.Name));																				//Event Name
                System.debug('Event Name' + curEvent.Name);
                if(curEvent.Act__c != null && curEvent.Act__r.Act_Major_Category__c != null){															//Major Category
                    writeToXML('MAJOR_CAT', checkForNullString(curEvent.Act__r.Act_Major_Category__r.name));
                }
                else{
                    writeToXML('MAJOR_CAT', ' ');
                }
                
                if(curEvent.Act__c != null && curEvent.Act__r.Act_Minor_Category__c != null){															//Minor Category
                    writeToXML('MINOR_CAT', checkForNullString(curEvent.Act__r.Act_Minor_Category__r.name));
                }
                else{
                    writeToXML('MINOR_CAT', ' ');
                }
                
                writeToXML('From', curEvent.Start_Date__c != null ? getFormattedDate(curEvent.Start_Date__c) : '<NULL VALUE>');							//start date
                writeToXML('To', curEvent.End_date__c != null ? getFormattedDate(curEvent.End_date__c) : '<NULL VALUE>');								//end date 
                
                if(curEvent.Embargo__c != null && curEvent.Embargo__c.date() > date.today()){															//if embargo date in future then false else true
                	writeToXML('Info', '0');
                }
                else{
                	writeToXML('Info', '1');
                }
                
                writeToXML('Type', ' ');																												//Oona to clarify
                writeToXML('Atp', curEvent.ATP_On_Off__c == 'On' ? '1': '0');																			//ATP On = 1 else 0
                writeToXML('T_stock', curEvent.Ticket_Stock_Name__c != null ? checkForNullString(curEvent.Ticket_Stock_Name__r.Name): ' ');				//ticket stock name 
                writeToXML('Atp_comm', checkForNullString(curEvent.Reason_No_ATP__c));																	//ATP Comment
              	writeToXML('Comment', checkForNullString(curEvent.Comment__c));																			//Comment
                writeToXML('Invname', curEvent.Invoicer__c != null ? checkForNullString(curEvent.Invoicer__r.name): ' ');								//invoicer name
                writeToXML('Skbd', curEvent.download__c == true ? '1': '0');																			//true if download flag is set							
                
                If((curEvent.COBO_CHARGE__c != null && curEvent.COBO_CHARGE__c != 0.00) 																//if either cobo value or cobo no charge has a value then true
                   	|| (curEvent.COBO_No_Charge__c != null && curEvent.COBO_No_Charge__c != 0.00)){
                    writeToXML('Cobos', 'T');
                }
                else{
                    writeToXML('Cobos', 'F');
                } 
                
                If(curEvent.Dupes_Requested__c != null && curEvent.Dupes_Requested__c != 0.00){															// if dupes requested has a value then 1 else 0
                    writeToXML('Dupes', '1');
                }
                else{
                    writeToXML('Dupes', '0');
                }
                
                writeToXML('No_post', checkForNullDecimal(curEvent.COBO_From_To__c));																	//Cobo from to
                writeToXML('Grp_inv', curEvent.Groups_Allowed__c == 'GROUP SALES ALLOWED' ? '1' : '0');													//group sales
                writeToXML('Zone', curEvent.Venue__c != null ? checkForNullString(curEvent.Venue__r.Zone__c) : ' ');									//venue zone
                writeToXML('Alte1', checkForNullString(curEvent.Alternative_Name_1__c));																//Alternate Name 1
                writeToXML('Alte2', checkForNullString(curEvent.Alternative_Name_2__c));																//Alternate Name 2
                writeToXML('Alte3', checkForNullString(curEvent.Alternative_Name_3__c));																//Alternate Name 3
                writeToXML('Alte4', checkForNullString(curEvent.Alternative_Name_4__c));																//Alternate Name 4
				writeToXML('Ssbdrep', curEvent.Print_Hard_Copy__c == true ? '1' : '0');																	//true if print hard copy is set
                writeToXML('Createdate', curEvent.CreatedDate != null ? getFormattedDate(curEvent.CreatedDate) : '<NULL VALUE>');						//true if print hard copy is set
                writeToXML('Createtime', getFormattedTime(curEvent.CreatedDate));																		//Created Time
				writeToXML('Createby', checkForNullString(curEvent.CreatedBy.Night_Run_ID__c));															//Created By Night Run ID
				writeToXML('Updatedate', curEvent.LastModifiedDate != null ? getFormattedDate(curEvent.LastModifiedDate) : '<NULL VALUE>');				//Updated date
                writeToXML('Updatetime', getFormattedTime(curEvent.LastModifiedDate));																	//Created Time
                writeToXML('Updateby', checkForNullString(curEvent.LastModifiedBy.Night_Run_ID__c));													//updated by
                writeToXML('Vatable', '0');																												//Oona to clarify
                writeToXML('Tmosat1', checkForNullString(curEvent.Attributes_1__c));																	//Attribute 1
                
                If(curEvent.Venue__c != null && curEvent.Venue__r.Semetra_Venue_Type__c == 'System'){													//true if system venue else false
                    writeToXML('Sys_venue', '1');
                }
                else{
                	writeToXML('Sys_venue', '0');
                }
                
                writeToXML('Priact', curEvent.Act__c != null ? checkForNullString(curEvent.Act__r.name) : ' ');											//primary act name
                writeToXML('Priactno', curEvent.Act__c != null ? checkForNullString(curEvent.Act__r.ObjectToolActId__c) : ' ');							//primary act no.
                writeToXML('Secact', curEvent.Act__c != null ? checkForNullString(curEvent.Secondary_Act__r.name) : ' ');								//secondary act name
                writeToXML('Secactno', curEvent.Act__c != null ? checkForNullString(curEvent.Secondary_Act__r.ObjectToolActId__c) : ' ');				//secondary act no.
                
                if(curEvent.Act__c != null && curEvent.Act__r.Act_Minor_Category__c != null){															//minor category no.
                    writeToXML('No', checkForNullString(curEvent.Act__r.Act_Minor_Category__r.Minor_Category_ID__c));
                }
                else{
                    writeToXML('No', ' ');
                }
                
                writeToXML('Onsaletmon', getSalesChannel(curEvent.Prices__r, 'Online'));																//True if online sales
                writeToXML('Onsaleph', getSalesChannel(curEvent.Prices__r, 'Phone'));																	//True if Phone sales
                writeToXML('Onsalebo', getSalesChannel(curEvent.Prices__r, 'Secondary Box Office'));													//True if Secondary box office sales
                writeToXML('Tixl', checkForNullDecimal(curEvent.Ticket_Limit__c));																		//Ticket Limit
                writeToXML('Cobofrda', checkForNullDecimal(curEvent.COBO_From_To__c));																	//COBO from to
                writeToXML('Statusid', ' ');																											//get mapping from Jeff              
                writeToXML('Embargodat', curEvent.Embargo__c != null ? getFormattedDate(curEvent.Embargo__c) : '<NULL VALUE>');							//Updated date
										
                If(curEvent.Venue__c != null){																											//Venue Night Run ID
                    if(curEvent.Venue__r.Migrated_Night_Run_ID__c != null && curEvent.Venue__r.Migrated_Night_Run_ID__c != ' ' ){
                        writeToXML('Venueid', curEvent.Venue__r.Migrated_Night_Run_ID__c);
                    }
                    else{
                        writeToXML('Venueid', checkForNullString(curEvent.Venue__r.Night_Run_ID__c));
                    }
                }
                else{
                	writeToXML('Venueid', ' ');    
                }
                
                writeToXML('Invoicerid', ' ');																											//needs key field
                writeToXML('Promoterid', ' ');																											//needs key field
                
                If(curEvent.Act__c != null){																											//Act Night Run ID
                    if(curEvent.Act__r.Migrated_Night_Run_ID__c != null && curEvent.Act__r.Migrated_Night_Run_ID__c != ' '){
                        writeToXML('Priactid', curEvent.Act__r.Migrated_Night_Run_ID__c);
                    }
                    else{
                        writeToXML('Priactid', checkForNullString(curEvent.Act__r.Night_Run_ID__c));
                    }
                }
                else{
                	writeToXML('Priactid', ' ');    
                }
                
                If(curEvent.Secondary_Act__c != null){																									//Secondary Act Night Run ID
                    if(curEvent.Secondary_Act__r.Migrated_Night_Run_ID__c != null && curEvent.Secondary_Act__r.Migrated_Night_Run_ID__c != ' '){
                        writeToXML('Secactid', curEvent.Secondary_Act__r.Migrated_Night_Run_ID__c);
                    }
                    else{
                        writeToXML('Secactid', checkForNullString(curEvent.Secondary_Act__r.Night_Run_ID__c));
                    }
                }
                else{
                	writeToXML('Secactid', ' ');    
                }
                
                writeToXML('Checkdate', curEvent.Date_Time_Checked__c != null ? getFormattedDate(curEvent.Date_Time_Checked__c) : '<NULL VALUE>');		//check date
				writeToXML('Checktime', getFormattedTime(curEvent.Date_Time_Checked__c));																//check date
                writeToXML('Checkby', curEvent.Checked_By__c != null ? checkForNullString(curEvent.Checked_By__r.Night_Run_ID__c) : ' ');				//checked by
                
                if(curEvent.Ticketfast_Delivery__c != null && curEvent.Ticketfast_Delivery__c != 0.0){													//if ticket fast has a value then true else false
                    writeToXML('Ticketfast', '1');    
                }
                else{
                    writeToXML('Ticketfast', '0');    
                }
                
                writeToXML('Pciinfoid', getPCIInfoKey(curEvent.PCI_Information__c)); 																	//PCI Info key   
               
                if(curEvent.ITV_override__c != null && curEvent.ITV_override__c != ' '){																	//true if itv overide has a value
                    writeToXML('Ignorepact', '1');    
                }
                else{
                    writeToXML('Ignorepact', '0');
                }
                							
                if(curEvent.Barcode_Modes__c == null || curEvent.Barcode_Modes__c == 'Off'){															//if barcode is on then true else off
                    writeToXML('Barcode', '0');
                }
                else{
                    writeToXML('Barcode', '1');
                }
                
                writeToXML('Webpromid', ' ');																											//needs the key
                writeToXML('Accntmgrid', checkForNullString(curEvent.Owner_Night_Run_ID__c));															//Owner Night Run ID
                writeToXML('Printrunid', curEvent.Print_Run_Name__c != null ? checkForNullString(curEvent.Print_Run_Name__r.Night_Run_ID__c) : ' ');   	//Print Run id
                writeToXML('Atpnoid', curEvent.Reason_No_ATP__c != null ? getNoATPKey(curEvent.Reason_No_ATP__c) : ' ');   								//Reason for NO ATP
                writeToXML('Ssbdgrp', curEvent.SSBD_Group__c == true ? '1' : '0');   																	//true if ssbdgroup is set
                writeToXML('Settlecode', checkForNullString(curEvent.Settlement_Code__c));																//settlement code
				writeToXML('Semetraid', curEvent.Online_Id__c != null ? curEvent.Online_Id__c : '0.0');													//semetra id
                writeToXML('Atpdate', curEvent.ATP_Date__c != null ? getFormattedDate(curEvent.ATP_Date__c) : '<NULL VALUE>');							//check date
                writeToXML('CUFlag', curEvent.CreatedDate >= lastSyncTime ? 'I' : 'U');																	//Update Flag
                
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
    
    
    public static string getFormattedDate(Datetime inputDate){
		String outputDate;
        
        if(inputDate != null){
            outputDate = inputDate.format('yyyy-MM-dd');
        }
        return outputDate;            
    }
    
    public static string getFormattedTime(Datetime inputDate){
        String outputTime;
        if(inputDate != null){
            outputTime = inputDate.format('HH:mm');
        }
        else{
            outputTime = ' ';
        }
            
        return outputTime;
    }
    
    private static string getSalesChannel(List<Price__c> evtPrices, String salesChannel){
        String retString = '0';
        
        for(Price__c curPrice:evtPrices){
            if(curPrice.Sales_Channel__c != null && curPrice.Sales_Channel__c.contains(salesChannel)){
                retString = '1';
                break;
            }
        }
        return retString;
    }

    private static string getPCIInfoKey(String pciInfo){
        String retString = ' ';
        
        if(pciInfo == '0 RESERVED/SOFT TIX/STD POST'){
            retString = 'PC-0000001';
        }
        else if(pciInfo == '1 RESERVED/SOFT TIX/SPECIAL DELIVERY'){
            retString = 'PC-0000002';
        }
        else if(pciInfo == '2 RESERVED/HARD TIX/STD POST'){
            retString = 'PC-0000003';
        }       
        else if(pciInfo == '3 RESERVED/HARD TIX/SPECIAL DELIVERY'){
            retString = 'PC-0000004';
        }
        else if(pciInfo == '4 RESERVED & UNRESERVED/SOFT TIX/STD POST'){
            retString = 'PC-0000005';
        }
        else if(pciInfo == '5 RESERVED & UNRESERVED/SOFT TIX/ALL SPECIAL DELIVERY'){
            retString = 'PC-0000006';
        }
        else if(pciInfo == '6 RESERVED & UNRESERVED/SOFT TIX/UNRESERVED=SPECIALDELIVERY'){
            retString = 'PC-0000007';
        }
        else if(pciInfo == '7 RESERVED & UNRESERVED/HARD TIX/STD POST'){
            retString = 'PC-0000008';
        }
        else if(pciInfo == '8 RESERVED & UNRESERVED/HARD TIX/ALL SPECIAL DELIVERY'){
            retString = 'PC-0000009';
        }
        else if(pciInfo == '9 RESERVED & UNRESERVED/HARD TIX/UNRESERVED=SPECIALDELIVERY'){
            retString = 'PC-0000010';
        }
        else if(pciInfo == '10 UNRESERVED/SOFT TIX/STD POST'){
            retString = 'PC-0000011';
        }
        else if(pciInfo == '11 UNRESERVED/SOFT TIX/SPECIAL DELIVERY'){
            retString = 'PC-0000012';
        }        
        else if(pciInfo == '12 UNRESERVED/HARD TIX/STD POST'){
            retString = 'PC-0000013';
        }
        else if(pciInfo == '13 UNRESERVED/HARD TIX/SPECIAL DELIVERY'){
            retString = 'PC-0000014';
        }
        else if(pciInfo == '14 UNRESERVED IN SEPARATE SECTIONS/SOFT TIX/STD POST'){
            retString = 'PC-0000015';
        }
        else if(pciInfo == '15 UNRESERVED IN SEPARATE SECTIONS/SOFT TIX/SPECIAL DELIVERY'){
            retString = 'PC-0000016';
        }
        else if(pciInfo == '16 UNRESERVED IN SEPARATE SECTIONS/HARD TIX/STD POST'){
            retString = 'PC-0000017';
        }
        else if(pciInfo == '17 UNRESERVED IN SEPARATE SECTIONS/HARD TIX/SPECIAL DELIVERY'){
            retString = 'PC-0000018';
        }
        else if(pciInfo == '18 TIMED EVENT'){
            retString = 'PC-0000019';
        }        
        else if(pciInfo == '19 OTHER/NO PCI FLAG'){
            retString = 'PC-0000020';
        }    
        return retString;
    }


    private static string getNoATPKey(String noATPReason){
        String retString = ' ';
        
        if(noATPReason == 'AWAITING HARD TICKETS'){
            retString = 'NA-0000001';
        }
        else if(noATPReason == 'AWAITING EVENT SPECIFIC TICKET STOCK'){
            retString = 'NA-0000002';
        }
        else if(noATPReason == 'AWAITING INSERTS'){
            retString = 'NA-0000003';
        }       
        else if(noATPReason == 'AWAITING WALLETS/CARRIERS'){
            retString = 'NA-0000004';
        }
        else if(noATPReason == 'AWAITING CLIENT APPROVAL - TICKET TEXT'){
            retString = 'NA-0000005';
        }
        else if(noATPReason == 'AWAITING CLIENT APPROVAL - PREVENTING TOUTING'){
            retString = 'NA-0000006';
        }
        else if(noATPReason == 'AWAITING SEATING RECONFIGURATION'){
            retString = 'NA-0000007';
        }
        else if(noATPReason == 'NON-TICKETED EVENT'){
            retString = 'NA-0000008';
        }
        else if(noATPReason == 'MATURED (FINANCE ONLY)'){
            retString = 'NA-0000009';
        }
        else if(noATPReason == 'AWAITING RESEAT'){
            retString = 'NA-0000010';
        }

        return retString;
    }    
    
    public static string checkForNullString(String strValue){
        return (strValue != null ? strValue : ' ');
    }
 
    
    private static string checkForNullDecimal(Decimal decValue){
        return (decValue != null ? String.valueOf(decValue) : '0');
    }
        
    private static void IntializeData(){
        host2System = new Map<string, string>();
        host2System.put('UK1', 'LE');
        host2System.put('UK2', 'IN');
        host2System.put('UK3', 'EU');
        host2System.put('UK4', 'UK');
        host2System.put('UK5', 'U5');
        host2System.put('UK6', 'U6');
    }
    
}