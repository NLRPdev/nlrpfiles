local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Paint
RegisterNetEvent('jim-mechanic:client:Paints:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if not IsPedInAnyVehicle(playerPed, false) then	vehicle = getClosest(coords) pushVehicle(vehicle) else
	vehicle = GetVehiclePedIsIn(playerPed, false) pushVehicle(vehicle) end
	spraying = true
	local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(vehicle)
	local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(vehicle)
	if data.paint == Loc[Config.Lan]["paint"].primary then colourCheck = vehPrimaryColour end
	if data.paint == Loc[Config.Lan]["paint"].secondary then colourCheck = vehSecondaryColour end
	if data.paint == Loc[Config.Lan]["paint"].pearl then colourCheck = vehPearlescentColour end
	if data.paint == Loc[Config.Lan]["paint"].wheel then colourCheck = vehWheelColour end
	if colourCheck == data.id then
		TriggerEvent('QBCore:Notify', data.finish.." "..data.name..Loc[Config.Lan]["common"].already, "error")
		TriggerEvent('jim-mechanic:client:Paints:Choose:Paint', data)
	elseif colourCheck ~= data.id then
		spraycan = CreateObject(`ng_proc_spraycan01b`,0.0, 0.0, 0.0,true, false, false)
		AttachEntityToEntity(spraycan, playerPed, GetPedBoneIndex(playerPed, 57005), 0.072, 0.041, -0.06,33.0, 38.0, 0.0, true, true, false, true, 1, true)	
		playAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_wall_loop_lamar", 6000, 8)
		local canCoords = GetEntityCoords(spraycan)
		Citizen.Wait(2000)
		time = math.random(1000,3000)
		--local fwd = GetEntityForwardVector(playerPed)
		--local coords = GetEntityCoords(playerPed) + fwd * 0.5 + vector3(0.0, 0.0, -0.5)

		CreateThread(function()
			while spraying do
				RequestNamedPtfxAsset("scr_recartheft")
				while not HasNamedPtfxAssetLoaded("scr_recartheft") do Citizen.Wait(10) end
				local color = {255, 255, 255}
				local heading = GetEntityHeading(playerPed)
				UseParticleFxAssetNextCall("scr_recartheft")
				if string.find(data.name, "Red") then color = {255, 1, 1} end
				if string.find(data.name, "Black") then color = {1, 1, 1} end
				if string.find(data.name, "Blue") then color = {2, 21, 255} end
				if string.find(data.name, "Green") then color = {94, 255, 1} end
				if string.find(data.name, "Yellow") then color = {255, 255, 0} end
				if string.find(data.name, "Orange") then color = {255, 62, 1} end
				if string.find(data.name, "Pink") then color = {255, 50, 100} end
				if string.find(data.name, "Purple") then color = {159, 43, 104} end
				setanimDict = "switch@franklin@lamar_tagging_wall"
				setanim = "lamar_tagging_exit_loop_lamar"
				setflags = 8
				settask = nil
				SetParticleFxNonLoopedColour(color[1] / 255, color[2] / 255, color[3] / 255)
				SetParticleFxNonLoopedAlpha(1.0)
				local spray = StartNetworkedParticleFxNonLoopedAtCoord("scr_wheel_burnout", canCoords.x, canCoords.y, canCoords.z + 0.8, 0.0, 0.0, heading, 1.0, 0.0, 0.0, 0.0)
				Wait(3000)
			end
		end)
		--while not HasAnimDictLoaded('anim@amb@business@weed@weed_inspecting_lo_med_hi@') do RequestAnimDict('anim@amb@business@weed@weed_inspecting_lo_med_hi@') Citizen.Wait(1) end
		--TaskPlayAnim(ped, 'anim@amb@business@weed@weed_inspecting_lo_med_hi@', 'weed_spraybottle_stand_spraying_01_inspector', 1.0, 1.0, -1, 16, 0, 0, 0, 0 )
		Wait(100)

		QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing..data.paint.." "..data.finish.." "..data.name, time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
		{ task = settask, animDict = setanimDict, anim = setanim, flags = setflag, },
		{}, {}, function()  

			if data.paint == Loc[Config.Lan]["paint"].primary then ClearVehicleCustomPrimaryColour(vehicle) SetVehicleColours(vehicle, data.id, vehSecondaryColour)
			elseif data.paint == Loc[Config.Lan]["paint"].secondary then ClearVehicleCustomSecondaryColour(vehicle) SetVehicleColours(vehicle, vehPrimaryColour, data.id)
			elseif data.paint == Loc[Config.Lan]["paint"].pearl then SetVehicleExtraColours(vehicle, data.id, vehWheelColour)
			elseif data.paint == Loc[Config.Lan]["paint"].wheel then SetVehicleExtraColours(vehicle, vehPearlescentColour, data.id)
			elseif data.paint == Loc[Config.Lan]["paint"].dashboard then SetVehicleDashboardColour(vehicle, data.id)
			elseif data.paint == Loc[Config.Lan]["paint"].interior then SetVehicleInteriorColour(vehicle, data.id) end
			spraying = false
			updateCar(vehicle)
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["paint"].installed, "success")
			if Config.CosmeticRemoval then TriggerServerEvent("QBCore:Server:RemoveItem", 'paintcan', 1) TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['paintcan'], "remove", 1)
			else TriggerEvent('jim-mechanic:client:Paints:Choose:Paint', data) end
			emptyHands(playerPed)
		end, function() -- Cancel
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["paint"].failed, "error")
			spraying = false
			TriggerEvent('jim-mechanic:client:Paints:Choose:Paint', data)
			emptyHands(playerPed)
		end, "paintcan")
	end
end)

RegisterNetEvent('jim-mechanic:client:Paints:Check', function()
	if Config.CosmeticsJob then if not jobChecks() then return end end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)  
	if not nearPoint(coords) then return end
	local vehicle = nil
	if not IsPedInAnyVehicle(playerPed, false) then	vehicle = getClosest(coords) pushVehicle(vehicle) else
	vehicle = GetVehiclePedIsIn(playerPed, false) pushVehicle(vehicle) end
	if lockedCar(vehicle) then return end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if DoesEntityExist(vehicle) then
	
	local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(vehicle)
	local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(vehicle)
	local interiorColor = GetVehicleInteriorColor(vehicle)
	local dashboardColor = GetVehicleDashboardColour(vehicle)
	
	for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do
		if vehPrimaryColour == v.id then vehPrimaryColour = Loc[Config.Lan]["paint"].metallic.." "..v.name	end
		if vehSecondaryColour == v.id then vehSecondaryColour = Loc[Config.Lan]["paint"].metallic.." "..v.name	end
		if vehPearlescentColour == v.id then vehPearlescentColour = Loc[Config.Lan]["paint"].metallic.." "..v.name	end
		if vehWheelColour == v.id then vehWheelColour = Loc[Config.Lan]["paint"].metallic.." "..v.name	end
		if interiorColor == v.id then interiorColor = Loc[Config.Lan]["paint"].metallic.." "..v.name	end
		if dashboardColor == v.id then dashboardColor = Loc[Config.Lan]["paint"].metallic.." "..v.name	end
	end			
	for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMatte) do
		if vehPrimaryColour == v.id then vehPrimaryColour = Loc[Config.Lan]["paint"].matte.." "..v.name	end
		if vehSecondaryColour == v.id then vehSecondaryColour = Loc[Config.Lan]["paint"].matte.." "..v.name	end
		if vehPearlescentColour == v.id then vehPearlescentColour = Loc[Config.Lan]["paint"].matte.." "..v.name	end
		if vehWheelColour == v.id then vehWheelColour = Loc[Config.Lan]["paint"].matte.." "..v.name	end
		if interiorColor == v.id then interiorColor = Loc[Config.Lan]["paint"].matte.." "..v.name	end
		if dashboardColor == v.id then dashboardColor = Loc[Config.Lan]["paint"].matte.." "..v.name	end
	end
	for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMetals) do
		if vehPrimaryColour == v.id then vehPrimaryColour = v.name	end
		if vehSecondaryColour == v.id then vehSecondaryColour = v.name	end
		if vehPearlescentColour == v.id then vehPearlescentColour = v.name	end
		if vehWheelColour == v.id then vehWheelColour = v.name	end
		if interiorColor == v.id then interiorColor = v.name	end
		if dashboardColor == v.id then dashboardColor = v.name	end
	end
	if type(vehPrimaryColour) == "number" then vehPrimaryColour = Loc[Config.Lan]["common"].stock end
	if type(vehSecondaryColour) == "number" then vehSecondaryColour = Loc[Config.Lan]["common"].stock end
	if type(vehPearlescentColour) == "number" then vehPearlescentColour = Loc[Config.Lan]["common"].stock end
	if type(vehWheelColour) == "number" then vehWheelColour = Loc[Config.Lan]["common"].stock end
	if type(interiorColor) == "number" then interiorColor = Loc[Config.Lan]["common"].stock end
	if type(dashboardColor) == "number" then dashboardColor = Loc[Config.Lan]["common"].stock end
	
		local PaintMenu = {	
				{ header = searchCar(vehicle)..Loc[Config.Lan]["paint"].menuheader, txt = "", isMenuHeader = true },
				{ header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "jim-mechanic:client:Menu:Close", } } }
			if not IsPedInAnyVehicle(playerPed, false) then
				PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["xenons"].customheader, params = { event = "jim-mechanic:client:rgbORhex" } }
				PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].primary, txt = Loc[Config.Lan]["common"].current..": "..vehPrimaryColour, params = { event = "jim-mechanic:client:Paints:Choose", args = Loc[Config.Lan]["paint"].primary } }
				PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].secondary, txt = Loc[Config.Lan]["common"].current..": "..vehSecondaryColour, params = { event = "jim-mechanic:client:Paints:Choose", args = Loc[Config.Lan]["paint"].secondary } }
				PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].pearl, txt = Loc[Config.Lan]["common"].current..": "..vehPearlescentColour, params = { event = "jim-mechanic:client:Paints:Choose", args = Loc[Config.Lan]["paint"].pearl } }
				PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].wheel, txt = Loc[Config.Lan]["common"].current..": "..vehWheelColour, params = { event = "jim-mechanic:client:Paints:Choose", args = Loc[Config.Lan]["paint"].wheel } }
			else
				PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].interior, txt = Loc[Config.Lan]["common"].current..": "..interiorColor, params = { event = "jim-mechanic:client:Paints:Choose", args = Loc[Config.Lan]["paint"].interior } }
				PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].dashboard, txt = Loc[Config.Lan]["common"].current..": "..dashboardColor, params = { event = "jim-mechanic:client:Paints:Choose", args = Loc[Config.Lan]["paint"].dashboard } }
			end
		exports['qb-menu']:openMenu(PaintMenu)
	end
end)

RegisterNetEvent('jim-mechanic:client:Paints:Choose', function(data)
	if Config.CosmeticsJob then if not jobChecks() then return end end
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if not nearPoint(coords) then return end
	local vehicle = nil
	if not IsPedInAnyVehicle(playerPed, false) then	vehicle = getClosest(coords) pushVehicle(vehicle) else
	vehicle = GetVehiclePedIsIn(playerPed, false) pushVehicle(vehicle) end
	if DoesEntityExist(vehicle) then
		exports['qb-menu']:openMenu({
			{ header = data..Loc[Config.Lan]["paint"].menuheader, txt = "", isMenuHeader = true },
			{ header = "", txt = Loc[Config.Lan]["common"].ret, params = { event = "jim-mechanic:client:Paints:Check" } },
			{ header = Loc[Config.Lan]["paint"].classic, txt = "", params = { event = "jim-mechanic:client:Paints:Choose:Paint", args = { paint = data, finish = Loc[Config.Lan]["paint"].classic } } },
			{ header = Loc[Config.Lan]["paint"].metallic, txt = "", params = { event = "jim-mechanic:client:Paints:Choose:Paint", args = { paint = data, finish = Loc[Config.Lan]["paint"].metallic } } },
			{ header = Loc[Config.Lan]["paint"].matte, txt = "", params = { event = "jim-mechanic:client:Paints:Choose:Paint", args = { paint = data, finish = Loc[Config.Lan]["paint"].matte } } },
			{ header = Loc[Config.Lan]["paint"].metals, txt = "", params = { event = "jim-mechanic:client:Paints:Choose:Paint", args = { paint = data, finish = Loc[Config.Lan]["paint"].metals } } },
		})
	end
end)

RegisterNetEvent('jim-mechanic:client:Paints:Choose:Paint', function(data)
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	if not nearPoint(coords) then return end
	local vehicle = nil
	if not IsPedInAnyVehicle(playerPed, false) then	
	vehicle = getClosest(coords) pushVehicle(vehicle) else
	vehicle = GetVehiclePedIsIn(playerPed, false) pushVehicle(vehicle) end
		local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(vehicle)
		local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(vehicle)
		if data.paint == Loc[Config.Lan]["paint"].primary then colourCheck = vehPrimaryColour end
		if data.paint == Loc[Config.Lan]["paint"].secondary then colourCheck = vehSecondaryColour end
		if data.paint == Loc[Config.Lan]["paint"].pearl then colourCheck = vehPearlescentColour end
		if data.paint == Loc[Config.Lan]["paint"].wheel then colourCheck = vehWheelColour end
		if data.paint == Loc[Config.Lan]["paint"].dashboard then colourCheck = GetVehicleDashboardColour(vehicle) end
		if data.paint == Loc[Config.Lan]["paint"].interior then colourCheck = GetVehicleInteriorColour(vehicle) end
	if DoesEntityExist(vehicle) then
		local PaintMenu = {	
			{ isMenuHeader = true, header = data.finish.." "..data.paint, txt = "" },
			{ header = "", txt = Loc[Config.Lan]["common"].ret, params = { event = "jim-mechanic:client:Paints:Choose", args = data.paint } } }
		local installed = nil
		if data.finish == Loc[Config.Lan]["paint"].classic then
			for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do
				if colourCheck == v.id then installed = Loc[Config.Lan]["common"].current else installed = "" end
				PaintMenu[#PaintMenu + 1] = { header = k..". "..v.name, txt = installed, params = { event = 'jim-mechanic:client:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } } } end
				
		elseif data.finish == Loc[Config.Lan]["paint"].metallic then
			for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do
				if colourCheck == v.id then installed = Loc[Config.Lan]["common"].current else installed = "" end
				PaintMenu[#PaintMenu + 1] = { header = k..". "..v.name, txt = installed, params = { event = 'jim-mechanic:client:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } } } end
				
		elseif data.finish == Loc[Config.Lan]["paint"].matte then
			for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMatte) do
				if colourCheck == v.id then installed = Loc[Config.Lan]["common"].current else installed = "" end
				PaintMenu[#PaintMenu + 1] = { header = k..". "..v.name, txt = installed, params = { event = 'jim-mechanic:client:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } } } end
				
		elseif data.finish == Loc[Config.Lan]["paint"].metals then
			for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMetals) do	
				if colourCheck == v.id then installed = Loc[Config.Lan]["common"].current else installed = "" end
				PaintMenu[#PaintMenu + 1] = { header = k..". "..v.name, txt = installed, params = { event = 'jim-mechanic:client:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } } } end
		end
		exports['qb-menu']:openMenu(PaintMenu)
	end
end)