@isTest
public class StoreAppointmentMock implements HttpCalloutMock {

    public HttpResponse respond(HttpRequest req) {
        return null;
    }
    
    public class SingleRequestMock implements HttpCalloutMock {
        protected Integer code;
        protected String status;
        protected String bodyAsString;
        protected Blob bodyAsBlob;
        protected Map<String, String> responseHeaders;
        
        public SingleRequestMock(Integer code, String status, String body,
                                 Map<String, String> responseHeaders) {
                                     this.code = code;
                                     this.status = status;
                                     this.bodyAsString = body;
                                     this.bodyAsBlob = null;
                                     this.responseHeaders = responseHeaders;
                                 }
        
        public SingleRequestMock(Integer code, String status, Blob body,
                                 Map<String, String> responseHeaders) {
                                     this.code = code;
                                     this.status = status;
                                     this.bodyAsBlob = body;
                                     this.bodyAsString = null;
                                     this.responseHeaders = responseHeaders;
                                 }
        
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse resp = new HttpResponse();
            resp.setStatusCode(code);
            resp.setStatus(status);
            if (bodyAsBlob != null) {
                resp.setBodyAsBlob(bodyAsBlob);
            } else {
                resp.setBody(bodyAsString);
            }
            
            if (responseHeaders != null) {
                for (String key : responseHeaders.keySet()) {
                    resp.setHeader(key, responseHeaders.get(key));
                }
            }
            return resp;
        }
    }
     public class getStoreAppointments implements HttpCalloutMock {
        private String storeId;
        private String date1;
        private String statusToReturn;
        
        public getStoreAppointments(String storeId,String date1,String statusToReturn) {
            this.storeId = storeId;
            this.date1 = date1;
            this.statusToReturn = statusToReturn;
        }
        
        public HttpResponse respond(HttpRequest req) {           
            HttpResponse res = new HttpResponse();
            res.setStatus(statusToReturn);
            res.setStatusCode(200);
            Set<Integer> slots = new   Set<Integer>(); 
            slots.add(10);
            slots.add(11);
            slots.add(12);
            slots.add(13);
            slots.add(14);
            slots.add(15);

            
            storeAppointments myapp = new storeAppointments();
            myapp.storeNumber = '1212';
            myapp.managertimeZone = 'PST';
            
            List<availableSlots> mySlots = new List<availableSlots>();
            
            availableSlots aslot1 = new availableSlots();
            aslot1.availableDate = '10/13/2017';
            aslot1.slots = slots;
    
            
            availableSlots aslot2 = new availableSlots();
            aslot2.availableDate = '10/14/2017';
            aslot2.slots = slots;
            
            mySlots.add(aslot1);
            mySlots.add(aslot2);
            
            myapp.perDay = mySlots;
            res.setBody(JSON.serialize(myapp));
            
            system.debug('JSON.serialize(myapp)'+JSON.serialize(myapp));
            return res;
        }
    }   
   
   @TestVisible
   class storeAppointments {
        String               storeNumber;
        String               managertimeZone;
        List<availableSlots> perDay;
        String               error;
    }
    
    @TestVisible
    class availableSlots {
        String       availableDate;
        Set<Integer> slots;
    }
}