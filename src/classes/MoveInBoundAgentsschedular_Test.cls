@isTest(SeeAllData=true)
public class MoveInBoundAgentsschedular_Test
{
public static testMethod void testschedule() {
Test.StartTest();
MoveInBoundAgentsschedular sh1 = new MoveInBoundAgentsschedular();
String sch = '0 0 23 * * ?'; 
system.schedule('Test Inbound Check', sch, sh1);
Test.stopTest(); 
}
}