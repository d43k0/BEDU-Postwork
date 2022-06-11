public with sharing class QuotationHelper implements QuotationSync {

    public void initialConfig(){
        List<Account> initialAccounts = new List<Account>{
            new Account(Name = 'compumundo'),
            new Account(Name='Compuworld')
        };
        insert initialAccounts;
    }

    public List<AB_Inventary__c> productsInInventory(){

        List<Inventary__c>lstInv = [SELECT Name,Available_Products__c, Product__c, ProductCodeInv__c, Reserved_Products__c FROM Inventary__c LIMIT 200];

        Return lstInv;

    }

    public static Boolean confirmProductExistByCode(String extCode){
        // Queries the product using the external ID
        Product2 code = [SELECT ProductCode FROM Product2 WHERE (ExternalId =:extCode) LIMIT 1];

        if(code.ProductCode != NULL){
        // Verifies product is not null, theres only one posible result so if its null, it would default to the else statement.
        	return True;
        }else {
            return False;
        }
    }

    public static Integer searchProductByCode(String prodCode){
        // Queries Available product by matching product code.
        Inventary__c inExistence = [SELECT Available_Products__c FROM Inventary__c WHERE (ProductCodeInv__c =:prodCode)LIMIT 1];

        // Ensures the returning value is Integer to avoid conversion rules errors.
        return (Integer)(inExistence.Available_Products__c);
    }
}