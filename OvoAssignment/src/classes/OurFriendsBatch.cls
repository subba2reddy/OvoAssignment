public class OurFriendsBatch implements Database.Batchable<customers>, Database.AllowsCallouts  {
    
    public class Customers {
        public String id;
        public String firstName;
        public String lastName;
        public String gender;
        public String title;
    }
    
    public class OurCustomers {
        public List<Customers> customers;
    }
    
    public customers[] start(Database.BatchableContext bc) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://sheltered-depths-66346.herokuapp.com/customers');
        request.setMethod('GET');
        Http http = new Http();
        HttpResponse response = http.send(request);
        String dateValue = response.getBody();
        system.debug('dateValue'+dateValue);
        
        OurCustomers customersObjectsList =(OurCustomers)JSON.deserialize(dateValue, OurCustomers.class);
        system.debug('customersObjectsList'+customersObjectsList);
        return customersObjectsList.customers;
    }
    
    public void execute(Database.BatchableContext bc, customers[] execs) {
        Schema.SObjectField f = Contact.Fields.OurFriends_extId__c;
        Contact con;
        List<Contact> contactList=new  List<Contact>();
        for (customers customer : execs) {
            con=new Contact();
            con.OurFriends_extId__c=customer.id;
            con.firstName=customer.FirstName;
            con.lastName=customer.LastName;
            con.gender__c=customer.gender;
            con.Title=customer.Title;
            con.Creation_Batch_ID__c = bc.getJobId();
            con.loyalty_status__c='Friendly';
            contactList.add(con);
        }
        
        Database.UpsertResult [] cr = Database.upsert(contactList, f, false);
        
    }
    
    public void finish(Database.BatchableContext bc) {
		Id jobid = bc.getJobId();
        Contact_Batch_ID__c newBatchId = new Contact_Batch_ID__c();
        newBatchId.Contact_Batch_ID__c = (String)jobid;
        newBatchId.Name = 'ContactBatch';
        Insert newBatchId;
        database.executeBatch(new ourFriendsExistingContactUpdateBatch());
    }
}