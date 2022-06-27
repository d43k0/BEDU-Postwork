public with sharing class CustomWebInventoryController {

   @AuraEnabled(cacheable=true)
    public static String getInventary(String prodCode) {
        try{
            Inventary__c inv = [SELECT Id FROM Inventary__c WHERE (ProductCodeInv__c = :prodCode)  LIMIT 1];
            String invID = (String)(inv.Id);
            return invID;
        }catch(QueryException err){
            return null;
        }
    }
    @AuraEnabled
    public static Id createNewQuoteLineItem(Double amount, String prodCode, String quoteId){

            Product2 prod = [SELECT id, Name FROM Product2 WHERE (ProductCode=:prodCode) LIMIT 1];
            Quote quo = [SELECT Pricebook2Id FROM Quote WHERE Id = :quoteId LIMIT 1];
            PriceBookEntry pce = [SELECT id, UnitPrice  FROM PricebookEntry WHERE (ProductCode= :prodCode AND PriceBook2Id = :quo.PriceBook2Id) LIMIT 1];

            QuoteLineItem newQLI = new QuoteLineItem(Product2Id = prod.id, QuoteId = quoteId, PricebookEntryId = pce.id, Quantity = amount, UnitPrice = pce.UnitPrice);

            insert newQLI;

            return newQLI.Id;
    }
}