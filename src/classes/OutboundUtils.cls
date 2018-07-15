/**
* @author PolSource
* @date 4/25/2016
* @description Takes cases out of On Hold Queue to Outbound Queue
*/

public class OutboundUtils{

    public static Map<String, Set<Date>> createHolidaysMap(){
        List<Holidays_cs__c> holidays = Holidays_cs__c.getAll().values();
        Map<String, Set<Date>> stateToDates = new Map<String, Set<Date>>();
        List<String> states = new List<String>();
        if(!holidays.isEmpty()){
            for(Holidays_cs__c h:holidays){
                states = h.State_list__c.split(',');
                for(String s :states){
                    if(stateToDates.get(s) == null){
                        stateToDates.put(s, new Set<Date>());
                    }
                    stateToDates.get(s).add(h.Holiday_date__c);
                }
            }
        }
        System.debug('!!! stateToDates:'+stateToDates);
        return stateToDates;
    }
    public static boolean isSunday(Datetime custDT,String cState){
        
        Map<String, Sundays_cs__c> allstates = Sundays_cs__c.getAll();        
        boolean result = False;
        String dayOfWeek = custDT.format('EEEE');        
        for(Sundays_cs__c state : allstates.values()) {        
        if ((state.Statelist__c == cState) &&(dayOfWeek == 'Sunday')) {
                result = True;
                System.debug('result1'+result);                
            }        
        }
        return result;
         
        /*String dayOfWeek = custDT.format('EEEE');
        boolean result = dayOfWeek == 'Sunday';
        return result;*/
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