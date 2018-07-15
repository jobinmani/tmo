trigger UserTrigger on User (before insert, before update) {

    for(User u : Trigger.new){
        u.TimeZoneSidKey = 'America/Los_Angeles';
    }

}