/**
 * TMobile Util Test Case
 * 
 * TMobile - Copyright 2018 All rights reserved.
 *
 * @company TMobile
 * @author Chris Matthews
 *
 */
@isTest
private class Test_TM_Util 
{
    static testMethod void testSenario1() 
    {
        TM_Util instance = new TM_Util();
        
        TMobile_Social_Settings__c socialSettings = TM_Util.getSocialSettings();
        Boolean                    isProduction   = TM_Util.isProdInstance();
        HttpResponse               response       = TM_Util.sendJSON('http://login.salesforce.com',
                                                                     '2323232',
                                                                     'test');
    }    
}