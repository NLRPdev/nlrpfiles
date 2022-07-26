key_open = 'E'
radius_coord = 2.0

-- Disable this variable if you use system limits on your server
use_weight_system = true

-- If true, players can only have one store
player_can_only_own_one_store = false

-- If false, owners will not be able to carry out quests in their own stores.
own_missions = true

-- Set up your stores here
-- Only coordinates with vector3 are accepted, put the x,y,z values inside it.
stores = {
    -- NAME OF THE STORE (HEADER)
    --[[["SUPERMARKET"] = {
        coordinates = {
            -- vector3(x, y, z)
            -- buy_items -> coordinate to buy items in the store
            -- buy_store -> coordinate to buy and Manage the Store
            -- mission -> coordinate to finish the missions
            {
                buy_items = vector3( 26.48082, -1347.098, 29.49702),
                buy_store = vector3(29.14463, -1340.202, 29.49702),
                mission = vector3(14.9722, -1338.554, 29.28262),
            },

            {
                buy_items = vector3( 374.186, 326.0856, 103.5664),
                buy_store = vector3(379.0671, 332.3189, 103.5664),
                mission = vector3(365.0981, 329.173, 103.6142),
            },

            {
                buy_items = vector3( 2557.324, 382.5602, 108.623),
                buy_store = vector3(2550.077, 385.5496, 108.6229),
                mission = vector3(2565.244, 379.1921, 108.4635),
            },

            {
                buy_items = vector3( -3038.939, 585.954, 7.908),
                buy_store = vector3( -3047.207, 586.0744, 7.908),
                mission = vector3( -3040.82, 600.8441, 7.560),
            },

            {
                buy_items = vector3( -3241.927, 1001.462, 12.830),
                buy_store = vector3( -3249.135, 1004.608, 12.830),
                mission = vector3( -3240.988, 992.2358, 12.442),
            },

            {
                buy_items = vector3( 547.2924, 2671.106, 42.15649),
                buy_store = vector3( 546.1507, 2663.525, 42.15649),
                mission = vector3( 544.3167, 2678.489, 42.22464),
            },

            {
                buy_items = vector3( 1961.464, 3740.672, 32.343),
                buy_store = vector3( 1960.323, 3748.646, 32.343),
                mission = vector3( 1967.048, 3735.063, 32.245),
            },

            {
                buy_items = vector3( 2679.086, 3280.735, 55.24113),
                buy_store = vector3( 2673.448, 3285.962, 55.24113),
                mission = vector3( 2686.254, 3279.725, 55.24056),
            },

            {
                buy_items = vector3( 1729.216, 6414.131, 35.037),
                buy_store = vector3( 1734.873, 6419.742, 35.037),
                mission = vector3( 1728.552, 6406.576, 34.381),
            },

            {
                buy_items = vector3( 1135.808, -982.281, 46.415),
                buy_store = vector3( 1130.302, -980.9026, 46.4158),
                mission = vector3( 1148.273, -981.3638, 46.00637),
            },

            {
                buy_items = vector3( -1222.915, -906.983, 12.326),
                buy_store = vector3( -1221.554, -912.2946, 12.326),
                mission = vector3( -1229.601, -896.2725, 12.130),
            },

            {
                buy_items = vector3( -1487.553, -379.107, 40.163),
                buy_store = vector3( -1482.8, -376.674, 40.163),
                mission = vector3( -1500.284, -393.836, 39.542),
            },

            {
                buy_items = vector3( -2968.243, 390.910, 15.043),
                buy_store = vector3( -2963.214, 389.0282, 15.043),
                mission = vector3( -2981.163, 391.9141, 14.8714),
            },

            {
                buy_items = vector3( 1166.024, 2708.930, 38.157),
                buy_store = vector3( 1167.841, 2714.201, 38.157),
                mission = vector3( 1167.323, 2695.775, 37.796),
            },

            {
                buy_items = vector3( 1392.562, 3604.684, 34.980),
                buy_store = vector3( 1396.154, 3611.901, 34.980),
                mission = vector3( 1397.637, 3591.436, 34.844),
            },

            {
                buy_items = vector3( -1391.477, -604.8229, 30.31955),
                buy_store = vector3( -1385.243, -606.2846, 30.31955),
                mission = vector3( -1398.125, -585.4959, 30.15292),
            },

            {
                buy_items = vector3( -1037.618, -2737.399, 20.169),
                buy_store = vector3( -1052.603, -2740.602, 20.965),
                mission = vector3( -1036.331, -2728.68, 20.077),
            },

            {
                buy_items = vector3( -48.519, -1757.514, 29.421),
                buy_store = vector3( -44.14389, -1749.341, 29.421),
                mission = vector3( -54.428, -1761.896, 28.962),
            },

            {
                buy_items = vector3( 1163.373, -323.801, 69.205),
                buy_store = vector3( 1159.75, -315.043, 69.205),
                mission = vector3( 1161.679, -332.0736, 68.864),
            },

            {
                buy_items = vector3( -707.501, -914.260, 19.215),
                buy_store = vector3( -709.220, -905.133, 19.215),
                mission = vector3( -711.122, -920.305, 19.013),
            },

            {
                buy_items = vector3( -1820.523, 792.518, 138.118),
                buy_store = vector3( -1828.394, 798.065, 138.185),
                mission = vector3( -1819.883, 786.245, 137.985),
            },

            {
                buy_items = vector3( 1698.388, 4924.404, 42.063),
                buy_store = vector3( 1706.776, 4920.808, 42.063),
                mission = vector3( 1695.07, 4933.871, 42.078),
            },

        },

        -- Items that will be sold in this store
        items = {
            -- name             -> The name of the item in the Items table (if you use ESX) or nameId (if you use VRP)
            -- label            -> The label of the item in the Items table (if you use ESX) or item name (if you use VRP)
            -- amount           -> Quantity of initial item that stores will have at the beginning
            -- weight           -> The item's weight. If you use limit system, just ignore it.
            -- price            -> Starting price of the item
            -- recommended_price-> recommended selling price of the item
            -- max_price        -> The maximum price the owner can put for the item
            -- request_price    -> The price that will be charged to the store owner for ordering new items
            -- mission_money    -> The value the player will earn for performing the quest for that item
            -- max_request      -> The maximum items the owner can request for a single quest
            {name = "bread", label = "Bread", amount = 500, weight = 1.0, price = 152, recommended_price = 100, max_price = 1000, request_price = 50, mission_money = 25, max_request = 500},
            {name = "drink", label = "Drink", amount = 500, weight = 1.0, price = 100, recommended_price = 100, max_price = 1000, request_price = 50, mission_money = 25, max_request = 500},
            {name = "cake", label = "Cake", amount = 500, weight = 1.0, price = 152, recommended_price = 100, max_price = 1000, request_price = 50, mission_money = 25, max_request = 500},
            {name = "coffe", label = "Coffe", amount = 500, weight = 1.0, price = 100, recommended_price = 100, max_price = 1000, request_price = 50, mission_money = 25, max_request = 500},
            {name = "cola", label = "Coca Cola", amount = 500, weight = 1.0, price = 152, recommended_price = 100, max_price = 1000, request_price = 50, mission_money = 25, max_request = 500},
            {name = "hamburger", label = "Hamburger", amount = 500, weight = 1.0, price = 100, recommended_price = 100, max_price = 1000, request_price = 50, mission_money = 25, max_request = 500},
            {name = "pudding", label = "Pudding", amount = 500, weight = 1.0, price = 152, recommended_price = 100, max_price = 1000, request_price = 50, mission_money = 25, max_request = 500},
            {name = "sandwich", label = "Sandwich", amount = 500, weight = 1.0, price = 100, recommended_price = 100, max_price = 1000, request_price = 50, mission_money = 25, max_request = 500},
            {name = "vodka", label = "Vodka", amount = 500, weight = 1.0, price = 152, recommended_price = 100, max_price = 1000, request_price = 50, mission_money = 25, max_request = 500},
        },

        marker = 29,        -- type of marker
        use_blip = true,    -- enable blip in map
        blip = 59,          -- type of blip map
        blip_color = 2,     -- color blip map
        blip_name = "SuperMarket",  -- name blip map

        color_header = "#03AE74",   -- color of store header
        color_buttons = "#03b67a",  -- color of store buttons

        price_store = 5000,         -- price of the store
        percentage_sell = 30,       -- Percentage that will be charged when selling the store
    },--]]

    -- this is a second example
    ["Reckless Customs"] = {
         coordinates = {
				{
              	buy_items = vector3(814.26, -782.22, 26.17),
              	buy_store = vector3(816.93, -774.96, 26.17),
              	mission = vector3(812.39, -774.42, 26.50),
				},    -- 
         },

         items = {
              {name = "harness", label = "Racing Harness", amount = 0, weight = 1.0, price = 1000, recommended_price = 25000, max_price = 25000, request_price = 50, mission_money = 500, max_request = 500},
              {name = "ducttape", label = "Duct Tape", amount = 0, weight = 0.0, price = 10, recommended_price = 1000, max_price = 1000, request_price = 50, mission_money = 50, max_request = 500},
              --{name = "laptop", label = "Laptop", amount = 500, weight = 1.0, price = 152, recommended_price = 100, max_price = 1000, request_price = 50, mission_money = 25, max_request = 500},
              --{name = "pendrive", label = "Pen Drive", amount = 500, weight = 1.0, price = 100, recommended_price = 100, max_price = 1000, request_price = 50, mission_money = 25, max_request = 500},  --]]      
         },
          marker = 29,        -- type of marker
          use_blip = false,    -- enable blip in map
          blip = 2,          -- type of blip map
          blip_color = 2,     -- color blip map
          blip_name = "Store 2",  -- name blip map
--      
          color_header = "rgb(75, 0, 0)",   -- color of store header
          color_buttons = "rgb(46, 46, 46)",  -- color of store buttons
--      
          price_store = 0,            -- price of the store
          percentage_sell = 30,       -- Percentage that will be charged when selling the store
    },
    ["blackmarket"] = {
        coordinates = {
            {
                buy_items = vector3(892.24, -2171.89, 32.29),
                buy_store = vector3(892.24, -2171.89, 20.29),
                mission = vector3(892.24, -2171.89, 20.29),
            },    -- 
        },

        items = {
            {name = "boostinglaptop", label = "Boosting tablet", amount = 25, weight = 1.0, price = 10000, recommended_price = 25000, max_price = 25000, request_price = 50, mission_money = 500, max_request = 500},
            {name = "boostingdisabler", label = "GPS Scrambler", amount = 25, weight = 0.0, price = 2500, recommended_price = 1000, max_price = 1000, request_price = 50, mission_money = 50, max_request = 500},
            {name = "advancedlockpick", label = "Advanced Lockpick", amount = 25, weight = 1.0, price = 500, recommended_price = 100, max_price = 1000, request_price = 50, mission_money = 25, max_request = 500},
            {name = "tunerlaptop", label = "Tunerchip", amount = 10, weight = 1.0, price = 25000, recommended_price = 100, max_price = 1000, request_price = 50, mission_money = 25, max_request = 500},  
            {name = "burnerphone", label = "burnerphone", amount = 50, weight = 1.0, price = 1000, recommended_price = 100, max_price = 1000, request_price = 50, mission_money = 25, max_request = 500},      
        },
        marker = 29,        -- type of marker
        use_blip = false,    -- enable blip in map
        blip = 2,          -- type of blip map
        blip_color = 2,     -- color blip map
        blip_name = "Store 2",  -- name blip map
--      
        color_header = "rgb(75, 0, 0)",   -- color of store header
        color_buttons = "rgb(46, 46, 46)",  -- color of store buttons
--      
        price_store = 0,            -- price of the store
        percentage_sell = 30,       -- Percentage that will be charged when selling the store
    }
}

-- Here, you define the coordinates of the missions.
-- You can define coordinates for each item or if you want, leave them as random.
-- If the item name is not on that list, the quest will be given at a random coordinate.
missions_coords = {
    ['RANDOM_MISSION'] = {
        vector3(492.4845, -893.8429, 25.72052),
        vector3(760.8992, -708.9007, 28.399),
        vector3(-1271.777, -1214.021, 4.7875),
        vector3(-1053.958, -2013.681, 13.16245),
        vector3(-672.7007, -2386.075, 13.83678),
        vector3(-936.1968, -2544.441, 14.04701),
        vector3(438.2368, -1478.14, 29.30269),
    },

    -- example coord item
    -- ['bread'] = {
    --     vector3(438.2368, -1478.14, 29.30269),
    -- }
}

-- Here you can translate all messages and graphical interface.
-- Remember to save your settings whenever you update the Script.
translate = {
    TR_TITLEWINDOW = "Items for sale",
    TR_TITLEWINDOW2 = "My Cart",
    TR_SEARCH = "Search",
    TR_MY_CART = "MY CART",
    TR_ADD_TO_CART = "ADD TO CART",
    TR_WEIGHT_SYMBOL = "kg",
    TR_PAYMENT = "PAYMENT",
    TR_STORE_CART = "CART",
    TR_PAYMENT_OPTIONS = "PAYMENT OPTIONS",
    TR_BANK_ACCOUNT = "Bank Account",
    TR_WALLET_MONEY = "Wallet Money",
    TR_BUY_NOW = "Buy now",
    TR_CONTINUE_SHOPPING = "Continue shopping",
    TR_TOTAL = "Total:",
    TR_MONEY_SIMBOL = "$",
    TR_CONFIRM_TITLE = "Are you sure about this?",
    TR_CONFIR_MESSAGE = "The total amount is",
    TR_CONFIR_MESSAGE2 = "and you have chosen to pay with",
    TR_CONFIR_MESSAGE3 = "Do you want to continue?",
    TR_YES = "Yes",
    TR_NO = "No",
    TR_PAYMENT_COMPLETE = "Payment Complete!",
    TR_PAYMENT_NEGADE = "Payment denied!",
    TR_REMOVE = "remove",
    TR_REASON = "Reason:",
    TR_NOT_MONEY = "You dont have money.",
    TR_NOT_WEIGHT = "Your inventory is too full.",

    TR_CANCEL = "Cancel",
    TR_STORE = "Store",
    TR_MANAGE_STORE = "MANAGE YOUR STORE",
    TR_STOCK = "STOCK",
    TR_BALANCE = "BALANCE",
    TR_SELL_STORE = "SELL STORE",
    TR_STORE_STOCK = "STORE STOCK",
    TR_STORE_PRODUCTS = "STORE PRODUCTS IN STOCK",
    TR_STORE_PRODUCTS2 = "STORE PRODUCTS FOR SALE",
    TR_PUT_FOT_SALE = "Put For Sale",
    TR_MAX = "Max",
    TR_TEXT_FOR_SALE = "Enter the quantity you want to put up for sale",
    TR_REQUEST_ITEM = "Request Item",
    TR_TEXT_REQUEST_ITEM = "Enter the quantity you want to request",
    TR_CURRENT = "Current",
    TR_REMOVE_ITEM = "Remove Item",
    TR_TEXT_REMOVE_ITEM = "Enter the quantity you want to remove",
    TR_CHANGE_PRICE = "Change Price",
    TR_TEXT_CHANGE_PRICE = "Enter the new Price you want",
    TR_STORE_BALANCE = "STORE BALANCE",
    TR_STORE_TITLE_POP = "Add Money to the Store",
    TR_TEXT_ADD_MONEY = "Enter the amount of money you want to add to your store. This money must be in your bank account.",
    TR_MONEY_BANK = "bank account money",
    TR_STORE_TITLE_POP2 = "Withdraw Money to the your Bank Account",
    TR_TEXT_WITHDRAW = "Enter the amount of money you want to remove to your store.",
    TR_MONEY_BALANCE = "balance money",
    TR_ADD_MONEY = "Add Money",
    TR_WITHDRAW = "Withdraw",
    TR_SELL = "SELL",
    TR_SELL_TEXT = "Currently the price of your store is",
    TR_SELL_TEXT2 = "When selling, you will lose all rights to the items that exist in it. Do you really want to sell your store?",
    TR_CONFIRM_SELL = "Confirm Sell",
    TR_CONFIR_SELL_MESSAGE = "Do you really want to sell your store? The money will be sent to your bank account and the value of your store is currently:",
    TR_BUY = "BUY",
    TR_BUY_TEXT = "Currently the price of the store is",
    TR_BUY_TEXT2 = "When purchasing, you will be able to manage this store and request new items. Do you really want to buy this store?",
    TR_CONFIRM_BUY = "Confirm Buy",
    TR_CONFIR_BUY_MESSAGE = "Do you really want to buy this store? The money will be charged from your bank account and the value of this store is currently:",
    TR_SOLD_OUT = "SOLD OUT",

    TR_MISSIONS = "MISSIONS",
    TR_STORE_MISSIONS = "STORE MISSIONS",
    TR_STORE_MISSIONS2 = "STORE PRODUCTS MISSIONS",

    TR_HAS_OWNER = "This store already has an owner.",
    TR_PURCHASE_STORE = "You purchased this store.",
    TR_DONT_HAVE_MONEY = "You don't have money to buy this Store.",
    TR_DONT_HAVE_MONEY2 = "You do not have money.",
    TR_NOT_OWNER = "You do not own this store.",
    TR_SOLD_STORE = "You sold the store.",
    TR_DONT_BALANCE = "The balance don't have this amount",
    TR_WITHDRAWED = "You withdraw money from the balance.",
    TR_STOCK_DONT_AMOUNT = "Store Stock dont have this amount.",
    TR_WAS_OFFERED = "The product was offered for sale.",
    TR_PRODUCTS_DONT_AMOUNT = "Store Products dont have this amount.",
    TR_PUT_BACK = "The product has been put back in stock",
    TR_PRICE_HIGHER = "Price higher than allowed for this item.",
    TR_PRICE_CHANGED = "Item price has changed.",
    TR_DONT_BALANCE2 = "Your store does not have enough money to order this product.",
    TR_PRODUCT_REQUEST = "You have placed a product request.",
    TR_DONT_EXIST = "This quest has already been chosen by another player or it no longer exists.",
    TR_RECEIVE_MISSION = "You have received the mission. Go to the point marked on the map to receive the products.",
    TR_ALREADY_MISSION = "You are already doing a mission.",
    TR_CANCEL_MISSION = "You canceled the mission.",
    TR_COMPLETE_MISSION = "You completed the mission and received: ",
    TR_DONT_AMOUNT = "The store does not have the quantity specified for the item: ",
    TR_WAIT_PRODUCTS = "Wait, the products are being loaded into your vehicle.",
    TR_GO_STORE = "Ready! Deliver the products with your vehicle at the store.",

    TR_OPERATION_SUCCESFUL = "Operation Successful.",
    TR_OPERATION_NEGADE = "Operation Denied.",

    TR_REQUEST = "Request",
    TR_ACCEPT_MISSION = "Accept Mission",
    TR_CANCEL_MISSION = "Cancel Mission",

    TR_PRESS_BUTTON = "To open the store, press: ",
    TR_NOT_OWN_MISSION = "You cannot pick up quests from your own store.",

    TR_JUST_ONE_STORE = "You can only own one store",
    TR_PRICE_REQUEST = "Price of this request",

    TR_MISSIONS2 = "Missions",
}