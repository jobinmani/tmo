/**
 * TMobile Facebook Service Class
 * 
 * TMobile - Copyright 2018 All rights reserved.
 *
 * @company TMobile
 * @author Chris Matthews
 *
 */
public with sharing class TM_FacebookService 
{    
    public static final String FLAG_ACTION                              = 'action';

    public static final String FLAG_ZIP                                 = 'zip';

    public static final String FLAG_LONGITUDE                           = 'longitude';
    public static final String FLAG_LATITUDE                            = 'latitude';
    public static final String FLAG_RADIUS                              = 'radius';

    public static final String ACTION_STORE_LOCATION_BY_ZIP             = 'storelocationbyzip';
    public static final String ACTION_STORE_LOCATION_BY_RADIUS          = 'storelocationbyradius';
    
    public static final String ACTION_STORE_CREATE_LEAD                 = 'storecreatelead';

    public static final String ACTION_STORE_APPOINTMENT_AVAILABLE_LIST  = 'storeappointmentavailablelist';
    public static final String ACTION_STORE_APPOINTMENT_RESERVE         = 'storeappointmentreserve';
    
    public static final String ACTION_LEAD_APPOINTMENT_LIST             = 'leadappointmentlist';
    public static final String ACTION_LEAD_SOCIAL_ID_SEARCH             = 'leadsocialidsearch';
    public static final String ACTION_LEAD_NOTE                         = 'leadnote';

    public static final String ACTION_LEAD_APPOINTMENT_CANCEL           = 'leadappointmentcancel';

    private static final String DEFAULT_DATETIME_GMT_FORMAT             = 'yyyy-MM-dd\'T\'hh:mm:ssZ';
    private static final String DEFAULT_DATETIME_LOCAL_FORMAT           = 'yyyy-MM-dd\'T\'hh:mm:ss';
    
    public class TM_Request_Store
    {
        public String zip                         { set; get; }
        public String longitude                   { set; get; } 
        public String latitude                    { set; get; }                
        public String radius                      { set; get; }                
    }

    public class TM_Request_Store_Appointment_List
    {
        public String storeId                     { set; get; }
        public String requestDateTime             { set; get; } 
        public String numberOfDays                { set; get; }                
    }
    
    public class TM_Request_Store_Appointment_Reserve
    {
        public String storeId                     { set; get; }
        public String leadId                      { set; get; }
        public String appointmentDate             { set; get; }
        public String appointmentTime             { set; get; }
    }

    public class TM_Request_Lead_Appointment
    {
        public String leadId                      { set; get; }
    }

    public class TM_Request_Lead_Note
    {
        public String leadId                      { set; get; }
        public String title                       { set; get; }
        public String body                        { set; get; }
    }

    public class TM_Request_Lead_By_SocialProfile
    {
        public String socialId                    { set; get; }
        public String socialNetwork               { set; get; }
    }

    public class TM_Request_Lead_Appointment_Cancel
    {
        public String leadId                      { set; get; }
        public String appointmentId               { set; get; }
    }

    public class TM_Result_Store_List
    {
        public TM_Result               result     { set; get; }
        public List<TM_Globals.Store>  storeList  { set; get; }
        
        public TM_Result_Store_List()
        {
            result = new TM_Result();
        }
    }

    public class TM_Result_Store_Appointment_List
    {
        public TM_Result               result                    { set; get; }

        public List<TM_Globals.StoreAppointment> 
                                       appointmentList           { set; get; }
                             
        public TM_Result_Store_Appointment_List()
        {
            result = new TM_Result();
        }
    }
    
    public class TM_Result_Store_Lead
    {
        public TM_Result               result                    { set; get; }
        public String                  leadId                    { set; get; }
                             
        public TM_Result_Store_Lead()
        {
            result = new TM_Result();
        }
    }

    public class TM_Result_Lead_Appointment_List
    {
        public TM_Result                        result          { set; get; }
        public List<TM_Result_Lead_Appointment> appointmentList { set; get; }
                             
        public TM_Result_Lead_Appointment_List()
        {
            result = new TM_Result();
        }
    }
    
    public class TM_Result_Lead_Appointment
    {
        public String appointmentId                             { set; get; }        
        public String storeId                                   { set; get; }
        public String leadId                                    { set; get; }
        public String startdatetime                             { set; get; }
        public String enddatetime                               { set; get; }
    }
    
    public TM_FacebookService()
    {
    }
    
    // Process inbound messages from Facebook MOC middleware
    public static void processMessage()
    {
        // Fetch System properties/keys
        TMobile_Social_Settings__c socialSettings = TM_Util.getSocialSettings();

        String fbAccessToken; 
        
        // Pull request/response context
        RestRequest  request  = RestContext.request;
        RestResponse response = RestContext.response;       

        System.debug('POST REQUEST');
                
        if( request != null )
        {
            Map<String,String> paramMap = request.params;

            System.debug('PARMS: ' + paramMap );
            
            // Check if prod instance otherwise always sandbox
            if( TM_Util.isProdInstance() )
            {
                fbAccessToken = socialSettings.FB_Access_Token_Production__c;
            }
            else
            {
                fbAccessToken = socialSettings.FB_Access_Token_Sandbox__c;
            }

            // Check we have parms on request
            if( paramMap != null )
            {
                String action = paramMap.get( FLAG_ACTION );

                // Verify key and actions are specified
                if( !String.isEmpty( action ) )
                {
                    String jsonString;
                    TM_Result result = new TM_Result();
                    
                    // Fetch body of POST request
                    Blob body = request.requestBody;

                    action = action.tolowercase().trim();

                    jsonString = body.toString();

                    System.debug('JSON String: ' + jsonString );
                    
                    // Action - Locate a store by zip code
                    if( action.equals( ACTION_STORE_LOCATION_BY_ZIP ) )
                    {
                        System.debug( ACTION_STORE_LOCATION_BY_ZIP );
                     
                        TM_Request_Store inRequest = (TM_Request_Store)
                                 JSON.deserialize( jsonString, 
                                                   TM_Request_Store.class );
                        if( inRequest != null )
                        {
	                        // Future phase
	                        result = findStoreByPostalCode( inRequest.zip );
	                        
	                        if( result.returnCode == TM_Result.RESULT_NO_ERROR )
	                        {
	                            List<TM_Globals.Store> storeList = 
	                               (List<TM_Globals.Store>)result.valueObject;
	                               
	                            // Build Results
	                            TM_Result_Store_List rsl = new TM_Result_Store_List();
	                            rsl.storeList            = storeList;       
	
	                            jsonString               = JSON.serialize( rsl );
	                        }
	                        else
	                        {
	                            jsonString = JSON.serialize( result );
	                        }
                        }
                        else
                        {
                            jsonString = JSON.serialize( result );
                        }
                    }
                    // Action - Locate a store by radius search
                    // bugbug - the SQL Database needs to have Long/Lat fields updated on source
                    //          or we create a scheduler that goes through in salesforce and 
                    //          auto-updates empty long/lat fields from Mapquest/etc. 
                    else if( action.equals( ACTION_STORE_LOCATION_BY_RADIUS ) )
                    {
                        TM_Request_Store inRequest = (TM_Request_Store)
                                 JSON.deserialize( jsonString, 
                                                   TM_Request_Store.class );
                        if( inRequest != null )
                        {
	                        // Future phase
	                        result = findStoreByRadius( inRequest.longitude,
	                                                    inRequest.latitude,
	                                                    inRequest.radius );
	
	                        if( result.returnCode == TM_Result.RESULT_NO_ERROR )
	                        {
	                            List<TM_Globals.Store> storeList = 
	                              (List<TM_Globals.Store>)result.valueObject;
	
	                            // Build Results
	                            TM_Result_Store_List rsl = new TM_Result_Store_List();
	                            rsl.storeList            = storeList;       
	
	                            jsonString               = JSON.serialize( rsl );
	                        }
	                        else
	                        {
	                            jsonString = JSON.serialize( result );
	                        }
                        }
                        else
                        {
                            jsonString = JSON.serialize( result );
                        }
                    }
                    // Action to provide list of appointment slots based on store id
                    else if( action.equals( ACTION_STORE_APPOINTMENT_AVAILABLE_LIST ) )
                    {
                        TM_Request_Store_Appointment_List inRequest = (TM_Request_Store_Appointment_List)
                                 JSON.deserialize( jsonString, 
                                                   TM_Request_Store_Appointment_List.class );

                        if( inRequest != null )
                        {
                            result = findStoreAppointmentAvailability( inRequest.storeId,
                                                                       inRequest.requestDateTime,
                                                                       inRequest.numberOfDays );

                            if( result.returnCode == TM_Result.RESULT_NO_ERROR )
                            {
                                List<TM_Globals.StoreAppointment> appointmentList = 
                                       (List<TM_Globals.StoreAppointment>)result.valueObject;
                                
                                // Build Results
                                TM_Result_Store_Appointment_List rsal = new TM_Result_Store_Appointment_List();
                                rsal.appointmentList                  = appointmentList;       

                                jsonString = JSON.serialize( rsal );
                            }
                            else
                            {
                                jsonString = JSON.serialize( result );
                            }
                        }
                        else
                        {
                            result.returnCode = TM_Result.RESULT_ERROR_INPUT_DATA;       
                            result.errorList.add('No input criteria');

                            jsonString = JSON.serialize( result );
                        }
                    }
                    // Action to create a lead
                    else if( action.equals( ACTION_STORE_CREATE_LEAD ) )
                    {
                        TM_LeadService.TM_Store_Lead inLead = (TM_LeadService.TM_Store_Lead)
                                 JSON.deserialize( jsonString, 
                                                   TM_LeadService.TM_Store_Lead.class );
                        if( inLead != null )
                        {
                            result = TM_LeadService.createLead( inLead ); 

                            if( result.returnCode == TM_Result.RESULT_NO_ERROR )
                            {
                                Lead lead = (Lead)result.valueObject;

                                // Build Results
                                TM_Result_Store_Lead rsl = new TM_Result_Store_Lead();
                                rsl.leadId = lead.id;       

                                jsonString = JSON.serialize( rsl );
                            }
                            else
                            {
                                jsonString = JSON.serialize( result );
                            }
                        }
                        else
                        {
                            result.returnCode = TM_Result.RESULT_ERROR_INPUT_DATA;       
                            result.errorList.add('No input criteria');
                            jsonString = JSON.serialize( result );
                        }
                    }
                    // Action to reserve and appointment
                    else if( action.equals( ACTION_STORE_APPOINTMENT_RESERVE ) )
                    {
                        TM_Request_Store_Appointment_Reserve reserve = 
                                 (TM_Request_Store_Appointment_Reserve)
                                 JSON.deserialize( jsonString, 
                                                   TM_Request_Store_Appointment_Reserve.class );
                        if( reserve != null )
                        {
                            // Reserve Appointment Here
                            result = reserveStoreAppointment( reserve );
                            
                            if( result.returnCode == TM_Result.RESULT_NO_ERROR )
                            {
                                TM_Result_Lead_Appointment_List lal = 
                                          buildLeadAppointmentList( reserve.leadid  );

                                if( lal.result.returnCode == TM_Result.RESULT_NO_ERROR )
                                {
                                    // Set the lead to reserved 
                                    Lead lead = 
                                         TM_LeadService.getLeadById( reserve.leadId );
                                    
                                    if( lead != null )
                                    {
                                       // Update schedule lead indicator
                                       // bugbug - this is only here because B2B is not setting it. 
                                       // Real solution is B2B is the authoritative source for
                                       // the schedule and should update/clear the flag. The
                                       // connector syncs the changes back to B2B until all B2B
                                       // management code is moved back to B2C. This updating is 
                                       // a work around for this issue for now. The update has to 
                                       // happen in this location (last in chain) or DML Exception
                                       // will occur with web service callouts to B2B
                                       lead.is_event_Scheduled__c = true;
                                       lead.store_sap_id__c       = reserve.storeId;
                                       update lead;
                                    
                                       // Nothing to return except error                                
                                       jsonString = JSON.serialize( lal );
                                    }
                                    else
                                    {
                                       result.returnCode = TM_Result.RESULT_GENERAL_ERROR;       
                                       result.errorList.add('Lead not found to updated schedule info');
                                       jsonString = JSON.serialize( result );
                                    }
                                }
                                else
                                {
                                    result.returnCode = TM_Result.RESULT_NO_RESULTS_FOUND;       
                                    result.errorList.add('No schedules found');
                                    jsonString = JSON.serialize( result );
                                }
                            }
                            else
                            {
                                jsonString = JSON.serialize( result );
                            }
                        }
                        else
                        {
                            result.returnCode = TM_Result.RESULT_ERROR_INPUT_DATA;       
                            result.errorList.add('No input criteria');
                            jsonString = JSON.serialize( result );
                        }
                    }
                    // Action to return appointment list for a given lead
                    else if( action.equals( ACTION_LEAD_APPOINTMENT_LIST ) )
                    {
                        TM_Request_Lead_Appointment leadappointmentreq = 
                                 (TM_Request_Lead_Appointment)
                                 JSON.deserialize( jsonString, 
                                                   TM_Request_Lead_Appointment.class );
                                                   
                        if( leadappointmentreq != null )
                        {
                            TM_Result_Lead_Appointment_List lal = 
                                      buildLeadAppointmentList( leadappointmentreq.leadid  );

                            if( lal.result.returnCode == TM_Result.RESULT_NO_ERROR )
                            {
                                // Nothing to return except error                                
                                jsonString = JSON.serialize( lal );
                            }
                            else
                            {
                                jsonString = JSON.serialize( result );
                            }
                        }
                        else
                        {
                            result.returnCode = TM_Result.RESULT_ERROR_INPUT_DATA;       
                            result.errorList.add('No input criteria');
                            jsonString = JSON.serialize( result );
                        }
                    }
                    // Search for Lead ID by Social ID / Social Network
                    else if( action.equals( ACTION_LEAD_SOCIAL_ID_SEARCH ))
                    {
                        TM_Request_Lead_By_SocialProfile leadsocialreq = 
                                 (TM_Request_Lead_By_SocialProfile)
                                 JSON.deserialize( jsonString, 
                                                   TM_Request_Lead_By_SocialProfile.class );
                                                   
                        if( leadsocialreq != null )
                        {
                            // Find lead by social media id
                            Lead lead = TM_LeadService.findLeadBySocialId( leadsocialreq.socialid,
                                                                           leadsocialreq.socialnetwork );
                            if( lead != null )
                            {
                                // Build Results
                                TM_Result_Store_Lead rsl = new TM_Result_Store_Lead();
                                rsl.leadId = lead.id;       
                                
                                // Nothing to return except error                                
                                jsonString = JSON.serialize( rsl );
                            }
                            else
                            {
                                result.returnCode = TM_Result.RESULT_NO_RESULTS_FOUND;
                                jsonString = JSON.serialize( result );
                            }
                        }
                        else
                        {
                            result.returnCode = TM_Result.RESULT_ERROR_INPUT_DATA;       
                            result.errorList.add('No input criteria');
                            jsonString = JSON.serialize( result );
                        }
                    }
                    // Action to cancel an appointment for a lead
                    else if( action.equals( ACTION_LEAD_NOTE ) )
                    {
                        TM_Request_Lead_Note leadNote = 
                                 (TM_Request_Lead_Note)
                                 JSON.deserialize( jsonString, 
                                                   TM_Request_Lead_Note.class );
                                                   
                        if( leadNote != null )
                        {
                            result = 
                                TM_LeadService.createLeadNote( leadNote.leadId, 
                                                               leadNote.title,
                                                               leadNote.body );

                            jsonString = JSON.serialize( result );
                        }
                        else
                        {
                            result.returnCode = TM_Result.RESULT_ERROR_INPUT_DATA;       
                            result.errorList.add('Invalid input criteria');
                            jsonString = JSON.serialize( result );
                        }
                    }
                    // Action to cancel an appointment for a lead
                    else if( action.equals( ACTION_LEAD_APPOINTMENT_CANCEL ) )
                    {
                        TM_Request_Lead_Appointment_Cancel leadappointmentcancelreq = 
                                 (TM_Request_Lead_Appointment_Cancel)
                                 JSON.deserialize( jsonString, 
                                                   TM_Request_Lead_Appointment_Cancel.class );
                                                   
                        if( leadappointmentcancelreq != null )
                        {
                            result = 
                             TM_AppointmentService.deleteAppointmentById( leadappointmentcancelreq.appointmentId );

                            jsonString = JSON.serialize( result );
                        }
                        else
                        {
                            result.returnCode = TM_Result.RESULT_ERROR_INPUT_DATA;       
                            result.errorList.add('No input criteria');
                            jsonString = JSON.serialize( result );
                        }
                    }
           
                    // Return data
                    response.responseBody = Blob.valueOf( jsonString );
                }
                else
                {
                    response.statusCode = 400; // Access denied
                }
            }        

            // Return a '200 OK' response to all events
            response.statusCode = 200;
        }
    }

    private static TM_Result_Lead_Appointment_List buildLeadAppointmentList( String leadId  )
    {
        TM_Result_Lead_Appointment_List lal = new TM_Result_Lead_Appointment_List();

        // List appointment by lead
        TM_Result result = TM_AppointmentService.getAppointmentByLeadId( leadId );

        if( result.returnCode == TM_Result.RESULT_NO_ERROR )
        {
           List<TM_Result_Lead_Appointment> leadAppointmentList = 
                                            new List<TM_Result_Lead_Appointment>();
            
           System.debug('XXX Results' + result );
                                           
           List<Event__x> eventList = (List<Event__x>)result.valueObject;
                                
           for( Event__x event : eventList )
           {
               TM_Result_Lead_Appointment leadAppointment = 
                                          new TM_Result_Lead_Appointment();
                                    
               String startTime  = event.startdatetime__c.format(DEFAULT_DATETIME_LOCAL_FORMAT);
               String endTime    = event.enddatetime__c.format(DEFAULT_DATETIME_LOCAL_FORMAT);
               
               //System.debug('Start TIme: ' + startTime + ' EndTime: ' + endTime );
                                      
               leadAppointment.appointmentId = event.externalId;
               leadAppointment.storeId       = event.event_store_id_c__c;
               leadAppointment.leadId        = event.consumerlead_c__c;
               leadAppointment.startdatetime = startTime;
               leadAppointment.enddatetime   = endTime;
                                   
               leadAppointmentList.add( leadAppointment );
           }
 
           // Assign the appointment list
           lal.appointmentList = leadAppointmentList;
        }
        return( lal );
    }    
    
    // Wrapper method to convert B2B Connect dataset with Transient Class for 
    // future migration of B2B to B2C without changes to client
    private static List<TM_Globals.Store> convertStoreList( List<Store_c__x> xStoreList )
    {
        List<TM_Globals.Store> storeList = new List<TM_Globals.Store>();

        if( xStoreList != null && xStoreList.size() > 0 )
        {       
           storeList = new List<TM_Globals.Store>();

           // Build return resultset
           for( Store_c__x xStore : xStoreList )
           {
               TM_Globals.Store store = new TM_Globals.Store();
               
               store.name           = xStore.name__c;
               store.channel        = xStore.channel_c__c;
               store.type           = xStore.storetype_c__c;
               store.storeId        = xStore.plant_number_c__c;
               store.address        = xStore.address_c__c;
               store.city           = xStore.city_c__c;
               store.state          = xStore.state_c__c;
               store.postalCode     = xStore.zip_c__c;
               store.email          = xStore.storeemail_c__c;
               store.longitude      = xStore.geolocation_longitude_s__c;
               store.latitude       = xStore.geolocation_latitude_s__c;
               
               storeList.add( store );
           }
        }
        return( storeList );
    }

    // Find a Store from a Given Radius
    public static TM_Result findStoreByPostalCode( String zip )
    { 
        TM_Result result = new TM_Result();
        
        // Fetch Stores based on GPS Long/Lat and radius
        result = TM_GeoService.findStoreByZip( zip );

        if( result.returnCode == TM_Result.RESULT_NO_ERROR )
        {
           List<Store_c__x> xStoreList = 
                            (List<Store_c__x>)result.valueObject;

           List<TM_Globals.Store> storeList = convertStoreList(xStoreList);

           result.valueObject = storeList;
        }
        return( result );
    }

    // Find a Store from a Given Radius
    public static TM_Result findStoreByRadius( String longitude,
                                               String latitude,
                                               String radius )
    { 
        TM_Result result = new TM_Result();

        // Fetch Stores based on GPS Long/Lat and radius
        result = TM_GeoService.findStoreByRadius( longitude, latitude, radius );
        
        if( result.returnCode == TM_Result.RESULT_NO_ERROR )
        {
           List<Store_c__x> xStoreList = 
                            (List<Store_c__x>)result.valueObject;

           List<TM_Globals.Store> storeList = convertStoreList(xStoreList);

           result.valueObject = storeList;
        }
        return( result );
    }

    // Find a Store Appointment Slots
    public static TM_Result findStoreAppointmentAvailability( String storeNumber,
                                                              String requestDateTime,
                                                              String numberOfDays )
    {
        TM_Result result =   
             TM_AppointmentService.getStoreAppointmentAvailabilityList( storeNumber, 
                                                                        requestDateTime,
                                                                        numberOfDays );
        return( result );
    }

    // Reserve Store Appointment
    public static TM_Result reserveStoreAppointment( TM_Request_Store_Appointment_Reserve reserve )
    {
        TM_Result result = new TM_Result();
        
        Lead lead = TM_LeadService.getLeadById( reserve.leadId );
        if( lead != null )
        {
            String subject = 'Appointment: ';
            
            System.debug('Reserve Appointment Date: ' + reserve );
                        
            Date startDate = Date.parse(reserve.appointmentDate);
            Time startTime = Time.newInstance(Integer.valueOf(reserve.appointmentTime), 0,0,0 );            
            DateTime startDateTime = DateTime.newInstance( startDate, startTime );
            
            //startDateTime.addHours(tzOffset); // Adjust Timezone - Remove for future
            String timezoneName = lead.customer_time_zone__c;
            
            if( String.isEmpty( timezoneName ) )
                timezoneName = 'pacific';
            
            DateTime endDateTime   = startDateTime.addHours(1);

            System.debug('START Date time: ' + startDateTime );
            System.debug('END Date time: '   + endDateTime );
            
            // Call Webservice to Offically Reserve the Schedule
            result = TM_AppointmentService.reserveStoreAppointment( reserve.storeId,
                                                                    reserve.leadId,
                                                                    startDateTime,
                                                                    endDateTime,
                                                                    timezoneName,
                                                                    subject );
        }
        else
        {
            result.returnCode  = TM_Result.RESULT_ERROR_LEAD_NOT_FOUND;
            result.errorList.add('Lead not found in store');
        }
        return( result );
    }
}