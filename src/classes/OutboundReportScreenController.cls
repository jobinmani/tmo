public class OutboundReportScreenController{

    public transient List<UserWrapper> userWrappers {get;set;}
    public transient List<SummaryWrapper> summaryWrapper {get;set;}
    public transient  List<StatusWrapper> unworkedStatusWrappers {get;set;}
    public transient  List<StatusWrapper> workedStatusWrappers {get;set;}    
    public transient  List<OnHoldWrapper> onHoldwrpObj{get;set;}
    public transient  List<StatusNoSaleWrapper> StatusNoSaleWrpobj{get;set;}
    public transient  List<OutBoundStatusWrapper> outboundStatwrpobj{get;set;}
    public String TotalPercConversion{get;set;}
    private transient Set<String> fieldToTrackSet = new Set<String>();
    
    public String currentUserRole {get;set;}
    
    private Id rekeyProfileId;
    private Id outboudProfileId;
    
    private String rekeyQueueId;
    private String onHoldQueueId;
    private String finishedQueueId;
    private String outboundQueueId;
    
    private transient Map<Id, User> userMap = new Map<Id, User>();
    private transient Map<Id, Case> caseMap = new Map<Id, Case>();
    
    private transient Map<Id, CaseCompleteHistoryWrapper> caseIdToCompleteCaseHistoryMap = new Map<Id, CaseCompleteHistoryWrapper>();
    private transient Map<Id, List<CaseCompleteHistoryWrapper>> userIdToCasesCompleteHistoryMap = new Map<Id, List<CaseCompleteHistoryWrapper>>();
    transient Map<Id,List<CaseHistory>> mapCaseHistory;
    transient Set<String> setUserIDs; // all outbound Agent 
    transient Set<String> setCaseComplt; // allCase complete by outbound agent
   // Long totalCaseprocesstime=0;
   Private transient map<Id,Long> mapidLogintime=new Map<Id,Long>();
   transient List<CaseHistory> history;
    public OutboundReportScreenController(){
        populateFieldToTrackSet();   
        populateProfileData();
        //populateCoachRole();
        populateQueueIds();
        calculateData();
    }
    
    private void populateFieldToTrackSet(){
        fieldToTrackSet.add('Owner');
        fieldToTrackSet.add('Call_Disposition_Formula__c');
        fieldToTrackSet.add('Call_Disposition_Reason__c');
        fieldToTrackSet.add('Rekey_Status__c');
        fieldToTrackSet.add('Outbound_Status_Formula__c');
        fieldToTrackSet.add('Outbound_Next_Step__c');
        fieldToTrackSet.add('ownerAssignment');
        fieldToTrackSet.add('ownerAccepted');
        fieldToTrackSet.add('ownerEscalated');
        fieldToTrackSet.add('external');
        fieldToTrackSet.add('created');
    }
    
    private void populateQueueIds(){
        List<QueueSObject> queues = [SELECT Id, Queue.Name, Queue.Id FROM QueueSobject WHERE Queue.Name = 'Rekey Queue' OR Queue.Name = 'Outbound Queue' OR Queue.Name = 'On Hold Queue' OR Queue.Name = 'Finished Queue'];
        for(QueueSObject q : queues){
            if(q.Queue.Name == 'Rekey Queue'){
                rekeyQueueId = q.Queue.Id;
            } else if(q.Queue.Name == 'Outbound Queue'){
                outboundQueueId = q.Queue.Id;
            } else if(q.Queue.Name == 'On Hold Queue'){
                onHoldQueueId = q.Queue.Id;
            } else if(q.Queue.Name == 'Finished Queue'){
                finishedQueueId = q.Queue.Id;
            }
        } 
            
    }
    
    private void populateProfileData(){
        system.debug('@@@@@pro'+'Profile');
        List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Name = 'Rekey Agent' OR Name = 'Outbound Agent' or name ='Outbound coach' or name='System Administrator' ];
        for(Profile p : profiles){
            if(p.Name == 'Rekey Agent'){
                rekeyProfileId = p.Id;
            }
            if(p.Name == 'Outbound Agent'){
                outboudProfileId = p.Id;
                
            }
            if(UserInfo.getProfileId()==p.id &&  (p.Name == 'Outbound coach' || p.Name == 'System Administrator' )) {
                
                currentUserRole = 'Outbound';
            }
        }    
    }
    
   
    
    public PageReference refresh(){ 
        caseIdToCompleteCaseHistoryMap.clear(); 
        userIdToCasesCompleteHistoryMap.clear();
        userMap.clear();
        caseMap.clear();
        calculateData();
        return null;
    }
    
    private void calculateData(){
        populateUserMap();
        populateCaseHistoryMaps();
        populateCaseMap();
        populateAdditionalDataOnHistoryWrappers();
        populateWrappers();
        populateOutBoundStatusWrapper();
        populateOnholdWrapper();
        populateNoSaleWrapper();
        
    }  
    
    private Set<Id> getAllOnlineUser(){
        List<AuthSession> listOfActiveUser=[SELECT   LastModifiedDate,LoginType,NumSecondsValid,SessionType,UsersId
                                            FROM AuthSession 
                                            WHERE SessionType = 'UI'
                                            AND LoginType = 'Application'];


        Set<ID> setCurrentLoginUser=new Set<ID>();
        for(AuthSession authSessionObj:listOfActiveUser){
            setCurrentLoginUser.add(authSessionObj.UsersId);
        }
    
        return setCurrentLoginUser;
    }

        
    private map<Id,String> mapUserIdLogintime  =new map<Id,String>();
    Private  void calculateTotalLoginTime(map<Id,User> mapUsers){
    
      mapUserIdLogintime.clear();
        set<Id> setuserIDsCheck=new set<Id>();
        for(loginhistory instLoginhsrty:[select userid,LoginTime from loginhistory where userid in :mapUsers.keyset() and LoginTime >: DateTime.now().addHours(-12) order by LoginTime desc ]){
            
            //decimal LoginTime=((System.now().getTime())/1000/60/60)-((instLoginhsrty.LoginTime.getTime())/1000/60/60);
            if(!setuserIDsCheck.contains(instLoginhsrty.userid)){
                Long miliSeconds=System.now().getTime()-instLoginhsrty.LoginTime.getTime();
                Integer seconds = Integer.valueOf(miliSeconds) / 1000;
                String LoginTime=convertTimeIntervalToString(seconds);
                //Integer minutes = seconds / 60;
                
                
                //Time LoginTime =Time.newInstance(hours, minutes, seconds, Integer.valueOf(miliSeconds));
                mapUserIdLogintime.put(instLoginhsrty.userid,LoginTime);
                setuserIDsCheck.add(instLoginhsrty.userid);
            }
            
        }
    }
    
    private void populateUserMap(){
        if(currentUserRole == 'Outbound'){
            userMap = new Map<Id,User>([SELECT Name, Id, ProfileId, Username, User_Location__c FROM User WHERE ProfileId =: outboudProfileId and (Id in :getAllOnlineUser())]);
              //userMap = new Map<Id,User>([SELECT Name, Id, ProfileId, Username, User_Location__c FROM User WHERE ProfileId =: outboudProfileId]);
           if(Test.isRunningTest()){
                 userMap = new Map<Id,User>([SELECT Name, Id, ProfileId, Username, User_Location__c FROM User WHERE ProfileId =: outboudProfileId]);
            }
          //  userMap = new Map<Id,User>([SELECT Name, Id, ProfileId, Username, User_Location__c FROM User WHERE id in ('00536000001Q2wQ','00536000001QcF7') or  Id in :getAllOnlineUser()]); 
            calculateTotalLoginTime(userMap);
            
        } 
    }
    
    private void populateCaseHistoryMaps(){
        Set<Id> userIdSet = new Set<Id>();
        for(User u : userMap.values()){
            userIdSet.add(u.Id);
        } 
        Time stTime= Time.newInstance(00,01,00,00);
        
        DateTime stDateTime = DateTime.newInstance(system.today(),stTime);
        DateTime enDateTime =stDateTime.addhours(24);
        system.debug('####################  '+stDateTime +'$$$$$$$$$$$$$$$$ '+enDateTime );
        if(Test.isRunningTest()){
            history = [SELECT CaseId, OldValue, NewValue, Field, CreatedById, CreatedDate FROM CaseHistory ORDER BY CreatedDate LIMIT 1000];
        } else {    
            history = [SELECT CaseId, OldValue, NewValue, Field, CreatedById, CreatedDate FROM CaseHistory WHERE CreatedDate >=: stDateTime And CreatedDate <=: enDateTime AND Field IN: fieldToTrackSet ORDER BY CreatedDate desc];        
        }
        system.debug('========>history'+history.size()+'=======>'+history);
        for(CaseHistory ch : history){
            if(!caseIdToCompleteCaseHistoryMap.containsKey(ch.CaseId)){
                caseIdToCompleteCaseHistoryMap.put(ch.CaseId, new CaseCompleteHistoryWrapper(ch.CaseId, currentUserRole, userMap.keySet()));
            }else{
                caseIdToCompleteCaseHistoryMap.get(ch.CaseId).addCaseHistory(ch);
            }
        }
        
        mapCaseHistory=new map<id,List<CaseHistory>>();
        for(CaseHistory hs:history){
                if(hs.field =='Owner'){
                    if(!mapCaseHistory.containsKey(hs.caseId))
                        mapCaseHistory.put(hs.caseId,new List<CaseHistory>{hs});
                    else
                        mapCaseHistory.get(hs.caseId).add(hs);
                }
        }
    }

    private void populateAdditionalDataOnHistoryWrappers(){
        system.debug('************caseIdToCompleteCaseHistoryMap'+caseIdToCompleteCaseHistoryMap.size());
        for(CaseCompleteHistoryWrapper wrapper : caseIdToCompleteCaseHistoryMap.values()){
            wrapper.setCaseObj(caseMap.get(wrapper.caseId));
            wrapper.sortAndProcess();
            if(wrapper.holderId == null){ //untouched case in queue.
                continue;
            }
            system.debug('*************wrapper.holderId'+wrapper.holderId);
            if(!userIdToCasesCompleteHistoryMap.containsKey(wrapper.holderId)){
                userIdToCasesCompleteHistoryMap.put(wrapper.holderId, new List<CaseCompleteHistoryWrapper>());
            }
            userIdToCasesCompleteHistoryMap.get(wrapper.holderId).add(wrapper);
        }    
    }
  //  transient list<case> casesIrrespectiveOfTime=[SELECT Id, Last_Case_Owner__c,Outbound_AgentAssign_Time__c,outbound_AgentCase_complete__c,CaseNumber,TOM_Order_Number__c,OwnerId, Outbound_Status_Formula__c,Outbound_Status__c, SLA_Time_Outbound__c, SLA_time__c, Elapsed_time__c, Rekey_Status__c, Call_Disposition_Formula__c, Call_Disposition_Reason__c FROM Case where TOM_Order_Number__c != null];
    private void populateCaseMap(){
        Set<Id> casesFromHistoryIdSet = new Set<Id>();
        for(CaseHistory casehtry : history){
            casesFromHistoryIdSet.add(casehtry.CaseId);
        } 
        
        caseMap = new Map<Id,Case>([SELECT Id, Last_Case_Owner__c,Outbound_AgentAssign_Time__c,outbound_AgentCase_complete__c,CaseNumber,TOM_Order_Number__c,OwnerId, Outbound_Status_Formula__c,Outbound_Status__c, SLA_Time_Outbound__c, SLA_time__c, Elapsed_time__c, Rekey_Status__c, Call_Disposition_Formula__c, Call_Disposition_Reason__c FROM Case WHERE Id IN: casesFromHistoryIdSet order by LastModifiedDate]);  
        
   }
    /* 
    @mthod-populateOnholdWrapper
    @Desc: call to populate wrapper class for onHold cases
    */
    private void populateOnholdWrapper(){
         system.debug('*************onHoldQueueId mehoid'+onHoldQueueId);       
         map<String,Integer> stOnholdStatusCountMap =new Map<String,Integer>();
         //caseMap = new Map<Id,Case>([SELECT Id, CaseNumber,TOM_Order_Number__c,OwnerId, Outbound_Status_Formula__c, SLA_Time_Outbound__c, SLA_time__c, Elapsed_time__c, Rekey_Status__c, Call_Disposition_Formula__c, Call_Disposition_Reason__c FROM Case WHERE ownerid=: onHoldQueueId]);  
        onHoldwrpObj=new List<OnHoldWrapper>();
        List<Schema.PicklistEntry> pleList = Case.Rekey_Status__c.getDescribe().getPicklistValues();
        for(Schema.PicklistEntry ple : pleList){
            stOnholdStatusCountMap.put(ple.getValue(), 0);
        }
        for(Case instCase:[SELECT Id, CaseNumber,TOM_Order_Number__c,OwnerId, Outbound_Status_Formula__c, SLA_Time_Outbound__c, SLA_time__c, Elapsed_time__c, Rekey_Status__c, Call_Disposition_Formula__c, Call_Disposition_Reason__c FROM Case WHERE ownerid=: onHoldQueueId]){
                system.debug('**************instCase'+instCase);
            if(stOnholdStatusCountMap.containsKey(instCase.Rekey_Status__c)){
                integer count=stOnholdStatusCountMap.get(instCase.Rekey_Status__c)+ 1;
                system.debug('==============>count=='+count);
                stOnholdStatusCountMap.put(instCase.Rekey_Status__c, count); 
            }
        }
        for(String status:stOnholdStatusCountMap.keySet()){
            system.debug('stOnholdStatusCountMap.get(status)=============>'+status);
            onHoldwrpObj.add(new OnHoldWrapper(status,stOnholdStatusCountMap.get(status)));
        }
        
        system.debug('*************onHoldwrpObj'+onHoldwrpObj.size());
    }
    
    /*  
     @method :Outbound Completed Cases by No Sale Reason
    

    */
    private void populateNoSaleWrapper(){
        
           
         map<String,Integer> dispostionReasonCountMap =new Map<String,Integer>();
         map<string,Integer> firstCallCountMap=new Map<String,Integer>();
         map<string,Integer> customerContCallCountMap=new Map<String,Integer>();
         map<string,Integer> customerContedCountMap=new Map<String,Integer>();
         map<string,Integer> secondCallCountMap=new Map<String,Integer>();
         StatusNoSaleWrpobj=new List<StatusNoSaleWrapper>();
         string key;
         //caseMap = new Map<Id,Case>([SELECT Id, CaseNumber,TOM_Order_Number__c,OwnerId, Outbound_Status_Formula__c, SLA_Time_Outbound__c, SLA_time__c, Elapsed_time__c, Rekey_Status__c, Call_Disposition_Formula__c, Call_Disposition_Reason__c FROM Case WHERE ownerid=: onHoldQueueId]);  
     
        List<Schema.PicklistEntry> pleList = Case.Call_Disposition_Reason__c.getDescribe().getPicklistValues();
        for(Schema.PicklistEntry ple : pleList){
            dispostionReasonCountMap.put(ple.getValue(), 0);
        }
        
 
       // for(Case instCase:[SELECT Id, CaseNumber,TOM_Order_Number__c,OwnerId, Outbound_Status_Formula__c, SLA_Time_Outbound__c, SLA_time__c, Elapsed_time__c, Rekey_Status__c, Call_Disposition_Formula__c, Call_Disposition_Reason__c FROM Case WHERE CreatedDate >: DateTime.now().addHours(-12) and Call_Disposition_Reason__c!=null ]){
          for(case instCase: caseMap.values() ){     
              system.debug('**************instCase--------'+instCase);
            if(instCase.Call_Disposition_Reason__c !=null && dispostionReasonCountMap.containsKey(instCase.Call_Disposition_Reason__c)){
                integer count=dispostionReasonCountMap.get(instCase.Call_Disposition_Reason__c)+ 1;
                system.debug('==============>count==-----'+count);
                dispostionReasonCountMap.put(instCase.Call_Disposition_Reason__c, count); 
                
                
            }
            
            if(instCase.Outbound_Status_Formula__c=='Customer Contacted'){
                key=instCase.Call_Disposition_Reason__c+instCase.Outbound_Status_Formula__c;
                if(!customerContedCountMap.containsKey(key)){
                    customerContedCountMap.put(key,1);
                }else{
                    customerContedCountMap.put(key,customerContedCountMap.get(key)+1);
                }
                
            }else if(instCase.Outbound_Status_Formula__c=='Customer Called In'){
                key=instCase.Call_Disposition_Reason__c+instCase.Outbound_Status_Formula__c;
                if(!customerContCallCountMap.containsKey(key)){
                    customerContCallCountMap.put(key,1);
                }else{
                    customerContCallCountMap.put(key,customerContCallCountMap.get(key)+1);
                }
            }
            else if(instCase.Outbound_Status_Formula__c=='First Call Attempt'){
                key=instCase.Call_Disposition_Reason__c+instCase.Outbound_Status_Formula__c;
                if(!firstCallCountMap.containsKey(key)){
                    firstCallCountMap.put(key,1);
                }else{
                    firstCallCountMap.put(key,firstCallCountMap.get(key)+1);
                }
            }
            else if(instCase.Outbound_Status_Formula__c=='Second Call Attempt'){
                key=instCase.Call_Disposition_Reason__c+instCase.Outbound_Status_Formula__c;
                if(!secondCallCountMap.containsKey(key)){
                    secondCallCountMap.put(key,1);
                }else{
                    secondCallCountMap.put(key,secondCallCountMap.get(key)+1);
                }
            }
        }
        
       
        string callDisposition;
        integer firstCallCount=0;
        integer customerContatcedCount=0;
        integer customerCalledinCount=0;
        integer secondCallCount=0;
        integer reasonByCount=0;
        
        for(string callDisposresn:dispostionReasonCountMap.keyset()){ 
            
             String key1=callDisposresn+'Customer Contacted';
             String key2=callDisposresn+'Customer Called In';
             String key3=callDisposresn+'First Call Attempt';
             String key4=callDisposresn+'Second Call Attempt';
              
            customerContatcedCount=customerContedCountMap.containsKey(key1)?customerContedCountMap.get(key1):0;
            customerCalledinCount=customerContCallCountMap.containsKey(key2)?customerContCallCountMap.get(key2):0;
            firstCallCount=firstCallCountMap.containsKey(key3)?firstCallCountMap.get(key3):0;
            secondCallCount=secondCallCountMap.containsKey(key4)?secondCallCountMap.get(key4):0;
            reasonByCount=dispostionReasonCountMap.get(callDisposresn);
            StatusNoSaleWrpobj.add(new StatusNoSaleWrapper(callDisposresn,firstCallCount,customerContatcedCount,customerCalledinCount,secondCallCount,reasonByCount));
            
            
        }
        
        
        
    }  // end of method
     /* 
    @mthod-populateOutBoundStatusWrapper
    @Desc: call to populate wrapper class for cases complete
    */
    private void populateOutBoundStatusWrapper(){
        map<String,Integer> OutBoundStatusCountMap =new Map<String,Integer>();
         map<String,Integer> OutBoundCmpltStatusCountMap =new Map<String,Integer>();
       
        
        map<String,String> OutBoundCoversnCountMap =new Map<String,String>();
        decimal countOfCompleteCase=0;
        decimal totalstatusbyCount=0;
        outboundStatwrpobj=new List<OutBoundStatusWrapper>();
        List<Schema.PicklistEntry> pleList = Case.Outbound_Status__c.getDescribe().getPicklistValues();
        for(Schema.PicklistEntry ple : pleList){
            OutBoundStatusCountMap.put(ple.getValue(), 0);
            OutBoundCoversnCountMap.put(ple.getValue(),null);
            OutBoundCmpltStatusCountMap.put(ple.getValue(), 0);
        }
        /*for(Case caseObj:caseMap.values()){
             system.debug('**********finishedQueueId'+finishedQueueId+'======caseObj.ownerid'+caseObj.ownerid);
            if(caseObj.ownerid==finishedQueueId){
                
                countOfCompleteCase++;
            }
        }*/
        countOfCompleteCase=setCaseComplt.size();
        setCaseComplt.clear();
        system.debug('************---------'+countOfCompleteCase+'***********'+caseMap.values());
        for(Case instCase:caseMap.values()){
                system.debug('************-------instCase.ownerid--'+instCase.ownerid+'**********instCase.Outbound_Status__c'+instCase.Outbound_Status__c);
            if(instCase.ownerid==finishedQueueId  &&  OutBoundStatusCountMap.containsKey(instCase.Outbound_Status__c)){
                integer count=OutBoundStatusCountMap.get(instCase.Outbound_Status__c)+ 1;
                system.debug('==============>count=='+count);
                OutBoundStatusCountMap.put(instCase.Outbound_Status__c, count);
                if(instCase.Outbound_Status__c=='Sale : Customer Called In' || instCase.Outbound_Status__c=='Sale : Customer Contacted' || instCase.Outbound_Status__c=='Sale : Price Mismatch – Express Checkout' || instCase.Outbound_Status__c=='Sale : Second Call Attempt'){
                     Integer k=OutBoundCmpltStatusCountMap.get(instCase.Outbound_Status__c)+ 1;
                     //system.debug('==============>count=='+count);
                     OutBoundCmpltStatusCountMap.put(instCase.Outbound_Status__c, k);
                    
                }
            }
        }
        for(String st:OutBoundStatusCountMap.keyset()){
                system.debug('============>OutBoundStatusCountMap.get(st)'+OutBoundCmpltStatusCountMap.get(st)+'========='+countOfCompleteCase);
                decimal percConversion=countOfCompleteCase!=0?decimal.valueOf(OutBoundCmpltStatusCountMap.get(st))/countOfCompleteCase :0;
                totalstatusbyCount=totalstatusbyCount+(percConversion*100).setScale(2);
                String conversion=string.valueOF((percConversion*100).setScale(2))+'%';
                OutBoundCoversnCountMap.put(st,conversion); 
            
        }
        for(String status:OutBoundStatusCountMap.keySet()){
            system.debug('OutBoundStatusCountMap.get(status)=============>'+OutBoundStatusCountMap.get(status));
            outboundStatwrpobj.add(new OutBoundStatusWrapper(status,OutBoundStatusCountMap.get(status),OutBoundCoversnCountMap.get(status)));
        }
        TotalPercConversion=(totalstatusbyCount>100?100:totalstatusbyCount)+'%';
        system.debug('*************outboundStatwrpobj'+outboundStatwrpobj.size());
    }// End of method
    
    
    private void populateWrappers(){
        //user wrappers
        userWrappers = new List<UserWrapper>();
        Set<Id> setOnlineUser=new Set<Id>();
        setOnlineUser.addAll(getAllOnlineUser());
        Integer sNumberOfCasesWithinSLA = 0;
        Integer sNumberOfCasesOutSLA = 0;
        
        //status wrappers variables
        Map<String, Integer> stUnworkedStatusCountMap = new Map<String, Integer>();
        Map<String, Integer> stWorkedStatusCountMap = new Map<String, Integer>();
        Map<String, Integer> stWorkedStatusSLACountMap = new Map<String, Integer>();
        Map<String, Integer> stWorkedStatusConversionCountMap = new Map<String, Integer>();
        
        
               
               
        List<Schema.PicklistEntry> pleList = Case.Rekey_Status__c.getDescribe().getPicklistValues();
        for(Schema.PicklistEntry ple : pleList){
            stUnworkedStatusCountMap.put(ple.getValue(), 0);
            stWorkedStatusCountMap.put(ple.getValue(), 0);
            stWorkedStatusSLACountMap.put(ple.getValue(), 0);
            stWorkedStatusConversionCountMap.put(ple.getValue(), 0);
        }
        
       transient map<id,list<case>> openCaseRecmap = new map<id,list<case>>();
       transient list<case> openLstCase = [Select id,caseNumber,status,ownerid,createdDate from case where ownerid IN :userMap.keySet() Order By createdDate ASC];
            for(case ca:openLstCase){
                if(!openCaseRecmap.containsKey(ca.ownerid)){
                    openCaseRecmap.put(ca.ownerid,new list<case>{ca});
                }else{
                    openCaseRecmap.get(ca.ownerid).add(ca);
                }
                
                //uCaseOpenNumber=caseMap.get(cchWrapper.caseId).caseNumber;
                        //uCaseOpenId=cchWrapper.caseId;
            }
            Integer sNumberOfUntouchedCases = 0;
           transient list<case> lstoutBoundCases=[select id,createdDate,ownerid,Rekey_Status__c from case where ownerid = :outboundQueueId];
            for(case cs:lstoutboundcases){
                    if(((system.now().getTime() - cs.createdDate.getTime())/1000/60) > 10){
                        sNumberOfCasesOutSLA++;                 
                    }else{
                        sNumberOfCasesWithinSLA++;
                        
                    }
                    
                    if(!stUnworkedStatusCountMap.containsKey(cs.Rekey_Status__c)){
                        stUnworkedStatusCountMap.put(cs.Rekey_Status__c, 0);
                    }else{
                        stUnworkedStatusCountMap.put(cs.Rekey_Status__c, stUnworkedStatusCountMap.get(cs.Rekey_Status__c) + 1);  
                    } 
                }
                
            sNumberOfUntouchedCases = lstoutBoundCases.size();
       // map<Id,Integer> mapIDLoginTimeInMin=ReportScreenController_Clone.populateTotalLogintime(setOnlineUser);
        for(User usr : userMap.values()){
            Integer uCaseHandlingTimeSummary = 0;
            Integer uCaseConvertedCount = 0;
            Integer uCountOpenCase=0;
            String uCaseOpenNumber;
            Id uCaseOpenId;
            Set<Id> uCaseTouchedTodaySet = new Set<Id>();
            Set<Id> uCaseCompletedTodaySet = new Set<Id>();
            Set<Id> uCaseSaleCompletTodaySet=new Set<ID>();
            CaseCompleteHistoryWrapper uMostRecentlyUpdateCaseWrapper = null;
            datetime assigntime,completeTime;
            Integer totalCompleteCasetimeinSec=0;
            long totalOpenCasetimeinMS=0;
            set<String> stCaseID=new Set<String>();
            
            if(openCaseRecmap.containsKey(usr.id)){
                        uCaseOpenNumber=openCaseRecmap.get(usr.id)[0].caseNumber;//caseMap.get(cchWrapper.caseId).caseNumber;
                        uCaseOpenId=openCaseRecmap.get(usr.id)[0].id;
            }
            
            //decimal noOfOpenCase=0;
            system.debug('***********userIdToCasesCompleteHistoryMap'+userIdToCasesCompleteHistoryMap.size()+'userIdToCasesCompleteHistoryMap.get(usr.Id)'+userIdToCasesCompleteHistoryMap.get(usr.Id));
            if(userIdToCasesCompleteHistoryMap.containsKey(usr.id) && userIdToCasesCompleteHistoryMap.get(usr.Id) != null){
                for(CaseCompleteHistoryWrapper cchWrapper : userIdToCasesCompleteHistoryMap.get(usr.Id)){
                
                    // Cases touched today calculation
                    uCaseTouchedTodaySet.add(cchWrapper.caseId);
                    
                    // Cases completed today calculation
                     if(currentUserRole == 'Outbound' && caseMap.containsKey(cchWrapper.caseId)){
                        if(String.valueOf(caseMap.get(cchWrapper.caseId).OwnerId) == finishedQueueId){
                            
                            system.debug('---------------->cchWrapper'+cchWrapper.holderId);
                            uCaseCompletedTodaySet.add(cchWrapper.caseId);
                        }
                        
                        if(String.valueOf(caseMap.get(cchWrapper.caseId).OwnerId) == finishedQueueId && (caseMap.get(cchWrapper.caseId).Outbound_Status__c=='Sale : Customer Contacted' || caseMap.get(cchWrapper.caseId).Outbound_Status__c =='Sale : Customer Called In' || caseMap.get(cchWrapper.caseId).Outbound_Status__c=='Sale : Price Mismatch – Express Checkout'|| caseMap.get(cchWrapper.caseId).Outbound_Status__c=='Sale : Second Call Attempt')){
                            
                            uCaseSaleCompletTodaySet.add(cchWrapper.caseId);
                        }
                    }
 
 
                    // Current case calculation
                    system.debug('*********caseMap.get(cchWrapper.caseId).OwnerId'+caseMap.get(cchWrapper.caseId).OwnerId+'=====>'+usr.Id);
                    if(caseMap.containsKey(cchWrapper.caseId) && caseMap.get(cchWrapper.caseId).OwnerId == usr.Id){
                        uMostRecentlyUpdateCaseWrapper = cchWrapper;
                       // uCaseOpenNumber=caseMap.get(cchWrapper.caseId).caseNumber;
                        //uCaseOpenId=cchWrapper.caseId;
                        for(CaseHistory chistory:mapCaseHistory.get(cchWrapper.caseId)){
                             string newOwnerID=String.valueOf(chistory.newValue);
                             string oldOwnerID=String.valueOF(chistory.oldValue);
                             string userId=String.valueOf(usr.Id);
                             system.debug('***********oldOwnerID'+oldOwnerID+'============'+newOwnerID);
                            if( newOwnerID==userId && oldOwnerID==outboundQueueId){
                                assigntime=chistory.createdDate;
                                uCountOpenCase++;
                                system.debug('chistory===>'+chistory+'**************assigntime'+assigntime+'*********-->'+System.now());
                                totalOpenCasetimeinMS=totalOpenCasetimeinMS+(System.now().getTime()-assigntime.getTime());
                            }
                            
                            
                        } 
                                            // AHT calculation
                        
                    }
                             
                            
                                
                                
                    
                    
                   
                    //uCaseHandlingTimeSummary = totalCompleteCasetimeinSec;    
                    //Conversion calculation
                     if(currentUserRole == 'Outbound' &&  caseMap.containsKey(cchWrapper.caseId)){
                        if(caseMap.get(cchWrapper.caseId).Call_Disposition_Formula__c == 'Sale'){
                            uCaseConvertedCount++;
                        }                
                    }
                    // AHT calculation
                    if(!stCaseID.contains(cchWrapper.caseID)){
                        uCaseHandlingTimeSummary = uCaseHandlingTimeSummary + cchWrapper.caseHandlingTimeInSeconds;
                        stCaseID.add(cchWrapper.caseID);
                    }   
                }
                 
                        
            }
            Integer totalOpenCasetimeinSec=Integer.valueOf(totalOpenCasetimeinMS/1000);
            
            Integer uCasesTouchedToday = uCaseTouchedTodaySet.size();
            Integer uCasesCompletedToday = uCaseCompletedTodaySet.size();
            Decimal uCaseSaleCompletToday = uCaseSaleCompletTodaySet.size();
            String uTodayCasesAHT = uCasesCompletedToday == 0 ? 'N/A' : convertTimeIntervalToString(uCaseHandlingTimeSummary / uCasesCompletedToday);
            String uCurrentCase = uMostRecentlyUpdateCaseWrapper == null ? 'None' : uMostRecentlyUpdateCaseWrapper.caseId;
            system.debug('*********uCountOpenCase'+uCountOpenCase+'******************'+uCurrentCase);
            String uTimeOnCurrentCase = uCountOpenCase == 0  ? 'N/A' : convertTimeIntervalToString(totalOpenCasetimeinSec/uCountOpenCase);
            system.debug('*********uCaseConvertedCount'+uCaseConvertedCount+'*----------'+uCasesCompletedToday);
           
            String uConversion = uCasesCompletedToday == 0 ? 'N/A' :((uCaseSaleCompletToday/uCasesCompletedToday)*100).setscale(2)+'%' ;        
             system.debug('***********-------uConversion'+mapUserIdLogintime);
            Long utotalLoginTimeInSec=getTimeInSeconds(mapUserIdLogintime.containsKey(usr.id)?mapUserIdLogintime.get(usr.id):'N/A');
            system.debug('--------------------*************>'+uTimeOnCurrentCase);
            Long utotalTimeOnCurrentCaseInSec=getTimeInSeconds(uTimeOnCurrentCase);
            system.debug('************'+utotalTimeOnCurrentCaseInSec+'============uCaseHandlingTimeSummary'+uCaseHandlingTimeSummary+'----utotalLoginTimeInSec'+utotalLoginTimeInSec);
            
            Long utotalTimeOnCaseInSec=utotalTimeOnCurrentCaseInSec+uCasesCompletedToday*getTimeInSeconds(uTodayCasesAHT);
            system.debug('***********------------>utotalTimeOnCaseInSec'+utotalTimeOnCaseInSec);
            if(utotalLoginTimeInSec<utotalTimeOnCaseInSec){
                utotalLoginTimeInSec=utotalLoginTimeInSec+utotalTimeOnCaseInSec;
                mapidLogintime.put(usr.id,utotalLoginTimeInSec);
            }else if(mapidLogintime.containsKey(usr.id)){
                utotalLoginTimeInSec=utotalLoginTimeInSec+mapidLogintime.get(usr.id);
            }
            
            //String LoginTime=convertTimeIntervalToString(utotalLoginTimeInSec);
            // integer logintimeInSec=mapIDLoginTimeInMin.containsKey(usr.Id)?(mapIDLoginTimeInMin.get(usr.Id))*60:0;
            integer logintimeInSec=0;
             String LoginTime=convertTimeIntervalToString(logintimeInSec);
            
            decimal uOccupancy=logintimeInSec!=0?decimal.valueOf(utotalTimeOnCaseInSec)/decimal.valueOf(logintimeInSec).setScale(2):0;
            system.debug('************----------**-----'+uOccupancy);
            String uOccupancyPerc=uOccupancy==0?'N/A':(uOccupancy*100).setScale(2)+'%';
            system.debug('************---------------uCaseOpenNumber'+uCaseOpenNumber);
            UserWrapper uWrapper = new UserWrapper(userMap.get(usr.Id), uCasesTouchedToday, uCasesCompletedToday, uTodayCasesAHT, uCurrentCase, uTimeOnCurrentCase, uConversion, uCaseHandlingTimeSummary, uCaseConvertedCount,uCaseOpenNumber,uCountOpenCase,LoginTime,uOccupancyPerc,uCaseOpenId);
           
            userWrappers.add(uWrapper);
            stCaseID.clear();
        }

        //summary wrapper variables
         
        Integer sNumberOfCasesBeingWorked = 0;
        for(id ownerid:openCaseRecmap.Keyset()){
                 sNumberOfCasesBeingWorked = sNumberOfCasesBeingWorked +openCaseRecmap.get(ownerid).size();
            }
        
        Integer sNumberOfCasesCompleted = 0;
        String sGlobalAHT;
        String sGlobalConversion;      
        
        

        //conversion wrappers
        Map<String, Integer> cConversionStatusCountMap = new Map<String, Integer>();
        Integer cSaleCount = 0;
        if(currentUserRole == 'Outbound'){
            pleList = Case.Call_Disposition_Reason__c.getDescribe().getPicklistValues();
            for(Schema.PicklistEntry ple : pleList){
                cConversionStatusCountMap.put(ple.getValue(), 0);
            }            
        } else if(currentUserRole == 'Rekey'){
            //TODO put logic here
        }
        system.debug('===========caseMap.values()'+caseMap.values());
        for(Case c : caseMap.values()){   
            if(currentUserRole == 'Outbound'){
                if(c.Rekey_Status__c == 'Sale Complete (Express Checkout)'){
                    cSaleCount++;
                } else {
                    if(!cConversionStatusCountMap.containsKey(c.Call_Disposition_Reason__c)){
                        cConversionStatusCountMap.put(c.Call_Disposition_Reason__c, 0);
                    }
                    cConversionStatusCountMap.put(c.Call_Disposition_Reason__c, cConversionStatusCountMap.get(c.Call_Disposition_Reason__c) + 1);
                }
            } 
            
            system.debug('=========currentUserRole'+currentUserRole+'c.OwnerId--------'+c.OwnerId+'=========outboundQueueId---'+outboundQueueId);
            if(currentUserRole == 'Outbound'  && c.OwnerId == outboundQueueId){//c.OwnerId == outboundQueueId){
                //sNumberOfUntouchedCases++;
                                 
            }else if(String.valueOf(c.OwnerId).startsWith('005')){
                //sNumberOfCasesBeingWorked++;
                if(!stWorkedStatusCountMap.containsKey(c.Rekey_Status__c)){
                    stWorkedStatusCountMap.put(c.Rekey_Status__c, 0);
                }
                if(!stWorkedStatusSLACountMap.containsKey(c.Rekey_Status__c)){
                    stWorkedStatusSLACountMap.put(c.Rekey_Status__c, 0);
                }
                if(!stWorkedStatusConversionCountMap.containsKey(c.Rekey_Status__c)){
                    stWorkedStatusConversionCountMap.put(c.Rekey_Status__c, 0);
                }                
                stWorkedStatusCountMap.put(c.Rekey_Status__c, stWorkedStatusCountMap.get(c.Rekey_Status__c) + 1);
                if(c.Call_Disposition_Formula__c == 'Sale'){
                    stWorkedStatusConversionCountMap.put(c.Rekey_Status__c, stWorkedStatusConversionCountMap.get(c.Rekey_Status__c) + 1);
                }   
                if(c.SLA_Time_Outbound__c < DateTime.now()){
                    stWorkedStatusSLACountMap.put(c.Rekey_Status__c, stWorkedStatusSLACountMap.get(c.Rekey_Status__c) + 1);
                }                     
            }                            
            
            
            /*if(currentUserRole == 'Outbound' && c.OwnerId != onHoldQueueId){
                if( c.SLA_Time_Outbound__c < DateTime.now()){//((Integer.ValueOf(system.NOW().getTime() - c.CreatedDate.getTime())) * 1440)
                    sNumberOfCasesOutSLA++;
                } else if(c.SLA_Time_Outbound__c!=null)  {//
                    sNumberOfCasesWithinSLA++;
                }
            }*/                           
        }
        
        //summary wrapper
        Integer sGlobalCaseHandlingTimeSummary = 0;
        Integer sGlobalConversionCount = 0;
        Integer activeUsers=userMap.size();
        for(UserWrapper uWrapper : userWrappers){
            sGlobalCaseHandlingTimeSummary = sGlobalCaseHandlingTimeSummary + uWrapper.caseHandlingTimeSummary;
            sGlobalConversionCount  = sGlobalConversionCount + uWrapper.caseConvertedCount;
            sNumberOfCasesCompleted = sNumberOfCasesCompleted + uWrapper.casesCompletedToday;
        }
        //sGlobalAHT = sNumberOfCasesCompleted == 0 ? 'N/A' : convertTimeIntervalToString(sGlobalCaseHandlingTimeSummary / sNumberOfCasesCompleted);
        //sGlobalConversion = sNumberOfCasesCompleted == 0 ? 'N/A' : getPercentValue(sGlobalConversionCount/ sNumberOfCasesCompleted);
        setUserIDs=new Set<String>();
        //setUserIDs.addAll(mapUsers.keyset());
        //Map<Id,User> mapUsers=new Map<Id,User>([SELECT Name, Id, ProfileId, Username, User_Location__c FROM User WHERE ProfileId =: outboudProfileId ]);
        sNumberOfCasesBeingWorked=0;
        for(user userObj:[SELECT Name, Id, ProfileId, Username, User_Location__c FROM User WHERE ProfileId =: outboudProfileId]){
            
            setUserIDs.add(string.valueOf(userObj.id));
        }
        long timeInSaleCompleteInmiliSec=0;
        long timeInNoSaleCompleteInmiliSec=0;
        integer countSaleComplete=0;
        integer countNoSaleComplete=0;
        decimal totalCaseComplete=0;
        decimal totalCaseSaleComplete=0;
        datetime assigntime,completeTime;
        setCaseComplt=new set<String>();
        set<String> setCaseSaleCmplt=new set<String>();
    for(case caseObj:caseMap.values()){
            system.debug('id-------->'+caseObj.id+'**********'+caseObj.ownerId+'************mapUsers.containsKey(caseObj.Last_Case_Owner__c)==='+setUserIDs+'========caseObj.Call_Disposition_Formula__c'+caseObj.Call_Disposition_Formula__c);
            string caseOwnerID=String.valueOf(caseObj.ownerId);
            if(mapCaseHistory.containsKey(caseObj.id)){
                for(CaseHistory chistory:mapCaseHistory.get(caseObj.id)){
                     string oldOwnerid=String.valueOf(chistory.oldValue);
                     string newOwnerId=String.valueOf(chistory.newValue);
                     system.debug('*************chistory*'+chistory);
                     system.debug('******---------'+setUserIDs);
                    if(caseObj.OwnerID==finishedQueueId  && setUserIDs.contains(oldOwnerid)){
                        
                          completeTime=chistory.createdDate;
                          system.debug('********completeTime'+completeTime);
                          string caseOwner=caseObj.id+oldOwnerid;
                          system.debug('************caseObj.id'+caseObj.id+'**********Outbound_Status__c'+caseObj.Outbound_Status__c);
                          setCaseComplt.add(caseOwner);
                         //totalCaseComplete++;
                    }
                    
                    else if(setUserIDs.contains(caseOwnerID)  && oldOwnerid==outboundQueueId){
                        assigntime=chistory.createdDate;
                        sNumberOfCasesBeingWorked++;
                        system.debug('**************assigntime'+assigntime);
                    }
                    
                    
                    
                    if(caseObj.ownerId==finishedQueueId && setUserIDs.contains(oldOwnerid) && (caseObj.Outbound_Status__c=='Sale : Customer Contacted' || caseObj.Outbound_Status__c =='Sale : Customer Called In' || caseObj.Outbound_Status__c=='Sale : Price Mismatch – Express Checkout'|| caseObj.Outbound_Status__c=='Sale : Second Call Attempt') ){
                        setCaseSaleCmplt.add(caseObj.id);
                    }  
                }
            
                
            }
            
            system.debug('==========completeTime'+completeTime+'========='+assigntime+'----------caseObj.Call_Disposition_Formula__c'+caseObj.Call_Disposition_Formula__c+'==caseObj.ownerId'+caseObj.ownerId);
            if(caseObj.ownerId==finishedQueueId  && caseObj.Call_Disposition_Formula__c=='Sale' && completeTime!=null && assigntime!=null ){
                countSaleComplete++;
                
                
                    timeInSaleCompleteInmiliSec=timeInSaleCompleteInmiliSec+(completeTime.getTime()-assigntime.getTime());
                    system.debug('**************timeInSaleCompleteInmiliSec'+timeInSaleCompleteInmiliSec);
            }else if(caseObj.ownerId==finishedQueueId  && caseObj.Call_Disposition_Formula__c=='No-Sale'   && completeTime!=null && assigntime!=null){
                    system.debug('Inside sale no');
                    timeInNoSaleCompleteInmiliSec=timeInNoSaleCompleteInmiliSec+(completeTime.getTime()-assigntime.getTime());
                    countNoSaleComplete++;
                
            }
           
                     
    }   
        system.debug('==========setCaseComplt'+setCaseComplt);
        totalCaseComplete=setCaseComplt.size();
        totalCaseSaleComplete=setCaseSaleCmplt.size();
        system.debug('*************totalCaseComplete'+totalCaseComplete+'===========>'+totalCaseSaleComplete);
        
        //setCaseComplt.clear();
        setCaseSaleCmplt.clear();
        Integer timeInSaleCompleteInSec=Integer.valueOf(timeInSaleCompleteInmiliSec) / 1000;
       
        Integer timeInNoSaleCompleteInSec=Integer.valueOf(timeInNoSaleCompleteInmiliSec) / 1000;
         system.debug('*************timeInSaleCompleteInSec'+timeInNoSaleCompleteInSec+'**************countNoSaleComplete'+countNoSaleComplete);
        String sSaleAHT = countSaleComplete == 0 ? 'N/A' : convertTimeIntervalToString(timeInSaleCompleteInSec / countSaleComplete);
        String sNoSaleAht=countNoSaleComplete==0? 'N/A' : convertTimeIntervalToString(timeInNoSaleCompleteInSec / countNoSaleComplete);
        String conversionInperc=totalCaseComplete==0?'N/A':(((totalCaseSaleComplete/totalCaseComplete)*100).setScale(2))+'%';
        summaryWrapper = new List<SummaryWrapper>();
        summaryWrapper.add(new SummaryWrapper(activeUsers,sNumberOfUntouchedCases, sNumberOfCasesBeingWorked, sNumberOfCasesWithinSLA, sNumberOfCasesOutSLA, Integer.valueOf(totalCaseComplete), sSaleAHT,sNoSaleAht, conversionInperc));
                        
        //status wrappers
        Map<String, Integer> stWorkedStatusToCaseHandlingTimeSummaryMap = new Map<String, Integer>();
        Map<String, Integer> stUnworkedStatusToCaseHandlingTimeSummaryMap = new Map<String, Integer>();
        
       /* for(CaseCompleteHistoryWrapper cchWrapper : caseIdToCompleteCaseHistoryMap.values()){
            String status = caseMap.get(cchWrapper.caseId).Rekey_Status__c;
            if(!stWorkedStatusToCaseHandlingTimeSummaryMap.containsKey(status)){
                stWorkedStatusToCaseHandlingTimeSummaryMap.put(status, 0);
            }
            if(!stUnworkedStatusToCaseHandlingTimeSummaryMap.containsKey(status)){
                stUnworkedStatusToCaseHandlingTimeSummaryMap.put(status, 0);
            }    
            if(String.valueOf(cchWrapper.caseId).startsWith('005')){
                stWorkedStatusToCaseHandlingTimeSummaryMap.put(status, stWorkedStatusToCaseHandlingTimeSummaryMap.get(status) + cchWrapper.caseHandlingTimeInSeconds);
            } else if(caseMap.get(cchWrapper.caseId).OwnerId == outboundQueueId){
                //stUnworkedStatusToCaseHandlingTimeSummaryMap.put(status, stUnworkedStatusToCaseHandlingTimeSummaryMap.get(status) + cchWrapper.caseHandlingTimeInSeconds);
            }
        } */       
        
        unworkedStatusWrappers = new List<StatusWrapper>();
        workedStatusWrappers = new List<StatusWrapper>();        
        for(String status : stUnworkedStatusCountMap.keySet()){
            Integer stUnworkedAHTSummary = stUnworkedStatusToCaseHandlingTimeSummaryMap.get(status);
            String stUnworkedRekeyAHT = stUnworkedStatusCountMap.get(status) == 0 || stUnworkedAHTSummary == null ? 'N/A' : convertTimeIntervalToString(stUnworkedAHTSummary / stUnworkedStatusCountMap.get(status));
            
            StatusWrapper unworkedWrapper = new StatusWrapper(status, stUnworkedStatusCountMap.get(status), stUnworkedRekeyAHT);
            unworkedStatusWrappers.add(unworkedWrapper);
            system.debug('*********--------'+unworkedStatusWrappers);
            String conversion = stWorkedStatusCountMap.get(status) == 0 || stWorkedStatusConversionCountMap.get(status) == null? 'N/A' : getPercentValue(stWorkedStatusConversionCountMap.get(status) / stWorkedStatusCountMap.get(status));
            String percentSLA = stWorkedStatusCountMap.get(status) == 0 || stWorkedStatusSLACountMap.get(status) == null ? 'N/A' : getPercentValue(stWorkedStatusSLACountMap.get(status) / stWorkedStatusCountMap.get(status));
            
           Integer stWorkedAHTSummary;
           String stWorkedRekeyAHT;
           if(stWorkedStatusToCaseHandlingTimeSummaryMap.containsKey(status)){
                stWorkedAHTSummary = stWorkedStatusToCaseHandlingTimeSummaryMap.get(status);
                stWorkedRekeyAHT = stWorkedStatusToCaseHandlingTimeSummaryMap.get(status) == 0 || stWorkedAHTSummary == null ? 'N/A' : convertTimeIntervalToString(stWorkedAHTSummary / stWorkedStatusCountMap.get(status));    
                
            }
            
            
            StatusWrapper workedWrapper = new StatusWrapper(status, stWorkedStatusCountMap.get(status), stWorkedRekeyAHT, conversion, percentSLA);
            workedStatusWrappers.add(workedWrapper);
        }
        
        
    }
    
    private class CaseCompleteHistoryWrapper {//describe complete history of a single case
        Id CaseId;
        Case caseObj;
        
        Id holderId; //user for which this case be assigned for today work calculation it is last user, which holded ownership
        CaseHistorySortableWrapper holderOwnershipChangeWrapper;
        CaseHistorySortableWrapper lastOwnershipChangeWrapper;
        
        List<CaseHistorySortableWrapper> caseHistoryList;
        Integer caseHandlingTimeInSeconds=0; //case handling time for holder
        
        String currentUserRole;
        Set<Id> userIdSet;
        
        private CaseCompleteHistoryWrapper(Id caseId, String currentUserRole, Set<Id> userIdSet){
            this.caseId = caseId;
            this.currentUserRole = currentUserRole;
            this.userIdSet = userIdSet;
            caseHistoryList = new List<CaseHistorySortableWrapper>();
        }
        
        private void addCaseHistory(CaseHistory ch){
            CaseHistorySortableWrapper caseHistoryWrapper = new CaseHistorySortableWrapper(ch);
            caseHistoryList.add(caseHistoryWrapper);
        }
        
        private void sortAndProcess(){
            caseHistoryList.sort();
            if(caseHistoryList.size() != 0){ //size = 0 should never happen
                for(CaseHistorySortableWrapper chsWrapper : caseHistoryList){
                    if(chsWrapper.ch.Field == 'Owner' || chsWrapper.ch.Field == 'ownerAccepted' || chsWrapper.ch.Field == 'ownerAssignment'){
                        lastOwnershipChangeWrapper = chsWrapper;
                        if(String.valueOf(chsWrapper.ch.NewValue).startsWith('005') && userIdSet.contains(String.valueOf(chsWrapper.ch.NewValue))){
                            holderId = String.valueOf(chsWrapper.ch.NewValue);
                            holderOwnershipChangeWrapper = chsWrapper;
                        }
                    }
                }
                if(holderOwnershipChangeWrapper != null){
                    getCaseHandlingTimes();
                }
            }
        }
        
        private void getCaseHandlingTimes(){
            //populate caseHandlingTimeInSeconds
            system.debug('/*************lastOwnershipChangeWrapper'+lastOwnershipChangeWrapper);
            system.debug('/*************holderOwnershipChangeWrapper'+holderOwnershipChangeWrapper);
            /*if(holderOwnershipChangeWrapper == lastOwnershipChangeWrapper){
                Long intervalInMiliseconds = DateTime.now().getTime() - holderOwnershipChangeWrapper.ch.CreatedDate.getTime();
                this.caseHandlingTimeInSeconds = Integer.valueOf(intervalInMiliseconds / 1000);             
            }*/ if(holderOwnershipChangeWrapper != lastOwnershipChangeWrapper) {
                    Long intervalInMiliseconds = lastOwnershipChangeWrapper.ch.CreatedDate.getTime() - holderOwnershipChangeWrapper.ch.CreatedDate.getTime();
                    this.caseHandlingTimeInSeconds = Integer.valueOf(intervalInMiliseconds / 1000);         
                }             
        } 
        
        private void setCaseObj(Case c){
            this.caseObj = c;
        }
    }
    
    private class CaseHistorySortableWrapper implements Comparable { //enables sorting CaseHistory by CreatedDate
        CaseHistory ch;
        
        public CaseHistorySortableWrapper(CaseHistory ch){
            this.ch = ch;
        }
        
        public Integer compareTo(Object compareTo) {
            CaseHistorySortableWrapper compareToEmp = (CaseHistorySortableWrapper)compareTo;
            if (this.ch.CreatedDate == compareToEmp.ch.CreatedDate) return 0;
            if (this.ch.CreatedDate > compareToEmp.ch.CreatedDate) return 1;
            return -1;               
        } 
    }

    public class ConversionWrapper{
        public Integer count {get; set;}
        public String label {get; set;}
        public Integer total {get;set;}
        
        public ConversionWrapper(String label, Integer count, Integer total){
            this.count  = count;
            this.label = label;
            this.total = total;
        }
    }
    
    public class StatusWrapper{
        public String statusLabel {get;set;}
        public Integer count {get; set;}
        public String rekeyAHT {get;set;}
        public String conversion {get;set;}
        public String percentSLA {get;set;}  
        
        public StatusWrapper(String statusLabel, Integer count, String rekeyAHT){
            this.statusLabel = statusLabel;
            this.count  = count;
            this.rekeyAHT = rekeyAHT;
        }
        
        public StatusWrapper(String statusLabel, Integer count, String rekeyAHT, String conversion, String percentSLA){
            this.statusLabel = statusLabel;
            this.count  = count;          
            this.rekeyAHT = rekeyAHT;
            this.conversion = conversion;
            this.percentSLA = percentSLA;
        }                  
    }
    
    public class SummaryWrapper{
        public Integer numberOfUntouchedCases {get;set;} // correct
        public Integer numberOfCasesBeingWorked {get;set;}
        public Integer numberOfCasesWithinSLA {get;set;} //correct
        public Integer numberOfCasesOutSLA {get;set;}// correct
        public Integer activeUsers{get;set;} // correct
        
        public Integer numberOfCasesCompleted {get;set;} // correct
        public String NoSaleAht {get;set;}
        public String SaleAht {get;set;}
        public String globalConversion {get;set;}
        
        public SummaryWrapper(integer activeUsers,Integer numberOfUntouchedCases, Integer numberOfCasesBeingWorked, Integer numberOfCasesWithinSLA, Integer numberOfCasesOutSLA, Integer numberOfCasesCompleted, String SaleAht,string NoSaleAht,String globalConversion){
            this.numberOfUntouchedCases = numberOfUntouchedCases;
            this.numberOfCasesBeingWorked = numberOfCasesBeingWorked;
            this.numberOfCasesWithinSLA = numberOfCasesWithinSLA;
            this.numberOfCasesOutSLA = numberOfCasesOutSLA;
            this.numberOfCasesCompleted = numberOfCasesCompleted;
            this.SaleAht = SaleAht;
            this.NoSaleAht=NoSaleAht;
            this.globalConversion = globalConversion;
            this.activeUsers=activeUsers;
        }    
    }    
    
    public class UserWrapper{
        public String fullName {get;set;}
        public String username {get;set;}
        public String location {get;set;}
        
        public Integer casesTouchedToday {get;set;}
        public Integer casesCompletedToday {get;set;}
        public String todayCasesAHT {get;set;}
        public String currentCase {get;set;}
        public String timeOnCurrentCase {get;set;}
        public String conversion {get;set;}
        public Id CaseId{get;set;}
        Public Integer countOpenCase{get;set;}
        public String CaseOpenNumber{get;set;}
        public String totalLoginTime{get;set;}
        public String OccupancyPerc{get;set;}
        //Below helper variables are used also during summary wrapper creation
        Integer caseHandlingTimeSummary = 0; //In seconds
        Integer caseConvertedCount = 0;
        
        public UserWrapper(User u, Integer casesTouchedToday, Integer casesCompletedToday, String todayCasesAHT, String currentCase, String timeOnCurrentCase, String conversion, Integer caseHandlingTimeSummary, Integer caseConvertedCount,String CaseOpenNumber,Integer countOpenCase,String totalLoginTime,String OccupancyPerc,Id CaseId){
            this.fullName = u.Name;
            this.username = u.username ;
            this.location = u.User_Location__c;
            this.CaseOpenNumber=CaseOpenNumber;
            this.casesTouchedToday = casesTouchedToday ;
            this.casesCompletedToday = casesCompletedToday;
            this.todayCasesAHT = todayCasesAHT;
            this.currentCase = currentCase;
            this.timeOnCurrentCase = timeOnCurrentCase;
            this.conversion = conversion;
            this.caseHandlingTimeSummary = caseHandlingTimeSummary;
            this.caseConvertedCount = caseConvertedCount;
            this.countOpenCase=countOpenCase;
            this.totalLoginTime=totalLoginTime;
            this.CaseId=CaseId;
            this.OccupancyPerc=OccupancyPerc;
        }     
    }   
    
    /*   
      Wrapper Class for onhold Cases
    */
    public class OnHoldWrapper{
        
        public string Status{get;set;}
        public integer count{get;set;}
       
        public onHoldWrapper(String status,Integer count){
            
            this.status=status;
            this.count=count;
        }      
        
    }
    
     /*   
      Wrapper Class for Outbound Completed Cases by No Sale Reason
    */
    public class StatusNoSaleWrapper{
        
        public string callDisposition{get;set;}
        public integer firstCallCount{get;set;}
        public integer customerContatcedCount{get;set;}
        public integer customerCalledinCount{get;set;}
        public integer secondCallCount{get;set;}
        public integer reasonByCount{get;set;}
       
        public StatusNoSaleWrapper(String callDisposition,Integer firstCallCount,Integer customerContatcedCount,Integer customerCalledinCount,Integer secondCallCount,Integer reasonByCount ){
            
            this.callDisposition=callDisposition;
            this.firstCallCount=firstCallCount;
            this.customerContatcedCount=customerContatcedCount;
            this.customerCalledinCount=customerCalledinCount;
            this.secondCallCount=secondCallCount;
            //this.reasonByCount=reasonByCount;
            this.reasonByCount=firstCallCount+customerContatcedCount+customerCalledinCount+secondCallCount;
        }      
        
    }
    
    
     
     /*   
      Wrapper Class for Outbound Completed Cases by Order Status
    */
    public class OutBoundStatusWrapper{
        
        public string status{get;set;}
        public integer Count{get;set;}
        public String conversion{get;set;}
       
       
        public OutBoundStatusWrapper(String status,Integer Count,String conversion){
            
            this.status=status;
            this.Count=Count;
            this.conversion=conversion;
            
        }      
        
    }
    private static String getPercentValue(Long value){
        return String.valueOf(Integer.valueOf(value)) + ' %';
    }
    
    private static String convertTimeIntervalToString(Integer intervalInSeconds){
        Integer h = Integer.valueOf(Math.floor(intervalInSeconds / 3600));
        Integer m = Integer.valueOf(Math.floor(Math.mod(intervalInSeconds,3600) / 60));
        Integer s = Integer.valueOf(Math.floor(Math.mod(Math.mod(intervalInSeconds,3600),60)));
        String hString = String.valueOf(h);
        String mString = m < 10 ? '0' + m : String.valueOf(m);
        String sString = s < 10 ? '0' + s : String.valueOf(s);

        return hString + ':' + mString + ':' + sString;        
    }
     @TestVisible
    private static String convertTimeIntervalToString(Decimal intervalInSeconds){
        return convertTimeIntervalToString(Integer.valueOf(intervalInSeconds));
    } 
    
    /*

        methods to get value in seconds from the hh:mm:ss format of time

    */
    @TestVisible
    private Long getTimeInSeconds(String timeValueinString){   // string in hh:mm:ss 

       Long totalSeconds=0;
        if(timeValueinString!='N/A' && timeValueinString!=null){
            String[] timeValue=timeValueinString.split(':');
            system.debug('****************timeValue'+timeValue);
            Integer hours=timeValue[0]!=null?Integer.valueOf(timeValue[0]):0;
            Integer Minutes=timeValue[1]!=null?Integer.valueOf(timeValue[1]):0;
            Integer Seconds=timeValue[2]!=null?Integer.valueOf(timeValue[2]):0;
            totalSeconds=hours*60*60+Minutes*60+seconds;
        }
        
        system.debug('***********'+totalSeconds);
        return totalSeconds; 
    }
}