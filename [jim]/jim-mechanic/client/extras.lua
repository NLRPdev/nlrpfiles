local QBCore = exports['qb-core']:GetCoreObject()

--Slow and visible cleaning command
RegisterNetEvent('jim-mechanic:client:cleanVehicle', function(skip)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if not skip then if not jobChecks() then return end end
	if not inCar() then return end
	if not nearPoint(coords) then return end
	vehicle = getClosest(coords) pushVehicle(vehicle)
	if DoesEntityExist(vehicle) then
	local cleaning = false
	if skip then
		if GetVehicleDirtLevel(vehicle) <= 0.1 then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["extras"].clean, "success") SetVehicleDirtLevel(vehicle, 0.0) updateCar(vehicle) return
		elseif GetVehicleDirtLevel(vehicle) > 0.1 then
			cleaning = true 
			TriggerServerEvent("QBCore:Server:RemoveItem", 'cleaningkit', 1)
			TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['cleaningkit'], "remove", 1)
		end
	else cleaning = true end
		TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
		Wait(150)
		TriggerEvent('animations:client:EmoteCommandStart', {"clean2"})
		while cleaning do 
			if GetVehicleDirtLevel(vehicle) >= 1.0 then SetVehicleDirtLevel(vehicle, (tonumber(GetVehicleDirtLevel(vehicle))) - 0.3)
			elseif GetVehicleDirtLevel(vehicle) <= 1.0 then SetVehicleDirtLevel(vehicle, 0.0) cleaning = false TriggerEvent("QBCore:Notify", Loc[Config.Lan]["extras"].clean, "success") emptyHands(playerPed, true) updateCar(vehicle) end
			Wait(300)
		end
	end
end)

--Multipurpose Door command
RegisterNetEvent('jim-mechanic:client:openDoor', function(door)
	local doornum = tonumber(door)
	if doornum < 0 or doornum > 5 then
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["extras"].doorerr, "error")
		return
	end
	local coords = GetEntityCoords(PlayerPedId())
	if not nearPoint(coords) then return end
	local vehicle = nil
	if IsPedSittingInAnyVehicle(PlayerPedId()) then	vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	else vehicle = getClosest(coords) pushVehicle(vehicle) end
	if DoesEntityExist(vehicle) then
		if GetVehicleDoorLockStatus(vehicle) == 2 then
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["extras"].locked, "error")
			return
		else
			if GetVehicleDoorAngleRatio(vehicle, doornum) > 0.0 then SetVehicleDoorShut(vehicle, doornum, false)
			else SetVehicleDoorOpen(vehicle, doornum, false, false) end
		end
	end
end)

RegisterNetEvent("jim-mechanic:flipvehicle", function()
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local vehicle = nil
	if not inCar() then	return end
	if not nearPoint(coords) then return end
	vehicle = getClosest(coords) pushVehicle(vehicle)
	if DoesEntityExist(vehicle) then
		QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["extras"].flipping, 12000, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false,	disableCombat = false, }, 
		{ task = "CODE_HUMAN_MEDIC_TEND_TO_DEAD" }, {}, {}, function() -- Done
			emptyHands(playerPed)
			vehiclecoords = GetEntityCoords(vehicle)
			SetEntityCoords(vehicle, vehiclecoords.x+0.5, vehiclecoords.y+0.5, vehiclecoords.z+1)
			Wait(200)
			SetEntityRotation(vehicle, GetEntityRotation(PlayerPedId(), 2), 2)
			Wait(500)
			SetVehicleOnGroundProperly(vehicle)
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["extras"].flipped, "success")
		end, function() -- Cancel
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["extras"].failed, "error")
			emptyHands(playerPed)
		end, "fas fa-car-burst")
	end
end)

RegisterNetEvent("jim-mechanic:seat", function(seat)
	if not seat then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["extras"].noseat, "error") return end
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	local IsSeatFree = IsVehicleSeatFree(vehicle, tonumber(seat))
	local speed = GetEntitySpeed(vehicle)
	local HasHarnass = exports['qb-smallresources']:HasHarness()
	if not HasHarnass then
		local kmh = (speed * 3.6);
		if IsSeatFree then
			if kmh <= 100.0 then
				SetPedIntoVehicle(PlayerPedId(), vehicle, tonumber(seat))
				QBCore.Functions.Notify(Loc[Config.Lan]["extras"].moveseat..seat.."!")
			else
				QBCore.Functions.Notify(Loc[Config.Lan]["extras"].fastseat)
			end
		else
			QBCore.Functions.Notify(Loc[Config.Lan]["extras"].notseat)
		end
	else
		QBCore.Functions.Notify(Loc[Config.Lan]["extras"].harness, 'error')
	end
end)

local vehicle_sounds = {}
RegisterNetEvent("engine:sound")
AddEventHandler("engine:sound", function(name,plate)
    if vehicle_sounds[plate] == nil then vehicle_sounds[plate] = {} end
    vehicle_sounds[plate].plate = plate vehicle_sounds[plate].name = name
end)

CreateThread(function()
    while true do
        local mycoords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(GetGamePool('CVehicle')) do
            if #(mycoords - GetEntityCoords(v, false)) < 100 then
                local plate = string.gsub(GetVehicleNumberPlateText(v), "%s+", "")
                if vehicle_sounds[plate] ~= nil and vehicle_sounds[plate].plate ~= nil and plate == vehicle_sounds[plate].plate and vehicle_sounds[plate].current ~= vehicle_sounds[plate].name then
                    ForceVehicleEngineAudio(v,vehicle_sounds[plate].name)
                    vehicle_sounds[plate].current = vehicle_sounds[plate].name
                end
            end
        end
        Wait(2000)
    end
end)

RegisterNetEvent("jim-mechanic:togglesound", function(toggle)
	if toggle:lower() ~= "on" and toggle:lower() ~= "off" then TriggerEvent('QBCore:Notify', "Error", "error") return end
	vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
	--Grab info which engine is already in
	currentEngine = GetVehicleMod(vehicle, 11)
	if toggle == "on" then
		if currentEngine == 3 then ForceVehicleEngineAudio(vehicle,"monster")
		elseif currentEngine == 2 then	ForceVehicleEngineAudio(vehicle,"krieger")
		elseif currentEngine == 1 then	ForceVehicleEngineAudio(vehicle,"zentorno")
		elseif currentEngine == 0 then	ForceVehicleEngineAudio(vehicle,"zorrusso") end
	elseif toggle == "off" then
		ForceVehicleEngineAudio(vehicle,string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))))
	end
end, false)

--ODOMETER FUNCTION
local DistAdd = 0
local DistCount = 0
local ShowOdo = Config.ShowOdo
local ShowingOdo = false

CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local invehicle = IsPedInAnyVehicle(ped, true)
		local veh = GetVehiclePedIsIn(ped)
		local prevLoc = GetEntityCoords(veh)
		local seat = GetPedInVehicleSeat(veh, -1)
		local plate = trim(GetVehicleNumberPlateText(veh))
		local owned = IsVehicleOwned(plate)
		if invehicle then
			if not IsVehicleStopped(veh) then
				if plate ~= nil then
					if seat == ped then
						--SHOW ODOMETER STUFF
						Wait(1000)
						if ShowOdo and (owned or Config.Debug) then
							if DistCount == 0 or Config.Debug then
								local p = promise.new()
								QBCore.Functions.TriggerCallback('jim-mechanic:distGrab', function(cb) p:resolve(cb) end, trim(GetVehicleNumberPlateText(veh)))
								dist = Citizen.Await(p)
								if dist ~= "" then
									if Config.distkph then dist = string.format("%05d", math.floor((dist+DistAdd) * 0.001)).." <b>Km</b>" 
									else dist = string.format("%05d", math.floor((dist+DistAdd) * 0.000621371)).." <b>Mi</b>" end
								end
								if Config.Debug then
									local p = promise.new() QBCore.Functions.TriggerCallback('jim-mechanic:GetNosLoaded', function(cb) p:resolve(cb) end) local VehicleNitrous = Citizen.Await(p)
									dist =
									"<b>Vehicle Debug Info</b>:"..
									"<br>"..searchCar(veh)..
									"Class: "..getClass(veh)..
									"<br>"..Loc[Config.Lan]["check"].plate..trim(GetVehicleNumberPlateText(veh)).."]"..
									"<br>Dist: "..tostring(dist)..
									"<br>Fuel Level: "..math.floor(exports['LegacyFuel']:GetFuel(veh)).."%"
									if VehicleNitrous[trim(GetVehicleNumberPlateText(veh))] then
										dist = dist.."<br>NOS Level: "..tostring((VehicleNitrous[trim(GetVehicleNumberPlateText(veh))].level)).."%" 
									end
									
									dist = dist..
									"<br><br><b>Vehicle Health</b>:"..
									"<br>Engine: "..math.floor(GetVehicleEngineHealth(veh)/10).."%"..
									"<br>Body: "..math.floor(GetVehicleBodyHealth(veh)/10).."%"
									if useMechJob() then
										dist = dist..
										"<br><br><b>Extra Damages</b>:"..
										"<br>"..Loc[Config.Lan]["repair"].radiator..": "..math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "radiator")).."%"..
										"<br>"..Loc[Config.Lan]["repair"].driveshaft..": "..math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "axle")).."%"..
										"<br>"..Loc[Config.Lan]["repair"].brakes..": "..math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "brakes")).."%"..
										"<br>"..Loc[Config.Lan]["repair"].clutch..": "..math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "clutch")).."%"..
										"<br>"..Loc[Config.Lan]["repair"].tank..": "..math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "fuel")).."%"
									end
									
									dist = dist..
									"<br><br><b>Upgrade Levels</b>:"..
									"<br>"..Loc[Config.Lan]["check"].label1.." Lvl "..(GetVehicleMod(vehicle, 11)+1)..
									"<br>"..Loc[Config.Lan]["check"].label2.." Lvl "..(GetVehicleMod(vehicle, 12)+1)..
									"<br>"..Loc[Config.Lan]["check"].label3.." Lvl "..(GetVehicleMod(vehicle, 15)+1)..
									"<br>"..Loc[Config.Lan]["check"].label4.." Lvl "..(GetVehicleMod(vehicle, 13)+1)..
									"<br>"..Loc[Config.Lan]["check"].label5.." Lvl "..(GetVehicleMod(vehicle, 16)+1)..
									"<br>"..Loc[Config.Lan]["check"].label6.." "..tostring(IsToggleModOn(vehicle, 18))..
									"<br>"..Loc[Config.Lan]["check"].label7.." "..tostring(IsToggleModOn(vehicle, 22))..
									"<br>"..Loc[Config.Lan]["check"].label8.." "..tostring(GetDriftTyresEnabled(vehicle))..
									"<br>"..Loc[Config.Lan]["check"].label9.." "..tostring(GetVehicleTyresCanBurst(vehicle))
								end
								if not ShowingOdo then TriggerEvent("jim-mechanic:client:DrawText", dist, tostring(Config.OdoLocation)) ShowingOdo = true
								else TriggerEvent("jim-mechanic:client:DrawText", dist, tostring(Config.OdoLocation)) end
							end
						end
						--Hide if it was enabled, but not now
						if not ShowOdo and ShowingOdo then ShowingOdo = false TriggerEvent("jim-mechanic:client:HideText") end
						DistAdd = DistAdd + #(prevLoc - GetEntityCoords(veh))
						DistCount = DistCount + 1
						if DistCount >= 6 then
							if owned then
								if useMechJob then
									if DoesEntityExist(veh) then
										local mechDamages = {
											["radiator"] = math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "radiator"))+0.0,
											["axle"] = math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "axle"))+0.0,
											["brakes"] = math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "brakes"))+0.0,
											["clutch"] = math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "clutch"))+0.0,
											["fuel"] = math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "fuel"))+0.0,
										}
										TriggerServerEvent('jim-mechanic:server:saveStatus', mechDamages, plate)
									end
								end
								TriggerServerEvent('jim-mechanic:server:UpdateDrivingDistance', plate, math.round(DistAdd)) end
							DistCount = 0
							DistAdd = 0
						end
					end
				end
			end
		else if ShowingOdo then ShowingOdo = false TriggerEvent("jim-mechanic:client:HideText") DistCount = 0 end
		end
		if invehicle then Wait(5000) 
		else Wait(500) end
	end
end)

RegisterNetEvent("jim-mechanic:ShowOdo", function() print("Odometer toggled") ShowOdo = not ShowOdo end)