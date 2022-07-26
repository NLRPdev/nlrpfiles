-------------------------------
---------- CASE#2506 ----------
-------------------------------

Config = {}
-- Core info settings you can ignore these if you have not edited any core functions in your city
Config.Core = 'QBCore' -- The name of your core. Default; QBCore
Config.CoreFolder = 'qb-core' -- The name of your core folder. Default; qb-core
Config.TargetName = 'qb-target' -- The name of your third eye targeting. Default; qb-target
Config.MenuName = 'qb-menu' -- The name of your menu. Default; qb-target
Config.InputName = 'qb-input' -- The name of your input menu for billing. Default; qb-input
Config.DutyEvent = 'QBCore:ToggleDuty' -- The name of your on duty event default; QBCore:ToggleDuty
Config.FuelEvent = 'LegacyFuel' -- The name of your fuel event. Default; LegacyFuel
Config.ItemCheckEvent = 'QBCore:HasItem' -- The name of your item check event. Default; 'QBCore:HasItem'
Config.RemoveItemEvent = 'QBCore:Server:RemoveItem' -- The name of your item check event. Default; 'QBCore:Server:AddItem'
Config.AddItemEvent = 'QBCore:Server:AddItem' -- The name of your item check event. Default; 'QBCore:Server:AddItem'
Config.MetaDataEvent = 'QBCore:Server:SetMetaData' -- The name of your set metadata event. Default; 'QBCore:Server:SetMetaData'
Config.PhoneEvent = 'qb-phone:RefreshPhone' -- The name of your phone event this is needed for billing. Default; 'qb-phone:RefreshPhone'
Config.ClothingEvent = 'qb-clothing:client:openOutfitMenu' -- The name of your clothing event this is needed to open outfit menu. Default; 'qb-clothing:client:OpenOutfitMenu'
Config.RemoveStress = 'hud:server:RelieveStress' -- Event to remove stress from player. Default; 'hud:server:RelieveStress'
Config.EvidenceEvent = 'evidence:client:SetStatus' -- Event to set drunk evidence status for police. Default; 'evidence:client:SetStatus'
Config.VehicleKeysEvent = 'vehiclekeys:client:SetOwner' -- Event to set vehicle keys. Default; 'vehiclekeys:client:SetOwner'
-- Blips
Config.Blips = {
	{title="8-Ball Haven", colour=5, id=536, x = -1596.43, y = -991.23, z = 48.66},
}
-- Job & item settings
Config.JobName = 'billiards' -- Job name in your shared.lua
Config.SnakeFoodItem = 'livemouse' -- Item required to feed snake to remove stress
-- Timers
Config.PullPintTime = math.random(5500,7500) -- Time in (ms) to pull pints
Config.CocktailTime = math.random(6500,9500) -- Time in (ms) to mix cocktails
Config.PullLiquorTime = math.random(5500,7500) -- Time in (ms) to pull pints
Config.HotDrinksTime = math.random(5500,7500) -- Time in (ms) to pour hot drinks
Config.MicrowaveTime = math.random(5500,7500) -- Time in (ms) to microwave food
Config.SnakeFoodTime = math.random(5000,7500) -- Time in (ms) collect snake food
Config.SnakeFeedTime = math.random(5000,7500) -- Time in (ms) feed snake
Config.EatPieTime = math.random(3000,5500) -- Time in (ms) to eat pies
Config.EatBurgerTime = math.random(3000,5500) -- Time in (ms) to eat burgers
Config.DrinkBeerTime = math.random(3000,5500) -- Time in (ms) to drink pints of beer
Config.DrinkLiquorTime = math.random(3000,5500) -- Time in (ms) to drink glasses of liquor
Config.DrinkCocktailTime = math.random(3000,5500) -- Time in (ms) to drink cocktails
Config.DrinkHotTime = math.random(3000,5500) -- Time in (ms) to drink hot drinks
Config.DrinkColdTime = math.random(3000,5500) -- Time in (ms) to drink hot drinks
Config.LightDrunkTime = 30 -- Time in (seconds) to stay drunk this is *10000 client side so 30 = 5 minutes, 60  = 10 minutes
Config.HeavyDrunkTime = 60 -- Time in (seconds) to stay drunk this is *10000 client side so 30 = 5 minutes, 60  = 10 minutes
-- Effects
Config.LightBeerAmount = 3 -- Amount of pints required before light drunk effects +1 so 4 pints to light drunk
Config.HeavyBeerAmount = 6  -- Amount of pints required before heavy drunk effects +1 so 7 pints to heavy drunk
Config.BeerStress = math.random(8,13) -- Amount of stress relived by drinking beer
Config.LightLiquorAmount = 2 -- Amount of pints required before light drunk effects +1 so 3 glasses of liquor to light drunk
Config.HeavyLiquorAmount = 5  -- Amount of pints required before heavy drunk effects +1 so 6 glasses of liquor to heavy drunk
Config.LiquorStress = math.random(9,15) -- Amount of stress relived by drinking liquor
Config.LightCocktailAmount = 1 -- Amount of pints required before light drunk effects +1 so 2 glasses of liquor to light drunk
Config.HeavyCocktailAmount = 3  -- Amount of pints required before heavy drunk effects +1 so 4 glasses of liquor to heavy drunk
Config.CocktailStress = math.random(13,22) -- Amount of stress relived by drinking liquor
Config.HotDrinkStress = math.random(8,11) -- Amount of stress relived by drunking coffee or tea
Config.ColdDrinkStress = math.random(8,11) -- Amount of stress relived by drinking kurkakola or sprunk
Config.PieStress = math.random(3,7) -- Amount of stress relived by eating pies
Config.BurgerStress = math.random(8,11) -- Amount of stress relived by eating burgers
Config.SnakeStress = math.random(1,5) -- Amount of stress relived by feeding snake
-- Location settings
Config.Duty = vector3(-1582.26, -986.95, 13.08) -- On duty location change heading in client
Config.Pay = vector3(-1586.82, -995.55, -13.08) -- Payment location change heading in client
Config.Store = vector3(-1585.51, -994.75, 13.08) -- Job store location change heading in client
Config.Pumps = vector3(-1583.47, -990.78, 13.08) -- Beer pumps location 1 change heading in client
Config.Pumps2 = vector3(-1584.25, -991.75, 13.08) -- Beer pumps location 2 change heading in client
Config.Pumps3 = vector3(-1585.04, -992.82, 13.08) -- Beer pumps location 3 change heading in client
Config.Liquor = vector3(-1583.8, -992.6, 13.08) -- Liqour pump location change heading in client
Config.Cocktails = vector3(-1584.45, -993.47, 13.08) -- Cocktails location change heading in client
Config.HotDrinks = vector3(-1583.32, -992.1, 13.08) -- Hot drinks location change heading in client
Config.Microwave = vector3(-1582.93, -991.6, 13.08) -- Microwave location change heading in client
Config.Outfits = vector3(-1581.88, -984.58, 13.08) -- Wardrobe location change heading in client
Config.Storage = vector3(-1574.71, -982.42, 13.08) -- Storage location change heading in client
Config.Snake = vector3(-1581.78, -980.52, 13.11) -- Snake location change heading in client
-- Cocktails settings
Config.LiquorAmount = 1 -- Amount of liquor to be removed when mixing cocktails
Config.IngredientAmount = 1 -- Amount of liquor to be removed when mixing cocktails
Config.IngredientAmount2 = 2 -- Amount of liquor to be removed when mixing cocktails
Config.IngredientAmount3 = 3 -- Amount of liquor to be removed when mixing cocktails
-- Vehicles
Config.Garage = vector3(-1592.13, -1009.59, 13.02) -- Vehicle polyzone to spawn/return vehicles adjust heading client side
Config.MoneyType = 'cash' -- Money type used for vehicle deposits
Config.CompanyVehicle = 'speedo' -- White widow company vehicle use any vehicle you want here
Config.VehicleDeposit = 100 -- Price to take out company van will return 50%
Config.VehicleSpawn = vector4(-1591.83, -1010.04, 13.02, 255.94) -- Vehicle spawn location
Config.VehicleSpawnHeading = 255.94 -- Vehicle spawn heading
-- Consumeables
Config.Alcohol = {
    ['pint_ambeer'] = math.random(23,42),
    ['pint_logger'] = math.random(23,42),
    ['pint_piswasser'] = math.random(23,42),
    ['pint_dusche'] = math.random(23,42),
    ['glass_whiskey'] = math.random(30, 55),
	['glass_rum'] = math.random(30, 55),
	['glass_vodka'] = math.random(30, 55),
    ['glass_whiskeycoke'] = math.random(30, 55),
    ['glass_rumlemon'] = math.random(30, 55),
	['glass_vodkalemon'] = math.random(30, 55),
	['irishcoffee'] = math.random(35, 60),
    ['whiskeysour'] = math.random(40, 70),
    ['whiskeysmash'] = math.random(40, 70),
    ['bloodandsand'] = math.random(40, 70),
    ['pinacolada'] = math.random(40, 70),
    ['zombie'] = math.random(40, 70),
    ['maitai'] = math.random(40, 70),
    ['appletini'] = math.random(40, 70),
    ['cosmopolitan'] = math.random(40, 70),
    ['bloodymary'] = math.random(40, 70),
}
Config.Food = {
    ["cookedcheesepie"] = math.random(20, 35),
	["cookedsteakpie"] = math.random(20, 35),
	["cookedmeatpie"] = math.random(20, 35),
	["cookedchickenpie"] = math.random(20, 25),
    ["cookedmwburger"] = math.random(25, 35),
    ["cookedmwcburger"] = math.random(25, 35),
    ["cookedmwbcburger"] = math.random(25, 35),
}
Config.Drink = {
    ['kurkakola'] = math.random(15,23),
    ['sprunk'] = math.random(15,23),
    ['cuptea'] = math.random(30,43),
    ['cupcoffee'] = math.random(30,43),
}
-- Shops
Config.ShopItems = {
    [1] = { name = 'pintglass',     price = 1,    amount = 100, info = {}, type = "item", slot = 1 }, -- Required
    [2] = { name = 'cocktailglass', price = 1,    amount = 100, info = {}, type = "item", slot = 2 }, -- Required
    [3] = { name = 'smallglass',    price = 1,    amount = 100, info = {}, type = "item", slot = 3 }, -- Required
    [4] = { name = 'wineglass',     price = 1,    amount = 100, info = {}, type = "item", slot = 4 }, -- Required
    [5] = { name = 'emptycup',      price = 1,    amount = 100, info = {}, type = "item", slot = 5 }, -- Required
    [6] = { name = 'kurkakola',     price = 1,    amount = 100, info = {}, type = "item", slot = 6 }, -- Required; QBCore base item you should have this already
    [7] = { name = 'sprunk',        price = 1,    amount = 100, info = {}, type = "item", slot = 7 }, -- Required
    [8] = { name = 'orange',        price = 1,    amount = 100, info = {}, type = "item", slot = 8 }, -- Required
    [9] = { name = 'tomato',        price = 1,    amount = 100, info = {}, type = "item", slot = 9 }, -- Required
    [10] = { name = 'apple',        price = 1,    amount = 100, info = {}, type = "item", slot = 10 }, -- Required
    [11] = { name = 'cherry',       price = 1,    amount = 100, info = {}, type = "item", slot = 11 }, -- Required
    [12] = { name = 'lime',         price = 1,    amount = 100, info = {}, type = "item", slot = 12 }, -- Required
    [13] = { name = 'pineapple',    price = 1,    amount = 100, info = {}, type = "item", slot = 13 }, -- Required
    [14] = { name = 'coconut',      price = 1,    amount = 100, info = {}, type = "item", slot = 14 }, -- Required
    [15] = { name = 'lemon',        price = 1,    amount = 100, info = {}, type = "item", slot = 15 }, -- Required
    [16] = { name = 'cranberry',    price = 1,    amount = 100, info = {}, type = "item", slot = 16 }, -- Required
    [17] = { name = 'steakpie',     price = 1,    amount = 100, info = {}, type = "item", slot = 17 }, -- Required
    [18] = { name = 'cheesepie',    price = 1,    amount = 100, info = {}, type = "item", slot = 18 }, -- Required
    [19] = { name = 'meatpie',      price = 1,    amount = 100, info = {}, type = "item", slot = 19 }, -- Required
    [20] = { name = 'chickenpie',   price = 1,    amount = 100, info = {}, type = "item", slot = 20 }, -- Required
    [21] = { name = 'mwburger',     price = 1,    amount = 100, info = {}, type = "item", slot = 21 }, -- Required
    [22] = { name = 'mwcburger',    price = 1,    amount = 100, info = {}, type = "item", slot = 22 }, -- Required
    [23] = { name = 'mwbcburger',   price = 1,    amount = 100, info = {}, type = "item", slot = 23 }, -- Required
}
-- Language settings
Config.Lang = {    
    -- Third eye
    ['dutyicon'] = 'fas fa-clipboard', -- Icon used by qb-target for on duty location visit; https://fontawesome.com to change
    ['dutylabel'] = 'Clock In/Out', -- Label used by qb-target for on duty location
    ['payicon'] = 'fas fa-cash-register', -- Icon used by qb-target for payment locations visit; https://fontawesome.com to change
    ['paylabel'] = 'Charge Customer', -- Label used by qb-target for payment locations
    ['storageicon'] = 'fas fa-box', -- Icon used by qb-target for storage locations visit; https://fontawesome.com to change
    ['storagelabel'] = 'Open Storage', -- Label used by qb-target for storage locations
    ['shopicon'] = 'fas fa-shopping-basket', -- Icon used by qb-target for shop locations visit; https://fontawesome.com to change
    ['shoplabel'] = 'Purchase Items', -- Label used by qb-target for storage locations
    ['outfiticon'] = 'fas fa-shirt', -- Icon used by qb-target for wardrobe location visit; https://fontawesome.com to change
    ['outfitlabel'] = 'Change Clothes', -- Label used by qb-target for wardrobe location
    ['pumpicon'] = 'fas fa-beer', -- Icon used by qb-target for pump locations visit; https://fontawesome.com to change
    ['pumplabel'] = 'Pull A Pint', -- Label used by qb-target for pump locations
    ['cocktailsicon'] = 'fas fa-cocktail', -- Icon used by qb-target for cocktail location visit; https://fontawesome.com to change
    ['cocktailslabel'] = 'Mix Cocktails', -- Label used by qb-target for cocktail location    
    ['liquoricon'] = 'fas fa-glass-whiskey', -- Icon used by qb-target for liquor location visit; https://fontawesome.com to change
    ['liquorlabel'] = 'Pull Hard Liquor', -- Label used by qb-target for liquor location    
    ['hotdrinksicon'] = 'fas fa-coffee', -- Icon used by qb-target for hot drinks location visit; https://fontawesome.com to change
    ['hotdrinkslabel'] = 'Make A Hot Drink', -- Label used by qb-target hot drinks location 
    ['microwaveicon'] = 'fas fa-utensils', -- Icon used by qb-target for microwave location visit; https://fontawesome.com to change
    ['microwavelabel'] = 'Cook Microwave Food', -- Label used by qb-target for microwave location  
    ['outfiticon'] = 'fas fa-shirt', -- Icon used by qb-target for microwave location visit; https://fontawesome.com to change
    ['outfitlabel'] = 'Change Clothes', -- Label used by qb-target for microwave location 
    ['snakeicon'] = 'fas fa-paw', -- Icon used by qb-target for snake location visit; https://fontawesome.com to change
    ['snakelabel'] = 'Feed The Snake', -- Label used by qb-target for snake location
    ['garageicon'] = 'fas fa-car', -- Icon used by qb-target for garage location visit; https://fontawesome.com to change
    ['garagelabel'] = 'Company Vehicle', -- Label used by qb-target for garage location  
    -- Duty
    ['dutymenuheader'] = 'Clock In/Out', -- Menu header
    ['dutymenuheadertext'] = 'Dont forget to clock in and out!', -- Menu header text
    ['dutytoggle'] = '• Clock In/Out', -- Menu header
    -- Stores
    ['jobstorelabel'] = 'Billards Bar Supplies', -- Label used by inventory for store name
    -- Billing
    ['paymenuheader'] = 'Billiards Bar', -- Menu header
    ['paymenuheadertext'] = 'Charge Customer', -- Menu header text
    ['invoicesent'] = 'Invoice sent successfully!', -- Notification
    ['invoicereceived'] = 'Invoice received!', -- Notification
    ['minamount'] = 'You cant charge someone nothing idiot..', -- Notification
    ['billself'] = 'You cant bill yourself idiot..', -- Notification
    ['billoffline'] = 'You cant bill someone whos not in city idiot..', -- Notification
    ['noaccess'] = 'You are not authorised to make sales..', -- Notification
    ['paytext'] = 'paypal id', -- Input text when charging customers
    ['payamount'] = '$ amount', -- Input text when charging customers
    -- Pumps 
    ['pumpmenuheader'] = 'Pull a Pint', -- Menu header
    ['pumpmenuheadertext'] = 'Required:</p>1x Pint Glass', -- Menu header text
    ['amheader'] = 'AM Beer', -- Menu header
    ['amheadertext'] = 'Mornings golden shower.', -- Menu header text
    ['pisheader'] = 'Piswasser', -- Menu header
    ['pisheadertext'] = 'Youre in for a good time.', -- Menu header text
    ['loggerheader'] = 'Logger', -- Menu header
    ['loggerheadertext'] = 'Best serve with your sister.', -- Menu header text
    ['duscheheader'] = 'Dusche Gold', -- Menu header
    ['duscheheadertext'] = 'Let it pour.', -- Menu header text
    ['pulledpint'] = 'You successfully pulled a pint!', -- Notification
    ['nopintglass'] = 'What are you planning to put the beer in dumbass..', -- Notification
    ['pullingpint'] = 'Pulling Pint..', -- Progressbar
    -- Cocktails
    ['cocktailsmenuheader'] = 'Cocktail Station', -- Menu header
    ['cocktailsmenuheadertext'] = 'Everyone loves a good cocktail!', -- Menu header text
    ['cocktailswhiskeyheader'] = 'Whiskey Cocktails', -- Menu header
    ['cocktailswhiskeyheadertext'] = 'View available recipes!', -- Menu header text
    ['cocktailsrumheader'] = 'Rum Cocktails', -- Menu header
    ['cocktailsrumheadertext'] = 'View available recipes!', -- Menu header text
    ['cocktailsvodkaheader'] = 'Vodka Cocktails', -- Menu header
    ['cocktailsvodkaheadertext'] = 'View available recipes!', -- Menu header text
    ['whiskeysourheader'] = 'Whiskey Sour', -- Menu header
    ['whiskeysourheadertext'] = 'Required:</p>1x Cocktail Glass</p>'..Config.LiquorAmount..'x Glass of Whiskey</p>'..Config.IngredientAmount..'x Lemon</p>'..Config.IngredientAmount..'x Orange', -- Menu header text
    ['whiskeysmashheader'] = 'Whiskey Smash', -- Menu header
    ['whiskeysmashheadertext'] = 'Required:</p>1x Cocktail Glass</p>'..Config.LiquorAmount..'x Glass of Whiskey</p>'..Config.IngredientAmount..'x Lemon</p>'..Config.IngredientAmount..'x Apple', -- Menu header text
    ['bloodsandheader'] = 'Blood and Sand', -- Menu header
    ['bloodsandheadertext'] = 'Required:</p>1x Cocktail Glass</p>'..Config.LiquorAmount..'x Glass of Whiskey</p>'..Config.IngredientAmount2..'x Cherries</p>'..Config.IngredientAmount..'x Orange', -- Menu header text
    ['pinacoladaheader'] = 'Pina Colada', -- Menu header
    ['pinacoladaheadertext'] = 'Required:</p>1x Cocktail Glass</p>'..Config.LiquorAmount..'x Glass of Rum</p>'..Config.IngredientAmount..'x Pineapple</p>'..Config.IngredientAmount..'x Coconut', -- Menu header text
    ['zombieheader'] = 'Zombie', -- Menu header
    ['zombieheadertext'] = 'Required:</p>1x Cocktail Glass</p>'..Config.LiquorAmount..'x Glass of Rum</p>'..Config.IngredientAmount..'x Pineapple</p>'..Config.IngredientAmount..'x Orange', -- Menu header text
    ['maitaiheader'] = 'Mai Tai', -- Menu header
    ['maitaiheadertext'] = 'Required:</p>1x Cocktail Glass</p>'..Config.LiquorAmount..'x Glass of Rum</p>'..Config.IngredientAmount..'x Lime</p>'..Config.IngredientAmount..'x Orange', -- Menu header text
    ['appletiniheader'] = 'Appletini', -- Menu header
    ['appletiniheadertext'] = 'Required:</p>1x Cocktail Glass</p>'..Config.LiquorAmount..'x Glass of Vodka</p>'..Config.IngredientAmount..'x Lemon</p>'..Config.IngredientAmount..'x Apple', -- Menu header text
    ['cosmopolitanheader'] = 'Cosmopolitan', -- Menu header
    ['cosmopolitanheadertext'] = 'Required:</p>1x Cocktail Glass</p>'..Config.LiquorAmount..'x Glass of Vodka</p>'..Config.IngredientAmount..'x Lime</p>'..Config.IngredientAmount3..'x Cranberries', -- Menu header text
    ['bloodymaryheader'] = 'Bloody Mary', -- Menu header
    ['bloodymaryheadertext'] = 'Required:</p>1x Cocktail Glass</p>'..Config.LiquorAmount..'x Glass of Vodka</p>'..Config.IngredientAmount..'x Lemon</p>'..Config.IngredientAmount2..'x Tomatoes', -- Menu header text
    ['enoughwhiskey'] = 'Looks like you dont have enough whiskey..', -- Notification
    ['nowhiskey'] = 'Looks like you dont have any whiskey..', -- Notification
    ['enoughrum'] = 'Looks like you dont have enough rum..', -- Notification
    ['norum'] = 'Looks like you dont have any rum..', -- Notification
    ['enoughvodka'] = 'Looks like you dont have enough vodka..', -- Notification
    ['novodka'] = 'Looks like you dont have any vodka..', -- Notification
    ['enoughorange'] = 'Looks like you dont have enough oranges..', -- Notification
    ['noorange'] = 'Looks like you dont have any orange..', -- Notification
    ['enoughlemon'] = 'Looks like you dont have enough lemons..', -- Notification
    ['nolemon'] = 'Looks like you dont have any lemon..', -- Notification
    ['enoughapple'] = 'Looks like you dont have enough apples..', -- Notification
    ['noapple'] = 'Looks like you dont have any apple..', -- Notification
    ['enoughlime'] = 'Looks like you dont have enough limes..', -- Notification
    ['nolime'] = 'Looks like you dont have any lime..', -- Notification
    ['enoughpineapple'] = 'Looks like you dont have enough pineapples..', -- Notification
    ['nopineapple'] = 'Looks like you dont have any pineapple..', -- Notification
    ['enoughcocomilk'] = 'Looks like you dont have enough coconut milk..', -- Notification
    ['nococomilk'] = 'Looks like you dont have any coconut milk..', -- Notification
    ['enoughcranberry'] = 'Looks like you dont have enough cranberries..', -- Notification
    ['nocranberry'] = 'Looks like you dont have any cranberries..', -- Notification
    ['enoughtomato'] = 'Looks like you dont have enough tomatoes..', -- Notification
    ['notomato'] = 'Looks like you dont have any tomato..', -- Notification
    ['nococktailglass'] = 'You need a cocktail glass stupid..', -- Notification
    ['mixedcocktail'] = 'You successfully mixed a cocktail!', -- Notification
    ['mixcocktail'] = 'Mixing Cocktail..', -- Progressbar
    -- Liquor
    ['liquormenuheader'] = 'Hard Liquor', -- Menu header
    ['liquormenuheadertext'] = 'Required:</p>1x Small Glass', -- Menu header text
    ['whiskeyheader'] = 'Mount Whiskey', -- Menu header
    ['whiskeyheadertext'] = 'Sour blend bourbon whiskey.', -- Menu header text
    ['rumheader'] = 'Ragga Rum', -- Menu header
    ['rumheadertext'] = 'Jamaicas finest rum.', -- Menu header text
    ['vodkaheader'] = 'Cherenkov Vodka', -- Menu header
    ['vodkaheadertext'] = 'Warms you to the core.', -- Menu header text
    ['noliquorglass'] = 'What are you planning to put the liquor in dumbass..', -- Notification
    ['pulledliquor'] = 'You successfully pulled some liquor!', -- Notification 
    ['pullingliquor'] = 'Pulling Liquor..', -- Progressbar
    -- Hot drinks 
    ['hotdrinksmenuheader'] = 'Coffee Machine', -- Menu header
    ['hotdrinksmenuheadertext'] = 'Required:</p>1x Empty Cup', -- Menu header text
    ['coffeeheader'] = 'Coffee', -- Menu header
    ['coffeeheadertext'] = 'Coffee is all about choice.', -- Menu header text
    ['teaheader'] = 'Tea', -- Menu header
    ['teaheadertext'] = 'A cup for every office.', -- Menu header text
    ['nocup'] = 'Im pretty sure you need a cup idiot..', -- Notification
    ['madehot'] = 'You successfully poured a hot drink!', -- Notification
    ['makehot'] = 'Making a Hot Drink..', -- Progressbar
    -- Microwave
    ['microwavemenuheader'] = 'Microwave', -- Menu header
    ['microwavemenuheadertext'] = 'Required:</p>1x Microwave meal or snack', -- Menu header text
    ['cheesepieheader'] = 'Cheese & Onion Pie', -- Menu header
    ['cheesepieheadertext'] = 'Keep calm & have a pie!', -- Menu header
    ['meatpieheader'] = 'Meat Pie', -- Menu header
    ['meatpieheadertext'] = 'Keep calm & have a pie!', -- Menu header
    ['steakpieheader'] = 'Steak & Kidney Pie', -- Menu header
    ['steakpieheadertext'] = 'Keep calm & have a pie!', -- Menu header
    ['chickenpieheader'] = 'Chicken & Mushroom Pie', -- Menu header
    ['chickenpieheadertext'] = 'Keep calm & have a pie!', -- Menu header
    ['mwburgerheader'] = 'Burger', -- Menu header
    ['mwburgerheadertext'] = 'Not as fresh but still tasty!', -- Menu header
    ['mwcburgerheader'] = 'Cheeseurger', -- Menu header
    ['mwcburgerheadertext'] = 'Not as fresh but still tasty!', -- Menu header
    ['mwbcburgerheader'] = 'Bacon Cheeseburger', -- Menu header
    ['mwbcburgerheadertext'] = 'Not as fresh but still tasty!', -- Menu header
    ['mademicrowave'] = 'You successfully microwaved some food!', -- Notification
    ['nofood'] = 'What are you planning on cooking? The air? Dont be stupid..', -- Notification
    ['microwavefood'] = 'Microwaving Food..', -- Progressbar
    -- Consumables
    ['eatpie'] = 'Eating A Pie..', -- Progressbar
    ['eatburger'] = 'Eating A Burger..', -- Progressbar
    ['drinkbeer'] = 'Drinking Beer..', -- Progressbar
    ['drinkliquor'] = 'Drinking Liquor..', -- Progressbar
    ['drinkcocktail'] = 'Drinking Cocktail..', -- Progressbar
    ['drinktea'] = 'Drinking Tea..', -- Progressbar
    ['drinkcoffee'] = 'Drinking Coffee..', -- Progressbar
    ['drinkcola'] = 'Drinking Sprunk..', -- Progressbar
    ['drinkcola'] = 'Drinking Kurkakola..', -- Progressbar
    -- Snake
    ['snakeheader'] = 'Snake Enclosure', -- Menu header
    ['snakeheadertext'] = 'Dont forget to feed your snake!', -- Menu header text
    ['feedsnakeheader'] = 'Feed Snake', -- Menu header
    ['feedsnakeheadertext'] = 'Feeding the snake removes stress!', -- Menu header text
    ['snakefoodheader'] = 'Collect Mouse', -- Menu header
    ['snakefoodheadertext'] = 'Take a mouse to feed to your snake!', -- Menu header text
    ['gotsnakefood'] = 'Successfully collected a mouse!', -- Notification
    ['fedsnake'] = 'Successfully fed the snake!', -- Notification
    ['getsnakefood'] = 'Collecting A Mouse..', -- Progressbar
    ['feedsnake'] = 'Feeding The Snake..', -- Progressbar
    -- Shared
    ['cancel'] = 'Action cancelled..', -- Notification
    ['returnmenu'] = '< Return', -- Menu header
    ['exitmenu'] = '< Exit', -- Menu header
    -- Vehicle
    ['returnedvan'] = 'Thank you for returning the van!', -- Notification
    ['rentedvan'] = 'You took out a van! Return it when your done!', -- Notification
    ['nomoney'] = 'You cant afford the deposit dumbass..', -- Notification
    ['rentheader'] = 'Billiards Bar Garage', -- Menu header
    ['rentmenuheader'] = 'Company Van', -- Menu header
    ['rentmenutext'] = 'A deposit of $'..Config.VehicleDeposit..' is required.', -- Menu text
    ['returnmenuheader'] = 'Return Van', -- Menu header
    ['returnmenutext'] = 'Return Vehicle to receive $'..math.floor(Config.VehicleDeposit/2), -- Menu text
}