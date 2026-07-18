public with sharing class MenuController {
    @AuraEnabled(Cacheable=true)
    Public static List<Menu_Item__c> getMenuItems(String CategoryFilter){
        // Base query selecting the fields our front-end UI needs
        String query = 'SELECT Id, Name, Price__c, Category__c FROM Menu_Item__c';
        
        // If the user selected a specific category filter, append a WHERE clause
        if (String.isNotBlank(categoryFilter) && categoryFilter != 'All') {
            query += ' WHERE Category__c = :categoryFilter';
        }
        
        // Always return them sorted alphabetically
        query += ' ORDER BY Name ASC';
        
        return Database.query(query);
    }
}