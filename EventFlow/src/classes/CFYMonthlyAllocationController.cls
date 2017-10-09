/**
 * CFYMonthlyAllocationController
 *
 * @description Controller for CFYMonthlyAllocation page
 * 
 * @author Phil Quinn
 * @date   2014-09-24
 *
 */

public class CFYMonthlyAllocationController {
    public CFYMonthlyAllocationController(){}
/*
    private final Event_Costs__c yearfinancial; // Current Year Financial
    //list to display AssignAmount objects related with the seleted yearfinancial
    List<Event_s_Details__c> monthlyAmountList = new List<Event_s_Details__c>();
    List<Event_s_Details__c> monthlyAssignAmountList = new List<Event_s_Details__c>();  //changed
    Boolean showBack = true;
    Boolean showSave = false;
    Boolean showCancel = false;
    String oppCurrency;
    public id eventRecordTypeID { get; set; }
    ID oppId;

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



    /**
     * @description Controller
     * @parm        stdController  Apex standard controller     
     */
/*    public CFYMonthlyAllocationController(ApexPages.StandardController stdController) {
        
        yearfinancial = [  SELECT  Id, 
                                   Opportunity__r.Currency__c,
                                   RecordTypeId  
                             FROM  Event_Costs__c
                            WHERE  Id = :stdController.getId()  ];
        oppCurrency = yearfinancial.Opportunity__r.Currency__c;
        oppId = yearfinancial.Opportunity__c;
        eventRecordTypeID = yearfinancial.RecordTypeId;

    }

    /**
     * @description List monthly amounts     
     */
/*    public void listAll() {

        Boolean page = true;
        Boolean error = false;
        List<Event_s_Details__c> initialLCNetGrossDetails = new List<Event_s_Details__c>();

        showBack = false;
        showCancel = true;
        
        monthlyAmountList = retrieveMonthlyAmountList();

    }

    /**
     * @description create and delete AssignObjects related with the selected yearfinancial
     */
/*    
    private Event_s_Details__c[] retrieveMonthlyAmountList() {
        
        final Integer MONTH_FIRST = 1;
        final Integer MONTH_LAST = 12;
        final Integer ADDITIONAL_YEARS = 5;  

        Integer currentYear = date.today().year();

        List<Event_s_Details__c> returnlist = new List<Event_s_Details__c>();
        List<Event_s_Details__c> initialLCNetGrossDetails = new List<Event_s_Details__c>();
        List<Event_s_Details__c> insertList = new List<Event_s_Details__c>();
        List<Event_s_Details__c> deleteList = new List<Event_s_Details__c>();
        Set<String> assignAmountContractDateSet  = new Set<String>();
        Set<String> allowedAssignAmountContractDateSet  = new Set<String>();

        Boolean isDisable = false;

        // Get user profile
        String SYSTEM_ADMIN = 'System Administrator';
        String usrProfileName = [ SELECT u.Profile.Name 
                                    FROM User u 
                                   WHERE u.id = :Userinfo.getUserId()].Profile.Name;

        // Get existing Monthly Amounts
        initialLCNetGrossDetails = [ SELECT Id, 
                                         Net_LC__c, 
                                         Net_USD__c, 
                                         Gross_LC__c, 
                                         Gross_USD__c, 
                                         Event_s__c, 
                                         Date__c, 
                                         Impressions__c 
                                    FROM Event_s_Details__c 
                                   WHERE Event_s__c = :yearfinancial.Id  ];
        
        // Create list of existing dates (String)
        for (Event_s_Details__c assignAmount : initialLCNetGrossDetails) {
            assignAmountContractDateSet.add(assignAmount.Date__c);
        }

        // Determine months for Current Year
        for (Integer i = 0; i < MONTH_LAST; i++) {
            String strMonth = getMonth(MONTH_FIRST + i);
            String conDate = strMonth + ' ' + currentYear;
            Id rtype;
            allowedAssignAmountContractDateSet.add(conDate);

            if (!(assignAmountContractDateSet.contains(conDate))) {
                if (yearfinancial.RecordTypeID == '01220000000Pj8TAAS') { //LN Current Year Financials
                    rtype = '01220000000Pj9MAAS'; //LN Gross and Net Details
                } else if (yearfinancial.RecordTypeID == '01220000000Pj8YAAS') { //TM Current Year Financials
                    rtype = '01220000000Pj9RAAS'; //TM Gross and Net Details
                }

                insertList.add(new Event_s_Details__c(RecordTypeID = rtype, 
                                                      Date__c = conDate, 
                                                      Event_s__c = yearfinancial.Id));
                                                      //,Opportunity__c = oppId));

            }
        }

        // Add years for additional years
        for (integer k = currentYear + 1 ; k <= currentYear + ADDITIONAL_YEARS; k++) {
            allowedAssignAmountContractDateSet.add(String.valueOf(k));
            if (!(assignAmountContractDateSet.contains(String.valueOf(k)))) {
                insertList.add(new Event_s_Details__c(Date__c = String.valueOf(k), 
                                                      Event_s__c = yearfinancial.Id));
                                                      //,Opportunity__c = oppId));
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


        monthlyAssignAmountList = [   SELECT Id, 
                                             Net_LC__c, 
                                             Net_USD__c, 
                                             Gross_LC__c, 
                                             Gross_USD__c, 
                                             Event_s__c, 
                                             Date__c, 
                                             YearMonth__c, 
                                             Impressions__c 
                                        FROM Event_s_Details__c 
                                       WHERE Event_s__c = :yearfinancial.Id 
                                    ORDER BY YearMonth__c  ];

        Datetime systemDate = System.now();
        Integer sysYear = systemDate.year();
        Integer sysMonth = systemDate.month();
        String sysYearMonth;

        // Zero pad single digit months
        sysYearMonth = sysYear + StringUtils.leftPad(String.valueOf(sysMonth), 2, '0');
        System.debug('sysYearMonth: ' + sysYearMonth);        
        
        Integer intSysYearMonth = Integer.valueof(sysYearMonth);

        // Disable past months unless user is a system admin
        for (Event_s_Details__c tempRetRecord : monthlyAssignAmountList) {
            if ((tempRetRecord.YearMonth__c) < intSysYearMonth) {
                if (usrProfileName != SYSTEM_ADMIN)
                    isDisable = true;
                else
                    isDisable = false;
            } else
                isDisable = false;            
        }
        return returnlist;
    }

    //function to get month according the totalTerms variable value of function retrieveMonthlyAmountList
    private String getMonth(Integer mon) {
        Integer month = mon;
        if (month > 12) {
            month = (mon - (12 * (month / 12)));
            if (month == 0)
                month = 12;
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


    private Integer getMonthInNumber(String monthName) {
        Integer month;
        month = 0;
        if (monthName == 'Jan') {
            month = 1;
        }
        if (monthName == 'Feb') {
            month = 2;
        }
        if (monthName == 'Mar') {
            month = 3;
        }
        if (monthName == 'Apr') {
            month = 4;
        }
        if (monthName == 'May') {
            month = 5;
        }
        if (monthName == 'Jun') {
            month = 6;
        }
        if (monthName == 'Jul') {
            month = 7;
        }
        if (monthName == 'Aug') {
            month = 8;
        }
        if (monthName == 'Sep') {
            month = 9;
        }
        if (monthName == 'Oct') {
            month = 10;
        }
        if (monthName == 'Nov') {
            month = 11;
        }
        if (monthName == 'Dec') {
            month = 12;
        }

        return month;
    }

    //function to save Amount1 and Amount2 fields of records ofAssignAmount object.
    private String getLastYear(String currentYear) {
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
        double TotalNetUSD = 0;
        double TotalImpressions = 0;
        double CurrentYearGrossLC = 0;
        double CurrentYearGrossUSD = 0 ;
        double CurrentYearNetLC = 0 ;
        double CurrentYearNetUSD = 0;
        String previousYear;
        /**for(Event_s_Details__c ED : monthlyAmountList){
                setMonths.add((ED.Date__c).substring(0,3));
                previousYear = getLastYear((ED.Date__c).substring(4,8));
                setYears.add(previousYear);
        }*/
/*        date myDate = date.today();
        Integer currentYear = mydate.year();

        for (Integer k = currentYear - 1; k <= currentYear + 5; k++) {
            setYears.add(String.valueOf(k));
        }
        Currencies__c [] curr = [Select c.Currency_Year__c, c.Currency_Type__c, c.Currency_Month__c, c.CurrencyRate__c From Currencies__c c where Currency_Year__c in: setYears and Currency_Type__c = :oppCurrency];
        for (Event_s_Details__c ED : monthlyAmountList) {

            if ((ED.Date__c).length() > 4) {
                for (Currencies__c c : curr) {
                    System.debug('c.Currency_Year__c = ' + c.Currency_Year__c);
                    System.debug('getLastYear((ED.Date__c).substring(4,8)) =' + getLastYear((ED.Date__c).substring(4, 8)));
                    System.debug('c.Currency_Month__c =' + c.Currency_Month__c );
                    System.debug('(ED.Date__c).substring(0,3)' + (ED.Date__c).substring(0, 3));
                    System.debug('oppCurrency' + oppCurrency);
                    System.debug('c.Currency_Type__c' + c.Currency_Type__c);

                    if (c.Currency_Year__c == getLastYear((ED.Date__c).substring(4, 8)) && c.Currency_Month__c == (ED.Date__c).substring(0, 3)  && oppCurrency == c.Currency_Type__c) {
                        System.debug('c.CurrencyRate__c = ' + c.CurrencyRate__c);
                        if (ED.Gross_LC__c != null) {
                            ED.Gross_USD__c = ED.Gross_LC__c * c.CurrencyRate__c;
                            TotalGrossLC += ED.Gross_LC__c;
                            TotalGrossUSD += ED.Gross_USD__c;
                            CurrentYearGrossLC += ED.Gross_LC__c;
                            CurrentYearGrossUSD += ED.Gross_USD__c;

                        }
                        if (ED.Net_LC__c != null) {
                            ED.Net_USD__c = ED.Net_LC__c * c.CurrencyRate__c;
                            TotalNetLC += ED.Net_LC__c;
                            TotalNetUSD += ED.Net_USD__c;
                            CurrentYearNetLC += ED.Net_LC__c;
                            CurrentYearNetUSD += ED.Net_USD__c;
                        }

                        if (ED.Impressions__c != null) {
                            TotalImpressions += ED.Impressions__c;
                            // TODO: Do we need a current year impressions?
                        }

                        //Added just for verification purpose.
                        ED.CurrentCurrencyRate__c =  c.CurrencyRate__c;
                    }
                }
            } else {
                Double TotalOfCurrencyRate = 0;
                for (Currencies__c cr : curr) {
                    if (oppCurrency == cr.Currency_Type__c && cr.Currency_Year__c  == getLastYear(ED.Date__c)) {
                        System.debug('cr.CurrencyRate__c = ' + cr.CurrencyRate__c);
                        TotalOfCurrencyRate += cr.CurrencyRate__c;
                    }
                }
                System.debug('TotalOfCurrencyRate' + TotalOfCurrencyRate);
                Double averageCurrencyRate = TotalOfCurrencyRate / 12;
                if (ED.Gross_LC__c != null) {
                    ED.Gross_USD__c = ED.Gross_LC__c * averageCurrencyRate;
                    TotalGrossLC += ED.Gross_LC__c;
                    TotalGrossUSD += ED.Gross_USD__c;
                }
                if (ED.Net_LC__c != null) {
                    ED.Net_USD__c = ED.Net_LC__c * averageCurrencyRate;
                    TotalNetLC += ED.Net_LC__c;
                    TotalNetUSD += ED.Net_USD__c;
                }
                if (ED.Impressions__c != null) {
                    TotalImpressions += ED.Impressions__c;
                }
            }


        }
        Event_Costs__c EC = new Event_Costs__c(Id = yearfinancial.Id);
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
        PageReference pageRef = new PageReference('/' + yearfinancial.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }

    //function to return back to the yearfinancial detail page.
    public PageReference cancel() {
        PageReference pageRef = new PageReference('/' + yearfinancial.Id);
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
/*    public class AmountDisplayException extends Exception {}
*/
}