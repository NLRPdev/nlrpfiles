-------------------------------
---------- CASE#1993 ----------
-------------------------------

### BOII | Development - Drug Script; Meth ###

Here we have a indepth meth drug script for your city.
Adds one usable drug, with custom drug effects.
Toggle-able XP system with 18 levels for your citizens to grind.
Highly customisable through config.
Easily pairs with any of our other drug scripts. 
Full information on how to itegrate is provided.
Enjoy!

### INFO ###

- Third-eye for all interactions
- Target barrels to collect methylamine *(requires plasticjerrycan)*
- Target tankers to collect hydrochloric acid *(requires plasticjerrycan)*
- Target airport boxes to collect acetone
- Target prospecting rocks to collect lithium *(requires trowel)*
- Target processing ped to exchange materials for ounces
- Use cutting kit to cut drugs *(requires empty_weed_bag, drug_scales, meth_1oz)*
- Use meth to take drugs *(requires lighter)* 

### INSTALL ###

1) Customise `config.lua` to your liking 
2) Drag and drop `boii-meth` into your server resources ensuring that all dependencies are started prior **IF UNSURE REFER TO LOAD ORDER IN OUR F-A-Q ON DISCORD**
3) Insert item information provided under **SHARED.LUA** into your `qb-core/shared/items.lua`
4) Insert the line of code provided under **QB-CORE/SERVER/PLAYER.LUA** into your `qb-core/server/player.lua`
5) Insert item information provided under **QB-SHOPS** into your `qb-shops/config.lua`
6) If using `boii-heroin` or `boii-cocaine` follow the instructions below under **BOII-HEROIN & BOII-COCAINE INTEGRATION**
7) Insert images provided into your `qb-inventory/html/images`
8) Insert information provided under **QB-DRUGS** into `qb-drugs/config.lua` in order to make drugs sell-able **!!BOII-DRUGSALES COMING SOON!!**
8) Restart your city

### BOII-HEROIN & BOII-COCAINE INTEGRATION ###

If you also own **BOII-HEROIN OR BOII-COCAINE** you need to disable the cutting kit code inside all but one of the scripts and uncomment the `DrugCuttingMenu` to suite your requirements.

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

	--<!>-- BOII-DRUGS --<!>--
	-- Shared
	-- Tools
	['plasticjerrycan'] 			= {['name'] = 'plasticjerrycan', 			['label'] = 'Plastic Jerrycan', 		['weight'] = 500, 		['type'] = 'item', 		['image'] = 'plasticjerrycan.png', 				['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A empty jerry can for storing liquids.'},
	['trowel'] 			 	        = {['name'] = 'trowel', 			  		['label'] = 'Trowel', 					['weight'] = 500, 		['type'] = 'item', 		['image'] = 'trowel.png', 						['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'Just a simple gardening tool.'},
	["drug_scales"] 		 	    = {["name"] = "drug_scales", 				["label"] = "Scale", 					["weight"] = 1500, 	    ["type"] = "item", 		["image"] = "drug_scales.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "A set of premium scales for weighing out decimals.."},
	['drug_cuttingkit'] 			= {['name'] = 'drug_cuttingkit', 			['label'] = 'Cutting Kit', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'drug_cuttingkit.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  		['combinable'] = nil,   ['description'] = 'A mirror, a razor blade.. obviously this is a make up kit..'},
	["empty_weed_bag"] 				= {["name"] = "empty_weed_bag", 			["label"] = "Resealable Bags", 			["weight"] = 1, 		["type"] = "item", 		["image"] = "empty_weed_bag.png", 		        ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   		["combinable"] = nil,   ["description"] = "A small empty bag"},
	
	-- Drug Materials
    ["hydrochloricacid"] 			= {["name"] = "hydrochloricacid", 			["label"] = "Hydrochloric Acid", 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "hydrochloricacid.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "Disolves food pretty well.."},
	["acetone"] 					= {["name"] = "acetone", 					["label"] = "Acetone", 					["weight"] = 1500, 		["type"] = "item", 		["image"] = "acetone.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "A highly volitile and flamable liquid.."},
	['lithium'] 			 	    = {['name'] = 'lithium', 					['label'] = 'Lithium', 				    ['weight'] = 500, 		['type'] = 'item', 		['image'] = 'lithium.png', 						['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'Lithium, for batteries or maybe or things?'},
 	['methylamine'] 			 	= {['name'] = 'methylamine', 				['label'] = 'Methylamine', 				['weight'] = 1500, 		['type'] = 'item', 		['image'] = 'methylamine.png', 					['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'Methylamine? What is this breaking bad?'},
	-- Drugs
	['meth'] 			 	        = {['name'] = 'meth', 						['label'] = '1g of Meth', 			    ['weight'] = 10, 		['type'] = 'item', 		['image'] = 'meth.png', 						['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A gram of the finest teeth rotting goodness!'},	
	['meth_1oz'] 			 	    = {['name'] = 'meth_1oz', 					['label'] = 'Ounce of Meth', 			['weight'] = 280, 		['type'] = 'item', 		['image'] = 'meth_1oz.png', 					['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A ounce of the finest teeth rotting goodness!'},	


### QB-CORE/SERVER/PLAYER.LUA ###
-- Insert the following line around `LINE:80` do not forget to edit this if you have changed your `MetaDataName` inside `config.lua`

PlayerData.metadata['drugxp'] = PlayerData.metadata['drugxp'] or 0 -- Added for drugs

### QB-SHOPS ###
-- Head to `qb-shops/config.lua` and insert the following lines 

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
-- Add meth into your qb-drugs adjust prices accordingly for your server, you could made the `_1oz` items sellable also
    
    ["meth"] = {
        min = 55,
        max = 90,
    },

### PREVIEW ###
COMING SOON!!
### SUPPORT ###
https://discord.gg/MUckUyS5Kq