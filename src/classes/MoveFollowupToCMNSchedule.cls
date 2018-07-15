global class MoveFollowupToCMNSchedule implements Schedulable
{
global void execute(SchedulableContext sc)
{
//execute the batch
MoveFollowupToCMN  MovetoCMN = new MoveFollowupToCMN();
ID batchprocessid = Database.executeBatch(MovetoCMN,200);
}
}