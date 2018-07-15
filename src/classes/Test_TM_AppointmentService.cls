/**
 * TMobile Appointment Service Test Case
 * 
 * TMobile - Copyright 2018 All rights reserved.
 *
 * @company TMobile
 * @author Chris Matthews
 *
 */
@isTest
private class Test_TM_AppointmentService 
{
    static testMethod void testSenario1() 
    {
        TM_LeadService.TM_Store_Lead storeLead = new TM_LeadService.TM_Store_Lead();
        
        storeLead.storeId             =  '1000';
        storeLead.socialId            =  '1111';
        storeLead.socialNetwork       =  'facebook';
        storeLead.firstName           =  'Bubba';
        storeLead.lastName            =  'Gump';
        storeLead.email               =  'bubba@none.com';
        storeLead.phoneNumber         =  '555-555-1212';
        storeLead.timezone            =  'GMT';        
        
        TM_Result result;
        
        result = TM_LeadService.createLead( storeLead );        
         
        Lead lead = (Lead)result.valueObject;

        TM_AppointmentService appointmentService = new TM_AppointmentService();
        
        String timezone='Pacific';
        
        result = TM_AppointmentService.reserveStoreAppointment( lead.id,
                                                                storeLead.storeid, 
                                                                System.now(), 
                                                                System.now().addDays(1), 
                                                                timezone,
                                                               'Test appointment' );
                                                                 
        result = TM_Appointmentservice.getStoreAppointmentAvailabilityList( storeLead.storeid, 
                                                                            System.now().format('mm/dd/yyyy'),
                                                                            '7');  
                                                                            
        result = TM_Appointmentservice.getAppointmentByLeadId( lead.id );
        
        List<Event__x> appointmentList = (List<Event__x>)result.valueObject;
        
        if( appointmentList != null && appointmentList.size() > 0 )
        {                                                                
           result = TM_Appointmentservice.deleteAppointmentById( appointmentList[0].externalid );
        }
        
        TM_AppointmentService.workaround1();                                                       
        TM_AppointmentService.workaround2();                                                       
        TM_AppointmentService.workaround3();
        TM_AppointmentService.workaround4();
        TM_AppointmentService.workaround5();
        TM_AppointmentService.workaround6();
    }
}