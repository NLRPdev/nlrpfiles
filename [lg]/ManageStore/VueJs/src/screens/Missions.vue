<template>
    <div>
        <div id="StoreBodyBox" :style="StyleHeader">
            <p class="close" @click="close">X</p>
            <i class="fas fa-arrow-left preview" @click="OpenScreen('Store')"></i>

            <div id="StoreTitleBox">
                <p id="StoreTitle">{{store_title}}</p>
            </div>

            <div id="StoreBox">
                <div id="StoreWindowBox">
                    {{translate.TR_MISSIONS}}
                </div>

                <div id="StoreContentBox">
                    <div>
                        <div id="CartTitleBox">
                            <p id="CartTitle">{{translate.TR_STORE_MISSIONS}}</p>
                        </div>

                        <div id="CartBodyBox">
                            <div class="MissionItensBox">
                                <p class="MissionItensTitle">{{translate.TR_STORE_MISSIONS2}}</p>
                            
                                <div class="Loading" v-if="loading">
                                    <div class="loader"></div>
                                </div>
                                <ul class="MissionItensList" v-else>
                                    <li class="MissionItem"
                                        v-for="(item) in request.filter(element => element.requested == identifier)"
                                        :key="item.name"
                                    >
                                        
                                        <div class="MissionItemNameBox">
                                            <div class="MissionItemImageBox">
                                                <img :src="`img/${item.name}.png`" alt="" class="MissionItemImage">
                                            </div>

                                            <p class="MissionItemName">{{item.label}}</p>
                                        </div>
                                    
                                        <p class="MissionItemWeight" v-if="weightSystem">{{item.weight}}kg</p>

                                        <div class="MissionItemAmountBox">
                                            <label for="">x</label>
                                            <label class="MissionItemAmount" for="">{{item.amount}}</label>
                                        </div>

                                        <p class="MissionItemPrice">{{translate.TR_MONEY_SIMBOL}}{{Number(item.amount * item.mission_money).toFixed(2)}}</p>

                                        <p class="MissionItemButton" :style="StyleBody" @click="CancelMission(item)">{{translate.TR_CANCEL_MISSION}}</p>
                                        <!-- <p class="MissionItemButton" :style="StyleBody" @click="CancelMission(item)">Cancel</p> -->
                                    </li>

                                    <li class="MissionItem"
                                        v-for="(item) in request.filter(element => element.requested == 'none')"
                                        :key="item.name"
                                    >
                                        
                                        <div class="MissionItemNameBox">
                                            <div class="MissionItemImageBox">
                                                <img :src="`img/${item.name}.png`" alt="" class="MissionItemImage">
                                            </div>

                                            <p class="MissionItemName">{{item.label}}</p>
                                        </div>
                                    
                                        <p class="MissionItemWeight" v-if="weightSystem">{{item.weight}}kg</p>

                                        <div class="MissionItemAmountBox">
                                            <label for="">x</label>
                                            <label class="MissionItemAmount" for="">{{item.amount}}</label>
                                        </div>

                                        <p class="MissionItemPrice">{{translate.TR_MONEY_SIMBOL}}{{Number(item.amount * item.mission_money).toFixed(2)}}</p>

                                        <p class="MissionItemButton" :style="StyleBody" @click="AcceptMission(item)">{{translate.TR_ACCEPT_MISSION}}</p>
                                        <!-- <p class="MissionItemButton" :style="StyleBody" @click="CancelMission(item)">Cancel</p> -->
                                    </li>

                                    <li class="MissionItem grayScale"
                                        v-for="(item) in request.filter(element => element.requested != identifier && element.requested != 'none')"
                                        :key="item.name"
                                    >
                                        
                                        <div class="MissionItemNameBox">
                                            <div class="MissionItemImageBox">
                                                <img :src="`img/${item.name}.png`" alt="" class="MissionItemImage">
                                            </div>

                                            <p class="MissionItemName">{{item.label}}</p>
                                        </div>
                                    
                                        <p class="MissionItemWeight" v-if="weightSystem">{{item.weight}}kg</p>

                                        <div class="MissionItemAmountBox">
                                            <label for="">x</label>
                                            <label class="MissionItemAmount" for="">{{item.amount}}</label>
                                        </div>

                                        <p class="MissionItemPrice">{{translate.TR_MONEY_SIMBOL}}{{Number(item.amount * item.mission_money).toFixed(2)}}</p>

                                        <p class="MissionItemButton" :style="StyleBody">{{translate.TR_ACCEPT_MISSION}}</p>
                                        <!-- <p class="MissionItemButton" :style="StyleBody">Cancel</p> -->
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
            request: [
                {name : "bread", label : "Bread", amount : 51000000, weight : 1.0, price : 152, recommended_price : 100, max_price : 1000, request_price : 50, mission_money : 25, max_request : 500, requested: 'none'},
                {name : "drink", label : "Drink", amount : 50, weight : 10.0, price : 100, recommended_price : 100, max_price : 1000, request_price : 50, mission_money : 25, max_request : 500, requested: 'mine'},
                {name : "drink", label : "Drink", amount : 50, weight : 10.0, price : 100, recommended_price : 100, max_price : 1000, request_price : 50, mission_money : 25, max_request : 500, requested: 'other'},
            ],

            identifier: "mine",

            loading: false,
        })
    },

    methods: {
        AcceptMission: function(item){
            const NameResource = this.NameResource[0];

            axios.post(`https://${NameResource}/acceptMission`, {
                item: item
            }).then( () => {
                this.loading = true;
            })
            .catch(msg => console.log(msg));
        },

        CancelMission: function(item){
            if(!this.closed){
                const NameResource = this.NameResource[0];

                axios.post(`https://${NameResource}/cancelMission`, {
                    item: item
                }).then( () => {
                    this.loading = true;
                })
                .catch(msg => console.log(msg));
            }
        },

        enablePopUp: function(value){
            this.popUp = value;
        },

        LoadMissions: function(){
            const NameResource = this.NameResource[0];

            axios.post(`https://${NameResource}/loadMissions`, {
                
            }).then( () => {
                this.loading = true;
            })
            .catch(msg => console.log(msg));
        },

        receiveLua: function(event){
            if(!event || !event.data)
                return;
            
            const lua = event.data;
            
            if(lua.loadMissions){
                this.request = lua.request;
                this.identifier = lua.identifier;
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

        this.LoadMissions();
    },
    destroyed: function(){
        window.removeEventListener('message', this.receiveLua);
        window.removeEventListener('keydown', this.keyPress);
    }
}
</script>

<style>
    .MissionItensBox{
        background-color: white;
        flex: 1;
        margin-left: 5vh;
        padding: 3vh 0;
        border-radius: 5px;
        box-shadow: 0px 0px 3px 1px rgba(173, 173, 173, 0.315);
    }

    .MissionItensTitle{
        color: gray;
        font-weight: bold;
        font-size: 2vh;
        padding: 0 3vh;
    }

    .MissionItensList{
        display: flex;
        flex-direction: column;
        margin-top: 2vh;
        height: 30vh;

        overflow-y: scroll;
    }

    .MissionItensList::-webkit-scrollbar-track {
        background-color: #ffffff;
    }
    .MissionItensList::-webkit-scrollbar {
        width: 0.0vh;
        background: rgba(20, 51, 136, 0.8);
    }
    .MissionItensList::-webkit-scrollbar-thumb {
        background: rgba(5, 6, 65, 0.8);
        border-radius: 20px;
    }

    .MissionItem{
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

    .MissionItem:hover .MissionItemWeight , .MissionItem:hover .MissionItemAmountBox , .MissionItem:hover .MissionItemPrice{
        /* display: none; */
    }

    .MissionItem:hover .MissionItemButton{
        display: block;
    }

    .MissionItem:first-child{
        border-top: 1px solid rgb(212, 212, 212);
    }

    .MissionItemNameBox{
        display: flex;
        flex-direction: row;

        align-items: center;
    }

    .MissionItemImageBox{
        background-color: #E9E9E9;
        display: flex;
        align-items: center;
        justify-content: center;

        width: 10vh;
        height: 6vh;
    }

    .MissionItemImage{
        max-width: 40%;
        max-height: 100%;
    }

    .MissionItemName{
        margin-left: 1vh;
        overflow: hidden;
        /* background-color: tomato; */
        flex: 1;

        text-overflow: ellipsis;
    }

    .MissionItemAmount{
        width: 8vh;
        border: none;
        outline: none;

        color: gray;
        font-weight: bold;
        font-size: 2.2vh;
    }

    .MissionItemPrice{
        width: 25%;
        /* background-color: violet; */
    }

    .MissionItemNameBox{
        width: 20%;
        /* background-color: tomato; */
    }

    .MissionItemPrice{
        text-align: center;
    }

    .MissionItemWeight, .MissionItemAmountBox{
        width: 15%;
        /* background-color: wheat; */
        text-align: center;
    }

    .MissionItemPrice, .MissionItemNameBox, .MissionItemRemove, .MissionItemPrice, .MissionItemWeight, .MissionItemAmountBox{
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
    }

    .MissionItemButton{
        /* display: none; */
        color: white;
        padding: 1vh 2vh;
        border-radius: 20px;
        font-size: 2vh;

        width: 18vh;
        text-align: center;
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
    }

    .MissionItemButton:hover{
        opacity: 0.9;
    }

    .MissionItensInfoBox{
        width: 100%;
        display: flex;
        flex-direction: row;
        align-items: center;
    }

    .PopUpTitleMission{
        margin: 0;
        margin-bottom: 3vh;
    }

    .MissionItemPopAmount{
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