-------------------------------
---------- CASE#1993 ----------
-------------------------------

Config = {}
-- Core settings for renamed cores
Config.Core = 'QBCore' -- The name of your core. Default; QBCore
Config.CoreFolder = 'qb-core' -- The name of your core folder. Default; qb-core
Config.TargetName = 'qb-target' -- The name of your third eye targeting. Default; qb-target
Config.MenuName = 'qb-menu' -- The name of your menu. Default; qb-menu
Config.AddItemEvent = 'QBCore:Server:AddItem' -- The name of your item check event. Default; 'QBCore:Server:AddItem'
-- Blips
Config.UseBlips = true -- Enables map blips 
Config.Blips = { -- Blips comment out or remove what you do not wish to use
	{title='Pawn Shop',     colour=5, id=431, x = -265.71, y = 235.88, z = 89.57},
	--{title='Digital Den',   colour=8, id=431, x = -657.4, y = -859.03, z = 23.49},
    {title='Gold Smelting', colour=12, id=431, x = 1107.51, y = -1992.46, z = 30.97}, -- Uncomment to activate blip for gold smelting location
    --{title='Gold Buyer',    colour=12, id=431, x = -111.09, y = -6.60, z = 69.52}, -- Uncomment to activate blip for gold buyer location
}
-- Stores
Config.PawnShopStore = { -- Pawnshop store items you can put whatever here
    [1] = { name = 'phone',             price = 700,    amount = 100, info = {}, type = 'item', slot = 1 },
    [2] = { name = 'radio',             price = 2000,   amount = 100, info = {}, type = 'item', slot = 2 },	
}
Config.DigitalDenStore = { -- Digital den items you can put whatever here
    [1] = { name = 'electronickit',     price = 300,    amount = 100, info = {}, type = 'item', slot = 1 },
    [2] = { name = 'phone',             price = 700,    amount = 100, info = {}, type = 'item', slot = 2 },
	[3] = { name = 'radio',             price = 2000,   amount = 100, info = {}, type = 'item', slot = 3 },
}
Config.GoldBuyStore = { -- Gold buyer items you can put whatever here
    [1] = { name = 'lockpick',          price = 300,    amount = 100, info = {}, type = 'item', slot = 1 },
    [2] = { name = 'screwdriverset',    price = 1000,   amount = 100, info = {}, type = 'item', slot = 2 },
    [3] = { name = 'radioscanner',      price = 2000,   amount = 100, info = {}, type = 'item', slot = 3 },
}
-- Store opening times
Config.PawnShopTimes = true -- Enables time locks on pawnshop
Config.PawnOpenTime = 1 -- Opening time
Config.PawnCloseTime = 24 -- Closing time
Config.DigitalDenTimes = true -- Enables time locks on digital den
Config.DigitalOpenTime = 1 -- Opening time
Config.DigitalCloseTime = 24 -- Closing time
Config.GoldBuyTimes = true -- Enables time locks on gold buyer
Config.GoldOpenTime = 1 -- Opening time
Config.GoldCloseTime = 24 -- Closing time
-- Selling
Config.MoneyType = 'cash' -- Money type to receive payment; 'cash' 'bank' 'crypto'
Config.SellItems = { -- Item prices
    -- Materials (pawnshop)
    ['metalscrap'] = 1,
    ['iron'] = 3,
    ['steel'] = 5,
    ['aluminum'] = 5,
    ['copper'] = 8,
    ['plastic'] = 1,
    ['rubber'] = 3,
    -- Gems (pawnshop)
    ['gold'] = 50,
    ['diamond'] = 100,
    ['emerald'] = 100,
    ['ruby'] = 100,
    ['opal'] = 100,
    ['black_diamond'] = 100,
    ['pink_diamond'] = 100,
    ['sapphire'] = 100,
    -- Jewellery (pawnshop)
    ['goldchain'] = 50,
    ['rolex'] = 100,
    ['10kgoldchain'] = 140,
    ['diamond_ring'] = 150,
    ['goldbar'] = 4000,
    -- Electronics (digital den)
    ['tablet'] = 50,
	['iphone'] = 150,
	['samsungphone'] = 100,
	['laptop'] = 75,
    -- Gold (gold buyer)
    ['goldbar'] = 4000,
}
-- Smelting
Config.SmeltingTime = math.random(10000,17500) -- Time in (ms) to smelt gold items into bars
Config.GoldBarReturn = 1 -- Amount of gold bars to be returned from smelting
Config.RolexAmount = 28 -- Amount of rolex required to return GoldBarReturn above
Config.GoldChainAmount = 45 -- Amount of gold chains required to return GoldBarReturn above
Config.KGoldChainAmount = 20 -- Amount of 10k gold chains required to return GoldBarReturn above
-- Language
Config.Lang = {
    -- Targeting
    ['pawnshopicon'] = 'fas fa-money-bill-wave', -- Icon used by qb-target for pawnshop ped visit; https://fontawesome.com to change
    ['pawnshoplabel'] = 'Speak to Molly', -- Label used by qb-target for digital den ped
    ['digitaldenicon'] = 'fas fa-money-bill-wave', -- Icon used by qb-target for digital den ped visit; https://fontawesome.com to change
    ['digitaldenlabel'] = 'Speak to Herman', -- Label used by qb-target for digital den ped    
    ['goldbuyicon'] = 'fab fa-drupal', -- Icon used by qb-target for gold buying ped visit; https://fontawesome.com to change
    ['goldbuylabel'] = 'Speak to Fence', -- Label used by qb-target for gold buying ped
    ['goldsmelticon'] = 'fas fa-fire-alt', -- Icon used by qb-target for gold smelting location visit; https://fontawesome.com to change
    ['goldsmeltlabel'] = 'Smelt Gold', -- Label used by qb-target for gold smelting location
    -- General
    ['returnmenu'] = '< Return', -- Menu header
    ['exitmenu'] = '< Exit', -- Menu header
    ['cancelled'] = 'Action Cancelled!', -- Notification
    -- Pawnshop
    ['pawnshopheader'] = 'Pawn Shop', -- Menu header 
    ['pawnshopheadertext'] = 'We will take your money so no one else can!', -- Menu header text
    ['pawnsellheader'] = 'Sell Us Your Items!', -- Menu header   
    ['pawnsellheadertext'] = 'Check the current prices of items here.', -- Menu header
    ['pawnstoreheader'] = 'Purchase Items!', -- Menu header   
    ['pawnstoreheadertext'] = 'Check what items are in stock here.', -- Menu header
    ['materialsellheader'] = 'Sell Raw Materials', -- Menu header
    ['materialsellheadertext'] = 'Check the current prices of materials here.', -- Menu header
    ['gemsellheader'] = 'Sell Gems', -- Menu header
    ['gemsellheadertext'] = 'Check the current prices of gems here.', -- Menu header
    ['jewellerysellheader'] = 'Sell Jewellery', -- Menu header
    ['jewellerysellheadertext'] = 'Check the current prices of jewellery here.', -- Menu header
    ['pawnshopclosed'] = 'My shift starts at '..Config.PawnOpenTime..' until '..Config.PawnCloseTime..' please come back later..', -- Notification
    -- Materials 
    ['metalscrapheader'] = 'Metalscrap', -- Menu header
    ['metalscrapheadertext'] = 'Price: $'..Config.SellItems['metalscrap']..' per item.', -- Menu header text
    ['ironheader'] = 'Iron', -- Menu header
    ['ironheadertext'] = 'Price: $'..Config.SellItems['iron']..' per item.', -- Menu header text
    ['steelheader'] = 'Steel', -- Menu header
    ['steelheadertext'] = 'Price: $'..Config.SellItems['steel']..' per item.', -- Menu header text
    ['aluminumheader'] = 'Aluminum', -- Menu header
    ['aluminumheadertext'] = 'Price: $'..Config.SellItems['aluminum']..' per item.', -- Menu header text
    ['copperheader'] = 'Copper', -- Menu header
    ['copperheadertext'] = 'Price: $'..Config.SellItems['copper']..' per item.', -- Menu header text
    ['plasticheader'] = 'Plastic', -- Menu header
    ['plasticheadertext'] = 'Price: $'..Config.SellItems['plastic']..' per item.', -- Menu header text
    ['rubberheader'] = 'Rubber', -- Menu header
    ['rubberheadertext'] = 'Price: $'..Config.SellItems['rubber']..' per item.', -- Menu header text
    -- Gems
    ['diamondheader'] = 'Diamond', -- Menu header
    ['diamondheadertext'] = 'Price: $'..Config.SellItems['diamond']..' per item.', -- Menu header text
    ['goldheader'] = 'Gold', -- Menu header
    ['goldheadertext'] = 'Price: $'..Config.SellItems['gold']..' per item.', -- Menu header text
    ['emeraldheader'] = 'Emerald', -- Menu header
    ['emeraldheadertext'] = 'Price: $'..Config.SellItems['emerald']..' per item.', -- Menu header text
    ['rubyheader'] = 'Ruby', -- Menu header
    ['rubyheadertext'] = 'Price: $'..Config.SellItems['ruby']..' per item.', -- Menu header text
    ['opalheader'] = 'Opal', -- Menu header
    ['opalheadertext'] = 'Price: $'..Config.SellItems['opal']..' per item.', -- Menu header text
    ['bdheader'] = 'Black Diamond', -- Menu header
    ['bdheadertext'] = 'Price: $'..Config.SellItems['black_diamond']..' per item.', -- Menu header text
    ['pdheader'] = 'Pink Diamond', -- Menu header
    ['pdheadertext'] = 'Price: $'..Config.SellItems['pink_diamond']..' per item.', -- Menu header text
    ['sapphireheader'] = 'Sapphire', -- Menu header
    ['sapphireheadertext'] = 'Price: $'..Config.SellItems['sapphire']..' per item.', -- Menu header text
    -- Jewellery
    ['goldchainheader'] = 'Gold Chain', -- Menu header
    ['goldchainheadertext'] = 'Price: $'..Config.SellItems['goldchain']..' per item.', -- Menu header text    
    ['rolexheader'] = 'Rolex', -- Menu header
    ['rolexheadertext'] = 'Price: $'..Config.SellItems['rolex']..' per item.', -- Menu header text
    ['10kgoldchainheader'] = '10K Gold Chain', -- Menu header
    ['10kgoldchainheadertext'] = 'Price: $'..Config.SellItems['10kgoldchain']..' per item.', -- Menu header text
    ['diamondringheader'] = 'Diamond Ring', -- Menu header
    ['diamondringheadertext'] = 'Price: $'..Config.SellItems['diamond_ring']..' per item.', -- Menu header text
    -- Digital den
    ['digitalheader'] = 'Digital Den', -- Menu header 
    ['digitalheadertext'] = 'We buy electronics no receipt required!', -- Menu header text
    ['digitalsellheader'] = 'Sell Us Your Electronics!', -- Menu header   
    ['digitalsellheadertext'] = 'Check the current prices of electronics here.', -- Menu header
    ['digitalstoreheader'] = 'Purchase Items!', -- Menu header   
    ['digitalstoreheadertext'] = 'Check what items are in stock here.', -- Menu header
    ['tabletheader'] = 'Tablet', -- Menu header
    ['tabletheadertext'] = 'Price: $'..Config.SellItems['tablet']..' per item.', -- Menu header text
    ['iphoneheader'] = 'iPhone', -- Menu header
    ['iphoneheadertext'] = 'Price: $'..Config.SellItems['iphone']..' per item.', -- Menu header text
    ['samsungheader'] = 'Samsung S20', -- Menu header
    ['samsungheadertext'] = 'Price: $'..Config.SellItems['samsungphone']..' per item.', -- Menu header text
    ['laptopheader'] = 'Laptop', -- Menu header
    ['laptopheadertext'] = 'Price: $'..Config.SellItems['laptop']..' per item.', -- Menu header text     
    ['digitalclosed'] = 'My shift starts at '..Config.DigitalOpenTime..' until '..Config.DigitalCloseTime..' please come back later..', -- Notification 
    -- Gold buyer
    ['goldbuyheader'] = 'Gold Buyer', -- Menu header 
    ['goldbuyheadertext'] = 'You got some less than legal stuff for me?', -- Menu header text
    ['goldbuysellheader'] = 'Sell Your Stuff!', -- Menu header   
    ['goldbuysellheadertext'] = 'Check the current prices of fenced goods here.', -- Menu header
    ['goldbuystoreheader'] = 'Purchase Items!', -- Menu header
    ['goldbuystoreheadertext'] = 'Check what items are in stock here.', -- Menu header
    ['goldbarheader'] = 'Gold Bar', -- Menu header
    ['goldbarheadertext'] = 'Price: $'..Config.SellItems['goldbar']..' per item.', -- Menu header text     
    ['goldbuyclosed'] = 'My buyers not around yet come back between '..Config.GoldOpenTime..' and '..Config.GoldCloseTime..' ..', -- Notification
    -- Smelting
    ['goldsmeltheader'] = 'Smelt Gold', -- Menu header 
    ['goldsmeltheadertext'] = 'Here you smelt gold items into bars.', -- Menu header text
    ['rolexsmeltheader'] = 'Rolexs', -- Menu header   
    ['rolexsmeltheadertext'] = 'Required: '..Config.RolexAmount..' to smelt '..Config.GoldBarReturn..' goldbar.', -- Menu header
    ['chainsmeltheader'] = 'Gold Chains', -- Menu header   
    ['chainsmeltheadertext'] = 'Required: '..Config.GoldChainAmount..' to smelt '..Config.GoldBarReturn..' goldbar.', -- Menu header text
    ['10kchainsmeltheader'] = '10K Gold Chains', -- Menu header   
    ['10kchainsmeltheadertext'] = 'Required: '..Config.KGoldChainAmount..' to smelt '..Config.GoldBarReturn..' goldbar.', -- Menu header text
    ['enoughsmelt'] = 'You dont have enough items to smelt into gold bars..', -- Notification
    ['nosmelt'] = 'You dont have any items to smelt gold bars..', -- Notification
    ['smeltrolex'] = 'Smelting Rolexs..', -- Progressbar
    ['smeltchain'] = 'Smelting Gold Chains..', -- Progressbar
    ['smelt10kchain'] = 'Smelting 10K Gold Chains..', -- Progressbar
    -- Shared
    ['noitems'] = 'I cant buy the air.. come back with some goods!', -- Notification
    ['solditems'] = 'You sold some items!', -- Notification   
}