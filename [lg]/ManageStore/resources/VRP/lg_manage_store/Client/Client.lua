local drawn_marker = false
local pos_close = nil
local marker = nil
local openned = false
local notify_open = false

local mission_started = false
local mission_point_start = nil
local mission_point_end = nil
local mission_name = nil
local mission_position = nil
local vehicle = nil
local draw_marker_mission = false
local step = 0

local configurated = false

RegisterKeyMapping('OpenStores:'..key_open, 'Open Store', 'keyboard', key_open)
RegisterCommand('OpenStores:'..key_open, function()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped)
		
	local closest, dist, dist2, position = closestStore()

	if dist < radius_coord then
		if not openned then
			TriggerServerEvent('lg_stores: OpenStore', closest, position.buy_items)
			openned = true
		end
	elseif dist2 < radius_coord then
		if not openned then
			TriggerServerEvent('lg_stores: CheckOwnerStore', closest, position.buy_items)
		end
	end
end)

RegisterNetEvent('lg_stores: OpenStore')
AddEventHandler('lg_stores: OpenStore', function(name, items)
	OpenStore(name, items)
	openned = true
end)

RegisterNetEvent('lg_stores: OpenDashboard')
AddEventHandler('lg_stores: OpenDashboard', function(name, balance)
	OpenDashboard(name, balance)
	openned = true
end)

RegisterNetEvent('lg_stores: OpenBuyStore')
AddEventHandler('lg_stores: OpenBuyStore', function(name)
	OpenBuyStore(name)
	openned = true
end)

function SetConfigs()
	if not configurated then
		SendNUIMessage({
			config = true,
			translate = translate,
			weightSystem = use_weight_system,
			NameResource = {GetCurrentResourceName(),
			GetCurrentServerEndpoint()
			}
		})

		configurated = true
	end
end

function OpenStore(name, items)
	SetConfigs()

	SendNUIMessage({
		open = true,
		store_title = name,
		items = items,
		color_header = stores[name].color_header,
		color_buttons = stores[name].color_buttons
	})

	SetNuiFocus(true, true)
end

function OpenBuyStore(name)
	SetConfigs()

	SendNUIMessage({
		open_buy = true,
		store_title = name,
		color_header = stores[name].color_header,
		color_buttons = stores[name].color_buttons,
		price_store = stores[name].price_store
	})

	SetNuiFocus(true, true)
end

function OpenDashboard(name, balance)
	SetConfigs()
	
	SendNUIMessage({
		open_dashboard = true,
		store_title = name,
		color_header = stores[name].color_header,
		color_buttons = stores[name].color_buttons,
		price_store = stores[name].price_store,
		percentage_sell = stores[name].percentage_sell
	})

	SetNuiFocus(true, true)
end

CreateThread(function()
	while true do
		local ped = GetPlayerPed(-1)
		local pos = GetEntityCoords(ped)
		
		local closest, dist, dist2, position = closestStore()
		
		if dist < radius_coord then
			if not notify_open then
				showNotification(translate.TR_PRESS_BUTTON .. key_open)
				notify_open = true
			end
		elseif dist2 < radius_coord then
			if not notify_open then
				showNotification(translate.TR_PRESS_BUTTON .. key_open)
				notify_open = true
			end
		elseif dist < 50.0 then
			pos_close = position
			marker = stores[closest].marker
			drawn_marker = true
			openned = false
			notify_open = false
		else
			drawn_marker = false					
			pos_close = nil
			marker = nil
			openned = false
			notify_open = false
		end

		if mission_started then
			if step == 0 then
				local dist_start = #(pos - mission_point_start)
				if dist_start < radius_coord then
					local veh = GetVehiclePedIsIn(ped, false)

					if veh ~= 0 then
						step = 1
						
						showNotification(translate.TR_WAIT_PRODUCTS)
						SetTimeout(2000, function()
							vehicle = GetEntityModel(veh)
							DeleteWaypoint()
							SetNewWaypoint(mission_point_end.x, mission_point_end.y)
							showNotification(translate.TR_GO_STORE)
						end)
					end

				elseif dist_start < 50.0 then
					draw_marker_mission = true
				else
					draw_marker_mission = false
				end
			elseif step == 1 then
				local dist_end = #(pos - mission_point_end)
				if dist_end < radius_coord then
					local veh = GetVehiclePedIsIn(ped, false)

					if veh ~= 0 then
						if vehicle == GetEntityModel(veh) then
							TriggerServerEvent('lg_stores: CompleteMission', mission_name, mission_position.buy_items)

							mission_started = false
							mission_point_start = nil
							mission_point_end = nil
							mission_name = nil
							mission_position = nil
							vehicle = nil
							draw_marker_mission = false
							step = 0
						end
					end

				elseif dist_end < 50.0 then
					draw_marker_mission = true
				else
					draw_marker_mission = false
				end
			end
		end
		
		Wait(2000)
	end
end)

CreateThread(function()
	while true do
		local sleep = 0
		if drawn_marker then
			sleep = 0

			pos_buy_items = pos_close.buy_items
			pos_buy_store = pos_close.buy_store

			DrawMarker(marker, pos_buy_items.x, pos_buy_items.y, pos_buy_items.z-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.75, 0, 255, 0, 100, false, true, 2, false, false, false, false)
			DrawMarker(marker, pos_buy_store.x, pos_buy_store.y, pos_buy_store.z-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.75, 0, 255, 0, 100, false, true, 2, false, false, false, false)
		else
			sleep = 1000
		end

		if draw_marker_mission then
			sleep = 0

			DrawMarker(2, mission_point_start.x, mission_point_start.y, mission_point_start.z-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.75, 0, 255, 0, 100, false, true, 2, false, false, false, false)
			DrawMarker(2, mission_point_end.x, mission_point_end.y, mission_point_end.z-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.75, 0, 255, 0, 100, false, true, 2, false, false, false, false)
		end

		Wait(sleep)
	end
end)

RegisterNetEvent('lg_stores: SendPopMessage')
AddEventHandler('lg_stores: SendPopMessage', function(type, message)
	SendNUIMessage({
		pop_up = true,
		type = type,
		message = message
	})
end)

RegisterNetEvent('lg_stores: LoadBalance')
AddEventHandler('lg_stores: LoadBalance', function(money)
	SendNUIMessage({
		loadBalance = true,
		money = money
	})
end)

RegisterNetEvent('lg_stores: LoadStock')
AddEventHandler('lg_stores: LoadStock', function(stock, products)
	SendNUIMessage({
		loadStock = true,
		stock = stock,
		products = products
	})
end)

RegisterNetEvent('lg_stores: LoadMissions')
AddEventHandler('lg_stores: LoadMissions', function(missions, identifier)
	SendNUIMessage({
		loadMissions = true,
		request = missions,
		identifier = identifier
	})
end)

RegisterNetEvent('lg_stores: AcceptMission')
AddEventHandler('lg_stores: AcceptMission', function(name, item_name)
	if not mission_started then
		local closest, dist, dist2, position = closestStore()

		mission_name = name		
		mission_position = position
		mission_point_end = position.mission

		if missions_coords[item_name] then
			local rand_point = math.random(1, #missions_coords[item_name])
			mission_point_start = missions_coords[item_name][rand_point]
		else
			local rand_point = math.random(1, #missions_coords['RANDOM_MISSION'])
			mission_point_start = missions_coords['RANDOM_MISSION'][rand_point]
		end

		-- print(mission_point_start)

		DeleteWaypoint()
		SetNewWaypoint(mission_point_start.x, mission_point_start.y)

		mission_started = true
	end
end)

RegisterNetEvent('lg_stores: CancelMission')
AddEventHandler('lg_stores: CancelMission', function()
	mission_started = false
	mission_point_start = nil
	mission_point_end = nil
	mission_name = nil
	mission_position = nil
	vehicle = nil
	draw_marker_mission = false
	step = 0

	DeleteWaypoint()
end)

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false, false)
	openned = false
	cb('ok')
end)

RegisterNUICallback('buyItens', function(data, cb)
	local closest, dist, dist2, position = closestStore()

	TriggerServerEvent("lg_stores: BuyItens", closest, position.buy_items, data)
	cb('ok')
end)

RegisterNUICallback('sendBuyStore', function(data, cb)
	local closest, dist, dist2, position = closestStore()
	
	TriggerServerEvent("lg_stores: SendBuyStore", closest, position.buy_items)
	cb('ok')
end)

RegisterNUICallback('sendSellStore', function(data, cb)
	local closest, dist, dist2, position = closestStore()
	
	TriggerServerEvent("lg_stores: SendSellStore", closest, position.buy_items)
	cb('ok')
end)

RegisterNUICallback('sendAddMoney', function(data, cb)
	local closest, dist, dist2, position = closestStore()
	
	TriggerServerEvent("lg_stores: SendAddMoney", closest, position.buy_items, data)
	cb('ok')
end)

RegisterNUICallback('sendWithdraw', function(data, cb)
	local closest, dist, dist2, position = closestStore()
	
	TriggerServerEvent("lg_stores: SendWithdraw", closest, position.buy_items, data)
	cb('ok')
end)

RegisterNUICallback('sendPutForSale', function(data, cb)
	local closest, dist, dist2, position = closestStore()
	
	TriggerServerEvent("lg_stores: SendPutForSale", closest, position.buy_items, data)
	cb('ok')
end)

RegisterNUICallback('sendRequestItem', function(data, cb)
	local closest, dist, dist2, position = closestStore()
	
	TriggerServerEvent("lg_stores: SendRequestItem", closest, position.buy_items, data)
	cb('ok')
end)

RegisterNUICallback('sendRemoveItem', function(data, cb)
	local closest, dist, dist2, position = closestStore()
	
	TriggerServerEvent("lg_stores: SendRemoveItem", closest, position.buy_items, data)
	cb('ok')
end)

RegisterNUICallback('sendChangePrice', function(data, cb)
	local closest, dist, dist2, position = closestStore()
	
	TriggerServerEvent("lg_stores: SendChangePrice", closest, position.buy_items, data)
	cb('ok')
end)

RegisterNUICallback('acceptMission', function(data, cb)
	local closest, dist, dist2, position = closestStore()
	
	TriggerServerEvent("lg_stores: AcceptMission", closest, position.buy_items, data)
	cb('ok')
end)

RegisterNUICallback('cancelMission', function(data, cb)
	local closest, dist, dist2, position = closestStore()
	
	TriggerServerEvent("lg_stores: CancelMission", closest, position.buy_items, data)
	cb('ok')
end)

RegisterNUICallback('loadBalance', function(data, cb)
	local closest, dist, dist2, position = closestStore()
	
	TriggerServerEvent("lg_stores: LoadBalance", closest, position.buy_items)
	cb('ok')
end)

RegisterNUICallback('loadStock', function(data, cb)
	local closest, dist, dist2, position = closestStore()
	
	TriggerServerEvent("lg_stores: LoadStock", closest, position.buy_items)
	cb('ok')
end)

RegisterNUICallback('loadMissions', function(data, cb)
	local closest, dist, dist2, position = closestStore()
	
	TriggerServerEvent("lg_stores: LoadMissions", closest, position.buy_items)
	cb('ok')
end)

CreateThread(function()
    --while not NetworkIsSessionStarted() do Wait(100) end
	while not DoesEntityExist(GetPlayerPed(-1)) do Wait(1000) end
	
	Wait(1000)

	for i,k in pairs(stores) do
		if k.use_blip then
			for c,j in pairs(k.coordinates) do
				local blip = AddBlipForCoord(j.buy_items.x, j.buy_items.y, j.buy_items.z)
				SetBlipSprite(blip, k.blip)
				SetBlipColour(blip, k.blip_color)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(k.blip_name)
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

function closestStore()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped)
	local min = 99999
	local buy = 99999

	local closest = -1
	local position = nil

	for i,k in pairs(stores) do
		for c,j in pairs(k.coordinates) do
			local dist = #(j.buy_items - pos)

			if dist < min then
				closest = i
				min = dist
				buy = #(j.buy_store - pos)
				position = j
			end
		end
	end

	return closest, min, buy, position
end

function showNotification(message)
    TriggerEvent('esx:showNotification', message)
    TriggerEvent('chat:addMessage', { args = { message }})
end