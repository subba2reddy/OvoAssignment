public with sharing class massApprovePOCon {

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

public massApprovePOCon()
{
    query = 'Select id, name, PO_Description__c, PO_Number__c, Festival__c, Gross_Total__c FROM Purchase_Order_Festival_Republic__c WHERE recordtypeid=\'01220000000PgsL\' OR recordtypeid = \'01220000000A7yg\' OR recordtypeid=\'01220000000AFUN\' OR recordtypeid=\'01220000000AFVk\' or recordtypeid=\'01220000000AIm9\' or recordtypeid = \'01220000000AImE\' or recordtypeid = \'01220000000AJQx\' or recordtypeid = \'01220000000AJR2\'';
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
    query = 'Select id, name, PO_Description__c, PO_Number__c, Festival__c, Gross_Total__c FROM Purchase_Order_Festival_Republic__c WHERE recordtypeid=\'01220000000PgsL\' OR recordtypeid = \'01220000000A7yg\' OR recordtypeid=\'01220000000AFUN\' OR recordtypeid=\'01220000000AFVk\' or recordtypeid=\'01220000000AIm9\' or recordtypeid = \'01220000000AImE\' or recordtypeid = \'01220000000AJQx\' or recordtypeid = \'01220000000AJR2\'';
    runQuery();
    return null;
}

public void ApprovePO()
{ 
    List<Purchase_Order_Festival_Republic__c> purchaseOrders = Database.query('select ID, RecordTypeID, Status__c, Previous_Status__c from Purchase_Order_Festival_Republic__c where ID = \'' + PurchaseOrderID + '\'');

    Purchase_Order_Festival_Republic__c thePO = purchaseOrders[0];
    
    ID approvedRecordTypeID = thePO .RecordTypeID;
    

    if (thePO .RecordTypeID == '01220000000PgsL')         //Submitted
        approvedRecordTypeID = '01220000000DZJJ';     //Committed
    else if (thePO .RecordTypeID == '01220000000A7yg')    //Submitted (staff)
        approvedRecordTypeID = '01220000000A7yW';     //Committed (staff)
    else if (thePO .RecordTypeID == '01220000000AFUN')    //Orlando submitted
        approvedRecordTypeID = '01220000000AFUX';     //Orlando committed
    else if (thePO.RecordTypeID == '01220000000AFVk')    //Orlando submitted (staff)
        approvedRecordTypeID = '01220000000AFVp';     //Orland committed (staff)
    else if (thePO.RecordTypeID == '01220000000AIm9')    //Berlin submitted
        approvedRecordTypeID = '01220000000AIlB';        //Berlin committed
    else if (thePO.RecordTypeID == '01220000000AImE')    //Berlin submitted (staff)
        approvedRecordTypeID = '01220000000AIlL';        //Berlin committed (staff)
    else if (thePO.RecordTypeID == '01220000000AJQx')    // EP Submitted
        approvedRecordTypeID = '01220000000AJQ9';        // EP Committed
    else if (thePO.RecordTypeID == '01220000000AJR2')    // EP Submitted Staff
        approvedRecordTypeID = '01220000000AJQE';        // EP Committed Staff
        
    thePO.RecordTypeID = approvedRecordTypeID;
    thePO.Status__c = 'Committed';

    // Duplicate status in other field for when we cancel (void) a Committed PO
    thePO.Previous_Status__c='Committed';

    //Timestamp it
    thePO.Date_Committed__c = Date.Today().Format(); 
    
    update thePO; 
    runQuery();    
}

public void RejectPO()
{ 
    List<Purchase_Order_Festival_Republic__c> purchaseOrders = Database.query('select ID, RecordTypeID, Status__c, Previous_Status__c from Purchase_Order_Festival_Republic__c where ID = \'' + PurchaseOrderID + '\'');

    Purchase_Order_Festival_Republic__c thePO = purchaseOrders[0];
    
    ID rejectedRecordTypeID = thePO .RecordTypeID;
    

    if (thePO .RecordTypeID == '01220000000PgsL')         //Submitted
        rejectedRecordTypeID = '01220000000A8eV';     //Rejected
    else if (thePO .RecordTypeID == '01220000000A7yg')    //Submitted (staff)
        rejectedRecordTypeID = '01220000000A8ea';     //Rejected (staff)
    else if (thePO .RecordTypeID == '01220000000AFUN')    //Orlando submitted
        rejectedRecordTypeID = '01220000000AFUc';     //Orlando rejected
    else if (thePO.RecordTypeID == '01220000000AFVk')    //Orlando submitted (staff)
        rejectedRecordTypeID = '01220000000AFVf';     //Orland rejected (staff)
    else if (thePO.RecordTypeID == '01220000000AIm9')    //Berlin submitted
        rejectedRecordTypeID = '01220000000AIlz';        //Berlin rejected
    else if (thePO.RecordTypeID == '01220000000AImE')    //Berlin submitted (staff)
        rejectedRecordTypeID = '01220000000AIm4';        //Berlin rejected(staff)
    else if (thePO.RecordTypeID == '01220000000AJQx')    // EP Submitted
        rejectedRecordTypeID = '01220000000AJQn';        // EP Rejected
    else if (thePO.RecordTypeID == '01220000000AJR2')    // EP Submitted Staff
        rejectedRecordTypeID = '01220000000AJQs';        // EP Rejected Staff
            
    thePO.RecordTypeID = rejectedRecordTypeID ;
    thePO.Status__c = 'Rejected';
    
    // Duplicate status in other field for when we cancel (void) a Committed PO
    thePO.Previous_Status__c='Rejected';

    update thePO; 
    runQuery();    
}
            
}