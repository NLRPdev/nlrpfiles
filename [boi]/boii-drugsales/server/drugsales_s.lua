----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- POLICE NOTIFY START --<!>--
RegisterServerEvent('boii-drugsales:server:PoliceNotification')
AddEventHandler('boii-drugsales:server:PoliceNotification', function(player)
	local source = source
	local Players = Core.Functions.GetPlayers()
	for i = 1, #Players do
	local pData = Core.Functions.GetPlayer(Players[i])
		if pData.PlayerData.job.name == 'police' then -- You can edit this to add more jobs for example; if Core.Functions.GetPlayerData().job.name == 'police' or Core.Functions.GetPlayerData().job.name == 'fib' then
		   TriggerClientEvent('boii-drugsales:client:PoliceNotification', Players[i], source )
        end
	end
end)
--<!>-- POLICE NOTIFY END --<!>--

--<!>-- BULK SELL BAGS START --<!>--
RegisterServerEvent('boii-drugsales:server:BulkSellBags', function(args) 
	local source = source
    local pData = Core.Functions.GetPlayer(source)
    local MoneyType = Config.DrugSales.BulkSelling.MoneyType
    local CashItem = Config.DrugSales.BulkSelling.CashItem
	local args = tonumber(args)
    bulkdrug = ''
    if args == 1 then
        bulkdrug =  'weed_skunk'
	elseif args == 2 then
        bulkdrug =  'weed_og-kush'
    elseif args == 3 then
        bulkdrug =  'weed_white-widow'
    elseif args == 4 then
        bulkdrug =  'weed_ak47'
    elseif args == 5 then
        bulkdrug =  'weed_amnesia'
    elseif args == 6 then
        bulkdrug =  'weed_purple-haze'
    elseif args == 7 then
        bulkdrug =  'heroinbaggy'
    elseif args == 8 then
        bulkdrug =  'morphine'
    elseif args == 9 then
        bulkdrug =  'liquidheroin'
    elseif args == 10 then
        bulkdrug =  'crack_baggy'
    elseif args == 11 then
        bulkdrug =  'meth'
    elseif args == 12 then
        bulkdrug =  'cokebaggy'
    end -- You can add more items here **ensure your args and menu triggers match client**
	if pData.Functions.GetItemByName(bulkdrug) ~= nil then
        amount = pData.Functions.GetItemByName(bulkdrug).amount
        pay = (amount*Config.DrugSales.BulkSelling.Drugs.Bags[bulkdrug])
        pData.Functions.RemoveItem(bulkdrug, amount)
        TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[bulkdrug], 'remove', amount)
        Wait(200)
        if Config.DrugSales.BulkSelling.UseCashItem == true then
            pData.Functions.AddItem(CashItem, pay)
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CashItem], 'add', Amount)
        elseif Config.DrugSales.BulkSelling.UseCashItem == false then
            pData.Functions.AddMoney(MoneyType, pay)
        end
    else
        TriggerClientEvent('boii-drugsales:notifications', Config.Lang.Shared['nodrugs'], 'error')
        TriggerClientEvent('boii-drugsales:client:BulkSellDrugsMenu', source)
    end
end)
--<!>-- BULK SELL BAGS END --<!>--

--<!>-- BULK SELL OUNCES START --<!>--
RegisterServerEvent('boii-drugsales:server:BulkSellOunces', function(args) 
	local source = source
    local pData = Core.Functions.GetPlayer(source)
    local MoneyType = Config.DrugSales.BulkSelling.MoneyType
    local CashItem = Config.DrugSales.BulkSelling.CashItem
	local args = tonumber(args)
    bulkdrug = ''
    if args == 1 then
        bulkdrug =  'heroin_1oz'
	elseif args == 2 then
        bulkdrug =  'crack_1oz'
    elseif args == 3 then
        bulkdrug =  'meth_1oz'
    elseif args == 4 then
        bulkdrug =  'coke_1oz'
    end -- You can add more items here **ensure your args and menu triggers match client**
	if pData.Functions.GetItemByName(bulkdrug) ~= nil then
        amount = pData.Functions.GetItemByName(bulkdrug).amount
        pay = (amount*Config.DrugSales.BulkSelling.Drugs.Ounces[bulkdrug])
        pData.Functions.RemoveItem(bulkdrug, amount)
        TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[bulkdrug], 'remove', amount)
        Wait(200)
        if Config.DrugSales.BulkSelling.UseCashItem == true then
            pData.Functions.AddItem(CashItem, pay)
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CashItem], 'add', Amount)
            return
        elseif Config.DrugSales.BulkSelling.UseCashItem == false then
            pData.Functions.AddMoney(MoneyType, pay)
            return
        end
    else
        TriggerClientEvent('boii-drugsales:notifications', Config.Lang.Shared['nodrugs'], 'error')
        TriggerClientEvent('boii-drugsales:client:BulkSellDrugsMenu', source)
    end
end)
--<!>-- BULK SELL OUNCES END --<!>--