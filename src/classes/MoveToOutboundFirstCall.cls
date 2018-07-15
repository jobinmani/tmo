/*
 @Created to pick First Call Attempt records to move it back to onho
*/
global class MoveToOutboundFirstCall implements Database.Batchable<sObject>, Schedulable{
    
  global final String query;
    boolean isBusinessHours;
    
    Time time_0800;
    Time time_2000;
    Id outboundId = [Select Queue.Id from QueueSobject where SobjectType = 'Case' and Queue.DeveloperName = 'Outbound_Queue'].Queue.Id;
    global List<Case> casesToUpdate;
    
    integer startH = 8;
    integer endH = 20;
    integer delay = 120;
    Datetime delay1 = DateTime.newInstance(0,0,0,0,120,0);
    Datetime mydt = Datetime.now();
    String outBoundReason = 'No-Sale : First Call Attempt';
    String assignTimer = mydt.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
    String thisTimeStr = Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss\'z\'', 'GMT' );
    
    Map<String, Set<Date>> stateToDates;
    String onHoldQueue = 'On Hold Queue';
    Datetime assignTime;
  
    global MoveToOutboundFirstCall (){
        List<Outbound_settings_cs__c> hours = Outbound_settings_cs__c.getAll().values();
        System.debug('!!!! assignTime10:'+assignTime);
        if(!hours.isEmpty()){
            startH = hours.get(0).start_hour__c.intValue();
            endH = hours.get(0).end_hour__c.intValue();
            delay = hours.get(0).Delay_time_minutes__c.intValue();
        }
        time_0800 = Time.newInstance( startH,  0, 0, 0 );
        time_2000 = Time.newInstance( endH,  0, 0, 0 );
        DateTime assignTime = mydt.addMinutes(-1);
        System.debug('!!!! assignTime11:'+assignTime);
        System.debug('!!!! assignTime9:'+assignTime);
        stateToDates = OutboundUtils.createHolidaysMap();
        casesToUpdate = new List<Case>();
        System.debug('!!!! assignTime:'+assignTime);
        System.debug('!!!! dateTime:'+mydt);
        System.debug('Assigntimer:'+assignTimer);
        //System.debug('today'+mydt);
        //query = 'select X2nd_Call_Back_Date__c, SLA_time__c, Case_assign_time__c, Customer_local_time__c, Customer_Timezone__c, Address_State__c, ownerId from Case where owner.name = :onHoldQueue and Case_assign_time__c < :assignTime';
        query = 'select X2nd_Call_Back_time__c,X2nd_Call_Back_Date__c, SLA_time__c, Case_assign_time__c, Customer_local_time__c, Customer_Timezone__c, Address_State__c, ownerId from Case where owner.name = :onHoldQueue and Outbound_Status__c = :outBoundReason and X2nd_Call_Back_time__c <'+thisTimeStr+'';
        System.debug('Queryformed:'+query);
    }
       
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
        
    global void execute(Database.BatchableContext BC, List<Case> scope){
        System.debug('!!! EXECUTE:'+scope);
        System.debug('!!! stateToDates:'+stateToDates);
        for(Case c : scope){
            if(!OutboundUtils.isHoliday(c.Customer_local_time__c, c.Address_State__c, stateToDates) && OutboundUtils.isBusinessHours(c.Customer_local_time__c, time_0800, time_2000) && !OutboundUtils.isSunday(c.Customer_local_time__c,c.Address_State__c)){
                if(c.X2nd_Call_Back_Date__c == null || c.X2nd_Call_Back_Date__c < Datetime.now()){
                    c.OwnerId = outboundId;
                    casesToUpdate.add(c);
                }
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