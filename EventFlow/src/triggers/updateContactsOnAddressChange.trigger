trigger updateContactsOnAddressChange on Account
                                         (before update){
                                             
	// Trigger to update Contact mailing address whenever Account billing address changes

    // The map allows us to keep track of the accounts that have new addresses 
    
    Map<Id, Account> acctsWithNewAddresses =new Map<Id, Account>();

    // Trigger.new is a list of the Accounts that will be updated 

	// This loop iterates over the list, and adds any that have new 
    // addresses to the acctsWithNewAddresses map. 
    
    for (Integer i = 0; i < Trigger.new.size(); i++){
        // only for Dublin (BGET) Accounts and excludes the group Account 'Personal'
        if(	Trigger.old[i].RecordTypeId == '01220000000AFqo' && Trigger.old[i].Id != '0012000000kMgqa' )
           {
            if(   (Trigger.old[i].BillingCity != Trigger.new[i].
                                                     BillingCity)
                || (Trigger.old[i].BillingCountry != Trigger.new[i].
                                                     BillingCountry)
                || (Trigger.old[i].BillingPostalCode != Trigger.new[i].
                                                     BillingPostalCode)
                || (Trigger.old[i].BillingState != Trigger.new[i].
                                                     BillingState)
                || (Trigger.old[i].BillingStreet != Trigger.new[i].
                                                    BillingStreet))  {
                acctsWithNewAddresses.put(Trigger.old[i].id,
                                          Trigger.new[i]);
                }
            }
        }

    List<Contact> updatedContacts =new List<Contact>();

    //Here we can see two syntatic features of Apex: 
    
    //  1) iterating over an embedded SOQL query 
    //  2) binding an array directly to a SOQL query with 'in' 
    

    for (Contact c : [SELECT id, accountId, MailingCity,
                             MailingCountry, MailingPostalCode,
                             MailingState, MailingStreet
                      FROM contact
                      WHERE accountId 
                            in :acctsWithNewAddresses.keySet()]){
        Account parentAccount = acctsWithNewAddresses.get(c.accountId);
        c.MailingCity = parentAccount.BillingCity;
        c.MailingCountry = parentAccount.BillingCountry;
        c.MailingPostalCode = parentAccount.BillingPostalCode;
        c.MailingState = parentAccount.BillingState;
        c.MailingStreet = parentAccount.BillingStreet;

        // Rather than insert the contacts individually, add the 
        // contacts to a list and bulk insert it. This makes the 
        // trigger run faster and allows us to avoid hitting the 
        // governor limit on DML statements 
    
        updatedContacts.add(c);
    }
    update updatedContacts;
}