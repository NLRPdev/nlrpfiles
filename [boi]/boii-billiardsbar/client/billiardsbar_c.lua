-------------------------------
---------- CASE#2506 ----------
-------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.Core
local CoreFolder = Config.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local TargetName = Config.TargetName
local MenuName = Config.MenuName
local InputName = Config.InputName
local DutyEvent = Config.DutyEvent
local ItemCheckEvent = Config.ItemCheckEvent
local RemoveItemEvent = Config.RemoveItemEvent
local AddItemEvent = Config.AddItemEvent
local RemoveStress = Config.RemoveStress
local MetaDataEvent = Config.MetaDataEvent
local EvidenceEvent = Config.EvidenceEvent
local FuelEvent = Config.FuelEvent
local JobName = Config.JobName
local ClothingEvent = Config.ClothingEvent
local VehicleKeysEvent = Config.VehicleKeysEvent
local SnakeFoodItem = Config.SnakeFoodItem
local LightDrunkTime = Config.LightDrunkTime
local HeavyDrunkTime = Config.HeavyDrunkTime
local alcoholCount = 0
local AlcoholType = Config.Alcohol
local FoodType = Config.Food
local DrinkType = Config.Drink
local LightBeerAmount = Config.LightBeerAmount
local HeavyBeerAmount = Config.HeavyBeerAmount
local LightLiquorAmount = Config.LightLiquorAmount
local HeavyLiquorAmount = Config.HeavyLiquorAmount
local LightCocktailAmount = Config.LightCocktailAmount
local HeavyCocktailAmount = Config.HeavyCocktailAmount
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- BLIPS CODE START --<!>-- **COMMENT OUT THIS CODE OR MOVE THE FILE IN ORDER TO DISABLE BLIPS**
-- Creates blip for white widow store (uncomment to add the blip)
Citizen.CreateThread(function()
	for _, info in pairs(Config.Blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.6)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)
--<!>-- BLIPS CODE END --<!>-- **COMMENT OUT THIS CODE OR MOVE THE FILE IN ORDER TO DISABLE BLIPS**

--<!>-- PLAYER LOADED CODE START --<!>--
RegisterNetEvent('Core:Client:OnPlayerLoaded')
AddEventHandler('Core:Client:OnPlayerLoaded', function()
    Core.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == JobName then
                TriggerServerEvent(DutyEvent)
            end
        end
    end)
end)
RegisterNetEvent('Core:Client:OnJobUpdate')
AddEventHandler('Core:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)
RegisterNetEvent('boii-billiardsbar:client:ToggleDuty', function()
	onDuty = not onDuty
	TriggerServerEvent(DutyEvent)
end)
--<!>-- PLAYER LOADED CODE END --<!>-- 

--<!>-- ON DUTY MENU CODE START --<!>--
exports[TargetName]:AddBoxZone("bb_duty", Config.Duty, 2.0, 1.0, {
    name="bb_duty",
    heading=48.50,
    debugPoly=false,
    minZ=12.55,
    maxZ=14.55
    }, {
    options = {
        {
            event = "boii-billiardsbar:client:WhiteWidowDutyMenu",
            icon = Config.Lang['dutyicon'], 
            label = Config.Lang['dutylabel'],
			job = JobName,
        },
    },
    distance = 1.0
})
RegisterNetEvent('boii-billiardsbar:client:WhiteWidowDutyMenu', function(data)
    exports[MenuName]:openMenu({
        { 
            header = Config.Lang['dutymenuheader'],
            txt = Config.Lang['dutymenuheadertext'],
            isMenuHeader = true
        },
        { 
            header = Config.Lang['dutytoggle'],
            params = {
                event = "boii-billiardsbar:client:ToggleDuty",
            }
        },
        {
            header = Config.Lang['exitmenu'],
            params = { 
                event = "boii-billiardsbar:client:StopMenu"
            }
        },
    })
end)
--<!>-- ON DUTY MENU CODE END --<!>--

--<!>-- PULL PINTS CODE START --<!>--
exports[TargetName]:AddBoxZone("bb_pumps", Config.Pumps, 1.5, 1.0, {
    name="bb_pumps",
    heading=50.50,
    debugPoly=false,
    minZ=12.55,
    maxZ=14.55
    }, {
    options = {
        {
            event = "boii-billiardsbar:client:PumpsMenu",
            icon = Config.Lang['pumpicon'], 
            label = Config.Lang['pumplabel'],
			job = JobName,
        },
    },
    distance = 1.0
})
exports[TargetName]:AddBoxZone("bb_pumps2", Config.Pumps2, 1.5, 1.0, {
    name="bb_pumps2",
    heading=50.50,
    debugPoly=false,
    minZ=12.55,
    maxZ=14.55
    }, {
    options = {
        {
            event = "boii-billiardsbar:client:PumpsMenu2",
            icon = Config.Lang['pumpicon'], 
            label = Config.Lang['pumplabel'],
			job = JobName,
        },
    },
    distance = 1.0
})
exports[TargetName]:AddBoxZone("bb_pumps3", Config.Pumps3, 1.5, 1.0, {
    name="bb_pumps3",
    heading=50.50,
    debugPoly=false,
    minZ=12.55,
    maxZ=14.55
    }, {
    options = {
        {
            event = "boii-billiardsbar:client:PumpsMenu",
            icon = Config.Lang['pumpicon'], 
            label = Config.Lang['pumplabel'],
			job = JobName,
        },
    },
    distance = 1.0
})
RegisterNetEvent('boii-billiardsbar:client:PumpsMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['pumpmenuheader'],
            txt = Config.Lang['pumpmenuheadertext'],
            isMenuHeader = true
        },
        {
            header = Config.Lang['amheader'],
            txt = Config.Lang['amheadertext'],
            params = {
                event = "boii-billiardsbar:server:PullPint",
                isServer = true,
                args = 1
            }
        },
		{
            header = Config.Lang['pisheader'],
            txt = Config.Lang['pisheadertext'],
            params = {
                event = "boii-billiardsbar:server:PullPint",
                isServer = true,
                args = 2
            }
        },
		{
            header = Config.Lang['loggerheader'],
            txt = Config.Lang['loggerheadertext'],
            params = {
                event = "boii-billiardsbar:server:PullPint",
                isServer = true,
                args = 3
            }
        },
		{
            header = Config.Lang['duscheheader'],
            txt = Config.Lang['duscheheadertext'],
            params = {
                event = "boii-billiardsbar:server:PullPint",
                isServer = true,
                args = 4
            }
        },
        {
            header = Config.Lang['exitmenu'],
            params = {
                event = "boii-billiardsbar:client:StopMenu"
            }
        },
    })
end)
RegisterNetEvent('boii-billiardsbar:client:PumpsMenu2', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['pumpmenuheader'],
            txt = Config.Lang['pumpmenuheadertext'],
            isMenuHeader = true
        },
		{
            header = Config.Lang['loggerheader'],
            txt = Config.Lang['loggerheadertext'],
            params = {
                event = "boii-billiardsbar:server:PullPint",
                isServer = true,
                args = 3
            }
        },
        {
            header = Config.Lang['exitmenu'],
            params = {
                event = "boii-billiardsbar:client:StopMenu"
            }
        },
    })
end)
RegisterNetEvent("boii-billiardsbar:client:PullPint", function(args)
    local player = PlayerPedId()
    if args == 1 then
        Core.Functions.Progressbar("bb_pullambeer", Config.Lang['pullingpint'], Config.PullPintTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@world_human_drinking@beer@female@base",
            anim = "base",
        }, {
            model = "prop_pint_glass_tall",
            bone = 28422,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'pint_ambeer', 1)
	        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['pint_ambeer'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['pulledpint'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 2 then
        Core.Functions.Progressbar("bb_pullpiswasser", Config.Lang['pullingpint'], Config.PullPintTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@world_human_drinking@beer@female@base",
            anim = "base",
        }, {
            model = "prop_pint_glass_tall",
            bone = 28422,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'pint_piswasser', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['pint_piswasser'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['pulledpint'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 3 then
        Core.Functions.Progressbar("bb_pulllogger", Config.Lang['pullingpint'], Config.PullPintTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@world_human_drinking@beer@female@base",
            anim = "base",
        }, {
            model = "prop_pint_glass_tall",
            bone = 28422,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'pint_logger', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['pint_logger'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['pulledpint'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 4 then
        Core.Functions.Progressbar("bb_pulldusche", Config.Lang['pullingpint'], Config.PullPintTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@world_human_drinking@beer@female@base",
            anim = "base",
        }, {
            model = "prop_pint_glass_tall",
            bone = 28422,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'pint_dusche', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['pint_dusche'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['pulledpint'], 'success')
            ClearPedTasks(player)
        end)
    end    
end)
--<!>-- PULL PINTS CODE END --<!>--

--<!>-- COCKTAILS CODE START --<!>--
exports[TargetName]:AddBoxZone("bb_cocktails", Config.Cocktails, 1.2, 0.7, {
    name="bb_cocktails",
    heading=229.50,
    debugPoly=false,
    minZ=12.55,
    maxZ=14.55
    }, {
    options = {
        {
            event = "boii-billiardsbar:client:CocktailsMainMenu",
            icon = Config.Lang['cocktailsicon'], 
            label = Config.Lang['cocktailslabel'],
			job = JobName,
        },
    },
    distance = 1.0
})
RegisterNetEvent('boii-billiardsbar:client:CocktailsMainMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['cocktailsmenuheader'],
            txt = Config.Lang['cocktailsmenuheadertext'],
            isMenuHeader = true
        },
        {
            header = Config.Lang['cocktailswhiskeyheader'],
            txt = Config.Lang['cocktailswhiskeyheadertext'],
            params = {
                event = "boii-billiardsbar:client:CocktailsMenu",
                args = 1
            }
        },
        {
            header = Config.Lang['cocktailsrumheader'],
            txt = Config.Lang['cocktailsrumheadertext'],
            params = {
                event = "boii-billiardsbar:client:CocktailsMenu",
                args = 2
            }
        },
        {
            header = Config.Lang['cocktailsvodkaheader'],
            txt = Config.Lang['cocktailsvodkaheadertext'],
            params = {
                event = "boii-billiardsbar:client:CocktailsMenu",
                args = 3
            }
        },
        {
            header = Config.Lang['exitmenu'],
            params = {
                event = "boii-billiardsbar:client:StopMenu"
            }
        },
    })
end)
RegisterNetEvent('boii-billiardsbar:client:CocktailsMenu', function(args)
    if args == 1 then
        exports[MenuName]:openMenu({
            {
                header = Config.Lang['cocktailswhiskeyheader'],
                txt = Config.Lang['cocktailswhiskeyheadertext'],
                isMenuHeader = true
            },
            {
                header = Config.Lang['whiskeysourheader'],
                txt = Config.Lang['whiskeysourheadertext'],
                params = {
                    event = "boii-billiardsbar:server:MixCocktails",
                    isServer = true,
                    args = 1
                }
            },
            {
                header = Config.Lang['whiskeysmashheader'],
                txt = Config.Lang['whiskeysmashheadertext'],
                params = {
                    event = "boii-billiardsbar:server:MixCocktails",
                    isServer = true,
                    args = 2
                }
            },
            {
                header = Config.Lang['bloodsandheader'],
                txt = Config.Lang['bloodsandheadertext'],
                params = {
                    event = "boii-billiardsbar:server:MixCocktails",
                    isServer = true,
                    args = 3
                }
            },
            {
                header = Config.Lang['returnmenu'],
                params = {
                    event = "boii-billiardsbar:client:CocktailsMainMenu"
                }
            },
        })
    elseif args == 2 then
        exports[MenuName]:openMenu({
            {
                header = Config.Lang['cocktailsrumheader'],
                txt = Config.Lang['cocktailsrumheadertext'],
                isMenuHeader = true
            },
            {
                header = Config.Lang['pinacoladaheader'],
                txt = Config.Lang['pinacoladaheadertext'],
                params = {
                    event = "boii-billiardsbar:server:MixCocktails",
                    isServer = true,
                    args = 4
                }
            },
            {
                header = Config.Lang['zombieheader'],
                txt = Config.Lang['zombieheadertext'],
                params = {
                    event = "boii-billiardsbar:server:MixCocktails",
                    isServer = true,
                    args = 5
                }
            },
            {
                header = Config.Lang['maitaiheader'],
                txt = Config.Lang['maitaiheadertext'],
                params = {
                    event = "boii-billiardsbar:server:MixCocktails",
                    isServer = true,
                    args = 6
                }
            },
            {
                header = Config.Lang['returnmenu'],
                params = {
                    event = "boii-billiardsbar:client:CocktailsMainMenu"
                }
            },
        })
    elseif args == 3 then
        exports[MenuName]:openMenu({
            {
                header = Config.Lang['cocktailsvodkaheader'],
                txt = Config.Lang['cocktailsvodkaheadertext'],
                isMenuHeader = true
            },
            {
                header = Config.Lang['appletiniheader'],
                txt = Config.Lang['appletiniheadertext'],
                params = {
                    event = "boii-billiardsbar:server:MixCocktails",
                    isServer = true,
                    args = 7
                }
            },
            {
                header = Config.Lang['cosmopolitanheader'],
                txt = Config.Lang['cosmopolitanheadertext'],
                params = {
                    event = "boii-billiardsbar:server:MixCocktails",
                    isServer = true,
                    args = 8
                }
            },
            {
                header = Config.Lang['bloodymaryheader'],
                txt = Config.Lang['bloodymaryheadertext'],
                params = {
                    event = "boii-billiardsbar:server:MixCocktails",
                    isServer = true,
                    args = 9
                }
            },
            {
                header = Config.Lang['returnmenu'],
                params = {
                    event = "boii-billiardsbar:client:CocktailsMainMenu"
                }
            },
        })
    end
end)
RegisterNetEvent("boii-billiardsbar:client:MixCocktails", function(args)
    local player = PlayerPedId()
    if args == 1 then
        Core.Functions.Progressbar("bb_cocktail_wsour", Config.Lang['mixcocktail'], Config.CocktailTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@bar@drink@one",
            anim = "one_bartender",
            flags = 8,
        }, {
            model = "prop_cocktail_glass",
            bone = 60309,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'whiskeysour', 1)
	        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['whiskeysour'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mixedcocktail'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 2 then
        Core.Functions.Progressbar("bb_cocktail_wsour", Config.Lang['mixcocktail'], Config.CocktailTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@bar@drink@one",
            anim = "one_bartender",
            flags = 8,
        }, {
            model = "prop_cocktail_glass",
            bone = 60309,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'whiskeysmash', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['whiskeysmash'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mixedcocktail'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 3 then
        Core.Functions.Progressbar("bb_cocktail_wsour", Config.Lang['mixcocktail'], Config.CocktailTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@bar@drink@one",
            anim = "one_bartender",
            flags = 8,
        }, {
            model = "prop_cocktail_glass",
            bone = 60309,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'bloodandsand', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['bloodandsand'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mixedcocktail'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 4 then
        Core.Functions.Progressbar("bb_cocktail_pcolada", Config.Lang['mixcocktail'], Config.CocktailTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@bar@drink@one",
            anim = "one_bartender",
            flags = 8,
        }, {
            model = "prop_shot_glass",
            bone = 60309,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'pinacolada', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['pinacolada'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mixedcocktail'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 5 then
        Core.Functions.Progressbar("bb_cocktail_zombie", Config.Lang['mixcocktail'], Config.CocktailTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@bar@drink@one",
            anim = "one_bartender",
            flags = 8,
        }, {
            model = "prop_cocktail_glass",
            bone = 60309,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'zombie', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['zombie'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mixedcocktail'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 6 then
        Core.Functions.Progressbar("bb_cocktail_maitai", Config.Lang['mixcocktail'], Config.CocktailTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@bar@drink@one",
            anim = "one_bartender",
            flags = 8,
        }, {
            model = "prop_cocktail_glass",
            bone = 60309,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'maitai', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['maitai'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mixedcocktail'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 7 then
        Core.Functions.Progressbar("bb_cocktail_appletini", Config.Lang['mixcocktail'], Config.CocktailTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@bar@drink@one",
            anim = "one_bartender",
            flags = 8,
        }, {
            model = "prop_cocktail_glass",
            bone = 60309,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'appletini', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['appletini'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mixedcocktail'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 8 then
        Core.Functions.Progressbar("bb_cocktail_cosmo", Config.Lang['mixcocktail'], Config.CocktailTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@bar@drink@one",
            anim = "one_bartender",
            flags = 8,
        }, {
            model = "prop_cocktail_glass",
            bone = 60309,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'cosmopolitan', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['cosmopolitan'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mixedcocktail'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 9 then
        Core.Functions.Progressbar("bb_cocktail_cosmo", Config.Lang['mixcocktail'], Config.CocktailTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@bar@drink@one",
            anim = "one_bartender",
            flags = 8,
        }, {
            model = "prop_cocktail_glass",
            bone = 60309,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'bloodymary', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['bloodymary'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mixedcocktail'], 'success')
            ClearPedTasks(player)
        end)
    end    
end)
--<!>-- COCKTAILS CODE END --<!>--

--<!>-- LIQOUR CODE START --<!>--
exports[TargetName]:AddBoxZone("bb_liquor", Config.Liquor, 1.2, 0.5, {
    name="bb_liquor",
    heading=228.50,
    debugPoly=false,
    minZ=12.55,
    maxZ=14.55
    }, {
    options = {
        {
            event = "boii-billiardsbar:client:LiquorMenu",
            icon = Config.Lang['liquoricon'], 
            label = Config.Lang['liquorlabel'],
			job = JobName,
        },
    },
    distance = 1.0
})
RegisterNetEvent('boii-billiardsbar:client:LiquorMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['liquormenuheader'],
            txt = Config.Lang['liquormenuheadertext'],
            isMenuHeader = true
        },
        {
            header = Config.Lang['whiskeyheader'],
            txt = Config.Lang['whiskeyheader'],
            params = {
                event = "boii-billiardsbar:server:PullLiquor",
                isServer = true,
                args = 1
            }
        },
		{
            header = Config.Lang['rumheader'],
            txt = Config.Lang['rumheader'],
            params = {
                event = "boii-billiardsbar:server:PullLiquor",
                isServer = true,
                args = 2
            }
        },
		{
            header = Config.Lang['vodkaheader'],
            txt = Config.Lang['vodkaheader'],
            params = {
                event = "boii-billiardsbar:server:PullLiquor",
                isServer = true,
                args = 3
            }
        },
        {
            header = Config.Lang['exitmenu'],
            params = {
                event = "boii-billiardsbar:client:StopMenu"
            }
        },
    })
end)
RegisterNetEvent("boii-billiardsbar:client:PullLiquor", function(args)
    local player = PlayerPedId()
    if args == 1 then
        Core.Functions.Progressbar("bb_pullwhiskey", Config.Lang['pullingliquor'], Config.PullLiquorTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@bar@drink@one",
            anim = "one_bartender",
            flags = 8,
        }, {
            model = "prop_shot_glass",
            bone = 28422,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'glass_whiskey', 1)
	        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['glass_whiskey'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['pulledliquor'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 2 then
        Core.Functions.Progressbar("bb_pullrum", Config.Lang['pullingliquor'], Config.PullLiquorTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@bar@drink@one",
            anim = "one_bartender",
            flags = 8,
        }, {
            model = "prop_shot_glass",
            bone = 28422,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'glass_rum', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['glass_rum'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['pulledliquor'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 3 then
        Core.Functions.Progressbar("bb_pullvodka", Config.Lang['pullingliquor'], Config.PullLiquorTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@bar@drink@one",
            anim = "one_bartender",
            flags = 8,
        }, {
            model = "prop_shot_glass",
            bone = 28422,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'glass_vodka', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['glass_vodka'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['pulledliquor'], 'success')
            ClearPedTasks(player)
        end)
    end    
end)
--<!>-- LIQUOR CODE END --<!>--

--<!>-- HOT DRINKS CODE START --<!>--
exports[TargetName]:AddBoxZone("bb_hotdrinks", Config.HotDrinks, 1.3, 0.7, {
    name="bb_hotdrinks",
    heading=229.50,
    debugPoly=false,
    minZ=12.55,
    maxZ=14.55
    }, {
    options = {
        {
            event = "boii-billiardsbar:client:HotDrinksMenu",
            icon = Config.Lang['hotdrinksicon'], 
            label = Config.Lang['hotdrinkslabel'],
			job = JobName,
        },
    },
    distance = 1.0
})
RegisterNetEvent('boii-billiardsbar:client:HotDrinksMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['hotdrinksmenuheader'], 
            txt = Config.Lang['hotdrinksmenuheadertext'], 
            isMenuHeader = true
        },
        {
            header = Config.Lang['coffeeheader'], 
            txt = Config.Lang['coffeeheadertext'],
            params = {
                event = "boii-billiardsbar:server:HotDrinks",
                isServer = true,
                args = 1
            }
        },
		{
            header = Config.Lang['teaheader'],
            txt = Config.Lang['teaheadertext'],
            params = {
                event = "boii-billiardsbar:server:HotDrinks",
                isServer = true,
                args = 2
            }
        },
        {
            header = Config.Lang['exitmenu'],
            params = {
                event = "boii-billiardsbar:client:StopMenu"
            }
        },
    })
end)
RegisterNetEvent("boii-billiardsbar:client:HotDrinks", function(args)
    local player = PlayerPedId()
    if args == 1 then
        Core.Functions.Progressbar("bb_makecoffee", Config.Lang['makehot'], Config.HotDrinksTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@world_human_drinking@beer@female@base",
            anim = "base",
        }, {
            model = "v_res_mcofcup",
            bone = 28422,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'cupcoffee', 1)
	        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['cupcoffee'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['madehot'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 2 then
        Core.Functions.Progressbar("bb_maketea", Config.Lang['makehot'], Config.HotDrinksTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@world_human_drinking@beer@female@base",
            anim = "base",
        }, {
            model = "v_res_mcofcup",
            bone = 28422,
            coords = vector3(-0.005, 0.00, 0.00),
            rotation = vector3(175.0, 160.0, 0.0),
        }, {}, function()
            TriggerServerEvent(AddItemEvent, 'cuptea', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['cuptea'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['madehot'], 'success')
            ClearPedTasks(player)
        end)
    end    
end)
--<!>-- HOT DRINKS CODE END --<!>--

--<!>-- MICROWAVE CODE START --<!>--
exports[TargetName]:AddBoxZone("bb_microwave", Config.Microwave, 1.2, 0.5, {
    name="bb_microwave",
    heading=229.50,
    debugPoly=false,
    minZ=12.55,
    maxZ=14.55
    }, {
    options = {
        {
            event = "boii-billiardsbar:client:MicrowaveMenu",
            icon = Config.Lang['microwaveicon'], 
            label = Config.Lang['microwavelabel'],
			job = JobName,
        },
    },
    distance = 1.0
})
RegisterNetEvent('boii-billiardsbar:client:MicrowaveMenu', function()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['microwavemenuheader'],
            txt = Config.Lang['microwavemenuheadertext'],
            isMenuHeader = true
        },
		{
            header = Config.Lang['cheesepieheader'],
            txt = Config.Lang['cheesepieheadertext'],
            params = {
                event = "boii-billiardsbar:server:MicrowaveFood",
                isServer = true,
                args = 1
            }
        },
		{
            header = Config.Lang['meatpieheader'],
            txt = Config.Lang['meatpieheadertext'],
            params = {
                event = "boii-billiardsbar:server:MicrowaveFood",
                isServer = true,
                args = 2
            }
        },
		{
            header = Config.Lang['steakpieheader'],
            txt = Config.Lang['steakpieheadertext'],
            params = {
                event = "boii-billiardsbar:server:MicrowaveFood",
                isServer = true,
                args = 3
            }
        },
		{
            header = Config.Lang['chickenpieheader'],
            txt = Config.Lang['chickenpieheadertext'],
            params = {
                event = "boii-billiardsbar:server:MicrowaveFood",
                isServer = true,
                args = 4
            }
        },
        {
            header = Config.Lang['mwburgerheader'],
            txt = Config.Lang['mwburgerheadertext'],
            params = {
                event = "boii-billiardsbar:server:MicrowaveFood",
                isServer = true,
                args = 5
            }
        },
        {
            header = Config.Lang['mwcburgerheader'],
            txt = Config.Lang['mwcburgerheadertext'],
            params = {
                event = "boii-billiardsbar:server:MicrowaveFood",
                isServer = true,
                args = 6
            }
        },
        {
            header = Config.Lang['mwbcburgerheader'],
            txt = Config.Lang['mwbcburgerheadertext'],
            params = {
                event = "boii-billiardsbar:server:MicrowaveFood",
                isServer = true,
                args = 7
            }
        },
        {
            header = Config.Lang['exitmenu'],
            params = {
                event = "boii-billiardsjob:client:StopMenu"
            }
        },
    })
end)
RegisterNetEvent("boii-billiardsbar:client:MicrowaveFood", function(args)
    local player = PlayerPedId()
    if args == 1 then
        Core.Functions.Progressbar("bb_cookcheesepie", Config.Lang['microwavefood'], Config.MicrowaveTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@board_room@supervising@",
            anim = "think_01_hi_amy_skater_01",
            flags = 49,
        }, {}, {}, function()
            TriggerServerEvent(AddItemEvent, 'cookedcheesepie', 1)
	        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['cookedcheesepie'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mademicrowave'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 2 then
        Core.Functions.Progressbar("bb_cookmeatpie", Config.Lang['microwavefood'], Config.MicrowaveTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@board_room@supervising@",
            anim = "think_01_hi_amy_skater_01",
            flags = 49,
        }, {}, {}, function()
            TriggerServerEvent(AddItemEvent, 'cookedmeatpie', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['cookedmeatpie'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mademicrowave'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 3 then
        Core.Functions.Progressbar("bb_cooksteakpie", Config.Lang['microwavefood'], Config.MicrowaveTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@board_room@supervising@",
            anim = "think_01_hi_amy_skater_01",
            flags = 49,
        }, {}, {}, function()
            TriggerServerEvent(AddItemEvent, 'cookedsteakpie', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['cookedsteakpie'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mademicrowave'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 4 then
        Core.Functions.Progressbar("bb_cookchickenpie", Config.Lang['microwavefood'], Config.MicrowaveTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@board_room@supervising@",
            anim = "think_01_hi_amy_skater_01",
            flags = 49,
        }, {}, {}, function()
            TriggerServerEvent(AddItemEvent, 'cookedchickenpie', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['cookedchickenpie'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mademicrowave'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 5 then
        Core.Functions.Progressbar("bb_cookburger", Config.Lang['microwavefood'], Config.MicrowaveTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@board_room@supervising@",
            anim = "think_01_hi_amy_skater_01",
            flags = 49,
        }, {}, {}, function()
            TriggerServerEvent(AddItemEvent, 'cookedmwburger', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['cookedmwburger'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mademicrowave'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 6 then
        Core.Functions.Progressbar("bb_cookcburger", Config.Lang['microwavefood'], Config.MicrowaveTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@board_room@supervising@",
            anim = "think_01_hi_amy_skater_01",
            flags = 49,
        }, {}, {}, function()
            TriggerServerEvent(AddItemEvent, 'cookedmwcburger', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['cookedmwcburger'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mademicrowave'], 'success')
            ClearPedTasks(player)
        end)
    elseif args == 7 then
        Core.Functions.Progressbar("bb_cookbcburger", Config.Lang['microwavefood'], Config.MicrowaveTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@board_room@supervising@",
            anim = "think_01_hi_amy_skater_01",
            flags = 49,
        }, {}, {}, function()
            TriggerServerEvent(AddItemEvent, 'cookedmwbcburger', 1)
            TriggerEvent("inventory:client:ItemBox", Core.Shared.Items['cookedmwbcburger'], "add")
            TriggerEvent('boii-billiardsbar:notifications', Config.Lang['mademicrowave'], 'success')
            ClearPedTasks(player)
        end)
    end    
end)
--<!>-- MICROWAVE CODE START --<!>--

--<!>-- EPOS CODE START --<!>--
exports[TargetName]:AddBoxZone("bb_pay", Config.Pay, 1.5, 1.0, {
    name="bb_pay",
    heading=143.50,
    debugPoly=false,
    minZ=-12.55,
    maxZ=-14.55
    }, {
    options = {
        {
            --event = "boii-billiardsbar:client:BilliardsPay",
            event = "jim-payments:client:Charge",
            icon = Config.Lang['payicon'], 
            label = Config.Lang['paylabel'],
			job = JobName,
        },
    },
    distance = 1.0
})
RegisterNetEvent("boii-billiardsbar:client:BilliardsPay", function()
    local input = exports[InputName]:ShowInput({
        header = Config.Lang['paymenuheader'],
        submitText = Config.Lang['paymenuheadertext'],
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'id',
                text = Config.Lang['paytext']
            },
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = Config.Lang['payamount'],
            }
        }
    })
    if input then
        if not input.id or not input.amount then return end
        TriggerServerEvent("boii-billiardsbar:server:BilliardsPay", input.id, input.amount)
    end
end)
--<!>-- EPOS CODE START --<!>--

--<!>-- OUTFITS CODE START --<!>--
exports[TargetName]:AddBoxZone("bb_outfits", Config.Outfits, 1.5, 1.5, {
    name="bb_outfits",
    heading= 145.32,
    debugPoly=false,
    minZ=12.55,
    maxZ=14.55
    }, {
    options = {
        {
            event = "boii-billardsbar:client:ChangeOutfit",
            icon = Config.Lang['outfiticon'], 
            label = Config.Lang['outfitlabel'],
			job = JobName,
        },
    },
    distance = 1.0
})
RegisterNetEvent('boii-billardsbar:client:ChangeOutfit', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "Clothes1", 0.4)
    TriggerEvent(ClothingEvent)
end)
--<!>-- OUTFITS CODE END --<!>--

--<!>-- JOB STORE CODE START --<!>--
exports[TargetName]:AddBoxZone("bb_store", Config.Store, 1.5, 1.0, {
    name="bb_store",
    heading=230.50,
    debugPoly=false,
    minZ=12.55,
    maxZ=14.55
    }, {
    options = {
        {
            event = "boii-billiardsbar:client:OpenShop",
            icon = Config.Lang['shopicon'], 
            label = Config.Lang['shoplabel'],
			job = JobName,
        },
    },
    distance = 1.0
})
RegisterNetEvent('boii-billiardsbar:client:OpenShop')
AddEventHandler('boii-billiardsbar:client:OpenShop', function()
    local ShopItems = {}
    ShopItems.label = Config.Lang['jobstorelabel']
    ShopItems.items = Config.ShopItems
    ShopItems.slots = #Config.ShopItems
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "bbshop", ShopItems)
end) 
--<!>-- JOB STORE CODE END --<!>--

--<!>-- STORAGE CODE START --<!>--
exports[TargetName]:AddBoxZone("bb_storage", Config.Storage, 1.5, 1.5, {
    name="bb_storage",
    heading= 323.50,
    debugPoly=false,
    minZ=12.66,
    maxZ=14.64
    }, {
    options = {
        {
            event = "boii-billardsbar:client:JobStorage",
            icon = Config.Lang['storageicon'], 
            label = Config.Lang['storagelabel'],
			job = JobName,
        },
    },
    distance = 1.0
})
RegisterNetEvent("boii-billardsbar:client:JobStorage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "billiardsstorage")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "billiardsstorage", {
        maxweight = 1000000,
        slots = 41,
    })
end)
--<!>-- STORAGE CODE END --<!>--

--<!>-- SNAKE CODE START --<!>--
exports[TargetName]:AddBoxZone("bb_snake", Config.Snake, 1.5, 1.5, {
    name="bb_snake",
    heading=52.50,
    debugPoly=false,
    minZ=12.55,
    maxZ=14.55
    }, {
    options = {
        {
            event = "boii-billiardsbar:client:SnakeMenu",
            icon = Config.Lang['snakeicon'], 
            label = Config.Lang['snakelabel'],
			job = JobName,
        },
    },
    distance = 1.0
})
RegisterNetEvent('boii-billiardsbar:client:SnakeMenu', function(data)
    local player = PlayerPedId()
    Core.Functions.TriggerCallback(ItemCheckEvent, function(HasItem)
	    if HasItem then
            FeedSnakeMenu()
        else
            GetSnakeFoodMenu()
        end
    end, SnakeFoodItem)
end)
function GetSnakeFoodMenu()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['snakeheader'],
            txt = Config.Lang['snakeheadertext'],
            isMenuHeader = true
        },
        {
            header = Config.Lang['snakefoodheader'],
            txt = Config.Lang['snakefoodheadertext'],
            params = {
                event = "boii-billiardsbar:client:FeedSnake",
				args = 1
            }
        },
        {
            header = Config.Lang['exitmenu'],
            params = {
                event = "boii-billiardsbar:client:StopMenu"
            }
        },
    })
end 
function FeedSnakeMenu()
    exports[MenuName]:openMenu({
		{
            header = Config.Lang['snakeheader'],
            txt = Config.Lang['snakeheadertext'],
            isMenuHeader = true
        },
		{
            header = Config.Lang['feedsnakeheader'],
            txt = Config.Lang['feedsnakeheadertext'],
            params = {
                event = "boii-billiardsbar:client:FeedSnake",
				args = 2
            }
        },
        {
            header = Config.Lang['exitmenu'],
            params = {
                event = "boii-billiardsbar:client:StopMenu"
            }
        },
    })
end
--<!>-- SNAKE CODE START --<!>--


--<!>-- GARAGE CODE START --<!>--
exports[TargetName]:AddBoxZone("bb_garage", Config.Garage, 6.8, 10.0, {
    name="bb_garage",
    heading=45.50,
    debugPoly=false,
    minZ=11.55,
    maxZ=15.55
    }, {
    options = {
        {
            event = "boii-billiardsbar:client:GarageMenu",
            icon = Config.Lang['garageicon'], 
            label = Config.Lang['garagelabel'],
			job = JobName,
        },
    },
    distance = 10.0
})
-- Event to open menu
RegisterNetEvent('boii-billiardsbar:client:GarageMenu', function(data)
    local player = PlayerPedId()
    local inVehicle = IsPedInAnyVehicle(player)
    if inVehicle then
        ReturnVehicle()
    else
        VehicleRentMenu()
    end
end)
function VehicleRentMenu()
    exports[MenuName]:openMenu({
        {
            header = Config.Lang['rentheader'],
            isMenuHeader = true
        },
        {
            header = Config.Lang['rentmenuheader'],
            txt = Config.Lang['rentmenutext'],
            params = {
                event = "boii-billiardsbar:client:RentVehicle",
				args = 1
            }
        },
        {
            header = Config.Lang['exitmenu'],
            params = {
                event = "boii-billiardsbar:client:StopMenu"
            }
        },
    })
end 
function ReturnVehicle()
    exports[MenuName]:openMenu({
		{
            header = Config.Lang['rentheader'],
            isMenuHeader = true
        },
		{
            header = Config.Lang['returnmenuheader'],
            txt = Config.Lang['returnmenutext'],
            params = {
                event = "boii-billiardsbar:client:ReturnVehicle",
				args = 1
            }
        },
        {
            header = Config.Lang['exitmenu'],
            params = {
                event = "boii-billiardsbar:client:StopMenu"
            }
        },
    })
end
RegisterNetEvent('boii-billiardsbar:client:ReturnVehicle', function()
	local player = PlayerPedId()
	if IsPedInAnyVehicle(player) then
        local van = GetVehiclePedIsIn(player,true) 
        Core.Functions.DeleteVehicle(van)
        SetEntityCoords(player, Config.VehicleSpawn.x, Config.VehicleSpawn.y, Config.VehicleSpawn.z, 0, 0, 0, false) 
        SetEntityHeading(player, Config.VehicleSpawnHeading)
        TriggerServerEvent('boii-billiardsbar:server:ReturnDeposit')
	end
end)
--<!>-- GARAGE CODE END --<!>--

--<!>-- EAT PIE CODE START --<!>--
RegisterNetEvent('boii-billiardsbar:client:EatPie', function(itemName)
    local player = PlayerPedId()
    Core.Functions.Progressbar("bb_eatpie", Config.Lang['eatpie'], Config.EatPieTime, false, true,{
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@code_human_wander_eating_donut@male@idle_a",
        anim = "idle_c",
        flags = 49,
    }, {
        model = "prop_cs_burger_01",
        bone = 28422,
        coords = vector3(-0.005, 0.00, -0.05),
        rotation = vector3(175.0, 185.0, 0.0),
    }, {}, function()
        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[itemName], "remove")
        TriggerServerEvent(RemoveItemEvent, itemName, 1)
        TriggerServerEvent(MetaDataEvent, "hunger", Core.Functions.GetPlayerData().metadata["hunger"] + FoodType[itemName])
        TriggerServerEvent(RemoveStress, Config.PieStress)
        ClearPedTasks(player)
    end)
end)
--<!>-- EAT PIE CODE END --<!>--

--<!>-- EAT BURGER CODE START --<!>--
RegisterNetEvent('boii-billiardsbar:client:EatBurger', function(itemName)
    local player = PlayerPedId()
    Core.Functions.Progressbar("bb_eatburger", Config.Lang['eatburger'], Config.EatBurgerTime, false, true,{
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@code_human_wander_eating_donut@male@idle_a",
        anim = "idle_c",
        flags = 49,
    }, {
        model = "prop_cs_burger_01",
        bone = 28422,
        coords = vector3(-0.005, 0.00, -0.05),
        rotation = vector3(175.0, 185.0, 0.0),
    }, {}, function()
        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[itemName], "remove")
        TriggerServerEvent(RemoveItemEvent, itemName, 1)
        TriggerServerEvent(MetaDataEvent, "hunger", Core.Functions.GetPlayerData().metadata["hunger"] + FoodType[itemName])
        TriggerServerEvent(RemoveStress, Config.BurgerStress)
        ClearPedTasks(player)
    end)
end)
--<!>-- EAT BURGER CODE END --<!>--


--<!>-- DRINK BEER CODE START --<!>--
RegisterNetEvent('boii-billiardsbar:client:DrinkBeer', function(itemName)
    local player = PlayerPedId()
    Core.Functions.Progressbar("bb_drinkpint", Config.Lang['drinkbeer'], Config.DrinkBeerTime, false, true,{
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@code_human_wander_drinking@male@idle_a",
        anim = "idle_c",
        flags = 49,
    }, {
        model = "prop_pint_glass_tall",
        bone = 28422,
        coords = vector3(-0.005, 0.00, -0.10),
        rotation = vector3(175.0, 185.0, 0.05),
    }, {}, function()
        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[itemName], "remove")
        TriggerServerEvent(RemoveItemEvent, itemName, 1)
        TriggerServerEvent(MetaDataEvent, "thirst", Core.Functions.GetPlayerData().metadata["thirst"] + Alcohol[itemName])
        TriggerServerEvent(RemoveStress, Config.BeerStress)
        ClearPedTasks(player)
        alcoholCount = alcoholCount + 1
        if alcoholCount > LightBeerAmount and alcoholCount < HeavyBeerAmount then
            LightDrunkEffect()
            TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
        elseif alcoholCount >= HeavyBeerAmount then
            HeavyDrunkEffect()
            TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
        end
    end, function()
        TriggerEvent('boii-billiardsbar:notifications', Config.Lang['cancel'], 'error')
        ClearPedTasks(player)
    end)
end)
--<!>-- DRINK BEER CODE END --<!>--

--<!>-- DRINK LIQUOR CODE START --<!>--
RegisterNetEvent('boii-billiardsbar:client:DrinkLiquor', function(itemName)
    local player = PlayerPedId()
    Core.Functions.Progressbar("bb_drinkliquor", Config.Lang['drinkliquor'], Config.DrinkLiquorTime, false, true,{
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@code_human_wander_drinking@male@idle_a",
        anim = "idle_c",
        flags = 49,
    }, {
        model = "prop_shot_glass",
        bone = 28422,
        coords = vector3(-0.005, 0.00, -0.01),
        rotation = vector3(175.0, 185.0, 0.05),
    }, {}, function()
        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[itemName], "remove")
        TriggerServerEvent(RemoveItemEvent, itemName, 1)
        TriggerServerEvent(MetaDataEvent, "thirst", Core.Functions.GetPlayerData().metadata["thirst"] + AlcoholType[itemName])
        TriggerServerEvent(RemoveStress, Config.LiquorStress)
        ClearPedTasks(player)
        alcoholCount = alcoholCount + 1
        if alcoholCount > LightLiquorAmount and alcoholCount < HeavyLiquorAmount then
            LightDrunkEffect()
            TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
        elseif alcoholCount >= HeavyLiquorAmount then
            HeavyDrunkEffect()
            TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
        end
    end, function()
        TriggerEvent('boii-billiardsbar:notifications', Config.Lang['cancel'], 'error')
        ClearPedTasks(player)
    end)
end)
--<!>-- DRINK LIQUOR CODE START --<!>--

--<!>-- DRINK COCKTAILS CODE START --<!>--
RegisterNetEvent('boii-billiardsbar:client:DrinkCocktail', function(itemName)
    local player = PlayerPedId()
    Core.Functions.Progressbar("bb_drinkliquor", Config.Lang['drinkcocktail'], Config.DrinkCocktailTime, false, true,{
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@code_human_wander_drinking@male@idle_a",
        anim = "idle_c",
        flags = 49,
    }, {
        model = "prop_cocktail_glass",
        bone = 28422,
        coords = vector3(-0.005, 0.00, -0.05),
        rotation = vector3(175.0, 185.0, 0.0),
    }, {}, function()
        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[itemName], "remove")
        TriggerServerEvent(RemoveItemEvent, itemName, 1)
        TriggerServerEvent(MetaDataEvent, "thirst", Core.Functions.GetPlayerData().metadata["thirst"] + AlcoholType[itemName])
        TriggerServerEvent(RemoveStress, Config.CocktailStress)
        ClearPedTasks(player)
        alcoholCount = alcoholCount + 1
        if alcoholCount > LightCocktailAmount and alcoholCount < HeavyCocktailAmount then
            LightDrunkEffect()
            TriggerEvent(EvidenceEvent, "alcohol", 200)
        elseif alcoholCount >= HeavyCocktailAmount then
            HeavyDrunkEffect()
            TriggerEvent(EvidenceEvent, "heavyalcohol", 200)
        end
    end, function()
        TriggerEvent('boii-billiardsbar:notifications', Config.Lang['cancel'], 'error')
        ClearPedTasks(player)
    end)
end)
--<!>-- DRINK COCKTAILS CODE END --<!>--

--<!>-- HOT DRINKS CODE START --<!>--
RegisterNetEvent('boii-billiardsbar:client:DrinkCoffee', function(itemName)
    local player = PlayerPedId()
    Core.Functions.Progressbar("bb_drinkcoffee", Config.Lang['drinkcoffee'], Config.DrinkHotTime, false, true,{
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@code_human_wander_drinking@male@idle_a",
        anim = "idle_c",
        flags = 49,
    }, {
        model = "v_res_mcofcup",
        bone = 28422,
        coords = vector3(-0.005, 0.00, -0.05),
        rotation = vector3(175.0, 185.0, 0.0),
    }, {}, function()
        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[itemName], "remove")
        TriggerServerEvent(RemoveItemEvent, itemName, 1)
        TriggerServerEvent(MetaDataEvent, "thirst", Core.Functions.GetPlayerData().metadata["thirst"] + DrinkType[itemName])
        TriggerServerEvent(RemoveStress, Config.HotDrinkStress)
        ClearPedTasks(player)
    end)
end)
RegisterNetEvent('boii-billiardsbar:client:DrinkTea', function(itemName)
    local player = PlayerPedId()
    Core.Functions.Progressbar("bb_drinktea", Config.Lang['drinktea'], Config.DrinkHotTime, false, true,{
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@code_human_wander_drinking@male@idle_a",
        anim = "idle_c",
        flags = 49,
    }, {
        model = "v_res_mcofcup",
        bone = 28422,
        coords = vector3(-0.005, 0.00, -0.05),
        rotation = vector3(175.0, 185.0, 0.0),
    }, {}, function()
        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[itemName], "remove")
        TriggerServerEvent(RemoveItemEvent, itemName, 1)
        TriggerServerEvent(MetaDataEvent, "thirst", Core.Functions.GetPlayerData().metadata["thirst"] + DrinkType[itemName])
        TriggerServerEvent(RemoveStress, Config.HotDrinkStress)
        ClearPedTasks(player)
    end)
end)
--<!>-- HOT DRINKS CODE END --<!>--

--<!>-- COLD DRINKS CODE START --<!>--
RegisterNetEvent('boii-billiardsbar:client:DrinkSprunk', function(itemName)
    local player = PlayerPedId()
    Core.Functions.Progressbar("bb_drinksprunk", Config.Lang['drinksprunk'], Config.DrinkColdTime, false, true,{
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@code_human_wander_drinking@male@idle_a",
        anim = "idle_c",
        flags = 49,
    }, {
        model = "prop_ld_can_01",
        bone = 28422,
        coords = vector3(-0.005, 0.00, -0.05),
        rotation = vector3(175.0, 185.0, 0.0),
    }, {}, function()
        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[itemName], "remove")
        TriggerServerEvent(RemoveItemEvent, itemName, 1)
        TriggerServerEvent(MetaDataEvent, "thirst", Core.Functions.GetPlayerData().metadata["thirst"] + DrinkType[itemName])
        TriggerServerEvent(RemoveStress, Config.ColdDrinkStress)
        ClearPedTasks(player)
    end)
end)
RegisterNetEvent('boii-billiardsbar:client:DrinkCola', function(itemName)
    local player = PlayerPedId()
    Core.Functions.Progressbar("bb_drinkcola", Config.Lang['drinkcola'], Config.DrinkColdTime, false, true,{
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@code_human_wander_drinking@male@idle_a",
        anim = "idle_c",
        flags = 49,
    }, {
        model = "prop_ecola_can",
        bone = 28422,
        coords = vector3(-0.005, 0.00, -0.05),
        rotation = vector3(175.0, 185.0, 0.0),
    }, {}, function()
        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[itemName], "remove")
        TriggerServerEvent(RemoveItemEvent, itemName, 1)
        TriggerServerEvent(MetaDataEvent, "thirst", Core.Functions.GetPlayerData().metadata["thirst"] + DrinkType[itemName])
        TriggerServerEvent(RemoveStress, Config.ColdDrinkStress)
        ClearPedTasks(player)
    end)
end)
--<!>-- COLD DRINKS CODE END --<!>--

exports['qb-target']:AddBoxZone("Receipt", vector3(-1586.82, -995.55, 13.08), 1.0, 1.0, { name="Receipt", heading = 335.0, debugPoly=debugPoly, minZ = 12.08, maxZ = 14.08, }, 
{ options = { { event = "jim-payments:client:Charge", icon = "fas fa-credit-card", label = "Charge Customer", job = "billiards",
                img = "<center><p><img src=https://cdn.discordapp.com/attachments/999830675635064942/999830863174959114/8bh.png width=200px></p>",
            } }, distance = 3.0	})