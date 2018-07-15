@isTest (SeeAllData = true) //CaseHistory data is not created in test class
public class OutboundReportScreenControllerTest{

    static List<User> users = new List<User>();
    static Profile outboundProfile;
    static Profile rekeyProfile;
    static User outboundCoachUser;
    static User rekeyCoachUser;
    static UserRole rekeyRole,outboundrole;
    static case caseObj;
    static List<Case> cases = new List<Case>();
    static{
        //rekeyRole=[Select ID from userRole where developerName='Rekey_Coach' limit 1 ];
        outboundrole=[Select ID from userRole where developerName='Outbound_Coach' limit 1 ];
        outboundProfile = [SELECT Id FROM Profile WHERE Name='Outbound Coach'];
    //    rekeyProfile = [SELECT Id FROM Profile WHERE Name='Rekey'];
        outboundCoachUser = new User(UserRoleid=outboundrole.id,Alias = 'outc', Email='outboundcoach@testorg.com', EmailEncodingKey='UTF-8', LastName='Outbound', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = outboundProfile.Id, TimeZoneSidKey='America/Los_Angeles', UserName='outboundcoach@testorg.com', Location_And_Code__c = '126-Tampa');
        insert outboundCoachUser;
        //rekeyCoachUser = new User(UserRoleid=rekeyRole.id, Alias = 'rekc', Email='rekeycoach@testorg.com', EmailEncodingKey='UTF-8', LastName='Rekey', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = rekeyProfile.Id, TimeZoneSidKey='America/Los_Angeles', UserName='rekeycoach@testorg.com', Location_And_Code__c = '126-Tampa');
        //insert rekeyCoachUser;
        
        
    }
   

     public static testMethod void myUnitTest(){
         Test.startTest();
       
            system.runAs(outboundCoachUser){
             
            OutboundReportScreenController ctrl = new OutboundReportScreenController();
            ctrl.refresh();
            ctrl.getTimeInSeconds('07:30:20');
           // OutboundReportScreenController.convertTimeIntervalToString(1000);
        } 
          Test.StopTest();  
    }       
}