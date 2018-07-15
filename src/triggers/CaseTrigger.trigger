trigger CaseTrigger on Case (before insert, before update) {
/* Call handler class */
    CaseTriggerHandler objCaseTriggerHandler=new CaseTriggerHandler();
    objCaseTriggerHandler.processAllTriggerEvents(trigger.new, trigger.newMap,  trigger.Old, trigger.oldMap, Trigger.isInsert, Trigger.isUpdate, Trigger.isDelete, Trigger.isBefore, Trigger.isAfter, Trigger.isUnDelete);

    
    Map<Id, String> queuesMap = new Map<Id, String>();
    Id onHoldQID;
    Map<String, Set<Date>> stateToDates = OutboundUtils.createHolidaysMap();
    Time time_0800;
    Time time_2000;
        
  getQueuesInfo();
  setWorkHours();

    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        for(Case newCase : Trigger.new){
            if(hasOwnerChanged(newCase)){
                setSLAForRekeyOutbound(newCase);
                newCase.Case_assign_time__c = Datetime.now();
                newCase.On_Hold_Reason__c = null;
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
    
    private void setZipCodeLookup(List<Case> newCases, Map<Id,Case> oldCases){
        List<Case> casesToUpdate = new List<Case>();
        if(oldCases == null){
            casesToUpdate = newCases;
        } 
        
        Set<String> zipCodeSet = new Set<String>();
        for(Case c : newCases){
            if(oldCases != null){
                if(c.Billing_Address_Zip__c != oldCases.get(c.Id).Billing_Address_Zip__c){
                    if(c.Billing_Address_Zip__c != null){
                        String zipCode = c.Billing_Address_Zip__c.replace('-','').replace(' ','');
                        zipCodeSet.add(zipCode); 
                    }
                    casesToUpdate.add(c);               
                }
            } else {
                if(c.Billing_Address_Zip__c != null){
                    String zipCode = c.Billing_Address_Zip__c.replace('-','').replace(' ','');
                    zipCodeSet.add(zipCode);
                }
            }
        }
        List<Zip_Code_Time_Zone__c> zipCodes = [SELECT Id, Zip_Code__c FROM Zip_Code_Time_Zone__c WHERE Zip_Code__c IN: zipCodeSet];
        Map<String, Zip_Code_Time_Zone__c> zipCodeMap = new Map<String, Zip_Code_Time_Zone__c>();
        for(Zip_Code_Time_Zone__c zc : zipCodes){
            zipCodeMap.put(zc.Zip_Code__c, zc);
        }
        for(Case c : casesToUpdate){
            if(c.Billing_Address_Zip__c == null){
                c.Zip_Code_Time_Zone__c = null;
                continue;
            }
            String zipCode = c.Billing_Address_Zip__c.replace('-','').replace(' ','');
            if(zipCodeMap.containsKey(zipCode)){
                c.Zip_Code_Time_Zone__c = zipCodeMap.get(zipCode).Id;
            } else {
                c.Zip_Code_Time_Zone__c = null;
            }
        }
    }
    
    private void checkUniqueOwner(Map<Id,Case> cases){

    Set<Id> ownersToQuery = new Set<Id>();
    List<Case> changedCases = new List<Case>();
    if (cases != null){
      for (Case newCase : cases.values()){
        if (hasOwnerChanged(newCase)){
          if (queuesMap.get(newCase.ownerId) == null){ // owner is a user
            ownersToQuery.add(newCase.ownerId);
            changedCases.add(newCase);
          }
        }
      }
      
      system.debug('******* ownersToQuery: ' + ownersToQuery);
      Map<Id, Boolean> ownerInfo = new Map<Id, Boolean>();  
      AggregateResult[] groupedResults = [select count(Id), OwnerId, owner.profile.name from Case where ownerId in :ownersToQuery and id not in :Trigger.new group by OwnerId, owner.profile.name];
      system.debug('******* groupedResults: ' + groupedResults);
      
      for(AggregateResult result : groupedResults){
        system.debug('******* result: ' + result);
        if(result.get('name') == 'Rekey' && (integer)result.get('expr0') > 0){
          ownerInfo.put((Id)result.get('OwnerId'), true);
        }else
        if(result.get('name') == 'Outbound' && (integer)result.get('expr0') > 0){
          ownerInfo.put((Id)result.get('OwnerId'), true);
        }
      }
      
      for (Case newCase : changedCases){
        if (ownerInfo.get(newCase.ownerId) == true){ 
          newCase.addError('Agent cannot have more cases assigned');
        }
      }
    }
    }
    

        
    private boolean hasOwnerChanged(Case newCase){
      return (Trigger.oldMap == null || Trigger.oldMap.get(newCase.Id).ownerId != newCase.ownerId);
    }
    
    private void setSLAForRekeyOutbound(Case newCase){
      if(queuesMap.get(newCase.ownerId) != null && queuesMap.get(newCase.ownerId).contains('Rekey')){
          newCase.SLA_time__c = Datetime.now().addMinutes(10);
        }else if(queuesMap.get(newCase.ownerId) != null && queuesMap.get(newCase.ownerId).contains('Outbound')){
          if(outsideBusinessHours(newCase)){
            moveToOnHold(newCase);
            newCase.SLA_Time_Outbound__c = null;
          }else{
            newCase.SLA_Time_Outbound__c = Datetime.now().addMinutes(30);
          }
        }else {
            newCase.SLA_time__c = null;
            newCase.SLA_Time_Outbound__c = null;
        }
    }
    
    private boolean outsideBusinessHours(Case c){
      return OutboundUtils.isHoliday(c.Customer_local_time__c, c.Address_State__c, stateToDates) 
        || !OutboundUtils.isBusinessHours(c.Customer_local_time__c, time_0800, time_2000) 
        || OutboundUtils.isSunday(c.Customer_local_time__c,c.Address_State__c);
               
    }
 
    private void moveToOnHold(Case c){
       c.OwnerId = onHoldQID;
       if(OutboundUtils.isHoliday(c.Customer_local_time__c, c.Address_State__c, stateToDates)){
           c.On_Hold_Reason__c = 'Holiday';
       } else if (!OutboundUtils.isBusinessHours(c.Customer_local_time__c, time_0800, time_2000) || OutboundUtils.isSunday(c.Customer_local_time__c,c.Address_State__c)){
           c.On_Hold_Reason__c = 'Business Hours';
       }
    }
 
  private void getQueuesInfo(){
    List<QueueSobject> queuesList = [select QueueId, queue.name from QueueSobject where SobjectType = 'Case'];
    for(QueueSobject q :queuesList){
          queuesMap.put(q.QueueId, q.queue.name);
          if(q.queue.name.contains('On Hold')){
            onHoldQID = q.QueueId;
          }
    }
  }
  
  private void setWorkHours(){
    integer startH = 8;
      integer endH = 20;
    List<Outbound_settings_cs__c> hours = Outbound_settings_cs__c.getAll().values();
        if(!hours.isEmpty()){
            startH = hours.get(0).start_hour__c.intValue();
            endH = hours.get(0).end_hour__c.intValue();
        }
        time_0800 = Time.newInstance( startH,  0, 0, 0 );
        time_2000 = Time.newInstance( endH,  0, 0, 0 );
  } 
    
}