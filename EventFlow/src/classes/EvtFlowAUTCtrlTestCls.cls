@isTest
public class EvtFlowAUTCtrlTestCls {
    
    public static testMethod void testAUTFileGeneration(){ 
        //1.Create Accounts for invoicer and promoter 
        //create the invoicer
        Invoicer__c invoicer = new Invoicer__c();
        invoicer.Name = 'RooWoo';
        invoicer.Promoter_ID__c = '987';
        insert invoicer;
        //create the promoter 1
        Invoicer__c promoter = new Invoicer__c();
        promoter.Name = 'RWANA';
        promoter.Promoter_ID__c = '789';
        insert promoter;        
        
        //2.Create Simetra Venue
        Simetra_Venue__c simetra = new Simetra_Venue__c();
        simetra.Name = 'ParkWay Town';
        simetra.Host_Id__c = '2';
        simetra.Online_Id__c = '23514';
        simetra.TM_Host__c = 'UK2';
        simetra.Active__c = 'y';
        insert simetra;        
        
        //3.Create Venue Record
        Venue__c venue = new Venue__c();
        venue.name = 'ParkWay Town';
		venue.Semetra_Venue_Type__c = 'Allocation';
        venue.Zone__c = '06';
        venue.Venue_Prefix__c = 'pwt';
        venue.Simetra_Venue__c = simetra.Id;
        insert venue;
        
        //4.Create object data performances
        //create object data for primary act
        ObjectToolData__c objDataPrimary = New ObjectToolData__c();
        Act_Major_Category__c majCat = New Act_Major_Category__c();
        majCat.Name = 'CONCERTS';
        majCat.Major_Category_ID__c = '819';
        insert majCat;
        Act_Minor_Category__c minCat = New Act_Minor_Category__c();
        minCat.Act_Major_Category__c = majCat.Id;
        minCat.Name = 'CONCERTS:ROCK/POP';
        minCat.Minor_Category_ID__c = '21';
        insert minCat;
        objDataPrimary.Name = 'Nirvana';
        objDataPrimary.Act_Major_Category__c = majCat.Id;
        objDataPrimary.Act_Minor_Category__c = minCat.Id;
        objDataPrimary.ActId__c = '123';
        insert objDataPrimary;
        //create object data for secondary act
        ObjectToolData__c objDataSecondary = New ObjectToolData__c();
        objDataSecondary.Name = 'Robbie Williams';
        objDataSecondary.Act_Major_Category__c = majCat.Id;
        objDataSecondary.Act_Minor_Category__c = minCat.Id;
        objDataSecondary.ActId__c = '456';        
        insert objDataSecondary;
        
        //5.Create Primary and Secondary Acts
        //create primary Act
        Act__c primaryAct = new Act__c();
        primaryAct.Act_Major_Category__c = majCat.Id;
        primaryAct.Act_Minor_Category__c = minCat.Id;
        primaryAct.Object_Tool_Name__c = objDataPrimary.id;
        primaryAct.Name = 'Nirvana';
        Insert primaryAct;
        //create secondary Act
        Act__c secondaryAct = new Act__c();
        secondaryAct.Act_Major_Category__c = majCat.Id;
        secondaryAct.Act_Minor_Category__c = minCat.Id;
        secondaryAct.Object_Tool_Name__c = objDataSecondary.id;
        secondaryAct.Name = 'Robbie Williams';
        Insert secondaryAct;
        
        //6.Create an Event
        Event__c curEvent = new Event__c();
        DateTime curDate = DateTime.now();
        curEvent.Name = 'Nevermind Tour';
        curEvent.Status__c = 'New';
        curEvent.Start_Date__c = curDate.addDays(30);
        curEvent.End_date__c = curDate.addDays(120);
        curEvent.CAM_Venue__c = 'ParkWay Town';
        curEvent.Needed_By__c = curDate.addDays(10);
        curEvent.Onsale__c = curDate.addDays(15);
        curEvent.ATP_On_Off__c = 'On';
        curEvent.Primary__c = 'Pri';
        curEvent.Groups_Allowed__c = 'GROUP SALES ALLOWED';
        curEvent.PCI_Information__c = '2 RESERVED/HARD TIX/STD POST';
        curEvent.Ticket_Limit__c = 6;
        curEvent.COBO_From_To__c = Double.valueOf(4);
        curEvent.COBO_CHARGE__c = Double.valueOf(2);
        curEvent.Handling_Fee__c = Double.valueOf(3);
        curEvent.Secure_Post__c = Double.valueOf(5);
        curEvent.Ticketfast_Delivery__c = Double.valueOf(6);
        curEvent.Post_Out__c = Double.valueOf(7);
        curEvent.FEDEX_INTERNATIONAL_ITV_ONLY__c = true;
        curEvent.FEDEX_EU_USA_ITV_ONLY__c = True;
        curEvent.INTERNATIONAL_COBO_ITV_ONLY__c = True;
        curEvent.INTERNATIONAL_POST_ITV_ONLY__c = False;
        curEvent.Secondary__c = 'Sec';
        curEvent.Tertiary__c = 'Ter';
        curEvent.Tertiary_Privilege__c = '3';
        curEvent.Quaternary__c = 'Qua';
        curEvent.Quaternary_Privilege__c = '4';
        curEvent.Quinary__c = 'Qui';
        curEvent.Quinnary_Privilege__c = '5';
        curEvent.Senary__c = 'Sen';
        curEvent.Senary_Privilege__c = '6';
        curEvent.Septenary__c = 'Sep';
        curEvent.Septenary_Privilege__c = '7';
        curEvent.Octonary__c = 'Oct';
        curEvent.Octonary_Privilege__c = '8';
        curEvent.Nonary__c = 'Non';
        curEvent.Nonary_Privilege__c = '9';
        curEvent.Infoke__c = 'Info Key';
        curEvent.ITV_override__c = 'OVR';
        curEvent.ISM__c = 5.0;
        curEvent.Attributes_1__c = 'BLACKBUR';
        curEvent.Attributes_2__c = 'BLUES';
        curEvent.Single_On_Off__c = 'On';
        curEvent.Graphical_Map__c = '6';
        curEvent.Invoicer__c = invoicer.Id;
        curEvent.Venue__c = venue.Id;
        curEvent.Promoter_1__c = promoter.id;
        curEvent.Act__c = primaryAct.Id;
        curEvent.Secondary_Act__c = secondaryAct.Id;
        insert curEvent;       
        
        //7.Create Prices
        List<Price__c> prices = new List<Price__c>();
        Price__c curPrice = new Price__c();
        curPrice.Event__c = curEvent.id;
        curPrice.Sales_Channel__c = 'Outlets;Online';           
		prices.add(curPrice);
        curPrice = new Price__c();
        curPrice.Event__c = curEvent.id;
        curPrice.Sales_Channel__c = 'Primary Box Office;Secondary Box Office';
        prices.add(curPrice);
        curPrice = new Price__c();
        curPrice.Event__c = curEvent.id;
        curPrice.Sales_Channel__c = 'Phone;IVR';
        prices.add(curPrice);
        insert prices;
        
        //8.Create pre-sales data
        List<Presale__c> presales = New List<Presale__c>();
        Presale__c curPresale = new Presale__c();
        curPresale.Name = 'PreSale1';
        curPresale.Presale__c = curDate.addDays(22);
        curPresale.End__c = curDate.addDays(29);
        curPresale.Event__c = curEvent.Id;
        presales.add(curPresale);
        curPresale = new Presale__c();
        curPresale.Name = 'PreSale2';
        curPresale.Presale__c = curDate.addDays(23);
        curPresale.End__c = curDate.addDays(29);
        curPresale.Event__c = curEvent.Id;
        presales.add(curPresale);
		curPresale = new Presale__c();
        curPresale.Name = 'PreSale3';
        curPresale.Presale__c = curDate.addDays(24);
        curPresale.End__c = curDate.addDays(29);
        curPresale.Event__c = curEvent.Id;
        presales.add(curPresale);        
        curPresale = new Presale__c();
        curPresale.Name = 'PreSale4';
        curPresale.Presale__c = curDate.addDays(25);
        curPresale.End__c = curDate.addDays(29);
        curPresale.Event__c = curEvent.Id;
        presales.add(curPresale);
        curPresale = new Presale__c();
        curPresale.Name = 'PreSale5';
        curPresale.Presale__c = curDate.addDays(26);
        curPresale.End__c = curDate.addDays(29);
        curPresale.Event__c = curEvent.Id;
        presales.add(curPresale);
        curPresale = new Presale__c();
        curPresale.Name = 'PreSale6';
        curPresale.Presale__c = curDate.addDays(27);
        curPresale.End__c = curDate.addDays(29);
        curPresale.Event__c = curEvent.Id;
        presales.add(curPresale);
        curPresale = new Presale__c();
        curPresale.Name = 'PreSale7';
        curPresale.Presale__c = curDate.addDays(28);
        curPresale.End__c = curDate.addDays(29);
        curPresale.Event__c = curEvent.Id;
        presales.add(curPresale);
		insert presales;
        
        //9.Create Performances
        List<Performance__c> performances = new List<Performance__c>();
        Performance__c curPerformance = new Performance__c();
        curPerformance.Event__c = curEvent.Id;
        curPerformance.Date_Time__c = curDate.addDays(30);
        curPerformance.Master_Chart__c = 'GOE';
        curPerformance.Day__c = 'SATURDAY';
        curPerformance.Performance__c = 'EVENING';
        curPerformance.Event_Code__c = 'pwt1007';
        performances.add(curPerformance);
        curPerformance = new Performance__c();
        curPerformance.Event__c = curEvent.Id;
        curPerformance.Date_Time__c = curDate.addDays(31);
        curPerformance.Master_Chart__c = 'SUN';
        curPerformance.Day__c = 'SUNDAY';
        curPerformance.Performance__c = 'EVENING';
        curPerformance.Event_Code__c = 'pwt1008';
        System.debug('Performance Date - ' + curPerformance.Date_Time__c);
        performances.add(curPerformance);
        curPerformance = new Performance__c();
        curPerformance.Event__c = curEvent.Id;
        curPerformance.Date_Time__c = curDate.addDays(32);
        curPerformance.Master_Chart__c = 'WEKD';
        curPerformance.Day__c = 'MONDAY';
        curPerformance.Performance__c = 'EVENING';
        curPerformance.Event_Code__c = 'pwt1009';
        performances.add(curPerformance);        
        curPerformance = new Performance__c();
        curPerformance.Event__c = curEvent.Id;
        curPerformance.Date_Time__c = curDate.addDays(33);
        curPerformance.Master_Chart__c = 'WEKD';
        curPerformance.Day__c = 'TUESDAY';
        curPerformance.Performance__c = 'EVENING';
        curPerformance.Event_Code__c = 'pwt1010';
        performances.add(curPerformance);
        insert performances;
        
        //10.Call method to generate AUT File without dates
		String createResult = EvtFlowAUTypeFileCtrl.generateAUTypeFiles(curEvent.Id, False, '', '');
        System.assertEquals('Created AUT and Text Files - PWT1007.AUT & PWT1007.TXT.', createResult);
        
        //11.Read and Validate AUT files
        ID contentDocumentId = [select ContentDocumentId from ContentDocumentLink where LinkedEntityId =:curEvent.Id and ContentDocument.title = 'pwt1007.txt' LIMIT 1].ContentDocumentId;
        Blob cvData = [select versionData from ContentVersion where ContentDocumentId =:contentDocumentId LIMIT 1].versionData;
        //get the file content as a string
        String fileContent = cvData.toString();
        //split the full string into each line
        List<String> arrStringContent = fileContent.split('\r\n');
        //now validate each performance line is correct
        String curLine = arrStringContent[0];															//Line 1 is 
        System.assertEquals('GOE', curLine);															//master chart of first performance
        curLine = arrStringContent[1];																	//Line 2 is 
        System.assertEquals('PWT1007', curLine);														//event code of first performance
        curLine = arrStringContent[2];																	//Line 3 is 
        System.assertEquals(curDate.addDays(30).format('dd-MMM-yy').toUpperCase(), curLine);			//Performance date of first performance
        curLine = arrStringContent[3];																	//Line 4 is 
        System.assertEquals(curDate.addDays(30).format('HH:mm'), curLine);								//Performance Time of first performance
        curLine = arrStringContent[4];																	//Line 5 is 
        System.assertEquals('2', curLine);																//Host ID of first performance
        curLine = arrStringContent[5];																	//Line 6 is 
        System.assertEquals('123', curLine);															//Primary Act Id of first performance       
        curLine = arrStringContent[6];																	//Line 7 is 
        System.assertEquals('456', curLine);															//Secondary Act Id of first performance     
        curLine = arrStringContent[7];																	//Line 8 is 
        System.assertEquals('CONCERTS', curLine);														//Act major category name of first performance     
        curLine = arrStringContent[8];																	//Line 9 is 
        System.assertEquals('21', curLine);																//Act minor category id of first performance
        curLine = arrStringContent[9];																	//Line 10 is 
        System.assertEquals('789', curLine);															//Promoter 1 of first performance        
        curLine = arrStringContent[10];																	//Line 11 is 
        System.assertEquals('987', curLine);															//Invoicer of first performance                
        curLine = arrStringContent[11];																	//Line 12 is 
        System.assertEquals('', curLine);																//Settlement Code of first performance  
        curLine = arrStringContent[12];																	//Line 13 is 
        System.assertEquals('ROOWOO PRESENTS', curLine);												//Master Chart Text Line1 of first performance         
        curLine = arrStringContent[13];																	//Line 14 is 
        System.assertEquals('NEVERMIND TOUR', curLine);													//Master Chart Text Line2 of first performance                 
        curLine = arrStringContent[14];																	//Line 15 is 
        System.assertEquals('', curLine);																//Master Chart Text Line3 of first performance    
        curLine = arrStringContent[15];																	//Line 16 is 
        System.assertEquals('PARKWAY TOWN', curLine);													//Master Chart Text Line4 of first performance                 
        curLine = arrStringContent[16];																	//Line 17 is 
        System.assertEquals('SATURDAY EVENING ' + curDate.addDays(30).format('HH:mm'), curLine);		//Master Chart Text Line5 of first performance is blank
        curLine = arrStringContent[17];																	//Line 18 is 
        System.assertEquals(curDate.addDays(30).format('dd MMMMMMMMM yyyy').toUpperCase(), curLine);	//Master Chart Text Line5 of first performance is blank        
        curLine = arrStringContent[18];																	//Line 19 is 
        System.assertEquals('ALLOCATION/HARD TICKETS/TLIMIT=6', curLine);								//Master Chart ExtComm Line1 of first performance        
        curLine = arrStringContent[19];																	//Line 20 is 
        System.assertEquals('OUTLETS,TMON,PBO,SBO,PH,IVR', curLine);									//Master Chart ExtComm Line2 of first performance        
        curLine = arrStringContent[20];																	//Line 21 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line3 of first performance        
        curLine = arrStringContent[21];																	//Line 22 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line4 of first performance         
        curLine = arrStringContent[22];																	//Line 23 is 
        System.assertEquals('GROUP SALES ALLOWED', curLine);											//Master Chart ExtComm Line5 of first performance            
        curLine = arrStringContent[23];																	//Line 24 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line6 of first performance       
        curLine = arrStringContent[24];																	//Line 25 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line7 of first performance               
        curLine = arrStringContent[25];																	//Line 26 is 
        System.assertEquals('ACCOUNT MANAGER: BOYAI PUKHRAMBAM', curLine);								//Master Chart ExtComm Line8 of first performance
        curLine = arrStringContent[26];																	//Line 27 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line9 of first performance
        curLine = arrStringContent[27];																	//Line 28 is 
        System.assertEquals('NEVERMIND TOUR/PARKWAY TOWN/' 
                            + curDate.addDays(30).format('EEE HH:mm').toUpperCase(), curLine);			//Event Name/Venue Name/Date of first performance
        curLine = arrStringContent[28];																	//Line 29 is 
        System.assertEquals(curDate.addDays(120).format('dd-MMM-yy').toUpperCase(), curLine);			//Delete date of first performance
        curLine = arrStringContent[29];																	//Line 30 is 
        System.assertEquals('-6', curLine);																//Last Mail of first performance        
        curLine = arrStringContent[30];																	//Line 31 is 
        System.assertEquals('', curLine);																//Blank Line       
        curLine = arrStringContent[31];																	//Line 32 is 
        System.assertEquals('PWT1007', curLine);														//Event Code of first performance                
        curLine = arrStringContent[32];																	//Line 33 is 
        System.assertEquals('2.00', curLine);															//COBO Value of first performance            
        curLine = arrStringContent[33];																	//Line 34 is 
        System.assertEquals('COBO CHARGE', curLine);													//COBO Description         
        curLine = arrStringContent[34];																	//Line 35 is 
        System.assertEquals('3.00', curLine);															//Handling Fees Value of first performance            
        curLine = arrStringContent[35];																	//Line 36 is 
        System.assertEquals('HANDLING FEES', curLine);													//Handling Fees Description          
        curLine = arrStringContent[36];																	//Line 37 is 
        System.assertEquals('5.00', curLine);															//Secure Post Value of first performance            
        curLine = arrStringContent[37];																	//Line 38 is 
        System.assertEquals('SECURE POST', curLine);													//Secure Post Description  
        curLine = arrStringContent[38];																	//Line 39 is 
        System.assertEquals('6.00', curLine);															//Ticket Fast Value of first performance            
        curLine = arrStringContent[39];																	//Line 40 is 
        System.assertEquals('TICKETFAST PROCESSING', curLine);											//Ticket Fast Description  
        curLine = arrStringContent[40];																	//Line 41 is 
        System.assertEquals('7.00', curLine);															//Post Out Value of first performance            
        curLine = arrStringContent[41];																	//Line 42 is 
        System.assertEquals('POST OUT', curLine);														//Post Out Description  
        curLine = arrStringContent[42];																	//Line 43 is 
        System.assertEquals('PWT1007', curLine);														//Event Code of first performance                
        curLine = arrStringContent[43];																	//Line 44 is 
        System.assertEquals('YES', curLine);															//COBO Charge of first performance has a value
        curLine = arrStringContent[44];																	//Line 45 is 
        System.assertEquals('YES', curLine);															//POST Out of first performance has a value
        curLine = arrStringContent[45];																	//Line 46 is 
        System.assertEquals('YES', curLine);															//Secure Post of first performance has a value
        curLine = arrStringContent[46];																	//Line 47 is 
        System.assertEquals('NO', curLine);																//INTERNATIONAL_POST_ITV_ONLY__c of first performance is false
        curLine = arrStringContent[47];																	//Line 48 is 
        System.assertEquals('YES', curLine);															//FEDEX_EU_USA_ITV_ONLY__c of first performance is true
        curLine = arrStringContent[48];																	//Line 49 is 
        System.assertEquals('YES', curLine);															//FEDEX_INTERNATIONAL_ITV_ONLY__c of first performance is true
        curLine = arrStringContent[49];																	//Line 50 is 
        System.assertEquals('YES', curLine);															//Ticket Fast of first performance has a value
        curLine = arrStringContent[50];																	//Line 51 is 
        System.assertEquals('PWT1007', curLine);														//Event Code of first performance                
        curLine = arrStringContent[51];																	//Line 52 is 
        System.assertEquals('Info Key', curLine);														//Info key of first performance      
        curLine = arrStringContent[52];																	//Line 53 is 
        System.assertEquals('PRI', curLine);															//Primary of first performance      
        curLine = arrStringContent[53];																	//Line 54 is 
        System.assertEquals('SEC', curLine);															//Secondary of first performance      
        curLine = arrStringContent[54];																	//Line 55 is 
        System.assertEquals('TER', curLine);															//Tertiary of first performance      
        curLine = arrStringContent[55];																	//Line 56 is 
        System.assertEquals('3', curLine);																//Tertiary Priviledge of first performance    
        curLine = arrStringContent[56];																	//Line 57 is 
        System.assertEquals('QUA', curLine);															//Quaternary of first performance      
        curLine = arrStringContent[57];																	//Line 58 is 
        System.assertEquals('4', curLine);																//Quaternary Priviledge of first performance    
        curLine = arrStringContent[58];																	//Line 59 is 
        System.assertEquals('QUI', curLine);															//Quinary of first performance      
        curLine = arrStringContent[59];																	//Line 60 is 
        System.assertEquals('5', curLine);																//Quinary Priviledge of first performance    
        curLine = arrStringContent[60];																	//Line 61 is 
        System.assertEquals('SEN', curLine);															//Senary of first performance      
        curLine = arrStringContent[61];																	//Line 62 is 
        System.assertEquals('6', curLine);																//Senary Priviledge of first performance    
        curLine = arrStringContent[62];																	//Line 63 is 
        System.assertEquals('SEP', curLine);															//Septenary of first performance      
        curLine = arrStringContent[63];																	//Line 64 is 
        System.assertEquals('7', curLine);																//Septenary Priviledge of first performance    
        curLine = arrStringContent[64];																	//Line 65 is 
        System.assertEquals('OCT', curLine);															//Octonary of first performance      
        curLine = arrStringContent[65];																	//Line 66 is 
        System.assertEquals('8', curLine);																//Octonary Priviledge of first performance    
        curLine = arrStringContent[66];																	//Line 67 is 
        System.assertEquals('NON', curLine);															//Nonary of first performance      
        curLine = arrStringContent[67];																	//Line 68 is 
        System.assertEquals('9', curLine);																//Nonary Priviledge of first performance    
        curLine = arrStringContent[68];																	//Line 69 is 
        System.assertEquals('ON', curLine);																//ATP ON OFF of first performance      
        curLine = arrStringContent[69];																	//Line 70 is 
        System.assertEquals('ON', curLine);																//Single ON OFF of first performance  
        curLine = arrStringContent[70];																	//Line 71 is 
        System.assertEquals('06', curLine);																//Zone of venue of first performance  
        curLine = arrStringContent[71];																	//Line 72 is 
        System.assertEquals('PWT1007', curLine);														//Event Code of first performance       
        curLine = arrStringContent[72];																	//Line 73 is 
        System.assertEquals('OVR', curLine);															//ITV Override of first performance       
        curLine = arrStringContent[73];																	//Line 74 is 
        System.assertEquals('5', curLine);																//ISM of first performance  
        curLine = arrStringContent[74];																	//Line 75 is 
        System.assertEquals('6', curLine);																//Graphical Map of first performance  
        curLine = arrStringContent[75];																	//Line 76 is 
        System.assertEquals(curDate.addDays(15).format('dd-MMM-yy').toUpperCase(), curLine);			//On Sale Date of first performance
        curLine = arrStringContent[76];																	//Line 77 is 
        System.assertEquals(curDate.addDays(15).format('HH:mm'), curLine);								//On Sale Time of first performance
        curLine = arrStringContent[77];																	//Line 78 is 
        System.assertEquals(curDate.addDays(15).format('dd-MMM-yy').toUpperCase(), curLine);			//On Sale Date of first performance
        curLine = arrStringContent[78];																	//Line 79 is 
        System.assertEquals(curDate.addDays(15).format('HH:mm'), curLine);								//On Sale Time of first performance
        curLine = arrStringContent[79];																	//Line 80 is 
        System.assertEquals(curDate.addDays(22).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale1 start date
        curLine = arrStringContent[80];																	//Line 81 is 
        System.assertEquals(curDate.addDays(22).format('HH:mm'), curLine);								//Presale1 start time        
        curLine = arrStringContent[81];																	//Line 82 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale1 end date        
        curLine = arrStringContent[82];																	//Line 83 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale1 end time        
        curLine = arrStringContent[83];																	//Line 84 is 
        System.assertEquals('PreSale1', curLine);														//Presale1 name         
        curLine = arrStringContent[84];																	//Line 85 is 
        System.assertEquals(curDate.addDays(23).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale2 start date
        curLine = arrStringContent[85];																	//Line 86 is 
        System.assertEquals(curDate.addDays(23).format('HH:mm'), curLine);								//Presale2 start time        
        curLine = arrStringContent[86];																	//Line 87 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale2 end date        
        curLine = arrStringContent[87];																	//Line 88 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale2 end time        
        curLine = arrStringContent[88];																	//Line 89 is 
        System.assertEquals('PreSale2', curLine);														//Presale2 name    
        curLine = arrStringContent[89];																	//Line 90 is 
        System.assertEquals(curDate.addDays(24).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale3 start date
        curLine = arrStringContent[90];																	//Line 91 is 
        System.assertEquals(curDate.addDays(24).format('HH:mm'), curLine);								//Presale3 start time        
        curLine = arrStringContent[91];																	//Line 92 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale3 end date        
        curLine = arrStringContent[92];																	//Line 93 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale3 end time        
        curLine = arrStringContent[93];																	//Line 94 is 
        System.assertEquals('PreSale3', curLine);														//Presale3 name         
        curLine = arrStringContent[94];																	//Line 95 is 
        System.assertEquals(curDate.addDays(25).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale4 start date
        curLine = arrStringContent[95];																	//Line 96 is 
        System.assertEquals(curDate.addDays(25).format('HH:mm'), curLine);								//Presale4 start time        
        curLine = arrStringContent[96];																	//Line 97 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);							//Presale4 end date        
        curLine = arrStringContent[97];																	//Line 98 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale4 end time        
        curLine = arrStringContent[98];																	//Line 99 is 
        System.assertEquals('PreSale4', curLine);														//Presale4 name    
        curLine = arrStringContent[99];																	//Line 100 is 
        System.assertEquals(curDate.addDays(26).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale5 start date
        curLine = arrStringContent[100];																//Line 101 is 
        System.assertEquals(curDate.addDays(26).format('HH:mm'), curLine);								//Presale5 start time        
        curLine = arrStringContent[101];																//Line 102 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale5 end date        
        curLine = arrStringContent[102];																//Line 103 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale5 end time        
        curLine = arrStringContent[103];																//Line 104 is 
        System.assertEquals('PreSale5', curLine);														//Presale5 name    
        curLine = arrStringContent[104];																//Line 105 is 
        System.assertEquals(curDate.addDays(27).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale6 start date
        curLine = arrStringContent[105];																//Line 106 is 
        System.assertEquals(curDate.addDays(27).format('HH:mm'), curLine);								//Presale6 start time        
        curLine = arrStringContent[106];																//Line 107 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale6 end date        
        curLine = arrStringContent[107];																//Line 108 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale6 end time        
        curLine = arrStringContent[108];																//Line 109 is 
        System.assertEquals('PreSale6', curLine);														//Presale6 name         
        curLine = arrStringContent[109];																//Line 110 is 
        System.assertEquals(curDate.addDays(28).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale7 start date
        curLine = arrStringContent[110];																//Line 111 is 
        System.assertEquals(curDate.addDays(28).format('HH:mm'), curLine);								//Presale7 start time        
        curLine = arrStringContent[111];																//Line 112 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale7 end date        
        curLine = arrStringContent[112];																//Line 113 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale7 end time        
        curLine = arrStringContent[113];																//Line 114 is 
        System.assertEquals('PreSale7', curLine);														//Presale7 name           
        curLine = arrStringContent[114];																//Line 115 is 
        System.assertEquals('PWT1007', curLine);														//Event Code of first performance
        curLine = arrStringContent[115];																//Line 116 is 
        System.assertEquals('PCI02~RESERVED/HARD TIX/STD POST', curLine);								//PCI information of first performance          
        curLine = arrStringContent[116];																//Line 117 is 
        System.assertEquals('OVR', curLine);															//ITV Override of first performance       
        curLine = arrStringContent[117];																//Line 118 is 
        System.assertEquals('BLACKBUR', curLine);														//Attribute 1 of first performance   
        curLine = arrStringContent[118];																//Line 119 is 
        System.assertEquals('BLUES', curLine);															//Attribute 2 of first performance
		curLine = arrStringContent[119];																//Line 120 is 
        System.assertEquals('1', curLine);																//Minimum number of tickets          
        curLine = arrStringContent[120];																//Line 121 is 
        System.assertEquals('6', curLine);																//Ticket limit value
        curLine = arrStringContent[121];																//Line 122 is 
        System.assertEquals('PWT1007', curLine);														//Event Code of first performance        
        curLine = arrStringContent[122];																//Line 123 is 
        System.assertEquals('Please note: There is a ticket Limit of 6', curLine);						//Text on the ticket
        curLine = arrStringContent[123];																//Line 124 is 
        System.assertEquals('tickets per person and per credit card on this event', curLine);			//Text on the ticket line 2
        
		//start of second performance
        curLine = arrStringContent[124];																//Line 1 is 
        System.assertEquals('SUN', curLine);															//master chart of second performance
        curLine = arrStringContent[125];																//Line 2 is 
        System.assertEquals('PWT1008', curLine);														//event code of second performance
        curLine = arrStringContent[126];																//Line 3 is 
        System.assertEquals(curDate.addDays(31).format('dd-MMM-yy').toUpperCase(), curLine);			//Performance date of second performance
        curLine = arrStringContent[127];																//Line 4 is 
        System.assertEquals(curDate.addDays(31).format('HH:mm'), curLine);								//Performance Time of second performance
        curLine = arrStringContent[128];																//Line 5 is 
        System.assertEquals('2', curLine);																//Host ID of second performance
        curLine = arrStringContent[129];																//Line 6 is 
        System.assertEquals('123', curLine);															//Primary Act Id of second performance       
        curLine = arrStringContent[130];																//Line 7 is 
        System.assertEquals('456', curLine);															//Secondary Act Id of second performance     
        curLine = arrStringContent[131];																//Line 8 is 
        System.assertEquals('CONCERTS', curLine);														//Act major category name of second performance     
        curLine = arrStringContent[132];																//Line 9 is 
        System.assertEquals('21', curLine);																//Act minor category id of second performance
        curLine = arrStringContent[133];																//Line 10 is 
        System.assertEquals('789', curLine);															//Promoter 1 of second performance        
        curLine = arrStringContent[134];																//Line 11 is 
        System.assertEquals('987', curLine);															//Invoicer of second performance                
        curLine = arrStringContent[135];																//Line 12 is 
        System.assertEquals('', curLine);																//Settlement Code of second performance  
        curLine = arrStringContent[136];																//Line 13 is 
        System.assertEquals('ROOWOO PRESENTS', curLine);												//Master Chart Text Line1 of second performance         
        curLine = arrStringContent[137];																//Line 14 is 
        System.assertEquals('NEVERMIND TOUR', curLine);													//Master Chart Text Line2 of second performance                 
        curLine = arrStringContent[138];																//Line 15 is 
        System.assertEquals('', curLine);																//Master Chart Text Line3 of second performance    
        curLine = arrStringContent[139];																//Line 16 is 
        System.assertEquals('PARKWAY TOWN', curLine);													//Master Chart Text Line4 of second performance                 
        curLine = arrStringContent[140];																//Line 17 is 
        System.assertEquals('SUNDAY EVENING ' + curDate.addDays(31).format('HH:mm'), curLine);			//Master Chart Text Line5 of second performance is blank
        curLine = arrStringContent[141];																//Line 18 is 
        System.assertEquals(curDate.addDays(31).format('dd MMMMMMMMM yyyy').toUpperCase(), curLine);	//Master Chart Text Line5 of second performance is blank        
        curLine = arrStringContent[142];																//Line 19 is 
        System.assertEquals('ALLOCATION/HARD TICKETS/TLIMIT=6', curLine);								//Master Chart ExtComm Line1 of second performance        
        curLine = arrStringContent[143];																//Line 20 is 
        System.assertEquals('OUTLETS,TMON,PBO,SBO,PH,IVR', curLine);									//Master Chart ExtComm Line2 of second performance        
        curLine = arrStringContent[144];																//Line 21 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line3 of second performance        
        curLine = arrStringContent[145];																//Line 22 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line4 of second performance         
        curLine = arrStringContent[146];																//Line 23 is 
        System.assertEquals('GROUP SALES ALLOWED', curLine);											//Master Chart ExtComm Line5 of second performance            
        curLine = arrStringContent[147];																//Line 24 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line6 of second performance       
        curLine = arrStringContent[148];																//Line 25 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line7 of second performance               
        curLine = arrStringContent[149];																//Line 26 is 
        System.assertEquals('ACCOUNT MANAGER: BOYAI PUKHRAMBAM', curLine);								//Master Chart ExtComm Line8 of second performance
        curLine = arrStringContent[150];																//Line 27 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line9 of second performance
        curLine = arrStringContent[151];																//Line 28 is 
        System.assertEquals('NEVERMIND TOUR/PARKWAY TOWN/' 
                            + curDate.addDays(31).format('EEE HH:mm').toUpperCase(), curLine);			//Event Name/Venue Name/Date of second performance
        curLine = arrStringContent[152];																//Line 29 is 
        System.assertEquals(curDate.addDays(121).format('dd-MMM-yy').toUpperCase(), curLine);			//Delete date of second performance
        curLine = arrStringContent[153];																//Line 30 is 
        System.assertEquals('-6', curLine);																//Last Mail of second performance        
        curLine = arrStringContent[154];																//Line 31 is 
        System.assertEquals('', curLine);																//Blank Line       
        curLine = arrStringContent[155];																//Line 32 is 
        System.assertEquals('PWT1008', curLine);														//Event Code of second performance                
        curLine = arrStringContent[156];																//Line 33 is 
        System.assertEquals('2.00', curLine);															//COBO Value of second performance            
        curLine = arrStringContent[157];																//Line 34 is 
        System.assertEquals('COBO CHARGE', curLine);													//COBO Description         
        curLine = arrStringContent[158];																//Line 35 is 
        System.assertEquals('3.00', curLine);															//Handling Fees Value of second performance            
        curLine = arrStringContent[159];																//Line 36 is 
        System.assertEquals('HANDLING FEES', curLine);													//Handling Fees Description          
        curLine = arrStringContent[160];																//Line 37 is 
        System.assertEquals('5.00', curLine);															//Secure Post Value of second performance            
        curLine = arrStringContent[161];																//Line 38 is 
        System.assertEquals('SECURE POST', curLine);													//Secure Post Description  
        curLine = arrStringContent[162];																//Line 39 is 
        System.assertEquals('6.00', curLine);															//Ticket Fast Value of second performance            
        curLine = arrStringContent[163];																//Line 40 is 
        System.assertEquals('TICKETFAST PROCESSING', curLine);											//Ticket Fast Description  
        curLine = arrStringContent[164];																//Line 41 is 
        System.assertEquals('7.00', curLine);															//Post Out Value of second performance            
        curLine = arrStringContent[165];																//Line 42 is 
        System.assertEquals('POST OUT', curLine);														//Post Out Description  
        curLine = arrStringContent[166];																//Line 43 is 
        System.assertEquals('PWT1008', curLine);														//Event Code of second performance                
        curLine = arrStringContent[167];																//Line 44 is 
        System.assertEquals('YES', curLine);															//COBO Charge of second performance has a value
        curLine = arrStringContent[168];																//Line 45 is 
        System.assertEquals('YES', curLine);															//POST Out of second performance has a value
        curLine = arrStringContent[169];																//Line 46 is 
        System.assertEquals('YES', curLine);															//Secure Post of second performance has a value
        curLine = arrStringContent[170];																//Line 47 is 
        System.assertEquals('NO', curLine);																//INTERNATIONAL_POST_ITV_ONLY__c of second performance is false
        curLine = arrStringContent[171];																//Line 48 is 
        System.assertEquals('YES', curLine);															//FEDEX_EU_USA_ITV_ONLY__c of second performance is true
        curLine = arrStringContent[172];																//Line 49 is 
        System.assertEquals('YES', curLine);															//FEDEX_INTERNATIONAL_ITV_ONLY__c of second performance is true
        curLine = arrStringContent[173];																//Line 50 is 
        System.assertEquals('YES', curLine);															//Ticket Fast of second performance has a value
        curLine = arrStringContent[174];																//Line 51 is 
        System.assertEquals('PWT1008', curLine);														//Event Code of second performance                
        curLine = arrStringContent[175];																//Line 52 is 
        System.assertEquals('Info Key', curLine);														//Info key of second performance      
        curLine = arrStringContent[176];																//Line 53 is 
        System.assertEquals('PRI', curLine);															//Primary of second performance      
        curLine = arrStringContent[177];																//Line 54 is 
        System.assertEquals('SEC', curLine);															//Secondary of second performance      
        curLine = arrStringContent[178];																//Line 55 is 
        System.assertEquals('TER', curLine);															//Tertiary of second performance      
        curLine = arrStringContent[179];																//Line 56 is 
        System.assertEquals('3', curLine);																//Tertiary Priviledge of second performance    
        curLine = arrStringContent[180];																//Line 57 is 
        System.assertEquals('QUA', curLine);															//Quaternary of second performance      
        curLine = arrStringContent[181];																//Line 58 is 
        System.assertEquals('4', curLine);																//Quaternary Priviledge of second performance    
        curLine = arrStringContent[182];																//Line 59 is 
        System.assertEquals('QUI', curLine);															//Quinary of second performance      
        curLine = arrStringContent[183];																//Line 60 is 
        System.assertEquals('5', curLine);																//Quinary Priviledge of second performance    
        curLine = arrStringContent[184];																//Line 61 is 
        System.assertEquals('SEN', curLine);															//Senary of second performance      
        curLine = arrStringContent[185];																//Line 62 is 
        System.assertEquals('6', curLine);																//Senary Priviledge of second performance    
        curLine = arrStringContent[186];																//Line 63 is 
        System.assertEquals('SEP', curLine);															//Septenary of second performance      
        curLine = arrStringContent[187];																//Line 64 is 
        System.assertEquals('7', curLine);																//Septenary Priviledge of second performance    
        curLine = arrStringContent[188];																//Line 65 is 
        System.assertEquals('OCT', curLine);															//Octonary of second performance      
        curLine = arrStringContent[189];																//Line 66 is 
        System.assertEquals('8', curLine);																//Octonary Priviledge of second performance    
        curLine = arrStringContent[190];																//Line 67 is 
        System.assertEquals('NON', curLine);															//Nonary of second performance      
        curLine = arrStringContent[191];																//Line 68 is 
        System.assertEquals('9', curLine);																//Nonary Priviledge of second performance    
        curLine = arrStringContent[192];																//Line 69 is 
        System.assertEquals('ON', curLine);																//ATP ON OFF of second performance      
        curLine = arrStringContent[193];																//Line 70 is 
        System.assertEquals('ON', curLine);																//Single ON OFF of second performance  
        curLine = arrStringContent[194];																//Line 71 is 
        System.assertEquals('06', curLine);																//Zone of venue of second performance  
        curLine = arrStringContent[195];																//Line 72 is 
        System.assertEquals('PWT1008', curLine);														//Event Code of second performance       
        curLine = arrStringContent[196];																//Line 73 is 
        System.assertEquals('OVR', curLine);															//ITV Override of second performance       
        curLine = arrStringContent[197];																//Line 74 is 
        System.assertEquals('5', curLine);																//ISM of second performance  
        curLine = arrStringContent[198];																//Line 75 is 
        System.assertEquals('6', curLine);																//Graphical Map of second performance  
        curLine = arrStringContent[199];																//Line 76 is 
        System.assertEquals(curDate.addDays(15).format('dd-MMM-yy').toUpperCase(), curLine);			//On Sale Date of second performance
        curLine = arrStringContent[200];																//Line 77 is 
        System.assertEquals(curDate.addDays(15).format('HH:mm'), curLine);								//On Sale Time of second performance
        curLine = arrStringContent[201];																//Line 78 is 
        System.assertEquals(curDate.addDays(15).format('dd-MMM-yy').toUpperCase(), curLine);			//On Sale Date of second performance
        curLine = arrStringContent[202];																//Line 79 is 
        System.assertEquals(curDate.addDays(15).format('HH:mm'), curLine);								//On Sale Time of second performance
        curLine = arrStringContent[203];																//Line 80 is 
        System.assertEquals(curDate.addDays(22).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale1 start date
        curLine = arrStringContent[204];																//Line 81 is 
        System.assertEquals(curDate.addDays(22).format('HH:mm'), curLine);								//Presale1 start time        
        curLine = arrStringContent[205];																//Line 82 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale1 end date        
        curLine = arrStringContent[206];																//Line 83 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale1 end time        
        curLine = arrStringContent[207];																//Line 84 is 
        System.assertEquals('PreSale1', curLine);														//Presale1 name         
        curLine = arrStringContent[208];																//Line 85 is 
        System.assertEquals(curDate.addDays(23).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale2 start date
        curLine = arrStringContent[209];																//Line 86 is 
        System.assertEquals(curDate.addDays(23).format('HH:mm'), curLine);								//Presale2 start time        
        curLine = arrStringContent[210];																//Line 87 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale2 end date        
        curLine = arrStringContent[211];																//Line 88 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale2 end time        
        curLine = arrStringContent[212];																//Line 89 is 
        System.assertEquals('PreSale2', curLine);														//Presale2 name    
        curLine = arrStringContent[213];																//Line 90 is 
        System.assertEquals(curDate.addDays(24).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale3 start date
        curLine = arrStringContent[214];																//Line 91 is 
        System.assertEquals(curDate.addDays(24).format('HH:mm'), curLine);								//Presale3 start time        
        curLine = arrStringContent[215];																//Line 92 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale3 end date        
        curLine = arrStringContent[216];																//Line 93 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale3 end time        
        curLine = arrStringContent[217];																//Line 94 is 
        System.assertEquals('PreSale3', curLine);														//Presale3 name         
        curLine = arrStringContent[218];																//Line 95 is 
        System.assertEquals(curDate.addDays(25).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale4 start date
        curLine = arrStringContent[219];																//Line 96 is 
        System.assertEquals(curDate.addDays(25).format('HH:mm'), curLine);								//Presale4 start time        
        curLine = arrStringContent[220];																//Line 97 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale4 end date        
        curLine = arrStringContent[221];																//Line 98 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale4 end time        
        curLine = arrStringContent[222];																//Line 99 is 
        System.assertEquals('PreSale4', curLine);														//Presale4 name    
        curLine = arrStringContent[223];																//Line 100 is 
        System.assertEquals(curDate.addDays(26).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale5 start date
        curLine = arrStringContent[224];																//Line 101 is 
        System.assertEquals(curDate.addDays(26).format('HH:mm'), curLine);								//Presale5 start time        
        curLine = arrStringContent[225];																//Line 102 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale5 end date        
        curLine = arrStringContent[226];																//Line 103 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale5 end time        
        curLine = arrStringContent[227];																//Line 104 is 
        System.assertEquals('PreSale5', curLine);														//Presale5 name    
        curLine = arrStringContent[228];																//Line 105 is 
        System.assertEquals(curDate.addDays(27).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale6 start date
        curLine = arrStringContent[229];																//Line 106 is 
        System.assertEquals(curDate.addDays(27).format('HH:mm'), curLine);								//Presale6 start time        
        curLine = arrStringContent[230];																//Line 107 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale6 end date        
        curLine = arrStringContent[231];																//Line 108 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale6 end time        
        curLine = arrStringContent[232];																//Line 109 is 
        System.assertEquals('PreSale6', curLine);														//Presale6 name         
        curLine = arrStringContent[233];																//Line 110 is 
        System.assertEquals(curDate.addDays(28).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale7 start date
        curLine = arrStringContent[234];																//Line 111 is 
        System.assertEquals(curDate.addDays(28).format('HH:mm'), curLine);								//Presale7 start time        
        curLine = arrStringContent[235];																//Line 112 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale7 end date        
        curLine = arrStringContent[236];																//Line 113 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale7 end time        
        curLine = arrStringContent[237];																//Line 114 is 
        System.assertEquals('PreSale7', curLine);														//Presale7 name           
        curLine = arrStringContent[238];																//Line 115 is 
        System.assertEquals('PWT1008', curLine);														//Event Code of second performance
        curLine = arrStringContent[239];																//Line 116 is 
        System.assertEquals('PCI02~RESERVED/HARD TIX/STD POST', curLine);								//PCI information of second performance          
        curLine = arrStringContent[240];																//Line 117 is 
        System.assertEquals('OVR', curLine);															//ITV Override of second performance       
        curLine = arrStringContent[241];																//Line 118 is 
        System.assertEquals('BLACKBUR', curLine);														//Attribute 1 of second performance   
        curLine = arrStringContent[242];																//Line 119 is 
        System.assertEquals('BLUES', curLine);															//Attribute 2 of second performance
		curLine = arrStringContent[243];																//Line 120 is 
        System.assertEquals('1', curLine);																//Minimum number of tickets          
        curLine = arrStringContent[244];																//Line 121 is 
        System.assertEquals('6', curLine);																//Ticket limit value
        curLine = arrStringContent[245];																//Line 122 is 
        System.assertEquals('PWT1008', curLine);														//Event Code of second performance        
        curLine = arrStringContent[246];																//Line 123 is 
        System.assertEquals('Please note: There is a ticket Limit of 6', curLine);						//Text on the ticket
        curLine = arrStringContent[247];																//Line 124 is 
        System.assertEquals('tickets per person and per credit card on this event', curLine);			//Text on the ticket line 2        


		//start of third performance
        curLine = arrStringContent[248];																//Line 1 is 
        System.assertEquals('WEKD', curLine);															//master chart of third performance
        curLine = arrStringContent[249];																//Line 2 is 
        System.assertEquals('PWT1009', curLine);														//event code of third performance
        curLine = arrStringContent[250];																//Line 3 is 
        System.assertEquals(curDate.addDays(32).format('dd-MMM-yy').toUpperCase(), curLine);			//Performance date of third performance
        curLine = arrStringContent[251];																//Line 4 is 
        System.assertEquals(curDate.addDays(32).format('HH:mm'), curLine);								//Performance Time of third performance
        curLine = arrStringContent[252];																//Line 5 is 
        System.assertEquals('2', curLine);																//Host ID of third performance
        curLine = arrStringContent[253];																//Line 6 is 
        System.assertEquals('123', curLine);															//Primary Act Id of third performance       
        curLine = arrStringContent[254];																//Line 7 is 
        System.assertEquals('456', curLine);															//Secondary Act Id of third performance     
        curLine = arrStringContent[255];																//Line 8 is 
        System.assertEquals('CONCERTS', curLine);														//Act major category name of third performance     
        curLine = arrStringContent[256];																//Line 9 is 
        System.assertEquals('21', curLine);																//Act minor category id of third performance
        curLine = arrStringContent[257];																//Line 10 is 
        System.assertEquals('789', curLine);															//Promoter 1 of third performance        
        curLine = arrStringContent[258];																//Line 11 is 
        System.assertEquals('987', curLine);															//Invoicer of third performance                
        curLine = arrStringContent[259];																//Line 12 is 
        System.assertEquals('', curLine);																//Settlement Code of third performance  
        curLine = arrStringContent[260];																//Line 13 is 
        System.assertEquals('ROOWOO PRESENTS', curLine);												//Master Chart Text Line1 of third performance         
        curLine = arrStringContent[261];																//Line 14 is 
        System.assertEquals('NEVERMIND TOUR', curLine);													//Master Chart Text Line2 of third performance                 
        curLine = arrStringContent[262];																//Line 15 is 
        System.assertEquals('', curLine);																//Master Chart Text Line3 of third performance    
        curLine = arrStringContent[263];																//Line 16 is 
        System.assertEquals('PARKWAY TOWN', curLine);													//Master Chart Text Line4 of third performance                 
        curLine = arrStringContent[264];																//Line 17 is 
        System.assertEquals('MONDAY EVENING ' + curDate.addDays(32).format('HH:mm'), curLine);			//Master Chart Text Line5 of third performance is blank
        curLine = arrStringContent[265];																//Line 18 is 
        System.assertEquals(curDate.addDays(32).format('dd MMMMMMMMM yyyy').toUpperCase(), curLine);	//Master Chart Text Line5 of third performance is blank        
        curLine = arrStringContent[266];																//Line 19 is 
        System.assertEquals('ALLOCATION/HARD TICKETS/TLIMIT=6', curLine);								//Master Chart ExtComm Line1 of third performance        
        curLine = arrStringContent[267];																//Line 20 is 
        System.assertEquals('OUTLETS,TMON,PBO,SBO,PH,IVR', curLine);									//Master Chart ExtComm Line2 of third performance        
        curLine = arrStringContent[268];																//Line 21 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line3 of third performance        
        curLine = arrStringContent[269];																//Line 22 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line4 of third performance         
        curLine = arrStringContent[270];																//Line 23 is 
        System.assertEquals('GROUP SALES ALLOWED', curLine);											//Master Chart ExtComm Line5 of third performance            
        curLine = arrStringContent[271];																//Line 24 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line6 of third performance       
        curLine = arrStringContent[272];																//Line 25 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line7 of third performance               
        curLine = arrStringContent[273];																//Line 26 is 
        System.assertEquals('ACCOUNT MANAGER: BOYAI PUKHRAMBAM', curLine);								//Master Chart ExtComm Line8 of third performance
        curLine = arrStringContent[274];																//Line 27 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line9 of third performance
        curLine = arrStringContent[275];																//Line 28 is 
        System.assertEquals('NEVERMIND TOUR/PARKWAY TOWN/' 
                            + curDate.addDays(32).format('EEE HH:mm').toUpperCase(), curLine);			//Event Name/Venue Name/Date of third performance
        curLine = arrStringContent[276];																//Line 29 is 
        System.assertEquals(curDate.addDays(122).format('dd-MMM-yy').toUpperCase(), curLine);			//Delete date of third performance
        curLine = arrStringContent[277];																//Line 30 is 
        System.assertEquals('-6', curLine);																//Last Mail of third performance        
        curLine = arrStringContent[278];																//Line 31 is 
        System.assertEquals('', curLine);																//Blank Line       
        curLine = arrStringContent[279];																//Line 32 is 
        System.assertEquals('PWT1009', curLine);														//Event Code of third performance                
        curLine = arrStringContent[280];																//Line 33 is 
        System.assertEquals('2.00', curLine);															//COBO Value of third performance            
        curLine = arrStringContent[281];																//Line 34 is 
        System.assertEquals('COBO CHARGE', curLine);													//COBO Description         
        curLine = arrStringContent[282];																//Line 35 is 
        System.assertEquals('3.00', curLine);															//Handling Fees Value of third performance            
        curLine = arrStringContent[283];																//Line 36 is 
        System.assertEquals('HANDLING FEES', curLine);													//Handling Fees Description          
        curLine = arrStringContent[284];																//Line 37 is 
        System.assertEquals('5.00', curLine);															//Secure Post Value of third performance            
        curLine = arrStringContent[285];																//Line 38 is 
        System.assertEquals('SECURE POST', curLine);													//Secure Post Description  
        curLine = arrStringContent[286];																//Line 39 is 
        System.assertEquals('6.00', curLine);															//Ticket Fast Value of third performance            
        curLine = arrStringContent[287];																//Line 40 is 
        System.assertEquals('TICKETFAST PROCESSING', curLine);											//Ticket Fast Description  
        curLine = arrStringContent[288];																//Line 41 is 
        System.assertEquals('7.00', curLine);															//Post Out Value of third performance            
        curLine = arrStringContent[289];																//Line 42 is 
        System.assertEquals('POST OUT', curLine);														//Post Out Description  
        curLine = arrStringContent[290];																//Line 43 is 
        System.assertEquals('PWT1009', curLine);														//Event Code of third performance                
        curLine = arrStringContent[291];																//Line 44 is 
        System.assertEquals('YES', curLine);															//COBO Charge of third performance has a value
        curLine = arrStringContent[292];																//Line 45 is 
        System.assertEquals('YES', curLine);															//POST Out of third performance has a value
        curLine = arrStringContent[293];																//Line 46 is 
        System.assertEquals('YES', curLine);															//Secure Post of third performance has a value
        curLine = arrStringContent[294];																//Line 47 is 
        System.assertEquals('NO', curLine);																//INTERNATIONAL_POST_ITV_ONLY__c of third performance is false
        curLine = arrStringContent[295];																//Line 48 is 
        System.assertEquals('YES', curLine);															//FEDEX_EU_USA_ITV_ONLY__c of third performance is true
        curLine = arrStringContent[296];																//Line 49 is 
        System.assertEquals('YES', curLine);															//FEDEX_INTERNATIONAL_ITV_ONLY__c of third performance is true
        curLine = arrStringContent[297];																//Line 50 is 
        System.assertEquals('YES', curLine);															//Ticket Fast of third performance has a value
        curLine = arrStringContent[298];																//Line 51 is 
        System.assertEquals('PWT1009', curLine);														//Event Code of third performance                
        curLine = arrStringContent[299];																//Line 52 is 
        System.assertEquals('Info Key', curLine);														//Info key of third performance      
        curLine = arrStringContent[300];																//Line 53 is 
        System.assertEquals('PRI', curLine);															//Primary of third performance      
        curLine = arrStringContent[301];																//Line 54 is 
        System.assertEquals('SEC', curLine);															//Secondary of third performance      
        curLine = arrStringContent[302];																//Line 55 is 
        System.assertEquals('TER', curLine);															//Tertiary of third performance      
        curLine = arrStringContent[303];																//Line 56 is 
        System.assertEquals('3', curLine);																//Tertiary Priviledge of third performance    
        curLine = arrStringContent[304];																//Line 57 is 
        System.assertEquals('QUA', curLine);															//Quaternary of third performance      
        curLine = arrStringContent[305];																//Line 58 is 
        System.assertEquals('4', curLine);																//Quaternary Priviledge of third performance    
        curLine = arrStringContent[306];																//Line 59 is 
        System.assertEquals('QUI', curLine);															//Quinary of third performance      
        curLine = arrStringContent[307];																//Line 60 is 
        System.assertEquals('5', curLine);																//Quinary Priviledge of third performance    
        curLine = arrStringContent[308];																//Line 61 is 
        System.assertEquals('SEN', curLine);															//Senary of third performance      
        curLine = arrStringContent[309];																//Line 62 is 
        System.assertEquals('6', curLine);																//Senary Priviledge of third performance    
        curLine = arrStringContent[310];																//Line 63 is 
        System.assertEquals('SEP', curLine);															//Septenary of third performance      
        curLine = arrStringContent[311];																//Line 64 is 
        System.assertEquals('7', curLine);																//Septenary Priviledge of third performance    
        curLine = arrStringContent[312];																//Line 65 is 
        System.assertEquals('OCT', curLine);															//Octonary of third performance      
        curLine = arrStringContent[313];																//Line 66 is 
        System.assertEquals('8', curLine);																//Octonary Priviledge of third performance    
        curLine = arrStringContent[314];																//Line 67 is 
        System.assertEquals('NON', curLine);															//Nonary of third performance      
        curLine = arrStringContent[315];																//Line 68 is 
        System.assertEquals('9', curLine);																//Nonary Priviledge of third performance    
        curLine = arrStringContent[316];																//Line 69 is 
        System.assertEquals('ON', curLine);																//ATP ON OFF of third performance      
        curLine = arrStringContent[317];																//Line 70 is 
        System.assertEquals('ON', curLine);																//Single ON OFF of third performance  
        curLine = arrStringContent[318];																//Line 71 is 
        System.assertEquals('06', curLine);																//Zone of venue of third performance  
        curLine = arrStringContent[319];																//Line 72 is 
        System.assertEquals('PWT1009', curLine);														//Event Code of third performance       
        curLine = arrStringContent[320];																//Line 73 is 
        System.assertEquals('OVR', curLine);															//ITV Override of third performance       
        curLine = arrStringContent[321];																//Line 74 is 
        System.assertEquals('5', curLine);																//ISM of third performance  
        curLine = arrStringContent[322];																//Line 75 is 
        System.assertEquals('6', curLine);																//Graphical Map of third performance  
        curLine = arrStringContent[323];																//Line 76 is 
        System.assertEquals(curDate.addDays(15).format('dd-MMM-yy').toUpperCase(), curLine);			//On Sale Date of third performance
        curLine = arrStringContent[324];																//Line 77 is 
        System.assertEquals(curDate.addDays(15).format('HH:mm'), curLine);								//On Sale Time of third performance
        curLine = arrStringContent[325];																//Line 78 is 
        System.assertEquals(curDate.addDays(15).format('dd-MMM-yy').toUpperCase(), curLine);			//On Sale Date of third performance
        curLine = arrStringContent[326];																//Line 79 is 
        System.assertEquals(curDate.addDays(15).format('HH:mm'), curLine);								//On Sale Time of third performance
        curLine = arrStringContent[327];																//Line 80 is 
        System.assertEquals(curDate.addDays(22).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale1 start date
        curLine = arrStringContent[328];																//Line 81 is 
        System.assertEquals(curDate.addDays(22).format('HH:mm'), curLine);								//Presale1 start time        
        curLine = arrStringContent[329];																//Line 82 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale1 end date        
        curLine = arrStringContent[330];																//Line 83 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale1 end time        
        curLine = arrStringContent[331];																//Line 84 is 
        System.assertEquals('PreSale1', curLine);														//Presale1 name         
        curLine = arrStringContent[332];																//Line 85 is 
        System.assertEquals(curDate.addDays(23).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale2 start date
        curLine = arrStringContent[333];																//Line 86 is 
        System.assertEquals(curDate.addDays(23).format('HH:mm'), curLine);								//Presale2 start time        
        curLine = arrStringContent[334];																//Line 87 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale2 end date        
        curLine = arrStringContent[335];																//Line 88 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale2 end time        
        curLine = arrStringContent[336];																//Line 89 is 
        System.assertEquals('PreSale2', curLine);														//Presale2 name    
        curLine = arrStringContent[337];																//Line 90 is 
        System.assertEquals(curDate.addDays(24).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale3 start date
        curLine = arrStringContent[338];																//Line 91 is 
        System.assertEquals(curDate.addDays(24).format('HH:mm'), curLine);								//Presale3 start time        
        curLine = arrStringContent[339];																//Line 92 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale3 end date        
        curLine = arrStringContent[340];																//Line 93 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale3 end time        
        curLine = arrStringContent[341];																//Line 94 is 
        System.assertEquals('PreSale3', curLine);														//Presale3 name         
        curLine = arrStringContent[342];																//Line 95 is 
        System.assertEquals(curDate.addDays(25).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale4 start date
        curLine = arrStringContent[343];																//Line 96 is 
        System.assertEquals(curDate.addDays(25).format('HH:mm'), curLine);								//Presale4 start time        
        curLine = arrStringContent[344];																//Line 97 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale4 end date        
        curLine = arrStringContent[345];																//Line 98 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale4 end time        
        curLine = arrStringContent[346];																//Line 99 is 
        System.assertEquals('PreSale4', curLine);														//Presale4 name    
        curLine = arrStringContent[347];																//Line 100 is 
        System.assertEquals(curDate.addDays(26).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale5 start date
        curLine = arrStringContent[348];																//Line 101 is 
        System.assertEquals(curDate.addDays(26).format('HH:mm'), curLine);								//Presale5 start time        
        curLine = arrStringContent[349];																//Line 102 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale5 end date        
        curLine = arrStringContent[350];																//Line 103 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale5 end time        
        curLine = arrStringContent[351];																//Line 104 is 
        System.assertEquals('PreSale5', curLine);														//Presale5 name    
        curLine = arrStringContent[352];																//Line 105 is 
        System.assertEquals(curDate.addDays(27).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale6 start date
        curLine = arrStringContent[353];																//Line 106 is 
        System.assertEquals(curDate.addDays(27).format('HH:mm'), curLine);								//Presale6 start time        
        curLine = arrStringContent[354];																//Line 107 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale6 end date        
        curLine = arrStringContent[355];																//Line 108 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale6 end time        
        curLine = arrStringContent[356];																//Line 109 is 
        System.assertEquals('PreSale6', curLine);														//Presale6 name         
        curLine = arrStringContent[357];																//Line 110 is 
        System.assertEquals(curDate.addDays(28).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale7 start date
        curLine = arrStringContent[358];																//Line 111 is 
        System.assertEquals(curDate.addDays(28).format('HH:mm'), curLine);								//Presale7 start time        
        curLine = arrStringContent[359];																//Line 112 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale7 end date        
        curLine = arrStringContent[360];																//Line 113 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale7 end time        
        curLine = arrStringContent[361];																//Line 114 is 
        System.assertEquals('PreSale7', curLine);														//Presale7 name           
        curLine = arrStringContent[362];																//Line 115 is 
        System.assertEquals('PWT1009', curLine);														//Event Code of third performance
        curLine = arrStringContent[363];																//Line 116 is 
        System.assertEquals('PCI02~RESERVED/HARD TIX/STD POST', curLine);								//PCI information of third performance          
        curLine = arrStringContent[364];																//Line 117 is 
        System.assertEquals('OVR', curLine);															//ITV Override of third performance       
        curLine = arrStringContent[365];																//Line 118 is 
        System.assertEquals('BLACKBUR', curLine);														//Attribute 1 of third performance   
        curLine = arrStringContent[366];																//Line 119 is 
        System.assertEquals('BLUES', curLine);															//Attribute 2 of third performance
		curLine = arrStringContent[367];																//Line 120 is 
        System.assertEquals('1', curLine);																//Minimum number of tickets          
        curLine = arrStringContent[368];																//Line 121 is 
        System.assertEquals('6', curLine);																//Ticket limit value
        curLine = arrStringContent[369];																//Line 122 is 
        System.assertEquals('PWT1009', curLine);														//Event Code of third performance        
        curLine = arrStringContent[370];																//Line 123 is 
        System.assertEquals('Please note: There is a ticket Limit of 6', curLine);						//Text on the ticket
        curLine = arrStringContent[371];																//Line 124 is 
        System.assertEquals('tickets per person and per credit card on this event', curLine);			//Text on the ticket line 2 
        

		//start of fourth performance
        curLine = arrStringContent[372];																//Line 1 is 
        System.assertEquals('WEKD', curLine);															//master chart of fourth performance
        curLine = arrStringContent[373];																//Line 2 is 
        System.assertEquals('PWT1010', curLine);														//event code of fourth performance
        curLine = arrStringContent[374];																//Line 3 is 
        System.assertEquals(curDate.addDays(33).format('dd-MMM-yy').toUpperCase(), curLine);			//Performance date of fourth performance
        curLine = arrStringContent[375];																//Line 4 is3
        System.assertEquals(curDate.addDays(33).format('HH:mm'), curLine);								//Performance Time of fourth performance
        curLine = arrStringContent[376];																//Line 5 is 
        System.assertEquals('2', curLine);																//Host ID of fourth performance
        curLine = arrStringContent[377];																//Line 6 is 
        System.assertEquals('123', curLine);															//Primary Act Id of fourth performance       
        curLine = arrStringContent[378];																//Line 7 is 
        System.assertEquals('456', curLine);															//Secondary Act Id of fourth performance     
        curLine = arrStringContent[379];																//Line 8 is 
        System.assertEquals('CONCERTS', curLine);														//Act major category name of fourth performance     
        curLine = arrStringContent[380];																//Line 9 is 
        System.assertEquals('21', curLine);																//Act minor category id of fourth performance
        curLine = arrStringContent[381];																//Line 10 is 
        System.assertEquals('789', curLine);															//Promoter 1 of fourth performance        
        curLine = arrStringContent[382];																//Line 11 is 
        System.assertEquals('987', curLine);															//Invoicer of fourth performance                
        curLine = arrStringContent[383];																//Line 12 is 
        System.assertEquals('', curLine);																//Settlement Code of fourth performance  
        curLine = arrStringContent[384];																//Line 13 is 
        System.assertEquals('ROOWOO PRESENTS', curLine);												//Master Chart Text Line1 of fourth performance         
        curLine = arrStringContent[385];																//Line 14 is 
        System.assertEquals('NEVERMIND TOUR', curLine);													//Master Chart Text Line2 of fourth performance                 
        curLine = arrStringContent[386];																//Line 15 is 
        System.assertEquals('', curLine);																//Master Chart Text Line3 of fourth performance    
        curLine = arrStringContent[387];																//Line 16 is 
        System.assertEquals('PARKWAY TOWN', curLine);													//Master Chart Text Line4 of fourth performance                 
        curLine = arrStringContent[388];																//Line 17 is 
        System.assertEquals('TUESDAY EVENING ' + curDate.addDays(33).format('HH:mm'), curLine);			//Master Chart Text Line5 of fourth performance is blank
        curLine = arrStringContent[389];																//Line 18 is 
        System.assertEquals(curDate.addDays(33).format('dd MMMMMMMMM yyyy').toUpperCase(), curLine);	//Master Chart Text Line5 of fourth performance is blank        
        curLine = arrStringContent[390];																//Line 19 is 
        System.assertEquals('ALLOCATION/HARD TICKETS/TLIMIT=6', curLine);								//Master Chart ExtComm Line1 of fourth performance        
        curLine = arrStringContent[391];																//Line 20 is 
        System.assertEquals('OUTLETS,TMON,PBO,SBO,PH,IVR', curLine);									//Master Chart ExtComm Line2 of fourth performance        
        curLine = arrStringContent[392];																//Line 21 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line3 of fourth performance        
        curLine = arrStringContent[393];																//Line 22 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line4 of fourth performance         
        curLine = arrStringContent[394];																//Line 23 is 
        System.assertEquals('GROUP SALES ALLOWED', curLine);											//Master Chart ExtComm Line5 of fourth performance            
        curLine = arrStringContent[395];																//Line 24 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line6 of fourth performance       
        curLine = arrStringContent[396];																//Line 25 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line7 of fourth performance               
        curLine = arrStringContent[397];																//Line 26 is 
        System.assertEquals('ACCOUNT MANAGER: BOYAI PUKHRAMBAM', curLine);								//Master Chart ExtComm Line8 of fourth performance
        curLine = arrStringContent[398];																//Line 27 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line9 of fourth performance
        curLine = arrStringContent[399];																//Line 28 is 
        System.assertEquals('NEVERMIND TOUR/PARKWAY TOWN/' 
                            + curDate.addDays(33).format('EEE HH:mm').toUpperCase(), curLine);			//Event Name/Venue Name/Date of fourth performance
        curLine = arrStringContent[400];																//Line 29 is 
        System.assertEquals(curDate.addDays(123).format('dd-MMM-yy').toUpperCase(), curLine);			//Delete date of fourth performance
        curLine = arrStringContent[401];																//Line 30 is 
        System.assertEquals('-6', curLine);																//Last Mail of fourth performance        
        curLine = arrStringContent[402];																//Line 31 is 
        System.assertEquals('', curLine);																//Blank Line       
        curLine = arrStringContent[403];																//Line 32 is 
        System.assertEquals('PWT1010', curLine);														//Event Code of fourth performance                
        curLine = arrStringContent[404];																//Line 33 is 
        System.assertEquals('2.00', curLine);															//COBO Value of fourth performance            
        curLine = arrStringContent[405];																//Line 34 is 
        System.assertEquals('COBO CHARGE', curLine);													//COBO Description         
        curLine = arrStringContent[406];																//Line 35 is 
        System.assertEquals('3.00', curLine);															//Handling Fees Value of fourth performance            
        curLine = arrStringContent[407];																//Line 36 is 
        System.assertEquals('HANDLING FEES', curLine);													//Handling Fees Description          
        curLine = arrStringContent[408];																//Line 37 is 
        System.assertEquals('5.00', curLine);															//Secure Post Value of fourth performance            
        curLine = arrStringContent[409];																//Line 38 is 
        System.assertEquals('SECURE POST', curLine);													//Secure Post Description  
        curLine = arrStringContent[410];																//Line 39 is 
        System.assertEquals('6.00', curLine);															//Ticket Fast Value of fourth performance            
        curLine = arrStringContent[411];																//Line 40 is 
        System.assertEquals('TICKETFAST PROCESSING', curLine);											//Ticket Fast Description  
        curLine = arrStringContent[412];																//Line 41 is 
        System.assertEquals('7.00', curLine);															//Post Out Value of fourth performance            
        curLine = arrStringContent[413];																//Line 42 is 
        System.assertEquals('POST OUT', curLine);														//Post Out Description  
        curLine = arrStringContent[414];																//Line 43 is 
        System.assertEquals('PWT1010', curLine);														//Event Code of fourth performance                
        curLine = arrStringContent[415];																//Line 44 is 
        System.assertEquals('YES', curLine);															//COBO Charge of fourth performance has a value
        curLine = arrStringContent[416];																//Line 45 is 
        System.assertEquals('YES', curLine);															//POST Out of fourth performance has a value
        curLine = arrStringContent[417];																//Line 46 is 
        System.assertEquals('YES', curLine);															//Secure Post of fourth performance has a value
        curLine = arrStringContent[418];																//Line 47 is 
        System.assertEquals('NO', curLine);																//INTERNATIONAL_POST_ITV_ONLY__c of fourth performance is false
        curLine = arrStringContent[419];																//Line 48 is 
        System.assertEquals('YES', curLine);															//FEDEX_EU_USA_ITV_ONLY__c of fourth performance is true
        curLine = arrStringContent[420];																//Line 49 is 
        System.assertEquals('YES', curLine);															//FEDEX_INTERNATIONAL_ITV_ONLY__c of fourth performance is true
        curLine = arrStringContent[421];																//Line 50 is 
        System.assertEquals('YES', curLine);															//Ticket Fast of fourth performance has a value
        curLine = arrStringContent[422];																//Line 51 is 
        System.assertEquals('PWT1010', curLine);														//Event Code of fourth performance                
        curLine = arrStringContent[423];																//Line 52 is 
        System.assertEquals('Info Key', curLine);														//Info key of fourth performance      
        curLine = arrStringContent[424];																//Line 53 is 
        System.assertEquals('PRI', curLine);															//Primary of fourth performance      
        curLine = arrStringContent[425];																//Line 54 is 
        System.assertEquals('SEC', curLine);															//Secondary of fourth performance      
        curLine = arrStringContent[426];																//Line 55 is 
        System.assertEquals('TER', curLine);															//Tertiary of fourth performance      
        curLine = arrStringContent[427];																//Line 56 is 
        System.assertEquals('3', curLine);																//Tertiary Priviledge of fourth performance    
        curLine = arrStringContent[428];																//Line 57 is 
        System.assertEquals('QUA', curLine);															//Quaternary of fourth performance      
        curLine = arrStringContent[429];																//Line 58 is 
        System.assertEquals('4', curLine);																//Quaternary Priviledge of fourth performance    
        curLine = arrStringContent[430];																//Line 59 is 
        System.assertEquals('QUI', curLine);															//Quinary of fourth performance      
        curLine = arrStringContent[431];																//Line 60 is 
        System.assertEquals('5', curLine);																//Quinary Priviledge of fourth performance    
        curLine = arrStringContent[432];																//Line 61 is 
        System.assertEquals('SEN', curLine);															//Senary of fourth performance      
        curLine = arrStringContent[433];																//Line 62 is 
        System.assertEquals('6', curLine);																//Senary Priviledge of fourth performance    
        curLine = arrStringContent[434];																//Line 63 is 
        System.assertEquals('SEP', curLine);															//Septenary of fourth performance      
        curLine = arrStringContent[435];																//Line 64 is 
        System.assertEquals('7', curLine);																//Septenary Priviledge of fourth performance    
        curLine = arrStringContent[436];																//Line 65 is 
        System.assertEquals('OCT', curLine);															//Octonary of fourth performance      
        curLine = arrStringContent[437];																//Line 66 is 
        System.assertEquals('8', curLine);																//Octonary Priviledge of fourth performance    
        curLine = arrStringContent[438];																//Line 67 is 
        System.assertEquals('NON', curLine);															//Nonary of fourth performance      
        curLine = arrStringContent[439];																//Line 68 is 
        System.assertEquals('9', curLine);																//Nonary Priviledge of fourth performance    
        curLine = arrStringContent[440];																//Line 69 is 
        System.assertEquals('ON', curLine);																//ATP ON OFF of fourth performance      
        curLine = arrStringContent[441];																//Line 70 is 
        System.assertEquals('ON', curLine);																//Single ON OFF of fourth performance  
        curLine = arrStringContent[442];																//Line 71 is 
        System.assertEquals('06', curLine);																//Zone of venue of fourth performance  
        curLine = arrStringContent[443];																//Line 72 is 
        System.assertEquals('PWT1010', curLine);														//Event Code of fourth performance       
        curLine = arrStringContent[444];																//Line 73 is 
        System.assertEquals('OVR', curLine);															//ITV Override of fourth performance       
        curLine = arrStringContent[445];																//Line 74 is 
        System.assertEquals('5', curLine);																//ISM of fourth performance  
        curLine = arrStringContent[446];																//Line 75 is 
        System.assertEquals('6', curLine);																//Graphical Map of fourth performance  
        curLine = arrStringContent[447];																//Line 76 is 
        System.assertEquals(curDate.addDays(15).format('dd-MMM-yy').toUpperCase(), curLine);			//On Sale Date of fourth performance
        curLine = arrStringContent[448];																//Line 77 is 
        System.assertEquals(curDate.addDays(15).format('HH:mm'), curLine);								//On Sale Time of fourth performance
        curLine = arrStringContent[449];																//Line 78 is 
        System.assertEquals(curDate.addDays(15).format('dd-MMM-yy').toUpperCase(), curLine);			//On Sale Date of fourth performance
        curLine = arrStringContent[450];																//Line 79 is 
        System.assertEquals(curDate.addDays(15).format('HH:mm'), curLine);								//On Sale Time of fourth performance
        curLine = arrStringContent[451];																//Line 80 is 
        System.assertEquals(curDate.addDays(22).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale1 start date
        curLine = arrStringContent[452];																//Line 81 is 
        System.assertEquals(curDate.addDays(22).format('HH:mm'), curLine);								//Presale1 start time        
        curLine = arrStringContent[453];																//Line 82 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale1 end date        
        curLine = arrStringContent[454];																//Line 83 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale1 end time        
        curLine = arrStringContent[455];																//Line 84 is 
        System.assertEquals('PreSale1', curLine);														//Presale1 name         
        curLine = arrStringContent[456];																//Line 85 is 
        System.assertEquals(curDate.addDays(23).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale2 start date
        curLine = arrStringContent[457];																//Line 86 is 
        System.assertEquals(curDate.addDays(23).format('HH:mm'), curLine);								//Presale2 start time        
        curLine = arrStringContent[458];																//Line 87 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale2 end date        
        curLine = arrStringContent[459];																//Line 88 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale2 end time        
        curLine = arrStringContent[460];																//Line 89 is 
        System.assertEquals('PreSale2', curLine);														//Presale2 name    
        curLine = arrStringContent[461];																//Line 90 is 
        System.assertEquals(curDate.addDays(24).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale3 start date
        curLine = arrStringContent[462];																//Line 91 is 
        System.assertEquals(curDate.addDays(24).format('HH:mm'), curLine);								//Presale3 start time        
        curLine = arrStringContent[463];																//Line 92 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale3 end date        
        curLine = arrStringContent[464];																//Line 93 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale3 end time        
        curLine = arrStringContent[465];																//Line 94 is 
        System.assertEquals('PreSale3', curLine);														//Presale3 name         
        curLine = arrStringContent[466];																//Line 95 is 
        System.assertEquals(curDate.addDays(25).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale4 start date
        curLine = arrStringContent[467];																//Line 96 is 
        System.assertEquals(curDate.addDays(25).format('HH:mm'), curLine);								//Presale4 start time        
        curLine = arrStringContent[468];																//Line 97 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale4 end date        
        curLine = arrStringContent[469];																//Line 98 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale4 end time        
        curLine = arrStringContent[470];																//Line 99 is 
        System.assertEquals('PreSale4', curLine);														//Presale4 name    
        curLine = arrStringContent[471];																//Line 100 is 
        System.assertEquals(curDate.addDays(26).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale5 start date
        curLine = arrStringContent[472];																//Line 101 is 
        System.assertEquals(curDate.addDays(26).format('HH:mm'), curLine);								//Presale5 start time        
        curLine = arrStringContent[473];																//Line 102 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale5 end date        
        curLine = arrStringContent[474];																//Line 103 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale5 end time        
        curLine = arrStringContent[475];																//Line 104 is 
        System.assertEquals('PreSale5', curLine);														//Presale5 name    
        curLine = arrStringContent[476];																//Line 105 is 
        System.assertEquals(curDate.addDays(27).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale6 start date
        curLine = arrStringContent[477];																//Line 106 is 
        System.assertEquals(curDate.addDays(27).format('HH:mm'), curLine);								//Presale6 start time        
        curLine = arrStringContent[478];																//Line 107 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale6 end date        
        curLine = arrStringContent[479];																//Line 108 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale6 end time        
        curLine = arrStringContent[480];																//Line 109 is 
        System.assertEquals('PreSale6', curLine);														//Presale6 name         
        curLine = arrStringContent[481];																//Line 110 is 
        System.assertEquals(curDate.addDays(28).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale7 start date
        curLine = arrStringContent[482];																//Line 111 is 
        System.assertEquals(curDate.addDays(28).format('HH:mm'), curLine);								//Presale7 start time        
        curLine = arrStringContent[483];																//Line 112 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale7 end date        
        curLine = arrStringContent[484];																//Line 113 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale7 end time        
        curLine = arrStringContent[485];																//Line 114 is 
        System.assertEquals('PreSale7', curLine);														//Presale7 name           
        curLine = arrStringContent[486];																//Line 115 is 
        System.assertEquals('PWT1010', curLine);														//Event Code of fourth performance
        curLine = arrStringContent[487];																//Line 116 is 
        System.assertEquals('PCI02~RESERVED/HARD TIX/STD POST', curLine);								//PCI information of fourth performance          
        curLine = arrStringContent[488];																//Line 117 is 
        System.assertEquals('OVR', curLine);															//ITV Override of fourth performance       
        curLine = arrStringContent[489];																//Line 118 is 
        System.assertEquals('BLACKBUR', curLine);														//Attribute 1 of fourth performance   
        curLine = arrStringContent[490];																//Line 119 is 
        System.assertEquals('BLUES', curLine);															//Attribute 2 of fourth performance
		curLine = arrStringContent[491];																//Line 120 is 
        System.assertEquals('1', curLine);																//Minimum number of tickets          
        curLine = arrStringContent[492];																//Line 121 is 
        System.assertEquals('6', curLine);																//Ticket limit value
        curLine = arrStringContent[493];																//Line 122 is 
        System.assertEquals('PWT1010', curLine);														//Event Code of fourth performance        
        curLine = arrStringContent[494];																//Line 123 is 
        System.assertEquals('Please note: There is a ticket Limit of 6', curLine);						//Text on the ticket
        curLine = arrStringContent[495];																//Line 124 is 
        System.assertEquals('tickets per person and per credit card on this event', curLine);			//Text on the ticket line 2 
       
        //12.Call method to generate AUT File with dates
        createResult = EvtFlowAUTypeFileCtrl.generateAUTypeFiles(curEvent.Id, True, curDate.addDays(31).format('yyyy-MM-dd'), curDate.addDays(32).format('yyyy-MM-dd'));
        System.assertEquals('Created AUT and Text Files - PWT1008.AUT & PWT1008.TXT.', createResult);

        //13.Read and Validate AUT files
        contentDocumentId = [select ContentDocumentId from ContentDocumentLink where LinkedEntityId =:curEvent.Id and ContentDocument.title = 'PWT1008.TXT' LIMIT 1].ContentDocumentId;
        cvData = [select versionData from ContentVersion where ContentDocumentId =:contentDocumentId and title = 'PWT1008.TXT' LIMIT 1].versionData;        

        fileContent = cvData.toString();
        //split the full string into each line
        arrStringContent = fileContent.split('\r\n');

        //start of first performance
        curLine = arrStringContent[0];																	//Line 1 is 
        System.assertEquals('SUN', curLine);															//master chart of first performance
        curLine = arrStringContent[1];																	//Line 2 is 
        System.assertEquals('PWT1008', curLine);														//event code of first performance
        curLine = arrStringContent[2];																	//Line 3 is 
        System.assertEquals(curDate.addDays(31).format('dd-MMM-yy').toUpperCase(), curLine);			//Performance date of first performance
        curLine = arrStringContent[3];																	//Line 4 is 
        System.assertEquals(curDate.addDays(31).format('HH:mm'), curLine);								//Performance Time of first performance
        curLine = arrStringContent[4];																	//Line 5 is 
        System.assertEquals('2', curLine);																//Host ID of first performance
        curLine = arrStringContent[5];																	//Line 6 is 
        System.assertEquals('123', curLine);															//Primary Act Id of first performance       
        curLine = arrStringContent[6];																	//Line 7 is 
        System.assertEquals('456', curLine);															//Secondary Act Id of first performance     
        curLine = arrStringContent[7];																	//Line 8 is 
        System.assertEquals('CONCERTS', curLine);														//Act major category name of first performance     
        curLine = arrStringContent[8];																	//Line 9 is 
        System.assertEquals('21', curLine);																//Act minor category id of first performance
        curLine = arrStringContent[9];																	//Line 10 is 
        System.assertEquals('789', curLine);															//Promoter 1 of first performance        
        curLine = arrStringContent[10];																	//Line 11 is 
        System.assertEquals('987', curLine);															//Invoicer of first performance                
        curLine = arrStringContent[11];																	//Line 12 is 
        System.assertEquals('', curLine);																//Settlement Code of first performance  
        curLine = arrStringContent[12];																	//Line 13 is 
        System.assertEquals('ROOWOO PRESENTS', curLine);												//Master Chart Text Line1 of first performance         
        curLine = arrStringContent[13];																	//Line 14 is 
        System.assertEquals('NEVERMIND TOUR', curLine);													//Master Chart Text Line2 of first performance                 
        curLine = arrStringContent[14];																	//Line 15 is 
        System.assertEquals('', curLine);																//Master Chart Text Line3 of first performance    
        curLine = arrStringContent[15];																	//Line 16 is 
        System.assertEquals('PARKWAY TOWN', curLine);													//Master Chart Text Line4 of first performance                 
        curLine = arrStringContent[16];																	//Line 17 is 
        System.assertEquals('SUNDAY EVENING ' + curDate.addDays(31).format('HH:mm'), curLine);			//Master Chart Text Line5 of first performance is blank
        curLine = arrStringContent[17];																	//Line 18 is 
        System.assertEquals(curDate.addDays(31).format('dd MMMMMMMMM yyyy').toUpperCase(), curLine);	//Master Chart Text Line5 of first performance is blank        
        curLine = arrStringContent[18];																	//Line 19 is 
        System.assertEquals('ALLOCATION/HARD TICKETS/TLIMIT=6', curLine);								//Master Chart ExtComm Line1 of first performance        
        curLine = arrStringContent[19];																	//Line 20 is 
        System.assertEquals('OUTLETS,TMON,PBO,SBO,PH,IVR', curLine);									//Master Chart ExtComm Line2 of first performance        
        curLine = arrStringContent[20];																	//Line 21 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line3 of first performance        
        curLine = arrStringContent[21];																	//Line 22 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line4 of first performance         
        curLine = arrStringContent[22];																	//Line 23 is 
        System.assertEquals('GROUP SALES ALLOWED', curLine);											//Master Chart ExtComm Line5 of first performance            
        curLine = arrStringContent[23];																	//Line 24 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line6 of first performance       
        curLine = arrStringContent[24];																	//Line 25 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line7 of first performance               
        curLine = arrStringContent[25];																	//Line 26 is 
        System.assertEquals('ACCOUNT MANAGER: BOYAI PUKHRAMBAM', curLine);								//Master Chart ExtComm Line8 of first performance
        curLine = arrStringContent[26];																	//Line 27 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line9 of first performance
        curLine = arrStringContent[27];																	//Line 28 is 
        System.assertEquals('NEVERMIND TOUR/PARKWAY TOWN/' 
                            + curDate.addDays(31).format('EEE HH:mm').toUpperCase(), curLine);			//Event Name/Venue Name/Date of first performance
        curLine = arrStringContent[28];																	//Line 29 is 
        System.assertEquals(curDate.addDays(121).format('dd-MMM-yy').toUpperCase(), curLine);			//Delete date of first performance
        curLine = arrStringContent[29];																	//Line 30 is 
        System.assertEquals('-6', curLine);																//Last Mail of first performance        
        curLine = arrStringContent[30];																	//Line 31 is 
        System.assertEquals('', curLine);																//Blank Line       
        curLine = arrStringContent[31];																	//Line 32 is 
        System.assertEquals('PWT1008', curLine);														//Event Code of first performance                
        curLine = arrStringContent[32];																	//Line 33 is 
        System.assertEquals('2.00', curLine);															//COBO Value of first performance            
        curLine = arrStringContent[33];																	//Line 34 is 
        System.assertEquals('COBO CHARGE', curLine);													//COBO Description         
        curLine = arrStringContent[34];																	//Line 35 is 
        System.assertEquals('3.00', curLine);															//Handling Fees Value of first performance            
        curLine = arrStringContent[35];																	//Line 36 is 
        System.assertEquals('HANDLING FEES', curLine);													//Handling Fees Description          
        curLine = arrStringContent[36];																	//Line 37 is 
        System.assertEquals('5.00', curLine);															//Secure Post Value of first performance            
        curLine = arrStringContent[37];																	//Line 38 is 
        System.assertEquals('SECURE POST', curLine);													//Secure Post Description  
        curLine = arrStringContent[38];																	//Line 39 is 
        System.assertEquals('6.00', curLine);															//Ticket Fast Value of first performance            
        curLine = arrStringContent[39];																	//Line 40 is 
        System.assertEquals('TICKETFAST PROCESSING', curLine);											//Ticket Fast Description  
        curLine = arrStringContent[40];																	//Line 41 is 
        System.assertEquals('7.00', curLine);															//Post Out Value of first performance            
        curLine = arrStringContent[41];																	//Line 42 is 
        System.assertEquals('POST OUT', curLine);														//Post Out Description  
        curLine = arrStringContent[42];																	//Line 43 is 
        System.assertEquals('PWT1008', curLine);														//Event Code of first performance                
        curLine = arrStringContent[43];																	//Line 44 is 
        System.assertEquals('YES', curLine);															//COBO Charge of first performance has a value
        curLine = arrStringContent[44];																	//Line 45 is 
        System.assertEquals('YES', curLine);															//POST Out of first performance has a value
        curLine = arrStringContent[45];																	//Line 46 is 
        System.assertEquals('YES', curLine);															//Secure Post of first performance has a value
        curLine = arrStringContent[46];																	//Line 47 is 
        System.assertEquals('NO', curLine);																//INTERNATIONAL_POST_ITV_ONLY__c of first performance is false
        curLine = arrStringContent[47];																	//Line 48 is 
        System.assertEquals('YES', curLine);															//FEDEX_EU_USA_ITV_ONLY__c of first performance is true
        curLine = arrStringContent[48];																	//Line 49 is 
        System.assertEquals('YES', curLine);															//FEDEX_INTERNATIONAL_ITV_ONLY__c of first performance is true
        curLine = arrStringContent[49];																	//Line 50 is 
        System.assertEquals('YES', curLine);															//Ticket Fast of first performance has a value
        curLine = arrStringContent[50];																	//Line 51 is 
        System.assertEquals('PWT1008', curLine);														//Event Code of first performance                
        curLine = arrStringContent[51];																	//Line 52 is 
        System.assertEquals('Info Key', curLine);														//Info key of first performance      
        curLine = arrStringContent[52];																	//Line 53 is 
        System.assertEquals('PRI', curLine);															//Primary of first performance      
        curLine = arrStringContent[53];																	//Line 54 is 
        System.assertEquals('SEC', curLine);															//Secondary of first performance      
        curLine = arrStringContent[54];																	//Line 55 is 
        System.assertEquals('TER', curLine);															//Tertiary of first performance      
        curLine = arrStringContent[55];																	//Line 56 is 
        System.assertEquals('3', curLine);																//Tertiary Priviledge of first performance    
        curLine = arrStringContent[56];																	//Line 57 is 
        System.assertEquals('QUA', curLine);															//Quaternary of first performance      
        curLine = arrStringContent[57];																	//Line 58 is 
        System.assertEquals('4', curLine);																//Quaternary Priviledge of first performance    
        curLine = arrStringContent[58];																	//Line 59 is 
        System.assertEquals('QUI', curLine);															//Quinary of first performance      
        curLine = arrStringContent[59];																	//Line 60 is 
        System.assertEquals('5', curLine);																//Quinary Priviledge of first performance    
        curLine = arrStringContent[60];																	//Line 61 is 
        System.assertEquals('SEN', curLine);															//Senary of first performance      
        curLine = arrStringContent[61];																	//Line 62 is 
        System.assertEquals('6', curLine);																//Senary Priviledge of first performance    
        curLine = arrStringContent[62];																	//Line 63 is 
        System.assertEquals('SEP', curLine);															//Septenary of first performance      
        curLine = arrStringContent[63];																	//Line 64 is 
        System.assertEquals('7', curLine);																//Septenary Priviledge of first performance    
        curLine = arrStringContent[64];																	//Line 65 is 
        System.assertEquals('OCT', curLine);															//Octonary of first performance      
        curLine = arrStringContent[65];																	//Line 66 is 
        System.assertEquals('8', curLine);																//Octonary Priviledge of first performance    
        curLine = arrStringContent[66];																	//Line 67 is 
        System.assertEquals('NON', curLine);															//Nonary of first performance      
        curLine = arrStringContent[67];																	//Line 68 is 
        System.assertEquals('9', curLine);																//Nonary Priviledge of first performance    
        curLine = arrStringContent[68];																	//Line 69 is 
        System.assertEquals('ON', curLine);																//ATP ON OFF of first performance      
        curLine = arrStringContent[69];																	//Line 70 is 
        System.assertEquals('ON', curLine);																//Single ON OFF of first performance  
        curLine = arrStringContent[70];																	//Line 71 is 
        System.assertEquals('06', curLine);																//Zone of venue of first performance  
        curLine = arrStringContent[71];																	//Line 72 is 
        System.assertEquals('PWT1008', curLine);														//Event Code of first performance       
        curLine = arrStringContent[72];																	//Line 73 is 
        System.assertEquals('OVR', curLine);															//ITV Override of first performance       
        curLine = arrStringContent[73];																	//Line 74 is 
        System.assertEquals('5', curLine);																//ISM of first performance  
        curLine = arrStringContent[74];																	//Line 75 is 
        System.assertEquals('6', curLine);																//Graphical Map of first performance  
        curLine = arrStringContent[75];																	//Line 76 is 
        System.assertEquals(curDate.addDays(15).format('dd-MMM-yy').toUpperCase(), curLine);			//On Sale Date of first performance
        curLine = arrStringContent[76];																	//Line 77 is 
        System.assertEquals(curDate.addDays(15).format('HH:mm'), curLine);								//On Sale Time of first performance
        curLine = arrStringContent[77];																	//Line 78 is 
        System.assertEquals(curDate.addDays(15).format('dd-MMM-yy').toUpperCase(), curLine);			//On Sale Date of first performance
        curLine = arrStringContent[78];																	//Line 79 is 
        System.assertEquals(curDate.addDays(15).format('HH:mm'), curLine);								//On Sale Time of first performance
        curLine = arrStringContent[79];																	//Line 80 is 
        System.assertEquals(curDate.addDays(22).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale1 start date
        curLine = arrStringContent[80];																	//Line 81 is 
        System.assertEquals(curDate.addDays(22).format('HH:mm'), curLine);								//Presale1 start time        
        curLine = arrStringContent[81];																	//Line 82 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale1 end date        
        curLine = arrStringContent[82];																	//Line 83 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale1 end time        
        curLine = arrStringContent[83];																	//Line 84 is 
        System.assertEquals('PreSale1', curLine);														//Presale1 name         
        curLine = arrStringContent[84];																	//Line 85 is 
        System.assertEquals(curDate.addDays(23).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale2 start date
        curLine = arrStringContent[85];																	//Line 86 is 
        System.assertEquals(curDate.addDays(23).format('HH:mm'), curLine);								//Presale2 start time        
        curLine = arrStringContent[86];																	//Line 87 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale2 end date        
        curLine = arrStringContent[87];																	//Line 88 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale2 end time        
        curLine = arrStringContent[88];																	//Line 89 is 
        System.assertEquals('PreSale2', curLine);														//Presale2 name    
        curLine = arrStringContent[89];																	//Line 90 is 
        System.assertEquals(curDate.addDays(24).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale3 start date
        curLine = arrStringContent[90];																	//Line 91 is 
        System.assertEquals(curDate.addDays(24).format('HH:mm'), curLine);								//Presale3 start time        
        curLine = arrStringContent[91];																	//Line 92 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale3 end date        
        curLine = arrStringContent[92];																	//Line 93 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale3 end time        
        curLine = arrStringContent[93];																	//Line 94 is 
        System.assertEquals('PreSale3', curLine);														//Presale3 name         
        curLine = arrStringContent[94];																	//Line 95 is 
        System.assertEquals(curDate.addDays(25).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale4 start date
        curLine = arrStringContent[95];																	//Line 96 is 
        System.assertEquals(curDate.addDays(25).format('HH:mm'), curLine);								//Presale4 start time        
        curLine = arrStringContent[96];																	//Line 97 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale4 end date        
        curLine = arrStringContent[97];																	//Line 98 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale4 end time        
        curLine = arrStringContent[98];																	//Line 99 is 
        System.assertEquals('PreSale4', curLine);														//Presale4 name    
        curLine = arrStringContent[99];																	//Line 100 is 
        System.assertEquals(curDate.addDays(26).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale5 start date
        curLine = arrStringContent[100];																//Line 101 is 
        System.assertEquals(curDate.addDays(26).format('HH:mm'), curLine);								//Presale5 start time        
        curLine = arrStringContent[101];																//Line 102 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale5 end date        
        curLine = arrStringContent[102];																//Line 103 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale5 end time        
        curLine = arrStringContent[103];																//Line 104 is 
        System.assertEquals('PreSale5', curLine);														//Presale5 name    
        curLine = arrStringContent[104];																//Line 105 is 
        System.assertEquals(curDate.addDays(27).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale6 start date
        curLine = arrStringContent[105];																//Line 106 is 
        System.assertEquals(curDate.addDays(27).format('HH:mm'), curLine);								//Presale6 start time        
        curLine = arrStringContent[106];																//Line 107 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale6 end date        
        curLine = arrStringContent[107];																//Line 108 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale6 end time        
        curLine = arrStringContent[108];																//Line 109 is 
        System.assertEquals('PreSale6', curLine);														//Presale6 name         
        curLine = arrStringContent[109];																//Line 110 is 
        System.assertEquals(curDate.addDays(28).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale7 start date
        curLine = arrStringContent[110];																//Line 111 is 
        System.assertEquals(curDate.addDays(28).format('HH:mm'), curLine);								//Presale7 start time        
        curLine = arrStringContent[111];																//Line 112 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale7 end date        
        curLine = arrStringContent[112];																//Line 113 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale7 end time        
        curLine = arrStringContent[113];																//Line 114 is 
        System.assertEquals('PreSale7', curLine);														//Presale7 name           
        curLine = arrStringContent[114];																//Line 115 is 
        System.assertEquals('PWT1008', curLine);														//Event Code of first performance
        curLine = arrStringContent[115];																//Line 116 is 
        System.assertEquals('PCI02~RESERVED/HARD TIX/STD POST', curLine);								//PCI information of first performance          
        curLine = arrStringContent[116];																//Line 117 is 
        System.assertEquals('OVR', curLine);															//ITV Override of first performance       
        curLine = arrStringContent[117];																//Line 118 is 
        System.assertEquals('BLACKBUR', curLine);														//Attribute 1 of first performance   
        curLine = arrStringContent[118];																//Line 119 is 
        System.assertEquals('BLUES', curLine);															//Attribute 2 of first performance
		curLine = arrStringContent[119];																//Line 120 is 
        System.assertEquals('1', curLine);																//Minimum number of tickets          
        curLine = arrStringContent[120];																//Line 121 is 
        System.assertEquals('6', curLine);																//Ticket limit value
        curLine = arrStringContent[121];																//Line 122 is 
        System.assertEquals('PWT1008', curLine);														//Event Code of first performance        
        curLine = arrStringContent[122];																//Line 123 is 
        System.assertEquals('Please note: There is a ticket Limit of 6', curLine);						//Text on the ticket
        curLine = arrStringContent[123];																//Line 124 is 
        System.assertEquals('tickets per person and per credit card on this event', curLine);			//Text on the ticket line 2        


		//start of second performance
        curLine = arrStringContent[124];																//Line 1 is 
        System.assertEquals('WEKD', curLine);															//master chart of second performance
        curLine = arrStringContent[125];																//Line 2 is 
        System.assertEquals('PWT1009', curLine);														//event code of second performance
        curLine = arrStringContent[126];																//Line 3 is 
        System.assertEquals(curDate.addDays(32).format('dd-MMM-yy').toUpperCase(), curLine);			//Performance date of second performance
        curLine = arrStringContent[127];																//Line 4 is 
        System.assertEquals(curDate.addDays(32).format('HH:mm'), curLine);								//Performance Time of second performance
        curLine = arrStringContent[128];																//Line 5 is 
        System.assertEquals('2', curLine);																//Host ID of second performance
        curLine = arrStringContent[129];																//Line 6 is 
        System.assertEquals('123', curLine);															//Primary Act Id of second performance       
        curLine = arrStringContent[130];																//Line 7 is 
        System.assertEquals('456', curLine);															//Secondary Act Id of second performance     
        curLine = arrStringContent[131];																//Line 8 is 
        System.assertEquals('CONCERTS', curLine);														//Act major category name of second performance     
        curLine = arrStringContent[132];																//Line 9 is 
        System.assertEquals('21', curLine);																//Act minor category id of second performance
        curLine = arrStringContent[133];																//Line 10 is 
        System.assertEquals('789', curLine);															//Promoter 1 of second performance        
        curLine = arrStringContent[134];																//Line 11 is 
        System.assertEquals('987', curLine);															//Invoicer of second performance                
        curLine = arrStringContent[135];																//Line 12 is 
        System.assertEquals('', curLine);																//Settlement Code of second performance  
        curLine = arrStringContent[136];																//Line 13 is 
        System.assertEquals('ROOWOO PRESENTS', curLine);												//Master Chart Text Line1 of second performance         
        curLine = arrStringContent[137];																//Line 14 is 
        System.assertEquals('NEVERMIND TOUR', curLine);													//Master Chart Text Line2 of second performance                 
        curLine = arrStringContent[138];																//Line 15 is 
        System.assertEquals('', curLine);																//Master Chart Text Line3 of second performance    
        curLine = arrStringContent[139];																//Line 16 is 
        System.assertEquals('PARKWAY TOWN', curLine);													//Master Chart Text Line4 of second performance                 
        curLine = arrStringContent[140];																//Line 17 is 
        System.assertEquals('MONDAY EVENING ' + curDate.addDays(32).format('HH:mm'), curLine);			//Master Chart Text Line5 of second performance is blank
        curLine = arrStringContent[141];																//Line 18 is 
        System.assertEquals(curDate.addDays(32).format('dd MMMMMMMMM yyyy').toUpperCase(), curLine);	//Master Chart Text Line5 of second performance is blank        
        curLine = arrStringContent[142];																//Line 19 is 
        System.assertEquals('ALLOCATION/HARD TICKETS/TLIMIT=6', curLine);								//Master Chart ExtComm Line1 of second performance        
        curLine = arrStringContent[143];																//Line 20 is 
        System.assertEquals('OUTLETS,TMON,PBO,SBO,PH,IVR', curLine);									//Master Chart ExtComm Line2 of second performance        
        curLine = arrStringContent[144];																//Line 21 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line3 of second performance        
        curLine = arrStringContent[145];																//Line 22 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line4 of second performance         
        curLine = arrStringContent[146];																//Line 23 is 
        System.assertEquals('GROUP SALES ALLOWED', curLine);											//Master Chart ExtComm Line5 of second performance            
        curLine = arrStringContent[147];																//Line 24 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line6 of second performance       
        curLine = arrStringContent[148];																//Line 25 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line7 of second performance               
        curLine = arrStringContent[149];																//Line 26 is 
        System.assertEquals('ACCOUNT MANAGER: BOYAI PUKHRAMBAM', curLine);								//Master Chart ExtComm Line8 of second performance
        curLine = arrStringContent[150];																//Line 27 is 
        System.assertEquals('', curLine);																//Master Chart ExtComm Line9 of second performance
        curLine = arrStringContent[151];																//Line 28 is 
        System.assertEquals('NEVERMIND TOUR/PARKWAY TOWN/' 
                            + curDate.addDays(32).format('EEE HH:mm').toUpperCase(), curLine);			//Event Name/Venue Name/Date of second performance
        curLine = arrStringContent[152];																//Line 29 is 
        System.assertEquals(curDate.addDays(122).format('dd-MMM-yy').toUpperCase(), curLine);			//Delete date of second performance
        curLine = arrStringContent[153];																//Line 30 is 
        System.assertEquals('-6', curLine);																//Last Mail of second performance        
        curLine = arrStringContent[154];																//Line 31 is 
        System.assertEquals('', curLine);																//Blank Line       
        curLine = arrStringContent[155];																//Line 32 is 
        System.assertEquals('PWT1009', curLine);														//Event Code of second performance                
        curLine = arrStringContent[156];																//Line 33 is 
        System.assertEquals('2.00', curLine);															//COBO Value of second performance            
        curLine = arrStringContent[157];																//Line 34 is 
        System.assertEquals('COBO CHARGE', curLine);													//COBO Description         
        curLine = arrStringContent[158];																//Line 35 is 
        System.assertEquals('3.00', curLine);															//Handling Fees Value of second performance            
        curLine = arrStringContent[159];																//Line 36 is 
        System.assertEquals('HANDLING FEES', curLine);													//Handling Fees Description          
        curLine = arrStringContent[160];																//Line 37 is 
        System.assertEquals('5.00', curLine);															//Secure Post Value of second performance            
        curLine = arrStringContent[161];																//Line 38 is 
        System.assertEquals('SECURE POST', curLine);													//Secure Post Description  
        curLine = arrStringContent[162];																//Line 39 is 
        System.assertEquals('6.00', curLine);															//Ticket Fast Value of second performance            
        curLine = arrStringContent[163];																//Line 40 is 
        System.assertEquals('TICKETFAST PROCESSING', curLine);											//Ticket Fast Description  
        curLine = arrStringContent[164];																//Line 41 is 
        System.assertEquals('7.00', curLine);															//Post Out Value of second performance            
        curLine = arrStringContent[165];																//Line 42 is 
        System.assertEquals('POST OUT', curLine);														//Post Out Description  
        curLine = arrStringContent[166];																//Line 43 is 
        System.assertEquals('PWT1009', curLine);														//Event Code of second performance                
        curLine = arrStringContent[167];																//Line 44 is 
        System.assertEquals('YES', curLine);															//COBO Charge of second performance has a value
        curLine = arrStringContent[168];																//Line 45 is 
        System.assertEquals('YES', curLine);															//POST Out of second performance has a value
        curLine = arrStringContent[169];																//Line 46 is 
        System.assertEquals('YES', curLine);															//Secure Post of second performance has a value
        curLine = arrStringContent[170];																//Line 47 is 
        System.assertEquals('NO', curLine);																//INTERNATIONAL_POST_ITV_ONLY__c of second performance is false
        curLine = arrStringContent[171];																//Line 48 is 
        System.assertEquals('YES', curLine);															//FEDEX_EU_USA_ITV_ONLY__c of second performance is true
        curLine = arrStringContent[172];																//Line 49 is 
        System.assertEquals('YES', curLine);															//FEDEX_INTERNATIONAL_ITV_ONLY__c of second performance is true
        curLine = arrStringContent[173];																//Line 50 is 
        System.assertEquals('YES', curLine);															//Ticket Fast of second performance has a value
        curLine = arrStringContent[174];																//Line 51 is 
        System.assertEquals('PWT1009', curLine);														//Event Code of second performance                
        curLine = arrStringContent[175];																//Line 52 is 
        System.assertEquals('Info Key', curLine);														//Info key of second performance      
        curLine = arrStringContent[176];																//Line 53 is 
        System.assertEquals('PRI', curLine);															//Primary of second performance      
        curLine = arrStringContent[177];																//Line 54 is 
        System.assertEquals('SEC', curLine);															//Secondary of second performance      
        curLine = arrStringContent[178];																//Line 55 is 
        System.assertEquals('TER', curLine);															//Tertiary of second performance      
        curLine = arrStringContent[179];																//Line 56 is 
        System.assertEquals('3', curLine);																//Tertiary Priviledge of second performance    
        curLine = arrStringContent[180];																//Line 57 is 
        System.assertEquals('QUA', curLine);															//Quaternary of second performance      
        curLine = arrStringContent[181];																//Line 58 is 
        System.assertEquals('4', curLine);																//Quaternary Priviledge of second performance    
        curLine = arrStringContent[182];																//Line 59 is 
        System.assertEquals('QUI', curLine);															//Quinary of second performance      
        curLine = arrStringContent[183];																//Line 60 is 
        System.assertEquals('5', curLine);																//Quinary Priviledge of second performance    
        curLine = arrStringContent[184];																//Line 61 is 
        System.assertEquals('SEN', curLine);															//Senary of second performance      
        curLine = arrStringContent[185];																//Line 62 is 
        System.assertEquals('6', curLine);																//Senary Priviledge of second performance    
        curLine = arrStringContent[186];																//Line 63 is 
        System.assertEquals('SEP', curLine);															//Septenary of second performance      
        curLine = arrStringContent[187];																//Line 64 is 
        System.assertEquals('7', curLine);																//Septenary Priviledge of second performance    
        curLine = arrStringContent[188];																//Line 65 is 
        System.assertEquals('OCT', curLine);															//Octonary of second performance      
        curLine = arrStringContent[189];																//Line 66 is 
        System.assertEquals('8', curLine);																//Octonary Priviledge of second performance    
        curLine = arrStringContent[190];																//Line 67 is 
        System.assertEquals('NON', curLine);															//Nonary of second performance      
        curLine = arrStringContent[191];																//Line 68 is 
        System.assertEquals('9', curLine);																//Nonary Priviledge of second performance    
        curLine = arrStringContent[192];																//Line 69 is 
        System.assertEquals('ON', curLine);																//ATP ON OFF of second performance      
        curLine = arrStringContent[193];																//Line 70 is 
        System.assertEquals('ON', curLine);																//Single ON OFF of second performance  
        curLine = arrStringContent[194];																//Line 71 is 
        System.assertEquals('06', curLine);																//Zone of venue of second performance  
        curLine = arrStringContent[195];																//Line 72 is 
        System.assertEquals('PWT1009', curLine);														//Event Code of second performance       
        curLine = arrStringContent[196];																//Line 73 is 
        System.assertEquals('OVR', curLine);															//ITV Override of second performance       
        curLine = arrStringContent[197];																//Line 74 is 
        System.assertEquals('5', curLine);															    //ISM of second performance  
        curLine = arrStringContent[198];																//Line 75 is 
        System.assertEquals('6', curLine);																//Graphical Map of second performance  
        curLine = arrStringContent[199];																//Line 76 is 
        System.assertEquals(curDate.addDays(15).format('dd-MMM-yy').toUpperCase(), curLine);			//On Sale Date of second performance
        curLine = arrStringContent[200];																//Line 77 is 
        System.assertEquals(curDate.addDays(15).format('HH:mm'), curLine);								//On Sale Time of second performance
        curLine = arrStringContent[201];																//Line 78 is 
        System.assertEquals(curDate.addDays(15).format('dd-MMM-yy').toUpperCase(), curLine);			//On Sale Date of second performance
        curLine = arrStringContent[202];																//Line 79 is 
        System.assertEquals(curDate.addDays(15).format('HH:mm'), curLine);								//On Sale Time of second performance
        curLine = arrStringContent[203];																//Line 80 is 
        System.assertEquals(curDate.addDays(22).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale1 start date
        curLine = arrStringContent[204];																//Line 81 is 
        System.assertEquals(curDate.addDays(22).format('HH:mm'), curLine);								//Presale1 start time        
        curLine = arrStringContent[205];																//Line 82 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale1 end date        
        curLine = arrStringContent[206];																//Line 83 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale1 end time        
        curLine = arrStringContent[207];																//Line 84 is 
        System.assertEquals('PreSale1', curLine);														//Presale1 name         
        curLine = arrStringContent[208];																//Line 85 is 
        System.assertEquals(curDate.addDays(23).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale2 start date
        curLine = arrStringContent[209];																//Line 86 is 
        System.assertEquals(curDate.addDays(23).format('HH:mm'), curLine);								//Presale2 start time        
        curLine = arrStringContent[210];																//Line 87 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale2 end date        
        curLine = arrStringContent[211];																//Line 88 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale2 end time        
        curLine = arrStringContent[212];																//Line 89 is 
        System.assertEquals('PreSale2', curLine);														//Presale2 name    
        curLine = arrStringContent[213];																//Line 90 is 
        System.assertEquals(curDate.addDays(24).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale3 start date
        curLine = arrStringContent[214];																//Line 91 is 
        System.assertEquals(curDate.addDays(24).format('HH:mm'), curLine);								//Presale3 start time        
        curLine = arrStringContent[215];																//Line 92 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale3 end date        
        curLine = arrStringContent[216];																//Line 93 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale3 end time        
        curLine = arrStringContent[217];																//Line 94 is 
        System.assertEquals('PreSale3', curLine);														//Presale3 name         
        curLine = arrStringContent[218];																//Line 95 is 
        System.assertEquals(curDate.addDays(25).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale4 start date
        curLine = arrStringContent[219];																//Line 96 is 
        System.assertEquals(curDate.addDays(25).format('HH:mm'), curLine);								//Presale4 start time        
        curLine = arrStringContent[220];																//Line 97 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale4 end date        
        curLine = arrStringContent[221];																//Line 98 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale4 end time        
        curLine = arrStringContent[222];																//Line 99 is 
        System.assertEquals('PreSale4', curLine);														//Presale4 name    
        curLine = arrStringContent[223];																//Line 100 is 
        System.assertEquals(curDate.addDays(26).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale5 start date
        curLine = arrStringContent[224];																//Line 101 is 
        System.assertEquals(curDate.addDays(26).format('HH:mm'), curLine);								//Presale5 start time        
        curLine = arrStringContent[225];																//Line 102 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale5 end date        
        curLine = arrStringContent[226];																//Line 103 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale5 end time        
        curLine = arrStringContent[227];																//Line 104 is 
        System.assertEquals('PreSale5', curLine);														//Presale5 name    
        curLine = arrStringContent[228];																//Line 105 is 
        System.assertEquals(curDate.addDays(27).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale6 start date
        curLine = arrStringContent[229];																//Line 106 is 
        System.assertEquals(curDate.addDays(27).format('HH:mm'), curLine);								//Presale6 start time        
        curLine = arrStringContent[230];																//Line 107 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale6 end date        
        curLine = arrStringContent[231];																//Line 108 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale6 end time        
        curLine = arrStringContent[232];																//Line 109 is 
        System.assertEquals('PreSale6', curLine);														//Presale6 name         
        curLine = arrStringContent[233];																//Line 110 is 
        System.assertEquals(curDate.addDays(28).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale7 start date
        curLine = arrStringContent[234];																//Line 111 is 
        System.assertEquals(curDate.addDays(28).format('HH:mm'), curLine);								//Presale7 start time        
        curLine = arrStringContent[235];																//Line 112 is 
        System.assertEquals(curDate.addDays(29).format('dd-MMM-yy').toUpperCase(), curLine);			//Presale7 end date        
        curLine = arrStringContent[236];																//Line 113 is 
        System.assertEquals(curDate.addDays(29).format('HH:mm'), curLine);								//Presale7 end time        
        curLine = arrStringContent[237];																//Line 114 is 
        System.assertEquals('PreSale7', curLine);														//Presale7 name           
        curLine = arrStringContent[238];																//Line 115 is 
        System.assertEquals('PWT1009', curLine);														//Event Code of second performance
        curLine = arrStringContent[239];																//Line 116 is 
        System.assertEquals('PCI02~RESERVED/HARD TIX/STD POST', curLine);								//PCI information of second performance          
        curLine = arrStringContent[240];																//Line 117 is 
        System.assertEquals('OVR', curLine);															//ITV Override of second performance       
        curLine = arrStringContent[241];																//Line 118 is 
        System.assertEquals('BLACKBUR', curLine);														//Attribute 1 of second performance   
        curLine = arrStringContent[242];																//Line 119 is 
        System.assertEquals('BLUES', curLine);															//Attribute 2 of second performance
		curLine = arrStringContent[243];																//Line 120 is 
        System.assertEquals('1', curLine);																//Minimum number of tickets          
        curLine = arrStringContent[244];																//Line 121 is 
        System.assertEquals('6', curLine);																//Ticket limit value
        curLine = arrStringContent[245];																//Line 122 is 
        System.assertEquals('PWT1009', curLine);														//Event Code of second performance        
        curLine = arrStringContent[246];																//Line 123 is 
        System.assertEquals('Please note: There is a ticket Limit of 6', curLine);						//Text on the ticket
        curLine = arrStringContent[247];																//Line 124 is 
        System.assertEquals('tickets per person and per credit card on this event', curLine);			//Text on the ticket line 2         
        
    }

}