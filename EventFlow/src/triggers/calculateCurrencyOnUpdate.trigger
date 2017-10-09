trigger calculateCurrencyOnUpdate on Event_s_Details__c (after update) {
  
	/*Event_s_Details__c [] updatedEventDetails = new Event_s_Details__c[]{};
	
	set<ID> setDealIDs = new Set<ID> ();
	set<ID> setUpdatedEventsIDs = new Set<ID> ();
	ID EventID;
	ID DealID;
	for (Integer i = 0; i < Trigger.old.size(); i++) {
		Event_s_Details__c old = Trigger.old[i];
		Event_s_Details__c nw = Trigger.new[i];
		if((old.Gross_LC__c != nw.Gross_LC__c && old.Gross_LC__c != null ) || (old.Net_LC__c != nw.Net_LC__c && old.Net_LC__c!= null) ){
			setUpdatedEventsIDs.add(nw.Event_s__c);
			setDealIDs.add(nw.Deal__c);
			EventID = nw.Event_s__c;
			DealID = nw.Deal__c;
		}
		
	}
	if(Trigger.isUpdate && setUpdatedEventsIDs.size()>0)
	{
		//calculateCurrency(setDealIDs,setUpdatedEventsIDs);
	}
	private void calculateCurrency(set<ID> dealIDs,set<ID> updatedEventsIDs){
		updatedEventDetails = [Select e.Deal__c,e.Event_s__c,Event_s__r.Event_to_Deal__c,Event_s__r.Event_to_Deal__r.Select_Currency__c,e.YearMonth__c, e.Net_USD__c, e.Net_LC__c, e.Gross_USD__c, e.Gross_LC__c, e.Date__c From Event_s_Details__c e where Event_s__c in:updatedEventsIDs];
		set<String> setMonths = new Set<String> ();
		set<String> setYears = new Set<String> ();
		String previousYear;
		for(Event_s_Details__c ED : updatedEventDetails){
		    setMonths.add((ED.Date__c).substring(0,3));
		    previousYear = getLastYear((ED.Date__c).substring(4,8));
		    setYears.add(previousYear);
		}
		double TotalGrossLC = 0; 
	    double TotalGrossUSD = 0 ;
	    double TotalNetLC = 0 ;
	    double TotalNetUSD= 0;  
		Currencies__c [] curr = [Select c.Currency_Year__c, c.Currency_Type__c, c.Currency_Month__c, c.CurrencyRate__c From Currencies__c c where Currency_Year__c in: setYears and Currency_Month__c in: setMonths];
		Map<String,Currencies__c> mapCurrency = new Map<String,Currencies__c>();
		for(Currencies__c c:curr){
			mapCurrency.put(c.Currency_Type__c + ',' + c.Currency_Year__c + ',' + c.Currency_Month__c, c);
			 
		}
		
		for(Event_s_Details__c ED : updatedEventDetails){
		   
		    ED.Gross_USD__c = ED.Gross_LC__c * mapCurrency.get(ED.Event_s__r.Event_to_Deal__r.Select_Currency__c + ',' + getLastYear((ED.Date__c).substring(4,8)) + ',' +(ED.Date__c).substring(0,3)).CurrencyRate__c;
		    TotalGrossLC += ED.Gross_LC__c;
		    TotalGrossUSD += ED.Gross_USD__c;

		    ED.Net_USD__c = ED.Net_LC__c * mapCurrency.get(ED.Event_s__r.Event_to_Deal__r.Select_Currency__c + ',' + getLastYear((ED.Date__c).substring(4,8)) + ',' +(ED.Date__c).substring(0,3)).CurrencyRate__c;
		    TotalNetLC += ED.Net_LC__c;
		    TotalNetUSD += ED.Net_USD__c;
		    
		}

		update updatedEventDetails;
		Event_Costs__c EC = new Event_Costs__c(Id = EventID);
        EC.Total_USD_Gross__c = TotalGrossUSD;
        EC.Total_USD_Net__c = TotalNetUSD;
        EC.Total_LC_Gross__c = TotalGrossLC;
        EC.Total_LC_Net__c = TotalNetLC;
        update EC;
        
	}
	
	private String getLastYear(String currentYear){
	    Integer YEAR = Integer.valueof(currentYear);
	    YEAR = YEAR - 1;
	    String strYEAR = String.valueOf(YEAR);
	    return strYEAR;
	}
	*/
}