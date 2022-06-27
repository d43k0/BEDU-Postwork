public with sharing class InventoryDataScheduler {
   	@future(callout=true)
    public static void ExternalLegacyConnection(){}

    public static HttpResponse makeGetCallout() {
        List<Inventary__c> nInv = [SELECT Available_Products__c, Name, ProductCodeInv__c, Reserved_Products__c   FROM Inventary__c LIMIT 5];
        system.debug(nInv);
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://64bjp0q5wg.execute-api.us-east-2.amazonaws.com/Implement/');
    request.setMethod('GET');
    HttpResponse response = http.send(request);
    if(response.getStatusCode() == 200) {
    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    List<Object> Inventory = (List<Object>) results.get('Inventory');
        for(Object name: results.values()) {
                System.debug(name);
            }
    	}
        return response;
    }
}