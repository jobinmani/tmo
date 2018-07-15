@isTest(SeeAllData=true)
private class CancelRescheduleAppointmentTest {
    static void setup() {
        List<B2BEndpoint__c> customSettings = new List<B2BEndpoint__c>();
        
        B2BEndpoint__c auth = new B2BEndpoint__c(Name='Authorization');
        auth.AuthTokenURL__c = 'authorization';
        auth.UserName__c = 'authorization';
        auth.Password__c = 'authorization';
        auth.clientId__c = 'authorization';
        auth.clientSecret__c = 'authorization';
        customSettings.add(auth);
 
        B2BEndpoint__c services = new B2BEndpoint__c(Name='Services');
        services.getStoreAppointments__c = 'getStoreAppointments';
        services.createStoreAppointment__c = 'createStoreAppointment';
        customSettings.add(services);
        
        update customSettings;
    }
    
    /*
    @isTest static void testgetAvailableSlots() {

        final String storeId = '1212';
        final String Date1 = '2017-10-13';
        final String status = 'success';
        
        Test.setMock(HttpCalloutMock.class, new StoreAppointmentMock.getStoreAppointments(storeId, Date1, status));
      
        Test.startTest();
        Object obj = StoreAppointment.getAvailableSlots(storeId,Date1,status);
        Test.stopTest();
             
        // Verify response received 
       // System.assertEquals('{error=null, managertimeZone=null, perDay=({availableDate=10/13/2017, slots=()}, {availableDate=10/14/2017, slots=(17, 18, 19, 20, 21, 23, 24)},{availableDate=10/15/2017, slots=()}, {availableDate=10/16/2017, slots=(17, 18, 19, 20, 21, 22, 23, 24)},{availableDate=10/17/2017, slots=(17, 18, 19, 20, 21, 22, 23, 24)}, {availableDate=10/18/2017, slots=(17, 18, 19, 20, 21, 22, 23, 24)},{availableDate=10/18/2017, slots=(17, 18, 19, 20, 21, 22, 23, 24)}),storeNumber=5914}', obj);
    }
    
    */
    /*@isTest static void getAppointmentDetails(){
    Test.StartTest();
        Lead Leadvar = new Lead();
        leadvar.LeadSource = 'Concierge';
        leadvar.FirstName = 'Firstname1';
        leadvar.LastName = 'LastName1';
        leadvar.Company = 'T-Mobile';
        insert leadvar;
        
        Event__x Eventvar = new Event__x();
        Eventvar.ExternalId='3e4uytyyt767676';
        Eventvar.StartDateTime__c=System.TODAY();
        Eventvar.EndDateTime__c = System.TODAY()+10;
        Eventvar.WhatId__c = 'rttrt45454e34r4';
        Eventvar.Store_Address_c__c='NewAddress';
        Eventvar.Event_Store_Id_c__c = '1212';
        Eventvar.ActivityDate__c = System.TODAY();
        Eventvar.ConsumerLead_c__c = leadvar.Id;
        Eventvar.Meeting_Status_c__c = 'Confirmed';
        Database.insertImmediate(Eventvar);
        
        Store_c__x Storevar = new Store_c__X();
        Storevar.Name__c = '1212StoreName';
        Storevar.ExternalId = 'rttrt45454e34r4';
        Database.insertImmediate(Storevar);
        
        CancelRescheduleAppointment.getAppointmentDetails(leadvar.Id);
        Test.StopTest();
       
    }*/
    
    @isTest public static void getcover()
    {
    Test.startTest();
    CancelRescheduleAppointment.Percentage();
    Test.stopTest();
    }
    
    
}