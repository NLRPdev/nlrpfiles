-------------------------------
---------- CASE#1993 ----------
-------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local AddStress = Config.CoreSettings.AddStressEvent
local MetaDataName = Config.XP.MetaDataName
local XPReward = Config.XP.XPReward
local XPRemove = Config.XP.XPRemove
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- POLICE NOTIFY CODE START --<!>--
RegisterServerEvent('boii-meth:server:PoliceNotification')
AddEventHandler('boii-meth:server:PoliceNotification', function(playerme)
	local source = source
	local Players = Core.Functions.GetPlayers()
	for i = 1, #Players do
	local Player =  Core.Functions.GetPlayer(Players[i])
		if Player.PlayerData.job.name == Config.PoliceJob then -- You can edit this to add more jobs for example; if Core.Functions.GetPlayerData().job.name == Config.PoliceJob or Core.Functions.GetPlayerData().job.name == 'fib' then
		   TriggerClientEvent('boii-meth:client:PoliceNotification', Players[i], source )
        end
	end
end)
--<!>-- POLICE NOTIFY CODE END --<!>--

--<!>-- COLLECT HYDROCHLORIC START --<!>--
RegisterNetEvent('boii-meth:server:CollectHydro', function()
	local source = source
    local pData = Core.Functions.GetPlayer(source)
	local DrugXP = pData.PlayerData.metadata[MetaDataName]
    local HydroItem = Config.DrugMaterials.Shared.Hydrochloric.ReturnItem
    local HydroCollectStress = Config.DrugMaterials.Shared.Hydrochloric.CollectStress
    local HydroCollectItem = Config.DrugMaterials.Shared.Hydrochloric.CollectItem
    local collectchance = Config.DrugMaterials.Shared.Hydrochloric.CollectChance
    local alertchance = Config.DrugMaterials.Shared.Hydrochloric.PoliceChance
    if Config.XP.UseXP == true then -- If using xp 
        if (collectchance >= math.random(1, 100)) then
            if DrugXP < 500 then -- Level 6; Edit XP here to match config!
                pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(HydroItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrosuccess'], 'success')
            elseif DrugXP >= 500 then -- Level 6; Edit XP here to match config!
                pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(HydroItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrosuccess'], 'success')
            elseif DrugXP >= 600 then -- Level 7; Edit XP here to match config!
                pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(HydroItem, math.random(1,2)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrosuccess'], 'success')
            elseif DrugXP >= 700 then -- Level 8; Edit XP here to match config!
                pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(HydroItem, math.random(1,3)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrosuccess'], 'success')
            elseif DrugXP >= 800 then -- Level 9; Edit XP here to match config!
                pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(HydroItem, math.random(1,4)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrosuccess'], 'success')
            end
            pData.Functions.SetMetaData(MetaDataName, (DrugXP + XPReward))
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-meth:client:AlertPolice', source)
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrofail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, HydroCollectStress)
        else
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrofail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, HydroCollectStress)
        end
    elseif Config.XP.UseXP == false then 
        if (collectchance >= math.random(1, 100)) then
            pData.Functions.RemoveItem(HydroCollectItem, 1) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroCollectItem], 'remove')
            Wait(1000)
            pData.Functions.AddItem(HydroItem, math.random(1,3)) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[HydroItem], 'add')
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrosuccessnoxp'], 'success')
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-meth:client:AlertPolice', source)
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrofailnoxp'], 'error')
            TriggerEvent(AddStress, HydroCollectStress)
        else
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Shared.Hydrochloric['hydrofailnoxp'], 'error')
            TriggerEvent(AddStress, HydroCollectStress)
        end
    end
end)
--<!>-- COLLECT HYDROCHLORIC END --<!>--

--<!>-- COLLECT METHYLAMINE START --<!>--
RegisterNetEvent('boii-meth:server:CollectMethy', function()
	local source = source
    local pData = Core.Functions.GetPlayer(source)
	local DrugXP = pData.PlayerData.metadata[MetaDataName]
    local MethyItem = Config.DrugMaterials.Meth.Methylamine.ReturnItem
    local MethyCollectStress = Config.DrugMaterials.Meth.Methylamine.CollectStress
    local MethyCollectItem = Config.DrugMaterials.Meth.Methylamine.CollectItem
    local collectchance = Config.DrugMaterials.Meth.Methylamine.CollectChance
    local alertchance = Config.DrugMaterials.Meth.Methylamine.PoliceChance
    if Config.XP.UseXP == true then -- If using xp 
        if (collectchance >= math.random(1, 100)) then
            if DrugXP < 200 then -- Level 3; Edit XP here to match config!
                pData.Functions.RemoveItem(MethyCollectItem, 1) -- Edit remove amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MethyCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(MethyItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MethyItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Methylamine['methysuccess'], 'success')
            elseif DrugXP >= 200 then -- Level 3; Edit XP here to match config!
                pData.Functions.RemoveItem(MethyCollectItem, 1) -- Edit remove amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MethyCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(MethyItem, 1) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MethyItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Methylamine['methysuccess'], 'success')
            elseif DrugXP >= 300 then -- Level 4; Edit XP here to match config!
                pData.Functions.RemoveItem(MethyCollectItem, 1) -- Edit remove amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MethyCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(MethyItem, math.random(1,2)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MethyItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Methylamine['methysuccess'], 'success')
            elseif DrugXP >= 400 then -- Level 5; Edit XP here to match config!
                pData.Functions.RemoveItem(MethyCollectItem, 1) -- Edit remove amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MethyCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(MethyItem, math.random(1,3)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MethyItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Methylamine['methysuccess'], 'success')
            elseif DrugXP >= 500 then -- Level 6; Edit XP here to match config!
                pData.Functions.RemoveItem(MethyCollectItem, 1) -- Edit remove amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MethyCollectItem], 'remove')
                Wait(1000)
                pData.Functions.AddItem(MethyItem, math.random(1,4)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MethyItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Methylamine['methysuccess'], 'success')
            end
            pData.Functions.SetMetaData(MetaDataName, (DrugXP + XPReward))
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-meth:client:AlertPolice', source)
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Methylamine['methyfail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, MethyCollectStress)
        else
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Methylamine['methyfail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, MethyCollectStress)
        end
    elseif Config.XP.UseXP == false then 
        if (collectchance >= math.random(1, 100)) then
            pData.Functions.RemoveItem(MethyCollectItem, 1) -- Edit remove amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MethyCollectItem], 'remove')
            Wait(1000)
            pData.Functions.AddItem(MethyItem, math.random(1,3)) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[MethyItem], 'add')
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Methylamine['methysuccessnoxp'], 'success')
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-meth:client:AlertPolice', source)
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Methylamine['methyfailnoxp'], 'error')
            TriggerEvent(AddStress, MethyCollectStress)
        else
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Methylamine['methyfailnoxp'], 'error')
            TriggerEvent(AddStress, MethyCollectStress)
        end
    end
end)
--<!>-- COLLECT METHYLAMINE END --<!>--

--<!>-- SEARCH BOXES START --<!>--
RegisterNetEvent('boii-meth:server:SearchBox', function()
	local source = source
    local pData = Core.Functions.GetPlayer(source)
	local DrugXP = pData.PlayerData.metadata[MetaDataName]
    local collectchance = Config.DrugMaterials.Meth.Acetone.CollectChance
    local alertchance = Config.DrugMaterials.Meth.Acetone.PoliceChance
    local BoxStress = Config.DrugMaterials.Meth.Acetone.CollectStress
    local BoxItem = Config.DrugMaterials.Meth.Acetone.RewardItems[math.random(1, #Config.DrugMaterials.Meth.Acetone.RewardItems)]
    if Config.XP.UseXP == true then        
        if (collectchance >= math.random(1, 100)) then
            if DrugXP < 700 then -- Level 8; Edit XP here to match config!
                pData.Functions.AddItem(BoxItem, math.random(1,2)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[BoxItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Acetone['acetonesuccess'], 'success')
            elseif DrugXP >= 700 then -- Level 8; Edit XP here to match config!
                pData.Functions.AddItem(BoxItem, math.random(1,2)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[BoxItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Acetone['acetonesuccess'], 'success')
            elseif DrugXP >= 800 then -- Level 9; Edit XP here to match config!
                pData.Functions.AddItem(BoxItem, math.random(1,3)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[BoxItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Acetone['acetonesuccess'], 'success')
            elseif DrugXP >= 900 then -- Level 10; Edit XP here to match config!
                pData.Functions.AddItem(BoxItem, math.random(1,4)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[BoxItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Acetone['acetonesuccess'], 'success')
            elseif DrugXP >= 1000 then -- Level 11; Edit XP here to match config!
                pData.Functions.AddItem(BoxItem, math.random(1,5)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[BoxItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Acetone['acetonesuccess'], 'success')
            end
            pData.Functions.SetMetaData(MetaDataName, (DrugXP + XPReward))
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-meth:client:AlertPolice', source)
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Acetone['acetonefail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, BoxStress)
        else 
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Acetone['acetonefail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, BoxStress)
        end
    elseif Config.XP.UseXP == false then
        if (collectchance >= math.random(1, 100)) then
            pData.Functions.AddItem(BoxItem, math.random(1,3)) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[BoxItem], 'add')
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Acetone['acetonesuccessnoxp'], 'success')
        elseif (alertchance >= math.random(1, 100)) then
            TriggerClientEvent('boii-meth:client:AlertPolice', source)
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Acetone['acetonefailnoxp'], 'error')
            TriggerEvent(AddStress, BoxStress)
        else
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Acetone['acetonefailnoxp'], 'error')
            TriggerEvent(AddStress, BoxStress)
        end
    end
end)
--<!>-- SEARCH BOXES END --<!>--

--<!>-- PROSPECT ROCKS START --<!>--
RegisterNetEvent('boii-meth:server:ProspectRock', function()
	local source = source
    local pData = Core.Functions.GetPlayer(source)
	local DrugXP = pData.PlayerData.metadata[MetaDataName]
    local collectchance = Config.DrugMaterials.Meth.Lithium.Chance
    local LithStress = Config.DrugMaterials.Meth.Lithium.CollectStress
    local LithItem = Config.DrugMaterials.Meth.Lithium.RewardItems[math.random(1, #Config.DrugMaterials.Meth.Lithium.RewardItems)]
    if Config.XP.UseXP == true then        
        if (collectchance >= math.random(1, 100)) then
            if DrugXP < 900 then -- Level 10; Edit XP here to match config!
                pData.Functions.AddItem(LithItem, math.random(1,2)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[LithItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Lithium['lithiumsuccess'], 'success')
            elseif DrugXP >= 900 then -- Level 10; Edit XP here to match config!
                pData.Functions.AddItem(LithItem, math.random(1,2)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[LithItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Lithium['lithiumsuccess'], 'success')
            elseif DrugXP >= 1000 then -- Level 11; Edit XP here to match config!
                pData.Functions.AddItem(LithItem, math.random(1,3)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[LithItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Lithium['lithiumsuccess'], 'success')
            elseif DrugXP >= 1100 then -- Level 12; Edit XP here to match config!
                pData.Functions.AddItem(LithItem, math.random(1,4)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[LithItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Lithium['lithiumsuccess'], 'success')
            elseif DrugXP >= 1200 then -- Level 13; Edit XP here to match config!
                pData.Functions.AddItem(LithItem, math.random(1,5)) -- Edit reward amount here
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[LithItem], 'add')
                TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Lithium['lithiumsuccess'], 'success')
            end
            pData.Functions.SetMetaData(MetaDataName, (DrugXP + XPReward))
        else 
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Lithium['lithiumfail'], 'error')
            pData.Functions.SetMetaData(MetaDataName, (DrugXP - XPRemove))
            TriggerEvent(AddStress, LithStress)
        end
    elseif Config.XP.UseXP == false then
        if (collectchance >= math.random(1, 100)) then
            pData.Functions.AddItem(LithItem, math.random(1,3)) -- Edit reward amount here
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[LithItem], 'add')
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Lithium['lithiumsuccessnoxp'], 'success')
        else
            TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugMaterials.Meth.Lithium['lithiumfailnoxp'], 'error')
            TriggerEvent(AddStress, LithStress)
        end
    end
end)
--<!>-- PROSPECT ROCKS END --<!>--

--<!>-- POLICE NOTIFY START --<!>--
RegisterServerEvent('boii-meth:server:PoliceNotification')
AddEventHandler('boii-meth:server:PoliceNotification', function(player)
	local source = source
	local Players = Core.Functions.GetPlayers()
	for i = 1, #Players do
	local Player =  Core.Functions.GetPlayer(Players[i])
		if Player.PlayerData.job.name == 'police' then -- You can edit this to add more jobs for example; if Core.Functions.GetPlayerData().job.name == 'police' or Core.Functions.GetPlayerData().job.name == 'fib' then
		   TriggerClientEvent('boii-meth:client:PoliceNotification', Players[i], source )
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
        TriggerClientEvent('boii-meth:client:DrugCuttingMenu', source)
    else
        TriggerClientEvent('boii-meth:notifications', source, Config.Lang.DrugCutting.Shared['noscales'], 'error')
    end
end)--]]
--<!>-- CUTTING KIT END --<!>--