--================================================================================================
--==            --    XenKnighT --        https://discord.gg/XUck63E                            ==
--================================================================================================

Gotur = {}

Config.Core.Functions.CreateCallback('tonygetcoords', function(source, cb, id)
    local player = id
    local ped = GetPlayerPed(player)
    local playerCoords = GetEntityCoords(ped)
    cb(playerCoords)
end)

AddEventHandler('playerDropped', function (reason)

    local xPlayer = Config.Core.Functions.GetPlayer(source)

        if (xPlayer ~= nil) then
            
            local id = xPlayer.PlayerData.charinfo.phone

            if (Gotur[id] ~= nil) then

                if (Gotur[id].durum == 'iptal' or Gotur[id].durum == 'teslimedildi') then

                else

                    local test = getSourceFromIdentifier()
                    local tutar = Gotur[id].total
                    if (json.encode(test) ~= '[]') then
                        for i=1, #test, 1 do
                            TriggerClientEvent('gksphone:sipariss', test[i].id, Gotur)
                            TriggerClientEvent('gksphone:notifi', test[i].id, {title = Config.AppName, message = Gotur[id].deneme .. 'canceled the order', img= '/html/static/img/icons/gotur.png' })
                        end
                    end

                    Gotur[id] = {
                        deneme = Gotur[id].deneme,
                        item = Gotur[id].item,
                        total = Gotur[id].total,
                        telno = id,
                        durum = 'iptal',
                    }

                    MySQL.Async.fetchAll("SELECT money FROM players WHERE citizenid = @identifier", {
                        ['@identifier'] = xPlayer.PlayerData.citizenid,
                    }, function(result)

                        g=json.decode(result[1].money)

                        g['bank']=g['bank']+(tonumber(tutar));
                

                        MySQL.Async.execute('UPDATE players SET `money` = @bank WHERE `citizenid` = @identifier', {
                        ['@identifier'] = xPlayer.PlayerData.citizenid,
                        ['@bank'] = json.encode(g),
                        })
                    end)
                
                    exports['qb-management']:AddMoney('gotur', tutar) 
                   -- TriggerEvent('qb-bossmenu:server:removeAccountMoney', 'gotur', tutar)

                end
            end
        end

end)

Config.Core.Functions.CreateCallback('gks_gotur:getInventory', function(source, cb)
	local xPlayer = Config.Core.Functions.GetPlayer(source)
	local layetedaw   = xPlayer.PlayerData.items
    cb(layetedaw)
end)

Config.Core.Functions.CreateCallback('gks_gotur:depoitemgotur', function(source, cb)
	local result = MySQL.Sync.fetchAll('SELECT * FROM gksphone_gotur')
	local valcik = {}
	for i=1, #result, 1 do
		table.insert(valcik, {label = result[i].label, count = result[i].count, item = result[i].item, price = result[i].price, kapat = result[i].kapat, adet = result[i].adet}) 
	end

	cb(valcik)

end)

function getSourceFromIdentifier()
    local Lawyers = {}
    for k, v in pairs(Config.Core.Functions.GetPlayers()) do
        local Player = Config.Core.Functions.GetPlayer(v)

        if Player ~= nil then
            
            if Player.PlayerData.job.name == 'gotur' and Player.PlayerData.job.onduty then
                table.insert(Lawyers, {
                    id = Player.PlayerData.source,
                })
            end
        end
    end
    return Lawyers
end

RegisterServerEvent('gks_gotur:siparis')
AddEventHandler('gks_gotur:siparis', function(deneme, a, b, c, d)
    local id = b
    local isim = a
    local src = source
	local xPlayer = Config.Core.Functions.GetPlayer(src)
    if xPlayer ~= nil then
        
        if xPlayer.PlayerData.money["bank"] > c then
                    local test = getSourceFromIdentifier()
                     if (json.encode(test) ~= '[]') then
                        Gotur[id] = {
                            source = src,
                            deneme = isim,
                            item = deneme,
                            telno = id,
                            durum = d,
                            total = c
                        }
                        
                        --TriggerEvent('qb-bossmenu:server:addAccountMoney', 'gotur', c)
                        exports['qb-management']:AddMoney('gotur', c) 
                        xPlayer.Functions.RemoveMoney('bank', c, "Gotur")
                        for i=1, #test, 1 do
                            TriggerClientEvent('gks_gotur:blipp', test[i].id, Gotur[id].deneme, xPlayer.PlayerData.source, id)
                            TriggerClientEvent('gksphone:notifi', test[i].id, {title = Config.AppName, message = Gotur[id].deneme ..' ' ..Config.Order, img= '/html/static/img/icons/gotur.png' })
                            TriggerClientEvent('gksphone:sipariss', test[i].id, Gotur)
                        end
               
                        TriggerClientEvent('gksphone:sipariss', src, Gotur)
                        TriggerClientEvent('gks_gotur:gerisayim', src, c, Gotur)
                    else
                        TriggerClientEvent('gksphone:notifi', src, {title = Config.AppName, message = Config.ShopColsed, img= '/html/static/img/icons/gotur.png' })
                    end
                    
         
        else
            TriggerClientEvent('gksphone:notifi', src, {title = Config.AppName, message = Config.NoMoney, img= '/html/static/img/icons/gotur.png' })
        end
    end
end)


RegisterServerEvent('gks_gotur:failed')
AddEventHandler('gks_gotur:failed', function(bilgi)
    local src = source
	local xPlayer = Config.Core.Functions.GetPlayer(src)

    if xPlayer ~= nil then
      
  
         
                    local test = getSourceFromIdentifier()
                    local id = xPlayer.PlayerData.charinfo.phone
                    local tutar = Gotur[id].total

                        Gotur[id] = {
                            source = Gotur[id].source,
                            deneme = Gotur[id].deneme,
                            item = Gotur[id].item,
                            telno = id,
                            durum = 'iptal',
                            total = Gotur[id].total
                        }

                        exports['qb-management']:AddMoney('gotur', tutar) 
                        --TriggerEvent('qb-bossmenu:server:removeAccountMoney', 'gotur', tutar)
                        xPlayer.Functions.AddMoney('bank', tutar, "Gotur")
                     
                        for i=1, #test, 1 do
                            TriggerClientEvent('gks_gotur:stopblipp', test[i].id, id, Gotur[id].source)
                            TriggerClientEvent('gksphone:sipariss', test[i].id, Gotur)
                            TriggerClientEvent('gksphone:notifi', test[i].id, {title = Config.AppName, message = Gotur[id].deneme ..' ' ..Config.PersonCancel, img= '/html/static/img/icons/gotur.png' })
                        end
                        TriggerClientEvent('gksphone:notifi', src, {title = Config.AppName, message = Config.OrderTime, img= '/html/static/img/icons/gotur.png' })
                        TriggerClientEvent('gksphone:sipariss', src, Gotur)
                        
           

    end
end)




RegisterServerEvent('gks_gotur:syold')
AddEventHandler('gks_gotur:syold', function(total, bilgi)
    local src = source
	local xPlayer = Config.Core.Functions.GetPlayer(src)
 
    if xPlayer ~= nil then
   
           
                    local test = getSourceFromIdentifier()
                    local Target = Config.Core.Functions.GetPlayerByPhone(bilgi)
                

                        Gotur[bilgi] = {
                            source = Gotur[bilgi].source,
                            deneme = total[bilgi].deneme,
                            item = total[bilgi].item,
                            total = Gotur[bilgi].total,
                            telno = bilgi,
                            durum = 'yolda',
                        }



                        for i=1, #test, 1 do
                            TriggerClientEvent('gksphone:sipariss', test[i].id, Gotur)
                        end
                        TriggerClientEvent('gksphone:notifi', Target.PlayerData.source, {title = Config.AppName, message = Config.OrderWay, img= '/html/static/img/icons/gotur.png' })

                        TriggerClientEvent('gksphone:sipariss', Target.PlayerData.source, Gotur)
                    
       

    end
end)

RegisterServerEvent('gks_gotur:teslimyapildi')
AddEventHandler('gks_gotur:teslimyapildi', function(total, bilgi)
    local src = source
	local xPlayer = Config.Core.Functions.GetPlayer(src)

    if xPlayer ~= nil then
   
           
                    local test = getSourceFromIdentifier()
                    local Target = Config.Core.Functions.GetPlayerByPhone(bilgi)
                 

                        Gotur[bilgi] = {
                            source = Gotur[bilgi].source,
                            deneme = total[bilgi].deneme,
                            item = total[bilgi].item,
                            total = Gotur[bilgi].total,
                            telno = bilgi,
                            durum = 'teslimedildi',
                        }



                        for i=1, #test, 1 do
                            TriggerClientEvent('gksphone:sipariss', test[i].id, Gotur)
                            TriggerClientEvent('gks_gotur:stopblipp', test[i].id, bilgi, Gotur[bilgi].source)
                        end
                        TriggerClientEvent('gksphone:notifi', Target.PlayerData.source, {title = Config.AppName, message = Config.Delivered, img= '/html/static/img/icons/gotur.png' })
                        TriggerClientEvent('gks_gotur:gerisaybitir', Target.PlayerData.source)
                        TriggerClientEvent('gksphone:sipariss', Target.PlayerData.source, Gotur)
                    
       

    end
end)


RegisterServerEvent('gks_gotur:depoitem')
AddEventHandler('gks_gotur:depoitem', function(Item, ItemCount, price)
  local xPlayer = Config.Core.Functions.GetPlayer(source)

        MySQL.Async.fetchAll(
        'SELECT item, count FROM gksphone_gotur WHERE item = @items',
        {
            ['@items'] = Item
        },
        function(data)
	
        if data[1] == nil then

            MySQL.Async.execute('INSERT INTO gksphone_gotur (label, price, count, item) VALUES (@label, @price, @count, @item)',
            {
                ['@label']         = Item,
                ['@price']         = price,
                ['@count']         = ItemCount,
                ['@item']          = Item
            })

            xPlayer.Functions.RemoveItem(Item, ItemCount)

        elseif data[1].item == Item then
            
                MySQL.Async.execute("UPDATE gksphone_gotur SET count = @count WHERE item = @name",
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


RegisterServerEvent('gks_gotur:depoitemdelete')
AddEventHandler('gks_gotur:depoitemdelete', function(item, count)
  local src = source
  local xPlayer = Config.Core.Functions.GetPlayer(src)

  MySQL.Async.fetchAll(
        'SELECT count, item FROM gksphone_gotur WHERE item = @item',
        {
            ['@item'] = item
        },
        function(data)

            if count > data[1].count then
                TriggerClientEvent(Config.CoreName..':Notify', src, Config.OutYouOwn, 'error')

                else

                if data[1].count ~= count then

                    MySQL.Async.execute("UPDATE gksphone_gotur SET count = @count WHERE item = @item",
                    {
                        ['@item'] = item,
                        ['@count'] = data[1].count - count
                    }, function(result)
                    
                    xPlayer.Functions.AddItem(data[1].item, count)
                end)
    
                elseif data[1].count == count then

                    MySQL.Async.execute("DELETE FROM gksphone_gotur WHERE item = @name",
                    {
                        ['@name'] = data[1].item
                    })

                    xPlayer.Functions.AddItem(data[1].item, count)
            end
        end
    end)
end)