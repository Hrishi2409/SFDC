import { LightningElement } from 'lwc';

export default class Practive_comp1 extends LightningElement {

    name = '';
    inputValue = '';
    
    handleChange(event) {
        this.inputValue = event.target.value;
    }
    handleClick(){
        this.name = this.inputValue.toUpperCase();
    }

    get isButtonDisabled() {
    return !this.inputValue;
    }
}
