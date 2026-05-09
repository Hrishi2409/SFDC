import { LightningElement } from 'lwc';

const TAB_CONFIG = [
    {
        label: 'Uppercase',
        type: 'uppercase',
        buttonLabel: 'Convert to Uppercase'
    },
    {
        label: 'Lowercase',
        type: 'lowercase',
        buttonLabel: 'Convert to Lowercase'
    },
    {
        label: 'Capitalize',
        type: 'capitalize',
        buttonLabel: 'Convert to Capitalized'
    }
];
export default class TextTransformationHub extends LightningElement {
    result = '';
    inputValue = '';
    showResult = false;
    tabs = TAB_CONFIG;

    currentTab = {
    type: 'uppercase',
    buttonLabel: 'Convert to Uppercase' 
        };

    handleChange(event) {

        this.inputValue = event.target.value;
    }    

    transformText(type) {

    switch(type) {

        case 'uppercase':
            this.result = this.inputValue.toUpperCase();
            this.showResult = true;
            break;

        case 'lowercase':
            this.result = this.inputValue.toLowerCase();
            this.showResult = true;
            break;

        case 'capitalize':
            this.result = this.inputValue
                .split(' ')
                .map(word =>
                    word.charAt(0).toUpperCase() +
                    word.slice(1).toLowerCase()
                )
                .join(' ');
            this.showResult = true;
            break;

        default:
            this.result = this.inputValue;
            this.showResult = true;
    }
}

handleTransform(event) {

    const type = event.currentTarget.dataset.type;

    this.transformText(type);
}

handleActive(event) {

    const selectedTab = event.target.value;

    this.currentTab = this.tabs.find(
        tab => tab.type === selectedTab
    );
    this.result = '';

    this.showResult = false;
}    
}