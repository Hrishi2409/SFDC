public with sharing class triggerHandler {
    
    public static void updateAccountRating(List<Opportunity> oppList,Map<Id,Opportunity> oldMap){
        
        Set<Id> AccIds = new Set<Id>();

        if(!oppList.isEmpty()){
            for(Opportunity newOpp: oppList){
                if(oldMap != null){
                    Opportunity oldOpp = oldMap.get(newOpp.Id);

                    if(oldOpp.AccountId != newOpp.AccountId){
                        AccIds.add(newOpp.AccountId);
                        AccIds.add(oldOpp.AccountId);
                    }
                    else if(oldOpp.Amount != newOpp.Amount){
                        AccIds.add(newOpp.AccountId);
                    }
                    else{
                        AccIds.add(newOpp.AccountId);
                    }
                }

            }
        }

        if()
    }
} 