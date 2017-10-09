public with sharing class SMSOverviewControllerExtension {
    public SMSOverviewControllerExtension(){}
/*
    public List<Event_Costs__c> deals {get; set;}
    public List<Event_Costs__c> dealcompanies {get; set;}
    public List<AggregateResult> aggCompanies {get; set;}
    public List<ClientCompany__c> companies {get; set;}
    
    public Set<String> MarketSet {get; set;}
    public Set<String> IndustrySet {get; set;}
    public Set<String> SectorSet {get;set;}
    
    public List<SelectOption> MarketList {get;set;}
    public List<SelectOption> IndustryList {get;set;}
    public List<SelectOption> SectorList {get;set;}
    
    public Set<ID> companyset {get;set;}
        
    public ID companyID {get;set;}
    public Event_Costs__c deal {get;set;}
    public ClientCompany__c clientcompany {get; set;}
    public string industry {get;set;}
    
    public String dealsQuery {get;set;}
    public String companyQuery {get;set;}
    public String marketsQuery {get; set;}
    
    public string debug {get;set;}
    
    public String market {get; set;}
    public String sector {get; set;}
    
    public string baseURL { get; set;}
    
    public Integer dealcount;
    public Integer marketscount;

    public Double TotalUSDGross {get; set;}
    public Double TotalUSDNet {get; set;}
        
    public Boolean isDebug {get;set;}
     
    public String dealGraph
    {
        get { return getDealGraph(); }
        set;
    }
    
    public String mapGraph
    {
        get { return getMap(); }
        set;
    }
    
    public String CompetitorGraph
    {
        get { return getCompetitorGraph(); }
        set;
    }
    

    
    // Constructor
    public SMSOverviewControllerExtension()
    {
        // Initialise things
        isDebug = false;
        baseURL = URL.getSalesForceBaseURL().toExternalForm(); // So we can insert links to objects in Sandbox Or Production
        clientcompany = null;
        
        //Get dropdown options - manually because they're unbound controls
        populateMarketList();
        populateIndustryList();
        populateSectorList();
        
        //Pre-select search dropdowns 
        market='All';
        industry = 'All';
        sector = 'All';   
        
    }
    
 
    private void populateMarketList()
    {
        // Build a set to cover DISTINCT values
        MarketSet = new Set<String>();
        LN_Operation__c[] operations = [Select Name from LN_Operation__c order by Name];
        for (LN_Operation__c operation : operations)
        {
            MarketSet.add(operation.Name);
        }
        
        // then use it to populate a List so we can bind to it
        
        MarketList = new List<SelectOption>();      
        List<string> MarketNames = new List<string>();
        // Now traverse the set
        for (String marketname : MarketSet)
        {
            //First add to list of names so we can sort it
            MarketNames.add(marketname);
        }
        
        //now sort it
        MarketNames.Sort();
        
        //Now traverse the sorted list to build the options
        for (String sortedMarketName : MarketNames)
        {
            MarketList.add(new SelectOption(sortedMarketName,sortedMarketName));
        }

        
    }
    
    private void populateIndustryList()
    {
        Schema.Describefieldresult fieldresult = ClientCompany__c.Industry__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPickListValues();
        IndustryList = new List<SelectOption>();
        for(Schema.PicklistEntry entry : ple)
        {
            if (entry.getValue() != null)
            {
                IndustryList.add(new SelectOption(entry.getValue(),entry.getLabel()));
            }
        }
    }
    
    public PageReference populateSectorList()
    {
        // Horrible hard-coded nonsense due to SF limitations. Again.
        SectorList = new List<SelectOption>();
        
        if (industry == 'Automotive')
        {
            SectorList.add(new SelectOption('Accessories','Accessories'));
            SectorList.add(new SelectOption('Cars','Cars'));
            SectorList.add(new SelectOption('Fuel','Fuel'));
        }
    
        else if (industry == 'Beverage')
        {
            SectorList.add(new SelectOption('Beer','Beer'));
            SectorList.add(new SelectOption('Soft/Energy Drink','Soft/Energy Drink'));
            SectorList.add(new SelectOption('Spirits','Spirits'));
            SectorList.add(new SelectOption('Water','Water'));
            SectorList.add(new SelectOption('Wine','Wine'));
        }   

        else if (industry == 'Energy')
        {
            SectorList.add(new SelectOption('Oil & Gas','Oil & Gas'));
            SectorList.add(new SelectOption('Utility','Utility'));
        }        
        
        else if (industry == 'Entertainment & Leisure')
        {
            SectorList.add(new SelectOption('Entertainment & Leisure','Entertainment & Leisure'));
            SectorList.add(new SelectOption('Gaming','Gaming'));
            SectorList.add(new SelectOption('Hotel','Hotel'));
            SectorList.add(new SelectOption('Magazines & Periodicals','Magazines & Periodicals'));
            SectorList.add(new SelectOption('Music','Music'));
            SectorList.add(new SelectOption('Radio','Radio'));
            SectorList.add(new SelectOption('Restaurant','Restaurant'));
            SectorList.add(new SelectOption('Television','Television'));
            SectorList.add(new SelectOption('Travel','Travel'));
            SectorList.add(new SelectOption('Video Games','Video Games'));
        }
        
        else if (industry == 'Financial Services')
        {
            SectorList.add(new SelectOption('Banking','Banking'));
            SectorList.add(new SelectOption('Credit Card','Credit Card'));
            SectorList.add(new SelectOption('Financial Services','Financial Services'));
            SectorList.add(new SelectOption('Mortgage Lending','Mortgage Lending'));
        }
        
        else if (industry == 'FMCG')
        {
            SectorList.add(new SelectOption('Clothing','Clothing'));
            SectorList.add(new SelectOption('Consumer Products','Consumer Products'));
            SectorList.add(new SelectOption('Electronics','Electronics'));
            SectorList.add(new SelectOption('Food','Food'));
            SectorList.add(new SelectOption('Footwear','Footwear'));
            SectorList.add(new SelectOption('Retail','Retail'));
        }
        
        else if (industry == 'Health Care')
        {
            SectorList.add(new SelectOption('Health Care Manufacturer','Health Care Manufacturer'));
            SectorList.add(new SelectOption('Health Care Services','Health Care Services'));
        }
        
        else if (industry == 'Media/Telco')
        {
            SectorList.add(new SelectOption('Broadband','Broadband'));
            SectorList.add(new SelectOption('Telephone','Telephone'));
        }

        else if (industry == 'Public Sector')
        {
            SectorList.add(new SelectOption('Association','Association'));
            SectorList.add(new SelectOption('Charity','Charity'));
            SectorList.add(new SelectOption('Government','Government'));
            SectorList.add(new SelectOption('Transport','Transport'));
        }       
        
        else if (industry == 'Support Services')
        {
            SectorList.add(new SelectOption('Cleaning Services','Cleaning Services'));
            SectorList.add(new SelectOption('Food Services','Food Services'));
            SectorList.add(new SelectOption('IT Services','IT Services'));
            SectorList.add(new SelectOption('Legal','Legal'));
            SectorList.add(new SelectOption('Staffing','Staffing'));
            SectorList.add(new SelectOption('Support Services','Support Services'));
        }
        
        else if (industry == 'Telecommunications')
        {
            SectorList.add(new SelectOption('Telecommunications','Telecommunications'));
        }
        
        else if (industry == 'Ticketing')
        {
            SectorList.add(new SelectOption('Ticketing','Ticketing'));
        }
        
        else if (industry == 'Tobacco')
        {
            SectorList.add(new SelectOption('Tobacco','Tobacco'));  
        }       
        return null;
    }
    
    public void debugOn()
    {
        isDebug = !isDebug; 
    }
    
    public List<String> lstMarkets {get; set;}
    public Set<String> markets = new Set<String>();
         
    public void runQuery()
    {     
        try
        {
            // Reset companies
            aggCompanies = new List<AggregateResult>();
            companies = new List<ClientCompany__c>();
            
            //Reset totals
            TotalUSDGross = 0;
            TotalUSDNet=0;
            
            companyset = new Set<ID>();
            
            // Use SOQLBuilder's object to pre-build our where clause
            // dependent on picklist values
            NestableCondition whereClause = new AndCondition().add(new FieldCondition('Event_to_Deal__r.Status__c').equals('Current'));
                            
            if(market != 'All')
                whereClause.add(new FieldCondition('Event_to_Deal__r.LNOperation__c').equals(market));
            
            if(industry != 'All')
                whereClause.add(new FieldCondition('Event_to_Deal__r.Client_Company__r.Industry__c').equals(industry));

            if(sector != 'All')
                whereClause.add(new FieldCondition('Event_to_Deal__r.Client_Company__r.Sectors__c').equals(sector));

            // only closed deals - RC 30/7/2014
           whereclause.add(new FieldCondition('Business_Stage__c').equals('8 - Closed'));
            
            companyquery = new SoqlBuilder()
                .selectx('Event_to_Deal__r.Client_Company__r.ID')
                .selectx('Event_to_Deal__r.Client_Company__r.Name')
                .selectX('Total_USD_Net__c')
                .selectx('Total_USD_Gross__c')
                .fromx('Event_Costs__c')
                .wherex(whereClause)
                
                .toSoql();

            dealcompanies = Database.query(companyquery);
            
            // pull into a set for uniqueness (aka SELECT DISTINCT)
            if (dealcompanies.size() > 0)
            {
                for (Event_Costs__c c : dealcompanies)
                {
                    if (c.Event_to_Deal__r.Client_Company__r.ID != null)
                        companyset.add(c.Event_to_Deal__r.Client_Company__r.ID);
                }
            }   
            
            if (companySet.Size() > 0)
            {
                // Now we can re-query to get name and ID on the distinct ones
                // Build SOQL - gotta do it with strings again, cos SOQLbuilder has issues for now
                
                companyquery = 'SELECT Event_to_Deal__r.Client_Company__r.ID companyID, ';
                companyquery += 'Event_to_Deal__r.Client_Company__r.Name companyName,';
                companyquery += 'SUM(Total_USD_Gross__c) Gross, ';
                companyquery += 'SUM(Total_USD_Net__c) Net ';
                companyquery += 'from Event_Costs__c ';
                companyquery += 'where Event_to_Deal__r.Client_Company__r.ID in (';
                for (Id cID : companySet)
                {
                    companyquery += '\'' + cID + '\',';
                }
                companyquery = companyquery.substring(0,companyquery.length()-1);
                companyquery += ') ';
                companyquery += 'Group By Event_to_Deal__r.Client_Company__r.ID, Event_to_Deal__r.Client_Company__r.Name';
                
//            debug = companyQuery;   // here we set the string to display in the hidden debug panel - see top of VF Page markup
                
                //finally we can re-run it
                aggCompanies = Database.query(companyquery);
                    
                // now move it out of an aggregate result
                // and maintain the "total of totals"
                
                for(AggregateResult ar : aggCompanies)
                {
                    ID thisCompanyID = (ID)ar.get('companyID');
                    ClientCompany__c thisCompany = new ClientCompany__c(Id = thisCompanyID);
                    thisCompany.Name = string.valueof(ar.get('companyName'));
                    thisCompany.Total_USD_Net__c = double.valueof(ar.get('Net'));
                    TotalUSDNet += double.valueof(ar.get('Net'));
                    thisCompany.Total_USD_Gross__c = double.valueof(ar.get('Gross'));
                    TotalUSDGross += double.valueof(ar.get('Gross'));
                    companies.add(thisCompany);
                }
                update companies;
                                
            }               
            
            deals = Database.query(dealsQuery);
            if (deals.size() > 0)
            {
                deal = deals[0];
                            
                // ...and markets
                markets.clear();
                lstMarkets = new List<String>();
        
                for(Integer i = 0; i < deals.size();i++)
                {
                    lstMarkets.add(deals[i].Event_to_Deal__r.LNOperation__c);
                }
                        
                // repopulate
                for(Integer j = 0; j < lstMarkets.size();j++)
                {
                    markets.add(lstMarkets[j]);
                }
            }
        }
        catch (Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'RunQuery error - ' + e.getMessage() + ' in line ' + e.getLineNumber()));
        }
    }

    // runs the search with parameters passed via Javascript
        public PageReference runSearch()
        {
            try {
        
                //Clear out clientcompany to force refreshed view
                clientcompany = null;
                
                market = Apexpages.currentPage().getParameters().get('market');
                industry = Apexpages.currentPage().getParameters().get('industry');
                sector = Apexpages.currentPage().getParameters().get('sector');
            
                // Log the search, cos we're evil (and cos customer asked for it)
                SMS_Overview_Log__c logentry = new SMS_Overview_Log__c();
                logentry.Username__c = UserInfo.getName();
                logentry.Datestamp__c = System.now();
                logentry.Market__c = market;
                logentry.Industry__c = industry;
                logentry.Sector__c = sector;
                insert logentry;
                
                dealsQuery = new SoqlBuilder()
                .selectx('Event_to_Deal__r.Name')
                .selectx('Event_to_Deal__r.LNOperation__c')
                .selectx('Event_to_Deal__r.ClientBrand__c')
                .selectx('Event_to_Deal__r.Client_Company__c')
                .selectx('Event_to_Deal__r.Total_USD_Gross__c')
                .selectx('Event_to_Deal__r.Deal_Duration__c')
                .selectx('Event_to_Deal__r.Year__c')
                .selectx('Event_to_Deal__r.Client_Contact__c')
                .selectx('Event_to_Deal__r.LN_Executive__c')
                .selectx('Event_to_Deal__r.Deal_Activation__c')
                .selectx('Event_to_Deal__r.Client_Company__r.Name')
                .selectx('Event__r.Name')
                .selectx('Event__r.Event_Type__c')
                .fromx('Event_Costs__c')
                .wherex(
                    new AndCondition()
                    .add(new FieldCondition('Event_to_Deal__r.Client_Company__c').equals(companyID))
                    .add(new FieldCondition('Event_to_Deal__r.Status__c').equals('Current'))
                    .add(new FieldCondition('Business_Stage__c').equals('8 - Closed'))
                )
                .toSoql();

                 // run the query again
                runQuery();
            }
            catch (Exception e)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'ClientSearch error - ' + e.getMessage() + ' in line ' + e.getLineNumber()));
            }
            
            return null;
            
        }
    
    public string getDealGraph()
    {
        // This method gathers the data to pass to the Google Graphs API for rendering
        string retval = '';
        string chd = '';
        string chd1='';
        
        List<AggregateResult> events = new List<AggregateResult>();        
        String eventquery = 'SELECT Event__r.Name EventName, ';
        eventquery += 'SUM(Total_USD_Gross__c) Gross ';
        eventquery += 'FROM Event_Costs__c ';
        eventquery += ' WHERE (Event_to_Deal__r.Status__c = \'Current\' ';
        if (market != 'All')
        {
            eventquery += 'AND Event_to_Deal__r.LNOperation__c = \'' + market + '\' ';
        }
        eventquery += 'AND Event_to_Deal__r.Client_Company__r.ID = \'' + clientcompany.ID + '\') ';
//add(new FieldCondition('Business_Stage__c').equals('8 - Closed'));
        eventquery += 'AND Event_Costs__c.Business_Stage__c = \'8 - Closed\' ';
        eventquery += 'GROUP BY Event__r.Name';
        
        events = database.query(eventquery);
                
        if (events != null)
        {
            Integer eventcount = events.size();
            if (eventcount > 0)
            {
                for (AggregateResult ar : events)
                {
                    chd += double.valueof(ar.get('Gross')) + ',';
                    //chd1 += ar.get('EventName')+ ' ($' + events[i].Total_USD_Gross__c.setscale(2).Format() + ')|';
                    Decimal gross = (Decimal)double.valueof(ar.get('Gross'));
                    chd1 += ar.get('EventName')+ ' ($' + gross.setscale(2).toplainstring() + ')|';
                }
                chd = chd.substring(0,chd.length()-1);
                chd1 = chd1.substring(0,chd1.length()-1);
            
                // cht=p3 = Chart type parameter, 3D Pie
                // For other parameters, see docs at http://code.google.com/apis/chart/image/docs/gallery/pie_charts.html
                
                retval = 'https://chart.googleapis.com/chart?chs=900x200&chdlp=b&cht=p3&chf=bg,s,F8F8F8&chco=FFFF10,FF0000&chd=t:' + chd + '&chds=0,9999999&chl=' + chd1 + '&chtt=Event+breakdown' + '&output=embed';
            }
        }
        
        return retval;
    }
    
public string getMap()
{
    // This method gathers the data to pass to the Google Graphs API for rendering
        Double totalDealValue = 0;
        Double marketvalue = 0;
        string marketName;
        string marketcodes='';
        string marketpercentages='';
        string flags='';
        Integer flagcounter=0;

        for (Event_Costs__c d : deals)
        {
            totalDealValue += Double.valueOf(d.total_usd_gross__c);
        }

        
        Map<String,Double> markettotals = new Map<String,Double>();
        for (Event_Costs__c dl : deals)
        {
            if(markettotals.containsKey(dl.Event_to_Deal__r.LNOperation__c) == false)
            {
                markettotals.put(dl.Event_to_Deal__r.LNOperation__c,Double.valueOf(dl.total_usd_gross__c));
            }
            else
            {
                markettotals.put(dl.Event_to_Deal__r.LNOperation__c,(markettotals.get(dl.Event_to_Deal__r.LNOperation__c) + Double.valueOf(dl.total_usd_gross__c)));
            }           
        }
        
        for(String country : markettotals.keySet())
        {    
            if (totalDealValue > 0)
                    marketvalue = (Double.valueOf(markettotals.get(country))/totalDealValue)*100.00;
            else
                   marketvalue = 0;
            
            marketpercentages += string.valueOf(marketvalue) + ',';
                   
            flags += country + '+-+' + string.valueOf(Decimal.valueOf(marketValue).SetScale(1)) + '%|';
            
            LN_Operation__c[] countrylookup = [Select Country_Code__c from LN_Operation__c where Name = :country];
            if (countrylookup.size() > 0)
            {
                marketcodes += string.valueOf(countrylookup[0].get('Country_Code__c')) + '|';    
            }
            else
                marketcodes += 'Country lookup error';
            
            flagcounter++;
            
        }
        
        if (marketpercentages.length() > 0)
                marketpercentages = marketpercentages.substring(0,marketpercentages.length()-1);
                
        if (marketcodes.length() > 0)
            marketcodes = marketcodes.substring(0,marketcodes.length()-1);
            
        if (flags.length() > 0)
            flags = flags.substring(0,flags.length()-1);

        // For other parameters, see docs http://code.google.com/apis/chart/image/docs/gallery/new_map_charts.html
        string retval = 'https://chart.googleapis.com/chart?chf=bg,s,F8F8F8&chs=450x450&cht=map&chco=CCCCCC,FF0000,00FF00&chld=' + marketcodes + '&chd=t:' + marketpercentages + '&chtt=Deals+by+market|Excludes+multi-territory+deals|where+territories+are+not+specified&chdl=' + flags + '&output=embed';

    return retval;
}

public string getCompetitorGraph()
{
        string retval='';
        string chd='t:';
        string chxl='1:|';
        string chco = '';
        
        if (companies != null)
        {
            Integer companycount = companies.size();
            if(companycount > 0)
            {
                for (Integer x=0; x < companycount; x++)
                {
                    
                    chd += companies[x].Total_USD_Gross__c.intvalue() + ',';
                    if (companies[x].Name == clientcompany.Name)
                    {
                        chco += 'FF0000|';
                    }
                    else
                    {
                        chco += '0000FF|';
                    }
                }
                
                for (Integer y = companycount-1; y >= 0; y--)
                {
                    chxl += EncodingUtil.urlEncode(companies[y].Name,'UTF=8') + '|';
                }
                
                chd = chd.substring(0,chd.length()-1);
                chco = chco.substring(0,chco.length()-1);
            
            retval = 'https://chart.googleapis.com/chart?chf=bg,s,F8F8F8&chxt=x,y&chxl=' + chxl + '&chbh=a&chs=450x450&cht=bhg&chco=' + chco + '&chds=a&chd=' + chd + '&chdlp=b&chg=-1,0,0,4&chma=10&chtt=Competitor+Comparison|(USD+Gross+Value)' + '&output=embed';  
            
            }
        }
        //debug=retval;
        return retval;
}

public void ShowDeals()
{
    List<ClientCompany__c> clientcompanies = new List<ClientCompany__c>([SELECT id,name from ClientCompany__c where ID = :companyID]);
    clientcompany = clientcompanies[0];
    
    // Use SOQLBuilder to query all current deals for the selected company
    
    // first do the where clause to handle optional market field
    NestableCondition whereClause = new AndCondition().add(new FieldCondition('Event_to_Deal__r.Status__c').equals('Current'));
            
    if(market != 'All')
        whereClause.add(new FieldCondition('Event_to_Deal__r.LNOperation__c').equals(market));
        
    // now the rest of the where clause that we always want
   whereclause.add(new FieldCondition('Event_to_Deal__r.Client_Company__c').equals(companyID));
   whereclause.add(new FieldCondition('Event_to_Deal__r.Status__c').equals('Current'));
   whereclause.add(new FieldCondition('Business_Stage__c').equals('8 - Closed'));
                
    dealsQuery = new SoqlBuilder()
        .selectx('Name')
        .selectx('Event_to_Deal__r.Name')
        .selectx('Event_to_Deal__r.LNOperation__c')
        .selectx('Event_to_Deal__r.ClientBrand__c')
        .selectx('Event_to_Deal__r.Client_Company__c')
        .selectx('Total_USD_Gross__c')
        .selectx('Event_to_Deal__r.Deal_Duration__c')
        .selectx('Event_to_Deal__r.Year__c')
        .selectx('Event_to_Deal__r.Client_Contact__c')
        .selectx('Event_to_Deal__r.LN_Executive__c')
        .selectx('Event_to_Deal__r.Deal_Activation__c')
        .selectx('Event_to_Deal__r.Client_Company__r.Name')
        .selectx('Event__r.Name')
        .selectx('Event__r.Event_Type__c')
        .fromx('Event_Costs__c')
        .wherex(whereclause)
        .toSoql();

    debug = dealsQuery;
    
    runQuery(); 
}
*/
}