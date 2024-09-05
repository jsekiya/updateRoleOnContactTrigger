trigger OpportunityUpdateTrigger on Opportunity (after insert, after update, after delete) {
    if(Trigger.isBefore && Trigger.isUpdate){
        OpportunityHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
}