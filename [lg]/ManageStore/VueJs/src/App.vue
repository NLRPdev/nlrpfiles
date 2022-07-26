<template>
    <div id="App" v-if="openned">
        <Store v-if="page === 'Store'" :store_title="store_title" :items="items" :payment_methods="payment_methods" :StyleHeader="StyleHeader" :StyleBody="StyleBody" :translate="translate" :weightSystem="weightSystem" :NameResource="NameResource" :close="close" :OpenScreen="OpenScreen" />
        <Dashboard v-else-if="page === 'Dashboard'" :store_title="store_title" :items="items" :payment_methods="payment_methods" :StyleHeader="StyleHeader" :StyleBody="StyleBody" :translate="translate" :weightSystem="weightSystem" :NameResource="NameResource" :close="close" :OpenScreen="OpenScreen" />
        <Stock v-else-if="page === 'Stock'" :store_title="store_title" :items="items" :payment_methods="payment_methods" :StyleHeader="StyleHeader" :StyleBody="StyleBody" :translate="translate" :weightSystem="weightSystem" :NameResource="NameResource" :close="close" :OpenScreen="OpenScreen" />
        <Balance v-else-if="page === 'Balance'" :store_title="store_title" :items="items" :payment_methods="payment_methods" :StyleHeader="StyleHeader" :StyleBody="StyleBody" :translate="translate" :weightSystem="weightSystem" :NameResource="NameResource" :close="close" :OpenScreen="OpenScreen" />
        <Sell v-else-if="page === 'Sell'" :price_store="price_store" :percentage_sell="percentage_sell" :store_title="store_title" :StyleHeader="StyleHeader" :StyleBody="StyleBody" :translate="translate" :NameResource="NameResource" :close="close" :OpenScreen="OpenScreen" />
        <Buy v-else-if="page === 'Buy'" :price_store="price_store" :store_title="store_title" :StyleHeader="StyleHeader" :StyleBody="StyleBody" :translate="translate" :NameResource="NameResource" :close="close" :OpenScreen="OpenScreen" />
        <Missions v-else-if="page === 'Missions'" :store_title="store_title" :items="items" :payment_methods="payment_methods" :StyleHeader="StyleHeader" :StyleBody="StyleBody" :translate="translate" :weightSystem="weightSystem" :NameResource="NameResource" :close="close" :OpenScreen="OpenScreen" />
    </div>
</template>

<script>

import axios from 'axios';
import Store from './screens/Store';
import Dashboard from './screens/Dashboard';
import Stock from './screens/Stock';
import Balance from './screens/Balance';
import Sell from './screens/Sell';
import Buy from './screens/Buy';
import Missions from './screens/Missions';

export default {
    components: {
        Store,
        Dashboard,
        Stock,
        Balance,
        Sell,
        Buy,
        Missions
    },

    data: function(){
        return({
            store_title: "SUPERMARKET",

            items: [
                {name: "bread", label: "Bread", weight: 1.0, amount: 500, price: 500},
                {name: "drink", label: "Drink", weight: 1.0, amount: 500, price: 452.52},
            ],

            payment_methods: [
                {name: "Bank Account", img: "img/card.png" },
                {name: "Wallet Money", img: "img/wallet.png" },
            ],

            StyleHeader: {
                backgroundColor: "#03AE74"
            },

            StyleBody:{
                backgroundColor: "#03b67a"
            },

            price_store: 5000,
            percentage_sell: 10,
            balance: 5000,

            translate:{
                TR_TITLEWINDOW: "Items for sale",
                TR_TITLEWINDOW2: "My Cart",
                TR_SEARCH: "Search",
                TR_MY_CART: "MY CART",
                TR_ADD_TO_CART: "ADD TO CART",
                TR_WEIGHT_SYMBOL: "kg",
                TR_PAYMENT: "PAYMENT",
                TR_STORE_CART: "CART",
                TR_PAYMENT_OPTIONS: "PAYMENT OPTIONS",
                TR_BANK_ACCOUNT: "Bank Account",
                TR_WALLET_MONEY: "Wallet Money",
                TR_BUY_NOW: "Buy now",
                TR_CONTINUE_SHOPPING: "Continue shopping",
                TR_TOTAL: "Total:",
                TR_MONEY_SIMBOL: "$",
                TR_CONFIRM_TITLE: "Are you sure about this?",
                TR_CONFIR_MESSAGE: "The total amount is",
                TR_CONFIR_MESSAGE2: "and you have chosen to pay with",
                TR_CONFIR_MESSAGE3: "Do you want to continue?",
                TR_YES: "Yes",
                TR_NO: "No",
                TR_CANCEL: "Cancel",
                TR_PAYMENT_COMPLETE: "Payment Complete!",
                TR_PAYMENT_NEGADE: "Payment denied!",
                TR_REMOVE: "remove",
                TR_REASON: "Reason:",

                TR_STORE: "Store",
                TR_MANAGE_STORE: "MANAGE YOUR STORE",
                TR_STOCK: "STOCK",
                TR_BALANCE: "BALANCE",
                TR_SELL_STORE: "SELL STORE",

                TR_STORE_STOCK: "STORE STOCK",
                TR_STORE_PRODUCTS: "STORE PRODUCTS IN STOCK",
                TR_STORE_PRODUCTS2: "STORE PRODUCTS FOR SALE",
                TR_PUT_FOT_SALE: "Put For Sale",
                TR_MAX: "Max",
                TR_TEXT_FOR_SALE: "Enter the quantity you want to put up for sale",
                TR_REQUEST_ITEM: "Request Item",
                TR_TEXT_REQUEST_ITEM: "Enter the quantity you want to request",
                TR_CURRENT: "Current",
                TR_REMOVE_ITEM: "Remove Item",
                TR_TEXT_REMOVE_ITEM: "Enter the quantity you want to remove",
                TR_CHANGE_PRICE: "Change Price",
                TR_TEXT_CHANGE_PRICE: "Enter the new Price you want",


                TR_STORE_BALANCE: "STORE BALANCE",
                TR_STORE_TITLE_POP: "Add Money to the Store",
                TR_TEXT_ADD_MONEY: "Enter the amount of money you want to add to your store. This money must be in your bank account.",
                TR_MONEY_BANK: "bank account money",
                TR_STORE_TITLE_POP2: "Withdraw Money to the your Bank Account",
                TR_TEXT_WITHDRAW: "Enter the amount of money you want to remove to your store.",
                TR_MONEY_BALANCE: "balance money",
                TR_ADD_MONEY: "Add Money",
                TR_WITHDRAW: "Withdraw",

                TR_SELL: "SELL",
                TR_SELL_TEXT: "Currently the price of your store is",
                TR_SELL_TEXT2: "When selling, you will lose all rights to the items that exist in it. Do you really want to sell your store?",
                TR_CONFIRM_SELL: "Confirm Sell",
                TR_CONFIR_SELL_MESSAGE: "Do you really want to sell your store? The money will be sent to your bank account and the value of your store is currently:",

                TR_BUY: "BUY",
                TR_BUY_TEXT: "Currently the price of the store is",
                TR_BUY_TEXT2: "When purchasing, you will be able to manage this store and request new items. Do you really want to buy this store?",
                TR_CONFIRM_BUY: "Confirm Buy",
                TR_CONFIR_BUY_MESSAGE: "Do you really want to buy this store? The money will be charged from your bank account and the value of this store is currently:",

                TR_SOLD_OUT: "SOLD OUT",

                TR_MISSIONS : "MISSIONS",
                TR_STORE_MISSIONS : "STORE MISSIONS",
                TR_STORE_MISSIONS2: "STORE PRODUCTS MISSIONS",

                TR_OPERATION_SUCCESFUL : "Operation Successful.",
                TR_OPERATION_NEGADE : "Operation Denied.",

                TR_REQUEST : "Request",
                TR_ACCEPT_MISSION: "Accept Mission",
                TR_CANCEL_MISSION: "Cancel Mission",

                TR_PRICE_REQUEST: "Price of this request",

                TR_MISSIONS2: "Missions",
            },

            weightSystem: true,
            NameResource: "lg_manage_store",
            openned: false,
            page : "",
        })
    },

    methods: {
        OpenScreen: function(name){
            this.page = name;
        },

        receiveLua: function(event){
            if(!event || !event.data)
                return;
            
            const lua = event.data;

            if(lua.config){
                this.translate = lua.translate;
                this.NameResource = lua.NameResource;
                this.weightSystem = lua.weightSystem;

                this.payment_methods[0].name = this.translate.TR_BANK_ACCOUNT;
                this.payment_methods[1].name = this.translate.TR_WALLET_MONEY;
            }
            else if(lua.open){
                this.openned = true;

                this.store_title = lua.store_title;

                this.items = lua.items;

                this.StyleHeader.backgroundColor = lua.color_header;
                this.StyleBody.backgroundColor = lua.color_buttons;

                this.OpenScreen('Store');
            }

            else if(lua.open_buy){
                this.openned = true;

                this.store_title = lua.store_title;
                this.StyleHeader.backgroundColor = lua.color_header;
                this.StyleBody.backgroundColor = lua.color_buttons;

                this.price_store = lua.price_store;

                this.OpenScreen('Buy');
            }

             else if(lua.open_dashboard){
                this.openned = true;

                this.store_title = lua.store_title;
                this.StyleHeader.backgroundColor = lua.color_header;
                this.StyleBody.backgroundColor = lua.color_buttons;

                this.price_store = lua.price_store;
                this.percentage_sell = lua.percentage_sell;

                this.OpenScreen('Dashboard');
            }
        },

        close: function(){     
            const NameResource = this.NameResource[0];

            axios.post(`https://${NameResource}/close`, {
                
            }).catch(msg => console.log(msg));

            this.openned = false;
        },

        confirmConfig: function(){
            const NameResource = this.NameResource[0];
            axios.post(`https://${NameResource}/confirmConfig`, {
                
            }).catch(msg => console.log(msg));
        },

        keyPress: function(event){
            const key = event.key;
            
            if(key == "Escape"){
                this.close();
            }
        },
    },

    created: function(){
        window.addEventListener('message', this.receiveLua);  
        window.addEventListener('keydown', this.keyPress);
    },
    destroyed: function(){
        window.removeEventListener('message', this.receiveLua);
        window.removeEventListener('keydown', this.keyPress);
    }

}
</script>

<style>
    *{
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        list-style: none;
        font-family: 'Roboto', sans-serif;

        user-select: none;
        -moz-user-select: none;
        -webkit-user-select: none;
    }

    body{
        overflow: hidden;
    }    
</style>