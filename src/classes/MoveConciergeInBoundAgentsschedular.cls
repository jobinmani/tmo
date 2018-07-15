global class MoveConciergeInBoundAgentsschedular implements Schedulable{
     global void execute(SchedulableContext sc) {
        // Implement any logic to be scheduled

           // We now call the Inbound batch class to be scheduled
        MovetoConciergeInboundAgents movetoib = new MovetoConciergeInboundAgents(); 
        
       //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(movetoib,200);
     }
  }