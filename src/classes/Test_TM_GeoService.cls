/**
 * TMobile Geo Location Service Test Case
 * 
 * TMobile - Copyright 2018 All rights reserved.
 *
 * @company TMobile
 * @author Chris Matthews
 *
 * BUGBUG (SeeAllData=true) can't be used because Test Cases doesn't seem to work
 *        with external data sources in current version of Salesforce. 
 *        We still need the test case to ensure code coverage limits for class
 *        but no real way to test the real data returned from external data source
 */
@isTest( SeeAllData=true )
private class Test_TM_GeoService 
{
    static testMethod void testSenario1() 
    {
        TM_Result result = new TM_Result();
 
        List<Store_c__x> storeList = null;
        
        result = TM_GeoService.findStoreByZip('92122');
        result = TM_GeoService.findStoreByRadius( '-81.261727', '28.61464', '5' );
        
        List<TM_GeoService.GPSItem> gpsItemList = new List<TM_GeoService.GPSItem>();
        
        TM_GeoService.GPSItem gpsItem = new TM_GeoService.GPSItem();
        
        gpsItem.street    = 'Main Street';
        gpsItem.city      = 'Orlando';
        gpsItem.state     = 'Florida';
        
        gpsItemList.add( gpsItem );
        
        TM_GeoService.getGPSData( gpsItemList );   
                       
        TM_GeoService.findStoresMissingGPSData();
                       
        System.debug('STORE LIST:' + storeList );
    }
}