global class MovetoInboundAgents implements Database.Batchable<sObject>{

String InboundonHoldQueue = 'Inbound On Hold Queue';
String leadsourcechat= 'chat';
String leadsourceconsumerIbound= 'Consumer Inbound';


  
    global Database.QueryLocator start(Database.BatchableContext bc){

        String query= 'SELECT  LeadSource,OwnerId,Followup_by_latest_Agent__c,get_OwnerId__c,Owner__c,Now__c,Agent_Reminder_Batch_Time__c,owner.name   from Lead  where owner.name = :InboundonHoldQueue ' ;
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        
        for(Lead l: scope){
             
            if( l.Owner__c=='Inbound On Hold Queue' && l.Now__c >= l.Agent_Reminder_Batch_Time__c){
                
        l.OwnerId = l.Followup_by_latest_Agent__c;
      
      }
               
        }
        update scope;
    }
    global void finish(Database.BatchableContext bc){
        
    }
}