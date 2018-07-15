@isTest(SeeAllData=true)
public class VIPSchedule_Test
{
public static testMethod void testschedule() {
Test.StartTest();
MoveToVIPSchedule sh1 = new MoveToVIPSchedule();
String sch = '0 0 23 * * ?'; 
system.schedule('Test VIP Check', sch, sh1);
Test.stopTest(); 
}
}