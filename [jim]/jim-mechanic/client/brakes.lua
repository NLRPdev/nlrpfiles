local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Brakes
--Add Brakes
RegisterNetEvent('jim-mechanic:client:applyBrakes', function(level)
	if not jobChecks() then return end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if not inCar() then return end
	if not nearPoint(coords) then return end
	if not IsPedInAnyVehicle(playerPed, false) then	vehicle = getClosest(coords) pushVehicle(vehicle) end
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
		currentBrakes = GetVehicleMod(vehicle, 12)
		if GetNumVehicleMods(vehicle, 12) == 0 then	TriggerEvent("QBCore:Notify", Loc[Config.Lan]["brakes"].cant, "error") return end
		if GetVehicleMod(vehicle, 12) == level then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].already, "error") else
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			SetVehicleEngineOn(vehicle, false, false, true)
			time = math.random(7000,10000)
			QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["common"].installing.."LVL: "..level+1, time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, }, 
			{ animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
				if GetVehicleMod(vehicle, 12) ~= currentBrakes then TriggerServerEvent("jim-mechanic:server:DupeWarn", "brakes"..(currentBrakes+1)) emptyHands(playerPed) return end
				SetVehicleMod(vehicle, 12, level)
				updateCar(vehicle)
				TriggerServerEvent('jim-mechanic:server:removeBrakes', level, currentBrakes)
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["brakes"].installed, "success")
				emptyHands(playerPed)
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["brakes"].failed, "error")
				emptyHands(playerPed)
			end, "brakes"..level+1)
		end
	end
end)
--Remove Brakes
RegisterNetEvent('jim-mechanic:client:giveBrakes', function()
	if not jobChecks() then return end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	currentBrakes = GetVehicleMod(vehicle, 12)
	TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
	Wait(1000)

	QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["brakes"].removing, 8000, false, true, { disableMovement = true, disableCarMovement = true,	disableMouse = false, disableCombat = false, }, 
	{ animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
		if GetVehicleMod(vehicle, 12) ~= currentBrakes then TriggerServerEvent("jim-mechanic:server:DupeWarn", "brakes"..(currentBrakes+1)) emptyHands(playerPed) return end
		SetVehicleMod(vehicle, 12, -1)
		updateCar(vehicle)
		TriggerServerEvent('jim-mechanic:server:removeBrakes', nil, currentBrakes)
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["brakes"].remove, "success")
		emptyHands(playerPed)
	end, function() -- Cancel
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["brakes"].remfail, "error")
		emptyHands(playerPed)
	end, "brakes"..currentBrakes+1)
end)