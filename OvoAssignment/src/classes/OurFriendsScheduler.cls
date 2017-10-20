public class OurFriendsScheduler implements Schedulable{
    
    public void execute(SchedulableContext sc){
        
        OurFriendsBatch ofriendsBatch=new OurFriendsBatch();
        database.executeBatch(ofriendsBatch);
    }
    
}