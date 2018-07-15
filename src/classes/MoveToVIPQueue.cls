/*
 @Created to pick First Call Attempt records to move it back to VIP Outbound Queue
*/
global class MoveToVIPQueue implements Database.Batchable<sObject>, Schedulable{
    
    global final String query;
    boolean isBusinessHours;
    
    Time time_0800;
    Time time_2000;
    Id outboundId = [Select Queue.Id from QueueSobject where SobjectType = 'Lead' and Queue.DeveloperName = 'VIP_Outbound_Queue'].Queue.Id;
    global List<Lead> leadsToUpdate;
    
    integer startH = 8;
    integer endH = 20;
    integer delay = 120;
    Datetime delay1 = DateTime.newInstance(0,0,0,0,120,0);
    Datetime mydt = Datetime.now();
    String outBoundReason = 'First Call Attempt';
    String disposition = 'No Contact(No Answer)';
    String followUp = 'Follow Up';
    String followupTime = 'True';
    String Noattempt = '';
    Datetime vipAgentTime = Datetime.now().addHours(3);
    String assignTimer = mydt.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
    String thisTimeStr = Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss\'z\'', 'GMT' );
    
    Map<String, Set<Date>> vipstateToDates;
    String onHoldQueue = 'VIP On Hold Queue';
    String vip = 'VIP';
    Datetime assignTime;
  
    global MoveToVIPQueue (){
        List<VIP_hours__c> hours = VIP_hours__c.getAll().values();
        System.debug('!!!! assignTime10:'+assignTime);
        if(!hours.isEmpty()){
            startH = hours.get(0).start_hour__c.intValue();
            endH = hours.get(0).end_hour__c.intValue();            
        }
        time_0800 = Time.newInstance( startH,  0, 0, 0 );
        time_2000 = Time.newInstance( endH,  0, 0, 0 );
        vipstateToDates = VIPOutboundUtils.createHolidaysMap();
        leadsToUpdate = new List<Lead>();
       /* query = 'select First_Call_Attempt_Date__c,SecondCallBack_time__c,Customer_Local_Time__c,Customer_Time_Zone__c,State,ownerId,Lead_ID__c,Follow_up_Date_Time__c,Disposition__c,Customer_local_time_calc__c,Zip_State__c  from lead where owner.name = :onHoldQueue  and ((Call_Type__c = :outBoundReason  and SecondCallBack_time__c < '+thisTimeStr+')OR ((Call_Type__c = :followUp or Disposition__c = :followUp) and Follow_up_Date_Time__c < '+thisTimeStr+') OR (Call_Type__c = null and Disposition__c = null))';*/
       query = 'select First_Call_Attempt_Date__c,SecondCallBack_time__c,Customer_Local_Time__c,Customer_Time_Zone__c,State,ownerId,Lead_ID__c,Follow_up_Date_Time__c,Disposition__c,Customer_local_time_calc__c,Zip_State__c  from lead where owner.name = :onHoldQueue and ((Call_Type__c = :outBoundReason and Disposition__c = :disposition and SecondCallBack_time__c < '+thisTimeStr+')OR ((Call_Type__c = :followUp or Disposition__c = :followUp) and Is_Followup__c = :followupTime)OR (Call_Type__c = null and Disposition__c = null))';
       
        System.debug('Queryformed:'+query);
    }
       
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
        
    global void execute(Database.BatchableContext BC, List<Lead> scope){
        System.debug('!!! EXECUTE:'+scope);
        System.debug('!!! stateToDates:'+vipstateToDates);
        for(Lead c : scope){
                    if(!VIPOutboundUtils.isHoliday(c.Customer_local_time_calc__c, c.Zip_State__c, vipstateToDates) && VIPOutboundUtils.isBusinessHours(c.Customer_local_time_calc__c, time_0800, time_2000) && !VIPOutboundUtils.isSunday(c.Customer_local_time_calc__c,c.Zip_State__c)){
                    c.OwnerId = outboundId;
                    LeadsToUpdate.add(c);
                    }
                       
        }
        update leadsToUpdate;
    }
    
    global void finish(Database.BatchableContext BC){
        System.debug('!!! FINISH');
    }
    
    global void execute(SchedulableContext sc){
        System.debug('!!! EXECUTE EMPTY');
        Database.executeBatch(this);
    }
}