-------------------------------
---------- CASE#2506 ----------
-------------------------------

local QBCore = exports['qb-core']:GetCoreObject()

--<!>-- MINING CODE START --<!>-- 
-- Mine Paydirt
RegisterServerEvent('boii-mining:server:PaydirtMining', function() 
    local src = source
    local Player  = QBCore.Functions.GetPlayer(src)
	if (30 >= math.random(1, 100)) then
        if Player.Functions.AddItem("premiumpaydirt", math.random(3,5)) then   
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["premiumpaydirt"], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
        end		
	elseif (80 >= math.random(1, 100)) then
        if Player.Functions.AddItem("paydirt", math.random(3,5)) then   
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["paydirt"], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
        end
	else
        TriggerClientEvent('QBCore:Notify', src, Config.Lang['miningfailed'], 'error')
	end
end)
--<!>-- MINING CODE END --<!>-- 

--<!>-- PROCESSING CODE START --<!>-- 
RegisterServerEvent('boii-mining:server:ProcessPaydirt', function(args) 
	local source = source
    local Player = QBCore.Functions.GetPlayer(source)
	local args = tonumber(args)
    local removeAmount = 1
    if args == 1 then 
        local paydirtitem = Player.Functions.GetItemByName("paydirt") 
        if paydirtitem ~= nil then
            Player.Functions.RemoveItem("paydirt", removeAmount)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['paydirt'], "remove", removeAmount)
            TriggerClientEvent('boii-mining:client:ProcessPaydirt', source)
		else
			TriggerClientEvent('QBCore:Notify', source, Config.Lang["anypaydirt"], "error", 1500)
			TriggerClientEvent('boii-mining:client:PaydirtProcessingMenu', source)
		end
    elseif args == 2 then 
        local paydirtitem = Player.Functions.GetItemByName("premiumpaydirt") 
        if paydirtitem ~= nil then
            Player.Functions.RemoveItem("premiumpaydirt", removeAmount)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['premiumpaydirt'], "remove", removeAmount)
            TriggerClientEvent('boii-mining:client:ProcessPremiumPaydirt', source)
        else
            TriggerClientEvent('QBCore:Notify', source, Config.Lang["anyprempaydirt"], "error", 1500)
            TriggerClientEvent('boii-mining:client:PaydirtProcessingMenu', source)
        end
	end
end)
--<!>-- PROCESSING CODE END --<!>--