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
private class Test_TM_Globals 
{
    static testMethod void testSenario1() 
    {
        TM_Globals instance = new TM_Globals();
        
        TM_Globals.Store store = new TM_Globals.Store();
        
        store.name            = 'test';
        store.storeId         = '1111';
        store.address         = '123 Any Street';
        store.city            = 'Seattle';
        store.state           = 'Washington';
        store.postalCode      = '555555';
        store.email           = 'none@none.com';
        store.longitude       =  123232323;
        store.latitude        =  123213233;

        TM_Globals.StoreAppointment storeAppointment = new TM_Globals.StoreAppointment();
        
        storeAppointment.storeId         = '1111';
        storeAppointment.appointmentDate = '11/11/2017';
        storeAppointment.appointmentTime = '10:00:00';
    }    
}