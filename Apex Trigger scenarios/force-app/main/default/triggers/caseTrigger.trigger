trigger caseTrigger on Case (after insert, after update, after delete, after undelete) {

    if(trigger.isAfter && (trigger.isInsert || trigger.isUndelete)){
        caseTriggerHandler.countStatusAccount(trigger.new,null);
    }
    else if(trigger.isAfter && trigger.isUpdate){
        caseTriggerHandler.countStatusAccount(trigger.new,trigger.oldMap);
    }
    else if(trigger.isAfter && trigger.isDelete){
           caseTriggerHandler.countStatusAccount(trigger.old,null);
    }
}