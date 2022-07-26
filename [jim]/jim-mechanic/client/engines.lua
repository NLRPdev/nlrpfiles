local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Engines
RegisterNetEvent('jim-mechanic:client:applyEngine', function(level)
	if not jobChecks() then return end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if not inCar() then return end
	if not nearPoint(coords) then return end
	if not IsPedInAnyVehicle(playerPed, false) then vehicle = getClosest(coords) pushVehicle(vehicle) end
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
		currentEngine = GetVehicleMod(vehicle, 11)
		if GetNumVehicleMods(vehicle, 11) == 0 then	TriggerEvent("QBCore:Notify", Loc[Config.Lan]["engines"].cant, "error") return	end
		if GetVehicleMod(vehicle, 11) == level then TriggerEvent("QBCore:Notify", "LVL: "..(level+1)..Loc[Config.Lan]["common"].already, "error") else
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			SetVehicleEngineOn(vehicle, false, false, true)
			SetVehicleDoorOpen(vehicle, 4, false, false)
			time = math.random(7000,10000)
			QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing.." LVL: "..level+1, time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
			{ animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, }, {}, {}, function()
				if GetVehicleMod(vehicle, 11) ~= currentEngine then TriggerServerEvent("jim-mechanic:server:DupeWarn", "engine"..(currentEngine+1)) emptyHands(playerPed) return end
				SetVehicleMod(vehicle, 11, level)
				SetVehicleDoorShut(vehicle, 4, false)
				emptyHands(playerPed)
				updateCar(vehicle)
				TriggerServerEvent('jim-mechanic:server:removeEngines', level, currentEngine)
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["engines"].installed, "success")						
			end, function()
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["engines"].failed, "error")
				SetVehicleDoorShut(vehicle, 4, false)
				emptyHands(playerPed)
			end, "engine"..level+1)
		end
	end
end)
--Simple remove the engine command and give what was already in
RegisterNetEvent('jim-mechanic:client:giveEngine', function()
	if not jobChecks() then return end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	currentEngine = GetVehicleMod(vehicle, 11)
	TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
	Wait(1000)
	SetVehicleDoorOpen(vehicle, 4, false, false)
	QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["engines"].removing, 8000, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
	{ animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, }, {}, {}, function()
		if GetVehicleMod(vehicle, 11) ~= currentEngine then TriggerServerEvent("jim-mechanic:server:DupeWarn", "engine"..(currentEngine+1)) emptyHands(playerPed) return end
		ClearPedTasks(playerPed)
		SetVehicleMod(vehicle, 11, -1)
		SetVehicleDoorShut(vehicle, 4, false)
		updateCar(vehicle)
		TriggerServerEvent('jim-mechanic:server:removeEngines', nil, currentEngine)
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["engines"].remove, "success")
		emptyHands(playerPed)
	end, function() -- Cancel
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["engines"].remfail, "error")
		emptyHands(playerPed)
	end, "engine"..currentEngine+1)
end)