global class MoveToVIPSchedule implements Schedulable
{
global void execute(SchedulableContext sc)
{
//execute the batch
MoveToVIPQueue  MoveVIPQue = new MoveToVIPQueue();
ID batchprocessid = Database.executeBatch(MoveVIPQue,200);
}
}