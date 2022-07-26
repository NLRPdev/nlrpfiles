local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Paint

local spraying = false

local function rgbToHex(r,g,b)
	local rgb = (r * 0x10000) + (g * 0x100) + b
	return string.format("%06x", rgb)
end

local function HexTorgb(hex)
	hex = hex:gsub("#","")
	return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

RegisterNetEvent('jim-mechanic:client:RGBApply', function(data)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local vehicle = getClosest(coords)

	if data.hex then r,g,b = HexTorgb(data.hex) else	
	if data.r >= 255 then r = 255 elseif data.r <= 0 then r = 0 else r = data.r end
		if data.g >= 255 then g = 255 elseif data.g <= 0 then g = 0 else g = data.g end
		if data.b >= 255 then b = 255 elseif data.b <= 0 then b = 0 else b = data.b end
	end
	RequestNamedPtfxAsset("scr_recartheft")
	while not HasNamedPtfxAssetLoaded("scr_recartheft") do Citizen.Wait(10) end
	local heading = GetEntityHeading(ped)
	UseParticleFxAssetNextCall("scr_recartheft")
	spraycan = CreateObject(`ng_proc_spraycan01b`,0.0, 0.0, 0.0,true, false, false)
	AttachEntityToEntity(spraycan, ped, GetPedBoneIndex(ped, 57005), 0.072, 0.041, -0.06, 33.0, 38.0, 0.0, true, true, false, true, 1, true)
	playAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_wall_loop_lamar", 6000, 8)
	Citizen.Wait(1000)
	playAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_exit_loop_lamar", 6000, 8)
	Wait(1000)
	SetParticleFxNonLoopedColour(r / 255, g / 255, b / 255)
	SetParticleFxNonLoopedAlpha(1.0)
	local canCoords = GetEntityCoords(spraycan)
	local spray = StartNetworkedParticleFxNonLoopedAtCoord("scr_wheel_burnout", canCoords.x, canCoords.y, canCoords.z+0.8, 0.0, 0.0, heading, 0.5, 0.0, 0.0, 0.0)
	local colorPrimary, colorSecondary = GetVehicleColours(vehicle)

	-- Set car to white/base coat
	if data.select == "pri" then 
		SetVehicleCustomPrimaryColour(vehicle, 1.0, 1.0, 1.0) 
		SetVehicleColours(vehicle, data.finish, colorSecondary)
	elseif data.select == "sec" then 
		SetVehicleCustomSecondaryColour(vehicle, 1.0, 1.0, 1.0) 
		SetVehicleColours(vehicle, colorPrimary, data.finish)
	end
	
	spraying = true

	--local r,g,b = 105, 0, 105 --New RBG test Colour
	local rd,gd,bd = 255,255,255 --Base Coat Numbers

    while spraying do
        while rd ~= r or gd ~= g or bd ~= b do
            if rd ~= r then rd = rd - 1 end
            if gd ~= g then gd = gd - 1 end
            if bd ~= b then bd = bd - 1 end
            if data.select == "pri" then SetVehicleCustomPrimaryColour(vehicle,rd,gd,bd)
            elseif data.select == "sec" then SetVehicleCustomSecondaryColour(vehicle,rd,gd,bd) end
			Wait(10)
        end
        spraying = false
        Wait(10)
    end
	--spray = nil
    spraying = false
	updateCar(vehicle)
	if Config.CosmeticRemoval then TriggerServerEvent("QBCore:Server:RemoveItem", 'paintcan', 1) TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['paintcan'], "remove", 1)
	else TriggerEvent("jim-mechanic:client:rgbORhex") end
	emptyHands(ped)
end)

RegisterNetEvent('jim-mechanic:client:RGBPicker', function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local vehicle = getClosest(coords)
	local r,g,b = GetVehicleCustomPrimaryColour(vehicle) priCol = tostring("("..r..","..g..","..b..")")
	local r,g,b = GetVehicleCustomSecondaryColour(vehicle) secCol = tostring("("..r..","..g..","..b..")")
	if DoesEntityExist(vehicle) then
    	local dialog = exports['qb-input']:ShowInput({
        	header = "<center>"..Loc[Config.Lan]["xenons"].customheader
					 .."<br><br>- "..Loc[Config.Lan]["paint"].primary.." -<br>"..priCol
					 .."<br>- "..Loc[Config.Lan]["paint"].secondary.." -<br>"..secCol,
        	inputs = {      
				{ type = 'number', isRequired = true, name = 'Red', text = 'R' },
            	{ type = 'number', isRequired = true, name = 'Green', text = 'G' },
            	{ type = 'number', isRequired = true, name = 'Blue', text = 'B' }, 
				{ type = 'radio', name = 'select', text = Loc[Config.Lan]["paintrgb"].select, 
					options = { { value = "pri", text = Loc[Config.Lan]["paint"].primary }, 
								{ value = "sec", text = Loc[Config.Lan]["paint"].secondary } } },
				{ type = 'radio', name = 'finish', text = Loc[Config.Lan]["paintrgb"].finish,
					options = { { value = "147", text = Loc[Config.Lan]["paint"].classic },
								{ value = "12", text = Loc[Config.Lan]["paint"].matte },
								{ value = "120", text = Loc[Config.Lan]["paintrgb"].chrome } } } } })
    	if dialog then
        	if not dialog.Red or not dialog.Green or not dialog.Blue then return TriggerEvent("jim-mechanic:client:RGBPicker") end
			local data = { finish = tonumber(dialog.finish), 
					   		select = dialog.select,
					   		r = tonumber(dialog.Red),
					   		g = tonumber(dialog.Green),
					   		b = tonumber(dialog.Blue)
					 	}
        	TriggerEvent('jim-mechanic:client:RGBApply', data)
		end
    end
end)

RegisterNetEvent('jim-mechanic:client:HEXPicker', function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local vehicle = getClosest(coords)
	local r,g,b = GetVehicleCustomPrimaryColour(vehicle) priCol = "[#"..rgbToHex(r,g,b):upper().."]"
	local r,g,b = GetVehicleCustomSecondaryColour(vehicle) secCol = "[#"..rgbToHex(r,g,b):upper().."]"
	if DoesEntityExist(vehicle) then
    	local dialog = exports['qb-input']:ShowInput({
        	header = "<center>"..Loc[Config.Lan]["xenons"].customheader
					 .."<br><br>- "..Loc[Config.Lan]["paint"].primary.." -<br>"..priCol
					 .."<br>- "..Loc[Config.Lan]["paint"].secondary.." -<br>"..secCol,
        	submitText = Loc[Config.Lan]["xenons"].customconfirm,
        	inputs = {            
				{ type = 'text', isRequired = true, name = 'hex', text = '#' },
				{ type = 'radio', name = 'select', text = Loc[Config.Lan]["paintrgb"].select,
					options = { { value = "pri", text = Loc[Config.Lan]["paint"].primary },
								{ value = "sec", text = Loc[Config.Lan]["paint"].secondary } } },
				{ type = 'radio', name = 'finish', text = Loc[Config.Lan]["paintrgb"].finish,
					options = { { value = "147", text = Loc[Config.Lan]["paint"].classic },
								{ value = "12", text = Loc[Config.Lan]["paint"].matte },
								{ value = "120", text = Loc[Config.Lan]["paintrgb"].chrome } } } } })
    	if dialog then
        	if not dialog.hex then return TriggerEvent("jim-mechanic:client:HEXPicker") end
			if dialog.hex then
				if string.len(dialog.hex:gsub("#","")) ~= 6 then
					TriggerEvent("QBCore:Notify", Loc[Config.Lan]["paintrgb"].error, "error")
					return TriggerEvent("jim-mechanic:client:HEXPicker")
				end
			end
			local data = { finish = tonumber(dialog.finish), 
					   		select = dialog.select,
					   		hex = dialog.hex,
					 	}
        	TriggerEvent('jim-mechanic:client:RGBApply', data)
		end
    end
end)

RegisterNetEvent('jim-mechanic:client:rgbORhex', function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local vehicle = getClosest(coords)
	if not inCar() then return end
	if DoesEntityExist(vehicle) then
		local r,g,b = GetVehicleCustomPrimaryColour(vehicle) priCol = "("..r..","..g..","..b..") - [#"..rgbToHex(r,g,b):upper().."]"
		local r,g,b = GetVehicleCustomSecondaryColour(vehicle) secCol = "("..r..","..g..","..b..") - [#"..rgbToHex(r,g,b):upper().."]"
		local PaintMenu = {}
		PaintMenu[#PaintMenu+1] = { header = Loc[Config.Lan]["paintrgb"].customheader, isMenuHeader = true }
		PaintMenu[#PaintMenu+1] = { header = Loc[Config.Lan]["common"].ret, params = { event = "jim-mechanic:client:Paints:Check" } }			 
		PaintMenu[#PaintMenu+1] = { header = Loc[Config.Lan]["paintrgb"].hex, params = { event = "jim-mechanic:client:HEXPicker" }, }
		PaintMenu[#PaintMenu+1] = { header = Loc[Config.Lan]["paintrgb"].rgb, params = { event = "jim-mechanic:client:RGBPicker" }, }
		exports['qb-menu']:openMenu(PaintMenu)
	end
end)