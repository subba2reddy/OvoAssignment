public class Currencies_Helper {
	public static void calculateTotals(List<Currencies__c> records) {
        Set<Id> currencyIds = new Set<Id>();
        for(Currencies__c c : records) {
            currencyIds.add(c.Id);
        }
        List<Opportunity> opps = [SELECT Id, CreatedDate, (SELECT Gross_USD_formula__c, Net_USD_formula__c, Date__c FROM LC_Gross_and_Net_Details__r) FROM Opportunity WHERE Id IN (SELECT Opportunity__c FROM Event_s_Details__c WHERE Currency__c IN :currencyIds)];
        
        for(Opportunity o : opps) {
            List<Event_s_Details__c> edList = o.LC_Gross_and_Net_Details__r;
            double CurrentYearGrossUSD = 0;
            double CurrentYearNetUSD = 0;
            double NextYearGrossUSD = 0;
            double NextYearNetUSD = 0;
            double TotalGrossUSD = 0;
            double TotalNetUSD = 0;
            Integer currentYear = DateTime.now().year();
            
            for(Event_s_Details__c ED : edList) {
                if (ED.Gross_USD_formula__c != 0 && ED.Gross_USD_formula__c != null) {
                    TotalGrossUSD += ED.Gross_USD_formula__c;
                    if (Integer.valueOf(ED.Date__c.right(4)) == currentYear) {
                        CurrentYearGrossUSD += ED.Gross_USD_formula__c;
                    }
                    else if (Integer.valueOf(ED.Date__c.right(4)) == currentYear + 1) {
                        NextYearGrossUSD += ED.Gross_USD_formula__c;
                    }
                }
                if (ED.Net_USD_formula__c != 0 && ED.Net_USD_formula__c != null) {
                    TotalNetUSD += ED.Net_USD_formula__c;
                    if (Integer.valueOf(ED.Date__c.right(4)) == currentYear) {
                        CurrentYearNetUSD += ED.Net_USD_formula__c;
                    }
                    else if (Integer.valueOf(ED.Date__c.right(4)) == currentYear + 1) {
                        NextYearNetUSD += ED.Net_USD_formula__c;
                    }
                }
            }
            o.Current_Year_USD_Gross__c = CurrentYearGrossUSD;
            o.Current_Year_USD_Net__c = CurrentYearNetUSD;
            o.Next_Year_USD_Gross__c = NextYearGrossUSD;
            o.Next_Year_USD_Net__c = NextYearNetUSD;
            o.Total_USD_Gross__c = TotalGrossUSD;
        	o.Total_USD_Net__c = TotalNetUSD;
        }
        update opps;
    }
}