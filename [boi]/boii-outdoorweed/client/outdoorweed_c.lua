-------------------------------
---------- CASE#2506 ----------
-------------------------------


--<!>-- DO NOT CHANGE ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--
local Core = exports['qb-core']:GetCoreObject()
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local TargetName = Config.CoreSettings.TargetName
local MenuName = Config.CoreSettings.MenuName
local ItemCheckEvent = Config.CoreSettings.ItemCheckEvent
local RemoveItemEvent = Config.CoreSettings.RemoveItemEvent
local AddItemEvent = Config.CoreSettings.AddItemEvent
local RemoveStress = Config.CoreSettings.RemoveStressEvent
local isLoggedIn = false
local PlayerJob = {}
local SpawnedPlants = {}
local InteractedPlant = nil
local HarvestedPlants = {}
local canHarvest = true
local closestPlant = nil
local isDoingAction = false
local source = source
local SkunkStressAmount = Config.SkunkStressAmount
local SkunkArmourAmount = Config.SkunkArmourAmount
local KushStressAmount = Config.KushStressAmount
local KushArmourAmount = Config.KushArmourAmount
local WidowStressAmount = Config.WidowStressAmount
local WidowArmourAmount = Config.WidowArmourAmount
local AK47StressAmount = Config.AK47StressAmount
local AK47ArmourAmount = Config.AK47ArmourAmount
local AmnesiaStressAmount = Config.AmnesiaStressAmount
local AmnesiaArmourAmount = Config.AmnesiaArmourAmount
local PurpleStressAmount = Config.PurpleStressAmount
local PurpleArmourAmount = Config.PurpleArmourAmount
--<!>-- DO NOT CHANGE ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--

--<!>-- BLIPS CODE START --<!>--
-- Creates blip for meth processing (uncomment to add the blip)
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
--<!>-- BLIPS CODE START --<!>--

--<!>-- PLAYER LOADED CODE START --<!>--
-- Player loaded
RegisterNetEvent('Core:Client:OnPlayerLoaded')
AddEventHandler('Core:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = Core.Functions.GetPlayerData().job
end)
-- Job update
RegisterNetEvent('Core:Client:OnJobUpdate')
AddEventHandler('Core:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)
--<!>-- PLAYER LOADED CODE END --<!>--

--<!>-- NOTIFICATION CODE START --<!>--
-- Notifications
RegisterNetEvent('boii-outdoorweed:notifications')
AddEventHandler('boii-outdoorweed:notifications', function(msg,type)
    Core.Functions.Notify(msg,type)
end)
--<!>-- NOTIFICATION CODE END --<!>--

--<!>-- SPAWN PEDS CODE START --<!>--
-- Smoke shop ped
local weedPed = {
  {-1169.22, -1573.28, 3.66,"Clyde",104.40,0xF041880B,"u_m_y_hippie_01"},

}
-- Spawns smoke shop ped
Citizen.CreateThread(function()
    for _,v in pairs(weedPed) do
        RequestModel(GetHashKey(v[7]))
        while not HasModelLoaded(GetHashKey(v[7])) do
            Wait(1)
        end
        SmokeShopPed =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
        SetEntityHeading(SmokeShopPed, v[5])
        FreezeEntityPosition(SmokeShopPed, true)
        SetEntityInvincible(SmokeShopPed, true)
        SetBlockingOfNonTemporaryEvents(SmokeShopPed, true)
        TaskStartScenarioInPlace(SmokeShopPed, "WORLD_HUMAN_SMOKING_POT", 0, true) 
    end
end)
--<!>-- SPAWN PED CODE END --<!>--

--<!>-- PED TARGETING CODE START --<!>--
-- Targeting for smoke shop ped
exports[TargetName]:AddTargetModel(`u_m_y_hippie_01`, {
    options = {
        {
            event = "boii-outdoorweed:client:SmokeShopPed",
            icon = "fab fa-drupal",
            label = "Speak with Clyde",
        },
    },
distance = 1.0 
})
--<!>-- PED TARGETING CODE END --<!>--

--<!>-- MENUS CODE START --<!>--
-- Smoke shop main menu
RegisterNetEvent('boii-outdoorweed:client:SmokeShopPed', function()
    exports[MenuName]:openMenu({
        {
            header = "Smoke on the Water",
            txt = "Marijuana Vendor",
            isMenuHeader = true
        },
        {
            header = "Sell to Shop",
            txt = "See current prices",
            params = {
                event = "boii-outdoorweed:client:SellingMenu",
            }
        },
        {
            header = "Browse Shop",
            txt = "See what we have to offer",
            params = {
                event = "boii-outdoorweed:client:OpenSmokeShop",
            }
        },
        {
            header = "< Exit",
            params = {
                event = "boii-outdoorweed:client:StopMenu"
            }
        },
    })
end)
-- Sell weed to store menu
RegisterNetEvent('boii-outdoorweed:client:SellingMenu', function()
    exports[MenuName]:openMenu({
        {
            header = "Smoke on the Water",
            txt = "We only accept ounces",
            isMenuHeader = true
        },
        {
            header = "Skunk",
            txt = "$5 per bag of Skunk.",
            params = {
                event = "boii-outdoorweed:server:SellBags",
                isServer = true,
                args = 1
            }
        },
        {
            header = "OG-Kush.",
            txt = "$8 per bag of OG-Kush.",
            params = {
                event = "boii-outdoorweed:server:SellBags",
                isServer = true,
                args = 2

            }
        },
        {
            header = "White Widow.",
            txt = "$11 per bag of White Widow.",
            params = {
                event = "boii-outdoorweed:server:SellBags",
                isServer = true,
                args = 3
            }
        },
		{
            header = "AK47.",
            txt = "$14 per bag of AK47.",
            params = {
                event = "boii-outdoorweed:server:SellBags",
                isServer = true,
                args = 4
            }
        },
		{
            header = "Amnesia.",
            txt = "$17 per bag of Amnesia.",
            params = {
                event = "boii-outdoorweed:server:SellBags",
                isServer = true,
                args = 5
            }
        },
		{
            header = "Purple Haze.",
            txt = "$20 per bag of Purple Haze.",
            params = {
                event = "boii-outdoorweed:server:SellBags",
                isServer = true,
                args = 6
            }
        },
        {
            header = "< Return",
            params = {
                event = "boii-outdoorweed:client:SmokeShopPed"
            }
        },
    })
end)
-- Use trimming shears menu
RegisterNetEvent('boii-outdoorweed:client:TrimmingMenu', function()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 3500, false)
    exports[MenuName]:openMenu({
        {
            header = "Weed Trimming",
            txt = "Requires:</p>14x Resealable bags</p>3x Buds",
            isMenuHeader = true
        },
        {
            header = "Skunk",
            txt = "Process skunk crops into bags.",
            params = {
                event = "boii-outdoorweed:server:TrimWeed",
                isServer = true,
                args = 1

            }
        },
        {
            header = "OG-Kush",
            txt = "Process OG Kush crops into bags.",
            params = {
                event = "boii-outdoorweed:server:TrimWeed",
                isServer = true,
                args = 2
            }
        },
		{ 
            header = "White Widow",
            txt = "Process White Widow crops into bags.",
            params = {
                event = "boii-outdoorweed:server:TrimWeed",
                isServer = true,
                args = 3
            }
        },
		{ 
            header = "AK47",
            txt = "Process AK47 crops into bags.",
            params = {
                event = "boii-outdoorweed:server:TrimWeed",
                isServer = true,
                args = 4
            }
        },
		{ 
            header = "Amnesia",
            txt = "Process Amnesia crops into bags.",
            params = {
                event = "boii-outdoorweed:server:TrimWeed",
                isServer = true,
                args = 5
            }
        },
		{ 
            header = "Purple Haze",
            txt = "Process Purple Haze crops into bags.",
            params = {
                event = "boii-outdoorweed:server:TrimWeed",
                isServer = true,
                args = 6
            }
        },
        {
            header = "< Exit",
            params = {
                event = "boii-outdoorweed:client:StopMenu"
            }
        },
    })
end)
-- Drug cutting kit main menu
RegisterNetEvent('boii-outdoorweed:client:RollJointsMenu', function()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 3500, false)
    exports[MenuName]:openMenu({
        {
            header = "Roll Joints",
            txt = "Required:</p>2x Rolling Papers</p>1x Bag of Weed",
            isMenuHeader = true
        },
        {
            header = "Skunk",
            txt = "Roll up some skunk joints!",
            params = {
                event = "boii-outdoorweed:server:RollJoints",
                isServer = true,
                args = 1
            }
        },
        {
            header = "OG-Kush",
            txt = "Roll up some og-kush joints!",
            params = {
                event = "boii-outdoorweed:server:RollJoints",
                isServer = true,
                args = 2
            }
        },
        {
            header = "White Widow",
            txt = "Roll up some white widow joints!",
            params = {
                event = "boii-outdoorweed:server:RollJoints",
                isServer = true,
                args = 3
            }
        },
        {
            header = "AK47",
            txt = "Roll up some ak47 joints!",
            params = {
                event = "boii-outdoorweed:server:RollJoints",
                isServer = true,
                args = 4
            }
        },
        {
            header = "Amnesia",
            txt = "Roll up some amnesia joints!",
            params = {
                event = "boii-outdoorweed:server:RollJoints",
                isServer = true,
                args = 5
            }
        },
        {
            header = "Purple Haze",
            txt = "Roll up some purple haze joints!",
            params = {
                event = "boii-outdoorweed:server:RollJoints",
                isServer = true,
                args = 6
            }
        },
        {
            header = "< Exit",
            params = {
                event = "boii-outdoorweed:client:StopMenu"
            }
        },
    })
end)
--<!>-- MENUS CODE END --<!>--

--<!>-- CREATE PLANTS CODE START --<!>--
-- Create plants
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(150)
    local player = GetPlayerPed(-1)
    local position = GetEntityCoords(player)
    local inRange = false
    for i = 1, #Config.Plants do
        local dist = GetDistanceBetweenCoords(position.x, position.y, position.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true)
            if dist < 50.0 then
                inRange = true
                local hasSpawned = false
                local needsUpgrade = false
                local upgradeId = nil
                local tableRemove = nil    
                for z = 1, #SpawnedPlants do
                    local p = SpawnedPlants[z]    
                    if p.id == Config.Plants[i].id then
                        hasSpawned = true
                        if p.stage ~= Config.Plants[i].stage then
                            needsUpgrade = true
                            upgradeId = p.id
                            tableRemove = z
                        end
                    end
                end    
                if not hasSpawned then
                    local hash = GetHashKey(Config.WeedStages[Config.Plants[i].stage])
                    RequestModel(hash)
                    local data = {}
                    data.id = Config.Plants[i].id
                    data.stage = Config.Plants[i].stage    
                    while not HasModelLoaded(hash) do
                        Citizen.Wait(10)
                        RequestModel(hash)
                    end    
                    data.obj = CreateObject(hash, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z + GetPlantZ(Config.Plants[i].stage), false, false, false) 
                    SetEntityAsMissionEntity(data.obj, true)
                    FreezeEntityPosition(data.obj, true)
                    table.insert(SpawnedPlants, data)
                    hasSpawned = false
                end    
                if needsUpgrade then
                    for o = 1, #SpawnedPlants do
                        local u = SpawnedPlants[o]    
                        if u.id == upgradeId then
                            SetEntityAsMissionEntity(u.obj, false)
                            FreezeEntityPosition(u.obj, false)
                            DeleteObject(u.obj)   
                            local hash = GetHashKey(Config.WeedStages[Config.Plants[i].stage])
                            RequestModel(hash)
                            local data = {}
                            data.id = Config.Plants[i].id
                            data.stage = Config.Plants[i].stage    
                            while not HasModelLoaded(hash) do
                                Citizen.Wait(10)
                                RequestModel(hash)
                            end    
                            data.obj = CreateObject(hash, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z + GetPlantZ(Config.Plants[i].stage), false, false, false) 
                            SetEntityAsMissionEntity(data.obj, true)
                            FreezeEntityPosition(data.obj, true)
                            table.remove(SpawnedPlants, o)
                            table.insert(SpawnedPlants, data)
                            needsUpgrade = false
                        end
                    end
                end
            end
    end
    if not InRange then
        Citizen.Wait(5000)
    end
    end
end)
--<!>-- CREATE PLANTS CODE END --<!>--

--<!>-- DESTROY PLANTS CODE START --<!>--
-- Destroy plants
function DestroyPlant()
    local plant = GetClosestPlant()
    local hasDone = false
    for k, v in pairs(HarvestedPlants) do
        if v == plant.id then
            hasDone = true
        end
    end
    if not hasDone then
        table.insert(HarvestedPlants, plant.id)
        local player = GetPlayerPed(-1)
        local playerPed = PlayerPedId()
        isDoingAction = true
		TriggerServerEvent('boii-outdoorweed:server:PlantHarvested', plant.id)
        Core.Functions.Progressbar("destroy_weed", Config.Lang["destroyplant"], Config.DestroyTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            anim = "weed_spraybottle_crouch_base_inspector"
        }, {}, {}, function()
            ClearPedTasks(playerPed)  
        end)
        TriggerServerEvent('boii-outdoorweed:server:DestroyPlants', plant.id)
        isDoingAction = false
        canHarvest = true
        ClearPedTasksImmediately(player)        
	end
end
--<!>-- DESTROY PLANTS CODE END --<!>--

--<!>-- HARVEST PLANTS CODE START --<!>--
-- Harvest plants
function HarvestWeedPlant()
    local plant = GetClosestPlant()
    local hasDone = false
    for k, v in pairs(HarvestedPlants) do
        if v == plant.id then
            hasDone = true
        end
    end
    if not hasDone then
        table.insert(HarvestedPlants, plant.id)
        local player = GetPlayerPed(-1)
        isDoingAction = true
        Core.Functions.Progressbar("harvest_weed", Config.Lang["harvestplant"], Config.HarvestTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            anim = "weed_spraybottle_crouch_base_inspector"
        }, {}, {}, function()
        TriggerServerEvent('boii-outdoorweed:server:HarvestPlant', plant.id)
        isDoingAction = false
        canHarvest = true
        ClearPedTasks(player)
        end)
	end
end
--<!>-- HARVEST PLANTS CODE END --<!>--

--<!>-- PLANTS CODE START --<!>--
-- Feed/water or destroy plants
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local InRange = false
            local player = GetPlayerPed(-1)
            local position = GetEntityCoords(player)
            for k, v in pairs(Config.Plants) do
                if GetDistanceBetweenCoords(position.x, position.y, position.z, v.x, v.y, v.z, true) < 1.3 and not isDoingAction and not v.beingHarvested and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                    if PlayerJob == 'police' --[[or PlayerJob.name == 'lspd' or PlayerJob.name == 'sapr' or PlayerJob.name == 'sahp' or PlayerJob.name == 'sast' or PlayerJob.name == 'fib' --]]then
                        local plant = GetClosestPlant()
                        DrawText3D(v.x, v.y, v.z, 'Type: ' .. v.type .. 'Thirst: ' .. v.thirst .. '% - Hunger: ' .. v.hunger .. '% - Growth: ' ..  v.growth .. '% -  Quality: ' .. v.quality)
                        DrawText3D(v.x, v.y, v.z - 0.18, '~r~G~w~ - Destroy Plant')
                        if IsControlJustReleased(0, 47) then
                            if v.id == plant.id then
                                DestroyPlant()
                            end
                        end
                    else
                        if v.growth < 100 then
                        local plant = GetClosestPlant()    
                        DrawText3D(v.x, v.y, v.z, 'Type: ' .. v.type .. ' Thirst: ' .. v.thirst .. '% - Hunger: ' .. v.hunger .. '% - Growth: ' ..  v.growth .. '% -  Quality: ' .. v.quality)
                        DrawText3D(v.x, v.y, v.z - 0.18, '~b~G~w~ - Water      ~y~H~w~ - Feed')
                        if IsControlJustReleased(0, 47) then
                            if v.id == plant.id then
                                TriggerServerEvent('boii-outdoorweed:server:ItemCheck', 'weed_water', 'boii-outdoorweed:client:WaterPlants', true)
                            end
                        elseif IsControlJustReleased(0, 74) then
                            if v.id == plant.id then
                                TriggerServerEvent('boii-outdoorweed:server:ItemCheck', 'weed_nutrition', 'boii-outdoorweed:client:FeedPlants', true)
                            end
                        end
                    else
                        DrawText3D(v.x, v.y, v.z, 'Type: ' .. v.type .. '[Quality: ' .. v.quality .. ']')
                        DrawText3D(v.x, v.y, v.z - 0.18, '~g~E~w~ - Harvest')
                        if IsControlJustReleased(0, 38) and canHarvest then
                            local plant = GetClosestPlant()
                            if v.id == plant.id then
                                HarvestWeedPlant()
                            end
                        end
                    end
                end
            end
        end
    end
end)
--<!>-- PLANTS CODE END --<!>--

--<!>-- GET CLOSEST PLANT CODE START --<!>--
-- Get closest plant data
function GetClosestPlant()
    local dist = 1000
    local player = GetPlayerPed(-1)
    local position = GetEntityCoords(player)
    local plant = {}
    for i = 1, #Config.Plants do
        local distance = GetDistanceBetweenCoords(position.x, position.y, position.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true)
        if distance < dist then
            dist = distance
            plant = Config.Plants[i]
        end
    end
    return plant
end
--<!>-- GET CLOSEST PLANT CODE END --<!>--

--<!>-- WATER PLANTS CODE START --<!>--
-- Water plants
RegisterNetEvent('boii-outdoorweed:client:WaterPlants')
AddEventHandler('boii-outdoorweed:client:WaterPlants', function()
    local entity = nil
    local plant = GetClosestPlant()
	playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 35000)
    local player = GetPlayerPed(-1)
    isDoingAction = true
    for k, v in pairs(SpawnedPlants) do
        if v.id == plant.id then
            entity = v.obj
        end
    end
	Core.Functions.Progressbar("watering_weed", Config.Lang['waterplant'], Config.WateringTime, false, true,{
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
        anim = "weed_spraybottle_crouch_base_inspector"
    }, {}, {}, function()
    TriggerServerEvent('boii-outdoorweed:server:WaterPlants', plant.id)
    ClearPedTasks(player)
    isDoingAction = false
    end)
end)
--<!>-- WATER PLANTS CODE END --<!>--

--<!>-- FEED PLANTS CODE START --<!>--
-- Feed plants
RegisterNetEvent('boii-outdoorweed:client:FeedPlants')
AddEventHandler('boii-outdoorweed:client:FeedPlants', function()
    local entity = nil
	local playerPed = PlayerPedId()
	playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 35000)
    local plant = GetClosestPlant()
    local player = GetPlayerPed(-1)
    isDoingAction = true
    for k, v in pairs(SpawnedPlants) do
        if v.id == plant.id then
            entity = v.obj
        end
    end
    Core.Functions.Progressbar("feeding_weed", Config.Lang['feedingplant'], Config.FeedingTime, false, true,{
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
        anim = "weed_spraybottle_crouch_base_inspector"
    }, {}, {}, function()
    TriggerServerEvent('boii-outdoorweed:server:FeedPlants', plant.id)
    ClearPedTasks(player)
    isDoingAction = false
    end)
end)
--<!>-- FEED PLANTS CODE END --<!>--

-- Plant seeds
RegisterNetEvent('boii-outdoorweed:client:SeedPlanted')
AddEventHandler('boii-outdoorweed:client:SeedPlanted', function(type)
    local position = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.0)
    if CanPlantSeedHere(position) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        Core.Functions.Progressbar("plant_seed_weed", Config.Lang['plantingseed'], Config.PlantingTime, false, true,{
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            anim = "weed_spraybottle_crouch_base_inspector"
        }, {}, {}, function()           
            TriggerServerEvent('boii-outdoorweed:server:SeedPlanted', type, position)
        end)
    else
        TriggerEvent('boii-outdoorweed:notifications', Config.Lang['tooclose'], 'error')
    end
end)
--<!>-- UPDATE PLANTS CODE END --<!>--

-- Drawtext **WILL BE REMOVED IN FUTURE UPDATE AS DRAW TEXT IS RESOURCE HEAVY**
function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

--<!>-- REMOVE PLANTS CODE START --<!>--
-- Deletes plant
RegisterNetEvent('boii-outdoorweed:client:RemovePlant')
AddEventHandler('boii-outdoorweed:client:RemovePlant', function(plant)
    for i = 1, #SpawnedPlants do
        local o = SpawnedPlants[i]
        if o.id == plant then
            SetEntityAsMissionEntity(o.obj, false)
            FreezeEntityPosition(o.obj, false)
            DeleteObject(o.obj)
            RemovePlantFromTable()
        end
    end
end)
-- Remove plants from table
function RemovePlantFromTable(plantId)
    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            table.remove(Config.Plants, k)
        end
    end
end
--<!>-- REMOVE PLANTS CODE END --<!>--

--<!>-- COORD VAL CODE START --<!>--
-- Checks if can plant seed
function CanPlantSeedHere(position)
    local canPlant = true
    for i = 1, #Config.Plants do
        if GetDistanceBetweenCoords(position.x, position.y, position.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true) < 1.5 then
            canPlant = false
        end
    end
    return canPlant
end
-- Plant z stage
function GetPlantZ(stage)
    if stage == 1 then
        return -1.0
    else
        return -3.5
    end
end
--<!>-- COORD VAL CODE END --<!>--


--<!>-- WEED TRIMMING CODE START --<!>--
local baggieAmount = math.random(10,14) -- Amount of baggies to award on trimming
-- Event to trim skunk buds
RegisterNetEvent('boii-outdoorweed:client:TrimSkunk', function()
    local playerPed = PlayerPedId()
	Core.Functions.Progressbar("trim_skunk", Config.Lang["trimmingweed"], Config.WeedTrimTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function()
	TriggerServerEvent(AddItemEvent, "weed_skunk", baggieAmount)
	TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_skunk"], "add")
    TriggerEvent('boii-outdoorweed:notifications', Config.Lang['trimmedweed'], 'error')
    ClearPedTasks(playerPed)	
	end)
    TriggerEvent('boii-outdoorweed:client:TrimmingMenu')
end)
-- Event to trim og kush buds
RegisterNetEvent('boii-outdoorweed:client:TrimKush', function()
    local playerPed = PlayerPedId()
	Core.Functions.Progressbar("trim_kush", Config.Lang["trimmingweed"], Config.WeedTrimTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function()
	TriggerServerEvent(AddItemEvent, "weed_og-kush", baggieAmount)
	TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_og-kush"], "add")
    TriggerEvent('boii-outdoorweed:notifications', Config.Lang['trimmedweed'], 'error')
    ClearPedTasks(playerPed)	
	end)
    TriggerEvent('boii-outdoorweed:client:TrimmingMenu')
end)
-- Event to trim white widow buds
RegisterNetEvent('boii-outdoorweed:client:TrimWidow', function()
    local playerPed = PlayerPedId()
	Core.Functions.Progressbar("trim_widow", Config.Lang["trimmingweed"], Config.WeedTrimTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function()
	TriggerServerEvent(AddItemEvent, "weed_white-widow", baggieAmount)
	TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_white-widow"], "add")
    TriggerEvent('boii-outdoorweed:notifications', Config.Lang['trimmedweed'], 'error')
    ClearPedTasks(playerPed)	
	end)
    TriggerEvent('boii-outdoorweed:client:TrimmingMenu')
end)
-- Event to trim ak47 buds
RegisterNetEvent('boii-outdoorweed:client:TrimAK47', function()
    local playerPed = PlayerPedId()
	Core.Functions.Progressbar("trim_ak47", Config.Lang["trimmingweed"], Config.WeedTrimTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function()
	TriggerServerEvent(AddItemEvent, "weed_ak47", baggieAmount)
	TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_ak47"], "add")
    TriggerEvent('boii-outdoorweed:notifications', Config.Lang['trimmedweed'], 'error')
    ClearPedTasks(playerPed)	
	end)
    TriggerEvent('boii-outdoorweed:client:TrimmingMenu')
end)
-- Event to trim amnesia buds
RegisterNetEvent('boii-outdoorweed:client:TrimAmnesia', function()
    local playerPed = PlayerPedId()
	Core.Functions.Progressbar("trim_amnesia", Config.Lang["trimmingweed"], Config.WeedTrimTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function()
	TriggerServerEvent(AddItemEvent, "weed_amnesia", baggieAmount)
	TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_amnesia"], "add")
    TriggerEvent('boii-outdoorweed:notifications', Config.Lang['trimmedweed'], 'error')
    ClearPedTasks(playerPed)	
	end)
    TriggerEvent('boii-outdoorweed:client:TrimmingMenu')
end)
-- Event to trim purple-haze buds
RegisterNetEvent('boii-outdoorweed:client:TrimPurple', function()
    local playerPed = PlayerPedId()
	Core.Functions.Progressbar("trim_amnesia", Config.Lang["trimmingweed"], Config.WeedTrimTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function()
	TriggerServerEvent(AddItemEvent, "weed_purple-haze", baggieAmount)
	TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_purple-haze"], "add")
    TriggerEvent('boii-outdoorweed:notifications', Config.Lang['trimmedweed'], 'error')
    ClearPedTasks(playerPed)	
	end)
    TriggerEvent('boii-outdoorweed:client:TrimmingMenu')
end)
--<!>-- WEED TRIMMING CODE END --<!>--

--<!>-- JOINT ROLLING CODE START --<!>--
-- Event to roll skunk joints
RegisterNetEvent('boii-outdoorweed:client:RollSkunk', function()
    local playerPed = PlayerPedId()
	Core.Functions.Progressbar("roll_skunk", Config.Lang["rollingjoint"], Config.JointRollTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function()
	TriggerServerEvent(AddItemEvent, "weed_skunk_joint", 2)
	TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_skunk_joint"], "add")
    TriggerEvent('boii-outdoorweed:notifications', Config.Lang['rolledjoints'], 'error')
    ClearPedTasks(playerPed)	
	end)
end)
-- Event to roll kush joints
RegisterNetEvent('boii-outdoorweed:client:RollKush', function()
    local playerPed = PlayerPedId()
	Core.Functions.Progressbar("roll_kush", Config.Lang["rollingjoint"], Config.JointRollTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function()
	TriggerServerEvent(AddItemEvent, "weed_og-kush_joint", 2)
	TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_og-kush_joint"], "add")
    TriggerEvent('boii-outdoorweed:notifications', Config.Lang['rolledjoints'], 'error')
    ClearPedTasks(playerPed)	
	end)
end)
-- Event to roll white widow joints
RegisterNetEvent('boii-outdoorweed:client:RollWidow', function()
    local playerPed = PlayerPedId()
	Core.Functions.Progressbar("roll_widow", Config.Lang["rollingjoint"], Config.JointRollTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function()
	TriggerServerEvent(AddItemEvent, "weed_white-widow_joint", 2)
	TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_white-widow_joint"], "add")
    TriggerEvent('boii-outdoorweed:notifications', Config.Lang['rolledjoints'], 'error')
    ClearPedTasks(playerPed)	
	end)
end)
-- Event to roll ak47 joints
RegisterNetEvent('boii-outdoorweed:client:RollAK47', function()
    local playerPed = PlayerPedId()
	Core.Functions.Progressbar("roll_ak47", Config.Lang["rollingjoint"], Config.JointRollTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function()
	TriggerServerEvent(AddItemEvent, "weed_ak47_joint", 2)
	TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_ak47_joint"], "add")
    TriggerEvent('boii-outdoorweed:notifications', Config.Lang['rolledjoints'], 'error')
    ClearPedTasks(playerPed)	
	end)
end)
-- Event to roll amnesia joints
RegisterNetEvent('boii-outdoorweed:client:RollAmnesia', function()
    local playerPed = PlayerPedId()
	Core.Functions.Progressbar("roll_amnesia", Config.Lang["rollingjoint"], Config.JointRollTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function()
	TriggerServerEvent(AddItemEvent, "weed_amnesia_joint", 2)
	TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_amnesia_joint"], "add")
    TriggerEvent('boii-outdoorweed:notifications', Config.Lang['rolledjoints'], 'error')
    ClearPedTasks(playerPed)	
	end)
end)
-- Event to roll purple-haze joints
RegisterNetEvent('boii-outdoorweed:client:RollPurple', function()
    local playerPed = PlayerPedId()
	Core.Functions.Progressbar("roll_purple", Config.Lang["rollingjoint"], Config.JointRollTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function()
	TriggerServerEvent(AddItemEvent, "weed_purple-haze_joint", 2)
	TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_purple-haze_joint"], "add")
    TriggerEvent('boii-outdoorweed:notifications', Config.Lang['rolledjoints'], 'error')
    ClearPedTasks(playerPed)	
	end)
end)
--<!>-- JOINT ROLLING CODE END --<!>--

--<!>-- USE DRUGS CODE START --<!>--
-- Event smoke skunk joints
RegisterNetEvent('boii-outdoorweed:client:UseSkunkJoint', function()
    local playerPed = PlayerPedId()
	Core.Functions.TriggerCallback(ItemCheckEvent, function(HasItem)
		if HasItem then
            Core.Functions.Progressbar("smoke_skunk", Config.Lang["smokeskunk"], Config.SmokeJointTime, false, true,{
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@world_human_smoking_pot@female@base",
                anim = "base",
                flags = 49,
            }, {}, {}, function()
                ClearPedTasks(playerPed)
                TriggerServerEvent(RemoveItemEvent, "weed_skunk_joint", 1)
                TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_skunk_joint"], "remove")
                TriggerEvent("evidence:client:SetStatus", "agitated", 100)
                JointEffects()
                AddArmourToPed(PlayerPedId(), SkunkArmourAmount)
                TriggerServerEvent(RemoveStress, SkunkStressAmount)
            end, function()
                ClearPedTasks(playerPed)
                TriggerEvent('boii-outdoorweed:notifications', Config.Lang['cancelled'], 'error')
            end)
		else		
			TriggerEvent('boii-outdoorweed:notifications', Config.Lang['nolighter'], 'error')
		end
	end, Config.SmokeJointItem)
end)
-- Event smoke ogkush joints
RegisterNetEvent('boii-outdoorweed:client:UseKushJoint', function()
    local playerPed = PlayerPedId()
	Core.Functions.TriggerCallback(ItemCheckEvent, function(HasItem)
		if HasItem then
            Core.Functions.Progressbar("smoke_kush", Config.Lang["smokekush"], Config.SmokeJointTime, false, true,{
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@world_human_smoking_pot@female@base",
                anim = "base",
                flags = 49,
            }, {}, {}, function()
                ClearPedTasks(playerPed)
                TriggerServerEvent(RemoveItemEvent, "weed_og-kush_joint", 1)
                TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_og-kush_joint"], "remove")
                TriggerEvent("evidence:client:SetStatus", "agitated", 100)
                JointEffects()
                AddArmourToPed(PlayerPedId(), KushArmourAmount)
                TriggerServerEvent(RemoveStress, KushStressAmount)
            end, function()
                ClearPedTasks(playerPed)
                TriggerEvent('boii-outdoorweed:notifications', Config.Lang['cancelled'], 'error')
            end)
		else		
			TriggerEvent('boii-outdoorweed:notifications', Config.Lang['nolighter'], 'error')
		end
	end, Config.SmokeJointItem)
end)
-- Event smoke white widow joints
RegisterNetEvent('boii-outdoorweed:client:UseWidowJoint', function()
    local playerPed = PlayerPedId()
	Core.Functions.TriggerCallback(ItemCheckEvent, function(HasItem)
		if HasItem then
            Core.Functions.Progressbar("smoke_widow", Config.Lang["smokewidow"], Config.SmokeJointTime, false, true,{
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@world_human_smoking_pot@female@base",
                anim = "base",
                flags = 49,
            }, {}, {}, function()
                ClearPedTasks(playerPed)
                TriggerServerEvent(RemoveItemEvent, "weed_white-widow_joint", 1)
                TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_white-widow_joint"], "remove")
                TriggerEvent("evidence:client:SetStatus", "agitated", 100)
                JointEffects()
                AddArmourToPed(PlayerPedId(), WidowArmourAmount)
                TriggerServerEvent(RemoveStress, WidowStressAmount)
            end, function()
                ClearPedTasks(playerPed)
                TriggerEvent('boii-outdoorweed:notifications', Config.Lang['cancelled'], 'error')
            end)
		else		
			TriggerEvent('boii-outdoorweed:notifications', Config.Lang['nolighter'], 'error')
		end
	end, Config.SmokeJointItem)
end)
-- Event smoke ak47 joints
RegisterNetEvent('boii-outdoorweed:client:UseAK47Joint', function()
    local playerPed = PlayerPedId()
	Core.Functions.TriggerCallback(ItemCheckEvent, function(HasItem)
		if HasItem then
            Core.Functions.Progressbar("smoke_ak47", Config.Lang["smokeak47"], Config.SmokeJointTime, false, true,{
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@world_human_smoking_pot@female@base",
                anim = "base",
                flags = 49,
            }, {}, {}, function()
                ClearPedTasks(playerPed)
                TriggerServerEvent(RemoveItemEvent, "weed_ak47_joint", 1)
                TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_ak47_joint"], "remove")
                TriggerEvent("evidence:client:SetStatus", "agitated", 100)
                JointEffects()
                AddArmourToPed(PlayerPedId(), AK47ArmourAmount)
                TriggerServerEvent(RemoveStress, AK47StressAmount)
            end, function()
                ClearPedTasks(playerPed)
                TriggerEvent('boii-outdoorweed:notifications', Config.Lang['cancelled'], 'error')
            end)
		else		
			TriggerEvent('boii-outdoorweed:notifications', Config.Lang['nolighter'], 'error')
		end
	end, Config.SmokeJointItem)
end)
-- Event to smoke amnesia joints
RegisterNetEvent('boii-outdoorweed:client:UseAmnesiaJoint', function()
    local playerPed = PlayerPedId()
	Core.Functions.TriggerCallback(ItemCheckEvent, function(HasItem)
		if HasItem then
            Core.Functions.Progressbar("smoke_amneisa", Config.Lang["smokeamnesia"], Config.SmokeJointTime, false, true,{
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@world_human_smoking_pot@female@base",
                anim = "base",
                flags = 49,
            }, {}, {}, function()
                ClearPedTasks(playerPed)
                TriggerServerEvent(RemoveItemEvent, "weed_amnesia_joint", 1)
                TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_amnesia_joint"], "remove")
                TriggerEvent("evidence:client:SetStatus", "agitated", 100)
                JointEffects()
                AddArmourToPed(PlayerPedId(), AmnesiaArmourAmount)
                TriggerServerEvent(RemoveStress, AmnesiaStressAmount)
            end, function()
                ClearPedTasks(playerPed)
                TriggerEvent('boii-outdoorweed:notifications', Config.Lang['cancelled'], 'error')
            end)
		else		
			TriggerEvent('boii-outdoorweed:notifications', Config.Lang['nolighter'], 'error')
		end
	end, Config.SmokeJointItem)
end)
-- Event to smoke purple haze joints
RegisterNetEvent('boii-outdoorweed:client:UsePurpleJoint', function()
    local playerPed = PlayerPedId()
	Core.Functions.TriggerCallback(ItemCheckEvent, function(HasItem)
		if HasItem then
            Core.Functions.Progressbar("smoke_purple", Config.Lang["smokepurple"], Config.SmokeJointTime, false, true,{
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@world_human_smoking_pot@female@base",
                anim = "base",
                flags = 49,
            }, {}, {}, function()
                ClearPedTasks(playerPed)
                TriggerServerEvent(RemoveItemEvent, "weed_purple-haze_joint", 1)
                TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["weed_purple-haze_joint"], "remove")
                JointEffects()
                AddArmourToPed(PlayerPedId(), PurpleArmourAmount)
                TriggerServerEvent(RemoveStress, PurpleStressAmount)
            end, function()
                ClearPedTasks(playerPed)
                TriggerEvent('boii-outdoorweed:notifications', Config.Lang['cancelled'], 'error')
            end)
		else
            TriggerEvent('boii-outdoorweed:notifications', Config.Lang['nolighter'], 'error')		
		end
	end, Config.SmokeJointItem)
end)
--<!>-- USE DRUGS CODE END --<!>--