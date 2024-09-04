public class AccountHandler {
    public static void updateContactRolesOnOwnerChange(Map<Id, Account> oldMap, Map<Id, Account> newMap) {
        Set<Id> accountIdsToUpdate = new Set<Id>();
        Set<Id> ownerIdsToQuery = new Set<Id>();

        for (Id accId : newMap.keySet()) {
            Account oldAcc = oldMap.get(accId);
            Account newAcc = newMap.get(accId);

            if(newAcc.OwnerId != oldAcc.OwnerId){
                accountIdsToUpdate.add(accId);
                ownerIdsToQuery.add(newAcc.OwnerId);
            }
        }

        Map<Id, User> ownerMap = new Map<Id, User>();
        List<Contact> contactsToUpdate = new List<Contact>();
        
        if(!accountIdsToUpdate.isEmpty()){
            ownerMap = new Map<Id, User>([SELECT Id, UserRole.Name FROM User WHERE Id IN :ownerIdsToQuery]);
            List<Contact> relatedContacts = [SELECT Id, Role__c, AccountId FROM Contact WHERE AccountId IN :accountIdsToUpdate];

            for(Contact contact : relatedContacts){
                Account acc = newMap.get(contact.AccountId);
                User owner = ownerMap.get(newMap.get(contact.AccountId).OwnerId);

                if(owner != null){
                    if(owner.UserRole.Name == 'SSD'){
                        contact.Role__c = 'Partner';
                    }else if(owner.UserRole.Name == 'VP'){
                        contact.Role__c = 'Partner';
                    }else if(owner.UserRole.Name == 'RSD'){
                        contact.Role__c = 'Non-Partner';
                    }
                    contactsToUpdate.add(contact);
                }           
            }
        }             
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
}