public with sharing class massAccountUpdateCon {
private List<Account> accounts;

  public List<Account> getAccounts() {
      return accounts;
  }

  public string keywords {
    get;
    set;
  }

  public PageReference ViewData() {
     //dynamically build the query to insert the filter values
     String query = 'Select id, name, type, OwnerId, Account_Type__c, Genre__c, Ticketing__c, Additional_Systems__c, Exclusive__c FROM account WHERE name LIKE \'' + keywords + '%\'';
   
     accounts = Database.query(query);
                   
     return null;
  }

  public PageReference UpdateRecords() {
    // this simple line of code finds out which column was changed and update the 
    // relevant account record accordingly!
    update accounts;
    return null;
  }
}