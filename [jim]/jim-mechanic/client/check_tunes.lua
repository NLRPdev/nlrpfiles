local QBCore = exports['qb-core']:GetCoreObject()
--========================================================= CheckTunes
local vehicle = nil	
local toolbox = nil

RegisterNetEvent('jim-mechanic:client:Menu', function()
	if not jobChecks() then return end
	if not locationChecks() then return end
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	if not nearPoint(coords) then return end
	if not inCar() then return end
	if not IsPedInAnyVehicle(ped, false) then vehicle = getClosest(coords) pushVehicle(vehicle) end
	if lockedCar(vehicle) then return end
	playAnim("anim@heists@narcotics@trash", "idle", 6000, 8)
	
	if toolbox == nil then toolbox = CreateObject(`v_ind_cs_toolbox4`,0.0, 0.0, 0.0,true, false, false) end
	AttachEntityToEntity(toolbox, ped, GetPedBoneIndex(ped, 57005), 0.20, -0.04, 0.0, 25.0, 270.0, 180.0, true, true, false, true, 1, true)

	-- Adding support for my qb-menu edit
	local engicon, bricon, susicon , tranicon, armicon, turicon, headicon, drifticon, bprooficon = ""

	local CheckMenu = {
		{ isMenuHeader = true, header = searchCar(vehicle),	txt = "Class: "..getClass(vehicle).."<br>"..Loc[Config.Lan]["check"].plate..trim(GetVehicleNumberPlateText(vehicle))..Loc[Config.Lan]["check"].value..searchPrice(vehicle).."<br>"..searchDist(vehicle)} }
		
		if Config.JimMenu then CheckMenu[#CheckMenu + 1] = { icon = "fas fa-circle-xmark", header = "", txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""), params = { event = "jim-mechanic:client:Menu:Close" } }
		else CheckMenu[#CheckMenu + 1] = { header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "jim-mechanic:client:Menu:Close" } } end

		--Engine
		if GetNumVehicleMods(vehicle,11) ~= 0 then
			if GetVehicleMod(vehicle, 11) == -1 then modEngine = Loc[Config.Lan]["common"].stock modEngineHead = true
			else 
				if Config.JimMenu then engicon = "engine"..(GetVehicleMod(vehicle, 11)+1) modEngine = QBCore.Shared.Items["engine"..(GetVehicleMod(vehicle, 11)+1)].label.." [LVL "..(GetVehicleMod(vehicle, 11)+1).."]"
				else modEngine = "<img src=nui://"..Config.img..QBCore.Shared.Items["engine"..(GetVehicleMod(vehicle, 11)+1)].image.." width=13px> "..QBCore.Shared.Items["engine"..(GetVehicleMod(vehicle, 11)+1)].label.." [LVL "..(GetVehicleMod(vehicle, 11)+1).."]" end
				modEngineHead = false 
			end
		else modEngine = Loc[Config.Lan]["check"].unavail modEngineHead = true end
		--Brakes	
		if GetNumVehicleMods(vehicle, 12) ~= 0 then
			if GetVehicleMod(vehicle, 12) == -1 then modBrakes = Loc[Config.Lan]["common"].stock modBrakesHead = true
			else
				if Config.JimMenu then bricon = "brakes"..(GetVehicleMod(vehicle, 12)+1) modBrakes = QBCore.Shared.Items["brakes"..(GetVehicleMod(vehicle, 12)+1)].label.." [LVL "..(GetVehicleMod(vehicle, 12)+1).."]" 
				else modBrakes = "<img src=nui://"..Config.img..QBCore.Shared.Items["brakes"..(GetVehicleMod(vehicle, 12)+1)].image.." width=13px> "..QBCore.Shared.Items["brakes"..(GetVehicleMod(vehicle, 12)+1)].label.." [LVL "..(GetVehicleMod(vehicle, 12)+1).."]" end
				modBrakesHead = false
			end
		else modBrakes = Loc[Config.Lan]["check"].unavail modBrakesHead = true end
		--Suspension
		if GetNumVehicleMods(vehicle,15) ~= 0 then 
			if GetVehicleMod(vehicle, 15) == -1 then modSuspension = Loc[Config.Lan]["common"].stock modSuspensionHead = true
			else
				if Config.JimMenu then susicon = "suspension"..(GetVehicleMod(vehicle, 15)+1) modSuspension = QBCore.Shared.Items["suspension"..(GetVehicleMod(vehicle, 15)+1)].label.." [LVL "..(GetVehicleMod(vehicle, 15)+1).."]"
				else modSuspension = "<img src=nui://"..Config.img..QBCore.Shared.Items["suspension"..(GetVehicleMod(vehicle, 15)+1)].image.." width=13px> "..QBCore.Shared.Items["suspension"..(GetVehicleMod(vehicle, 15)+1)].label.." [LVL "..(GetVehicleMod(vehicle, 15)+1).."]" end
				modSuspensionHead = false
			end
		else modSuspension = Loc[Config.Lan]["check"].unavail modSuspensionHead = true end
		--Transmission
		if GetNumVehicleMods(vehicle,13) ~= 0 then 
			if GetVehicleMod(vehicle, 13) == -1 then modTransmission = Loc[Config.Lan]["common"].stock modTransmissionHead = true
			else 
				if Config.JimMenu then tranicon = "transmission"..(GetVehicleMod(vehicle, 13)+1) modTransmission = QBCore.Shared.Items["transmission"..(GetVehicleMod(vehicle, 13)+1)].label
				else modTransmission = "<img src=nui://"..Config.img..QBCore.Shared.Items["transmission"..(GetVehicleMod(vehicle, 13)+1)].image.." width=13px> "..QBCore.Shared.Items["transmission"..(GetVehicleMod(vehicle, 13)+1)].label end
				modTransmissionHead = false
			end
		else modTransmission = Loc[Config.Lan]["check"].unavail modTransmissionHead = true end
		--Armor
		if GetNumVehicleMods(vehicle, 16) ~= 0 then 
			if GetVehicleMod(vehicle, 16)+1 == GetNumVehicleMods(vehicle, 16) then 
				if Config.JimMenu then armicon = "car_armor" modArmor = Loc[Config.Lan]["check"].reinforced
				else modArmor = "<img src=nui://"..Config.img..QBCore.Shared.Items["car_armor"].image.." width=13px> "..Loc[Config.Lan]["check"].reinforced end
				modArmorHead = false
			else modArmor = Loc[Config.Lan]["common"].stock modArmorHead = true end
		else modArmor = Loc[Config.Lan]["check"].unavail modArmorHead = true end
		--Turbo
		if not IsToggleModOn(vehicle, 18) and GetNumVehicleMods(vehicle,11) ~= 0 then modTurbo = Loc[Config.Lan]["check"].notinstall modTurboHead = true 
		elseif IsToggleModOn(vehicle, 18) then
			if Config.JimMenu then turicon = "turbo" modTurbo = QBCore.Shared.Items["turbo"].label
			else modTurbo = "<img src=nui://"..Config.img..QBCore.Shared.Items["turbo"].image.." width=13px> "..QBCore.Shared.Items["turbo"].label end
			modTurboHead = false
		elseif GetNumVehicleMods(vehicle,11) == 0 then modTurbo = Loc[Config.Lan]["check"].unavail turicon = "" modTurboHead = true end
		--Xenons
		if not IsToggleModOn(vehicle, 22) and GetNumVehicleMods(vehicle,11) ~= 0 then modXenon = Loc[Config.Lan]["check"].notinstall modXenonHead = true 
		elseif IsToggleModOn(vehicle, 22) then 
			if Config.JimMenu then headicon = "headlights" modXenon = Loc[Config.Lan]["check"].xenoninst
			else modXenon = "<img src=nui://"..Config.img..QBCore.Shared.Items["headlights"].image.." width=13px> "..Loc[Config.Lan]["check"].xenoninst end
			modXenonHead = false
		elseif GetNumVehicleMods(vehicle,11) == 0 then modXenon = Loc[Config.Lan]["check"].unavail modXenonHead = true  end
		for k, v in pairs(Loc[Config.Lan].vehicleXenonOptions) do if GetVehicleHeadlightsColour(vehicle) == v.id then xenonColor = " ("..v.name..")" else xenonColor = "" end end
		--Drift
		if GetGameBuildNumber() >= 2372 then
			if GetDriftTyresEnabled(vehicle) == false and GetNumVehicleMods(vehicle,11) ~= 0 then modDrift = Loc[Config.Lan]["check"].notinstall modDriftHead = true 
			elseif GetDriftTyresEnabled(vehicle) == 1 then 
				if Config.Jim then drifticon = "drifttires" modDrift = Loc[Config.Lan]["check"].tireinst
				else modDrift = "<img src=nui://"..Config.img..QBCore.Shared.Items["drifttires"].image.." width=13px> "..Loc[Config.Lan]["check"].tireinst end
				modDriftHead = false
			elseif GetNumVehicleMods(vehicle,11) == 0 then modDrift = Loc[Config.Lan]["check"].unavail modDriftHead = true  end
		end
		--BulletProof
		if GetVehicleTyresCanBurst(vehicle) == 1 then modBproof = Loc[Config.Lan]["check"].notinstall modBproofHead = true 
		elseif GetVehicleTyresCanBurst(vehicle) == false and GetNumVehicleMods(vehicle,11) ~= 0 then
			if Config.JimMenu then bprooficon = "bprooftires" modBproof = Loc[Config.Lan]["check"].tireinst
			else modBproof = "<img src=nui://"..Config.img..QBCore.Shared.Items["bprooftires"].image.." width=13px> "..Loc[Config.Lan]["check"].tireinst end
			modBproofHead = false
		elseif GetNumVehicleMods(vehicle,11) == 0 then modBproof = Loc[Config.Lan]["check"].unavail modBproofHead = true  end
		
		if IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then local p = promise.new() QBCore.Functions.TriggerCallback('jim-mechanic:GetNosLoaded', function(cb) p:resolve(cb) end) local VehicleNitrous = Citizen.Await(p)
			if VehicleNitrous[trim(GetVehicleNumberPlateText(vehicle))] then local nosicon = "nos"
				local text = " LVL: "..VehicleNitrous[trim(GetVehicleNumberPlateText(vehicle))].level.."%"
				if not Config.JimMenu then nosicon = "" text = "<img src=nui://"..Config.img..QBCore.Shared.Items["nos"].image.." width=13px>"..text end
				CheckMenu[#CheckMenu + 1] = { icon = nosicon, header = Loc[Config.Lan]["check"].label58, txt = text, params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "nos" } } }
			end
		end
		
		CheckMenu[#CheckMenu + 1] = { icon = engicon, isMenuHeader = modEngineHead, header = Loc[Config.Lan]["check"].label1, txt = modEngine, params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "engine" } } }
		CheckMenu[#CheckMenu + 1] = { icon = bricon, isMenuHeader = modBrakesHead, header = Loc[Config.Lan]["check"].label2, txt = modBrakes, params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "brakes" } } }	
		CheckMenu[#CheckMenu + 1] = { icon = susicon, isMenuHeader = modSuspensionHead, header = Loc[Config.Lan]["check"].label3, txt = modSuspension, params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "suspension" } } }
		CheckMenu[#CheckMenu + 1] = { icon = tranicon, isMenuHeader = modTransmissionHead, header = Loc[Config.Lan]["check"].label4, txt = modTransmission, params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "transmission" } } }
		CheckMenu[#CheckMenu + 1] = { icon = armicon, isMenuHeader = modArmorHead, header = Loc[Config.Lan]["check"].label5, txt = modArmor, params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "armour" } } }
		CheckMenu[#CheckMenu + 1] = { icon = turicon, isMenuHeader = modTurboHead, header = Loc[Config.Lan]["check"].label6, txt = modTurbo, params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "turbo" } } }
		CheckMenu[#CheckMenu + 1] = { icon = headicon, isMenuHeader = modXenonHead, header = Loc[Config.Lan]["check"].label7, txt = modXenon..xenonColor, params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "xenon" } } }
		if GetGameBuildNumber() >= 2372 then
			CheckMenu[#CheckMenu + 1] = { icon = drifticon, isMenuHeader = modDriftHead, header = Loc[Config.Lan]["check"].label8, txt = modDrift, params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "drift" } } }
		end
		CheckMenu[#CheckMenu + 1] = { icon = bprooficon, isMenuHeader = modBproofHead, header = Loc[Config.Lan]["check"].label9, txt = modBproof, params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "bproof" } } }
		
		if Config.JimMenu then CheckMenu[#CheckMenu + 1] = { icon = "fas fa-toolbox", header = "", txt = Loc[Config.Lan]["check"].label10, params = { event = "jim-mechanic:client:Menu:List" } }
		else CheckMenu[#CheckMenu + 1] = { header = "", txt = "🧰 - "..Loc[Config.Lan]["check"].label10, params = { event = "jim-mechanic:client:Menu:List" } } end

	exports['qb-menu']:openMenu(CheckMenu)
	toolbox = nil
end)

RegisterNetEvent('jim-mechanic:client:Menu:List', function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local vehicle = nil
	if not nearPoint(coords) then return end
	vehicle = getClosest(coords) pushVehicle(vehicle)
	local internal, external = false

	local CheckMenu = {
		{ isMenuHeader = true, header = Loc[Config.Lan]["check"].label11..searchCar(vehicle), txt = Loc[Config.Lan]["check"].label10 } }
		
		if Config.JimMenu then CheckMenu[#CheckMenu + 1] = { icon = "fas fa-circle-xmark", header = "", txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""), params = { event = "jim-mechanic:client:Menu:Close" } }
		else CheckMenu[#CheckMenu + 1] = { header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "jim-mechanic:client:Menu:Close" } } end
		
		
	local exterior = { 0, 1, 2, 3, 4, 6, 7, 8, 9, 10, 25, 26, 27, 44, 37, 39, 40, 41, 42 }
	local external = nil
	for k, v in pairs(exterior) do if GetNumVehicleMods(vehicle, v) ~= 0 then external = true break else external = nil end end
	
	if external ~= nil then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = Loc[Config.Lan]["check"].label13, } end
	
	if GetNumVehicleMods(vehicle, 48) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["police"].livery.." - [ "..GetNumVehicleMods(vehicle, 48)..Loc[Config.Lan]["check"].label12, } end
	if GetVehicleLiveryCount(vehicle) ~= -1 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["police"].livery.." - [ "..GetVehicleLiveryCount(vehicle)..Loc[Config.Lan]["check"].label12, } end
	
	if GetNumVehicleMods(vehicle, 0) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label15..GetNumVehicleMods(vehicle, 0)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 1) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label16..GetNumVehicleMods(vehicle, 1)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 2) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label17..GetNumVehicleMods(vehicle, 2)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 3) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label18..GetNumVehicleMods(vehicle, 3)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 4) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label19..GetNumVehicleMods(vehicle, 4)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 6) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label20..GetNumVehicleMods(vehicle, 6)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 7) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label21..GetNumVehicleMods(vehicle, 7)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 8) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label22..GetNumVehicleMods(vehicle, 8)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 9) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label23..GetNumVehicleMods(vehicle, 9)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 10) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label24..GetNumVehicleMods(vehicle, 10)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 25) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label25..GetNumVehicleMods(vehicle, 25)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 26) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label26..GetNumVehicleMods(vehicle, 26)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 27) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label27..GetNumVehicleMods(vehicle, 27)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 44) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label28..GetNumVehicleMods(vehicle, 44)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 37) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label29..GetNumVehicleMods(vehicle, 37)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 39) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label30..GetNumVehicleMods(vehicle, 39)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 40) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label31..GetNumVehicleMods(vehicle, 40)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 41) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label32..GetNumVehicleMods(vehicle, 41)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 42) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label33..GetNumVehicleMods(vehicle, 42)..Loc[Config.Lan]["check"].label12, } end
	
	local interior = { 5, 28, 29, 30, 31, 32, 33, 34, 35, 36, 38, 43, 45 }
	for k, v in pairs(interior) do if GetNumVehicleMods(vehicle, v) ~= 0 then internal = true end end
	if internal then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = Loc[Config.Lan]["check"].label14, } end
	if GetNumVehicleMods(vehicle, 5) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label34..GetNumVehicleMods(vehicle, 5)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 28) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label35..GetNumVehicleMods(vehicle, 28)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 29) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label36..GetNumVehicleMods(vehicle, 29)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 30) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label37..GetNumVehicleMods(vehicle, 30)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 31) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label38..GetNumVehicleMods(vehicle, 31)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 32) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label39..GetNumVehicleMods(vehicle, 32)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 33) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label40..GetNumVehicleMods(vehicle, 33)..Loc[Config.Lan]["check"].label12, } end
	if GetNumVehicleMods(vehicle, 34) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label41..GetNumVehicleMods(vehicle, 34)..Loc[Config.Lan]["check"].label12, } end 
	if GetNumVehicleMods(vehicle, 35) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label42..GetNumVehicleMods(vehicle, 35)..Loc[Config.Lan]["check"].label12, } end 
	if GetNumVehicleMods(vehicle, 36) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label43..GetNumVehicleMods(vehicle, 36)..Loc[Config.Lan]["check"].label12, } end 
	if GetNumVehicleMods(vehicle, 38) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label44..GetNumVehicleMods(vehicle, 38)..Loc[Config.Lan]["check"].label12, } end 
	if GetNumVehicleMods(vehicle, 43) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label45..GetNumVehicleMods(vehicle, 43)..Loc[Config.Lan]["check"].label12, } end 
	if GetNumVehicleMods(vehicle, 45) ~= 0 then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = "", txt = Loc[Config.Lan]["check"].label46..GetNumVehicleMods(vehicle, 45)..Loc[Config.Lan]["check"].label12, } end 

	--if GetNumVehicleMods(vehicle, 17) ~= 0 then  = "✅- " else  = false end
	--if GetNumVehicleMods(vehicle, 18) ~= 0 then  = "✅- " else  = false end
	--if GetNumVehicleMods(vehicle, 19) ~= 0 then  = "✅- " else  = false end
	--if GetNumVehicleMods(vehicle, 20) ~= 0 then  = "✅- " else  = false end
	--if GetNumVehicleMods(vehicle, 21) ~= 0 then  = "✅- " else  = false end
	--if GetNumVehicleMods(vehicle, 22) ~= false then  = "✅- " else  = false end
	--if GetNumVehicleMods(vehicle, 23) ~= 0 then  = "✅- " else  = false end
	--if GetNumVehicleMods(vehicle, 24) ~= 0 then  = "✅- " else  = false end
	

	local all = { 0, 1, 2, 3, 4, 6, 7, 8, 9, 10, 25, 26, 27, 44, 37, 39, 40, 41, 42, 5, 28, 29, 30, 31, 32, 33, 34, 35, 36, 38, 43, 45 }
	local mods = nil
	for k, v in pairs(all) do if GetNumVehicleMods(vehicle, v) ~= 0 then mods = true break else mods = nil end end
	if GetVehicleLiveryCount(vehicle) ~= -1 then mods = true end
	if mods then exports['qb-menu']:openMenu(CheckMenu) else TriggerEvent("QBCore:Notify", Loc[Config.Lan]["common"].noOptions, "error") return end
end)

---BRAKES
RegisterNetEvent('jim-mechanic:client:Menu:Remove', function(data)
	local removeevent, setheader = ""
	if data.mod == "brakes" then
		if Config.JimMenu then icon = "brakes"..(GetVehicleMod(data.vehicle, 12)+1) setheader = Loc[Config.Lan]["check"].label49
		else setheader = "<img src=nui://"..Config.img..QBCore.Shared.Items["brakes"..(GetVehicleMod(data.vehicle, 12)+1)].image.." width=50px>"..Loc[Config.Lan]["check"].label49 end
		removeevent = "jim-mechanic:client:giveBrakes"
	elseif data.mod == "engine" then
		if Config.JimMenu then icon = "engine"..(GetVehicleMod(data.vehicle, 11)+1)	setheader = Loc[Config.Lan]["check"].label50
		else setheader = "<img src=nui://"..Config.img..QBCore.Shared.Items["engine"..(GetVehicleMod(data.vehicle, 11)+1)].image.." width=50px>"..Loc[Config.Lan]["check"].label50 end
		removeevent = "jim-mechanic:client:giveEngine"
	elseif data.mod == "suspension" then
		if Config.JimMenu then icon = "suspension"..(GetVehicleMod(data.vehicle, 15)+1) setheader = Loc[Config.Lan]["check"].label51
		else setheader = "<img src=nui://"..Config.img..QBCore.Shared.Items["suspension"..(GetVehicleMod(data.vehicle, 15)+1)].image.." width=50px>"..Loc[Config.Lan]["check"].label51 end
		removeevent = "jim-mechanic:client:giveSuspension"
	elseif data.mod == "transmission" then
		if Config.JimMenu then icon = "transmission"..(GetVehicleMod(data.vehicle, 13)+1) setheader = Loc[Config.Lan]["check"].label52
		else setheader = "<img src=nui://"..Config.img..QBCore.Shared.Items["transmission"..(GetVehicleMod(data.vehicle, 13)+1)].image.." width=50px>"..Loc[Config.Lan]["check"].label52 end
		removeevent = "jim-mechanic:client:giveTransmission"
	elseif data.mod == "armour" then
		if Config.JimMenu then icon = "car_armor" setheader = Loc[Config.Lan]["check"].label53
		else setheader = "<img src=nui://"..Config.img..QBCore.Shared.Items["car_armor"].image.." width=50px>"..Loc[Config.Lan]["check"].label53 end
		removeevent = "jim-mechanic:client:giveArmor"
	elseif data.mod == "turbo" then
		if Config.JimMenu then icon = "turbo" setheader = Loc[Config.Lan]["check"].label54
		else setheader = "<img src=nui://"..Config.img..QBCore.Shared.Items["turbo"].image.." width=50px>"..Loc[Config.Lan]["check"].label54 end
		removeevent = "jim-mechanic:client:giveTurbo"
	elseif data.mod == "xenon" then
		if Config.JimMenu then icon = "headlights" setheader = Loc[Config.Lan]["check"].label55
		else setheader = "<img src=nui://"..Config.img..QBCore.Shared.Items["headlights"].image.." width=50px>"..Loc[Config.Lan]["check"].label55 end
		removeevent = "jim-mechanic:client:giveXenon"
	elseif data.mod == "drift" then
		if Config.JimMenu then icon = "drifttires" setheader = Loc[Config.Lan]["check"].label56
		else setheader = "<img src=nui://"..Config.img..QBCore.Shared.Items["drifttires"].image.." width=50px>"..Loc[Config.Lan]["check"].label56 end
		removeevent = "jim-mechanic:client:giveDrift"
	elseif data.mod == "bproof" then
		if Config.JimMenu then icon = "bprooftires" setheader = Loc[Config.Lan]["check"].label56
		else setheader = "<img src=nui://"..Config.img..QBCore.Shared.Items["bprooftires"].image.." width=50px>"..Loc[Config.Lan]["check"].label56 end
		removeevent = "jim-mechanic:client:giveBulletProof"
	elseif data.mod == "nos" then 
		if Config.JimMenu then icon = "nos" setheader = Loc[Config.Lan]["check"].label57
		else setheader = "<img src=nui://"..Config.img..QBCore.Shared.Items["noscan"].image.." width=50px>"..Loc[Config.Lan]["check"].label57 end
		removeevent = "jim-mechanic:client:giveNOS"
	end
	local CheckMenu = { }
	CheckMenu[#CheckMenu+1] = { isMenuHeader = true, header = searchCar(vehicle), txt = Loc[Config.Lan]["check"].plate..trim(GetVehicleNumberPlateText(data.vehicle))..Loc[Config.Lan]["check"].value..searchPrice(data.vehicle).."<br>"..searchDist(data.vehicle) }
	CheckMenu[#CheckMenu+1] = { icon = icon, isMenuHeader = true, header = setheader }
	if Config.JimMenu then
		CheckMenu[#CheckMenu + 1] = { icon = "fas fa-circle-check", header = "", txt = string.gsub(Loc[Config.Lan]["check"].label47, "✅ ", ""), params = { event = removeevent } }
		CheckMenu[#CheckMenu + 1] = { icon = "fas fa-circle-xmark", header = "", txt = string.gsub(Loc[Config.Lan]["check"].label48, "❌ ", ""), params = { event = "jim-mechanic:client:Menu" } }
	else 
		CheckMenu[#CheckMenu + 1] = { header = "", txt = Loc[Config.Lan]["check"].label47, params = { event = removeevent } }
		CheckMenu[#CheckMenu + 1] = { header = "", txt = Loc[Config.Lan]["check"].label48, params = { event = "jim-mechanic:client:Menu" } }
	end
	exports['qb-menu']:openMenu(CheckMenu)
end)