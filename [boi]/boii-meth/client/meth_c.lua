-------------------------------
---------- CASE#1993 ----------
-------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local TargetName = Config.CoreSettings.TargetName
local MenuName = Config.CoreSettings.MenuName
local ItemCheckEvent = Config.CoreSettings.ItemCheckEvent
local RemoveItemEvent = Config.CoreSettings.RemoveItemEvent
local AddItemEvent = Config.CoreSettings.AddItemEvent
local MetaDataEvent = Config.CoreSettings.MetaDataEvent
local MetaDataName = Config.XP.MetaDataName
local XPLevels = Config.XP.XPLevels
local XPReward = Config.XP.XPReward
local XPRemove = Config.XP.XPRemove
local HydroProp = Config.DrugMaterials.Shared.Hydrochloric.Prop
local HydroCollectItem = Config.DrugMaterials.Shared.Hydrochloric.CollectItem
local MethyProp = Config.DrugMaterials.Meth.Methylamine.Prop
local MethyCollectItem = Config.DrugMaterials.Meth.Methylamine.CollectItem
local BoxProp = Config.DrugMaterials.Meth.Acetone.Prop
local LithProp = Config.DrugMaterials.Meth.Lithium.Prop
local LithCollectItem = Config.DrugMaterials.Meth.Lithium.CollectItem
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- NOTIFICATIONS START --<!>--
RegisterNetEvent('boii-meth:notifications')
AddEventHandler('boii-meth:notifications', function(msg, type)
    Core.Functions.Notify(msg,type)
end)
--<!>-- NOTIFICATIONS END --<!>--

--<!>-- BLIPS START --<!>--
if Config.UseBlips == true then
	CreateThread(function()
		for _, info in pairs(Config.Blips) do
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 0.6)
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)
		end
	end)
end
--<!>-- BLIPS END --<!>--

--<!>-- PED STUFF START --<!>--
-- Targeting for meth processing ped
exports[TargetName]:AddTargetModel(`ig_chef2`, {
    options = {
        {
            event = 'boii-meth:client:MethMenu',
            label = Config.Lang.Targeting.Meth['methprocessorlabel'],
            icon = Config.Lang.Targeting.Meth['processoricon'],
            canInteract = function(entity)
                if IsPedDeadOrDying(entity, true) or IsPedAPlayer(entity) then return false end
                return true
            end,    
        },
    },
    distance = 1.5
})
--  Thread to spawn peds from Config.Peds
Citizen.CreateThread(function()
    for _,v in pairs(Config.Peds.Meth) do
        RequestModel(GetHashKey(v[7]))
        while not HasModelLoaded(GetHashKey(v[7])) do
            Wait(1)
        end
        MethPed = CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
        SetEntityHeading(MethPed, v[5])
        FreezeEntityPosition(MethPed, true)
        SetEntityInvincible(MethPed, true)
        SetBlockingOfNonTemporaryEvents(MethPed, true)
        TaskStartScenarioInPlace(MethPed, "WORLD_HUMAN_SEAT_WALL_TABLET", 0, true) -- Change animation here 
    end
end)
--<!>-- PED STUFF END --<!>--

--<!>-- METH PROCESSING MENU START--<!>--
-- Main menu
RegisterNetEvent('boii-meth:client:MethMenu', function()
	local MethMenu = {
		{
			header = Config.Lang.Processing.Meth.Meth['processormethheader'],
			txt = Config.Lang.Processing.Meth.Meth['processormethheadertext'],
            icon = Config.Lang.Processing.Meth.Meth['processormethheadericon'],
			isMenuHeader = true
		},
		{
			header = Config.Lang.Processing.Meth.Meth['processingmethheader'],
			txt = Config.Lang.Processing.Meth.Meth['processingmethheadertext'],
            icon = Config.Lang.Processing.Meth.Meth['processingmethheadericon'],
			params = {
				event = 'boii-meth:server:ProcessDrugs', -- Do not edit this
				isServer = true, -- Do not edit this
			}
		},
		{
			header = Config.Lang.Stores.Meth.BlackMarket['blackmarketheader'],
			txt = Config.Lang.Stores.Meth.BlackMarket['blackmarketheadertext'],
            icon = Config.Lang.Stores.Meth.BlackMarket['blackmarketheadericon'],
			params = {
				event = 'boii-meth:client:OpenShops', -- Do not edit this
				args = 1, -- Do not edit this
			}
		}, -- Add more choices here
		{
			header = Config.Lang.Shared['exitmenu'],
			params = {
				event = 'boii-meth:client:StopMenu'
			}
		}
	}
    if Config.Processing.Meth.Meth.UseTimes == true then
        if GetClockHours() >= Config.Processing.Meth.Meth.StartTime and GetClockHours() <= Config.Processing.Meth.Meth.EndTime then
            exports[MenuName]:openMenu(MethMenu)
        else
            TriggerEvent('boii-meth:notifications', Config.Lang.Processing.Meth.Meth['processorclosed'], 'error')
        end
    elseif Config.Processing.Meth.Meth.UseTimes == false then
		exports[MenuName]:openMenu(MethMenu)
	end
end)
--<!>-- METH PROCESSING MENU END --<!>--

--<!>-- DRUG MATERIALS START --<!>--
-- Targeting
-- Hydrochloric Acid
exports[TargetName]:AddTargetModel(HydroProp, {options = {{event = 'boii-meth:client:CollectHydro',icon = Config.Lang.Targeting.Meth['hydroicon'],label = Config.Lang.Targeting.Meth['hydrolabel'],item = HydroCollectItem,},},distance = 2.0})
-- Methylamine
exports[TargetName]:AddTargetModel(MethyProp, {options = {{event = 'boii-meth:client:CollectMethy',icon = Config.Lang.Targeting.Meth['methyicon'],label = Config.Lang.Targeting.Meth['methylabel'],item = MethyCollectItem,},},distance = 2.0})
-- Acetone boxes
exports[TargetName]:AddTargetModel(BoxProp, {options = {{event = 'boii-meth:client:SearchBox',icon = Config.Lang.Targeting.Meth['acetoneicon'],label = Config.Lang.Targeting.Meth['acetonelabel']},},distance = 2.0})
-- Prospecting rocks
exports[TargetName]:AddTargetModel(LithProp, {options = {{event = 'boii-meth:client:ProspectRock',icon = Config.Lang.Targeting.Meth['lithicon'],label = Config.Lang.Targeting.Meth['lithlabel'],item = LithCollectItem,},},distance = 2.0})
--<!>-- DRUG MATERIALS END --<!>--

--<!>-- OPEN STORES START --<!>--
RegisterNetEvent('boii-meth:client:OpenShops', function(args)
    args = tonumber(args)
    ShopItems = {}
    ShopItems.label = ''
    ShopItems.items = ''
    ShopItems.slots = ''
    lang = ''
    if args == 1 then
        ShopItems.label = Config.Lang.Stores.Meth.BlackMarket['blackmarketstorelabel']
		ShopItems.items = Config.Stores.Meth.BlackMarket.BlackMarketItems
		ShopItems.slots = #Config.Stores.Meth.BlackMarket.BlackMarketItems
		lang = 'BlackMarket_' 
    end -- You can define separate stores here for example; add a new store with elseif args == 2 then, create a new item table within config and update menus accordingly
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', lang, ShopItems)
end)
--<!>-- OPEN STORES END --<!>--

--<!>-- CUTTING KIT MENU START --<!>--
--[[RegisterNetEvent('boii-meth:client:DrugCuttingMenu', function()
	local DrugCuttingMenu = {
		{
			header = Config.Lang.DrugCutting.Shared['cuttingheader'],
			txt = Config.Lang.DrugCutting.Shared['cuttingheadertext'],
            icon = Config.Lang.DrugCutting.Shared['cuttingheadericon'],
			isMenuHeader = true
		},
		{
			header = Config.Lang.DrugCutting.Heroin.Morphine['cutmorphineheader'],
            icon = Config.Lang.DrugCutting.Heroin.Morphine['cutmorphineheadericon'],
			params = {
				event = 'boii-heroin:server:DrugCuttingCheck',
				isServer = true,
				args = 1 -- DO NOT EDIT THIS
			}				
		},
		{
			header = Config.Lang.DrugCutting.Heroin.Heroin['cutheroinheader'],
            icon = Config.Lang.DrugCutting.Heroin.Heroin['cutheroinheadericon'],
			params = {
				event = 'boii-heroin:server:DrugCuttingCheck',
				isServer = true,
				args = 2 -- DO NOT EDIT THIS
			}				 
		},
		{
			header = Config.Lang.DrugCutting.Cocaine.Cocaine['cutcokeheader'],
            icon = Config.Lang.DrugCutting.Cocaine.Cocaine['cutcokeheadericon'],
			params = {
				event = 'boii-cocaine:server:DrugCuttingCheck',
                isServer = true,
				args = 3 -- DO NOT EDIT THIS
			}				
		},
		{
			header = Config.Lang.DrugCutting.Cocaine.Crack['cutcrackheader'],
            icon = Config.Lang.DrugCutting.Cocaine.Crack['cutcrackheadericon'],
			params = {
				event = 'boii-cocaine:server:DrugCuttingCheck',
                isServer = true,
				args = 4 -- DO NOT EDIT THIS
			}				
		},
		{
			header = Config.Lang.DrugCutting.Meth.Meth['cutmethheader'],
            icon = Config.Lang.DrugCutting.Meth.Meth['cutmethheadericon'],
			params = {
				event = 'boii-meth:server:DrugCuttingCheck',
                isServer = true,
				args = 5 -- DO NOT EDIT THIS
			}				
		},
		{
			header = Config.Lang.Shared['exitmenu'],
            icon = Config.Lang.Shared['exitmenuicon'],
			params = {
				event = 'boii-meth:client:StopMenu'
			}
		}
	}
	exports[MenuName]:openMenu(DrugCuttingMenu)
end)--]]
--<!>-- CUTTING KIT MENU END--<!>--

--<!>-- CUTTING KIT METH MENU START --<!>--
RegisterNetEvent('boii-meth:client:DrugCuttingMenu2', function(args)
	local args = tonumber(args)
	if args == 5 then
		exports[MenuName]:openMenu({
			{
				header = Config.Lang.DrugCutting.Shared['cuttingheader'],
				txt = Config.Lang.DrugCutting.Shared['cuttingheadertext'],
                icon = Config.Lang.DrugCutting.Shared['cuttingheadericon'],
				isMenuHeader = true
			},
			{
				header = Config.Lang.DrugCutting.Meth.Meth['cutmethheader'],
				txt = Config.Lang.DrugCutting.Meth.Meth['cutmethheadertext'],
                icon = Config.Lang.DrugCutting.Meth.Meth['cutmethheadericon'],
				params = {
					event = 'boii-meth:server:CutDrugs',
					isServer = true,
					args = 1
				}				
			},
			{
				header = Config.Lang.Shared['returnmenu'],
                icon = Config.Lang.Shared['returnmenuicon'],
				params = {
					event = 'boii-meth:client:DrugCuttingMenu',
				}
			}
		})
	end
end)
--<!>-- CUTTING KIT METH MENU END --<!>--

--<!>-- CUT DRUGS START --<!>--
RegisterNetEvent('boii-meth:client:CutDrugs', function(args)
    local pData = Core.Functions.GetPlayerData()
    local DrugXP = pData.metadata[MetaDataName]
    if Config.XP.UseXP == true then
        barname = 'cut_meth'
        lang = Config.Lang.DrugCutting.Meth.Meth['cutmeth']
        lang2 = Config.Lang.DrugCutting.Meth.Meth['cutmethxp']
        processtime = Config.DrugCutting.Meth.Meth.CuttingTime
        drug = ''
        drugamount = ''
        druganimdict = Config.DrugCutting.Meth.Meth.AnimationDict
        druganim = Config.DrugCutting.Meth.Meth.Animation
        if DrugXP < 1300 then -- Level 14; Edit XP here to match config!
            drug = Config.DrugCutting.Meth.Meth.ReturnItem['1'].name
            drugamount = Config.DrugCutting.Meth.Meth.ReturnItem['1'].amount
        elseif DrugXP >= 1300 then -- Level 14; Edit XP here to match config!
            drug = Config.DrugCutting.Meth.Meth.ReturnItem['1'].name
            drugamount = Config.DrugCutting.Meth.Meth.ReturnItem['1'].amount
        elseif DrugXP >= 1400 then -- Level 15; Edit XP here to match config!
            drug = Config.DrugCutting.Meth.Meth.ReturnItem['2'].name
            drugamount = Config.DrugCutting.Meth.Meth.ReturnItem['2'].amount
        elseif DrugXP >= 1500 then -- Level 16; Edit XP here to match config!
            drug = Config.DrugCutting.Meth.Meth.ReturnItem['3'].name
            drugamount = Config.DrugCutting.Meth.Meth.ReturnItem['3'].amount
        elseif DrugXP >= 1600 then -- Level 17; Edit XP here to match config!
            drug = Config.DrugCutting.Meth.Meth.ReturnItem['4'].name
            drugamount = Config.DrugCutting.Meth.Meth.ReturnItem['4'].amount
        elseif DrugXP >= 1700 then -- Level 18; Edit XP here to match config!
            drug = Config.DrugCutting.Meth.Meth.ReturnItem['4'].name
            drugamount = Config.DrugCutting.Meth.Meth.ReturnItem['4'].amount
        end
        Core.Functions.Progressbar(barname, lang, processtime, false, true, {
            disableMovement = false, 
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = druganimdict,
            anim = druganim,
            flags = 49,
        }, {}, {}, function()
            TriggerServerEvent('boii-meth:server:XP', 1)
            TriggerServerEvent(AddItemEvent, drug, drugamount)
            TriggerEvent('inventory:client:ItemBox', Core.Shared.Items[drug], 'add', drugamount)
            TriggerEvent('boii-meth:notifications', lang2, 'success')
        end, function() -- Cancel
            TriggerEvent('inventory:client:busy:status', false)
            TriggerEvent('boii-meth:notifications', Config.Lang.Shared['cancelled'], 'primary')
        end) 
    elseif Config.XP.UseXP == false then
        barname = 'cut_meth'
        lang = Config.Lang.DrugCutting.Meth.Meth['cutmeth']
        lang2 = Config.Lang.DrugCutting.Meth.Meth['cutmethnoxp']
        processtime = Config.DrugCutting.Meth.Meth.CuttingTime
        drug = Config.DrugCutting.Meth.Meth.ReturnItem['5'].name
        drugamount = Config.DrugCutting.Meth.Meth.ReturnItem['5'].amount
        druganimdict = Config.DrugCutting.Meth.Meth.AnimationDict
        druganim = Config.DrugCutting.Meth.Meth.Animation
        Core.Functions.Progressbar(barname, lang, processtime, false, true, {
            disableMovement = true, 
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = druganimdict,
            anim = druganim,
            flags = 49,
        }, {}, {}, function()
            TriggerServerEvent(AddItemEvent, drug, drugamount)
            TriggerEvent('inventory:client:ItemBox', Core.Shared.Items[drug], 'add', drugamount)
			TriggerEvent('boii-meth:notifications', lang2, 'success')
            ClearPedTasks(player)
        end, function() -- Cancel
            TriggerEvent('inventory:client:busy:status', false)
            TriggerClientEvent('boii-meth:notifications', Config.Lang.Shared['cancelled'], 'primary')
            ClearPedTasks(player)
        end)
    end
end)
--<!>-- CUT DRUGS END --<!>--

--<!>-- POLICE ALERTS START --<!>--
-- Used to trigger alerts from server/locked code side
RegisterNetEvent('boii-meth:client:AlertPolice', function()
	Wait(10)
	AlertPolice()
end)
-- Function to alert police
function AlertPolice(coords)
    if Core.Functions.GetPlayerData().job.name == 'police' then -- You can edit this to add more jobs for example; if Core.Functions.GetPlayerData().job.name == 'police' or Core.Functions.GetPlayerData().job.name == 'fib' then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local alpha = 250 -- Change blip alpha here
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip,  161) -- Change blip here
		SetBlipColour(Blip,  1) -- Change blip colour here
		SetBlipScale(Blip , 1.5) -- Change blip scale here
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Config.Lang.Alerts.Meth['bliptext'])
        EndTextCommandSetBlipName(Blip)
        TriggerServerEvent('boii-meth:server:PoliceNotification')
        while alpha ~= 0 do
            Wait(60*4) -- Change blip alpha tick here
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    end
end
-- Sends notification
RegisterNetEvent('boii-meth:client:PoliceNotification', function(player)
	if Core.Functions.GetPlayerData().job.name == 'police' then -- You can edit this to add more jobs for example; if Core.Functions.GetPlayerData().job.name == 'police' or Core.Functions.GetPlayerData().job.name == 'fib' then
		TriggerEvent('boii-meth:notifications', Config.Lang.Alerts.Meth['policenotif'], 'police')
	end
end)
--<!>-- POLICE ALERTS END --<!>--