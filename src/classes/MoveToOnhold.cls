/**
* @description Takes cases out of On Outbound Queue to On Hold Queue after business hours
*/
global class MoveToOnhold implements Database.Batchable<sObject>, Schedulable{
    
  global final String query;
  boolean isBusinessHours;
    
    Time time_0800;
    Time time_2000;
    Id onholdId = [Select Queue.Id from QueueSobject where SobjectType = 'Case' and Queue.DeveloperName = 'On_Hold_Queue'].Queue.Id;
    global List<Case> casesToUpdate;
    
    integer startH = 8;
    integer endH = 20;
    integer delay = 120;    
    Datetime mydt = Datetime.now();    
    String OutbundQueue = 'Outbound Queue';
    Datetime assignTime;
  
    global MoveToOnhold (){
        List<Outbound_settings_cs__c> hours = Outbound_settings_cs__c.getAll().values();
        System.debug('!!!! assignTime10:'+assignTime);
        if(!hours.isEmpty()){
            startH = hours.get(0).start_hour__c.intValue();
            endH = hours.get(0).end_hour__c.intValue();
            delay = hours.get(0).Delay_time_minutes__c.intValue();
        }
        time_0800 = Time.newInstance( startH,  0, 0, 0 );
        time_2000 = Time.newInstance( endH,  0, 0, 0 );        
        System.debug('!!!! assignTime11:'+assignTime);        
        casesToUpdate = new List<Case>();              
             
        String assignTimer = mydt.format('yyyy-MM-dd\'T\'19:59:00\'Z\'');
        System.debug('###assignTime:'+assignTimer);                
        query = 'select X2nd_Call_Back_Date__c, SLA_time__c, Case_assign_time__c, Customer_local_time__c, Customer_Timezone__c, Address_State__c, ownerId from Case where owner.name = :OutbundQueue and Customer_local_time__c  > '+assignTimer+'';
        
    }  
      
    global Database.QueryLocator start(Database.BatchableContext BC){    
        return Database.getQueryLocator(query);         
    }   
       
    global void execute(Database.BatchableContext BC, List<Case> scope){
        System.debug('!!! EXECUTE:'+scope);              
        for(Case c : scope){
              if(!OutboundUtils.isBusinessHours(c.Customer_local_time__c, time_0800, time_2000)){     
                    c.OwnerId = onholdId;
                    casesToUpdate.add(c);                
            }
        }
        update casesToUpdate;
    }
    
    global void finish(Database.BatchableContext BC){
        System.debug('!!! FINISH');
    }
    
    global void execute(SchedulableContext sc){
        System.debug('!!! EXECUTE EMPTY');
        Database.executeBatch(this);
    }
}