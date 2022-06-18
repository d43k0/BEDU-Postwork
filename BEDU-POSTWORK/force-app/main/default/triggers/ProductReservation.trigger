trigger ProductReservation on QuoteLineItem (after insert, after update) {

    QuoteLineItem quote = new QuoteLineItem();
    
    QuotationHelper quo = new QuotationHelper();
    Integer quantity;
    System.debug(Trigger.New);
    // Se crea un objeto por cada registro recibido en la variable de contexto.
    // Se asigna dicho objeto a una lista para evitar llamadas innecesarias.
    for(QuoteLineItem related:Trigger.New){
        quote = related;
        quantity = (Integer)(quote.Quantity);
        System.debug(quantity);
        quo.UpdateReservation(quote.Product_Code_Quote__c, quantity);
    }
    
    
    
	
}