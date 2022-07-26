----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local TargetName = Config.CoreSettings.TargetName
local MenuName = Config.CoreSettings.MenuName
local CoolDown = false
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- NOTIFICATIONS START --<!>--
RegisterNetEvent('boii-drugsales:notifications')
AddEventHandler('boii-drugsales:notifications', function(msg, type)
    Core.Functions.Notify(msg,type)
end)
--<!>-- NOTIFICATIONS END --<!>--

--<!>-- PED STUFF START --<!>--
exports[TargetName]:AddTargetModel(`a_m_y_stwhi_01`, {options = {{event = 'boii-drugsales:client:MakeDelivery',icon = Config.Lang.Targeting['offerdrugsicon'],label = Config.Lang.Targeting['offerdrugslabel'],},},distance = 1.5})
-- Bulk dealer targeting
exports[TargetName]:AddTargetModel(`cs_martinmadrazo`, {options = {{event = 'boii-drugsales:client:BulkSellingMenu',icon = Config.Lang.Targeting['bulkdealericon'],label = Config.Lang.Targeting['bulkdealerlabel'],},},distance = 1.5})
--<!>-- PED STUFF END --<!>--

--<!>-- BURNER PHONE MENU START --<!>--
RegisterNetEvent('boii-drugsales:client:ToggleSellingMenu', function()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)
    local ToggleSellingMenu = {
        {
            header = Config.Lang.DrugSales.Menus['phoneheader'],
            txt = Config.Lang.DrugSales.Menus['phoneheadertext'],
            icon = Config.Lang.DrugSales.Menus['phoneheadericon'],
            isMenuHeader = true
        },
        {
            header = Config.Lang.DrugSales.Menus['streetsellingheader'],
            icon = Config.Lang.DrugSales.Menus['streetsellingheadericon'],
            params = {
                event = 'boii-drugsales:client:ToggleStreetSelling', -- Do not edit this
            }
        },--[[
        {
            header = Config.Lang.DrugSales.Menus['deliveriesheader'],
            icon = Config.Lang.DrugSales.Menus['deliveriesheadericon'],
            params = {
                event = 'boii-drugsales:client:ToggleDeliveries', -- Do not edit this
            }
        }, -- Add more choices here--]]
        {
            header = Config.Lang.Shared['exitmenu'],
            icon = Config.Lang.Shared['exitmenuicon'],
            params = {
                event = 'boii-drugsales:client:StopMenu'
            }
        }
    }
    exports[MenuName]:openMenu(ToggleSellingMenu)
end)
--<!>-- BURNER PHONE MENU END --<!>--

--<!>-- BULK SELLING MAIN MENU START --<!>--
RegisterNetEvent('boii-drugsales:client:BulkSellingMenu', function()
    local BulkBuyerMenu = {
        {
            header = Config.Lang.DrugSales.BulkSelling['bulkbuyerheader'],
            txt = Config.Lang.DrugSales.BulkSelling['bulkbuyerheadertext'],
            icon = Config.Lang.DrugSales.BulkSelling['bulkbuyerheadericon'],
            isMenuHeader = true,
        },
        {
            header = Config.Lang.DrugSales.BulkSelling['bulkbuyerbagsheader'],
            txt = Config.Lang.DrugSales.BulkSelling['bulkbuyerbagsheadertext'],
            icon = Config.Lang.DrugSales.BulkSelling['bulkbuyerbagsheadericon'],
            params = {
                event = 'boii-drugsales:client:BulkSellDrugsMenu',
                args = 1,
            }
        },
        {
            header = Config.Lang.DrugSales.BulkSelling['bulkbuyerouncesheader'],
            txt = Config.Lang.DrugSales.BulkSelling['bulkbuyerouncesheadertext'],
            icon = Config.Lang.DrugSales.BulkSelling['bulkbuyerouncesheadericon'],
            params = {
                event = 'boii-drugsales:client:BulkSellDrugsMenu',
                args = 2,
            }
        },
        {
            header = Config.Lang.DrugSales.BlackMarket['blackmarketheader'],
            txt = Config.Lang.DrugSales.BlackMarket['blackmarketheadertext'],
            icon = Config.Lang.DrugSales.BlackMarket['blackmarketheadericon'],
            params = {
                event = 'boii-drugsales:client:OpenBlackMarket', -- Do not edit this
            }
        },
        {
            header = Config.Lang.Shared['exitmenu'],
            icon = Config.Lang.Shared['exitmenuicon'],
            params = {
                event = 'boii-drugsales:client:StopMenu'
            }
        }
    }
    if Config.DrugSales.BulkSelling.UseTimes == true then
        if GetClockHours() >= Config.DrugSales.BulkSelling.StartTime and GetClockHours() <= Config.DrugSales.BulkSelling.EndTime then 
            exports[MenuName]:openMenu(BulkBuyerMenu)
        else 
            TriggerEvent('boii-drugsales:notifications', Config.Lang.DrugSales.BulkSelling['timer'], 'error')
        end
    else
        exports[MenuName]:openMenu(BulkBuyerMenu)
    end 
end)
--<!>-- BULK SELLING MAIN MENU END --<!>--

--<!>-- BULK SELLING DRUGS MENU START --<!>--
RegisterNetEvent('boii-drugsales:client:BulkSellDrugsMenu', function(args)
    local args = tonumber(args)
    local BulkBagsMenu = {
        {
            header = Config.Lang.DrugSales.BulkSelling['bulkbuyerheader'],
            txt = Config.Lang.DrugSales.BulkSelling['bulkbuyerheadertext'],
            icon = Config.Lang.DrugSales.BulkSelling['bulkbuyerheadericon'],
            isMenuHeader = true,
        },
        {
            header = 'Skunk: 2g',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Bags['weed_skunk']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellBags',
                isServer = true,
                args = 1, -- Match the args to your server side
            }
        },
        {
            header = 'OG-Kush: 2g',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Bags['weed_og-kush']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellBags',
                isServer = true,
                args = 2, -- Match the args to your server side
            }
        },
        {
            header = 'White-Widow: 2g',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Bags['weed_white-widow']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellBags',
                isServer = true,
                args = 3, -- Match the args to your server side
            }
        },
        {
            header = 'AK47: 2g',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Bags['weed_ak47']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellBags',
                isServer = true,
                args = 4, -- Match the args to your server side
            }
        },
        {
            header = 'Amnesia: 2g',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Bags['weed_amnesia']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellBags',
                isServer = true,
                args = 5, -- Match the args to your server side
            }
        },
        {
            header = 'Purple-Haze: 2g',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Bags['weed_purple-haze']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellBags',
                isServer = true,
                args = 6, -- Match the args to your server side
            }
        },
        {
            header = 'Heroin: 1g',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Bags['heroinbaggy']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellBags',
                isServer = true,
                args = 7, -- Match the args to your server side
            }
        },
        {
            header = 'Morphine Vial',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Bags['morphine']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellBags',
                isServer = true,
                args = 8, -- Match the args to your server side
            }
        },
        {
            header = 'Liquid Heroin',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Bags['liquidheroin']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellBags',
                isServer = true,
                args = 9, -- Match the args to your server side
            }
        },
        {
            header = 'Crack: 1g',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Bags['crack_baggy']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellBags',
                isServer = true,
                args = 10, -- Match the args to your server side
            }
        },
        {
            header = 'Meth: 1g',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Bags['meth']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellBags',
                isServer = true,
                args = 11, -- Match the args to your server side
            }
        },
        {
            header = 'Cocaine: 1g',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Bags['cokebaggy']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellBags',
                isServer = true,
                args = 12, -- Match the args to your server side
            }
        },
        {
            header = Config.Lang.Shared['returnmenu'],
            icon = Config.Lang.Shared['returnmenuicon'],
            params = {
                event = 'boii-drugsales:client:BulkSellingMenu'
            }
        }
    }
    local BulkOunceMenu = {
        {
            header = Config.Lang.DrugSales.BulkSelling['bulkbuyerheader'],
            txt = Config.Lang.DrugSales.BulkSelling['bulkbuyerheadertext'],
            icon = Config.Lang.DrugSales.BulkSelling['bulkbuyerheadericon'],
            isMenuHeader = true,
        },
        {
            header = 'Heroin: 1oz',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Ounces['heroin_1oz']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellOunces',
                isServer = true,
                args = 1, -- Match the args to your server side
            }
        },
        {
            header = 'Crack: 1oz',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Ounces['crack_1oz']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellOunces',
                isServer = true,
                args = 2, -- Match the args to your server side
            }
        },
        {
            header = 'Meth: 1oz',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Ounces['meth_1oz']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellOunces',
                isServer = true,
                args = 3, -- Match the args to your server side
            }
        },
        {
            header = 'Cocaine: 1oz',
            txt = 'Price: $'..Config.DrugSales.BulkSelling.Drugs.Ounces['coke_1oz']..' each',
            icon = 'fa-solid fa-cannabis',
            params = {
                event = 'boii-drugsales:server:BulkSellOunces',
                isServer = true,
                args = 4, -- Match the args to your server side
            }
        },
        {
            header = Config.Lang.Shared['returnmenu'],
            icon = Config.Lang.Shared['returnmenuicon'],
            params = {
                event = 'boii-drugsales:client:BulkSellingMenu'
            }
        }
    } 
    if args == 1 then
        exports[MenuName]:openMenu(BulkBagsMenu)
    elseif args == 2 then
        exports[MenuName]:openMenu(BulkOunceMenu)
    end 
end)
--<!>-- BULK SELLING DRUGS MENU END --<!>--

--<!>-- OPEN STORES START --<!>--
RegisterNetEvent('boii-drugsales:client:OpenBlackMarket', function()
    ShopItems = {}
    ShopItems.label = Config.Lang.DrugSales.BlackMarket['blackmarketstorelabel']
	ShopItems.items = Config.DrugSales.BulkSelling.BlackMarket.BlackMarketItems
	ShopItems.slots = #Config.DrugSales.BulkSelling.BlackMarket.BlackMarketItems
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'BlackMarket_', ShopItems)
end)
--<!>-- OPEN STORES END --<!>--

--<!>-- POLICE ALERTS START --<!>--
RegisterNetEvent('boii-drugsales:client:TriggerPoliceAlert', function()
    Wait(00)
    AlertPolice()
end)
function AlertPolice(coords)
    if Core.Functions.GetPlayerData().job.name == 'police' then -- You can edit this to add more jobs for example; if Core.Functions.GetPlayerData().job.name == Config.PoliceJob or Core.Functions.GetPlayerData().job.name == Config.PoliceJob2 then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local alpha = 250 -- Change blip alpha here
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip,  161) -- Change blip here
		SetBlipColour(Blip,  1) -- Change blip colour here
		SetBlipScale(Blip , 1.5) -- Change blip scale here
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Config.Lang.Alerts.Selling['bliptext'])
        EndTextCommandSetBlipName(Blip)
        TriggerServerEvent('boii-drugsales:server:PoliceNotification')
        while alpha ~= 0 do
            Wait(30*4) -- Change blip alpha tick here
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
RegisterNetEvent('boii-drugsales:client:PoliceNotification', function(player)
	if Core.Functions.GetPlayerData().job.name == 'police' then -- You can edit this to add more jobs for example; if Core.Functions.GetPlayerData().job.name == Config.PoliceJob or Core.Functions.GetPlayerData().job.name == Config.PoliceJob2 then
		TriggerEvent('boii-drugsales:notifications', Config.Lang.Alerts.Selling['policenotif'], 'police')
	end
end)
--<!>-- POLICE ALERTS END --<!>--
