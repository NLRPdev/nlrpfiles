local QBCore = exports['qb-core']:GetCoreObject()

local Size = {
	["big"] = { 1024, 1024 },
	["medium"] = { 512, 512 },
}
--This is the list that loads at server start
--it's updated in server memory as people change them
--When ClearDui is run, it sets the url to "" making it load nothing

-- Default images
-- Targets for these are in dui.lua
local duiList = {
	-- The exterior sign isn't just the logo, its the metal aswell, use this to make a new one for easy edits here: https://i.imgur.com/3GoamzI.png
	["Exterior_Sign_Maldinis_d"] = { url = "https://cdn.discordapp.com/attachments/999830675635064942/1003339383803482122/Chuck_E_Cheeze_2.png", size = Size["medium"], texd = "sm_pizzeria_exterior_txd", },
	["maldini-logo"] = { url = "https://cdn.discordapp.com/attachments/999830675635064942/1003346744240767057/chuck_e_cheezes_1.png", size = Size["medium"], texd = "sm_pizzeria_txd_01", },
	["pizzeria_dinks"] = { url = "https://i.imgur.com/XnibdXo.jpeg", size = Size["big"], texd = "sm_pizzeria_txd_02", },
	["pizzeria_menu"] = { url = "https://i.imgur.com/8EXn5tX.jpeg", size = Size["big"], texd = "sm_pizzeria_txd_02", },
}

AddEventHandler('onResourceStart', function(r) if r ~= GetCurrentResourceName() then return end
	-- Tidier way of duplicating the original url at startup to make "presets"
	for k, v in pairs(duiList) do duiList[k].preset = duiList[k].url end
end)

RegisterServerEvent("jim-pizzathis:Server:ChangeDUI", function(data)
	-- if no url given, "reset" it back to preset
	if not data.url then
		if Config.Debug then print("Preset: "..tostring(duiList[tostring(data.tex)].preset)) end
		data.url = duiList[tostring(data.tex)].preset
		data.size = duiList[tostring(data.tex)].size
	end
	-- if it has a url, update server DUI list and send to players
	if Config.Debug then print("Sending new DUI to all players") end
	duiList[tostring(data.tex)] = { url = data.url, preset = duiList[tostring(data.tex)].preset, texd = duiList[tostring(data.tex)].txd, size = data.size }
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local Player = QBCore.Functions.GetPlayer(v)
		if Player ~= nil then
			TriggerClientEvent("jim-pizzathis:ChangeDUI", Player.PlayerData.source, data)
		end
	end
end)
RegisterServerEvent("jim-pizzathis:Server:ClearDUI", function(data)
	-- Clear the DUI from loading
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local Player = QBCore.Functions.GetPlayer(v)
		if Player ~= nil then
			TriggerClientEvent("jim-pizzathis:ClearDUI", Player.PlayerData.source, data)
		end
	end
	duiList[tostring(data.tex)].url = ""
end)

QBCore.Functions.CreateCallback('jim-pizzathis:Server:duiList', function(source, cb) cb(duiList) end)