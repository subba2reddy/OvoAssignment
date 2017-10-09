/*
	Name: FRSupplierUpdaterHttpCallOutMock
	
	Description:
	An implementation of the HttpCalloutMock interface
	for testing the webservice associated with FRSupplierUpdater
	Based on http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_classes_restful_http_testing_httpcalloutmock.htm

	Author: Phil Quinn
	Created: 2013-07-15
*/


@isTest
global class FRSupplierUpdaterHttpCalloutMock implements HttpCalloutMock {
    
    // Implement interface method
    global HTTPResponse respond(HTTPRequest req) {
        
		// Only GET requests allowed
        System.assertEquals('GET', req.getMethod());
        
        // Create fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'text/plain');        
        res.setBody('$2a$10$ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZA');        
        res.setStatusCode(200);
        
        return res;
        
    }

}