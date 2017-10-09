@isTest(SeeAllData=true)
public class UpdateCaseTriggerTest {

    @isTest static void UpdateSubject() {
        
        Account a = new Account(Name='TestAccount');
        insert a;
        
        Contact co = new Contact(LastName='TestContact',AccountId=a.id);
        insert co;
        
        Case c = new Case(AccountId=a.Id,ContactId=co.id);
        insert c;
        
        c.Subject='Test';
        update c;
    }
}