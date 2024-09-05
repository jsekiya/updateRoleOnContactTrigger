public with sharing class AccountUpdater {
    public static void updateAccounts(List<Opportunity> opps) {
        Set<Id> accountIds = new Set<Id>();

        for (Opportunity opp : opps) {
            if (opp.AccountId != null && opp.IsWon) {
                accountIds.add(opp.AccountId);
            }
        }

        List<Account> accountsToUpdate = [SELECT Id, AnnualRevenue FROM Account WHERE Id IN :accountIds];
        for (Account acc : accountsToUpdate) {
            for(Opportunity opp : opps){
                if(opp.AccountId == acc.Id && opp.Amount != null){
                    acc.AnnualRevenue += opp.Amount;
                }
            }
            System.debug('Updated Annual Revenue for Account Id ' + acc.AnnualRevenue);
        }

        // Aktualizujemy konta w bazie danych
        update accountsToUpdate;
        System.debug('Updated Accounts: ' + accountsToUpdate);
    }
}
