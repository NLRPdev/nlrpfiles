<template>
    <div>
        <div id="PopUpBox" v-if="popUp">
            <div id="PopUp">
                <div id="PopAlert" v-if="step == 'putSale'">
                    <p class="PopUpTitle PopUpTitleStock">{{translate.TR_PUT_FOT_SALE}}:</p>
                    <div class="StockItemPopImageBox">
                        <img :src="`img/${itemForSale.name}.png`" alt="" class="StockItemImage">
                    </div>
                    <p class="PopUpTitle">{{itemForSale.label}}</p>
                    <p class="PopUpMessage">{{translate.TR_TEXT_FOR_SALE}}</p>
                    <input type="number" name="" class="StockItemPopAmount" min="0" v-model="itemForSale_selected" @input="checkValidValue(1)" :placeholder="`${translate.TR_MAX}: ${itemForSale.amount}`">
                    <div id="PopUpButtons">
                        <p id="PopUpButtonGreen" :style="StyleBody" @click="SendPutForSale">{{translate.TR_PUT_FOT_SALE}}</p>
                        <p id="PopUpButtonRed" @click="enablePopUp(false)">{{translate.TR_CANCEL}}</p>
                    </div>
                </div>

                <div id="PopAlert" v-if="step == 'requestItem'">
                    <p class="PopUpTitle PopUpTitleStock">{{translate.TR_REQUEST_ITEM}}:</p>
                    <div class="StockItemPopImageBox">
                        <img :src="`img/${itemRequest.name}.png`" alt="" class="StockItemImage">
                    </div>
                    <p class="PopUpTitle">{{itemRequest.label}}</p>
                    <p class="PopUpTitle">{{translate.TR_PRICE_REQUEST}} {{translate.TR_MONEY_SIMBOL}} {{itemRequest_selected*itemRequest.request_price}}</p>
                    <p class="PopUpMessage">{{translate.TR_TEXT_REQUEST_ITEM}}</p>
                    <input type="number" name="" class="StockItemPopAmount" min="0" @input="checkValidValue(2)" v-model="itemRequest_selected" :placeholder="`${translate.TR_CURRENT}: ${itemRequest.amount}`">
                    <div id="PopUpButtons">
                        <p id="PopUpButtonGreen" :style="StyleBody" @click="SendRequestItem">{{translate.TR_REQUEST_ITEM}}</p>
                        <p id="PopUpButtonRed" @click="enablePopUp(false)">{{translate.TR_CANCEL}}</p>
                    </div>
                </div>

                <div id="PopAlert" v-if="step == 'removeItem'">
                    <p class="PopUpTitle PopUpTitleStock">{{translate.TR_REMOVE_ITEM}}:</p>
                    <div class="StockItemPopImageBox">
                        <img :src="`img/${itemRemove.name}.png`" alt="" class="StockItemImage">
                    </div>
                    <p class="PopUpTitle">{{itemRemove.label}}</p>
                    <p class="PopUpMessage">{{translate.TR_TEXT_REMOVE_ITEM}}</p>
                    <input type="number" name="" class="StockItemPopAmount" min="0" @input="checkValidValue(3)" v-model="itemRemove_selected" :placeholder="`${translate.TR_CURRENT}: ${itemRemove.amount}`">
                    <div id="PopUpButtons">
                        <p id="PopUpButtonGreen" :style="StyleBody" @click="SendRemoveItem">{{translate.TR_REMOVE_ITEM}}</p>
                        <p id="PopUpButtonRed" @click="enablePopUp(false)">{{translate.TR_CANCEL}}</p>
                    </div>
                </div>

                <div id="PopAlert" v-if="step == 'changePrice'">
                    <p class="PopUpTitle PopUpTitleStock">{{translate.TR_CHANGE_PRICE}}:</p>
                    <div class="StockItemPopImageBox">
                        <img :src="`img/${changePrice.name}.png`" alt="" class="StockItemImage">
                    </div>
                    <p class="PopUpTitle">{{changePrice.label}}</p>
                    <p class="PopUpMessage">{{translate.TR_TEXT_CHANGE_PRICE}}</p>
                    <input type="number" name="" class="StockItemPopAmount" min="0" @input="checkValidValue(4)" v-model="changePrice_selected" :placeholder="`${translate.TR_MAX}: ${changePrice.recommended_price}`">
                    <div id="PopUpButtons">
                        <p id="PopUpButtonGreen" :style="StyleBody" @click="SendChangePrice">{{translate.TR_CHANGE_PRICE}}</p>
                        <p id="PopUpButtonRed" @click="enablePopUp(false)">{{translate.TR_CANCEL}}</p>
                    </div>
                </div>

                <div id="PopLoading" v-else-if="step == 'waiting'">
                    <div class="loader"></div>
                </div>

                <div id="PopSucessfull" v-else-if="step == 'success'">
                    <p class="close" @click="enablePopUp(false)">X</p>
                    <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                    <circle class="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
                    <path class="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
                    </svg>

                    <p class="PaymentCompletText">{{translate.TR_OPERATION_SUCCESFUL}}</p>
                </div>

                <div id="PopNegade" v-else-if="step == 'error'">
                    <p class="close" @click="enablePopUp(false)">X</p>
                    <i class="fas fa-times"></i>

                    <p class="PaymentNegadeText">{{translate.TR_OPERATION_NEGADE}}</p>
                    <p class="PaymentNegadeReason">{{translate.TR_REASON}} {{pop_up_error}}</p>
                </div>
            </div>
        </div>
        <div id="StoreBodyBox" :class="{blur: popUp}" :style="StyleHeader">
            <p class="close" @click="close">X</p>
            <i class="fas fa-arrow-left preview" @click="OpenScreen('Dashboard')"></i>

            <div id="StoreTitleBox">
                <p id="StoreTitle">{{store_title}}</p>
            </div>

            <div id="StoreBox">
                <div id="StoreWindowBox">
                    {{translate.TR_STOCK}}
                </div>

                <div id="StoreContentBox">
                    <div>
                        <div id="CartTitleBox">
                            <p id="CartTitle">{{translate.TR_STORE_STOCK}}</p>
                        </div>

                        <div id="CartBodyBox">
                            <div class="StockItensBox">
                                <p class="StockItensTitle">{{translate.TR_STORE_PRODUCTS}}</p>
                            
                                <div class="Loading" v-if="loading">
                                    <div class="loader"></div>
                                </div>
                                <ul class="StockItensList" v-else>
                                    <li class="StockItem"
                                        v-for="(item) in stock.filter(element => element.amount > 0)"
                                        :key="item.name"
                                    >
                                        
                                        <div class="StockItemNameBox">
                                            <div class="StockItemImageBox">
                                                <img :src="`img/${item.name}.png`" alt="" class="StockItemImage">
                                            </div>

                                            <p class="StockItemName">{{item.label}}</p>
                                        </div>
                                    
                                        <p class="StockItemWeight" v-if="weightSystem">{{item.weight}}kg</p>

                                        <div class="StockItemAmountBox">
                                            <label for="">x</label>
                                            <label class="StockItemAmount" for="">{{item.amount}}</label>
                                        </div>

                                        <!-- <p class="StockItemPrice">{{translate.TR_MONEY_SIMBOL}}{{Number(item.amount * item.price).toFixed(2)}}</p> -->

                                        <p class="StockItemButton" :style="StyleBody" @click="PutForSale(item)">{{translate.TR_PUT_FOT_SALE}}</p>
                                        <p class="StockItemButton" :style="StyleBody" @click="RequestMission(item)">{{translate.TR_REQUEST}}</p>
                                    </li>

                                    <li class="StockItem grayScale"
                                        v-for="(item) in stock.filter(element => element.amount <= 0)"
                                        :key="item.name"
                                    >
                                        
                                        <div class="StockItemNameBox">
                                            <div class="StockItemImageBox">
                                                <img :src="`img/${item.name}.png`" alt="" class="StockItemImage">
                                            </div>

                                            <p class="StockItemName">{{item.label}}</p>
                                        </div>
                                    
                                        <p class="StockItemWeight" v-if="weightSystem">{{item.weight}}kg</p>

                                        <div class="StockItemAmountBox">
                                            <label for="">x</label>
                                            <label class="StockItemAmount" for="">{{item.amount}}</label>
                                        </div>

                                        <!-- <p class="StockItemPrice">{{translate.TR_MONEY_SIMBOL}}{{Number(item.amount * item.price).toFixed(2)}}</p> -->

                                        <p class="StockItemButton" :style="StyleBody">{{translate.TR_PUT_FOT_SALE}}</p>
                                        <p class="StockItemButton" :style="StyleBody" @click="RequestMission(item)">{{translate.TR_REQUEST}}</p>
                                    </li>
                                </ul>
                            </div>

                            <div class="StockItensBox">
                                <p class="StockItensTitle">{{translate.TR_STORE_PRODUCTS2}}</p>
                            
                                <div class="Loading" v-if="loading">
                                    <div class="loader"></div>
                                </div>
                                <ul class="StockItensList" v-else>
                                    <li class="StockItem"
                                        v-for="(item) in products.filter(element => element.amount > 0)"
                                        :key="item.name"
                                    >
                                        <div class="StockItemNameBox">
                                            <div class="StockItemImageBox">
                                                <img :src="`img/${item.name}.png`" alt="" class="StockItemImage">
                                            </div>

                                            <p class="StockItemName">{{item.label}}</p>
                                        </div>

                                        <p class="StockItemWeight" v-if="weightSystem">{{item.weight}}kg</p>

                                        <div class="StockItemAmountBox">
                                            <label for="">x</label>
                                            <label class="StockItemAmount" for="">{{item.amount}}</label>
                                        </div>

                                        <p class="StockItemPrice">{{translate.TR_MONEY_SIMBOL}}{{Number(item.price).toFixed(2)}}</p>

                                        <p class="StockItemButton" :style="StyleBody"  @click="RemoveItem(item)">{{translate.TR_REMOVE}}</p>
                                        <p class="StockItemButton" :style="StyleBody"  @click="ChangePrice(item)">{{translate.TR_CHANGE_PRICE}}</p>
                                    </li>

                                    <li class="StockItem grayScale"
                                        v-for="(item) in products.filter(element => element.amount <= 0)"
                                        :key="item.name"
                                    >
                                        <div class="StockItemNameBox">
                                            <div class="StockItemImageBox">
                                                <img :src="`img/${item.name}.png`" alt="" class="StockItemImage">
                                            </div>

                                            <p class="StockItemName">{{item.label}}</p>
                                        </div>

                                        <p class="StockItemWeight" v-if="weightSystem">{{item.weight}}kg</p>

                                        <div class="StockItemAmountBox">
                                            <label for="">x</label>
                                            <label class="StockItemAmount" for="">{{item.amount}}</label>
                                        </div>

                                        <p class="StockItemPrice">{{translate.TR_MONEY_SIMBOL}}{{Number(item.price).toFixed(2)}}</p>

                                        <p class="StockItemButton" :style="StyleBody">{{translate.TR_REMOVE}}</p>
                                        <p class="StockItemButton" :style="StyleBody"  @click="ChangePrice(item)">{{translate.TR_CHANGE_PRICE}}</p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>

import axios from 'axios';

export default {
    props: {
        store_title: {},
        StyleHeader: {},
        StyleBody: {},
        translate: {},
        weightSystem: {},
        NameResource: {},
        close: {},
        OpenScreen: {},
    },

    data: function(){
        return({
            stock: [
                {name : "bread", label : "Bread", amount : 51000000, weight : 1.0, price : 152, recommended_price : 100, max_price : 1000, request_price : 50, mission_money : 25, max_request : 500},
                {name : "drink", label : "Drink", amount : 0, weight : 10.0, price : 100, recommended_price : 100, max_price : 1000, request_price : 50, mission_money : 25, max_request : 500},
            ],

            products: [
                {name: "bread", label: "Bread", weight: 1.0, price: 500, amount: 1},
                {name: "drink", label: "Drink", weight: 1.0, price: 452.52, amount: 1},
            ],

            itemForSale: {},
            itemRequest: {},
            itemRemove: {},
            changePrice: {},

            itemForSale_selected: '',
            itemRequest_selected: '',
            itemRemove_selected: '',
            changePrice_selected: '',

            popUp: false,
            step: 'putSale',

            pop_up_error: "",

            loading: false,
        })
    },

    methods: {
        PutForSale: function(item){
            this.itemForSale = item;
            this.itemForSale_selected = '';
            this.step = "putSale";
            this.enablePopUp(true);
        },

        RequestMission: function(item){
            this.itemRequest = item;
            this.itemRequest_selected = '';
            this.step = "requestItem";
            this.enablePopUp(true);            
        },

        RemoveItem: function(item){
            this.itemRemove = item;
            this.itemRemove_selected = '';
            this.step = "removeItem";
            this.enablePopUp(true);
        },

        ChangePrice: function(item){
            this.changePrice = item;
            this.changePrice_selected = '';
            this.step = "changePrice";
            this.enablePopUp(true);            
        },

        SendPutForSale: function(){
            if(this.itemForSale_selected != ''){
                this.step = "waiting";

                // setTimeout(() => this.step = "error", 5000);

                const NameResource = this.NameResource[0];

                axios.post(`https://${NameResource}/sendPutForSale`, {
                    item: {...this.itemForSale, amount_selected: this.itemForSale_selected}
                }).then( () => {
                    this.loading = true;
                })
                .catch(msg => console.log(msg));
            }
        },

        SendRequestItem: function(){
            if(this.itemRequest_selected != ''){
                this.step = "waiting";

                // setTimeout(() => this.step = "error", 5000);

                const NameResource = this.NameResource[0];

                axios.post(`https://${NameResource}/sendRequestItem`, {
                    item: {...this.itemRequest, amount_selected: this.itemRequest_selected}
                }).then( () => {
                    this.loading = true;
                })
                .catch(msg => console.log(msg));
            }
        },

        SendRemoveItem: function(){
            if(this.itemRemove_selected != ''){
                this.step = "waiting";

                // setTimeout(() => this.step = "error", 5000);

                const NameResource = this.NameResource[0];

                axios.post(`https://${NameResource}/sendRemoveItem`, {
                    item: {...this.itemRemove, amount_selected: this.itemRemove_selected}
                }).then( () => {
                    this.loading = true; 
                })
                .catch(msg => console.log(msg));
            }
        },

        SendChangePrice: function(){
            if(this.changePrice_selected != ''){
                this.step = "waiting";

                // setTimeout(() => this.step = "error", 5000);

                const NameResource = this.NameResource[0];

                axios.post(`https://${NameResource}/sendChangePrice`, {
                    item: {...this.changePrice, price_selected: this.changePrice_selected}
                }).then( () => {
                    this.loading = true;
                })
                .catch(msg => console.log(msg));
            }
        },
        
        checkValidValue:function(index){
            if(index == 1){
                if(Number(this.itemForSale_selected) > Number(this.itemForSale.amount))
                    this.itemForSale_selected = this.itemForSale.amount;
                    
                if(this.itemForSale_selected < 1)
                    this.itemForSale_selected = 1;
            }

            else if(index == 2){
                if(this.itemRequest_selected > this.itemRequest.max_request)
                    this.itemRequest_selected = this.itemRequest.max_request;
                if(this.itemRequest_selected < 1)
                    this.itemRequest_selected = 1;
            }

            else if(index == 3){
                if(this.itemRemove_selected > this.itemRemove.amount)
                    this.itemRemove_selected = this.itemRemove.amount;
                if(this.itemRemove_selected < 1)
                    this.itemRemove_selected = 1;
            }

            else if(index == 4){
                if(this.changePrice_selected > this.changePrice.max_price)
                    this.changePrice_selected = this.changePrice.max_price;
                if(this.changePrice_selected < 0)
                    this.changePrice_selected = 0;
            }
        },

        TotalPrice: function(){
            let price = 0.0;

            this.cart.forEach(element => {
                price = price + (element.price * element.amount);
            });

            return price.toFixed(2);
        },

        enablePopUp: function(value){
            this.popUp = value;
        },

        LoadStock: function(){
            const NameResource = this.NameResource[0];

            axios.post(`https://${NameResource}/loadStock`, {
                
            }).then( () => {
                this.loading = true;
            })
            .catch(msg => console.log(msg));
        },

        receiveLua: function(event){
            if(!event || !event.data)
                return;
            
            const lua = event.data;

            if(lua.pop_up){
                
                this.step = lua.type;

                if(lua.message){
                    this.pop_up_error = lua.message;
                }

                if(this.step == "success"){
                    // 
                }
                
            }
            else if(lua.loadStock){
                this.stock = lua.stock;
                this.products = lua.products;
                this.loading = false;
            }
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

        this.LoadStock();
    },
    destroyed: function(){
        window.removeEventListener('message', this.receiveLua);
        window.removeEventListener('keydown', this.keyPress);
    }
}
</script>

<style>
    .StockItensBox{
        background-color: white;
        flex: 1;
        margin-left: 5vh;
        padding: 3vh 0;
        border-radius: 5px;
        box-shadow: 0px 0px 3px 1px rgba(173, 173, 173, 0.315);
    }

    .StockItensTitle{
        color: gray;
        font-weight: bold;
        font-size: 2vh;
        padding: 0 3vh;
    }

    .StockItensList{
        display: flex;
        flex-direction: column;
        margin-top: 2vh;
        height: 30vh;

        overflow-y: scroll;
    }

    .StockItensList::-webkit-scrollbar-track {
        background-color: #ffffff;
    }
    .StockItensList::-webkit-scrollbar {
        width: 0.0vh;
        background: rgba(20, 51, 136, 0.8);
    }
    .StockItensList::-webkit-scrollbar-thumb {
        background: rgba(5, 6, 65, 0.8);
        border-radius: 20px;
    }

    .StockItem{
        /* flex: 1; */
        display: flex;
        flex-direction: row;

        align-items: center;
        justify-content: space-between;

        border-bottom: 1px solid rgb(212, 212, 212);
        padding: 1vh 3vh;

        color: gray;
        font-weight: bold;
        font-size: 2.2vh;

        /* background: transparent !important; */
    }

    .StockItem:hover .StockItemWeight , .StockItem:hover .StockItemAmountBox , .StockItem:hover .StockItemPrice{
        display: none;
    }

    .StockItem:hover .StockItemButton{
        display: block;
    }

    .StockItem:first-child{
        border-top: 1px solid rgb(212, 212, 212);
    }

    .StockItemNameBox{
        display: flex;
        flex-direction: row;

        align-items: center;
    }

    .StockItemImageBox{
        background-color: #E9E9E9;
        display: flex;
        align-items: center;
        justify-content: center;

        width: 10vh;
        height: 6vh;
    }

    .StockItemPopImageBox{
        background-color: #E9E9E9;
        display: flex;
        align-items: center;
        justify-content: center;

        width: 20vh;
        height: 10vh;
        margin: auto;
    }

    .StockItemImage{
        max-width: 40%;
        max-height: 100%;
    }

    .StockItemName{
        margin-left: 1vh;
        overflow: hidden;
        /* background-color: tomato; */
        flex: 1;

        text-overflow: ellipsis;
    }

    .StockItemAmount{
        width: 8vh;
        border: none;
        outline: none;

        color: gray;
        font-weight: bold;
        font-size: 2.2vh;
    }

    .StockItemPrice{
        width: 25%;
        /* background-color: violet; */
    }

    .StockItemNameBox{
        width: 35%;
        /* background-color: tomato; */
    }

    .StockItemRemove{
        width: 15%;
        /* background-color: turquoise; */
        text-align: right;
        color: rgb(190, 0, 0);
    }

    .StockItemPrice{
        text-align: center;
    }

    .StockItemWeight, .StockItemAmountBox{
        width: 25%;
        /* background-color: wheat; */
        text-align: center;
    }

    .StockItemPrice, .StockItemNameBox, .StockItemRemove, .StockItemPrice, .StockItemWeight, .StockItemAmountBox{
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
    }

    .StockItemButton{
        display: none;
        color: white;
        padding: 1vh 2vh;
        border-radius: 20px;
        font-size: 2vh;
    }

    .StockItemButton:hover{
        opacity: 0.9;
    }

    .StockItensInfoBox{
        width: 100%;
        display: flex;
        flex-direction: row;
        align-items: center;
    }

    .PopUpTitleStock{
        margin: 0;
        margin-bottom: 3vh;
    }

    .StockItemPopAmount{
        padding: 1vh 2vh;
        font-size: 2.4vh;
        outline: none;
        border: none;
        background: rgb(240, 240, 240);
        border-radius: 20px;
        margin-top: 3vh;

        width: 50%;
        text-align: center;
    }
</style>