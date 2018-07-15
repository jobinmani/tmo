global class MoveToOutboundSchedule implements Schedulable
{
global void execute(SchedulableContext sc)
{
//execute the batch
MoveToOutboundFirstCall MoveOutFirstCall = new MoveToOutboundFirstCall();
ID batchprocessid = Database.executeBatch(MoveOutFirstCall,200);
}
}