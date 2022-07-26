-------------------------------
---------- CASE#1933 ----------
-------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.Core
local CoreFolder = Config.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local TargetName = Config.TargetName
local MenuName = Config.MenuName
local AddItemEvent = Config.AddItemEvent
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- NOTIFICATIONS CODE START --<!>--
RegisterNetEvent('boii-pawnshop:notifications')
AddEventHandler('boii-pawnshop:notifications', function(msg, type)
    -- You can add custom notifcation types here
    Core.Functions.Notify(msg,type)
end)
--<!>-- NOTIFICATIONS CODE END --<!>--

--<!>-- SPAWN PEDS START --<!>--
local PawnshopPeds = {
    {-265.71, 235.88, 89.57,'Pawn Shop',65.7,0x45918E44,'cs_molly'}, -- Pawnshop ped
    --{-657.4, -859.03, 23.49,'Digital Den',357.24,0x6BD9B68C,'a_m_m_hasjew_01'}, -- Digital den ped
    --{-111.09, -6.6, 69.52,'Gold Buyer',219.95,0xE497BBEF,'s_m_y_dealer_01'}, -- Gold buyer ped
}
CreateThread(function()
    for _,v in pairs(PawnshopPeds) do
        RequestModel(GetHashKey(v[7]))
        while not HasModelLoaded(GetHashKey(v[7])) do
            Wait(1)
        end
        PawnPed = CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
        SetEntityHeading(PawnPed, v[5])
        FreezeEntityPosition(PawnPed, true)
        SetEntityInvincible(PawnPed, true)
        SetBlockingOfNonTemporaryEvents(PawnPed, true)
        TaskStartScenarioInPlace(PawnPed, 'WORLD_HUMAN_SMOKING', 0, true) 
    end
end)
--<!>-- SPAWN PEDS END --<!>--

--<!>-- TARGETING START --<!>--
-- Pawnshop ped 
exports[TargetName]:AddTargetModel(`cs_molly`, {options = {{event = 'boii-pawnshop:client:PawnshopMainMenu',icon = Config.Lang['pawnshopicon'],label = Config.Lang['pawnshoplabel']},},distance = 2.5 })
-- Digital den ped 
--exports[TargetName]:AddTargetModel(`a_m_m_hasjew_01`, {options = {{event = 'boii-pawnshop:client:DigitalMainMenu',icon = Config.Lang['digitaldenicon'],label = Config.Lang['digitaldenlabel']},},distance = 2.5 })
-- Gold buyer ped
--exports[TargetName]:AddTargetModel(`s_m_y_dealer_01`, {options = {{event = 'boii-pawnshop:client:GoldBuyMainMenu',icon = Config.Lang['goldbuyicon'],label = Config.Lang['goldbuylabel'],},},distance = 2.0})
-- Smelting zone
exports[TargetName]:AddBoxZone('pawn_smelting', vector3(1086.16, -2004.0, 31.37), 6.0, 6.0, {name='pawn_smelting',heading=139.50,debugPoly=false,minZ=30.55,maxZ=34.55}, {options = {{event = 'boii-pawnshop:client:SmeltingMenu',icon = Config.Lang['goldsmelticon'], label = Config.Lang['goldsmeltlabel'],},},distance = 6.0})
--<!>-- TARGETING END --<!>--

--<!>-- PAWNSHOP MENU START --<!>--
-- Main menu
RegisterNetEvent('boii-pawnshop:client:PawnshopMainMenu', function()
    if Config.PawnShopTimes then
        if GetClockHours() >= Config.PawnOpenTime and GetClockHours() <= Config.PawnCloseTime then
            exports[MenuName]:openMenu({
                {
                    header = Config.Lang['pawnshopheader'],
                    txt = Config.Lang['pawnshopheadertext'],
                    isMenuHeader = true
                },
                {
                    header = Config.Lang['pawnsellheader'],
                    txt = Config.Lang['pawnsellheadertext'],
                    params = {
                        event = 'boii-pawnshop:client:PawnshopOptionsMenu',
                    }
                },
                {
                    header = Config.Lang['pawnstoreheader'],
                    txt = Config.Lang['pawnstoreheadertext'],
                    params = {
                        event = 'boii-pawnshop:client:OpenShops', -- Do not edit this
                        args = 1, -- Do not edit this
                    }
                }, -- Add more choices here
                {
                    header = Config.Lang['exitmenu'],
                    params = {
                        event = 'boii-pawnshop:client:StopMenu'
                    }
                },
            })
        else
            TriggerEvent('boii-pawnshop:notifications', Config.Lang['pawnshopclosed'], 'error')
        end
        exports[MenuName]:openMenu()
    end
end)
-- Options menu
RegisterNetEvent('boii-pawnshop:client:PawnshopOptionsMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['pawnshopheader'],
            txt = Config.Lang['pawnshopheadertext'],
            isMenuHeader = true
        },
        {
            header = Config.Lang['materialsellheader'],
            txt = Config.Lang['materialsellheadertext'],
            params = {
                event = 'boii-pawnshop:client:SellMaterialsMenu',
            }
        },
		{
            header = Config.Lang['gemsellheader'],
            txt = Config.Lang['gemsellheadertext'],
            params = {
                event = 'boii-pawnshop:client:SellGemsMenu',
            }
        },
		{
            header = Config.Lang['jewellerysellheader'],
            txt = Config.Lang['jewellerysellheadertext'],
            params = {
                event = 'boii-pawnshop:client:SellJewelleryMenu',
            }
        }, -- Add more choices here
        {
            header = Config.Lang['returnmenu'],
            params = {
                event = 'boii-pawnshop:client:PawnshopMainMenu'
            }
        },
    })
end)
-- Sell materials menu
RegisterNetEvent('boii-pawnshop:client:SellMaterialsMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['materialsellheader'],
            txt = Config.Lang['materialsellheadertext'],
            isMenuHeader = true
        },
        {
            header = Config.Lang['metalscrapheader'],
            txt = Config.Lang['metalscrapheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 1
            }
        },
        {
            header = Config.Lang['ironheader'],
            txt = Config.Lang['ironheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 2
            }
        },
        {
            header = Config.Lang['steelheader'],
            txt = Config.Lang['steelheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 3
            }
        },
		{
            header = Config.Lang['aluminumheader'],
            txt = Config.Lang['aluminumheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 4
            }
        },
		{
            header = Config.Lang['copperheader'],
            txt = Config.Lang['copperheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 5
            }
        },
		{
            header = Config.Lang['plasticheader'],
            txt = Config.Lang['plasticheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 6
            }
        },
		{
            header = Config.Lang['rubberheader'],
            txt = Config.Lang['rubberheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 7
            }
        }, -- Add more choices here
		{
            header = Config.Lang['returnmenu'],
            params = {
                event = 'boii-pawnshop:client:PawnshopOptionsMenu'
            }
        },
    })
end)
-- Sell gems menu
RegisterNetEvent('boii-pawnshop:client:SellGemsMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['gemsellheader'],
            txt = Config.Lang['gemsellheadertext'],
            isMenuHeader = true
        },
		{
            header = Config.Lang['diamondheader'],
            txt = Config.Lang['diamondheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 8
            }
        },
		{
            header = Config.Lang['goldheader'],
            txt = Config.Lang['goldheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 18
            }
        },
		{
            header = Config.Lang['emeraldheader'],
            txt = Config.Lang['emeraldheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 19
            }
        },
		{
            header = Config.Lang['rubyheader'],
            txt = Config.Lang['rubyheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 20
            }
        },
		{
            header = Config.Lang['opalheader'],
            txt = Config.Lang['opalheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 21
            }
        },
		{
            header = Config.Lang['bdheader'],
            txt = Config.Lang['bdheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 22
            }
        },
		{
            header = Config.Lang['pdheader'],
            txt = Config.Lang['pdheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 23
            }
        },
		{
            header = Config.Lang['sapphireheader'],
            txt = Config.Lang['sapphireheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 24
            }
        },	-- Add more choices here	
		{
            header = Config.Lang['goldbarheader'],
            txt = Config.Lang['goldbarheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 25
            }
        },
		{
            header = Config.Lang['returnmenu'],
            params = {
                event = 'boii-pawnshop:client:PawnshopOptionsMenu'
            }
        },
    })
end)
-- Sell jewellery menu 
RegisterNetEvent('boii-pawnshop:client:SellJewelleryMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['jewellerysellheader'],
            txt = Config.Lang['jewellerysellheadertext'],
            isMenuHeader = true
        },
        {
            header = Config.Lang['goldchainheader'],
            txt = Config.Lang['goldchainheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 9
            }
        },
		{
            header = Config.Lang['rolexheader'],
            txt = Config.Lang['rolexheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 10
            }
        },
		{
            header = Config.Lang['10kgoldchainheader'],
            txt = Config.Lang['10kgoldchainheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 11
            }
        },
		{
            header = Config.Lang['diamondringheader'],
            txt = Config.Lang['diamondringheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 12
            }
        },-- Add more choices here
		{
            header = Config.Lang['returnmenu'],
            params = {
                event = 'boii-pawnshop:client:PawnshopOptionsMenu'
            }
        },
    })
end)

--<!>-- DIGITAL DEN MENU START --<!>--
-- Main menu
RegisterNetEvent('boii-pawnshop:client:DigitalMainMenu', function()
    if Config.DigitalDenTimes then
        if GetClockHours() >= Config.DigitalOpenTime and GetClockHours() <= Config.DigitalCloseTime then
            exports[MenuName]:openMenu({
                {
                    header = Config.Lang['digitalheader'],
                    txt = Config.Lang['digitalheadertext'],
                    isMenuHeader = true
                },
                {
                    header = Config.Lang['digitalsellheader'],
                    txt = Config.Lang['digitalsellheadertext'],
                    params = {
                        event = 'boii-pawnshop:client:DigitalSellMenu',
                    }
                },
                {
                    header = Config.Lang['digitalstoreheader'],
                    txt = Config.Lang['digitalstoreheadertext'],
                    params = {
                        event = 'boii-pawnshop:client:OpenShops', -- Do not edit this
                        args = 2, -- Do not edit this
                    }
                }, -- Add more choices here
                {
                    header = Config.Lang['exitmenu'],
                    params = {
                        event = 'boii-pawnshop:client:StopMenu'
                    }
                },
            })
        else
            TriggerEvent('boii-pawnshop:notifications', Config.Lang['pawnshopclosed'], 'error')
        end
        exports[MenuName]:openMenu()
    end
end)
-- Sell items menu 
RegisterNetEvent('boii-pawnshop:client:DigitalSellMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['digitalsellheader'],
            txt = Config.Lang['digitalsellheadertext'],
            isMenuHeader = true
        },
        {
            header = Config.Lang['tabletheader'],
            txt = Config.Lang['tabletheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 13
            }
        },
		{
            header = Config.Lang['iphoneheader'],
            txt = Config.Lang['iphoneheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 14
            }
        },
		{
            header = Config.Lang['samsungheader'],
            txt = Config.Lang['samsungheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 15
            }
        },
		{
            header = Config.Lang['laptopheader'],
            txt = Config.Lang['laptopheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 16
            }
        }, -- Add more choices here
		{

            header = Config.Lang['returnmenu'],
            params = {
                event = 'boii-pawnshop:client:hardwareshopMenu'
            }
        },
    })
end)
--<!>-- DIGITAL DEN MENU END --<!>--

--<!>-- GOLD BUYER MENU START --<!>--
-- Main menu
RegisterNetEvent('boii-pawnshop:client:GoldBuyMainMenu', function()
    if Config.GoldBuyTimes then
        if GetClockHours() >= Config.GoldOpenTime and GetClockHours() <= Config.GoldCloseTime then
            exports[MenuName]:openMenu({
                {
                    header = Config.Lang['goldbuyheader'],
                    txt = Config.Lang['goldbuyheadertext'],
                    isMenuHeader = true
                },
                {
                    header = Config.Lang['goldbuysellheader'],
                    txt = Config.Lang['goldbuysellheadertext'],
                    params = {
                        event = 'boii-pawnshop:client:GoldSellMenu',
                    }
                },
                {
                    header = Config.Lang['goldbuystoreheader'],
                    txt = Config.Lang['goldbuystoreheadertext'],
                    params = {
                        event = 'boii-pawnshop:client:OpenShops', -- Do not edit this
                        args = 3, -- Do not edit this
                    }
                }, -- Add more choices here
                {
                    header = Config.Lang['exitmenu'],
                    params = {
                        event = 'boii-pawnshop:client:StopMenu'
                    }
                },
            })
        else
            TriggerEvent('boii-pawnshop:notifications', Config.Lang['goldbuyclosed'], 'error')
        end
        exports[MenuName]:openMenu()
    end
end)
-- Sell items menu 
RegisterNetEvent('boii-pawnshop:client:GoldSellMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['goldbuysellheader'],
            txt = Config.Lang['goldbuysellheadertext'],
            isMenuHeader = true
        },
        {
            header = Config.Lang['goldbarheader'],
            txt = Config.Lang['goldbarheadertext'],
            params = {
                event = 'boii-pawnshop:server:SellItems',
                isServer = true,
                args = 17
            }
        }, -- Add more choices here
		{

            header = Config.Lang['returnmenu'],
            params = {
                event = 'boii-pawnshop:client:GoldBuyMainMenu'
            }
        },
    })
end)
--<!>-- GOLD BUYER MENU END --<!>--

--<!>-- GOLD SMELTING MENU START --<!>--
RegisterNetEvent('boii-pawnshop:client:SmeltingMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['goldsmeltheader'],
            txt = Config.Lang['goldsmeltheadertext'],
            isMenuHeader = true
        },
        {
            header = Config.Lang['rolexsmeltheader'],
            txt = Config.Lang['rolexsmeltheadertext'],
            params = {
                event = 'boii-pawnshop:server:SmeltItems',
                isServer = true,
                args = 1
            }
        },
        {
            header = Config.Lang['chainsmeltheader'],
            txt = Config.Lang['chainsmeltheadertext'],
            params = {
                event = 'boii-pawnshop:server:SmeltItems',
                isServer = true,
                args = 2
            }
        }, 
        {
            header = Config.Lang['10kchainsmeltheader'],
            txt = Config.Lang['10kchainsmeltheadertext'],
            params = {
                event = 'boii-pawnshop:server:SmeltItems',
                isServer = true,
                args = 3
            }
        }, -- Add more choices here
		{
            header = Config.Lang['exitmenu'],
            params = {
                event = 'boii-pawnshop:client:StopMenu'
            }
        },
    })
end)

RegisterNetEvent('boii-pawnshop:client:SmeltItems', function(args)
    local args = tonumber(args)
    local GoldReturn = Config.GoldBarReturn
    barname = ''
    lang = ''
    if args == 1 then 
        barname = 'smelt_rolex'
        lang = 'smeltrolex'
    elseif args == 2 then 
        barname = 'smelt_chain'
        lang = 'smeltchain'
    elseif args == 3 then 
        barname = 'smelt_10kchain'
        lang = 'smelt10kchain'
    end
    Core.Functions.Progressbar(barname, Config.Lang[lang], Config.SmeltingTime, false, true, {
        disableMovement = true, 
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_movie_bulb@base',
        anim = 'base',
        flags = 49,
    }, {}, {}, function()  
        TriggerServerEvent(AddItemEvent, 'goldbar', GoldReturn)
        TriggerEvent('inventory:client:ItemBox', Core.Shared.Items['goldbar'], 'add')
    end, function() -- Cancel
        TriggerEvent('inventory:client:busy:status', false)
        TriggerClientEvent('boii-pawnshop:notifications', Config.Lang['cancelled'], 'primary')
    end)
end)
