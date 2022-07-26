local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Tires
RegisterNetEvent('jim-mechanic:client:Tires:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	spraying = true
	local r,g,b = GetVehicleTyreSmokeColor(vehicle)
	if r == data.R and g == data.G and b == data.B then
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["smoke"].already, "error")
		TriggerEvent('jim-mechanic:client:Tires:Check')
	else
		time = math.random(3000,5000)
		TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
		Wait(1000)
		local fwd = GetEntityForwardVector(playerPed)
		local coords = GetEntityCoords(playerPed) + fwd * 0.5 + vector3(0.0, 0.0, -0.5)
		CreateThread(function()
			while spraying do
				RequestNamedPtfxAsset("scr_recartheft")
				while not HasNamedPtfxAssetLoaded("scr_recartheft") do Citizen.Wait(0) end
				local heading = GetEntityHeading(vehicle)
				UseParticleFxAssetNextCall("scr_recartheft")
				SetParticleFxNonLoopedColour(data.R / 255, data.G / 255, data.B / 255)
				SetParticleFxNonLoopedAlpha(1.0)
				local spray = StartNetworkedParticleFxNonLoopedAtCoord("scr_wheel_burnout", coords.x, coords.y, coords.z, 0.0, 0.0, heading+180.0, 0.6, 0.0, 0.0, 0.0)
				Wait(3000)
			end
		end)
		QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["smoke"].installing, time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, }, 
		{ animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
			ToggleVehicleMod(vehicle, 20, true)
			SetVehicleTyreSmokeColor(vehicle, data.R, data.G, data.B)
			emptyHands(playerPed)
			updateCar(vehicle)
			if Config.CosmeticRemoval then TriggerServerEvent("QBCore:Server:RemoveItem", 'tires', 1) TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['tires'], "remove", 1)
			else TriggerEvent('jim-mechanic:client:Tires:Check') end
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["smoke"].installed, "success")
			spraying = false
		end, function() -- Cancel
			TriggerEvent("QBCore:Notify", Loc[Config.Lan]["smoke"].failed, "error")
			emptyHands(playerPed)
			spraying = false
		end, "tires")
	end
end)

RegisterNetEvent('jim-mechanic:client:Tires:Check', function()
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
	local r,g,b = GetVehicleTyreSmokeColor(vehicle)
	local applied0 = ""
	local applied1 = ""
	local applied2 = ""
	local applied3 = ""
	local applied4 = ""
	local applied5 = ""
	local applied6 = ""
	local applied7 = ""
	local applied8 = ""
	local applied9 = ""
	local applied10 = ""
	local applied11 = ""
	local applied12 = ""
	local applied13 = ""
	local applied14 = ""
	local applied15 = ""
	if r == 1 and g == 1 and b == 1 then applied1 = Loc[Config.Lan]["common"].current
	elseif r == 255 and g == 255 and b == 255 then applied2 = Loc[Config.Lan]["common"].current
	elseif r == 2 and g == 21 and b == 255 then applied3 = Loc[Config.Lan]["common"].current
	elseif r == 3 and g == 83 and b == 255 then applied4 = Loc[Config.Lan]["common"].current
	elseif r == 0 and g == 255 and b == 140 then applied5 = Loc[Config.Lan]["common"].current
	elseif r == 94 and g == 255 and b == 1 then applied6 = Loc[Config.Lan]["common"].current
	elseif r == 255 and g == 255 and b == 0 then applied7 = Loc[Config.Lan]["common"].current
	elseif r == 255 and g == 150 and b == 0 then applied8 = Loc[Config.Lan]["common"].current
	elseif r == 255 and g == 62 and b == 1 then applied9 = Loc[Config.Lan]["common"].current
	elseif r == 255 and g == 1 and b == 1 then applied10 = Loc[Config.Lan]["common"].current
	elseif r == 255 and g == 50 and b == 100 then applied11 = Loc[Config.Lan]["common"].current
	elseif r == 255 and g == 5 and b == 190 then applied12 = Loc[Config.Lan]["common"].current
	elseif r == 35 and g == 1 and b == 255 then applied13 = Loc[Config.Lan]["common"].current
	elseif r == 15 and g == 3 and b == 255 then applied14 = Loc[Config.Lan]["common"].current
	elseif r == 0 and g == 0 and b == 0 then applied15 = Loc[Config.Lan]["common"].current
	else applied0 = Loc[Config.Lan]["common"].current end
	exports['qb-menu']:openMenu({
		{ header = searchCar(vehicle)..Loc[Config.Lan]["smoke"].menuheader, txt = "", isMenuHeader = true, },
		{ header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "jim-mechanic:client:Menu:Close" } },
		{ header = Loc[Config.Lan]["smoke"].remove, txt = applied15, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 0, G = 0, B = 0 } } },
		{ header = Loc[Config.Lan]["smoke"].custom, txt = applied0, params = { event = "jim-mechanic:client:smokeCustomMenu", } },
		{ header = Loc[Config.Lan]["smoke"].black, txt = applied1, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 1, G = 1, B = 1 } } },
		{ header = Loc[Config.Lan]["smoke"].white, txt = applied2, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 255, B = 255 } } },
		{ header = Loc[Config.Lan]["smoke"].blue, txt = applied3, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 2, G = 21, B = 255 } } },
		{ header = Loc[Config.Lan]["smoke"].eblue, txt = applied4, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 3, G = 83, B = 255 } } },
		{ header = Loc[Config.Lan]["smoke"].mgreen, txt = applied5, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 0, G = 255, B = 140 } } },
		{ header = Loc[Config.Lan]["smoke"].lgreen, txt = applied6, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 94, G = 255, B = 1 } } },
		{ header = Loc[Config.Lan]["smoke"].yellow, txt = applied7, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 255, B = 0 } } },
		{ header = Loc[Config.Lan]["smoke"].gshower, txt = applied8, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 150, B = 0 } } },
		{ header = Loc[Config.Lan]["smoke"].orange, txt = applied9,  params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 62, B = 0 } } },
		{ header = Loc[Config.Lan]["smoke"].red, txt = applied10, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 1, B = 1 } } },
		{ header = Loc[Config.Lan]["smoke"].ppink, txt = applied11, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 50, B = 100 } } },
		{ header = Loc[Config.Lan]["smoke"].hpink, txt = applied12, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 5, B = 190 } } },
		{ header = Loc[Config.Lan]["smoke"].purple, txt = applied13, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 35, G = 1, B = 255 } } },
		{ header = Loc[Config.Lan]["smoke"].blacklight, txt = applied14, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 15, G = 3, B = 255 } } },
	})
end)

RegisterNetEvent('jim-mechanic:client:smokeCustomMenu', function()
    local dialog = exports['qb-input']:ShowInput({
        header = Loc[Config.Lan]["smoke"].custom,
        submitText = "Submit",
        inputs = {
            { type = 'number', isRequired = true, name = 'R', text = 'R' },
            { type = 'number', isRequired = true, name = 'G', text = 'G' },
            { type = 'number', isRequired = true, name = 'B', text = 'B' } }
    })
    if dialog then
        if not dialog.R or not dialog.G or not dialog.B then return end
        local data = { R = tonumber(dialog.R), G = tonumber(dialog.G), B = tonumber(dialog.B) }
		TriggerEvent('jim-mechanic:client:Tires:Apply', data)
    end
end)