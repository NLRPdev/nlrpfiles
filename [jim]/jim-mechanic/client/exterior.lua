local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Exterior
RegisterNetEvent('jim-mechanic:client:Exterior:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	local modName = GetLabelText(GetModTextLabel(vehicle, tonumber(data.mod), tonumber(data.id)))
	if modName == "NULL" then modName = Loc[Config.Lan]["exterior"].stockMod end
	if GetVehicleMod(vehicle, tonumber(data.mod)) == tonumber(data.id) then
		TriggerEvent('QBCore:Notify', modName..Loc[Config.Lan]["common"].already, "error")
		TriggerEvent('jim-mechanic:client:Exterior:Choose', data)
	elseif GetVehicleMod(vehicle, tonumber(data.mod)) ~= tonumber(data.id) then
		time = math.random(3000,5000)
		QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing..modName.."..", time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
		{ animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
			SetVehicleMod(vehicle, tonumber(data.mod), tonumber(data.id))
			emptyHands(playerPed)
			updateCar(vehicle)
			if Config.CosmeticRemoval then TriggerServerEvent("QBCore:Server:RemoveItem", 'externals', 1) TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['externals'], "remove", 1)
			else TriggerEvent('jim-mechanic:client:Exterior:Choose', data) end
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["exterior"].installed, "success")
		end, function() -- Cancel
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["exterior"].failed, "error")
			emptyHands(playerPed)
		end, "externals")
	end
end)

RegisterNetEvent('jim-mechanic:client:Exterior:Check', function()
	if Config.CosmeticsJob then if not jobChecks() then return end end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)  
	if not inCar() then return end
	if not nearPoint(coords) then return end
	local vehicle = nil
	if not IsPedInAnyVehicle(playerPed, false) then	vehicle = getClosest(coords) pushVehicle(vehicle) end
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
	
		local exterior = { 27, 44, 37, 39, 40, 41, 38, 42, 45, 43 }
		local external = nil
		for k, v in pairs(exterior) do if GetNumVehicleMods(vehicle, v) ~= 0 then external = true break else external = nil end end
		if external ~= true then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].noOptions, "error") return end
		local ExteriorMenu = {
			{ isMenuHeader = true, header = searchCar(vehicle)..Loc[Config.Lan]["exterior"].menuheader, },
			{ header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "jim-mechanic:client:Menu:Close" } } }
		installed2 = GetLabelText(GetModTextLabel(vehicle, 27, GetVehicleMod(vehicle, 27)))	if installed2 == "NULL" then installed2 = Loc[Config.Lan]["common"].stock else end
		if GetNumVehicleMods(vehicle, 27) ~= 0 then ExteriorMenu[#ExteriorMenu + 1] = { header = Loc[Config.Lan]["exterior"].label1, txt = "["..(GetNumVehicleMods(vehicle, 27)+1)..Loc[Config.Lan]["common"].menuinstalled..installed2, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 27 } } } end
		installed3 = GetLabelText(GetModTextLabel(vehicle, 44, GetVehicleMod(vehicle, 44)))	if installed3 == "NULL" then installed3 = Loc[Config.Lan]["common"].stock else end
		if GetNumVehicleMods(vehicle, 44) ~= 0 then ExteriorMenu[#ExteriorMenu + 1] = { header = Loc[Config.Lan]["exterior"].label2, txt = "["..(GetNumVehicleMods(vehicle, 44)+1)..Loc[Config.Lan]["common"].menuinstalled..installed3, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 44 } } } end
		installed4 = GetLabelText(GetModTextLabel(vehicle, 37, GetVehicleMod(vehicle, 37)))	if installed4 == "NULL" then installed4 = Loc[Config.Lan]["common"].stock else end
		if GetNumVehicleMods(vehicle, 37) ~= 0 then ExteriorMenu[#ExteriorMenu + 1] = { header = Loc[Config.Lan]["exterior"].label3, txt = "["..(GetNumVehicleMods(vehicle, 37)+1)..Loc[Config.Lan]["common"].menuinstalled..installed4, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 37 } } } end
		installed5 = GetLabelText(GetModTextLabel(vehicle, 39, GetVehicleMod(vehicle, 39)))	if installed5 == "NULL" then installed5 = Loc[Config.Lan]["common"].stock else end
		if GetNumVehicleMods(vehicle, 39) ~= 0 then ExteriorMenu[#ExteriorMenu + 1] = { header = Loc[Config.Lan]["exterior"].label4, txt = "["..(GetNumVehicleMods(vehicle, 39)+1)..Loc[Config.Lan]["common"].menuinstalled..installed5, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 39 } } } end
		installed6 = GetLabelText(GetModTextLabel(vehicle, 40, GetVehicleMod(vehicle, 40)))	if installed6 == "NULL" then installed6 = Loc[Config.Lan]["common"].stock else end
		if GetNumVehicleMods(vehicle, 40) ~= 0 then ExteriorMenu[#ExteriorMenu + 1] = { header = Loc[Config.Lan]["exterior"].label5, txt = "["..(GetNumVehicleMods(vehicle, 40)+1)..Loc[Config.Lan]["common"].menuinstalled..installed6, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 40 } } } end
		installed7 = GetLabelText(GetModTextLabel(vehicle, 41, GetVehicleMod(vehicle, 41)))	if installed7 == "NULL" then installed7 = Loc[Config.Lan]["common"].stock else end
		if GetNumVehicleMods(vehicle, 41) ~= 0 then ExteriorMenu[#ExteriorMenu + 1] = { header = Loc[Config.Lan]["exterior"].label6, txt = "["..(GetNumVehicleMods(vehicle, 41)+1)..Loc[Config.Lan]["common"].menuinstalled..installed7, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 41 } } } end
		installed8 = GetLabelText(GetModTextLabel(vehicle, 38, GetVehicleMod(vehicle, 38)))	if installed8 == "NULL" then installed8 = Loc[Config.Lan]["common"].stock else end
		if GetNumVehicleMods(vehicle, 38) ~= 0 then ExteriorMenu[#ExteriorMenu + 1] = { header = Loc[Config.Lan]["exterior"].label7, txt = "["..(GetNumVehicleMods(vehicle, 38)+1)..Loc[Config.Lan]["common"].menuinstalled..installed8, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 38 } } } end
		installed9 = GetLabelText(GetModTextLabel(vehicle, 42, GetVehicleMod(vehicle, 42)))	if installed9 == "NULL" then installed9 = Loc[Config.Lan]["common"].stock else end
		if GetNumVehicleMods(vehicle, 42) ~= 0 then ExteriorMenu[#ExteriorMenu + 1] = { header = Loc[Config.Lan]["exterior"].label8, txt = "["..(GetNumVehicleMods(vehicle, 42)+1)..Loc[Config.Lan]["common"].menuinstalled..installed9, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 42 } } } end
		installed10 = GetLabelText(GetModTextLabel(vehicle, 45, GetVehicleMod(vehicle, 45))) if installed10 == "NULL" then installed10 = Loc[Config.Lan]["common"].stock else end
		if GetNumVehicleMods(vehicle, 45) ~= 0 then ExteriorMenu[#ExteriorMenu + 1] = { header = Loc[Config.Lan]["exterior"].label9, txt = "["..(GetNumVehicleMods(vehicle, 45)+1)..Loc[Config.Lan]["common"].menuinstalled..installed10, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 45 } } } end
		installed11 = GetLabelText(GetModTextLabel(vehicle, 43, GetVehicleMod(vehicle, 43))) if installed11 == "NULL" then installed11 = Loc[Config.Lan]["common"].stock else end
		if GetNumVehicleMods(vehicle, 43) ~= 0 then ExteriorMenu[#ExteriorMenu + 1] = { header = Loc[Config.Lan]["exterior"].label10, txt = "["..(GetNumVehicleMods(vehicle, 43)+1)..Loc[Config.Lan]["common"].menuinstalled..installed11, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 43 } } } end
	
		exports['qb-menu']:openMenu(ExteriorMenu)
	end
end)

RegisterNetEvent('jim-mechanic:client:Exterior:Choose', function(data)
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local validMods = {}
	if not inCar() then return end
	if not nearPoint(coords) then return end
	local vehicle = nil
	if not IsPedInAnyVehicle(playerPed, false) then vehicle = getClosest(coords) pushVehicle(vehicle)
		for i = 1, GetNumVehicleMods(vehicle, tonumber(data.mod)) do
			if GetVehicleMod(vehicle, tonumber(data.mod)) == (i-1) then txt = Loc[Config.Lan]["common"].current else txt = "" end
			validMods[i] = { id = (i - 1), name = GetLabelText(GetModTextLabel(vehicle, tonumber(data.mod), (i - 1))), install = txt }
		end
	end
	if DoesEntityExist(vehicle) then
		if GetVehicleMod(vehicle, tonumber(data.mod)) == -1 then stockinstall = Loc[Config.Lan]["exterior"].chooseinstalled else stockinstall = "" end
		for i = 0, 5 do SetVehicleDoorOpen(vehicle, i, false, false) end
		local ModMenu = {
				{ isMenuHeader = true, header = searchCar(vehicle)..Loc[Config.Lan]["exterior"].menuheader, txt = Loc[Config.Lan]["common"].amountoption..#validMods+1,	},
				{ header = "", txt = Loc[Config.Lan]["common"].ret, params = { event = "jim-mechanic:client:Exterior:Check" } },
				{ header = "0. "..Loc[Config.Lan]["common"].stock, txt = stockinstall,	params = { event = "jim-mechanic:client:Exterior:Apply", args = { id = -1, mod = tonumber(data.mod) } }	} }
			for k,v in pairs(validMods) do
				ModMenu[#ModMenu + 1] = { header = k..". "..v.name, txt = v.install, params = { event = 'jim-mechanic:client:Exterior:Apply', args = { id = v.id, mod = data.mod } } }
			end
		exports['qb-menu']:openMenu(ModMenu)
	end
end)