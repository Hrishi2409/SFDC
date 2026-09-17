public with sharing class caseTriggerHandler {
    
    public static void countStatusAccount(List<Case> newList, Map<Id,Case> OldMap){

        Set<Id> accIds = new Set<Id>();
        Map<Id,Integer> newCaseCountMap = new Map<Id,Integer>();
        Map<Id,Integer> workingCaseCountMap = new Map<Id,Integer>();
        Map<Id,Integer> escalatedCaseCountMap = new Map<Id,Integer>();

        Map<Id,Account> accountsToUpdate = new Map<Id,Account>();

        // Determine whether we are processing incoming records or deleted records
        List<Case> targetCases = (newList != null) ? newList : oldMap.values();
        
        for (Case c : targetCases) {
            if (oldMap != null && newList != null) { // Update Operation
                Case oldCase = oldMap.get(c.Id);
                if (oldCase.AccountId != c.AccountId) {
                    if (oldCase.AccountId != null) accIds.add(oldCase.AccountId);
                    if (c.AccountId != null) accIds.add(c.AccountId);
                } else if (oldCase.Status != c.Status) {
                    if (c.AccountId != null) accIds.add(c.AccountId);
                }
            } else { // Insert, Delete, or Undelete Operations
                if (c.AccountId != null) accIds.add(c.AccountId);
            }
        }

        if (accIds.isEmpty()) {
            return;
        }

        /* if(!newList.isEmpty()){
            for(Case newCase : newList){
                if(oldMap != null){
                    Case oldCase = oldMap.get(newCase.Id);
                    if(oldCase.AccountId != newCase.AccountId){
                        accIds.add(oldCase.AccountId);
                        accIds.add(newCase.AccountId);
                    }
                    else if(oldCase.Status != newCase.Status){
                        accIds.add(newCase.AccountId);
                    }
                    else{
                        accIds.add(newCase.AccountId);
                    }
                }
            }
        } */

        if(!accIds.isEmpty()){
              for(Account acc: [Select Id,Number_of_escalated_cases__c,Number_of_new_cases__c,Number_of_working_cases__c,
              (Select Id,Status from Cases) From Account Where Id IN : accIds]){
                newCaseCountMap.put(acc.Id,0);
                workingCaseCountMap.put(acc.Id,0);
                escalatedCaseCountMap.put(acc.Id,0);

                for(Case caseObj : acc.Cases){
                    if(caseObj.Status == 'New'){
                        newCaseCountMap.put(acc.Id,newCaseCountMap.get(acc.Id) + 1);
                    }
                    else if(caseObj.Status == 'Working'){
                        workingCaseCountMap.put(acc.Id,workingCaseCountMap.get(acc.Id) + 1);
                    }
                    else if(caseObj.Status == 'Escalated'){
                        escalatedCaseCountMap.put(acc.Id,escalatedCaseCountMap.get(acc.Id) + 1);
                    }
                }

                if(newCaseCountMap.get(acc.Id) != acc.Number_of_new_cases__c || 
                    workingCaseCountMap.get(acc.Id) != acc.Number_of_working_cases__c ||
                    escalatedCaseCountMap.get(acc.Id) != acc.Number_of_escalated_cases__c){
                        
                        acc.Number_of_new_cases__c = newCaseCountMap.get(acc.Id);
                        acc.Number_of_working_cases__c = workingCaseCountMap.get(acc.Id);
                        acc.Number_of_escalated_cases__c = escalatedCaseCountMap.get(acc.Id);

                        accountsToUpdate.put(acc.Id,acc);
                    }
              }
              
              if(!accountsToUpdate.isEmpty()){
                update accountsToUpdate.values();
              }
        }
    }
}