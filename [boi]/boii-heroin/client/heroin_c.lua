----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local TargetName = Config.CoreSettings.TargetName
local MenuName = Config.CoreSettings.MenuName
local MetaDataEvent = Config.CoreSettings.MetaDataEvent
local MetaDataName = Config.XP.MetaDataName
local AddItemEvent = Config.CoreSettings.AddItemEvent
local OpiPlant = Config.DrugMaterials.Heroin.Opium.Prop
local HydroProp = Config.DrugMaterials.Shared.Hydrochloric.Prop
local HydroCollectItem = Config.DrugMaterials.Shared.Hydrochloric.CollectItem
local EtherProp = Config.DrugMaterials.Heroin.Ether.Prop
local EtherCollectItem = Config.DrugMaterials.Heroin.Ether.CollectItem
local BuildingMatsProp = Config.DrugMaterials.Shared.ConstructionSite.Prop
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- NOTIFICATIONS CODE START --<!>--
-- Notification event
RegisterNetEvent('boii-heroin:notifications')
AddEventHandler('boii-heroin:notifications', function(msg, type)
	-- You can replace if not using qb-core built in notifications
    Core.Functions.Notify(msg,type)
end)
--<!>-- NOTIFICATIONS CODE END --<!>--

--<!>-- PED STUFF START --<!>--
-- Pharmacist
exports[TargetName]:AddTargetModel(`s_m_m_doctor_01`, {options = {{event = 'boii-heroin:client:PharmacyMainMenu',icon = Config.Lang.Targeting.Heroin['pharmacyicon'],label = Config.Lang.Targeting.Heroin['pharmacylabel'],},},distance = 1.5})
-- Morphine processor
exports[TargetName]:AddTargetModel(`u_m_m_willyfist`, {options = {{event = 'boii-heroin:client:MorphineMainMenu',icon = Config.Lang.Targeting.Heroin['processoricon'],label = Config.Lang.Targeting.Heroin['morphineprocessorlabel'],},},distance = 1.5})
-- Heroin base processor
exports[TargetName]:AddTargetModel(`ig_terry`, {options = {{event = 'boii-heroin:client:HeroinBaseMenu',icon = Config.Lang.Targeting.Heroin['processoricon'],label = Config.Lang.Targeting.Heroin['heroinbaseprocessorlabel'],},},distance = 1.5})
-- Heroin processor
exports[TargetName]:AddTargetModel(`ig_ashley`, {options = {{event = 'boii-heroin:client:HeroinMenu',icon = Config.Lang.Targeting.Heroin['processoricon'],label = Config.Lang.Targeting.Heroin['heroinprocessorlabel'],},},distance = 1.5})
--  Thread to spawn peds from Config.Peds
Citizen.CreateThread(function()
    for _,v in pairs(Config.Peds) do
        RequestModel(GetHashKey(v[7]))
        while not HasModelLoaded(GetHashKey(v[7])) do
            Wait(1)
        end
        HeroinPed = CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
        SetEntityHeading(HeroinPed, v[5])
        FreezeEntityPosition(HeroinPed, true)
        SetEntityInvincible(HeroinPed, true)
        SetBlockingOfNonTemporaryEvents(HeroinPed, true)
        TaskStartScenarioInPlace(HeroinPed, 'WORLD_HUMAN_SMOKING', 0, true) -- Change animation here 
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

--<!>-- MORPHINE PROCESSING MENU CODE START --<!>--
-- Main menu
RegisterNetEvent('boii-heroin:client:MorphineMainMenu', function()
	local MorphineMainMenu = {
		{
			header = Config.Lang.Processing.Heroin.Morphine['processormorphineheader'],
			txt = Config.Lang.Processing.Heroin.Morphine['processormoprphineheadertext'],
			icon = Config.Lang.Processing.Heroin.Morphine['processormorphineheadericon'],
			isMenuHeader = true
		},
		{
			header = Config.Lang.Processing.Heroin.Morphine['processingmorphineheader'],
			txt = Config.Lang.Processing.Heroin.Morphine['processingmorphineheadertext'],
			icon = Config.Lang.Processing.Heroin.Morphine['processingmorphineheadericon'],
			params = {
				event = 'boii-heroin:server:ProcessDrugs', -- Do not edit this
				isServer = true, -- Do not edit this
				args = 1, -- Do not edit this
			}
		},
		{
			header = Config.Lang.Stores.Heroin.BlackMarket['blackmarketheader'],
			txt = Config.Lang.Stores.Heroin.BlackMarket['blackmarketheadertext'],
			icon = Config.Lang.Stores.Heroin.BlackMarket['blackmarketheadericon'],
			params = {
				event = 'boii-heroin:client:OpenShops', -- Do not edit this
				args = 2, -- Do not edit this
			}
		}, -- Add more choices here
		{
			header = Config.Lang.Shared['exitmenu'],
			params = {
				event = 'boii-heroin:client:StopMenu'
			}
		}
	}
    if Config.Processing.Heroin.Morphine.UseTimes == true then
        if GetClockHours() >= Config.Processing.Heroin.Morphine.StartTime and GetClockHours() <= Config.Processing.Heroin.Morphine.EndTime then
            exports[MenuName]:openMenu(MorphineMainMenu)
        else
            TriggerEvent('boii-heroin:notifications', Config.Lang.Processing.Heroin.Morphine['processorclosed'], 'error')
        end
    elseif Config.Processing.Heroin.Morphine.UseTimes == false then
		exports[MenuName]:openMenu(MorphineMainMenu)
	end
end)
--<!>-- HEROIN MORPHINE MENU END --<!>--

--<!>-- HEROIN PROCESSING MENU CODE START --<!>--
-- Main menu
RegisterNetEvent('boii-heroin:client:HeroinBaseMenu', function()
	local HeroinBaseMenu = {
		{
			header = Config.Lang.Processing.Heroin.HeroinBase['processorheroinbaseheader'],
			txt = Config.Lang.Processing.Heroin.HeroinBase['processorheroinbaseheadertext'],
			icon = Config.Lang.Processing.Heroin.HeroinBase['processorheroinbaseheadericon'],
			isMenuHeader = true
		},
		{
			header = Config.Lang.Processing.Heroin.HeroinBase['processingheroinbaseheader'],
			txt = Config.Lang.Processing.Heroin.HeroinBase['processingheroinbaseheadertext'],
			icon = Config.Lang.Processing.Heroin.HeroinBase['processingheroinbaseheadericon'],
			params = {
				event = 'boii-heroin:server:ProcessDrugs', -- Do not edit this
				isServer = true, -- Do not edit this
				args = 2, -- Do not edit this
			}
		},
		{
			header = Config.Lang.Stores.Heroin.BlackMarket['blackmarketheader'],
			txt = Config.Lang.Stores.Heroin.BlackMarket['blackmarketheadertext'],
			icon = Config.Lang.Stores.Heroin.BlackMarket['blackmarketheadericon'],
			params = {
				event = 'boii-heroin:client:OpenShops', -- Do not edit this
				args = 2, -- Do not edit this unless you have created a custom store refer to line 269 for notes
			}
		}, -- Add more choices here
		{
			header = Config.Lang.Shared['exitmenu'],
			params = {
				event = 'boii-heroin:client:StopMenu'
			}
		}
	}
    if Config.Processing.Heroin.HeroinBase.UseTimes == true then
        if GetClockHours() >= Config.Processing.Heroin.HeroinBase.StartTime and GetClockHours() <= Config.Processing.Heroin.HeroinBase.EndTime then
            exports[MenuName]:openMenu(HeroinBaseMenu)
        else
            TriggerEvent('boii-heroin:notifications', Config.Lang.Processing.Heroin.HeroinBase['processorclosed'], 'error')
        end
    elseif Config.Processing.Heroin.HeroinBase.UseTimes == false then
		exports[MenuName]:openMenu(HeroinBaseMenu)
	end
end)
--<!>-- HEROIN PROCESSING MENU END --<!>--

--<!>-- HEROIN PROCESSING MENU CODE START --<!>--
-- Main menu
RegisterNetEvent('boii-heroin:client:HeroinMenu', function()
	local HeroinMenu = {
		{
			header = Config.Lang.Processing.Heroin.Heroin['processorheroinheader'],
			txt = Config.Lang.Processing.Heroin.Heroin['processorheroinheadertext'],
			icon = Config.Lang.Processing.Heroin.Heroin['processorheroinheadericon'],
			isMenuHeader = true
		},
		{
			header = Config.Lang.Processing.Heroin.Heroin['processingheroinheader'],
			txt = Config.Lang.Processing.Heroin.Heroin['processingheroinheadertext'],
			icon = Config.Lang.Processing.Heroin.Heroin['processingheroinheadericon'],
			params = {
				event = 'boii-heroin:server:ProcessDrugs', -- Do not edit this
				isServer = true,
				args = 3,
			}
		},
		{
			header = Config.Lang.Stores.Heroin.BlackMarket['blackmarketheader'],
			txt = Config.Lang.Stores.Heroin.BlackMarket['blackmarketheadertext'],
			icon = Config.Lang.Stores.Heroin.BlackMarket['blackmarketheadericon'],
			params = {
				event = 'boii-heroin:client:OpenShops', -- Do not edit this
				args = 2, -- Do not edit this unless you have created a custom store refer to line 269 for notes
			}
		}, -- Add more choices here
		{
			header = Config.Lang.Shared['exitmenu'],
			icon = Config.Lang.Shared['exitmenuicon'],
			params = {
				event = 'boii-heroin:client:StopMenu'
			}
		}
	}
    if Config.Processing.Heroin.Heroin.UseTimes == true then
        if GetClockHours() >= Config.Processing.Heroin.Heroin.StartTime and GetClockHours() <= Config.Processing.Heroin.Heroin.EndTime then
            exports[MenuName]:openMenu(HeroinMenu)
        else
            TriggerEvent('boii-heroin:notifications', Config.Lang.Processing.Heroin.Heroin['processorclosed'], 'error')
        end
    elseif Config.Processing.Heroin.Heroin.UseTimes == false then
		exports[MenuName]:openMenu(HeroinMenu)
	end
end)
--<!>-- HEROIN PROCESSING MENU END --<!>--

--<!>-- PHARMACY MENU START --<!>--
-- Main menu
RegisterNetEvent('boii-heroin:client:PharmacyMainMenu', function()
	local PharmacyMenu = {
		{
			header = Config.Lang.Stores.Heroin.Pharmacy['pharmacyheader'],
			txt = Config.Lang.Stores.Heroin.Pharmacy['pharmacyheadertext'],
			icon = Config.Lang.Stores.Heroin.Pharmacy['pharmacyheadericon'],
			isMenuHeader = true
		},
		{
			header = Config.Lang.Stores.Heroin.Pharmacy['pharmacystoreheader'],
			txt = Config.Lang.Stores.Heroin.Pharmacy['pharmacystoreheadertext'],
			icon = Config.Lang.Stores.Heroin.Pharmacy['pharmacystoreheadericon'],
			params = {
				event = 'boii-heroin:client:OpenShops', -- Do not edit this
				args = 1, -- Do not edit this
			}
		}, -- Add more choices here
		{
			header = Config.Lang.Shared['exitmenu'],
			icon = Config.Lang.Shared['exitmenuicon'],
			params = {
				event = 'boii-heroin:client:StopMenu'
			}
		}
	}
    if Config.Stores.Heroin.Pharmacy.UseTimes == true then
        if GetClockHours() >= Config.Stores.Heroin.Pharmacy.OpenTime and GetClockHours() <= Config.Stores.Heroin.Pharmacy.CloseTime then
            exports[MenuName]:openMenu(PharmacyMenu)
        else
            TriggerEvent('boii-heroin:notifications', Config.Lang.Stores.Heroin.Pharmacy['pharmacyclosed'], 'error')
        end
    elseif Config.Stores.Heroin.Pharmacy.UseTimes == false then
		exports[MenuName]:openMenu(PharmacyMenu)
	end
end)
--<!>-- PHARMACY MENU END --<!>--

--<!>-- OPEN STORES START --<!>--
RegisterNetEvent('boii-heroin:client:OpenShops', function(args)
    args = tonumber(args)
    ShopItems = {}
    ShopItems.label = ''
    ShopItems.items = ''
    ShopItems.slots = ''
    lang = ''
    if args == 1 then
        ShopItems.label = Config.Lang.Stores.Heroin.Pharmacy['pharmacystorelabel']
        ShopItems.items = Config.Stores.Heroin.Pharmacy.PharmacyItems
        ShopItems.slots = #Config.Stores.Heroin.Pharmacy.PharmacyItems
        lang = 'Pharmacist_'
	elseif args == 2 then
		ShopItems.label = Config.Lang.Stores.Heroin.BlackMarket['blackmarketstorelabel']
		ShopItems.items = Config.Stores.Heroin.BlackMarket.BlackMarketItems
		ShopItems.slots = #Config.Stores.Heroin.BlackMarket.BlackMarketItems
		lang = 'BlackMarket_' 
    end -- You can define separate stores for each ped here for example; add a new store with elseif args == 3 then, create a new item table within config and update menus accordingly
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', lang, ShopItems)
end)
--<!>-- OPEN STORES END --<!>--

--<!>-- DRUGS TARGETING START --<!>--
-- Opium Plants
exports[TargetName]:AddTargetModel(OpiPlant, {options = {{event = 'boii-heroin:client:HarvestOpium',icon = Config.Lang.Targeting.Heroin['opiumicon'],label = Config.Lang.Targeting.Heroin['opiumlabel'],},},distance = 1.5})
-- Hydrochloric Acid
exports[TargetName]:AddTargetModel(HydroProp, {options = {{event = 'boii-heroin:client:CollectHydro',icon = Config.Lang.Targeting.Heroin['hydroicon'],label = Config.Lang.Targeting.Heroin['hydrolabel'],item = HydroCollectItem,},},distance = 2.0})
-- Petroleum Ether
exports[TargetName]:AddTargetModel(EtherProp, {options = {{event = 'boii-heroin:client:CollectEther',icon = Config.Lang.Targeting.Heroin['ethericon'],label = Config.Lang.Targeting.Heroin['etherlabel'],item = EtherCollectItem,},},distance = 2.0})
-- Building Materials
exports[TargetName]:AddTargetModel(BuildingMatsProp, {options = {{event = 'boii-heroin:client:SearchBuildingMaterials',icon = Config.Lang.Targeting.Heroin['matsicon'],label = Config.Lang.Targeting.Heroin['matslabel']},},distance = 2.0})
--<!>-- DRUGS TARGETING END --<!>--

--<!>-- CUTTING KIT MENU START --<!>--
RegisterNetEvent('boii-heroin:client:DrugCuttingMenu', function()
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
end)
--<!>-- CUTTING KIT MENU END--<!>--

--<!>-- DRUGS CUTTING MENU START --<!>--
RegisterNetEvent('boii-heroin:client:DrugCuttingMenu2', function(args)
	local args = tonumber(args)
	if args == 1 then
		exports[MenuName]:openMenu({
			{
				header = Config.Lang.DrugCutting.Shared['cuttingheader'],
				txt = Config.Lang.DrugCutting.Shared['cuttingheadertext'],
				icon = Config.Lang.DrugCutting.Shared['cuttingheadericon'],
				isMenuHeader = true
			},
			{
				header = Config.Lang.DrugCutting.Heroin.Morphine['cutmorphineheader'],
				txt = Config.Lang.DrugCutting.Heroin.Morphine['cutmorphineheadertext'],
				icon = Config.Lang.DrugCutting.Heroin.Morphine['cutmorphineheadericon'],
				params = {
					event = 'boii-heroin:server:CutDrugs',
					isServer = true,
					args = 1
				}				
			},
			{
				header = Config.Lang.Shared['returnmenu'],
				icon = Config.Lang.Shared['returnmenuicon'],
				params = {
					event = 'boii-heroin:client:DrugCuttingMenu',
				}
			}
		})
	elseif args == 2 then
		exports[MenuName]:openMenu({
			{
				header = Config.Lang.DrugCutting.Shared['cuttingheader'],
				txt = Config.Lang.DrugCutting.Shared['cuttingheadertext'],
				icon = Config.Lang.DrugCutting.Shared['cuttingheadericon'],
				isMenuHeader = true
			},
			{
				header = Config.Lang.DrugCutting.Heroin.Heroin['cutheroinheader'],
				txt = Config.Lang.DrugCutting.Heroin.Heroin['cutheroinheadertext'],
				icon = Config.Lang.DrugCutting.Heroin.Heroin['cutheroinheadericon'],
				params = {
					event = 'boii-heroin:server:CutDrugs',
					isServer = true,
					args = 2
				}				
			},
			{
				header = Config.Lang.Shared['returnmenu'],
				icon = Config.Lang.Shared['returnmenuicon'],
				params = {
					event = 'boii-heroin:client:DrugCuttingMenu',
				}
			}
		})
	end
end)
--<!>-- DRUGS CUTTING MENU END --<!>--

--<!>-- CUT DRUGS START --<!>--
RegisterNetEvent('boii-heroin:client:CutDrugs', function(args)
    local pData = Core.Functions.GetPlayerData()
    local DrugXP = pData.metadata[MetaDataName]
    local args = tonumber(args)
    if Config.XP.UseXP == true then
        if args == 1 then
            barname = 'cut_morphine'
            lang = Config.Lang.DrugCutting.Heroin.Morphine['cutmorphine']
            lang2 = Config.Lang.DrugCutting.Heroin.Morphine['cutmorphinexp']
            processtime = Config.DrugCutting.Heroin.Morphine.CuttingTime
            drug = ''
            drugamount = ''
            druganimdict = Config.DrugCutting.Heroin.Morphine.AnimationDict
            druganim = Config.DrugCutting.Heroin.Morphine.Animation
            if DrugXP < 800 then -- Level 9 match xp to your config
                drug = Config.DrugCutting.Heroin.Morphine.ReturnItem['1'].name
                drugamount = Config.DrugCutting.Heroin.Morphine.ReturnItem['1'].amount
            elseif DrugXP >= 800 then -- Level 9 match xp to your config
                drug = Config.DrugCutting.Heroin.Morphine.ReturnItem['2'].name
                drugamount = Config.DrugCutting.Heroin.Morphine.ReturnItem['2'].amount
            elseif DrugXP >= 900 then -- Level 10 match xp to your config
                drug = Config.DrugCutting.Heroin.Morphine.ReturnItem['3'].name
                drugamount = Config.DrugCutting.Heroin.Morphine.ReturnItem['3'].amount
            elseif DrugXP >= 1000 then -- Level 11 match xp to your config
                drug = Config.DrugCutting.Heroin.Morphine.ReturnItem['4'].name
                drugamount = Config.DrugCutting.Heroin.Morphine.ReturnItem['4'].amount
            elseif DrugXP >= 1100 then -- Level 12 match xp to your config
                drug = Config.DrugCutting.Heroin.Morphine.ReturnItem['5'].name
                drugamount = Config.DrugCutting.Heroin.Morphine.ReturnItem['5'].amount
            end
        elseif args == 2 then
            barname = 'cut_heroin'
            lang = Config.Lang.DrugCutting.Heroin.Heroin['cutheroin']
            lang2 = Config.Lang.DrugCutting.Heroin.Heroin['cutheroinxp']
            processtime = Config.DrugCutting.Heroin.Heroin.CuttingTime
            drug = ''
            drugamount = ''
            druganimdict = Config.DrugCutting.Heroin.Heroin.AnimationDict
            druganim = Config.DrugCutting.Heroin.Heroin.Animation
            if DrugXP < 1000 then -- Level 10 match xp to your config
                drug = Config.DrugCutting.Heroin.Heroin.ReturnItem['1'].name
                drugamount = Config.DrugCutting.Heroin.Heroin.ReturnItem['1'].amount
            elseif DrugXP >= 1000 then -- Level 11 match xp to your config
                drug = Config.DrugCutting.Heroin.Heroin.ReturnItem['2'].name
                drugamount = Config.DrugCutting.Heroin.Heroin.ReturnItem['2'].amount
            elseif DrugXP >= 1100 then -- Level 12 match xp to your config
                drug = Config.DrugCutting.Heroin.Heroin.ReturnItem['3'].name
                drugamount = Config.DrugCutting.Heroin.Heroin.ReturnItem['3'].amount
            elseif DrugXP >= 1200 then -- Level 13 match xp to your config
                drug = Config.DrugCutting.Heroin.Heroin.ReturnItem['4'].name
                drugamount = Config.DrugCutting.Heroin.Heroin.ReturnItem['4'].amount
            elseif DrugXP >= 1300 then -- Level 14 match xp to your config
                drug = Config.DrugCutting.Heroin.Heroin.ReturnItem['5'].name
                drugamount = Config.DrugCutting.Heroin.Heroin.ReturnItem['5'].amount               
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
            TriggerServerEvent('boii-heroin:server:XP', 1)
            TriggerServerEvent(AddItemEvent, drug, drugamount)
            TriggerEvent('inventory:client:ItemBox', Core.Shared.Items[drug], 'add', drugamount)
            TriggerEvent('boii-heroin:notifications', lang2, 'success')
        end, function() -- Cancel
            TriggerEvent('inventory:client:busy:status', false)
            TriggerEvent('boii-heroin:notifications', Config.Lang.Shared['cancelled'], 'primary')
        end) 
    elseif Config.XP.UseXP == false then
        if args == 1 then
            barname = 'cut_morphine'
            lang = Config.Lang.DrugCutting.Heroin.Morphine['cutmorphine']
            lang2 = Config.Lang.DrugCutting.Heroin.Morphine['cutmorphinenoxp']
            processtime = Config.DrugCutting.Heroin.Morphine.CuttingTime
            drug = Config.DrugCutting.Heroin.Morphine.ReturnItem['5'].name
            drugamount = Config.DrugCutting.Heroin.Morphine.ReturnItem['5'].amount
            druganimdict = Config.DrugCutting.Heroin.Morphine.AnimationDict
            druganim = Config.DrugCutting.Heroin.Morphine.Animation
        elseif args == 2 then
            barname = 'cut_heroin'
            lang = Config.Lang.DrugCutting.Heroin.Heroin['cutheroin']
            lang2 = Config.Lang.DrugCutting.Heroin.Heroin['cutheroinnoxp']
            processtime = Config.DrugCutting.Heroin.Heroin.CuttingTime
            drug = Config.DrugCutting.Heroin.Heroin.ReturnItem['5'].name
            drugamount = Config.DrugCutting.Heroin.Heroin.ReturnItem['5'].amount
            druganimdict = Config.DrugCutting.Heroin.Heroin.AnimationDict
            druganim = Config.DrugCutting.Heroin.Heroin.Animation
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
			TriggerEvent('boii-heroin:notifications', lang2, 'success')
            ClearPedTasks(player)
        end, function() -- Cancel
            TriggerEvent('inventory:client:busy:status', false)
            TriggerClientEvent('boii-heroin:notifications', Config.Lang.Shared['cancelled'], 'primary')
            ClearPedTasks(player)
        end)
    end
end)
--<!>-- CUT DRUGS END --<!>--

--<!>-- POLICE ALERTS START --<!>--
-- Used to trigger alerts from server/locked code side
RegisterNetEvent('boii-heroin:client:AlertPolice', function()
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
        AddTextComponentString(Config.Lang.Alerts.Heroin['bliptext'])
        EndTextCommandSetBlipName(Blip)
        TriggerServerEvent('boii-heroin:server:PoliceNotification')
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
RegisterNetEvent('boii-heroin:client:PoliceNotification', function(player)
	if Core.Functions.GetPlayerData().job.name == Config.PoliceJob then -- You can edit this to add more jobs for example; if Core.Functions.GetPlayerData().job.name == Config.PoliceJob or Core.Functions.GetPlayerData().job.name == Config.PoliceJob2 then
		TriggerEvent('boii-heroin:notifications', Config.Lang.Alerts.Heroin['policenotif'], 'police')
	end
end)
--<!>-- POLICE ALERTS END --<!>--