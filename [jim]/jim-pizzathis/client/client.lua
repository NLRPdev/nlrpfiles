local QBCore = exports['qb-core']:GetCoreObject()

PlayerJob = {}
local onDuty = false
local alcoholCount = 0
local Targets = {}
local Props = {}

local function jobCheck()
	canDo = true
	if not onDuty then TriggerEvent('QBCore:Notify', "Not clocked in!", 'error') canDo = false end
	return canDo
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then if PlayerData.job.name == "pizzathis" then TriggerServerEvent("QBCore:ToggleDuty") end end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo) PlayerJob = JobInfo onDuty = PlayerJob.onduty end) 
RegisterNetEvent('QBCore:Client:SetDuty', function(duty) onDuty = duty end)

AddEventHandler('onResourceStart', function(resource) if GetCurrentResourceName() ~= resource then return end
	QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job if PlayerData.job.name == "pizzathis" then onDuty = PlayerJob.onduty end end)
end)


CreateThread(function()
	local bossroles = {}
	for k, v in pairs(QBCore.Shared.Jobs["pizzathis"].grades) do
		if QBCore.Shared.Jobs["pizzathis"].grades[k].isboss == true then
			if bossroles["pizzathis"] ~= nil then
				if bossroles["pizzathis"] > tonumber(k) then bossroles["pizzathis"] = tonumber(k) end
			else bossroles["pizzathis"] = tonumber(k)	end
		end
	end
	for k, v in pairs(Config.Locations) do
		if Config.Locations[k].zoneEnable then
			JobLocation = PolyZone:Create(Config.Locations[k].zones, { name = Config.Locations[k].label, debugPoly = Config.Debug })
			JobLocation:onPlayerInOut(function(isPointInside) if not isPointInside and onDuty and PlayerJob.name == "pizzathis" then TriggerServerEvent("QBCore:ToggleDuty") end end)	
		end
	end
	for k, v in pairs(Config.Locations) do
		if Config.Locations[k].zoneEnable then
			blip = AddBlipForCoord(Config.Locations[k].blip)	
			SetBlipAsShortRange(blip, true)
			SetBlipSprite(blip, 89)
			SetBlipColour(blip, Config.Locations[k].blipcolor)
			SetBlipScale(blip, 0.7)
			SetBlipDisplay(blip, 6)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString("Chuck E Cheese")
			EndTextCommandSetBlipName(blip)
		end
	end
	Targets["PizzTray"] =
	exports['qb-target']:AddBoxZone("PizzTray", vector3(811.94, -755.57, 26.78), 0.6, 1.6, { name="PizzTray", heading = 0.0, debugPoly=Config.Debug, minZ = 26.58, maxZ = 27.58, }, 
		{ options = { {  event = "jim-pizzathis:Stash", icon = "fas fa-box-open", label = "Toppings Tray", stash = "Toppings", job = "pizzathis" }, }, distance = 1.0 })
	
	Targets["PizzBase"] =
	exports['qb-target']:AddBoxZone("PizzBase", vector3(811.42, -754.55, 26.78), 0.4, 0.4, { name="PizzBase", heading = 0.0, debugPoly=Config.Debug, minZ = 26.58, maxZ = 27.18, }, 
		{ options = { {  event = "jim-pizzathis:Crafting", icon = "fas fa-pizza-slice", label = "Prepare Pizza", job = "pizzathis", craftable = Crafting.Base, header = "Pizza Base" }, }, distance = 1.0 })
	
	Targets["PizzDough"] =	
	exports['qb-target']:AddBoxZone("PizzDough", vector3(806.98, -757.05, 26.78), 1.2, 3.2, { name="PizzDough", heading = 0.0, debugPoly=Config.Debug, minZ = 25.78, maxZ = 27.58, }, 
		{ options = { {  event = "jim-pizzathis:JustGive", icon = "fas fa-cookie", label = "Prepare Dough", job = "pizzathis", id = "pizzadough" }, }, distance = 1.0 })	
	
	Targets["PizzOven"] =
	exports['qb-target']:AddBoxZone("PizzOven", vector3(808.28, -761.19, 26.78), 2.8, 0.7, { name="PizzOven", heading = 0.0, debugPoly=Config.Debug, minZ = 26.18, maxZ = 27.38, }, 
		{ options = { {  event = "jim-pizzathis:Crafting", icon = "fas fa-temperature-high", label = "Use Oven", job = "pizzathis", craftable = Crafting.Oven, header = "Oven Menu" }, }, distance = 1.0 })
	
	Targets["PizzChop"] =
	exports['qb-target']:AddBoxZone("PizzChop", vector3(810.45, -765.17, 26.78), 0.6, 0.6, { name="PizzChop", heading = 0.0, debugPoly=Config.Debug, minZ = 26.18, maxZ = 27.38, }, 
		{ options = { {  event = "jim-pizzathis:Crafting", icon = "fas fa-utensils", label = "Use Chopping Board", job = "pizzathis", craftable = Crafting.ChoppingBoard, header = "Chopping Board" }, }, distance = 1.0	})

	Targets["PizzChop2"] =
	exports['qb-target']:AddBoxZone("PizzChop2", vector3(809.26, -761.19, 26.78), 0.55, 0.4, { name="PizzChop2", heading = 10.0, debugPoly=Config.Debug, minZ = 26.18, maxZ = 27.38, }, 
		{ options = { {  event = "jim-pizzathis:Crafting", icon = "fas fa-utensils", label = "Use Chopping Board", job = "pizzathis", craftable = Crafting.ChoppingBoard, header = "Chopping Board" }, }, distance = 1.0	})
	
	Targets["PizzBurner"] =
	exports['qb-target']:AddBoxZone("PizzBurner", vector3(814.05, -752.89, 26.78), 2.4, 1.2, { name="PizzBurner", heading = 0.0, debugPoly=Config.Debug, minZ = 25.98, maxZ = 27.98, }, 
		{ options = { {  event = "jim-pizzathis:Crafting", icon = "fas fa-temperature-high", label = "Use Stone Oven", job = "pizzathis", craftable = Crafting.PizzaOven, header = "Stone Pizza Oven" }, }, distance = 1.0 })

	Targets["PizzWine"] =
	exports['qb-target']:AddBoxZone("PizzWine", vector3(809.34, -761.84, 22.3), 0.4, 1.7, { name="PizzWine", heading = 0.0, debugPoly=Config.Debug, minZ = 21.3, maxZ = 22.9, }, 
		{ options = { {  event = "jim-pizzathis:Shop", icon = "fas fa-archive", label = "Open Wine Rack", job = "pizzathis", shop = Config.WineItems, }, }, distance = 1.5 })	
	Targets["PizzWine2"] =
	exports['qb-target']:AddBoxZone("PizzWine2", vector3(807.25, -761.79, 22.3), 0.4, 1.7, { name="PizzWine", heading = 0.0, debugPoly=Config.Debug, minZ = 21.3, maxZ = 22.9, }, 
		{ options = { {  event = "jim-pizzathis:Shop", icon = "fas fa-archive", label = "Open Wine Rack", job = "pizzathis", shop = Config.WineItems, }, }, distance = 1.5 })	
	
	Targets["PizzFridge"] =
	exports['qb-target']:AddBoxZone("PizzFridge", vector3(814.09, -750.07, 26.78), 0.6, 0.6, { name="PizzFridge", heading = 0.0, debugPoly=Config.Debug, minZ=25.98, maxZ=26.83 }, 
		{ options = { {  event = "jim-pizzathis:Shop", icon = "fas fa-archive", label = "Open Drink Fridge", job = "pizzathis", shop = Config.DrinkItems, }, }, distance = 1.5 })	
	Targets["PizzFridge2"] =
	exports['qb-target']:AddBoxZone("PizzFridge2", vector3(814.07, -748.64, 26.78), 0.6, 0.6, { name="PizzFridge2", heading = 0.0, debugPoly=Config.Debug, minZ=25.98, maxZ=26.83 }, 
		{ options = { {  event = "jim-pizzathis:Shop", icon = "fas fa-archive", label = "Open Drink Fridge", job = "pizzathis", shop = Config.DrinkItems, }, }, distance = 1.5 })	
	Targets["PizzFridge3"] =
	exports['qb-target']:AddBoxZone("PizzFridge3", vector3(805.68, -761.62, 26.78), 1.6, 0.6, { name="PizzFridge3", heading = 0.0, debugPoly=Config.Debug, minZ = 25.98, maxZ = 28.18, }, 
		{ options = { {  event = "jim-pizzathis:Shop", icon = "fas fa-temperature-low", label = "Open Food Fridge",  job = "pizzathis", shop = Config.FoodItems, }, }, distance = 2.0 })	
	Targets["PizzFreezer"] =
	exports['qb-target']:AddBoxZone("PizzFreezer", vector3(802.75, -756.85, 26.78), 0.6, 4.0, { name="PizzFreezer", heading = 0.0, debugPoly=Config.Debug, minZ = 25.78, maxZ = 28.58, }, 
		{ options = { {  event = "jim-pizzathis:Shop", icon = "fas fa-temperature-low", label = "Open Freezer", job = "pizzathis", shop = Config.FreezerItems }, }, distance = 1.0 })
	
	Targets["PizzWash1"] =
	exports['qb-target']:AddBoxZone("PizzWash1", vector3(809.47, -765.19, 26.78), 0.6, 0.8, { name="PizzWash1", heading = 0.0, debugPoly=Config.Debug, minZ = 26.58, maxZ = 27.38, }, 
		{ options = { { event = "jim-pizzathis:washHands", icon = "fas fa-hand-holding-water", label = "Wash Your Hands", }, }, distance = 1.5 })		
	Targets["PizzWash2"] =
	exports['qb-target']:AddBoxZone("PizzWash2", vector3(809.25, -760.15, 26.78), 0.8, 0.6, { name="PizzWash2", heading = 0.0, debugPoly=Config.Debug, minZ = 26.58, maxZ = 27.38, }, 
		{ options = { { event = "jim-pizzathis:washHands", icon = "fas fa-hand-holding-water", label = "Wash Your Hands" }, }, distance = 1.5 })		
	Targets["PizzWash3"] =
	exports['qb-target']:AddBoxZone("PizzWash3", vector3(813.35, -755.46, 26.78), 0.4, 0.8, { name="PizzWash3", heading = 0.0, debugPoly=Config.Debug, minZ = 26.58, maxZ = 27.38, }, 
		{ options = { { event = "jim-pizzathis:washHands", icon = "fas fa-hand-holding-water", label = "Wash Your Hands" }, }, distance = 1.2 })
	Targets["PizzWash4"] =
	exports['qb-target']:AddBoxZone("PizzWash4", vector3(800.88, -767.88, 26.78), 0.8, 0.6, { name="PizzWash4", heading = 0.0, debugPoly=Config.Debug, minZ = 26.58, maxZ = 27.38, }, 
		{ options = { { event = "jim-pizzathis:washHands", icon = "fas fa-hand-holding-water", label = "Wash Your Hands", job = "pizzathis" }, }, distance = 1.5 })		
	Targets["PizzWash5"] =
	exports['qb-target']:AddBoxZone("PizzWash5", vector3(800.85, -767.07, 26.78), 0.8, 0.6, { name="PizzWash5", heading = 0.0, debugPoly=Config.Debug, minZ = 26.58, maxZ = 27.38, }, 
		{ options = { { event = "jim-pizzathis:washHands", icon = "fas fa-hand-holding-water", label = "Wash Your Hands" }, }, distance = 1.5 })		
	Targets["PizzWash6"] =
	exports['qb-target']:AddBoxZone("PizzWash6", vector3(800.85, -761.18, 26.78), 0.8, 0.6, { name="PizzWash6", heading = 0.0, debugPoly=Config.Debug, minZ = 26.58, maxZ = 27.38, }, 
		{ options = { { event = "jim-pizzathis:washHands", icon = "fas fa-hand-holding-water", label = "Wash Your Hands" }, }, distance = 1.2 })	
	Targets["PizzWash7"] =
	exports['qb-target']:AddBoxZone("PizzWash7", vector3(800.89, -762.04, 26.78), 0.8, 0.6, { name="PizzWash7", heading = 0.0, debugPoly=Config.Debug, minZ = 26.58, maxZ = 27.38, }, 
		{ options = { { event = "jim-pizzathis:washHands", icon = "fas fa-hand-holding-water", label = "Wash Your Hands" }, }, distance = 1.2 })
	Targets["PizzWash8"] =
	exports['qb-target']:AddBoxZone("PizzWash8", vector3(809.9, -765.32, 31.27), 0.6, 0.6, { name="PizzWash8", heading = 0.0, debugPoly=Config.Debug, minZ=30.67, maxZ=31.67 }, 
		{ options = { { event = "jim-pizzathis:washHands", icon = "fas fa-hand-holding-water", label = "Wash Your Hands" }, }, distance = 1.2 })
	Targets["PizzWash9"] =
	exports['qb-target']:AddBoxZone("PizzWash9", vector3(808.91, -765.34, 31.27), 0.6, 0.6, { name="PizzWash9", heading = 0.0, debugPoly=Config.Debug, minZ=30.67, maxZ=31.67 }, 
		{ options = { { event = "jim-pizzathis:washHands", icon = "fas fa-hand-holding-water", label = "Wash Your Hands" }, }, distance = 1.2 })
		
	Targets["PizzCounter"] =
	exports['qb-target']:AddBoxZone("PizzCounter", vector3(810.98, -752.9, 26.78), 0.6, 0.6, { name="PizzCounter", heading = 9.0, debugPoly=Config.Debug, minZ = 26.78, maxZ = 27.58, }, 
		{ options = { { event = "jim-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Counter", stash = "CounterRight" }, }, distance = 2.0 })
	Targets["PizzCounter2"] =
	exports['qb-target']:AddBoxZone("PizzCounter2", vector3(810.93, -749.92, 26.78), 0.7, 0.7, { name="PizzCounter2", heading = 30.0, debugPoly=Config.Debug, minZ = 26.78, maxZ = 27.58, }, 
		{ options = { { event = "jim-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Counter", stash = "CounterLeft" }, }, distance = 2.0 })
		
	Targets["PizzReceipt"] =
	exports['qb-target']:AddBoxZone("PizzReceipt", vector3(811.32, -750.77, 26.78), 0.7, 0.35, { name="PizzReceipt", heading = 0.0, debugPoly=Config.Debug, minZ = 26.78, maxZ = 27.18, }, 
		{ options = { { event = "jim-payments:client:Charge", icon = "fas fa-credit-card", label = "Charge Customer", job = "pizzathis",
						img = "<center><p><img src=https://logos-world.net/wp-content/uploads/2021/08/Chuck-E.-Cheeses-first-era-Logo-1984-1989.png width=200px></p>",
		} }, distance = 2.0 })		
	Targets["PizzReceipt2"] =
	exports['qb-target']:AddBoxZone("PizzReceipt2", vector3(811.29, -752.09, 26.78), 0.7, 0.35, { name="PizzReceipt2", heading = 0.0, debugPoly=Config.Debug, minZ = 26.78, maxZ = 27.18, }, 
		{ options = { { event = "jim-payments:client:Charge", icon = "fas fa-credit-card", label = "Charge Customer", job = "pizzathis",
						img = "<center><p><img src=https://logos-world.net/wp-content/uploads/2021/08/Chuck-E.-Cheeses-first-era-Logo-1984-1989.png width=200px></p>",
		} }, distance = 2.0	})		

	Targets["PizzTap"] =
	exports['qb-target']:AddBoxZone("PizzTap", vector3(814.14, -749.35, 26.78), 0.9, 0.6, { name="PizzTap", heading = 0.0, debugPoly=Config.Debug, minZ = 26.78, maxZ = 27.48, }, 
		{ options = { { event = "jim-pizzathis:Crafting", icon = "fas fa-beer", label = "Pour Beer", job = "pizzathis", craftable = Crafting.Beer, header = "Beer Menu" }, }, distance = 1.5 })

	Targets["PizzCoffee"] =
	exports['qb-target']:AddBoxZone("PizzCoffee", vector3(808.78, -765.35, 26.78), 0.6, 0.6, { name="PizzCoffee", heading = 0.0, debugPoly=Config.Debug, minZ = 26.58, maxZ = 27.58, }, 
		{ options = { { event = "jim-pizzathis:JustGive", icon = "fas fa-mug-hot", label = "Pour Coffee", job = "pizzathis", id = "coffee"}, }, distance = 2.0 })				
	Targets["PizzCoffee2"] =
	exports['qb-target']:AddBoxZone("PizzCoffee2", vector3(811.49, -764.82, 26.78), 1.6, 0.63, { name="PizzCoffee2", heading = 0.0, debugPoly=Config.Debug, minZ = 26.58, maxZ = 27.58, }, 
		{ options = { { event = "jim-pizzathis:JustGive", icon = "fas fa-mug-hot", label = "Pour Coffee", job = "pizzathis", id = "coffee"}, }, distance = 2.0 })
		
	Targets["PizzClockin"] =
	exports['qb-target']:AddBoxZone("PizzClockin", vector3(807.15, -761.83, 31.27), 1.2, 0.2, { name="PizzClockin", heading = 0.0, debugPoly=Config.Debug, minZ = 31.27, maxZ = 32.52, }, 
		{ options = { { type = "server", event = "QBCore:ToggleDuty", icon = "fas fa-user-check", label = "Toggle Duty", job = "pizzathis" }, }, distance = 2.0 })				
	Targets["PizzClockin2"] =
	exports['qb-target']:AddBoxZone("PizzClockin2", vector3(799.17, -767.91, 28.35), 1.2, 1.2, { name="PizzClockin2", heading = 0.0, debugPoly=Config.Debug, minZ = 25.78, maxZ = 27.78, }, 
		{ options = { { type = "server", event = "QBCore:ToggleDuty", icon = "fas fa-user-check", label = "Toggle Duty", job = "pizzathis" }, }, distance = 2.0 })
		
	Targets["PizzBoss"] =
	exports['qb-target']:AddBoxZone("PizzBoss", vector3(797.46, -751.52, 31.27), 1.5, 1.0, { name="PizzBoss", heading = 90.0, debugPoly=Config.Debug, minZ = 30.87, maxZ = 31.87, }, 
		{ options = { { event = "qb-bossmenu:client:OpenMenu", icon = "fas fa-list", label = "Open Bossmenu", job = bossroles, }, }, distance = 2.0 })
	Targets["PizzBoss2"] =
	exports['qb-target']:AddBoxZone("PizzBoss2", vector3(794.91, -767.06, 31.27), 0.6, 0.6, { name="PizzBoss2", heading = 90.0, debugPoly=Config.Debug, minZ = 30.87, maxZ = 31.87, }, 
		{ options = { { event = "qb-bossmenu:client:OpenMenu", icon = "fas fa-list", label = "Open Bossmenu", job = bossroles, }, }, distance = 2.0 })
	
	Targets["PizzTable"] =
	exports['qb-target']:AddBoxZone("PizzTable", vector3(807.08, -751.57, 26.78), 1.0, 1.0, { name="PizzTable", heading = 0.0, debugPoly=Config.Debug, minZ=25.98, maxZ=27.18 }, 
		{ options = { { event = "jim-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table1" }, }, distance = 2.0 })
	Targets["PizzTable2"] =
	exports['qb-target']:AddBoxZone("PizzTable2", vector3(803.13, -751.59, 26.78), 1.0, 1.0, { name="PizzTable2", heading = 0.0, debugPoly=Config.Debug, minZ=25.98, maxZ=27.18 }, 
		{ options = { { event = "jim-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table2" }, }, distance = 2.0 })
	Targets["PizzTable3"] =
	exports['qb-target']:AddBoxZone("PizzTable3", vector3(799.13, -751.57, 26.78), 1.0, 1.0, { name="PizzTable3", heading = 0.0, debugPoly=Config.Debug, minZ=25.98, maxZ=27.18 }, 
		{ options = { { event = "jim-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table3" }, }, distance = 2.0 })
	Targets["PizzTable4"] =
	exports['qb-target']:AddBoxZone("PizzTable4", vector3(797.96, -748.86, 26.78), 1.0, 1.0, { name="PizzTable4", heading = 0.0, debugPoly=Config.Debug, minZ=25.98, maxZ=27.18 }, 
		{ options = { { event = "jim-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table4" }, }, distance = 2.0 })
	Targets["PizzTable5"] =
	exports['qb-target']:AddBoxZone("PizzTable5", vector3(795.25, -751.55, 26.78), 1.0, 1.0, { name="PizzTable5", heading = 0.0, debugPoly=Config.Debug, minZ=25.98, maxZ=27.18 }, 
		{ options = { { event = "jim-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table5" }, }, distance = 2.0 })
	Targets["PizzTable6"] =
	exports['qb-target']:AddBoxZone("PizzTable6", vector3(799.46, -755.04, 26.78), 1.0, 1.0, { name="PizzTable6", heading = 0.0, debugPoly=Config.Debug, minZ=25.98, maxZ=27.18 }, 
		{ options = { { event = "jim-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table6" }, }, distance = 2.0 })
	Targets["PizzTable7"] =
	exports['qb-target']:AddBoxZone("PizzTable7", vector3(807.71, -754.9, 26.78), 2.0, 0.8, { name="PizzTable7", heading = 0.0, debugPoly=Config.Debug, minZ=26.18, maxZ=26.98 }, 
		{ options = { { event = "jim-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table7" }, }, distance = 2.0 })
	Targets["PizzTable8"] =
	exports['qb-target']:AddBoxZone("PizzTable8", vector3(805.61, -754.89, 26.78), 2.0, 0.8, { name="PizzTable8", heading = 0.0, debugPoly=Config.Debug, minZ=26.18, maxZ=26.98 }, 
		{ options = { { event = "jim-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table8" }, }, distance = 2.0 })
	Targets["PizzTable9"] =
	exports['qb-target']:AddBoxZone("PizzTable9", vector3(803.51, -754.9, 26.78), 2.0, 0.8, { name="PizzTable9", heading = 0.0, debugPoly=Config.Debug, minZ=26.18, maxZ=26.98 }, 
		{ options = { { event = "jim-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table9" }, }, distance = 2.0 })
	Targets["PizzTable10"] =
	exports['qb-target']:AddBoxZone("PizzTable10", vector3(801.42, -754.93, 26.78), 2.0, 0.8, { name="PizzTable10", heading = 0.0, debugPoly=Config.Debug, minZ=26.18, maxZ=26.98 }, 
		{ options = { { event = "jim-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table10" }, }, distance = 2.0 })
	Targets["PizzTable11"] =
	exports['qb-target']:AddBoxZone("PizzTable11", vector3(799.32, -757.63, 26.78), 0.8, 1.4, { name="PizzTable11", heading = 0.0, debugPoly=Config.Debug, minZ=26.18, maxZ=26.98 }, 
		{ options = { { event = "jim-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table11" }, }, distance = 2.0 })
	Targets["PizzTable12"] =
	exports['qb-target']:AddBoxZone("PizzTable12", vector3(799.32, -759.72, 26.78), 0.8, 1.4, { name="PizzTable12", heading = 0.0, debugPoly=Config.Debug, minZ=26.18, maxZ=26.98 }, 
		{ options = { { event = "jim-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table12" }, }, distance = 2.0 })
	-- Quick Prop Changes
	if not Props["box1"] then
		local prop = `prop_pizza_box_01`
		RequestModel(prop)
		while not HasModelLoaded(prop) do Citizen.Wait(1) end
		Props["box1"] = CreateObject(prop, 810.94, -749.94, 28.03-1.0, false,false,false)
		SetEntityHeading(Props["box1"],-150.0)
		FreezeEntityPosition(Props["box1"], true)
	end
	if not Props["box2"] then
		local prop = `prop_pizza_box_02`
		RequestModel(prop)
		while not HasModelLoaded(prop) do Citizen.Wait(1) end
		Props["box2"] = CreateObject(prop,810.98, -752.89, 28.03-1.0,false,false,false)
		SetEntityHeading(Props["box2"],-80.0)
		FreezeEntityPosition(Props["box2"], true)
	end
	if not Props["clockin"] then
		local prop = `v_ind_tor_clockincard`
		RequestModel(prop)
		while not HasModelLoaded(prop) do Citizen.Wait(1) end
		Props["clockin"] = CreateObject(prop,807.07, -761.83, 31.27,false,false,false)
		SetEntityHeading(Props["clockin"], -270.0)
		FreezeEntityPosition(Props["clockin"], true)
	end
end)

RegisterNetEvent('jim-pizzathis:washHands', function()
    QBCore.Functions.Progressbar('washing_hands', 'Washing hands', 5000, false, false, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
	{ animDict = "mp_arresting", anim = "a_uncuff", flags = 8, }, {}, {}, function()
		TriggerEvent('QBCore:Notify', "You've washed your hands!", 'success')
	end, function()
        TriggerEvent('inventory:client:busy:status', false)
		TriggerEvent('QBCore:Notify', "Cancelled", 'error')
    end, "fas fa-hand-holding-droplet")
end)
RegisterNetEvent('jim-pizzathis:Shop', function(data)
	if not jobCheck() then return end
	local event = "inventory:server:OpenInventory"
	if Config.JimShop then event = "jim-shops:ShopOpen" end
	TriggerServerEvent(event, "shop", "pizzathis", data.shop)
end)
RegisterNetEvent('jim-pizzathis:Stash', function(data) TriggerServerEvent("inventory:server:OpenInventory", "stash", "pizza_"..data.stash) TriggerEvent("inventory:client:SetCurrentStash", "pizza_"..data.stash) end)

RegisterNetEvent('jim-pizzathis:Crafting:MakeItem', function(data)
	QBCore.Functions.TriggerCallback('jim-pizzathis:Crafting:get', function(amount) 
		if not amount then TriggerEvent('QBCore:Notify', "You don't have the correct ingredients", 'error') else TriggerEvent('jim-pizzathis:Crafting:ItemProgress', data) end		
	end, data.item, data.craft)
end)

function FoodProgress(ItemMake)
	if ItemMake == "pizzadough" then
		bartext = "Grabbing "..QBCore.Shared.Items[ItemMake].label
		bartime = 3000
		animDictNow = "anim@heists@prison_heiststation@cop_reactions"
		animNow = "cop_b_idle"	
	elseif ItemMake == "coffee" then
		bartext = "Pouring "..QBCore.Shared.Items[ItemMake].label
		bartime = 1500
		animDictNow = "mp_ped_interaction"
		animNow = "handshake_guy_a"
	end
	QBCore.Functions.Progressbar('making_food', bartext, bartime, false, false, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, 
	{ animDict = animDictNow, anim = animNow, flags = 8, },	{}, {}, function()  
		TriggerServerEvent('jim-pizzathis:Crafting:GetItem', ItemMake)
		StopAnimTask(PlayerPedId(), animDictNow, animNow, 1.0)
	end, function() -- Cancel
		TriggerEvent('inventory:client:busy:status', false)
		TriggerEvent('QBCore:Notify', "Cancelled!", 'error')
	end, ItemMake)
end

RegisterNetEvent('jim-pizzathis:JustGive', function(data) 
	if not jobCheck() then return end 
	FoodProgress(data.id) 
end)

RegisterNetEvent('jim-pizzathis:Crafting:ItemProgress', function(data)
	local bartext = ""
	bartime = 3000
	animDictNow = "anim@heists@prison_heiststation@cop_reactions"
	animNow = "cop_b_idle"
	for i = 1, #Crafting.ChoppingBoard do
		for k, v in pairs(Crafting.ChoppingBoard[i]) do
			if data.item == k then
				bartext = "Mixing a "
				bartime = 3000
				animDictNow = "anim@heists@prison_heiststation@cop_reactions"
				animNow = "cop_b_idle"
			end
		end
	end
	for i = 1, #Crafting.Oven do
		for k, v in pairs(Crafting.Oven[i]) do
			if data.item == k then
				bartext = "Cooking "
				bartime = 3000
				animDictNow = "amb@prop_human_bbq@male@base"
				animNow = "base"
			end
		end
	end		
	for i = 1, #Crafting.PizzaOven do
		for k, v in pairs(Crafting.PizzaOven[i]) do
			if data.item == k then
				bartext = "Cooking "
				bartime = 3000
				animDictNow = "amb@prop_human_bbq@male@base"
				animNow = "base"
			end
		end
	end	
	for i = 1, #Crafting.Beer do
		for k, v in pairs(Crafting.Beer[i]) do
			if data.item == k then
				bartext = "Pouring "
				bartime = 3000
				animDictNow = "mp_ped_interaction"
				animNow = "handshake_guy_a"
			end
		end
	end
	QBCore.Functions.Progressbar('making_food', bartext..QBCore.Shared.Items[data.item].label, bartime, false, true, { disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false, }, 
	{ animDict = animDictNow, anim = animNow, flags = 8, },
	{}, {}, function()  
		TriggerServerEvent('jim-pizzathis:Crafting:GetItem', data.item, data.craft)
		TriggerEvent("jim-pizzathis:Crafting", data)
	end, function() -- Cancel
		TriggerEvent('inventory:client:busy:status', false)
	end, data.item)
end)

RegisterNetEvent('jim-pizzathis:client:Menu:Close', function() exports['qb-menu']:closeMenu() end)

RegisterNetEvent('jim-pizzathis:Crafting', function(data)
	local Menu = {}
	Menu[#Menu + 1] = { header = data.header, txt = "", isMenuHeader = true }
	Menu[#Menu + 1] = { icon = "fas fa-circle-xmark", header = "", txt = "Close", params = { event = "jim-pizzathis:client:Menu:Close" } }
	for i = 1, #data.craftable do
		for k, v in pairs(data.craftable[i]) do
			if k ~= "amount" then
				local text = ""
				setheader = "<img src=nui://"..Config.img..QBCore.Shared.Items[k].image.." width=35px onerror='this.onerror=null; this.remove();'>"..QBCore.Shared.Items[tostring(k)].label
				if data.craftable[i]["amount"] ~= nil then setheader = setheader.." x"..data.craftable[i]["amount"] end
				if Config.CheckMarks then
					local p = promise.new()
					QBCore.Functions.TriggerCallback('jim-pizzathis:Crafting:get', function(cb) p:resolve(cb) end, k, data.craftable[i])
					if Citizen.Await(p) then setheader = setheader.." ✅" end
				end
				for l, b in pairs(data.craftable[i][tostring(k)]) do
					if b == 1 then number = "" else number = " x"..b end
					text = text.."- "..QBCore.Shared.Items[l].label..number.."<br>"
					settext = text
				end
				Menu[#Menu + 1] = { icon = k, header = setheader, txt = settext, params = { event = "jim-pizzathis:Crafting:MakeItem", args = { item = k, craft = data.craftable[i], craftable = data.craftable, header = data.header } } }
				settext, setheader = nil
			end
		end Wait(0)
	end
	exports['qb-menu']:openMenu(Menu)
end)

RegisterNetEvent('jim-pizzathis:client:Eat', function(itemName)
	if itemName == "capricciosa" or itemName == "diavola" or itemName == "marinara" or itemName == "margherita" or itemName == "prosciuttio" or itemName == "vegetariana" then TriggerEvent('animations:client:EmoteCommandStart', {"pizza"})
	elseif itemName == "tiramisu" or itemName == "gelato" then TriggerEvent('animations:client:EmoteCommandStart', {"bowl"})
	elseif itemName == "medfruits" then TriggerEvent('animations:client:EmoteCommandStart', {"pineapple"})
	elseif itemName == "calamari" or itemName == "bolognese" or itemName == "meatball" or itemName == "alla" or itemName == "pescatore" then TriggerEvent('animations:client:EmoteCommandStart', {"foodbowl"}) end
    QBCore.Functions.Progressbar("eat_something", "Eating "..QBCore.Shared.Items[itemName].label.."..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove", 1)
		TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		if QBCore.Shared.Items[itemName].thirst then TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
		if QBCore.Shared.Items[itemName].hunger then TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end
        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
		if Config.RewardItem == itemName then 
			local prize = Config.RewardPool[math.random(1, #Config.RewardPool)]
			TriggerServerEvent("QBCore:Server:AddItem", prize, 1)
			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[prize], "add", 1)
		end
	end, function() -- Cancel
	    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, itemName)
end)

RegisterNetEvent('jim-pizzathis:client:DrinkAlcohol', function(itemName)
	if itemName == "ambeer" then TriggerEvent('animations:client:EmoteCommandStart', {"beer3"})
	elseif itemName == "dusche" then TriggerEvent('animations:client:EmoteCommandStart', {"beer1"})
	elseif itemName == "logger" then TriggerEvent('animations:client:EmoteCommandStart', {"beer2"})
	elseif itemName == "pisswasser" then TriggerEvent('animations:client:EmoteCommandStart', {"beer4"})
	elseif itemName == "pisswasser2" then TriggerEvent('animations:client:EmoteCommandStart', {"beer5"})
	elseif itemName == "pisswasser3" then TriggerEvent('animations:client:EmoteCommandStart', {"beer6"})
	elseif itemName == "amarone" or itemName == "barbera" or itemName == "housered" or itemName == "rosso" then	TriggerEvent('animations:client:EmoteCommandStart', {"redwine"})
	elseif itemName == "dolceto" or itemName == "housewhite" then TriggerEvent('animations:client:EmoteCommandStart', {"whitewine"})
	else TriggerEvent('animations:client:EmoteCommandStart', {"flute"}) end
    QBCore.Functions.Progressbar("snort_coke", "Drinking "..QBCore.Shared.Items[itemName].label.."..", math.random(3000, 6000), false, true, { disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true, },
		{}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove", 1)
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
		if QBCore.Shared.Items[itemName].thirst then TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
		if QBCore.Shared.Items[itemName].hunger then TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end
        alcoholCount = alcoholCount + 1
        if alcoholCount > 1 and alcoholCount < 4 then TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
        elseif alcoholCount >= 4 then TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
			AlienEffect()
        end
        if Config.RewardItem == itemName then 
			local prize = Config.RewardPool[math.random(1, #Config.RewardPool)]
			TriggerServerEvent("QBCore:Server:AddItem", prize, 1)
			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[prize], "add", 1)
		end
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Cancelled..", "error")
	end, function() -- Cancel
	    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, itemName)
end)

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    local ped = PlayerPedId()
    RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK") 
    while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
      Citizen.Wait(0)
    end    
    SetPedCanRagdoll( ped, true )
    ShakeGameplayCam('DRUNK_SHAKE', 2.80)
    SetTimecycleModifier("Drunk")
    SetPedMovementClipset(ped, "MOVE_M@DRUNK@VERYDRUNK", true)
    SetPedMotionBlur(ped, true)
    SetPedIsDrunk(ped, true)
    Wait(1500)
    SetPedToRagdoll(ped, 5000, 1000, 1, false, false, false )
    Wait(13500)
    SetPedToRagdoll(ped, 5000, 1000, 1, false, false, false )
    Wait(120500)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(ped, 0)
    SetPedIsDrunk(ped, false)
    SetPedMotionBlur(ped, false)
    AnimpostfxStopAll()
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(45000, 60000))    
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end

RegisterNetEvent('jim-pizzathis:client:Drink', function(itemName)
	if itemName == "sprunk" or itemName == "sprunklight" then TriggerEvent('animations:client:EmoteCommandStart', {"sprunk"})
	elseif itemName == "ecola" or itemName == "ecolalight" then TriggerEvent('animations:client:EmoteCommandStart', {"ecola"}) end
    QBCore.Functions.Progressbar("drink_something", "Drinking "..QBCore.Shared.Items[itemName].label.."..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove", 1)
		TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		if QBCore.Shared.Items[itemName].thirst then TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
		if QBCore.Shared.Items[itemName].hunger then TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end
		if Config.RewardItem == itemName then 
			local prize = Config.RewardPool[math.random(1, #Config.RewardPool)]
			TriggerServerEvent("QBCore:Server:AddItem", prize, 1)
			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[prize], "add", 1)
		end
	end, function() -- Cancel
	    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, itemName)
end)

AddEventHandler('onResourceStop', function(r) if r ~= GetCurrentResourceName() then return end
	for k, v in pairs(Props) do	DeleteEntity(Props[k]) end
	for k, v in pairs(Targets) do exports['qb-target']:RemoveZone(k) end
end)