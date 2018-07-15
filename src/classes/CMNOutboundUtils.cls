/**
* @author Srikar
* @date 03/05/2017
* @description Takes Leads to CMN On Hold Queue
*/

public class CMNOutboundUtils{

    public static Map<String, Set<Date>> createHolidaysMap(){
        List<CMNHolidays__c> holidays = CMNHolidays__c.getAll().values();
        Map<String, Set<Date>> stateToDates = new Map<String, Set<Date>>();
        List<String> states = new List<String>();
        if(!holidays.isEmpty()){
            for(CMNHolidays__c h:holidays){
                states = h.CMNState_list__c.split(',');
                for(String s :states){
                    if(stateToDates.get(s) == null){
                        stateToDates.put(s, new Set<Date>());
                    }
                    stateToDates.get(s).add(h.CMNHoliday_date__c);
                }
            }
        }
        System.debug('!!! stateToDates:'+stateToDates);
        return stateToDates;
    }
    public static boolean isSunday(Datetime custDT,String cState){
        
        Map<String, CMN_Sundays__c> allstates = CMN_Sundays__c.getAll();        
        boolean result = False;
        String dayOfWeek = custDT.format('EEEE');        
        for(CMN_Sundays__c state : allstates.values()) {        
        /*if ((state.Statelist__c == cState) &&(dayOfWeek == 'Sunday'))*/
        if(((state.Statelist__c == cState) &&(dayOfWeek == 'Sunday')) ||((state.Statelist__c == cState) &&(dayOfWeek == 'Saturday'))) {
                result = True;
                System.debug('result1'+result);                
            }        
        }
        return result;
         
        /*String dayOfWeek = custDT.format('EEEE');
        boolean result = dayOfWeek == 'Sunday';
        return result;Saturday*/
    }
    
    public static boolean isHoliday(Datetime custDT, String cState, Map<String, Set<Date>> stateToDates){
        Date cDate = custDT.date();
        boolean result = false;
        if(cState != null){
            result = (stateToDates.get(cState) != null) && (stateToDates.get(cState).contains(cDate));
        }
        result = result || (stateToDates.get('National') != null && stateToDates.get('National').contains(cDate));
        System.debug('!!!! isHoliday:'+result);
        return result;
    }
    
    public static boolean isBusinessHours(Datetime custDT, Time time_0800, Time time_2000){
        Time cTime = custDT.time();
        boolean result = time_0800 <= cTime && cTime <= time_2000;
        System.debug('!!!! isBusinessHours:'+result);
        return  result;
    }
    

}