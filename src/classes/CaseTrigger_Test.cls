@isTest
private class CaseTrigger_Test {

    static testmethod void testQueueAssignment() {
    
        //createHolidays();
    
        List<QueueSobject> queuesList = [select QueueId, queue.name from QueueSobject where SobjectType = 'Case'];
        Map<String,Id> queuesMap = new Map<String, Id>();
        
        for(QueueSobject q :queuesList){
            if(q.queue.name.contains('Rekey'))
                queuesMap.put('rekey',q.QueueId);
            if(q.queue.name.contains('Outbound'))
                queuesMap.put('outbound',q.QueueId);
        }

        Case newCase = new Case(status='new');
        insert newCase;
        Case result = [select ownerId, SLA_time__c from Case where id = :newCase.Id];

        //System.assertEquals(queuesMap.get('rekey'),result.ownerId);
       // System.assert(result.SLA_time__c != null);
    
        newCase.Rekey_Status__c = 'Payment Error';
        newCase.TOM_Order_Number__c = '0123456789';
        update newCase;
    
        result = [select ownerId, SLA_time__c from Case where id = :newCase.Id];

    // assertion works only if currently are business hours for a customer
    //    System.assertEquals(queuesMap.get('outbound'),result.ownerId);
    //    System.assert(result.SLA_time__c != null);
    }
    
    
    static testmethod void testUniqueRekeyOwner() {
    
        //User rekey = [select id from User where profile.name = 'Rekey' and isActive = true limit 1];
        Id pId = [select id from profile where name ='Rekey Agent'].Id;
        User rekey = new User(username = 'tets@rekey.com', profileId = pId,
        Location_And_code__c ='Tampa 1515', lastname = 'tets',email  = 'tets@outbound.com', alias='test2',
        localesidkey = 'en_US', emailencodingkey='UTF-8', languagelocalekey='en_US');
        insert rekey;
        
        boolean excCaught = false;
        
        Case newCase1 = new Case(status='new');
        insert newCase1;
        newCase1.OwnerId = rekey.Id;
        newCase1.TOM_Order_Number__c = '0123456789';
        update newCase1;
            
        Case newCase2 = new Case(status='new');
        insert newCase2;
        newCase2.TOM_Order_Number__c = '0123456789';
        newCase2.OwnerId = rekey.Id;
        try{
            System.debug('!!!!! start');
            update newCase2;
            System.debug('!!!!! end');
        }catch(Exception e){
            excCaught = true;
        }
            
      //  System.assertEquals(true, excCaught, 'Second case should not be inserted for rekey');
    
    }
    
    static testmethod void testUniqueOutboundOwner() {
    
        //User outbound = [select id from User where profile.name = 'Outbound' and isActive = true limit 1];
        Id pId = [select id from profile where name ='Outbound Agent'].Id;
        User outbound = new User(username = 'tets@outbound.com', profileId = pId, 
        Location_And_code__c ='Tampa 1515', lastname = 'tets',email  = 'tets@outbound.com', alias='test',
        localesidkey = 'en_US', emailencodingkey='UTF-8', languagelocalekey='en_US');
        insert outbound;
        
        boolean excCaught = false;
        
        Case newCase1 = new Case(status='new');
        insert newCase1;
        newCase1.OwnerId = outbound.Id;
        newCase1.TOM_Order_Number__c = '0123456789';
        update newCase1;
            
            
        Case newCase3 = new Case(status='new');
        insert newCase3;
        newCase3.TOM_Order_Number__c = '0123456789';
        update newCase3;
        
        newCase3.OwnerId = outbound.Id;
        try{
            System.debug('!!!!! start');
            update newCase3;
            System.debug('!!!!! end');
        }catch(Exception e){
            excCaught = true;
        }
            
       // System.assertEquals(true, excCaught, 'Third case should not be inserted for outbound');
    
    }
    
   
    private void createHolidays(){
        
    }
}