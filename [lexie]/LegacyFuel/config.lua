Config = {}

-- LixeiroCharmoso: Gas station script settings
Config.defaultGasPrice = 10.00
Config.defaultGasStock = 9999
Config.GasStationOwner = {
	["gas_station_1"] = {264.95275878906,-1259.4567871094,29.142911911011,30},
	["gas_station_2"] = {819.61047363281,-1028.2071533203,26.404321670532,30},
	["gas_station_3"] = {1208.6068115234,-1402.2863769531,35.224140167236,30},
	["gas_station_4"] = {1180.9593505859,-329.84280395508,69.316436767578,30},
	["gas_station_5"] = {620.80499267578,268.73849487305,103.08948516846,30},
	["gas_station_6"] = {2581.1779785156,362.01254272461,108.46883392334,30},
	["gas_station_7"] = {175.55857849121,-1562.2135009766,29.264209747314,30},
	["gas_station_8"] = {-319.42581176758,-1471.8182373047,30.548692703247,30},
	["gas_station_9"] = {1785.9000244141,3330.9035644531,41.377250671387,30},
	["gas_station_10"] = {49.802303314209,2779.318359375,58.043937683105,30},
	["gas_station_11"] = {263.92358398438,2607.4140625,44.983062744141,30},
	["gas_station_12"] = {1039.1220703125,2671.30859375,39.550872802734,30},
	["gas_station_13"] = {1208.0380859375,2660.4892578125,37.899772644043,30},
	["gas_station_14"] = {2539.3337402344,2594.61328125,37.944820404053,30},
	["gas_station_15"] = {2679.9396972656,3264.0981445313,55.240585327148,30},
	["gas_station_16"] = {2005.0074462891,3774.2006835938,32.40393447876,30},
	["gas_station_17"] = {1687.263671875,4929.6328125,42.078086853027,30},
	["gas_station_18"] = {1702.0052490234,6416.9975585938,32.763767242432,30},
	["gas_station_19"] = {179.82470703125,6602.8408203125,31.868196487427,30},
	["gas_station_19"] = {165.67567443848,6616.951171875,31.900749206543,50},
	["gas_station_20"] = {-94.206100463867,6419.4975585938,31.489490509033,30},
	["gas_station_21"] = {-2555.1257324219,2334.2705078125,33.078022003174,30},
	["gas_station_22"] = {-1799.4152832031,802.8154296875,138.65368652344,30},
	["gas_station_23"] = {-1436.9724121094,-276.55426025391,46.207653045654,30},
	["gas_station_24"] = {-2096.5913085938,-321.48611450195,13.168619155884,30},
	["gas_station_25"] = {-723.298828125,-935.55322265625,19.213928222656,30},
	["gas_station_26"] = {-525.35266113281,-1211.3215332031,18.184829711914,30},
	["gas_station_27"] = {-70.514175415039,-1761.2590332031,29.655626296997,30},
	["gas_station_28"] = {809.88, -790.09, 26.20, 30},
}

-- What should the price of jerry cans be?
Config.JerryCanCost = 2000
Config.RefuelWithJerryCanCost = 1000
Config.RefillCost = 1000 -- If it is missing half of it capacity, this amount will be divided in half, and so on.

-- What keys are disabled while you're fueling.
Config.DisableKeys = {0, 22, 23, 24, 29, 30, 31, 37, 44, 56, 82, 140, 166, 167, 168, 170, 288, 289, 311, 323}

-- Fuel decor - No need to change this, just leave it.
Config.FuelDecor = "_FUEL_LEVEL"

-- Want to use the HUD? Turn this to true.
Config.EnableHUD = false

-- Configure blips here. Turn both to false to disable blips all together.
Config.ShowNearestGasStationOnly = true
Config.ShowAllGasStations = false

-- Configure the strings as you wish here.
Config.Strings = {
	ExitVehicle = "Exit the vehicle to refuel",
	EToRefuelJerryCan = "Press ~g~E ~w~to refuel vehicle for ~g~$",
	EToRefuel = "Press ~g~E ~w~to refuel vehicle",
	JerryCanEmpty = "Jerry can is empty",
	FullTank = "Tank is full",
	CancelFuelingJerryCan = "Press ~g~E ~w~to cancel the fueling",
	PurchaseJerryCan = "Press ~g~E ~w~to purchase a jerry can for ~g~$" .. Config.JerryCanCost,
	JerryCanFull = "Jerry can is full",
	JerryCan = "Gas can",
	Vehicle = "Vehicle",
}

Config.PumpModels = {
	[-2007231801] = true,
	[1339433404] = true,
	[1694452750] = true,
	[1933174915] = true,
	[-462817101] = true,
	[-469694731] = true,
	[-164877493] = true,
	[318466] = true
}

-- Blacklist certain vehicles. Use names or hashes. https://wiki.gtanet.work/index.php?title=Vehicle_Models
Config.Blacklist = {
	"veto2",
	--276773164
}

-- Do you want the HUD removed from showing in blacklisted vehicles?
Config.RemoveHUDForBlacklistedVehicle = true

-- Class multipliers. If you want SUVs to use less fuel, you can change it to anything under 1.0, and vise versa.
Config.Classes = {
	[0] = 0.6, -- Compacts
	[1] = 0.6, -- Sedans
	[2] = 0.6, -- SUVs
	[3] = 0.6, -- Coupes
	[4] = 0.6, -- Muscle
	[5] = 0.6, -- Sports Classics
	[6] = 0.6, -- Sports
	[7] = 0.6, -- Super
	[8] = 0.6, -- Motorcycles
	[9] = 0.6, -- Off-road
	[10] = 0.6, -- Industrial
	[11] = 0.6, -- Utility
	[12] = 0.6, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 0.0, -- Boats
	[15] = 0.0, -- Helicopters
	[16] = 0.0, -- Planes
	[17] = 0.3, -- Service
	[18] = 0.3, -- Emergency
	[19] = 0.6, -- Military
	[20] = 0.6, -- Commercial
	[21] = 0.6, -- Trains
}

-- The left part is at percentage RPM, and the right is how much fuel (divided by 10) you want to remove from the tank every second
Config.FuelUsage = {
	[1.0] = 1.4,
	[0.9] = 1.2,
	[0.8] = 1.0,
	[0.7] = 0.9,
	[0.6] = 0.8,
	[0.5] = 0.7,
	[0.4] = 0.5,
	[0.3] = 0.4,
	[0.2] = 0.2,
	[0.1] = 0.1,
	[0.0] = 0.0,
}

Config.GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253),
	vector3(809.88, -790.09, 26.20)
}

Config.EnableToxicPumpNozzles = false -- Set this as true if you are using the Toxic Gas Pump Nozzles script (https://tox-scripts.tebex.io/package/4829274)