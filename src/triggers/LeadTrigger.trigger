trigger LeadTrigger on Lead (before insert, before update) {
Map<Id, String> queuesMap = new Map<Id, String>();
Map<Id, String> VIPqueuesMap = new Map<Id, String>();
Id onHoldQID;
Id VIPonHoldQID;
Map<String, Set<Date>> stateToDates = CMNOutboundUtils.createHolidaysMap();
Map<String, Set<Date>> vipstateToDates = VIPOutboundUtils.createHolidaysMap();
Time time_0800;
Time time_2000;
Time viptime_0800;
Time viptime_2000;
Datetime vipAgentTime = Datetime.now().addHours(3);
getQueuesInfo();
setWorkHours();
vipsetWorkHours();
if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
for(Lead newLead : Trigger.new){
            if(hasOwnerChanged(newLead)){
                setSLAForRekeyOutbound(newLead);
                newLead.Lead_assign_time__c = Datetime.now();
                newLead.Lead_Hold_Reason__c = null;
            }
        }
        checkUniqueOwner(Trigger.newMap);
        
        if(Trigger.IsInsert){
            setZipCodeLookup(Trigger.new, null);
        } 
       if(Trigger.isUpdate){
            setZipCodeLookup(Trigger.new, Trigger.OldMap);
        }
    }




private void setZipCodeLookup(List<Lead> newLeads, Map<Id,Lead> oldLeads){
        List<Lead> leadsToUpdate = new List<Lead>();
        if(oldLeads == null){
            leadsToUpdate = newLeads;
        } 
        
        Set<String> zipCodeSet = new Set<String>();
        for(Lead c : newLeads){
            if(oldLeads != null){
                if(c.ZIP__c != oldLeads.get(c.Id).ZIP__c){
                    if(c.ZIP__c != null){
                        String zipCode = c.ZIP__c.replace('-','').replace(' ','');
                        zipCodeSet.add(zipCode); 
                    }
                    leadsToUpdate.add(c);               
                }
            } else {
                if(c.ZIP__c != null){
                    String zipCode = c.ZIP__c.replace('-','').replace(' ','');
                    zipCodeSet.add(zipCode);
                }
            }
        }
        List<Zip_Code_Time_Zone__c> zipCodes = [SELECT Id, Zip_Code__c FROM Zip_Code_Time_Zone__c WHERE Zip_Code__c IN: zipCodeSet];
        Map<String, Zip_Code_Time_Zone__c> zipCodeMap = new Map<String, Zip_Code_Time_Zone__c>();
        for(Zip_Code_Time_Zone__c zc : zipCodes){
            zipCodeMap.put(zc.Zip_Code__c, zc);
        }
        for(Lead c : leadsToUpdate){
            if(c.ZIP__c == null){
                c.Zip_Code_Time_Zone__c = null;
                continue;
            }
            String zipCode = c.ZIP__c.replace('-','').replace(' ','');
            if(zipCodeMap.containsKey(zipCode)){
                c.Zip_Code_Time_Zone__c = zipCodeMap.get(zipCode).Id;
            } else {
                c.Zip_Code_Time_Zone__c = null;
            }
        }
    }
    
    
   private void checkUniqueOwner(Map<Id,Lead> Leads){

    Set<Id> ownersToQuery = new Set<Id>();
    List<Lead> changedLeads = new List<Lead>();
    if (leads != null){
      for (Lead newLead : leads.values()){
        if (hasOwnerChanged(newLead)){
          if (queuesMap.get(newLead.ownerId) == null){ // owner is a user
            ownersToQuery.add(newLead.ownerId);
            changedLeads.add(newLead);
          }
        }
      }
      
      
   system.debug('******* ownersToQuery: ' + ownersToQuery);
      Map<Id, Boolean> ownerInfo = new Map<Id, Boolean>();  
      AggregateResult[] groupedResults = [select count(Id), OwnerId, owner.profile.name from Lead where ownerId in :ownersToQuery and id not in :Trigger.new group by OwnerId, owner.profile.name];
      system.debug('******* groupedResults: ' + groupedResults);
      
      for(AggregateResult result : groupedResults){
        system.debug('******* result: ' + result);
        if(result.get('name') == 'CMN_Queue' && (integer)result.get('expr0') > 0){
          ownerInfo.put((Id)result.get('OwnerId'), true);
        }else
        if(result.get('name') == 'CMN_On_Hold' && (integer)result.get('expr0') > 0){
          ownerInfo.put((Id)result.get('OwnerId'), true);
        }
      }
      
      for (Lead newLead : changedLeads){
        if (ownerInfo.get(newLead.ownerId) == true){ 
          newLead.addError('Agent cannot have more cases assigned');
        }
      }
    }
    }
    
 
 
 private boolean hasOwnerChanged(Lead newLead){
      return (Trigger.oldMap == null || Trigger.oldMap.get(newLead.Id).ownerId != newLead.ownerId);
    }
    
    
 private void setSLAForRekeyOutbound(Lead newLead){
      if(queuesMap.get(newLead.ownerId) != null && queuesMap.get(newLead.ownerId).contains('CMN Queue')){
         if(outsideBusinessHours(newLead)){
         moveToOnHold(newLead);
         newLead.CMN_OnHold_SLA_Time__c = null;
         }
         else
         {
          newLead.CMN_SLA_time__c = Datetime.now().addMinutes(2);
         }
         
       }
     if(queuesMap.get(newLead.ownerId) != null && queuesMap.get(newLead.ownerId).contains('VIP Outbound Queue')){
         if(VIPoutsideBusinessHours(newLead)){
         moveToVipOnHold(newLead);
         newLead.CMN_OnHold_SLA_Time__c = null;
         }
         else
         {
          newLead.CMN_SLA_time__c = Datetime.now().addMinutes(2);
         }
         
       }             
       
    }
    
    
    
    private boolean outsideBusinessHours(Lead c){
      return CMNOutboundUtils.isHoliday(c.Customer_local_time_calc__c, c.Zip_State__c, stateToDates) 
        || !CMNOutboundUtils.isBusinessHours(c.Customer_local_time_calc__c, time_0800, time_2000) 
        || CMNOutboundUtils.isSunday(c.Customer_local_time_calc__c,c.Zip_State__c);
               
    }
    
    private boolean VIPoutsideBusinessHours(Lead c){
      return VIPOutboundUtils.isHoliday(c.Customer_local_time_calc__c, c.Zip_State__c, vipstateToDates) 
        || !VIPOutboundUtils.isBusinessHours(c.Customer_local_time_calc__c, viptime_0800, viptime_2000) 
        || VIPOutboundUtils.isSunday(c.Customer_local_time_calc__c,c.Zip_State__c);
               
    }
 
 
 private void moveToOnHold(Lead c){
       c.OwnerId = onHoldQID;
       if(CMNOutboundUtils.isHoliday(c.Customer_local_time_calc__c, c.Zip_State__c, stateToDates)){
           c.Lead_Hold_Reason__c = 'Holiday';
       } else if (!CMNOutboundUtils.isBusinessHours(c.Customer_local_time_calc__c, time_0800, time_2000) || CMNOutboundUtils.isSunday(c.Customer_local_time_calc__c,c.Zip_State__c)){
           c.Lead_Hold_Reason__c = 'Business Hours';
       }
    }
    
 private void moveToVipOnHold(Lead c){
       c.OwnerId = VIPonHoldQID;
       if(VIPOutboundUtils.isHoliday(c.Customer_local_time_calc__c, c.Zip_State__c, stateToDates)){
           c.Lead_Hold_Reason__c = 'Holiday';
       } else if (!VIPOutboundUtils.isBusinessHours(c.Customer_local_time_calc__c, viptime_0800, viptime_2000) || VIPOutboundUtils.isSunday(c.Customer_local_time_calc__c,c.Zip_State__c)){
           c.Lead_Hold_Reason__c = 'Business Hours';
       }
    }
        
    
   private void getQueuesInfo(){
    List<QueueSobject> queuesList = [select QueueId, queue.name from QueueSobject where SobjectType = 'Lead'];
    for(QueueSobject q :queuesList){
          queuesMap.put(q.QueueId, q.queue.name);
          if(q.queue.name.contains('CMN On Hold')){
            onHoldQID = q.QueueId;
          }
          if(q.queue.name.contains('VIP On Hold')){
            VIPonHoldQID = q.QueueId;
          }
    }
  } 
  
  
   private void setWorkHours(){
    integer startH = 8;
      integer endH = 20;
    List<CMN_hours__c> hours = CMN_hours__c.getAll().values();
        if(!hours.isEmpty()){
            startH = hours.get(0).start_hour__c.intValue();
            endH = hours.get(0).end_hour__c.intValue();
        }
        time_0800 = Time.newInstance( startH,  0, 0, 0 );
        time_2000 = Time.newInstance( endH,  0, 0, 0 );
  } 
 
  private void vipsetWorkHours(){
    integer vipstartH = 8;
      integer vipendH = 20;
    List<VIP_hours__c> hours = VIP_hours__c.getAll().values();
        if(!hours.isEmpty()){
            vipstartH = hours.get(0).start_hour__c.intValue();
            vipendH = hours.get(0).end_hour__c.intValue();
        }
        viptime_0800 = Time.newInstance( vipstartH,  0, 0, 0 );
        viptime_2000 = Time.newInstance( vipendH,  0, 0, 0 );
  } 
 
 }