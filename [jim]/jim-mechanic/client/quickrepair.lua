local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Repair
RegisterNetEvent('jim-mechanic:quickrepair', function()
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local repaireng = true
	local repairbody = true
	if not IsPedInAnyVehicle(playerPed, false) then	vehicle = getClosest(coords) pushVehicle(vehicle) end
	if DoesEntityExist(vehicle) then
		currentenginehealth = GetVehicleEngineHealth(vehicle)
		currentbodyhealth = GetVehicleBodyHealth(vehicle)
		
		if GetVehicleEngineHealth(vehicle) >= Config.MaxDuctEngine then repaireng = false else repaireng = true end
		if Config.DuctTapeBody and GetVehicleBodyHealth(vehicle) >= Config.MaxDuctBody then repairbody = false else repairbody = true end
		
		if repaireng or repairbody then
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			SetVehicleDoorOpen(vehicle, 4, false, false)
			QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["repair"].applyduct, 10000, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
			{ animDict = "mini@repair",	anim = "fixing_a_ped", flags = 16, },
			{}, {}, function()
				Wait(1000)
				emptyHands(playerPed)
				if Config.DuctSimpleMode then 
					SetVehicleEngineHealth(vehicle, Config.MaxDuctEngine) 
					SetVehicleBodyHealth(vehicle, Config.MaxDuctBody)
				elseif not Config.DuctSimpleMode then
					if currentenginehealth <= 50.0 and currentenginehealth <= 200 then SetVehicleEngineHealth(vehicle, 300.0)
					else
						SetVehicleEngineHealth(vehicle, currentenginehealth + Config.DuctAmountEngine)
						if GetVehicleEngineHealth(vehicle) > Config.MaxDuctEngine then SetVehicleEngineHealth(vehicle, Config.MaxDuctEngine) end
					end
					
					if Config.DuctTapeBody then
						if currentbodyhealth <= 50.0 and currentbodyhealth <= 200 then SetVehicleBodyHealth(vehicle, 300.0)
						else SetVehicleBodyHealth(vehicle, currentbodyhealth + Config.DuctAmountBody)
							if GetVehicleBodyHealth(vehicle) > Config.MaxDuctBody then SetVehicleBodyHealth(vehicle, Config.MaxDuctBody) end
						end
					end
					SetVehicleDoorShut(vehicle, 4, false, false)
				end
				if Config.RemoveDuctTape then TriggerServerEvent("jim-mechanic:server:removeTape") end
			end, function()
				SetVehicleDoorShut(vehicle, 4, false, false)
				emptyHands(playerPed)
			end, "ducttape")
		else TriggerEvent("QBCore:Notify", Loc[Config.Lan]["repair"].ductfull, "error") end
	else TriggerEvent("QBCore:Notify", Loc[Config.Lan]["repair"].nocar "error") end
end)