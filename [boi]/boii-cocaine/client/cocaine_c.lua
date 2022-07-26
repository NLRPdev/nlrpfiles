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
local RemoveStress = Config.CoreSettings.RemoveStressEvent
local MetaDataName = Config.XP.MetaDataName
local BuildingMatsProp = Config.DrugMaterials.Shared.ConstructionSite.Prop
local CocaPlant = Config.DrugMaterials.Cocaine.CocaPlants.Prop
local GasolineProp = Config.DrugMaterials.Cocaine.IllegalGasoline.Prop
local GasolineCollectItem = Config.DrugMaterials.Cocaine.IllegalGasoline.CollectItem
local CartProp = Config.DrugMaterials.Cocaine.Benzocaine.Prop
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- NOTIFICATIONS START --<!>--
-- Notification event
RegisterNetEvent('boii-cocaine:notifications')
AddEventHandler('boii-cocaine:notifications', function(msg, type)
	-- You can replace if not using qb-core built in notifications
    Core.Functions.Notify(msg,type)
end)
--<!>-- NOTIFICATIONS END --<!>--

--<!>-- PED STUFF START --<!>--
-- Cocaine processor
exports[TargetName]:AddTargetModel(`ig_avon`, {options = {{event = 'boii-cocaine:client:CocaineMenu',icon = Config.Lang.Targeting.Cocaine['processoricon'],label = Config.Lang.Targeting.Cocaine['cocaineprocessorlabel'],},},distance = 1.5})
-- Crack processor
exports[TargetName]:AddTargetModel(`ig_stretch`, {options = {{event = 'boii-cocaine:client:CrackMenu',icon = Config.Lang.Targeting.Cocaine['processoricon'],label = Config.Lang.Targeting.Cocaine['crackprocessorlabel'],},},distance = 1.5})
--  Thread to spawn peds from Config.Peds
Citizen.CreateThread(function()
    for _,v in pairs(Config.Peds) do
        RequestModel(GetHashKey(v[7]))
        while not HasModelLoaded(GetHashKey(v[7])) do
            Wait(1)
        end
        CocainePed = CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
        SetEntityHeading(CocainePed, v[5])
        FreezeEntityPosition(CocainePed, true)
        SetEntityInvincible(CocainePed, true)
        SetBlockingOfNonTemporaryEvents(CocainePed, true)
        TaskStartScenarioInPlace(CocainePed, 'WORLD_HUMAN_SMOKING', 0, true) -- Change animation here 
    end
end)
--<!>-- PED STUFF END --<!>--

--<!>-- BLIPS START --<!>-- 
if Config.UseBlips then
    Citizen.CreateThread(function()
        for _, info in pairs(Config.Blips) do
            info.blip = AddBlipForCoord(info.x, info.y, info.z)
            SetBlipSprite(info.blip, info.id)
            SetBlipDisplay(info.blip, 4)
            SetBlipScale(info.blip, info.scale)
            SetBlipColour(info.blip, info.colour)
            SetBlipAsShortRange(info.blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(info.title)
            EndTextCommandSetBlipName(info.blip)
        end
    end)
end
--<!>-- BLIPS END --<!>--

--<!>-- DRUGS TARGETING START --<!>--
-- Opium Plants
exports[TargetName]:AddTargetModel(CocaPlant, {options = {{event = 'boii-cocaine:client:HarvestCoca',icon = Config.Lang.Targeting.Cocaine['cocaicon'],label = Config.Lang.Targeting.Cocaine['cocalabel'],},},distance = 1.5})
-- Illegal Gasoline
exports[TargetName]:AddTargetModel(GasolineProp, {options = {{event = 'boii-cocaine:client:CollectGasoline',icon = Config.Lang.Targeting.Cocaine['gasolineicon'],label = Config.Lang.Targeting.Cocaine['gasolinelabel'],item = GasolineCollectItem,},},distance = 2.0})
-- Benzocaine carts
exports[TargetName]:AddTargetModel(CartProp, {options = {{event = 'boii-cocaine:client:SearchCart',icon = Config.Lang.Targeting.Cocaine['carticon'],label = Config.Lang.Targeting.Cocaine['cartlabel']},},distance = 2.0})
-- Building Materials
exports[TargetName]:AddTargetModel(BuildingMatsProp, {options = {{event = 'boii-cocaine:client:SearchBuildingMaterials',icon = Config.Lang.Targeting.Cocaine['matsicon'],label = Config.Lang.Targeting.Cocaine['matslabel']},},distance = 2.0})
--<!>-- DRUGS TARGETING END --<!>--

--<!>-- COCAINE PROCESSING MENU START --<!>--
-- Main menu
RegisterNetEvent('boii-cocaine:client:CocaineMenu', function()
	local CocaineMenu = {
		{
			header = Config.Lang.Processing.Cocaine.Cocaine['processorcocaineheader'],
			txt = Config.Lang.Processing.Cocaine.Cocaine['processorcocaineheadertext'],
			icon = Config.Lang.Processing.Cocaine.Cocaine['processorcocaineheadericon'],
			isMenuHeader = true
		},
		{
			header = Config.Lang.Processing.Cocaine.Cocaine['processingcocaineheader'],
			txt = Config.Lang.Processing.Cocaine.Cocaine['processingcocaineheadertext'],
			icon = Config.Lang.Processing.Cocaine.Cocaine['processingcocaineheadericon'],
			params = {
				event = 'boii-cocaine:server:ProcessDrugs', -- Do not edit this
				isServer = true, -- Do not edit this
				args = 1, -- Do not edit this
			}
		},
		{
			header = Config.Lang.Stores.Cocaine.BlackMarket['blackmarketheader'],
			txt = Config.Lang.Stores.Cocaine.BlackMarket['blackmarketheadertext'],
			icon = Config.Lang.Stores.Cocaine.BlackMarket['blackmarketheadericon'],
			params = {
				event = 'boii-cocaine:client:OpenShops', -- Do not edit this
				args = 1, -- Do not edit this
			}
		}, -- Add more choices here
		{
			header = Config.Lang.Shared['exitmenu'],
			icon = Config.Lang.Shared['exitmenuicon'],
			params = {
				event = 'boii-cocaine:client:StopMenu'
			}
		}
	}
    if Config.Processing.Cocaine.Cocaine.UseTimes == true then
        if GetClockHours() >= Config.Processing.Cocaine.Cocaine.StartTime and GetClockHours() <= Config.Processing.Cocaine.Cocaine.EndTime then
            exports[MenuName]:openMenu(CocaineMenu)
        else
            TriggerEvent('boii-cocaine:notifications', Config.Lang.Processing.Cocaine.Cocaine['processorclosed'], 'error')
        end
    elseif Config.Processing.Cocaine.Cocaine.UseTimes == false then
		exports[MenuName]:openMenu(CocaineMenu)
	end
end)
--<!>-- COCAINE PROCESSING MENU END --<!>--

--<!>-- CRACK PROCESSING MENU START --<!>--
-- Main menu
RegisterNetEvent('boii-cocaine:client:CrackMenu', function()
	local CrackMenu = {
		{
			header = Config.Lang.Processing.Cocaine.Crack['processorcrackheader'],
			txt = Config.Lang.Processing.Cocaine.Crack['processorcrackheadertext'],
			icon = Config.Lang.Processing.Cocaine.Crack['processorcrackheadericon'],
			isMenuHeader = true
		},
		{
			header = Config.Lang.Processing.Cocaine.Crack['processingcrackheader'],
			txt = Config.Lang.Processing.Cocaine.Crack['processingcrackheadertext'],
			icon = Config.Lang.Processing.Cocaine.Crack['processingcrackheadericon'],
			params = {
				event = 'boii-cocaine:server:ProcessDrugs', -- Do not edit this
				isServer = true, -- Do not edit this
				args = 2, -- Do not edit this
			}
		},
		{
			header = Config.Lang.Stores.Cocaine.BlackMarket['blackmarketheader'],
			txt = Config.Lang.Stores.Cocaine.BlackMarket['blackmarketheadertext'],
			icon = Config.Lang.Stores.Cocaine.BlackMarket['blackmarketheadericon'],
			params = {
				event = 'boii-cocaine:client:OpenShops', -- Do not edit this
				args = 1, -- Do not edit this
			}
		}, -- Add more choices here
		{
			header = Config.Lang.Shared['exitmenu'],
			icon = Config.Lang.Shared['exitmenuicon'],
			params = {
				event = 'boii-cocaine:client:StopMenu'
			}
		}
	}
    if Config.Processing.Cocaine.Crack.UseTimes == true then
        if GetClockHours() >= Config.Processing.Cocaine.Crack.StartTime and GetClockHours() <= Config.Processing.Cocaine.Crack.EndTime then
            exports[MenuName]:openMenu(CrackMenu)
        else
            TriggerEvent('boii-cocaine:notifications', Config.Lang.Processing.Cocaine.Crack['processorclosed'], 'error')
        end
    elseif Config.Processing.Cocaine.Crack.UseTimes == false then
		exports[MenuName]:openMenu(CrackMenu)
	end
end)
--<!>-- CRACK PROCESSING MENU END --<!>--

--<!>-- OPEN STORES START --<!>--
RegisterNetEvent('boii-cocaine:client:OpenShops', function(args)
    args = tonumber(args)
    ShopItems = {}
    ShopItems.label = ''
    ShopItems.items = ''
    ShopItems.slots = ''
    lang = ''
    if args == 1 then
        ShopItems.label = Config.Lang.Stores.Cocaine.BlackMarket['blackmarketstorelabel']
		ShopItems.items = Config.Stores.Cocaine.BlackMarket.BlackMarketItems
		ShopItems.slots = #Config.Stores.Cocaine.BlackMarket.BlackMarketItems
		lang = 'BlackMarket_' 
    end -- You can define separate stores for each ped here for example; add a new store with elseif args == 2 then, create a new item table within config and update menus accordingly
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', lang, ShopItems)
end)
--<!>-- OPEN STORES END --<!>--

--<!>-- CUTTING KIT MENU START --<!>--
--[[RegisterNetEvent('boii-cocaine:client:DrugCuttingMenu', function()
	local DrugCuttingMenu = {
		{
			header = Config.Lang.DrugCutting.Shared['cuttingheader'],
			txt = Config.Lang.DrugCutting.Shared['cuttingheadertext'],
            icon = Config.Lang.DrugCutting.Shared['cuttingheadericon'],
			isMenuHeader = true
		},
		--[[{
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

--<!>-- CUTTING KIT COCAINE MENU START --<!>--
RegisterNetEvent('boii-cocaine:client:DrugCuttingMenu2', function(args)
	local args = tonumber(args)
	if args == 3 then
		exports[MenuName]:openMenu({
			{
				header = Config.Lang.DrugCutting.Shared['cuttingheader'],
				txt = Config.Lang.DrugCutting.Shared['cuttingheadertext'],
				icon = Config.Lang.DrugCutting.Shared['cuttingheadericon'],
				isMenuHeader = true
			},
			{
				header = Config.Lang.DrugCutting.Cocaine.Cocaine['cutcokeheader'],
				txt = Config.Lang.DrugCutting.Cocaine.Cocaine['cutcokeheadertext'],
				icon = Config.Lang.DrugCutting.Cocaine.Cocaine['cutcokeheadericon'],
				params = {
					event = 'boii-cocaine:server:CutDrugs',
					isServer = true,
					args = 1
				}				
			},
			{
				header = Config.Lang.Shared['returnmenu'],
				icon = Config.Lang.Shared['returnmenuicon'],
				params = {
					event = 'boii-cocaine:client:DrugCuttingMenu',
				}
			}
		})
	elseif args == 4 then
		exports[MenuName]:openMenu({
			{
				header = Config.Lang.DrugCutting.Shared['cuttingheader'],
				txt = Config.Lang.DrugCutting.Shared['cuttingheadertext'],
				icon = Config.Lang.DrugCutting.Shared['cuttingheadericon'],
				isMenuHeader = true
			},
			{
				header = Config.Lang.DrugCutting.Cocaine.Crack['cutcrackheader'],
				txt = Config.Lang.DrugCutting.Cocaine.Crack['cutcrackheadertext'],
				icon = Config.Lang.DrugCutting.Cocaine.Crack['cutcrackheadericon'],
				params = {
					event = 'boii-cocaine:server:CutDrugs',
					isServer = true,
					args = 2
				}				
			},
			{
				header = Config.Lang.Shared['returnmenu'],
				icon = Config.Lang.Shared['returnmenuicon'],
				params = {
					event = 'boii-cocaine:client:DrugCuttingMenu',
				}
			}
		})
	end
end)
--<!>-- CUTTING KIT COCAINE MENU END --<!>--

--<!>-- CUT DRUGS START --<!>--
RegisterNetEvent('boii-cocaine:client:CutDrugs', function(args)
    local pData = Core.Functions.GetPlayerData()
    local DrugXP = pData.metadata[MetaDataName]
    local args = tonumber(args)
    if Config.XP.UseXP == true then
        if args == 1 then
            barname = 'cut_coke'
            lang = Config.Lang.DrugCutting.Cocaine.Cocaine['cutcoke']
            lang2 = Config.Lang.DrugCutting.Cocaine.Cocaine['cutcokexp']
            processtime = Config.DrugCutting.Cocaine.Cocaine.CuttingTime
            drug = ''
            drugamount = ''
            druganimdict = Config.DrugCutting.Cocaine.Cocaine.AnimationDict
            druganim = Config.DrugCutting.Cocaine.Cocaine.Animation
            if DrugXP < 1500 then -- Level 16; Edit XP here to match config!
                drug = Config.DrugCutting.Cocaine.Cocaine.ReturnItem['1'].name
                drugamount = Config.DrugCutting.Cocaine.Cocaine.ReturnItem['1'].amount
            elseif DrugXP >= 1500 then -- Level 16; Edit XP here to match config!
                drug = Config.DrugCutting.Cocaine.Cocaine.ReturnItem['2'].name
                drugamount = Config.DrugCutting.Cocaine.Cocaine.ReturnItem['2'].amount
            elseif DrugXP >= 1600 then -- Level 17; Edit XP here to match config!
                drug = Config.DrugCutting.Cocaine.Cocaine.ReturnItem['3'].name
                drugamount = Config.DrugCutting.Cocaine.Cocaine.ReturnItem['3'].amount
            elseif DrugXP >= 1700 then -- Level 18; Edit XP here to match config!
                drug = Config.DrugCutting.Cocaine.Cocaine.ReturnItem['4'].name
                drugamount = Config.DrugCutting.Cocaine.Cocaine.ReturnItem['4'].amount
            elseif DrugXP >= 1800 then -- Level 19; Edit XP here to match config!
                drug = Config.DrugCutting.Cocaine.Cocaine.ReturnItem['5'].name
                drugamount = Config.DrugCutting.Cocaine.Cocaine.ReturnItem['5'].amount
            end
        elseif args == 2 then
            barname = 'cut_crack'
            lang = Config.Lang.DrugCutting.Cocaine.Crack['cutcrack']
            lang2 = Config.Lang.DrugCutting.Cocaine.Crack['cutcrackxp']
            processtime = Config.DrugCutting.Cocaine.Crack.CuttingTime
            drug = ''
            drugamount = ''
            druganimdict = Config.DrugCutting.Cocaine.Crack.AnimationDict
            druganim = Config.DrugCutting.Cocaine.Crack.Animation
            if DrugXP < 1100 then -- Level 11; Edit XP here to match config!
                drug = Config.DrugCutting.Cocaine.Crack.ReturnItem['1'].name
                drugamount = Config.DrugCutting.Cocaine.Crack.ReturnItem['1'].amount
            elseif DrugXP >= 1100 then -- Level 12; Edit XP here to match config!
                drug = Config.DrugCutting.Cocaine.Crack.ReturnItem['2'].name
                drugamount = Config.DrugCutting.Cocaine.Crack.ReturnItem['2'].amount
            elseif DrugXP >= 1200 then -- Level 13; Edit XP here to match config!
                drug = Config.DrugCutting.Cocaine.Crack.ReturnItem['3'].name
                drugamount = Config.DrugCutting.Cocaine.Crack.ReturnItem['3'].amount
            elseif DrugXP >= 1300 then -- Level 14; Edit XP here to match config!
                drug = Config.DrugCutting.Cocaine.Crack.ReturnItem['4'].name
                drugamount = Config.DrugCutting.Cocaine.Crack.ReturnItem['4'].amount
            elseif DrugXP >= 1400 then -- Level 15; Edit XP here to match config!
                drug = Config.DrugCutting.Cocaine.Crack.ReturnItem['5'].name
                drugamount = Config.DrugCutting.Cocaine.Crack.ReturnItem['5'].amount               
            end
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
            TriggerServerEvent('boii-cocaine:server:XP', 1)
            TriggerServerEvent(AddItemEvent, drug, drugamount)
            TriggerEvent('inventory:client:ItemBox', Core.Shared.Items[drug], 'add', drugamount)
            TriggerEvent('boii-cocaine:notifications', lang2, 'success')
        end, function() -- Cancel
            TriggerEvent('inventory:client:busy:status', false)
            TriggerEvent('boii-cocaine:notifications', Config.Lang.Shared['cancelled'], 'primary')
        end) 
    elseif Config.XP.UseXP == false then
        if args == 1 then
            barname = 'cut_coke'
            lang = Config.Lang.DrugCutting.Cocaine.Cocaine['cutcoke']
            lang2 = Config.Lang.DrugCutting.Cocaine.Cocaine['cutcokenoxp']
            processtime = Config.DrugCutting.Cocaine.Cocaine.CuttingTime
            drug = Config.DrugCutting.Cocaine.Cocaine.ReturnItem['5'].name
            drugamount = Config.DrugCutting.Cocaine.Cocaine.ReturnItem['5'].amount
            druganimdict = Config.DrugCutting.Cocaine.Cocaine.AnimationDict
            druganim = Config.DrugCutting.Cocaine.Cocaine.Animation
        elseif args == 2 then
            barname = 'cut_crack'
            lang = Config.Lang.DrugCutting.Cocaine.Crack['cutcrack']
            lang2 = Config.Lang.DrugCutting.Cocaine.Crack['cutcracknoxp']
            processtime = Config.DrugCutting.Cocaine.Crack.CuttingTime
            drug = Config.DrugCutting.Cocaine.Crack.ReturnItem['5'].name
            drugamount = Config.DrugCutting.Cocaine.Crack.ReturnItem['5'].amount
            druganimdict = Config.DrugCutting.Cocaine.Crack.AnimationDict
            druganim = Config.DrugCutting.Cocaine.Crack.Animation
        end
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
            TriggerEvent('animations:client:EmoteCommandStart', {"point"})
            Wait(200)
            TriggerServerEvent(AddItemEvent, drug, drugamount)
            TriggerEvent('inventory:client:ItemBox', Core.Shared.Items[drug], 'add', drugamount)
			TriggerEvent('boii-cocaine:notifications', lang2, 'success')
            ClearPedTasks(player)
        end, function() -- Cancel
            TriggerEvent('inventory:client:busy:status', false)
            TriggerClientEvent('boii-cocaine:notifications', Config.Lang.Shared['cancelled'], 'primary')
            ClearPedTasks(player)
        end)
    end
end)
--<!>-- CUT DRUGS END --<!>--

--<!>-- POLICE ALERTS START --<!>--
-- Used to trigger alerts from server/locked code side
RegisterNetEvent('boii-cocaine:client:AlertPolice', function()
	Wait(10)
	AlertPolice()
end)
-- Function to alert police
function AlertPolice(coords)
    if Core.Functions.GetPlayerData().job.name == Config.PoliceJob then -- You can edit this to add more jobs for example; if Core.Functions.GetPlayerData().job.name == Config.PoliceJob or Core.Functions.GetPlayerData().job.name == Config.PoliceJob2 then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local alpha = 250 -- Change blip alpha here
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip,  161) -- Change blip here
		SetBlipColour(Blip,  1) -- Change blip colour here
		SetBlipScale(Blip , 1.5) -- Change blip scale here
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Config.Lang.Alerts.Cocaine['bliptext'])
        EndTextCommandSetBlipName(Blip)
        TriggerServerEvent('boii-cocaine:server:PoliceNotification')
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
RegisterNetEvent('boii-cocaine:client:PoliceNotification', function(player)
	if Core.Functions.GetPlayerData().job.name == Config.PoliceJob then -- You can edit this to add more jobs for example; if Core.Functions.GetPlayerData().job.name == Config.PoliceJob or Core.Functions.GetPlayerData().job.name == Config.PoliceJob2 then
		TriggerEvent('boii-cocaine:notifications', Config.Lang.Alerts.Cocaine['policenotif'], 'police')
	end
end)
--<!>-- POLICE ALERTS END --<!>--