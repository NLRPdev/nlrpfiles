local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Exhaust
RegisterNetEvent('jim-mechanic:client:Exhaust:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	local modName = GetLabelText(GetModTextLabel(vehicle, 4, tonumber(data.id)))
	if modName == "NULL" then modName = Loc[Config.Lan]["exhaust"].stockMod end
	if GetVehicleMod(vehicle, 4) == tonumber(data.id) then
		TriggerEvent('QBCore:Notify', modName..Loc[Config.Lan]["common"].already, "error")
		TriggerEvent('jim-mechanic:client:Exhaust:Check')
	elseif GetVehicleMod(vehicle, 4) ~= tonumber(data.id) then
		time = math.random(3000,5000)
		QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing..modName.."..", time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
			{ animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
			SetVehicleMod(vehicle, 4, tonumber(data.id))	
			emptyHands(playerPed)
			updateCar(vehicle)
			if Config.CosmeticRemoval then TriggerServerEvent("QBCore:Server:RemoveItem", 'exhaust', 1) TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['exhaust'], "remove", 1)
			else TriggerEvent('jim-mechanic:client:Exhaust:Check') end
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["exhaust"].installed, "success")
		end, function()
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["exhaust"].failed, "error")
			emptyHands(playerPed)
		end, "exhaust")
	end
end)

RegisterNetEvent('jim-mechanic:client:Exhaust:Check', function()
	if Config.CosmeticsJob then if not jobChecks() then return end end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local validMods = {}
	if not inCar() then return end
	if not nearPoint(coords) then return end
	local vehicle = nil
	if not IsPedInAnyVehicle(playerPed, false) then vehicle = getClosest(coords) pushVehicle(vehicle)
		for i = 1, GetNumVehicleMods(vehicle, 4) do
			if GetVehicleMod(vehicle, 4) == (i-1) then txt = Loc[Config.Lan]["common"].current
			elseif GetVehicleMod(vehicle, 4) ~= (i-1) then txt = ""	end
			validMods[i] = { id = (i - 1), name = GetLabelText(GetModTextLabel(vehicle, 4, (i - 1))), install = txt }
		end
	end
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
		if GetVehicleMod(vehicle, 4) == -1 then	stockinstall = Loc[Config.Lan]["common"].current else stockinstall = "" end
		local ExhaustMenu = {
			{ isMenuHeader = true, header = searchCar(vehicle)..Loc[Config.Lan]["exhaust"].menuheader, txt = Loc[Config.Lan]["common"].amountoption..#validMods+1, },
			{ header = "", txt = "❌ Close", params = { event = "jim-mechanic:client:Menu:Close" } },
			{ header = "0. "..Loc[Config.Lan]["common"].stock, txt = stockinstall,	params = { event = "jim-mechanic:client:Exhaust:Apply", args = { id = -1 } } }, }
			for k,v in pairs(validMods) do
				ExhaustMenu[#ExhaustMenu + 1] = { header = k..". "..v.name, txt = v.install, params = { event = 'jim-mechanic:client:Exhaust:Apply', args = { id = tostring(v.id) } } }
			end
		exports['qb-menu']:openMenu(ExhaustMenu)
	end
end)