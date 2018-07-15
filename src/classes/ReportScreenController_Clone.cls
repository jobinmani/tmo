public class ReportScreenController_Clone{

    public transient List<UserWrapper> userWrappers {get;set;}
    Private transient List<UserWrapper> pageUserWrappers;
    public transient List<SummaryWrapper> summaryWrapper {get;set;}
    public transient List<StatusWrapper> unworkedStatusWrappers ;
    public transient List<StatusWrapper> workedStatusWrappers ;
    public transient List<ConversionWrapper> conversionWrappers ;
    
    private transient Set<String> fieldToTrackSet = new Set<String>();
    
    public String currentUserRole {get;set;}
    
    private Id rekeyProfileId;
    private Id outboudProfileId;
    
    private String rekeyQueueId;
    private String onHoldQueueId;
    private String finishedQueueId;
    private String outboundQueueId;
    
    private transient Map<Id, User> userMap = new Map<Id, User>();
    private  transient Map<Id, Case> caseMap = new Map<Id, Case>();
    transient Map<Id,List<CaseHistory>> mapCaseHistory;
    private  transient Map<Id, CaseCompleteHistoryWrapper> caseIdToCompleteCaseHistoryMap = new Map<Id, CaseCompleteHistoryWrapper>();
    private  transient Map<Id, List<CaseCompleteHistoryWrapper>> userIdToCasesCompleteHistoryMap = new Map<Id, List<CaseCompleteHistoryWrapper>>();
   // Long totalCaseprocesstime=0;
   Private transient map<Id,Long> mapidLogintime=new Map<Id,Long>();
    public ReportScreenController_Clone(){
        populateFieldToTrackSet();   
        populateProfileData();
       // populateCoachRole();
        populateQueueIds();
        calculateData();
    }
    
    private void populateFieldToTrackSet(){
        fieldToTrackSet.add('Owner');
        
        
        
        fieldToTrackSet.add('ownerAssignment');
        fieldToTrackSet.add('ownerAccepted');
        
        
       
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
        List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Name = 'Rekey Agent' OR Name = 'Outbound Agent' OR Name ='Rekey Coach' OR Name ='Telesales Manager' OR Name ='System Administrator'];
        for(Profile p : profiles){
            if(p.Name == 'Rekey Agent'){
                rekeyProfileId = p.Id;
            }
            if(p.Name == 'Outbound Agent'){
                outboudProfileId = p.Id;
            }
             if(p.Name == 'Rekey Coach'){
               
                currentUserRole = 'Rekey';
            }
            
        }

        currentUserRole = 'Rekey';      
    }
    
    
    public PageReference refresh(){   
        userIdToCasesCompleteHistoryMap.clear();
        caseIdToCompleteCaseHistoryMap.clear(); 
        if(userWrappers!=null)
                userWrappers.clear();
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
    }  
    
    private Set<Id> getAllOnlineUser(){
        List<AuthSession> listOfActiveUser=[SELECT   LastModifiedDate,LoginType,NumSecondsValid,SessionType,UsersId
                                            FROM AuthSession 
                                            WHERE SessionType = 'UI'
                                            AND LoginType = 'Application'];

    system.debug('********allActiveUser***************'+listOfActiveUser);
    
        Set<ID> setCurrentLoginUser=new Set<ID>();
        for(AuthSession authSessionObj:listOfActiveUser){
            setCurrentLoginUser.add(authSessionObj.UsersId);
        }
    
        return setCurrentLoginUser;
    }

        
    private transient map<Id,String> mapUserIdLogintime  =new map<Id,String>();
    Private void calculateTotalLoginTime(map<Id,User> mapUsers){
    
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
        if(currentUserRole == 'Rekey'){
            //userMap = new Map<Id,User>([SELECT Name, Id, ProfileId, Username, User_Location__c FROM User WHERE ProfileId =: rekeyProfileId and Id in :getAllOnlineUser()]);
             userMap = new Map<Id,User>([SELECT Name, Id, ProfileId, Username, User_Location__c FROM User WHERE ProfileId =: rekeyProfileId]);
            if(Test.isRunningTest()){
                 userMap = new Map<Id,User>([SELECT Name, Id, ProfileId, Username, User_Location__c FROM User WHERE ProfileId =: rekeyProfileId]);
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
        Time enTime= Time.newInstance(11,59,00,00);
        DateTime stDateTime = DateTime.newInstance(system.today(),stTime);
        DateTime enDateTime =stDateTime.addhours(24);// DateTime.newInstance(system.today(),enTime);
        system.debug('####################  '+stDateTime +'$$$$$$$$$$$$$$$$ '+enDateTime );
        List<CaseHistory> history;
        if(Test.isRunningTest()){
            history = [SELECT CaseId, OldValue, NewValue, Field, CreatedById, CreatedDate FROM CaseHistory ORDER BY CreatedDate LIMIT 1000];
        } else {    
            history = [SELECT CaseId, OldValue, NewValue, Field, CreatedById, CreatedDate FROM CaseHistory WHERE  CreatedDate >=: stDateTime  And CreatedDate <=: enDateTime   AND Field IN: fieldToTrackSet ORDER BY CreatedDate Desc];        
        }
        system.debug('Case  History++++++++++++++++ '+history);
        for(CaseHistory ch : history){
            if(!caseIdToCompleteCaseHistoryMap.containsKey(ch.CaseId)){
                caseIdToCompleteCaseHistoryMap.put(ch.CaseId, new CaseCompleteHistoryWrapper(ch.CaseId, currentUserRole, userMap.keySet()));
            }else{
            caseIdToCompleteCaseHistoryMap.get(ch.CaseId).addCaseHistory(ch);
            }
        }
        
        mapCaseHistory=new map<id,List<CaseHistory>>();
        for(CaseHistory hs:history){
                if(hs.field =='Owner'||hs.field =='ownerAssignment'||hs.field =='ownerAccepted'){
                  //  system.debug('==========caseID'+hs.caseID+'==========hs'+hs);
                    if(!mapCaseHistory.containsKey(hs.caseId))
                        mapCaseHistory.put(hs.caseId,new List<CaseHistory>{hs});
                    else
                        mapCaseHistory.get(hs.caseId).add(hs);
                }
        }
    }
    
     private void populateCaseMap(){
        Set<Id> casesFromHistoryIdSet = new Set<Id>();
        for(Id caseId : caseIdToCompleteCaseHistoryMap.keySet()){
            casesFromHistoryIdSet.add(caseId);
        } 
        
        caseMap = new Map<Id,Case>([SELECT Id, Last_OwnerID__c ,CreatedDate,CaseNumber,TOM_Order_Number__c,OwnerId, Outbound_Status_Formula__c, SLA_Time_Outbound__c, SLA_time__c, Elapsed_time__c, Rekey_Status__c, Call_Disposition_Formula__c, Call_Disposition_Reason__c FROM Case WHERE Id IN: casesFromHistoryIdSet]);  
        
    }

    private void populateAdditionalDataOnHistoryWrappers(){
        for(CaseCompleteHistoryWrapper wrapper : caseIdToCompleteCaseHistoryMap.values()){
            wrapper.setCaseObj(caseMap.get(wrapper.caseId));
            wrapper.sortAndProcess();
            if(wrapper.holderId == null){ //untouched case in queue.
                continue;
            }
            if(!userIdToCasesCompleteHistoryMap.containsKey(wrapper.holderId)){
                userIdToCasesCompleteHistoryMap.put(wrapper.holderId, new List<CaseCompleteHistoryWrapper>());
            }
            userIdToCasesCompleteHistoryMap.get(wrapper.holderId).add(wrapper);
        }    
    }

   
    
    
    private void populateWrappers(){
        //user wrappers
        userWrappers = new List<UserWrapper>();
        Set<Id> setOnlineUser=new Set<Id>();
        Set<ID> setActiveRekeyAgent=new set<Id>();
        transient map<id,integer> openCaseMap = new map<id,integer>();
        transient map<id,list<case>> openCaseRecmap = new map<id,list<case>>();
        setOnlineUser.addAll(getAllOnlineUser());
        transient list<AggregateResult> openCasesLst = [select count(id) oc,ownerid oi from case where ownerid IN :userMap.keySet() Group By ownerid];
        transient list<case> openLstCase = [Select id,caseNumber,status,ownerid,createdDate from case where ownerid IN :userMap.keySet() Order By createdDate ASC];
        for(case ca:openLstCase){
            if(!openCaseRecmap.containsKey(ca.ownerid)){
                openCaseRecmap.put(ca.ownerid,new list<case>{ca});
            }else{
                openCaseRecmap.get(ca.ownerid).add(ca);
            }
        }
        for(AggregateResult ag:openCasesLst){
            openCaseMap.put(string.valueOf(ag.get('oi')),integer.valueOf(ag.get('oc')));            
        }
      //  map<Id,Integer> mapIDLoginTimeInMin=ReportScreenController_Clone.populateTotalLogintime(setOnlineUser);
        for(User usr : userMap.values()){
            Integer uCaseHandlingTimeSummary = 0;
            Integer uCaseConvertedCount = 0;
            Integer uCountOpenCase=0;
            String uCaseOpenNumber;
            Id uCaseId;
            Set<Id> uCaseTouchedTodaySet = new Set<Id>();
            Set<Id> uCaseCompletedTodaySet = new Set<Id>();
            Set<string> uCaseConveretdTodaySet =new Set<string>();
            CaseCompleteHistoryWrapper uMostRecentlyUpdateCaseWrapper = null;
            datetime assigntime;
            
            if(openCaseRecmap.containsKey(usr.id)){
                        uCaseOpenNumber=openCaseRecmap.get(usr.id)[0].caseNumber;//caseMap.get(cchWrapper.caseId).caseNumber;
                        uCaseId=openCaseRecmap.get(usr.id)[0].id;
                        }
            uCountOpenCase = openCaseMap.containskey(usr.Id)?openCaseMap.get(usr.id):0;
            long totalOpenCasetimeinMS=0;
            if(userIdToCasesCompleteHistoryMap.get(usr.Id) != null){
            for(CaseCompleteHistoryWrapper cchWrapper : userIdToCasesCompleteHistoryMap.get(usr.Id)){
            
                // Cases touched today calculation
                uCaseTouchedTodaySet.add(cchWrapper.caseId);
                
             
                
               // Current case calculation
                if((caseMap.containsKey(cchWrapper.caseId))){
                    uMostRecentlyUpdateCaseWrapper = cchWrapper;
                    system.debug('-----------mapCaseHistory'+mapCaseHistory.size());
                    if(mapCaseHistory.containsKey(cchWrapper.caseId)){
                        for(CaseHistory chistory:mapCaseHistory.get(cchWrapper.caseId)){
                             //string newOwnerID=String.valueOf(chistory.newValue);
                             string newOwnerID=String.valueOf(caseMap.get(cchWrapper.caseId).ownerID);
                             string oldOwnerID=String.valueOF(chistory.oldValue);
                             string userId=String.valueOf(usr.Id);
                             
                            system.debug('===========>newOwnerID='+newOwnerID+'---------finishedQueueId='+finishedQueueId);                            
                            system.debug('-------------------userId>='+userId+'--------->oldOwnerID=='+oldOwnerID+'----------->chistory'+caseMap.get(cchWrapper.caseId).last_ownerID__c);
                            if( newOwnerID==userId && oldOwnerID==rekeyQueueId && ((caseMap.get(cchWrapper.caseId).TOM_Order_Number__c=='' || caseMap.get(cchWrapper.caseId).TOM_Order_Number__c==null) && caseMap.get(cchWrapper.caseId).OwnerId == usr.Id )){
                                assigntime=chistory.createdDate;
                                //uCountOpenCase++;
                                system.debug('chistory===>'+chistory+'**************assigntime'+assigntime+'*********-->'+userId);
                                totalOpenCasetimeinMS=totalOpenCasetimeinMS+(System.now().getTime()-assigntime.getTime());
                            }
                            System.debug('Case Number Completed::'+caseMap.get(cchWrapper.caseId).caseNumber);
                             System.debug('Is Out Bound::'+(newOwnerID==outboundQueueId && oldOwnerID==userId) );
                              System.debug('OutBound Value'+newOwnerID+'=='+outboundQueueId+ '&&'+oldOwnerID+'=='+userId);
                               System.debug('is Finished::'+oldOwnerID+'=='+userId +' &&'+ newOwnerID+'=='+ finishedQueueId);
                               
                                System.debug('is Rekey Finish::'+oldOwnerid +'=='+ rekeyQueueId +'&&'+ newOwnerID +'=='+finishedQueueId);
                                
                            if( (newOwnerID==outboundQueueId && oldOwnerID==userId) || (oldOwnerID==userId  && newOwnerID== finishedQueueId) ||(newOwnerID==onHoldQueueId  && oldOwnerid==rekeyQueueId )||(newOwnerID==onHoldQueueId && oldOwnerid==userid)||(oldOwnerid == rekeyQueueId && newOwnerID ==finishedQueueId)  ){
                                 System.debug('Case Number Completed In::'+caseMap.get(cchWrapper.caseId).caseNumber);
                                uCaseCompletedTodaySet.add(cchWrapper.caseId);
                                
                                
                            }
                            system.debug('########## '+uCaseCompletedTodaySet.size());
                          
                            if(currentUserRole == 'Rekey' && caseMap.get(cchWrapper.caseId).Rekey_Status__c == 'Sale Complete (Express Checkout)' && ((oldOwnerID==userId || (caseMap.get(cchWrapper.caseId).last_ownerID__c==userId)) && caseMap.get(cchWrapper.caseId).ownerID== finishedQueueId)){
                                   uCaseConveretdTodaySet.add(cchWrapper.caseId);
                            }
                            
                            
                        }   
                        
                    }
                    
                }
                
                   // Cases completed today calculation
               
                  
                     
                    /*if(currentUserRole == 'Rekey' && (caseMap.containsKey(cchWrapper.caseId))&& (String.valueOf(caseMap.get(cchWrapper.caseId).OwnerId).startsWith('005') && (caseMap.get(cchWrapper.caseId).TOM_Order_Number__c=='' || caseMap.get(cchWrapper.caseId).TOM_Order_Number__c==null))){
                        //uCountOpenCase++;
                       
                    }*/
                    
                 
                
                // AHT calculation
                uCaseHandlingTimeSummary = uCaseHandlingTimeSummary + cchWrapper.caseHandlingTimeInSeconds;
                
                //Conversion calculation
                
            }
            uCaseConvertedCount=uCaseConveretdTodaySet.size();
            uCaseConveretdTodaySet.clear();
            system.debug('*************uCaseConvertedCount'+uCaseConvertedCount+'--------------'+uCaseCompletedTodaySet.size());
            }
            Integer totalOpenCasetimeinSec=Integer.valueOf(totalOpenCasetimeinMS/1000);
            
            Integer uCasesTouchedToday = uCaseTouchedTodaySet.size();
            Integer uCasesCompletedToday = uCaseCompletedTodaySet.size();
            String uTodayCasesAHT = uCasesCompletedToday == 0 ? 'N/A' : convertTimeIntervalToString(uCaseHandlingTimeSummary / uCasesCompletedToday);
            String uCurrentCase = uMostRecentlyUpdateCaseWrapper == null ? 'None' : uMostRecentlyUpdateCaseWrapper.caseId;
            //system.debug('************uCountOpenCase'+uCountOpenCase);
             String uTimeOnCurrentCase;
            if(uCountOpenCase!=0)
                uTimeOnCurrentCase = uCurrentCase == null || uCurrentCase == 'None' ? 'N/A' : convertTimeIntervalToString(totalOpenCasetimeinSec/uCountOpenCase);
            //system.debug('*********uCaseConvertedCount'+uCaseConvertedCount+'*----------'+uCasesCompletedToday);
            decimal conversionValue=0;
            if(uCasesCompletedToday!=0 && uCaseConvertedCount<=uCasesCompletedToday){
                 decimal convCount=Decimal.valueOf(uCaseConvertedCount);
                 decimal caseCmplttdy=decimal.valueOf(uCasesCompletedToday);
                 conversionValue=convCount/caseCmplttdy;
                
            }
              // system.debug('********--------conversionValue'+conversionValue);
            String uConversion = uCasesCompletedToday == 0 ? 'N/A' :((conversionValue)*100).setScale(2)+'%' ;        
            // system.debug('***********-------uConversion'+mapUserIdLogintime);
            Long utotalLoginTimeInSec=getTimeInSeconds(mapUserIdLogintime.containsKey(usr.id)?mapUserIdLogintime.get(usr.id):'N/A');
            //system.debug('--------------------*************>'+uTimeOnCurrentCase);
            Long utotalTimeOnCurrentCaseInSec=getTimeInSeconds(uTimeOnCurrentCase);
            //system.debug('************'+utotalTimeOnCurrentCaseInSec+'============uCaseHandlingTimeSummary'+uCaseHandlingTimeSummary+'----utotalLoginTimeInSec'+utotalLoginTimeInSec);
            
            Long utotalTimeOnCaseInSec=utotalTimeOnCurrentCaseInSec+uCasesCompletedToday*getTimeInSeconds(uTodayCasesAHT);
            //system.debug('***********------------>utotalTimeOnCaseInSec'+utotalTimeOnCaseInSec);
            if(utotalLoginTimeInSec<utotalTimeOnCaseInSec){
                utotalLoginTimeInSec=utotalLoginTimeInSec+utotalTimeOnCaseInSec;
                mapidLogintime.put(usr.id,utotalLoginTimeInSec);
            }else if(mapidLogintime.containsKey(usr.id)){
                utotalLoginTimeInSec=utotalLoginTimeInSec+mapidLogintime.get(usr.id);
            }
            //integer logintimeInSec=mapIDLoginTimeInMin.containsKey(usr.Id)?(mapIDLoginTimeInMin.get(usr.Id))*60:0;
            integer logintimeInSec=0;
            String LoginTime=convertTimeIntervalToString(logintimeInSec);
           
            decimal uOccupancy=logintimeInSec!=0?decimal.valueOf(utotalTimeOnCaseInSec)/decimal.valueOf(logintimeInSec).setScale(2):0;
           // system.debug('************----------**-----'+uOccupancy);
            String uOccupancyPerc=uOccupancy==0?'N/A':(uOccupancy*100).setScale(2)+'%';
           // system.debug('************---------------uOccupancyPerc'+uOccupancyPerc);
            Boolean isActive=false;
            system.debug('================>setOnlineUser'+setOnlineUser);
            if(setOnlineUser.contains(usr.Id)){
                isActive=true;
                setActiveRekeyAgent.add(usr.Id);
            }   
               // isActive=true;pageUserWrappers;
            UserWrapper uWrapper = new UserWrapper(userMap.get(usr.Id), uCasesTouchedToday, uCasesCompletedToday, uTodayCasesAHT, uCurrentCase, uTimeOnCurrentCase, uConversion, uCaseHandlingTimeSummary, uCaseConvertedCount,uCaseOpenNumber,uCountOpenCase,LoginTime,uOccupancyPerc,isActive,uCaseId);
            userWrappers.add(uWrapper);
            
            
        }

        //summary wrapper variables
        Integer sNumberOfUntouchedCases = 0;
        Integer sNumberOfCasesBeingWorked = 0;
        Integer sNumberOfCasesWithinSLA = 0;
        Integer sNumberOfCasesOutSLA = 0;
        
        Decimal sNumberOfCasesCompleted = 0;
        String sGlobalAHT;
        String sGlobalConversion;      
        
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
        Set<String> setRekeyAgents=new Set<String>();
        for(user userID:userMap.values()){
            
            setRekeyAgents.add(String.valueOF(userID.id));
        }  
        userMap.clear(); // clear map       
                 
        for(Case c : caseMap.values()){   
        
            string caseOwnerId=String.valueOf(c.ownerID);
            if(mapCaseHistory.containsKey(c.id)){
                for(CaseHistory chistory:mapCaseHistory.get(c.id)){
                     string oldOwnerid=String.valueOf(chistory.oldValue);
                     string newOwnerId=String.valueOf(chistory.newValue);
                     system.debug('*************chistory*'+chistory);
                     //system.debug('******---------'+setUserIDs);
                    
                    if(setRekeyAgents.contains(caseOwnerId)  && oldOwnerid==rekeyQueueId){
                        //assigntime=chistory.createdDate;
                        sNumberOfCasesBeingWorked++;
                        //system.debug('**************assigntime'+assigntime);
                    }
                    
                                                                                               
                }                            
            }      
            
            
            
            

        }
        if(currentUserRole == 'Rekey'){
               
               list<case> lstRekeycases= [select id,createdDate,ownerid from case where ownerid = :rekeyQueueId ];
               
                sNumberOfUntouchedCases = lstRekeycases.size();
                system.debug('############ '+sNumberOfUntouchedCases );
                
                for(case cs:lstRekeycases){
                    if(((system.now().getTime() - cs.createdDate.getTime())/1000/60) > 10){
                        sNumberOfCasesOutSLA++;                 
                    }else{
                        sNumberOfCasesWithinSLA++;
                        
                    }
                }
                
            }
        //summary wrapper
        Integer sGlobalCaseHandlingTimeSummary = 0;
        decimal sGlobalConversionCount = 0;
        Integer activeUsers=setActiveRekeyAgent.size();
        for(UserWrapper uWrapper : userWrappers){
            sGlobalCaseHandlingTimeSummary = sGlobalCaseHandlingTimeSummary + Integer.valueOf(getTimeInSeconds(uWrapper.todayCasesAHT));
            sGlobalConversionCount  = sGlobalConversionCount + decimal.valueOf(uWrapper.caseConvertedCount);
            sNumberOfCasesCompleted = sNumberOfCasesCompleted + decimal.valueOf(uWrapper.casesCompletedToday);
        }
        sNumberOfCasesCompleted=sNumberOfCasesCompleted;
        sGlobalAHT = sNumberOfCasesCompleted == 0 ? 'N/A' : convertTimeIntervalToString(sGlobalCaseHandlingTimeSummary / sNumberOfCasesCompleted);
      
        sGlobalConversion = sNumberOfCasesCompleted == 0 ? 'N/A' :((sGlobalConversionCount/sNumberOfCasesCompleted)*100).setScale(2)+'%';
       
        summaryWrapper = new List<SummaryWrapper>();
        summaryWrapper.add(new SummaryWrapper(activeUsers,sNumberOfUntouchedCases, sNumberOfCasesBeingWorked, sNumberOfCasesWithinSLA, sNumberOfCasesOutSLA, Integer.valueOf(sNumberOfCasesCompleted), sGlobalAHT, sGlobalConversion));
                        
        //status wrappers
        Map<String, Integer> stWorkedStatusToCaseHandlingTimeSummaryMap = new Map<String, Integer>();
        Map<String, Integer> stUnworkedStatusToCaseHandlingTimeSummaryMap = new Map<String, Integer>();
        
        for(CaseCompleteHistoryWrapper cchWrapper : caseIdToCompleteCaseHistoryMap.values()){
            if(caseMap.containsKey(cchWrapper.caseId)){
                   
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
                        if(cchWrapper.caseHandlingTimeInSeconds==null)
                            cchWrapper.caseHandlingTimeInSeconds=0;
                        if(stUnworkedStatusToCaseHandlingTimeSummaryMap.containsKey(status))
                            stUnworkedStatusToCaseHandlingTimeSummaryMap.put(status, stUnworkedStatusToCaseHandlingTimeSummaryMap.get(status) + cchWrapper.caseHandlingTimeInSeconds);
                
            }
            }
        }        
        
        unworkedStatusWrappers = new List<StatusWrapper>();
        workedStatusWrappers = new List<StatusWrapper>();        
        for(String status : stUnworkedStatusCountMap.keySet()){
            Integer stUnworkedAHTSummary = stUnworkedStatusToCaseHandlingTimeSummaryMap.get(status);
            String stUnworkedRekeyAHT = stUnworkedStatusCountMap.get(status) == 0 || stUnworkedAHTSummary == null ? 'N/A' : convertTimeIntervalToString(stUnworkedAHTSummary / stUnworkedStatusCountMap.get(status));
            
            StatusWrapper unworkedWrapper = new StatusWrapper(status, stUnworkedStatusCountMap.get(status), stUnworkedRekeyAHT);
            //unworkedStatusWrappers.add(unworkedWrapper);
            
            String conversion = stWorkedStatusCountMap.get(status) == 0 || stWorkedStatusConversionCountMap.get(status) == null? 'N/A' : getPercentValue(stWorkedStatusConversionCountMap.get(status) / stWorkedStatusCountMap.get(status));
            String percentSLA = stWorkedStatusCountMap.get(status) == 0 || stWorkedStatusSLACountMap.get(status) == null ? 'N/A' : getPercentValue(stWorkedStatusSLACountMap.get(status) / stWorkedStatusCountMap.get(status));
            
            Integer stWorkedAHTSummary = stWorkedStatusToCaseHandlingTimeSummaryMap.get(status);
            String stWorkedRekeyAHT = stWorkedStatusToCaseHandlingTimeSummaryMap.get(status) == 0 || stWorkedAHTSummary == null ? 'N/A' : convertTimeIntervalToString(stWorkedAHTSummary / stWorkedStatusCountMap.get(status));
            
            StatusWrapper workedWrapper = new StatusWrapper(status, stWorkedStatusCountMap.get(status), stWorkedRekeyAHT, conversion, percentSLA);
            //workedStatusWrappers.add(workedWrapper);
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
            if(holderOwnershipChangeWrapper == lastOwnershipChangeWrapper){
                Long intervalInMiliseconds = DateTime.now().getTime() - holderOwnershipChangeWrapper.ch.CreatedDate.getTime();
                this.caseHandlingTimeInSeconds = Integer.valueOf(intervalInMiliseconds / 1000);             
            } else {
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
        public Integer numberOfUntouchedCases {get;set;}
        public Integer numberOfCasesBeingWorked {get;set;}
        public Integer numberOfCasesWithinSLA {get;set;}
        public Integer numberOfCasesOutSLA {get;set;}
        public Integer activeUsers{get;set;}
        
        public Integer numberOfCasesCompleted {get;set;}
        public String globalAHT {get;set;}
        public String globalConversion {get;set;}
        
        public SummaryWrapper(integer activeUsers,Integer numberOfUntouchedCases, Integer numberOfCasesBeingWorked, Integer numberOfCasesWithinSLA, Integer numberOfCasesOutSLA, Integer numberOfCasesCompleted, String globalAHT, String globalConversion){
            this.numberOfUntouchedCases = numberOfUntouchedCases;
            this.numberOfCasesBeingWorked = numberOfCasesBeingWorked;
            this.numberOfCasesWithinSLA = numberOfCasesWithinSLA;
            this.numberOfCasesOutSLA = numberOfCasesOutSLA;
            this.numberOfCasesCompleted = numberOfCasesCompleted;
            this.globalAHT = globalAHT;
            this.globalConversion = globalConversion;
            this.activeUsers=activeUsers;
        }    
    }    
    
    public class UserWrapper{
        public String fullName {get;set;}
        public String username {get;set;}
        public String location {get;set;}
        public Boolean isActive{get;set;}
        public Integer casesTouchedToday {get;set;}
        public Integer casesCompletedToday {get;set;}
        public String todayCasesAHT {get;set;}
        public String currentCase {get;set;}
        public String timeOnCurrentCase {get;set;}
        public String conversion {get;set;}
        
        Public Integer countOpenCase{get;set;}
        public String CaseOpenNumber{get;set;}
        public String totalLoginTime{get;set;}
        public String OccupancyPerc{get;set;}
         public Id CaseId{get;set;}
        //Below helper variables are used also during summary wrapper creation
        Integer caseHandlingTimeSummary = 0; //In seconds
        Integer caseConvertedCount = 0;
        
        public UserWrapper(User u, Integer casesTouchedToday, Integer casesCompletedToday, String todayCasesAHT, String currentCase, String timeOnCurrentCase, String conversion, Integer caseHandlingTimeSummary, Integer caseConvertedCount,String CaseOpenNumber,Integer countOpenCase,String totalLoginTime,String OccupancyPerc,boolean isActive,Id CaseId){
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
            this.isActive=isActive;
            this.OccupancyPerc=OccupancyPerc;
            this.CaseId=CaseId;
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
    
    private static String convertTimeIntervalToString(Decimal intervalInSeconds){
        return convertTimeIntervalToString(Integer.valueOf(intervalInSeconds));
    } 
    
    /*

        methods to get value in seconds from the hh:mm:ss format of time

    */
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