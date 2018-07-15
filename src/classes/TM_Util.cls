/**
 * TMobile Utility Service Class
 * 
 * TMobile - Copyright 2018 All rights reserved.
 *
 * @company TMobile
 * @author Chris Matthews
 *
 */
public with sharing class TM_Util 
{
    private final static String PROD_ORG_ID = '00D36000000rhGR';
    
    // Get Social Settings for Facebook/Twitter/etc
    public static TMobile_Social_Settings__c getSocialSettings()
    {
        TMobile_Social_Settings__c socialSettings =  
                                TMobile_Social_Settings__c.getInstance('Default');
                                
        // Auto-Create default settings if not instantiated
        if( socialSettings == null )
        {
           socialSettings = new TMobile_Social_Settings__c(Name = 'Default');
           insert socialSettings;
        }
        return( socialSettings );
    }
    
    // Check if Salesforce Instance is Production
    public static Boolean isProdInstance()
    {
        Boolean isProductionInstance = false;
        
        String orgId = UserInfo.getOrganizationId();
        
        if( orgId.contains( PROD_ORG_ID ) )
        {
            isProductionInstance = true;
        }
        return( isProductionInstance );
    }
    
    public static HttpResponse sendJSON( String url,
                                         String accessToken, 
                                         String body )
    {
        HttpResponse response = new HttpResponse();
        
        if( !String.isEmpty( url ) )
        {
           Http http = new Http();
        
           HttpRequest request = new HttpRequest();

           if( String.isNotEmpty( accessToken ) )
               request.setHeader('Authorization','Bearer ' + accessToken );
 
           request.setHeader('Content-Type','application/json');
           request.setHeader('accept','application/json');
           request.setMethod('POST');
           request.setTimeout(50000);
           request.setEndpoint( url );

           if( !String.isEmpty(body) )
               request.setBody( body );
           else
               request.setBody('');
            
           if(!Test.isRunningTest())
           {
              System.debug('\n\nREQUEST: ' + request );
              System.debug('BODY: ' + request.getBody() + '\n\n');
               
              response = http.send( request );
           }
        }
        return( response );
    }
    
    public static String check( String value )
    {
        String returnValue = '';
        if( String.isNotEmpty( value ) )
            returnValue = value;
        
        return( returnValue );
    }
    
    public static void log( String message )
    {
        // work around for sites debug issue
        //Log__c log = new Log__c();
        //log.message__c = message;
        //insert log;
    }
}