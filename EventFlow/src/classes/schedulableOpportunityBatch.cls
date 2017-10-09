public class schedulableOpportunityBatch implements Schedulable {
   public void execute(SchedulableContext sc) {
      opportunityBatch b = new opportunityBatch(); 
      database.executebatch(b);
   }
}