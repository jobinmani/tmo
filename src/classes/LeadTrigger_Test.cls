@isTest
private class LeadTrigger_Test {

    static testmethod void testQueueAssignment() {
    
        //createHolidays();
    
        List<QueueSobject> queuesList = [select QueueId, queue.name from QueueSobject where SobjectType = 'Lead'];
        Map<String,Id> queuesMap = new Map<String, Id>();
        
        for(QueueSobject q :queuesList){
            if(q.queue.name.contains('CMN_Queue'))
                queuesMap.put('rekey',q.QueueId);
            if(q.queue.name.contains('CMN_Finished'))
                queuesMap.put('outbound',q.QueueId);
            if(q.queue.name.contains('VIP_Outbound_Queue'))
                queuesMap.put('rekey',q.QueueId);
            if(q.queue.name.contains('VIP_Finished_Queue'))
                queuesMap.put('outbound',q.QueueId);
        }

        Lead newLead = new Lead(Company='T-Mobile',firstName = 'CMN Handletime81', lastName = 'Test',OwnerId = '00G36000001lXx9',ZIP__C = '98007');
        insert newLead;
        Lead result = [select ownerId,Lead_assign_time__c from Lead where id = :newLead.Id];

        //System.assertEquals(queuesMap.get('rekey'),result.ownerId);
       // System.assert(result.SLA_time__c != null);
    
        newLead.Disposition__c = 'Sale';
        newLead.Call_Type__c = 'First Call Attempt';
        newLead.TOM_Order__c = '0123456789';
        update newLead;
    
        result = [select ownerId,Lead_assign_time__c from Lead where id = :newLead.Id];

    // assertion works only if currently are business hours for a customer
    //    System.assertEquals(queuesMap.get('outbound'),result.ownerId);
    //    System.assert(result.SLA_time__c != null);
    }
    
    
    static testmethod void testUniqueCMNOwner() {
    
        //User rekey = [select id from User where profile.name = 'Rekey' and isActive = true limit 1];
        Id pId = [select id from profile where name ='CMN Agent'].Id;
        User cmn = new User(username = 'test1@cmn.com', profileId = pId,
        Location_And_code__c ='Tampa 1515', lastname = 'tets',email  = 'tets@cmn.com', alias='test2',
        localesidkey = 'en_US', emailencodingkey='UTF-8', languagelocalekey='en_US');
        insert cmn;
        
        boolean excCaught = false;
        
        Lead newLead1 = new Lead(Company='T-Mobile1',firstName = 'CMN Handletime811',lastName = 'Test1');
        insert newLead1;
        newLead1.OwnerId = cmn.Id;
        newLead1.TOM_Order__c = '0123456789';
        update newLead1;
            
        Lead newLead2 = new Lead(Company='T-Mobile2',firstName = 'CMN Handletime812',lastName = 'Test2');
        insert newLead2;
        newLead2.TOM_Order__c = '0123456789';
        newLead2.OwnerId = cmn.Id;
        try{
            System.debug('!!!!! start');
            update newLead2;
            System.debug('!!!!! end');
        }catch(Exception e){
            excCaught = true;
        }
            
      //  System.assertEquals(true, excCaught, 'Second case should not be inserted for rekey');
    
    }
    
    static testmethod void testUniqueOutboundOwner() {
    
        //User outbound = [select id from User where profile.name = 'Outbound' and isActive = true limit 1];
        Id pId = [select id from profile where name ='CMN Coach'].Id;
        User coach = new User(username = 'tets@outbound.com', profileId = pId, 
        Location_And_code__c ='Tampa 1515', lastname = 'tets',email  = 'tets@cmn.com', alias='test',
        localesidkey = 'en_US', emailencodingkey='UTF-8', languagelocalekey='en_US');
        insert coach;
        
        boolean excCaught = false;
        
        Lead newLead2 = new Lead(Company='T-Mobile3',firstName = 'CMN Handletime813', lastName = 'Test3');
        insert newLead2;
        newLead2.OwnerId = coach.Id;
        newLead2.TOM_Order__c = '0123456789';
        update newLead2;
            
            
        Lead newLead3 = new Lead(Company='T-Mobile4',firstName = 'CMN Handletime814', lastName = 'Test4');
        insert newLead3;
        newLead3.TOM_Order__c = '0123456789';
        update newLead3;
        
        newLead3.OwnerId = coach.Id;
        try{
            System.debug('!!!!! start');
            update newLead3;
            System.debug('!!!!! end');
        }catch(Exception e){
            excCaught = true;
        }
            
       // System.assertEquals(true, excCaught, 'Third case should not be inserted for outbound');
    
    }
    
    
    static testmethod void vipowner() {
    
        //User outbound = [select id from User where profile.name = 'Outbound' and isActive = true limit 1];
        Id pId = [select id from profile where name ='VIP Coach'].Id;
        User coach = new User(username = 'tets@outbound.com', profileId = pId, 
        Location_And_code__c ='Tampa 1515', lastname = 'tets',email  = 'tets@cmn.com', alias='test',
        localesidkey = 'en_US', emailencodingkey='UTF-8', languagelocalekey='en_US');
        insert coach;
        
        boolean excCaught = false;
        
        Lead newLead2 = new Lead(Company='T-Mobile3',firstName = 'VIPHandletime813', lastName = 'Test3',OwnerId = '00G36000001liKk',ZIP__C = '98007');
        insert newLead2;
        newLead2.OwnerId = coach.Id;
        newLead2.TOM_Order__c = '0123456789';
        update newLead2;
            
            
        Lead newLead3 = new Lead(Company='T-Mobile4',firstName = 'CMN Handletime814', lastName = 'Test4',OwnerId = '00G36000001liKk',ZIP__C = '10022');
        insert newLead3;
        newLead3.TOM_Order__c = '0123456789';
        update newLead3;
        
        newLead3.OwnerId = coach.Id;
        try{
            System.debug('!!!!! start');
            update newLead3;
            System.debug('!!!!! end');
        }catch(Exception e){
            excCaught = true;
        }
            
       // System.assertEquals(true, excCaught, 'Third case should not be inserted for outbound');
    
    }
    
   
    private void createHolidays(){
        
    }
}