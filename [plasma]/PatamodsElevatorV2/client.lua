-- Wait(500)
local active = false

function DisplayHelpText(text)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringPlayerName(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


Citizen.CreateThread(function()
	RequestScriptAudioBank("CABLE_CAR", false, -1)
	RequestScriptAudioBank("CABLE_CAR_SOUNDS", false, -1)
	LoadStream("CABLE_CAR", "CABLE_CAR_SOUNDS")
	LoadStream("CABLE_CAR_SOUNDS", "CABLE_CAR")
	
	RequestScriptAudioBank("LIFT_NORMAL", false, -1)
	RequestScriptAudioBank("LIFT_NORMAL_SOUNDSET", false, -1)
	RequestScriptAudioBank("Freight_Elevator", false, -1);
	
	-- LIFT_NORMAL_SOUNDSET
end)

-- local firstTime = true

Citizen.CreateThread(function()
	while true do
		-- if firstTime then
		Citizen.Wait(3000)
		local pedcoords = {}
		pedcoords.x,pedcoords.y,pedcoords.z = table.unpack(GetEntityCoords(PlayerPedId()))
		if #(vector3(liftData.lodCoords.x, liftData.lodCoords.y, liftData.lodCoords.z) - vector3(pedcoords.x,pedcoords.y,pedcoords.z)) < 100.0 then
			TriggerServerEvent(tostring(EventHash)..":SendMeStatusPlease")
			print("ask status")
		else
			print("trop loin : "..tostring(#(vector3(liftData.lodCoords.x, liftData.lodCoords.y, liftData.lodCoords.z) - vector3(pedcoords.x,pedcoords.y,pedcoords.z))))
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		
		-- for k,v in pairs(liftData) do
		if active then
			Citizen.Wait(100)
			local pedcoords = {}
			pedcoords.x,pedcoords.y,pedcoords.z = table.unpack(GetEntityCoords(PlayerPedId()))
			
			-- print( tostring(#(vector3(liftData.lodCoords.x, liftData.lodCoords.y, liftData.lodCoords.z) - vector3(pedcoords.x,pedcoords.y,pedcoords.z)))    )
			
			if #(vector3(liftData.lodCoords.x, liftData.lodCoords.y, liftData.lodCoords.z) - vector3(pedcoords.x,pedcoords.y,pedcoords.z)) < 100.0 then
			-- print("liftData.elevateID:"..tostring(liftData.elevateID).." exist?: "..tostring(DoesEntityExist(liftData.elevateID)))
				if not DoesEntityExist(liftData.elevateID) then
					local tempObject
					-- print("Plat Hash : "..tostring(GetHashKey(liftData.elevateProps)).." "..tostring(liftData.elevateProps))
					if not liftData.isUp then
						tempObject = CreateObject(liftData.elevateProps,liftData.down.x,liftData.down.y,liftData.offsetdown.z ,false,true,false)
						toggleTexture("Race")
					else
						tempObject = CreateObject(liftData.elevateProps,liftData.up.x,liftData.up.y,liftData.offsetup.z ,false,true,false)
						toggleTexture("Lobby")
					end
					
					if liftData.useMLOInterior == true then
						-- ForceRoomForEntity(tempObject,129538,549289364)
						-- print("Set Interior and room for elevator")
						ForceRoomForEntity(tempObject,GetInteriorAtCoords(liftData.interiorCoords.x,liftData.interiorCoords.y,liftData.interiorCoords.z),liftData.room)
					end
					FreezeEntityPosition(tempObject,true)
					SetEntityRotation(tempObject,liftData.rotation.a,liftData.rotation.b,liftData.rotation.c,0,false)
					SetEntityHeading(tempObject,liftData.elevateHeading)
					Wait(150)
					FreezeEntityPosition(tempObject,true)
					SetEntityInvincible(tempObject,true)
					-- liftData.elevateNetID = NetworkGetNetworkIdFromEntity(tempObject)
					liftData.elevateID = tempObject
					-- print("liftData.elevateID:"..tostring(liftData.elevateID).." exist?: "..tostring(DoesEntityExist(liftData.elevateID)).." netid : "..tostring(liftData.elevateNetID ))
				else
					if liftData.useMLOInterior == true then
						-- ForceRoomForEntity(liftData.elevateID,129538,549289364)
						-- print("2-Set Interior and room for elevator")
						ForceRoomForEntity(liftData.elevateID,GetInteriorAtCoords(liftData.interiorCoords.x,liftData.interiorCoords.y,liftData.interiorCoords.z),liftData.room)
						
					end
				end
				if not DoesEntityExist(liftData.doorDownID) then
					local tempObject
					-- print("Door Hash : "..tostring(GetHashKey(liftData.doorDown)).." "..tostring(liftData.doorDown))
					-- local tempObject = CreateObject(liftData.doorDown,liftData.doorDownCoords.x,liftData.doorDownCoords.y,liftData.doorDownCoords.z-0.05 ,false,true,true)
					
					if liftData.downDoorIsOpen then
						tempObject = CreateObject(liftData.doorDown,liftData.doorDownOpenCoords.x,liftData.doorDownOpenCoords.y,liftData.doorDownOpenCoords.z ,false,true,true)
					else
						tempObject = CreateObject(liftData.doorDown,liftData.doorDownCoords.x,liftData.doorDownCoords.y,liftData.doorDownCoords.z ,false,true,true)
					end
					
					
					
					if liftData.useMLOInterior == true then
						-- ForceRoomForEntity(tempObject,129538,549289364)
						-- print("Set Interior and room for door down")
						ForceRoomForEntity(tempObject,GetInteriorAtCoords(liftData.interiorCoords.x,liftData.interiorCoords.y,liftData.interiorCoords.z),liftData.room)
					else
						-- print("liftData.interior : "..tostring(liftData.interior).." liftData.room : "..tostring(liftData.room))
					end
					
					FreezeEntityPosition(tempObject,true)
					SetEntityHeading(tempObject,liftData.doorDownHeading)
					Wait(150)
					FreezeEntityPosition(tempObject,true)
					SetEntityInvincible(tempObject,true)
					-- liftData.doorDownNetID = NetworkGetNetworkIdFromEntity(tempObject)
					liftData.doorDownID = tempObject
					-- print("liftData.doorDownID:"..tostring(liftData.doorDownID).." exist?: "..tostring(DoesEntityExist(liftData.doorDownID)).." netid : "..tostring(liftData.doorDownNetID))
				else
					if liftData.useMLOInterior == true then
						-- ForceRoomForEntity(liftData.doorDownID,129538,549289364)
						-- print("2-Set Interior and room for door down")
						ForceRoomForEntity(liftData.doorDownID,GetInteriorAtCoords(liftData.interiorCoords.x,liftData.interiorCoords.y,liftData.interiorCoords.z),liftData.room)
					else
						-- print("liftData.interior : "..tostring(liftData.interior).." liftData.room : "..tostring(liftData.room))
					end
				end
				if not DoesEntityExist(liftData.doorUpID) then
					local tempObject
					if liftData.upDoorIsOpen then
						-- print("spawn up door 1")
						tempObject = CreateObject(liftData.doorUp,liftData.doorUpOpenCoords.x,liftData.doorUpOpenCoords.y,liftData.doorUpOpenCoords.z ,false,true,true)
					else
						-- print("spawn up door 2")
						tempObject = CreateObject(liftData.doorUp,liftData.doorUpCoords.x,liftData.doorUpCoords.y,liftData.doorUpCoords.z,false,true,true)
					end
					
					if liftData.useMLOInterior == true then
						-- ForceRoomForEntity(tempObject,129538,549289364)
						-- print("Set Interior and room for door up")
						ForceRoomForEntity(tempObject,GetInteriorAtCoords(liftData.interiorCoords.x,liftData.interiorCoords.y,liftData.interiorCoords.z),liftData.room)
					else
						-- print("liftData.interior : "..tostring(liftData.interior).." liftData.room : "..tostring(liftData.room))
					end
					
					FreezeEntityPosition(tempObject,true)
					SetEntityHeading(tempObject,liftData.doorUpHeading)
					Wait(150)
					FreezeEntityPosition(tempObject,true)
					SetEntityInvincible(tempObject,true)
					-- liftData.doorUpNetID = NetworkGetNetworkIdFromEntity(tempObject)
					liftData.doorUpID = tempObject
					-- print("liftData.doorUpID:"..tostring(liftData.doorUpID).." exist?: "..tostring(DoesEntityExist(liftData.doorUpID)).." netid : "..tostring(liftData.doorUpNetID))
				else
					if liftData.useMLOInterior == true then
						-- print("2-Set Interior and room for door up")
						ForceRoomForEntity(liftData.doorUpID,GetInteriorAtCoords(liftData.interiorCoords.x,liftData.interiorCoords.y,liftData.interiorCoords.z),liftData.room)
					else
						-- print("liftData.interior : "..tostring(liftData.interior).." liftData.room : "..tostring(liftData.room))
					end
				end
			elseif #(vector3(liftData.lodCoords.x, liftData.lodCoords.y, liftData.lodCoords.z) - vector3(pedcoords.x,pedcoords.y,pedcoords.z)) > 135.0 then
				if DoesEntityExist(liftData.elevateID) then
					DeleteEntity(liftData.elevateID)
				end
				if DoesEntityExist(liftData.doorDownID) then
					DeleteEntity(liftData.doorDownID)
				end
				if DoesEntityExist(liftData.doorUpID) then
					DeleteEntity(liftData.doorUpID)
				end
				Citizen.Wait(1000)
			else
				print("plus de 100m moins de 135")
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)
		if not liftData.isInUse then
			local px,py,pz = table.unpack(GetEntityCoords(PlayerPedId(), true))
			
			local contDownDist = #(vector3(px, py, pz) - vector3(liftData.controldown.x,liftData.controldown.y,liftData.controldown.z))
			local contUpDist = #(vector3(px, py, pz) - vector3(liftData.controlup.x,liftData.controlup.y,liftData.controlup.z))
			local contIntDownDist = #(vector3(px, py, pz) - vector3(liftData.controlCabineDown.x,liftData.controlCabineDown.y,liftData.controlCabineDown.z))
			local contIntUpDist = #(vector3(px, py, pz) - vector3(liftData.controlCabineUp.x,liftData.controlCabineUp.y,liftData.controlCabineUp.z))
			
			if  contDownDist > 3.0 and contUpDist > 3.0 and contIntDownDist > 3.0 and contIntUpDist > 3.0 then
				Wait(1000)
			else
				if contDownDist < 1.0  then -- En bas appel
					DisplayHelpText(t[Lang].call)
					if IsControlJustReleased(1, 51) then
						TriggerServerEvent(tostring(EventHash)..":askDownstair")
						PlaySoundFromEntity(-1, "Pin_Good", PlayerPedId(),"DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
						Wait(2000)
					end
				end
				if contUpDist < 1.0  then -- En haut appel
					DisplayHelpText(t[Lang].call)
					if IsControlJustReleased(1, 51) then
					TriggerServerEvent(tostring(EventHash)..":askUpstair")
					PlaySoundFromEntity(-1, "Pin_Good",  PlayerPedId(),"DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
					Wait(2000)
					end
				end
				if contIntDownDist < 1.0  then -- dedans en bas donc monte
					DisplayHelpText(t[Lang].up)
					if IsControlJustReleased(1, 51) then
					TriggerServerEvent(tostring(EventHash)..":askToGoUp")
					Wait(2000)
					end
				end
				if contIntUpDist < 1.0  then -- dedans en haut donc descend
					DisplayHelpText(t[Lang].down)
					if IsControlJustReleased(1, 51) then
					TriggerServerEvent(tostring(EventHash)..":askToGoDown")
					Wait(2000)
					end
				end	
			end
		end
	end
end)


RegisterNetEvent(tostring(EventHash)..':openDoorUP')
AddEventHandler(tostring(EventHash)..':openDoorUP', function(doorNetId)
	local newCoords = {}
	local Door = liftData.doorUpID
	PlaySoundFromEntity(-1, "Hack_Success", Door,"DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 0)
	
	newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(Door))
	local DBGCPT = 0
	while math.abs(newCoords.z-liftData.doorUpOpenCoords.z) > 0.02 and DBGCPT < 800 do
		DBGCPT = DBGCPT + 1
		Wait(0)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(Door))
		SetEntityCoords(Door,newCoords.x,newCoords.y,newCoords.z+0.01)
	end

	Citizen.Wait(10)
	SetEntityCoords(Door,liftData.doorUpOpenCoords.x,liftData.doorUpOpenCoords.y,liftData.doorUpOpenCoords.z)
end)

RegisterNetEvent(tostring(EventHash)..':openDoorDown')
AddEventHandler(tostring(EventHash)..':openDoorDown', function(doorNetId)
	local newCoords = {}
	local Door = liftData.doorDownID
	PlaySoundFromEntity(-1, "Hack_Success", Door,"DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 0)
	newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(Door))
	local DBGCPT = 0
	while math.abs(newCoords.z-liftData.doorDownOpenCoords.z) > 0.02 and DBGCPT < 800 do
		DBGCPT = DBGCPT + 1
		Wait(0)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(Door))
		SetEntityCoords(Door,newCoords.x,newCoords.y,newCoords.z+0.01)
	end

	Citizen.Wait(10)
	print("openDoorDown : "..tostring(newCoords.z))
	SetEntityCoords(Door,liftData.doorDownOpenCoords.x,liftData.doorDownOpenCoords.y,liftData.doorDownOpenCoords.z)
end)

RegisterNetEvent(tostring(EventHash)..':closeDoorUP')
AddEventHandler(tostring(EventHash)..':closeDoorUP', function(doorNetId)
	local newCoords = {}
	local Door = liftData.doorUpID
	
	newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(Door))
	local DBGCPT = 0
	while math.abs(newCoords.z-(liftData.doorUpCoords.z+0.08)) > 0.02 and DBGCPT < 800 do
		DBGCPT = DBGCPT + 1
		Wait(0)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(Door))
		SetEntityCoords(Door,newCoords.x,newCoords.y,newCoords.z-0.01)
	end

	Citizen.Wait(10)
	print("closeDoorUP : "..tostring(newCoords.z))
	SetEntityCoords(Door,liftData.doorUpCoords.x,liftData.doorUpCoords.y,liftData.doorUpCoords.z+0.08)
end)

RegisterNetEvent(tostring(EventHash)..':closeDoorDown')
AddEventHandler(tostring(EventHash)..':closeDoorDown', function(doorNetId)
	local newCoords = {}
	local Door = liftData.doorDownID
	
	newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(Door))
	local DBGCPT = 0
	while math.abs(newCoords.z-(liftData.doorDownCoords.z+0.08)) > 0.02 and DBGCPT < 800 do
		DBGCPT = DBGCPT + 1
		Wait(0)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(Door))
		SetEntityCoords(Door,newCoords.x,newCoords.y,newCoords.z-0.01)
	end

	Citizen.Wait(10)
	print("closeDoorDown : "..tostring(newCoords.z))
	SetEntityCoords(Door,liftData.doorDownCoords.x,liftData.doorDownCoords.y,liftData.doorDownCoords.z+0.08)
end)


local upSpeed = 140
local downSpeed = 140

local velocity = -2.6

RegisterCommand("+downlift", function(source, args, fullCommand)
	downSpeed = downSpeed + 5
	print("New downSpeed: "..tostring(downSpeed))
end, false)

RegisterCommand("activelift", function(source, args, fullCommand)
	TriggerServerEvent(tostring(EventHash)..':GetStatus')
	Wait(1000)
	
	active = true
end, false)

RegisterCommand("-downlift", function(source, args, fullCommand)
	downSpeed = downSpeed - 5
	print("New downSpeed: "..tostring(downSpeed))
end, false)

RegisterCommand("+speed", function(source, args, fullCommand)
	velocity = velocity + 0.1
	print("New downSpeed: "..tostring(velocity))
end, false)

RegisterCommand("-speed", function(source, args, fullCommand)
	velocity = velocity - 0.1
	print("New downSpeed: "..tostring(velocity))
end, false)

function getPlayerNearMe(dist)
	local tabPlayer = GetActivePlayers()
	local tabToReturn = {}
	for k,v in pairs (tabPlayer) do
		local ped = GetPlayerPed(v)
		
		if (#(GetEntityCoords(PlayerPedId()) - GetEntityCoords(ped))<dist) then
			tabToReturn[#tabToReturn+1] = ped
		end
	end
	return tabToReturn
end

RegisterNetEvent(tostring(EventHash)..':goDown')
AddEventHandler(tostring(EventHash)..':goDown', function(elevateNetId)
	local newCoords = {}
	local CommutAudio = true
	elevate = liftData.elevateID
	FreezeEntityPosition(elevate,true)
	newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(elevate))
	local allPedNear = getPlayerNearMe(4.7)
	local DBGCPT = 0
	toggleTexture("Down")
	TriggerServerEvent(tostring(EventHash)..':synchroDown')
	local cptMax = ((1/Timestep())*27.7) + 2200
	while math.abs(newCoords.z-liftData.down.z) > 0.02 and DBGCPT < cptMax do
		if liftData.useMLOInterior == true then
			ForceRoomForEntity(elevate,liftData.interior,liftData.room)
			ForceRoomForEntity(PlayerPedId(),liftData.interior,liftData.room)
		end
		SetEntityLights(elevate,true)
		DBGCPT = DBGCPT + 1
		local speed = ((1.0 / (liftData.up.z-liftData.down.z)) * Timestep())*downSpeed
		Wait(7)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(elevate))

		if (#(GetEntityCoords(PlayerPedId()) - GetEntityCoords(elevate))<4.7) then
			if CommutAudio == true then
				audio = GetSoundId()
				-- PlaySoundFromEntity(audio, "Running", elevate, "CABLE_CAR_SOUNDS", 0, 0)
				PlaySoundFromEntity(audio, "FREIGHT_ELEVATOR_01_MOTOR", elevate, 0, 0, 0)
				CommutAudio = false
			end
			SetEntityVelocity(PlayerPedId(),0.0,0.0,velocity)
			for k,v in pairs(allPedNear) do
				SetEntityVelocity(v,0.0,0.0,velocity)
				if liftData.useMLOInterior == true then
					ForceRoomForEntity(v,liftData.interior,liftData.room)
				end
			end
		end
		
		SetEntityCoords(elevate,newCoords.x,newCoords.y,newCoords.z-speed)
		FreezeEntityPosition(elevate,true)
	end
	print("DBGCPT : "..tostring(DBGCPT))
	Citizen.Wait(10)
	SetEntityCoords(elevate,liftData.down.x,liftData.down.y,liftData.down.z)
	if CommutAudio == false then
		StopSound(audio)
        ReleaseSoundId(audio)
	end
	FreezeEntityPosition(elevate,true)
	-- TriggerServerEvent(tostring(EventHash)..':reachDown')
	toggleTexture("Race")
end)

RegisterNetEvent(tostring(EventHash)..':goUp')
AddEventHandler(tostring(EventHash)..':goUp', function(elevateNetId)
	local newCoords = {}
	local CommutAudio = true
	elevate = liftData.elevateID
	FreezeEntityPosition(elevate,true)
	newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(elevate))
	local allPedNear = getPlayerNearMe(4.7)
	local DBGCPT = 0
	toggleTexture("Up")
	TriggerServerEvent(tostring(EventHash)..':synchroUp')
	local cptMax = ((1/Timestep())*27.7) + 2200
	while math.abs(newCoords.z-liftData.up.z) > 0.02 and DBGCPT < cptMax do
		if liftData.useMLOInterior == true then
			ForceRoomForEntity(elevate,liftData.interior,liftData.room)
			ForceRoomForEntity(PlayerPedId(),liftData.interior,liftData.room)
		end
		SetEntityLights(elevate,true)
		DBGCPT = DBGCPT + 1
		local speed = ((1.0 / (liftData.up.z-liftData.down.z)) * Timestep())*upSpeed
		Wait(7)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(elevate))
		
		if (#(GetEntityCoords(PlayerPedId()) - GetEntityCoords(elevate))<4.7) then
			if CommutAudio == true then
				audio = GetSoundId()
				-- PlaySoundFromEntity(audio, "Running", elevate, "CABLE_CAR_SOUNDS", 0, 0)
				PlaySoundFromEntity(audio, "FREIGHT_ELEVATOR_02_MOTOR", elevate, 0, 0, 0)
				CommutAudio = false
			end
			SetEntityVelocity(PlayerPedId(),0.0,0.0,0.5)
			for k,v in pairs(allPedNear) do
				SetEntityVelocity(v,0.0,0.0,1.0)
				if liftData.useMLOInterior == true then
					ForceRoomForEntity(v,liftData.interior,liftData.room)
				end
			end
		end
		
		SetEntityCoords(elevate,newCoords.x,newCoords.y,newCoords.z+speed)
		FreezeEntityPosition(elevate,true)
	end
	print("DBGCPT : "..tostring(DBGCPT))
	Citizen.Wait(10)
	SetEntityCoords(elevate,liftData.up.x,liftData.up.y,liftData.up.z)
	if CommutAudio == false then
		StopSound(audio)
        ReleaseSoundId(audio)
	end
	FreezeEntityPosition(elevate,true)
	-- TriggerServerEvent(tostring(EventHash)..':reachUp')
	toggleTexture("Lobby")
end)

AddEventHandler('onResourceStop', function(resource)
	print("Resource stop")
  if resource == GetCurrentResourceName() then
    -- DestroyAllProps()
	-- for k,v in pairs(liftData) do
	if DoesEntityExist(liftData.elevateID) then
		DeleteEntity(liftData.elevateID)
	end
	if DoesEntityExist(liftData.doorDownID) then
		DeleteEntity(liftData.doorDownID)
	end
	if DoesEntityExist(liftData.doorUpID) then
		DeleteEntity(liftData.doorUpID)
	end
	-- end
  end
end)





local timerFinished = {}

function timer2(timetowait)
	-- timerFinished = false
	Citizen.SetTimeout(timetowait, function()
		timerFinished[#timerFinished] = true
	end)
end

function NewWait(timeToWait)
	timerFinished[#timerFinished+1] = false
	timer2(timeToWait)
	while not timerFinished[#timerFinished] do
		Wait(0)
	end
end

AddEventHandler('playerSpawned', function()
	TriggerServerEvent(tostring(EventHash)..':GetStatus')
	Wait(10000)
	active = true
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	TriggerServerEvent(tostring(EventHash)..':GetStatus')
	Wait(10000)
	active = true
end)

RegisterNetEvent(tostring(EventHash)..':sendStatus')
AddEventHandler(tostring(EventHash)..':sendStatus', function(data)
	liftData.isUp = data.isUp
	liftData.isInUse = data.isInUse
	liftData.downDoorIsOpen = data.downDoorIsOpen
	liftData.upDoorIsOpen = data.upDoorIsOpen
end)

TriggerServerEvent(tostring(EventHash)..':GetStatus')


function toggleTexture(currText)

	Citizen.CreateThread(function()
		local txd1 = CreateRuntimeTxd('elevatorTxd1')
		CreateRuntimeTextureFromImage(txd1,"elevatorTex1","img/elevatorlobby.png")
		
		local txd2 = CreateRuntimeTxd('elevatorTxd2')
		CreateRuntimeTextureFromImage(txd2,"elevatorTex2","img/elevatordown.png")
		
		local txd3 = CreateRuntimeTxd('elevatorTxd3')
		CreateRuntimeTextureFromImage(txd3,"elevatorTex3","img/elevatorrace.png")
		
		local txd4 = CreateRuntimeTxd('elevatorTxd4')
		CreateRuntimeTextureFromImage(txd4,"elevatorTex4","img/elevatorup.png")
		
		local txd5 = CreateRuntimeTxd('elevatorTxd5')
		CreateRuntimeTextureFromImage(txd5,"elevatorTex5","img/elevatorlobby.png")
		
		if currText == "Lobby" then
			print("Lobby")
			AddReplaceTexture('patoche_plasmakart_elevator', 'elevatorlobby', 'elevatorTxd1', 'elevatorTex1')
		elseif currText == "Down" then
			print("Down")
			AddReplaceTexture('patoche_plasmakart_elevator', 'elevatorlobby', 'elevatorTxd2', 'elevatorTex2')
		elseif currText == "Race" then
			print("Race")
			AddReplaceTexture('patoche_plasmakart_elevator', 'elevatorlobby', 'elevatorTxd3', 'elevatorTex3')
		elseif currText == "Up" then
			print("up")
			AddReplaceTexture('patoche_plasmakart_elevator', 'elevatorlobby', 'elevatorTxd4', 'elevatorTex4')
		else
			AddReplaceTexture('patoche_plasmakart_elevator', 'elevatorlobby', 'elevatorTxd5', 'elevatorTex5')
			print("other")
		end
	end)
end

RegisterCommand("+texture", function(source, args, fullCommand)
	print("args[1]:"..tostring(args[1]))
	if args[1] == "Lobby" then
		toggleTexture(args[1])
	elseif args[1] == "Down" then
		toggleTexture(args[1])
	elseif args[1] == "Race" then
		toggleTexture(args[1])
	elseif args[1] == "Up" then
		toggleTexture(args[1])
	else
		Citizen.CreateThread(function()
			local txd2 = CreateRuntimeTxd('duiTxd2')
			local duiObj2 = CreateDui('img/elevatorlobby.png', 565, 309)
			_G.duiObj2 = duiObj2
			local dui2 = GetDuiHandle(duiObj2)
			local tx2 = CreateRuntimeTextureFromDuiHandle(txd2, 'duiTex2', dui2)
			AddReplaceTexture('patoche_plasmakart_elevator', 'elevatorlobby', 'duiTxd2', 'duiTex2')
			print("eeror args")
		end)
	end
end, false)

