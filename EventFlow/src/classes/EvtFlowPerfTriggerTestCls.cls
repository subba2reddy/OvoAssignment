@isTest
public class EvtFlowPerfTriggerTestCls {
    public static testMethod void testPerformanceTrigger(){
        
        //1. Create the data required
        //create the invoicer
        Invoicer__c invoicer = new Invoicer__c();
        invoicer.Name = 'RooWoo';
        insert invoicer;
        
        //create the simetra venue
        Simetra_Venue__c simetra = new Simetra_Venue__c();
        simetra.Name = 'ParkWay Town';
        simetra.Host_Id__c = '2';
        simetra.Online_Id__c = '23514';
        simetra.TM_Host__c = 'UK2';
        simetra.Active__c = 'y';
        insert simetra;
        
        //create the venue record
        Venue__c venue = new Venue__c();
        venue.name = 'ParkWay Town';
		venue.Semetra_Venue_Type__c = 'Allocation';
        venue.Zone__c = '06';
        venue.Venue_Prefix__c = 'pwt';
        venue.Simetra_Venue__c = simetra.Id;
        insert venue;
        
        //create the event
        Event__c curEvent = new Event__c();
        DateTime curDate = DateTime.now();
        curEvent.Name = 'Metallica Tour';
        curEvent.Status__c = 'New';
        curEvent.Start_Date__c = curDate.addDays(30);
        curEvent.End_date__c = curDate.addDays(120);
        curEvent.CAM_Venue__c = 'ParkWay Town';
        curEvent.Needed_By__c = curDate.addDays(10);
        curEvent.ATP_On_Off__c = 'On';
        curEvent.Primary__c = 'Pri';
        curEvent.Groups_Allowed__c = 'GROUP SALES ALLOWED';
        curEvent.PCI_Information__c = '2 RESERVED/HARD TIX/STD POST';
        curEvent.Ticket_Limit__c = 6;
        curEvent.Invoicer__c = invoicer.Id;
        curEvent.Venue__c = venue.Id;
        insert curEvent;
        
        //create the prices
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
        
        //create the performances
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
        //end of data creation
        
        
        //2. start validating the master charts created by the above data - insert scenario
        Integer GOECount = 0, SUNCount = 0, WEKDCount = 0;
        List<Master_charts__c> masterCharts = new List<Master_Charts__c>();
        masterCharts = [select name, TXT_Line_1__c, TXT_Line_2__c, TXT_Line_4__c, EXTCOM_Line_1__c, EXTCOM_Line_2__c, EXTCOM_Line_5__c, EXTCOM_Line_8__c 
                        																					from Master_charts__c where event__c =:curEvent.Id];
        
        //there should be three master charts created
        System.assertEquals(3, masterCharts.size());
        
        for(Master_charts__c curMC:masterCharts){
            if(curMC.Name == 'GOE'){
                GOECount = GOECount + 1;
            }
            else if(curMC.Name == 'SUN'){
                SUNCount = SUNCount + 1;
            }
            else if(curMC.Name == 'WEKD'){
                WEKDCount = WEKDCount + 1;
            }
            
            System.assertEquals('ROOWOO PRESENTS', curMC.TXT_Line_1__c);
            System.assertEquals('METALLICA TOUR', curMC.TXT_Line_2__c);
            System.assertEquals('PARKWAY TOWN', curMC.TXT_Line_4__c);
            System.assertEquals('ALLOCATION/HARD TICKETS/TLIMIT=6', curMC.EXTCOM_Line_1__c);
            System.assertEquals('OUTLETS,TMON,PBO,SBO,PH,IVR', curMC.EXTCOM_Line_2__c);
            System.assertEquals('GROUP SALES ALLOWED', curMC.EXTCOM_Line_5__c);
            System.assertEquals('ACCOUNT MANAGER: BOYAI PUKHRAMBAM', curMC.EXTCOM_Line_8__c);
        }
        
        //one master chart object created for each master chart
        System.assertEquals(1, GOECount);
        System.assertEquals(1, SUNCount);
        System.assertEquals(1, WEKDCount);
        
        
        //3. update scenario - make changes and validate the master charts
        for(Performance__c chgPerformance: performances){
            if(chgPerformance.Event_Code__c == 'pwt1010'){
                chgPerformance.Master_Chart__c = 'GOE';
            }
        }
        
        update performances;
        // there shouldn't be any changes to the master charts
        masterCharts = [select name, TXT_Line_1__c, TXT_Line_2__c, TXT_Line_4__c, EXTCOM_Line_1__c, EXTCOM_Line_2__c, EXTCOM_Line_5__c, EXTCOM_Line_8__c 
                        																					from Master_charts__c where event__c =:curEvent.Id];
        GOECount = 0;
        SUNCount = 0;
        WEKDCount = 0;
        //there should be three master charts created
        System.assertEquals(3, masterCharts.size());
        
        for(Master_charts__c curMC:masterCharts){
            if(curMC.Name == 'GOE'){
                GOECount = GOECount + 1;
            }
            else if(curMC.Name == 'SUN'){
                SUNCount = SUNCount + 1;
            }
            else if(curMC.Name == 'WEKD'){
                WEKDCount = WEKDCount + 1;
            }
            
            System.assertEquals('ROOWOO PRESENTS', curMC.TXT_Line_1__c);
            System.assertEquals('METALLICA TOUR', curMC.TXT_Line_2__c);
            System.assertEquals('PARKWAY TOWN', curMC.TXT_Line_4__c);
            System.assertEquals('ALLOCATION/HARD TICKETS/TLIMIT=6', curMC.EXTCOM_Line_1__c);
            System.assertEquals('OUTLETS,TMON,PBO,SBO,PH,IVR', curMC.EXTCOM_Line_2__c);
            System.assertEquals('GROUP SALES ALLOWED', curMC.EXTCOM_Line_5__c);
            System.assertEquals('ACCOUNT MANAGER: BOYAI PUKHRAMBAM', curMC.EXTCOM_Line_8__c);
        }
        
        //one master chart object created for each master chart
        System.assertEquals(1, GOECount);
        System.assertEquals(1, SUNCount);
        System.assertEquals(1, WEKDCount);        
        
        for(Performance__c chgPerformance: performances){
            if(chgPerformance.Event_Code__c == 'pwt1010'){
                chgPerformance.Master_Chart__c = 'POE';
            }
        }
        update performances;

        // there should be 4 master charts now
        Integer POECount = 0;
        GOECount = 0;
        SUNCount = 0;
        WEKDCount = 0;        
        masterCharts = [select name, TXT_Line_1__c, TXT_Line_2__c, TXT_Line_4__c, EXTCOM_Line_1__c, EXTCOM_Line_2__c, EXTCOM_Line_5__c, EXTCOM_Line_8__c 
                        																					from Master_charts__c where event__c =:curEvent.Id];
        //there should be 4 master charts now
        System.assertEquals(4, masterCharts.size());
        
        for(Master_charts__c curMC:masterCharts){
            if(curMC.Name == 'GOE'){
                GOECount = GOECount + 1;
            }
            else if(curMC.Name == 'SUN'){
                SUNCount = SUNCount + 1;
            }
            else if(curMC.Name == 'WEKD'){
                WEKDCount = WEKDCount + 1;
            }
            else if(curMC.Name == 'POE'){
                POECount = POECount + 1;
            }
            
            System.assertEquals('ROOWOO PRESENTS', curMC.TXT_Line_1__c);
            System.assertEquals('METALLICA TOUR', curMC.TXT_Line_2__c);
            System.assertEquals('PARKWAY TOWN', curMC.TXT_Line_4__c);
            System.assertEquals('ALLOCATION/HARD TICKETS/TLIMIT=6', curMC.EXTCOM_Line_1__c);
            System.assertEquals('OUTLETS,TMON,PBO,SBO,PH,IVR', curMC.EXTCOM_Line_2__c);
            System.assertEquals('GROUP SALES ALLOWED', curMC.EXTCOM_Line_5__c);
            System.assertEquals('ACCOUNT MANAGER: BOYAI PUKHRAMBAM', curMC.EXTCOM_Line_8__c);
        }
        
        //one master chart object created for each master chart
        System.assertEquals(1, GOECount);
        System.assertEquals(1, SUNCount);
        System.assertEquals(1, WEKDCount);
        System.assertEquals(1, POECount);
        
        
        for(Performance__c chgPerformance: performances){
            if(chgPerformance.Event_Code__c == 'pwt1010'){
                chgPerformance.Master_Chart__c = 'WEKD';
            }
            else if(chgPerformance.Event_Code__c == 'pwt1007'){
                chgPerformance.Master_Chart__c = 'WEKD';
            }
        }
        update performances;       

        POECount = 0;
        GOECount = 0;
        SUNCount = 0;
        WEKDCount = 0;  
        // there should be just two master charts now
        masterCharts = [select name, TXT_Line_1__c, TXT_Line_2__c, TXT_Line_4__c, EXTCOM_Line_1__c, EXTCOM_Line_2__c, EXTCOM_Line_5__c, EXTCOM_Line_8__c 
                        																					from Master_charts__c where event__c =:curEvent.Id];
        //there should be 2 master charts 
        System.assertEquals(2, masterCharts.size());
        
        for(Master_charts__c curMC:masterCharts){
            if(curMC.Name == 'GOE'){
                GOECount = GOECount + 1;
            }
            else if(curMC.Name == 'SUN'){
                SUNCount = SUNCount + 1;
            }
            else if(curMC.Name == 'WEKD'){
                WEKDCount = WEKDCount + 1;
            }
            else if(curMC.Name == 'POE'){
                POECount = POECount + 1;
            }
            
            System.assertEquals('ROOWOO PRESENTS', curMC.TXT_Line_1__c);
            System.assertEquals('METALLICA TOUR', curMC.TXT_Line_2__c);
            System.assertEquals('PARKWAY TOWN', curMC.TXT_Line_4__c);
            System.assertEquals('ALLOCATION/HARD TICKETS/TLIMIT=6', curMC.EXTCOM_Line_1__c);
            System.assertEquals('OUTLETS,TMON,PBO,SBO,PH,IVR', curMC.EXTCOM_Line_2__c);
            System.assertEquals('GROUP SALES ALLOWED', curMC.EXTCOM_Line_5__c);
            System.assertEquals('ACCOUNT MANAGER: BOYAI PUKHRAMBAM', curMC.EXTCOM_Line_8__c);
        }
        
        //only two master charts left now
        System.assertEquals(0, GOECount);
        System.assertEquals(1, SUNCount);
        System.assertEquals(1, WEKDCount);
        System.assertEquals(0, POECount);


        
        //4. delete scenario - delete performances and validate the master charts
        POECount = 0;
        GOECount = 0;
        SUNCount = 0;
        WEKDCount = 0;
 
        for(Performance__c chgPerformance: performances){
            if(chgPerformance.Event_Code__c == 'pwt1008'){
               delete chgPerformance;
            }
        }

        // there should be just one master chart now
        masterCharts = [select name, TXT_Line_1__c, TXT_Line_2__c, TXT_Line_4__c, EXTCOM_Line_1__c, EXTCOM_Line_2__c, EXTCOM_Line_5__c, EXTCOM_Line_8__c 
                        																					from Master_charts__c where event__c =:curEvent.Id];
        //there should be just 1 master chart now
        System.assertEquals(1, masterCharts.size());
        
        for(Master_charts__c curMC:masterCharts){
            if(curMC.Name == 'GOE'){
                GOECount = GOECount + 1;
            }
            else if(curMC.Name == 'SUN'){
                SUNCount = SUNCount + 1;
            }
            else if(curMC.Name == 'WEKD'){
                WEKDCount = WEKDCount + 1;
            }
            else if(curMC.Name == 'POE'){
                POECount = POECount + 1;
            }
            
            System.assertEquals('ROOWOO PRESENTS', curMC.TXT_Line_1__c);
            System.assertEquals('METALLICA TOUR', curMC.TXT_Line_2__c);
            System.assertEquals('PARKWAY TOWN', curMC.TXT_Line_4__c);
            System.assertEquals('ALLOCATION/HARD TICKETS/TLIMIT=6', curMC.EXTCOM_Line_1__c);
            System.assertEquals('OUTLETS,TMON,PBO,SBO,PH,IVR', curMC.EXTCOM_Line_2__c);
            System.assertEquals('GROUP SALES ALLOWED', curMC.EXTCOM_Line_5__c);
            System.assertEquals('ACCOUNT MANAGER: BOYAI PUKHRAMBAM', curMC.EXTCOM_Line_8__c);
        }
        
        //one master chart object created for each master chart
        System.assertEquals(0, GOECount);
        System.assertEquals(0, SUNCount);
        System.assertEquals(1, WEKDCount);
        System.assertEquals(0, POECount);
        
        //4.now make changes to events/venues/invoicer to see changes to the existing master chart
        //create a new invoicer
        invoicer = new Invoicer__c();
        invoicer.Name = 'RwanMan';
        insert invoicer;
        
        //create the simetra venue
        simetra = new Simetra_Venue__c();
        simetra.Name = 'DownLane Studio';
        simetra.Host_Id__c = '2';
        simetra.Online_Id__c = '23511';
        simetra.TM_Host__c = 'UK2';
        simetra.Active__c = 'y';
        insert simetra;
        
        //create the venue record
        venue = new Venue__c();
        venue.name = 'DownLane Studio';
		venue.Semetra_Venue_Type__c = 'Allocation';
        venue.Zone__c = '06';
        venue.Venue_Prefix__c = 'pwt';
        venue.Simetra_Venue__c = simetra.Id;
        insert venue;
        
        //change few details on the event
        curEvent.Name = 'Metallica Tribute Tour';
        curEvent.Groups_Allowed__c = 'NO GROUPS ALLOWED';
        curEvent.PCI_Information__c = '0 RESERVED/SOFT TIX/STD POST';
        curEvent.Ticket_Limit__c = 10;
        curEvent.Invoicer__c = invoicer.Id;
        curEvent.Venue__c = venue.Id;
        update curEvent;
        
        //create a price for price insert scenario
        curPrice = new Price__c();
        curPrice.Event__c = curEvent.id;
        curPrice.Sales_Channel__c = 'NOTAP';           
		insert curPrice;
        
        //get existing prices and change sales channel for update scenario
        prices = [select Sales_Channel__c from Price__c where Event__c =: curEvent.id];
        for(Price__c chgPrice:prices){
            if(chgPrice.Sales_Channel__c == 'Outlets;Online'){
                chgPrice.Sales_Channel__c = 'Outlets';
            }
            else if(chgPrice.Sales_Channel__c == 'Primary Box Office;Secondary Box Office'){
                chgPrice.Sales_Channel__c = 'Primary Box Office';
            }
        }
        //update the price now
        update prices;
 
        String strLine2 = '';
        // there should be just one master chart now
        masterCharts = [select name, TXT_Line_1__c, TXT_Line_2__c, TXT_Line_4__c, EXTCOM_Line_1__c, EXTCOM_Line_2__c, EXTCOM_Line_5__c, EXTCOM_Line_8__c 
                        																					from Master_charts__c where event__c =:curEvent.Id];
        //there should be just 1 master chart now
        System.assertEquals(1, masterCharts.size());
        
        for(Master_charts__c curMC:masterCharts){
            //make sure that the master details are updated
            System.assertEquals('RWANMAN PRESENTS', curMC.TXT_Line_1__c);
            System.assertEquals('METALLICA TRIBUTE TOUR', curMC.TXT_Line_2__c);
            System.assertEquals('DOWNLANE STUDIO', curMC.TXT_Line_4__c);
            System.assertEquals('ALLOCATION/TLIMIT=10', curMC.EXTCOM_Line_1__c);
            strLine2 = curMC.EXTCOM_Line_2__c;
            System.assertEquals(True, strLine2.contains('OUTLETS'));
            System.assertEquals(True, strLine2.contains('PBO'));
            System.assertEquals(True, strLine2.contains('PH'));
            System.assertEquals(True, strLine2.contains('NOTAP'));
            System.assertEquals(True, strLine2.contains('IVR'));
            System.assertEquals(False, strLine2.contains('TMON'));
            System.assertEquals(False, strLine2.contains('SBO'));
            System.assertEquals('NO GROUPS ALLOWED', curMC.EXTCOM_Line_5__c);
            System.assertEquals('ACCOUNT MANAGER: BOYAI PUKHRAMBAM', curMC.EXTCOM_Line_8__c);
        }

    }
}