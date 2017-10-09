public class FRSupplierUpdater {

    @Future(callout=true)
    public static void updateFRSupplier(Id id, String name, String password)
    {
        // non-blank plaintext password must be supplied
        if (String.isBlank(password)) {
            System.debug('Plaintext password is empty, white-space only or is null ' + name + '(' +id +')'); 
            return;
        }
        Supplier_Festival_Republic__c supplier = new Supplier_Festival_Republic__c(Id=id);        
        HttpResponse res;
        
        try {
        	res = getHashPasswordFromContractorDocs(password);
        } catch (CalloutException ex) {
            // CalloutException - likely a 'Read timed out' encountered while ContractorDocs spins-up
            System.debug('Callout Exception  ' + name + '(' +id +') - ' + ex);
            EmailSupport(id, name, 'Callout Exception - ' + ex);
        }
        
        if (res.getStatusCode() == 200 || !String.isBlank(res.getBody()))
        {
            if (!(Test.isRunningTest()))
        	{
            	supplier.Health_And_Safety_Password__c = res.getBody();
            	update supplier;
            }
        }
        else
        {
            String msg = 'Callout for password hashing failed for ' +id + '('+name+')'+': ' + res.getStatusCode() + res.getBody();
            System.debug(msg);
            EmailSupport(id, name, msg);
        }
   }
        
    
    
    // Separate method for HttpRequest makes it easier to test      
    public static HttpResponse getHashPasswordFromContractorDocs(String password) {
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');        
        req.setEndpoint('http://contractordocs.herokuapp.com/Services/HashPassword?plaintext=' + password);
        req.setTimeout(60000);
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        return res;
    }
    
	public static Boolean EmailSupport(String myid, String name, String msg) {
        
        Datetime dateOfMsg = datetime.now();
        
        // Setup email
        Messaging.reserveSingleEmailCapacity(1);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'business.systems@livenation.co.uk'}; 
        mail.setToAddresses(toAddresses);        
        mail.setReplyTo('business.systems@livenation.co.uk');
        mail.setSenderDisplayName('International Business Systems');
        mail.setSubject('Salesforce - FRSupplierUpdater: ' + name + '(' + myid + ')' );
        mail.setUseSignature(false);
        
        // Content 
        String contentPlainText = 'Function: FRSupplierUpdater\n' +
                              'Record: ' + name + '(' + myid + ')\n' + 
                              'User: ' + UserInfo.getName() + '(' + UserInfo.getUserId() +')\n' +
                              'Date: ' + dateOfMsg.format('yyyy-mm-dd HH:mm:ss') + '\n' +
                              'Message: ' + msg + '\n\n\n';        
        mail.setPlainTextBody(contentPlainText);
        String contentHTML = '<p>Function: FRSupplierUpdater</p>' +
                              '<p>Record: ' + name + '(' + myid + ')</p>' + 
                              '<p>User: ' + UserInfo.getName() + '(' + UserInfo.getUserId() +')</p>' +
                              '<p>Date: ' + dateOfMsg.format('yyyy-mm-dd HH:mm:ss') + '</p>' +
                              '<p>Message: ' + msg + '</p>';        
        mail.setHtmlBody(contentHTML);        
        // Send        
        List<Messaging.SendEmailResult> notifyResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }, false);
        
        // Debug
        for (Messaging.SendEmailResult result : notifyResults) {
            System.debug(result.isSuccess() + ': ' + result.getErrors().size());
        }
        
        // Return
        return notifyResults.get(0).success;
    }
}