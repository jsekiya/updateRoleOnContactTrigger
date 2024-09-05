public with sharing class AccountUpdater {
    public static void updateAccount(List<Opportunity> opps) {
        Set<Id> accountIds = new Set<Id>();

        for (Opportunity opp : opps) {
            if (opp.AccountId != null && opp.IsWon) {
                accountIds.add(opp.AccountId);
                System.debug('account id: '+ opp.AccountId);
            }
        }

        List<Account> accountsToUpdate = [SELECT Id, AnnualRevenue FROM Account WHERE Id IN :accountIds];
        for (Account acc : accountsToUpdate) {
            for(Opportunity opp : opps){
                if(opp.AccountId == acc.Id && opp.Amount != null){
                    System.debug('account revenue '+ acc.AnnualRevenue);
                    System.debug('opp amount: '+ opp.Amount);
                    if(acc.AnnualRevenue == null){
                        acc.AnnualRevenue = 0;
                    }
                    acc.AnnualRevenue += opp.Amount;
                    System.debug('new annual revenue: '+ acc.AnnualRevenue);

                }
            }
        }  
        update accountsToUpdate;
        System.debug('Updated Accounts: ' + accountsToUpdate);
        
    }
}
