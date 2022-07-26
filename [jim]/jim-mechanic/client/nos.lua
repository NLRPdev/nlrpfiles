local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== NOS

--Leave alone--
local NitrousActivated = false
local VehicleNitrous = {}
---------------

LastEngineMultiplier = 1.0
local NitrousBoost = 55.0 -- This changes boost power, have fun.
local NitrousUseRate = 0.5 -- How fast the nitrous drains
local NitrousCoolDown = 7000 -- 7000 = 7 Seconds, set to 0 to disable

local OldFlame = false -- Enable to enable QBCore flame effect.
local tyreSync = false -- Enable so EVERY car's purge is the same colour as it's tiresmoke. W.I.P.
local EnableTrails = true -- True adds taillight effects while boosting
local EnableScreen = true -- True adds screen effects while boosting

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() GetNos() end)

AddEventHandler('onResourceStart', function(resource) if GetCurrentResourceName() == resource then GetNos() end end)

function GetNos()
	local p = promise.new()
	QBCore.Functions.TriggerCallback('jim-mechanic:GetNosLoaded', function(vehs) p:resolve(vehs) end)
	VehicleNitrous = Citizen.Await(p)
	for k, v in pairs(VehicleNitrous) do 
		if Config.Debug then print("VehicleNitrous["..tostring(k).."] = { level = "..tonumber(VehicleNitrous[k].level)..", hasnitro = "..tostring(VehicleNitrous[k].hasnitro).." }") end 
	end
end

RegisterNetEvent('jim-mechanic:client:applyNOS', function()
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	--if not jobChecks() then return end --uncomment this line to make nos mechanic only
	--if not locationChecks() then return end
	if not inCar() then return end
	if not nearPoint(coords) then return end
	if not IsPedInAnyVehicle(playerPed, false) then	vehicle = getClosest(coords) pushVehicle(vehicle) end
	if lockedCar(vehicle) then return end
	if DoesEntityExist(vehicle) then
		if not IsToggleModOn(vehicle, 18) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["nos"].notinstalled, "error") return end
		SetVehicleEngineOn(vehicle, false, false, true)
		TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
		Wait(1000)
		playAnim("mini@repair", "fixing_a_ped", 35000, 16)
		SetVehicleDoorOpen(vehicle, 4, false, false)
		
		local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
		Skillbar.Start({ duration = math.random(2500,5000), pos = math.random(10, 30), width = math.random(10, 20),	},
		function() -- On success
		
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["nos"].installing, "success")
			time = math.random(7000,10000)
			playAnim("mini@repair", "fixing_a_ped", time, 16)
			QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing.."NOS..", time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, }, 
			{ animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, }, {}, {}, function()
				ClearPedTasks(playerPed)
				if VehicleNitrous[trim(GetVehicleNumberPlateText(vehicle))] ~= nil then TriggerServerEvent("jim-mechanic:server:giveNOS") end
				TriggerServerEvent('jim-mechanic:server:LoadNitrous', trim(GetVehicleNumberPlateText(vehicle)))
				SetVehicleDoorShut(vehicle, 4, false)
				updateCar(vehicle)
				TriggerServerEvent('jim-mechanic:server:removeNOS')
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["nos"].installed, "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["nos"].failed, "error")
				SetVehicleDoorShut(vehicle, 4, false)
				ClearPedTasks(playerPed)
			end, "nos")
		
		end, function() -- On fail
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["nos"].failed, "error")
			SetVehicleDoorShut(vehicle, 4, false)
			ClearPedTasks(playerPed)
		end)
		
		--[[ -- QB-LOCK
		time = math.random(7000,10000)
		playAnim("mini@repair", "fixing_a_ped", time, 16)
		
		local success = exports['qb-lock']:StartLockPickCircle(math.random(2,4), math.random(7,10), success)
		if success then
			QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing.."NOS..", time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, }, 
			{ animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, }, {}, {}, function()
				ClearPedTasks(playerPed)
				if VehicleNitrous[trim(GetVehicleNumberPlateText(vehicle))] then TriggerServerEvent("jim-mechanic:server:giveNOS") end
				TriggerServerEvent('jim-mechanic:server:LoadNitrous', trim(GetVehicleNumberPlateText(vehicle)))
				SetVehicleDoorShut(vehicle, 4, false)
				updateCar(vehicle)
				TriggerServerEvent('jim-mechanic:server:removeNOS')
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["nos"].installed, "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", Loc[Config.Lan]["nos"].failed, "error")
				SetVehicleDoorShut(vehicle, 4, false)
				emptyHands(playerPed)
			end, "nos")
		else
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["nos"].failed, "error")
			SetVehicleDoorShut(vehicle, 4, false)
			emptyHands(playerPed)
		end]]
	end
end)

--MESS OF CODE TAKEN FROM QB-TUNERCHIP
RegisterNetEvent('jim-mechanic:client:UpdateNitroLevel', function(Plate, level) VehicleNitrous[Plate].level = level end)

RegisterNetEvent('jim-mechanic:client:LoadNitrous', function(Plate)
    VehicleNitrous[Plate] = { hasnitro = true, level = 100, }
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
    local CurrentVehicle = getClosest(coords) pushVehicle(vehicle)
    local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
    if CPlate == Plate then TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false) end
end)

RegisterNetEvent('jim-mechanic:client:UnloadNitrous', function(Plate)
    VehicleNitrous[Plate] = nil
    local CurrentVehicle = GetVehiclePedIsIn(PlayerPedId())
    local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
    if CPlate == Plate then NitrousActivated = false TriggerEvent('hud:client:UpdateNitrous', false, nil, false) end
end)

local nosupdated = false
local previousVehicle = nil
local previousPlate = nil
local boosting = false

CreateThread(function()
    while true do
        local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
		local CurrentVehicle = nil
		local Plate = nil
		if IsInVehicle then
			CurrentVehicle = GetVehiclePedIsIn(PlayerPedId())
			Plate = trim(GetVehicleNumberPlateText(CurrentVehicle))
		end
        if IsInVehicle then
			if VehicleNitrous[Plate] then
				if VehicleNitrous[Plate].hasnitro then
					if IsControlJustPressed(0, 21) and GetPedInVehicleSeat(CurrentVehicle, -1) == PlayerPedId() then
						local speed = GetEntitySpeed(CurrentVehicle)
						local kmh = (speed * 3.6)
						if kmh <= 25.0 then
						TriggerServerEvent('jim-mechanic:server:SyncPurge', VehToNet(CurrentVehicle), true)
						elseif kmh > 25.0 and not boosting then
							boosting = true
							SetVehicleEnginePowerMultiplier(CurrentVehicle, NitrousBoost)
							SetVehicleEngineTorqueMultiplier(CurrentVehicle, NitrousBoost)
							SetEntityMaxSpeed(CurrentVehicle, 999.0)
							NitrousActivated = true
							SetNitroBoostScreenEffectsEnabled(true)
							TriggerServerEvent('jim-mechanic:server:SyncTrail', VehToNet(CurrentVehicle), true)
							SetVehicleBoostActive(CurrentVehicle, 1)

						-- Boosting Effects
							CreateThread(function()
								while NitrousActivated do
									TriggerServerEvent('jim-mechanic:server:SyncPurge', VehToNet(CurrentVehicle), false)
									if VehicleNitrous[Plate].level - 1 >= 0 then
										TriggerServerEvent('jim-mechanic:server:SyncFlame', VehToNet(CurrentVehicle), 1.25)
										TriggerServerEvent('jim-mechanic:server:UpdateNitroLevel', Plate, (VehicleNitrous[Plate].level - NitrousUseRate))
										TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,  VehicleNitrous[Plate].level, true)
									elseif VehicleNitrous[Plate].level - 1 <= 0 then
										TriggerServerEvent('jim-mechanic:server:UnloadNitrous', Plate)
										TriggerServerEvent("jim-mechanic:server:giveNOS")
										SetNitroBoostScreenEffectsEnabled(false)
										TriggerServerEvent('jim-mechanic:server:SyncTrail', VehToNet(CurrentVehicle), false)
										NitrousActivated = false
										SetVehicleBoostActive(CurrentVehicle, 0)
										TriggerServerEvent('jim-mechanic:server:SyncFlame', VehToNet(CurrentVehicle), 0)
										SetVehicleEnginePowerMultiplier(CurrentVehicle, LastEngineMultiplier)
										SetVehicleEngineTorqueMultiplier(CurrentVehicle, 1.0)
									end
									Wait(100)
								end
							end)
							
						end
                    end
				end
				if IsControlJustReleased(0, 21) and GetPedInVehicleSeat(CurrentVehicle, -1) == PlayerPedId() then
					TriggerServerEvent('jim-mechanic:server:SyncPurge', VehToNet(CurrentVehicle), false)
					if NitrousActivated then
						SetVehicleBoostActive(CurrentVehicle, 0)
						TriggerServerEvent('jim-mechanic:server:SyncFlame', VehToNet(CurrentVehicle), 0)
						SetVehicleEnginePowerMultiplier(CurrentVehicle, LastEngineMultiplier)
						SetVehicleEngineTorqueMultiplier(CurrentVehicle, 1.0)
						TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
						NitrousActivated = not NitrousActivated
						TriggerServerEvent('jim-mechanic:server:SyncTrail', VehToNet(CurrentVehicle), false)
						SetNitroBoostScreenEffectsEnabled(false)
						if VehicleNitrous[Plate] then
							CreateThread(function()
								while boosting do
									Wait(NitrousCoolDown)
									boosting = not boosting
								end
							end)
						end
					end
				end
            elseif VehicleNitrous[Plate] == nil then
                if not nosupdated then
				VehicleNitrous[Plate] = nil
				TriggerEvent('hud:client:UpdateNitrous', false, nil, false)
				nosupdated = true end
            end
        else
            if nosupdated then nosupdated = false end
			NitrousActivated = false
            Wait(1500)
        end
        Wait(5)
    end
end)

CreateThread(function()
    while true do
        local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
		local CurrentVehicle = nil
		local Plate = nil
		if IsInVehicle then
			CurrentVehicle = GetVehiclePedIsIn(PlayerPedId())
			Plate = trim(GetVehicleNumberPlateText(CurrentVehicle))
		end
        if IsInVehicle then
			previousPlate = Plate
			previousVehicle = CurrentVehicle
            if VehicleNitrous[Plate] then
                if VehicleNitrous[Plate].hasnitro then
					TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,  VehicleNitrous[Plate].level, false)
				end
			end
        else
			if previousVehicle ~= CurrentVehicle then boosting = false
				if VehicleNitrous[previousPlate] then
					TriggerServerEvent('jim-mechanic:database:UpdateNitroLevel', previousPlate, VehicleNitrous[previousPlate].level)
					TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[previousPlate].hasnitro,  VehicleNitrous[previousPlate].level, false)
				end
				SetVehicleBoostActive(previousVehicle, 0)
				TriggerServerEvent('jim-mechanic:server:SyncTrail', VehToNet(previousVehicle), false)
				SetNitroBoostScreenEffectsEnabled(false)
				TriggerServerEvent('jim-mechanic:server:SyncPurge', VehToNet(previousVehicle), false)
				previousVehicle, previousPlate = nil
			end
        end
        Wait(1500)
    end
end)

--Purge Effects
local vehicles = {}
local particles = {}

function IsVehicleNitroPurgeEnabled(vehicle) return vehicles[vehicle] == true end

RegisterNetEvent('jim-mechanic:client:SyncPurge', function(netid, enabled)
	SetVehicleNitroPurgeEnabled(NetToVeh(netid), enabled)
end)

function setCol(vehicle, ptfx)
	local r,g,b = GetVehicleTyreSmokeColor(vehicle)
	return SetParticleFxLoopedColour(ptfx, r/255, g/255, b/255)
end

function SetVehicleNitroPurgeEnabled(vehicle, enabled)
	local bonnet = nil
	if IsVehicleNitroPurgeEnabled(vehicle) == enabled then return end
	if enabled then
		local r,g,b = GetVehicleTyreSmokeColor(vehicle)
		local bone = GetEntityBoneIndexByName(vehicle, 'bonnet')
		local pos = GetWorldPositionOfEntityBone(vehicle, bone)
		if pos == vector3(0.0, 0.0, 0.0) then
			pos = GetEntityCoords(vehicle) bonnet = false
		end
		local off = GetOffsetFromEntityGivenWorldCoords(vehicle, pos.x, pos.y, pos.z)
		local ptfxs = {}
		for i=0,3 do
			if IsThisModelABike(GetEntityModel(vehicle)) then
				-- Left
				ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x - 0.1, off.y-0.2, off.z, 40.0, -90.0, 70.0, 0.5)
				--Right
				ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x + 0.1, off.y-0.2, off.z, 40.0, 90.0, -70.0, 0.5)
			else
				if bonnet ~= nil then
					if GetEntityModel(vehicle) == -1403128555 then
						--Left
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x-0.10, off.y-0.8, off.z+0.52, 40.0, -20.0, 0.0, 0.2)
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x-0.10, off.y-1.05, off.z+0.49, 40.0, -20.0, 0.0, 0.2)
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x-0.10, off.y-1.3, off.z+0.48, 40.0, -20.0, 0.0, 0.2)
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x-0.10, off.y-1.55, off.z+0.47, 40.0, -20.0, 0.0, 0.2)
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x-0.10, off.y-1.75, off.z+0.40, 40.0, -20.0, 0.0, 0.2)
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x-0.10, off.y-1.9, off.z+0.37, 40.0, -20.0, 0.0, 0.2)
						--Right
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x+0.10, off.y-0.8, off.z+0.52, 40.0, 20.0, 0.0, 0.2)
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x+0.10, off.y-1.05, off.z+0.49, 40.0, 20.0, 0.0, 0.2)
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x+0.10, off.y-1.3, off.z+0.48, 40.0, 20.0, 0.0, 0.2)
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x+0.10, off.y-1.55, off.z+0.47, 40.0, 20.0, 0.0, 0.2)
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x+0.10, off.y-1.75, off.z+0.40, 40.0, 20.0, 0.0, 0.2)
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x+0.10, off.y-1.9, off.z+0.37, 40.0, 20.0, 0.0, 0.2)					
					elseif GetEntityModel(vehicle) == -1963629913 then
						--Left
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x-0.25, off.y-0.62, off.z+0.64, 90.0, 0.0, 0.0, 0.2)
						--Right
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x+0.25, off.y-0.62, off.z+0.64, 90.0, 0.0, 0.0, 0.2)
					else
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x - 0.5, off.y - 1.1, off.z+0.3, 40.0, -20.0, 0.0, 0.5)
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x + 0.5, off.y - 1.1, off.z+0.3, 40.0, 20.0, 0.0, 0.5)
					end
				else
					if GetEntityModel(vehicle) == -682108547 then
						--Left
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, (off.x+0.45)-0.3, off.y-1, off.z-0.1, 40.0, -20.0, 0.0, 0.3)
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, (off.x+0.45)-0.3, off.y-0.8, off.z-0.1, 10.0, -20.0, 0.0, 0.4)
						--Right
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, (off.x+0.45)+ 0.3, off.y-1, off.z-0.1, 40.0, 20.0, 0.0, 0.3)
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, (off.x+0.45)+ 0.3, off.y-0.8, off.z-0.1, 10.0, 20.0, 0.0, 0.4)
					else
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x - 0.4, off.y + 0.05, off.z, 40.0, -20.0, 0.0, 0.5) 
						ptfxs[#ptfxs+1] = CreateVehiclePurgeSpray(vehicle, off.x + 0.4, off.y + 0.05, off.z, 40.0, 20.0, 0.0, 0.5) 
					end
				end
			end
			if tyreSync then for i=1,#ptfxs do SetParticleFxLoopedColour(ptfxs[i], r/255, g/255, b/255) end end
		end
			vehicles[vehicle] = true particles[vehicle] = ptfxs
	else
    if particles[vehicle] and #particles[vehicle] > 0 then for _, particleId in ipairs(particles[vehicle]) do StopParticleFxLooped(particleId) end end
		vehicles[vehicle] = nil
		particles[vehicle] = nil
	end
end
function CreateVehiclePurgeSpray(vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale)
	UseParticleFxAssetNextCall('core')

	return StartParticleFxLoopedOnEntity('ent_sht_steam', vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale, false, false, false)
end

-- Trails
local vehicles2 = {}
local particles2 = {}

function IsVehicleLightTrailEnabled(vehicle) return vehicles2[vehicle] == true end

RegisterNetEvent('jim-mechanic:client:SyncTrail', function(netid, enabled)
	if EnableTrails then SetVehicleLightTrailEnabled(NetToVeh(netid), enabled) end
end)

function SetVehicleLightTrailEnabled(vehicle, enabled, nosid)
	if IsVehicleLightTrailEnabled(vehicle) == enabled then return end
	local myid = GetPlayerServerId(PlayerId())
	if enabled then
		local ptfxs = {}
		ptfxs[#ptfxs+1] = CreateVehicleLightTrail(vehicle, GetEntityBoneIndexByName(vehicle, "taillight_l"), 1.0)
		ptfxs[#ptfxs+1] = CreateVehicleLightTrail(vehicle, GetEntityBoneIndexByName(vehicle, "taillight_r"), 1.0)
		vehicles2[vehicle] = true
		particles2[vehicle] = ptfxs
	else
		if particles2[vehicle] and #particles2[vehicle] > 0 then
			for _, particleId in ipairs(particles2[vehicle]) do StopVehicleLightTrail(particleId, 500) end 
		end
		vehicles2[vehicle] = nil
		particles2[vehicle] = nil
	end
end

function CreateVehicleLightTrail(vehicle, bone, scale)
	UseParticleFxAssetNextCall('core')
	local ptfx = StartParticleFxLoopedOnEntityBone('veh_light_red_trail', vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone, scale, false, false, false)
	SetParticleFxLoopedEvolution(ptfx, "speed", 1.0, false)
	return ptfx
end

function StopVehicleLightTrail(ptfx, duration)
	Citizen.CreateThread(function()
		local startTime = GetGameTimer()
		local endTime = GetGameTimer() + duration
		while GetGameTimer() < endTime do 
			Citizen.Wait(0)
			local now = GetGameTimer()
			local scale = (endTime - now) / duration
			SetParticleFxLoopedScale(ptfx, scale)
			SetParticleFxLoopedAlpha(ptfx, scale)
		end
		StopParticleFxLooped(ptfx)
	end)
end
RegisterNetEvent('jim-mechanic:client:SyncFlame', function(netid, scale)
	if OldFlame then
		RequestNamedPtfxAsset("veh_xs_vehicle_mods")
		while not HasNamedPtfxAssetLoaded("veh_xs_vehicle_mods") do Wait(0) end
		if scale ~= 0 then SetVehicleNitroEnabled(NetToVeh(netid), 1) end
		if scale <= 0 then SetVehicleNitroEnabled(NetToVeh(netid), 0) end
	else
		CreateVehicleExhaustBackfire(NetToVeh(netid), scale)
	end
end)
--Exhaust Fires
function CreateVehicleExhaustBackfire(vehicle, scale)
	local exhaustNames = {
			"exhaust",    "exhaust_2",  "exhaust_3",  "exhaust_4",
			"exhaust_5",  "exhaust_6",  "exhaust_7",  "exhaust_8",
			"exhaust_9",  "exhaust_10", "exhaust_11", "exhaust_12",
			"exhaust_13", "exhaust_14", "exhaust_15", "exhaust_16"
		}

	for _, exhaustName in ipairs(exhaustNames) do
		local boneIndex = GetEntityBoneIndexByName(vehicle, exhaustName)
		if boneIndex ~= -1 then
			local pos = GetWorldPositionOfEntityBone(vehicle, boneIndex)
			local off = GetOffsetFromEntityGivenWorldCoords(vehicle, pos.x, pos.y, pos.z)
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do Wait(0) end
			SetPtfxAssetNextCall("core")
			UseParticleFxAssetNextCall("core")
			StartParticleFxNonLoopedOnEntity("veh_backfire" , vehicle, off.x, off.y, off.z, 0.0, 0.0, 0.0, scale, false, false, false)
		end
	end
end

function SetNitroBoostScreenEffectsEnabled(enabled)
	if enabled and EnableScreen then
		StopScreenEffect('RaceTurbo')
		StartScreenEffect('RaceTurbo', 0, false)
		SetTimecycleModifier('rply_motionblur')
		ShakeGameplayCam('SKY_DIVING_SHAKE', 0.25)
	else
		StopGameplayCamShaking(true)
		SetTransitionTimecycleModifier('default', 0.35)
	end
end

function IsVehicleNitroBoostEnabled(vehicle)
	return vehicles[vehicle] == true
end

function BoostLoop(enabled)
	local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player)
	local driver = GetPedInVehicleSeat(vehicle, -1)
	local enabled = IsVehicleNitroBoostEnabled(vehicle)

	if vehicle == 0 or driver ~= player or not enabled then return end

	if not IsVehicleStopped(vehicle) then
		local vehicleModel = GetEntityModel(vehicle)
		local currentSpeed = GetEntitySpeed(vehicle)
		local maximumSpeed = GetVehicleModelMaxSpeed(vehicleModel)
		local multiplier = 2.0 * maximumSpeed / currentSpeed

		SetVehicleEngineTorqueMultiplier(vehicle, multiplier)
	end
end

-- Mechanic Remove NOS
RegisterNetEvent('jim-mechanic:client:giveNOS', function()
	if not jobChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	if lockedCar(vehicle) then return end
	TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
	Wait(1000)
	SetVehicleDoorOpen(vehicle, 4, false, false)
	playAnim("mini@repair", "fixing_a_ped", 8000, 16)
	QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["nos"].removing, 8000, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, }, 
	{ animDict = "mini@repair", anim = "fixing_a_ped", flags = 16, }, {}, {}, function()
		SetVehicleMod(vehicle, 16, -1)
		SetVehicleDoorShut(vehicle, 4, false)
		updateCar(vehicle)
		TriggerServerEvent('jim-mechanic:server:UnloadNitrous', trim(GetVehicleNumberPlateText(vehicle)))
		TriggerServerEvent('jim-mechanic:server:giveNOS')
		emptyHands(playerPed)				
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["nos"].removed, "success")
	end, function()
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["nos"].remfail, "error")
		emptyHands(playerPed)
	end)
end)