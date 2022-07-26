local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Seat
RegisterNetEvent('jim-mechanic:client:Seat:Apply', function(mod)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetVehiclePedIsIn(playerPed, false) pushVehicle(vehicle)
	local modName = GetLabelText(GetModTextLabel(vehicle, 32, tonumber(mod)))
	if modName == "NULL" then modName = Loc[Config.Lan]["common"].stock end
	if GetVehicleMod(vehicle, 32) == tonumber(mod) then TriggerEvent('QBCore:Notify', modName..Loc[Config.Lan]["common"].already, "error") TriggerEvent('jim-mechanic:client:Seat:Check')
	elseif GetVehicleMod(vehicle, 32) ~= tonumber(mod) then
		time = math.random(3000,5000)
		for i = 0, 5 do SetVehicleDoorOpen(vehicle, i, false, false) end
		QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing..modName.."..", time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
		{ animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 16, }, {}, {}, function()
			SetVehicleMod(vehicle, 32, tonumber(mod))
			emptyHands(playerPed)
			updateCar(vehicle)
			if Config.CosmeticRemoval then TriggerServerEvent("QBCore:Server:RemoveItem", 'seat', 1) TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['seat'], "remove", 1)
			else TriggerEvent('jim-mechanic:client:Seat:Check') end
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["seat"].installed, "success")
		end, function() -- Cancel
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["seat"].failed, "error")
			emptyHands(playerPed)
		end, "seat")
	end
end)

RegisterNetEvent('jim-mechanic:client:Seat:Check', function()
	if Config.CosmeticsJob then if not jobChecks() then return end end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local validMods = {}
	if not outCar() then return end
	if not nearPoint(coords) then return end
	local vehicle = nil
	if IsPedInAnyVehicle(playerPed, false) then	vehicle = GetVehiclePedIsIn(playerPed, false) pushVehicle(vehicle)
		for i = 1, GetNumVehicleMods(vehicle, 32) do
			if GetVehicleMod(vehicle, 32) == (i-1) then	txt = Loc[Config.Lan]["common"].current else txt = "" end
			validMods[i] = { id = (i-1), name = GetLabelText(GetModTextLabel(vehicle, 32, (i - 1))), install = txt }
		end
	end
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
		if GetNumVehicleMods(vehicle, 32) == 0 then	TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].noOptions, "error") return end				
		if GetVehicleMod(vehicle, 32) == -1 then stockinstall = Loc[Config.Lan]["common"].current else stockinstall = ""	end
		local SeatMenu = {
				{ isMenuHeader = true, header = searchCar(vehicle)..Loc[Config.Lan]["seat"].menuheader, txt = Loc[Config.Lan]["common"].amountoption..#validMods+1,	},
				{ header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "jim-mechanic:client:Menu:Close" } },
				{ header = "0. "..Loc[Config.Lan]["common"].stock, txt = stockinstall, params = { event = "jim-mechanic:client:Seat:Apply", args = -1 } } }
			for k,v in pairs(validMods) do
				SeatMenu[#SeatMenu + 1] = { header = k..". "..v.name, txt = v.install, params = { event = 'jim-mechanic:client:Seat:Apply', args = tostring(v.id) } }
			end
		exports['qb-menu']:openMenu(SeatMenu)
	end
end)