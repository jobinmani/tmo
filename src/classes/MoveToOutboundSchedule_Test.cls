@isTest(SeeAllData=true)
public class MoveToOutboundSchedule_Test
{
public static testMethod void testschedule() {
Test.StartTest();
MoveToOutboundSchedule sh1 = new MoveToOutboundSchedule();
String sch = '0 0 23 * * ?'; 
system.schedule('Test VIP Check', sch, sh1);
Test.stopTest(); 
}
}