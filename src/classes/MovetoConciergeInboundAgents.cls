global class MovetoConciergeInboundAgents implements Database.Batchable<sObject>{

String ConciergeonHoldQueue = 'Concierge On hold queue';
//String leadsourcechat= 'chat';
//String leadsourceconsumerIbound= 'Consumer Inbound';
String leadsourceconcierge = 'Concierge';
String followUp = 'Follow Up';
String followupTime = 'True';

  
    global Database.QueryLocator start(Database.BatchableContext bc){

        //String query= 'SELECT  LeadSource,OwnerId,Followup_by_latest_Agent__c,get_OwnerId__c,Owner__c,Now__c,Agent_Reminder_Batch_Time__c,owner.name   from Lead  where owner.name = :ConciergeonHoldQueue and Disposition__c = :followUp and Is_Followup__c = :followupTime ' ;
        String query= 'SELECT  LeadSource,OwnerId,Followup_by_latest_Agent__c,get_OwnerId__c,Owner__c,Now__c,Agent_Reminder_Batch_Time__c,owner.name   from Lead  where owner.name = :ConciergeonHoldQueue and Disposition__c = :followUp ' ;
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        
        for(Lead l: scope){
             
            if( l.Owner__c=='Concierge On hold queue' && l.Now__c >= l.Agent_Reminder_Batch_Time__c){
                
        l.OwnerId = l.Followup_by_latest_Agent__c;
      
      }
               
        }
        update scope;
    }
    global void finish(Database.BatchableContext bc){
        
    }
}