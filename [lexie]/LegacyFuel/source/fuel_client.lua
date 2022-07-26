QBCore = exports['qb-core']:GetCoreObject()

local isNearPump = false
local pumpLocation = nil
local isFueling = false
local currentFuel = 0.0
local currentCost = 0.0
local fuelSynced = false
local inBlacklisted = false

local currentRefilVehicle = nil

local output = nil
RegisterNetEvent('LegacyFuel:LixeiroCB01')
AddEventHandler('LegacyFuel:LixeiroCB01', function(ret)
    output = ret
end)

RegisterNetEvent('LegacyFuel:LixeiroCB02')
AddEventHandler('LegacyFuel:LixeiroCB02', function(ret)
    output = ret
end)

function close()
	SetNuiFocus(false, false)
	SendNUIMessage({ action = false })
end

function open(vehicle,data)
	SetNuiFocus(true, true)
	SendNUIMessage({ action = true, fuel = GetVehicleFuelLevel(vehicle), data = data })
end

RegisterNUICallback('escape', function(data, cb)
    close()
	local ped = PlayerPedId()
	ClearPedTasks(ped)
	RemoveAnimDict("timetable@gardener@filling_can")
end)

RegisterNUICallback('pay', function(data, cb)
	local vehicle = nil
	if Config.EnableToxicPumpNozzles then
		vehicle = currentRefilVehicle
	else
		vehicle = GetPlayersLastVehicle()
	end
    local new_perc = tonumber(data.new_perc)
	if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(vehicle)) < 5 then
		TriggerServerEvent('LegacyFuel:pagamento01',math.floor(new_perc),false,VehToNet(vehicle),math.floor(new_perc),Config.FuelDecor,pumpLocation)
	end
end)

RegisterNUICallback('notifytext', function(data, cb)
    local text = data.text
	TriggerEvent("Notify","importante",text)
end)

RegisterNUICallback('startanim',function(data,cb)
	local ped = PlayerPedId()
	local vehicle = GetPlayersLastVehicle()
	TaskTurnPedToFaceEntity(ped,vehicle,5000)
	LoadAnimDict("timetable@gardener@filling_can")
	TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0,8.0,-1,50,0,0,0,0)
end)

RegisterNUICallback('removeanim',function(data,cb)
	local ped = PlayerPedId()
	ClearPedTasks(ped)
	RemoveAnimDict("timetable@gardener@filling_can")
end)

function ManageFuelUsage(vehicle)
	if not DecorExistOn(vehicle, Config.FuelDecor) then
		SetFuel(vehicle, math.random(200, 800) / 10)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))

		fuelSynced = true
	end

	if IsVehicleEngineOn(vehicle) then
		SetFuel(vehicle, GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
	end
end

RegisterNetEvent('LegacyFuel:galao01')
AddEventHandler('LegacyFuel:galao01',function()
	GiveWeaponToPed(PlayerPedId(),883325847,4500,false,true)

	TriggerServerEvent('QBCore:Server:AddItem', "weapon_petrolcan", 1)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["weapon_petrolcan"], "add")
	-- SetPedAmmo(ped, 883325847, 4500)
end)

Citizen.CreateThread(function()
	DecorRegister(Config.FuelDecor, 1)

	for index = 1, #Config.Blacklist do
		if type(Config.Blacklist[index]) == 'string' then
			Config.Blacklist[GetHashKey(Config.Blacklist[index])] = true
		else
			Config.Blacklist[Config.Blacklist[index]] = true
		end
	end

	for index = #Config.Blacklist, 1, -1 do
		table.remove(Config.Blacklist, index)
	end

	while true do
		Citizen.Wait(1000)

		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)

			if Config.Blacklist[GetEntityModel(vehicle)] then
				inBlacklisted = true
			else
				inBlacklisted = false
			end

			if not inBlacklisted and GetPedInVehicleSeat(vehicle, -1) == ped then
				ManageFuelUsage(vehicle)
			end
		else
			if fuelSynced then
				fuelSynced = false
			end

			if inBlacklisted then
				inBlacklisted = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)

		local pumpObject, pumpDistance = FindNearestFuelPump()

		if pumpDistance < 5 then
			pumpLocation = nil
			for k,v in pairs(Config.GasStationOwner) do 
				if GetDistanceBetweenCoords(vector3(v[1],v[2],v[3]),GetEntityCoords(pumpObject)) <= v[4] then
					pumpLocation = k
				end
			end
			isNearPump = pumpObject
		else
			isNearPump = false

			Citizen.Wait(math.ceil(pumpDistance * 20))
		end
	end
end)

RegisterNetEvent("fuel:setvehiclefuel")
AddEventHandler("fuel:setvehiclefuel",function(index,change)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			SetFuel(v, (GetVehicleFuelLevel(v) + change))
		end
	end
end)

AddEventHandler('fuel:startFuelUpTick', function(pumpObject, ped, vehicle)
	currentFuel = GetVehicleFuelLevel(vehicle)

	while isFueling do
		Citizen.Wait(1000)

		local oldFuel = GetVehicleFuelLevel(vehicle)
		local fuelToAdd = math.random(10, 20) / 10.0

		if not pumpObject then
			if GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100 >= 0 then
				currentFuel = oldFuel + fuelToAdd

				SetPedAmmo(ped, 883325847, math.floor(GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100))
			else
				TriggerEvent("Notify","importante",Config.Strings.JerryCanEmpty)
				isFueling = false
			end
		else
			currentFuel = oldFuel + fuelToAdd
		end

		if currentFuel > 100.0 then
			currentFuel = 100.0
			isFueling = false
		end

		SetFuel(vehicle, currentFuel)
	end

	if pumpObject then
		TriggerServerEvent('fuel:pay', currentCost)
	end

	currentCost = 0.0
end)

if Config.EnableToxicPumpNozzles then
	AddEventHandler('fuel:stopRefuelFromPump', function()
		if isFueling then
			SendNUIMessage({ data = "stop"})
		end
		isFueling = false
	end)

	AddEventHandler('fuel:refuelFromPump', function(ped, vehicle)
		output = nil
		TriggerServerEvent('LegacyFuel:LixeiroCB01',pumpLocation)
		while output == nil do 
			Wait(10)
		end
		currentRefilVehicle = vehicle
		open(vehicle,output)
	end)
end

if Config.EnableToxicPumpNozzles then eventName = 'fuel:refuelFromJerryCan' else eventName = 'fuel:refuelFromPump' end
AddEventHandler(eventName, function(ped, vehicle)

	output = nil
	TriggerServerEvent('LegacyFuel:LixeiroCB02')
	while output == nil do 
		Wait(10)
	end
	if output then
		isFueling = true
	end
	
	TaskTurnPedToFaceEntity(ped, vehicle, 1000)
	Citizen.Wait(1000)
	SetCurrentPedWeapon(ped, -1569615261, true)
	LoadAnimDict("timetable@gardener@filling_can")
	TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)

	TriggerEvent('fuel:startFuelUpTick', pumpObject, ped, vehicle)

	while isFueling do
		for _, controlIndex in pairs(Config.DisableKeys) do
			DisableControlAction(0, controlIndex)
		end

		local vehicleCoords = GetEntityCoords(vehicle)

		DrawText3Ds(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z + 0.5, Config.Strings.CancelFuelingJerryCan .. "\n"..Config.Strings.JerryCan..": ~g~" .. Round(GetAmmoInPedWeapon(ped, 883325847) / 4500 * 100, 1) .. "%~w~ | "..Config.Strings.Vehicle..": ~g~" .. Round(currentFuel, 1) .. "%~w~")

		if not IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
			TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
		end

		if IsControlJustReleased(0, 38) or DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) or (isNearPump and GetEntityHealth(pumpObject) <= 0) then
			isFueling = false
		end

		Citizen.Wait(0)
	end

	ClearPedTasks(ped)
	RemoveAnimDict("timetable@gardener@filling_can")
end)

Citizen.CreateThread(function()
	while not Config.EnableToxicPumpNozzles do
		local ped = PlayerPedId()

		if not isFueling and ((isNearPump and GetEntityHealth(isNearPump) > 0) or (GetSelectedPedWeapon(ped) == 883325847 and not isNearPump)) then
			if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped then
				local pumpCoords = GetEntityCoords(isNearPump)

				DrawText3Ds(pumpCoords.x, pumpCoords.y, pumpCoords.z + 1.2, Config.Strings.ExitVehicle)
			else
				local vehicle = GetPlayersLastVehicle()
				local vehicleCoords = GetEntityCoords(vehicle)

				if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(ped), vehicleCoords) < 2.5 then
					if not DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) then
						local stringCoords = GetEntityCoords(isNearPump)
						local canFuel = true
						local hasJerryCan = false

						if GetSelectedPedWeapon(ped) == 883325847 then
							hasJerryCan = true
							stringCoords = vehicleCoords

							if GetAmmoInPedWeapon(ped, 883325847) < 100 then
								canFuel = false
							end
						end

						if hasJerryCan then
							if GetVehicleFuelLevel(vehicle) < 95 then
								DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.EToRefuelJerryCan..Config.RefuelWithJerryCanCost)

								if IsControlJustReleased(0, 38) then
									TriggerEvent('fuel:refuelFromPump', ped, vehicle)
								end
							else
								DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.FullTank)
							end
						elseif GetVehicleFuelLevel(vehicle) < 95 and canFuel then
							DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.EToRefuel)

							if IsControlJustReleased(0, 38) then
								output = nil
								TriggerServerEvent('LegacyFuel:LixeiroCB01',pumpLocation)
								while output == nil do 
									Wait(10)
								end
								open(vehicle,output)
							end
						elseif not canFuel then
							DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.JerryCanEmpty)
						else
							DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.FullTank)
						end
					end
				elseif isNearPump then
					local stringCoords = GetEntityCoords(isNearPump)

					DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.PurchaseJerryCan)

					if IsControlJustReleased(0, 38) then
						TriggerServerEvent('LegacyFuel:pagamento01',Config.JerryCanCost,true)
					end
				else
					Citizen.Wait(250)
				end
			end
		else
			Citizen.Wait(250)
		end

		Citizen.Wait(0)
	end
end)

if Config.ShowNearestGasStationOnly then
	Citizen.CreateThread(function()
		local currentGasBlip = 0

		while true do
			local coords = GetEntityCoords(PlayerPedId())
			local closest = 1000
			local closestCoords

			for _, gasStationCoords in pairs(Config.GasStations) do
				local dstcheck = GetDistanceBetweenCoords(coords, gasStationCoords)

				if dstcheck < closest then
					closest = dstcheck
					closestCoords = gasStationCoords
				end
			end

			if DoesBlipExist(currentGasBlip) then
				RemoveBlip(currentGasBlip)
			end

			currentGasBlip = CreateBlip(closestCoords)

			Citizen.Wait(10000)
		end
	end)
elseif Config.ShowAllGasStations then
	Citizen.CreateThread(function()
		for _, gasStationCoords in pairs(Config.GasStations) do
			CreateBlip(gasStationCoords)
		end
	end)
end

if Config.EnableHUD then
	local function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
		SetTextFont(font)
		SetTextProportional(0)
		SetTextScale(sc, sc)
		N_0x4e096588b13ffeca(jus)
		SetTextColour(r, g, b, a)
		SetTextDropShadow(0, 0, 0, 0,255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(x - 0.1+w, y - 0.02+h)
	end

	local mph = 0
	local kmh = 0
	local fuel = 0
	local displayHud = false

	local x = 0.01135
	local y = 0.002

	Citizen.CreateThread(function()
		while true do
			local ped = PlayerPedId()

			if IsPedInAnyVehicle(ped) and not (Config.RemoveHUDForBlacklistedVehicle and inBlacklisted) then
				local vehicle = GetVehiclePedIsIn(ped)
				local speed = GetEntitySpeed(vehicle)

				mph = tostring(math.ceil(speed * 2.236936))
				kmh = tostring(math.ceil(speed * 3.6))
				fuel = tostring(math.ceil(GetVehicleFuelLevel(vehicle)))

				displayHud = true
			else
				displayHud = false

				Citizen.Wait(500)
			end

			Citizen.Wait(50)
		end
	end)

	Citizen.CreateThread(function()
		while true do
			if displayHud then
				DrawAdvancedText(0.130 - x, 0.77 - y, 0.005, 0.0028, 0.6, mph, 255, 255, 255, 255, 6, 1)
				DrawAdvancedText(0.174 - x, 0.77 - y, 0.005, 0.0028, 0.6, kmh, 255, 255, 255, 255, 6, 1)
				DrawAdvancedText(0.2195 - x, 0.77 - y, 0.005, 0.0028, 0.6, fuel, 255, 255, 255, 255, 6, 1)
				DrawAdvancedText(0.148 - x, 0.7765 - y, 0.005, 0.0028, 0.4, "mp/h              km/h              Fuel", 255, 255, 255, 255, 6, 1)
			else
				Citizen.Wait(750)
			end

			Citizen.Wait(0)
		end
	end)
end
