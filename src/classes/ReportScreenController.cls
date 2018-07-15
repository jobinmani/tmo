public class ReportScreenController{

    public List<UserWrapper> userWrappers {get;set;}
    public List<SummaryWrapper> summaryWrapper {get;set;}
    public List<StatusWrapper> unworkedStatusWrappers {get;set;}
    public List<StatusWrapper> workedStatusWrappers {get;set;}
    public List<ConversionWrapper> conversionWrappers {get;set;}
    
    private Set<String> fieldToTrackSet = new Set<String>();
    
    public String currentUserRole {get;set;}
    
    private Id rekeyProfileId;
    private Id outboudProfileId;
    
    private Id rekeyQueueId;
    private Id onHoldQueueId;
    private Id finishedQueueId;
    private Id outboundQueueId;
    
    private Map<Id, User> userMap = new Map<Id, User>();
    private Map<Id, Case> caseMap = new Map<Id, Case>();
    private Map<Id, CaseCompleteHistoryWrapper> caseIdToCompleteCaseHistoryMap = new Map<Id, CaseCompleteHistoryWrapper>();
    private Map<Id, List<CaseCompleteHistoryWrapper>> userIdToCasesCompleteHistoryMap = new Map<Id, List<CaseCompleteHistoryWrapper>>();
    
    public ReportScreenController(){
        populateFieldToTrackSet();   
        populateProfileData();
        populateCoachRole();
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
        List<QueueSObject> queues = [SELECT Id, Queue.Name, Queue.Id FROM QueueSobject WHERE Queue.Name = 'Rekey' OR Queue.Name = 'Outbound' OR Queue.Name = 'OnHold' OR Queue.Name = 'Finish'];
        for(QueueSObject q : queues){
            if(q.Queue.Name == 'Rekey'){
                rekeyQueueId = q.Queue.Id;
            } else if(q.Queue.Name == 'Outbound'){
                outboundQueueId = q.Queue.Id;
            } else if(q.Queue.Name == 'On Hold'){
                onHoldQueueId = q.Queue.Id;
            } else if(q.Queue.Name == 'Finish'){
                finishedQueueId = q.Queue.Id;
            }
        }   
    }
    
    private void populateProfileData(){
        List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Name = 'Rekey' OR Name = 'Outbound'];
        for(Profile p : profiles){
            if(p.Name == 'Rekey'){
                rekeyProfileId = p.Id;
            }
            if(p.Name == 'Outbound'){
                outboudProfileId = p.Id;
            }
        }    
    }
    
    private void populateCoachRole(){
        User currentUser = [SELECT Id, ProfileId, UserRole.DeveloperName FROM User WHERE Id =: UserInfo.getUserId()];
        if(currentUser.UserRole.DeveloperName == 'Outbound_Coach'){
            currentUserRole = 'Outbound';
        } else if(currentUser.UserRole.DeveloperName == 'Rekey_Coach'){
            currentUserRole = 'Rekey';
        }
    }
    
    public PageReference refresh(){    
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
    
    private void populateUserMap(){
        if(currentUserRole == 'Rekey'){
            userMap = new Map<Id,User>([SELECT Name, Id, ProfileId, Username, User_Location__c FROM User WHERE ProfileId =: rekeyProfileId]);
        } else if(currentUserRole == 'Outbound'){
            userMap = new Map<Id,User>([SELECT Name, Id, ProfileId, Username, User_Location__c FROM User WHERE ProfileId =: outboudProfileId]);
        }
    }
    
    private void populateCaseHistoryMaps(){
        Set<Id> userIdSet = new Set<Id>();
        for(User u : userMap.values()){
            userIdSet.add(u.Id);
        } 
        List<CaseHistory> history;
        if(Test.isRunningTest()){
            history = [SELECT CaseId, OldValue, NewValue, Field, CreatedById, CreatedDate FROM CaseHistory ORDER BY CreatedDate LIMIT 1000];
        } else {    
            history = [SELECT CaseId, OldValue, NewValue, Field, CreatedById, CreatedDate FROM CaseHistory WHERE CreatedDate >: DateTime.now().addHours(-12) AND Field IN: fieldToTrackSet ORDER BY CreatedDate];        
        }
        for(CaseHistory ch : history){
            if(!caseIdToCompleteCaseHistoryMap.containsKey(ch.CaseId)){
                caseIdToCompleteCaseHistoryMap.put(ch.CaseId, new CaseCompleteHistoryWrapper(ch.CaseId, currentUserRole, userMap.keySet()));
            }
            caseIdToCompleteCaseHistoryMap.get(ch.CaseId).addCaseHistory(ch);
        }
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

    private void populateCaseMap(){
        Set<Id> casesFromHistoryIdSet = new Set<Id>();
        for(Id caseId : caseIdToCompleteCaseHistoryMap.keySet()){
            casesFromHistoryIdSet.add(caseId);
        }    
        caseMap = new Map<Id,Case>([SELECT Id, OwnerId, Outbound_Status_Formula__c, SLA_Time_Outbound__c, SLA_time__c, Elapsed_time__c, Rekey_Status__c, Call_Disposition_Formula__c, Call_Disposition_Reason__c FROM Case WHERE Id IN: casesFromHistoryIdSet]);  
    }
    
    
    private void populateWrappers(){
        //user wrappers
        userWrappers = new List<UserWrapper>();
        for(User usr : userMap.values()){
            Integer uCaseHandlingTimeSummary = 0;
            Integer uCaseConvertedCount = 0;
        
            Set<Id> uCaseTouchedTodaySet = new Set<Id>();
            Set<Id> uCaseCompletedTodaySet = new Set<Id>();
            CaseCompleteHistoryWrapper uMostRecentlyUpdateCaseWrapper = null;
            
            if(userIdToCasesCompleteHistoryMap.get(usr.Id) != null){
            for(CaseCompleteHistoryWrapper cchWrapper : userIdToCasesCompleteHistoryMap.get(usr.Id)){
            
                // Cases touched today calculation
                uCaseTouchedTodaySet.add(cchWrapper.caseId);
                
                // Cases completed today calculation
                if(currentUserRole == 'Rekey'){
                    if(caseMap.get(cchWrapper.caseId).Rekey_Status__c != null && caseMap.get(cchWrapper.caseId).Rekey_Status__c != 'System Downtime' && !String.valueOf(caseMap.get(cchWrapper.caseId).OwnerId).startsWith('005')){
                        uCaseCompletedTodaySet.add(cchWrapper.caseId);
                    }
                } else if(currentUserRole == 'Outbound'){
                    if(String.valueOf(caseMap.get(cchWrapper.caseId).OwnerId) == finishedQueueId){
                        uCaseCompletedTodaySet.add(cchWrapper.caseId);
                    }
                }
                
                // Current case calculation
                if(caseMap.get(cchWrapper.caseId).OwnerId == usr.Id && (uMostRecentlyUpdateCaseWrapper == null || uMostRecentlyUpdateCaseWrapper.holderOwnershipChangeWrapper.ch.CreatedById < cchWrapper.holderOwnershipChangeWrapper.ch.CreatedById)){
                    uMostRecentlyUpdateCaseWrapper = cchWrapper;
                }
                
                // AHT calculation
                uCaseHandlingTimeSummary = uCaseHandlingTimeSummary + cchWrapper.caseHandlingTimeInSeconds;
                
                //Conversion calculation
                if(currentUserRole == 'Rekey'){
                    if(caseMap.get(cchWrapper.caseId).Rekey_Status__c == 'Sale Complete'){
                        uCaseConvertedCount++;
                    }
                } else if(currentUserRole == 'Outbound'){
                    if(caseMap.get(cchWrapper.caseId).Call_Disposition_Formula__c == 'Sale'){
                        uCaseConvertedCount++;
                    }                
                }
            }
            }
            Integer uCasesTouchedToday = uCaseTouchedTodaySet.size();
            Integer uCasesCompletedToday = uCaseCompletedTodaySet.size();
            String uTodayCasesAHT = uCasesCompletedToday == 0 ? 'N/A' : convertTimeIntervalToString(uCaseHandlingTimeSummary / uCasesCompletedToday);
            String uCurrentCase = uMostRecentlyUpdateCaseWrapper == null ? 'None' : uMostRecentlyUpdateCaseWrapper.caseId;
            String uTimeOnCurrentCase = uCurrentCase == null || uCurrentCase == 'None' ? 'N/A' : caseMap.get(uCurrentCase).Elapsed_time__c;
            String uConversion = uCasesCompletedToday == 0 ? 'N/A' : getPercentValue(uCaseConvertedCount / uCasesCompletedToday);        
        
            UserWrapper uWrapper = new UserWrapper(userMap.get(usr.Id), uCasesTouchedToday, uCasesCompletedToday, uTodayCasesAHT, uCurrentCase, uTimeOnCurrentCase, uConversion, uCaseHandlingTimeSummary, uCaseConvertedCount);
            userWrappers.add(uWrapper);
        }

        //summary wrapper variables
        Integer sNumberOfUntouchedCases = 0;
        Integer sNumberOfCasesBeingWorked = 0;
        Integer sNumberOfCasesWithinSLA = 0;
        Integer sNumberOfCasesOutSLA = 0;
        
        Integer sNumberOfCasesCompleted = 0;
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
        
        for(Case c : caseMap.values()){   
            if(currentUserRole == 'Outbound'){
                if(c.Rekey_Status__c == 'Sale Complete'){
                    cSaleCount++;
                } else {
                    if(!cConversionStatusCountMap.containsKey(c.Call_Disposition_Reason__c)){
                        cConversionStatusCountMap.put(c.Call_Disposition_Reason__c, 0);
                    }
                    cConversionStatusCountMap.put(c.Call_Disposition_Reason__c, cConversionStatusCountMap.get(c.Call_Disposition_Reason__c) + 1);
                }
            } else if(currentUserRole == 'Rekey'){
                //TODO put logic here
            }
            
            if(currentUserRole == 'Rekey'){
                if(caseIdToCompleteCaseHistoryMap.get(c.Id).holderId == null){//c.OwnerId == rekeyQueueId){
                    sNumberOfUntouchedCases++;
                } else if(String.valueOf(c.OwnerId).startsWith('005')){
                    sNumberOfCasesBeingWorked++;
                }
            } else if(currentUserRole == 'Outbound'){
                if(caseIdToCompleteCaseHistoryMap.get(c.Id).holderId == null){//c.OwnerId == outboundQueueId){
                    sNumberOfUntouchedCases++;
                    if(!stUnworkedStatusCountMap.containsKey(c.Rekey_Status__c)){
                        stUnworkedStatusCountMap.put(c.Rekey_Status__c, 0);
                    }
                        stUnworkedStatusCountMap.put(c.Rekey_Status__c, stUnworkedStatusCountMap.get(c.Rekey_Status__c) + 1);                    
                }else if(String.valueOf(c.OwnerId).startsWith('005')){
                    sNumberOfCasesBeingWorked++;
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
            }
            
            if(currentUserRole == 'Rekey'){
                if(c.SLA_time__c < DateTime.now()){
                    sNumberOfCasesOutSLA++;
                } else {
                    sNumberOfCasesWithinSLA++;
                }
            } else if(currentUserRole == 'Outbound' && c.OwnerId != onHoldQueueId){
                if(c.SLA_Time_Outbound__c < DateTime.now()){
                    sNumberOfCasesOutSLA++;
                } else {
                    sNumberOfCasesWithinSLA++;
                }
            }                            
        }
        
        //summary wrapper
        Integer sGlobalCaseHandlingTimeSummary = 0;
        Integer sGlobalConversionCount = 0;
        for(UserWrapper uWrapper : userWrappers){
            sGlobalCaseHandlingTimeSummary = sGlobalCaseHandlingTimeSummary + uWrapper.caseHandlingTimeSummary;
            sGlobalConversionCount  = sGlobalConversionCount + uWrapper.caseConvertedCount;
            sNumberOfCasesCompleted = sNumberOfCasesCompleted + uWrapper.casesCompletedToday;
        }
        sGlobalAHT = sNumberOfCasesCompleted == 0 ? 'N/A' : convertTimeIntervalToString(sGlobalCaseHandlingTimeSummary / sNumberOfCasesCompleted);
        sGlobalConversion = sNumberOfCasesCompleted == 0 ? 'N/A' : getPercentValue(sGlobalConversionCount/ sNumberOfCasesCompleted);
        
        summaryWrapper = new List<SummaryWrapper>();
        summaryWrapper.add(new SummaryWrapper(sNumberOfUntouchedCases, sNumberOfCasesBeingWorked, sNumberOfCasesWithinSLA, sNumberOfCasesOutSLA, sNumberOfCasesCompleted, sGlobalAHT, sGlobalConversion));
                        
        //status wrappers
        Map<String, Integer> stWorkedStatusToCaseHandlingTimeSummaryMap = new Map<String, Integer>();
        Map<String, Integer> stUnworkedStatusToCaseHandlingTimeSummaryMap = new Map<String, Integer>();
        
        for(CaseCompleteHistoryWrapper cchWrapper : caseIdToCompleteCaseHistoryMap.values()){
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
                stUnworkedStatusToCaseHandlingTimeSummaryMap.put(status, stUnworkedStatusToCaseHandlingTimeSummaryMap.get(status) + cchWrapper.caseHandlingTimeInSeconds);
            }
        }        
        
        unworkedStatusWrappers = new List<StatusWrapper>();
        workedStatusWrappers = new List<StatusWrapper>();        
        for(String status : stUnworkedStatusCountMap.keySet()){
            Integer stUnworkedAHTSummary = stUnworkedStatusToCaseHandlingTimeSummaryMap.get(status);
            String stUnworkedRekeyAHT = stUnworkedStatusCountMap.get(status) == 0 || stUnworkedAHTSummary == null ? 'N/A' : convertTimeIntervalToString(stUnworkedAHTSummary / stUnworkedStatusCountMap.get(status));
            
            StatusWrapper unworkedWrapper = new StatusWrapper(status, stUnworkedStatusCountMap.get(status), stUnworkedRekeyAHT);
            unworkedStatusWrappers.add(unworkedWrapper);
            
            String conversion = stWorkedStatusCountMap.get(status) == 0 || stWorkedStatusConversionCountMap.get(status) == null? 'N/A' : getPercentValue(stWorkedStatusConversionCountMap.get(status) / stWorkedStatusCountMap.get(status));
            String percentSLA = stWorkedStatusCountMap.get(status) == 0 || stWorkedStatusSLACountMap.get(status) == null ? 'N/A' : getPercentValue(stWorkedStatusSLACountMap.get(status) / stWorkedStatusCountMap.get(status));
            
            Integer stWorkedAHTSummary = stWorkedStatusToCaseHandlingTimeSummaryMap.get(status);
            String stWorkedRekeyAHT = stWorkedStatusToCaseHandlingTimeSummaryMap.get(status) == 0 || stWorkedAHTSummary == null ? 'N/A' : convertTimeIntervalToString(stWorkedAHTSummary / stWorkedStatusCountMap.get(status));
            
            StatusWrapper workedWrapper = new StatusWrapper(status, stWorkedStatusCountMap.get(status), stWorkedRekeyAHT, conversion, percentSLA);
            workedStatusWrappers.add(workedWrapper);
        }
        
        //conversion wrappers
        conversionWrappers = new List<ConversionWrapper>();
        for(String status : cConversionStatusCountMap.keySet()){
            ConversionWrapper cWrapper = new ConversionWrapper(status, cConversionStatusCountMap.get(status), 123); //TODO put total value here
            conversionWrappers.add(cWrapper);
        }
    }
    
    private class CaseCompleteHistoryWrapper {//describe complete history of a single case
        Id CaseId;
        Case caseObj;
        
        Id holderId; //user for which this case be assigned for today work calculation it is last user, which holded ownership
        CaseHistorySortableWrapper holderOwnershipChangeWrapper;
        CaseHistorySortableWrapper lastOwnershipChangeWrapper;
        
        List<CaseHistorySortableWrapper> caseHistoryList;
        Integer caseHandlingTimeInSeconds; //case handling time for holder
        
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
        
        public Integer numberOfCasesCompleted {get;set;}
        public String globalAHT {get;set;}
        public String globalConversion {get;set;}
        
        public SummaryWrapper(Integer numberOfUntouchedCases, Integer numberOfCasesBeingWorked, Integer numberOfCasesWithinSLA, Integer numberOfCasesOutSLA, Integer numberOfCasesCompleted, String globalAHT, String globalConversion){
            this.numberOfUntouchedCases = numberOfUntouchedCases;
            this.numberOfCasesBeingWorked = numberOfCasesBeingWorked;
            this.numberOfCasesWithinSLA = numberOfCasesWithinSLA;
            this.numberOfCasesOutSLA = numberOfCasesOutSLA;
            this.numberOfCasesCompleted = numberOfCasesCompleted;
            this.globalAHT = globalAHT;
            this.globalConversion = globalConversion;
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
        
        //Below helper variables are used also during summary wrapper creation
        Integer caseHandlingTimeSummary = 0; //In seconds
        Integer caseConvertedCount = 0;
        
        public UserWrapper(User u, Integer casesTouchedToday, Integer casesCompletedToday, String todayCasesAHT, String currentCase, String timeOnCurrentCase, String conversion, Integer caseHandlingTimeSummary, Integer caseConvertedCount){
            this.fullName = u.Name;
            this.username = u.username ;
            this.location = u.User_Location__c;
            
            this.casesTouchedToday = casesTouchedToday ;
            this.casesCompletedToday = casesCompletedToday;
            this.todayCasesAHT = todayCasesAHT;
            this.currentCase = currentCase;
            this.timeOnCurrentCase = timeOnCurrentCase;
            this.conversion = conversion;
            this.caseHandlingTimeSummary = caseHandlingTimeSummary;
            this.caseConvertedCount = caseConvertedCount;
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
}