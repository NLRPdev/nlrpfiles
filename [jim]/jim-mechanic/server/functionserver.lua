local QBCore = exports['qb-core']:GetCoreObject()

----Commands
--[[QBCore.Commands.Add("test", "", {}, false, function(source, args)
	local src = source
    local CurrentVehicle = GetVehiclePedIsIn(src)
	TriggerServerEvent('jim-mechanic:server:LoadNitrous', trim(GetVehicleNumberPlateText(CurrentVehicle)))
end)]]

QBCore.Commands.Add("preview", Loc[Config.Lan]["servfunction"].checkmods, {}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:client:Preview:Menu", source)
end)

QBCore.Commands.Add("showodo", "Odometer", {}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:ShowOdo", source)
end)

QBCore.Commands.Add("checkdamage", Loc[Config.Lan]["servfunction"].checkdamage, {}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:client:Repair:Check", source, -2)
end)

QBCore.Commands.Add("checkmods", Loc[Config.Lan]["servfunction"].checkmods, {}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:client:Menu:List", source)
end)

QBCore.Commands.Add("flipvehicle", Loc[Config.Lan]["servfunction"].flipvehicle, {}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:flipvehicle", source)
end)

QBCore.Commands.Add("togglesound", Loc[Config.Lan]["servfunction"].togglesound, {{name="on/off", help= Loc[Config.Lan]["servfunction"].togglesounddesc}}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:togglesound", source, args[1])
end)

QBCore.Commands.Add("cleancar", Loc[Config.Lan]["servfunction"].cleancar, {}, false, function(source)
	TriggerClientEvent("jim-mechanic:client:cleanVehicle", source, false)
end)

QBCore.Commands.Add("hood", Loc[Config.Lan]["servfunction"].hood, {}, false, function(source)
	TriggerClientEvent("jim-mechanic:client:openDoor", source, 4)
end)

QBCore.Commands.Add("trunk", Loc[Config.Lan]["servfunction"].trunk, {}, false, function(source)
	TriggerClientEvent("jim-mechanic:client:openDoor", source, 5)
end)

QBCore.Commands.Add("door", Loc[Config.Lan]["servfunction"].door, {{name="0-3", help="Door ID"}}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:client:openDoor", source, args[1])
end)

QBCore.Commands.Add("seat", Loc[Config.Lan]["servfunction"].seat, {{name="id", help="Seat ID"}}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:seat", source, args[1])
end)

QBCore.Functions.CreateCallback("jim-mechanic:checkVehicleOwner", function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?',{plate}, function(result)
        if result[1] then cb(true)
        else cb(false) end
	end)
end)

RegisterNetEvent("jim-mechanic:updateVehicle", function(myCar, plate)
	local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {plate})
	if result[1] then
		if Config.Debug then print("Vehicle Mods - ["..plate.."]: "..json.encode(myCar)) end
		MySQL.Async.execute('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(myCar), plate})
	end
end)

--Grabbing traveldistance from database, if you haven't added "traveldistance" column to player_vehicles this won't show up
QBCore.Functions.CreateCallback("jim-mechanic:distGrab", function(source, cb, plate)
	local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {plate})
	if result[1] then
		if result[1]["traveldistance"] ~= nil then cb(result[1]["traveldistance"])
		else cb("") end
	else cb("") end
end)

--ODOMETER STUFF
RegisterNetEvent('jim-mechanic:server:UpdateDrivingDistance', function(plate, DistAdd)
	local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {plate})
	if result[1] then
		if result[1].traveldistance ~= nil then
			MySQL.Async.execute('UPDATE player_vehicles SET traveldistance = ? WHERE plate = ?', {result[1]["traveldistance"] + DistAdd, plate}) 
			if Config.Debug then print("Travel distance - ["..plate.."]: "..result[1]["traveldistance"] + DistAdd) end
		end
	end
end)

--SAVE EXTRA DAMAGES
RegisterNetEvent('jim-mechanic:server:saveStatus', function(mechDamages, plate)
	local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {plate})
	if result[1] then
		if Config.Debug then print("Save Extra Damages - ["..plate.."]: "..json.encode(mechDamages)) end
		MySQL.Async.execute('UPDATE player_vehicles SET status = ? WHERE plate = ?', {json.encode(mechDamages), plate})
	end
end)
--LOAD EXTRA DAMAGES
RegisterNetEvent('jim-mechanic:server:loadStatus', function(plate)
	if GetResourceState('qb-mechanicjob') == "started" then
		TriggerEvent('vehiclemod:server:setupVehicleStatus', plate)
		local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {plate})
		if result[1] then
			if Config.Debug then print("Load Extra Damages - ["..plate.."]: "..result[1].status) end
			if tostring(result[1].status) ~= "nil" then
				for k, v in pairs(json.decode(result[1].status)) do 
					if Config.Debug then print("["..plate.."] Setting damage of "..k.." to: "..tonumber(v)) end
					TriggerEvent("vehiclemod:server:updatePart", plate, tostring(k), tonumber(v))
				end
			end
		end
	end
end)

--MANUALLY SAVE STASH STUFF
RegisterNetEvent('jim-mechanic:server:saveStash', function(stashId, items)
	if items then
		for slot, item in pairs(items) do item.description = nil end
		MySQL.Async.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items', {
			['stash'] = stashId,
			['items'] = json.encode(items)
		})
	end
end)

RegisterNetEvent("jim-mechanic:server:DupeWarn", function(item)
	local src = source
	local P = QBCore.Functions.GetPlayer(src)
	print("Player: "..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."["..tostring(src).."] - Tried to remove ('"..item.."') but it wasn't there")
	DropPlayer(src, "Attempting to duplicate items") 
	print("Player: "..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."["..tostring(src).."] - Dropped from server for item duplicating")
end)

RegisterNetEvent("jim-mechanic:server:giveList", function(info)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem("mechboard", 1, nil, info)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["mechboard"], "add", 1)
end)

QBCore.Functions.CreateUseableItem("mechboard", function(source, item)
	if item.info["vehlist"] == nil then 
		TriggerClientEvent("QBCore:Notify", source, "The board is empty, don't spawn this item", "error")
	else
		TriggerClientEvent("jim-mechanic:client:giveList", source, item)
	end
end)

RegisterNetEvent('jim-mechanic:server:updateCar', function(netId, props)
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local P = QBCore.Functions.GetPlayer(v)
		TriggerClientEvent("jim-mechanic:forceProperties", P.PlayerData.source, netId, props)
	end
end)

QBCore.Functions.CreateCallback("jim-mechanic:checkCash", function(source, cb)
    local P = QBCore.Functions.GetPlayer(source)
	cb(P.Functions.GetMoney("cash"))
end)

RegisterNetEvent('jim-mechanic:chargeCash', function(cost)
	QBCore.Functions.GetPlayer(source).Functions.RemoveMoney("cash", cost)
end)

QBCore.Functions.CreateCallback('jim-mechanic:mechCheck', function(source, cb)
	local dutyList = {}
	--Make list and set them all to false
	for _, v in pairs(Config.JobRoles) do dutyList[tostring(v)] = false end
		
	for _, v in pairs(QBCore.Functions.GetPlayers()) do
		local Player = QBCore.Functions.GetPlayer(v)
		for l, b in pairs(Config.JobRoles) do
			if Player.PlayerData.job.name == b and Player.PlayerData.job.onduty then dutyList[tostring(b)] = true end
		end
	end
	local result = false
	for k, v in pairs(dutyList) do if v then result = true end end
	cb(result)
end)