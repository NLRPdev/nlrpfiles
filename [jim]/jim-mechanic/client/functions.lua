local QBCore = exports['qb-core']:GetCoreObject()

--Don't even try to ask me how this works, found it on a tutorial site for organising tables
function pairsByKeys(t)
	local a = {}
	for n in pairs(t) do a[#a+1] = n end
	table.sort(a)
	local i = 0 
	local iter = function ()
		i = i + 1
		if a[i] == nil then return nil
		else return a[i], t[a[i]]
		end
	end
	return iter
end

function cv(amount)
    local formatted = amount
    while true do formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') if (k==0) then break end end
    return formatted
end

function toBool(int)
	if int == 0 then return false
	elseif int == 1 then return true
	else return false end
end

function IsVehicleOwned(plate)
	local p = promise.new()
	QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(cb) p:resolve(cb) end, plate)
    return Citizen.Await(p)
end

--attempt at grabbing odometer info, doesn't work as mechanicjob sets it to 0 after restart
function searchDist(vehicle)
	local p = promise.new()
	QBCore.Functions.TriggerCallback('jim-mechanic:distGrab', function(cb) p:resolve(cb) end, trim(GetVehicleNumberPlateText(vehicle)))
	dist = Citizen.Await(p)
		if dist ~= "" then
			if Config.distkph then 
				dist = Loc[Config.Lan]["functions"].distance..string.format("%.2f", (math.floor(dist) * 0.001)).."Km" 
			else 
				dist = Loc[Config.Lan]["functions"].distance..string.format("%.2f", (math.floor(dist) * 0.000621371)).."Mi"
			end
		end
	distance = nil
    return dist
end

function getClass(vehicle)
	local classlist = {
	[0] = "Compacts",  
	[1] = "Sedans",  
	[2] = "SUVs",
	[3] = "Coupes",
	[4] = "Muscle",
	[5] = "Sports Classics", 
	[6] = "Sports", 
	[7] = "Super",
	[8] = "Motorcycles",  
	[9] = "Off-road",
	[10] = "Industrial", 
	[11] = "Utility",
	[12] = "Vans",
	[13] = "Cycles", 
	[14] = "Boats",
	[15] = "Helicopters",
	[16] = "Planes",
	[17] = "Service",
	[18] = "Emergency", 
	[19] = "Military",
	[20] = "Commercial",
	[21] = "Trains", }
	return classlist[GetVehicleClass(vehicle)]
end

function useMechJob()
if GetResourceState('qb-mechanicjob') == "started" then return true else return false end
end

function getClosest(coords)
	local vehs = { 71, 0, 2, 4, 6, 7, 23, 127, 260, 2146, 2175, 12294, 16834, 16386, 20503, 32768, 67590, 67711, 98309, 100359 }
	for k, v in pairs(vehs) do if GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, v) ~= 0 then vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, v) break end end
	return vehicle
end

function searchCar(vehicle)
	local newName = nil
	for k, v in pairs(QBCore.Shared.Vehicles) do
		if tonumber(v.hash) == GetEntityModel(vehicle) then
		if Config.Debug then print("Vehicle: "..v.hash.. " ("..QBCore.Shared.Vehicles[k].name..")") end
		newName = QBCore.Shared.Vehicles[k].name.." "..QBCore.Shared.Vehicles[k].brand.."<br>"
		end
	end
	if Config.Debug then if not newName then print("Vehicle not found in shared: "..GetEntityModel(vehicle).." ("..GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()..")") end end
	if not newName then newName = string.upper(GetMakeNameFromVehicleModel(GetEntityModel(vehicle)).." "..GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))).." <br>" end	
    return newName
end

function searchPrice(vehicle)
	local price = nil
	for k, v in pairs(QBCore.Shared.Vehicles) do
		if tonumber(v.hash) == GetEntityModel(vehicle) then 
		price = cv(QBCore.Shared.Vehicles[k].price) 
		end
	end
	if not price then price = (0).."<br>" end	
    return price
end

-- Push as in push to every player
-- Doubles up as a way to reduce spam of commands
function pushVehicle(entity)
	SetVehicleModKit(entity, 0)
	NetworkRequestControlOfEntity(entity)
	local timeout = 2000
	while timeout > 0 and not NetworkHasControlOfEntity(entity) do
		Wait(100)
		timeout = timeout - 100
	end
	SetEntityAsMissionEntity(entity, true, true)
	local timeout = 2000
	while timeout > 0 and not IsEntityAMissionEntity(entity) do
		Wait(100)
		timeout = timeout - 100
	end
end

function updateCar(vehicle) -- This updates the database
	CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
	TriggerServerEvent('jim-mechanic:updateVehicle', CurrentVehicleData, trim(GetVehicleNumberPlateText(vehicle)))
	if useMechJob() then
		local mechDamages = {}
		local parts = {"radiator", "axle", "brakes", "clutch", "fuel"}
		for _, v in pairs(parts) do
			mechDamages[v] = tonumber(exports['qb-mechanicjob']:GetVehicleStatus(trim(GetVehicleNumberPlateText(vehicle)), v)) or 100
		end
		TriggerServerEvent('jim-mechanic:server:saveStatus', mechDamages, trim(GetVehicleNumberPlateText(vehicle)))
	end
	TriggerServerEvent("jim-mechanic:server:updateCar", VehToNet(vehicle), CurrentVehicleData)
end

RegisterNetEvent("jim-mechanic:forceProperties", function(vehicle, props) -- This forces updates of the vehicle from the person who updated it
	QBCore.Functions.SetVehicleProperties(NetToVeh(netid), props)
end)

function inCar()
	local inCar = false
	if IsPedSittingInAnyVehicle(PlayerPedId()) then	
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["functions"].inCar, "error") 
		inCar = false
	else inCar = true end
	return inCar
end

function outCar()
	local outCar = false
	if not IsPedSittingInAnyVehicle(PlayerPedId()) then
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["functions"].outCar, "error")
		outCar = false
	else outCar = true end
	return outCar
end

function lockedCar(vehicle)
	local locked = false
	if GetVehicleDoorLockStatus(vehicle) >= 2 then
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["functions"].locked, "error")
		locked = true
	else locked = false end
	return locked
end

function nearPoint(coords)
	if not IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["functions"].nearby, "error") near = false
	else near = true end
	return near
end

injob = nil
function locationChecks()
	local check = true
	if Config.LocationRequired then
		if not injob then
			check = false TriggerEvent('QBCore:Notify', Loc[Config.Lan]["functions"].shop, "error")
		else end
	end
	return check
end

function jobChecks()
	local check = true
	if Config.RequiresJob == true then check = false
		for k, v in pairs(Config.JobRoles) do
			if v == PlayerJob.name then check = true end
		end
		if check == false then TriggerEvent('QBCore:Notify', Loc[Config.Lan]["functions"].mechanic, "error") check = false end
	end
	return check
end

function playAnim(animDict, animName, duration, flag)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Wait(50) 
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, flag, 1, false, false, false)
    RemoveAnimDict(animDict)
end

function trim(value)
	if not value then return nil end
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

--not a function, but a widely used event
RegisterNetEvent('jim-mechanic:client:Menu:Close', function()
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	emptyHands(playerPed)
	FreezeEntityPosition(playerPed, false)	
	if IsPedSittingInAnyVehicle(PlayerPedId()) then	vehicle = GetVehiclePedIsIn(playerPed, false)
	else vehicle = getClosest(coords) end
	for i = 0, 5 do	SetVehicleDoorShut(vehicle, i, false, true) end
	exports['qb-menu']:closeMenu()
end)

function emptyHands(playerPed, dpemote)
	if dpemote then TriggerEvent('animations:client:EmoteCommandStart', {"c"})
	else ClearPedTasks(playerPed) end
	for k, v in pairs(GetGamePool('CObject')) do
		if IsEntityAttachedToEntity(playerPed, v) then
			DeleteObject(v)
			DetachEntity(v, 0, 0)
			SetEntityAsMissionEntity(v, true, true)
			Wait(100)
			DeleteEntity(v)
		end
	end
end

function doCarDamage(currentVehicle, veh)
	smash = false
	damageOutside = false
	damageOutside2 = false
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0
	if engine < 200.0 then engine = 200.0 end
    if engine > 1000.0 then engine = 1000.0 end
	if body < 150.0 then body = 150.0 smash = true end
	if body < 900.0 then smash = true end
	if body < 800.0 then damageOutside = true end
	if body < 500.0 then damageOutside2 = true end
    SetVehicleEngineHealth(currentVehicle, engine)
	if smash then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
	end
	if damageOutside then
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
	end
	if damageOutside2 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end
end

local ELECTRIC_VEHICLES = {
	[`AIRTUG`] = true,
	[`CYCLONE`] = true,
	[`CADDY`] = true,
	[`CADDY2`] = true,
	[`CADDY3`] = true,
	[`DILETTANTE`] = true,
	[`IMORGON`] = true,
	[`KHAMEL`] = true,
	[`NEON`] = true,
	[`RAIDEN`] = true,
	[`SURGE`] = true,
	[`VOLTIC`] = true,
	[`VOLTIC2`] = true,
	[`TEZERACT`] = true
}

function IsVehicleElectric(vehicle)
	local model = GetEntityModel(vehicle)
	return ELECTRIC_VEHICLES[model] or false
end

function Draw2DText(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end