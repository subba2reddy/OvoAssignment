@isTest(SeeAllData=true)
private class EmailCaseOwnerTest {
    @isTest static void testInsertFeedItem(){
        UserRole r = [SELECT Id FROM UserRole WHERE Name=:'Product Support' LIMIT 1];
        User u = [SELECT Id FROM User WHERE IsActive=TRUE AND Email!=Null AND UserRoleId=:r.Id LIMIT 1];
        //Case c = [SELECT Id FROM Case WHERE OwnerId=:u.Id LIMIT 1];
        Case c = [SELECT Id FROM Case WHERE OwnerId!=:u.Id LIMIT 1];
        FeedItem f = new FeedItem(ParentId=c.Id,Body='Hello');
        insert f;
    }
}