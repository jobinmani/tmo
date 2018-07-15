/**
 * TMobile Lead Service Class
 * 
 * TMobile - Copyright 2018 All rights reserved.
 *
 * @company TMobile
 * @author Chris Matthews
 *
 */
public without sharing class TM_LeadService 
{
    // Transient Store Lead
    public class TM_Store_Lead
    {
        public String storeId                     { set; get; }
        public String socialId                    { set; get; }  
        public String socialNetwork               { set; get; }      
        public String socialProfilePicURL         { set; get; }
        public String firstName                   { set; get; }
        public String lastName                    { set; get; }
        public String email                       { set; get; }
        public String phoneNumber                 { set; get; }
        public String phoneColor                  { set; get; }
        public String phoneMake                   { set; get; }
        public String phoneModel                  { set; get; }
        public String phoneType                   { set; get; }
        public String phoneOS                     { set; get; }
        public String gender                      { set; get; }
        public String locale                      { set; get; }
        public String timezone                    { set; get; }
        public String notes                       { set; get; }
        public String updateRecord                { set; get; }
    }
    
    public TM_LeadService()
    {
    }

    // Create a Lead in Salesforce
    public static TM_Result createLead( TM_Store_Lead slLead )
    {
        TM_Result result = new TM_Result();
        Lead lead        = null;
        
        // Find by email 1st
        lead = findLeadByEmail( slLead.email );

        // Find by social Id 2nd
        if( lead == null )
            lead = findLeadBySocialId( slLead.socialId, slLead.socialNetwork );
        
        // Find by phone 3rd
        if( lead == null )
            lead = findLeadByPhone( slLead.firstname, slLead.lastname, slLead.phoneNumber );
        
        // Not found, create new lead
        if( lead == null )
        {
            lead = new Lead();
            
            String queueName = 'Concierge_Finished_queue';
            
            Group queue = [ 
                            select id from group 
                            where type = 'queue' AND developername = :queueName 
                          ];
            
            if( queue != null )
            {            
               lead.company                       = 'T-Mobile';
               lead.store_sap_id__c               = slLead.storeId;
               lead.firstname                     = slLead.firstName;
               lead.lastname                      = slLead.lastName;
               lead.email                         = slLead.email;
               lead.social_media_facebook_id__c   = slLead.socialId;
               //lead.leadsource                    = slLead.socialNetwork;
               lead.channel__c                    = slLead.socialNetwork;
               
               if( String.isNotEmpty( slLead.phoneNumber ) )
                   lead.phone                     = slLead.phoneNumber;

               lead.leadsource                    = 'Concierge';
               lead.status                        = 'Open';
               lead.disposition__c                = 'Referred to Retail'; 
               //lead.call_type__c                  = 'Inbound Call'; 
               
               lead.device__c                     = slLead.phoneMake + ' | ' + 
                                                    slLead.phoneModel + ' | ' + 
                                                    slLead.phoneType + ' | ' + ' | ' +
                                                    slLead.phoneOS + ' | ' + 
                                                    slLead.phoneColor;
               
               lead.device_family__c              = slLead.phoneMake;   
               lead.language_preference__c        = slLead.locale;                                
               lead.ownerid                       = queue.id;
               
               String timezone                    = 'pacific';
               
               // Map Numeric Offset to Timezone Name
               if( String.isNotEmpty( slLead.timezone ) )
                   timezone = TM_AppointmentService.offsetToTz.get( slLead.timezone );
               
               System.debug('Mapped Timezone ' + timezone );
               
               lead.customer_time_zone__c         = timezone;
            
               lead.description                   = 'Phone Color:' + slLead.phoneColor + '\n' +
                                                    'Phone Make:' + slLead.phoneMake + '\n' +
                                                    'Phone Model:' + slLead.phoneModel + '\n' +
                                                    'Phone Type:' + slLead.phoneType + '\n' +
                                                    'Phone OS:'+ slLead.phoneOS + '\n' +
                                                    'Gender:' + slLead.gender + '\n' +
                                                    'Locale:' + slLead.locale +' \n' +
                                                    'Timezone:' + slLead.timezone + '\n' + 
                                                    'Profile Pic URL:' + slLead.socialProfilePicURL + '\n' +
                                                    'Notes:' + slLead.notes + '\n';
            
               insert lead;
               
               System.debug('Lead Inserted: ' + lead );
            }
            else
            {
                result.returnCode = TM_Result.RESULT_GENERAL_ERROR;
                result.errorList.add('Queue not found [' + queueName + ']' );                
            }
        }
        else
        {
            //
            // update data
            //
            if( slLead.updateRecord == 'true' )
            {
                if( String.isNotEmpty( slLead.email ))
                    lead.email = slLead.email;
                    
                if( String.isNotEmpty( slLead.phoneNumber ))
                    lead.phone = slLead.phoneNumber;

                if( String.isNotEmpty( slLead.socialId ))
                    lead.social_media_facebook_id__c = slLead.socialId;

                if( String.isNotEmpty( slLead.socialNetwork ))
                    lead.channel__c = slLead.socialNetwork;
            }
            else
            {
                // Update social info in case old lead
                if( String.isEmpty( slLead.socialId ))
                    lead.social_media_facebook_id__c = slLead.socialId;

                if( String.isEmpty( slLead.socialNetwork ))
                    lead.channel__c = slLead.socialNetwork;
                    
                if( String.isNotEmpty( slLead.timezone ) &&
                    String.isEmpty( lead.customer_time_zone__c ) )
                    lead.customer_time_zone__c = TM_AppointmentService.offsetToTz.get( slLead.timezone );
            }
            update lead;
        }
        
        result.valueObject = lead;
        
        return( result );
    }
    
    // Create a Note on Lead
    public static TM_Result createLeadNote( String leadId, 
                                            String title,
                                            String body )
    {
        TM_Result result = new TM_Result();
        Lead lead        = null;
        
        System.debug('Lead Note' + leadId + ' Title:' + title + ' body:' + body );
        
        try
        {
	        if( String.isNotEmpty( leadId ) &&
	            String.isNotEmpty( title )  &&
	            String.isNotEmpty( body ) )
	        {
                // Create Note
                ContentNote cnote           = new ContentNote();
                cnote.title                 = title;
                cnote.content               = Blob.valueOf(body.escapeHTML4());
                    
                insert cnote;    

                System.debug('NOTE ' + cnote );
                    
                if( cnote.id != null )
                {
                    // Associate Note to Lead
                    ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
                    
                    contentDocumentLink.linkedEntityId    = leadId;
                    contentDocumentLink.contentDocumentId = cnote.id;
                    contentDocumentLink.shareType         = 'V';
                    contentDocumentLink.visibility        = 'AllUsers';            
                    
                    insert contentDocumentLink;
                }
                else
                {
                    System.debug('Could not create lead note');
                }
	        }
        }
        catch( Exception e )
        {
            result.returnCode = TM_Result.RESULT_GENERAL_ERROR;       
            result.errorList.add('Exception:' + e );
        }
        return( result );
    }

    // Find a lead by an ID
    public static Lead getLeadById( String leadId )
    {
        Lead lead = null;
        
        try
        {
            lead = [ 
                      select id,
                             name,
                             firstname,
                             lastname,
                             store_sap_id__c,
                             social_media_facebook_id__c,
                             channel__c,
                             device__c,
                             device_family__c,
                             language_preference__c,
                             is_event_Scheduled__c,
                             customer_time_zone__c
                      from Lead
                      where id =: leadId
                   ]; 
        }
        catch( Exception e )
        {
            System.debug('Lead query:' + e );
        }
        return( lead );
    }   
    
    // Find a lead by an email
    public static Lead findLeadByEmail( String emailAddress )
    {
        Lead lead = null;

        System.debug('findLeadByEmail');
        
        try
        {
            lead = [ 
                      select id,
                             name,
                             firstname,
                             lastname,
                             phone,
                             email,
                             store_sap_id__c,
                             social_media_facebook_id__c,
                             channel__c,
                             device__c,
                             device_family__c,
                             language_preference__c,
                             is_event_Scheduled__c,
                             customer_time_zone__c
                      from Lead
                      where email         =: emailAddress
                      limit 1
                   ]; 
        }
        catch( Exception e )
        {
            System.debug('LeadByEmail query:' + e );
        }
        return( lead );
    }     

    // Find a lead by phone number
    public static Lead findLeadByPhone( String firstname, String lastname, String phone )
    {
        Lead lead = null;

        System.debug('findLeadByPhone');
        
        try
        {
            lead = [ 
                      select id,
                             name,
                             firstname,
                             lastname,
                             phone,
                             email,
                             store_sap_id__c,
                             social_media_facebook_id__c,
                             channel__c,
                             device__c,
                             device_family__c,
                             language_preference__c,
                             is_event_Scheduled__c,
                             customer_time_zone__c
                      from Lead
                      where phone         =: phone 
                      and firstname       =: firstname
                      and lastname        =: lastname
                      limit 1
                   ]; 
        }
        catch( Exception e )
        {
            System.debug('LeadbyPhone query:' + e );
        }
        return( lead );
    }     

    // Find a lead by it's social ID
    public static Lead findLeadBySocialId( String socialId, String socialNetwork )
    {
        Lead lead = null;
        
        System.debug('findLeadBySocialId');
        
        try
        {
            lead = [ 
                      select id,
                             name,
                             firstname,
                             lastname,
                             phone,
                             email,
                             store_sap_id__c,
                             is_event_Scheduled__c,
                             social_media_facebook_id__c,
                             channel__c,
                             device__c,
                             device_family__c,
                             language_preference__c,
                             customer_time_zone__c
                      from Lead
                      where social_media_facebook_id__c =: socialId
                      and channel__c like :socialNetwork
                      limit 1
                   ]; 
        }
        catch( Exception e )
        {
            System.debug('LeadBySocialId query:' + e );
        }
        return( lead );
    }     
}