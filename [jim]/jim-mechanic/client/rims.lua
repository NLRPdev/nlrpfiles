local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Rims
RegisterNetEvent('jim-mechanic:client:Rims:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = getClosest(coords) pushVehicle(vehicle)
	TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
	Wait(1000)
	time = math.random(3000,5000)
	QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["rims"].installing, time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
	{ animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, },
	{}, {}, function()
		SetVehicleWheelType(vehicle, tonumber(data.wheeltype))
		if not data.bike then SetVehicleMod(vehicle, 23, tonumber(data.mod), true)
		else SetVehicleMod(vehicle, 24, tonumber(data.mod), false) end
		emptyHands(playerPed)
		updateCar(vehicle)
		if data.mod == -1 then 
			if Config.CosmeticRemoval then TriggerServerEvent("QBCore:Server:RemoveItem", 'rims', 1) TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['rims'], "remove", 1)
			else TriggerEvent('jim-mechanic:client:Rims:Choose', data) end
		else 
			if Config.CosmeticRemoval then TriggerServerEvent("QBCore:Server:RemoveItem", 'rims', 1) TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['rims'], "remove", 1)
			else TriggerEvent('jim-mechanic:client:Rims:SubMenu', data) end
		end
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["rims"].installed, "success")
	end, function() -- Cancel
		TriggerEvent("QBCore:Notify", Loc[Config.Lan]["rims"].failed, "error")
		emptyHands(playerPed)
	end, "rims")
end)

RegisterNetEvent('jim-mechanic:client:Rims:Check', function()
	if Config.CosmeticsJob then if not jobChecks() then return end end	
	if not locationChecks() then return end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)  
	if not inCar() then return end
	if not nearPoint(coords) then return end
	local vehicle = nil
	if not IsPedInAnyVehicle(playerPed, false) then	vehicle = getClosest(coords) pushVehicle(vehicle) end
	if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].owned, "error") return end
	if lockedCar(vehicle) then return end
	if DoesEntityExist(vehicle) then
		if IsThisModelABike(GetEntityModel(vehicle)) then cycle = true else cycle = false end
		--if IsThisModelABicycle(GetEntityModel(vehicle)) then cycle = true end
		--if IsThisModelAQuadbike(GetEntityModel(vehicle)) then cycle = true end

		local WheelMenu = { }
			WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].menuheader, txt = "", isMenuHeader = true }
			if Config.JimMenu then WheelMenu[#WheelMenu + 1] = { icon = "fas fa-circle-xmark", header = "", txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""), params = { event = "jim-mechanic:client:Menu:Close" } }
			else WheelMenu[#WheelMenu + 1] = { header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "jim-mechanic:client:Menu:Close" } } end
			if not cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label1, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 0, bike = false } } } end
			if not cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label2, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 1, bike = false } } } end
			if not cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label3, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 2, bike = false } } } end
			if not cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label4, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 3, bike = false } } } end
			if not cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label5, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 4, bike = false } } } end
			if not cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label6, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 5, bike = false } } } end
			if not cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label7, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 7, bike = false } } } end
			if not cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label8, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 8, bike = false } } } end
			if not cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label9, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 9, bike = false } } } end
			if not cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label10, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 10, bike = false } } } end
			if not cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label11, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 11, bike = false } } } end
			if not cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label12, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 12, bike = false } } } end
			--if not cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label15, params = { event = "jim-mechanic:client:Rims:Choose", args = 6 } } end
			if cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label13, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 6, bike = false } } } end
			if cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label14, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 6, bike = true } } } end			
		exports['qb-menu']:openMenu(WheelMenu)		
	end
end)

RegisterNetEvent('jim-mechanic:client:Rims:Choose', function(data)
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local validMods = {}
	if not inCar() then return end
	if not nearPoint(coords) then return end
	local vehicle = nil
	if not IsPedInAnyVehicle(playerPed, false) then vehicle = getClosest(coords) pushVehicle(vehicle)
		if DoesEntityExist(vehicle) then
			originalWheel = GetVehicleWheelType(vehicle)
			SetVehicleWheelType(vehicle, tonumber(data.wheeltype))
			for i = 1, (GetNumVehicleMods(vehicle, 23) +1) do	
				local modName = GetLabelText(GetModTextLabel(vehicle, 23, (i-1)))
				if not validMods[modName] then
					if GetVehicleMod(vehicle, 23) == (i-1) and tonumber(originalWheel) == tonumber(data.wheeltype) then txt = Loc[Config.Lan]["common"].current else txt = "" end
					validMods[modName] = {}
					validMods[modName][#validMods[modName]+1] = { id = (i-1), name = modName, install = txt }
				elseif validMods[modName] ~= nil then
					if validMods[modName][1] then
						if GetVehicleMod(vehicle, 23) == (i) and tonumber(originalWheel) == tonumber(data.wheeltype) then txt = Loc[Config.Lan]["common"].current else txt = "" end
						local name = modName
						if modName == "NULL" then name = modName.." ("..(i-1)..")" end
						validMods[modName][#validMods[modName]+1] = { id = (i-1), name = name.." - Var "..(#validMods[modName]+1), install = txt }
					else
						validMods[modName][#validMods[modName]+1] = { id = validMods[modName].id, name = validMods[modName].name.." - Var 1", install = validMods[modName].install }
						if GetVehicleMod(vehicle, 23) == (i) and tonumber(originalWheel) == tonumber(data.wheeltype) then txt = Loc[Config.Lan]["common"].current else txt = "" end
						validMods[modName][#validMods[modName]+1] = { id = (i-1), name = modName.." - Var "..(#validMods[modName]+1), install = txt } 
					end
				end
			end
			
			if validMods["NULL"] then validMods[Loc[Config.Lan]["rims"].labelcustom] = validMods["NULL"] validMods["NULL"] = nil end
			
			if GetVehicleMod(vehicle, 23) == -1 then stockinstall = Loc[Config.Lan]["common"].current else stockinstall = "" end
			label = ""
			if data.wheeltype == 0 then label = Loc[Config.Lan]["rims"].label1 end
			if data.wheeltype == 1 then label = Loc[Config.Lan]["rims"].label2 end
			if data.wheeltype == 2 then label = Loc[Config.Lan]["rims"].label3 end
			if data.wheeltype == 3 then label = Loc[Config.Lan]["rims"].label4 end
			if data.wheeltype == 4 then label = Loc[Config.Lan]["rims"].label5 end
			if data.wheeltype == 5 then label = Loc[Config.Lan]["rims"].label6 end
			if data.wheeltype == 6 then label = Loc[Config.Lan]["rims"].label15 end
			if data.wheeltype == 7 then label = Loc[Config.Lan]["rims"].label7 end
			if data.wheeltype == 8 then label = Loc[Config.Lan]["rims"].label8 end
			if data.wheeltype == 9 then label = Loc[Config.Lan]["rims"].label9 end
			if data.wheeltype == 10 then label = Loc[Config.Lan]["rims"].label10 end
			if data.wheeltype == 11 then label = Loc[Config.Lan]["rims"].label11 end
			if data.wheeltype == 12 then label = Loc[Config.Lan]["rims"].label12 end
			local RimsMenu = {}
				RimsMenu[#RimsMenu + 1] =  { isMenuHeader = true, header = searchCar(vehicle).." "..Loc[Config.Lan]["rims"].menuheader.."<br>("..string.upper(label)..")", txt = "", }
					
				if Config.JimMenu then RimsMenu[#RimsMenu + 1] = { icon = "fas fa-circle-arrow-left", header = "", txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""), params = { event = "jim-mechanic:client:Rims:Check" } }
				else RimsMenu[#RimsMenu + 1] =  { header = "", txt = Loc[Config.Lan]["common"].ret, params = { event = "jim-mechanic:client:Rims:Check" } } end
					
				RimsMenu[#RimsMenu + 1] = { header = Loc[Config.Lan]["common"].stock, txt = stockinstall, params = { event = "jim-mechanic:client:Rims:Apply",  args = { mod = -1, wheeltype = data.wheeltype, } } }
				for k, v in pairsByKeys(validMods) do
					RimsMenu[#RimsMenu + 1] = { header = k, txt = Loc[Config.Lan]["common"].amountoption..#validMods[k], params = { event = 'jim-mechanic:client:Rims:SubMenu', args = { mod = v.id, wheeltype = data.wheeltype, wheeltable = validMods[k], bike = data.bike } } }
				end
			exports['qb-menu']:openMenu(RimsMenu)
			SetVehicleWheelType(vehicle, originalWheel)
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:Rims:SubMenu', function(data)
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	if not inCar() then return end
	if not nearPoint(coords) then return end
	local vehicle = nil
	if not IsPedInAnyVehicle(playerPed, false) then vehicle = getClosest(coords) pushVehicle(vehicle)
		if DoesEntityExist(vehicle) then
			local RimsMenu = {
					{ isMenuHeader = true, header = searchCar(vehicle).." "..Loc[Config.Lan]["rims"].menuheader.."<br>("..string.upper(label)..")", txt = Loc[Config.Lan]["common"].amountoption..#data.wheeltable.."<br>"..Loc[Config.Lan]["common"].current..": "..GetLabelText(GetModTextLabel(vehicle, 23, GetVehicleMod(vehicle, 23))), }, }
				
				if Config.JimMenu then RimsMenu[#RimsMenu + 1] = { icon = "fas fa-circle-arrow-left", header = "", txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""), params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = data.wheeltype } } }
				else RimsMenu[#RimsMenu + 1] =  { header = "", txt = Loc[Config.Lan]["common"].ret, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = data.wheeltype } } } end
					
				for i=1, #data.wheeltable do
					RimsMenu[#RimsMenu + 1] = { header = data.wheeltable[i].name, txt = data.wheeltable[i].install, params = { event = 'jim-mechanic:client:Rims:Apply', args = { mod = data.wheeltable[i].id, wheeltype = data.wheeltype, wheeltable = data.wheeltable, bike = data.bike } } }
				end
			exports['qb-menu']:openMenu(RimsMenu)
		end
	end
end)