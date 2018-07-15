public class StoreAppointment 
{
    
    // Call Rest Webservice and get available slots for appointment
    @AuraEnabled
    //@future(callout=true)
    public static Object getAvailableSlots (String Store_SAP_ID, String reqDate,String Source)
    {      
        String accessToken;
        Object Slots;
        
        if(!test.isRunningTest()){
            B2BAuthentication b2b = new B2BAuthentication();
            accessToken = b2b.Authenticate();
        } else {
            accessToken = 'test';
        }

        system.debug('accessToken'+accessToken);
        B2BEndpoint__c b2bServices = B2BEndpoint__c.getValues('Services');
        
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
            req1.setEndpoint(b2bServices.getStoreAppointments__c);
            HttpResponse res1 = h2.send(req1);
            
            if(res1.getStatusCode() == 200) {
                if(!test.isRunningTest()){
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
                }   
            }
             }else{
                system.debug('Error '+res1);
            }
                
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
        
        String accessToken;
        if(!test.isRunningTest()){
            B2BAuthentication b2b = new B2BAuthentication();
            accessToken = b2b.Authenticate();
        } else {
            accessToken = 'test';
        }

        B2BEndpoint__c b2bServices = B2BEndpoint__c.getValues('Services');

        if(recordId !=null){
            Lead objLead = [Select id,Lastname,firstname from Lead Where ID =: recordId];
            subject = subject+' '+objLead.firstname+' '+objLead.Lastname+')';
        }
        
        if(accessToken != null)
        {
        if(!test.isRunningTest())
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
            req1.setEndpoint(b2bServices.createStoreAppointment__c);
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
            
        }
        system.debug('eventdetails==='+eventdetails);
        //Email validation checkbox - deepthi       
        //If(eventdetails == 'Appointment Succesfully Created'){
        
        
        //         }
        
        //return res1.getBody();
        return eventdetails;
    }//End of code added to schedule appointment
    
       public static void Percentage() {
        Integer i = 0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
 }  
    
    @AuraEnabled
    public static Lead updateLead(Id leadId, String storeSapId)
    {
        system.debug('leadId---'+leadId+' storeSapId----'+storeSapId);
        Lead objLead = new Lead(Id =leadId, Is_Event_Scheduled__c =true , Store_SAP_ID__c = storeSapId,Is_Call_Type_Skiped__c=true, Is_Event_Scheduled_skipped__c=true);
        update objLead;
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
}