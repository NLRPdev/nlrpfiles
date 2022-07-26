print("Jim-PizzaThis v1.5.1 - PizzaThis Job Script by Jimathy")

-- If you need support I now have a discord available, it helps me keep track of issues and give better support.

-- https://discord.gg/xKgQZ6wZvS

Config = {
	Debug = false,
	img = "qb-inventory/html/images/", -- Change this to your inventory's name and image folder
	JimShop = false, -- If true shops will open in jim-shops
	CheckMarks = true, -- If true this will show the player if they have the correct items to be able to craft the items

		--Simple Toy Reward Support
	RewardItem = "", --Set this to the name of an item eg "bento"
	RewardPool = { -- Set this to the list of items to be given out as random prizes when the item is used - can be more or less items in the list
		"",
		"",
		"",
	},
	Locations = {
		[1] = {
			zoneEnable = true,
			label = "pizzathis", -- Set this to the required job
			zones = {
				vector2(776.45977783203, -734.53753662109),
				vector2(815.66552734375, -733.91662597656),
				vector2(819.54748535156, -747.50708007812),
				vector2(827.40344238281, -760.18341064453),
				vector2(829.70361328125, -769.6220703125),
				vector2(830.78997802734, -775.21801757812),
				vector2(776.12048339844, -774.75408935547)
			},
			blip = vector3(806.97, -759.59, 26.78),
			blipcolor = 43,
			garage = { spawn = vector4(791.12, -720.16, 27.45, 90.18),
			out = vector4(793.93, -717.42, 28.09, 180.56),
			list = { "rmodescort", } },
		},
	},
	DrinkItems = {
		label = "Drinks Store",
		slots = 5,
		items = {
			[1] = { name = "vodka", price = 0, amount = 50, info = {}, type = "item", slot = 1, },
			[2] = { name = "sprunk", price = 0, amount = 50, info = {}, type = "item", slot = 2, },
			[3] = { name = "sprunklight", price = 0, amount = 50, info = {}, type = "item", slot = 3, },
			[4] = { name = "ecola", price = 0, amount = 50, info = {}, type = "item", slot = 4, },
			[5] = { name = "ecolalight", price = 0, amount = 50, info = {}, type = "item", slot = 5, },
		}
	},	
	WineItems = {
		label = "Wine Store",
		slots = 6,
		items = {
			[1] = { name = "amarone", price = 0, amount = 50, info = {}, type = "item", slot = 1, },
			[2] = { name = "barbera", price = 0, amount = 50, info = {}, type = "item", slot = 2, },
			[3] = { name = "dolceto", price = 0, amount = 50, info = {}, type = "item", slot = 3, },
			[4] = { name = "housered", price = 0, amount = 50, info = {}, type = "item", slot = 4, },
			[5] = { name = "housewhite", price = 0, amount = 50, info = {}, type = "item", slot = 5, },
			[5] = { name = "rosso", price = 0, amount = 50, info = {}, type = "item", slot = 5, },
		}
	},

	FoodItems = {
		label = "Food Fridge Store",
		slots = 7,
		items = {
			[1] = { name = "sauce", price = 0, amount = 50, info = {}, type = "item", slot = 1, },
			[2] = { name = "pasta", price = 0, amount = 50, info = {}, type = "item", slot = 2, },
			[3] = { name = "olives", price = 0, amount = 50, info = {}, type = "item", slot = 3, },
			[4] = { name = "basil", price = 0, amount = 50, info = {}, type = "item", slot = 4, },
			[5] = { name = "mozz", price = 0, amount = 50, info = {}, type = "item", slot = 5, },
			[6] = { name = "lettuce", price = 0, amount = 50, info = {}, type = "item", slot = 6, },
			[7] = { name = "pizzmushrooms", price = 0, amount = 50, info = {}, type = "item", slot = 7, },	
			[8] = { name = "tiramisu", price = 0, amount = 50, info = {}, type = "item", slot = 8, },	
			[9] = { name = "gelato", price = 0, amount = 50, info = {}, type = "item", slot = 9, },	
			[10] = { name = "medfruits", price = 0, amount = 50, info = {}, type = "item", slot = 10, },	
		}
	},
	FreezerItems = {
		label = "Freezer Store",
		slots = 2,
		items = {
			[1] = { name = "meat", price = 0, amount = 50, info = {}, type = "item", slot = 1, },
			[2] = { name = "squid", price = 0, amount = 50, info = {}, type = "item", slot = 2, },
		}
	},
}
Crafting = {
	Beer = {
		[1] = { ['ambeer'] = { } },
		[2] = { ['dusche'] = { } },
		[3] = { ['logger'] = { } },
		[4] = { ['pisswasser'] = { } },
		[5] = { ['pisswasser2'] = { } },
		[6] = { ['pisswasser3'] = { } },
	},
	Base = {
		[1] = { ['pizzabase'] = { ['pizzadough'] = 1, ['sauce'] = 1, } },
	},
	Oven = {
		[1] = { ['bolognese'] = { ['meat'] = 1, ['sauce'] = 1, } },
		[2] = { ['calamari'] = { ['squid'] = 1, ['sauce'] = 1, } },
		[3] = { ['meatball'] = { ['meat'] = 1, ['pasta'] = 1, } },
		[4] = { ['alla'] = { ['ham'] = 1, ['pasta'] = 1, ['vodka'] = 1, } },
		[5] = { ['pescatore'] = { ['squid'] = 1, } },
	},
	PizzaOven = {
		[1] = { ['margheritabox'] = { ['pizzabase'] = 1, ['mozz'] = 1, } },
		[2] = { ['marinarabox'] = { ['pizzabase'] = 1, ['basil'] = 1, } },
		[3] = { ['prosciuttiobox'] = { ['pizzabase'] = 1, ['mozz'] = 1, ['ham'] = 1, ['pizzmushrooms'] = 1, } },
		[4] = { ['diavolabox'] = { ['pizzabase'] = 1, ['mozz'] = 1, ['salami'] = 1, ['basil'] = 1, } },
		[5] = { ['capricciosabox'] = { ['pizzabase'] = 1, ['ham'] = 1, ['pizzmushrooms'] = 1, ['olives'] = 1, } },
		[6] = { ['vegetarianabox'] = { ['pizzabase'] = 1, ['mozz'] = 1, ['lettuce'] = 1, ['basil'] = 1, } },
	},
	ChoppingBoard = {
		[1] = { ['salami'] = { ['meat'] = 1, } },
		[2] = { ['ham'] = { ['meat'] = 1, } },
	},
}