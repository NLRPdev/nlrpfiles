


-- PUT HERE YOUR SPECIFIC FUNCTION TO GET THE PLAYER NAME
function GetPlayerPseudo(source)
	
	
	local name = GetPlayerName(source)
	return name
end



RegisterServerEvent("PlasmaKart:ServerSpawnedKartFunction")
AddEventHandler("PlasmaKart:ServerSpawnedKartFunction", function(kartID,kartPlate)
	local player = source
	local kart = NetworkGetEntityFromNetworkId(kartID)
	-- This is Called when the kart is created
	-- You can add here all that you need (server side)
	-- key for hotwire script
	-- fuel
	-- etc...
	
	-- kartID is the network id of the kart
	-- kart is the id of the entity
	-- kartPlate is the license plate of the kart
	
	print(tostring(player).." SpawnedKartFunction")
	
end)

RegisterServerEvent("PlasmaKart:ExtCpPassed")
AddEventHandler("PlasmaKart:ExtCpPassed", function(currentShop,curCP,curLap,kart)
	local player = source
	-- This is called each time the kart pass a checkpoint
	-- you can add here all that you need (server side)
	-- repair function
	-- refuel
	-- etc...
	-- 
	-- currentShop is the place where the race as been launch (if you have only one lobby this will be the same each time)
	-- curCP  this is the number of the currentCP passed
	-- curLap this is the number of the current lap
	-- kart this is the kart entity
	print(tostring(player).." ExtCpPassed")
end)

RegisterServerEvent("PlasmaKart:AskForCreateAlobby")
AddEventHandler("PlasmaKart:AskForCreateAlobby", function(data)
	local player = source
	local canCreateAlobby = true
	
	-- This is called when someone try to create a lobby (pressing the validate key)
	-- you can add here all that you need (server side)
	-- check if have the any role
	-- payment
	-- etc...
	-- 
	-- data contain all the data needed to create the session
	-- data.sessionname => the lobby name
	-- data.gamemode => Classic Race / Battle Race
	-- data.maps => current maps
	-- data.nblap => number of lap
	-- data.cylindre => kart power (50cc,100cc etc...)
	-- data.curshop => the place where the race as been launch (if you have only one lobby this will be the same each time)
	
	
	if canCreateAlobby then
		print("canCreateAlobby")
		TriggerClientEvent("PlasmaKart:OkForCreateAlobby",player,data)
	else
		notification(player,trad[lang]["CantCreateASession"],"error")
	end

	-- print(tostring(player).." ExtCpPassed")
end)


RegisterServerEvent("PlasmaKart:AskForJoinASession")
AddEventHandler("PlasmaKart:AskForJoinASession", function(player,shop,nbPlayer)
	-- local player = source
	local canJoinASession = true
	
	-- This is called when someone try to join a lobby
	-- you can add here all that you need (server side)
	-- check if have the any role
	-- payment
	-- etc...
	-- 
	-- player is the player source

	
	if canJoinASession then
		print("canJoinASession")
		TriggerEvent("PlasmaKart:CanJoinSession",player,shop,nbPlayer)
	else
		notification(player,trad[lang]["CantJoinASession"],"error")
	end

	-- print(tostring(player).." ExtCpPassed")
end)


RegisterServerEvent('PlasmaKart:AskDeleteSession')
AddEventHandler('PlasmaKart:AskDeleteSession', function(shop,owner)
	local player = source
	if not owner then
		local canDeleteSession = false
		local authorizedIdentifier = {
		"fivem:XXX",
		"steam:XXX",
		}
		for k,v in pairs(authorizedIdentifier) do
			for k1,v1 in ipairs(GetPlayerIdentifiers(player)) do
				print(tostring(v))
				if v == v1 then
					canDeleteSession = true
					break
				end
			end
			if canDeleteSession == true then
				break
			end
		end
		if canDeleteSession == true then
			TriggerEvent('PlasmaKart:DeleteSession',shop,player)
		else
			notification(player,trad[lang]["CantDeleteSession"],"error")
		end
		-- print("PlasmaKart:AskDeleteSession")
	else
		TriggerEvent('PlasmaKart:DeleteSession',shop,player)
	end
end)

RegisterServerEvent('PlasmaKart:getIdentifier')
AddEventHandler('PlasmaKart:getIdentifier', function(data)
	local player = source
	for k,v in ipairs(GetPlayerIdentifiers(player)) do
		print(tostring(v))
	end
	-- print("identifier steam: "..tostring(GetPlayerIdentifier(player,1)))
	-- print("identifier fiveM: "..tostring(GetPlayerIdentifier(player,2)))
	-- print("identifier fiveM: "..tostring(GetPlayerIdentifier(player,3)))
	

	
end)