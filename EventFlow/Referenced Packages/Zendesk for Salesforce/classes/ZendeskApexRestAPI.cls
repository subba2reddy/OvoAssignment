/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
@isTest
@RestResource(urlMapping='/RestApi/*')
global class ZendeskApexRestAPI {
    global ZendeskApexRestAPI() {

    }
    global static String createUpdateTicketsforSingleandMultipleDomain(Boolean isMultipleDomainEnabled) {
        return null;
    }
    @HttpPost
    global static String createUpdateZendesk() {
        return null;
    }
    global static Account populateAccountDetails(Account acc, Zendesk.ZendeskApexRestAPI.organizationClass org) {
        return null;
    }
    @isTest(SeeAllData=false OnInstall=false)
    global static void testZendeskApexRestAPI_Four() {

    }
    @isTest(SeeAllData=false OnInstall=false)
    global static void testZendeskApexRestAPI_One() {

    }
    @isTest(SeeAllData=false OnInstall=false)
    global static void testZendeskApexRestAPI_Three() {

    }
    @isTest(SeeAllData=false OnInstall=false)
    global static void testZendeskApexRestAPI_Two() {

    }
    @isTest(SeeAllData=false OnInstall=false)
    global static void testZendeskApexRestAPI_six() {

    }
global class commentClass {
    global String author_id {
        get;
        set;
    }
    global String body {
        get;
        set;
    }
    global Datetime created_at {
        get;
        set;
    }
    global String id {
        get;
        set;
    }
    global Boolean is_public {
        get;
        set;
    }
    global String name {
        get;
        set;
    }
    global commentClass() {

    }
}
global class fieldsClass {
    global String id {
        get;
        set;
    }
    global String title {
        get;
        set;
    }
    global String value {
        get;
        set;
    }
    global fieldsClass() {

    }
}
global class groupClass {
    global String id {
        get;
        set;
    }
    global String name {
        get;
        set;
    }
    global groupClass() {

    }
}
global class metricsClass {
    global Zendesk.ZendeskApexRestAPI.timeClass agent_wait_time_in_minutes {
        get;
        set;
    }
    global Datetime created_at {
        get;
        set;
    }
    global Zendesk.ZendeskApexRestAPI.timeClass full_resolution_time_in_minutes {
        get;
        set;
    }
    global Datetime initially_assigned_at {
        get;
        set;
    }
    global Zendesk.ZendeskApexRestAPI.timeClass on_hold_time_in_minutes {
        get;
        set;
    }
    global Zendesk.ZendeskApexRestAPI.timeClass reply_time_in_minutes {
        get;
        set;
    }
    global Zendesk.ZendeskApexRestAPI.timeClass requester_wait_time_in_minutes {
        get;
        set;
    }
    global Datetime solved_at {
        get;
        set;
    }
    global Datetime updated_at {
        get;
        set;
    }
    global metricsClass() {

    }
}
global class organizationClass {
    global List<String> domain_names {
        get;
        set;
    }
    global String id {
        get;
        set;
    }
    global String name {
        get;
        set;
    }
    global String notes {
        get;
        set;
    }
    global organizationClass() {

    }
}
global class ticketClass {
    global String assignee_id {
        get;
        set;
    }
    global String description {
        get;
        set;
    }
    global List<Zendesk.ZendeskApexRestAPI.fieldsClass> field {
        get;
        set;
    }
    global String group_id {
        get;
        set;
    }
    global String id {
        get;
        set;
    }
    global String organization_id {
        get;
        set;
    }
    global String priority {
        get;
        set;
    }
    global String requester_id {
        get;
        set;
    }
    global String status {
        get;
        set;
    }
    global String subject {
        get;
        set;
    }
    global List<String> tags {
        get;
        set;
    }
    global Long ticket_form_id {
        get;
        set;
    }
    global String type {
        get;
        set;
    }
    global String url {
        get;
        set;
    }
    global ticketClass() {

    }
}
global class timeClass {
    global Double business {
        get;
        set;
    }
    global Double calendar {
        get;
        set;
    }
    global timeClass() {

    }
}
global class userClass {
    global String email {
        get;
        set;
    }
    global String id {
        get;
        set;
    }
    global String name {
        get;
        set;
    }
    global userClass() {

    }
}
global class zendeskTicketClass {
    global List<Zendesk.ZendeskApexRestAPI.commentClass> comments {
        get;
        set;
    }
    global List<Zendesk.ZendeskApexRestAPI.groupClass> groups {
        get;
        set;
    }
    global Zendesk.ZendeskApexRestAPI.metricsClass metrics {
        get;
        set;
    }
    global List<Zendesk.ZendeskApexRestAPI.organizationClass> organizations {
        get;
        set;
    }
    global Zendesk.ZendeskApexRestAPI.ticketClass ticket {
        get;
        set;
    }
    global List<Zendesk.ZendeskApexRestAPI.userClass> users {
        get;
        set;
    }
    global zendeskTicketClass() {

    }
}
}
