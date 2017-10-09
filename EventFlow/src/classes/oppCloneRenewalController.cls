//This class clones an opportunity
public class oppCloneRenewalController {
 
    //added an instance variable for the standard controller
    private ApexPages.StandardController controller {get; set;}
     //add the instance for the variables being passed by id on the url
    private Opportunity opp {get;set;}
 
    //initialize the controller
    public OppCloneRenewalController(ApexPages.StandardController controller) { 
        //initialize the stanrdard controller
        this.controller = controller;
        //load the current record
        opp = (Opportunity)controller.getRecord();       
    }
 
    //method called from the VF's action attribute to clone 
    public PageReference oppCloneRenewal() { 
         Opportunity newOpp;
         Opportunity updateOpp;
         
         try {                      
              //Copy the opportunity - ONLY INCLUDE THE FIELDS YOU WANT TO CLONE              
             opp = [Select o.AccountId, o.Account.Name, o.Primary_Genre__c, o.Other_Genre__c, o.Platform__c, o.Id, o.Name, o.RecordTypeID, o.ContractStartDate__c, o.ContractEndDate__c, o.National_State__c, o.Num_of_Memberships__c, o.Business_development_director_BDD__c, o.Client_support_manager_CSM__c, o.Client_marketing_manager_CMM__c, o.Client_Code__c, o.Spotlight_Homepage__c, o.Spotlight_Homepage_Section__c, o.Spotlight_Subpage__c, o.Ticketalert_Headline__c, o.Ticketalert_Highlight__c, o.Ticketalert_Tip__c, o.Dedicated_Alert__c, o.Genre_Alert__c, o.Co_branding_CO__c, o.Marketing_Notes__c, o.Social_Media__c, o.Static_Page__c, o.Co_branding__c, o.Additional_Promotion__c, o.Ticketalert__c from Opportunity o where o.Id = :opp.id];
                           
             opp.CloseDate = system.today() + 31;
             opp.Preceding_Opportunity__c = opp.id;
             opp.Existing_Contract_Expiration_Date__c = opp.ContractEndDate__c;
             opp.Type = 'Existing Client - Renewal of Contract';
             opp.Name =  opp.Account.Name + ' - Renewal';
             opp.StageName = '3 - Proposal/ Quote';
             opp.ContractStartDate__c = opp.ContractEndDate__c + 1;
             opp.ContractEndDate__c = null;
             opp.Retail_Tickets__c = 0; 
             opp.Box_Office_Tickets__c = 0;   

             newOpp = opp.clone(false);
             insert newOpp;
             
             updateOpp = [Select u.Id, u.Succeeding_Opportunity__c from Opportunity u where u.Id = :opp.id];
             updateOpp.Succeeding_Opportunity__c = newOpp.Id;
             update updateOpp;
                                    
         } catch (Exception e){
            ApexPages.addMessages(e);
            return null;
         }
 
         return new PageReference('/'+newOpp.id);
    }
    
}