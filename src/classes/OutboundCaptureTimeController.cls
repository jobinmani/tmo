public class OutboundCaptureTimeController{

    private static Case c;

    public OutboundCaptureTimeController(ApexPages.StandardController stdController){
        c = (Case)stdController.getRecord();
    }
    
    public static PageReference redirect(){
        c.X2nd_Call_Back_Date__c = DateTime.now();
        update c;
        
        PageReference pRef = new PageReference('/' + c.Id);
        return pRef;
    }
}