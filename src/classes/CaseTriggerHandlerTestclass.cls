/* 
@Author:sirdik Marella 
Test class- CaseTriggerHandlerTestclass
Desc: Test class for CaseTriggerHandler
vesrion 1.0
Date :21 july 2016
*/

@isTest
private class CaseTriggerHandlerTestclass{
    
    static{
        
        
        
    }
    private static case caseObj;
    private static User userObj;
     
    private static void  createUser(){
        ID profileID=[select name,Id from Profile where name='Dedicated Inbound' limit 1].Id;
        userObj=new User(Alias = 'standt', Email='standarduser@testorg.com', 
                        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                        LocaleSidKey='en_US', ProfileId = profileID, 
                        TimeZoneSidKey='America/Los_Angeles', UserName='DedicatedInbound@testorg.com',Location_And_Code__c='USA-101');
        insert  userObj;        
    } 
    private static  void  createCaseData(){
        
        caseObj = new case(
                            TOM_Order_Number__c = '1234567890',
                            Status= 'open',
                            Subject='Test Subject',
                            Inbound_Order_status__c ='Sale: Customer called in',
                            Outbound_Status__c='No-Sale : Customer Called In',
                            Call_Disposition_Reason__c='Add A Line'
                            
                        );
        insert caseObj;
    }
    
    private static  void  updateCaseData(){
        
        //Case instCase=[select Outbound_Status__c,Call_despostion_reason__c,Call_Disposition_Reason__c from case where id =:caseObj.id ];
        caseObj.Inbound_Order_status__c='No Sale : Customer call in';
        caseObj.Outbound_Status__c='Duplicate Order';
        caseObj.ownerid=userObj.Id;
        update caseObj;
        
    }
    
   /* private static testmethod void CaseTriggerHandler() {
        
        
        for(User u :[select profile.name from user where profile.name='Dedicated Inbound']){


        case con = new case(
        TOM_Order_Number__c = '1234567890',
        Status= 'closed',
        Call_Disposition_Reason__c='test',
        Outbound_Status__c= 'test',
        call_despostion_reason__c ='test');



        // if (case c:trigger.new)
        //     {

        //  con.Outbound_Status__c=c.Inbound_Order_status__c;
        //con.  Call_Disposition_Reason__c=c.Call_despostion_reason__c ;
            
        //   }




        insert con;




    }*/
    
    private static TestMethod void myUnitTest(){
        Test.startTest();
        createUser();
        
        System.runAs(userObj) {
            
            createCaseData();
            system.assertnotEquals(caseObj.id,null);
            
        }
            Case instCase=[select Outbound_Status__c,Call_despostion_reason__c,Call_Disposition_Reason__c from case where id =:caseObj.id ];
            
            system.assertEquals(caseObj.Inbound_Order_status__c,instCase.Outbound_Status__c);
            system.assertEquals(instCase.Call_Disposition_Reason__c,null);
            updateCaseData();
            
            Case instCaseObj=[select Outbound_Status__c,Call_despostion_reason__c,Call_Disposition_Reason__c from case where id =:caseObj.id ];
            system.assertEquals(caseObj.Inbound_Order_status__c,instCaseObj.Outbound_Status__c);
            system.assertEquals(instCaseObj.Call_Disposition_Reason__c,null);
        Test.stopTest();
    }
   
    
}