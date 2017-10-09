trigger DefaultEntitlement on Case (Before Insert, Before Update) {
   List<Id> acctIds = new List<Id>();
   for (Case c : Trigger.new){
      if (c.EntitlementId == null && c.AccountId != null){
         acctIds.add(c.AccountId);
      }
   }
   if(acctIds.isEmpty()==false){

         List <Entitlement> entls = [Select e.StartDate, e.Id, e.EndDate, e.AccountId, e.AssetId
                                     From Entitlement e
                                     Where e.AccountId in :acctIds And e.StartDate <= Today];
         if(entls.isEmpty()==false){
            for(Case c : Trigger.new){
               if(c.EntitlementId == null && c.AccountId != null){
                  for(Entitlement e:entls){
                     if(e.AccountId==c.AccountId){
                        c.EntitlementId = e.Id;
                        //if(c.AssetId==null && e.AssetId!=null)
                           //c.AssetId=e.AssetId;
                        //break;
                     }
                  } // end for
               }
            } // end for         
      }
   } // end if(acctIds.isEmpty()==false)
}