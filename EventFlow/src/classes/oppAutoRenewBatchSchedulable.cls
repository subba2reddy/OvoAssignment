global class oppAutoRenewBatchSchedulable implements Schedulable{
   global void execute(SchedulableContext sc) {
      oppAutoRenewBatch b = new oppAutoRenewBatch(); 
      database.executebatch(b);
   }
}