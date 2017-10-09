public class LC_Gross_Net_AllocationController {

    //oe:gen private final Event_Costs__c yearfinancial; // Current Year Financial
    private final Opportunity theOpp;
    //list to display AssignAmount objects related to the Opportunity
    List<Event_s_Details__c> monthlyAmountList = new List<Event_s_Details__c>();
    //oe:gen List<Event_s_Details__c> monthlyAssignAmountList = new List<Event_s_Details__c>();  //changed
    Boolean showBack = true;
    Boolean showSave = false;
    Boolean showCancel = false;
    String oppCurrency;
    public id oppRecordTypeID { get; set; }
    ID oppId;
    
    //oe:gen
    Integer startMonthInt = 0;
    Integer totalMonthsInt = 0;
    Integer startYearInt = 0;
    Integer endYearInt = 0;

    //getters & setters
    public Event_s_Details__c[] getmonthlyAmountList () {
        return monthlyAmountList ;
    }
    public void setmonthlyAmountList (Event_s_Details__c[] monAmount) {
        monthlyAmountList  = monAmount;
    }
    public Boolean getHasErrors() {
        return ApexPages.hasMessages();
    }
    public Boolean getHasNoErrors() {
        return !getHasErrors();
    }
    public Boolean getShowBack() {
        return showBack;
    }
    public void setShowBack(Boolean bool) {
        showBack = bool;
    }
    public Boolean getShowCancel() {
        return showCancel;
    }
    public void setShowCancel(Boolean bool) {
        showCancel = bool;
    }
    
    //Extension constructor
    public LC_Gross_Net_AllocationController(ApexPages.StandardController stdController) {
        theOpp = [SELECT  Id, Currency__c, RecordTypeId, RecordType.DeveloperName, ContractStartDate__c, ContractEndDate__c, CreatedDate, Name
                  FROM Opportunity
                  WHERE  Id = :stdController.getId() LIMIT 1];
        oppCurrency = theOpp.Currency__c;
        oppRecordTypeID = theOpp.RecordTypeId;
        if(theOpp.ContractStartDate__c == null || theOpp.ContractEndDate__c == null) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please return to the Opportunity and enter Contract Start and End Dates'));
        }
        else {
            startMonthInt = theOpp.ContractStartDate__c.month();
            startYearInt = theOpp.ContractStartDate__c.year();
            endYearInt = theOpp.ContractEndDate__c.year();
            totalMonthsInt = (((theOpp.ContractEndDate__c.year() - theOpp.ContractStartDate__c.year() - 1) *12) + (12 - theOpp.ContractStartDate__c.month() +1) + theOpp.ContractEndDate__c.month());
        }        
    }

    // List monthly amounts
    public void listAll() {
        //oe:gen
        if(ApexPages.getMessages().size() > 0){
            // do nothing, just display the messages
        }
        else{
            Boolean page = true;
            Boolean error = false;
            List<Event_s_Details__c> initialLCNetGrossDetails = new List<Event_s_Details__c>();
            showBack = false;
            showCancel = true;
            monthlyAmountList = retrieveMonthlyAmountList();
        }
    }

    /**
     * @description create and delete AssignObjects related to the Opportunity
     */
    
    private Event_s_Details__c[] retrieveMonthlyAmountList() {

        List<Event_s_Details__c> returnlist = new List<Event_s_Details__c>();
        List<Event_s_Details__c> initialLCNetGrossDetails = new List<Event_s_Details__c>();
        List<Event_s_Details__c> insertList = new List<Event_s_Details__c>();
        List<Event_s_Details__c> deleteList = new List<Event_s_Details__c>();
        Set<String> existingDates = new Set<String>();
        Set<String> allowedAssignAmountContractDateSet  = new Set<String>();

        Boolean isDisable = false;
        
        // Get existing Monthly Amounts
        initialLCNetGrossDetails = [ SELECT Id, 
                                         Net_LC__c, 
                                         Gross_LC__c,
                                         Opportunity__c, 
                                         Date__c
                                    FROM Event_s_Details__c 
                                   WHERE Opportunity__c = :theOpp.Id  ];
        
        // Create list of existing dates (String)
        for (Event_s_Details__c assignAmount : initialLCNetGrossDetails) {
            existingDates.add(assignAmount.Date__c);
        }

        //oe:gen - move to using contract start/end dates instead of current year
        for (Integer i = 0; i < totalMonthsInt; i++) {
            
            String strMonth = getMonth(startMonthInt + i);
            Decimal yearDecimal = ((startMonthInt + i - 0.1) / 12);
            String currentYear = String.valueOf(startYearInt + yearDecimal.round(System.RoundingMode.DOWN));
            
            String conDate = strMonth + ' ' + currentYear;
            Id rtype;
            allowedAssignAmountContractDateSet.add(conDate);

            if (!(existingDates.contains(conDate))) {
                //oe:gen
                if (theOpp.RecordType.DeveloperName == 'Marketing_Partnerships_Current' || theOpp.RecordType.DeveloperName == 'Marketing_Partnerships_Budget') { //LN Current/Budget Year Financials
                    rtype = '01220000000Pj9M'; //LN Gross and Net Details
                }
                else if (theOpp.RecordType.DeveloperName == 'TM_Current') { //TM Current Year Financials
                    rtype = '01220000000Pj9R'; //TM Gross and Net Details
                }
                insertList.add(new Event_s_Details__c(RecordTypeID = rtype, 
                                                      Date__c = conDate, 
                                                      Opportunity__c = theOpp.Id,
                                                      Gross_LC__c = 0,
                                                      Net_LC__c = 0));
            }
        }

        // Prepare to remove LC Gross/Net records for dates not required
        for (Event_s_Details__c assignAmount : initialLCNetGrossDetails) {
            if (!(allowedAssignAmountContractDateSet.contains(assignAmount.Date__c))) {
                deleteList.add(assignAmount);
            } else {
                returnlist.add(assignAmount);
            }
        }

        // Delete unneeded LC Gross/Net records
        try {
            if (deleteList.size() > 0)
                delete deleteList;
        } catch (Exception e) {
            throw new AmountDisplayException('Error:  Deletion failed: ' + e.getMessage());
        }
        // Insert new LC Gross/Net records
        try {
            if (insertList.size() > 0)
                insert insertList;
        } catch (Exception e) {
            throw new AmountDisplayException('Error:  Insertion failed: ' + e.getMessage());
        }

        // Add inserted records to return list
        returnlist.addAll(insertList);
        return returnlist;
    }

    //function to get month string via integer representation of month
    private String getMonth(Integer mon) {
        Integer month = mon;
        if (month > 12) {
            month = math.mod(month, 12);
            if (month == 0) {
                month = 12;
            }
        }
        String strMonth = 'None';
        if (month == 1)
            strMonth = 'Jan';
        else if (month == 2)
            strMonth = 'Feb';
        else if (month == 3)
            strMonth = 'Mar';
        else if (month == 4)
            strMonth = 'Apr';
        else if (month == 5)
            strMonth = 'May';
        else if (month == 6)
            strMonth = 'Jun';
        else if (month == 7)
            strMonth = 'Jul';
        else if (month == 8)
            strMonth = 'Aug';
        else if (month == 9)
            strMonth = 'Sep';
        else if (month == 10)
            strMonth = 'Oct';
        else if (month == 11)
            strMonth = 'Nov';
        else if (month == 12)
            strMonth = 'Dec';
        return strMonth;
    }
    
    /*
    //function to save Amount1 and Amount2 fields of records ofAssignAmount object.
    private String getLastYear(String currentYear) {
        Integer YEAR = Integer.valueof(currentYear);
        YEAR = YEAR - 1;
        String strYEAR = String.valueOf(YEAR);
        return strYEAR;
    }
    */

    public PageReference save() {
        System.debug('monthlyAmountList2 =' + monthlyAmountList);
        update monthlyAmountList;
        set<String> setMonths = new Set<String> ();
        set<String> setYears = new Set<String> ();
        double CurrentYearGrossLC = 0;
        double CurrentYearGrossUSD = 0;
        double CurrentYearNetLC = 0;
        double CurrentYearNetUSD = 0;
        double NextYearGrossLC = 0;
        double NextYearGrossUSD = 0;
        double NextYearNetLC = 0;
        double NextYearNetUSD = 0;
        double TotalGrossUSD = 0;
        double TotalNetUSD = 0;
        Integer currentYear = DateTime.now().year();
        
        //oe:gen
        if(theOpp.ContractStartDate__c != null && theOpp.ContractEndDate__c != null) {
            for (Integer k = theOpp.ContractStartDate__c.year()-1; k <= theOpp.ContractEndDate__c.year(); k++) {
                setYears.add(String.valueOf(k));
            }
        }
        Currencies__c [] curr = [Select c.Currency_Year__c, c.Currency_Type__c, c.Currency_Month__c, c.CurrencyRate__c From Currencies__c c where Currency_Year__c in: setYears and Currency_Type__c = :oppCurrency];
        //oe:gen - move to a map for efficiency
        Map<String,Currencies__c> currencyMap = new Map<String,Currencies__c>();
        for(Currencies__c c : curr) {
            currencyMap.put(c.Currency_Year__c + c.Currency_Month__c.toLowerCase() + c.Currency_Type__c.toLowerCase(), c);
        }
        for (Event_s_Details__c ED : monthlyAmountList) {
            //oe:gen - change so that now we match the LC_Gross_Net_Details record against a current year currency, and not one year previous
            String matchingStr = ED.Date__c.right(4) + ED.Date__c.left(3).toLowerCase() + oppCurrency.toLowerCase();
            //oe:gen
            if (currencyMap.get(matchingStr) != null) {
                Currencies__c c = currencyMap.get(matchingStr);
                ED.Currency__c = c.Id;
                if (ED.Gross_LC__c != null) {
                    Decimal grossUSD = ED.Gross_LC__c * c.CurrencyRate__c;
                    TotalGrossUSD += grossUSD;
                    if (Integer.valueOf(ED.Date__c.right(4)) == currentYear) {
                        CurrentYearGrossLC += ED.Gross_LC__c;
                        CurrentYearGrossUSD += grossUSD;
                    }
                    else if (Integer.valueOf(ED.Date__c.right(4)) == currentYear + 1) {
                        NextYearGrossLC += ED.Gross_LC__c;
                        NextYearGrossUSD += grossUSD;
                    }
                }
                if (ED.Net_LC__c != null) {
                    Decimal netUSD = ED.Net_LC__c * c.CurrencyRate__c;
                    TotalNetUSD += netUSD;
                    if (Integer.valueOf(ED.Date__c.right(4)) == currentYear) {                       
                        CurrentYearNetLC += ED.Net_LC__c;
                        CurrentYearNetUSD += netUSD;
                    }
                    else if (Integer.valueOf(ED.Date__c.right(4)) == currentYear + 1) {
                        NextYearNetLC += ED.Net_LC__c;
                        NextYearNetUSD += netUSD;
                    }
                }
            }
        }
        
        Opportunity o = new Opportunity(Id = theOpp.Id);

        o.Total_USD_Gross__c = TotalGrossUSD;
        o.Total_USD_Net__c = TotalNetUSD;
        o.Current_Year_USD_Gross__c = CurrentYearGrossUSD;
        o.Current_Year_USD_Net__c = CurrentYearNetUSD;
        o.Current_Year_LC_Gross__c = CurrentYearGrossLC;
        o.Current_Year_LC_Net__c = CurrentYearNetLC;
        o.Next_Year_USD_Gross__c = NextYearGrossUSD;
        o.Next_Year_USD_Net__c = NextYearNetUSD;
        o.Next_Year_LC_Gross__c = NextYearGrossLC;
        o.Next_Year_LC_Net__c = NextYearNetLC;
        
        //oe:gen
        try{
            update o;
            if(test.isRunningTest() && theOpp.Name == 'Fail'){
                o = new Opportunity();
                update o;
            }
        } catch(DMLexception e) {
            Integer numErrors = e.getNumDml();
            for(Integer i=0;i<numErrors;i++) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, e.getDmlMessage(i)));
            }
            return null;
        }
        //oe:gen
        try{
            update monthlyAmountList;
            if(test.isRunningTest() && theOpp.Name == 'Fail'){
                monthlyAmountList = new List<Event_s_Details__c>();
                update monthlyAmountList;
            }
        } catch(DMLexception e) {
            Integer numErrors = e.getNumDml();
            for(Integer i=0;i<numErrors;i++) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, e.getDmlMessage(i)));
            }
            return null;
        }
        PageReference pageRef = new PageReference('/' + theOpp.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }

    //function to return back to the Opportunity detail page
    public PageReference cancel() {
        PageReference pageRef = new PageReference('/' + theOpp.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public class AmountDisplayException extends Exception {}
}