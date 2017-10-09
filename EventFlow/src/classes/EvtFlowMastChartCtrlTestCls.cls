@isTest
public class EvtFlowMastChartCtrlTestCls {
    public static testMethod void testMasterCharts(){
        //create an event
        DateTime curDate = DateTime.now();
		Event__c curEvt = new Event__c();
        curEvt.Name = 'Metallica Tour';
        curEvt.Status__c = 'New';
        curEvt.Start_Date__c = curDate.addDays(30);
        curEvt.End_date__c = curDate.addDays(120);
        curEvt.CAM_Venue__c = '100 Club';
        curEvt.Needed_By__c = curDate.addDays(10);
        curEvt.ATP_On_Off__c = 'On';
        curEvt.Primary__c = 'Pri';
        
        //insert the event
        insert curEvt;

        //add master charts to the event
        Master_Charts__c curMasterChart;
		List<Master_Charts__c> masterCharts = new List<Master_Charts__c>();
        //add three master charts
        for(integer i=0; i<3; i++){
            curMasterChart = new Master_Charts__c();
            curMasterChart.Name = 'EVE' + String.valueOf(i);
            curMasterChart.Event__c = curEvt.id;
            curMasterChart.EXTCOM_Line_1__c = curMasterChart.Name + '_ExtComm Line 1';
            curMasterChart.EXTCOM_Line_2__c = curMasterChart.Name + '_ExtComm Line 2';
            curMasterChart.EXTCOM_Line_3__c = curMasterChart.Name + '_ExtComm Line 3';
            curMasterChart.EXTCOM_Line_4__c = curMasterChart.Name + '_ExtComm Line 4';
            curMasterChart.EXTCOM_Line_5__c = curMasterChart.Name + '_ExtComm Line 5';
            curMasterChart.EXTCOM_Line_6__c = curMasterChart.Name + '_ExtComm Line 6';
            curMasterChart.EXTCOM_Line_7__c = curMasterChart.Name + '_ExtComm Line 7';
            curMasterChart.EXTCOM_Line_8__c = curMasterChart.Name + '_ExtComm Line 8';
            curMasterChart.EXTCOM_Line_9__c = curMasterChart.Name + '_ExtComm Line 9';
            curMasterChart.TXT_Line_1__c = curMasterChart.Name + '_Text Line 1';
            curMasterChart.TXT_Line_2__c = curMasterChart.Name + '_Text Line 2';
            curMasterChart.TXT_Line_3__c = curMasterChart.Name + '_Text Line 3';
            curMasterChart.TXT_Line_4__c = curMasterChart.Name + '_Text Line 4';
            curMasterChart.TXT_Line_5__c = curMasterChart.Name + '_Text Line 5';
			masterCharts.add(curMasterChart);
        }
        
        
        //insert the master charts to the system
        insert masterCharts;
        
        //retrieve the master charts as json and see if they are all there
        //this is testing of method getMasterCharts
        String mcJSON = EvtFlowMasterChartCtrl.getMasterCharts(curEvt.id);
        //deserialize the master charts into a list
        List<Master_Charts__c> retMCs = (List<Master_Charts__c>)System.JSON.deserialize(mcJSON, List<Master_Charts__c>.class);
        //make sure that there are three master charts
        System.assertEquals(3, retMCs.size());
        //loop through the returned master charts and see if make sure that data is as expected
        for(Master_Charts__c curMC1 : retMCs){
            if(curMC1.name == 'EVE0'){
                System.assertEquals('EVE0_ExtComm Line 1', curMC1.EXTCOM_Line_1__c);
                System.assertEquals('EVE0_ExtComm Line 2', curMC1.EXTCOM_Line_2__c);
                System.assertEquals('EVE0_ExtComm Line 3', curMC1.EXTCOM_Line_3__c);
                System.assertEquals('EVE0_ExtComm Line 4', curMC1.EXTCOM_Line_4__c);
                System.assertEquals('EVE0_ExtComm Line 5', curMC1.EXTCOM_Line_5__c);
                System.assertEquals('EVE0_ExtComm Line 6', curMC1.EXTCOM_Line_6__c);
                System.assertEquals('EVE0_ExtComm Line 7', curMC1.EXTCOM_Line_7__c);
                System.assertEquals('EVE0_ExtComm Line 8', curMC1.EXTCOM_Line_8__c);
                System.assertEquals('EVE0_ExtComm Line 9', curMC1.EXTCOM_Line_9__c);
                System.assertEquals('EVE0_Text Line 1', curMC1.TXT_Line_1__c);
                System.assertEquals('EVE0_Text Line 2', curMC1.TXT_Line_2__c);
                System.assertEquals('EVE0_Text Line 3', curMC1.TXT_Line_3__c);
                System.assertEquals('EVE0_Text Line 4', curMC1.TXT_Line_4__c);
                System.assertEquals('EVE0_Text Line 5', curMC1.TXT_Line_5__c);
            }
            else if(curMC1.name == 'EVE1'){
                System.assertEquals('EVE1_ExtComm Line 1', curMC1.EXTCOM_Line_1__c);
                System.assertEquals('EVE1_ExtComm Line 2', curMC1.EXTCOM_Line_2__c);
                System.assertEquals('EVE1_ExtComm Line 3', curMC1.EXTCOM_Line_3__c);
                System.assertEquals('EVE1_ExtComm Line 4', curMC1.EXTCOM_Line_4__c);
                System.assertEquals('EVE1_ExtComm Line 5', curMC1.EXTCOM_Line_5__c);
                System.assertEquals('EVE1_ExtComm Line 6', curMC1.EXTCOM_Line_6__c);
                System.assertEquals('EVE1_ExtComm Line 7', curMC1.EXTCOM_Line_7__c);
                System.assertEquals('EVE1_ExtComm Line 8', curMC1.EXTCOM_Line_8__c);
                System.assertEquals('EVE1_ExtComm Line 9', curMC1.EXTCOM_Line_9__c);
                System.assertEquals('EVE1_Text Line 1', curMC1.TXT_Line_1__c);
                System.assertEquals('EVE1_Text Line 2', curMC1.TXT_Line_2__c);
                System.assertEquals('EVE1_Text Line 3', curMC1.TXT_Line_3__c);
                System.assertEquals('EVE1_Text Line 4', curMC1.TXT_Line_4__c);
                System.assertEquals('EVE1_Text Line 5', curMC1.TXT_Line_5__c);                
            }
            else if(curMC1.name == 'EVE2'){
                System.assertEquals('EVE2_ExtComm Line 1', curMC1.EXTCOM_Line_1__c);
                System.assertEquals('EVE2_ExtComm Line 2', curMC1.EXTCOM_Line_2__c);
                System.assertEquals('EVE2_ExtComm Line 3', curMC1.EXTCOM_Line_3__c);
                System.assertEquals('EVE2_ExtComm Line 4', curMC1.EXTCOM_Line_4__c);
                System.assertEquals('EVE2_ExtComm Line 5', curMC1.EXTCOM_Line_5__c);
                System.assertEquals('EVE2_ExtComm Line 6', curMC1.EXTCOM_Line_6__c);
                System.assertEquals('EVE2_ExtComm Line 7', curMC1.EXTCOM_Line_7__c);
                System.assertEquals('EVE2_ExtComm Line 8', curMC1.EXTCOM_Line_8__c);
                System.assertEquals('EVE2_ExtComm Line 9', curMC1.EXTCOM_Line_9__c);
                System.assertEquals('EVE2_Text Line 1', curMC1.TXT_Line_1__c);
                System.assertEquals('EVE2_Text Line 2', curMC1.TXT_Line_2__c);
                System.assertEquals('EVE2_Text Line 3', curMC1.TXT_Line_3__c);
                System.assertEquals('EVE2_Text Line 4', curMC1.TXT_Line_4__c);
                System.assertEquals('EVE2_Text Line 5', curMC1.TXT_Line_5__c);                
            }
        }
        
        //make changes to the master charts to test saving of master charts
        //remove the word "Line" from extcomm and text lines
        for(Master_Charts__c curMC2: retMCs){
            curMC2.EXTCOM_Line_1__c = curMC2.EXTCOM_Line_1__c.replace('Line ', '');
            curMC2.EXTCOM_Line_2__c = curMC2.EXTCOM_Line_2__c.replace('Line ', '');
            curMC2.EXTCOM_Line_3__c = curMC2.EXTCOM_Line_3__c.replace('Line ', '');
            curMC2.EXTCOM_Line_4__c = curMC2.EXTCOM_Line_4__c.replace('Line ', '');
            curMC2.EXTCOM_Line_5__c = curMC2.EXTCOM_Line_5__c.replace('Line ', '');
            curMC2.EXTCOM_Line_6__c = curMC2.EXTCOM_Line_6__c.replace('Line ', '');
            curMC2.EXTCOM_Line_7__c = curMC2.EXTCOM_Line_7__c.replace('Line ', '');
            curMC2.EXTCOM_Line_8__c = curMC2.EXTCOM_Line_8__c.replace('Line ', '');
            curMC2.EXTCOM_Line_9__c = curMC2.EXTCOM_Line_9__c.replace('Line ', '');
            curMC2.TXT_Line_1__c = curMC2.TXT_Line_1__c.replace('Line ', '');
            curMC2.TXT_Line_2__c = curMC2.TXT_Line_2__c.replace('Line ', '');
            curMC2.TXT_Line_3__c = curMC2.TXT_Line_3__c.replace('Line ', '');
            curMC2.TXT_Line_4__c = curMC2.TXT_Line_4__c.replace('Line ', '');
            curMC2.TXT_Line_5__c = curMC2.TXT_Line_5__c.replace('Line ', '');   
        }
        //serialize them again
        mcJSON = JSON.serialize(retMCs);
        
        //call the json save method to save all changes
        String saveResult = EvtFlowMasterChartCtrl.saveMasterCharts(mcJSON);
        System.assertEquals('Master Charts updated succefully!!', saveResult);
        
        //retrieve the changes to the master charts and see if all is fine
        List<Master_Charts__c> mcRetrived = [select name, EXTCOM_Line_1__c, EXTCOM_Line_2__c, EXTCOM_Line_3__c, EXTCOM_Line_4__c, EXTCOM_Line_5__c, EXTCOM_Line_6__c, EXTCOM_Line_7__c, EXTCOM_Line_8__c,
                                            	EXTCOM_Line_9__c, TXT_Line_1__c, TXT_Line_2__c, TXT_Line_3__c, TXT_Line_4__c, TXT_Line_5__c from Master_Charts__c where event__c =:curEvt.id];
        
        for(Master_Charts__c curMC3: mcRetrived){
            if(curMC3.name == 'EVE0'){
                System.assertEquals('EVE0_ExtComm 1', curMC3.EXTCOM_Line_1__c);
                System.assertEquals('EVE0_ExtComm 2', curMC3.EXTCOM_Line_2__c);
                System.assertEquals('EVE0_ExtComm 3', curMC3.EXTCOM_Line_3__c);
                System.assertEquals('EVE0_ExtComm 4', curMC3.EXTCOM_Line_4__c);
                System.assertEquals('EVE0_ExtComm 5', curMC3.EXTCOM_Line_5__c);
                System.assertEquals('EVE0_ExtComm 6', curMC3.EXTCOM_Line_6__c);
                System.assertEquals('EVE0_ExtComm 7', curMC3.EXTCOM_Line_7__c);
                System.assertEquals('EVE0_ExtComm 8', curMC3.EXTCOM_Line_8__c);
                System.assertEquals('EVE0_ExtComm 9', curMC3.EXTCOM_Line_9__c);
                System.assertEquals('EVE0_Text 1', curMC3.TXT_Line_1__c);
                System.assertEquals('EVE0_Text 2', curMC3.TXT_Line_2__c);
                System.assertEquals('EVE0_Text 3', curMC3.TXT_Line_3__c);
                System.assertEquals('EVE0_Text 4', curMC3.TXT_Line_4__c);
                System.assertEquals('EVE0_Text 5', curMC3.TXT_Line_5__c);
            }
            else if(curMC3.name == 'EVE1'){
                System.assertEquals('EVE1_ExtComm 1', curMC3.EXTCOM_Line_1__c);
                System.assertEquals('EVE1_ExtComm 2', curMC3.EXTCOM_Line_2__c);
                System.assertEquals('EVE1_ExtComm 3', curMC3.EXTCOM_Line_3__c);
                System.assertEquals('EVE1_ExtComm 4', curMC3.EXTCOM_Line_4__c);
                System.assertEquals('EVE1_ExtComm 5', curMC3.EXTCOM_Line_5__c);
                System.assertEquals('EVE1_ExtComm 6', curMC3.EXTCOM_Line_6__c);
                System.assertEquals('EVE1_ExtComm 7', curMC3.EXTCOM_Line_7__c);
                System.assertEquals('EVE1_ExtComm 8', curMC3.EXTCOM_Line_8__c);
                System.assertEquals('EVE1_ExtComm 9', curMC3.EXTCOM_Line_9__c);
                System.assertEquals('EVE1_Text 1', curMC3.TXT_Line_1__c);
                System.assertEquals('EVE1_Text 2', curMC3.TXT_Line_2__c);
                System.assertEquals('EVE1_Text 3', curMC3.TXT_Line_3__c);
                System.assertEquals('EVE1_Text 4', curMC3.TXT_Line_4__c);
                System.assertEquals('EVE1_Text 5', curMC3.TXT_Line_5__c);                
            }
            else if(curMC3.name == 'EVE2'){
                System.assertEquals('EVE2_ExtComm 1', curMC3.EXTCOM_Line_1__c);
                System.assertEquals('EVE2_ExtComm 2', curMC3.EXTCOM_Line_2__c);
                System.assertEquals('EVE2_ExtComm 3', curMC3.EXTCOM_Line_3__c);
                System.assertEquals('EVE2_ExtComm 4', curMC3.EXTCOM_Line_4__c);
                System.assertEquals('EVE2_ExtComm 5', curMC3.EXTCOM_Line_5__c);
                System.assertEquals('EVE2_ExtComm 6', curMC3.EXTCOM_Line_6__c);
                System.assertEquals('EVE2_ExtComm 7', curMC3.EXTCOM_Line_7__c);
                System.assertEquals('EVE2_ExtComm 8', curMC3.EXTCOM_Line_8__c);
                System.assertEquals('EVE2_ExtComm 9', curMC3.EXTCOM_Line_9__c);
                System.assertEquals('EVE2_Text 1', curMC3.TXT_Line_1__c);
                System.assertEquals('EVE2_Text 2', curMC3.TXT_Line_2__c);
                System.assertEquals('EVE2_Text 3', curMC3.TXT_Line_3__c);
                System.assertEquals('EVE2_Text 4', curMC3.TXT_Line_4__c);
                System.assertEquals('EVE2_Text 5', curMC3.TXT_Line_5__c);                
            }            
        }
    }
}