local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Livery
RegisterNetEvent('jim-mechanic:client:Livery:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	local modName = GetLabelText(GetModTextLabel(vehicle, 48, tonumber(data.id)))
	if data.old then
		if modName == "NULL" then modName = Loc[Config.Lan]["livery"].oldMod end
		if GetVehicleLivery(vehicle) == tonumber(data.id) then
			TriggerEvent('QBCore:Notify', data.id..Loc[Config.Lan]["common"].already, "error")
			TriggerEvent('jim-mechanic:client:Livery:Check')
		return end
	else
		if modName == "NULL" then modName = Loc[Config.Lan]["common"].stock end
		if GetVehicleMod(vehicle, 48) == tonumber(data.id) then
			TriggerEvent('QBCore:Notify', modName..Loc[Config.Lan]["common"].already, "error")
			TriggerEvent('jim-mechanic:client:Livery:Check')
		return end
	end
	time = math.random(3000,5000)
	TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
	QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing..modName, time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, }, 
	{ animDict = "timetable@floyd@clean_kitchen@base", anim = "base", flags = 16, }, {}, {}, function()
		if data.old then
			if tonumber(data.id) == 0 then 
				SetVehicleMod(vehicle, 48, -1, false) 
				SetVehicleLivery(vehicle, 0)
			else 
				SetVehicleMod(vehicle, 48, -1, false)			
				SetVehicleLivery(vehicle, tonumber(data.id))
			end
		elseif not data.old then
			if tonumber(data.id) == -1 then 
				SetVehicleMod(vehicle, 48, -1, false) 
				SetVehicleLivery(vehicle, -1)
			else
				SetVehicleMod(vehicle, 48, tonumber(data.id), false) 
				SetVehicleLivery(vehicle, -1)
			end
		end
		emptyHands(playerPed)
		updateCar(vehicle)
		if Config.CosmeticRemoval then TriggerServerEvent("QBCore:Server:RemoveItem", 'livery', 1) TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['livery'], "remove", 1)
		else TriggerEvent('jim-mechanic:client:Livery:Check') end
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["livery"].installed, "success")
	end, function() -- Cancel
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["livery"].failed, "error")
		emptyHands(playerPed)
	end, "livery")
end)

RegisterNetEvent('jim-mechanic:client:Livery:Check', function()
	if Config.CosmeticsJob then if not jobChecks() then return end end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local validMods = {}
	if not inCar() then return end
	if not nearPoint(coords) then return end
	local vehicle = nil
	local oldlivery = false
	if not IsPedInAnyVehicle(playerPed, false) then vehicle = getClosest(coords) pushVehicle(vehicle) end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
    if GetNumVehicleMods(vehicle, 48) == 0 and GetVehicleLiveryCount(vehicle) ~= 0 then
		oldlivery = true
		for i = 0, GetVehicleLiveryCount(vehicle)-1 do
			if GetVehicleLivery(vehicle) == (i) then txt = Loc[Config.Lan]["common"].current
			elseif GetVehicleLivery(vehicle) ~= (i) then txt = "" end
			if i ~= 0 then validMods[i] = { id = i, name = "Livery "..i, install = txt } end
		end
	else
		oldlivery = false
		for i = 1, GetNumVehicleMods(vehicle, 48) do
			local modName = GetLabelText(GetModTextLabel(vehicle, 48, (i - 1)))
			if GetVehicleMod(vehicle, 48) == (i-1) then txt = Loc[Config.Lan]["common"].current
			elseif GetVehicleMod(vehicle, 48) ~= (i-1) then txt = "" end
			validMods[i] = { id = (i - 1), name = modName, install = txt }
		end
	end
	if GetNumVehicleMods(vehicle, 48) == 0 and GetVehicleLiveryCount(vehicle) == -1 then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].noOptions, "error") return end
	if DoesEntityExist(vehicle) then
		local LiveryMenu = {}
		if oldlivery == true then
				if GetVehicleLivery(vehicle) == 0 then stockinstall = Loc[Config.Lan]["common"].current else stockinstall = "" end
				LiveryMenu[#LiveryMenu + 1] = { isMenuHeader = true, header = Loc[Config.Lan]["livery"].menuheader, txt = 'Amount of Options: '..GetVehicleLiveryCount(vehicle) }
				LiveryMenu[#LiveryMenu + 1] = { header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "jim-mechanic:client:Menu:Close" } }
				LiveryMenu[#LiveryMenu + 1] = {  header = "0. "..Loc[Config.Lan]["common"].stock, txt = stockinstall, params = { event = "jim-mechanic:client:Livery:Apply", args = { id = tostring(0), old = true } } }
			for k,v in pairs(validMods) do
				LiveryMenu[#LiveryMenu + 1] = { header = k..". "..v.name, txt = v.install, params = { event = 'jim-mechanic:client:Livery:Apply', args = { id = tostring(v.id), old = true } } }
			end
		elseif oldlivery ~= true then
				if GetVehicleMod(vehicle, 48) == -1 then stockinstall = Loc[Config.Lan]["common"].current else stockinstall = "" end
				LiveryMenu[#LiveryMenu + 1] = { isMenuHeader = true, header = Loc[Config.Lan]["livery"].menuheader, txt = 'Amount of Options: '..GetNumVehicleMods(vehicle, 48)+1 }
				LiveryMenu[#LiveryMenu + 1] = { header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "jim-mechanic:client:Menu:Close" } }
				LiveryMenu[#LiveryMenu + 1] = {  header = "0. "..Loc[Config.Lan]["common"].stock, txt = stockinstall, params = { event = "jim-mechanic:client:Livery:Apply", args = { id = tostring(-1) } } }
			for k,v in pairs(validMods) do
				LiveryMenu[#LiveryMenu + 1] = { header = k..". "..v.name, txt = v.install, params = { event = 'jim-mechanic:client:Livery:Apply', args = { id = tostring(v.id) } } }
			end
		end
		exports['qb-menu']:openMenu(LiveryMenu)
	end
end)