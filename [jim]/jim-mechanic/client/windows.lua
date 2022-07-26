local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Windows
RegisterNetEvent('jim-mechanic:client:Windows:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	if lockedCar(vehicle) then return end
	if GetVehicleWindowTint(vehicle) == tonumber(data.mod) then TriggerEvent('QBCore:Notify', data.name..Loc[Config.Lan]["common"].already, "error") TriggerEvent('jim-mechanic:client:Windows:Check')
	elseif GetVehicleWindowTint(vehicle) ~= tonumber(data.mod) then
		time = math.random(3000,5000)
		TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
		Wait(1000)
		TriggerEvent('animations:client:EmoteCommandStart', {"maid"})
		QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing..data.name.."..", time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, }, 
		{}, {}, {}, function()
			SetVehicleWindowTint(vehicle, tonumber(data.mod))
			updateCar(vehicle)
			if Config.CosmeticRemoval then TriggerServerEvent("QBCore:Server:RemoveItem", 'tint_supplies', 1) TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['tint_supplies'], "remove", 1)
			else TriggerEvent('jim-mechanic:client:Windows:Check') end
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["windows"].installed, "success")
			emptyHands(playerPed, true)
		end, function() -- Cancel
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["windows"].failed, "error")
			emptyHands(playerPed, true)
		end, "tint_supplies")
	end
end)

RegisterNetEvent('jim-mechanic:client:Windows:Check', function()
	if Config.CosmeticsJob then if not jobChecks() then return end end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)  
	if not inCar() then return end
	if not nearPoint(coords) then return end
	local vehicle = nil
	if not IsPedInAnyVehicle(playerPed, false) then	vehicle = getClosest(coords) pushVehicle(vehicle) end
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
		if GetVehicleWindowTint(vehicle) == 0 then applied1 = Loc[Config.Lan]["common"].current else applied1 = "" end
		if GetVehicleWindowTint(vehicle) == 4 then applied2 = Loc[Config.Lan]["common"].current else applied2 = "" end
		if GetVehicleWindowTint(vehicle) == 5 then applied3 = Loc[Config.Lan]["common"].current else applied3 = "" end
		if GetVehicleWindowTint(vehicle) == 3 then applied4 = Loc[Config.Lan]["common"].current else applied4 = "" end
		if GetVehicleWindowTint(vehicle) == 2 then applied5 = Loc[Config.Lan]["common"].current else applied5 = "" end
		if GetVehicleWindowTint(vehicle) == 1 then applied6 = Loc[Config.Lan]["common"].current else applied6 = "" end
		
		exports['qb-menu']:openMenu({
			{ header = searchCar(vehicle)..Loc[Config.Lan]["windows"].menuheader, txt = "", isMenuHeader = true },
			{ header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "jim-mechanic:client:Menu:Close" } },
			{ header = Loc[Config.Lan]["windows"].label1, txt = applied1, params = { event = "jim-mechanic:client:Windows:Apply", args = { mod = 0, name = Loc[Config.Lan]["windows"].label1 } } },
			{ header = Loc[Config.Lan]["windows"].label2, txt = applied2, params = { event = "jim-mechanic:client:Windows:Apply", args = { mod = 4, name = Loc[Config.Lan]["windows"].label2 } } },
			{ header = Loc[Config.Lan]["windows"].label3, txt = applied3, params = { event = "jim-mechanic:client:Windows:Apply", args = { mod = 5, name = Loc[Config.Lan]["windows"].label3 } } },
			{ header = Loc[Config.Lan]["windows"].label4, txt = applied4, params = { event = "jim-mechanic:client:Windows:Apply", args = { mod = 3, name = Loc[Config.Lan]["windows"].label4 } } },
			{ header = Loc[Config.Lan]["windows"].label5, txt = applied5, params = { event = "jim-mechanic:client:Windows:Apply", args = { mod = 2, name = Loc[Config.Lan]["windows"].label5 } } },
			{ header = Loc[Config.Lan]["windows"].label6, txt = applied6, params = { event = "jim-mechanic:client:Windows:Apply", args = { mod = 1, name = Loc[Config.Lan]["windows"].label6 } } },
		})
	end
end)