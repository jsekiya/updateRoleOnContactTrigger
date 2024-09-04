trigger AccountOwnerChangeTrigger on Account (after update) {
    AccountHandler.updateContactRolesOnOwnerChange(Trigger.oldMap, Trigger.newMap);
}
