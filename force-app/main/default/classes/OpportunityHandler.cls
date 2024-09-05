public with sharing class OpportunityHandler {
    public static void handleBeforeUpdate(List<Opportunity>newRecords) {
        Savepoint sp = Database.setSavepoint();

        try{
            AccountUpdater.updateAccounts(newRecords);
            //TaskCreator.createTasks(newRecords);
        }catch(Exception e){
            //RollbackHandler.rollback(sp, newRecords, e.getMessage());
        }
    }
}