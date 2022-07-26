----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

Config = {}
-- Core settings edit these to match your core data if you have not edited your core use the default options in notes
Config.CoreSettings = {
    Core = 'QBCore', -- The name of your core. Default; QBCore
    CoreFolder = 'qb-core', -- The name of your core folder. Default; qb-core
    TargetName = 'qb-target', -- The name of your third eye targeting. Default; qb-target
    MenuName = 'qb-menu', -- The name of your menu. Default; qb-menu
    ItemCheckEvent = 'QBCore:HasItem', -- The name of your item check event. Default; 'QBCore:HasItem'
    RemoveItemEvent = 'QBCore:Server:RemoveItem', -- The name of your item check event. Default; 'QBCore:Server:AddItem'
    AddItemEvent = 'QBCore:Server:AddItem', -- The name of your item check event. Default; 'QBCore:Server:AddItem'
    MetaDataEvent = 'QBCore:Server:SetMetaData', -- The name of your set metadata event. Default; 'QBCore:Server:SetMetaData'
    AddStressEvent = 'hud:server:GainStress', -- Event to remove stress from player. Default; 'hud:server:GainStress'
}
-- Selling settings
Config.DrugSales = {
    DrugPhone = 'burnerphone', -- Item used to open your drug selling menu
    StreetSelling = {
        UseTimes = false, -- Toggle time locks for corner selling; true = enables corner selling; false = disabled
        StartTime = 10, -- Time you can start corner selling drugs
        EndTime = 20, -- Time to stop corner selling drugs
        UseCashItem = false, -- Toggle cash as item; true = CashItem reward, false = MoneyType reward
        MoneyType = 'cash', -- Money type rewarded for bulk selling; 'cash', 'bank', 'crypto' etc...
        CashItem = 'markedbills', -- Name of your cash item in your city
        RequiredCops = 0, -- Number of active cops required to sell drugs
        SaleChance = 50, -- Chance in % for successful sale
        StealChance = 25, -- Chance in % for peds to steal
        AlertChance = 10, -- Chance in % for peds to alertcops
        Drugs = { -- Your street selling drugs list add your servers drugs here; drugs sell from top down; if you have bags of weed and bags of coke you will sell the weed first!
            {name = 'weed_skunk', 			label = '2g Bag of Skunk',          minprice = 40,      maxprice = 60},
            {name = 'weed_og-kush', 		label = '2g Bag of OG Kush',        minprice = 40,      maxprice = 60},
            {name = 'weed_white-widow', 	label = '2g Bag of White Widow',    minprice = 40,      maxprice = 60},
            {name = 'weed_ak47', 			label = '2g Bag of AK47',           minprice = 40,      maxprice = 60},
            {name = 'weed_amnesia', 		label = '2g Bag of Amnesia',        minprice = 40,      maxprice = 60},
            {name = 'weed_purple-haze', 	label = '2g Bag of Purple Haze',    minprice = 40,      maxprice = 60},
            {name = 'morphine', 		    label = 'Vial of Morphine',         minprice = 400, 	maxprice = 600},
            {name = 'heroinbaggy', 			label = '1g Bag of Heroin',         minprice = 400,     maxprice = 600},
            {name = 'liquidheroin', 		label = 'Vial of Heroin',           minprice = 400, 	maxprice = 600},
            {name = 'crack_baggy', 		    label = '1g Bag of Crack',          minprice = 400, 	maxprice = 600},
            {name = 'meth', 				label = '1g Bag of Meth',           minprice = 400, 	maxprice = 600},
            {name = 'cokebaggy', 			label = '1g Bag of Cocaine',        minprice = 400,     maxprice = 600},
        },
        Jobs = {
            Blacklist = { -- Jobs blacklist; add any jobs here you do not want to be able to toggle selling drugs
                --{name = 'police'},
                {name = 'ambulance', 'police'},
            },
        },
        Peds = {
            Blacklist = { -- Ped blacklist; add any peds here you do not want to be able to sell drugs too
                'cs_martinmadrazo',
                'csb_vincent',
                'mp_m_shopkeep_01',
                's_m_y_ammucity_01',
                'a_m_y_stwhi_01',
            }
        } 
    },
    Deliveries = {
        UseTimes = false, -- Toggle time locks for corner selling; true = enables corner selling; false = disabled
        StartTime = 10, -- Time you can request a delivery from
        EndTime = 20, -- Time to cant request a delivery from
        RequiredCops = 0, -- Number of active cops required to sell drugs
        UseCashItem = false, -- Toggle cash as item; true = CashItem reward, false = MoneyType reward
        MoneyType = 'cash', -- Money type rewarded for bulk selling; 'cash', 'bank', 'crypto' etc...
        CashItem = 'dirtycash', -- Name of your cash item in your city
        NewDeliveryTimer = 10, -- Time in (mins) to receive delivery
        CooldownTime = 10, -- Time in (mins) to be able to request another delivery
        DeliveryPed = {{'a_m_y_stwhi_01', 'WORLD_HUMAN_SMOKING'}}, -- Your delivery ped; model, scenario
        Drugs = { -- Your delivery drugs these are 28*bag prices -25%; adjust these however you like; drugs sell from top down; if you have ounces of heroin and coke you will sell the heroin first!
            {name = 'heroin_1oz', 	label = 'Ounce of Heroin',      minprice = 1241,    maxprice = 1995},
            {name = 'crack_1oz', 	label = 'Ounce of Crack',       minprice = 1680,    maxprice = 2415},
            {name = 'meth_1oz', 	label = 'Ounce of Meth',        minprice = 2016, 	maxprice = 2520},
            {name = 'coke_1oz',     label = 'Ounce of Cocaine',     minprice = 2100, 	maxprice = 2835},
        },
        Locations = { -- Delivery location you can add as many as you like here; lower your Z by 1.00 to stop peds floating! 
            [1] =  { ['x'] = -790.72,   ['y'] = -964.07,    ['z'] = 14.16,  ['h'] = 330.71},
	        [2] =  { ['x'] = 1143.71,   ['y'] = -299.11,    ['z'] = 67.80,  ['h'] = 96.11},
	        [3] =  { ['x'] = 1104.49,   ['y'] = 87.08,      ['z'] = 79.89,  ['h'] = 324.07},
	        [4] =  { ['x'] = 1136.46,   ['y'] = -1247.57,   ['z'] = 20.19,  ['h'] = 124.63},
	        [5] =  { ['x'] = 979.76,    ['y'] = -1659.31,   ['z'] = 28.27,  ['h'] = 353.66},
	        [6] =  { ['x'] = 654.00,    ['y'] = -3017.50,   ['z'] = 5.15,   ['h'] = 359.33},
	        [7] =  { ['x'] = -991.04,   ['y'] = -2634.62,   ['z'] = 12.98,  ['h'] = 61.12},
	        [8] =  { ['x'] = -3268.97,  ['y'] = 954.53,     ['z'] = 7.35,   ['h'] = 268.82},
	        [9] =  { ['x'] = 1621.19,   ['y'] = 3564.39,    ['z'] = 34.29,  ['h'] = 302.04},
	        [10] =  { ['x'] = -358.91,  ['y'] = 6062.09,    ['z'] = 30.50,  ['h'] = 42.95},
        }
    },
    BulkSelling = {
        UseTimes = false, -- Toggle time locks for corner selling; true = enables corner selling; false = disabled
        StartTime = 10, -- Time you can start corner selling drugs
        EndTime = 20, -- Time to stop corner selling drugs
        UseCashItem = false, -- Toggle cash as item; true = CashItem reward, false = MoneyType reward
        MoneyType = 'cash', -- Money type rewarded for bulk selling; 'cash', 'bank', 'crypto' etc...
        CashItem = 'dirtycash', -- Name of your cash item in your city
        Drugs = { -- Bulkselling drugs list
            Bags = { -- Bags are 50% of the street sale minimum prices *(adjust these however you like)*
                ['weed_skunk'] = 5,
                ['weed_og-kush'] = 8,
                ['weed_white-widow'] = 10,
                ['weed_ak47'] = 13,
                ['weed_amnesia'] = 15,
                ['weed_purple-haze'] = 18,
                ['heroinbaggy'] = 25,
                ['morphine'] = 30,
                ['liquidheroin'] = 35,
                ['crack_baggy'] = 40,
                ['meth'] = 45,
                ['cokebaggy'] = 50,
            },
            Ounces = { -- Ounces are 28*bag price -25% *(adjust these however you like)*
                ['heroin_1oz'] = 630,
                ['crack_1oz'] = 840,
                ['meth_1oz'] = 945,
                ['coke_1oz'] = 1050,
            } 
        },
        Peds = {
            Buyer = {
                -- X, Y, Z, NAME, H, HASH, MODEL, SCENARIO ANIMATION
                {-1757.21, 427.49, 126.70, 'Bulkbuyer', 243.89, 0x43595670, 'cs_martinmadrazo', 'WORLD_HUMAN_SMOKING'},
            },
            Bodyguard = {
                -- X, Y, Z, NAME, H, HASH, MODEL, WEAPON TYPE
                {-1759.69, 427.25, 126.35, 'Bodyguard1', 76.44, 0x1F0846A7, 'csb_vincent', 'WEAPON_ASSAULTRIFLE'},
            }
        },
        BlackMarket = {
            BlackMarketItems = { -- Black market items stocked by processing peds
                [1] = { name = 'lockpick',      price = 300,   amount = 100, info = {}, type = 'item', slot = 1 },
                [2] = { name = 'burnerphone',   price = 200,   amount = 100, info = {}, type = 'item', slot = 2 },
            }
        }
    }
}
-- Language
Config.Lang = {
    Targeting = {
        ['offerdrugsicon'] = 'fa-solid fa-comment', -- Icon used by qb-target for offering drugs to ped visit; https://fontawesome.com to change
        ['offerdrugslabel'] = 'Offer Drugs', -- Label used by qb-target for offering drugs
        ['bulkdealericon'] = 'fab fa-drupal', -- Icon used by qb-target for bulk dealer to ped visit; https://fontawesome.com to change
        ['bulkdealerlabel'] = 'Speak To Madrazo', -- Label used by qb-target for bulk dealer
    },
    Alerts = {
        Selling = {
            ['policenotif'] = '10-66: Suspicious Person in Area!', -- Notification
            ['bliptext'] = '10-66: Suspicious Person in Area!', -- Blip text 
        },
    },
    DrugSales = {
        StreetSelling = {
            ['startedselling'] = 'You started selling drugs! Go speak to some locals!', -- Notification
            ['stoppedselling'] = 'You stopped selling drugs.', -- Notification
            ['enoughcops'] = 'Not enough on duty officers! Required: ('..Config.DrugSales.StreetSelling.RequiredCops..')', -- Notification
            ['timer'] = 'You can only sell between '..Config.DrugSales.Deliveries.StartTime..' and '..Config.DrugSales.Deliveries.EndTime..'..', -- Notification
            ['alreadysold'] = 'You have already tried to offer this person drugs..', -- Notification
        },
        Deliveries = {
            ['startedselling'] = 'You requested a delivery! Wait for a customer!', -- Notification
            ['stoppedselling'] = 'You stopped your delivery!', -- Notification
            ['enoughcops'] = 'Not enough on duty officers! Required: ('..Config.DrugSales.Deliveries.RequiredCops..')', -- Notification
            ['timer'] = 'You can only sell between '..Config.DrugSales.Deliveries.StartTime..' and '..Config.DrugSales.Deliveries.EndTime..'..', -- Notification
            ['alreadysold'] = 'You have already tried to deliver to this person..', -- Notification
            ['cooldowntimer'] = 'You can only request a delivery once every ('..Config.DrugSales.Deliveries.CooldownTime..') mins..', -- Notification
            ['customerready'] = 'A customer is waiting for their delivery!', -- Notification
        },
        Menus = {
            ['phoneheader'] = 'Burner Phone', -- Menu header   
            ['phoneheadertext'] = 'Start street selling or make deliveries!', -- Menu header text
            ['phoneheadericon'] = 'fa-solid fa-user-ninja', -- Menu header icon
            ['streetsellingheader'] = 'Start slinging that good good', -- Menu header  
            ['streetsellingheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
            ['deliveriesheader'] = 'Request Delivery', -- Menu header 
            ['deliveriesheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
        },
        BulkSelling = {
            ['bulkbuyerheader'] = 'Bulk Buyer', -- Menu header   
            ['bulkbuyerheadertext'] = 'Bulk sell your drugs here.', -- Menu header text
            ['bulkbuyerheadericon'] = 'fa-solid fa-user-ninja', -- Menu header icon
            ['bulkbuyerbagsheader'] = 'Bulk Sell Bags', -- Menu header   
            ['bulkbuyerbagsheadertext'] = 'Bulk sell your baggies here!', -- Menu header text
            ['bulkbuyerbagsheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
            ['bulkbuyerouncesheader'] = 'Bulk Sell Ounces', -- Menu header   
            ['bulkbuyerouncesheadertext'] = 'Bulk sell your ounces here!', -- Menu header text
            ['bulkbuyerouncesheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
            ['timer'] = 'You can only sell between '..Config.DrugSales.BulkSelling.StartTime..' and '..Config.DrugSales.BulkSelling.EndTime..'..', -- Notification

        },
        BlackMarket = {
            ['blackmarketheader'] = 'Black Market', -- Menu header   
            ['blackmarketheadertext'] = 'Check what items are in stock here.', -- Menu header text
            ['blackmarketheadericon'] = 'fa-solid fa-cash-register', -- Menu header icon
            ['blackmarketstorelabel'] = 'Black Market', -- Store header
        },
    },
    Shared = {
        ['returnmenu'] = 'Return', -- Menu header
        ['returnmenuicon'] = 'fa-solid fa-backward', -- Menu header icon
        ['exitmenu'] = 'Exit', -- Menu header
        ['exitmenuicon'] = 'fa-solid fa-circle-xmark', -- Menu header icon
        ['nodrugs'] = 'You dont have any drugs with you..', -- Notification
        ['blacklistedjob'] = 'You cant sell drugs with your current job..', -- Notification
        ['nobothsaletypes'] = 'You cant street sell and deliver drugs at the same time..', -- Notification
    },
}