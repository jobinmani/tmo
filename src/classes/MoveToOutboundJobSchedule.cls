global class MoveToOutboundJobSchedule implements Schedulable
{
global void execute(SchedulableContext sc)
{
MoveToOutboundJob MoveOutOutbound = new MoveToOutboundJob();
ID batchprocessid = Database.executeBatch(MoveOutOutbound,200);
}
}