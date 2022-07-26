-------------------------------
---------- CASE#1993 ----------
-------------------------------

### BOII | Development - Drug Script; Cocaine & Crack ###

Here we have a indepth cocaine & crack drug script for your city.
You can manufacture cocaine from plant to coke, and coke into crack!
Adds two usable drugs, cocaine & crack both with custom drug effects.
Toggle-able XP system with 20 levels for your citizens to grind.
Highly customisable through config.
Easily pairs with any of our other drug scripts. 
Full information on how to itegrate is provided.
Enjoy!

### INFO ###

- Third-eye for all interactions
- Target coca plants to harvest leaves *(trowel required)*
- Target gasoline tankers to steal gasoline *(plasticjerrycan required)*
- Target airplane carts to steal benzocaine
- Target cement pallets to steal cement
- Target cocaine processing ped to exchange materials for ounces
- Target crack processing ped to exchange materials for ounces
- Use cutting kit to prepare usable drugs
- Take drugs or sell them *(boii-drugsales coming soon!!)*

### INSTALL ###

1) Customise `config.lua` to your liking 
2) Drag and drop `boii-cocaine` into your server resources ensuring that all dependencies are started prior **IF UNSURE REFER TO LOAD ORDER IN OUR F-A-Q ON DISCORD**
3) Insert item information provided under **SHARED.LUA** into your `qb-core/shared/items.lua`
4) Insert the line of code provided under **QB-CORE/SERVER/PLAYER.LUA** into your `qb-core/server/player.lua`
5) Insert item information provided under **QB-SHOPS** into your `qb-shops/config.lua`
6) If using `boii-heroin` or `boii-meth` follow the instructions below under **BOII-HEROIN & BOII-METH INTEGRATION**
7) Insert images provided into your `qb-inventory/html/images`
8) Insert information provided under **QB-DRUGS** into `qb-drugs/config.lua` in order to make drugs sell-able **!!BOII-DRUGSALES COMING SOON!!**
8) Restart your city

### BOII-HEROIN & BOII-METH INTEGRATION ###

If you also own **BOII-HEROIN OR BOII-METH** you need to disable the cutting kit code inside all but one of the scripts and uncomment the `DrugCuttingMenu` to suite your requirements.

Remove the following code from all but one of the scripts you can do this in the server side for example `heroin_s.lua`;
*(whichever script/s you remove this code from, you need to uncomment the menu in all but one)* 

--<!>-- CUTTING KIT START --<!>--
-- Drug cutting kit
local CuttingKit = Config.DrugCutting.Shared.CuttingKit['1'].name
local ScaleItem = Config.DrugCutting.Shared.Scales['1'].name
Core.Functions.CreateUseableItem(CuttingKit, function(source, item)
    local Player = Core.Functions.GetPlayer(source)
    local scales = Player.Functions.GetItemByName(ScaleItem)
    if scales ~= nil then
        TriggerClientEvent('boii-heroin:client:DrugCuttingMenu', source)
    else
        TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugCutting.Shared['noscales'], 'error')
    end
end)
--<!>-- CUTTING KIT END --<!>--

Uncomment the menu for the drugs that you have in your city you do this in the client side for example `heroin_c.lua`; **!!ONLY UNCOMMENT THE MENU INSIDE THE SCRIPT YOU DID NOT REMOVE THE CUTTING KIT FROM!!**
*(whichever script you uncomment the menu from, you need to remove the cutting kit code in the other/s)* 

--<!>-- CUTTING KIT MENU START --<!>--
RegisterNetEvent('boii-cocaine:client:DrugCuttingMenu', function()
	local DrugCuttingMenu = {
		{
			header = Config.Lang.DrugCutting.Shared['cuttingheader'],
			txt = Config.Lang.DrugCutting.Shared['cuttingheadertext'],
			isMenuHeader = true
		},
		{
			header = Config.Lang.DrugCutting.Heroin.Morphine['cutmorphineheader'],
			params = {
				event = 'boii-heroin:server:DrugCuttingCheck', -- DO NOT EDIT THIS
				isServer = true, -- DO NOT EDIT THIS
				args = 1 -- DO NOT EDIT THIS
			}				
		},
		{
			header = Config.Lang.DrugCutting.Heroin.Heroin['cutheroinheader'],
			params = {
				event = 'boii-heroin:server:DrugCuttingCheck', -- DO NOT EDIT THIS
				isServer = true, -- DO NOT EDIT THIS
				args = 2 -- DO NOT EDIT THIS
			}				 
		},
		{
			header = Config.Lang.DrugCutting.Cocaine.Cocaine['cutcokeheader'],
			params = {
				event = 'boii-cocaine:server:DrugCuttingCheck', -- DO NOT EDIT THIS
                isServer = true, -- DO NOT EDIT THIS
				args = 3 -- DO NOT EDIT THIS
			}				
		},
		{
			header = Config.Lang.DrugCutting.Cocaine.Crack['cutcrackheader'],
			params = {
				event = 'boii-cocaine:server:DrugCuttingCheck', -- DO NOT EDIT THIS
                isServer = true, -- DO NOT EDIT THIS
				args = 4 -- DO NOT EDIT THIS
			}				
		},
		{
			header = Config.Lang.DrugCutting.Meth['cutmethheader'],
			params = {
				event = 'boii-meth:server:DrugCuttingCheck', -- DO NOT EDIT THIS
                isServer = true, -- DO NOT EDIT THIS
				args = 5 -- DO NOT EDIT THIS
			}				
		},
		{
			header = Config.Lang.Shared['exitmenu'],
			params = {
				event = 'boii-cocaine:client:StopMenu'
			}
		}
	}
	exports[MenuName]:openMenu(DrugCuttingMenu)
end)
--<!>-- CUTTING KIT MENU END--<!>--

### SHARED.LUA ###

	-- Shared
	['drug_scales'] 		 	     = {['name'] = 'drug_scales', 					['label'] = 'Scale', 					['weight'] = 1500, 	    ['type'] = 'item', 		['image'] = 'drug_scales.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'A set of premium scales for weighing out decimals..'},
	['drug_cuttingkit'] 			 = {['name'] = 'drug_cuttingkit', 				['label'] = 'Cutting Kit', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'drug_cuttingkit.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  		['combinable'] = nil,   ['description'] = 'A mirror, a razor blade.. obviously this is a make up kit..'},
	['plasticjerrycan'] 			 = {['name'] = 'plasticjerrycan', 				['label'] = 'Plastic Jerrycan', 		['weight'] = 500, 		['type'] = 'item', 		['image'] = 'plasticjerrycan.png', 		['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'A empty jerry can for storing liquids.'},
	['trowel'] 			 	         = {['name'] = 'trowel', 			  			['label'] = 'Trowel', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'trowel.png', 						['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'Small handheld garden shovel'},
	['lighter'] 				 	 = {['name'] = 'lighter', 			  	  		['label'] = 'Lighter', 					['weight'] = 5, 		['type'] = 'item', 		['image'] = 'lighter.png', 						['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'On new years eve a nice fire to stand next to'},
	['empty_weed_bag'] 				 = {['name'] = 'empty_weed_bag', 			    ['label'] = 'Empty Weed Bag', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_baggy_empty.png', 	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A small empty bag'},

	-- Cocaine
	-- Tools
	['coke_spoon'] 				     = {['name'] = 'coke_spoon', 					['label'] = 'Snuff Spoon', 				['weight'] = 50, 		['type'] = 'item', 		['image'] = 'coke_spoon.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,  		['combinable'] = nil,   ['description'] = 'A premium snuff spoon!'},	
	-- Drug materials
	['cement'] 						 = {['name'] = 'cement',			 			['label'] = 'Cement', 			    	['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'cement.png', 						['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'Just a regular bag of builders cement.'},	
	['cocaleaf'] 				     = {['name'] = 'cocaleaf', 						['label'] = 'Cocaine Leaf', 			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'cocaineleaf.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,  		['combinable'] = nil,   ['description'] = 'Makes that premium nose candy!'},	
	['sodiumbicarbonate'] 			 = {['name'] = 'sodiumbicarbonate', 			['label'] = 'Baking Soda', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'sodiumbicarbonate.png', 			['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'Baking soda ey? What you cooking?'},	
	['illegalgasoline'] 			 = {['name'] = 'illegalgasoline', 				['label'] = 'Illegal Gasoline', 		['weight'] = 2500, 		['type'] = 'item', 		['image'] = 'illegalgasoline.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    		['combinable'] = nil,   ['description'] = 'Stolen gasoline? What are you doing with this?'},
	['benzocaine'] 					 = {['name'] = 'benzocaine', 			  		['label'] = 'Benzocaine', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'benzocaine.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    		['combinable'] = nil,   ['description'] = 'Benzo? You got a toothache mate?'},
	['water_bottle'] 				 = {['name'] = 'water_bottle', 			  		['label'] = 'Bottle of Water', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'water_bottle.png', 		        ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	        ['combinable'] = nil,   ['description'] = 'For all the thirsty out there'},
	-- Drugs
	['cokebaggy'] 					 = {['name'] = 'cokebaggy', 			  		['label'] = '1g Bag of Coke', 			['weight'] = 10, 		['type'] = 'item', 		['image'] = 'cocaine_baggy.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    		['combinable'] = nil,   ['description'] = 'A gram of the finest nose candy!'},
	['coke_1oz'] 					 = {['name'] = 'coke_1oz', 			  	  		['label'] = 'Ounce of Cocaine', 	    ['weight'] = 280, 		['type'] = 'item', 		['image'] = 'coke_1oz.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    		['combinable'] = nil,   ['description'] = 'A ounce of the finest nose candy!'},
	['crack_1oz'] 				     = {['name'] = 'crack_1oz', 			  		['label'] = 'Ounce of Crack', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'crack_1oz.png', 		            ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	        ['combinable'] = nil,   ['description'] = 'For all the thirsty out there'},
	['crack_baggy'] 			     = {['name'] = 'crack_baggy', 			  		['label'] = '1g Bag of Crack', 			['weight'] = 10, 		['type'] = 'item', 		['image'] = 'crack_baggy.png', 		            ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,         ['combinable'] = nil,   ['description'] = 'Man your about to lose some teeth!'},

### QB-CORE/SERVER/PLAYER.LUA ###
-- Insert the following line around `LINE:80` do not forget to edit this if you have changed your `MetaDataName` inside `config.lua`

PlayerData.metadata['drugxp'] = PlayerData.metadata['drugxp'] or 0 -- Added for drugs

### QB-SHOPS ###
-- Head to `qb-shops/config.lua` and insert the following lines 

-- Normal stores **you can put this anywhere do not forget to edit accordingly if you have edited in config**

        [14] = {
            name = "sodiumbicarbonate",
            price = 8,
            amount = 50,
            info = {},
            type = "item",
            slot = 14,
        },

-- Hardware stores **you can put these anywhere do not forget to edit accordingly if you have edited in config**

        [18] = {
            name = "plasticjerrycan",
            price = 20,
            amount = 100,
            info = {},
            type = "item",
            slot = 18,
        },
        [19] = {
            name = "trowel",
            price = 50,
            amount = 100,
            info = {},
            type = "item",
            slot = 19,
        },

### QB-DRUGS EXAMPLE ###
-- Add these items into your qb-drugs adjust prices accordingly for your server, you could made the `_1oz` items sellable also
    
    ["cokebaggy"] = {
        min = 55,
        max = 90,
    },
	["crack_baggy"] = {
        min = 25,
        max = 50,
    },

### PREVIEW ###
COMING SOON!!
### SUPPORT ###
https://discord.gg/MUckUyS5Kq