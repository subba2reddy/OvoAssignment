public class ContactListController {

    @AuraEnabled
    public static List<Contact> getContacts() {
        List<Contact> contacts = 
                [SELECT Name, Phone, Email, loyalty_status__c, Account.Name  FROM Contact];
        return contacts;
    }

    @AuraEnabled
    public static void updateLoyalty(String contactList){
        List<Contact> contacts = (List<Contact>)System.JSON.deserialize(contactList, List<Contact>.class);
        List<Contact> ContactsToUpdate = new List<Contact>(); 
        for(Contact c: contacts){
            String email = c.Email;
            if(email != null){
                c.Email = email.remove('&');
            }
            ContactsToUpdate.add(c);
        }
        upsert ContactsToUpdate;    
    }
}