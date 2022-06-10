public with sharing class QuotationHelper implements QuotationSync {

    public void initialConfig(){
        List<Account> initialAccounts = new List<Account>{
            new Account(Name = 'compumundo'),
            new Account(Name='Compuworld')
        };
        insert initialAccounts;
    }

    public List<AB_Inventary__c> productsInInventory(){

        List<AB_Inventary__c>lstInv = [SELECT Name,Available_Product__c, AB_Product__c, ProductCodeInv__c, Reserved_Product__c FROM AB_Inventary__c LIMIT 200];

        Return lstInv;

    }

    public static Boolean confirmProductExistByCode(String extCode){
        // Queries the product using the external ID
        AB_Product__c code = [SELECT ProductCode__c FROM AB_Product__c WHERE (External_id__c =:extCode) LIMIT 1];

        if(code.ProductCode__c != NULL){
        // Verifies product is not null, theres only one posible result so if its null, it would default to the else statement.
        	return True;
        }else {
            return False;
        }
    }

    public static Integer searchProductByCode(String prodCode){
        // Queries Available product by matching product code.
        AB_Inventary__c inExistence = [SELECT Available_Product__c FROM AB_Inventary__c WHERE (ProductCodeInv__c =:prodCode)LIMIT 1];

        // Ensures the returning value is Integer to avoid conversion rules errors.
        return (Integer)(inExistence.Available_Product__c);
    }
}