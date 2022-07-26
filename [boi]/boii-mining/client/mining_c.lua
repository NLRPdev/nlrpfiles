-------------------------------
---------- CASE#2506 ----------
-------------------------------

local QBCore = exports['qb-core']:GetCoreObject()

--<!>-- DO NOT CHANGE ANYTHING BELOW THIS TEXT OR THE SCRIPT WILL NOT WORK CORRECTLY! SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS! --<!>--
local spawnedrocks = 0
local paydirtrocks = {}
local isPickingUp = false
local isProcessing = false
local MiningItem = Config.MiningItem
--<!>-- DO NOT CHANGE ANYTHING ABOVE THIS TEXT OR THE SCRIPT WILL NOT WORK CORRECTLY! SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS! --<!>--

--<!>-- BLIPS CODE START --<!>--
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
--<!>-- BLIPS CODE END --<!>--

--<!>-- PED LOCATION AND SPAWN CODE START --<!>--
local paydirtped = {
  {2952.98, 2788.44, 40.54,"Cletus",280.70,0xCAE9E5D5,"csb_cletus"}, -- Meth processing ped and location

}
-- Spawns processing ped
Citizen.CreateThread(function()
    for _,v in pairs(paydirtped) do
        RequestModel(GetHashKey(v[7]))
        while not HasModelLoaded(GetHashKey(v[7])) do
            Wait(1)
        end
        PaydirtPed =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
        SetEntityHeading(PaydirtPed, v[5])
        FreezeEntityPosition(PaydirtPed, true)
        SetEntityInvincible(PaydirtPed, true)
        SetBlockingOfNonTemporaryEvents(PaydirtPed, true)
        TaskStartScenarioInPlace(PaydirtPed, "WORLD_HUMAN_CLIPBOARD", 0, true) 
    end
end)
--<!>-- PED LOCATION AND SPAWN CODE END --<!>--

--<!>-- TARGETING CODE START --<!>--
-- Targeting for mining store ped
exports['qb-target']:AddTargetModel(`csb_cletus`, {
    options = {
        {
            event = "boii-mining:client:PaydirtPed",
            icon = "fab fa-gem",
            label = "Speak with Cletus",           
        },
    },
distance = 2.0 
})
-- Rocks targetting
exports['qb-target']:AddTargetModel(`h4_prop_rock_med_01`, {
    options = {
        {
            event = "boii-mining:client:PaydirtMining",
            icon = "fas fa-gem",
            label = "Drill for Paydirt",
            item = MiningItem,
        },
    },
    distance = 2.0
})
-- Paydirt p
exports['qb-target']:AddBoxZone("PayDirt", Config.PaydirtProcessing, 1.0, 40.0, {
    name="PayDirt",
    heading= 235.339,
    debugPoly=false,
    minZ=30.664,
    maxZ=40.664
    }, {
    options = {
        {
            event = "boii-mining:client:PaydirtProcessingMenu",
            icon = "fas fa-gem", 
            label = "Process Paydirt",
        },
    },
    distance = 3.5
})
--<!>-- TARGETING CODE END --<!>--

--<!>-- MENUS CODE START --<!>--
-- Mining ped shop menu
RegisterNetEvent('boii-mining:client:PaydirtPed', function()
    exports['qb-menu']:openMenu({
        {
            header = "Mining",
            txt = "You need a permit to mine this here quarry!",
            isMenuHeader = true
        },
		{
            header = "Mining Permits",
            txt = "Purchase a mining permit here.",
            params = {
                event = "boii-mining:client:OpenMiningShop",
            }
        },
        {
            header = "< Exit",
            params = {
                event = "boii-mining:client:StopMenu"
            }
        },
    })
end)
-- Main cocaine processing menu
RegisterNetEvent('boii-mining:client:PaydirtProcessingMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "Paydirt Processing",
            txt = "Is there gold waiting for you?",
            isMenuHeader = true
        },
        {
            header = "Process Paydirt",
            txt = "I wonder what will be inside?",
            params = {
                event = "boii-mining:server:ProcessPaydirt",
                isServer = true,
                args = 1,
            }
        },
		{
            header = "Process Premuium Paydirt",
            txt = "I wonder what will be inside?",
            params = {
                event = "boii-mining:server:ProcessPaydirt",
                isServer = true,
                args = 2,
            }
        },
        {
            header = "< Exit",
            params = {
                event = "boii-mining:client:StopMenu"
            }
        },
    })
end)
--<!>-- MENUS CODE START --<!>--

--<!>-- PAYDIRT MINING CODE START --<!>--
-- Event to mine paydirt
RegisterNetEvent('boii-mining:client:PaydirtMining', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID
	for i=1, #paydirtrocks, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(paydirtrocks[i]), false) < 1.2 then
			nearbyObject, nearbyID = paydirtrocks[i], i
		end
	end
	local playerPed = PlayerPedId()
    local model = loadModel(GetHashKey(Config.Objects['drill']))
    local drill = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
    AttachEntityToEntity(drill, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.09, 0.03, -0.02, 0.0, 0.0, 0.0, false, true, true, true, 0, true)
    Citizen.Wait(10)
    QBCore.Functions.Progressbar("paydirt_mining", Config.Lang['miningrocks'], Config.MiningTime, false, true,{
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@world_human_const_drill@male@drill@base",
        anim = "base"
    }, {}, {}, function()              
    DeleteObject(drill)
    ClearPedTasks(playerPed)
    end)
    Wait(Config.MiningTime)
    DeleteObject(nearbyObject) 
    table.remove(paydirtrocks, nearbyID)
    spawnedrocks = spawnedrocks - 1
    TriggerServerEvent('boii-mining:server:PaydirtMining')
end)
--<!>-- PAYDIRT MINING CODE END --<!>--

-- Event to process cocaine into crack ounces
RegisterNetEvent('boii-mining:client:ProcessPaydirt', function()
    local playerPed = PlayerPedId()
    local paydirtitems = Config.PaydirtItems[math.random(1, #Config.PaydirtItems)]
	QBCore.Functions.Progressbar("process_paydirt", Config.Lang["processingpaydirt"], Config.PaydirtProcessTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
    }, {}, {}, function()
    ClearPedTasks(playerPed)	
    TriggerServerEvent("QBCore:Server:AddItem", paydirtitems, math.random(5,10))
	TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[paydirtitems], 'add')
    end)
end)
RegisterNetEvent('boii-mining:client:ProcessPremiumPaydirt', function()
    local playerPed = PlayerPedId()
    local prempaydirtitems = Config.PremPaydirtItems[math.random(1, #Config.PremPaydirtItems)]
	QBCore.Functions.Progressbar("process_paydirt", Config.Lang["processingprempaydirt"], Config.PaydirtPremProcessTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
    }, {}, {}, function()
    ClearPedTasks(playerPed)	
    TriggerServerEvent("QBCore:Server:AddItem", prempaydirtitems, math.random(1,2))
	TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[prempaydirtitems], 'add')
    end)
end)
--<!>-- PROCESSING CODE END --<!>--

--<!>-- DO NOT CHANGE ANYTHING INSIDE THIS SECTION UNLESS YOU KNOW WHAT YOU ARE DOING --<!>--
-- Get coords
CreateThread(function()
	while true do
		Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, Config.PaydirtMining, true) < 50 then
			SpawnPaydirtRocks()
			Wait(500)
		else
			Wait(500)
		end
	end
end)
-- Delete spawned plants on stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(paydirtrocks) do
			DeleteObject(v)
		end
	end
end)
-- Spawn plants
function SpawnMiningObject(model, coords, cb)
	local model = (type(model) == 'number' and model or GetHashKey(model))
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end
    local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, true)
    SetModelAsNoLongerNeeded(model)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    if cb then
        cb(obj)
    end
end
-- Gen coords for plants
function SpawnPaydirtRocks()
	while spawnedrocks < 15 do
		Wait(1)
		local rockCoords = GeneratePaydirtCoords()
		SpawnMiningObject('h4_prop_rock_med_01', rockCoords, function(obj)
			table.insert(paydirtrocks, obj)
			spawnedrocks = spawnedrocks + 1
		end)
	end
end 
-- Coord validation
function ValidatePaydirtCoords(paydirtCoord)
	if spawnedrocks > 0 then
		local validate = true
		for k, v in pairs(paydirtrocks) do
			if GetDistanceBetweenCoords(paydirtCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(paydirtCoord, Config.PaydirtMining, false) > 50 then
			validate = false
		end
		return validate
	else
		return true
	end
end
-- Generate Box Coords
function GeneratePaydirtCoords()
	while true do
		Wait(1)
		local rockCoordX, rockCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)
		Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)
		rockCoordX = Config.PaydirtMining.x + modX
		rockCoordY = Config.PaydirtMining.y + modY
		local coordZ = GetCoordZPaydirt(rockCoordX, rockCoordY)
		local coord = vector3(rockCoordX, rockCoordY, coordZ)
		if ValidatePaydirtCoords(coord) then
			return coord
		end
	end
end
-- Check height coords
function GetCoordZPaydirt(x, y)
	local groundCheckHeights = { 35, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0 }
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end
	return 53.85
end
--<!>-- DO NOT CHANGE ANYTHING INSIDE THIS SECTION UNLESS YOU KNOW WHAT YOU ARE DOING --<!>--