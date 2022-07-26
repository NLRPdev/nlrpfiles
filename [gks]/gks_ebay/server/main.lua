--================================================================================================
--==            --    XenKnighT --        https://discord.gg/XUck63E                            ==
--================================================================================================


Config.Core.Functions.CreateCallback('gks_ebay:getInventory', function(source, cb)
	local xPlayer = Config.Core.Functions.GetPlayer(source)
	local layetedaw   = xPlayer.PlayerData.items
    cb(layetedaw)
end)

Config.Core.Functions.CreateCallback('gks_ebay:depoitemgotur', function(source, cb)
	local result = MySQL.Sync.fetchAll('SELECT * FROM gksphone_ebay WHERE store = 1')
	local valcik = {}
	for i=1, #result, 1 do
		table.insert(valcik, {label = result[i].label, count = result[i].count, item = result[i].item, price = result[i].price, kapat = result[i].kapat, adet = result[i].adet, cid = result[i].cid})
	end
	cb(valcik)
end)

Config.Core.Functions.CreateCallback('gks_ebay:depoitemgoturtest', function(source, cb)
    local xPlayer = Config.Core.Functions.GetPlayer(source)
	local result = MySQL.Sync.fetchAll('SELECT * FROM gksphone_ebay WHERE store = 1 AND cid = @cid', {['@cid']   = xPlayer.PlayerData.citizenid})
	local valcik = {}
	for i=1, #result, 1 do
		table.insert(valcik, {label = result[i].label, count = result[i].count, item = result[i].item, price = result[i].price, kapat = result[i].kapat, adet = result[i].adet, cid = result[i].cid})
	end
	cb(valcik)
end)

Config.Core.Functions.CreateCallback('gks_ebay:purchitemgotur', function(source, cb)
    local src = source
	local xPlayer = Config.Core.Functions.GetPlayer(src)
	local result = MySQL.Sync.fetchAll('SELECT * FROM gksphone_ebay WHERE store = 0 AND cid = @cid', {['@cid']   = xPlayer.PlayerData.citizenid})
	local valcik = {}
	for i=1, #result, 1 do
		table.insert(valcik, {label = result[i].label, count = result[i].count, item = result[i].item, price = result[i].price, kapat = result[i].kapat, adet = result[i].adet, cid = result[i].cid})
	end

	cb(valcik)

end)


RegisterServerEvent('gks_ebay:siparis')
AddEventHandler('gks_ebay:siparis', function(deneme, a, b, c, d, itemname)
    local id = b
    local isim = a
    local src = source
	local xPlayer = Config.Core.Functions.GetPlayer(src)

        if xPlayer ~= nil then

            if xPlayer.PlayerData.money["bank"] > c then

                for i=1, #deneme, 1 do

                    local zPlayer = Config.Core.Functions.GetPlayerByCitizenId(deneme[i].cid)

                    if zPlayer ~= nil then

                        MySQL.Async.fetchAll(
                            'SELECT * FROM gksphone_ebay WHERE item = @item AND cid = @cid AND store = 1',
                            {
                                ['@item']  = deneme[i].itemname,
                                ['@cid']   = deneme[i].cid
                            },
                            function(data)
                               if data[1] then

                                if tonumber(data[1].price) == tonumber(deneme[i].price) then
                                    if tonumber(deneme[i].adet) > data[1].count then
                                        TriggerClientEvent(Config.CoreName..':Notify', src, Config.Takeout, 'error')

                                    else
                                        if xPlayer.Functions.RemoveMoney('bank', tonumber(c), Config.APPName) then
                                            if data[1].count ~= deneme[i].adet then

                                                MySQL.Async.execute("UPDATE gksphone_ebay SET count = @count WHERE item = @item AND cid = @cid AND store = 1",
                                                {
                                                    ['@item'] = deneme[i].itemname,
                                                    ['@count'] = data[1].count - deneme[i].adet,
                                                    ['@cid']   = deneme[i].cid
                                                }, function(result)

                                                    MySQL.Async.fetchAll(
                                                        'SELECT * FROM gksphone_ebay WHERE item = @items AND cid = @cid AND store = 0',
                                                        {
                                                            ['@items'] = deneme[i].itemname,
                                                            ['@cid']   = xPlayer.PlayerData.citizenid
                                                        },
                                                        function(ikinciurun)

                                                            if ikinciurun[1] == nil then

                                                                MySQL.Async.execute('INSERT INTO gksphone_ebay (label, price, count, item, cid, store) VALUES (@label, @price, @count, @item, @cid, @store)',
                                                                {
                                                                    ['@label']         = data[1].label,
                                                                    ['@price']         = data[1].price,
                                                                    ['@count']         = deneme[i].adet,
                                                                    ['@item']          = data[1].item,
                                                                    ['@cid']           = xPlayer.PlayerData.citizenid,
                                                                    ['@store']         = 0
                                                                })


                                                            elseif ikinciurun[1].item == data[1].item then

                                                                    MySQL.Async.fetchAll("UPDATE gksphone_ebay SET count = @count WHERE item = @name AND store = 0",
                                                                        {
                                                                            ['@name'] = data[1].item,
                                                                            ['@count'] = ikinciurun[1].count + deneme[i].adet
                                                                        }
                                                                    )



                                                            end

                                                    end)
                                                --xPlayer.Functions.AddItem(data[1].item, deneme[i].adet, nil)
                                                local toplam = deneme[i].adet * deneme[i].price
                                                zPlayer.Functions.AddMoney('bank', tonumber(toplam), "AH")


                                            end)

                                            elseif data[1].count == deneme[i].adet then

                                                MySQL.Async.execute("DELETE FROM gksphone_ebay WHERE item = @name AND cid = @cid AND store = 1",
                                                {
                                                    ['@name'] = data[1].item,
                                                    ['@cid']   = deneme[i].cid
                                                })
                                                MySQL.Async.fetchAll(
                                                    'SELECT * FROM gksphone_ebay WHERE item = @items AND cid = @cid AND store = 0',
                                                    {
                                                        ['@items'] = deneme[i].itemname,
                                                        ['@cid']   = xPlayer.PlayerData.citizenid
                                                    },
                                                    function(ikinciurun)

                                                        if ikinciurun[1] == nil then

                                                            MySQL.Async.execute('INSERT INTO gksphone_ebay (label, price, count, item, cid, store) VALUES (@label, @price, @count, @item, @cid, @store)',
                                                            {
                                                                ['@label']         = data[1].label,
                                                                ['@price']         = data[1].price,
                                                                ['@count']         = deneme[i].adet,
                                                                ['@item']          = data[1].item,
                                                                ['@cid']           = xPlayer.PlayerData.citizenid,
                                                                ['@store']         = 0
                                                            })


                                                        elseif ikinciurun[1].item == data[1].item then

                                                                MySQL.Async.fetchAll("UPDATE gksphone_ebay SET count = @count WHERE item = @name AND store = 0",
                                                                    {
                                                                        ['@name'] = data[1].item,
                                                                        ['@count'] = ikinciurun[1].count + deneme[i].adet
                                                                    }
                                                                )



                                                        end

                                                end)
                                                --xPlayer.Functions.AddItem(data[1].item, deneme[i].adet, nil)
                                                local toplam = deneme[i].adet * deneme[i].price
                                                zPlayer.Functions.AddMoney('bank', tonumber(toplam), "AH")

                                            end
                                            Citizen.Wait(500)
                                            TriggerClientEvent('gksphone:urunsayfasiyenile', -1)
                                        else
                                            TriggerClientEvent('gksphone:notifi', src, {title = Config.APPName, message = Config.Notmoney, img= '/html/static/img/icons/ebay.png' })
                                            Citizen.Wait(500)
                                            TriggerClientEvent('gksphone:urunsayfasiyenile', -1)
                                        end
                                    end
                                else
                                    TriggerEvent('gksphone:exploitwebhook', src, Config.APPName, Config.ebayexploitmoney)
                                end
                            else

                                TriggerEvent('gksphone:exploitwebhook', src, Config.APPName, Config.ebayexploitnotowner)

                            end
                        end)
                    else


                        MySQL.Async.fetchAll(
                            'SELECT * FROM gksphone_ebay WHERE item = @item AND cid = @cid AND store = 1',
                            {
                                ['@item']  = deneme[i].itemname,
                                ['@cid']   = deneme[i].cid
                            },
                            function(data)
                               if data[1] then

                                if tonumber(data[1].price) == tonumber(deneme[i].price) then
                                    if tonumber(deneme[i].adet) > data[1].count then
                                        TriggerClientEvent(Config.CoreName..':Notify', src, Config.Takeout, 'error')

                                        else

                                        if data[1].count ~= deneme[i].adet then

                                            MySQL.Async.execute("UPDATE gksphone_ebay SET count = @count WHERE item = @item AND cid = @cid AND store = 1",
                                            {
                                                ['@item'] = deneme[i].itemname,
                                                ['@count'] = data[1].count - deneme[i].adet,
                                                ['@cid']   = deneme[i].cid
                                            }, function(result)

                                                MySQL.Async.fetchAll(
                                                    'SELECT * FROM gksphone_ebay WHERE item = @items AND cid = @cid AND store = 0',
                                                    {
                                                        ['@items'] = deneme[i].itemname,
                                                        ['@cid']   = xPlayer.PlayerData.citizenid
                                                    },
                                                    function(ikinciurun)

                                                        if ikinciurun[1] == nil then

                                                            MySQL.Async.execute('INSERT INTO gksphone_ebay (label, price, count, item, cid, store) VALUES (@label, @price, @count, @item, @cid, @store)',
                                                            {
                                                                ['@label']         = data[1].label,
                                                                ['@price']         = data[1].price,
                                                                ['@count']         = deneme[i].adet,
                                                                ['@item']          = data[1].item,
                                                                ['@cid']           = xPlayer.PlayerData.citizenid,
                                                                ['@store']         = 0
                                                            })


                                                        elseif ikinciurun[1].item == data[1].item then

                                                                MySQL.Async.fetchAll("UPDATE gksphone_ebay SET count = @count WHERE item = @name AND store = 0",
                                                                    {
                                                                        ['@name'] = data[1].item,
                                                                        ['@count'] = ikinciurun[1].count + deneme[i].adet
                                                                    }
                                                                )



                                                        end

                                                end)
                                            --xPlayer.Functions.AddItem(data[1].item, deneme[i].adet, nil)
                                            local toplam = deneme[i].adet * deneme[i].price



                                            MySQL.Async.fetchAll("SELECT money FROM players WHERE citizenid = @identifier", {
                                                ['@identifier'] = deneme[i].cid,
                                            }, function(result)

                                                local g=json.decode(result[1].money)


                                                g['bank']=g['bank']+(toplam);




                                                    MySQL.Async.execute('UPDATE players SET `money` = @bank WHERE `citizenid` = @identifier', {
                                                        ['@identifier'] = deneme[i].cid,
                                                        ['@bank'] = json.encode(g),
                                                    })

                                            end)

                                        end)

                                        elseif data[1].count == deneme[i].adet then

                                            MySQL.Async.execute("DELETE FROM gksphone_ebay WHERE item = @name AND cid = @cid AND store = 1",
                                            {
                                                ['@name'] = data[1].item,
                                                ['@cid']   = deneme[i].cid
                                            })

                                            xPlayer.Functions.AddItem(data[1].item, deneme[i].adet, nil)
                                            local toplam = deneme[i].adet * deneme[i].price
                                            MySQL.Async.fetchAll("SELECT money FROM players WHERE citizenid = @identifier", {
                                                ['@identifier'] = deneme[i].cid,
                                            }, function(result)

                                                local g=json.decode(result[1].money)


                                                g['bank']=g['bank']+(toplam);




                                                    MySQL.Async.execute('UPDATE players SET `money` = @bank WHERE `citizenid` = @identifier', {
                                                        ['@identifier'] = deneme[i].cid,
                                                        ['@bank'] = json.encode(g),
                                                    })

                                            end)

                                        end
                                        xPlayer.Functions.RemoveMoney('bank', c, Config.APPName)
                                        Citizen.Wait(500)
                                        TriggerClientEvent('gksphone:urunsayfasiyenile', -1)
                                    end
                                else

                                    TriggerEvent('gksphone:exploitwebhook', src, Config.APPName, Config.ebayexploitmoney)
                                end
                            else

                                TriggerEvent('gksphone:exploitwebhook', src, Config.APPName, Config.ebayexploitnotowner)

                            end
                        end)



                    end

                end





            else
                TriggerClientEvent('gksphone:notifi', src, {title = Config.APPName, message = Config.Notmoney, img= '/html/static/img/icons/ebay.png' })
            end
        end
end)


RegisterServerEvent('gks_ebay:depoitem')
AddEventHandler('gks_ebay:depoitem', function(Item, ItemCount, price, itemLabel)
  local xPlayer = Config.Core.Functions.GetPlayer(source)

        MySQL.Async.fetchAll(
        'SELECT item, count FROM gksphone_ebay WHERE item = @items AND cid = @cid',
        {
            ['@items'] = Item,
            ['@cid']   = xPlayer.PlayerData.citizenid
        },
        function(data)

            if data[1] == nil then

                MySQL.Async.execute('INSERT INTO gksphone_ebay (label, price, count, item, cid, store) VALUES (@label, @price, @count, @item, @cid, @store)',
                {
                    ['@label']         = itemLabel,
                    ['@price']         = price,
                    ['@count']         = ItemCount,
                    ['@item']          = Item,
                    ['@cid']           = xPlayer.PlayerData.citizenid,
                    ['@store']         = 1
                })

                xPlayer.Functions.RemoveItem(Item, ItemCount)

            elseif data[1].item == Item then

                MySQL.Async.execute("UPDATE gksphone_ebay SET count = @count WHERE item = @name AND store = 1",
                {
                    ['@name'] = Item,
                    ['@count'] = data[1].count + ItemCount
                }
                )
                xPlayer.Functions.RemoveItem(Item, ItemCount)


            elseif data ~= nil and data[1].item ~= Item then
                Wait(250)
                TriggerClientEvent(Config.CoreName..':Notify', source, Config.SameItem, 'error')
                Wait(250)
                TriggerClientEvent(Config.CoreName..':Notify', source, Config.RemoveItem, 'error')

            end
        end)
end)


RegisterServerEvent('gks_ebay:depoitemdelete')
AddEventHandler('gks_ebay:depoitemdelete', function(item, count)
  local src = source
  local xPlayer = Config.Core.Functions.GetPlayer(src)

  MySQL.Async.fetchAll(
        'SELECT count, item FROM gksphone_ebay WHERE item = @item AND cid = @cid',
        {
            ['@item'] = item,
            ['@cid']   = xPlayer.PlayerData.citizenid
        },
        function(data)

            if count > data[1].count then
                TriggerClientEvent(Config.CoreName..':Notify', src, Config.Takeout , 'error')

                else

                if data[1].count ~= count then

                    MySQL.Async.execute("UPDATE gksphone_ebay SET count = @count WHERE item = @item AND cid = @cid",
                    {
                        ['@item'] = item,
                        ['@count'] = data[1].count - count,
                        ['@cid']   = xPlayer.PlayerData.citizenid
                    }, function(result)

                    xPlayer.Functions.AddItem(data[1].item, count)
                end)

                elseif data[1].count == count then

                    MySQL.Async.execute("DELETE FROM gksphone_ebay WHERE item = @name AND cid = @cid",
                    {
                        ['@name'] = data[1].item,
                        ['@cid']   = xPlayer.PlayerData.citizenid
                    })

                    xPlayer.Functions.AddItem(data[1].item, count)
            end
        end
    end)
end)

RegisterServerEvent('gks_ebay:purchitemdelete')
AddEventHandler('gks_ebay:purchitemdelete', function(item, count)
  local src = source
  local xPlayer = Config.Core.Functions.GetPlayer(src)

    MySQL.Async.fetchAll(
        'SELECT count, item FROM gksphone_ebay WHERE item = @item AND cid = @cid AND store = 0',
        {
            ['@item'] = item,
            ['@cid']   = xPlayer.PlayerData.citizenid
        },
        function(data)

                if count > data[1].count then
                    TriggerClientEvent(Config.CoreName..':Notify', src, Config.Takeout , 'error')

                elseif data[1].count ~= count then
                        if xPlayer.Functions.AddItem(data[1].item, count) then
                            MySQL.Async.execute("UPDATE gksphone_ebay SET count = @count WHERE item = @item AND cid = @cid AND store = 0",
                            {
                                ['@item'] = item,
                                ['@count'] = data[1].count - count,
                                ['@cid']   = xPlayer.PlayerData.citizenid
                            }, function(result)
                            end)
                        end


                elseif data[1].count == count then
                        if xPlayer.Functions.AddItem(data[1].item, count) then
                            MySQL.Async.execute("DELETE FROM gksphone_ebay WHERE item = @name AND cid = @cid AND store = 0",
                            {
                                ['@name'] = data[1].item,
                                ['@cid']   = xPlayer.PlayerData.citizenid
                            })
                end


        end
    end)
end)