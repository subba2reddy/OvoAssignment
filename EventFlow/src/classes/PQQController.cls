public class PQQController{

    private final PQQ__c pqq;

    public PQQController() {
        User u = [SELECT Id, Contact.AccountId, Contact.Account.Id FROM User WHERE Id = :UserInfo.getUSerId()];

        pqq = [SELECT Id, 
               		Name, 
	        		Account__c, 
	        		Accidents_reportable_under_RIDDOR__c,
	        		Accredited_ISO_9001_or_any_equivalent__c, 
	        		Activities_present_risk__c, 
	        		Adverse_Weather_Plan__c, 
	        		Annual_Turnover_Last_Year__c, 
	        		Annual_Turnover_Previous_Year__c, 
	        		Appointed_person_responsible_for_H_S__c, 
	        		Assessed_risks_arising_from_work__c, 
	        		Audited_Accounts__c, 
	        		Bank__c, 
	        		Breach_of_any_environmental_legislation__c, 
	        		Carry_out_work_which_deemed_construction__c, 
	        		Comments__c,
	        		COSHH_Policy__c, 
	        		Company_H_S_Policy__c, 
					Company_Registration_Number__c, 
					Contact_Mobile_Number__c, 
					Contact_Office_Number__c, 
					Contact_Position__c, 
					Criminal_Offences__c, 
					Date_of_Registration__c, 
					Declaration__c, 
					Details_of_Subcontractors__c, 
					Email__c, 
					Employee_involvement_scheme__c, 
					Employers_Liability_Insurance_10M__c, 
					Employers_Liability_Insurance_FROM__c, 
					Employers_Liability_Insurance_TO__c, 
					Ensure_staff_are_competent__c, 
					Ensure_sub_contractors_are_competent__c, 
					Environmental_Sustainability_Policy__c, 
					Environmental_management_system__c,  
					Environmental_policy_management_system__c, 
					Event_H_S_Documentation_Comments__c, 
					Event_Method_Statement__c, 
					Event_Risk_Assessment__c, 
					Financial_or_Family_Connections__c, 
					Financial_Standing__c, 
					Fire_Risk_Assessment__c, 
					First_aid_arrangements__c, 
					Flame_Certificates__c, 
					H_S_Offences__c, 
					Industrial_Tribunals__c, 
					Is_the_Organisation__c, 
					Litigation__c, 
					LOLER_certificates__c, 
					Manual_Handling_Policy__c, 
					Medical_Malpractice_Insurance__c, 
					Method_statement__c, 
					Met_Obligations_To_Pay_Creditors_Staff__c, 
					Met_the_terms_of_its_banking_facilities__c, 
					Mobile_Number__c, 
					Modern_Slavery_Act_2015__c, 
					Name__c, 
					Name_Addresses_All_UK_Group_Companies__c, 
					Name_relevant_qualification_experience__c, 
					Name_of_Day_to_Day_contact__c, 
					Name_of_Parent_Company__c, 
					Notice_relating_food_hygiene__c, 
					Office_Number__c, 
					Other__c, 
					Parent_Company_Registration_Number__c, 
					Position__c, 
					Position_with_respect_to_the_ISO_14001__c, 
					Postal_Address__c, 
					Primary_Business_Activity__c, 
					Professional_association_membership__c, 
					Professional_Indemnity_Insurance__c, 
					Provide_staff_with_work_Method_Statement__c, 
					Public_Product_Liability_Insurance_5M__c, 
					Public_Product_Liability_Insurance_FROM__c, 
					Public_Product_Liability_Insurance_TO__c, 
					Ref1_Approx_Value__c, 
					Ref1_Start_End_Dates_of_Contract__c, 
					Ref2_Approx_Value__c, 
					Ref2_Start_End_Dates_of_Contract__c, 
					Reference_1__c, 
					Reference_2__c, 
					Registered_Address__c, 
					Registered_Name__c, 
					Registration_as_a_Food_Business__c, 
					Responsible_for_H_S_management_on_site__c, 
					Risk_Assessment__c, 
					Status__c, 
					Structural_Drawings_Calculations__c, 
					Structure_Under_Which_Submitting_PQQ__c, 
					System_of_quality_assurance__c, 
					Trading_Name__c, 
					Training_and_induction_processes__c, 
					Turnover_profit_and_loss_and_cash_flow__c, 
					VAT_Registration_Number__c, 
					Who_is_responsible_for_training__c, 
					Winding_Up_Order_or_Similar__c, 
					Work_at_Height__c 
        			FROM PQQ__c 
					WHERE Account__c = :u.Contact.Account.Id
					LIMIT 1];
    }

    public PQQ__c getPQQ() {
        return pqq;
   }

    public PageReference save() {
    	try{
        	update pqq;
        	Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,+'Record saved successfully')); 
        	return null;	
        }
        catch(Exception ex){
			ApexPages.addMessages(ex);
			return null;	
		}
    }
    
    public PageReference submit() {
    	if(pqq.Declaration__c){    		
	    	try{
	    		pqq.Status__c = 'Submitted';
	        	update pqq;
	        	Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,+'Record submitted successfully')); 
	        	return null;
	        }
	        catch(Exception ex){
				ApexPages.addMessages(ex);
				return null;	
			}
    	}
		else {
			Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,+'Please accept declaration'));
			return null;	
		}
    }
}