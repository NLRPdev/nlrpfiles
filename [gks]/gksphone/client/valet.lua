--================================================================================================
--==            --    XenKnighT --        https://discord.gg/XUck63E                            ==
--================================================================================================

local fizzPed = nil
local carBlip = nil
local wait = false
local inVehicle = false

RegisterNUICallback('getCarsValetGKS', function(data)
	if not wait then
		local plate = data.plate
		Config.Core.Functions.TriggerCallback('gksphone:loadVehicle', function(hash)
			if Config.cdGarages then
				if hash.impound == 1 then
					TriggerEvent('gksphone:notifi', {title = _U('vale_title'), message = _U('vale_vehimpounded'), img= '/html/static/img/icons/vale.png' })
					return
				elseif not hash.in_garage then
					TriggerEvent('gksphone:notifi', {title = _U('vale_title'), message = _U('vale_vehoutside'), img= '/html/static/img/icons/vale.png' })
					return
				end
			else
				if tonumber(hash.state) == 2 then
					TriggerEvent('gksphone:notifi', {title = _U('vale_title'), message = _U('vale_vehimpounded'), img= '/html/static/img/icons/vale.png' })
					return
				end
			end
			local gameVehicles = Config.Core.Functions.GetVehicles()
			for i = 1, #gameVehicles do
				local vehicle = gameVehicles[i]

				if DoesEntityExist(vehicle) then
					if GetVehicleNumberPlateText(vehicle) == data.plate then
					local vehicleCoords = GetEntityCoords(vehicle)
					SetNewWaypoint(vehicleCoords.x, vehicleCoords.y)
					TriggerEvent('gksphone:notifi', {title = _U('vale_title'), message = _U('vale_getr'), img= '/html/static/img/icons/vale.png' })
					return
					end
				end
			end
			Config.Core.Functions.TriggerCallback('gksphone:checkMoney2', function(hasEnoughMoney)
				if hasEnoughMoney == true then
					TriggerServerEvent("gksphone:valet-car-set-outside", data.plate, hash.garage)
					SpawnVehicle(hash, data.plate)
				else
					TriggerEvent('gksphone:notifi', {title = _U('vale_title'), message = _U('vale_checmoney'), img= '/html/static/img/icons/vale.png' })
				end
			end)

		end,plate)
	else
		TriggerEvent('gksphone:notifi', {title = _U('vale_title'), message = _U('vale_coming'), img= '/html/static/img/icons/vale.png' })
	end
end)


function SpawnVehicle(vehicle, plate)
	wait = true
	if	Config.ValeNPC  then
		local coords = GetEntityCoords(PlayerPedId())
		local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(coords.x + math.random(-Config.ValespawnRadius, Config.ValespawnRadius), coords.y + math.random(-Config.ValespawnRadius, Config.ValespawnRadius), coords.z, 0, 3, 0)
		local coordinates = {x=spawnPos.x,y=spawnPos.y,z=spawnPos.z, spawnHeading}
		local driverhash = 999748158
		local vehhash = tonumber(vehicle.hash)
		while not HasModelLoaded(driverhash) and RequestModel(driverhash) or not HasModelLoaded(vehhash) and RequestModel(vehhash) do
			RequestModel(driverhash)
			RequestModel(vehhash)
			Citizen.Wait(0)
		end
		TriggerEvent('gksphone:notifi', {title = _U('vale_title'), message = _U('vale_spawntime'), img= '/html/static/img/icons/vale.png' })
		Config.Core.Functions.SpawnVehicle(vehicle.vehicle,  function(callback_vehicle)
			Config.Core.Functions.TriggerCallback('gksphone:GetVehicleProperties', function(properties)
				Config.Core.Functions.SetVehicleProperties(callback_vehicle, properties)
				SetVehicleHasBeenOwnedByPlayer(callback_vehicle, true)
				SetVehRadioStation(callback_vehicle, "OFF")
				doCarDamage(callback_vehicle, vehicle)
				fizzPed = CreatePedInsideVehicle(callback_vehicle, 26, driverhash, -1, true, false)
				SetVehicleNumberPlateText(callback_vehicle, plate)
				SetEntityAsMissionEntity(callback_vehicle, true, true)
				ClearAreaOfVehicles(GetEntityCoords(callback_vehicle), 5000, false, false, false, false, false);
				SetVehicleOnGroundProperly(callback_vehicle)
				SetVehicleEngineOn(callback_vehicle,true)

				carBlip = AddBlipForEntity(callback_vehicle)
				SetBlipSprite(carBlip, 225)                                                      	--Blip Spawning.
				SetBlipFlashes(carBlip, true)
				SetBlipColour(carBlip, 0)
				SetBlipFlashes(carBlip, false)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(plate)
				EndTextCommandSetBlipName(carBlip)

				inVehicle = true
				GiveKeyCar(callback_vehicle, vehicle)
				TaskVehicle(callback_vehicle, vehhash)
			end, plate)
		end, coordinates)

	else

		local coords = GetEntityCoords(PlayerPedId())
		local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(coords.x + math.random(-30, 30), coords.y + math.random(-30, 30), coords.z, 0, 3, 0)
		local coordinates = {x=spawnPos.x,y=spawnPos.y,z=spawnPos.z, spawnHeading}
		local driverhash = 999748158
		local vehhash = tonumber(vehicle.hash)
		while not HasModelLoaded(driverhash) and RequestModel(driverhash) or not HasModelLoaded(vehhash) and RequestModel(vehhash) do
			RequestModel(driverhash)
			RequestModel(vehhash)
			Citizen.Wait(0)
		end
		TriggerEvent('gksphone:notifi', {title = _U('vale_title'), message = _U('vale_spawntime'), img= '/html/static/img/icons/vale.png' })
		Config.Core.Functions.SpawnVehicle(vehicle.vehicle,  function(callback_vehicle)
			Config.Core.Functions.TriggerCallback('gksphone:GetVehicleProperties', function(properties)
				Config.Core.Functions.SetVehicleProperties(callback_vehicle, properties)
				SetVehicleHasBeenOwnedByPlayer(callback_vehicle, true)
				SetVehRadioStation(callback_vehicle, "OFF")
				doCarDamage(callback_vehicle, vehicle)
				SetVehicleNumberPlateText(callback_vehicle, plate)
				SetEntityAsMissionEntity(callback_vehicle, true, true)
				ClearAreaOfVehicles(GetEntityCoords(callback_vehicle), 5000, false, false, false, false, false);
				SetVehicleOnGroundProperly(callback_vehicle)
				SetVehicleEngineOn(callback_vehicle,true)

				carBlip = AddBlipForEntity(callback_vehicle)
				SetBlipSprite(carBlip, 225)                                                      	--Blip Spawning.
				SetBlipFlashes(carBlip, true)
				SetBlipColour(carBlip, 0)
				SetBlipFlashes(carBlip, false)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(plate)
				EndTextCommandSetBlipName(carBlip)
				GiveKeyCar(callback_vehicle, vehicle)

				Citizen.Wait(10000)
				RemoveBlip(carBlip)
				carBlip = nil

			end, plate)
		end, coordinates)

	end

end

function TaskVehicle(vehicle, vehhash)
	while inVehicle do
		Citizen.Wait(750)
		local pedcoords = GetEntityCoords(PlayerPedId())
		local plycoords = GetEntityCoords(fizzPed)
		local dist = GetDistanceBetweenCoords(plycoords, pedcoords.x,pedcoords.y,pedcoords.z, false)

		if dist <= 25.0 then
			TaskVehicleDriveToCoord(fizzPed, vehicle, pedcoords.x, pedcoords.y, pedcoords.z, 60.0, 1, vehhash, 2883621, 5.0, 1)
			SetVehicleFixed(vehicle)
			if dist <= 7.5 then
				LeaveIt(vehicle)
				break
			else
				Citizen.Wait(500)
			end
		else
			TaskVehicleDriveToCoord(fizzPed, vehicle, pedcoords.x, pedcoords.y, pedcoords.z, 60.0, 1, vehhash, 2883621, 15.0, 1)
			Citizen.Wait(500)
		end
	end
end

function LeaveIt(vehicle)
	TaskLeaveVehicle(fizzPed, vehicle, 14)
	inVehicle = false
	while IsPedInAnyVehicle(fizzPed, false) do
		Citizen.Wait(0)
	end

	Citizen.Wait(500)
	TaskWanderStandard(fizzPed, 10.0, 10)
	Citizen.Wait(10000)
	DeleteEntity(fizzPed)
	RemoveBlip(carBlip)
	carBlip = nil
	fizzPed = nil
	wait = false
end


function doCarDamage(currentVehicle, veh)
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0
	if Config.cdGarages then
		local mods = json.decode(veh.mods)
		engine = math.ceil(mods.engineHealth + 0.0)
		body = math.ceil(mods.bodyHealth + 0.0)
	end
    Wait(100)

        if body < 900.0 then
            SmashVehicleWindow(currentVehicle, 0)
            SmashVehicleWindow(currentVehicle, 1)
            SmashVehicleWindow(currentVehicle, 2)
            SmashVehicleWindow(currentVehicle, 3)
            SmashVehicleWindow(currentVehicle, 4)
            SmashVehicleWindow(currentVehicle, 5)
            SmashVehicleWindow(currentVehicle, 6)
            SmashVehicleWindow(currentVehicle, 7)
        end
        if body < 800.0 then
            SetVehicleDoorBroken(currentVehicle, 0, true)
            SetVehicleDoorBroken(currentVehicle, 1, true)
            SetVehicleDoorBroken(currentVehicle, 2, true)
            SetVehicleDoorBroken(currentVehicle, 3, true)
            SetVehicleDoorBroken(currentVehicle, 4, true)
            SetVehicleDoorBroken(currentVehicle, 5, true)
            SetVehicleDoorBroken(currentVehicle, 6, true)
        end
        if engine < 700.0 then
            SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
            SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
            SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
            SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
        end
        if engine < 500.0 then
            SetVehicleTyreBurst(currentVehicle, 0, false, 990.0)
            SetVehicleTyreBurst(currentVehicle, 5, false, 990.0)
            SetVehicleTyreBurst(currentVehicle, 6, false, 990.0)
            SetVehicleTyreBurst(currentVehicle, 7, false, 990.0)
        end

	SetVehicleBodyHealth(currentVehicle, body)
	SetVehicleEngineHealth(currentVehicle, engine)
end