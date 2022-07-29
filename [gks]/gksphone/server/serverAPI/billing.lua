
if not Config.okokBilling then

    -- BILLING --

    Config.Core.Functions.CreateCallback('gksphone:getbilling', function(source, cb)
        local e = Config.Core.Functions.GetPlayer(source)
        MySQL.Async.fetchAll('SELECT * FROM gksphone_invoices WHERE citizenid = @identifier ', { ["@identifier"] = e.PlayerData.citizenid }, function(result)
            local billingg = {}
            for i = 1, #result, 1 do
                table.insert(billingg, { id = result[i].id, sender = result[i].society, sendercitizenid = result[i].sendercitizenid, label = result[i].label, amount = result[i].amount })
            end
            cb(billingg)
        end)
    end)

    function round(num, numDecimalPlaces)
        if numDecimalPlaces and numDecimalPlaces > 0 then
            local mult = 10 ^ numDecimalPlaces
            return math.floor(num * mult + 0.5) / mult
        end
        return math.floor(num + 0.5)
    end

    RegisterServerEvent("gksphone:faturapayBill")
    AddEventHandler("gksphone:faturapayBill", function(id)
        local src = source
        local Ply = Config.Core.Functions.GetPlayer(src)

        MySQL.Async.fetchAll('SELECT * FROM gksphone_invoices WHERE id = @id', {
            ['@id'] = id.id
        }, function(data)
            local SenderPly = Config.Core.Functions.GetPlayerByCitizenId(data[1].sendercitizenid)
            if Ply.PlayerData.money.bank >= data[1].amount then
                if SenderPly ~= nil then
                    if Config.BillingCommissions[data[1].society] then
                        local commission = round(data[1].amount * Config.BillingCommissions[data[1].society])
                        SenderPly.Functions.AddMoney('bank', commission)
                        TriggerClientEvent('gksphone:notifi', SenderPly.PlayerData.source, { title = _U('billing_title'), message = string.format('You received a commission check of $%s when %s %s paid a bill of $%s.', commission, Ply.PlayerData.charinfo.firstname, Ply.PlayerData.charinfo.lastname, data[1].amount), img = '/html/static/img/icons/logo.png' })
                    end
                end
                Ply.Functions.RemoveMoney('bank', data[1].amount, "paid-invoice")
                if Config.qbmanagement then
                    exports['qb-management']:AddMoney(data[1].society, data[1].amount)
                else
                    TriggerEvent("qb-bossmenu:server:addAccountMoney", data[1].society, data[1].amount)
                end
                TriggerEvent('gksphone:server:bank_gettransferinfo', src)
                MySQL.Async.execute('DELETE FROM gksphone_invoices WHERE id=@id', { ['@id'] = id.id })
                TriggerClientEvent('updatebilling', src)


                MySQL.Async.execute("INSERT INTO gksphone_bank_transfer (type, identifier, price, name) VALUES (@type, @identifier, @price, @name)", {
                    ["@type"] = 1,
                    ["@identifier"] = Ply.PlayerData.citizenid,
                    ["@price"] = data[1].amount,
                    ["@name"] = _U('bill_billing') .. data[1].amount
                })
            else
                TriggerClientEvent('gksphone:notifi', Ply.PlayerData.source, { title = _U('billing_title'), message = _U('bill_nocash'), img = '/html/static/img/icons/logo.png' })
                TriggerEvent('gksphone:server:bank_gettransferinfo', src)
                TriggerClientEvent('updatebilling', src)
            end
        end)
    end)

    RegisterServerEvent("gksphone:server:faturapayBill")
    AddEventHandler("gksphone:server:faturapayBill", function()
        local src = source
        local Ply = Config.Core.Functions.GetPlayer(src)
        local money = Ply.PlayerData.money.bank
        MySQL.Async.fetchAll('SELECT * FROM gksphone_invoices WHERE citizenid = @citizenid', {
            ['@citizenid'] = Ply.PlayerData.citizenid
        }, function(data)
            for i = 1, #data, 1 do
                local SenderPly = Config.Core.Functions.GetPlayerByCitizenId(data[i].sendercitizenid)
                if money >= data[i].amount then
                    if SenderPly ~= nil then
                        if Config.BillingCommissions[data[i].society] then
                            local commission = round(data[i].amount * Config.BillingCommissions[data[i].society])
                            SenderPly.Functions.AddMoney('bank', commission)
                            TriggerClientEvent('gksphone:notifi', tonumber(SenderPly.PlayerData.source), { title = _U('billing_title'), message = string.format('You received a commission check of $%s when %s %s paid a bill of $%s.', commission, Ply.PlayerData.charinfo.firstname, Ply.PlayerData.charinfo.lastname, data[i].amount), img = '/html/static/img/icons/logo.png' })
                        end
                    end
                    money = money - data[i].amount
                    Ply.Functions.RemoveMoney('bank', data[i].amount, "paid-invoice")
                    if Config.qbmanagement then
                        exports['qb-management']:AddMoney(data[1].society, data[1].amount)
                    else
                        TriggerEvent("qb-bossmenu:server:addAccountMoney", data[i].society, data[i].amount)
                    end
                    MySQL.Async.execute('DELETE FROM gksphone_invoices WHERE id=@id', { ['@id'] = data[i].id })

                    MySQL.Async.execute("INSERT INTO gksphone_bank_transfer (type, identifier, price, name) VALUES (@type, @identifier, @price, @name)", {
                        ["@type"] = 1,
                        ["@identifier"] = Ply.PlayerData.citizenid,
                        ["@price"] = data[i].amount,
                        ["@name"] = _U('bill_billing') .. data[i].amount
                    })

                else
                    TriggerClientEvent('gksphone:notifi', src, { title = _U('billing_title'), message = _U('bill_nocash'), img = '/html/static/img/icons/logo.png' })
                    break
                end
            end
            TriggerEvent('gksphone:server:bank_gettransferinfo', src)
            TriggerClientEvent('updatebilling', src)
        end)
    end)

    Config.Core.Commands.Add('billing', 'Bill A Player', { { name = 'id', help = 'Player ID' }, { name = 'amount', help = 'Fine Amount' }, { name = 'label', help = 'Invoice Description' } }, false, function(source, args)
        local biller = Config.Core.Functions.GetPlayer(source)
        local billed = Config.Core.Functions.GetPlayer(tonumber(args[1]))
        local amount = tonumber(args[2])
        local jobinfo = false
        table.remove(args, 1)
        table.remove(args, 1)
        local label = ""
        for i = 1, #args, 1 do
            label = label .. ' ' .. args[i]
        end
        for _, k in pairs(Config.BillingJob) do
            if _ == biller.PlayerData.job.name and k then
                jobinfo = true
                break
            end
        end
        if jobinfo then
            if billed ~= nil then
                if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                    if amount and amount > 0 then
                        MySQL.Async.execute('INSERT INTO gksphone_invoices (citizenid, amount, society, sender, sendercitizenid, label) VALUES (@citizenid, @amount, @society, @sender, @sendercitizenid, @label)', {
                            ['@citizenid'] = billed.PlayerData.citizenid,
                            ['@amount'] = amount,
                            ['@society'] = biller.PlayerData.job.name,
                            ['@sender'] = biller.PlayerData.charinfo.firstname,
                            ['@sendercitizenid'] = biller.PlayerData.citizenid,
                            ['@label'] = label
                        })

                        TriggerClientEvent('gksphone:notifi', source, { title = _U('billing_title'), message = _U('bill_invosucss'), img = '/html/static/img/icons/logo.png' })
                        TriggerClientEvent('gksphone:notifi', billed.PlayerData.source, { title = _U('billing_title'), message = _U('bill_younewin'), img = '/html/static/img/icons/logo.png' })

                    else
                        TriggerClientEvent('gksphone:notifi', source, { title = _U('billing_title'), message = _U('bill_amounterror'), img = '/html/static/img/icons/logo.png' })
                    end
                else
                    TriggerClientEvent('gksphone:notifi', source, { title = _U('billing_title'), message = _U('bill_cannotbill'), img = '/html/static/img/icons/logo.png' })
                end
            else
                TriggerClientEvent('gksphone:notifi', source, { title = _U('billing_title'), message = _U('bill_notplayer'), img = '/html/static/img/icons/logo.png' })
            end
        else
            TriggerClientEvent(Config.CoreNotify, source, 'No Access', 'error')
        end
    end)


    --- Business İnvoices ---

    Config.Core.Functions.CreateCallback('gksphone:server:bfaturalist', function(source, cb)
        local e = Config.Core.Functions.GetPlayer(source)
        local billingg = {}
        MySQL.query("SELECT * FROM gksphone_invoices WHERE society = @society", { ["@society"] = e.PlayerData.job.name }, function(result)
            for i = 1, #result, 1 do
                local yPlayer = Config.Core.Functions.GetPlayerByCitizenId(result[i].citizenid)
                if yPlayer then
                    table.insert(billingg, { id = result[i].id, alici = yPlayer.PlayerData.charinfo.firstname, society = result[i].society, sender = result[i].sender, sendercitizenid = result[i].sendercitizenid, label = result[i].label, amount = result[i].amount })
                else
                    local players = MySQL.scalar.await("SELECT charinfo FROM `players` WHERE `citizenid` LIKE '%" .. result[i].citizenid .. "%'", {})
                    if players then
                        local name = json.decode(players)
                        table.insert(billingg, { id = result[i].id, alici = name.firstname, society = result[i].society, sender = result[i].sender, sendercitizenid = result[i].sendercitizenid, label = result[i].label, amount = result[i].amount })
                    else
                        table.insert(billingg, { id = result[i].id, alici = "", society = result[i].society, sender = result[i].sender, sendercitizenid = result[i].sendercitizenid, label = result[i].label, amount = result[i].amount })
                    end
                end
            end
            cb(billingg)
        end)
    end)

    RegisterServerEvent("gksphone:business:delbill")
    AddEventHandler("gksphone:business:delbill", function(id)
        local src = source
        local e = Config.Core.Functions.GetPlayer(src)
        local gradejob = e.PlayerData.job.grade.level

        if gradejob >= Config.JobGrade then
            MySQL.Async.fetchAll('SELECT * FROM gksphone_invoices WHERE society = @society AND id = @id', {
            ['@society'] = e.PlayerData.job.name,
            ['@id'] = id
            }, function(data)
            if data[1] then
                local Player = Config.Core.Functions.GetPlayerByCitizenId(data[1].citizenid)
                if Player then
                    TriggerClientEvent('gksphone:notifi', Player.PlayerData.source, {title = _U('bussines_title'), message = data[1].label .._('bill_invoicecancel'), img= '/html/static/img/icons/logo.png' })
                end
                MySQL.Async.fetchAll("DELETE FROM gksphone_invoices WHERE id = @id",
                {
                    ['@id'] = data[1].id
                })
                TriggerClientEvent('gksphone:notifi', src, {title = _U('bussines_title'), message = _U('buss_delbill'), img= '/html/static/img/icons/business.png' })
            else
                TriggerClientEvent('gksphone:notifi', src, {title = _U('bussines_title'), message = _U('buss_nodelbill'), img= '/html/static/img/icons/business.png' })
            end
            end)
        else
            TriggerClientEvent('gksphone:notifi', src, {title = _U('bussines_title'), message = _U('buss_gradenotbill'), img= '/html/static/img/icons/business.png' })
        end
    end)

else
    Config.Core.Functions.CreateCallback('gksphone:getbilling', function(source, cb)
        local xPlayer = Config.Core.Functions.GetPlayer(source)

        MySQL.query('SELECT * FROM okokBilling WHERE receiver_identifier = @identifier AND status = "unpaid"', {
            ['@identifier'] = xPlayer.PlayerData.citizenid
        }, function(result)
            local billingg = {}

            if result ~= nil then
                for i=1, #result, 1 do
                    table.insert(billingg, {id = result[i].id, label = result[i].notes, sender = result[i].society_name, target=result[i].society, amount=result[i].invoice_value})
                end
            end

            cb(billingg)
        end)

    end)

    RegisterServerEvent("gksphone:faturapayBill")
    AddEventHandler("gksphone:faturapayBill", function(invoice_id)
        local xPlayer = Config.Core.Functions.GetPlayer(source)
        local _source = source

        MySQL.query('SELECT * FROM okokBilling WHERE id = @id', {
            ['@id'] = invoice_id
        }, function(result)
            local invoices = result[1]
            local playerMoney = xPlayer.PlayerData.money.bank
            local job = xPlayer.PlayerData.job.name
            local webhookData = {
                id = invoices.id,
                player_name = invoices.receiver_name,
                value = invoices.invoice_value,
                item = invoices.item,
                society = invoices.society_name
            }

            invoices.invoice_value = math.ceil(invoices.invoice_value)

            if playerMoney == nil then
                playerMoney = 0
            end

            if playerMoney < invoices.invoice_value then
                TriggerClientEvent('gksphone:notifi', _source, { title = _U('billing_title'), message = _U('bill_nocash'), img = '/html/static/img/icons/logo.png' })
            else
                xPlayer.Functions.RemoveMoney('bank', invoices.invoice_value)

                TriggerEvent("qb-bossmenu:server:okokBillingDeposit", invoices.society, invoices.invoice_value)

                MySQL.query('UPDATE okokBilling SET status = @status, paid_date = CURRENT_TIMESTAMP WHERE id = @id', {
                    ['@status'] = 'paid',
                    ['@id'] = invoice_id
                })

                TriggerClientEvent('gksphone:notifi', _source, { title = _U('billing_title'), message = _U('bill_paid') ..invoices.invoice_value, img = '/html/static/img/icons/logo.png' })

                TriggerEvent('gksphone:server:bank_gettransferinfo', _source)
                TriggerClientEvent('updatebilling', _source)


                MySQL.Async.execute("INSERT INTO gksphone_bank_transfer (type, identifier, price, name) VALUES (@type, @identifier, @price, @name)", {
                    ["@type"] = 1,
                    ["@identifier"] = xPlayer.PlayerData.citizenid,
                    ["@price"] = invoices.invoice_value,
                    ["@name"] = _U('bill_billing') .. invoices.invoice_value
                })
            end
        end)
    end)


    RegisterServerEvent("gksphone:server:faturapayBill")
    AddEventHandler("gksphone:server:faturapayBill", function()
        local src = source
        local Ply = Config.Core.Functions.GetPlayer(src)
        MySQL.Async.fetchAll('SELECT * FROM okokBilling WHERE receiver_identifier = @identifier AND status = "unpaid"', {
            ['@identifier'] = Ply.PlayerData.citizenid
        }, function(data)
            for i = 1, #data, 1 do
                local xPlayer = Config.Core.Functions.GetPlayer(src)
                local playerMoney = xPlayer.PlayerData.money.bank
                if playerMoney < data[i].invoice_value then
                    TriggerClientEvent('gksphone:notifi', src, { title = _U('billing_title'), message = _U('bill_nocash'), img = '/html/static/img/icons/logo.png' })
                    break
                else

                    xPlayer.Functions.RemoveMoney('bank', data[i].invoice_value)

                    TriggerEvent("qb-bossmenu:server:okokBillingDeposit", data[i].society, data[i].invoice_value)

                    MySQL.query('UPDATE okokBilling SET status = @status, paid_date = CURRENT_TIMESTAMP WHERE id = @id', {
                        ['@status'] = 'paid',
                        ['@id'] = data[i].id
                    })

                    TriggerClientEvent('gksphone:notifi', src, { title = _U('billing_title'), message = _U('bill_paid') ..data[i].invoice_value, img = '/html/static/img/icons/logo.png' })

                    MySQL.Async.execute("INSERT INTO gksphone_bank_transfer (type, identifier, price, name) VALUES (@type, @identifier, @price, @name)", {
                        ["@type"] = 1,
                        ["@identifier"] = xPlayer.PlayerData.citizenid,
                        ["@price"] = data[i].invoice_value,
                        ["@name"] = _U('bill_billing') .. data[i].invoice_value
                    })

                end
            end

            TriggerEvent('gksphone:server:bank_gettransferinfo', src)
            TriggerClientEvent('updatebilling', src)
        end)
    end)

    Config.Core.Functions.CreateCallback('gksphone:server:bfaturalist', function(source, cb)
        local e = Config.Core.Functions.GetPlayer(source)
        local billingg = {}
        MySQL.query("SELECT * FROM okokbilling WHERE society = @society AND status = 'unpaid'", { ["@society"] = e.PlayerData.job.name }, function(result)
            for i = 1, #result, 1 do
                table.insert(billingg, { id = result[i].id, alici = result[i].receiver_name, society = result[i].society, sender = result[i].author_name, sendercitizenid = result[i].author_identifier, label = result[i].notes, amount = result[i].invoice_value })
            end
            cb(billingg)
        end)
    end)

    RegisterServerEvent("gksphone:business:delbill")
    AddEventHandler("gksphone:business:delbill", function(invoice_id)
        local xPlayer = Config.Core.Functions.GetPlayer(source)
        local _source = source
        local gradejob = xPlayer.PlayerData.job.grade.level
        if gradejob >= Config.JobGrade then
            MySQL.query('SELECT * FROM okokBilling WHERE id = @id AND society = @society AND status = "unpaid"', {
                ['@society'] = xPlayer.PlayerData.job.name,
                ['@id'] = invoice_id
            }, function(result)
                if result[1] then
                    local invoices = result[1]
                    local Player = Config.Core.Functions.GetPlayerByCitizenId(invoices.receiver_identifier)
                    if Player then
                        TriggerClientEvent('gksphone:notifi', Player.PlayerData.source, {title = _U('bussines_title'), message = invoices.notes .._('bill_invoicecancel'), img= '/html/static/img/icons/logo.png' })
                        TriggerClientEvent('updatebilling', Player.PlayerData.source)
                    end
                    local webhookData = {
                        id = invoices.id,
                        player_name = invoices.receiver_name,
                        value = invoices.invoice_value,
                        item = invoices.item,
                        society = invoices.society_name,
                        name = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname
                    }
                    MySQL.query('UPDATE okokBilling SET status = "cancelled", paid_date = CURRENT_TIMESTAMP WHERE id = @id', {
                        ['@id'] = invoice_id
                    })
                    TriggerClientEvent('gksphone:notifi', _source, {title = _U('bussines_title'), message = _U('buss_delbill'), img= '/html/static/img/icons/business.png' })

                    local billingg = {}
                    MySQL.query("SELECT * FROM okokbilling WHERE society = @society AND status = 'unpaid'", { ["@society"] = xPlayer.PlayerData.job.name }, function(result)
                        for i = 1, #result, 1 do
                            table.insert(billingg, { id = result[i].id, alici = result[i].receiver_name, society = result[i].society, sender = result[i].author_name, sendercitizenid = result[i].author_identifier, label = result[i].notes, amount = result[i].invoice_value })
                        end
                        TriggerClientEvent('gksphone:client:billrefresh', _source, billingg)
                    end)


                else
                    TriggerClientEvent('gksphone:notifi', _source, {title = _U('bussines_title'), message = _U('buss_gradenotbill'), img= '/html/static/img/icons/business.png' })
                end
            end)
        end
    end)

end