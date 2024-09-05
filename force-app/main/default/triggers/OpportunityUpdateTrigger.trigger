trigger OpportunityUpdateTrigger on Opportunity (before update) {
    if(Trigger.isBefore && Trigger.isUpdate){
        OpportunityHandler.handleBeforeUpdate(Trigger.new);
    }
}