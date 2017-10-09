public class calculateCurrency {
    public calculateCurrency() {}
        /*private final Event_Costs__c event;
            //list to display AssignAmount objects related with the seleted event
            List<Event_s_Details__c> monthlyAmountList = new List<Event_s_Details__c>();
            List<Event_s_Details__c> monthlyAssignAmountList = new List<Event_s_Details__c>();      //changed
            Boolean showBack = true;
            Boolean showSave = false;
            Boolean showCancel = false;
            String dealCurrency;  
            //getters & setters
            public Event_s_Details__c[] getmonthlyAmountList () { return monthlyAmountList ; }
            public void setmonthlyAmountList (Event_s_Details__c[] monAmount) { this.monthlyAmountList  = monAmount; }
            public Boolean getHasErrors() { return ApexPages.hasMessages(); }    
            public Boolean getHasNoErrors() { return !getHasErrors(); }    
            public Boolean getShowBack() { return showBack; }
            public void setShowBack(Boolean bool) { showBack = bool; } 
            public Boolean getShowCancel() { return showCancel; }
            public id eventRecordTypeID { get; set; }
            
            public void setShowCancel(Boolean bool) { showCancel = bool; }
            
            ID dealId;
             
            //Controller
            public calculateCurrency(ApexPages.StandardController stdController) {
                this.event = [Select Id,Event_Costs__c.Event_to_Deal__r.Select_Currency__c, End_Month_of_Recognition__c, End_Year_of_Recognition__c, Month_of_Recognition__c, Year_of_Recognition__c, Event_Costs__c.RecordTypeId  from Event_Costs__c where Id=:stdController.getId()];
                dealCurrency = event.Event_to_Deal__r.Select_Currency__c;
            
                dealId = event.Event_to_Deal__c;
                eventRecordTypeID = event.RecordTypeId;
            }
            
            //function to list all related AssignAmount objects.    
            public void listAll(){
                monthlyAmountList.clear();
                Boolean page = true;
                Boolean error = false;
                List<Event_s_Details__c> tempMonthlyAmountList = new List<Event_s_Details__c>();
                //Validations
                /**if((event.Year_of_Recognition__c) == null){
                    ApexPages.Message msg = new ApexPages.message(ApexPages.Severity.Error,'Starting Year field is blank');
                    ApexPages.addMessage(msg);
                    error = true;            
                }
                if((event.End_Year_of_Recognition__c) == null){
                    ApexPages.Message msg = new ApexPages.message(ApexPages.Severity.Error,'Ending Year field is blank');
                    ApexPages.addMessage(msg);
                    error = true;           
                }*/
/*
       			if(error == false){
                    /*Integer valStartingYear = Integer.valueof(event.Year_of_Recognition__c);
                    Integer valEndingYear = Integer.valueof(event.End_Year_of_Recognition__c);
                    Integer yearDifference = valEndingYear - valStartingYear;
                    String strStartingMonth = String.valueOf(event.Month_of_Recognition__c);
                    String strEndingMonth = String.valueOf(event.End_Month_of_Recognition__c);
                    
                    Integer valStartingMonth = getMonthInNumber(strStartingMonth);
                    Integer valEndingMonth = getMonthInNumber(strEndingMonth);
                   
                    //Validations
                    if(valStartingMonth == 0){
                        ApexPages.Message msg = new ApexPages.message(ApexPages.Severity.Error,'Starting Month field is blank');
                        ApexPages.addMessage(msg);
                        page = false;
                    }
                    if(valEndingMonth == 0){
                        ApexPages.Message msg = new ApexPages.message(ApexPages.Severity.Error,'Ending Month field is blank');
                        ApexPages.addMessage(msg);
                        page = false;
                    }
                    if(yearDifference == 0){
                        if(valStartingMonth > valEndingMonth){
                            ApexPages.Message msg = new ApexPages.message(ApexPages.Severity.Error,'Starting Month value is less than Ending Month value');
                            ApexPages.addMessage(msg);
                            page = false;
                        }
                    }*/
/*
                    if(page == true){
                        showBack = false;
                        showCancel = true;
                        //Calling function to retreive list of related AssignAmount objects.
                        monthlyAmountList = retrieveMonthlyAmountList();
                        //monthlyAmountList = [Select Id, Net_LC__c,Net_USD__c, Gross_LC__c,Gross_USD__c, Event_s__c, Date__c from Event_s_Details__c where Event_s__c=:event.Id];
                        System.debug('monthlyAmountList ====' + monthlyAmountList);
                    }
                }
            }
            
            /** function to create and delete AssignObjects related with the selected event
                based on the value of End_Month_of_Recognition__c, End_Year_of_Recognition__c, Month_of_Recognition__c and 
                Year_of_Recognition__c fields of Event_Costs__c object. */
/*
            private Event_s_Details__c[] retrieveMonthlyAmountList() {
                Integer totalTerms = 0;
                
                date myDate = date.today();
                //Integer startingMonth = mydate.month();
                Integer startingMonth = 1;
                Integer startingYear = mydate.year();
                
                //Integer valStartingYear = startYear;
                //Integer valEndingYear = endYear;
                
                Integer valStartingYear = startingYear;
                Integer valEndingYear = startingYear;
                
                Integer yearDifference = valEndingYear - valStartingYear;
                
                //Integer valStartingMonth = startMonth;
                //Integer valEndingMonth = endMonth;
                if(startingMonth > 1){
                        startingMonth -= 1;
                } 
                Integer valStartingMonth = startingMonth;
                Integer valEndingMonth = 12;
                
                List<Event_s_Details__c> returnlist = new List<Event_s_Details__c>();
                List<Event_s_Details__c> tempMonthlyAmountList = new List<Event_s_Details__c>(); 
                List<Event_s_Details__c> insertList = new List<Event_s_Details__c>(); 
                List<Event_s_Details__c> deleteList = new List<Event_s_Details__c>(); 
                Set<String> assignAmountContractDateSet  = new Set<String>();
                Set<String> allowedAssignAmountContractDateSet  = new Set<String>();
                
                Boolean isDisable = false;
                String SYSTEM_ADMIN ='System Administrator';
                String usrProfileName = [select u.Profile.Name from User u where u.id = :Userinfo.getUserId()].Profile.Name; 
                
                if(yearDifference == 0){            
                    totalTerms = (valEndingMonth - valStartingMonth)+1;
                }
                /*else if(yearDifference>0){
                    totalTerms = totalTerms + ((yearDifference - 1) * 12);
                    totalTerms = totalTerms + (12 - valStartingMonth) + 1;
                    totalTerms = totalTerms + valEndingMonth;
                }  */
/*
                tempMonthlyAmountList = [Select Id, Net_LC__c,Net_USD__c, Gross_LC__c,Gross_USD__c, Event_s__c, Date__c, Impressions__c from Event_s_Details__c where Event_s__c=:event.Id];
                for(Event_s_Details__c assignAmount: tempMonthlyAmountList){
                    assignAmountContractDateSet.add(assignAmount.Date__c);
                }
                
                for(Integer i=0; i<totalTerms; i++){
                    Integer year;
                    if(yearDifference == 0)
                        year = valStartingYear;
                    /*else if(yearDifference > 0){
                        if((valStartingMonth + i)>12){ 
                            Integer addYear = ((valStartingMonth + i - 1) / 12);
                            year = valStartingYear + addYear;
                        }else
                            year = valStartingYear; 
                    }*/
/*
                    String strMonth = getMonth(valStartingMonth + i);
                    String conDate = strMonth+' '+ year;
                    Id rtype;
                    allowedAssignAmountContractDateSet.add(conDate);
                    
                    if(!(assignAmountContractDateSet.contains(conDate))){
                        if (event.RecordTypeID == '01220000000Pj8TAAS') //LN Current Year Financials
                        {
                            rtype = '01220000000Pj9MAAS'; //LN Gross and Net Details
                        }
                        else if (event.RecordTypeID == '01220000000Pj8YAAS') //TM Current Year Financials
                        {
                            rtype = '01220000000Pj9RAAS'; //TM Gross and Net Details
                        }
                            
                        insertList.add(new Event_s_Details__c(RecordTypeID = rtype, Date__c = conDate, Event_s__c = event.Id,Deal__c=dealId));
                        
                        }
                    }
                for (integer k=startingYear+1 ; k<= startingYear+5; k++){
                        allowedAssignAmountContractDateSet.add(String.valueOf(k));
                        if(!(assignAmountContractDateSet.contains(String.valueOf(k)))){
                                insertList.add(new Event_s_Details__c(Date__c = String.valueOf(k), Event_s__c = event.Id,Deal__c=dealId));
                        }
                
                }
                    
                for(Event_s_Details__c assignAmount: tempMonthlyAmountList){
                    if(!(allowedAssignAmountContractDateSet.contains(assignAmount.Date__c))){
                        deleteList.add(assignAmount);
                    }else{
                        returnlist.add(assignAmount);
                    }
                }
                        
                try{
                    if(deleteList.size()>0)
                        delete deleteList;
                }catch (Exception e) {
                    throw new AmountDisplayException('Error:  Deletion failed: '+e.getMessage());
                }
                try{
                    if(insertList.size()>0)
                        insert insertList;
                }catch (Exception e) {
                    throw new AmountDisplayException('Error:  Insertion failed: '+e.getMessage());
                }    
                 
                returnlist.addAll(insertList);
                monthlyAssignAmountList = [Select Id, Net_LC__c,Net_USD__c, Gross_LC__c,Gross_USD__c, Event_s__c, Date__c,YearMonth__c, Impressions__c from Event_s_Details__c where Event_s__c=:event.Id order by YearMonth__c];
                  
                Datetime systemDate = System.now();
                Integer sysYear = systemDate.year();
                Integer sysMonth = systemDate.month();
                String sysYearMonth;
                if(sysMonth<10)
                    sysYearMonth = sysYear +'0'+ sysMonth;
                else
                    sysYearMonth = sysYear +''+ sysMonth;
                Integer intSysYearMonth = Integer.valueof(sysYearMonth);
                
                for(Event_s_Details__c tempRetRecord : monthlyAssignAmountList){
                        if((tempRetRecord.YearMonth__c) < intSysYearMonth){
                                if(usrProfileName != SYSTEM_ADMIN)                  
                                isDisable = true;
                            else
                                isDisable = false;
                        }
                    else
                        isDisable = false;
                    //returnlist.add(new AssignAmountEdit(tempRetRecord, isDisable)); 
                }
                return returnlist;      
            }
            
            //function to get month according the totalTerms variable value of function retrieveMonthlyAmountList
            private String getMonth(Integer mon){
                Integer month = mon;
                if(month>12){
                    month = (mon-(12*(month/12)));  
                    if(month == 0)
                        month = 12;
                }        
                String strMonth = 'None';
                    if(month == 1)
                        strMonth = 'Jan';
                    else if(month == 2)
                        strMonth = 'Feb';
                    else if(month == 3)
                        strMonth = 'Mar';
                    else if(month == 4)
                        strMonth = 'Apr';
                    else if(month == 5)
                        strMonth = 'May';
                    else if(month == 6)
                        strMonth = 'Jun';
                    else if(month == 7)
                        strMonth = 'Jul';
                    else if(month == 8)
                        strMonth = 'Aug';
                    else if(month == 9)
                        strMonth = 'Sep';
                    else if(month == 10)
                        strMonth = 'Oct';
                    else if(month == 11)
                        strMonth = 'Nov';
                    else if(month == 12)
                        strMonth = 'Dec';
                return strMonth;
            }
            private Integer getMonthInNumber(String monthName){
                Integer month;
                month = 0;
                if(monthName == 'Jan'){
                        month = 1;
                }
                if(monthName == 'Feb'){
                        month = 2;
                }
                if(monthName == 'Mar'){
                        month = 3;
                }
                if(monthName == 'Apr'){
                        month = 4;
                }
                if(monthName == 'May'){
                        month = 5;
                }
                if(monthName == 'Jun'){
                        month = 6;
                }
                if(monthName == 'Jul'){
                        month = 7;
                }
                if(monthName == 'Aug'){
                        month = 8;
                }
                if(monthName == 'Sep'){
                        month = 9;
                }
                if(monthName == 'Oct'){
                        month = 10;
                }
                if(monthName == 'Nov'){
                        month = 11;
                }
                if(monthName == 'Dec'){
                        month = 12;
                }
                
                return month; 
            } 
            
            //function to save Amount1 and Amount2 fields of records ofAssignAmount object.
            private String getLastYear(String currentYear){
                Integer YEAR = Integer.valueof(currentYear);
                YEAR = YEAR - 1;
                String strYEAR = String.valueOf(YEAR);
                return strYEAR;
            }
            
            public PageReference save() {     
                 System.debug('monthlyAmountList2 =' + monthlyAmountList);   
                update monthlyAmountList;
                set<String> setMonths = new Set<String> ();
                set<String> setYears = new Set<String> ();
                double TotalGrossLC = 0;
                double TotalGrossUSD = 0 ;
                double TotalNetLC = 0 ;
                double TotalNetUSD= 0;
                double TotalImpressions = 0;
                double CurrentYearGrossLC = 0;
                double CurrentYearGrossUSD = 0 ;
                double CurrentYearNetLC = 0 ;
                double CurrentYearNetUSD= 0;
                String previousYear;
                /**for(Event_s_Details__c ED : monthlyAmountList){
                        setMonths.add((ED.Date__c).substring(0,3));
                        previousYear = getLastYear((ED.Date__c).substring(4,8));
                        setYears.add(previousYear);
                }*/
/*
                date myDate = date.today();
                Integer startingYear = mydate.year();
                        
                for(Integer k=startingYear-1; k<=startingYear + 5; k++){
                        setYears.add(String.valueOf(k));
                }
                Currencies__c [] curr = [Select c.Currency_Year__c, c.Currency_Type__c, c.Currency_Month__c, c.CurrencyRate__c From Currencies__c c where Currency_Year__c in: setYears and Currency_Type__c =:dealCurrency];
                for(Event_s_Details__c ED : monthlyAmountList){
        
                        if((ED.Date__c).length() > 4){
                                for(Currencies__c c:curr){
                                        System.debug('c.Currency_Year__c = ' + c.Currency_Year__c);
                                        System.debug('getLastYear((ED.Date__c).substring(4,8)) =' + getLastYear((ED.Date__c).substring(4,8)));
                                        System.debug('c.Currency_Month__c =' + c.Currency_Month__c );
                                        System.debug('(ED.Date__c).substring(0,3)' + (ED.Date__c).substring(0,3));
                                        System.debug('dealCurrency' + dealCurrency);
                                        System.debug('c.Currency_Type__c' + c.Currency_Type__c);
                                
                                        if(c.Currency_Year__c == getLastYear((ED.Date__c).substring(4,8)) && c.Currency_Month__c == (ED.Date__c).substring(0,3)  && dealCurrency == c.Currency_Type__c){
                                                System.debug('c.CurrencyRate__c = ' + c.CurrencyRate__c);
                                                if(ED.Gross_LC__c != null){
                                                        ED.Gross_USD__c = ED.Gross_LC__c * c.CurrencyRate__c;
                                                        TotalGrossLC += ED.Gross_LC__c;
                                                        TotalGrossUSD += ED.Gross_USD__c;
                                                        CurrentYearGrossLC += ED.Gross_LC__c;
                                                        CurrentYearGrossUSD += ED.Gross_USD__c;
             
                                                }
                                                if(ED.Net_LC__c != null){       
                                                        ED.Net_USD__c = ED.Net_LC__c * c.CurrencyRate__c;
                                                        TotalNetLC += ED.Net_LC__c;
                                                        TotalNetUSD += ED.Net_USD__c;
                                                        CurrentYearNetLC += ED.Net_LC__c;
                                                        CurrentYearNetUSD += ED.Net_USD__c;
                                                }
                                             
                                                 if(ED.Impressions__c != null)
                                                 {
                                                     TotalImpressions += ED.Impressions__c;
                                                     // TODO: Do we need a current year impressions?
                                                 }   
                                                 
                                                //Added just for verification purpose.
                                                ED.CurrentCurrencyRate__c =  c.CurrencyRate__c;
                                        }
                                }
                        }
                        else{
                                        Double TotalOfCurrencyRate = 0;
                                        for(Currencies__c cr:curr){
                                                if(dealCurrency == cr.Currency_Type__c && cr.Currency_Year__c  == getLastYear(ED.Date__c)){
                                                        System.debug('cr.CurrencyRate__c = ' + cr.CurrencyRate__c);
                                                        TotalOfCurrencyRate += cr.CurrencyRate__c;
                                                }
                                        }
                                        System.debug('TotalOfCurrencyRate' + TotalOfCurrencyRate);
                                        Double averageCurrencyRate = TotalOfCurrencyRate/12;
                                        if(ED.Gross_LC__c != null){
                                                ED.Gross_USD__c = ED.Gross_LC__c * averageCurrencyRate;
                                                TotalGrossLC += ED.Gross_LC__c;
                                                TotalGrossUSD += ED.Gross_USD__c;
                                        }
                                        if(ED.Net_LC__c != null){       
                                                ED.Net_USD__c = ED.Net_LC__c * averageCurrencyRate;
                                                TotalNetLC += ED.Net_LC__c;
                                                TotalNetUSD += ED.Net_USD__c;
                                        }
                                        if(ED.Impressions__c != null)
                                        {
                                            TotalImpressions += ED.Impressions__c;
                                        }
                                }
                                        
                        
                }
                Event_Costs__c EC = new Event_Costs__c(Id = event.Id);
                EC.Total_USD_Gross__c = TotalGrossUSD;
                EC.Total_USD_Net__c = TotalNetUSD;
                EC.Total_LC_Gross__c = TotalGrossLC;
                EC.Total_LC_Net__c = TotalNetLC;
                EC.Impressions_Number__c = TotalImpressions;
                
                //Total of current years
                EC.Current_Year_USD_Gross__c = CurrentYearGrossUSD;
                EC.Current_Year_USD_Net__c = CurrentYearNetUSD;
                EC.Current_Year_LC_Gross__c = CurrentYearGrossLC;
                EC.Current_Year_LC_Net__c = CurrentYearNetLC;
                
                update EC;
                
                        
                System.debug('monthlyAmountList' + monthlyAmountList);
                update monthlyAmountList;
                PageReference pageRef = new PageReference('/' + event.Id);        
                pageRef.setRedirect(true);
                return pageRef;
            } 
            
            //function to return back to the event detail page.
            public PageReference cancel() {
                PageReference pageRef = new PageReference('/' + event.Id);
                pageRef.setRedirect(true);
                return pageRef;
            }
            /**public class AssignAmountEdit {
        
                public String assignAmountId {
                    get { return assignAmountId; }
                    set { assignAmountId = value; }
                }
                public String assignAmountContractDate {
                    get { return assignAmountContractDate; }
                    set { assignAmountContractDate = value; }
                }
                public String assignAmountAmount1 {
                    get { return assignAmountAmount1; }
                    set { assignAmountAmount1 = value; }
                }
                public String assignAmountAmount2 {
                    get { return assignAmountAmount2; }
                    set { assignAmountAmount2 = value; }
                }
                public Boolean isDisable {
                    get { return isDisable; }
                    set { isDisable = value; }
                }
        
        // constructor
                public AssignAmountEdit(Event_s_Details__c assignAmount, Boolean disable) {
                    this.isDisable = disable; 
                    if(assignAmount==null) {
                        assignAmountId = null;
                    }
                    else {
                        this.assignAmountId = assignAmount.Id;
                        this.assignAmountAmount1 = String.valueOf(assignAmount.Net_LC__c);  
                        this.assignAmountAmount2 = String.valueOf(assignAmount.Gross_LC__c); 
                        this.assignAmountContractDate = assignAmount.Date__c;             
                    }
                }
        }*/
/*
            public class AmountDisplayException extends Exception {}  
*/
}