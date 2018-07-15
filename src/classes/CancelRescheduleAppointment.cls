global with Sharing class CancelRescheduleAppointment 
{
  
    public class deserializeResponse
    {
      public String id;
      public String access_token;
    }
   
        
// To fetch active/confirmed appointment    
@AuraEnabled
 Public static List<GetAppointment> getAppointmentDetails(String lead)
 
// Public static List<Event__x> getAppointmentDetails(String lead)
 {
  //Event__x e = [Select StartDateTime__c,EndDateTime__c,WhatId__c,Store_Address_c__c from Event__x where ConsumerLead_c__c =:lead and Meeting_Status_c__c='Confirmed' limit 1];
 Event__x e = [Select ExternalId,StartDateTime__c,EndDateTime__c,WhatId__c,Store_Address_c__c,Event_Store_Id_c__c,ActivityDate__c from Event__x where ConsumerLead_c__c =:lead  and Meeting_Status_c__c='Confirmed' limit 1];
   System.debug(e);
   
   Store_c__X s = [Select Name__c from Store_c__x where ExternalId =:e.WhatId__c limit 1];
   System.debug(s);
    
    DateTime StartDateTime;
    DateTime EndDateTime;
    String StoreName;
    String StoreAddress; 
    Date Appointmentdate;
    String Storeid;
    String externalid; 
    
   List<GetAppointment> result = new List<GetAppointment>();

   StartDateTime = e.StartDateTime__c;
   EndDateTime = e.EndDateTime__c;
   StoreName = s.Name__c;
   StoreAddress = e.Store_Address_c__c;
   Appointmentdate = e.ActivityDate__c;
   Storeid = e.Event_Store_Id_c__c;
   externalid = e.ExternalId;
   
   result.add(new GetAppointment(StartDateTime,EndDateTime,StoreName,StoreAddress,Appointmentdate,Storeid,externalid));   
    System.debug(result);
    return result;
 
// return [Select ExternalId,StartDateTime__c,EndDateTime__c,WhatId__c,Store_Address_c__c,Event_Store_Id_c__c,ActivityDate__c from Event__x where ConsumerLead_c__c =:lead  and Meeting_Status_c__c='Confirmed' limit 1];
 }
 //End of logic to feth active/confirmed Retail Appointment
 
// Logic for Cancel Retail Appointment
    
    @AuraEnabled
    public Static String cancelAppointment(String eventId, Id leadId)
    {           
       Lead objLead1 = [Select id,Lastname,firstname from Lead where ID=:leadId];
       String subject =  'Cancelled - Consumer Appointment with ('+''+objLead1.firstname+''+objLead1.Lastname+')';
        //Event__x extEvent = new Event__x(ExternalId = eventId);
        Event__x extEvent = [select id,StartDateTime__c,EndDateTime__c,Event_Store_Id_c__c,ConsumerLead_c__c,Store_Address_c__c,WhatId__c from Event__x where ExternalId =:eventId];
      
      /*String storeaddress = extEvent.Store_Address_c__c;
      System.debug(storeaddress);
        Store_Appointment__c s = new Store_Appointment__c();
        s.Store_Address__c = storeaddress ;
       // s.Store_Name__c = extEvent.WhatId__c;
        //s.Store_SAP_ID__c = extEvent.Event_Store_Id_c__c ;
        //StartDateTime__c = extEvent.StartDateTime__c,
        //EndDateTime__c = extEvent.EndDateTime__c        
        insert s;*/
        if(!test.isRunningTest())
        {
        Database.deleteImmediate(extEvent);
        }
        
        system.debug('leadId---'+leadId);
        //Lead objLead = new Lead(Id =leadId, Is_Event_Scheduled__c =false);
        Lead objLead = new Lead(Id =leadId, Is_Event_Scheduled__c =false, Is_Call_Type_Skiped__c=true, Is_Event_Scheduled_skipped__c=true);
        update objLead;
        return 'Appointment Cancelled Successfully';
        
    }
    
    //Update the Is Event Scheduled flag to False when appointment is cancelled
        @AuraEnabled
    public static Lead updateLead(Id leadId)
    {
        
        Lead objLead = new Lead(Id =leadId, Is_Event_Scheduled__c =false, Is_Call_Type_Skiped__c=true, Is_Event_Scheduled_skipped__c=true);
        update objLead;
        return objLead; 
     }
     
    //End of logic for cancel Retail Appointment
    
    //Begin of logic for Reschedule appointment
    @AuraEnabled
    public Static String rescheduleAppointment(String eventId, Id leadId)
    {
    // cancel Appointment
    /*Lead objLead2 = [Select id,Lastname,firstname from Lead where ID=:leadId];
       String subject =  'Cancelled - Consumer Appointment with ('+''+objLead2.firstname+''+objLead2.Lastname+')';
        /*Event__x extEvent = new Event__x(ExternalId = eventId,Meeting_Status_c__c ='Cancelled',Subject__c = subject);

        //Event__x extEvent = new Event__x(ExternalId = eventId,Meeting_Status_c__c ='Unconfirmed');
        //Database.updateImmediate(extEvent);
        Event__x extEvent = [select id,StartDateTime__c,EndDateTime__c,Event_Store_Id_c__c,ConsumerLead_c__c,Store_Address_c__c,WhatId__c from Event__x where ExternalId =:eventId];
        Database.deleteImmediate(extEvent);
        system.debug('leadId---'+leadId);
        Lead objLead = new Lead(Id =leadId, Is_Event_Scheduled__c =false);
        update objLead;

        //update is event scheduled flag
        Lead objLead1 = new Lead(Id =leadId, Is_Event_Scheduled__c =false, Is_Call_Type_Skiped__c=true, Is_Event_Scheduled_skipped__c=true);
        update objLead1;*/
     //End of logic for reschedule appointment
     return 'Appointment Reschedule Successful';
     }
   /*  public class eventWrapper{
        public String Subject{get;set;}
        public DateTime StartDateTime{get;set;}
        public DateTime endDateTime{get;set;}
        }*/
    
    //wrapper class for result list
    public Class GetAppointment
    {
    @AuraEnabled Public DateTime StartDateTime {get; set; }
    @AuraEnabled Public DateTime EndDateTime {get; set; }
    @AuraEnabled Public String StoreName {get; set; }
    @AuraEnabled Public String StoreAddress {get; set; }
    @AuraEnabled public Date Appointmentdate {get; set; } 
    @AuraEnabled public String Storeid {get; set; }
    @AuraEnabled Public String externalid {get; set; }
    
    Public GetAppointment (DateTime StartDateTime, DateTime EndDateTime, String StoreName, String StoreAddress, Date Appointmentdate, String Storeid, String externalid)
    {
    this.StartDateTime = StartDateTime;
    this.EndDateTIme = EndDateTIme;
    this.StoreName = StoreName;
    this.StoreAddress = StoreAddress;
    this.Appointmentdate = Appointmentdate;
    this.Storeid = Storeid;
    this.externalid = externalid;
    }
    
    public GetAppointment(){}
    }
    
// Call Rest Webservice and get available slots for appointment
@AuraEnabled
 //@future(callout=true)
   public static Object getAvailableSlots (String Store_SAP_ID, String reqDate,String Source)
   {
     //CancelRescheduleAppointment app = new CancelRescheduleAppointment();
      String accessToken;
      Object Slots;
     // accessToken = app.ReturnAccessToken (app);
      
       if(!test.isRunningTest()){
            B2BAuthentication b2b = new B2BAuthentication();
            accessToken = b2b.Authenticate();
        } else {
            accessToken = 'test';
        }
        
        B2BEndpoint__c b2bServices = B2BEndpoint__c.getValues('Services'); // added now 11/8
      if(accessToken != null)
      {
        
         Http h2 = new Http();
         HttpRequest req1 = new HttpRequest();
         req1.setHeader('Authorization','Bearer ' + accessToken);
         req1.setHeader('Content-Type','application/json');
         req1.setHeader('accept','application/json');
         //Convert date reqDate format from "2017-08-17" to 'M/dd/YYYY'
         Date d = date.valueOf(reqDate);

         String dt = DateTime.newInstance(d.year(),d.month(),d.day()).format('M/d/YYYY');
        
         reqDate = dt;
         //JSON Generator
         JSONGenerator gen=JSON.createGenerator(true);
         System.debug(Store_SAP_ID);
         gen.writeStartObject();
         gen.writeStringField('storeSAPId',Store_SAP_ID);
         gen.writeStringField('reqDate',reqDate);
         gen.writeStringField('source',' ');
         gen.writeEndObject();
         System.debug('getAsString:'+gen.getAsString());
         req1.setBody(gen.getASString());
         //req1.setBody('{"storeSAPId" : "5914","reqDate" : "08/17/2017","source"  : ""}');
         req1.setMethod('POST');
         if(accessToken != null)
        {
         //req1.setEndpoint('https://t-mobile--fullsbx.cs23.my.salesforce.com/services/apexrest/getStoreAppointments');//commented now 11/8
         req1.setEndpoint(b2bServices.getStoreAppointments__c);//added now 11/8
         HttpResponse res1 = h2.send(req1);
         
//to get all day wise slots
         String params = (String)JSON.deserializeUntyped(res1.getBody()); 
         Map<String, Object> tmpResult = (Map<String, Object>) JSON.deserializeUntyped(params);
         

// Get slots of date provided in input
List<Object> resultList = (List<Object>)(tmpResult.get('perDay'));
Integer count;
count = resultList.size();
System.debug(count);
Object AvailabilityDate;
for(integer i=0; i<count; i++)
{    
Map<String, Object> test3 = (Map<String, Object>)resultList[i];   
    
    AvailabilityDate = test3.get('availableDate');
    //System.debug(AvailabilityDate);
    System.debug(LoggingLevel.Info, AvailabilityDate); //  9/1/2017 value from B2b

   // System.debug(reqDate);
     System.debug(LoggingLevel.Info, reqDate); //  9/01/2017 value on UI
    if(AvailabilityDate == reqDate)  
    { 
    Slots = test3.get('slots');   
    }   
}         }           
         }
         return Slots;
      } 
//Begin of code added to schedule appointment
 // Call Rest Webservice and create event
@AuraEnabled
   public Static Object createEvent(Id recordId,String storeSapId, DateTime StartDateTime, DateTime endDateTime, String subject)
   {
       // String eventBody ='{"Subject":"'+subject+'", "StartDateTime":"'+StartDateTime+'","EndDateTime":"'+endDateTime+'"}';
        Object eventdetails;
     // CancelRescheduleAppointment app = new CancelRescheduleAppointment();
      String accessToken;
    //  accessToken = app.ReturnAccessToken (app);
    
     if(!test.isRunningTest()){
            B2BAuthentication b2b = new B2BAuthentication();
            accessToken = b2b.Authenticate();
        } else {
            accessToken = 'test';
        }
     
      B2BEndpoint__c b2bServices = B2BEndpoint__c.getValues('Services');// added now 11/8
      
       if(recordId !=null){
           Lead objLead = [Select id,Lastname,firstname from Lead Where ID =: recordId];
           subject = subject+' '+objLead.firstname+' '+objLead.Lastname+')';
       }
       
        if(accessToken != null)
        {
            Http h2 = new Http();
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization','Bearer ' + accessToken);
            req1.setHeader('Content-Type','application/json');
            req1.setHeader('accept','application/json');
            System.debug(recordId);
            System.debug(storeSapId);
            System.debug(StartDateTime);
            System.debug(endDateTime);
            System.debug(subject);
            JSONGenerator gen=JSON.createGenerator(true);
              gen.writeStartObject();
               gen.writeStringField('LeadID',recordId);
               gen.writeDateTimeField('StartDateTime',StartDateTime);
               gen.writeDateTimeField('EndDateTime' ,endDateTime);
               gen.writeStringField('subject', subject);
              // gen.writeDateField('appointmentdate',appointmentdate);
               gen.writeEndObject();
              String eventBody = gen.getASString();
               
            JSONGenerator gen1=JSON.createGenerator(true);
             gen1.writeStartObject(); 
             gen1.writeStringField('storeSAPId',storeSapId);
             gen1.writeStringField('eventBody',eventBody);
             gen1.writeEndObject();
             System.debug('getAsString:'+gen1.getAsString());
             req1.setBody(gen1.getASString());
            
            req1.setMethod('POST');
           // req1.setEndpoint('https://t-mobile--fullsbx.cs23.my.salesforce.com/services/apexrest/createStoreEvent');//commented now 11/8
           req1.setEndpoint(b2bServices.createStoreAppointment__c);//added now 11/8
            system.debug('req--'+req1);
            HttpResponse res1 = h2.send(req1);
            /*
                 //create event on lead
                String sObjName = recordId.getSObjectType().getDescribe().getName();
                Event e = new Event();                  
                if(sObjName == 'Lead' || sObjName == 'Contact')
                e.WhoId=recordId;  //Lead or Contact            
                e.Subject = subject;            
                e.StartDateTime=StartDateTime;
                e.EndDateTime=endDateTime;
                insert e;  */
                system.debug('body==='+res1.getBody());
                eventdetails = res1.getBody();

         }
         system.debug('eventdetails==='+eventdetails);
         //Email validation checkbox - deepthi       
         //If(eventdetails == 'Appointment Succesfully Created'){
         
             
//         }
                
         //return res1.getBody();
         return eventdetails;
      }//End of code added to schedule appointment  
    
    @AuraEnabled
    public static Lead updateLead(Id leadId, String storeSapId)
    {
        system.debug('leadId---'+leadId+' storeSapId----'+storeSapId);
        Lead objLead = new Lead(Id =leadId, Is_Event_Scheduled__c =true , Store_SAP_ID__c = storeSapId,Is_Call_Type_Skiped__c=true, Is_Event_Scheduled_skipped__c=true);
        update objLead;
        System.debug('ISEVENTFLAG========'+objLead);
        return objLead; 
     }
    //Begin of code to get store details      
    /*@AuraEnabled
    public static Store_c__x getStoreDetails(String Store_SAP_ID)
    {
        return [Select Name__c,Address_c__c,Plant_Number_c__c from Store_c__x where Plant_Number_c__c =:Store_SAP_ID and StoreEligible_For_Appointments_c__c= true limit 1];     
    }*/
    
     @AuraEnabled
    public static List<Store_c__x> getStoreDetails(String Store_SAP_ID)
    {
        return [Select Name__c,Full_Address_c__c,Plant_Number_c__c from Store_c__x where Plant_Number_c__c =:Store_SAP_ID and StoreEligible_For_Appointments_c__c= true limit 1];     
    }
    
//End of code to get store details
//Begin of code to get Event Details
@AuraEnabled
 Public static Boolean getEventDetails(String lead)
 {
   return [Select Is_Event_Scheduled__c from Lead where id =:lead limit 1].Is_Event_Scheduled__c;
 }
 
  
 @AuraEnabled
 Public static List<Lead> getLeadSource(String lead)
 {
   return [Select Is_Event_Scheduled__c,LeadSource from Lead where id =:lead limit 1];
 }
 
//End of code to get Event Details
@AuraEnabled
    public Static String cancelAppointmentreschedule(String eventId, Id leadId)
    {           
       Lead objLead1 = [Select id,Lastname,firstname from Lead where ID=:leadId];
       String subject =  'Cancelled - Consumer Appointment with ('+''+objLead1.firstname+''+objLead1.Lastname+')';
        //Event__x extEvent = new Event__x(ExternalId = eventId);
        Event__x extEvent = [select id,StartDateTime__c,EndDateTime__c,Event_Store_Id_c__c,ConsumerLead_c__c,Store_Address_c__c,WhatId__c from Event__x where ExternalId =:eventId];      
       if(!test.isRunningTest())
       {
        Database.deleteImmediate(extEvent); 
               }
        return 'Appointment Cancelled Successfully';
        
    }
   
    
}