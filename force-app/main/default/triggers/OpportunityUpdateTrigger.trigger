trigger OpportunityUpdateTrigger on Opportunity (after insert, after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        OpportunityHandler.handleAfterInsertOrUpdate(Trigger.new);
    }
}