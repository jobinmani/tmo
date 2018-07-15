@isTest(SeeAllData=true)
public class MoveConciergeInBoundAgentsschedular_Test
{
public static testMethod void testschedule() {
Test.StartTest();
MoveConciergeInBoundAgentsschedular sh1 = new MoveConciergeInBoundAgentsschedular();
String sch = '0 0 23 * * ?'; 
system.schedule('Test concierge Check', sch, sh1);
Test.stopTest(); 
}
}