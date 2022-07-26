local QBCore = exports["qb-core"]:GetCoreObject()

local Webhook = ''
local sessions = {}
local levels = {}

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  if levels[1] == nil then
  	local xp = Config.StartEXP
  	local nextLevel = xp
  	for i=1, Config.MaxLevel, 1 do
		table.insert(levels, math.floor(nextLevel+0.5))
		xp = xp*Config.LevelMultiplier
		nextLevel = nextLevel+xp
	end
  end
end)

QBCore.Functions.CreateCallback("okokCrafting:getLevel", function(source, cb)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	MySQL.query('SELECT * FROM players WHERE citizenid = @identifier', {
		['@identifier'] = xPlayer.PlayerData.citizenid,
	}, function(users) 
		local xp = tonumber(users[1].xp)
		local maxLevel = Config.MaxLevel
		for k,v in ipairs(levels) do
			if v > xp then
				local percentage = 0
				if levels[k-1] ~= nil then
					percentage = ((xp - levels[k-1]) * 100) / (levels[k] - levels[k-1])
				else
					percentage = ((xp - 0) * 100) / (levels[k] - 0)
				end
				cb(k-1, math.floor(percentage+0.5))
				break
			elseif k == maxLevel then
				cb(k, 100)
			end
		end
	end)
end)

RegisterServerEvent('okokCrafting:craftStartItem')
AddEventHandler('okokCrafting:craftStartItem',function()
	local _source = source
	sessions[_source] = {
		stoppedCraft = false,
		isCrafting = true,
		last = GetGameTimer(),
	}
end)

RegisterServerEvent('okokCrafting:craftStopItem')
AddEventHandler('okokCrafting:craftStopItem',function()
	local _source = source
	sessions[_source] = {
		stoppedCraft = true,
		isCrafting = false,
	}
end)

RegisterServerEvent('okokCrafting:failedCraft')
AddEventHandler('okokCrafting:failedCraft',function(item, xp)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	if Config.GiveXPOnCraftFailed and Config.UseXP then
		MySQL.query('UPDATE players SET xp = xp+@xp WHERE citizenid = @identifier', {
			['@identifier'] = xPlayer.PlayerData.citizenid,
			['@xp'] = xp,
		}, function (result)
		end)

		TriggerClientEvent('okokCrafting:updateXP', _source)
	end

	if Webhook ~= '' then
		local identifierlist = ExtractIdentifiers(_source)
		local data = {
			playerid = _source,
			identifier = identifierlist.license:gsub("license2:", ""),
			discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
			type = "failed",
			item = item,
		}
		noSession(data)
	end
end)

RegisterServerEvent('okokCrafting:craftItemDeath')
AddEventHandler('okokCrafting:craftItemDeath',function(queueClient)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local queue = queueClient

	if sessions[_source] then
		if sessions[_source].stoppedCraft then
			for k,v in ipairs(queue) do
				for k2,v2 in ipairs(v.recipe) do
					if v2[3] then
						xPlayer.Functions.AddItem(v2[1], v2[2])
					end
				end
			end
			TriggerClientEvent('okokNotify:Alert', _source, "CRAFTING", "You died, all crafting items were given back", 5000, 'info')
			sessions[_source] = nil
		end
	else
		if Webhook ~= '' then
			local identifierlist = ExtractIdentifiers(_source)
			local data = {
				playerid = _source,
				identifier = identifierlist.license:gsub("license2:", ""),
				discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
				type = "Death",
			}
			noSession(data)
		end
		TriggerClientEvent('okokNotify:Alert', _source, "CRAFTING", "No session!", 5000, 'error')
	end
			
end)

RegisterServerEvent('okokCrafting:craftItemFinished')
AddEventHandler('okokCrafting:craftItemFinished', function(item, crafts, itemName, isItem, xp)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local timeToCraft = 600000
	local amount = 0

	if sessions[_source] then
		for k,v in ipairs(crafts) do
			if v.item == item then
				amount = v.amount
				timeToCraft = v.time * 1000
			end
		end
		sessions[_source].last = GetGameTimer() - sessions[_source].last

		if sessions[_source].last+500 >= timeToCraft then
			if isItem then
				xPlayer.Functions.AddItem(item, amount)
			else
				xPlayer.Functions.AddItem(item, amount)
			end

			if Config.UseXP then
				MySQL.query('UPDATE players SET xp = xp+@xp WHERE citizenid = @identifier', {
					['@identifier'] = xPlayer.PlayerData.citizenid,
					['@xp'] = xp,
				}, function (result)
				end)
				TriggerClientEvent('okokCrafting:updateXP', _source)
			end

			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(_source)
				local data = {
					playerid = _source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = "conclude-crafting",
					itemName = itemName,
					time = sessions[_source].last,
				}
				noSession(data)
			end
			sessions[_source] = nil
		else
			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(_source)
				local data = {
					playerid = _source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = "crafted-soon",
					time_taken = sessions[_source].last,
					time_needed = timeToCraft,
					itemName = itemName,
				}
				noSession(data)
			end
			TriggerClientEvent('okokNotify:Alert', _source, "CRAFTING", "Anti-cheat protection!", 5000, 'error')
		end
	else
		if Webhook ~= '' then
			local identifierlist = ExtractIdentifiers(_source)
			local data = {
				playerid = _source,
				identifier = identifierlist.license:gsub("license2:", ""),
				discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
				type = "conclude",
			}
			noSession(data)
		end
		TriggerClientEvent('okokNotify:Alert', _source, "CRAFTING", "No session!", 5000, 'error')
	end
			
end)

QBCore.Functions.CreateCallback("okokCrafting:inv2", function(source, cb, item)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local items = xPlayer.Functions.GetItemByName(item)

	if items ~= nil then
		cb(items.amount)
	else
		cb(0)
	end
end)

QBCore.Functions.CreateCallback("okokCrafting:itemNames", function(source, cb)
	cb(Config.itemNames)
end)

QBCore.Functions.CreateCallback("okokCrafting:CanCraftItem", function(source, cb, itemID, recipe, itemName, amount, isItem)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local canCraft = true

	for k,v in pairs(recipe) do
		local item = xPlayer.Functions.GetItemByName(v[1])

		if item == nil then
			canCraft = false
		else
			if item.amount < v[2] then
				canCraft = false
			end
		end
	end
	if canCraft then
		if xPlayer.Functions.AddItem(itemID, amount) then
			xPlayer.Functions.RemoveItem(itemID, amount)
			for k,v in pairs(recipe) do
				if v[3] == "true" then
					xPlayer.Functions.RemoveItem(v[1], v[2])
				end
			end
			cb(true)
			TriggerClientEvent('okokNotify:Alert', _source, "CRAFTING", itemName[itemID].." added to the crafting queue", 5000, 'success')
			if Webhook ~= '' then
				local identifierlist = ExtractIdentifiers(_source)
				local data = {
					playerid = _source,
					identifier = identifierlist.license:gsub("license2:", ""),
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
					type = "crafting",
					itemName = itemName[itemID],
				}
				noSession(data)
			end
		else
			cb(false)
			TriggerClientEvent('okokNotify:Alert', _source, "CRAFTING", "You can't carry "..itemName[itemID], 5000, 'error')
		end		
	else
		cb(false)
		TriggerClientEvent('okokNotify:Alert', _source, "CRAFTING", "You can't craft "..itemName[itemID], 5000, 'error')
	end
end)

-------------------------- IDENTIFIERS

function ExtractIdentifiers(id)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(id) - 1 do
        local playerID = GetPlayerIdentifier(id, i)

        if string.find(playerID, "steam") then
            identifiers.steam = playerID
        elseif string.find(playerID, "ip") then
            identifiers.ip = playerID
        elseif string.find(playerID, "discord") then
            identifiers.discord = playerID
        elseif string.find(playerID, "license") then
            identifiers.license = playerID
        elseif string.find(playerID, "xbl") then
            identifiers.xbl = playerID
        elseif string.find(playerID, "live") then
            identifiers.live = playerID
        end
    end

    return identifiers
end

-------------------------- NO SESSION WEBHOOK

function noSession(data)
	local color = '65352'
	local category = 'test'

	if data.type == 'Death' then
		color = Config.AnticheatProtectionWebhookColor
		category = 'Tried to receive the crafting items without starting a crafting, he might be cheating'
	elseif data.type == 'conclude' then
		color = Config.AnticheatProtectionWebhookColor
		category = 'Tried to conclude a crafting without starting it first, he might be cheating'
	elseif data.type == 'crafted-soon' then
		color = Config.AnticheatProtectionWebhookColor
		category = 'Concluded the crafting of '..data.itemName..' after '..data.time_taken..'ms while it takes '..data.time_needed..'ms to craft, he might be cheating'
	elseif data.type == 'crafting' then
		color = Config.StartCraftWebhookColor
		category = 'Added '..data.itemName..' to queue'
	elseif data.type == 'conclude-crafting' then
		color = Config.ConcludeCraftWebhookColor
		category = 'Crafted a '..data.itemName..' after '..data.time..'ms'
	elseif data.type == 'failed' then
		color = Config.FailWebhookColor
		category = 'Failed to craft a '..data.item
	end
	
	local information = {
		{
			["color"] = color,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = 'CRAFTING',
			["description"] = '**Action:** '..category..'\n\n**ID:** '..data.playerid..'\n**Identifier:** '..data.identifier..'\n**Discord:** '..data.discord,
			["footer"] = {
				["text"] = os.date(Config.DateFormat),
			}
		}
	}

	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end