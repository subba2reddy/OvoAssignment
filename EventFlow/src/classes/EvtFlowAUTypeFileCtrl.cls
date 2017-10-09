public class EvtFlowAUTypeFileCtrl {
	Private static String AUTTextFileContent = '';
    Private static String eventID = '';
    
    @auraEnabled
    public static string generateAUTypeFiles(String evtId, Boolean dateBased, String strtDate, String endDate){
        Boolean firstEntry = true;
        String retValue = '';
        String strFileContent = '';
        String strFileName = '';
        String strPCIInfo = '';
        String strCommentLine = '';
        Final String tktMsg1 = 'Please note: There is a ticket Limit of ';
        Final String tktMsg2 = 'tickets per person and per credit card on this event';
        Map<string, Master_Charts__c> masterCharts;
        eventID = evtId;
        AUTTextFileContent = '';
        
        System.debug('1. Check for Template');
        
        Try{
            // There should be only one template
            for(StaticResource srObject:[select id, body from StaticResource Where Name = 'AUTTemplate']){
                strFileContent = srObject.body.toString();
            }
             if(strFileContent == ''){
                //no AU Type template
                System.debug('Cannot find template file.');
                throw new AuraHandledException('No Template File');
            }
			//we found an AUT Template 
            //get the event object 
            Event__c evtObj = [select id, name, Host_Id__c, Settlement_Code__c, Primary__c, Secondary__c, COBO_From_To__c, PCI_Information__c, COBO_CHARGE__c, Handling_Fee__c, Secure_Post__c, 
                               		Ticketfast_Delivery__c, Post_Out__c, Act__r.ObjectToolActId__c, INTERNATIONAL_POST_ITV_ONLY__c, FEDEX_EU_USA_ITV_ONLY__c, FEDEX_INTERNATIONAL_ITV_ONLY__c,
                               			Infoke__c, Act__r.Name, Tertiary__c, Tertiary_Privilege__c, Quaternary__c, Quaternary_Privilege__c, Quinary__c, Quinnary_Privilege__c, Senary__c,
                      						Senary_Privilege__c, Septenary__c, Septenary_Privilege__c, Octonary__c, Octonary_Privilege__c, Nonary__c, Nonary_Privilege__c, ATP_On_Off__c, 
                               					Single_On_Off__c, ISM__c, Graphical_Map__c, Onsale__c, Attributes_1__c, Attributes_2__c, Ticket_Limit__c, Act__r.Act_Major_Category__r.Name, 
                               						Act__r.Act_Minor_Category__r.Minor_Category_ID__c, Secondary_Act__r.ObjectToolActId__c, Invoicer__r.Promoter_ID__c, Promoter_1__r.Promoter_ID__c, 
                               							Venue__r.Zone__c, ITV_override__c, Venue__r.Name from Event__c where id =:eventID LIMIT 1];
            //get the performances associated with the event
            List<Performance__c> evtPerformances = getPerformanceData(dateBased, strtDate, endDate);
            //get presales data
            List<Presale__c> preSales = [select name, Presale__c, End__c from Presale__c where event__r.id =: eventID order by Presale__c ASC];
            
            if(evtPerformances.size() > 0){
				//get master charts as a map with the event code
				masterCharts = initializeMasterCharts(evtPerformances);
            }
            else{
                //no performamce on the event
                System.debug('Cannot find any performance for the event.');
                throw new AuraHandledException('No Performance');                             
            }
            
            //read the performances and process them one by one
            for(Performance__c curPerformance: evtPerformances){
				//if first entry then get the event code to be used as filename
                if(firstEntry){
                    strFileName = curPerformance.event_code__c.toUpperCase() + '.TXT';
                    firstEntry = false;
                }                
                //start processing file entry for current performance													//Line No - Data
                System.debug('Master Chart - ' + curPerformance.Master_Chart__c);
                System.debug('Event Code - ' + curPerformance.event_code__c);
                System.debug('Event Date - ' + getPerformanceDateTime(curPerformance, 'dd-MMM-yy'));
                addLinesToAUTText(curPerformance.Master_Chart__c);														//1 - Master chart
                addLinesToAUTText(curPerformance.event_code__c.toUpperCase());											//2 - Event Code
                addLinesToAUTText(getPerformanceDateTime(curPerformance, 'dd-MMM-yy'));									//3 - performance date; format - 13-Aug-18
				addLinesToAUTText(getPerformanceDateTime(curPerformance, 'HH:mm'));										//4 - performance date; format - 20:00
                addLinesToAUTText(evtObj.Host_Id__c);																	//5 - Host Id
                addLinesToAUTText(evtObj.Act__r != null ? evtObj.Act__r.ObjectToolActId__c : '');						//6 - Primary Act Id
                addLinesToAUTText(evtObj.Secondary_Act__r != null ? evtObj.Secondary_Act__r.ObjectToolActId__c : '');	//7 - Secondary Act Id
                addLinesToAUTText(evtObj.Act__r != null ? evtObj.Act__r.Act_Major_Category__r.Name.toUpperCase() : '');	//8 - Act Major Category Name
                addLinesToAUTText(evtObj.Act__r != null ? evtObj.Act__r.Act_Minor_Category__r.Minor_Category_ID__c:'');	//9 - Minor category id
                addLinesToAUTText(evtObj.Promoter_1__r != null ? evtObj.Promoter_1__r.Promoter_ID__c : '');				//10- Promoter 1 ID
                addLinesToAUTText(evtObj.Invoicer__r != null ? evtObj.Invoicer__r.Promoter_ID__c : '');					//11- Invoicer ID
                addLinesToAUTText(evtObj.Settlement_Code__c);															//12- Settlement Code
                addLinesToAUTText(masterCharts.get(curPerformance.Master_Chart__c).TXT_Line_1__c);						//13- Text Line 1
                addLinesToAUTText(masterCharts.get(curPerformance.Master_Chart__c).TXT_Line_2__c);						//14- Text Line 2
                addLinesToAUTText(masterCharts.get(curPerformance.Master_Chart__c).TXT_Line_3__c);						//15- Text Line 3
                addLinesToAUTText(masterCharts.get(curPerformance.Master_Chart__c).TXT_Line_4__c);						//16- Text Line 4
                if(masterCharts.get(curPerformance.Master_Chart__c).TXT_Line_5__c != '' && 
                  					masterCharts.get(curPerformance.Master_Chart__c).TXT_Line_5__c != null ){
                    addLinesToAUTText(masterCharts.get(curPerformance.Master_Chart__c).TXT_Line_5__c);					//17- Text Line 5
                    addLinesToAUTText(getPerformanceDateTime(curPerformance,'EEE dd-MMM-yy HH:mm'));					//18- Performance date; format - TUE 13-Aug-18 20:00
                }
                else{
                    addLinesToAUTText(getPerformanceDateTime(curPerformance, 'DAY PERFORMANCE TTTT'));					//17- Performance date; format - TUESDAY EVENING 20:00
                    addLinesToAUTText(getPerformanceDateTime(curPerformance, 'dd MMMMMMMMM yyyy'));						//18- Performance date; format - 13 AUGUST 2018
                }
                addLinesToAUTText(masterCharts.get(curPerformance.Master_Chart__c).EXTCOM_Line_1__c);					//19- Extcom Line 1
                addLinesToAUTText(masterCharts.get(curPerformance.Master_Chart__c).EXTCOM_Line_2__c);					//20- Extcom Line 2
                addLinesToAUTText(masterCharts.get(curPerformance.Master_Chart__c).EXTCOM_Line_3__c);					//21- Extcom Line 3
                addLinesToAUTText(masterCharts.get(curPerformance.Master_Chart__c).EXTCOM_Line_4__c);					//22- Extcom Line 4
                addLinesToAUTText(masterCharts.get(curPerformance.Master_Chart__c).EXTCOM_Line_5__c);					//23- Extcom Line 5
                addLinesToAUTText(masterCharts.get(curPerformance.Master_Chart__c).EXTCOM_Line_6__c);					//24- Extcom Line 6
                addLinesToAUTText(masterCharts.get(curPerformance.Master_Chart__c).EXTCOM_Line_7__c);					//25- Extcom Line 7
                addLinesToAUTText(masterCharts.get(curPerformance.Master_Chart__c).EXTCOM_Line_8__c);					//26- Extcom Line 8
                addLinesToAUTText(masterCharts.get(curPerformance.Master_Chart__c).EXTCOM_Line_9__c);					//27- Extcom Line 9
                strCommentLine = (evtObj.Name != null ? evtObj.Name.toUpperCase() + '/' : '');
                strCommentLine = strCommentLine + 
                    				(evtObj.Venue__r != null ? evtObj.Venue__r.Name.toUpperCase() + '/' : '');
                addLinesToAUTText( strCommentLine + getPerformanceDateTime(curPerformance, 'EEE HH:mm')); 				//28- Comment - Event Name/Venue Name/Day Time
                addLinesToAUTText(getDeleteDate(curPerformance));														//29- Delete Date; format 13-Aug-18
				addLinesToAUTText(getLastMail(evtObj.COBO_From_To__c));													//30- Last Mail = -(COBO From To + 2)
                addLinesToAUTText('');																					//31- Blank line
                addLinesToAUTText(curPerformance.event_code__c.toUpperCase());											//32- Event Code
                addLinesToAUTText(evtObj.COBO_CHARGE__c != null ? String.valueOf(evtObj.COBO_CHARGE__c) : '');			//33- COBO Value
                addLinesToAUTText('COBO CHARGE');																		//34- COBO Description
                addLinesToAUTText(evtObj.Handling_Fee__c != null ? String.valueOf(evtObj.Handling_Fee__c) : '');		//35- Handling Fee
                addLinesToAUTText('HANDLING FEES');																		//36- Handling Fee Description
                addLinesToAUTText(evtObj.Secure_Post__c != null ? String.valueOf(evtObj.Secure_Post__c) : '');			//37- Secure Post
                addLinesToAUTText('SECURE POST');																		//38- Secure Post Description
                addLinesToAUTText(evtObj.Ticketfast_Delivery__c != null ? 
                                  							String.valueOf(evtObj.Ticketfast_Delivery__c) : '');		//39- Ticket Fast
                addLinesToAUTText('TICKETFAST PROCESSING');																//40- Ticket Fast Description
                addLinesToAUTText(evtObj.Post_Out__c != null ? String.valueOf(evtObj.Post_Out__c) : '');				//41- Post Out
                addLinesToAUTText('POST OUT');																			//42- Post Out Description                
                addLinesToAUTText(curPerformance.event_code__c.toUpperCase());											//43- Event Code
                if(evtObj.COBO_CHARGE__c == null || evtObj.COBO_CHARGE__c == 0){
                    addLinesToAUTText('NO');																			//44- NO if COBO value is blank
                }
                else{
                    addLinesToAUTText('YES');																			//44- YES if COBO has a value
                }

                if(evtObj.Post_Out__c == null || evtObj.Post_Out__c == 0){
                    addLinesToAUTText('NO');																			//45- NO if Post out value is blank
                }
                else{
                    addLinesToAUTText('YES');																			//45- YES if Post out has a value
                }

                if(evtObj.Secure_Post__c == null || evtObj.Secure_Post__c == 0){
                    addLinesToAUTText('NO');																			//46- NO if Secure Post value is blank
                }
                else{
                    addLinesToAUTText('YES');																			//46- YES if Secure Post has a value
                }

                if(evtObj.INTERNATIONAL_POST_ITV_ONLY__c == true){
                    addLinesToAUTText('YES');																			//47- YES if International post is checked
                }
                else{
                    addLinesToAUTText('NO');																			//47- NO if International post is not checked
                }

                if(evtObj.FEDEX_EU_USA_ITV_ONLY__c == true){
                    addLinesToAUTText('YES');																			//48- YES if Fedex EU US is checked
                }
                else{
                    addLinesToAUTText('NO');																			//48- NO if Fedex EU US is not checked
                }
 
                if(evtObj.FEDEX_INTERNATIONAL_ITV_ONLY__c == true){
                    addLinesToAUTText('YES');																			//49- YES if Fedex International is checked
                }
                else{
                    addLinesToAUTText('NO');																			//49- NO if Fedex International is not checked
                }
                
                if(evtObj.Ticketfast_Delivery__c == null || evtObj.Ticketfast_Delivery__c == 0){
                    addLinesToAUTText('NO');																			//50- NO if Ticket Fast value is blank
                }
                else{
                    addLinesToAUTText('YES');																			//50- YES if Ticket Fast has a value
                }
                addLinesToAUTText(curPerformance.event_code__c.toUpperCase());											//51- Event Code  
                addLinesToAUTText(evtObj.Infoke__c);																	//52- INFOKE
                addLinesToAUTText(evtObj.Primary__c != null ? evtObj.Primary__c.toUpperCase() : '');					//53- Primary
                addLinesToAUTText(evtObj.Secondary__c != null ? evtObj.Secondary__c.toUpperCase() : '');				//54- Secondary
                addLinesToAUTText(evtObj.Tertiary__c != null ? evtObj.Tertiary__c.toUpperCase() : '');					//55- Tertiary
                addLinesToAUTText(evtObj.Tertiary_Privilege__c);														//56- Tertiary Priviledge
                addLinesToAUTText(evtObj.Quaternary__c != null ? evtObj.Quaternary__c.toUpperCase() : '');				//57- Quaternary
                addLinesToAUTText(evtObj.Quaternary_Privilege__c);														//58- Quaternary Priviledge
                addLinesToAUTText(evtObj.Quinary__c != null ? evtObj.Quinary__c.toUpperCase() : '');					//59- Quinary
                addLinesToAUTText(evtObj.Quinnary_Privilege__c);														//60- Quinary Priviledge
                addLinesToAUTText(evtObj.Senary__c != null ? evtObj.Senary__c.toUpperCase() : '');						//61- Senary
                addLinesToAUTText(evtObj.Senary_Privilege__c);															//62- Senary Priviledge
                addLinesToAUTText(evtObj.Septenary__c != null ? evtObj.Septenary__c.toUpperCase() : '');				//63- Septenary
                addLinesToAUTText(evtObj.Septenary_Privilege__c);														//64- Septenary Priviledge
                addLinesToAUTText(evtObj.Octonary__c != null ? evtObj.Octonary__c.toUpperCase() : '');					//65- Octonary
                addLinesToAUTText(evtObj.Octonary_Privilege__c);														//66- Octonary Priviledge                
                addLinesToAUTText(evtObj.Nonary__c != null ? evtObj.Nonary__c.toUpperCase() : '');						//67- Nonary
                addLinesToAUTText(evtObj.Nonary_Privilege__c);															//68- Nonary Priviledge
                addLinesToAUTText(evtObj.ATP_On_Off__c != null ? evtObj.ATP_On_Off__c.toUpperCase() : '');				//69- ATP ON/OFF
                addLinesToAUTText(evtObj.Single_On_Off__c != null ? evtObj.Single_On_Off__c.toUpperCase() : '');		//70- Single ON/OFF
                addLinesToAUTText(evtObj.Venue__r != null ? evtObj.Venue__r.Zone__c : '');								//71- Venue Zone
                addLinesToAUTText(curPerformance.event_code__c.toUpperCase());											//72- Event Code 
                addLinesToAUTText(evtObj.ITV_override__c != null ? evtObj.ITV_override__c.toUpperCase() : '');			//73- ITV Override 
                addLinesToAUTText(evtObj.ISM__c != null ? String.valueOf(evtObj.ISM__c) : '');							//74- ISM Value 
                addLinesToAUTText(evtObj.Graphical_Map__c != null ? evtObj.Graphical_Map__c : '');						//75- Graphical Map 
                addLinesToAUTText(evtObj.Onsale__c != null ? evtObj.Onsale__c.format('dd-MMM-yy').toUpperCase() : '');	//76- On Sale Date; format - 14-Aug-18 
                addLinesToAUTText(evtObj.Onsale__c != null ? evtObj.Onsale__c.format('HH:mm') : '');					//77- On Sale Date; format - 20:00
                addLinesToAUTText(evtObj.Onsale__c != null ? evtObj.Onsale__c.format('dd-MMM-yy').toUpperCase() : '');	//78- On Sale Date; format - 14-Aug-18 
                addLinesToAUTText(evtObj.Onsale__c != null ? evtObj.Onsale__c.format('HH:mm') : '');					//79- On Sale Date; format - 20:00
                //lines 80 to 114 - pre sales data
                for(Integer i = 0; i < 7 ; i++){
                    if(i < preSales.size()){
                        // if presales has value put it here
                        addLinesToAUTText(preSales.get(i).Presale__c != null ? preSales.get(i).Presale__c.format('dd-MMM-yy').toUpperCase() : '');
                        addLinesToAUTText(preSales.get(i).Presale__c != null ? preSales.get(i).Presale__c.format('HH:mm') : '');
                        addLinesToAUTText(preSales.get(i).End__c != null ? preSales.get(i).End__c.format('dd-MMM-yy').toUpperCase() : '');
                        addLinesToAUTText(preSales.get(i).End__c != null ? preSales.get(i).End__c.format('HH:mm') : '');
                        addLinesToAUTText(preSales.get(i).name);
                    }
                    else{
                        // else put blank spaces on all of it
                        addLinesToAUTText('');
                        addLinesToAUTText('');
                        addLinesToAUTText('');
                        addLinesToAUTText('');
                        addLinesToAUTText('');                       
                    }
                }
                addLinesToAUTText(curPerformance.event_code__c.toUpperCase());											//115- Event Code 
                strPCIInfo = '';
                if(evtObj.PCI_Information__c != null){
                	strPCIInfo = 'PCI0' + evtObj.PCI_Information__c.replaceFirst(' ','~');
                }
                addLinesToAUTText(strPCIInfo);																			//116- PCI Information
                
                if(evtObj.ITV_override__c != null && evtObj.ITV_override__c != ''){
                	addLinesToAUTText(evtObj.ITV_override__c.toUpperCase());											//117- ITV Override if it has a value
                }
                else{
                    addLinesToAUTText(evtObj.Act__r != null ? evtObj.Act__r.Name.toUpperCase() : '');					//117- Else Primary Act Name
                }
                
                addLinesToAUTText(evtObj.Attributes_1__c);																//118- Attribute 1 value
                addLinesToAUTText(evtObj.Attributes_2__c);																//119- Attribute 2 value
                
                if(evtObj.Ticket_Limit__c != null && evtObj.Ticket_Limit__c != 0){
                    addLinesToAUTText('1');																				//120- 1 if ticket limit has a value
                    addLinesToAUTText(String.valueOf(evtObj.Ticket_Limit__c));											//121- value of ticket limit if it has a value
                    addLinesToAUTText(curPerformance.event_code__c.toUpperCase());										//122- Event Code
                    addLinesToAUTText(tktMsg1 + String.valueOf(evtObj.Ticket_Limit__c));								//123- value of ticket limit if it has a value
                    addLinesToAUTText(tktMsg2);																			//124- value of ticket limit if it has a value
                }else{
                    addLinesToAUTText('');																				//120- else blank
                    addLinesToAUTText('');																				//121- else blank
                    addLinesToAUTText(curPerformance.event_code__c.toUpperCase());										//122- Event Code
                    addLinesToAUTText('');																				//123- else blank
                    addLinesToAUTText('');																				//124- else blank                    
                }
            }
            //all done - now generate the files and attach it
            retValue = genFilesAndAttach(strFileContent, strFileName);
            //return the message
            return retValue;
        }
        catch(exception ex){
            //handle the error message to be passed to lightning here
            if(ex.getTypeName() == 'System.AuraHandledException'){
                If(strFileContent == ''){
                    throw new AuraHandledException('Unable to find the template file on the Event!!!');
                }
                else{
                    throw new AuraHandledException('No Performances found for the event!!!');
                }
            }
            else{
                throw new AuraHandledException('Error while creating the template files - ' + ex.getMessage());    
            } 
        }
    }
    
    
	//get the list of performances
    public static List<Performance__c> getPerformanceData(Boolean dateBased, String strtDate, String endDate){
        //if date based fire query based on the date else without dates
        List<Performance__c> evtPerformances = new List<Performance__c>();
        try{
            if(dateBased == true){
                System.debug('dateBased');
                List<String> strDates = strtDate.split('-');
                DateTime startTime = DateTime.newInstance(Integer.valueOf(strDates.get(0)), Integer.valueOf(strDates.get(1)), Integer.valueOf(strDates.get(2)));
                strDates = endDate.split('-');
                DateTime endTime = DateTime.newInstance(Integer.valueOf(strDates.get(0)), Integer.valueOf(strDates.get(1)), Integer.valueOf(strDates.get(2)) + 1);
                System.debug('Start Time - ' + startTime);
                System.debug('End Time - ' + endTime);
                evtPerformances = [select Event_Code__c, Master_Chart__c, Date_Time__c, Day__c, Performance__c from Performance__c where Event__r.id =:eventID 
                                       and Date_Time__c >:startTime and Date_Time__c <:endTime ORDER BY Date_Time__c];
            }
            else{
                System.debug('Without Date');
                evtPerformances = [select Event_Code__c, Master_Chart__c, Date_Time__c, Day__c, Performance__c 
                                                                                        from Performance__c where Event__r.id =:eventID ORDER BY Date_Time__c];
            }
            return evtPerformances;
        }
        catch(Exception ex){
            throw new AuraHandledException('Error while retrieving performances - ' + ex.getMessage());
        }
    }

    
    //get the master charts ready for use
    public static Map<string, Master_Charts__c> initializeMasterCharts(List<Performance__c> evtPerformances){
        //get master chart data for the performances
        //Map<String, String> masterChartNames = new Map<String, String>();
        Map<string, Master_Charts__c> masterChartsMap = new Map<string, Master_Charts__c>();
        Set<String> masterChartNames = new Set<String>();
        
        Try{
            for(Performance__c tmpPerf: evtPerformances){
                //create a set of master chart names to query all master objects for the performance
                masterChartNames.add(tmpPerf.master_chart__c);
            }
            
            List<Master_Charts__c> tmpMasterCharts = [select id, name, TXT_Line_1__c, TXT_Line_2__c, TXT_Line_3__c, TXT_Line_4__c, TXT_Line_5__c, EXTCOM_Line_1__c, EXTCOM_Line_2__c, 
                                                            EXTCOM_Line_3__c, EXTCOM_Line_4__c, EXTCOM_Line_5__c, EXTCOM_Line_6__c, EXTCOM_Line_7__c, EXTCOM_Line_8__c, EXTCOM_Line_9__c 
                                                                from Master_Charts__c where Event__c =:eventID and name in:masterChartNames];
            
            
            for(Master_Charts__c curMasterChart: tmpMasterCharts){
                //create a map between master chart name and master charts object
                masterChartsMap.put(curMasterChart.Name, curMasterChart);
            }
            
            return masterChartsMap;           
        }
        catch(Exception ex){
            throw new AuraHandledException('Error while retrieving master charts - ' + ex.getMessage());
        }
    }
    

    //returns performance date time based on 
    public static string getPerformanceDateTime(Performance__c curPerformance, String dateFormat){
        String dateFormated;
        Try{
            if(dateFormat == 'DAY PERFORMANCE TTTT'){
                //date format example -> THURSDAY EVENING 20:00
                dateFormated = curPerformance.Day__c + ' ' + curPerformance.Performance__c +  ' ' + curPerformance.Date_Time__c.format('HH:mm');
            }
            else{
                // just return based on the format
                dateFormated = curPerformance.Date_Time__c.format(dateFormat).toUpperCase();
            }
            Return dateFormated;            
        }
        catch(Exception ex){
            throw new AuraHandledException('Error while formatting date and time - ' + ex.getMessage());
        }
    }

    
    //get the delete date based on teh peroformance
    private static string getDeleteDate(Performance__c curPerformance){
        Try{
            DateTime deleteDate = curPerformance.Date_Time__c.addDays(90);
            Return deleteDate.format('dd-MMM-yy').toUpperCase(); // return delete date in format 13-Aug-18            
        }
        Catch(Exception ex){
            throw new AuraHandledException('Error while formatting delete date - ' + ex.getMessage());
        }

    }

    
    //get last mail
    private static string getLastMail(Decimal coboFromTo){
        Try{
            If(coboFromTo == null || coboFromTo == 0){
                Return ''; 											// blank if no value
            }
            else{
                Return ('-' + (String.valueOf(coboFromTo + 2)));	// else - (COBO FROM TO + 2)
            }            
        }
        Catch(Exception ex){
        	throw new AuraHandledException('Error while formatting last mail - ' + ex.getMessage());    
        }
    }
    
    
    //method to add a line to the AUT text file
    private static void addLinesToAUTText(String nextLine){
        if(nextLine == null){
            //if there is no value pass add an empty string
            nextLine = '';
        }
        AUTTextFileContent = AUTTextFileContent + nextLine + '\r\n';
    }
    
    
    //create files and attach it to the event
    public static string genFilesAndAttach(String templateFile, String strFilename){
        try{
            System.Debug('Inside Generate Files');
            //create the text file
            createFiles(strFilename, AUTTextFileContent);
            
            //now create the AUT file
            String tplFileCont = templateFile.replace('EVENTFILE, PROMPT', strFilename);
            String tplFileName = strFilename.replace('TXT', 'AUT');
            
            createFiles(tplFileName, tplFileCont);
            
            Return 'Created AUT and Text Files - ' + tplFileName + ' & ' + strFilename + '.';           
        }
        catch(exception ex){
            throw new AuraHandledException('Error while generating the files - ' + ex.getMessage());
        }
    }
    
    
    //do the actual creation of file and attach
    private static void createFiles(String strFileName, String fileContent){
        Try{
            List<id> contIds = new List<id>();
            for(ContentDocumentLink cvLinked:[select ContentDocumentId from ContentDocumentLink where LinkedEntityId =:eventID]){
                contIds.add(cvLinked.ContentDocumentId);
            }
            
            //check if the file exists before creating it
            List<ContentVersion> cvCol = [select id, ContentDocumentId from ContentVersion where title =:strFilename and ContentDocumentId in:contIds];
            ContentVersion cv = new ContentVersion();
            
            if(cvCol.size() > 0){
				//if the file exists then just update the content
				ContentVersion cvOld = cvCol.get(0);
                cv.ContentDocumentId = cvOld.ContentDocumentId;
                System.debug('Updated file version - ' + strFilename);
                cv.ReasonForChange = 'New Version Generated';
            }

            //create a version of the file first for text file
            cv.ContentLocation = 'S';
            System.debug(strFilename + ' -- ' + fileContent);
            cv.VersionData = Blob.valueOf(fileContent);
            cv.Title = strFilename;
            cv.PathOnClient = strFilename;
            insert cv;
            System.debug('Created file version - ' + strFilename);
            
            if(cvCol.size() == 0){
                //create a document link only if a new file is uploaded
                ContentDocumentLink cdl = new ContentDocumentLink();
                cdl.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id].ContentDocumentId;
                cdl.LinkedEntityId = eventID;
                cdl.ShareType = 'V';
                insert cdl;
                System.debug('Created file link');                     
            }
        }
        catch(Exception ex){
            throw new AuraHandledException('Error while generating the files - ' + ex.getMessage());
        }
    }    
}