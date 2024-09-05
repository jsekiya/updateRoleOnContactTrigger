public with sharing class AccountUpdater {
    public static void updateAccounts(List<Opportunity> opps) {
        Set<Id> accountIds = new Set<Id>();

        for(Opportunity opp : opps){
            if(opp.AccountId != null){
                accountIds.add(opp.AccountId);
            }
        }
        System.debug('Account Ids: ' + accountIds);

        List<Account> accountsToUpdate = [SELECT Id, AnnualRevenue FROM Account WHERE Id IN :accountIds];
        System.debug('Accounts to update: '+ accountsToUpdate);

        Map<Id, Account> accountMap = new Map<Id, Account>();
        for(Account acc : accountsToUpdate){
            accountMap.put(acc.Id, acc);
        }
        for(Opportunity opp : opps){
            Account acc = accountMap.get(opp.AccountId);
            acc.AnnualRevenue += opp.Amount;
            System.debug('annual revenue: '+ acc.AnnualRevenue);
        }
        System.debug('Updated Accounts: '+ accountsToUpdate);
        update accountsToUpdate;
    }
}