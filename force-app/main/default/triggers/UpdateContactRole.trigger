trigger UpdateContactRole on Contact (before insert, before update) {
    ContactHandler.updateContactRoles(Trigger.new);
}