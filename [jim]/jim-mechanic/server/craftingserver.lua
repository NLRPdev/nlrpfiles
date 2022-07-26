local QBCore = exports['qb-core']:GetCoreObject()

local function StashTidy(stash, stashId)
	if Config.Debug then print("Tidying Stash...('"..stashId.."')") end
	for k,v in pairs(stash) do
		for l, b in pairs(stash) do
			if v.name == b.name and k ~= l then
				if not v.unique then
					if Config.Debug then 
						print("Found duplicate item: '"..v.name.."'")
						print("Removing Stash slot ["..l.."] (x"..b.amount..") and Adding to Stash slot ["..k.."] (x"..v.amount..")")
					end
					v.amount = v.amount + b.amount
					if Config.Debug then print("Adjusted Slot - ["..k.."] - '"..v.name.."' (x"..v.amount..")") end
					stash[l] = nil
				end
			end
		end	
	end
	if Config.Debug then print("Tidying Complete!") end
	TriggerEvent('jim-mechanic:server:saveStash', stashId, stash)
	return stash
end

local function GetStashItems(stashId)
	local items = {}
	local result = MySQL.Sync.fetchScalar('SELECT items FROM stashitems WHERE stash = ?', {stashId})
	if result then
		local stashItems = json.decode(result)
		if stashItems then
			for k, item in pairs(stashItems) do
				local itemInfo = QBCore.Shared.Items[item.name:lower()]
				if itemInfo then
					items[item.slot] = {
						name = itemInfo["name"],
						amount = tonumber(item.amount),
						info = item.info ~= nil and item.info or "",
						label = itemInfo["label"],
						description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
						weight = itemInfo["weight"],
						type = itemInfo["type"],
						unique = itemInfo["unique"],
						useable = itemInfo["useable"],
						image = itemInfo["image"],
						slot = item.slot,
					}
				end
			end
		end
	end
	return items
end

QBCore.Functions.CreateCallback('jim-mechanic:server:GetStashItems', function(source, cb, stashName)
	local stash = GetStashItems(stashName)
	cb(stash)
end)

---Crafting 
RegisterServerEvent('jim-mechanic:Crafting:GetItem', function(ItemMake, craftable)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	--This grabs the table from client and removes the item requirements
	if craftable["amount"] then amount = craftable["amount"] else amount = 1 end
	if Config.StashCraft then
		stashItems = GetStashItems(Player.PlayerData.job.name .. "Safe")
		for k,v in pairs(craftable[ItemMake]) do
			for l, b in pairs(stashItems) do
				if k == b.name then
					stashItems[l].amount = stashItems[l].amount - v
					if stashItems[l].amount <= 0 then stashItems[l] = nil end
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], "use", v)
					TriggerEvent('jim-mechanic:server:saveStash', Player.PlayerData.job.name .. "Safe", stashItems)
					if Config.Debug then print("Removing "..QBCore.Shared.Items[k].label.." x"..v.." from stash: '"..Player.PlayerData.job.name.."Safe'") end
				end
			end
		end
	else
		for k,v in pairs(craftable[ItemMake]) do
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[tostring(k)], "remove", v) 
			Player.Functions.RemoveItem(tostring(k), v)
		end
	end
	--This should give the item, while the rest removes the requirements
	Player.Functions.AddItem(ItemMake, amount)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[ItemMake], "add", amount) 
end)

---ITEM REQUIREMENT CHECKS
QBCore.Functions.CreateCallback('jim-mechanic:Crafting:get', function(source, cb, item, craftable)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local hasitem = true
	local testtable = {}
	for k, v in pairs(craftable[item]) do testtable[k] = false end
	if Config.StashCraft then
		stashItems = StashTidy(GetStashItems(Player.PlayerData.job.name.."Safe"), Player.PlayerData.job.name.."Safe")
		for k, v in pairs(craftable[item]) do
			for l, b in pairs(stashItems) do
				if k == b.name and b.amount >= v then testtable[k] = true if Config.Debug then print(b.label.." x"..b.amount.." found in stash: '"..Player.PlayerData.job.name.."Safe'") end end
			end
		end
	else
		for k,v in pairs(craftable[item]) do
			if QBCore.Functions.GetPlayer(source).Functions.GetItemByName(k) and QBCore.Functions.GetPlayer(source).Functions.GetItemByName(k).amount >= v then
				testtable[k] = true if Config.Debug then print(k.." (x"..v..") found") end
			end
		end
	end
	for k, v in pairs(testtable) do
		if not v then hasitem = false if Config.Debug then print(QBCore.Shared.Items[k].label.." NOT found") end end
	end
	cb(hasitem)
end)