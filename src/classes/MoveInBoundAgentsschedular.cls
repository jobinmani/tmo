global class MoveInBoundAgentsschedular implements Schedulable{
     global void execute(SchedulableContext sc) {
        // Implement any logic to be scheduled

           // We now call the Inbound batch class to be scheduled
        MovetoInboundAgents movetoib = new MovetoInboundAgents(); 
        
       //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(movetoib,200);
     }
  }