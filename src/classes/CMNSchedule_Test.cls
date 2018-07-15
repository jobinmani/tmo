@isTest(SeeAllData=true)
public class CMNSchedule_Test
{
public static testMethod void testschedule() {
Test.StartTest();
MoveToCMNSchedule sh1 = new MoveToCMNSchedule();
String sch = '0 0 23 * * ?'; 
system.schedule('Test CMN Check', sch, sh1);
Test.stopTest(); 
}
}