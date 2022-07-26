<template>
    <div>
        <div id="PopUpBox" v-if="popUp">
            <div id="PopUp">
                <div id="PopAlert" v-if="step == 'confirm'">
                    <i class="fas fa-shopping-cart"></i>
                    <p class="PopUpTitle">{{translate.TR_CONFIRM_TITLE}}</p>
                    <p class="PopUpMessage">{{translate.TR_CONFIR_MESSAGE}} <b>{{translate.TR_MONEY_SIMBOL}} {{TotalPrice()}}</b> {{translate.TR_CONFIR_MESSAGE2}} <b>{{buy_method}}</b>. {{translate.TR_CONFIR_MESSAGE3}}</p>
                    <div id="PopUpButtons">
                        <p id="PopUpButtonGreen" :style="StyleBody" @click="BuyItens">{{translate.TR_YES}}</p>
                        <p id="PopUpButtonRed" @click="enablePopUp(false)">{{translate.TR_NO}}</p>
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

                    <p class="PaymentCompletText">{{translate.TR_PAYMENT_COMPLETE}}</p>
                </div>

                <div id="PopNegade" v-else-if="step == 'error'">
                    <p class="close" @click="enablePopUp(false)">X</p>
                    <i class="fas fa-times"></i>

                    <p class="PaymentNegadeText">{{translate.TR_PAYMENT_NEGADE}}</p>
                    <p class="PaymentNegadeReason">{{translate.TR_REASON}} {{pop_up_error}}</p>
                </div>
            </div>
        </div>
        <div id="StoreBodyBox" :class="{blur: popUp}" :style="StyleHeader">
            <p class="close" @click="close">X</p>

            <div id="StoreTitleBox">
                <p id="StoreTitle">{{store_title}}</p>
            </div>

            <div id="StoreBox">
                <div id="StoreWindowBox">
                    {{inCart ? translate.TR_TITLEWINDOW2 : translate.TR_TITLEWINDOW}}
                </div>

                <div id="StoreContentBox">
                    <div v-if="!inCart">
                        <div id="StoreContentTopBox">
                            <div id="StoreSearchBox">
                                <i class="fas fa-search"></i>
                                <input type="text" id="StoreInputSearch" :placeholder="translate.TR_SEARCH" v-model="search">
                            </div>

                            <div id="StoreCartButton" :style="StyleBody">
                                <div class="ClickBox" @click="GoToCart(true)"></div>
                                <i class="fas fa-shopping-cart"></i>
                                <p>{{translate.TR_MY_CART}}</p>
                                <i class="fas fa-arrow-right"></i>
                            </div>
                        </div>

                        <div id="StoreListItensBox">
                            <ul id="StoreListItens">
                                <li class="StoreItem"
                                    v-for="(item) in items.filter( item => {
                                        for(let i = 0; i < cart.length; i++){
                                            if(cart[i].name == item.name){
                                                return false;
                                            }
                                        }

                                        if(!item.label.includes(this.search))
                                            return false;

                                        if(item.amount <= 0)
                                            return false;

                                        return true;
                                    })"
                                    :key="item.name"
                                >
                                    <p class="StoreItemWeight" v-if="weightSystem">{{item.weight}}{{translate.TR_WEIGHT_SYMBOL}}</p>
                                    
                                    <div class="StoreItemImageBox">
                                        <img :src="`img/${item.name}.png`" alt="" class="StoreItemImage">
                                    </div>

                                    <p class="StoreItemName">{{item.label}}</p>
                                    <p class="StoreItemPrice">{{translate.TR_MONEY_SIMBOL}} {{Number(item.price).toFixed(2)}}</p>

                                    <div class="StoreItemCartButton" :style="StyleBody">
                                        <div class="ClickBox" @click="AddCart(item)"></div>
                                        <i class="fas fa-shopping-cart"></i>
                                        <p>{{translate.TR_ADD_TO_CART}}</p>
                                    </div>
                                </li>

                                <li class="StoreItem grayScale"
                                    v-for="(item) in items.filter( item => {
                                        for(let i = 0; i < cart.length; i++){
                                            if(cart[i].name == item.name){
                                                return false;
                                            }
                                        }

                                        if(!item.label.includes(this.search))
                                            return false;

                                        if(item.amount > 0)
                                            return false;

                                        return true;
                                    })"
                                    :key="item.name"
                                >
                                    <p class="StoreItemWeight" v-if="weightSystem">{{item.weight}}{{translate.TR_WEIGHT_SYMBOL}}</p>
                                    
                                    <div class="StoreItemImageBox">
                                        <img :src="`img/${item.name}.png`" alt="" class="StoreItemImage">
                                    </div>

                                    <p class="StoreItemName">{{item.label}}</p>
                                    <p class="StoreItemPrice">{{translate.TR_MONEY_SIMBOL}} {{Number(item.price).toFixed(2)}}</p>

                                    <div class="StoreItemCartButton" :style="StyleBody">
                                        <i class="fas fa-shopping-cart"></i>
                                        <p>{{translate.TR_SOLD_OUT}}</p>
                                    </div>
                                </li>
                            </ul>
                        </div>

                        <div id="MissionsButton" :style="StyleBody" @click="OpenScreen('Missions')">{{translate.TR_MISSIONS2}}</div>
                    </div>

                    <div v-else>
                        <div id="CartTitleBox">
                            <p id="CartTitle">{{translate.TR_PAYMENT}}</p>
                        </div>

                        <div id="CartBodyBox">
                            <div class="CartItensBox">
                                <p class="CartItensTitle">{{store_title}} {{translate.TR_STORE_CART}}</p>
                            
                                <ul id="CartItensList">
                                    <li class="CartItem"
                                        v-for="(item,index) in cart"
                                        :key="item.name"
                                    >
                                        <div class="CartItemNameBox">
                                            <div class="CartItemImageBox">
                                                <img :src="`img/${item.name}.png`" alt="" class="CartItemImage">
                                            </div>

                                            <p class="CartItemName">{{item.label}}</p>
                                        </div>

                                        <p class="CartItemWeight" v-if="weightSystem">{{item.weight}}kg</p>

                                        <div class="CartItemAmountBox">
                                            <label for="">x</label>
                                            <input class="CartItemAmount" type="number" min="1" v-model="item.amount_selected" @input="checkValidValue(index)"/>
                                            <label for="">/ {{item.amount}}</label>
                                        </div>

                                        <p class="CartItemPrice">{{translate.TR_MONEY_SIMBOL}}{{Number(item.amount_selected * item.price).toFixed(2)}}</p>

                                        <p class="CartItemRemove" @click="RemoveCart(item)">{{translate.TR_REMOVE}}</p>
                                    </li>
                                </ul>

                                <div id="CartBodyFooterBox">
                                    <div id="CartBodyFooterButton">
                                        <div class="ClickBox" @click="GoToCart(false)"></div>
                                        <i class="fas fa-arrow-left"></i>
                                        <p>{{translate.TR_CONTINUE_SHOPPING}}</p>
                                    </div>

                                    <p id="CartBodyFooterTotal">{{translate.TR_TOTAL}} {{translate.TR_MONEY_SIMBOL}}{{TotalPrice()}}</p>
                                </div>
                            </div>

                            <div id="CartPaymentBox">
                                <p class="CartPaymentTitle">{{translate.TR_PAYMENT_OPTIONS}}</p>

                                <ul id="CartPaymentList">
                                    <li class="CartPaymentItem"
                                        v-for="item in payment_methods"
                                        :key="item.name"
                                        :class="{CartPaymentItemChecked : item.name == buy_method}"
                                    >
                                        <div class="ClickBox" @click="SelectMethod(item.name)"></div>
                                        <div class="CartPaymentNameBox">
                                            <img :src="item.img" alt="" class="CartPaymentImage">
                                            <p class="CartPaymentName">{{item.name}}</p>
                                        </div>

                                        <div class="CheckedPayment"></div>
                                    </li>
                                </ul>

                                <div id="CartPaymentButtonBuy" :style="StyleBody" :class="{disabledButton : cart.length <= 0}" @click="ConfirmBuyItens">{{translate.TR_BUY_NOW}}</div>
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
        items: {},
        payment_methods: {},
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
            cart: [

            ],

            search: "",
            inCart: false,
            popUp: false,

            buy_method: "Bank Account",
            step: 'confirm',

            pop_up_error: "",
        })
    },

    methods: {
        AddCart: function(item){
            this.cart.push({
                ...item,
                amount_selected: 1
            });
        },

        RemoveCart: function(item){
            this.cart.forEach((element, index) => {
                if(element.name == item.name)
                    this.cart.splice(index, 1);
            });
        },

        GoToCart: function(value){
            this.inCart = value;
        },

        checkValidValue:function(index){
            if(this.cart[index].amount_selected < 1){
                this.cart[index].amount_selected = 1;
            }
            if(this.cart[index].amount_selected > this.cart[index].amount){
                this.cart[index].amount_selected = this.cart[index].amount;
            }
        },

        TotalPrice: function(){
            let price = 0.0;

            this.cart.forEach(element => {
                price = price + (element.price * element.amount_selected);
            });

            return price.toFixed(2);
        },

        SelectMethod: function(name){
            this.buy_method = name;
        },

        enablePopUp: function(value){
            this.popUp = value;
        },

        ConfirmBuyItens: function(){
            if(this.cart.length <= 0)
                return;

            this.step = 'confirm';
            this.enablePopUp(true);
        },

        BuyItens: function(){
            
            this.step = "waiting";

            // setTimeout(() => this.step = "error", 5000);

            const NameResource = this.NameResource[0];

            axios.post(`https://${NameResource}/buyItens`, {
                cart: this.cart,
                buy_method: this.buy_method
            }).then( () => {
                // 
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
                    this.items.forEach(element => {
                        this.cart.forEach(element2 => {
                            if (element.name == element2.name) {
                                element.amount = element.amount - element2.amount_selected;
                            }
                        })
                    })

                    this.cart = [];
                }
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

        this.buy_method = this.translate.TR_BANK_ACCOUNT;
    },
    destroyed: function(){
        window.removeEventListener('message', this.receiveLua);
        window.removeEventListener('keydown', this.keyPress);
    }
    
}
</script>

<style>
    #StoreBodyBox{
        width: 150vh;
        height: 85vh;
        overflow: hidden;

        position: absolute;
        top: 50%;
        left: 50%;

        transform: translate(-50%, -50%);

        display: flex;
        flex-direction: column;
    }

    .blur{
        filter: blur(2px);
    }

    .close{
        position: absolute;
        top: 2%;
        right: 1%;
        color: white;
        font-size: 2.5vh;
    }

    .preview{
        position: absolute;
        top: 2%;
        left: 1%;
        color: white;
        font-size: 2.5vh;
    }

    #StoreBox{
        display: flex;
        flex-direction: column;
        flex: 1;
    }

    #StoreTitleBox{
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;

        width: 100%;
        height: 15vh;
    }

    #StoreTitle{
        color: white;
        font-size: 4.5vh;
        font-weight: bold;
    }

    #StoreWindowBox{
        background-color: #F1F1F1;
        width: max-content;
        padding: 1.5vh 2.5vh;
        border-radius: 5px 5px 0 0;
        margin-left: 10vh;

        font-size: 2.6vh;
        font-weight: 600;
        color: #323C67;
    }

    #StoreContentBox{
        background-color: #F1F1F1;
        margin-top: -0.1vh;
        flex: 1;

        padding: 2vh 5vh;
    }

    #StoreContentTopBox{
        display: flex;
        flex-direction: row;

        justify-content: space-between;
        align-items: center;

        margin: 0 5vh;
    }

    #StoreSearchBox{
        flex: 1;
        display: flex;
        flex-direction: row;
        align-items: center;

        background-color: white;
        color: gray;
        border-radius: 20px;
        padding: 0 2vh;

        font-size: 2.4vh;
    }

    #StoreInputSearch{
        flex: 1;
        border: none;
        outline: none;
        padding: 1vh;
        
        font-size: 2.4vh;
        background-color: rgba(255, 255, 255, 0);
        color: gray;
    }

    #StoreInputSearch::placeholder{
        color: gray;
    }

    #StoreCartButton{
        /* background-color: #03b67a; */
        color: white;
        width: max-content;

        padding: 1vh 3vh;
        border-radius: 3px;
        /* box-shadow: 0px 0px 1px 1px rgba(199, 199, 199, 0.315); */
        margin-left: 5vh;

        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;

        font-weight: bolder;
        font-size: 3vh;

        position: relative;
    }
    #StoreCartButton:hover{
        /* background-color: #02a16c; */
        opacity: 0.9;
    }
    #StoreCartButton i:first-of-type{
        margin-right: 3vh;
    }

    #StoreCartButton i:last-child{
        margin-left: 3vh;
    }

    #StoreListItensBox{
        overflow-y: scroll;
        max-height: 48vh;
        margin-top: 1vh;
    }

    #StoreListItensBox::-webkit-scrollbar-track {
        background-color: #ffffff;
    }
    #StoreListItensBox::-webkit-scrollbar {
        width: 0.0vh;
        background: rgba(20, 51, 136, 0.8);
    }
    #StoreListItensBox::-webkit-scrollbar-thumb {
        background: rgba(5, 6, 65, 0.8);
        border-radius: 20px;
    }

    #StoreListItens{
        display: flex;
        flex-direction: row;
        flex-wrap: wrap;
        margin: 0 5vh;
        margin-bottom: 2vh;
    }

    .StoreItem{
        background-color: white;
        box-shadow: 1px 1px 3px 1px #a2a2a280;
        margin-right: 4vh;
        margin-top: 4vh;

        width: 20vh;
        height: 30vh;

        position: relative;
        padding: 0.5vh;
    }

    .StoreItemWeight{
        position: absolute;
        background-color: #F19D74;
        box-shadow: 3px 3px 6px 1px #bf7e5de0;
        font-size: 1.5vh;
        font-weight: bold;
        color: white;
        padding: 0.6vh 1.5vh;

        transform: translate(-50%, 80%);
    }

    .StoreItemImageBox{
        background-color: #E9E9E9;
        width: 100%;
        height: 55%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .StoreItemImage{
        max-width: 50%;
        max-height: 100%;
    }

    .StoreItemName{
        color: gray;
        text-align: center;
        margin-top: 1vh;
        font-size: 2.2vh;
    }

    .StoreItemPrice{
        color: #323C67;
        font-weight: 500;
        text-align: center;
        margin-top: 1vh;
        font-size: 2.2vh;
    }

    .StoreItemCartButton{
        /* background-color: #03b67a; */
        color: white;

        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;

        font-size: 1.5vh;
        font-weight: bold;
        /* padding: 1vh 2vh; */
        padding: 1vh 0;

        width: 80%;
        margin: auto;
        margin-top: 1vh;

        position: relative;
    }

    .StoreItemCartButton:hover{
        /* background-color: #02a16c; */
        opacity: 0.9;
    }

    .StoreItemCartButton p{
        margin-left: 1vh;
    }

    .ClickBox{
        /* background-color: black; */
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0;
        left: 0;
    }

    #CartTitleBox{
        text-align: center;
        font-size: 5vh;
        font-weight: bolder;
        color: #323C67;
    }

    #CartBodyBox{
        display: flex;
        flex-direction: row;
        justify-content: center;

        margin-top: 2vh;
    }

    .CartItensBox{
        background-color: white;
        flex: 1;
        margin-left: 5vh;
        padding: 3vh;
        border-radius: 5px;
        box-shadow: 0px 0px 3px 1px rgba(173, 173, 173, 0.315);
    }

    .CartItensTitle{
        color: gray;
        font-weight: bold;
        font-size: 2vh;
    }

    #CartItensList{
        display: flex;
        flex-direction: column;
        margin-top: 2vh;
        height: 30vh;

        overflow-y: scroll;
    }

    #CartItensList::-webkit-scrollbar-track {
        background-color: #ffffff;
    }
    #CartItensList::-webkit-scrollbar {
        width: 0.0vh;
        background: rgba(20, 51, 136, 0.8);
    }
    #CartItensList::-webkit-scrollbar-thumb {
        background: rgba(5, 6, 65, 0.8);
        border-radius: 20px;
    }

    .CartItem{
        /* flex: 1; */
        display: flex;
        flex-direction: row;

        align-items: center;
        justify-content: space-between;

        border-bottom: 1px solid rgb(212, 212, 212);
        padding: 1vh 0;

        color: gray;
        font-weight: bold;
        font-size: 2.2vh;
    }

    .CartItem:first-child{
        border-top: 1px solid rgb(212, 212, 212);
    }

    .CartItemNameBox{
        display: flex;
        flex-direction: row;

        align-items: center;
    }

    .CartItemImageBox{
        background-color: #E9E9E9;
        display: flex;
        align-items: center;
        justify-content: center;

        width: 10vh;
        height: 6vh;
    }

    .CartItemImage{
        max-width: 40%;
        max-height: 100%;
    }

    .CartItemName{
        margin-left: 1vh;
        overflow: hidden;
        /* background-color: tomato; */
        flex: 1;

        text-overflow: ellipsis;
    }

    .CartItemAmount{
        width: 8vh;
        border: none;
        outline: none;

        color: gray;
        font-weight: bold;
        font-size: 2.2vh;
        text-align: right;

        background: whitesmoke;
    }

    .CartItemPrice{
        width: 25%;
        /* background-color: violet; */
    }

    .CartItemNameBox{
        width: 35%;
        /* background-color: tomato; */
    }

    .CartItemRemove{
        width: 15%;
        /* background-color: turquoise; */
        text-align: right;
        color: rgb(190, 0, 0);
    }

    .CartItemPrice{
        text-align: center;
    }

    .CartItemWeight{
        width: 10%;
        /* background-color: wheat; */
        text-align: center;
    }

    .CartItemAmountBox{
        width: 25%;
        /* background-color: wheat; */
        text-align: center;
    }

    .CartItemPrice, .CartItemNameBox, .CartItemRemove, .CartItemPrice, .CartItemWeight, .CartItemAmountBox{
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
    }

    #CartBodyFooterBox{
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;

        padding: 1vh 0;
        margin-top: 2vh;
    }

    #CartBodyFooterButton{
        display: flex;
        flex-direction: row;
        align-items: center;

        color: gray;
        font-size: 2vh;

        border: 1px solid gray;
        border-radius: 5px;
        padding: 1vh 1vh;
        font-weight: bold;

        transition: 0.3s all;

        position: relative;
    }

    #CartBodyFooterButton p{
        margin-left: 1vh;
    }

    #CartBodyFooterButton:hover{
        background-color: gray;
        color: white;
    }

    #CartBodyFooterTotal{
        font-size: 2.8vh;
        color:gray;
        font-weight: bold;
    }

    #CartPaymentBox{
        background-color: white;
        margin-left: 2vh;
        padding: 3vh;
        border-radius: 5px;
        box-shadow: 0px 0px 3px 1px rgba(173, 173, 173, 0.315);

        width: 40vh;

        display: flex;
        flex-direction: column;
    }

    .CartPaymentTitle{
        color: gray;
        font-weight: bold;
        font-size: 2vh;
    }

    #CartPaymentList{
        margin-top: 2vh;
        flex: 1;
    }

    .CartPaymentItem{
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;

        background-color: rgb(243, 243, 243);
        padding: 1vh;

        margin-top: 1vh;

        position: relative;
    }

    .CartPaymentItemChecked{
        background-color: rgb(228, 228, 228);
    }

    .CartPaymentNameBox{
        display: flex;
        flex-direction: row;

        align-items: center;
    }

    .CartPaymentImage{
        width: 15%;
    }

    .CartPaymentName{
        margin-left: 1vh;
        color: gray;
        font-weight: bold;
        font-size: 2vh;
    }

    .CheckedPayment{
        width: 10px;
        height: 10px;
        border-radius: 50%;
        border: 1px solid rgb(206, 206, 206);

        background-color: white;
    }

    .CartPaymentItemChecked .CheckedPayment{
        background-color: rgb(75, 75, 75);
    }
    

    #CartPaymentButtonBuy{
        text-align: center;
        /* background-color: #03b67a; */

        padding: 3vh;

        font-size: 3vh;
        font-weight: bold;
        color: white;

        border-radius: 5px;
    }

    #CartPaymentButtonBuy:hover{
        /* background-color: #02a16c; */
        opacity: 0.9;
    }

    #PopUpBox{
        position: absolute;

        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);

        width: 150vh;
        min-height: 85vh;

        z-index: 1;
    }

    #PopUp{
        width: 75vh;
        min-height: 50vh;

        position: absolute;

        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);

        background-color: white;
        box-shadow: 0px 0px 3px 1px rgb(168, 168, 168);
        border-radius: 5px;
        z-index: 1;

        text-align: center;
        padding: 5vh;

        animation: entering;
        animation-duration: 1s;
    }

    #PopUpBox i{
        font-size: 8vh;
        color: #02a16c;

        border: 5px solid #02a16c;
        width: 15vh;
        height: 15vh;
        border-radius: 50%;

        display: flex;
        justify-content: center;
        align-items: center;

        margin: auto;
        /* margin-top: 5vh; */
    }

    .PopUpTitle{
        font-size: 2.5vh;
        font-weight: bold;
        color: rgb(80, 80, 80);
        margin-top: 2vh;
    }
    .PopUpMessage{
        font-size: 2vh;
        margin-top: 2vh;
    }
    #PopUpButtons{
        display: flex;
        flex-direction: row;
        justify-content: center;

        margin-top: 5vh;
    }
    #PopUpButtonGreen{
        /* background-color: #03b67a; */
        padding: 0.5vh 3vh;

        border-radius: 10px;
        color: whitesmoke;
    }
    #PopUpButtonRed{
        margin-left: 3vh;

        background-color: rgb(150, 150, 150);
        padding: 0.5vh 3vh;

        border-radius: 10px;
        color: whitesmoke;
    }

    @keyframes entering{
        0%{
            top: 150%;
        }
        100%{
            top: 50%;
        }
    }

    .loader {
        border: 16px solid #f3f3f3; /* Light grey */
        border-top: 16px solid #3498db; /* Blue */
        border-radius: 50%;
        width: 20vh;
        height: 20vh;
        animation: spin 2s linear infinite;
        margin: auto;
        margin-top: 5vh;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    .checkmark__circle {
        stroke-dasharray: 166;
        stroke-dashoffset: 166;
        stroke-width: 2;
        stroke-miterlimit: 10;
        stroke: #7ac142;
        fill: none;
        animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
    }

    .checkmark {
        width: 12vh;
        height: 12vh;
        border-radius: 50%;
        display: block;
        stroke-width: 3;
        stroke: #fff;
        stroke-miterlimit: 10;
        margin: 0 auto;
        margin-top: 8vh;
        box-shadow: inset 0px 0px 0px #7ac142;
        animation: fill .4s ease-in-out .4s forwards, scale .3s ease-in-out .9s both;
        /* background-color: #7ac142; */
    }

    .checkmark__check {
        transform-origin: 50% 50%;
        stroke-dasharray: 48;
        stroke-dashoffset: 48;
        animation: stroke 0.3s cubic-bezier(0.65, 0, 0.45, 1) 0.8s forwards;
    }

    @keyframes stroke {
        100% {
            stroke-dashoffset: 0;
        }
    }

    @keyframes scale {
        0%, 100% {
            transform: none;
        }
        50% {
            transform: scale3d(1.1, 1.1, 1);
        }
    }
    @keyframes fill {
        100% {
            box-shadow: inset 0px 0px 0px 10vh #7ac142;
        }
    }

    #PopNegade i{
        border: 5px solid #bd2525;
        color: #bd2525;
        margin-top: 5vh;
    }

    #PopSucessfull .close, #PopNegade .close{
        color: rgb(71, 71, 71);
        font-weight: bolder;
    }

    .PaymentCompletText{
        font-size: 3vh;
        color: #2c743e;
        font-weight: 500;
        margin-top: 2vh;
    }

    .PaymentNegadeText{
        font-size: 3vh;
        color: #742c2c;
        font-weight: 500;
        margin-top: 2vh;
    }
    .PaymentNegadeReason{
        margin-top: 3vh;
        font-size: 2vh;
        color: gray;
        font-weight: 500;
    }

    .disabledButton{
        background-color: gray !important;
    }

    #MissionsButton{
        position: absolute;
        top: 50%;
        right: 0;
        transform: translate(35%, -50%) rotateZ(270deg);

        padding: 0.6vh 2vh;
        color: whitesmoke;
        font-weight: 500;

        font-size: 2.4vh;
        border-radius: 20px 20px 0 0;
    }

    #MissionsButton:hover{
        opacity: 0.9;
    }

    .grayScale{
        filter: grayscale(1);
    }
</style>