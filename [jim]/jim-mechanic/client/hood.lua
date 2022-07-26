local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Hood
RegisterNetEvent('jim-mechanic:client:Hood:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	local modName = GetLabelText(GetModTextLabel(vehicle, 7, tonumber(data.id)))
	if modName == "NULL" then modName = Loc[Config.Lan]["hood"].stockMod end
	if GetVehicleMod(vehicle, 7) == tonumber(data.id) then
		TriggerEvent('QBCore:Notify', modName..Loc[Config.Lan]["hood"].installed, "error")
		TriggerEvent('jim-mechanic:client:Hood:Check')
	elseif GetVehicleMod(vehicle, 7) ~= tonumber(data.id) then
		time = math.random(3000,5000)
		QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing..modName.."..", time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
		{ animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, }, {}, {}, function()
			SetVehicleDoorOpen(vehicle, 4, false, false)
			Wait(500)
			SetVehicleMod(vehicle, 7, tonumber(data.id))
			Wait(500)
			SetVehicleDoorShut(vehicle, 4, false)
			updateCar(vehicle)
			emptyHands(playerPed)
			if Config.CosmeticRemoval then TriggerServerEvent("QBCore:Server:RemoveItem", 'hood', 1) TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['hood'], "remove", 1)
			else TriggerEvent('jim-mechanic:client:Hood:Check') end
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["hood"].installed, "success")
		end, function()
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["hood"].failed, "error")
			emptyHands(playerPed)
		end, "hood")
	end
end)

RegisterNetEvent('jim-mechanic:client:Hood:Check', function()
	if Config.CosmeticsJob then if not jobChecks() then return end end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local validMods = {}
	if not inCar() then return end
	if not nearPoint(coords) then return end
	local vehicle = nil
	if not IsPedInAnyVehicle(playerPed, false) then vehicle = getClosest(coords) pushVehicle(vehicle)
		for i = 1, GetNumVehicleMods(vehicle, 7) do
			if GetVehicleMod(vehicle, 7) == (i-1) then txt = Loc[Config.Lan]["common"].current else txt = ""	end
			validMods[i] = { id = (i-1), name = GetLabelText(GetModTextLabel(vehicle, 7, (i - 1))), install = txt }
		end
	end
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
		if GetNumVehicleMods(vehicle, 7) == 0 then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].noOptions, "error") return	end				
		if GetVehicleMod(vehicle, 7) == -1 then stockinstall = Loc[Config.Lan]["hood"].chooseinstalled else stockinstall = "" end
		local HoodMenu = {
				{ isMenuHeader = true, header = searchCar(vehicle)..Loc[Config.Lan]["hood"].menuheader, txt = Loc[Config.Lan]["common"].amountoption..#validMods+1, },
				{ header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "jim-mechanic:client:Menu:Close" } },
				{ header = "0. "..Loc[Config.Lan]["common"].stock, txt = stockinstall,	params = { event = "jim-mechanic:client:Hood:Apply", args = { id = -1 } } }, }
			for k,v in pairs(validMods) do
				HoodMenu[#HoodMenu + 1] = { header = k..". "..v.name, txt = v.install, params = { event = 'jim-mechanic:client:Hood:Apply', args = { id = tostring(v.id) } } }
			end
		exports['qb-menu']:openMenu(HoodMenu)
	end
end)