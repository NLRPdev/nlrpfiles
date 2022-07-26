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
	{title="Meth Processing", colour=1, id=51, x = -41.09, y = 6575.83, z = 32.63},
	{title="Methylamine Barrels", colour=1, id=51, x = 3629.35, y = 3761.10, z = 31.50},
	{title="Hydrochloric Acid", colour=1, id=51, x = 2705.04, y = 1557.17, z = 26.04}, -- Shared with **BOII-HEROIN**
	{title="Airport Boxes", colour=1, id=51, x = -801.88, y = -2788.82, z = 14.0},
	{title="Prospecting Zone", colour=10, id=365, x = 2823.87, y = -627.59, z = 2.19},
}
-- Peds
Config.Peds = {
    Meth = {
        {-37.52, 6572.76, 30.7,"Chef",248.71,0x85889AC3,"ig_chef2"}, -- Meth processing ped and location
    },
}
-- XP settings
Config.XP = {
    UseXP = true, -- Toggles xp system on or off; true = on, false = off
    UseCommand = true, -- Toggles xp command on or off; true = on, false = off -- Important if using our other drug scripts refer to readme!
    MetaDataName = 'methxp', -- The name of your xp if you edit this make sure to also edit the line included in readme this is also your /drugxp command
    XPReward = math.random(1,5), -- Amount of XP to reward for successful drug actions
    XPRemove = math.random(1,5), -- Amount of XP to reward for unsuccessful drug actions
    XPLevels = { -- Change your xp requirements here to suit your server set these as high as you want
        100, -- Experience required for level 2 
        200, -- Experience required for level 3 -- 3 - 6 increases chance to receive more methylamine from barrels
        300, -- Experience required for level 4
        400, -- Experience required for level 5
        500, -- Experience required for level 6 -- 6 - 9 increases chance to receive more hydrochloric acid
        600, -- Experience required for level 7
        700, -- Experience required for level 8 -- 8 - 11 increases chance to receive more items from airport boxes
        800, -- Experience required for level 9
        900, -- Experience required for level 10 -- 10 - 13 increases chance to receive more items from prospecting
        1000, -- Experience required for level 11
        1100, -- Experience required for level 12
        1200, -- Experience required for level 13
        1300, -- Experience required for level 14
        1400, -- Experience required for level 15
        1500, -- Experience required for level 16
        1600, -- Experience required for level 17
        1700, -- Experience required for level 18 -- Max level 
    },  
}
-- Opium settings
Config.DrugMaterials = {
    Shared = {
        Hydrochloric = {
            Prop = { 'prop_ind_mech_01c' }, -- Prop used for hydrochloric acid if you wish to change the prop do so here
            CollectItem = 'plasticjerrycan', -- Item required to collect hydrochloric acid
            ReturnItem = 'hydrochloricacid', -- Item returned by collecting hydrochloric acid
            CollectChance = 75, -- Chance to collect hydrochloric acid successfully 10 = 10% - 100 = 100%
            PoliceChance = 100, -- Chance to send alert to police on failiure to collect
            CollectTime = math.random(10000,16500), -- Time in (ms) to collect hydrochloric
            CollectStress = math.random(1,8), -- Stress gained by failing to collect hydrochloric acid
            SearchCD = 60, -- Cooldown timer in (mins) 10 = 10mins, 15 = 15mins, etc etc..
            AnimationDict = 'anim@amb@business@weed@weed_inspecting_lo_med_hi@',
            Animation = 'weed_crouch_checkingleaves_idle_01_inspector',
            
        },    
    },
    Meth = {
        Methylamine = {
            Prop = { 'prop_barrel_02b' }, -- Prop used for methylamine if you wish to change the prop do so here
            CollectItem = 'plasticjerrycan', -- Item required to collect methylamine
            ReturnItem = 'methylamine', -- Item returned by collecting methylamine
            CollectChance = 60, -- Chance to collect methylamine successfully 10 = 10% - 100 = 100%
            PoliceChance = 100, -- Chance to send alert to police on failiure to collect
            CollectTime = math.random(10000,16500), -- Time in (ms) to collect methylamine
            CollectStress = math.random(1,8), -- Stress gained by failing to collect methylamine
            SearchCD = 60, -- Cooldown timer in (mins) 10 = 10mins, 15 = 15mins, etc etc..
            AnimationDict = 'anim@amb@business@weed@weed_inspecting_lo_med_hi@',
            Animation = 'weed_crouch_checkingleaves_idle_01_inspector',
        },
        Acetone = {
            Prop = { 'prop_boxpile_07d' }, -- Prop used for acetone boxes if you wish to change the prop do so here
            CollectChance = 75, -- Chance to collect from acetone boxes successfully 10 = 10% - 100 = 100%
            PoliceChance = 100, -- Chance to send alert to police on failiure to collect
            CollectTime = math.random(8500,14000), -- Time in (ms) to collect from acetone boxes
            CollectStress = math.random(1,8), -- Stress gained by failing to collect from acetone boxes
            SearchCD = 60, -- Cooldown timer in (mins) 10 = 10mins, 15 = 15mins, etc etc..
            AnimationDict = 'anim@amb@business@weed@weed_inspecting_lo_med_hi@',
            Animation = 'weed_crouch_checkingleaves_idle_01_inspector',
            RewardItems = { -- Reward items for searching acetone boxes you can add anything here
                'iron',
                'steel',
                'copper',
                'rubber',
                'acetone', -- REQUIRED
            },
        },
        Lithium = {
            Field = vector3(2818.43, -636.70, 2.42), -- Location of prospecting rocks change the coords here to move the field
            Prop = 'prop_rock_1_i', -- Prospecting rocks prop to spawn at field location
            RockAmount = 15, -- Amount of rocks to spawn   
            Chance = 75, -- Chance to prospect rocks successfully 10 = 10% - 100 = 100%
            CollectItem = 'trowel', -- Item required to prospect rocks
            CollectTime = math.random(5000,10000), -- Time in (ms) to prospect rocks
            CollectStress = math.random(1,8), -- Stress gained by failing to prospect rocks
            AnimationDict = 'anim@amb@business@weed@weed_inspecting_lo_med_hi@',
            Animation = 'weed_crouch_checkingleaves_idle_01_inspector',
            RewardItems = { -- Reward items for prospecting rocks you can add anything here 
                'iron',
                'steel',
                'copper',
                'rubber',
                'lithium', -- REQUIRED
            },
        },
    }
}
-- Drug processing
Config.Processing = {
    Meth = {
        Meth = {
            UseTimes = false, -- Enables time locks on cocaine processing; true = enabled, false = disabled - can process 24/7
            StartTime = 10, -- Time you can start processing cocaine
            EndTime = 21, -- Cut off time for processing cocaine
            ProcessTime = math.random(10000,18500), -- Time in (ms) to process cocaine
            AnimationDict = 'anim@amb@board_room@supervising@', -- Animations used to process
            Animation = 'think_01_hi_amy_skater_01', -- Animations used to process
            ReturnItem = { -- Item and amount to return after processing **DO NOT EXCEED 1 ITEM**
                ['1'] = { name = 'meth_1oz', label = 'Ounce of Meth', amount = 1}
            },
            RequiredItems = { -- Items and amounts required to process cocaine 
                ['1'] = { name = 'methylamine', label = 'Methylamine', amount = 3 },
                ['2'] = { name = 'hydrochloricacid', label = 'Hydrochloric Acid', amount = 5 },
                ['3'] = { name = 'acetone', label = 'Acetone', amount = 2 },
                ['4'] = { name = 'lithium', label = 'Lithium', amount = 6 },
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
    },
    Meth = {
        Meth = {
            CuttingTime = math.random(10000,18500), -- Time in (ms) to cut morphine
            AnimationDict = 'amb@prop_human_parking_meter@female@base',
            Animation = 'base_female',
            ReturnItem = { -- Item to return by cutting meth ounces these scale per xp levels listed above, if XP is disabled item 5 only will be used
            ['1'] = { name = 'meth', label = 'Bags of Meth', amount = math.random(10,28) }, -- Level 14
            ['2'] = { name = 'meth', label = 'Bags of Meth', amount = math.random(14,28) }, -- Level 15
            ['3'] = { name = 'meth', label = 'Bags of Meth', amount = math.random(18,28) }, -- Level 16
            ['4'] = { name = 'meth', label = 'Bags of Meth', amount = math.random(22,28) }, -- Level 17
            ['5'] = { name = 'meth', label = 'Bags of Meth', amount = math.random(26,28) }, -- Level 18 -- **ONLY ITEM USED WHEN XP IS DISABLED**
            },
            RequiredItems = {
                ['1'] = { name = 'meth_1oz', label = 'Ounce of Meth', amount = 1 }, -- This is your main drug item used by server to open menu
                ['2'] = { name = 'empty_weed_bag', label = 'Resealable Bags', amount = 28 },
            },
        },
    },  
}
-- Drug taking
Config.TakeDrugs = {
    Meth = {
        Meth = {
            UseScreenEffects = true, -- Enables screen effects for meth; true = enabled, false = disabled 
            TakeTime = math.random(5500,8500), -- Time in (ms) to take meth
            AnimationDict = 'amb@world_human_aa_smoke@male@idle_a',
            Animation = 'idle_c',
            RemoveStress = math.random(10,30), -- Amount of stress to recover by using meth
            AddArmour = math.random(60,90), -- Amount of armour to add when using meth
            DrugItem = { -- Usable drug item
                ['1'] = { name = 'meth', label = '1g Bag of Meth', amount = 1 }
            },
            TakeItem = { -- Item required to use drug
                ['1'] = { name = 'lighter', label = 'Lighter' }
            },
        },
    }
} 
-- Stores
Config.Stores = {
    Meth = {
        BlackMarket = {
            BlackMarketItems = { -- Black market items stocked by processing peds
                [1] = { name = 'lockpick',                 price = 300,   amount = 100, info = {}, type = 'item', slot = 1 },
                [2] = { name = 'phone',                    price = 700,   amount = 100, info = {}, type = 'item', slot = 2 },
                [3] = { name = 'radio',                    price = 2000,  amount = 100, info = {}, type = 'item', slot = 3 },
                [4] = { name = 'empty_weed_bag',           price = 2,     amount = 500, info = {}, type = 'item', slot = 4 }, -- Required
                [5] = { name = 'trowel',                   price = 100,   amount = 50,  info = {}, type = 'item', slot = 5 }, -- Required
                [6] = { name = 'drug_cuttingkit',          price = 1000,  amount = 50,  info = {}, type = 'item', slot = 6 }, -- Required
                [7] = { name = 'drug_scales',              price = 1500,  amount = 50,  info = {}, type = 'item', slot = 7 }, -- Required
            },
        },
    },
}
-- Language
Config.Lang = {
    Targeting = {
        Meth = {
            ['hydroicon'] = 'fas fa-biohazard', -- Icon used by qb-target for hydrochloric location visit; https://fontawesome.com to change
            ['hydrolabel'] = 'Collect Hydrochloric Acid', -- Label used by qb-target for hydrochloric location
            ['methyicon'] = 'fas fa-biohazard', -- Icon used by qb-target for methylamine location visit; https://fontawesome.com to change
            ['methylabel'] = 'Collect Methylamine', -- Label used by qb-target for methylamine location
            ['acetoneicon'] = 'fas fa-box', -- Icon used by qb-target for acetone box location visit; https://fontawesome.com to change
            ['acetonelabel'] = 'Search Through Box', -- Label used by qb-target for acetone box location
            ['lithicon'] = 'fa-solid fa-person-digging', -- Icon used by qb-target for prospecting location visit; https://fontawesome.com to change
            ['lithlabel'] = 'Prospect Rock', -- Label used by qb-target for prospecting location
            ['processoricon'] = 'fab fa-drupal', -- Icon used by qb-target for heroin processor visit; https://fontawesome.com to change
            ['methprocessorlabel'] = 'Speak To Chef', -- Label used by qb-target for meth processor

        },
    },
    Shared = {
        ['returnmenu'] = 'Return', -- Menu header
        ['returnmenuicon'] = 'fa-solid fa-backward', -- Menu header icon
        ['exitmenu'] = 'Exit', -- Menu header
        ['exitmenuicon'] = 'fa-solid fa-circle-xmark', -- Menu header icon
        ['cancelled'] = 'Action cancelled..', -- Notification
        ['noinvent'] = 'Looks like your pockets are full..', -- Notification
        ['outrange'] = 'Looks like you are too far away..', -- Notification
        ['searchcd'] = 'You have already searched this location.. come back later..', -- Notification
    },
    XP = {
        Meth = {
            ['commandtext'] = 'Displays your current drug manufacturing xp.', -- Command text
            ['xplevelnotif'] = 'Drug Manufacturing:', -- Notification
        },
    },
    Alerts = {
        Meth = {
            ['policenotif'] = '10-66: Suspicious Person in Area!', -- Notification
            ['bliptext'] = '10-66: Suspicious Person in Area!', -- Blip text 
        },
    },
    DrugMaterials = {
        Shared = {
            Hydrochloric = {
                ['hydrosuccessnoxp'] = 'You collected some '..Config.DrugMaterials.Shared.Hydrochloric.ReturnItem..'!', -- Notification
                ['hydrofailnoxp'] = 'You accidently spilled the acid..', -- Notification
                ['hydrosuccess'] = 'You collect some '..Config.DrugMaterials.Shared.Hydrochloric.ReturnItem..' and gained '..Config.XP.XPReward..' drug experience!', -- Notification
                ['hydrofail'] = 'You accidently spilled the acid and lost '..Config.XP.XPRemove..' drug experience..', -- Notification
                ['collecthydro'] = 'Collecting Hydrochloric Acid..', -- Progressbar
            },
        },
        Meth = {
            Methylamine = {
                ['methysuccessnoxp'] = 'You collected some '..Config.DrugMaterials.Meth.Methylamine.ReturnItem..'!', -- Notification
                ['methyfailnoxp'] = 'You accidently spilled the methylamine..', -- Notification
                ['methysuccess'] = 'You collect some '..Config.DrugMaterials.Meth.Methylamine.ReturnItem..' and gained '..Config.XP.XPReward..' drug experience!', -- Notification
                ['methyfail'] = 'You accidently spilled the methylamine and lost '..Config.XP.XPRemove..' drug experience..', -- Notification
                ['collectmethy'] = 'Collecting Methylamine..', -- Progressbar
            },
            Acetone = {
                ['acetonesuccessnoxp'] = 'You found something inside the box!', -- Notification
                ['acetonefailnoxp'] = 'You didnt find anything useful here..', -- Notification
                ['acetonesuccess'] = 'You found something inside the box and gained '..Config.XP.XPReward..' drug experience in the process!', -- Notification
                ['acetonefail'] = 'You didnt find anything of use here and lost '..Config.XP.XPRemove..' drug experience for wasting time..', -- Notification
                ['searchacetone'] = 'Searching Through Box..', -- Progressbar
            },
            Lithium = {
                ['lithiumsuccessnoxp'] = 'You found something whilst digging!', -- Notification
                ['lithiumfailnoxp'] = 'You didnt find anything useful here..', -- Notification
                ['lithiumsuccess'] = 'You found something whilst digging and gained '..Config.XP.XPReward..' drug experience in the process!', -- Notification
                ['lithiumfail'] = 'You didnt find anything of use here and lost '..Config.XP.XPRemove..' drug experience for wasting time..', -- Notification
                ['prospectrock'] = 'Prospecting Rocks..', -- Progressbar
            },
        }    
    },
    Processing = {
        Meth = {
            Meth = {
                ['processormethheader'] = 'Meth Processing', -- Menu header 
                ['processormethheadertext'] = 'Ill take those drug materials from you!', -- Menu header text
                ['processormethheadericon'] = 'fa-solid fa-user-ninja', -- Menu header icon
                ['processingmethheader'] = 'Exchange Materials', -- Menu header   
                ['processingmethheadertext'] = 'Required:</p>'..Config.Processing.Meth.Meth.RequiredItems['1'].amount..'x '..Config.Processing.Meth.Meth.RequiredItems['1'].label..'</p>'..Config.Processing.Meth.Meth.RequiredItems['2'].amount..'x '..Config.Processing.Meth.Meth.RequiredItems['2'].label..'</p>'..Config.Processing.Meth.Meth.RequiredItems['3'].amount..'x '..Config.Processing.Meth.Meth.RequiredItems['3'].label..'</p>'..Config.Processing.Meth.Meth.RequiredItems['4'].amount..'x '..Config.Processing.Meth.Meth.RequiredItems['4'].label..'', -- Menu header
                ['processingmethheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['processorclosed'] = 'Man we dont need anything right now.. come back later between '..Config.Processing.Meth.Meth.StartTime..' and '..Config.Processing.Meth.Meth.EndTime..' ..', -- Notification
                ['enoughmeth1'] = 'Looks like you dont have enough '..Config.Processing.Meth.Meth.RequiredItems['1'].label..'.. check your pockets..', -- Notification
                ['nometh1'] = 'Looks like you dont have any '..Config.Processing.Meth.Meth.RequiredItems['1'].label..'..', -- Notification
                ['enoughmeth2'] = 'Looks like you dont have enough '..Config.Processing.Meth.Meth.RequiredItems['2'].label..'.. check your pockets..', -- Notification
                ['nometh2'] = 'Looks like you dont have any '..Config.Processing.Meth.Meth.RequiredItems['2'].label..'..', -- Notification
                ['enoughmeth3'] = 'Looks like you dont have enough '..Config.Processing.Meth.Meth.RequiredItems['3'].label..'.. check your pockets..', -- Notification
                ['nometh3'] = 'Looks like you dont have any '..Config.Processing.Meth.Meth.RequiredItems['3'].label..'..', -- Notification
                ['enoughmeth4'] = 'Looks like you dont have enough '..Config.Processing.Meth.Meth.RequiredItems['4'].label..'.. check your pockets..', -- Notification
                ['nometh4'] = 'Looks like you dont have any '..Config.Processing.Meth.Meth.RequiredItems['4'].label..'..', -- Notification
                ['processmeth'] = 'Exchanging Meth Materials..', -- Progressbar
            },  
        },
    },
    DrugCutting = {
        Shared = {
            ['noscales'] = 'How are you going to weigh out drugs without a '..Config.DrugCutting.Shared.Scales['1'].label..'..', -- Notification
            ['cuttingheader'] = 'Cutting Kit', -- Menu header
            ['cuttingheadertext'] = 'Cut your weight into something usable!', -- Menu header text
            ['cuttingheadericon'] = 'fa-solid fa-user-ninja', -- Menu header icon
            ['nocutkit'] = 'Looks like your missing a '..Config.DrugCutting.Shared.CuttingKit['1'].label..' check your pockets.', -- Notification
        },
        Meth = {
            Meth = {
                ['cutmethheader'] = 'Cut Meth', -- Menu header
                ['cutmethheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['cutmethheadertext'] = 'Required:</p>1x '..Config.DrugCutting.Shared.Scales['1'].label..'</p>'..Config.DrugCutting.Meth.Meth.RequiredItems['1'].amount..'x '..Config.DrugCutting.Meth.Meth.RequiredItems['1'].label..'</p>'..Config.DrugCutting.Meth.Meth.RequiredItems['2'].amount..'x '..Config.DrugCutting.Meth.Meth.RequiredItems['2'].label..'', -- Menu header text        
                ['cutenoughmeth1'] = 'Looks like you dont have enough '..Config.DrugCutting.Meth.Meth.RequiredItems['1'].label..'.. check your pockets..', -- Notification
                ['cutnometh1'] = 'Looks like you dont have any '..Config.DrugCutting.Meth.Meth.RequiredItems['1'].label..'..', -- Notification
                ['cutenoughmeth2'] = 'Looks like you dont have enough '..Config.DrugCutting.Meth.Meth.RequiredItems['2'].label..'.. check your pockets..', -- Notification
                ['cutnometh2'] = 'Looks like you dont have any '..Config.DrugCutting.Meth.Meth.RequiredItems['2'].label..'..', -- Notification
                ['cutmethxp'] = 'You sucessfully cut some '..Config.DrugCutting.Meth.Meth.ReturnItem['1'].label..' and gained '..Config.XP.XPReward..' drug experience!', -- Notification
                ['cutmethnoxp'] = 'You sucessfully cut some '..Config.DrugCutting.Meth.Meth.ReturnItem['1'].label..'!', -- Notification
                ['nomethounce'] = 'You cant cut meth without '..Config.DrugCutting.Meth.Meth.RequiredItems['1'].label..'..', -- Notification
                ['cutmeth'] = 'Cutting Meth..', -- Progressbar
            },
        },
        Cocaine = {
            Cocaine = {
                ['cutcokeheader'] = 'Cut Cocaine', -- ONLY NEED IF USING **BOII-COCAINE** FOLLOW INSTRUCTIONS WITHIN README
                ['cutcokeheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['nocokeounce'] = 'You cant cut cocaine without '..Config.DrugCutting.Shared.Cocaine.Cocaine.RequiredItems['1'].label..'..', -- ONLY NEED IF USING **BOII-HEROIN** FOLLOW INSTRUCTIONS WITHIN README

            },
            Crack = {
                ['cutcrackheader'] = 'Cut Crack', -- ONLY NEED IF USING **BOII-COCAINE** FOLLOW INSTRUCTIONS WITHIN README
                ['cutcrackheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['nocrackounce'] = 'You cant cut crack without '..Config.DrugCutting.Shared.Cocaine.Crack.RequiredItems['1'].label..'..', -- ONLY NEED IF USING **BOII-HEROIN** FOLLOW INSTRUCTIONS WITHIN README
            },
        },
        Heroin = {
            Morphine = {
                ['cutmorphineheader'] = 'Cut Morphine', -- ONLY NEED IF USING **BOII-HEROIN** FOLLOW INSTRUCTIONS WITHIN README
                ['cutmorphineheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['nomorphounce'] = 'You cant cut morphine without '..Config.DrugCutting.Shared.Heroin.Morphine.RequiredItems['1'].label..'..', -- ONLY NEED IF USING **BOII-HEROIN** FOLLOW INSTRUCTIONS WITHIN README

            },
            Heroin = {
                ['cutheroinheader'] = 'Cut Heroin', -- ONLY NEED IF USING **BOII-HEROIN** FOLLOW INSTRUCTIONS WITHIN README
                ['cutheroinheadericon'] = 'fa-solid fa-cannabis', -- Menu header icon
                ['noheroinounce'] = 'You cant cut heroin without '..Config.DrugCutting.Shared.Heroin.Heroin.RequiredItems['1'].label..'..', -- ONLY NEED IF USING **BOII-HEROIN** FOLLOW INSTRUCTIONS WITHIN README
            },
        },
    },
    TakeDrugs = {
        Meth = {
            Meth = {
                ['nomethitem'] = 'You need a '..Config.TakeDrugs.Meth.Meth.TakeItem['1'].label..' to take '..Config.TakeDrugs.Meth.Meth.DrugItem['1'].label..'', -- Notification
                ['takemeth'] = 'Smoking Meth..', -- Progressbar
            },
        },
    },
    Stores = {
        Meth = {
            BlackMarket = {
                ['blackmarketheader'] = 'Black Market', -- Menu header   
                ['blackmarketheadertext'] = 'Check what items are in stock here.', -- Menu header
                ['blackmarketheadericon'] = 'fa-solid fa-cash-register', -- Menu header icon
                ['blackmarketstorelabel'] = 'Black Market', -- Store header
            },
        },       
    },
}