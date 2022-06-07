public with sharing class QuotationHelper {

    public void initialConfig(){
        Account compumundo = new Account();
        Compumundo.Name = 'Compumundo';
        Account compuworld = new Account();
        Compuworld.Name = 'Compuworld';
    }

    public List<AB_Inventary__c> productsInInventory(){
        List<AB_Inventary__c>lstInv = [SELECT Name,Available_Product__c, AB_Product__c, ProductCodeInv__c FROM AB_Inventary__c LIMIT 200];

        Return lstInv;

    }
}
