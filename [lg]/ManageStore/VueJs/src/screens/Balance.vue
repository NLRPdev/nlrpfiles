<template>
    <div>     
        <div id="PopUpBox" v-if="popUp">
            <div id="PopUp">
                <div id="PopAlert" v-if="step == 'addMoney'">
                    <i class="fas fa-dollar-sign"></i>
                    <p class="PopUpTitle">{{translate.TR_STORE_TITLE_POP}}</p>
                    <p class="PopUpMessage">{{translate.TR_TEXT_ADD_MONEY}}</p>
                    <input type="number" name="" class="StockItemPopAmount" min="0" v-model="addMoney" @input="checkValidMoney" :placeholder="`${translate.TR_MONEY_BANK}:`">
                    <div id="PopUpButtons">
                        <p id="PopUpButtonGreen" :style="StyleBody" @click="SendAddMoney">{{translate.TR_ADD_MONEY}}</p>
                        <p id="PopUpButtonRed" @click="enablePopUp(false)">{{translate.TR_CANCEL}}</p>
                    </div>
                </div>

                <div id="PopAlert" v-if="step == 'withdraw'">
                    <i class="fas fa-dollar-sign"></i>
                    <p class="PopUpTitle">{{translate.TR_STORE_TITLE_POP2}}</p>
                    <p class="PopUpMessage">{{translate.TR_TEXT_WITHDRAW}}</p>
                    <input type="number" name="" class="StockItemPopAmount" min="0" v-model="withdraw" @input="checkValidWithdraw" :placeholder="`${translate.TR_MONEY_BALANCE}`">
                    <div id="PopUpButtons">
                        <p id="PopUpButtonGreen" :style="StyleBody" @click="SendWithdraw">{{translate.TR_WITHDRAW}}</p>
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
            <i class="fas fa-arrow-left preview" @click="OpenScreen('Dashboard')"></i>

            <div id="StoreTitleBox">
                <p id="StoreTitle">{{store_title}}</p>
            </div>

            <div id="StoreBox">
                <div id="StoreWindowBox">
                    {{translate.TR_BALANCE}}
                </div>

                <div id="StoreContentBox">
                    <div>
                        <div id="CartTitleBox">
                            <p id="CartTitle">{{translate.TR_STORE_BALANCE}}</p>
                        </div>

                        <div id="Loading" v-if="loading">
                            <div class="loader"></div>
                        </div>

                        <div id="BalanceBox" v-else>
                            <div id="BalanceImageBox">
                                <img src="img/salary.png" alt="" id="BalanceImage">
                            </div>

                            <div id="BalanceMoneyBox">
                                <p id="BalanceMoney">{{translate.TR_MONEY_SIMBOL}} {{balance.toFixed(2)}}</p>
                            </div>

                            <div id="BalanceButtonsBox">
                                <p class="BalanceButton" :style="StyleBody" @click="AddMoney">{{translate.TR_ADD_MONEY}}</p>
                                <p class="BalanceButton" @click="Withdraw">{{translate.TR_WITHDRAW}}</p>
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
        NameResource: {},
        close: {},
        OpenScreen: {},
    },

    data: function(){
        return({
            popUp: false,
            step: 'confirm',

            pop_up_error: "",

            addMoney: "",
            withdraw: "",

            loading: false,
            balance: 0
        })
    },

    methods: {
        AddMoney: function(){
            this.step = 'addMoney';
            this.enablePopUp(true);
        },

        Withdraw: function(){
            this.step = 'withdraw';
            this.enablePopUp(true);
        },

        SendAddMoney: function(){
            if(this.addMoney && this.addMoney > 0){
                this.step = "waiting";

                // setTimeout(() => this.step = "error", 5000);

                const NameResource = this.NameResource[0];

                axios.post(`https://${NameResource}/sendAddMoney`, {
                    money: this.addMoney
                }).then( () => {
                    this.loading = true;
                })
                .catch(msg => console.log(msg));
            }
        },

        SendWithdraw: function(){
            if(this.withdraw && this.withdraw > 0){
                this.step = "waiting";

                // setTimeout(() => this.step = "error", 5000);

                const NameResource = this.NameResource[0];

                axios.post(`https://${NameResource}/sendWithdraw`, {
                    money: this.withdraw
                }).then( () => {
                    this.loading = true;
                })
                .catch(msg => console.log(msg));
            }
        },

        checkValidMoney:function(){
            if(this.addMoney < 0){
                this.addMoney = 0;
            }
            if(this.addMoney > 9999999){
                this.addMoney = 9999999;
            }
        },

        checkValidWithdraw:function(){
            if(this.withdraw < 0){
                this.withdraw = 0;
            }
            if(this.withdraw > 9999999){
                this.withdraw = 9999999;
            }
        },

        enablePopUp: function(value){
            this.popUp = value;
        },

        LoadBalance: function(){
            const NameResource = this.NameResource[0];

            axios.post(`https://${NameResource}/loadBalance`, {
                money: this.withdraw
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
            else if(lua.loadBalance){
                this.balance = lua.money;
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

        this.LoadBalance();
    },
    destroyed: function(){
        window.removeEventListener('message', this.receiveLua);
        window.removeEventListener('keydown', this.keyPress);
    }
}
</script>

<style>
    #BalanceBox{
        margin-top: 5vh;
        text-align: center;
    }
    #BalanceImageBox{
        text-align: center;
    }

    #BalanceMoneyBox{
        width: 60%;
        margin: auto;
    }

    #BalanceMoney{
        font-size: 4vh;
        font-weight: 500;
        color: green;
        text-shadow: 1px 1px 1px rgb(158, 158, 158);
        margin-top: 5vh;
    }

    #BalanceButtonsBox{
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;

        margin-top: 5vh;
    }

    .BalanceButton:not(:first-child){
        margin-left: 5vh;
    }

    .BalanceButton{
        padding: 1vh 4vh;
        color: white;
        border-radius: 3px;
        font-weight: 500;

        background-color: rgb(104, 104, 104);
        text-align: center;
    }
    .BalanceButton:hover{
        opacity: 0.9;
    }
</style>