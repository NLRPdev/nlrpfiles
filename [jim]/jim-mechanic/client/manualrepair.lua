local QBCore = exports['qb-core']:GetCoreObject()

Config.RepairLocations = {
    --Add your poly zone box locations and job name for each store and it will add it to the qb-target loop above
    { coords = vector4(121.0, -3047.69, 7.04, 270.11), }, -- TUNERS GARAGE
	{ coords = vector4(-45.27, -1048.43, 28.4, 250.0), }, -- BENNYS NEXT TO PDM
}

local bench = {}
CreateThread(function()
	for k, v in pairs(Config.RepairLocations) do
		RequestModel(`gr_prop_gr_bench_03a`) while not HasModelLoaded(`gr_prop_gr_bench_03a`) do Citizen.Wait(2) end
		bench[#bench+1] = CreateObject(`gr_prop_gr_bench_03a`,v.coords.x, v.coords.y, v.coords.z-2.4,false,false,false)
		SetEntityHeading(bench[#bench], v.coords.a-180)
		FreezeEntityPosition(bench[#bench], true)
		exports['qb-target']:AddBoxZone("repairbench"..k, v.coords, 1.2, 4.2, { name="repairbench"..k, heading = v.coords.a, debugPoly=Config.Debug, minZ = v.coords.z-1, maxZ = v.coords.z+1.4, }, 
			{ options = { { event = "jim-mechanic:client:Manual:Menu", icon = "fas fa-cogs", label = Loc[Config.Lan]["police"].userepair, }, }, distance = 5.0 })
	end
end)

RegisterNetEvent('jim-mechanic:client:Manual:Menu', function()
	if Config.requireDutyCheck then
		local p = promise.new()	QBCore.Functions.TriggerCallback('jim-mechanic:mechCheck', function(cb) p:resolve(cb) end) 
		if Citizen.Await(p) == true then TriggerEvent("QBCore:Notify", Config.dutyMessage, "error") return end
	end
	local playerPed = PlayerPedId()
	local validMods = {}
	local vehicle = nil
	if not outCar() then return end
	vehicle = GetVehiclePedIsIn(playerPed, false)
	
	local health = 0
	if Config.repairEngine then
		health = math.ceil((GetVehicleEngineHealth(vehicle)/10)/2)+math.ceil((GetVehicleBodyHealth(vehicle)/10)/2)	
	elseif not Config.repairEngine then
		health = math.ceil((GetVehicleBodyHealth(vehicle)/10))
	end
	
	local cost = 0
	if Config.ManualRepairBased then
		for k, v in pairs(QBCore.Shared.Vehicles) do
			if tonumber(v.hash) == GetEntityModel(vehicle) then
				local percent = (Config.ManualRepairPercent / 100)
				if Config.Debug then print("Vehicle: "..v.hash.. " ("..QBCore.Shared.Vehicles[k].name..")") end
				cost = math.ceil((QBCore.Shared.Vehicles[k].price * percent) - math.ceil((health/100) * (QBCore.Shared.Vehicles[k].price * percent)))
			end
		end
	else cost = Config.ManualRepairCost --[[ - math.ceil((health/100) * Config.ManualRepairCost) --]]end
	
	local p2 = promise.new()
	QBCore.Functions.TriggerCallback('jim-mechanic:checkCash', function(cb) p2:resolve(cb) end) 
	local cash = Citizen.Await(p2)
	
	if GetPedInVehicleSeat(vehicle, -1) ~= playerPed then return end
	if IsPedInAnyVehicle(playerPed, false) then
		local RepairMenu = {}
			RepairMenu[#RepairMenu+1] = {  isMenuHeader = true, header = searchCar(vehicle),
											txt = "Class: "..getClass(vehicle).."<br>"..Loc[Config.Lan]["check"].plate..trim(GetVehicleNumberPlateText(vehicle)).."]<br>"..searchDist(vehicle)}
			RepairMenu[#RepairMenu+1] = { icon = "fas fa-circle-xmark", header = string.gsub(Loc[Config.Lan]["common"].close, "❌", " "), params = { event = "jim-mechanic:client:Menu:Close" } }
			
			local settext = Loc[Config.Lan]["repair"].engine..": "..math.ceil((GetVehicleEngineHealth(vehicle)/10)).."%<br>"..Loc[Config.Lan]["repair"].body..": "..math.ceil((GetVehicleBodyHealth(vehicle)/10)).."%"
			if not Config.repairEngine then settext = Loc[Config.Lan]["repair"].body..": "..math.ceil((GetVehicleBodyHealth(vehicle)/10)).."%" end
			
			local seticon = "fas fa-wrench" local greyed = false local check = " ✅"
			if cost == 0 then greyed = true check = "" end
			if cash < cost then seticon = "fas fa-wallet" greyed = true check = " ❌" end
			RepairMenu[#RepairMenu+1] = { isMenuHeader = greyed,
										  icon = seticon,
										  header = Loc[Config.Lan]["police"].repair.." - $"..cost..check,
										  txt = settext,
										  params = { event = "jim-mechanic:client:Manual:Repair", args = { cost = cost, }, } }
										  
			--RepairMenu[#RepairMenu+1] = { icon = "fas fa-magnifying-glass", header = "Preview", txt = "", params = { event = "jim-mechanic:client:Preview:Menu" }, }
			--RepairMenu[#RepairMenu+1] = { header = "Test", txt = "Vehicle Death Simulator", params = { event = "jim-mechanic:client:Police:test" }, }

		exports['qb-menu']:openMenu(RepairMenu)
	end
end)

RegisterNetEvent('jim-mechanic:client:Manual:Repair', function(data)
	local playerPed = PlayerPedId()
	TriggerServerEvent("jim-mechanic:chargeCash", data.cost)
	vehicle = GetVehiclePedIsIn(playerPed, false) pushVehicle(vehicle)
	FreezeEntityPosition(vehicle, true)
	if Config.repairEngine then
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["police"].engine)
		Wait(10000) -- 10000 = 10 second wait
		SetVehicleEngineHealth(vehicle, 1000.0)
		if useMechJob() and Config.repairExtras then
			TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "radiator", 100)
			TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "axle", 100)
			TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "brakes", 100)
			TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "clutch", 100)
			TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "fuel", 100)
		end
	end
	if Config.repairAnimate then
		local wait = 1500
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["manual"].tyres)
		for _, v in pairs({0, 1, 4, 5}) do
			if IsVehicleTyreBurst(vehicle, v, false) then SetVehicleTyreBurst(vehicle, v, true) SetVehicleTyreFixed(vehicle, v) Wait(wait) end
		end
		if not AreAllVehicleWindowsIntact(vehicle) then
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["manual"].window)
			for i = 0, 5 do if not IsVehicleWindowIntact(vehicle, i) then RemoveVehicleWindow(vehicle, i) Wait(wait/2) end end
		end

		--[[TriggerEvent("QBCore:Notify", Loc[Config.Lan]["manual"].doors)
		for i = 0, 5 do if not IsVehicleDoorDamaged(vehicle, i) then SetVehicleDoorBroken(vehicle, i, false) Wait(wait) else print("door "..i.." not found") end end]]
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["police"].body) 
		Wait(wait*2)
		SetVehicleBodyHealth(vehicle, 1000.0)
		SetVehicleFixed(vehicle)
	else
		Wait(8000)
		SetVehicleBodyHealth(vehicle, 1000.0)
		SetVehicleFixed(vehicle)
	end
	TriggerEvent("QBCore:Notify", Loc[Config.Lan]["police"].complete, "success")
	FreezeEntityPosition(vehicle, false)
	TriggerEvent('jim-mechanic:client:Manual:Menu')
end)

AddEventHandler('onResourceStop', function(r) if r ~= GetCurrentResourceName() then return end
	for k, v in pairs(Config.RepairLocations) do exports['qb-target']:RemoveZone("repairbench"..k) end
	for i = 1, #bench do DeleteEntity(bench[i])	end
end)

