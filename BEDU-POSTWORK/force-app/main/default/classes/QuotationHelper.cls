public with sharing class QuotationHelper implements QuotationSync {

    public static void initialConfig(){
        List<Account> initialAccounts = new List<Account>{
            new Account(Name = 'compumundo'),
            new Account(Name='Compuworld')
        };
        insert initialAccounts;
    }

    public static List<Inventary__c> productsInInventory(){

        List<Inventary__c>lstInv = [SELECT Name,Available_Products__c, Product__c, ProductCodeInv__c, Reserved_Products__c FROM Inventary__c LIMIT 200];

        Return lstInv;

    }

    public static Boolean confirmProductExistByCode(String ProdCode){
        // Queries the product using the external ID
        // // Using a try-catch method here it assings from the query to the object then returns true. If product doesnt exist then catch provides a list empty error and returns false.
        try{
        	Product2 code = [SELECT ProductCode FROM Product2 WHERE (ProductCode =:ProdCode) LIMIT 1];
            system.debug(code);
            return true;
        }catch (QueryException err) {
            System.debug('A Query exception has occurred: ' + err.getMessage());
            return false;
        }
    }

    public static Integer searchProductByCode(String prodCode){
        // Queries Available product by matching product code
        try{
        Inventary__c inExistence = [SELECT Available_Products__c FROM Inventary__c WHERE (ProductCodeInv__c =:prodCode)LIMIT 1];
        // Ensures the returning value is Integer to avoid conversion rules errors.
        return (Integer)(inExistence.Available_Products__c);
        }catch (QueryException err){
            System.debug('A Query exception has occurred: ' + err.getMessage());
            return 0;
        }
    }

    public void UpdateReservation(String prodCode, Integer quantity){
        // Retrieves product code and quantity from the trigger
        try {
            Inventary__c newReservation = [SELECT id, Reserved_Products__c FROM Inventary__c WHERE (ProductCodeInv__c =:prodCode)LIMIT 1];
            // Adds the reserved amount to the existing quantity.
            newReservation.Reserved_Products__c += quantity;
            update newReservation;

        } catch (DmlException err) {
            System.debug('A DML exception has occurred: ' + err.getMessage());

        }
    }
    public static Boolean isOutOfStock = false;
    @InvocableMethod(label='StockEmpty')
    public static void StockEmptyAlert(){
        System.debug(productsInInventory());
        Datetime lastExecuted;
        
        for(Inventary__c ls:productsInInventory()){
            if(ls.Available_Products__c == 0){
                isOutOfStock = True;
            }
        }
        
        if(isOutOfStock){
        	lastExecuted = System.Datetime.now();
        	FeedItem objPost = new FeedItem();
        	objPost.ParentId = System.UserInfo.getUserId();
        	objPost.Body = 'Product is out of stock';
        	insert objPost;
        }
    }
}