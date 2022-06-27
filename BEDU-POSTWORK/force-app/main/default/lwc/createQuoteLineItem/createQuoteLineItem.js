import { LightningElement, wire, api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getInventary from '@salesforce/apex/CustomWebInventoryController.getInventary';
import NewQuoteLineItem from '@salesforce/apex/CustomWebInventoryController.createNewQuoteLineItem';

export default class CreateQuoteLineItem extends LightningElement {

    @api searchKey;
    @api amountValue;
    @api recordId;

    @wire(getInventary, {prodCode: '$searchKey'})
    inventaries;
    // Llamandolo con wire
    // @wire(NewQuoteLineItem, {amount: '$amountValue', prodCode: '$searchKey'})
    // values;

    //Llamada con imperativo
    handleSave(){
      console.log(this.amountValue, this.searchKey, this.recordId);
       NewQuoteLineItem({amount: this.amountValue, prodCode: this.searchKey, quoteId: this.recordId})
           .then(result => {
            console.log(JSON.stringify(result));
               if (result) {
                   this.fireSuccessToast();
                   console.log('Funciono');
               } else {
                   console.log('No hay resultado');
               }
           })
           .catch(error => {
               console.log('error: ', error);
           });
          }

  // Asignacion de los datos traidos de los input.
    handleChange(event) {
      const defaultValue = event.target.value
      this.searchKey = defaultValue;
    }

    handleAmount(event){
      const amount = event.target.value
      this.amountValue = amount;
    }

    handleClick(){
      this.fireSuccessToast();
    }

    handleCancel() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    fireSuccessToast(){
       const evt = new ShowToastEvent({
           title: "WOAHH",
           message: 'You just updated your own name! nice',
           variant: "success",
       });
       this.dispatchEvent(evt);
   }

}