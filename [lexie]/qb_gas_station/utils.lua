QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("gas_station:Notify")
AddEventHandler("gas_station:Notify", function(type,msg)
	-- Você pode mudar a notificação como desejar
	SendNUIMessage({ 
		notification = msg,
		notification_type = type,
	})

	-- local prefix = ""
	-- if type == "negado" then
	-- 	prefix = "~r~"
    -- elseif type == "importante" then
	-- 	prefix = "~y~"
    -- elseif type == "sucesso" then
    --     prefix = "~g~"
	-- end
	-- SetNotificationTextEntry("STRING")
	-- AddTextComponentString(prefix..msg)
	-- DrawNotification(false, false)
end)

function DrawMarker_blip(x,y,z)
	DrawMarker(21,x,y,z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
end
function DrawMarker_truck(x,y,z)
	DrawMarker(39,x,y,z-0.6,0,0,0,0.0,0,0,1.0,1.0,1.0,255,0,0,50,0,0,0,1)
end

function DrawText3D2(x,y,z, text, size)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = #(vector3(px,py,pz) - vector3(x,y,z))
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, size*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- spawnVehicle
-----------------------------------------------------------------------------------------------------------------------------------------

function spawnVehicle(name,x,y,z,h)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		local veh = CreateVehicle(mhash,x,y,z+0.5,h,true,false)
		local netid = NetworkGetNetworkIdFromEntity(veh)
		SetVehicleHasBeenOwnedByPlayer(veh, true)
		SetNetworkIdCanMigrate(netid, true)
		SetVehicleNeedsToBeHotwired(veh, false)
		SetVehRadioStation(veh, 'OFF')
		SetModelAsNoLongerNeeded(model)

        SetVehicleNumberPlateText(veh, Lang[Config.lang]['truck_plate']..tostring(math.random(1000, 9999)))
		TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))

		SetVehicleFuelLevel(veh,100.0)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
		DecorSetFloat(veh, "_FUEL_LEVEL", GetVehicleFuelLevel(veh))

		local blip = AddBlipForEntity(veh)
		SetBlipSprite(blip,477)
		SetBlipColour(blip,26)
		SetBlipAsShortRange(blip,false)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Lang[Config.lang]['truck_blip'])
		EndTextCommandSetBlipName(blip)

		return veh,blip
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- addBlip
-----------------------------------------------------------------------------------------------------------------------------------------
local gas_station_blips = {}

function addBlip(x,y,z,idtype,idcolor,text,scale)
	if idtype ~= 0 then
		local blip = AddBlipForCoord(x,y,z)
		SetBlipSprite(blip,idtype)
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,idcolor)
		SetBlipScale(blip,scale)

		if text then
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(text)
			EndTextCommandSetBlipName(blip)
		end
		return blip
	end
end

Citizen.CreateThread(function()
	Wait(5000)
	TriggerServerEvent("gas_station:getBlips")
end)

RegisterNetEvent('gas_station:setBlips')
AddEventHandler('gas_station:setBlips', function(blips_table)
	for k,v in pairs(Config.gas_station_locations) do
		local x,y,z = table.unpack(v.coord)
		local blips = Config.gas_station_types[v.type].blips
		if blips_table[k] and blips_table[k].gas_station_blip and blips_table[k].gas_station_name and blips_table[k].gas_station_color then
			gas_station_blips[k] = addBlip(x,y,z,tonumber(blips_table[k].gas_station_blip),tonumber(blips_table[k].gas_station_color),blips_table[k].gas_station_name,blips.scale)
		else
			gas_station_blips[k] = addBlip(x,y,z,blips.id,blips.color,blips.name,blips.scale)
		end
	end
end)

RegisterNetEvent('gas_station:updateBlip')
AddEventHandler('gas_station:updateBlip', function(key,name,color,blip)
	RemoveBlip(gas_station_blips[key])
	local x,y,z = table.unpack(Config.gas_station_locations[key].coord)
	local blips = Config.gas_station_types[Config.gas_station_locations[key].type].blips
	gas_station_blips[key] = addBlip(x,y,z,tonumber(blip),tonumber(color),name,blips.scale)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- IsSpawnPointClear
-----------------------------------------------------------------------------------------------------------------------------------------

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end

	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))

		if distance <= maxDistance then
			table.insert(nearbyEntities, isPlayerEntities and k or entity)
		end
	end

	return nearbyEntities
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		local next = true

		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

GetVehicles = function()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

GetVehiclesInArea = function(coords, maxDistance) return EnumerateEntitiesWithinDistance(GetVehicles(), false, coords, maxDistance) end
IsSpawnPointClear = function(coords, maxDistance) return #GetVehiclesInArea(coords, maxDistance) == 0 end

-----------------------------------------------------------------------------------------------------------------------------------------
-- createBlip
-----------------------------------------------------------------------------------------------------------------------------------------

function createBlip(x,y,z)
	blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip,478)
	SetBlipColour(blip,5)
	SetBlipAsShortRange(blip,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Lang[Config.lang]['blip_route'])
	EndTextCommandSetBlipName(blip)
	SetBlipRoute(blip, 1)
	return blip
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- showScaleform
-----------------------------------------------------------------------------------------------------------------------------------------

function showScaleform(title, desc, sec)
	function Initialize(scaleform)
		local scaleform = RequestScaleformMovie(scaleform)

		while not HasScaleformMovieLoaded(scaleform) do
			Citizen.Wait(0)
		end
		PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
		PushScaleformMovieFunctionParameterString(title)
		PushScaleformMovieFunctionParameterString(desc)
		PopScaleformMovieFunctionVoid()
		return scaleform
	end
	scaleform = Initialize("mp_big_message_freemode")
	while sec > 0 do
		sec = sec - 0.02
		Citizen.Wait(0)
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
	end
	SetScaleformMovieAsNoLongerNeeded(scaleform)
end