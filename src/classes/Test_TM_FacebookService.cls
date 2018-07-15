/**
 * TMobile Facebook Service Test Case
 * 
 * TMobile - Copyright 2018 All rights reserved.
 *
 * @company TMobile
 * @author Chris Matthews
 *
 */
@isTest
private class Test_TM_FacebookService 
{
    static String fbAccesstoken = '123232132132312321313';
    
    static void setup() 
    {
        TM_FacebookService facebookService        = new TM_FacebookService();
        TMobile_Social_Settings__c socialSettings = TM_Util.getSocialSettings();
        
        socialSettings.FB_Access_Token_Sandbox__c    = fbAccessToken;
        socialSettings.FB_Access_Token_Production__c = fbAccessToken;

        upsert socialSettings;
        
        // Setup fake service calls        
        RestRequest  request       = new RestRequest();
        RestResponse response      = new RestResponse();
        
        RestContext.request        = request;    
        RestContext.response       = response;      
        
        request.addHeader('Content-Type', 'application/json'); 
    }    

    static testMethod void testSenario1() 
    {
        setup();
        
        String jsonString = '';
        
        // Create Lead
        RestContext.request.params.put( TM_FacebookService.FLAG_ACTION,     TM_FacebookService.ACTION_STORE_LOCATION_BY_ZIP );

        jsonString = '{"zip":"92122"}';
        
        RestContext.request.requestBody = Blob.valueOf( jsonString );
        
        TM_FacebookService.processMessage();

        System.debug('Response: Code : ' + RestContext.response.statusCode + 
                   '\n          Body : ' + RestContext.response.responseBody );
    }

    static testMethod void testSenario2() 
    {
        setup();
        
        String jsonString = '';
        
        // Create Lead
        RestContext.request.params.put( TM_FacebookService.FLAG_ACTION,     TM_FacebookService.ACTION_STORE_LOCATION_BY_RADIUS );

        jsonString = '{"longitude":"50.7374","latitude":"7.0982","radius":"3"}';
        
        RestContext.request.requestBody = Blob.valueOf( jsonString );
        
        TM_FacebookService.processMessage();

        System.debug('Response: Code : ' + RestContext.response.statusCode + 
                   '\n          Body : ' + RestContext.response.responseBody );
    }

    
    static testMethod void testSenario3() 
    {
        setup();
        
        String jsonString = '';
        
        // Create Lead
        RestContext.request.params.put( TM_FacebookService.FLAG_ACTION,     TM_FacebookService.ACTION_STORE_CREATE_LEAD );
        
        jsonString = '{"storeId":"1212",' +
                     ' "socialId":"111111",' +
                     ' "socialNetwork":"facebook", ' +
                     ' "firstName":"Bubba", ' +
                     ' "lastName":"Gump", ' +
                     ' "email":"bubba1@none.com", ' +
                     ' "phone":"4235555555"}';
        
        RestContext.request.requestBody = Blob.valueOf( jsonString );
        
        TM_FacebookService.processMessage();

        System.debug('Response: Code : ' + RestContext.response.statusCode + 
                   '\n          Body : ' + RestContext.response.responseBody );
    }

    static testMethod void testSenario4() 
    {
        setup();
        
        String jsonString = '';
        
        // Create Lead
        RestContext.request.params.put( TM_FacebookService.FLAG_ACTION,     
                                        TM_FacebookService.ACTION_STORE_APPOINTMENT_AVAILABLE_LIST );
        
        jsonString = '{"storeId":"1212",'+
                     ' "requestDateTime":"2017-12-15",' +
                     ' "numberOfDays":"7" }';
        
        RestContext.request.requestBody = Blob.valueOf( jsonString );
        
        TM_FacebookService.processMessage();
        
        System.debug('Response: Code : ' + RestContext.response.statusCode + 
                   '\n          Body : ' + RestContext.response.responseBody );
    }

    static testMethod void testSenario5() 
    {
        setup();
        
        String jsonString = '';
        
        // Create Lead
        RestContext.request.params.put( TM_FacebookService.FLAG_ACTION,     
                                        TM_FacebookService.ACTION_STORE_APPOINTMENT_RESERVE );
        
        
        TM_LeadService.TM_Store_Lead slLead = new TM_LeadService.TM_Store_Lead();
        slLead.firstname  = 'Bubba';
        slLead.lastname   = 'Gump';
        slLead.email      = 'bgump@none.com';
        
        TM_Result result = TM_LeadService.createLead( slLead );
        Lead lead = (Lead)result.valueObject;
        
        jsonString = '{ "storeId":"1212",' + 
                     '  "leadId":"' + lead.id + '",' +
                     '  "appointmentDate":"12/15/2017",'+
                     '  "appointmentTime":"10" }';
        
        RestContext.request.requestBody = Blob.valueOf( jsonString );
        
        TM_FacebookService.processMessage();
        
        System.debug('Response: Code : ' + RestContext.response.statusCode + 
                   '\n          Body : ' + RestContext.response.responseBody );
    }

    static testMethod void testSenario6() 
    {
        setup();
        
        String jsonString = '';
        
        // Create Lead
        RestContext.request.params.put( TM_FacebookService.FLAG_ACTION,     
                                        TM_FacebookService.ACTION_LEAD_APPOINTMENT_LIST );
        
        TM_LeadService.TM_Store_Lead slLead = new TM_LeadService.TM_Store_Lead();
        slLead.firstname  = 'Bubba';
        slLead.lastname   = 'Gump';
        slLead.email      = 'bgump@none.com';
        
        TM_Result result = TM_LeadService.createLead( slLead );
        Lead lead = (Lead)result.valueObject;
        
        jsonString = '{"leadId":"' + lead.id + '"}';
        
        RestContext.request.requestBody = Blob.valueOf( jsonString );
        
        TM_FacebookService.processMessage();
        
        System.debug('Response: Code : ' + RestContext.response.statusCode + 
                   '\n          Body : ' + RestContext.response.responseBody );
    }

    static testMethod void testSenario7() 
    {
        setup();
        
        String jsonString = '';
        
        // Create Lead
        RestContext.request.params.put( TM_FacebookService.FLAG_ACTION,     
                                        TM_FacebookService.ACTION_LEAD_SOCIAL_ID_SEARCH );
        
        String SOCIAL_ID = '2222222222';
        
        TM_LeadService.TM_Store_Lead slLead = new TM_LeadService.TM_Store_Lead();
        slLead.firstname     = 'Bubba';
        slLead.lastname      = 'Gump';
        slLead.email         = 'bgump@none.com';
        slLead.socialId      = SOCIAL_ID;
        slLead.socialNetwork = 'facebook';
        
        TM_Result result = TM_LeadService.createLead( slLead );
        Lead lead = (Lead)result.valueObject;
        
        jsonString = '{"socialId":"' + SOCIAL_ID + '","socialNetwork":"facebook"}';
        
        RestContext.request.requestBody = Blob.valueOf( jsonString );
        
        TM_FacebookService.processMessage();
        
        System.debug('Response: Code : ' + RestContext.response.statusCode + 
                   '\n          Body : ' + RestContext.response.responseBody );
    }

    static testMethod void testSenario8() 
    {
        setup();
        
        String jsonString = '';
        
        // Create Lead
        RestContext.request.params.put( TM_FacebookService.FLAG_ACTION,     
                                        TM_FacebookService.ACTION_LEAD_APPOINTMENT_CANCEL );
        
        TM_LeadService.TM_Store_Lead slLead = new TM_LeadService.TM_Store_Lead();
        slLead.firstname  = 'Bubba';
        slLead.lastname   = 'Gump';
        slLead.email      = 'bgump@none.com';
        
        TM_Result result = TM_LeadService.createLead( slLead );
        Lead lead = (Lead)result.valueObject;
        
        jsonString = '{"leadId":"' + lead.id + '","appointmentId":"00QW0000005UJwSMAW"}';
        
        RestContext.request.requestBody = Blob.valueOf( jsonString );
        
        TM_FacebookService.processMessage();
        
        System.debug('Response: Code : ' + RestContext.response.statusCode + 
                   '\n          Body : ' + RestContext.response.responseBody );
    }

}