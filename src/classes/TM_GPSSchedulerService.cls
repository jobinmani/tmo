/**
 * TMobile GPS Scheduler Service.
 *
 * This class resolves GPS coordinates across various objects
 * on a scheduled basis
 * 
 * TMobile - Copyright 2018 All rights reserved.
 *
 * @company TMobile
 * @author Chris Matthews
 *
 */
global with sharing class TM_GPSSchedulerService implements Schedulable 
{
   public TM_GPSSchedulerService()
   {
   }

   public TM_GPSSchedulerService(ApexPages.StandardController controller)
   {   
   }
    
   global void execute(SchedulableContext SC)
   {
       TM_GPSSchedulerService.runGPSLoader();
   }    

   public PageReference testScheduler()
   {
       TM_GPSSchedulerService.runGPSLoader();
       
       return(null);
   }   
  
   @future (callout=true)
   public static void runGPSLoader()
   {
       // Resolve Accounts
       List<TM_GeoService.GPSItem> gpsItemList = new List<TM_GeoService.GPSItem>();
       
       List<Store_c__x> storeList = TM_GeoService.findStoresMissingGPSData();

       // Build list to populate
       for( Store_c__x store : storeList )
       {
           // Only validate stores with addresses
           if( String.isNotEmpty( store.address_c__c ) && 
               String.isNotEmpty( store.city_c__c ) &&
               String.isNotEmpty( store.state_c__c ) )
           {
              TM_GeoService.GPSItem gpsItem = new TM_GeoService.GPSItem();
           
              gpsItem.objectid = store.id;
              gpsItem.street   = store.address_c__c;
              gpsItem.city     = store.city_c__c;
              gpsItem.state    = store.state_c__c;
              //gpsItem.country  = store.country_c__c;

              gpsItemList.add( gpsItem );
           }
       }
       
       TM_Result result = TM_GeoService.getGPSData( gpsItemList );
       
       if( result.returnCode == TM_Result.RESULT_NO_ERROR )
       {
           gpsItemList = (List<TM_GeoService.GPSItem>)result.valueObject;

	       if( gpsItemList != null )
	       {
               System.debug('ItemList 2: ' + gpsItemList );

	           List<Store_c__x> storeUpdateList = new List<Store_c__x>();
	           
	           for( TM_GeoService.GPSItem gpsItem : gpsItemList )
	           {
                   Store_c__x store = new Store_c__x();
                   
                   store.id         = gpsItem.objectid;

	               if( String.isNotEmpty( gpsItem.latitude ) && String.isNotEmpty( gpsItem.longitude ) )
	               {
                       store.geolocation_latitude_s__c       = Decimal.valueof( gpsItem.latitude );
                       store.geolocation_longitude_s__c      = Decimal.valueof( gpsItem.longitude ); 
                       store.geolocation_error__c            = gpsItem.errorMsg;                  
	               }
	               else
	               {
                       store.geolocation_error__c            = gpsItem.errorMsg;                  
	               }
                   storeUpdateList.add( store );
	           }
	           
	           if( storeUpdateList.size() > 0 )
	               database.updateImmediate(storeUpdateList);
	               
	           System.debug('Update: ' + storeUpdateList ); 
	       }
       }
   }
}