/**
 * TMobile Lead Service Test Case
 * 
 * TMobile - Copyright 2018 All rights reserved.
 *
 * @company TMobile
 * @author Chris Matthews
 *
 */
@isTest
private class Test_TM_LeadService 
{
    static testMethod void testSenario1() 
    {
        TM_LeadService leadService = new TM_LeadService();
        
        TM_LeadService.TM_Store_Lead storeLead = new TM_LeadService.TM_Store_Lead();
        
        storeLead.storeId             =  '1000';
        storeLead.socialId            =  '1111';
        storeLead.socialNetwork       =  'facebook';
        storeLead.firstName           =  'Bubba';
        storeLead.lastName            =  'Gump';
        storeLead.email               =  'bubba@none.com';
        storeLead.phoneNumber         =  '555-555-1212';
        storeLead.timezone            =  'GMT';        
        
        TM_Result result = TM_LeadService.createLead( storeLead );
        
        Lead lead = (Lead)result.valueObject;
        
        lead = TM_LeadService.getLeadById( lead.id );
        lead = TM_LeadService.findLeadByEmail( storeLead.email );
        lead = TM_LeadService.findLeadBySocialId( storeLead.socialId, storeLead.socialNetwork );
    }    
}