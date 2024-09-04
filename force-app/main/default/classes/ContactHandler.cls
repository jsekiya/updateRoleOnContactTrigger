public with sharing class ContactHandler {
    public static void updateContactRoles(List<Contact> contacts) {
        Set<Id> accountIds = new Set<Id>();
        for (Contact con : contacts) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }

        if (!accountIds.isEmpty()) {
            Map<Id, Account> accountMap = new Map<Id, Account>([
                SELECT Id, Owner.UserRole.Name
                FROM Account
                WHERE Id IN :accountIds
            ]);

            for (Contact con : contacts) {
                if (con.AccountId != null && accountMap.containsKey(con.AccountId)) {
                    Account acc = accountMap.get(con.AccountId);
                    String userRoleName = acc.Owner.UserRole.Name;

                    switch on userRoleName {
                        when 'SSD' {
                            con.Role__c = 'Partner';
                        }
                        when 'VP' {
                            con.Role__c = 'Admin';
                        }
                        when 'RSD' {
                            con.Role__c = 'RSD';
                        }
                    }
                }
            }
        }
    }
}