
-- Wait(500)

-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(3000)
		-- TriggerClientEvent(tostring(EventHash)..':sendStatus',-1,liftData)
	-- end
-- end)
		
RegisterServerEvent(tostring(EventHash)..':SendMeStatusPlease') --Demande l'ascenseur en bas
AddEventHandler(tostring(EventHash)..':SendMeStatusPlease', function()
	local player = source
	TriggerClientEvent(tostring(EventHash)..':sendStatus',player,liftData)
	print("send status to : "..tostring(player))
end)
		
function goUp()
	local elevateOwner = NetworkGetEntityOwner(liftData.elevateID)
	local elevateNetId = NetworkGetNetworkIdFromEntity(liftData.elevateID)
	
	if not liftData.isInUse then
		print("not isInUse goUp")
			liftData.isUp = true
		liftData.isInUse = true
			if liftData.downDoorIsOpen == true then
		closeDoorDown()
			Wait(6000)
			end
		TriggerClientEvent(tostring(EventHash)..':sendStatus',-1,liftData)
		TriggerClientEvent(tostring(EventHash)..':goUp',-1,elevateNetId)
	else
		print("goUp isInUse so dont move")
	
	end
end


function goDown()
	local elevateOwner = NetworkGetEntityOwner(liftData.elevateID)
	local elevateNetId = NetworkGetNetworkIdFromEntity(liftData.elevateID)
	
	if not liftData.isInUse then
		print("not isInUse goDown")
		liftData.isUp = false
		liftData.isInUse = true
		if liftData.upDoorIsOpen == true then
		closeDoorUp()
		Wait(6000)
		end
		TriggerClientEvent(tostring(EventHash)..':sendStatus',-1,liftData)
		TriggerClientEvent(tostring(EventHash)..':goDown',-1,elevateNetId)
	else
		print("goDown isInUse so dont move")
	
	end
end


function openDoorUp()
	local DoorOwner = NetworkGetEntityOwner(liftData.doorUpID)
	local DoorNetId = NetworkGetNetworkIdFromEntity(liftData.doorUpID)

	if not liftData.upDoorIsOpen then
		print("openDoorUp")
		liftData.upDoorIsOpen = true
		TriggerClientEvent(tostring(EventHash)..':sendStatus',-1,liftData)
		TriggerClientEvent(tostring(EventHash)..':openDoorUP',-1,DoorNetId)
	end
end

function openDoorDown()
	local DoorOwner = NetworkGetEntityOwner(liftData.doorDownID)
	local DoorNetId = NetworkGetNetworkIdFromEntity(liftData.doorDownID)
	
	if not liftData.downDoorIsOpen then
		print("openDoorDown")
		liftData.downDoorIsOpen = true
		TriggerClientEvent(tostring(EventHash)..':sendStatus',-1,liftData)
		TriggerClientEvent(tostring(EventHash)..':openDoorDown',-1,DoorNetId)
		
	end
end

function closeDoorUp()
	local DoorOwner = NetworkGetEntityOwner(liftData.doorUpID)
	local DoorNetId = NetworkGetNetworkIdFromEntity(liftData.doorUpID)

	if liftData.upDoorIsOpen then
		print("closeDoorUp")
		liftData.upDoorIsOpen = false
		TriggerClientEvent(tostring(EventHash)..':sendStatus',-1,liftData)
		TriggerClientEvent(tostring(EventHash)..':closeDoorUP',-1,DoorNetId)
	end
end

function closeDoorDown()
	local DoorOwner = NetworkGetEntityOwner(liftData.doorDownID)
	local DoorNetId = NetworkGetNetworkIdFromEntity(liftData.doorDownID)

	if liftData.downDoorIsOpen then
		print("closeDoorDown")
		liftData.downDoorIsOpen = false
		TriggerClientEvent(tostring(EventHash)..':sendStatus',-1,liftData)
		TriggerClientEvent(tostring(EventHash)..':closeDoorDown',-1,DoorNetId)
	end
end

RegisterServerEvent(tostring(EventHash)..':askUpstair') --Demande l'ascenseur en haut
AddEventHandler(tostring(EventHash)..':askUpstair', function(code)
	if not liftData.isInUse then
		if liftData.isUp then
			print("Is Outside UP already here so open door")
			openDoorUp()
			print("Is in use? : "..tostring(liftData.isInUse).." isUp? : "..tostring(liftData.isUp))
		else
			print("Is Outside UP elevator goUp")
			print("1-Is in use? : "..tostring(liftData.isInUse).." isUp? : "..tostring(liftData.isUp))
			goUp()
			liftData.isInUse = true
			Wait(33000)
			print("2-Is in use? : "..tostring(liftData.isInUse).." isUp? : "..tostring(liftData.isUp))
			openDoorUp()
			Wait(7000)
			liftData.isInUse = false
			print("3-Is in use? : "..tostring(liftData.isInUse).." isUp? : "..tostring(liftData.isUp))
		end
	end
end)


RegisterServerEvent(tostring(EventHash)..':askDownstair') --Demande l'ascenseur en bas
AddEventHandler(tostring(EventHash)..':askDownstair', function(code)
	if not liftData.isInUse then
		if not liftData.isUp then
			print("Is Outside Down already here so open door")
			openDoorDown()
			print("Is in use? : "..tostring(liftData.isInUse).." isUp? : "..tostring(liftData.isUp))
		else
			print("Is Outside Down elevator goDown")
			print("1-Is in use? : "..tostring(liftData.isInUse).." isUp? : "..tostring(liftData.isUp))
			goDown()
			liftData.isInUse = true
			Wait(33000)
			print("2-Is in use? : "..tostring(liftData.isInUse).." isUp? : "..tostring(liftData.isUp))
			openDoorDown()
			Wait(7000)
			liftData.isInUse = false
			print("3-Is in use? : "..tostring(liftData.isInUse).." isUp? : "..tostring(liftData.isUp))
		end
	end
end)

RegisterServerEvent(tostring(EventHash)..':askToGoUp') --Demande l'ascenseur en bas
AddEventHandler(tostring(EventHash)..':askToGoUp', function(code)
	print("Is Inside and ask to go UP")
	print("1-Is in use? : "..tostring(liftData.isInUse).." isUp? : "..tostring(liftData.isUp))
	goUp()
	liftData.isInUse = true
	Wait(37000)
	print("2-Is in use? : "..tostring(liftData.isInUse).." isUp? : "..tostring(liftData.isUp))
	openDoorUp()
	Wait(8000)
	liftData.isInUse = false
	print("3-Is in use? : "..tostring(liftData.isInUse).." isUp? : "..tostring(liftData.isUp))
end)

RegisterServerEvent(tostring(EventHash)..':askToGoDown') --Demande l'ascenseur en bas
AddEventHandler(tostring(EventHash)..':askToGoDown', function(code)
	print("Is Inside and ask to go Down")
	print("1-Is in use? : "..tostring(liftData.isInUse).." isUp? : "..tostring(liftData.isUp))
	goDown()
	liftData.isInUse = true
	Wait(37000)
	print("2-Is in use? : "..tostring(liftData.isInUse).." isUp? : "..tostring(liftData.isUp))
	openDoorDown()
	Wait(8000)
	liftData.isInUse = false
	print("3-Is in use? : "..tostring(liftData.isInUse).." isUp? : "..tostring(liftData.isUp))
end)

RegisterServerEvent(tostring(EventHash)..':synchroDown') --Demande l'ascenseur en bas
AddEventHandler(tostring(EventHash)..':synchroDown', function()
	-- goDown()
	-- local ctime = GetGameTimer() + 1000
	-- while(GetGameTimer() < ctime) do
		-- Citizen.Wait(0)
	-- end
	-- openDoorDown()
	-- liftData.isInUse = false
	print("synchroDown is up false")
	liftData.isUp = false
end)

RegisterServerEvent(tostring(EventHash)..':synchroUp') --Demande l'ascenseur en bas
AddEventHandler(tostring(EventHash)..':synchroUp', function()
	-- goDown()
	-- local ctime = GetGameTimer() + 1000
	-- while(GetGameTimer() < ctime) do
		-- Citizen.Wait(0)
	-- end
	-- openDoorUp()
	-- liftData.isInUse = false
	print("synchroUp is up true")
	liftData.isUp = true
end)

RegisterServerEvent(tostring(EventHash)..':reachDown') --Demande l'ascenseur en bas
AddEventHandler(tostring(EventHash)..':reachDown', function()
	-- goDown()
	print("source: "..tostring(source).." reachDown")
	local ctime = GetGameTimer() + 1000
	while(GetGameTimer() < ctime) do
		Citizen.Wait(0)
	end
	if liftData.isInUse == true then
		openDoorDown()
	end
	local ctime = GetGameTimer() + 10000
	while(GetGameTimer() < ctime) do
		Citizen.Wait(0)
	end
	liftData.isInUse = false
	liftData.isUp = false
end)

RegisterServerEvent(tostring(EventHash)..':reachUp') --Demande l'ascenre bas
AddEventHandler(tostring(EventHash)..':reachUp', function()
	-- goDown()
	print("source: "..tostring(source).." reachUp")
	local ctime = GetGameTimer() + 1000
	while(GetGameTimer() < ctime) do
		Citizen.Wait(0)
	end
	if liftData.isInUse == true then
		openDoorUp()
	end
	local ctime = GetGameTimer() + 10000
	while(GetGameTimer() < ctime) do
		Citizen.Wait(0)
	end
	liftData.isInUse = false
	liftData.isUp = true
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

RegisterServerEvent(tostring(EventHash)..':GetStatus')
AddEventHandler(tostring(EventHash)..':GetStatus', function()
	local player = source
	TriggerClientEvent(tostring(EventHash)..':sendStatus',player,liftData)
end)