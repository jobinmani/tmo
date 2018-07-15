public class B2BAuthentication {
    public class LoginRequest{
        public String errorResponse {get;set;}
        public final String endpoint;
        public final String username;
        public final String password;
        public final String clientId;
        public final String clientSecret;
        public HttpResponse response;
          
        public LoginRequest(){
            B2BEndpoint__c OauthVal = B2BEndpoint__c.getValues('Authorization');
            this.endpoint = OauthVal.AuthTokenURL__c;
            this.username = OauthVal.UserName__c;
            this.password = OauthVal.Password__c;
            this.clientId = OauthVal.clientId__c;
            this.clientSecret = OauthVal.clientSecret__c;            
        }    
    }
    public class authenticationJSON{
        public String id;
        public String access_token;
        public authenticationJSON(){}
    }
    public String Authenticate(){
        LoginRequest lr = new LoginRequest();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        authenticationJSON tokenInfo;
        String reqbody = 'grant_type=password&client_id='+lr.clientId+
                         '&client_secret='+lr.clientSecret+'&username='+
                          lr.username+'&password='+lr.password;
   
        req.setEndpoint(lr.endpoint);
        req.setMethod('POST');
        req.setBody(reqbody);
        system.debug('Req:::'+req);
        try{
            if(!Test.isRunningTest())
                res = http.send(req);
            if (res.getStatusCode() == 200)
            {
                tokenInfo = (authenticationJSON)JSON.deserialize(res.getBody(), authenticationJSON.class);
                system.debug('Inside 200 success'+tokenInfo);
            }
            
        }catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
        }
        
        return tokenInfo.access_token;
    }
}