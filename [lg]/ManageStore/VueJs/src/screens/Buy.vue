<template>
    <div>            
        <div id="PopUpBox" v-if="popUp">
            <div id="PopUp">
                <div id="PopAlert" v-if="step == 'sell'">
                    <i class="fas fa-shopping-cart"></i>
                    <p class="PopUpTitle">{{translate.TR_CONFIRM_TITLE}}</p>
                    <p class="PopUpMessage">{{translate.TR_CONFIR_BUY_MESSAGE}}</p>
                    <div id="PopUpButtons">
                        <p id="PopUpButtonGreen" :style="StyleBody" @click="SendBuyStore">{{translate.TR_YES}}</p>
                        <p id="PopUpButtonRed" @click="enablePopUp(false)">{{translate.TR_NO}}</p>
                    </div>
                </div>

                <div id="PopLoading" v-else-if="step == 'waiting'">
                    <div class="loader"></div>
                </div>

                <div id="PopSucessfull" v-else-if="step == 'success'">
                    <!-- <p class="close" @click="enablePopUp(false)">X</p> -->
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
                    {{translate.TR_BUY}}
                </div>

                <div id="StoreContentBox">
                    <div>
                        <div id="CartTitleBox">
                            <p id="CartTitle">{{translate.TR_BUY_STORE}}</p>
                        </div>

                        <div id="BalanceBox">
                            <div id="BalanceImageBox">
                                <img src="img/buy.png" alt="" id="BalanceImage">
                            </div>

                            <div id="BalanceMoneyBox">
                                <p id="BuyMoney">{{translate.TR_MONEY_SIMBOL}} {{price_store.toFixed(2)}}</p>
                                <p id="SellTextConfirm">{{translate.TR_BUY_TEXT}} {{translate.TR_MONEY_SIMBOL}} {{price_store.toFixed(2)}}. {{translate.TR_BUY_TEXT2}}</p>
                            </div>

                            <div id="BalanceButtonsBox">
                                <p class="BalanceButton" :style="StyleBody" @click="BuyStore">{{translate.TR_CONFIRM_BUY}}</p>
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
        price_store: {},
        store_title: {},
        StyleHeader: {},
        StyleBody: {},
        translate: {},
        NameResource: {},
        close: {},
    },

    data: function(){
        return({
            popUp: false,
            step: 'confirm',

            pop_up_error: "",
        })
    },

    methods: {

        enablePopUp: function(value){
            this.popUp = value;
        },

        BuyStore: function(){
            this.step = 'sell';
            this.enablePopUp(true);
        },

        SendBuyStore: function(){
            
            this.step = "waiting";

            // setTimeout(() => this.step = "error", 5000);

            const NameResource = this.NameResource[0];

            axios.post(`https://${NameResource}/sendBuyStore`, {

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
                    // 
                    setTimeout(() => this.close(), 2000);
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
    #BuyMoney{
        font-size: 4vh;
        font-weight: 500;
        color: #059250;
        text-shadow: 1px 1px 1px rgb(158, 158, 158);
        margin-top: 5vh;
    }
</style>