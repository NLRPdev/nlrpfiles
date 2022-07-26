local QBCore = exports['qb-core']:GetCoreObject()

local VehicleNitrous = {}

AddEventHandler('onResourceStart', function(resource) if GetCurrentResourceName() == resource then TriggerEvent("jim-mechanic:GetNosUpdate") end end)

--These events sync the VehicleNitrous table with the server, making them able to be synced with the players
RegisterNetEvent('jim-mechanic:server:LoadNitrous', function(Plate)
	VehicleNitrous[Plate] = { hasnitro = 1, level = 100, }
	TriggerClientEvent('jim-mechanic:client:LoadNitrous', -1, Plate)
	TriggerClientEvent('hud:client:UpdateNitrous', -1, VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
	TriggerEvent('jim-mechanic:database:LoadNitro', Plate, 100)
end)

RegisterNetEvent('jim-mechanic:server:UnloadNitrous', function(Plate)
	VehicleNitrous[Plate] = nil
	TriggerClientEvent('jim-mechanic:client:UnloadNitrous', -1, Plate)
	TriggerEvent('jim-mechanic:database:UnloadNitro', Plate)
end)

RegisterNetEvent('jim-mechanic:server:UpdateNitroLevel', function(Plate, level)
	VehicleNitrous[Plate].level = level
	TriggerClientEvent('jim-mechanic:client:UpdateNitroLevel', -1, Plate, level)
end)

--Event called on script start to grab Database info about nos
RegisterNetEvent("jim-mechanic:GetNosUpdate", function()
	local result = {}
	result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE hasnitro = ?', {1})
	if result[1] then
		if Config.Debug then print("VehicleNitrous Results Found: "..#result) end
		for k, v in pairs(result) do
			if Config.Debug then print("VehicleNitrous["..tostring(v["plate"]).."] = { level = "..tonumber(v["noslevel"])..", hasnitro = "..tostring(v["hasnitro"]).." }") end
			VehicleNitrous[v["plate"]] = { hasnitro = v["hasnitro"], level = tonumber(v["noslevel"]), }
		end
	else if Config.Debug then print("Checked Database and found no vehicles with NOS") end end
end)

--Callback to send Database info to Client
QBCore.Functions.CreateCallback('jim-mechanic:GetNosLoaded', function(source, cb) cb(VehicleNitrous) end)

--Database interactions
RegisterNetEvent('jim-mechanic:database:LoadNitro', function(plate, level)
	MySQL.Async.execute('UPDATE player_vehicles SET noslevel = ? WHERE plate = ?', {level, plate}) Wait(10)
	MySQL.Async.execute('UPDATE player_vehicles SET hasnitro = ? WHERE plate = ?', {true, plate})
end)

RegisterNetEvent('jim-mechanic:database:UnloadNitro', function(plate)
	MySQL.Async.execute('UPDATE player_vehicles SET noslevel = ? WHERE plate = ?', {0, plate}) Wait(10)
	MySQL.Async.execute('UPDATE player_vehicles SET hasnitro = ? WHERE plate = ?', {false, plate})
end)

RegisterNetEvent('jim-mechanic:database:UpdateNitroLevel', function(plate, level)
	MySQL.Async.execute('UPDATE player_vehicles SET noslevel = ? WHERE plate = ?', {level, plate})
end)

--Syncing stuff
RegisterNetEvent('jim-mechanic:server:SyncPurge', function(netId, enabled)
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local P = QBCore.Functions.GetPlayer(v)
		TriggerClientEvent('jim-mechanic:client:SyncPurge', P.PlayerData.source, netId, enabled)
	end
end)
RegisterNetEvent('jim-mechanic:server:SyncTrail', function(netId, enabled)
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local P = QBCore.Functions.GetPlayer(v)
		TriggerClientEvent('jim-mechanic:client:SyncTrail', P.PlayerData.source, netId, enabled)
	end
end)
RegisterNetEvent('jim-mechanic:server:SyncFlame', function(netId, scale)
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local P = QBCore.Functions.GetPlayer(v)
		TriggerClientEvent('jim-mechanic:client:SyncFlame', P.PlayerData.source, netId, scale)
	end
end)