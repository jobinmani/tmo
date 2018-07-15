/**
* @author Srikar
* @date 04/04/2017
* @Created for VIP Programme
*/

public class VIPOutboundUtils{

    public static Map<String, Set<Date>> createHolidaysMap(){
        List<VIPHolidays__c> holidays = VIPHolidays__c.getAll().values();
        Map<String, Set<Date>> vipstateToDates = new Map<String, Set<Date>>();
        List<String> states = new List<String>();
        if(!holidays.isEmpty()){
            for(VIPHolidays__c h:holidays){
                states = h.VIPState_list__c.split(',');
                for(String s :states){
                    if(vipstateToDates.get(s) == null){
                        vipstateToDates.put(s, new Set<Date>());
                    }
                    vipstateToDates.get(s).add(h.VIPHoliday_date__c);
                }
            }
        }
        System.debug('!!! stateToDates:'+vipstateToDates);
        return vipstateToDates;
    }
    public static boolean isSunday(Datetime custDT,String cState){
        
        Map<String, VIP_Sundays__c> allstates = VIP_Sundays__c.getAll();        
        boolean result = False;
        String dayOfWeek = custDT.format('EEEE');        
        for(VIP_Sundays__c state : allstates.values()) {        
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