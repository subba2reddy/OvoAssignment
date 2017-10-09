@isTest(SeeAllData=true)
public class DefaultEntitlementTest {

    @isTest static void UpdateSubject() {
        
        Account a = new Account(Name='TestAccount');
        insert a;
        
        Entitlement e = new Entitlement(Name='Standard',AccountId=a.Id,StartDate=system.today());
        insert e;
        
        Contact co = new Contact(LastName='TestContact',AccountId=a.id);
        insert co;
        
        Case c = new Case(AccountId=a.Id,ContactId=co.id);
        insert c;
       
    }
}