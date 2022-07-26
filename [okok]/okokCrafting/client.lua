local QBCore = exports["qb-core"]:GetCoreObject()
local PlayerData = {}
local isCraftOpen = false
local SE = TriggerServerEvent
local waitMore = true
local hasEntered = false
local blipsLoaded = false
local itemAmnt, timeCraft, itemRecipe, craftss, success, isItem
local tableName, tableCrafts, tableItemNames, workbench
local queue = {}
local closestBlip
local maxCraftRadius

Citizen.CreateThread(function()
	while QBCore.Functions.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = QBCore.Functions.GetPlayerData()
end)

Citizen.CreateThread(function()
	if Config.ShowBlips then
		Citizen.Wait(2000)
		for k,v in ipairs(Config.Crafting) do
			local blip = AddBlipForCoord(v.coordinates[1], v.coordinates[2], v.coordinates[3])
			SetBlipSprite (blip, v.blip.blipId)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, v.blip.blipScale)
			SetBlipColour (blip, v.blip.blipColor)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.blip.blipText)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

Citizen.CreateThread(function()
	if not blipsLoaded then
		blipsLoaded = true
		Citizen.Wait(2000)
		local playerPed = GetPlayerPed(-1)
		local waitMoreTime = true
		while Config.ShowFloorBlips do
			Citizen.Wait(0)
			if DoesEntityExist(playerPed) then
				waitMoreTime = true
				local playerCoords = GetEntityCoords(PlayerPedId())
				for k,v in pairs(Config.Crafting) do
					local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, v.coordinates[1], v.coordinates[2], v.coordinates[3])
					if distance < v.showBlipRadius then
						waitMoreTime = false
						if DoesEntityExist(playerPed) then
							DrawMarker(20, v.coordinates[1], v.coordinates[2], v.coordinates[3]-0.0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 31, 94, 255, 155, 0, 0, 2, 1, 0, 0, 0)
					 	end
					end
				end
			else
				playerPed = GetPlayerPed(-1)
			end

			if waitMoreTime then
				Citizen.Wait(1000)
			end
		end
	end
end)

Citizen.CreateThread(function()
	local inZone = false
	local num = 0
	local nearZone = false
	local enteredRange = false
	local inWideRange = false

	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		
		nearZone = false
		inZone = false

		for k,v in pairs(Config.Crafting) do
			local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, v.coordinates[1], v.coordinates[2], v.coordinates[3])
			local zDiference = playerCoords.z - v.coordinates[3]
		
			if distance < v.radius + 2 and zDiference < v.radius + 2 and zDiference > (v.radius + 2)*(-1) then
				nearZone = true
				if waitMore and not isCraftOpen then
					waitMore = false
				end
				
				if distance < v.radius then
					inZone = true
					if IsControlJustReleased(0, Config.Key) then
						if GetVehiclePedIsUsing(PlayerPedId()) == 0 then
							waitMore = true
							if not isCraftOpen then
								TriggerScreenblurFadeIn(5000)
								closestBlip = v.coordinates
								maxCraftRadius = v.maxCraftRadius
								isCraftOpen = true
								if Config.UseOkokTextUI then
									exports['okokTextUI']:Close()
								end
								Citizen.Wait(100)
								if Config.HideMinimap then
									DisplayRadar(false)
								end
								
								QBCore.Functions.TriggerCallback("okokCrafting:itemNames", function(itemNames)
									tableName, tableCrafts, tableItemNames, workbench = v.tableName, v.crafts, itemNames, v.tableID
									if not Config.UseXP then
										SetNuiFocus(true, true)
										SendNUIMessage({
											action = "openCraft",
											name = v.tableName,
											craft = v.crafts,
											itemNames = itemNames,
											job = QBCore.Functions.GetPlayerData().job.name,
											wb = v.tableID,
											UseXP = false,
										})
									else
										QBCore.Functions.TriggerCallback("okokCrafting:getLevel", function(level, percentage)
											SetNuiFocus(true, true)
											SendNUIMessage({
												action = "openCraft",
												name = v.tableName,
												craft = v.crafts,
												itemNames = itemNames,
												job = QBCore.Functions.GetPlayerData().job.name,
												wb = v.tableID,
												UseXP = true,
												level = level,
												percentage = percentage,
											})
										end)
									end
								end)
							end
						else
							exports['okokNotify']:Alert("CRAFTING", "You can't craft inside a vehicle", 5000, 'error')
						end
					end
				end
			elseif not waitMore and not inWideRange then
				waitMore = true
			end
		end

		if nearZone and not enteredRange then
			enteredRange = true
			inWideRange = true
		elseif not nearZone and enteredRange then
			enteredRange = false
			inWideRange = false
		end

		if inZone and not hasEntered then
			if Config.UseOkokTextUI then
				exports['okokTextUI']:Open('[E] To open crafting table', 'darkblue', 'left') 
			else
				TriggerEvent('QBCore:Notify', "Press E to access the crafting table", "success")
			end
			hasEntered = true
		elseif not inZone and hasEntered then
			if Config.UseOkokTextUI then
				exports['okokTextUI']:Close()
			end
			hasEntered = false
		end 

		if waitMore then
			Citizen.Wait(1000)
		end
	end
end)

RegisterNUICallback('action', function(data, cb)
	if data.action == 'close' then
		TriggerScreenblurFadeOut(5000)
		SetNuiFocus(false, false)
		if Config.HideMinimap then
			DisplayRadar(true)
		end
		hasEntered = true
		if Config.UseOkokTextUI then
			exports['okokTextUI']:Open('[E] To open crafting table', 'darkblue', 'left') 
		end
		isCraftOpen = false
		waitMore = false
	elseif data.action == 'craft' then
		local invItems = {}
		local loop = 0
		local added = 0
		local amount_item = 0

		for k,v in pairs(data.crafts) do
			if data.item == v.item then
				for k2,v2 in pairs(v.recipe) do
					loop = loop + 1
					QBCore.Functions.TriggerCallback("okokCrafting:inv2", function(item)
						local value = {key = item}
						table.insert(invItems, value)
						added = added + 1
					end, v2[1])
					while loop ~= added do
						Citizen.Wait(100)
					end
				end
				
				itemAmnt, timeCraft, itemRecipe, craftss, success, isItem, xp = v.amount, v.time, v.recipe, data.crafts, v.successCraftPercentage, v.isItem, v.xpPerCraft
				SendNUIMessage({
					action = "openSideCraft",
					itemNameID = data.item,
					itemName = data.itemName[data.item],
					itemNames = data.itemName,
					itemAmount = v.amount,
					percentage = v.successCraftPercentage,
					time = v.time,
					recipe = v.recipe,
					inventory = invItems,
					crafts = data.crafts,
					xp = xp,
				})
				break
			end
		end
	elseif data.action == 'craft-button' then
		local recipeTable = Split(data.recipe, ",")
		local invItems = {}
		local loop = 0
		local added = 0

		local item = {
			item = data.itemID,
			recipe = recipeTable,
			amount = data.amount,
			success = success,
			isItem = isItem,
			time = timeCraft,
			recipe = itemRecipe,
			crafts = craftss,
			closeBlip = closestBlip,
			maxCraftRadius = maxCraftRadius,
			xp = xp,
		}
		
		QBCore.Functions.TriggerCallback("okokCrafting:itemNames", function(itemNames)
			QBCore.Functions.TriggerCallback("okokCrafting:CanCraftItem", function(canCraft)
				if canCraft then
					table.insert(queue, item)
					for k2,v2 in pairs(recipeTable) do
						loop = loop + 1
						QBCore.Functions.TriggerCallback("okokCrafting:inv2", function(item)
							local value = {key = item}
							table.insert(invItems, value)
							added = added + 1
						end, v2[1])
						while added ~= loop do
							Citizen.Wait(100)
						end
					end

					SendNUIMessage({
						action = "openSideCraft",
						itemNameID = data.itemID,
						itemName = itemNames[data.itemID],
						itemNames = itemNames,
						itemAmount = data.amount,
						time = timeCraft,
						recipe = itemRecipe,
						inventory = invItems,
						crafts = craftss,
						xp = data.xp,
					})

					if queue[1] == item then
						local crafting = false
						while queue[1] ~= nil do
							Citizen.Wait(100)
							if not crafting then
								crafting = true
								SE('okokCrafting:craftStartItem')
								local invItems = {}
								local loop = 0
								local added = 0
								
								for k,v in pairs(queue[1].recipe) do
									loop = loop + 1
									QBCore.Functions.TriggerCallback("okokCrafting:inv2", function(item)
										local value = {key = item}
										table.insert(invItems, value)
										added = added + 1
									end, v[1])
									while added ~= loop do
										Citizen.Wait(50)
									end
								end
								local timePassed = 0
								while timePassed < queue[1].time do
									local playerCoords = GetEntityCoords(PlayerPedId())
									local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, queue[1].closeBlip[1], queue[1].closeBlip[2], queue[1].closeBlip[3])
									SendNUIMessage({
										action = "ShowCraftCount",
										time = queue[1].time - timePassed,
										name = itemNames[queue[1].item],
									})
									if distance <= queue[1].maxCraftRadius then
										timePassed = timePassed + 1
									end
									Citizen.Wait(1000)

									if IsEntityDead(PlayerPedId()) then
										SE('okokCrafting:craftStopItem')
										break
									end
								end
								if IsEntityDead(PlayerPedId()) then
									SendNUIMessage({
										action = "HideCraftCount",
									})
									SE('okokCrafting:craftItemDeath', queue)
									for k,v in pairs(queue) do
										queue[k] = nil
									end
									break
								end
								local randomNumber = math.random(0, 100)

								if randomNumber <= queue[1].success then
									SE('okokCrafting:craftItemFinished', queue[1].item, queue[1].crafts, itemNames[queue[1].item], queue[1].isItem, queue[1].xp)
									SendNUIMessage({
										action = "CompleteCraftCount",
										name = itemNames[queue[1].item],
									})
								else
									SendNUIMessage({
										action = "FailedCraftCount",
										name = itemNames[queue[1].item],
									})
									SE('okokCrafting:failedCraft', itemNames[queue[1].item], queue[1].xp)
								end
								
								Citizen.Wait(2000)
								SendNUIMessage({
									action = "HideCraftCount",
								})
								table.remove(queue, 1)
								crafting = false
							end
							while crafting do
								Citizen.Wait(500)
							end
						end
					end
				end
			end, data.itemID, recipeTable, itemNames, data.amount, isItem)
		end)
	end
end)

function Split(s, delimiter)
	local index = 0
	local result = {}
	local line = {}

	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		if tonumber(match) ~= nil then
			match = tonumber(match)
		end
		if index == 0 or index % 3 ~= 0 then
			table.insert(line, match)
		else
			table.insert(result, line)
			line = {}
			table.insert(line, match)
		end
		index = index + 1
	end
	table.insert(result, line)
	return result
end

RegisterNetEvent("okokCrafting:updateXP")
AddEventHandler("okokCrafting:updateXP", function()
	Citizen.Wait(100)
	if isCraftOpen then
		QBCore.Functions.TriggerCallback("okokCrafting:getLevel", function(level, percentage)
			SendNUIMessage({
				action = "openCraft",
				name = tableName,
				craft = tableCrafts,
				itemNames = tableItemNames,
				job = QBCore.Functions.GetPlayerData().job.name,
				wb = workbench,
				UseXP = true,
				level = level,
				percentage = percentage,
			})
		end)
	end
end)