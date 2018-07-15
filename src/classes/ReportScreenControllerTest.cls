@isTest (SeeAllData = true) //CaseHistory data is not created in test class
public class ReportScreenControllerTest{

    static List<User> users = new List<User>();
    static Profile outboundProfile;
    static Profile rekeyProfile;
    static User outboundCoachUser;
    static User rekeyCoachUser;
    
    static UserRole outboundRole;
    static UserRole rekeyRole;    
    
    static List<Case> cases = new List<Case>();
    
    public static testMethod void runTest(){
        outboundProfile = [SELECT Id FROM Profile WHERE Name='Outbound Agent'];
        rekeyProfile = [SELECT Id FROM Profile WHERE Name='Rekey Agent'];
        
        //outboundRole = new UserRole(DeveloperName = 'Outbound_Coach', Name = 'Outbound Coach');
        //insert outboundRole;
        //rekeyRole = new UserRole(DeveloperName = 'Rekey_Coach', Name = 'Rekey Coach');
        //insert rekeyRole;
        
        outboundRole = [SELECT Id FROM UserRole WHERE DeveloperName = 'Outbound_Coach'];
        rekeyRole = [SELECT Id FROM UserRole WHERE DeveloperName = 'Rekey_Coach'];
        
        outboundCoachUser = new User(Alias = 'outc', UserRoleId = outboundRole.Id, Email='outboundcoach@testorg.com', EmailEncodingKey='UTF-8', LastName='Outbound', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = outboundProfile.Id, TimeZoneSidKey='America/Los_Angeles', UserName='outboundcoach@testorg.com', Location_And_Code__c = '126-Tampa');
        insert outboundCoachUser;
        rekeyCoachUser = new User(Alias = 'rekc', UserRoleId = rekeyRole.Id,  Email='rekeycoach@testorg.com', EmailEncodingKey='UTF-8', LastName='Rekey', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = rekeyProfile.Id, TimeZoneSidKey='America/Los_Angeles', UserName='rekeycoach@testorg.com', Location_And_Code__c = '126-Tampa');
        insert rekeyCoachUser;
        
        //createBasicData();
        
        system.runAs(outboundCoachUser){
            ReportScreenController ctrl = new ReportScreenController();
            ctrl.refresh();
        }
        
        system.runAs(rekeyCoachUser){
            ReportScreenController ctrl = new ReportScreenController();
            ctrl.refresh();
        } 
        
        ReportScreenController ctrl = new ReportScreenController();
        ctrl.refresh();            
    }

    /*
    private static void createBasicData(){
        createUsers();
        
        Account acc = new Account(Name='Test', OwnerId = outboundCoachUser.Id);
        insert acc;
        
        cases.add(new Case(AccountId = acc.Id, OwnerId = users.get(0).Id));
        cases.add(new Case(AccountId = acc.Id, OwnerId = users.get(1).Id));
        cases.add(new Case(AccountId = acc.Id, OwnerId = outboundCoachUser.Id));
        cases.add(new Case(AccountId = acc.Id, OwnerId = users.get(3).Id));
        cases.add(new Case(AccountId = acc.Id, OwnerId = rekeyCoachUser.Id));
        cases.add(new Case(AccountId = acc.Id, OwnerId = outboundCoachUser.Id));
        cases.add(new Case(AccountId = acc.Id, OwnerId = outboundCoachUser.Id));
        cases.add(new Case(AccountId = acc.Id, OwnerId = outboundCoachUser.Id));
        cases.add(new Case(AccountId = acc.Id, OwnerId = rekeyCoachUser.Id));
        cases.add(new Case(AccountId = acc.Id, OwnerId = rekeyCoachUser.Id));
        insert cases;
        
        cases.get(2).OwnerId = users.get(2).Id; //ownership assigned by admin
        cases.get(4).OwnerId = users.get(4).Id; //ownership assigned by admin
        cases.get(5).OwnerId = users.get(0).Id; 
        cases.get(6).OwnerId = users.get(1).Id;
        cases.get(7).OwnerId = users.get(2).Id;
        cases.get(8).OwnerId = users.get(3).Id;
        cases.get(9).OwnerId = users.get(4).Id;
        update cases;
        
        system.runAs(users.get(0)){
            List<Case> casesToUpdate = new List<Case>();
            //cases.get(5).OwnerId = users.get(0).Id; 
            cases.get(0).Rekey_Status__c = 'Manual Review';
            cases.get(5).Rekey_Status__c = 'Sale Complete';
            
            casesToUpdate.add(cases.get(0));
            casesToUpdate.add(cases.get(5));
            update casesToUpdate ;
        }
        system.runAs(users.get(1)){
            //cases.get(6).OwnerId = users.get(1).Id;
            update cases.get(6);        
        }
        system.runAs(users.get(2)){
            //cases.get(7).OwnerId = users.get(2).Id;
            update cases.get(7);      
        }
        system.runAs(users.get(3)){
            //cases.get(8).OwnerId = users.get(3).Id;
            update cases.get(8);      
        }        
        system.runAs(users.get(4)){
            //cases.get(9).OwnerId = users.get(4).Id;
            update cases.get(9);
        }                                                  
    }
    
    private static void createUsers(){
        users.add(new User(Alias = 'outu1', Email='outbounduser1@testorg.com', EmailEncodingKey='UTF-8', LastName='Outbound1', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = outboundProfile.Id, TimeZoneSidKey='America/Los_Angeles', UserName='outboundtest1@testorg.com'));
        users.add(new User(Alias = 'outu2', Email='outbounduser2@testorg.com', EmailEncodingKey='UTF-8', LastName='Outbound2', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = outboundProfile.Id, TimeZoneSidKey='America/Los_Angeles', UserName='outboundtest2@testorg.com'));
        users.add(new User(Alias = 'outu3', Email='outbounduser3@testorg.com', EmailEncodingKey='UTF-8', LastName='Outbound3', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = outboundProfile.Id, TimeZoneSidKey='America/Los_Angeles', UserName='outboundtest3@testorg.com'));
        users.add(new User(Alias = 'reku1', Email='rekeyuser1@testorg.com', EmailEncodingKey='UTF-8', LastName='Rekey1', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = rekeyProfile.Id, TimeZoneSidKey='America/Los_Angeles', UserName='rekeytest1@testorg.com'));
        users.add(new User(Alias = 'reku2', Email='rekeyuser2@testorg.com', EmailEncodingKey='UTF-8', LastName='Rekey2', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = rekeyProfile.Id, TimeZoneSidKey='America/Los_Angeles', UserName='rekeytest2@testorg.com'));
        insert users;    
    }
    */
}