----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

Config = {}
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
    RemoveStressEvent = 'hud:server:RelieveStress', -- Event to remove stress from player. Default; 'hud:server:RelieveStress'
}
-- Blips
Config.UseBlips = false -- Enable blips
Config.Blips = {
	{title='Opium Field',           colour=10,  id=51,   x = -2332.28,   y = 2516.33,    z = 3.43}, 
    {title='Hydrochloric Acid',     colour=10,  id=51,   x = 2705.04,    y = 1557.17,    z = 26.04}, -- Shared with BOII-METH
    {title='Petroleum Ether',       colour=10,  id=51,   x = 453.47,     y = -585.43,    z = 28.5},
    {title='Construction Site',     colour=10,  id=51,   x = -453.74,    y = -983.82,    z = 25.9}, -- Shared with BOII-COCAINE
    {title='Pharmacist',            colour=10,  id=51,   x = 95.23,      y = -1607.81,   z = 30.9},
    {title='Morphine Processor',    colour=10,  id=51,   x = 166.04,     y = 295.21,     z = 111.84},
    {title='Heroin Base Processor', colour=10,  id=51,   x = -1125.46,   y = 4895.55,    z = 218.47},
    {title='Heroin Processor',      colour=10,  id=51,   x = 1963.15,    y = 4639.16,    z = 42.1}, 
}
Config.Peds = {
    {91.23, -1603.81, 29.90, 'Pharmacist', 248.07, 0xD47303AC, 's_m_m_doctor_01'}, -- Pharmacy ped and location
	{166.0, 293.21, 109.84, 'Morphine Processor', 20.07, 0x90769A8F, 'u_m_m_willyfist'}, -- Morphine base processing ped and location  
	{-1124.27, 4892.85, 217.47,'Heroin Base Processor',19.07, 0x67000B94, 'ig_terry'}, -- Heroin base processing ped and location
	{1967.15, 4634.16, 40.10, 'Heroin Processor', 39.07, 0x7EF440DB, 'ig_ashley'}, -- Heroin processing ped and location   
}
-- XP settings
Config.XP = {
    UseXP = true, -- Toggles xp system on or off; true = on, false = off
    MetaDataName = 'heoinxp', -- The name of your xp if you edit this make sure to also edit the line included in readme this is also your /drugxp command
    XPReward = math.random(1,5), -- Amount of XP to reward for successful drug actions
    XPRemove = math.random(1,5), -- Amount of XP to reward for unsuccessful drug actions
    XPLevels = { -- Change your xp requirements here to suit your server set these as high as you want
        100, -- Experience required for level 2 -- 1 - 5 increases chance to receive more opium from poppies
        200, -- Experience required for level 3 -- 3 - 6 increases chance to reveive more building materials
        300, -- Experience required for level 4 
        400, -- Experience required for level 5 -- 5 - 8 increases chance to receive more hydrochloric acid
        500, -- Experience required for level 6 -- 6 - 10 increases chance to receive more ether
        600, -- Experience required for level 7  
        700, -- Experience required for level 8 -- 8 - 12 increase amount of morphine from cutting
        800, -- Experience required for level 9 
        900, -- Experience required for level 10 -- 10 - 14 increase amount of heroin from cutting
        1000, -- Experience required for level 11 
        1100, -- Experience required for level 12
        1200, -- Experience required for level 13
        1300, -- Experience required for level 14
        1400, -- Experience required for level 15 -- Max level 
    },  
}
-- General settings
Config.SearchCD = 30 -- Cooldown timer in (mins) used by hydrochloric & ether locations default = 30mins; 1 = 1min, 5 = 5min, 10 = 10min, 12 = 12mins.. etc..
Config.PoliceJob = 'police' -- Name of your police job to receive alerts
-- Opium settings
Config.DrugMaterials = {
    Heroin = {
        Opium = {
            Field = vector3(-2332.28, 2516.33, 1.43), -- Location of opium plants (currently on cayo perico) change the coords here to move the field
            Prop = 'prop_plant_cane_01a', -- Opium plant prop to spawn at field location
            PlantAmount = 12, -- Amount of plants to spawn
            CollectItem = 'razorblade', -- Item required to collect opium plants
            ReturnItem = 'opium', -- Item to receive from opium plants **this is also used in processing**
            PickChance = 75, -- Chance to harvest opium plants successfully 10 = 10% - 100 = 100%
            PickTime = math.random(5000,10000), -- Time in (ms) to harvest opium plants
            PickStress = math.random(1,8), -- Stress gained by failing to pick opium plants
        },
        Ether = {
            Prop = { 'prop_barrel_exp_01a' }, -- Prop used for ether if you wish to change the prop do so here
            CollectItem = 'plasticjerrycan', -- Item required to collect ether
            ReturnItem = 'ether', -- Item returned by collecting ether
            CollectChance = 50, -- Chance to collect ether successfully 10 = 10% - 100 = 100%
            PoliceChance = 100, -- Chance to send alert to police on failiure to collect 10 = 10% - 100 = 100%
            CollectTime = math.random(8500,14000), -- Time in (ms) to collect ether
            CollectStress = math.random(1,8), -- Stress gained by failing to collect ether
        },
    },
    Shared = {
        Hydrochloric = {
            Prop = { 'prop_ind_mech_01c' }, -- Prop used for hydrochloric acid if you wish to change the prop do so here
            CollectItem = 'plasticjerrycan', -- Item required to collect hydrochloric acid
            ReturnItem = 'hydrochloricacid', -- Item returned by collecting hydrochloric acid
            CollectChance = 75, -- Chance to collect hydrochloric acid successfully 10 = 10% - 100 = 100%
            PoliceChance = 100, -- Chance to send alert to police on failiure to collect
            CollectTime = math.random(10000,16500), -- Time in (ms) to collect hydrochloric
            CollectStress = math.random(1,8), -- Stress gained by failing to collect hydrochloric acid
        },
        ConstructionSite = {
            Prop = { 'prop_cons_cements01' }, -- Prop used for building materials if you wish to change the prop do so here
            Chance = 75, -- Chance to collect building materials successfully 10 = 10% - 100 = 100%
            PoliceChance = 100, -- Chance to send alert to police on failiure to collect
            CollectTime = math.random(8500,14000), -- Time in (ms) to collect building materials
            CollectStress = math.random(1,8), -- Stress gained by failing to collect building materials
            RewardItems = {
                'slakedlime',
                'cement', -- **UNCOMMENT IF USING BOII-COCAINE**
            },
        },    
    },
}
Config.Stores = {
    Heroin = {
        Pharmacy = {
            UseTimes = false, -- Enables time locks on pharmacy; true = enabled, false = disabled - store will be open 24/7
            OpenTime = 14, -- Time you can access pharmacy
            CloseTime = 16, -- Closing time for pharmacy
            PharmacyItems = { -- Items sold by pharamacy do not remove the required items unless you plan to add your own method to aquire them
                [1] = { name = 'emptyvial',         price = 5,   amount = 100, info = {}, type = 'item', slot = 1 }, -- Required
                [2] = { name = 'sterilewater',      price = 2,   amount = 100, info = {}, type = 'item', slot = 2 }, -- Required
                [3] = { name = 'syringe',           price = 5,   amount = 100, info = {}, type = 'item', slot = 3 }, -- Required
                [4] = { name = 'aceticacid',        price = 10,  amount = 100, info = {}, type = 'item', slot = 4 }, -- Required
                [5] = { name = 'painkillers',       price = 35,  amount = 100, info = {}, type = 'item', slot = 5 },
                [6] = { name = 'ammonia',           price = 10,  amount = 100, info = {}, type = 'item', slot = 6 },     
            },
        },
        BlackMarket = {
            BlackMarketItems = { -- Black market items stocked by all processing peds
                [1] = { name = 'lockpick',          price = 300,  amount = 100, info = {}, type = 'item', slot = 1 },
                [2] = { name = 'phone',             price = 700,  amount = 100, info = {}, type = 'item', slot = 2 },
                [3] = { name = 'radio',             price = 20,   amount = 100, info = {}, type = 'item', slot = 3 },
                [4] = { name = 'empty_weed_bag',    price = 2,    amount = 500, info = {}, type = 'item', slot = 4 }, -- Required
                [5] = { name = 'razorblade',        price = 5,    amount = 50,  info = {}, type = 'item', slot = 5 }, -- Required
                [6] = { name = 'drug_cuttingkit',   price = 800,  amount = 50,  info = {}, type = 'item', slot = 6 }, -- Required
                [7] = { name = 'drug_scales',       price = 450,  amount = 50,  info = {}, type = 'item', slot = 7 }, -- Required
            },
        },
    },
}
Config.Processing = {
    Heroin = {
        Morphine = {
            UseTimes = false, -- Enables time locks on morphine processing; true = enabled, false = disabled - can process 24/7
            StartTime = 18, -- Time you can start processing morphine
            EndTime = 21, -- Cut off time for processing morphine
            ProcessTime = math.random(10000,18500), -- Time in (ms) to process morphine
            AnimationDict = 'anim@amb@board_room@supervising@', -- Animations used to process
            Animation = 'think_01_hi_amy_skater_01', -- Animations used to process
            ReturnItem = { -- Item and amount to return after processing **DO NOT EXCEED 1 ITEM**
                ['1'] = { name = 'morphinebase', label = 'Morphine Base', amount = 1}
            },
            RequiredItems = { -- Items and amounts required to process morphine base if using XP material costs will increase; level 5 = x4, level 7 = x3, level 9 = x2, level 11 = x1 
                ['1'] = { name = 'opium', label = 'Opium Sap', amount = 10 },
                ['2'] = { name = 'slakedlime', label = 'Slaked Lime', amount = 3 },
                ['3'] = { name = 'ammonia', label = 'Concentrated Ammonia', amount = 3 },
            },
        },
        HeroinBase = {
            UseTimes = false, -- Enables time locks on heroin base processing; true = enabled, false = disabled - can process 24/7
            StartTime = 10, -- Time you can start processing heroin base
            EndTime = 15, -- Cut off time for processing heroin base
            ProcessTime = math.random(10000,18500), -- Time in (ms) to process heroin base
            AnimationDict = 'anim@amb@board_room@supervising@', -- Animations used to process
            Animation = 'think_01_hi_amy_skater_01', -- Animations used to process
            ReturnItem = { -- Item and amount to return after processing
                ['1'] = { name = 'heroinbase', label = 'Heroin Base', amount = 1}
            },
            RequiredItems = { -- Items and amounts required to process heroin if using XP material costs will increase
                ['1'] = { name = 'morphinebase', label = 'Morphine Base', amount = 2 },
                ['2'] = { name = 'aceticacid', label = 'Acetic Acid', amount = 10 },
                ['3'] = { name = 'sodiumcarbonate', label = 'Sodium Carbonate', amount = 3 },
            }, 
        },
        Heroin = {
            UseTimes = false, -- Enables time locks on heroin processing; true = enabled, false = disabled - can process 24/7
            StartTime = 14, -- Time you can start processing heroin
            EndTime = 23, -- Cut off time for processing heroin
            ProcessTime = math.random(10000,18500), -- Time in (ms) to process heroin
            AnimationDict = 'anim@amb@board_room@supervising@', -- Animations used to process
            Animation = 'think_01_hi_amy_skater_01', -- Animations used to process
            ReturnItem = { -- Item and amount to return after processing **DO NOT EXCEED 1 ITEM**
                ['1'] = { name = 'heroin_1oz', label = 'Ounce of Heroin', amount = 1 }
            },
            RequiredItems = { -- Items and amounts required to process heroin **DO NOT EXCEED 3 ITEMS**
                ['1'] = { name = 'heroinbase', label = 'Heroin Base', amount = 2 },
                ['2'] = { name = 'ether', label = 'Petroleum Ether', amount = 4 },
                ['3'] = { name = 'hydrochloricacid',label = 'Hydrochloric Acid', amount = 3 },
            },
        },
    }
}
-- Drug cutting
Config.DrugCutting = {
    Shared = {
        CuttingKit = {  -- Item required to open cutting menus for drugs
            ['1'] = { name = 'drug_cuttingkit', label = 'Cutting Kit' }
        },
        Scales = {  -- Item required to open cutting menus for drugs
            ['1'] = { name = 'drug_scales', label = 'Scales' }
        },
        Cocaine = {
            Cocaine = {
                RequiredItems = {
                    ['1'] = { name = 'coke_1oz', label = 'Ounce of Cocaine', amount = 1 }, -- REQUIRED IF USING **BOII-COCAINE** FOLLOW INSTRUCTIONS WITHIN README
                },
            },
            Crack = {
                RequiredItems = {
                    ['1'] = { name = 'crack_1oz', label = 'Ounce of Crack', amount = 1 }, -- REQUIRED IF USING **BOII-COCAINE** FOLLOW INSTRUCTIONS WITHIN README
                },
            },
        },
        Meth = {
            RequiredItems = {
                ['1'] = { name = 'meth_1oz', label = 'Ounce of Meth', amount = 1 }, -- REQUIRED IF USING **BOII-METH** FOLLOW INSTRUCTIONS WITHIN README
            },
        },
    },
    Heroin = {
        Morphine = {
            CuttingTime = math.random(10000,18500), -- Time in (ms) to cut morphine
            AnimationDict = 'amb@prop_human_parking_meter@female@base',
            Animation = 'base_female',
            ReturnItem = { -- Item to return by cutting morphine base these scale per xp levels listed above, if XP is disabled item 5 only will be used
                ['1'] = { name = 'morphine', label = 'Morphine', amount = math.random(1,10) }, -- Level 9
                ['2'] = { name = 'morphine', label = 'Morphine', amount = math.random(3,10) }, -- Level 10
                ['3'] = { name = 'morphine', label = 'Morphine', amount = math.random(5,10) }, -- Level 11
                ['4'] = { name = 'morphine', label = 'Morphine', amount = math.random(7,10) }, -- Level 12
                ['5'] = { name = 'morphine', label = 'Morphine', amount = math.random(9,10) }, -- Level 13 -- **ONLY ITEM USED WHEN XP IS DISABLED**
            },
            RequiredItems = {
                ['1'] = { name = 'morphinebase', label = 'Morphine Base', amount = 1 }, -- This is your main drug item used by server to open menu
                ['2'] = { name = 'sterilewater', label = 'Sterile Water', amount = 10 },
                ['3'] = { name = 'emptyvial', label = 'Empty Vial', amount = 10 },
            },
        },
        Heroin = {
            CuttingTime = math.random(10000,18500), -- Time in (ms) to cut heroin
            AnimationDict = 'amb@prop_human_parking_meter@female@base',
            Animation = 'base_female',
            ReturnItem = { -- Item to return by cutting heroin ounces these scale per xp levels listed above, if XP is disabled item 5 only will be used
                ['1'] = { name = 'heroinbaggy', label = 'Bags of Heroin', amount = math.random(10,28) }, -- Level 11
                ['2'] = { name = 'heroinbaggy', label = 'Bags of Heroin', amount = math.random(14,28) }, -- Level 12
                ['3'] = { name = 'heroinbaggy', label = 'Bags of Heroin', amount = math.random(18,28) }, -- Level 13
                ['4'] = { name = 'heroinbaggy', label = 'Bags of Heroin', amount = math.random(22,28) }, -- Level 14
                ['5'] = { name = 'heroinbaggy', label = 'Bags of Heroin', amount = math.random(26,28) }, -- Level 15 -- **ONLY ITEM USED WHEN XP IS DISABLED**
            },
            RequiredItems = {
                ['1'] = { name = 'heroin_1oz', label = 'Ounce of Heroin', amount = 1 }, -- This is your main drug item used by server to open menu
                ['2'] = { name = 'empty_weed_bag', label = 'Resealable Bags', amount = 28 },
            },
        },
    },   
}
Config.TakeDrugs = {
    Heroin = {
        Morphine = {
            UseScreenEffects = true, -- Enables screen effects for morphine; true = enabled, false = disabled 
            TakeTime = math.random(5500,8500), -- Time in (ms) to take morphine
            AnimationDict = 'amb@world_human_hang_out_street@female_hold_arm@idle_a',
            Animation = 'idle_a',
            RemoveStress = math.random(10,30), -- Amount of stress to recover by using morphine
            AddArmour = math.random(60,90), -- Amount of armour to add when using morphine **ARMOUR IS SET TO 0 AFTER USING MORPHINE**
            DrugItem = { -- Usable drug item
                ['1'] = { name = 'morphine', label = 'Morphine', amount = 1 }
            },
            TakeItem = { -- Item required to use drug
                ['1'] = { name = 'syringe', label = 'Syringe' }
            },
        },
        Heroin = {
            UseScreenEffects = true, -- Enables screen effects for heroin; true = enabled, false = disabled 
            PrepTime = math.random(5500,8500), -- Time in (ms) to take heroin
            PrepAnimDict = 'amb@prop_human_parking_meter@female@base',
            PrepAnim = 'base_female',
            TakeTime = math.random(5500,8500), -- Time in (ms) to take heroin
            AnimationDict = 'amb@world_human_leaning@female@wall@back@holding_elbow@idle_b',
            Animation = 'idle_d',
            RemoveStress = math.random(10,30), -- Amount of stress to recover by using heroin
            AddArmour = math.random(33,59), -- Amount of armour to add when using heroin      
            DrugItem = { -- Usable drug item
                ['1'] = { name = 'liquidheroin', label = 'Liquid Heroin', amount = 1 }
            },
            TakeItem = { -- Item required to use drug
                ['1'] = { name = 'syringe', label = 'Syringe' }
            },
            RequiredItems = { -- Required to create usable liquid heroin do this by using item 1 
                ['1'] = { name = 'heroinbaggy', label = 'Bag of Heroin', amount = 1 }, -- Item used to start preparing
                ['2'] = { name = 'sterilewater', label = 'Sterile Water', amount = 1 },
                ['3'] = { name = 'emptyvial', label = 'Empty Vial', amount = 1 },
                ['4'] = { name = 'lighter', label = 'Lighter', amount = 1 },
            },
        },
    }
} 
-- Language
Config.Lang = {
    Targeting = {
        Heroin = {
            ['opiumicon'] = 'fas fa-cannabis', -- Icon used by qb-target for opium plants visit; https://fontawesome.com to change
            ['opiumlabel'] = 'Harvest Poppies', -- Label used by qb-target for opium plants
            ['hydroicon'] = 'fas fa-biohazard', -- Icon used by qb-target for hydrochloric location visit; https://fontawesome.com to change
            ['hydrolabel'] = 'Collect Hydrochloric Acid', -- Label used by qb-target for hydrochloric location
            ['ethericon'] = 'fab fa-gripfire', -- Icon used by qb-target for ether location visit; https://fontawesome.com to change
            ['etherlabel'] = 'Collect Petroleum Ether', -- Label used by qb-target for ether location
            ['pharmacyicon'] = 'fab fa-gripfire', -- Icon used by qb-target for pharmacy ped visit; https://fontawesome.com to change
            ['pharmacylabel'] = 'Speak To Pharmacist', -- Label used by qb-target for pharmacy ped
            ['matsicon'] = 'fab fa-drupal', -- Icon used by qb-target for building materials location visit; https://fontawesome.com to change
            ['matslabel'] = 'Search Through Materials', -- Label used by qb-target for building materials location
            ['processoricon'] = 'fab fa-drupal', -- Icon used by qb-target for heroin processor visit; https://fontawesome.com to change
            ['morphineprocessorlabel'] = 'Speak To Willy Fist', -- Label used by qb-target for morphine processor
            ['heroinbaseprocessorlabel'] = 'Speak To Terry', -- Label used by qb-target for heroin base processor
            ['heroinprocessorlabel'] = 'Speak to Ashley', -- Label used by qb-target for heroin processor
        },
    },
    Shared = {
        ['returnmenu'] = '< Return', -- Menu header
        ['returnmenuicon'] = 'fa-solid fa-backward', -- Menu header icon
        ['exitmenu'] = '< Exit', -- Menu header
        ['exitmenuicon'] = 'fa-solid fa-circle-xmark', -- Menu header icon
        ['cancelled'] = 'Action cancelled..', -- Notification
        ['noinvent'] = 'Looks like your pockets are full..', -- Notification
        ['outrange'] = 'Looks like you are too far away..', -- Notification
        ['searchcd'] = 'You have already searched this location.. come back later..', -- Notification
    },
    XP = {
        Heroin = {
            ['commandtext'] = 'Displays your current drug manufacturing xp.', -- Command text
            ['xplevelnotif'] = 'Drug Manufacturing:', -- Notification
        },
    },
    DrugMaterials = {
        Heroin = {
            Opium = {
                ['notool'] = 'You dont have the required tool to harvest these plants..', -- Notification	
                ['opiumsuccessnoxp'] = 'You harvested some '..Config.DrugMaterials.Heroin.Opium.ReturnItem..'!', -- Notification
                ['opiumfailnoxp'] = 'You accidently destroyed the plant..', -- Notification
                ['opiumsuccess'] = 'You harvested some '..Config.DrugMaterials.Heroin.Opium.ReturnItem..' and gained '..Config.XP.XPReward..' drug experience!', -- Notification
                ['opiumfail'] = 'You accidently destroyed the plant and lost '..Config.XP.XPRemove..' drug experience..', -- Notification
                ['pickopium'] = 'Harvesting Poppies..', -- Progressbar
            },
            Ether = {
                ['ethersuccessnoxp'] = 'You collected some '..Config.DrugMaterials.Heroin.Ether.ReturnItem..'!', -- Notification
                ['etherfailnoxp'] = 'You accidently spilled the ether..', -- Notification
                ['ethersuccess'] = 'You collect some '..Config.DrugMaterials.Heroin.Ether.ReturnItem..' and gained '..Config.XP.XPReward..' drug experience!', -- Notification
                ['etherfail'] = 'You accidently spilled the ether and lost '..Config.XP.XPRemove..' drug experience..', -- Notification
                ['collectether'] = 'Collecting Petroleum Ether..', -- Progressbar
            },
        },
        Shared = {
            Hydrochloric = {
                ['hydrosuccessnoxp'] = 'You collected some '..Config.DrugMaterials.Shared.Hydrochloric.ReturnItem..'!', -- Notification
                ['hydrofailnoxp'] = 'You accidently spilled the acid..', -- Notification
                ['hydrosuccess'] = 'You collect some '..Config.DrugMaterials.Shared.Hydrochloric.ReturnItem..' and gained '..Config.XP.XPReward..' drug experience!', -- Notification
                ['hydrofail'] = 'You accidently spilled the acid and lost '..Config.XP.XPRemove..' drug experience..', -- Notification
                ['collecthydro'] = 'Collecting Hydrochloric Acid..', -- Progressbar
            },
            ConstructionSite = {
                ['matssuccessnoxp'] = 'You found something useful!', -- Notification
                ['matsfailnoxp'] = 'You didnt find anything useful here..', -- Notification
                ['matssuccess'] = 'You found something useful and gained '..Config.XP.XPReward..' drug experience in the process!', -- Notification
                ['matsfail'] = 'You didnt find anything of use here and lost '..Config.XP.XPRemove..' drug experience for wasting time..', -- Notification
                ['searchmats'] = 'Searching For Materials..', -- Progressbar
            },
        },    
    },
    Stores = {
        Heroin = {
            Pharmacy = {
                ['pharmacyheader'] = 'Pharmacist', -- Menu header 
                ['pharmacyheadertext'] = 'I can sell you some under the counter meds!', -- Menu header text
                ['pharmacyheadericon'] = 'fa-solid fa-capsules', -- Menu header 
                ['pharmacystoreheader'] = 'Purchase Items!', -- Menu header   
                ['pharmacystoreheadertext'] = 'Check what items are in stock here.', -- Menu header
                ['pharmacystoreheadericon'] = 'fa-solid fa-cash-register', -- Menu header icon
                ['pharmacystorelabel'] = 'Pharmacist', -- Store header
                ['pharmacyclosed'] = 'Cant you see im taking a break? Come back between '..Config.Stores.Heroin.Pharmacy.OpenTime..' and '..Config.Stores.Heroin.Pharmacy.CloseTime..' ..', -- Notification
            },
            BlackMarket = {
                ['blackmarketheader'] = 'Black Market', -- Menu header   
                ['blackmarketheadertext'] = 'Check what items are in stock here.', -- Menu header
                ['blackmarketheadericon'] = 'fa-solid fa-cash-register', -- Menu header icon
                ['blackmarketstorelabel'] = 'Black Market', -- Store header
            },
        },       
    },
    Processing = {
        Heroin = {
            Morphine = {
                ['processormorphineheader'] = 'Morphine Processing', -- Menu header 
                ['processormorphineheadertext'] = 'Ill take those drug materials from you!', -- Menu header text
                ['processormorphineheadericon'] = 'fa-solid fa-user-ninja', -- Menu header icon
                ['processingmorphineheader'] = 'Morphine Processing', -- Menu header   
                ['processingmorphineheadertext'] = 'Required:</p>'..Config.Processing.Heroin.Morphine.RequiredItems['1'].amount..'x '..Config.Processing.Heroin.Morphine.RequiredItems['1'].label..'</p>'..Config.Processing.Heroin.Morphine.RequiredItems['2'].amount..'x '..Config.Processing.Heroin.Morphine.RequiredItems['2'].label..'</p>'..Config.Processing.Heroin.Morphine.RequiredItems['3'].amount..'x '..Config.Processing.Heroin.Morphine.RequiredItems['3'].label..'', -- Menu header
                ['processingmorphineheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['processorclosed'] = 'Dude we are stocked up right now.. try us between '..Config.Processing.Heroin.Morphine.StartTime..' and '..Config.Processing.Heroin.Morphine.EndTime..' ..', -- Notification
                ['enoughmorph1'] = 'Looks like you dont have enough '..Config.Processing.Heroin.Morphine.RequiredItems['1'].label..'.. check your pockets..', -- Notification
                ['nomorph1'] = 'Looks like you dont have any '..Config.Processing.Heroin.Morphine.RequiredItems['1'].label..'..', -- Notification
                ['enoughmorph2'] = 'Looks like you dont have enough '..Config.Processing.Heroin.Morphine.RequiredItems['2'].label..'.. check your pockets..', -- Notification
                ['nomorph2'] = 'Looks like you dont have any '..Config.Processing.Heroin.Morphine.RequiredItems['2'].label..'..', -- Notification
                ['enoughmorph3'] = 'Looks like you dont have enough '..Config.Processing.Heroin.Morphine.RequiredItems['3'].label..'.. check your pockets..', -- Notification
                ['nomorph3'] = 'Looks like you dont have any '..Config.Processing.Heroin.Morphine.RequiredItems['3'].label..'..', -- Notification
                ['processmorphine'] = 'Exchanging Morphine Materials..', -- Progressbar
            },
            HeroinBase = {
                ['processorheroinbaseheader'] = 'Heroin Base Processing', -- Menu header 
                ['processorheroinbaseheadertext'] = 'Ill take those drug materials from you!', -- Menu header text 
                ['processorheroinbaseheadericon'] = 'fa-solid fa-user-ninja', -- Menu header icon
                ['processingheroinbaseheader'] = 'Heroin Base Processing', -- Menu header   
                ['processingheroinbaseheadertext'] = 'Required:</p>'..Config.Processing.Heroin.HeroinBase.RequiredItems['1'].amount..'x '..Config.Processing.Heroin.HeroinBase.RequiredItems['1'].label..'</p>'..Config.Processing.Heroin.HeroinBase.RequiredItems['2'].amount..'x '..Config.Processing.Heroin.HeroinBase.RequiredItems['2'].label..'</p>'..Config.Processing.Heroin.HeroinBase.RequiredItems['3'].amount..'x '..Config.Processing.Heroin.HeroinBase.RequiredItems['3'].label..'', -- Menu header
                ['processingheroinbaseheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['processorclosed'] = 'We dont need anything right now.. come back between '..Config.Processing.Heroin.HeroinBase.StartTime..' and '..Config.Processing.Heroin.HeroinBase.EndTime..' ..', -- Notification
                ['enoughheroinbase1'] = 'Looks like you dont have enough '..Config.Processing.Heroin.HeroinBase.RequiredItems['1'].label..'.. check your pockets..', -- Notification
                ['noheroinbase1'] = 'Looks like you dont have any '..Config.Processing.Heroin.HeroinBase.RequiredItems['1'].label..'..', -- Notification
                ['enoughheroinbase2'] = 'Looks like you dont have enough '..Config.Processing.Heroin.HeroinBase.RequiredItems['2'].label..'.. check your pockets..', -- Notification
                ['noheroinbase2'] = 'Looks like you dont have any '..Config.Processing.Heroin.HeroinBase.RequiredItems['2'].label..'..', -- Notification
                ['enoughheroinbase3'] = 'Looks like you dont have enough '..Config.Processing.Heroin.HeroinBase.RequiredItems['3'].label..'.. check your pockets..', -- Notification
                ['noheroinbase3'] = 'Looks like you dont have any '..Config.Processing.Heroin.HeroinBase.RequiredItems['3'].label..'..', -- Notification
                ['processheroinbase'] = 'Exchanging Heroin Base Materials..', -- Progressbar            
            },
            Heroin = {
                ['processorheroinheader'] = 'Heroin Processing', -- Menu header 
                ['processorheroinheadertext'] = 'Ill take those drug materials from you!', -- Menu header text
                ['processorheroinheadericon'] = 'fa-solid fa-user-ninja', -- Menu header icon 
                ['processingheroinheader'] = 'Heroin Processing', -- Menu header   
                ['processingheroinheadertext'] = 'Required:</p>'..Config.Processing.Heroin.Heroin.RequiredItems['1'].amount..'x '..Config.Processing.Heroin.Heroin.RequiredItems['1'].label..'</p>'..Config.Processing.Heroin.Heroin.RequiredItems['2'].amount..'x '..Config.Processing.Heroin.Heroin.RequiredItems['2'].label..'</p>'..Config.Processing.Heroin.Heroin.RequiredItems['3'].amount..'x '..Config.Processing.Heroin.Heroin.RequiredItems['3'].label..'', -- Menu header
                ['processingheroinheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['processorclosed'] = 'Johnny is stocked up right now.. come back between '..Config.Processing.Heroin.Heroin.StartTime..' and '..Config.Processing.Heroin.Heroin.EndTime..' ..', -- Notification
                ['enoughheroin1'] = 'Looks like you dont have enough '..Config.Processing.Heroin.Heroin.RequiredItems['1'].label..'.. check your pockets..', -- Notification
                ['noheroin1'] = 'Looks like you dont have any '..Config.Processing.Heroin.Heroin.RequiredItems['1'].label..'..', -- Notification
                ['enoughheroin2'] = 'Looks like you dont have enough '..Config.Processing.Heroin.Heroin.RequiredItems['2'].label..'.. check your pockets..', -- Notification
                ['noheroin2'] = 'Looks like you dont have any '..Config.Processing.Heroin.Heroin.RequiredItems['2'].label..'..', -- Notification
                ['enoughheroin3'] = 'Looks like you dont have enough '..Config.Processing.Heroin.Heroin.RequiredItems['3'].label..'.. check your pockets..', -- Notification
                ['noheroin3'] = 'Looks like you dont have any '..Config.Processing.Heroin.Heroin.RequiredItems['3'].label..'..', -- Notification
                ['processheroin'] = 'Exchanging Heroin Materials..', -- Progressbar  
            },   
        },
    },
    DrugCutting = {
        Heroin = {
            Morphine = {
                ['cutmorphineheader'] = 'Cut Morphine', -- Menu header
                ['cutmorphineheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['cutmorphineheadertext'] = 'Required:</p>1x '..Config.DrugCutting.Shared.Scales['1'].label..'</p>'..Config.DrugCutting.Heroin.Morphine.RequiredItems['1'].amount..'x '..Config.DrugCutting.Heroin.Morphine.RequiredItems['1'].label..'</p>'..Config.DrugCutting.Heroin.Morphine.RequiredItems['2'].amount..'x '..Config.DrugCutting.Heroin.Morphine.RequiredItems['2'].label..'</p>'..Config.DrugCutting.Heroin.Morphine.RequiredItems['3'].amount..'x '..Config.DrugCutting.Heroin.Morphine.RequiredItems['3'].label..'', -- Menu header text        
                ['cutenoughmorph1'] = 'Looks like you dont have enough '..Config.DrugCutting.Heroin.Morphine.RequiredItems['1'].label..'.. check your pockets..', -- Notification
                ['cutnomorph1'] = 'Looks like you dont have any '..Config.DrugCutting.Heroin.Morphine.RequiredItems['1'].label..'..', -- Notification
                ['cutenoughmorph2'] = 'Looks like you dont have enough '..Config.DrugCutting.Heroin.Morphine.RequiredItems['2'].label..'.. check your pockets..', -- Notification
                ['cutnomorph2'] = 'Looks like you dont have any '..Config.DrugCutting.Heroin.Morphine.RequiredItems['2'].label..'..', -- Notification
                ['cutenoughmorph3'] = 'Looks like you dont have enough '..Config.DrugCutting.Heroin.Morphine.RequiredItems['3'].label..'.. check your pockets..', -- Notification
                ['cutnomorph3'] = 'Looks like you dont have any '..Config.DrugCutting.Heroin.Morphine.RequiredItems['3'].label..'..', -- Notification
                ['cutmorphinexp'] = 'You sucessfully cut some '..Config.DrugCutting.Heroin.Morphine.ReturnItem['1'].label..' and gained '..Config.XP.XPReward..' drug experience!', -- Notification
                ['cutmorphinenoxp'] = 'You sucessfully cut some '..Config.DrugCutting.Heroin.Morphine.ReturnItem['1'].label..'!', -- Notification
				['nomorphounce'] = 'You cant cut morphine without '..Config.DrugCutting.Heroin.Morphine.RequiredItems['1'].label..'..', -- Notification
                ['cutmorphine'] = 'Cutting Morphine..', -- Progressbar
            },
            Heroin = {
                ['cutheroinheader'] = 'Cut Heroin', -- Menu header
                ['cutheroinheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['cutheroinheadertext'] = 'Required:</p>1x '..Config.DrugCutting.Shared.Scales['1'].label..'</p>'..Config.DrugCutting.Heroin.Heroin.RequiredItems['1'].amount..'x '..Config.DrugCutting.Heroin.Heroin.RequiredItems['1'].label..'</p>'..Config.DrugCutting.Heroin.Heroin.RequiredItems['2'].amount..'x '..Config.DrugCutting.Heroin.Heroin.RequiredItems['2'].label..'', -- Menu header text        
                ['cutenoughheroin1'] = 'Looks like you dont have enough '..Config.DrugCutting.Heroin.Heroin.RequiredItems['1'].label..'.. check your pockets..', -- Notification
                ['cutnoheroin1'] = 'Looks like you dont have any '..Config.DrugCutting.Heroin.Heroin.RequiredItems['1'].label..'..', -- Notification
                ['cutenoughheroin2'] = 'Looks like you dont have enough '..Config.DrugCutting.Heroin.Heroin.RequiredItems['2'].label..'.. check your pockets..', -- Notification
                ['cutnoheroin2'] = 'Looks like you dont have any '..Config.DrugCutting.Heroin.Heroin.RequiredItems['2'].label..'..', -- Notification
                ['cutheroinxp'] = 'You sucessfully cut some '..Config.DrugCutting.Heroin.Heroin.ReturnItem['1'].label..' and gained '..Config.XP.XPReward..' drug experience!', -- Notification
                ['cutheroinnoxp'] = 'You sucessfully cut some '..Config.DrugCutting.Heroin.Heroin.ReturnItem['1'].label..'!', -- Notification
				['noheroinounce'] = 'You cant cut heroin without '..Config.DrugCutting.Heroin.Heroin.RequiredItems['1'].label..'..', -- Notification
                ['cutheroin'] = 'Cutting Heroin..', -- Progressbar
            },
        },
        Cocaine = {
            Cocaine = {
                ['cutcokeheader'] = 'Cut Cocaine', -- ONLY NEED IF USING **BOII-COCAINE** FOLLOW INSTRUCTIONS WITHIN README
                ['cutcokeheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['nocokeounce'] = 'You cant cut cocaine without '..Config.DrugCutting.Shared.Cocaine.Cocaine.RequiredItems['1'].label..'..', -- Notification
            },
            Crack = {
                ['cutcrackheader'] = 'Cut Crack', -- ONLY NEED IF USING **BOII-COCAINE** FOLLOW INSTRUCTIONS WITHIN README
                ['cutcrackheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['nocrackounce'] = 'You cant cut crack without '..Config.DrugCutting.Shared.Cocaine.Crack.RequiredItems['1'].label..'..', -- Notification
            },
        },       
        Meth = {
            Meth = {
                ['cutmethheader'] = 'Cut Meth', -- ONLY NEED IF USING **BOII-METH** FOLLOW INSTRUCTIONS WITHIN README
                ['cutmethheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['nomethounce'] = 'You cant cut meth without '..Config.DrugCutting.Shared.Meth.RequiredItems['1'].label..'..', -- ONLY NEED IF USING **BOII-METH** FOLLOW INSTRUCTIONS WITHIN README    
            }
        },
        Shared = {
            ['noscales'] = 'How are you going to weigh out drugs without a '..Config.DrugCutting.Shared.Scales['1'].label..'..', -- Notification
            ['cuttingheader'] = 'Cutting Kit', -- Menu header
            ['cuttingheadertext'] = 'Cut your weight into something usable!', -- Menu header text
            ['nocutkit'] = 'Looks like your missing a '..Config.DrugCutting.Shared.CuttingKit['1'].label..' check your pockets.', -- Notification
        },
    },
    TakeDrugs = {
        Heroin = {
            Morphine = {
                ['nomorphineitem'] = 'You need a '..Config.TakeDrugs.Heroin.Morphine.TakeItem['1'].label..' to inject '..Config.TakeDrugs.Heroin.Morphine.DrugItem['1'].label..'', -- Notification
                ['takemorphine'] = 'Taking Morphine..', -- Progressbar
            },
            Heroin = {
                ['noheroinitem'] = 'You need a '..Config.TakeDrugs.Heroin.Heroin.TakeItem['1'].label..' to inject '..Config.TakeDrugs.Heroin.Heroin.DrugItem['1'].label..'', -- Notification
                ['noheroprepitem'] = 'You need some '..Config.TakeDrugs.Heroin.Heroin.RequiredItems['2'].label..' to prepare '..Config.TakeDrugs.Heroin.Heroin.DrugItem['1'].label..'', -- Notification
                ['noheroprepitem2'] = 'You need a '..Config.TakeDrugs.Heroin.Heroin.RequiredItems['3'].label..' to prepare '..Config.TakeDrugs.Heroin.Heroin.DrugItem['1'].label..'', -- Notification
                ['noheroprepitem3'] = 'You need a '..Config.TakeDrugs.Heroin.Heroin.RequiredItems['4'].label..' to prepare '..Config.TakeDrugs.Heroin.Heroin.DrugItem['1'].label..'', -- Notification
                ['preparedheroin'] = 'You successfully prepared some '..Config.TakeDrugs.Heroin.Heroin.DrugItem['1'].label..' and gained '..Config.XP.XPReward..' drug experience!', -- Progressbar
                ['preparedheroinnoxp'] = 'You successfully prepared some '..Config.TakeDrugs.Heroin.Heroin.DrugItem['1'].label..'', -- Progressbar
                ['prepareheroin'] = 'Preparing Heroin Free Base..', -- Progressbar
                ['takeheroin'] = 'Taking Heroin..', -- Progressbar
            },
        },
    },
    Alerts = {
        Heroin = {
            ['policenotif'] = '10-66: Suspicious Person in Area!', -- Notification
            ['bliptext'] = '10-66: Suspicious Person in Area!', -- Blip text 
        },
    },   
}