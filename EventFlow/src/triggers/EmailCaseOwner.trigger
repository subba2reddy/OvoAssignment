trigger EmailCaseOwner on FeedItem (after insert) {
    
    for (FeedItem f: trigger.new) {
        if (f.ParentID != null && f.body != null) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            //Case c = [SELECT Id, CaseNumber, OwnerId, Owner.Email, Owner.Name, Owner.UserRoleId FROM Case WHERE Id = :f.ParentID];
            List<Case> c = [SELECT Id, CaseNumber, OwnerId, Owner.Email, Owner.Name, Owner.UserRoleId FROM Case WHERE Id = :f.ParentID];
            
            if (c.size()>0){
  
                User u = [SELECT ID, Name FROM User WHERE Id = :f.CreatedById];
                
                //Dont email if owner creates post or owner @mentioned as this send email by default
                if (c[0].Owner.Email != null && c[0].OwnerId != f.CreatedById && !f.body.contains('@'+ c[0].Owner.Name)) {
                    String[] toAddresses = new List<String>();
                    toAddresses.add(c[0].owner.email);    
                    //mail.setOrgWideEmailAddressId(owea.Id);
                    mail.setToAddresses(toAddresses);
                    mail.setSubject('New Chatter Post: Case '+ c[0].casenumber);
                    mail.setHtmlBody('<p>' + u.Name + ' wrote...</p>' + '<div style="border-style: Solid; border-width: 1px; padding:10px; width: 50%; border-color: grey">' + f.body + '</div> <p>To view your case <a href=' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + c[0].Id + '>click here.</a></p>');
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                    }
                }
            }
        }
    }