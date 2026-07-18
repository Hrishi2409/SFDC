import { LightningElement,wire,track } from 'lwc';
import getMenuItems from '@salesforce/apex/MenuController.getMenuItems';

export default class MenuExplorer extends LightningElement {
    selectedCategory = 'All';

    @wire(getMenuItems,{CategoryFilter: '$selectedCategory'})
    menuItems;
}