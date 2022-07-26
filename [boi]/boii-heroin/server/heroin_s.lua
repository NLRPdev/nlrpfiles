----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local AddStress = Config.CoreSettings.AddStressEvent
local MetaDataEvent = Config.CoreSettings.MetaDataEvent
local MetaDataName = Config.XP.MetaDataName
local XPLevels = Config.XP.XPLevels
local XPReward = Config.XP.XPReward
local XPRemove = Config.XP.XPRemove
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- POLICE NOTIFY CODE START --<!>--
RegisterServerEvent('boii-heroin:server:PoliceNotification')
AddEventHandler('boii-heroin:server:PoliceNotification', function(playerme)
	local source = source
	local Players = Core.Functions.GetPlayers()
	for i = 1, #Players do
	local Player =  Core.Functions.GetPlayer(Players[i])
		if Player.PlayerData.job.name == Config.PoliceJob then -- You can edit this to add more jobs for example; if Core.Functions.GetPlayerData().job.name == Config.PoliceJob or Core.Functions.GetPlayerData().job.name == 'fib' then
		   TriggerClientEvent('boii-heroin:client:PoliceNotification', Players[i], source )
        end
	end
end)
--<!>-- POLICE NOTIFY CODE END --<!>--

--<!>-- PICK OPIUM CODE START --<!>--
RegisterNetEvent('boii-heroin:server:HarvestOpium', function()
	local source = source
    local pData = Core.Functions.GetPlayer(source)
	local DrugXP = pData.PlayerData.metadata[MetaDataName]
    local OpiumItem = Config.DrugMaterials.Heroin.Opium.ReturnItem
    local OpiumPickStress = Config.DrugMaterials.Heroin.Opium.PickStress
    local chance = Config.DrugMaterials.Heroin.Opium.PickChance
    if Config.XP.UseXP == true then        
        if (chance >= math.random(1, 100)) then
            if DrugXP < 100 then -- Level 1; Edit XP here to match config!
                pData.Functions.AddItem(OpiumItem, math.random(1,2)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[OpiumItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Opium['opiumsuccess'], 'success')
            elseif DrugXP >= 100 then -- Level 2; Edit XP here to match config!
                pData.Functions.AddItem(OpiumItem, math.random(1,3)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[OpiumItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Opium['opiumsuccess'], 'success')
            elseif DrugXP >= 200 then -- Level 3; Edit XP here to match config!
                pData.Functions.AddItem(OpiumItem, math.random(1,4)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[OpiumItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Opium['opiumsuccess'], 'success')
            elseif DrugXP >= 300 then -- Level 4; Edit XP here to match config!
                pData.Functions.AddItem(OpiumItem, math.random(1,5)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[OpiumItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Opium['opiumsuccess'], 'success')
            elseif DrugXP >= 400 then -- Level 5; Edit XP here to match config!
                pData.Functions.AddItem(OpiumItem, math.random(1,6)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[OpiumItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Opium['opiumsuccess'], 'success')
            end
            pData.Functions.SetMetaData(MetaDataName, (DrugXP + XPReward))
        else
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Opium['opiumfail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, OpiumPickStress)
        end
    elseif Config.XP.UseXP == false then
        if (chance >= math.random(1, 100)) then
            pData.Functions.AddItem(OpiumItem, math.random(1,3)) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[OpiumItem], 'add')
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Opium['opiumsuccessnoxp'], 'success')
        else
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Opium['opiumfailnoxp'], 'error')
            TriggerEvent(AddStress, OpiumPickStress)
        end
    end
end)
--<!>-- PICK OPIUM CODE END --<!>--

--<!>-- SEARCH MATERIALS CODE START --<!>--
RegisterNetEvent('boii-heroin:server:SearchBuildingMaterials', function()
	local source = source
    local pData = Core.Functions.GetPlayer(source)
	local DrugXP = pData.PlayerData.metadata[MetaDataName]
    local chance = Config.DrugMaterials.Shared.ConstructionSite.Chance
    local alertchance = Config.DrugMaterials.Shared.ConstructionSite.PoliceChance
    local BuildingMatsStress = Config.DrugMaterials.Shared.ConstructionSite.CollectStress
    local MatsItem = Config.DrugMaterials.Shared.ConstructionSite.RewardItems[math.random(1, #Config.DrugMaterials.Shared.ConstructionSite.RewardItems)]
    if Config.XP.UseXP == true then        
        if (chance >= math.random(1, 100)) then
            if DrugXP < 300 then -- Level 3; Edit XP here to match config!
                pData.Functions.AddItem(MatsItem, math.random(1,2))
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MatsItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matssuccess'], 'success')
            elseif DrugXP >= 300 then -- Level 4; Edit XP here to match config!
                pData.Functions.AddItem(MatsItem, math.random(1,3))
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MatsItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matssuccess'], 'success')
            elseif DrugXP >= 400 then -- Level 5; Edit XP here to match config!
                pData.Functions.AddItem(MatsItem, math.random(1,4))
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MatsItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matssuccess'], 'success')
            elseif DrugXP >= 500 then -- Level 6; Edit XP here to match config!
                pData.Functions.AddItem(MatsItem, math.random(1,5))
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MatsItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matssuccess'], 'success')
            end
            pData.Functions.SetMetaData(MetaDataName, (DrugXP + XPReward))
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-heroin:client:AlertPolice', source)
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matsfail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, BuildingMatsStress)
        else 
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matsfail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, BuildingMatsStress)
        end
    elseif Config.XP.UseXP == false then
        if (chance >= math.random(1, 100)) then
            pData.Functions.AddItem(MatsItem, math.random(1,3)) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MatsItem], 'add')
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matssuccessnoxp'], 'success')
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-heroin:client:AlertPolice', source)
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matsfailnoxp'], 'error')
            TriggerEvent(AddStress, BuildingMatsStress)
        else
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.ConstructionSite['matsfailnoxp'], 'error')
            TriggerEvent(AddStress, BuildingMatsStress)
        end
    end
end)
--<!>-- SEARCH MATERIALS CODE END --<!>--

--<!>-- COLLECT ETHER CODE START --<!>--
RegisterNetEvent('boii-heroin:server:CollectEther', function()
	local source = source
    local pData = Core.Functions.GetPlayer(source)
	local DrugXP = pData.PlayerData.metadata[MetaDataName]
    local EtherItem = Config.DrugMaterials.Heroin.Ether.ReturnItem
    local EtherCollectItem = Config.DrugMaterials.Heroin.Ether.CollectItem
    local EtherCollectStress = Config.DrugMaterials.Heroin.Ether.CollectStress
    local chance = Config.DrugMaterials.Heroin.Ether.CollectChance
    local alertchance = Config.DrugMaterials.Heroin.Ether.PoliceChance
    if Config.XP.UseXP == true then        
        if (chance >= math.random(1, 100)) then
            if DrugXP < 600 then -- Level 7; Edit XP here to match config!
                pData.Functions.RemoveItem(EtherCollectItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[EtherCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(EtherItem, math.random(1,2)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[EtherItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Ether['ethersuccess'], 'success')
            elseif DrugXP >= 600 then -- Level 7; Edit XP here to match config!
                pData.Functions.RemoveItem(EtherCollectItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[EtherCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(EtherItem, math.random(1,3)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[EtherItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Ether['ethersuccess'], 'success')
            elseif DrugXP >= 700 then -- Level 8; Edit XP here to match config!
                pData.Functions.RemoveItem(EtherCollectItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[EtherCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(EtherItem, math.random(1,4)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[EtherItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Ether['ethersuccess'], 'success')
            elseif DrugXP >= 800 then -- Level 9; Edit XP here to match config!
                pData.Functions.RemoveItem(EtherCollectItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[EtherCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(EtherItem, math.random(1,5)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[EtherItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Ether['ethersuccess'], 'success')
            elseif DrugXP >= 900 then -- Level 10; Edit XP here to match config!
                pData.Functions.RemoveItem(EtherCollectItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[EtherCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(EtherItem, math.random(1,6)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[EtherItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Ether['ethersuccess'], 'success')
            end
            pData.Functions.SetMetaData(MetaDataName, (DrugXP + XPReward))
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-heroin:client:AlertPolice', source)
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Ether['etherfail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, EtherCollectStress)
        else 
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Ether['etherfail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, EtherCollectStress)
        end
    elseif Config.XP.UseXP == false then
        if (chance >= math.random(1, 100)) then
            pData.Functions.RemoveItem(EtherCollectItem, 1) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[EtherCollectItem], 'remove')
            Wait(1000)
            pData.Functions.AddItem(EtherItem, math.random(1,3)) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[EtherItem], 'add')
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Ether['ethersuccessnoxp'], 'success')
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-heroin:client:AlertPolice', source)
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Ether['etherfailnoxp'], 'error')
            TriggerEvent(AddStress, EtherCollectStress)
        else
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Heroin.Ether['etherfailnoxp'], 'error')
            TriggerEvent(AddStress, EtherCollectStress)
        end
    end
end)
--<!>-- COLLECT ETHER CODE END --<!>--

--<!>-- COLLECT HYDROCHLORIC CODE START --<!>--
RegisterNetEvent('boii-heroin:server:CollectHydro', function()
	local source = source
    local pData = Core.Functions.GetPlayer(source)
	local DrugXP = pData.PlayerData.metadata[MetaDataName]
    local HydroItem = Config.DrugMaterials.Shared.Hydrochloric.ReturnItem
    local HydroCollectStress = Config.DrugMaterials.Shared.Hydrochloric.CollectStress
    local HydroCollectItem = Config.DrugMaterials.Shared.Hydrochloric.CollectItem
    local chance = Config.DrugMaterials.Shared.Hydrochloric.CollectChance
    local alertchance = Config.DrugMaterials.Shared.Hydrochloric.PoliceChance
    if Config.XP.UseXP == true then        
        if (chance >= math.random(1, 100)) then
            if DrugXP < 500 then -- Level 6; Edit XP here to match config!
                pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(HydroItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrosuccess'], 'success')
            elseif DrugXP >= 500 then -- Level 6; Edit XP here to match config!
                pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(HydroItem, math.random(1,2)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrosuccess'], 'success')
            elseif DrugXP >= 600 then -- Level 7; Edit XP here to match config!
                pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(HydroItem, math.random(1,3)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrosuccess'], 'success')
            elseif DrugXP >= 700 then -- Level 8; Edit XP here to match config!
                pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(HydroItem, math.random(1,4)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
                TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrosuccess'], 'success')
            end
            pData.Functions.SetMetaData(MetaDataName, (DrugXP + XPReward))
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-heroin:client:AlertPolice', source)
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrofail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, HydroCollectStress)
        else
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrofail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, HydroCollectStress)
        end
    elseif Config.XP.UseXP == false then
        if (chance >= math.random(1, 100)) then
            pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
            Wait(1000)
            pData.Functions.AddItem(HydroItem, math.random(1,3)) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrosuccessnoxp'], 'success')
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-heroin:client:AlertPolice', source)
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrofailnoxp'], 'error')
            TriggerEvent(AddStress, HydroCollectStress)
        else
            TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrofailnoxp'], 'error')
            TriggerEvent(AddStress, HydroCollectStress)
        end
    end
end)
--<!>-- COLLECT HYDROCHLORIC CODE END --<!>--

--<!>-- CUTTING KIT START --<!>--
-- Drug cutting kit
local CuttingKit = Config.DrugCutting.Shared.CuttingKit['1'].name
local ScaleItem = Config.DrugCutting.Shared.Scales['1'].name
Core.Functions.CreateUseableItem(CuttingKit, function(source, item)
    local Player = Core.Functions.GetPlayer(source)
    local scales = Player.Functions.GetItemByName(ScaleItem)
    if scales ~= nil then
        TriggerClientEvent('boii-heroin:client:DrugCuttingMenu', source)
    else
        TriggerClientEvent('boii-heroin:notifications', source, Config.Lang.DrugCutting.Shared['noscales'], 'error')
    end
end)
--<!>-- CUTTING KIT END --<!>--