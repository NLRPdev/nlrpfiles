local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Spoilers
RegisterNetEvent('jim-mechanic:client:Spoilers:Apply', function(mod)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	local modName = GetLabelText(GetModTextLabel(vehicle, 0, tonumber(mod)))
	if modName == "NULL" then modName = Loc[Config.Lan]["common"].stock end
	if GetVehicleMod(vehicle, 0) == tonumber(mod) then
		TriggerEvent('QBCore:Notify', modName..Loc[Config.Lan]["common"].already, "error")
		TriggerEvent('jim-mechanic:client:Spoilers:Check')
	elseif GetVehicleMod(vehicle, 0) ~= tonumber(mod) then
		time = math.random(3000,5000)
		QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing..modName.."..", time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
		{ task = "WORLD_HUMAN_WELDING" }, {}, {}, function()
			SetVehicleMod(vehicle, 0, tonumber(mod))
			emptyHands(playerPed)
			updateCar(vehicle)
			if Config.CosmeticRemoval then TriggerServerEvent("QBCore:Server:RemoveItem", 'spoiler', 1) TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['rims'], "spoiler", 1)
			else TriggerEvent('jim-mechanic:client:Spoilers:Check') end
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["spoilers"].installed, "success")
		end, function() -- Cancel
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["spoilers"].failed, "error")
			emptyHands(playerPed)
		end, "spoilers")
	end
end)

RegisterNetEvent('jim-mechanic:client:Spoilers:Check', function()
	if Config.CosmeticsJob then if not jobChecks() then return end end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local validMods = {}
	if not inCar() then return end
	if not nearPoint(coords) then return end
	local vehicle = nil
	if not IsPedInAnyVehicle(playerPed, false) then vehicle = getClosest(coords) pushVehicle(vehicle)
		for i = 1, GetNumVehicleMods(vehicle,0) do
			if GetVehicleMod(vehicle, 0) == (i-1) then txt = Loc[Config.Lan]["common"].current else txt = "" end
			validMods[i] = { id = (i - 1), name = GetLabelText(GetModTextLabel(vehicle, 0, (i - 1))), install = txt }
		end
	end
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
		if GetNumVehicleMods(vehicle, 0) == 0 then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].noOptions, "error") return	end
		if GetVehicleMod(vehicle, 0) == -1 then	stockinstall = Loc[Config.Lan]["common"].current else stockinstall = ""	end
		local spoilerMenu = {
				{ isMenuHeader = true, header = searchCar(vehicle)..Loc[Config.Lan]["spoilers"].menuheader, txt = Loc[Config.Lan]["common"].amountoption..#validMods+1,	},
				{ header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "jim-mechanic:client:Menu:Close" } },
				{ header = "0. "..Loc[Config.Lan]["common"].stock, txt = stockinstall,	params = { event = "jim-mechanic:client:Spoilers:Apply", args = -1 } } }
			for k,v in pairs(validMods) do
				spoilerMenu[#spoilerMenu + 1] = { header = k..". "..v.name, txt = v.install, params = { event = 'jim-mechanic:client:Spoilers:Apply', args = tostring(v.id) } }
			end
		exports['qb-menu']:openMenu(spoilerMenu)
	end
end)