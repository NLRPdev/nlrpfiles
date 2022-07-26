----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

### BOII | Development - Heroin Drug Script ###

Here we have a indepth heroin & morphine drug script for your city.
You can manufacture heroin from poppy to morphine, to liquid freebase.
Adds two usable drugs, heroin & morphine both with custom drug effects.
Toggle-able XP system with 15 levels for your citizens to grind.
Highly customisable through config.
Enjoy!

### INFO ###

- Third eye for all interactions
- Collect opium sap from poppies *(requires razorblade)*
- Collect hydrochloric acid from tankers *(requires plasticjerrycan)*
- Collect petroleum ether from barrels *(requires plasticjerrycan)*
- Collect slaked lime *(& cement if using boii-cocaine)* from construction site
- Pharmacy store to sell other required items
- Ped to process morphine base
- Ped to process heroin base from morphine base
- Ped to process heroin ounces from heroin base
- Cut morphine base with sterile water and empty vials to make morphine for injecting
- Cut heroin ounces to make sell-able bags
- Process heroin bags into liquid heroin for injecting

### INSTALL ###

1) Customise `config.lua` to your liking 
2) Drag and drop `boii-heroin` into your server resources ensuring that all dependencies are started prior **IF UNSURE REFER TO LOAD ORDER IN OUR F-A-Q ON DISCORD**
3) Insert item information provided under **SHARED.LUA** into your `qb-core/shared/items.lua`
4) Insert the line of code provided under **QB-CORE/SERVER/PLAYER.LUA** into your `qb-core/server/player.lua`
5) Insert item information provided under **QB-SHOPS** into your `qb-shops/config.lua`
6) If using `boii-cocaine` or `boii-meth` follow the instructions below under **BOII-COCAINE & BOII-METH INTEGRATION**
7) Insert images provided into your `qb-inventory/html/images`
8) Insert information provided under **QB-DRUGS** into `qb-drugs/config.lua` in order to make drugs sell-able
8) Restart your city

### SHARED.LUA ###
-- If you already own `boii-cocaine`, `boii-meth`, `boii-outdoorweed` you will have some of these items already you can ignore those.

	-- Heroin
	-- Tools
	['razorblade'] 			 		 = {['name'] = 'razorblade', 					['label'] = 'Razor Blade', 				['weight'] = 10, 		['type'] = 'item', 		['image'] = 'razorblade.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'A sharp razorblade, be careful not to cut yourself!'},
	['syringe'] 			 		 = {['name'] = 'syringe', 						['label'] = 'Syringe', 					['weight'] = 50, 		['type'] = 'item', 		['image'] = 'syringe.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'A sterile syringe, dont share!'},
	['plasticjerrycan'] 			 = {['name'] = 'plasticjerrycan', 				['label'] = 'Plastic Jerrycan', 		['weight'] = 500, 		['type'] = 'item', 		['image'] = 'plasticjerrycan.png', 		['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'A empty jerry can for storing liquids.'},
	['emptyvial'] 			 		 = {['name'] = 'emptyvial', 					['label'] = 'Empty Vial', 				['weight'] = 50, 		['type'] = 'item', 		['image'] = 'emptyvial.png', 			['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'A empty sterile vial for storing liquid meds.'},
	['drug_scales'] 		 	     = {['name'] = 'drug_scales', 					['label'] = 'Scale', 					['weight'] = 1500, 	    ['type'] = 'item', 		['image'] = 'drug_scales.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'A set of premium scales for weighing out decimals..'},
	['drug_cuttingkit'] 			 = {['name'] = 'drug_cuttingkit', 				['label'] = 'Cutting Kit', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'drug_cuttingkit.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  		['combinable'] = nil,   ['description'] = 'A mirror, a razor blade.. obviously this is a make up kit..'},


	-- Drug materials
	['cement'] 						 = {['name'] = 'cement',			 			['label'] = 'Cement', 			    	['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'cement.png', 				['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'Just a regular bag of builders cement.'},	
	['slakedlime'] 			 		 = {['name'] = 'slakedlime', 					['label'] = 'Slaked Lime', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'slakedlime.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'Supposed to be used in preparation of dry mixer for painting and white washing.. However..'},
	['ammonia'] 			 		 = {['name'] = 'ammonia', 						['label'] = 'Ammonia', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'ammonia.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'Ammonia is a colorless, highly irritating gas with a pungent, suffocating odor.'},
	['aceticacid'] 			 		 = {['name'] = 'aceticacid', 					['label'] = 'Acetic Acid', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'aceticacid.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'Acetic Acid is a clear colourless liquid which has a pungent, vinegar-like odour.'},
	['hydrochloricacid'] 			 = {['name'] = 'hydrochloricacid', 				['label'] = 'Hydrochloric Acid', 		['weight'] = 1500, 		['type'] = 'item', 		['image'] = 'hydrochloricacid.png', 	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,  ['combinable'] = nil,   ['description'] = 'Disolves food pretty well..'},
	['ether'] 			 		 	 = {['name'] = 'ether', 						['label'] = 'Petroleum Ether', 		    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'ether.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'Petroleum ether is the petroleum fraction consisting of aliphatic hydrocarbons, commonly used as a laboratory solvent.'},
	['sodiumcarbonate'] 			 = {['name'] = 'sodiumcarbonate', 				['label'] = 'Sodium Carbonate', 		['weight'] = 200, 		['type'] = 'item', 		['image'] = 'sodiumcarbonate.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'Sodium Carbonate is the disodium salt of carbonic acid with alkalinizing property.'},
	['opium'] 			 		 	 = {['name'] = 'opium', 						['label'] = 'Opium Sap', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'opium.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'Opium, do you know how to refine it?'},
	['morphinebase'] 				 = {['name'] = 'morphinebase', 					['label'] = 'Morphine Base', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'morphinebase.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'Morphine base. You can turn this into morphine or heroin.'},
	['heroinbase'] 				 	 = {['name'] = 'heroinbase', 					['label'] = 'Heroin Base', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'heroinbase.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'Heroin base. Refine this into heroin powder.'},
	['sterilewater'] 			 	 = {['name'] = 'sterilewater', 					['label'] = 'Sterile Water', 			['weight'] = 50, 		['type'] = 'item', 		['image'] = 'sterilewater.png', 		['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'A vial of sterile water for injecting meds.'},

	-- Drugs
	['morphine'] 			 		 = {['name'] = 'morphine', 						['label'] = 'Morphine', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'morphine.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'Morphine. Good for pain but also a good time!'},
	['heroin_1oz'] 			 	 	 = {['name'] = 'heroin_1oz', 					['label'] = 'Ounce of Heroin', 			['weight'] = 280, 		['type'] = 'item', 		['image'] = 'heroin_1oz.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'A large amount of heroin.'},
	['heroinbaggy'] 			 	 = {['name'] = 'heroinbaggy', 					['label'] = 'Bag of Heroin', 			['weight'] = 10, 		['type'] = 'item', 		['image'] = 'heroinbaggy.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'Heroin. Destroying lives since 1898!'},
	['liquidheroin'] 			 	 = {['name'] = 'liquidheroin', 					['label'] = 'Liquid Heroin', 			['weight'] = 10, 		['type'] = 'item', 		['image'] = 'liquidheroin.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'Heroin. Destroying lives since 1898!'},


### QB-CORE/SERVER/PLAYER.LUA ###
-- Insert the following line around `LINE:80` do not forget to edit this if you have changed your `MetaDataName` inside `config.lua`

PlayerData.metadata['drugxp'] = PlayerData.metadata['drugxp'] or 0 -- Added for drugs

### QB-SHOPS ###
-- Head to `qb-shops/config.lua` and insert the following lines 

-- Normal stores **you can put this anywhere do not forget to edit accordingly if you have edited in config**

        [13] = {
            name = "sodiumcarbonate",
            price = 8,
            amount = 50,
            info = {},
            type = "item",
            slot = 13,
        },

-- Hardware stores **you can put these anywhere do not forget to edit accordingly if you have edited in config**

        [17] = {
            name = "razorblade",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 17,
        },
        [18] = {
            name = "plasticjerrycan",
            price = 20,
            amount = 100,
            info = {},
            type = "item",
            slot = 18,
        },
        [19] = {
            name = "ammonia",
            price = 20,
            amount = 100,
            info = {},
            type = "item",
            slot = 19,
        },

### BOII-COCAINE & BOII-METH INTEGRATION ###
-- If you are using `boii-cocaine` or `boii-meth` you need to make some edits to the cutting kit in order for them to work together
-- You MUST make these edits to 2 of the scripts, this can be any two you choose.
-- First, search for `DrugCuttingMenu` inside all  drug scripts you own and uncomment what you need
-- Second, you need to remove the cutting cut from the 2 other scripts for example; we uncommented the menu above within `boii-meth` so we remove the cutting kit from `boii-heroin/heroin_s.lua` & `boii-cocaine/server/cocaine_s.lua`

--<!>-- CUTTING KIT MENU START --<!>--
RegisterNetEvent('boii-meth:client:DrugCuttingMenu', function()
	local DrugCuttingMenu = {
		{
			header = Config.Lang.DrugCutting.Shared['cuttingheader'],
			txt = Config.Lang.DrugCutting.Shared['cuttingheadertext'],
            icon = Config.Lang.DrugCutting.Shared['cuttingheadericon'],
			isMenuHeader = true
		},
		{
			header = Config.Lang.DrugCutting.Heroin.Morphine['cutmorphineheader'],
			params = {
				event = 'boii-heroin:server:DrugCuttingCheck',
				isServer = true,
				args = 1 -- DO NOT EDIT THIS
			}				
		},
		{
			header = Config.Lang.DrugCutting.Heroin.Heroin['cutheroinheader'],
			params = {
				event = 'boii-heroin:server:DrugCuttingCheck',
				isServer = true,
				args = 2 -- DO NOT EDIT THIS
			}				 
		},
		{
			header = Config.Lang.DrugCutting.Cocaine.Cocaine['cutmethheader'],
			params = {
				event = 'boii-cocaine:server:DrugCuttingCheck',
                isServer = true,
				args = 3 -- DO NOT EDIT THIS
			}				
		},
		{
			header = Config.Lang.DrugCutting.Cocaine.Crack['cutcrackheader'],
			params = {
				event = 'boii-cocaine:server:DrugCuttingCheck',
                isServer = true,
				args = 4 -- DO NOT EDIT THIS
			}				
		},
		{
			header = Config.Lang.DrugCutting.Meth.Meth['cutmethheader'],
            icon = Config.Lang.DrugCutting.Meth.Meth['cutmethheadericon'],
			params = {
				event = 'boii-meth:server:DrugCuttingCheck',
                isServer = true,
				args = 5 -- DO NOT EDIT THIS
			}				
		},
		{
			header = Config.Lang.Shared['exitmenu'],
            icon = Config.Lang.Shared['exitmenuicon'],
			params = {
				event = 'boii-meth:client:StopMenu'
			}
		}
	}
	exports[MenuName]:openMenu(DrugCuttingMenu)
end)
--<!>-- CUTTING KIT MENU END--<!>--

-- Do not remove this code from the script you have uncommented your menu!
-- This can be found at the bottom of all unlocked server side scripts

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

### BOII-COCAINE ###
-- If you are using `boii-cocaine` you must disable the targeting for the hydrochloric acid location or they will conflict.
-- You can remove this code from either `boii-cocaine` or `boii-heroin`
-- You can do this inside `boii-cocaine/client/cocaine_c.lua` line `80' or inside `boii-heroin/client/heroin_c.lua` line `275`

-- Building Materials -- Cocaine
exports[TargetName]:AddTargetModel(BuildingMatsProp, {options = {{event = 'boii-cocaine:client:SearchBuildingMaterials',icon = Config.Lang.Targeting.Cocaine['matsicon'],label = Config.Lang.Targeting.Cocaine['matslabel']},},distance = 2.0})
or
-- Building Materials -- Heroin
exports[TargetName]:AddTargetModel(BuildingMatsProp, {options = {{event = 'boii-heroin:client:SearchBuildingMaterials',icon = Config.Lang.Targeting.Heroin['matsicon'],label = Config.Lang.Targeting.Heroin['matslabel']},},distance = 2.0})

### BOII-METH ###
-- If you are using `boii-meth` you must disable the targeting for the hydrochloric acid location or they will conflict.
-- You can remove this code from either `boii-meth` or `boii-heroin`
-- You can do this inside `boii-meth/client/meth_c.lua` line `136` or inside `boii-heroin/client/heroin_c.lua` line `271`

-- Hydrochloric Acid -- Heroin
exports[TargetName]:AddTargetModel(HydroProp, {options = {{event = 'boii-heroin:client:CollectHydro',icon = Config.Lang.Targeting.Heroin['hydroicon'],label = Config.Lang.Targeting.Heroin['hydrolabel'],item = HydroCollectItem,},},distance = 2.0})
or
-- Hydrochloric Acid -- Meth
exports[TargetName]:AddTargetModel(HydroProp, {options = {{event = 'boii-meth:client:CollectHydro',icon = Config.Lang.Targeting.Meth['hydroicon'],label = Config.Lang.Targeting.Meth['hydrolabel'],item = HydroCollectItem,},},distance = 2.0})


### QB-DRUGS ###
-- Add these items into your qb-drugs adjust prices accordingly for your server
    
    ["morphine"] = {
        min = 10,
        max = 20,
    },
	["heroinbaggy"] = {
        min = 22,
        max = 39,
    },
	["liquidheroin"] = {W
        min = 48,
        max = 60,
    },

### PREVIEW ###
https://www.youtube.com/watch?v=_jrrunOn6yU
### SUPPORT ###
https://discord.gg/MUckUyS5Kq