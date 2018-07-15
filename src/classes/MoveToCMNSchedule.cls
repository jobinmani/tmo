global class MoveToCMNSchedule implements Schedulable
{
global void execute(SchedulableContext sc)
{
//execute the batch
MoveToCMNQueue  MoveCMNQue = new MoveToCMNQueue();
ID batchprocessid = Database.executeBatch(MoveCMNQue,200);
}
}