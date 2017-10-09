public class AccountController {
    @AuraEnabled
    public static Account saveAccount(Account accountObj) {
        insert accountObj;
        system.debug('AccountAccount'+accountObj);
        return accountObj;
    }
}