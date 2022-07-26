-------------------------------
---------- CASE#2506 ----------
-------------------------------

Config = {}
-- Blips information
Config.Blips = {
	{title="Paydirt", colour=5, id=365, x = 2952.93, y = 2789.36, z = 42.48}, -- Blip info for paydirt rocks
	{title="Paydirt Processing", colour=5, id=365, x = 1110.7, y = -2008.46, z = 33.03}, -- Blip info for paydirt processing
}
Config.PaydirtMining = vector3(2952.93, 2789.36, 41.48) -- Location to spawn paydirt rocks
Config.PaydirtProcessing = vector3(1110.7, -2008.46, 32.03) -- Processing location change heading client side
Config.MiningItem = 'miningpermit' -- Item required to mine for paydirt
Config.MiningTime = math.random(5500,7500) -- Time in (ms) to mine paydirt
Config.PaydirtProcessTime = 5000 -- Time in (ms) to process paydirt
Config.PaydirtPremProcessTime = 6500 -- Time in (ms) to process premium paydirt
-- Items available from mining store, sell anything you like here.
Config.MiningStore = { 
    [1] = { name = "miningpermit",	price = 250,	amount = 100, info = {}, type = "item", slot = 1 },
}
-- Regular paydirt items, put whatever you want in here
Config.PaydirtItems = { 
	'iron',
	'plastic',
	'metalscrap',
	'aluminum',
	'steel',
	'glass',
	'rubber',
	'slakedlime',
	'lithium',
}
-- Premium paydirt items, put whatever you want in here
Config.PremPaydirtItems = {
	'diamond',
	'sapphire',
	'emerald',
	'ruby',
	'opal',
	'ruby',
	'pink_diamond',
	'black_diamond',
}
-- Prop used for mining
Config.Objects = {
    ['drill'] = 'prop_tool_jackham',
}	
Config.Lang = {
	['noinvent'] = 'Looks like your pockets are full..', -- Notification
	['miningfailed'] = 'Looks like theres nothing of interest here..', -- Notification
	['anypaydirt'] = 'You dont have any paydirt with you..', -- Notification
	['anyprempaydirt'] = 'You dont have any premium paydirt with you..', -- Notification
	['processedpaydirt'] = 'Successfully processed some paydirt!', -- Notification
	['processedprempaydirt'] = 'Successfully processed some premum paydirt!', -- Notification
	['processingpaydirt'] = 'Processing Paydirt..', -- Progressbar
	['processingprempaydirt'] = 'Processing Premium Paydirt..', -- Progressbar
	['miningrocks'] = 'Drilling For Paydirt..', -- Progressbar
}
