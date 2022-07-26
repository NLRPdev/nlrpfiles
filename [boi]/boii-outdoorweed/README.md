-------------------------------
---------- CASE#2506 ----------
-------------------------------

### BOII OUTDOORWEED ###

We were not happy with the base `boii-weed` forcing us to plant indoors so we made an outdoor system.
This system is built to use all 6 original seeds that come with `boii-weed`.
Customise to your liking in the `config.lua`.
Grow weed outdoors, harvest into crops, trim crops into bags, turn bags into joints and then finally smoke up!
All joints give a small amount of armour and reduce stress. The amount scales depending on which joint you are smoking.

### USAGE ###

- Plant weed outdoors
- Buy equipment from ped store access with third-eye
- Bulk sell to ped store
- Plants need food and water
- Harvest into crops
- Trim crops into bags
- Make bags into joints
- Smoke up!
- Police can destroy plants.

### INSTALL ###

1) Customise to your liking, support can be provided if needed
2) Drag and drop `boii-outdoorweed` into your server resources
3) Remove `boii-weed` from your server resources as my weed is built to replace
4) Upload `outdoor_plants.sql` into your server sql 
5) Add `boii-outdoorweed` to your `server.cfg`
6) Add information provided into your `boii-core/shared.lua` or `boii-core/shared/items.lua`
7) Add images provided into your `boii-inventory/html/images`
8) Restart city

### REQUIREMENTS ###

boii-menu - https://github.com/qbcore-framework/boii-menu
boii-target - https://github.com/BerkieBb/boii-target
progressbar - https://github.com/qbcore-framework/progressbar


### SHARED.LUA REPLACE ITEMS YOU ALREADY HAVE FOR THE ONES HERE! ### 

	["weed_white-widow"] 			 = {["name"] = "weed_white-widow", 			["label"] = "White Widow 2g", 			["weight"] = 5, 		["type"] = "item", 		["image"] = "weed_white-widow.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "A weed bag with 2g White Widow"},
	["weed_skunk"] 				  	 = {["name"] = "weed_skunk", 			 	["label"] = "Skunk 2g", 				["weight"] = 5, 		["type"] = "item", 		["image"] = "weed_skunk.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "A weed bag with 2g Skunk"},
	["weed_purple-haze"] 			 = {["name"] = "weed_purple-haze", 			["label"] = "Purple Haze 2g", 			["weight"] = 5, 		["type"] = "item", 		["image"] = "weed_purple-haze.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "A weed bag with 2g Purple Haze"},
	["weed_og-kush"] 				 = {["name"] = "weed_og-kush", 			 	["label"] = "OGKush 2g", 				["weight"] = 5, 		["type"] = "item", 		["image"] = "weed_og-kush.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "A weed bag with 2g OG Kush"},
	["weed_amnesia"] 				 = {["name"] = "weed_amnesia", 			 	["label"] = "Amnesia 2g", 				["weight"] = 5, 		["type"] = "item", 		["image"] = "weed_amnesia.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "A weed bag with 2g Amnesia"},
	["weed_ak47"] 				     = {["name"] = "weed_ak47", 			 	["label"] = "AK47 2g", 					["weight"] = 5, 		["type"] = "item", 		["image"] = "weed_ak47.png", 			        ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "A weed bag with 2g AK47"},
	["weed_white-widow_seed"] 		 = {["name"] = "weed_white-widow_seed", 	["label"] = "White Widow Seed", 		["weight"] = 1, 		["type"] = "item", 		["image"] = "weed_white-widow_seed.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,  		["combinable"] = nil,   ["description"] = "A weed seed of White Widow"},
	["weed_skunk_seed"] 			 = {["name"] = "weed_skunk_seed", 			["label"] = "Skunk Seed", 				["weight"] = 1, 		["type"] = "item", 		["image"] = "weed_skunk_seed.png", 		        ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   		["combinable"] = nil,   ["description"] = "A weed seed of Skunk"},
	["weed_purple-haze_seed"] 		 = {["name"] = "weed_purple-haze_seed", 	["label"] = "Purple Haze Seed", 		["weight"] = 1, 		["type"] = "item", 		["image"] = "weed_purple-haze_seed.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   		["combinable"] = nil,   ["description"] = "A weed seed of Purple Haze"},
	["weed_og-kush_seed"] 			 = {["name"] = "weed_og-kush_seed", 		["label"] = "OG Kush Seed", 			["weight"] = 1, 		["type"] = "item", 		["image"] = "weed_og-kush_seed.png", 		    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   		["combinable"] = nil,   ["description"] = "A weed seed of OG Kush"},
	["weed_amnesia_seed"] 			 = {["name"] = "weed_amnesia_seed", 		["label"] = "Amnesia Seed", 			["weight"] = 1, 		["type"] = "item", 		["image"] = "weed_amnesia_seed.png", 		    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   		["combinable"] = nil,   ["description"] = "A weed seed of Amnesia"},
	["weed_ak47_seed"] 				 = {["name"] = "weed_ak47_seed", 			["label"] = "AK 47 Seed", 				["weight"] = 1, 		["type"] = "item", 		["image"] = "weed_ak47_seed.png", 		        ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   		["combinable"] = nil,   ["description"] = "A weed seed of AK47"},
	["weed_white-widow_crop"] 		 = {["name"] = "weed_white-widow_crop", 	["label"] = "White Widow Crop", 		["weight"] = 1200, 		["type"] = "item", 		["image"] = "weed_white-widow_crop.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "A weed bag with 2g White Widow"},
	["weed_skunk_crop"] 			 = {["name"] = "weed_skunk_crop", 			["label"] = "Skunk Crop", 				["weight"] = 1200, 		["type"] = "item", 		["image"] = "weed_skunk_crop.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "A weed bag with 2g Skunk"},
	["weed_purple-haze_crop"] 		 = {["name"] = "weed_purple-haze_crop", 	["label"] = "Purple Haze Crop", 		["weight"] = 1200, 		["type"] = "item", 		["image"] = "weed_purple-haze_crop.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "A weed bag with 2g Purple Haze"},
	["weed_og-kush_crop"] 			 = {["name"] = "weed_og-kush_crop", 		["label"] = "OG Kush Crop", 			["weight"] = 1200, 		["type"] = "item", 		["image"] = "weed_og-kush_crop.png", 		    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "A weed bag with 2g OG Kush"},
	["weed_amnesia_crop"] 			 = {["name"] = "weed_amnesia_crop", 		["label"] = "Amnesia Crop", 			["weight"] = 1200, 		["type"] = "item", 		["image"] = "weed_amnesia_crop.png", 		    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "A weed bag with 2g Amnesia"},
	["weed_ak47_crop"] 				 = {["name"] = "weed_ak47_crop", 			["label"] = "AK 47 Crop", 				["weight"] = 1200, 		["type"] = "item", 		["image"] = "weed_ak47_crop.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "A weed bag with 2g AK47"},
	["weed_white-widow_joint"] 		 = {["name"] = "weed_white-widow_joint", 	["label"] = "White Widow Joint", 		["weight"] = 1, 		["type"] = "item", 		["image"] = "weed_white-widow_joint.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "Light up that white widow son!"},
	["weed_skunk_joint"] 			 = {["name"] = "weed_skunk_joint", 			["label"] = "Skunk Joint", 				["weight"] = 1, 		["type"] = "item", 		["image"] = "weed_skunk_joint.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "Light up that skunk son!"},
	["weed_purple-haze_joint"] 		 = {["name"] = "weed_purple-haze_joint", 	["label"] = "Purple Haze Joint", 		["weight"] = 1, 		["type"] = "item", 		["image"] = "weed_purple-haze_joint.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "Light up that purple haze son!"},
	["weed_og-kush_joint"] 			 = {["name"] = "weed_og-kush_joint", 		["label"] = "OG Kush Joint", 			["weight"] = 1, 		["type"] = "item", 		["image"] = "weed_og-kush_joint.png", 		    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "Light up that og kush son!"},
	["weed_amnesia_joint"] 			 = {["name"] = "weed_amnesia_joint", 		["label"] = "Amnesia Joint", 			["weight"] = 1, 		["type"] = "item", 		["image"] = "weed_amnesia_joint.png", 		    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "Light up that amnesia son!"},
	["weed_ak47_joint"] 			 = {["name"] = "weed_ak47_joint", 			["label"] = "AK 47 Joint", 				["weight"] = 1, 		["type"] = "item", 		["image"] = "weed_ak47_joint.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   		["combinable"] = nil,   ["description"] = "Light up that ak47 son!"},
	["empty_weed_bag"] 				 = {["name"] = "empty_weed_bag", 			["label"] = "Drug Baggies", 			["weight"] = 1, 		["type"] = "item", 		["image"] = "weed-empty-bag.png", 		        ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   		["combinable"] = nil,   ["description"] = "A small empty bag"},
	["weed_nutrition"] 				 = {["name"] = "weed_nutrition", 			["label"] = "Plant Fertilizer", 		["weight"] = 500, 		["type"] = "item", 		["image"] = "weed_nutrition.png", 		        ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	  	    ["combinable"] = nil,   ["description"] = "Get that big bug energy!"},
	["weed_water"] 				     = {["name"] = "weed_water", 			    ["label"] = "Distilled Water", 		    ["weight"] = 500, 		["type"] = "item", 		["image"] = "weed_water.png", 		            ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   		["combinable"] = nil,   ["description"] = "Distilled water for your plants"},
	["weed_pot"] 				     = {["name"] = "weed_pot", 			        ["label"] = "Plant Pot", 		        ["weight"] = 100, 		["type"] = "item", 		["image"] = "weed_pot.png", 		            ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   		["combinable"] = nil,   ["description"] = "A simple plant pot for all your planting needs!"},
	["rolling_paper"] 			 	 = {["name"] = "rolling_paper", 			["label"] = "Rolling Papers", 			["weight"] = 1, 		["type"] = "item", 		["image"] = "rolling_paper.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   		["combinable"] = nil,   ["description"] = "Paper made specifically for encasing and smoking tobacco or cannabis."},
	['drug_shears'] 			     = {['name'] = 'drug_shears', 		        ['label'] = 'Trimming Shears', 			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'drug_shears.png', 					['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A set of high quality trimming shears.'},	
	['drug_grinder'] 			     = {['name'] = 'drug_grinder', 		        ['label'] = 'Tobacco Grinder', 		    ['weight'] = 100, 		['type'] = 'item', 		['image'] = 'drug_grinder.png', 				['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A tobacco grinder or something more..'},	
	["empty_weed_bag"] 				 = {["name"] = "empty_weed_bag", 			["label"] = "Sealy Bags", 			    ["weight"] = 1, 		["type"] = "item", 		["image"] = "empty_weed_bag.png", 		        ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   		["combinable"] = nil,   ["description"] = "A small empty bag"},
	['trowel']                       = {['name'] = 'trowel',                    ['label'] = 'Trowel',                   ['weight'] = 1000,      ['type'] = 'item',      ['image'] = 'trowel.png',                       ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,         ['combinable'] = nil,   ['description'] = 'Small handheld garden shovel'},
    ['drug_scales']                  = {['name'] = 'drug_scales',               ['label'] = 'Scale',                    ['weight'] = 1500,      ['type'] = 'item',      ['image'] = 'drug_scales.png',                  ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,        ['combinable'] = nil,   ['description'] = 'A set of premium scales for weighing out decimals..'},

### PREVIEW ###
https://www.youtube.com/watch?v=CkTD-SqchC4

### SUPPORT ### 
https://discord.gg/MUckUyS5Kq



