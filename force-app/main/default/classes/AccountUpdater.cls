public with sharing class AccountUpdater {
    public static void updateAccounts(List<Opportunity> opps) {
        // Zestaw ID kont, które mają być zaktualizowane
        Set<Id> accountIds = new Set<Id>();

        // Zbieramy ID kont, które mają powiązane szanse sprzedaży
        for (Opportunity opp : opps) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }
        System.debug('Account Ids: ' + accountIds);

        // Pobieramy wszystkie konta powiązane ze zmienionymi szansami sprzedaży
        List<Account> accountsToUpdate = [SELECT Id, AnnualRevenue FROM Account WHERE Id IN :accountIds];
        System.debug('Accounts to update: ' + accountsToUpdate);

        // Mapa przechowująca sumy amount dla każdego konta
        Map<Id, Decimal> accountToOpportunityAmountMap = new Map<Id, Decimal>();

        // Sumujemy amount dla każdego konta
        for (Opportunity opp : opps) {
            if (opp.AccountId != null) {
                // Dodajemy kwotę z Opportunity do mapy
                if (!accountToOpportunityAmountMap.containsKey(opp.AccountId)) {
                    accountToOpportunityAmountMap.put(opp.AccountId, 0);
                }
                accountToOpportunityAmountMap.put(opp.AccountId, accountToOpportunityAmountMap.get(opp.AccountId) + (opp.Amount != null ? opp.Amount : 0));
            }
        }

        System.debug('Account to Opportunity Amount Map: ' + accountToOpportunityAmountMap);

        // Aktualizujemy wartość AnnualRevenue dla każdego konta
        for (Account acc : accountsToUpdate) {
            if (accountToOpportunityAmountMap.containsKey(acc.Id)) {
                acc.AnnualRevenue += accountToOpportunityAmountMap.get(acc.Id);
                System.debug('Updated Annual Revenue for Account Id ' + acc.Id + ': ' + acc.AnnualRevenue);
            }
        }

        // Aktualizujemy konta w bazie danych
        update accountsToUpdate;
        System.debug('Updated Accounts: ' + accountsToUpdate);
    }
}
