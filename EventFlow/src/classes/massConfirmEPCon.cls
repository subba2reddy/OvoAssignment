public with sharing class massConfirmEPCon {

private String query {get;set;}

public List<Purchase_Order_Festival_Republic__c> pos {get;set;}

public String sortDir {
    get { if (sortDir == null) { sortDir = 'asc'; } return sortDir; }
    set;
}

public String sortField {
    get { if (sortField == null) { sortField = 'Name'; } return sortField; }
    set;
}

public ID PurchaseOrderID {
    get;
    set;
}

public String serverURL { get; set; }
public String sessionID { get; set; }

public String emailAddress = UserInfo.getUserEmail();

public massConfirmEPCon()
{
    query = 'Select id, name, PO_Description__c, PO_Number__c, Festival__c, Gross_Total__c, Supplier__c, VAT_Total__c FROM Purchase_Order_Festival_Republic__c WHERE recordtypeid=\'01220000000AJQJ\' OR recordtypeid = \'01220000000AJQO\'';
    runQuery();
}

public void runQuery()
{
    try
    {
        pos = Database.query( query + ' order by ' + sortField + ' ' + sortDir);
    }
    catch (Exception e)
    {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
    }
}

// toggles the sorting of query from asc<-->desc
  public void toggleSort() {
    // simply toggle the direction
    sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
    // run the query again
    runQuery();
  }

  // format the soql for display on the visualforce page
  public String debugSoql {
    get { return query + ' order by ' + sortField + ' ' + sortDir; }
    set;
  }

public PageReference runSearch()
{
    query = 'Select id, name, PO_Description__c, PO_Number__c, Festival__c, Gross_Total__c FROM Purchase_Order_Festival_Republic__c WHERE recordtypeid=\'01220000000AJQJ\' OR recordtypeid = \'01220000000AJQO\'';
    runQuery();
    return null;
}

public void CongaMerge()
{
    // Conga merge and email
    
    List<Purchase_Order_Festival_Republic__c> purchaseOrders = Database.query('select ID, RecordTypeID, Status__c, PO_Number__c, Supplier__c, Previous_Status__c, Partner_URL__c from Purchase_Order_Festival_Republic__c where ID = \'' + PurchaseOrderID + '\'');
    Purchase_Order_Festival_Republic__c thePO = purchaseOrders[0];
    
    // First,build the URL with querystring 
    string baseURL = 'https://www.appextremes.com/apps/Conga/PM.aspx';
    String url = baseURL + '?SessionID=' + sessionID;
    url += '&ServerUrl=' + serverURL;
    url += '&Id=' + thePO.Id;
    url += '&QueryId=[Suppliers]a0I20000008WKb7,[POItems]a0I20000008WKbM';
    url += '&DefaultPDF=1';
    url += '&EmailAdditionalTo=' + emailAddress;
    //url += '&EmailToId=0032000000fMVnS';  //PO Approvals
    //url += '&EmailCC=jvenus@festivalrepublic.com';
    //url += '&EmailBCC=business.systems@livenation.co.uk';
    //url += '&EmailToID=003W000000JDu4V';    // Rob C test
    url += '&EmailReplyToId=003W000000JDu4V';
    url += '&EmailTemplateID=00X200000014Ph1';
    url += '&EmailTemplateAttachments=1';
    url += '&EmailRelatedToId=' + thePO.Id;
    url += '&fp0=1';        // Force PDF format
    url += '&ps1=1';        // Enable PDF printing
    url += '&ds1=0';        // Disable Merge button
    url += '&ds3=1';        // Disable log activity button
    url += '&ds4=1';        // Lock template choice
    url += '&ds5=0';        // Disable View Data link
    url += '&ds6=1';        // Disable View Template link
    url += '&APIMode=12';   // API mode - email
    url += '&OFN=' + EncodingUtil.URLEncode(thePO.PO_Number__c,'UTF-8');
    url += '&CurrencyCulture=en-GB';
//    url += '&Inline=1';
    url += '&TemplateId=a0vw000000CNASp';
    
    System.Debug('URL = ' + url);
    
    // then, send it over HTTP
    HttpRequest req = new HttpRequest();
    req.setTimeout(60000);
    req.setEndpoint(url);
    req.setMethod('GET');
    Http h = new Http();
    Httpresponse res = h.send(req); 
    System.debug(res.getBody());
    
}

public void ConfirmPO()
{ 
    CongaMerge();
    List<Purchase_Order_Festival_Republic__c> purchaseOrders = Database.query('select ID, RecordTypeID, Status__c, Previous_Status__c from Purchase_Order_Festival_Republic__c where ID = \'' + PurchaseOrderID + '\'');

    Purchase_Order_Festival_Republic__c thePO = purchaseOrders[0];   
    ID approvedRecordTypeID = thePO .RecordTypeID;
    
    if (thePO.RecordTypeID == '01220000000AJQJ')    // EP Confirmation
        approvedRecordTypeID = '01220000000AJQx';        // EP Submitted
    else if (thePO.RecordTypeID == '01220000000AJQO')    // EP Confirmation Staff
        approvedRecordTypeID = '01220000000AJR2';        // EP Submitted Staff
        
    thePO.RecordTypeID = approvedRecordTypeID;
    thePO.Status__c = 'Submitted for Approval';

    // Duplicate status in other field for when we cancel (void) a Committed PO
    thePO.Previous_Status__c='Submitted for Approval';

    //Timestamp it
    thePO.Date_Committed__c = Date.Today().Format(); 
    
    update thePO;
    
    
    
    // then refresh
    runQuery();    
}

public void RejectPO()
{ 
    List<Purchase_Order_Festival_Republic__c> purchaseOrders = Database.query('select ID, RecordTypeID, Status__c, Previous_Status__c from Purchase_Order_Festival_Republic__c where ID = \'' + PurchaseOrderID + '\'');

    Purchase_Order_Festival_Republic__c thePO = purchaseOrders[0];
    
    ID rejectedRecordTypeID = thePO .RecordTypeID;
    
    if (thePO.RecordTypeID == '01220000000AJQJ')    // EP Confirmation
        rejectedRecordTypeID = '01220000000AJQn';        // EP Rejected
    else if (thePO.RecordTypeID == '01220000000AJQO')    // EP Confirmation Staff
        rejectedRecordTypeID = '01220000000AJQs';        // EP Rejected Staff
            
    thePO.RecordTypeID = rejectedRecordTypeID ;
    thePO.Status__c = 'Rejected';
    
    // Duplicate status in other field for when we cancel (void) a Committed PO
    thePO.Previous_Status__c='Rejected';

    update thePO; 
    runQuery();    
}
            
}