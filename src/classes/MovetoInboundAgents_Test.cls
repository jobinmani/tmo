@isTest(seeAllData=true)
private class MovetoInboundAgents_Test{


static testmethod void MovetoInboundAgents_TestMethod() 
{
    
     
   Test.StartTest();
   
   Database.executeBatch(New MovetoInboundAgents (),200);        
   
   Test.StopTest();
 
}
}