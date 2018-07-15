@isTest
private class UserTrigger_Test{
    public static testMethod void UserTrigger () {
    
    
Profile testProfile = [SELECT Id 
                           FROM profile
                           WHERE Name = 'System Administrator' 
                           LIMIT 1];

    User testUser = new User(LastName = 'test user 1', 
                             Username = 'test.user.1@example.com', 
                             Email = 'test.1@example.com', 
                             Alias = 'testu1', 
                             Location_And_Code__c='126-Tampa',
                             TimeZoneSidKey = 'America/Los_Angeles', 
                             LocaleSidKey = 'en_GB', 
                             EmailEncodingKey = 'ISO-8859-1', 
                             ProfileId = testProfile.Id, 
                             LanguageLocaleKey = 'en_US'); 
                             
                             insert testuser;
        }
    }