//Used to calculate the grand totals for USD Gross, USD Net, LC Gross and LC Net CURRENT YEAR and TOTAL fields on Opportunity
//Whenever an LC_Gross_Net_Details record is updated, the totals on Opportunity are re-calculated and updated
public with sharing class LC_Gross_Net_Helper {
    public static void calculateTotals(List<Event_s_Details__c> records) {
        Set<Id> oppIds = new Set<Id>();
        for(Event_s_Details__c e : records) {
            oppIds.add(e.Opportunity__c);
        }
        List<Opportunity> LC_Gross_Net_Opps = [SELECT Id, (SELECT Id, Gross_LC__c, Net_LC__c, Gross_USD_formula__c, Net_USD_formula__c, CreatedDate, Date__c, Currency__r.CurrencyRate__c FROM LC_Gross_and_Net_Details__r) FROM Opportunity WHERE Id IN :oppIds];
        
        for(Opportunity o : LC_Gross_Net_Opps) {
            List<Event_s_Details__c> edList = o.LC_Gross_and_Net_Details__r;
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
            for(Event_s_Details__c ED : edList) {
                if (ED.Gross_LC__c != null) {
                    TotalGrossUSD += ED.Gross_USD_formula__c;
                    if (Integer.valueOf(ED.Date__c.right(4)) == currentYear) {
                        CurrentYearGrossLC += ED.Gross_LC__c;
                        CurrentYearGrossUSD += ED.Gross_USD_formula__c;
                    }
                    else if (Integer.valueOf(ED.Date__c.right(4)) == currentYear + 1) {
                        NextYearGrossLC += ED.Gross_LC__c;
                        NextYearGrossUSD += ED.Gross_USD_formula__c;
                    }
                }
                if (ED.Net_LC__c != null) {
                    TotalNetUSD += ED.Net_USD_formula__c;
                    if (Integer.valueOf(ED.Date__c.right(4)) == currentYear) {                       
                        CurrentYearNetLC += ED.Net_LC__c;
                        CurrentYearNetUSD += ED.Net_USD_formula__c;
                    }
                    else if (Integer.valueOf(ED.Date__c.right(4)) == currentYear + 1) {
                        NextYearNetLC += ED.Net_LC__c;
                        NextYearNetUSD += ED.Net_USD_formula__c;
                    }
                }
            }
            o.Current_Year_USD_Gross__c = CurrentYearGrossUSD;
            o.Current_Year_USD_Net__c = CurrentYearNetUSD;
            o.Current_Year_LC_Gross__c = CurrentYearGrossLC;
            o.Current_Year_LC_Net__c = CurrentYearNetLC;
            o.Next_Year_USD_Gross__c = NextYearGrossUSD;
            o.Next_Year_USD_Net__c = NextYearNetUSD;
            o.Next_Year_LC_Gross__c = NextYearGrossLC;
            o.Next_Year_LC_Net__c = NextYearNetLC;
            o.Total_USD_Gross__c = TotalGrossUSD;
        	o.Total_USD_Net__c = TotalNetUSD;
        }
        update LC_Gross_Net_Opps;
    }
}