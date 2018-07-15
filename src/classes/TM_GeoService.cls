/**
 * TMobile Geo Location Service
 * 
 * TMobile - Copyright 2018 All rights reserved.
 *
 * @company TMobile
 * @author Chris Matthews
 *
 */
public with sharing class TM_GeoService 
{
    public class GPSItem
    {
        public String objectId            { set; get; }
        public String street              { set; get; }
        public String city                { set; get; }
        public String state               { set; get; }
        public String country             { set; get; }
        public String longitude           { set; get; }
        public String latitude            { set; get; }
        public String errorMsg            { set; get; }
        
        public GPSItem()
        {
        }
    }
    
    // GPS Cod Service Structures
    private class GIOCodeHeader
    {
        public List<GIOCodeResult>     results            { set; get; }
    }
    
    private class GIOCodeResult
    {
        public String                  query              { set; get; }
        public GIOCodeResponse         response           { set; get; }
    }
    
    public class GIOCodeResponse
    {
        public GIOCodeInput            input              { set; get; }
        public List<GIOResponseResult> results            { set; get; }
    }
    
    public class GIOCodeInput
    {
        public Map<String,String>      address_components { set; get; }
        public String                  formatted_address  { set; get; }
    }
    
    public class GIOResponseResult
    {
        public Map<String,String>      address_components { set; get; }
        public String                  formatted_address  { set; get; }
        public GIOLocation             location           { set; get; }
        public String                  accuracy           { set; get; }
        public String                  accuracy_type      { set; get; }
        public String                  source             { set; get; }
    }
    
    public class GIOLocation
    {
        public String                  lat                { set; get; }
        public String                  lng                { set; get; }
    }
        
    // Search for stores by zip code from B2B
    public static TM_Result findStoreByZip( String zip )
    {
        TM_Result result = new TM_Result();

        List<Store_c__x> storeList = new List<Store_c__x>();
        
        try
        {
	           storeList = 
	                       [ 
	                           select externalId, 
	                                  name__c,
	                                  storename_c__c,
	                                  plant_number_c__c,
	                                  address_c__c,
	                                  city_c__c,
	                                  state_c__c,
	                                  zip_c__c,
	                                  phone_c__c,
	                                  region_c__c,
	                                  district_c__c,
	                                  storeemail_c__c,
	                                  channel_c__c,
	                                  storetype_c__c,
	                                  geolocation_latitude_s__c,
	                                  geolocation_longitude_s__c,
                                      geolocation_error__c
                                      
	                           from Store_c__x
	                           where zip_c__c = :zip
	                           limit 100
	                       ];
	        
	        System.debug('STORE LIST: ' + storeList.size() );

            result.valueObject = storeList;   

            /*	        
	        for( Store_c__x store : storeList )
	        {
	            System.debug('\n' + 
	                         'ExternalID   : ' + store.externalId  + '\n' +
	                         'Name         : ' + store.name__c     + '\n' +
	                         'Plant #/SAP# : ' + store.plant_number_c__c + '\n' +
	                         'Address      : ' + store.address_c__c + '\n' +
	                         'City         : ' + store.city_c__c   + '\n' + 
	                         'State        : ' + store.state_c__c + '\n' +
	                         'Postal Code  : ' + store.zip_c__c + '\n' +
	                         'Phone        : ' + store.phone_c__c + '\n' +
	                         'District     : ' + store.district_c__c + '\n' +
	                         'Region       : ' + store.region_c__c + '\n' +
	                         'Email        : ' + store.storeemail_c__c + '\n' +
	                         'Latitude     : ' + store.geolocation_latitude_s__c + '\n' +
	                         'Longitude    : ' + store.geolocation_longitude_s__c + '\n\n' );
	        }
	        */
        }
        catch( Exception e )
        {
            result.returnCode = TM_Result.RESULT_GENERAL_ERROR;
            result.errorList.add('Exception: ' + e );                

            System.debug('Exception: ' + e );
        }
        return( result );
    }    

    // Search for stores by long/lat from B2B
    // bugbug.. long/lat are empty and need to be populated in SQL Database
    //          or update B2B to auto-populate in Salesforce from Mapquest/etc
    public static TM_Result findStoreByRadius( String longitude, 
                                               String latitude, 
                                               String radiusInMiles )
    {
        TM_Result result = new TM_Result();

        List<Store_c__x> storeList = new List<Store_c__x>();

        try
        {
            if( String.isNotEmpty( longitude ) && 
                String.isNotEmpty( latitude )  &&
                String.isNotEmpty( radiusInMiles ) )
            {
                Double MILE_CONST  = .0144927536231884; // Approx 1 mile calc of 1 degree 1/69th
                
                Double xLat     = Double.valueOf( latitude  ); 
                Double xLong    = Double.valueOf( longitude ); 
                Double radius   = Double.valueOf( radiusInMiles );
            
                if( radius == 0 )
                    radius = 2;
                    
                Double rangeCalc = radius * MILE_CONST;
            
                Double minLat   = xLat  - rangeCalc;
                Double maxLat   = xLat  + rangeCalc;
                Double minLong  = xLong - rangeCalc;
                Double maxLong  = xLong + rangeCalc;
	
	            System.debug('GPS Checking Point: \n' + 
	                         '            MinLat  [' + minLat    + '] Lat  [' + xLat + '] MaxLat [' + maxLat + ']\n' +
                             '            MinLong [' + minLong   + '] Long [' + xLong + '] MaxLong [' + maxLong + ']\n' +
                             '            Range   [' + rangeCalc + ']\n');
		        storeList = 
		                       [ 
		                           select externalId, 
		                                  name__c,
		                                  storename_c__c,
		                                  plant_number_c__c,
		                                  address_c__c,
		                                  city_c__c,
		                                  state_c__c,
		                                  zip_c__c,
		                                  phone_c__c,
		                                  region_c__c,
		                                  district_c__c,
		                                  storeemail_c__c,
	                                      channel_c__c,
	                                      storetype_c__c,
		                                  geolocation_latitude_s__c,
		                                  geolocation_longitude_s__c,
		                                  geolocation_error__c
		                                  
		                           from Store_c__x
		                           where  geolocation_latitude_s__c  >= :minLat  and
		                                  geolocation_latitude_s__c  <= :maxLat  and
		                                  geolocation_longitude_s__c >= :minLong and
		                                  geolocation_longitude_s__c <= :maxLong 
		                          
		                           limit 50
		                       ];
		        
		        System.debug('STORE LIST: ' + storeList.size() );

                result.valueObject = storeList;   
		        
		        /*
		        for( Store_c__x store : storeList )
		        {
		            System.debug('\n' + 
		                         'ExternalID   : ' + store.externalId  + '\n' +
		                         'Name         : ' + store.name__c     + '\n' +
		                         'Plant #/SAP# : ' + store.plant_number_c__c + '\n' +
		                         'Address      : ' + store.address_c__c + '\n' +
		                         'City         : ' + store.city_c__c   + '\n' + 
		                         'State        : ' + store.state_c__c + '\n' +
		                         'Postal Code  : ' + store.zip_c__c + '\n' +
		                         'Phone        : ' + store.phone_c__c + '\n' +
		                         'District     : ' + store.district_c__c + '\n' +
		                         'Region       : ' + store.region_c__c + '\n' +
		                         'Email        : ' + store.storeemail_c__c + '\n' +
		                         'Latitude     : ' + store.geolocation_latitude_s__c + '\n' +
		                         'Longitude    : ' + store.geolocation_longitude_s__c + '\n\n' );
		        }
		        */
            }
            else
            {
                result.returnCode = TM_Result.RESULT_GENERAL_ERROR;
                result.errorList.add('Long/Lat or Radius Not Specified' );                
            }
        }
        catch( Exception e )
        {
            result.returnCode = TM_Result.RESULT_GENERAL_ERROR;
            result.errorList.add('Exception: ' + e );                

            System.debug('Exception: ' + e );
        }
        return( result );
    }    
    
    public static TM_Result getGPSData( List<GPSItem> itemList )
    {
        TM_Result result = new TM_Result();

        TMobile_Social_Settings__c socialSettings = TM_Util.getSocialSettings();
        
        String GEO_CODE_API_KEY = socialSettings.TM_Geo_Key__c;
        String GEO_CODE_REQUEST = socialSettings.TM_Geo_Url__c + '?api_key=' + GEO_CODE_API_KEY;
                
        List<String> addressList = new List<String>();
        
        for( GPSItem item : itemList )
        {
            String address = '';
            
            address = TM_Util.check( item.street ) + ', ' +
                      TM_Util.check( item.city ) + ', ' +
                      TM_Util.check( item.state ) + ', ' + 
                      TM_Util.check( item.country );
            
            addressList.add( address );
        }
        
        String jsonString = JSON.serializePretty( addressList );
        
        try
        {
            System.debug('GPS Item Size: ' + itemList.size() );
            
	        HttpResponse response = TM_Util.sendJSON( GEO_CODE_REQUEST, null, jsonString );

            if( response != null )
            {
               String responseBody = response.getBody(); 
        
               // Check Success
               if( response.getStatusCode() == 200 )
               {
                  GIOCodeHeader geo = (GIOCodeHeader)
                               JSON.deserialize( responseBody, 
                                                 GIOCodeHeader.class );
                  if( geo != null )
                  {
                     Integer i=0;  
                     
                     System.debug('GPS Row Count: ' + geo.results.size() );
                     
                     for( GIOCodeResult r : geo.results )
                     {
                         if( r.response.results        != null && 
                             r.response.results.size() > 0 )
                         {
	                         GIOResponseResult responseResult = r.response.results[0];

	                         String street1 = itemList[i].street;
	                         String street2 = responseResult.address_components.get('number');
		
	                         if( String.isNotEmpty( street2 ) && 
	                             street1.startsWith( street2 ) )
	                         {
	                            if( responseResult.location != null )
	                            {
	                                itemList[i].latitude  = responseResult.location.lat;
	                                itemList[i].longitude = responseResult.location.lng;
	                            }
	                         }
	                         else
	                         {
                                String foundAddress = responseResult.formatted_address;

                                //System.debug('ERROR: MISMATCH: \n' + 
                                //             '       ORG ADDRESS : ' + itemList[i].street + '\n' +
                                //             '       GPS STREET  : ' + foundAddress + '\n' );

                                itemList[i].latitude  = responseResult.location.lat;
                                itemList[i].longitude = responseResult.location.lng;
                                itemList[i].errorMsg  = 'MISMATCH: ' +  foundAddress;
	                         }
                         }
                         else
                         {
                             //System.debug('ERROR: NOT FOUND: ' + itemList[i].street );
                             itemList[i].errorMsg = 'NOT FOUND';
                         }
                         i++;
                     }
                     
                     result.valueObject = itemList;
                  }
               }
               else
               {
                   // May have hit FREE daily limits
                   
                   // Error condition
                   // System.debug('ERROR: ' + responseBody );
                   result.errorList.add( responseBody );
               }
            }
            else
            {
                 result.returnCode = TM_Result.RESULT_GENERAL_ERROR;       
                 result.errorList.add('Error fetching GEO Service, try again later');
            }
        }
        catch( Exception e )
        {
            System.debug('Exception occured: ' + e + '\n' + e.getStackTraceString() );
        }
        return( result );       
    }

    public static List<Store_c__x> findStoresMissingGPSData()
    {
        List<Store_c__x> storeList = new List<Store_c__x>();
        
        try
        {
            storeList = 
                           [ 
                               select externalId, 
                                      name__c,
                                      storename_c__c,
                                      plant_number_c__c,
                                      address_c__c,
                                      city_c__c,
                                      state_c__c,
                                      zip_c__c,
                                      phone_c__c,
                                      region_c__c,
                                      district_c__c,
                                      storeemail_c__c,
                                      geolocation_latitude_s__c,
                                      geolocation_longitude_s__c,
                                      geolocation_error__c

                               from Store_c__x
                               where ( geolocation_latitude_s__c  = null or
                                       geolocation_longitude_s__c = null ) and
                                       address_c__c != null and 
                                       address_c__c != ''   and
                                       city_c__c    != null and 
                                       city_c__c    != ''   and
                                       state_c__c   != null and 
                                       state_c__c   != ''   and
                                     ( geolocation_error__c = null or
                                       geolocation_error__c = '' )
                                     
                               limit 1000
                           ];
            
            System.debug('STORE LIST: ' + storeList );
        }
        catch( Exception e )
        {
            System.debug('Exception: ' + e );
        }
        return( storeList );
    }
}