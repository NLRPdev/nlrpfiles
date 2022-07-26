local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Armour
-- Add Armour
RegisterNetEvent('jim-mechanic:client:applyArmour', function()
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if not jobChecks() then return end
	if not locationChecks() then return end
	if not inCar() then return end
	if not nearPoint(coords) then return end
	if not IsPedInAnyVehicle(playerPed, false) then	vehicle = getClosest(coords) pushVehicle(vehicle) end
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
		if GetNumVehicleMods(vehicle, 16) == 0 then	TriggerEvent("QBCore:Notify", Loc[Config.Lan]["armour"].cant, "error") return end
		if GetVehicleMod(vehicle, 16)+1 == GetNumVehicleMods(vehicle, 16) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].already, "error") else
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			SetVehicleEngineOn(vehicle, false, false, true)
			SetVehicleDoorOpen(vehicle, 4, false, false)
			time = math.random(7000,10000)
			QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["armour"].install, time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
			{ animDict = "mini@repair", anim = "fixing_a_ped", flags = 16, }, {}, {}, function()
				SetVehicleMod(vehicle, 16, GetNumVehicleMods(vehicle, 16)-1)
				SetVehicleDoorShut(vehicle, 4, false)
				emptyHands(playerPed)
				updateCar(vehicle)
				TriggerServerEvent('jim-mechanic:server:removeArmour')
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["armour"].installed, "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["armour"].failed, "error")
				SetVehicleDoorShut(vehicle, 4, false)
				emptyHands(playerPed)
			end, "car_armor")
		end
	end
end)
-- Remove Armour
RegisterNetEvent('jim-mechanic:client:giveArmor', function()
	if not jobChecks() then return end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
	Wait(1000)
	SetVehicleDoorOpen(vehicle, 4, false, false)
	QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["armour"].removing, 8000, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, }, 
	{ animDict = "mini@repair", anim = "fixing_a_ped", flags = 16, }, {}, {}, function()
		if GetVehicleMod(vehicle, 16) == -1 then TriggerServerEvent("jim-mechanic:server:DupeWarn", "car armor") emptyHands(playerPed) return end
		SetVehicleMod(vehicle, 16, -1)
		SetVehicleDoorShut(vehicle, 4, false)
		updateCar(vehicle)
		TriggerServerEvent('jim-mechanic:server:giveArmour')
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["armour"].removed, "success")
		emptyHands(playerPed)				
	end, function()
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["armour"].remfail, "error")
		emptyHands(playerPed)
	end, "car_armor")
end)