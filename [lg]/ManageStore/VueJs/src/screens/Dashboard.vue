<template>
    <div>            
        <div id="StoreBodyBox" :style="StyleHeader">
            <p class="close" @click="close">X</p>

            <div id="StoreTitleBox">
                <p id="StoreTitle">{{store_title}}</p>
            </div>

            <div id="StoreBox">
                <div id="StoreWindowBox">
                    {{translate.TR_STORE}}
                </div>

                <div id="StoreContentBox">
                    <div>
                        <div id="CartTitleBox">
                            <p id="CartTitle">{{translate.TR_MANAGE_STORE}}</p>
                        </div>

                        <div id="DashboardListItensBox">
                            <ul id="DashboardListItens">
                                <li class="DashboardItem">                                    
                                    <div class="DashboardItemImageBox">
                                        <img :src="`img/packages.png`" alt="" class="DashboardItemImage">
                                    </div>

                                    <p class="DashboardItemPrice">{{translate.TR_STOCK}}</p>
                                    <div class="ClickBox" @click="OpenScreen('Stock')"></div>
                                </li>

                                <li class="DashboardItem">                                    
                                    <div class="DashboardItemImageBox">
                                        <img :src="`img/salary.png`" alt="" class="DashboardItemImage">
                                    </div>

                                    <p class="DashboardItemPrice">{{translate.TR_BALANCE}}</p>
                                    <div class="ClickBox" @click="OpenScreen('Balance')"></div>
                                </li>

                                <li class="DashboardItem">                                    
                                    <div class="DashboardItemImageBox">
                                        <img :src="`img/banner.png`" alt="" class="DashboardItemImage">
                                    </div>

                                    <p class="DashboardItemPrice">{{translate.TR_SELL_STORE}}</p>
                                    <div class="ClickBox" @click="OpenScreen('Sell')"></div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>

export default {
    props: {
        store_title: {},
        StyleHeader: {},
        StyleBody: {},
        translate: {},
        NameResource: {},
        close: {},
        OpenScreen: {}
    },

    data: function(){
        return({
            
        })
    },

    methods: {
        keyPress: function(event){
            const key = event.key;
            
            if(key == "Escape"){
                this.close();
            }
        },
    },

    created: function(){
        // window.addEventListener('message', this.receiveLua);  
        window.addEventListener('keydown', this.keyPress);
    },
    destroyed: function(){
        // window.removeEventListener('message', this.receiveLua);
        window.removeEventListener('keydown', this.keyPress);
    }
}
</script>

<style>
    #DashboardListItensBox{
        overflow-y: scroll;
        max-height: 48vh;
        margin-top: 1vh;
    }

    #DashboardListItensBox::-webkit-scrollbar-track {
        background-color: #ffffff;
    }
    #DashboardListItensBox::-webkit-scrollbar {
        width: 0.0vh;
        background: rgba(20, 51, 136, 0.8);
    }
    #DashboardListItensBox::-webkit-scrollbar-thumb {
        background: rgba(5, 6, 65, 0.8);
        border-radius: 20px;
    }

    #DashboardListItens{
        display: flex;
        flex-direction: row;
        flex-wrap: wrap;
        margin: 0 5vh;
        margin-bottom: 2vh;
    }

    .DashboardItem{
        background-color: white;
        box-shadow: 1px 1px 3px 1px #a2a2a280;
        margin-right: 4vh;
        margin-top: 4vh;

        width: 20vh;
        height: 20vh;

        position: relative;
        padding: 0.5vh;
    }

    .DashboardItemImageBox{
        background-color: #E9E9E9;
        width: 100%;
        height: 75%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .DashboardItemImage{
        max-width: 50%;
        max-height: 100%;
    }

    .DashboardItemPrice{
        color: #323C67;
        font-weight: 500;
        text-align: center;
        margin-top: 1vh;
        font-size: 2.2vh;
    }
</style>