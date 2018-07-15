@isTest(seeAllData=true)
private class MoveToOutboundJob_Test{
/*
static testmethod void MoveToOutboundJob() 
{
        Test.startTest();
        List<QueueSobject> queuesList = [select QueueId, queue.name from QueueSobject where SobjectType = 'Case'];
        Map<String,Id> queuesMap = new Map<String, Id>();        
        for(QueueSobject q :queuesList){
        if(q.queue.name.contains('On Hold'))
            queuesMap.put('on_hold',q.QueueId);         
        if(q.queue.name.contains('Outbound'))
            queuesMap.put('outbound',q.QueueId);
            }

        Case newCase = new Case(status='in progress', Outbound_Status__c = 'No-Sale : First Call Attempt',ownerid = queuesMap.get('on_hold'), Address_State__c='NJ');
        insert newCase;
        
        newCase.Case_assign_time__c = Datetime.now().addHours(3);
        newCase.ownerid = queuesMap.get('on_hold');
        update newCase;
        Database.executeBatch(New MoveToOutboundJob(),200);        
}*/
}