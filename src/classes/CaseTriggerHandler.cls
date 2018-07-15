/* 

Class :Case trigger handler call by case trigger.
Version:1.0
Date :20 July 2016
Desc: Copy the picklist value from  Inbound_Order_status__c to Outbound_Status__c and   Call_despostion_reason__c to Call_Disposition_Reason__c
      for Dedicated Inbound profile user.
      


*/

public class CaseTriggerHandler{
    /* To control recursion on this trigger, assuming a scenario where anything in this trigger updates another object which in turn again updates Case, a static 
        variable could be used to prevent such a condition. A static variable retains its value in a transactional context 
    */
public static boolean isCurrentlyInExecution = false;

    public void processAllTriggerEvents(List<Case> triggerNew, Map<Id, Case> triggerNewMap,  List<Case> triggerOld, Map<Id, Case> triggerOldMap, Boolean isInsert, Boolean isUpdate, Boolean isDelete, Boolean isBefore, Boolean isAfter, Boolean isUnDelete){

        if(isCurrentlyInExecution){
            //Dont do anything. Simply return as this is a recursion. This will break the flow.
            return;
        } else {
            //Set the flag for the first time this trigger is called in a transaction.
            isCurrentlyInExecution = true;
        }
        
        if(Test.isRunningTest())
             isCurrentlyInExecution=false;
       
          
        
        /* Execute any Common SOQL that would get all the data you need for all the triggers being consolidated. You can pass on the 
        results of these SOQL as a parameter to the various event handler methods for further processing */
    
        /*  BEFORE INSERT. You can also join multiple BEFORE Events like Before Update/Before Insert if you like. */
        if(isInsert && isBefore){
           OnBeforeInsert(TriggerNew);
        }
        
        /* BEFORE UPDATE Event */
        if(isUpdate && isBefore){
            OnBeforeUpdate(triggerOld, triggerOldMap, TriggerNew, triggerNewMap);
        }

        /* AFTER UPDATE Event 
        if(isUpdate && isAfter){
            OnAfterUpdate(triggerOld, triggerOldMap, TriggerNew, triggerNewMap);
        }
        
        /* BEFORE DELETE Event 
        if(isBefore && isDelete){
            OnBeforeDelete(triggerOld, triggerOldMap);
        }*/

    }
    
    /* Event Handlers */
    public void OnBeforeInsert(List<Case>  triggernew){
        
        Set<Id> setOwnerIds=new Set<Id>();
        Set<Id> setInboundUserIds=new Set<Id>();
        Map<Id,String> mapIdProfileName=new Map<Id,String>();
        for(Case instCase:triggernew){
            
            setOwnerIds.add(instCase.OwnerId);
            
        }
        for(User instUser:[select profile.name from user where id in :setOwnerIds and profile.name='Dedicated Inbound']){
            
            
            setInboundUserIds.add(instUser.id);
        }
        
        for(Case instCase:triggernew){
            
            if(setInboundUserIds.contains(instCase.ownerID) && String.isNotBlank(instCase.Inbound_Order_status__c )){
                
                instCase.Outbound_Status__c=instCase.Inbound_Order_status__c;
                instCase.Call_Disposition_Reason__c=instCase.Call_despostion_reason__c ;
                
            }
            
        }
        
    }
    public void OnBeforeUpdate(List<Case>  triggerOld, Map<ID, Case> triggerOldMap, List<Case>  triggerNew, Map<ID, Case> triggerNewMap){
        
        Set<Id> setOwnerIds=new Set<Id>();
        Set<Id> setInboundUserIds=new Set<Id>();
        Map<Id,String> mapIdProfileName=new Map<Id,String>();
        for(Case instCase:triggernew){
            
            setOwnerIds.add(instCase.ownerID);
            
        }
        for(User instUser:[select profile.name from user where id in :setOwnerIds and profile.name='Dedicated Inbound']){
            
            
            setInboundUserIds.add(instUser.id);
        }
        
        for(Case instCase:triggernew){
            instCase.last_OwnerId__c=string.valueOF(instCase.ownerId);
         if(setInboundUserIds.contains(instCase.ownerID) && (triggerOldMap.get(instCase.id).Inbound_Order_status__c !=instCase.Inbound_Order_status__c && String.isNotBlank(instCase.Inbound_Order_status__c )) || (triggerOldMap.get(instCase.id).Call_despostion_reason__c !=instCase.Call_despostion_reason__c )){
                
                instCase.Outbound_Status__c=instCase.Inbound_Order_status__c;
                instCase.Call_Disposition_Reason__c=instCase.Call_despostion_reason__c ;
                
            }
            
        }
    }

   /* public void OnBeforeDelete( List<Case> triggerOld, Map<Id, Case> triggerOldMap){
    }

    
    public void OnAfterUpdate(List<Case> triggerNew, Map<Id, Case> triggerNewMap,  List<Case> triggerOld, Map<Id, Case> triggerOldMap){
        
    }*/




}