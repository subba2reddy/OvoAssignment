/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class ZendeskSyncOrgs implements Database.AllowsCallouts, Database.Batchable<Integer>, Database.Stateful {
    global ZendeskSyncOrgs() {

    }
    global void execute(Database.BatchableContext info, List<Integer> scope) {

    }
    global void finish(Database.BatchableContext info) {

    }
    global void getAllZendeskOrgs(List<Zendesk.ZendeskSyncOrgs.listofOrganizationClass> listofOrgs) {

    }
    global static Integer getExecutesNeeded(Boolean updateSetting) {
        return null;
    }
    global static Integer getOrgsFromZDCount() {
        return null;
    }
    global Account populateAccountDetails(Account acc, Zendesk.ZendeskSyncOrgs.organizationClass org) {
        return null;
    }
    global static String remoteRequest(String method, String resource, String body) {
        return null;
    }
    global System.Iterable start(Database.BatchableContext info) {
        return null;
    }
    global static Id startBatch() {
        return null;
    }
    global static Boolean tooManyZDOrgs() {
        return null;
    }
global class listofOrganizationClass {
}
global class organizationClass {
}
}
