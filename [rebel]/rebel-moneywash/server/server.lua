local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
	while true do
        Wait(1000)
        MySQL.Async.fetchAll('SELECT * FROM player_moneywash WHERE time_left IS NOT NULL', {}, function(result)
            if result then
                for k,v in pairs(result) do
                    if v.time_left ~= 0 then
                        MySQL.Async.execute('UPDATE player_moneywash SET time_left = ? WHERE time_left = ?', {v.time_left - 1, v.time_left})
                    end
                end
            end
        end)
    end
end)

QBCore.Functions.CreateCallback("rebel-moneywash:server:GetWashableItems", function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    local washable_items = {}

    for a, b in pairs(Player.PlayerData.items) do
        for c, d in pairs(Config.Washable_Items) do
            if c == b.name then
                table.insert(washable_items, b)
            end
        end
    end

    if #washable_items == 0 then
        cb(nil)
    else
        cb(washable_items)
    end
end)

QBCore.Functions.CreateCallback("rebel-moneywash:server:GetDryableItems", function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    local dryable_items = {}

    for k,v in pairs(Player.PlayerData.items) do
        if v.name == "wetbills" then
            table.insert(dryable_items, v)
        end
    end

    if #dryable_items == 0 then
        cb(nil)
    else
        cb(dryable_items)
    end
end)

QBCore.Functions.CreateCallback("rebel-moneywash:server:GetAvailableMoney", function(source, cb, machine, mtype)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local citizenid = player.PlayerData.citizenid
    local charactername = player.PlayerData.charinfo.firstname.." "..player.PlayerData.charinfo.lastname

    if mtype == "Wash" then
        MySQL.Async.fetchAll('SELECT * FROM player_moneywash WHERE citizenid = ? and name = ? and machine = ? and type = ?', {citizenid, charactername, machine, 'Wash'}, function(result)
            if result[1] then
                cb(result[1])
            else
                cb(nil)
            end
        end)
    else
        MySQL.Async.fetchAll('SELECT * FROM player_moneywash WHERE citizenid = ? and name = ? and machine = ? and type = ?', {citizenid, charactername, machine, 'Dry'}, function(result)
            if result[1] then
                cb(result[1])
            else
                cb(nil)
            end
        end)
    end
end)

RegisterNetEvent('rebel-moneywash:server:WashMoney', function(args)
    local Player = QBCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    local charactername = Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname

	MySQL.Async.fetchAll('SELECT * FROM player_moneywash WHERE citizenid = ? and name = ? and machine = ?', {citizenid, charactername, args.args.machine}, function(result)
        if not result[1] then
            MySQL.Async.insert("INSERT INTO `player_moneywash` (`citizenid`, `name`, `machine`, `amount`, `time_left`, `type`) VALUES (@citizenid, @name, @machine, @amount, @time_left, @type)", {
                ['@citizenid'] = citizenid,
                ['@name'] = charactername,
                ['@machine'] = args.args.oldargs.machine,
                ['@amount'] = args.item_worth,
                ['@time_left'] = args.washtime,
                ['@type'] = "Wash"
            })
        end
    end)

    Player.Functions.RemoveItem(args.item.name, 1, args.item.slot)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[args.item.name], "remove")

    TriggerClientEvent('QBCore:Notify', source, 'You started washing $'..args.item_worth, 'success')

    TriggerEvent('rebel-moneywash:server:sendWebhook', 1, 4360181, charactername.." started washing $"..args.item_worth, "Player Name: "..charactername.."\nCitizen ID: "..Player.PlayerData.citizenid.."\nMoney Amount: $"..args.item_worth.."\nWash Time: "..args.washtime.." seconds", "Made by Rebel Scripts")
end)

RegisterNetEvent('rebel-moneywash:server:DryMoney', function(args)
    local Player = QBCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    local charactername = Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname

	MySQL.Async.fetchAll('SELECT * FROM player_moneywash WHERE citizenid = ? and name = ? and machine = ?', {citizenid, charactername, args.args.machine}, function(result)
        if not result[1] then
            MySQL.Async.insert("INSERT INTO `player_moneywash` (`citizenid`, `name`, `machine`, `amount`, `time_left`, `type`) VALUES (@citizenid, @name, @machine, @amount, @time_left, @type)", {
                ['@citizenid'] = citizenid,
                ['@name'] = charactername,
                ['@machine'] = args.args.oldargs.machine,
                ['@amount'] = args.item_worth,
                ['@time_left'] = args.drytime,
                ['@type'] = "Dry"
            })
        end
    end)

    Player.Functions.RemoveItem(args.item.name, 1, args.item.slot)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[args.item.name], "remove")

    TriggerClientEvent('QBCore:Notify', source, 'You started drying $'..args.item_worth, 'success')

    TriggerEvent('rebel-moneywash:server:sendWebhook', 2, 4360181, charactername.." started drying $"..args.item_worth, "Player Name: "..charactername.."\nCitizen ID: "..Player.PlayerData.citizenid.."\nMoney Amount: $"..args.item_worth.."\nWash Time: "..args.drytime.." seconds", "Made by Rebel Scripts")
end)

RegisterNetEvent('rebel-moneywash:server:GrabWetMoney', function(args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local charactername = Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname

    local success = nil

	MySQL.Async.fetchAll('SELECT * FROM player_moneywash WHERE citizenid = ? and name = ? and machine = ? and type = ?', {citizenid, charactername, args.machine, "Wash"}, function(result)
        if result[1] then
            success = true
            MySQL.Async.execute('DELETE FROM player_moneywash WHERE citizenid = ? and name = ? and machine = ?', {citizenid, charactername, args.machine})
        else
            success = false
        end
    end)

    repeat
        Wait(0)
    until success ~= nil

    if success then
        local info = {
            worth = args.wetmoney
        }

        Player.Functions.AddItem('wetbills', 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wetbills'], "add")
        TriggerClientEvent('QBCore:Notify', src, 'Good job! Now you have to dry the cash before you can use them...', 'success')

        TriggerEvent('rebel-moneywash:server:sendWebhook', 1, 4360181, charactername.." grabbed $"..args.wetmoney.." worth of wet money", "Player Name: "..charactername.."\nCitizen ID: "..Player.PlayerData.citizenid.."\nMoney Amount: $"..args.wetmoney, "Made by Rebel Scripts")
    end
end)

RegisterNetEvent('rebel-moneywash:server:GrabDryMoney', function(args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local charactername = Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname

    local MoneyWashExperience = Player.PlayerData.metadata.moneywashrep
	local highestvalue = 0
	local level = nil

    for k,v in pairs(Config.MoneyDestructionRate) do
		if MoneyWashExperience >= k then
			if tonumber(k) >= highestvalue then
				highestvalue = tonumber(k)
				level = v
			end
		end
	end

    local success = nil

	MySQL.Async.fetchAll('SELECT * FROM player_moneywash WHERE citizenid = ? and name = ? and machine = ? and type = ?', {citizenid, charactername, args.machine, "Dry"}, function(result)
        if result[1] then
            success = true
            MySQL.Async.execute('DELETE FROM player_moneywash WHERE citizenid = ? and name = ? and machine = ?', {citizenid, charactername, args.machine})
        else
            success = false
        end
    end)

    repeat
        Wait(0)
    until success ~= nil

    if success then
        Player.Functions.AddMoney('cash', args.drymoney, 'money wash')
        TriggerClientEvent('QBCore:Notify', src, 'Good job! You finished washing money and received $'..args.drymoney..' and '..level.experience_knowledge..' experience points...', 'success', 3000)

        Player.Functions.SetMetaData('moneywashrep', (MoneyWashExperience + level.experience_knowledge))

        TriggerEvent('rebel-moneywash:server:sendWebhook', 2, 4360181, charactername.." grabbed $"..args.drymoney.." worth of dry money", "Player Name: "..charactername.."\nCitizen ID: "..Player.PlayerData.citizenid.."\nMoney Amount: $"..args.drymoney.."\nGained Experience Points: "..level.experience_knowledge, "Made by Rebel Scripts")
    end
end)