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
    RemoveStressEvent = 'hud:server:RelieveStress', -- Event to remove stress from player. Default; 'hud:server:RelieveStress'
}
Config.Blips = { -- Blips information
	--{title="Smoke on the Water", colour=25, id=496, x = -1173.55, y = -1574.21, z = 5.38}, -- Blip info for smoke on the water
}    
Config.Plants = {} -- Plants array
Config.DegradeTimer = math.random(20000, 25000) -- Plant tick timer
Config.MaxPlantCount = 6 -- Maximum amount of plants a player can plant, i suggest keeping this low for ms reasons
Config.StartingThirst = 90.0 -- Starting thirst amount for plants
Config.StartingHunger = 90.0 -- Starting hunger amount for plants
Config.HungerIncrease = math.random(25,35) -- Amount to replensish on feeding plants
Config.ThirstIncrease = math.random(25,35) -- Amount to replensish on feeding plants
Config.Degrade = {min = 1, max = 15} -- Amount to degrade on low food and water 
Config.QualityDegrade = {min = 15, max = 20} -- Amount to degrade quality this should be relatively high
Config.GrowthIncrease = {min = 3, max = 10} -- Amount to increase plant growth / 10 so 100 = 10% 1000 = 100%
Config.PlantingTime = math.random(2500,5000) -- Time in (ms) to plant seeds
Config.FeedingTime = math.random(2500,5000) -- Time in (ms) to feed plants 
Config.WateringTime = math.random(2500,5000) -- Time in (ms) to water plants
Config.HarvestTime = math.random(2500,5000) -- Time in (ms) to harvest plants
Config.DestroyTime = math.random(2500,5000) -- Time in (ms) to destroy plants
Config.WeedTrimTime = math.random(2500,5000) -- Time in (ms) to trim weed buds into bags
Config.JointRollTime = math.random(2500,5000) -- Time in (ms) to roll joints
Config.SmokeJointTime = math.random(3000,5000) -- Time in (ms) seconds to smoke joints
Config.SmokeJointItem = 'lighter' -- Item required to smoke joints
Config.SkunkStressAmount = math.random(4,9) -- Skunk joints stress amount
Config.SkunkArmourAmount = math.random(4,9) -- Skunk joints armour amount
Config.KushStressAmount = math.random(6,11) -- OG-Kush joints stress amount
Config.KushArmourAmount = math.random(6,11) -- OG-Kush joints armour amount
Config.WidowStressAmount = math.random(8,13) -- White widow joints stress amount
Config.WidowArmourAmount = math.random(8,13) -- White widow joints armour amount
Config.AK47StressAmount = math.random(10,15) -- AK47 joints stress amount
Config.AK47ArmourAmount = math.random(10,15) -- AK47 joints armour amount
Config.AmnesiaStressAmount = math.random(15,20) -- Amnesia joints stress amount
Config.AmnesiaArmourAmount = math.random(15,20) -- Amenesia joints armour amount
Config.PurpleStressAmount = math.random(20,25) -- Purplehaze joints stress amount
Config.PurpleArmourAmount = math.random(20,25) -- Purplehaze joints armour amount
Config.WeedShopPrice = { -- Prices at smoke on water store, adjust your drug dealer prices in boii-drugs so people cannot meta this.
		["weed_skunk"] = 5,
        ["weed_og-kush"] = 8,
        ["weed_white-widow"] = 11,
        ["weed_ak47"] = 14,
		["weed_amnesia"] = 17,
        ["weed_purple-haze"] = 20,     
}
Config.SmokeShopItems = { -- Items available for sale in smoke on the water                 
    [1] = { name = "empty_weed_bag",            price = 2,    amount = 1000, info = {}, type = "item", slot = 1 },
    [2] = { name = "drug_scales",               price = 1200, amount = 100,  info = {}, type = "item", slot = 2 },
    [3] = { name = "rolling_paper",             price = 1,    amount = 2000, info = {}, type = "item", slot = 3 },
    [4] = { name = "lighter",                   price = 2,    amount = 1000, info = {}, type = "item", slot = 4 },
    [5] = { name = "trowel",                    price = 200,  amount = 1000, info = {}, type = "item", slot = 5 },
    [6] = { name = "drug_cuttingkit",           price = 1000, amount = 1000, info = {}, type = "item", slot = 6 },
    [7] = { name = "weed_water",                price = 2,    amount = 1000, info = {}, type = "item", slot = 7 },
    [8] = { name = "weed_nutrition",            price = 100,  amount = 1000, info = {}, type = "item", slot = 8 },
    [9] = { name = "weed_pot",                  price = 10,   amount = 1000, info = {}, type = "item", slot = 9 },
    [10] = { name = "drug_shears",              price = 100,  amount = 1000, info = {}, type = "item", slot = 10 },
    [11] = { name = "drug_grinder",             price = 50,   amount = 1000, info = {}, type = "item", slot = 11 },
    [12] = { name = "weed_skunk_seed",                    price = 250,   amount = 1000, info = {}, type = "item", slot = 12 },
    [13] = { name = "weed_og-kush_seed",                  price = 250,   amount = 1000, info = {}, type = "item", slot = 13 },
    [14] = { name = "weed_white-widow_seed",              price = 250,   amount = 1000, info = {}, type = "item", slot = 14 },
    [15] = { name = "weed_ak47_seed",                     price = 250,   amount = 1000, info = {}, type = "item", slot = 15 },
    [16] = { name = "weed_amnesia_seed",                  price = 250,   amount = 1000, info = {}, type = "item", slot = 16 },
    [17] = { name = "weed_purple-haze_seed",              price = 250,   amount = 1000, info = {}, type = "item", slot = 17 },
}	
Config.WeedStages = { -- Plant prop growth stages
    [1] = "bkr_prop_weed_01_small_01c",
    [2] = "bkr_prop_weed_med_01a",
    [3] = "bkr_prop_weed_lrg_01a",
}
Config.SeedTypes = { -- Seed types you can add more seeds here if you want just make sure to add the items into your city
    {type = "skunk",        rewardMin = 1, rewardMax = 3, item = 'weed_skunk_crop',         label = 'Skunk Crop'},
    {type = "og-kush",      rewardMin = 1, rewardMax = 3, item = 'weed_og-kush_crop',       label = 'OG-Kush Crop'},
    {type = "white-widow",  rewardMin = 1, rewardMax = 3, item = 'weed_white-widow_crop',   label = 'White Widow Crop'},
    {type = "ak47",         rewardMin = 1, rewardMax = 3, item = 'weed_ak47_crop',          label = 'AK47 Crop'},
	{type = "amnesia",      rewardMin = 1, rewardMax = 2, item = 'weed_amnesia_crop',       label = 'Amnesia Crop'},
	{type = "purple-haze",  rewardMin = 1, rewardMax = 2, item = 'weed_purple-haze_crop',   label = 'Purple Haze Crop'},
}
Config.Lang = { -- Notifications and progressbar text change here to what you like
    -- General notifications and progressbar
    ['noinvent'] = 'Looks like your pockets are full..', --Notification

    -- Plant notifications and progressbar
    ['nopot'] = 'You cant plant seeds without a pot..', -- Notification
    ['tooclose'] = 'You are too close to another plant..', -- Notification
	['destroyedplant'] = 'You successfully destroyed a plant!', -- Notification
    ['feedingplant'] = 'Feeding Plant..', -- Progressbar
    ['waterplant'] = 'Watering Plant..', -- Progressbar
    ['harvestplant'] = 'Harvesting Plant..', -- Progressbar
    ['destroyplant'] = 'Destroying Plant..', -- Progressbar
    ['plantingseed'] = 'Planting Seed..', -- Progressbar

    -- Smoke joints notifications and progressbar
    ['nolighter'] = 'How are you going to smoke without a lighter..', -- Notification
    ['smokeskunk'] = 'Smoking Skunk..', -- Progressbar
    ['smokekush'] = 'Smoking OG Kush..', -- Progressbar
    ['smokewidow'] = 'Smoking White Widow..', -- Progressbar
    ['smokeak47'] = 'Smoking AK47..', -- Progressbar
    ['smokeamnesia'] = 'Smoking Amnesia..', -- Progressbar
    ['smokepurple'] = 'Smoking Purple Haze..', -- Progressbar

    -- Rolling joints and selling notifications and progressbar
    ['enoughpapers'] = 'You need at least 2 rolling papers..', -- Notification
    ['anypapers'] = 'You dont have any rolling papers..', -- Notification
    ['enoughskunk'] = 'You dont have enough bags of skunk..', -- Notification
    ['anyskunk'] = 'You dont have any bags of skunk..', -- Notification
    ['enoughkush'] = 'You dont have enough bags of og-kush..', -- Notification
    ['anykush'] = 'You dont have any bags of og-kush..', -- Notification
    ['enoughwidow'] = 'You dont have enough bags of white widow..', -- Notification
    ['anywidow'] = 'You dont have any bags of white widow..', -- Notification
    ['enoughpurple'] = 'You dont have enough bags of purple haze..', -- Notification
    ['anypurple'] = 'You dont have any bags of purple haze..', -- Notification
    ['rolledjoints'] = 'You rolled a couple of joints!', -- Notificaiotn
    ['rollingjoint'] = 'Rolling Joints..', -- Progressbar

    -- Trimming notifications and progressbar
    ['enoughbaggies'] = 'You need at least 14 drug bags..', -- Notification
    ['anybaggies'] = 'You dont have any drug bags..', -- Notification
    ['enoughskunkcrop'] = 'You dont have enough skunk buds..', -- Notification
    ['anyskunkcrop'] = 'You dont have any skunk buds..', -- Notification
    ['enoughkushcrop'] = 'You dont have enough skunk buds..', -- Notification
    ['anykushcrop'] = 'You dont have any og-kush buds..', -- Notification
    ['enoughwidowcrop'] = 'You dont have enough white widow buds..', -- Notification
    ['anywidowcrop'] = 'You dont have any white widow buds..', -- Notification
    ['enoughpurplecrop'] = 'You dont have purple haze buds..', -- Notification
    ['anypurplecrop'] = 'You dont have any purple haze buds..', -- Notification
    ['trimmedweed'] = 'You successfully trimmed some weed!', -- Notification
    ['trimmingweed'] = 'Trimming Weed..', -- Progressbar
}