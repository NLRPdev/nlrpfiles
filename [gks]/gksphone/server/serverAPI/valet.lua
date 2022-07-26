-- VALE --

Config.Core.Functions.CreateCallback('gksphone:gks:getCars', function(source, cb)
    local xPlayer = Config.Core.Functions.GetPlayer(source)
    if not xPlayer then return; end
    MySQL.Async.fetchAll("SELECT * FROM " .. Config.OwnedVehicles .. " WHERE `citizenid` = @cid", {
        ["@cid"] = xPlayer.PlayerData.citizenid
    }, function(result)
        local valcik = {}
        for i = 1, #result, 1 do
            local VehicleState = "In Garage"
            local VehicleGarage = "None"

                if Config.qbGarages then
                    if Garages[result[i].garage] ~= nil then
                        VehicleGarage = Garages[result[i].garage]["label"]
                    else
                        VehicleGarage = result[i].garage
                    end
                    if result[i].state == 0 then
                        VehicleState = "On The Street"
                    elseif result[i].state == 2 then
                        VehicleState = "Impounded"
                    end
                elseif Config.cdGarages then
                    VehicleGarage = result[i].garage_id
                    if not result[i].in_garage then
                        VehicleState = "On The Street"
                    end
                    if result[i].impound == 1 then
                        VehicleState = "Impounded"
                    end
                elseif Config.loafGarages then
                    VehicleGarage = result[i].garage
                    if result[i].state == 0 then
                        VehicleState = "On The Street"
                    elseif result[i].state == 2 then
                        VehicleState = "Impounded"
                    end
                else
                    VehicleGarage = result[i].garage
                end

            table.insert(valcik, { plate = result[i].plate, garage = VehicleState, hash = result[i].hash, mods = json.decode(result[i].mods), model = result[i].vehicle, props = { model = result[i].vehicle }, state = VehicleGarage, fuel = result[i].fuel, engine = result[i].engine, body = result[i].body })

        end
        cb(valcik)
    end)
end)

Config.Core.Functions.CreateCallback('gksphone:getSellerCar', function(source, cb)
    local xPlayer = Config.Core.Functions.GetPlayer(source)
    if not xPlayer then return; end
    MySQL.Async.fetchAll("SELECT * FROM " .. Config.OwnedVehicles .. " WHERE `citizenid` = @cid and carseller = 0", {
        ["@cid"] = xPlayer.PlayerData.citizenid
    }, function(result)
        local valcik = {}
        for i = 1, #result, 1 do
            local VehicleState = "In Garage"
            local VehicleGarage = "None"

                if Config.qbGarages then
                    if Garages[result[i].garage] ~= nil then
                        VehicleGarage = Garages[result[i].garage]["label"]
                    else
                        VehicleGarage = result[i].garage
                    end
                    if result[i].state == 0 then
                        VehicleState = "On The Street"
                    elseif result[i].state == 2 then
                        VehicleState = "Impounded"
                    end
                elseif Config.cdGarages then
                    VehicleGarage = result[i].garage_id
                    if not result[i].in_garage then
                        VehicleState = "On The Street"
                    end
                    if result[i].impound == 1 then
                        VehicleState = "Impounded"
                    end
                elseif Config.loafGarages then
                    VehicleGarage = result[i].garage
                    if result[i].state == 0 then
                        VehicleState = "On The Street"
                    elseif result[i].state == 2 then
                        VehicleState = "Impounded"
                    end
                else
                    VehicleGarage = result[i].garage
                end
            table.insert(valcik, { plate = result[i].plate, garage = VehicleState, hash = result[i].hash, mods = json.decode(result[i].mods), model = result[i].vehicle, props = { model = result[i].vehicle }, state = VehicleGarage, fuel = result[i].fuel, engine = result[i].engine, body = result[i].body })

        end
        cb(valcik)
    end)
end)

Config.Core.Functions.CreateCallback('gksphone:checkMoney2', function(source, cb)
    local xPlayer = Config.Core.Functions.GetPlayer(source)

    if xPlayer.Functions.RemoveMoney('bank', Config.ValePrice, "vale") then
        TriggerClientEvent(Config.CoreNotify, source, _U('vale_get') .. Config.ValePrice)
        MySQL.Async.execute("INSERT INTO gksphone_bank_transfer (type, identifier, price, name) VALUES (@type, @identifier, @price, @name)", {
            ["@type"] = 1,
            ["@identifier"] = xPlayer.PlayerData.citizenid,
            ["@price"] = Config.ValePrice,
            ["@name"] = _U('vale_get') .. Config.ValePrice
        })
        cb(true)
    else
        cb(false)
    end

end)

Config.Core.Functions.CreateCallback('gksphone:loadVehicle', function(source, cb, plate)
    MySQL.Async.fetchAll("SELECT * FROM " .. Config.OwnedVehicles .. " WHERE plate = @cid", { ["@cid"] = plate }, function(d)
        if d[1] ~= nil then
            cb(d[1])
        end
    end)
end)


Config.Core.Functions.CreateCallback("gksphone:GetVehicleProperties", function(source, cb, plate)
    local properties = {}
    local result = MySQL.Sync.fetchAll('SELECT mods FROM ' .. Config.OwnedVehicles .. ' WHERE plate = ?', { plate })
    if result[1] ~= nil then
        properties = json.decode(result[1].mods)
    end
    cb(properties)
end)

RegisterServerEvent('gksphone:valet-car-set-outside')
AddEventHandler('gksphone:valet-car-set-outside', function(plate, garage)
    local src = source
    local xPlayer = Config.Core.Functions.GetPlayer(source)
    if xPlayer then
        if Config.cdGarages then
            MySQL.Async.execute('UPDATE ' .. Config.OwnedVehicles .. ' SET  `in_garage` = @in_garage WHERE `plate` = @plate', {
                ['@plate'] = plate,
                ['@in_garage'] = 0,
            }, function(result)
                TriggerClientEvent('valeduzel', src)
            end)
        else
            MySQL.Async.execute('UPDATE ' .. Config.OwnedVehicles .. ' SET `garage` = @garage, `state` = @state WHERE `plate` = @plate', {
                ['@plate'] = plate,
                ['@state'] = 0,
                ['@garage'] = garage,
            }, function(result)
                TriggerClientEvent('valeduzel', src)
            end)
        end
    end
end)

-- VALE --
