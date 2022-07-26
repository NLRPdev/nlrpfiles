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
    {title="Cocaine Field",         colour=3,   id=51,    scale=0.6,    x = 4823.74,   y = -5791.59,   z = 36.89},
	{title="Cocaine Processing",    colour=3,   id=51,    scale=0.6,    x = 517.33,    y = 172.95,     z = 100.25},
	{title="Crack Processing",      colour=3,   id=51,    scale=0.6,    x = -255.73,   y = -1544.53,   z = 31.90},
	{title="Airport Crates",        colour=3,   id=51,    scale=0.6,    x = -1150.35,  y = -2566.99,   z = 13.94},
	{title="Gasoline Tankers",      colour=3,   id=51,    scale=0.6,    x = -1932.35,  y = 3038.86,    z = 32.81},
	{title="Construction Site",     colour=3,   id=51,    scale=0.6,    x = -453.74,   y = -983.82,    z = 25.9}, -- Shared with **BOII-HEROIN** 
}
-- Peds
Config.Peds = {
    {515.13, 174.49, 99.68,"Avon",248.07,0xFCE270C2,"ig_avon"}, -- Coke processing ped and location
    {-255.88, -1542.7, 30.92,"Stretch",194.07,0x36984358,"ig_stretch"}, -- Crack processing ped and location
}
-- General settings
Config.SearchCD = 30 -- Cooldown timer in (mins) used by hydrochloric & ether locations default = 30mins; 1 = 1min, 5 = 5min, 10 = 10min, 12 = 12mins.. etc..
Config.PoliceJob = 'police' -- Name of your police job to receive alerts
-- XP settings
Config.XP = {
    UseXP = true, -- Toggles xp system on or off; true = on, false = off
    MetaDataName = 'cocainexp', -- The name of your xp if you edit this make sure to also edit the line included in readme this is also your /drugxp command
    XPReward = math.random(1,5), -- Amount of XP to reward for successful drug actions
    XPRemove = math.random(1,5), -- Amount of XP to reward for unsuccessful drug actions
    XPLevels = { -- Change your xp requirements here to suit your server set these as high as you want **!!DONT FORGET TO EDIT YOUR SERVER SIDE TO MATCH!!**
        100, -- Experience required for level 2
        200, -- Experience required for level 3 -- 3 - 11 increases amount of coca leaves from plants
        300, -- Experience required for level 4 -- 4 - 7 increases chance to reveive more building materials
        400, -- Experience required for level 5 -- 5 - 8 increase amount of gasoline collected
        500, -- Experience required for level 6
        600, -- Experience required for level 7 -- 7 - 10 increases amount of items from airplane carts
        700, -- Experience required for level 8
        800, -- Experience required for level 9
        900, -- Experience required for level 10 
        1000, -- Experience required for level 11
        1100, -- Experience required for level 12 -- 12 - 16 increase amount of crack baggies from cutting
        1200, -- Experience required for level 13 
        1300, -- Experience required for level 14
        1400, -- Experience required for level 15
        1500, -- Experience required for level 16 -- 16 - 20 increase amount of cocaine baggies from cutting
        1600, -- Experience required for level 17
        1700, -- Experience required for level 18
        1800, -- Experience required for level 19
        1900, -- Experience required for level 20 -- Max level
    },  
}
Config.Stores = {
    Cocaine = {
        BlackMarket = {
            BlackMarketItems = { -- Black market items stocked by all processing peds
            [1] = { name = 'lockpick',                  price = 300,   amount = 100, info = {}, type = 'item', slot = 1 },
            [2] = { name = 'phone',                     price = 700,   amount = 100, info = {}, type = 'item', slot = 2 },
            [3] = { name = 'radio',                     price = 2000,  amount = 100, info = {}, type = 'item', slot = 3 },
            [4] = { name = 'empty_weed_bag',            price = 2,     amount = 500, info = {}, type = 'item', slot = 4 }, -- Required
            [5] = { name = 'trowel',                    price = 100,   amount = 50,  info = {}, type = 'item', slot = 5 }, -- Required
            [6] = { name = 'drug_cuttingkit',           price = 1000,  amount = 50,  info = {}, type = 'item', slot = 6 }, -- Required
            [7] = { name = 'drug_scales',               price = 1500,  amount = 50,  info = {}, type = 'item', slot = 7 }, -- Required
            [8] = { name = 'coke_spoon',                price = 20,    amount = 50,  info = {}, type = 'item', slot = 8 }, -- Required
            },
        },
    },
}
-- Drug materials
Config.DrugMaterials = {
    Cocaine = {
        CocaPlants = {
            Field = vector3(4823.74, -5791.59, 36.89), -- Location of coca plants (currently on cayo perico) change the coords here to move the field
            Prop = 'prop_bush_dead_02', -- Opium plant prop to spawn at field location
            PlantAmount = 15, -- Amount of plants to spawn
            CollectItem = 'trowel', -- Item required to collect coca plants
            ReturnItem = 'cocaleaf', -- Item to receive from coca plants **this is also used in processing**
            PickChance = 75, -- Chance to harvest coca plants successfully 10 = 10% - 100 = 100%
            PickTime = math.random(5000,10000), -- Time in (ms) to harvest coca plants
            PickStress = math.random(1,8), -- Stress gained by failing to pick coca plants
        },
        IllegalGasoline = {
            Prop = { 'prop_air_fueltrail2' }, -- Prop used for illegal gasoline if you wish to change the prop do so here
            CollectItem = 'plasticjerrycan', -- Item required to collect illegal gasoline
            ReturnItem = 'illegalgasoline', -- Item returned by collecting illegal gasoline
            CollectChance = 50, -- Chance to collect illegal gasoline successfully 10 = 10% - 100 = 100%
            PoliceChance = 100, -- Chance to send alert to police on failiure to collect 10 = 10% - 100 = 100%
            CollectTime = math.random(8500,14000), -- Time in (ms) to collect illegal gasoline
            CollectStress = math.random(1,8), -- Stress gained by failing to collect illegal gasoline
        },
        Benzocaine = {
            Prop = { 'prop_air_cargo_01b' }, -- Prop used for building materials if you wish to change the prop do so here
            Chance = 75, -- Chance to collect building materials successfully 10 = 10% - 100 = 100%
            PoliceChance = 100, -- Chance to send alert to police on failiure to collect
            CollectTime = math.random(8500,14000), -- Time in (ms) to collect building materials
            CollectStress = math.random(1,8), -- Stress gained by failing to collect building materials
            RewardItems = { -- High chance reward items for searching airplane carts you can add anything here
                --'goldchain',
                --'iphone',
                --'samsungphone',
                --'rolex',
                --'bandage',
                --'tosti',
                --'kurkakola',
                --'vodka',
                --'whiskey',
                'benzocaine', -- REQUIRED
            },
        },
    },
    Shared = {
        ConstructionSite = {
            Prop = { 'prop_cons_cements01' }, -- Prop used for building materials if you wish to change the prop do so here
            Chance = 75, -- Chance to collect building materials successfully 10 = 10% - 100 = 100%
            PoliceChance = 100, -- Chance to send alert to police on failiure to collect
            CollectTime = math.random(8500,14000), -- Time in (ms) to collect building materials
            CollectStress = math.random(1,8), -- Stress gained by failing to collect building materials
            RewardItems = {
                'slakedlime', -- **UNCOMMENT IF USING BOII-METH**
                'cement', -- **UNCOMMENT IF USING BOII-COCAINE**
            },
        },    
    },
}
Config.Processing = {
    Cocaine = {
        Cocaine = {
            UseTimes = false, -- Enables time locks on cocaine processing; true = enabled, false = disabled - can process 24/7
            StartTime = 10, -- Time you can start processing cocaine
            EndTime = 21, -- Cut off time for processing cocaine
            ProcessTime = math.random(10000,18500), -- Time in (ms) to process cocaine
            AnimationDict = 'anim@amb@board_room@supervising@', -- Animations used to process
            Animation = 'think_01_hi_amy_skater_01', -- Animations used to process
            ReturnItem = { -- Item and amount to return after processing **DO NOT EXCEED 1 ITEM**
                ['1'] = { name = 'coke_1oz', label = 'Ounce of Cocaine', amount = 1}
            },
            RequiredItems = { -- Items and amounts required to process cocaine 
                ['1'] = { name = 'cocaleaf', label = 'Coca Leaf', amount = 10 },
                ['2'] = { name = 'illegalgasoline', label = 'Illegal Gasoline', amount = 3 },
                ['3'] = { name = 'cement', label = 'Cement', amount = 3 },
                ['4'] = { name = 'benzocaine', label = 'Benzocaine', amount = 5 },
            },
        },
        Crack = {
            UseTimes = false, -- Enables time locks on crack processing; true = enabled, false = disabled - can process 24/7
            StartTime = 10, -- Time you can start processing crack
            EndTime = 21, -- Cut off time for processing crack
            ProcessTime = math.random(10000,18500), -- Time in (ms) to process crack
            AnimationDict = 'anim@amb@board_room@supervising@', -- Animations used to process
            Animation = 'think_01_hi_amy_skater_01', -- Animations used to process
            ReturnItem = { -- Item and amount to return after processing **DO NOT EXCEED 1 ITEM**
                ['1'] = { name = 'crack_1oz', label = 'Ounce of Crack', amount = 1}
            },
            RequiredItems = { -- Items and amounts required to process crack 
                ['1'] = { name = 'coke_1oz', label = 'Ounce of Cocaine', amount = 2 },
                ['2'] = { name = 'sodiumbicarbonate', label = 'Sodium Bicarbonate', amount = 5 },
                ['3'] = { name = 'water', label = 'Bottled Water', amount = 5 },
            },
        },
    },
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
        Heroin = {
            Morphine = {
                RequiredItems = {
                    ['1'] = { name = 'morphinebase', label = 'Morphine Base', amount = 1 }, -- REQUIRED IF USING **BOII-HEROIN** FOLLOW INSTRUCTIONS WITHIN README
                },
            },
            Heroin = {
                RequiredItems = {
                    ['1'] = { name = 'heroin_1oz', label = 'Ounce of Heroin', amount = 1 }, -- REQUIRED IF USING **BOII-HEROIN** FOLLOW INSTRUCTIONS WITHIN README
                },
            },
        },
        Meth = {
            RequiredItems = {
                ['1'] = { name = 'meth_1oz', label = 'Ounce of Meth', amount = 1 }, -- REQUIRED IF USING **BOII-METH** FOLLOW INSTRUCTIONS WITHIN README
            },
        },
    },
    Cocaine = {
        Cocaine = {
            CuttingTime = math.random(10000,18500), -- Time in (ms) to cut cocaine
            AnimationDict = 'amb@prop_human_parking_meter@female@base',
            Animation = 'base_female',
            ReturnItem = { -- Item to return by cutting cocaine these scale per xp levels listed above, if XP is disabled item 5 only will be used
                ['1'] = { name = 'cokebaggy', label = 'Bags of Cocaine', amount = math.random(10,28) }, -- Level 16
                ['2'] = { name = 'cokebaggy', label = 'Bags of Cocaine', amount = math.random(14,28) }, -- Level 17
                ['3'] = { name = 'cokebaggy', label = 'Bags of Cocaine', amount = math.random(18,28) }, -- Level 18
                ['4'] = { name = 'cokebaggy', label = 'Bags of Cocaine', amount = math.random(22,28) }, -- Level 19
                ['5'] = { name = 'cokebaggy', label = 'Bags of Cocaine', amount = math.random(26,28) }, -- Level 20 -- **ONLY ITEM USED WHEN XP IS DISABLED**
            },
            RequiredItems = {
                ['1'] = { name = 'coke_1oz', label = 'Ounce of Cocaine', amount = 1 }, -- This is your main drug item used by server to open menu
                ['2'] = { name = 'empty_weed_bag', label = 'Resealable Bags', amount = 28 },
            },
        },
        Crack = {
            CuttingTime = math.random(10000,18500), -- Time in (ms) to cut crack
            AnimationDict = 'amb@prop_human_parking_meter@female@base',
            Animation = 'base_female',
            ReturnItem = { -- Item to return by cutting crack ounces these scale per xp levels listed above, if XP is disabled item 5 only will be used
                ['1'] = { name = 'crack_baggy', label = 'Bags of Crack', amount = math.random(22,50) }, -- Level 12
                ['2'] = { name = 'crack_baggy', label = 'Bags of Crack', amount = math.random(28,50) }, -- Level 13
                ['3'] = { name = 'crack_baggy', label = 'Bags of Crack', amount = math.random(34,50) }, -- Level 14
                ['4'] = { name = 'crack_baggy', label = 'Bags of Crack', amount = math.random(40,50) }, -- Level 15
                ['5'] = { name = 'crack_baggy', label = 'Bags of Crack', amount = math.random(46,50) }, -- Level 16 -- **ONLY ITEM USED WHEN XP IS DISABLED**
            },
            RequiredItems = {
                ['1'] = { name = 'crack_1oz', label = 'Ounce of Crack', amount = 1 }, -- This is your main drug item used by server to open menu
                ['2'] = { name = 'empty_weed_bag', label = 'Resealable Bags', amount = 50 },
            },
        },
    },   
}
Config.TakeDrugs = {
    Cocaine = {
        Cocaine = {
            UseScreenEffects = true, -- Enables screen effects for cocaine; true = enabled, false = disabled
            TakeTime = math.random(5500,8500), -- Time in (ms) to take cocaine
            AnimationDict = 'anim@mp_player_intuppernose_pick',
            Animation = 'enter',
            RemoveStress = math.random(10,30), -- Amount of stress to recover by using cocaine
            AddArmour = math.random(10,21), -- Amount of armour to add when using cocaine
            DrugItem = { -- Usable drug item
                ['1'] = { name = 'cokebaggy', label = '1g Bag of Cocaine', amount = 1 }
            },
            TakeItem = { -- Item required to use drug
                ['1'] = { name = 'coke_spoon', label = 'Snuff Spoon' }
            },
        },
        Crack = {
            UseScreenEffects = true, -- Enables screen effects for crack; true = enabled, false = disabled 
            TakeTime = math.random(5500,8500), -- Time in (ms) to take crack
            AnimationDict = 'amb@world_human_aa_smoke@male@idle_a',
            Animation = 'idle_c',
            RemoveStress = math.random(10,30), -- Amount of stress to recover by using crack
            AddArmour = math.random(60,90), -- Amount of armour to add when using crack
            DrugItem = { -- Usable drug item
                ['1'] = { name = 'crack_baggy', label = '1g Bag of Crack', amount = 1 }
            },
            TakeItem = { -- Item required to use drug
                ['1'] = { name = 'lighter', label = 'Lighter' }
            },
        },
    }
} 
-- Language
Config.Lang = {
    Targeting = {
        Cocaine = {
            ['processoricon'] = 'fab fa-drupal', -- Icon used by qb-target for processors visit; https://fontawesome.com to change
            ['cocaineprocessorlabel'] = 'Speak To Avon', -- Label used by qb-target for cocaine processor
            ['crackprocessorlabel'] = 'Speak To Stretch', -- Label used by qb-target for crack processor
            ['matsicon'] = 'fab fa-drupal', -- Icon used by qb-target for building materials location visit; https://fontawesome.com to change
            ['matslabel'] = 'Search Through Materials', -- Label used by qb-target for building materials location
            ['cocaicon'] = 'fas fa-cannabis', -- Icon used by qb-target for coca plants visit; https://fontawesome.com to change
            ['cocalabel'] = 'Harvest Coca Plants', -- Label used by qb-target for coca plants
            ['gasolineicon'] = 'fab fa-gripfire', -- Icon used by qb-target for illegal gasoline location visit; https://fontawesome.com to change
            ['gasolinelabel'] = 'Steal Gasoline', -- Label used by qb-target for illegal gasoline location
            ['carticon'] = 'fab fa-drupal', -- Icon used by qb-target for illegal gasoline location visit; https://fontawesome.com to change
            ['cartlabel'] = 'Search Airplane Cart', -- Label used by qb-target for illegal gasoline location  
        },
    },
    XP = {
        ['commandtext'] = 'Displays your current drug manufacturing xp.', -- Command text
        ['xplevelnotif'] = 'Drug Manufacturing:', -- Notification
    },
    Alerts = {
        Cocaine = {
            ['policenotif'] = '10-66: Suspicious Person in Area!', -- Notification
            ['bliptext'] = '10-66: Suspicious Person in Area!', -- Blip text 
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
    DrugMaterials = {
        Shared = {
            ConstructionSite = {
                ['matssuccessnoxp'] = 'You found something useful!', -- Notification
                ['matsfailnoxp'] = 'You didnt find anything useful here..', -- Notification
                ['matssuccess'] = 'You found something useful and gained '..Config.XP.XPReward..' drug experience in the process!', -- Notification
                ['matsfail'] = 'You didnt find anything of use here and lost '..Config.XP.XPRemove..' drug experience for wasting time..', -- Notification
                ['searchmats'] = 'Searching For Materials..', -- Progressbar
            },
        },
        Cocaine = {
            CocaPlants = {
                ['notool'] = 'You need a '..Config.DrugMaterials.Cocaine.CocaPlants.CollectItem..' to harvest coca plants..', -- Notification	
                ['cocasuccessnoxp'] = 'You harvested some '..Config.DrugMaterials.Cocaine.CocaPlants.ReturnItem..'!', -- Notification
                ['cocafailnoxp'] = 'You accidently destroyed the plant..', -- Notification
                ['cocasuccess'] = 'You harvested some '..Config.DrugMaterials.Cocaine.CocaPlants.ReturnItem..' and gained '..Config.XP.XPReward..' drug experience!', -- Notification
                ['cocafail'] = 'You accidently destroyed the plant and lost '..Config.XP.XPRemove..' drug experience..', -- Notification
                ['pickcoca'] = 'Harvesting Coca Plants..', -- Progressbar
            },
            IllegalGasoline = {
                ['gassuccessnoxp'] = 'You collected some '..Config.DrugMaterials.Cocaine.IllegalGasoline.ReturnItem..'!', -- Notification
                ['gasfailnoxp'] = 'You accidently spilled the gas..', -- Notification
                ['gassuccess'] = 'You collect some '..Config.DrugMaterials.Cocaine.IllegalGasoline.ReturnItem..' and gained '..Config.XP.XPReward..' drug experience!', -- Notification
                ['gasfail'] = 'You accidently spilled the gas and lost '..Config.XP.XPRemove..' drug experience..', -- Notification
                ['collectgas'] = 'Stealing Some Gasoline..', -- Progressbar
            },
            Benzocaine = {
                ['benzosuccessnoxp'] = 'You found something inside the cart!', -- Notification
                ['benzofailnoxp'] = 'You didnt find anything useful here..', -- Notification
                ['benzosuccess'] = 'You found something inside the cart and gained '..Config.XP.XPReward..' drug experience in the process!', -- Notification
                ['benzofail'] = 'You didnt find anything of use here and lost '..Config.XP.XPRemove..' drug experience for wasting time..', -- Notification
                ['searchbenzo'] = 'Searching Through Cart..', -- Progressbar
            },
        },    
    },
    Processing = {
        Cocaine = {
            Cocaine = {
                ['processorcocaineheader'] = 'Cocaine Processing', -- Menu header 
                ['processorcocaineheadertext'] = 'Ill take those drug materials from you!', -- Menu header text
				['processorcocaineheadericon'] = 'fa-solid fa-user-ninja', -- Menu header icon
                ['processingcocaineheader'] = 'Cocaine Processing', -- Menu header   
                ['processingcocaineheadertext'] = 'Required:</p>'..Config.Processing.Cocaine.Cocaine.RequiredItems['1'].amount..'x '..Config.Processing.Cocaine.Cocaine.RequiredItems['1'].label..'</p>'..Config.Processing.Cocaine.Cocaine.RequiredItems['2'].amount..'x '..Config.Processing.Cocaine.Cocaine.RequiredItems['2'].label..'</p>'..Config.Processing.Cocaine.Cocaine.RequiredItems['3'].amount..'x '..Config.Processing.Cocaine.Cocaine.RequiredItems['3'].label..'</p>'..Config.Processing.Cocaine.Cocaine.RequiredItems['4'].amount..'x '..Config.Processing.Cocaine.Cocaine.RequiredItems['4'].label..'', -- Menu header
                ['processingcocaineheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
				['processorclosed'] = 'Dude we are stocked up right now.. try us between '..Config.Processing.Cocaine.Cocaine.StartTime..' and '..Config.Processing.Cocaine.Cocaine.EndTime..' ..', -- Notification
                ['enoughcoke1'] = 'Looks like you dont have enough '..Config.Processing.Cocaine.Cocaine.RequiredItems['1'].label..'.. check your pockets..', -- Notification
                ['nocoke1'] = 'Looks like you dont have any '..Config.Processing.Cocaine.Cocaine.RequiredItems['1'].label..'..', -- Notification
                ['enoughcoke2'] = 'Looks like you dont have enough '..Config.Processing.Cocaine.Cocaine.RequiredItems['2'].label..'.. check your pockets..', -- Notification
                ['nocoke2'] = 'Looks like you dont have any '..Config.Processing.Cocaine.Cocaine.RequiredItems['2'].label..'..', -- Notification
                ['enoughcoke3'] = 'Looks like you dont have enough '..Config.Processing.Cocaine.Cocaine.RequiredItems['3'].label..'.. check your pockets..', -- Notification
                ['nocoke3'] = 'Looks like you dont have any '..Config.Processing.Cocaine.Cocaine.RequiredItems['3'].label..'..', -- Notification
                ['enoughcoke4'] = 'Looks like you dont have enough '..Config.Processing.Cocaine.Cocaine.RequiredItems['4'].label..'.. check your pockets..', -- Notification
                ['nocoke4'] = 'Looks like you dont have any '..Config.Processing.Cocaine.Cocaine.RequiredItems['4'].label..'..', -- Notification
                ['processcoke'] = 'Exchanging Cocaine Materials..', -- Progressbar
            },
            Crack = {
                ['processorcrackheader'] = 'Crack Processing', -- Menu header 
                ['processorcrackheadertext'] = 'Ill take those drug materials from you!', -- Menu header text
				['processorcrackheadericon'] = 'fa-solid fa-user-ninja', -- Menu header icon
                ['processingcrackheader'] = 'Crack Processing', -- Menu header   
                ['processingcrackheadertext'] = 'Required:</p>'..Config.Processing.Cocaine.Crack.RequiredItems['1'].amount..'x '..Config.Processing.Cocaine.Crack.RequiredItems['1'].label..'</p>'..Config.Processing.Cocaine.Crack.RequiredItems['2'].amount..'x '..Config.Processing.Cocaine.Crack.RequiredItems['2'].label..'</p>'..Config.Processing.Cocaine.Crack.RequiredItems['3'].amount..'x '..Config.Processing.Cocaine.Crack.RequiredItems['3'].label..'', -- Menu header
                ['processingcrackheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
				['processorclosed'] = 'Dude we are stocked up right now.. try us between '..Config.Processing.Cocaine.Crack.StartTime..' and '..Config.Processing.Cocaine.Crack.EndTime..' ..', -- Notification
                ['enoughcrack1'] = 'Looks like you dont have enough '..Config.Processing.Cocaine.Crack.RequiredItems['1'].label..'.. check your pockets..', -- Notification
                ['nocrack1'] = 'Looks like you dont have any '..Config.Processing.Cocaine.Crack.RequiredItems['1'].label..'..', -- Notification
                ['enoughcrack2'] = 'Looks like you dont have enough '..Config.Processing.Cocaine.Crack.RequiredItems['2'].label..'.. check your pockets..', -- Notification
                ['nocrack2'] = 'Looks like you dont have any '..Config.Processing.Cocaine.Crack.RequiredItems['2'].label..'..', -- Notification
                ['enoughcrack3'] = 'Looks like you dont have enough '..Config.Processing.Cocaine.Crack.RequiredItems['3'].label..'.. check your pockets..', -- Notification
                ['nocrack3'] = 'Looks like you dont have any '..Config.Processing.Cocaine.Crack.RequiredItems['3'].label..'..', -- Notification
                ['processcrack'] = 'Exchanging Crack Materials..', -- Progressbar
            },   
        },
    },
    DrugCutting = {
        Cocaine = {
            Cocaine = {
                ['cutcokeheader'] = 'Cut Cocaine', -- Menu header
				['cutcokeheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['cutcokeheadertext'] = 'Required:</p>1x '..Config.DrugCutting.Shared.Scales['1'].label..'</p>'..Config.DrugCutting.Cocaine.Cocaine.RequiredItems['1'].amount..'x '..Config.DrugCutting.Cocaine.Cocaine.RequiredItems['1'].label..'</p>'..Config.DrugCutting.Cocaine.Cocaine.RequiredItems['2'].amount..'x '..Config.DrugCutting.Cocaine.Cocaine.RequiredItems['2'].label..'', -- Menu header text        
                ['cutenoughcoke1'] = 'Looks like you dont have enough '..Config.DrugCutting.Cocaine.Cocaine.RequiredItems['1'].label..'.. check your pockets..', -- Notification
                ['cutnocoke1'] = 'Looks like you dont have any '..Config.DrugCutting.Cocaine.Cocaine.RequiredItems['1'].label..'..', -- Notification
                ['cutenoughcoke2'] = 'Looks like you dont have enough '..Config.DrugCutting.Cocaine.Cocaine.RequiredItems['2'].label..'.. check your pockets..', -- Notification
                ['cutnocoke2'] = 'Looks like you dont have any '..Config.DrugCutting.Cocaine.Cocaine.RequiredItems['2'].label..'..', -- Notification
                ['cutcokexp'] = 'You sucessfully cut some '..Config.DrugCutting.Cocaine.Cocaine.ReturnItem['1'].label..' and gained '..Config.XP.XPReward..' drug experience!', -- Notification
                ['cutcokenoxp'] = 'You sucessfully cut some '..Config.DrugCutting.Cocaine.Cocaine.ReturnItem['1'].label..'!', -- Notification
                ['nocokeounce'] = 'You cant cut cocaine without '..Config.DrugCutting.Cocaine.Cocaine.RequiredItems['1'].label..'..', -- Notification
                ['cutcoke'] = 'Cutting Cocaine..', -- Progressbar
            },
            Crack = {
                ['cutcrackheader'] = 'Cut Crack', -- Menu header
				['cutcrackheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['cutcrackheadertext'] = 'Required:</p>1x '..Config.DrugCutting.Shared.Scales['1'].label..'</p>'..Config.DrugCutting.Cocaine.Crack.RequiredItems['1'].amount..'x '..Config.DrugCutting.Cocaine.Crack.RequiredItems['1'].label..'</p>'..Config.DrugCutting.Cocaine.Crack.RequiredItems['2'].amount..'x '..Config.DrugCutting.Cocaine.Crack.RequiredItems['2'].label..'', -- Menu header text        
                ['cutenoughcrack1'] = 'Looks like you dont have enough '..Config.DrugCutting.Cocaine.Crack.RequiredItems['1'].label..'.. check your pockets..', -- Notification
                ['cutnocrack1'] = 'Looks like you dont have any '..Config.DrugCutting.Cocaine.Crack.RequiredItems['1'].label..'..', -- Notification
                ['cutenoughcrack2'] = 'Looks like you dont have enough '..Config.DrugCutting.Cocaine.Crack.RequiredItems['2'].label..'.. check your pockets..', -- Notification
                ['cutnocrack2'] = 'Looks like you dont have any '..Config.DrugCutting.Cocaine.Crack.RequiredItems['2'].label..'..', -- Notification
                ['cutcrackxp'] = 'You sucessfully cut some '..Config.DrugCutting.Cocaine.Crack.ReturnItem['1'].label..' and gained '..Config.XP.XPReward..' drug experience!', -- Notification
                ['cutcracknoxp'] = 'You sucessfully cut some '..Config.DrugCutting.Cocaine.Crack.ReturnItem['1'].label..'!', -- Notification
                ['nocrackounce'] = 'You cant cut crack without '..Config.DrugCutting.Cocaine.Crack.RequiredItems['1'].label..'..', -- Notification
                ['cutcrack'] = 'Cutting Crack..', -- Progressbar
            },
        },
        Heroin = {
            Morphine = {
                ['cutmorphineheader'] = 'Cut Cocaine', -- ONLY NEED IF USING **BOII-HEROIN** FOLLOW INSTRUCTIONS WITHIN README
				['cutmorphineheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['nomorphounce'] = 'You cant cut morphine without '..Config.DrugCutting.Shared.Heroin.Morphine.RequiredItems['1'].label..'..', -- ONLY NEED IF USING **BOII-HEROIN** FOLLOW INSTRUCTIONS WITHIN README

            },
            Heroin = {
                ['cutheroinheader'] = 'Cut Crack', -- ONLY NEED IF USING **BOII-HEROIN** FOLLOW INSTRUCTIONS WITHIN README
				['cutheroinheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['noheroinounce'] = 'You cant cut heroin without '..Config.DrugCutting.Shared.Heroin.Heroin.RequiredItems['1'].label..'..', -- ONLY NEED IF USING **BOII-HEROIN** FOLLOW INSTRUCTIONS WITHIN README
            },
        },       
        Meth = {
            Meth = {
				['cutmethheader'] = 'Cut Meth', -- ONLY NEED IF USING **BOII-METH** FOLLOW INSTRUCTIONS WITHIN README
				['cutmethheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
				['nomethounce'] = 'You cant cut meth without '..Config.DrugCutting.Shared.Meth.RequiredItems['1'].label..'..', -- ONLY NEED IF USING **BOII-METH** FOLLOW INSTRUCTIONS WITHIN README
			},
        },
        Shared = {
            ['noscales'] = 'How are you going to weigh out drugs without a '..Config.DrugCutting.Shared.Scales['1'].label..'..', -- Notification
            ['cuttingheader'] = 'Cutting Kit', -- Menu header
            ['cuttingheadertext'] = 'Cut your weight into something usable!', -- Menu header text
			['cuttingheadericon'] = 'fa-solid fa-user-ninja', -- Menu header icon
            ['nocutkit'] = 'Looks like your missing a '..Config.DrugCutting.Shared.CuttingKit['1'].label..' check your pockets.', -- Notification
        },
    },
    TakeDrugs = {
        Cocaine = {
            Cocaine = {
                ['nocokeitem'] = 'You need a '..Config.TakeDrugs.Cocaine.Cocaine.TakeItem['1'].label..' to take '..Config.TakeDrugs.Cocaine.Cocaine.DrugItem['1'].label..'', -- Notification
                ['takecoke'] = 'Taking Cocaine..', -- Progressbar
            },
            Crack = {
                ['nocrackitem'] = 'You need a '..Config.TakeDrugs.Cocaine.Crack.TakeItem['1'].label..' to smoke '..Config.TakeDrugs.Cocaine.Crack.DrugItem['1'].label..'', -- Notification
                ['takecrack'] = 'Smoking Crack..', -- Progressbar
            },
        },
    },
    Stores = {
        Cocaine = {
            BlackMarket = {
                ['blackmarketheader'] = 'Black Market', -- Menu header   
                ['blackmarketheadertext'] = 'Check what items are in stock here.', -- Menu header
                ['blackmarketstorelabel'] = 'Black Market', -- Store header
            },
        },       
    },
}