@isTest(SeeAllData=true)
private class StoreAppointmentTest2 {
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
    
    @isTest static void testgetAvailableSlots() {

        final String storeId = '1212';
        final String Date1 = '2017-10-13';
        final String status = 'success';
        //list<Slots> Slots= new list<Slots>;
       // List<Object> resultList= List<Object>();
       //List<Object> acctList = new List<Object>(); 
        //List<String> my_list = new List<String>();
        
        Test.setMock(HttpCalloutMock.class, new StoreAppointmentMock.getStoreAppointments(storeId, Date1, status));
      
        Test.startTest();
        //Object obj = StoreAppointment.getAvailableSlots(storeId,Date1,status);
        StoreAppointment.getAvailableSlots(storeId,Date1,status);
        Test.stopTest();
             
        // Verify response received 
       // System.assertEquals('{error=null, managertimeZone=null, perDay=({availableDate=10/13/2017, slots=()}, {availableDate=10/14/2017, slots=(17, 18, 19, 20, 21, 23, 24)},{availableDate=10/15/2017, slots=()}, {availableDate=10/16/2017, slots=(17, 18, 19, 20, 21, 22, 23, 24)},{availableDate=10/17/2017, slots=(17, 18, 19, 20, 21, 22, 23, 24)}, {availableDate=10/18/2017, slots=(17, 18, 19, 20, 21, 22, 23, 24)},{availableDate=10/18/2017, slots=(17, 18, 19, 20, 21, 22, 23, 24)}),storeNumber=5914}', obj);
    }
    
    @isTest public static void createevent()
    {
        
        DateTime  StartDateTime = DateTime.newInstance(2017,10,07,17,00,00);
        DateTime  endDateTime = DateTime.newInstance(2017,10,07,18,00,00);
        //id LeadID = '00Q29000003fozaEAA';
          id LeadID = '00Q3600000c67aYEAQ';
        lead objLead = new Lead(Lastname='test',Firstname='mcnc',Company='t2',LeadSource='Concierge');
        insert objLead;
        String storeSAPId = '5914';
        String subject = '';
        Test.startTest();
        //Object store = StoreAppointment.getAvailableSlots(storeid,sdate,source);
        StoreAppointment.createEvent(objLead.Id,storeSAPId,StartDateTime,endDateTime,subject); 
        StoreAppointment.updateLead(objLead.Id,'5914');
        StoreAppointment.getLeadSource(objLead.Id); 
        StoreAppointment.getEventDetails(objLead.Id);                               
        Test.stopTest();
    }
    
    @isTest public static void getcover()
    {
    Test.startTest();
    StoreAppointment.Percentage();
    Test.stopTest();
    }
    
}