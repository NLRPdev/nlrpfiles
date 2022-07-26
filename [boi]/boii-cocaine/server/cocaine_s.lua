-------------------------------
---------- CASE#1993 ----------
-------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local RemoveItemEvent = Config.CoreSettings.RemoveItemEvent
local AddItemEvent = Config.CoreSettings.AddItemEvent
local AddStress = Config.CoreSettings.AddStressEvent
local RemoveStress = Config.CoreSettings.RemoveStress
local MetaDataEvent = Config.CoreSettings.MetaDataEvent
local MetaDataName = Config.XP.MetaDataName
local XPLevels = Config.XP.XPLevels
local XPReward = Config.XP.XPReward
local XPRemove = Config.XP.XPRemove
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- PICK COCA START --<!>--
RegisterNetEvent('boii-cocaine:server:HarvestCoca', function()
	local source = source
    local pData = Core.Functions.GetPlayer(source)
	local DrugXP = pData.PlayerData.metadata[MetaDataName]
    local CocaItem = Config.DrugMaterials.Cocaine.CocaPlants.ReturnItem
    local CocaStress = Config.DrugMaterials.Cocaine.CocaPlants.PickStress
    local chance = Config.DrugMaterials.Cocaine.CocaPlants.PickChance
    if Config.XP.UseXP == true then        
        if (chance >= math.random(1, 100)) then
            if DrugXP < 200 then -- Level 3; Edit XP here to match config!
                pData.Functions.AddItem(CocaItem, math.random(1,3)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CocaItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.CocaPlants['cocasuccess'], 'success')
            elseif DrugXP >= 200 then -- Level 5; Edit XP here to match config!
                pData.Functions.AddItem(CocaItem, math.random(1,3)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CocaItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.CocaPlants['cocasuccess'], 'success')
            elseif DrugXP >= 300 then -- Level 5; Edit XP here to match config!
                pData.Functions.AddItem(CocaItem, math.random(1,4)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CocaItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.CocaPlants['cocasuccess'], 'success')
            elseif DrugXP >= 400 then -- Level 7; Edit XP here to match config!
                pData.Functions.AddItem(CocaItem, math.random(1,5)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CocaItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.CocaPlants['cocasuccess'], 'success')
            elseif DrugXP >= 500 then -- Level 9; Edit XP here to match config!
                pData.Functions.AddItem(CocaItem, math.random(1,6)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CocaItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.CocaPlants['cocasuccess'], 'success')
            elseif DrugXP >= 6000 then -- Level 11; Edit XP here to match config!
                pData.Functions.AddItem(CocaItem, math.random(1,7)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CocaItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.CocaPlants['cocasuccess'], 'success')
            end
            pData.Functions.SetMetaData(MetaDataName, (DrugXP + XPReward))
        else
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.CocaPlants['cocafail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, CocaStress)
        end
    elseif Config.XP.UseXP == false then
        if (chance >= math.random(1, 100)) then
            pData.Functions.AddItem(CocaItem, math.random(1,3)) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CocaItem], 'add')
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.CocaPlants['cocasuccessnoxp'], 'success')
        else
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.CocaPlants['cocafailnoxp'], 'error')
            TriggerEvent(AddStress, CocaStress)
        end
    end
end)
--<!>-- PICK COCA END --<!>--

--<!>-- SEARCH MATERIALS START --<!>--
RegisterNetEvent('boii-cocaine:server:SearchBuildingMaterials', function()
	local source = source
    local pData = Core.Functions.GetPlayer(source)
	local DrugXP = pData.PlayerData.metadata[MetaDataName]
    local chance = Config.DrugMaterials.Shared.ConstructionSite.Chance
    local alertchance = Config.DrugMaterials.Shared.ConstructionSite.PoliceChance
    local BuildingMatsStress = Config.DrugMaterials.Shared.ConstructionSite.CollectStress
    local MatsItem = Config.DrugMaterials.Shared.ConstructionSite.RewardItems[math.random(1, #Config.DrugMaterials.Shared.ConstructionSite.RewardItems)]
    if Config.XP.UseXP == true then        
        if (chance >= math.random(1, 100)) then
            if DrugXP < 300 then  -- Level 4; Edit XP here to match config!
                pData.Functions.AddItem(MatsItem, math.random(1,2)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MatsItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matssuccess'], 'success')
            elseif DrugXP >= 300 then -- Level 4; Edit XP here to match config!
                pData.Functions.AddItem(MatsItem, math.random(1,2)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MatsItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matssuccess'], 'success')
            elseif DrugXP >= 400 then -- Level 5; Edit XP here to match config!
                pData.Functions.AddItem(MatsItem, math.random(1,3)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MatsItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matssuccess'], 'success')
            elseif DrugXP >= 500 then -- Level 6; Edit XP here to match config!
                pData.Functions.AddItem(MatsItem, math.random(1,4)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MatsItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matssuccess'], 'success')
            elseif DrugXP >= 600 then -- Level 7; Edit XP here to match config!
                pData.Functions.AddItem(MatsItem, math.random(1,5)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MatsItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matssuccess'], 'success')
            end
            pData.Functions.SetMetaData(MetaDataName, (DrugXP + XPReward))
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-cocaine:client:AlertPolice', source)
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matsfail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, BuildingMatsStress)
        else 
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matsfail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, BuildingMatsStress)
        end
    elseif Config.XP.UseXP == false then
        if (chance >= math.random(1, 100)) then
            pData.Functions.AddItem(MatsItem, math.random(1,3)) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MatsItem], 'add')
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matssuccessnoxp'], 'success')
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-cocaine:client:AlertPolice', source)
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matsfailnoxp'], 'error')
            TriggerEvent(AddStress, BuildingMatsStress)
        else
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matsfailnoxp'], 'error')
            TriggerEvent(AddStress, BuildingMatsStress)
        end
    end
end)
--<!>-- SEARCH MATERIALS END --<!>--

--<!>-- COLLECT GASOLINE CODE START --<!>--
RegisterNetEvent('boii-cocaine:server:CollectGasoline', function()
	local source = source
    local pData = Core.Functions.GetPlayer(source)
	local DrugXP = pData.PlayerData.metadata[MetaDataName]
    local HydroItem = Config.DrugMaterials.Cocaine.IllegalGasoline.ReturnItem
    local GasCollectStress = Config.DrugMaterials.Cocaine.IllegalGasoline.CollectStress
    local HydroCollectItem = Config.DrugMaterials.Cocaine.IllegalGasoline.CollectItem
    local chance = Config.DrugMaterials.Cocaine.IllegalGasoline.CollectChance
    local alertchance = Config.DrugMaterials.Cocaine.IllegalGasoline.PoliceChance
    if Config.XP.UseXP == true then        
        if (chance >= math.random(1, 100)) then
            if DrugXP < 400 then -- Level 5; Edit XP here to match config!
                pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit remove amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(HydroItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.IllegalGasoline['gassuccess'], 'success')
            elseif DrugXP >= 400 then -- Level 5; Edit XP here to match config!
                pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit remove amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(HydroItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.IllegalGasoline['gassuccess'], 'success')
            elseif DrugXP >= 500 then -- Level 6; Edit XP here to match config!
                pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit remove amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(HydroItem, math.random(1,2)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.IllegalGasoline['gassuccess'], 'success')
            elseif DrugXP >= 600 then -- Level 7; Edit XP here to match config!
                pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit remove amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(HydroItem, math.random(1,3)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.IllegalGasoline['gassuccess'], 'success')
            elseif DrugXP >= 700 then -- Level 8; Edit XP here to match config!
                pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit remove amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(HydroItem, math.random(1,4)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.IllegalGasoline['gassuccess'], 'success')
            end
            pData.Functions.SetMetaData(MetaDataName, (DrugXP + XPReward))
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-cocaine:client:AlertPolice', source)
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.IllegalGasoline['gasfail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, GasCollectStress)
        else
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.IllegalGasoline['gasfail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, GasCollectStress)
        end
    elseif Config.XP.UseXP == false then
        if (chance >= math.random(1, 100)) then
            pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit remove amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
            Wait(1000)
            pData.Functions.AddItem(HydroItem, math.random(1,3)) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.IllegalGasoline['gassuccessnoxp'], 'success')
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-cocaine:client:AlertPolice', source)
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.IllegalGasoline['gasfailnoxp'], 'error')
            TriggerEvent(AddStress, GasCollectStress)
        else
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.IllegalGasoline['gasfailnoxp'], 'error')
            TriggerEvent(AddStress, GasCollectStress)
        end
    end
end)
--<!>-- COLLECT GASOLINE CODE END --<!>--

--<!>-- AIRPLANE CARTS CODE START --<!>--
RegisterNetEvent('boii-cocaine:server:SearchCart', function()
	local source = source
    local pData = Core.Functions.GetPlayer(source)
	local DrugXP = pData.PlayerData.metadata[MetaDataName]
    local chance = Config.DrugMaterials.Cocaine.Benzocaine.Chance
    local alertchance = Config.DrugMaterials.Cocaine.Benzocaine.PoliceChance
    local CartStress = Config.DrugMaterials.Cocaine.Benzocaine.CollectStress
    local CartItem = Config.DrugMaterials.Cocaine.Benzocaine.RewardItems[math.random(1, #Config.DrugMaterials.Cocaine.Benzocaine.RewardItems)]
    if Config.XP.UseXP == true then        
        if (chance >= math.random(1, 100)) then
            if DrugXP < 600 then -- Level 7; Edit XP here to match config!
                pData.Functions.AddItem(CartItem, math.random(1,2)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CartItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.Benzocaine['benzosuccess'], 'success')
            elseif DrugXP >= 600 then -- Level 7; Edit XP here to match config!
                pData.Functions.AddItem(CartItem, math.random(1,2)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CartItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.Benzocaine['benzosuccess'], 'success')
            elseif DrugXP >= 700 then -- Level 8; Edit XP here to match config!
                pData.Functions.AddItem(CartItem, math.random(1,3)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CartItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.Benzocaine['benzosuccess'], 'success')
            elseif DrugXP >= 800 then -- Level 9; Edit XP here to match config!
                pData.Functions.AddItem(CartItem, math.random(1,4)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CartItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.Benzocaine['benzosuccess'], 'success')
            elseif DrugXP >= 900 then -- Level 10; Edit XP here to match config!
                pData.Functions.AddItem(CartItem, math.random(1,5)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CartItem], 'add')
                TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.Benzocaine['benzosuccess'], 'success')
            end
            pData.Functions.SetMetaData(MetaDataName, (DrugXP + XPReward))
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-cocaine:client:AlertPolice', source)
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.Benzocaine['benzofail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, CartStress)
        else 
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.Benzocaine['benzofail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, CartStress)
        end
    elseif Config.XP.UseXP == false then
        if (chance >= math.random(1, 100)) then
            pData.Functions.AddItem(CartItem, math.random(1,3)) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[CartItem], 'add')
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.Benzocaine['benzosuccessnoxp'], 'success')
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-cocaine:client:AlertPolice', source)
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.Benzocaine['benzofailnoxp'], 'error')
            TriggerEvent(AddStress, CartStress)
        else
            TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugMaterials.Cocaine.Benzocaine['benzofailnoxp'], 'error')
            TriggerEvent(AddStress, CartStress)
        end
    end
end)
--<!>-- AIRPLANE CARTS CODE END --<!>--

--<!>-- POLICE NOTIFY START --<!>--
RegisterServerEvent('boii-cocaine:server:PoliceNotification')
AddEventHandler('boii-cocaine:server:PoliceNotification', function(player)
	local source = source
	local Players = Core.Functions.GetPlayers()
	for i = 1, #Players do
	local Player =  Core.Functions.GetPlayer(Players[i])
		if Player.PlayerData.job.name == Config.PoliceJob then -- You can edit this to add more jobs for example; if Core.Functions.GetPlayerData().job.name == Config.PoliceJob or Core.Functions.GetPlayerData().job.name == 'fib' then
		   TriggerClientEvent('boii-cocaine:client:PoliceNotification', Players[i], source )
        end
	end
end)
--<!>-- POLICE NOTIFY END --<!>--

--<!>-- CUTTING KIT START --<!>--
-- Drug cutting kit
--[[local CuttingKit = Config.DrugCutting.Shared.CuttingKit['1'].name
local ScaleItem = Config.DrugCutting.Shared.Scales['1'].name
Core.Functions.CreateUseableItem(CuttingKit, function(source, item)
    local Player = Core.Functions.GetPlayer(source)
    local scales = Player.Functions.GetItemByName(ScaleItem)
    if scales ~= nil then
        TriggerClientEvent('boii-cocaine:client:DrugCuttingMenu', source)
    else
        TriggerClientEvent('boii-cocaine:notifications', source, Config.Lang.DrugCutting.Shared['noscales'], 'error')
    end
end)--]]
--<!>-- CUTTING KIT END --<!>--