local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Suspension
RegisterNetEvent('jim-mechanic:client:applySuspension', function(level)
	if not jobChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if not inCar() then return end
	if not nearPoint(coords) then return end
	if not IsPedInAnyVehicle(playerPed, false) then vehicle = getClosest(coords) pushVehicle(vehicle) end
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
		currentSuspension = GetVehicleMod(vehicle, 15)
		if GetNumVehicleMods(vehicle, 15) == 0 then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["suspension"].cant, "error") return end	
		if currentSuspension == level then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].already, "error") else						
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			SetVehicleEngineOn(vehicle, false, false, true)
			time = math.random(7000,10000)
			QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing.."LVL: "..level+1, time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
			{ animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
				if GetVehicleMod(vehicle, 15) ~= currentSuspension then TriggerServerEvent("jim-mechanic:server:DupeWarn", "suspension"..(currentSuspension+1)) emptyHands(playerPed) return end
				SetVehicleMod(vehicle, 15, level)
				SetVehicleDoorShut(vehicle, 4, false)
				emptyHands(playerPed)
				updateCar(vehicle)
				TriggerServerEvent('jim-mechanic:server:removeSuspension', level, currentSuspension)
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["suspension"].installed, "success")						
			end, function()
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["suspension"].failed, "error")
				emptyHands(playerPed)
			end, "suspension"..level+1)
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:giveSuspension', function()
	if not jobChecks() then return end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	currentSuspension = GetVehicleMod(vehicle, 15)
	TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
	Wait(1000)
	QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["suspension"].removing, 8000, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, }, 
	{ animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function() -- Done
		if GetVehicleMod(vehicle, 15) ~= currentSuspension then TriggerServerEvent("jim-mechanic:server:DupeWarn", "suspension"..(currentSuspension+1)) emptyHands(playerPed) return end
		SetVehicleMod(vehicle, 15, -1)
		updateCar(vehicle)
		TriggerServerEvent('jim-mechanic:server:removeSuspension', nil, currentSuspension)
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["suspension"].removed, "success")
		emptyHands(playerPed)
	end, function() -- Cancel
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["suspension"].remfail, "error")
		emptyHands(playerPed)
	end, "suspension"..currentSuspension+1)
end)
