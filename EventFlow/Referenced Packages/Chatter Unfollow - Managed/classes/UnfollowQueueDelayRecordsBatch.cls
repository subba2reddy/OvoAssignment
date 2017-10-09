/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class UnfollowQueueDelayRecordsBatch implements Database.Batchable<SObject> {
    global List<chttrunfollow__UnfollowRule__c> delayRules;
    global Boolean evalateEachRecordForDaysDelay;
    global String objectName;
    global String sObjectQuery;
    global UnfollowQueueDelayRecordsBatch() {

    }
    global void execute(Database.BatchableContext BC, List<SObject> scope) {

    }
    global void finish(Database.BatchableContext BC) {

    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return null;
    }
}
