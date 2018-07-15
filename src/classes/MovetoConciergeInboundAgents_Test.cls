@isTest(seeAllData=true)
private class MovetoConciergeInboundAgents_Test{
static testmethod void MoveToConcierge() 
{
        Test.startTest();
        List<QueueSobject> queuesList = [select QueueId, queue.name from QueueSobject where SobjectType = 'Lead'];
        Map<String,Id> queuesMap = new Map<String, Id>();        
        for(QueueSobject q :queuesList){
        if(q.queue.name.contains('Concierge_On_hold_queue'))
            queuesMap.put('con_hold',q.QueueId);         
        if(q.queue.name.contains('Concierge_Finished_queue'))
            queuesMap.put('con',q.QueueId);
            }
        Lead newLead = new Lead(Company='T-Mobile',firstName = 'CON Handletime811',lastName = 'Test',Call_Type__c  = 'Follow Up', Disposition__c = 'Follow Up',ownerid = '0053600000251YD',First_Call_Attempt_Date__c = Datetime.now(),ZIP__c='98007');
        insert newLead;        
        newLead.First_Call_Attempt_Date__c  = Datetime.now().addHours(-1);
        //newLead.ownerid = '005290000014ozB';
        update newLead;
        Database.executeBatch(New MovetoConciergeInboundAgents(),200);        
}
}