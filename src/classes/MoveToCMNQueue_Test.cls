@isTest(seeAllData=true)
private class MoveToCMNQueue_Test{
static testmethod void MoveToCMN() 
{
        Test.startTest();
        List<QueueSobject> queuesList = [select QueueId, queue.name from QueueSobject where SobjectType = 'Lead'];
        Map<String,Id> queuesMap = new Map<String, Id>();        
        for(QueueSobject q :queuesList){
        if(q.queue.name.contains('CMN_On_Hold_Queue'))
            queuesMap.put('cmn_hold',q.QueueId);         
        if(q.queue.name.contains('CMN_Queue'))
            queuesMap.put('cmn',q.QueueId);
            }
        Lead newLead = new Lead(Company='T-Mobile',firstName = 'CMN Handletime811',lastName = 'Test',Call_Type__c  = 'First Call Attempt', Disposition__c = 'No Contact(No Answer)',ownerid = '0053600000251YD',First_Call_Attempt_Date__c = Datetime.now(),ZIP__c='98007');
        insert newLead;        
        newLead.First_Call_Attempt_Date__c  = Datetime.now().addHours(-1);
        newLead.ownerid = '0053600000251YD';
        update newLead;
        Database.executeBatch(New MoveToCMNQueue(),200);        
}
}